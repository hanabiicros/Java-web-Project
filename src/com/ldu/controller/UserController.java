package com.ldu.controller;

import com.ldu.pojo.*;
import com.ldu.service.*;
import com.ldu.util.DateUtil;
import com.ldu.util.MD5;
import com.ldu.util.NoticeGrid;
import com.ldu.util.ReplyGrid;
import com.ldu.util.UserGrid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping(value = "/user")
public class UserController {

	@Autowired
	private UserService userService;
	@Resource
	private GoodsService goodsService;
	@Autowired
	private ImageService imageService;

	@Resource
	private FocusService focusService;
	
	@Resource
	private ShoppingCartService shoppingcartService;

	@Resource
	private PurseService purseService;
	
	@Resource
	private NoticeService noticeService;
	
	@Resource
	private ReplyService replyService;
	/**
	 * 用户注册
	 * 
	 * @param user1
	 * @return
	 */
	@RequestMapping(value = "/addUser")
	@ResponseBody
	public String addUser(HttpServletRequest request, @ModelAttribute("user") User user1) {
		String url = request.getHeader("Referer");
		//String imgUrl="123.jpg";
		User user = userService.getUserByPhone(user1.getPhone());
		//String qq = "'"+user1.getQq()+"'";
		//System.out.println(qq);
		
		if (user == null) {// 检测该用户是否已经注册
			String t = DateUtil.getNowDate();
			// 对密码进行MD5加密
			String str = MD5.md5(user1.getPassword());
			user1.setCreateAt(t);// 创建开始时间
			//user1.setQq(qq);
			user1.setPassword(str);
			user1.setGoodsNum(0);
			user1.setStatus((byte) 1);//初始正常状态
			user1.setPower(100);
			//user1.setImgUrl(imgUrl);
			try {
				userService.addUser(user1);
				purseService.addPurse(user1.getId());// 注册的时候同时生成钱包
				
				return "{\"success\":true,\"msg\":\"注册成功!\"}";
			}catch(Exception e) {
				return "{\"success\":false,\"msg\":\"注册失败!\"}";
			}
			
		}
		return "{\"success\":false,\"msg\":\"注册失败!\"}";
	}
	
	/**
	 * 注册验证账号
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/registerPhone",method = RequestMethod.POST)
	@ResponseBody
	public String registerPhone(HttpServletRequest request){
		String regex = "^((13[0-9])|(14[5,7,9])|(15([0-3]|[5-9]))|(166)|(17[0,1,3,5,6,7,8])|(18[0-9])|(19[8|9]))\\d{8}$";
		
		String phone=request.getParameter("phone");
		if(phone.length()!=11) {
			return "{\"success\":false,\"msg\":\"手机号为11位数\"}";
		}else {
	        Pattern p = Pattern.compile(regex);
	        Matcher m = p.matcher(phone);
	        boolean isMatch = m.matches();
	        if (!isMatch) {
	        	return "{\"success\":false,\"msg\":\"请输入正确的手机号！\"}";
	        }
	        else {
	        	User user = userService.getUserByPhone(phone);
	    		if(user==null) {
	    			return "{\"success\":true,\"flag\":true}";//用户不存在，可以注册
	    		}else {
	    			return "{\"success\":true,\"flag\":false,\"msg\":\"用户已存在\"}";//用户存在，注册失败
	    		}
	        }
	     }

		
	}
	/**
	 * 注册验证邮箱
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/registerQq",method = RequestMethod.POST)
	@ResponseBody
	public String registerQq(HttpServletRequest request){
		String regex = "^([a-zA-Z\\d])(\\w|\\-)+@[a-zA-Z\\d]+\\.[a-zA-Z]{2,4}$";
		
		String qq=request.getParameter("qq");
		
	        Pattern p = Pattern.compile(regex);
	        Matcher m = p.matcher(qq);
	        boolean isMatch = m.matches();
	        if (!isMatch) {
	        	return "{\"success\":false}";
	        }
	        else {
	        	return "{\"success\":true}";
	        }
	}
	/**
	 * 注册验证密码
	 */
	@RequestMapping(value = "/registerPassword",method = RequestMethod.POST)
	@ResponseBody
	public String registerPassword(HttpServletRequest request){
		
		//必须包含一个大写，一个小写字母，且长度为8到16位
		String regex = "^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9~!@&%#_]{8,16}$";
		
		String password=request.getParameter("password");
		
	        Pattern p = Pattern.compile(regex);
	        Matcher m = p.matcher(password);
	        boolean isMatch = m.matches();
	        if (!isMatch) {
	        	return "{\"success\":false,\"msg\":\"必须包含一个大写，一个小写字母，且长度为8到16位\"}";
	        }
	        else {
	    		
	    			return "{\"success\":true}";//
	    		
	        }
	}

	
	
