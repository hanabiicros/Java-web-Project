package com.ldu.controller;

import com.ldu.pojo.Goods;
import com.ldu.pojo.Orders;
import com.ldu.pojo.OrdersGoods;
import com.ldu.pojo.Purse;
import com.ldu.pojo.User;
import com.ldu.service.GoodsService;
import com.ldu.service.MailSenderSrvService;
import com.ldu.service.OrdersGoodsService;
import com.ldu.service.OrdersService;
import com.ldu.service.PurseService;
import com.ldu.service.ShoppingCartService;
import com.ldu.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value="/orders")
public class OrdersController {
	
	@Resource
	private UserService userService;
	@Resource
	private OrdersService ordersService;
	@Resource
	private GoodsService goodsService;
	@Resource
	private PurseService  purseService;
	@Resource
	private OrdersGoodsService ordersGoodsService;
	@Resource
	private ShoppingCartService shoppingCartService;
	@Autowired
    private MailSenderSrvService mailsend;
	
    
    ModelAndView mv = new ModelAndView();
	
	 /**
     * 我的订单 买
     */
    @RequestMapping(value = "/myOrders")
    public ModelAndView orders(HttpServletRequest request) {
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer user_id = cur_user.getId();
        List<Orders> ordersList1=new ArrayList<Orders>();
        List<Orders> ordersList2=new ArrayList<Orders>();
        
        ordersList1 = ordersService.getOrdersByUserId(user_id);
        ordersList2 = ordersService.getOrdersByUserAndGoods(user_id);
        
        /*
        for(int i = 0;i<ordersList1.size();i++) {
        	ordersList1.get(i).getGoods()
        }*/
        System.out.println(ordersList1);
        Purse myPurse=purseService.getPurseByUserId(user_id);
        mv.addObject("ordersOfSell",ordersList2);
        mv.addObject("orders",ordersList1);
        mv.addObject("myPurse",myPurse);
        mv.setViewName("/user/orders");
        return mv;
    }
    
    
	 /**
     * 提交单个商品订单
     */
    @RequestMapping(value = "/addOrders")
    public String addorders(HttpServletRequest request,Orders orders) {
    	Date d=new Date();//获取时间
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");//转换格式
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer goodsId = Integer.parseInt(request.getParameter("goodsId"));
        Integer user_id = cur_user.getId();
        orders.setUserId(user_id);
        Integer goodsNum = 1;
        orders.setGoodsNum(goodsNum);
        orders.setOrderDate(sdf.format(d));
        
        Goods goods=new Goods();
        goods.setStatus(0);
        goods.setId(goodsId);
        
        goodsService.updateGoodsByGoodsId(goods);
        ordersService.addOrders(orders);
        
        Integer ordersId = orders.getId();
        
        OrdersGoods ordersGoods = new OrdersGoods();
        ordersGoods.setGoodsId(goodsId);
        ordersGoods.setOrdersId(ordersId);
        
        ordersGoodsService.addOrdersGoods(ordersGoods);
        shoppingCartService.deleteShoppingCartByUserIdAndGoodsId(goodsId, user_id);
        
        Float balance=orders.getOrderPrice();
        purseService.updatePurseOfdel(user_id,balance);
        return "redirect:/orders/myOrders";
    }
    
    /**
     * 提交多个商品的订单
     */
    @RequestMapping(value = "/addOrdersbyGoodsIds")
    public String addOrdersbyGoodsIds(HttpServletRequest request,Orders orders) {
    	Date d=new Date();//获取时间
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");//转换格式
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer user_id = cur_user.getId();
        
        String goodsIds = request.getParameter("goodsIds");
		List<String> result = Arrays.asList(goodsIds.split(","));
		
        orders.setOrderDate(sdf.format(d));     
        orders.setUserId(user_id);
        ordersService.addOrders(orders);
        
        Integer ordersId = orders.getId();
        
		for (int i = 0; i < result.size(); i++) {
			Goods goods=new Goods();
	        goods.setStatus(0);
	        Integer goodsId = Integer.parseInt(result.get(i));
	        goods.setId(goodsId);
	        goodsService.updateGoodsByGoodsId(goods);
	        
	        OrdersGoods ordersGoods = new OrdersGoods();
	        ordersGoods.setGoodsId(goodsId);
	        ordersGoods.setOrdersId(ordersId);
	        
	        ordersGoodsService.addOrdersGoods(ordersGoods);
	        
	        shoppingCartService.deleteShoppingCartByUserIdAndGoodsId(goodsId, user_id);
		}

        Float balance=orders.getOrderPrice();
        purseService.updatePurseOfdel(user_id,balance);
        return "redirect:/orders/myOrders";
    }
    
    /**
     * 发货 根据订单号
     */
    @RequestMapping(value = "/deliver/{orderId}")
    @ResponseBody
    public String deliver(HttpServletRequest request,@PathVariable("orderId")Integer orderId) {
      
    	Orders order = ordersService.getOrdersById(orderId);
    	Integer userId = order.getUserId();
    	User user = userService.getUserById(userId);
    	String qq = user.getQq();
    	try {
	    	ordersService.deliverByOrderNum(orderId);
	    	
    	}catch(Exception e) {
    		return "{\"success\":false}";
    	}
    	String to = qq;  //收件人地址
        String subject = "交易信息";   //邮件标题
        String content = "卖家已发货";    //邮件内容

        mailsend.sendEmail(to,subject,content);    //发送邮件
    	
    	return "{\"success\":true}";
        
    }
    
    
    
    /**
     * 收货
     */
    @RequestMapping(value = "/receipt")
    @ResponseBody
    public String receipt(HttpServletRequest request) {
    	Integer orderId=Integer.parseInt(request.getParameter("orderId"));
    	//Float balance=Float.parseFloat(request.getParameter("orderPrice"));
    	//Integer goodsId=Integer.parseInt(request.getParameter("goodsId"));
    	//Integer userId=goodsService.getGoodsById(goodsId).getUserId();
    	
    	List<Integer> goodsIds=ordersGoodsService.getOrdersGoodsByOrdersId(orderId);
    	
    	try {
    		/*买家确认收货后，卖家钱包+*/
    		ordersService.receiptByOrderNum(orderId);
    		System.out.println(goodsIds);
    		for(int i = 0;i<goodsIds.size();i++) {
    			Integer goodsId = goodsIds.get(i);
    			Integer userId=goodsService.getGoodsById(goodsId).getUserId();
    			Float goodsPrice=goodsService.getGoodsById(goodsId).getPrice();
    			purseService.updatePurseByuserId(userId,goodsPrice);
    		}        	
        	return "{\"success\":true}";
    	}catch(Exception e) {
    		return "{\"success\":false}";
    	}
    	
    	
    }
}