	/**
	 * 登陆验证密码
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/password",method = RequestMethod.POST)
	@ResponseBody
	public String password(HttpServletRequest request){
		String phone=request.getParameter("phone");
		String password=request.getParameter("password");
		//User cur_user = userService.getUserByPhone(phone);
		if((phone==null||phone=="")&&(password==null||password=="")) {
			return "{\"success\":false,\"flag\":true}";
		}else {
			User user = userService.getUserByPhone(phone);
			if(user==null) {
				return "{\"success\":false,\"flag\":false}";//账号错误
			}
			String pwd = MD5.md5(password);
			if (pwd.equals(user.getPassword())) {
				request.getSession().setAttribute("cur_user", user);
				return "{\"success\":true,\"flag\":false}";//密码正确
			}else {
				return "{\"success\":true,\"flag\":true}";//密码错误
			}
		}
		
	}
	/*
	@ResponseBody
	@RequestMapping(value = "/uploadFile")
	public Map<String, Object> uploadFile2(HttpSession session, MultipartFile myfile)
			throws IllegalStateException, IOException {
			// 原始名称
			String oldFileName = myfile.getOriginalFilename(); // 获取上传文件的原名
			// 存储图片的物理路径
			System.out.println(oldFileName);
			String file_path = session.getServletContext().getRealPath("/");
			// System.out.println("file_path:"+file_path);
			// 上传图片
			if (myfile != null && oldFileName != null && oldFileName.length() > 0) {
				// 新的图片名称
				String newFileName = UUID.randomUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
				// 新图片
				File newFile = new File(file_path + "/" + newFileName);
				// 将内存中的数据写入磁盘
				myfile.transferTo(newFile);
				// 将新图片名称返回到前端
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("success", "成功啦");
				map.put("imgUrl", newFileName);
				return map;
			} else {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("error", "图片不合法");
				return map;
			}
		}
	*/

	/**
	 * 验证登录
	 * @param request
	 * @param user
	 * @param modelMap
	 * @param response 
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/login")
	public String loginValidate(HttpServletRequest request,User user, ModelMap modelMap, HttpServletResponse response) throws IOException{
		//ModelAndView mv = new ModelAndView();
		User cur_user = userService.getUserByPhone(user.getPhone());
		
		//String phone=request.getParameter("phone");
		//User cur_user = userService.getUserByPhone(phone);
		//String password=request.getParameter("password");
		
		String url = request.getHeader("Referer");
		if (cur_user != null) {
			String pwd = MD5.md5(user.getPassword());
			if (pwd.equals(cur_user.getPassword())) {
				if(cur_user.getStatus()==1) {
				//String a ="a";
				request.getSession().setAttribute("cur_user", cur_user);
				//request.getSession().setAttribute("error", false);
				//mv.setViewName("redirect:" + url);
				//response.setContentType("text/html; charset=utf-8");
				//response.getWriter().write("<script language='javascript'>alert('登录成功！');</script>");
				return "redirect:" + url;
					//return "{\"success\":true,\"msg\":\"登录成功!\"}";
				}
			}
			else {
				//String b ="b";
				//response.setContentType("text/html; charset=utf-8");
				//response.getWriter().write("<script language='javascript'>alert('密码错误！');</script>");
				//System.out.println("输错了");
				//mv.addObject("error", 6);
				//request.setAttribute("error", "用户名或密码错误！");
				//request.getSession().setAttribute("abc", b);
				//System.out.println(request.getSession().getAttribute("abc"));
				//request.getSession().setAttribute("error", true);
				return "redirect:"+ url;
				//return "{\"success\":false,\"msg\":\"登录失败！用户名或密码错误!\"}";
			}
		}
			
			
			//request.getSession().setAttribute("abc", 2);
		return "redirect:"+ url;
		//return "{\"success\":true,\"msg\":\"您输入的用户不存在!\"}";
	}

	/**
	 * 更改用户名
	 * 
	 * @param request
	 * @param user
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/changeName")
	public ModelAndView changeName(HttpServletRequest request, User user, ModelMap modelMap) {
		String url = request.getHeader("Referer");
		// 从session中获取出当前用户
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		cur_user.setUsername(user.getUsername());// 更改当前用户的用户名
		userService.updateUserName(cur_user);// 执行修改操作
		request.getSession().setAttribute("cur_user", cur_user);// 修改session值
		return new ModelAndView("redirect:" + url);
	}

	/**
	 * 完善或修改信息
	 * 
	 * @param request
	 * @param user
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/updateInfo")
	public ModelAndView updateInfo(HttpServletRequest request, User user, ModelMap modelMap) {
		// 从session中获取出当前用户
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		cur_user.setUsername(user.getUsername());
		//cur_user.setImgUrl("15632.jpg");
		cur_user.setQq(user.getQq());
		//String url=new String("123.jpg");
		//cur_user.setImgUrl(url);
		//String str=request.getParameter("lastLogin");
		if(user.getImgUrl()==""||user.getImgUrl()==null) {
			cur_user.setImgUrl(cur_user.getImgUrl());
		}
		else{
			cur_user.setImgUrl(user.getImgUrl());
		}
		//cur_user.setPower(300);
		//cur_user.setGoodsNum(4);
		//int goodsId = 140;
		//ima.setGoodsId(goodsId);
		//ima.setImgUrl(url);
		//imageService.insert(ima);
		
		
		request.getSession().setAttribute("cur_user", cur_user);// 修改session值
		userService.updateUserName(cur_user);// 执行修改操作
		return new ModelAndView("redirect:/user/basic");
	}

	/**
	 * 用户退出
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().setAttribute("cur_user", null);
		return "redirect:/goods/homeGoods";
	}

	/**
	 * 个人中心
	 * 
	 * @return
	 */
	@RequestMapping(value = "/home")
	@ResponseBody
	public ModelAndView home(HttpServletRequest request,@RequestParam("pageNum") int pageNum) {
		ModelAndView mv = new ModelAndView();
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer userId = cur_user.getId();
		//int size=5;
		Purse myPurse = purseService.getPurseByUserId(userId);
		//List<User> users=userService.getUserOrderByDate(size);
		List<Notice> notice=noticeService.getNoticeList();
		
		List<Reply> reply=replyService.getInUserReplyList();
		
		int pageSize = 10;
		
		int total = noticeService.getNoticeNum();
		int totalnum=total;
		total=(total+9)/10;
		List<Notice> rows = noticeService.getPageNotice(pageNum, pageSize);
		//List<Reply> replyrows = replyService.getPageInUserReply(replyPageNum, pageSize);
		
		NoticeGrid noticeGrid = new NoticeGrid();
		noticeGrid.setCurrent(pageNum);
		noticeGrid.setRowCount(pageSize);
		noticeGrid.setRows(rows);
		noticeGrid.setTotal(total);
		noticeGrid.setTotalnum(totalnum);
		
		//int replytotal = replyService.getInUserReplyNum();
		//replytotal=(replytotal+9)/10;
		
		//ReplyGrid replyGrid = new ReplyGrid();
		//replyGrid.setCurrent(replyPageNum);
		//replyGrid.setRowCount(pageSize);
		//replyGrid.setRows(replyrows);
		//replyGrid.setTotal(replytotal);
		
		mv.addObject("noticeGrid", noticeGrid);
		//mv.addObject("replyGrid",replyGrid);
		mv.addObject("reply",reply);
		mv.addObject("notice", notice);
		mv.addObject("myPurse", myPurse);
		//mv.addObject("users", users);
		mv.setViewName("/user/home");
		return mv;
	}
	
	
	
	

	/**
	 * 个人信息设置
	 * 
	 * @return
	 */
	@RequestMapping(value = "/basic")
	public ModelAndView basic(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		//cur_user.setLastLogin("123456789");
		//cur_user.setQq("123479845");
		
		//request.getSession().setAttribute("cur_user", cur_user);
		Integer userId = cur_user.getId();
		Purse myPurse = purseService.getPurseByUserId(userId);
		ModelAndView mv = new ModelAndView();
		mv.addObject("myPurse", myPurse);
		mv.setViewName("/user/basic");
		return mv;
	}

	/**
	 * 我的闲置 查询出所有的用户商品以及商品对应的图片
	 * 
	 * @return 返回的model为 goodsAndImage对象,该对象中包含goods 和 images，参考相应的类
	 */
	@RequestMapping(value = "/allGoods")
	public ModelAndView goods(HttpServletRequest request) {
		
		Date dd=new Date();
		SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date=sim.format(dd);
		
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer userId = cur_user.getId();
		List<Goods> goodsList = goodsService.getGoodsByUserId(userId);
		List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
		for (int i = 0; i < goodsList.size(); i++) {
			// 将用户信息和image信息封装到GoodsExtend类中，传给前台
			GoodsExtend goodsExtend = new GoodsExtend();
			Goods goods = goodsList.get(i);
			List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(images);
			goodsAndImage.add(i, goodsExtend);
		}
		Purse myPurse = purseService.getPurseByUserId(userId);
		ModelAndView mv = new ModelAndView();
		mv.addObject("goodsAndImage", goodsAndImage);
		mv.setViewName("/user/goods");
		mv.addObject("date", date);
		mv.addObject("myPurse", myPurse);
		return mv;
	}
	
	/**
	 * 我的购物车
	 */

	@RequestMapping(value = "/shoppingCart")
	public ModelAndView shoppingCart(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer userId = cur_user.getId();
		List<ShoppingCart> shoppingcartList = shoppingcartService.getShoppingCartByUserId(userId);
		
		Date dd=new Date();
		SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date=sim.format(dd);
		
		List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
		
		for (int i = 0; i < shoppingcartList.size(); i++) {
			// 将用户信息和image信息封装到GoodsExtend类中，传给前台
			GoodsExtend goodsExtend = new GoodsExtend();
			ShoppingCart shoppingcart = shoppingcartList.get(i);
			Goods goods = goodsService.getGoodsById(shoppingcart.getGoodsId());
			Integer goodsId = shoppingcart.getGoodsId();
			List<Image> images = imageService.getImagesByGoodsPrimaryKey(shoppingcart.getGoodsId());
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(images);
			goodsAndImage.add(i, goodsExtend);
		}
		Purse myPurse = purseService.getPurseByUserId(userId);
		ModelAndView mv = new ModelAndView();
		mv.addObject("goodsAndImage", goodsAndImage);
		mv.addObject("myPurse", myPurse);
		mv.addObject("date", date);
		mv.setViewName("/user/shoppingCart");
		return mv;
	}
	
	/**
	 * 我的关注 查询出所有的用户商品以及商品对应的图片
	 * 
	 * @return 返回的model为 goodsAndImage对象,该对象中包含goods 和 images，参考相应的类
	 */
	@RequestMapping(value = "/allFocus")
	public ModelAndView focus(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer userId = cur_user.getId();
		List<Focus> focusList = focusService.getFocusByUserId(userId);
		
		Date dd=new Date();
		SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date=sim.format(dd);
		
		List<GoodsExtend> goodsAndImage = new ArrayList<GoodsExtend>();
		for (int i = 0; i < focusList.size(); i++) {
			// 将用户信息和image信息封装到GoodsExtend类中，传给前台
			GoodsExtend goodsExtend = new GoodsExtend();
			Focus focus = focusList.get(i);
			Goods goods = goodsService.getGoodsById(focus.getGoodsId());
			List<Image> images = imageService.getImagesByGoodsPrimaryKey(focus.getGoodsId());
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(images);
			goodsAndImage.add(i, goodsExtend);
		}
		Purse myPurse = purseService.getPurseByUserId(userId);
		ModelAndView mv = new ModelAndView();
		mv.addObject("goodsAndImage", goodsAndImage);
		mv.addObject("myPurse", myPurse);
		mv.addObject("date", date);
		mv.setViewName("/user/focus");
		return mv;
	}

	/**
	 * 删除我的关注
	 * @return
	 */
	@RequestMapping(value = "/deleteFocus/{id}")
	public String deleteFocus(HttpServletRequest request, @PathVariable("id") Integer goods_id) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer user_id = cur_user.getId();
		focusService.deleteFocusByUserIdAndGoodsId(goods_id, user_id);

		return "redirect:/user/allFocus";

	}
	
	/**
	 * 删除评论
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = "/deleteReply")
	@ResponseBody
	public String deleteReply(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer id=Integer.valueOf(request.getParameter("id"));
		
		//Integer user_id = cur_user.getId();
		//focusService.deleteFocusByUserIdAndGoodsId(goods_id, user_id);
		
		try {
			noticeService.deleteReply(id);
			replyService.deleteUnderUserReply(id);
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"删除失败!\"}";
		}
			return "{\"success\":true,\"msg\":\"删除成功!\"}";

	}
	
	@RequestMapping(value = "/deleteInUserReply")
	@ResponseBody
	public String deleteInUserReply(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer id=Integer.valueOf(request.getParameter("id"));
		Integer commentId=Integer.valueOf(request.getParameter("commentId"));
		
		Notice notice=noticeService.getSpecialNotice(commentId);
		Integer replyNum=notice.getReplyNum();
		//Integer user_id = cur_user.getId();
		//focusService.deleteFocusByUserIdAndGoodsId(goods_id, user_id);
		
		try {
			replyService.deleteMyReply(id);
			replyNum=replyNum-1;
			notice.setReplyNum(replyNum);
			noticeService.updateSpecialNotice(notice);
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"删除失败!\"}";
		}
			return "{\"success\":true,\"msg\":\"删除成功!\"}";

	}
	
	/*为求购信息分页
	 * 
	 * 
	@RequestMapping(value = "/userList")
	@ResponseBody
	public ModelAndView getUserList(@RequestParam("pageNum") int pageNum) {
		ModelAndView modelAndView = new ModelAndView();
		int pageSize = 10;
		int total = noticeService.getNoticeNum();
		total=(total+9)/10;
		List<Notice> rows = noticeService.getPageNotice(pageNum, pageSize);
		NoticeGrid noticeGrid = new NoticeGrid();
		noticeGrid.setCurrent(pageNum);
		noticeGrid.setRowCount(pageSize);
		noticeGrid.setRows(rows);
		noticeGrid.setTotal(total);
		modelAndView.addObject("noticeGrid", noticeGrid);
		modelAndView.setViewName("/user/home");
		return modelAndView;
	}
*/
	/**
	 * 添加到购物车
	 */
	
	@RequestMapping(value="/addShoppingCart/{id}")
	@ResponseBody
	public String addShoppingCart(HttpServletRequest request, @PathVariable("id") Integer goods_id) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		//String url = request.getHeader("Referer");
		Integer user_id = cur_user.getId();
		//首先获取用户购物车中的所有商品信息
		List<ShoppingCart> shoppingcartList=shoppingcartService.getShoppingCartByUserId(user_id);
		//若购物车列表为空，则直接加入购物车
		if(shoppingcartList.isEmpty()) {
			try {
				shoppingcartService.addShoppingCartByUserIdAndId(goods_id, user_id);
				return "{\"success\":true,\"warning\":false,\"msg\":\"商品成功加入购物车，请查看我的购物车~\"}";
			}catch(Exception e) {
				return "{\"success\":false,\"warning\":true,\"msg\":\"加入购物车失败!\"}";
			}
			
		}
		//遍历购物车中的商品信息
		for (ShoppingCart myshoppingcart : shoppingcartList) {
			int goodsId=myshoppingcart.getGoodsId();
			//若该商品已经被加入购物车，则直接返回
			if(goodsId == goods_id.intValue()) {
				return "{\"success\":true,\"warning\":true,\"msg\":\"该商品您已加入购物车，请勿重复操作!\"}";
			}
		}
		try {
			shoppingcartService.addShoppingCartByUserIdAndId(goods_id, user_id);
			return "{\"success\":true,\"msg\":\"商品成功加入购物车，请查看我的购物车~\"}";
		}catch(Exception e) {
			return "{\"success\":false,\"warning\":true,\"msg\":\"加入购物车失败!\"}";
		}

	}
	
	/**
	 * 添加我的关注
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addFocus/{id}")
	@ResponseBody
	public String addFocus(HttpServletRequest request, @PathVariable("id") Integer goods_id) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		String url = request.getHeader("Referer");
		Integer user_id = cur_user.getId();
		//首先获取用户所有的关注列表
		List<Focus> focus=focusService.getFocusByUserId(user_id);
		//若关注列表为空，则直接添加关注
		if(focus.isEmpty()) {
			try {
				focusService.addFocusByUserIdAndId(goods_id, user_id);
				return "{\"success\":true,\"warning\":false,\"msg\":\"已关注成功，请查看关注列表~\"}";
			}catch(Exception e) {
				return "{\"success\":false,\"warning\":true,\"msg\":\"添加关注失败!\"}";
			}
			
		}
		//遍历所有的关注列表
		for (Focus myfocus : focus) {
			int goodsId=myfocus.getGoodsId();
			//若该商品已经被关注，则直接返回
			if(goodsId == goods_id.intValue()) {
				return "{\"success\":true,\"warning\":true,\"msg\":\"该商品您已关注，请勿重复关注!\"}";
			}
		}
		try {
			focusService.addFocusByUserIdAndId(goods_id, user_id);
			return "{\"success\":true,\"msg\":\"已关注成功，请查看关注列表~\"}";
		}catch(Exception e) {
			return "{\"success\":false,\"warning\":true,\"msg\":\"添加关注失败!\"}";
		}

	}

	/**
	 * 我的钱包
	 * 
	 * @return 返回的model为 goodsAndImage对象
	 */
	@RequestMapping(value = "/myPurse")
	public ModelAndView getMoney(HttpServletRequest request) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer user_id = cur_user.getId();
		Purse purse = purseService.getPurseByUserId(user_id);
		ModelAndView mv = new ModelAndView();
		mv.addObject("myPurse", purse);
		mv.setViewName("/user/purse");
		return mv;
	}

	/**
	 * 充值与提现 根据传过来的两个值进行判断是充值还是提现
	 * 
	 * @return 返回的model为 goodsAndImage对象
	 */
	@RequestMapping(value = "/updatePurse")
	public String updatePurse(HttpServletRequest request, Purse purse) {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer user_id = cur_user.getId();
		purse.setUserId(user_id);
		purse.setState(0);
		if (purse.getRecharge() != null) {
			purseService.updatePurse(purse);
		}
		if (purse.getWithdrawals() != null) {
			purseService.updatePurse(purse);
		}
		return "redirect:/user/myPurse";
	}
	
	/**
	 * 发布评论
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = "/insertSelective",method = RequestMethod.POST)
	@ResponseBody
	public String insertSelective(HttpServletRequest request){
		String context=request.getParameter("context");
		System.out.println(context);
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Notice notice=new Notice();
		notice.setContext(context);
		notice.setReplyNum(0);
		Date dt = new Date();     
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		notice.setCreateAt(sdf.format(dt));
		notice.setStatus((byte) 0);
		notice.setUser(cur_user);
		if(context==null||context=="") {
			return "{\"success\":false,\"msg\":\"发布失败，请输入内容!\"}";
		}
	try {
			noticeService.insertSelective(notice);
			Integer noticeId=notice.getId();
			//System.out.println(noticeId);
			String nId=noticeId.toString();
			String createAt=notice.getCreateAt();
			return "{\"success\":true,\"msg\":\"发布成功!\",\"noticeId\":"+"\""+nId+"\""+",\"createAt\":"+"\""+createAt+"\""+"}";
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"发布失败!\"}";
		}
	
	}
	/**
	 * 发布回复
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = "/insertInUserSelective",method = RequestMethod.POST)
	@ResponseBody
	public String insertInUserSelective(HttpServletRequest request){
		String content=request.getParameter("content");
		Integer atuserId=Integer.valueOf(request.getParameter("atuserId"));
		Integer commentId=Integer.valueOf(request.getParameter("commentId"));
		
		Notice notice=noticeService.getSpecialNotice(commentId);
		Integer replyNum=notice.getReplyNum();
		
		
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Reply reply=new Reply();
		reply.setContent(content);
		
		reply.setCommentId(commentId);
		
		
		Date dt = new Date();     
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String createAt=sdf.format(dt);
		reply.setCreateAt(sdf.format(dt));
		reply.setUserId(cur_user.getId());

		reply.setAtuserId(atuserId);
		//notice.setUser(cur_user);
		if(content==null||content=="") {
			return "{\"success\":false,\"msg\":\"发布失败，请输入内容!\"}";
		}
	try {
			replyService.insertInUserSelective(reply);
			Integer replyId=reply.getId();
			String rId=replyId.toString();
			
			replyNum+=1;
			notice.setReplyNum(replyNum);
			noticeService.updateSpecialNotice(notice);
			
			return "{\"success\":true,\"msg\":\"发布成功!\",\"createAt\":"+"\""+createAt+"\","+"\"replyId\":"+"\""+rId+"\""+"}";
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"发布失败!\"}";
		}
			
		
	}

}
