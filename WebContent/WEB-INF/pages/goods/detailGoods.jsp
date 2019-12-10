<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>校园二手市场</title>
    
    <link rel="stylesheet" href="<%=basePath%>css/detail.css" />
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="<%=basePath%>css/index.css" />
    <link rel="stylesheet" href="<%=basePath%>css/swiper.min.css" />
    
    <script type="text/javascript" src="<%=basePath%>js/jquery.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/swiper.js" ></script>
    
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <link rel="stylesheet" href="<%=basePath%>css/sweetalert.min.css" rel="stylesheet">
	<script type="text/javascript" src="<%=basePath%>js/sweetalert.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/loginRegister.js" ></script>
    
    <script type="text/javascript">
    
    function keydown(){
    	if (event.keyCode==13){  //回车键的键值为13 
    	       $("#loginIn").click(); //调用登录按钮的登录事件 
    	    } 
    }
    
    function addShoppingCart(id){
    	$.ajax({
			 url:'<%=basePath%>user/addShoppingCart/'+id,
			 type:'POST',
			 data:{},
			 dataType:'json',
			 success:function(json){
				 if(!json.success){
					 swal({
						  title: "Error!",
						  text: json.msg,
						  type: "error",
						  confirmButtonText: "OK"
						});
					}
				 else if(json.success&&!json.warning){
					 swal({
						  title: "Success!",
						  text: json.msg,
						  type: "success",
						  confirmButtonText: "OK",
						  closeOnConfirm:"false"
					
					});
				 }
				 else if(json.success&&json.warning){
					 swal({
						  title: "Warning!",
						  text: json.msg,
						  type: "warning",
						  confirmButtonText: "OK",
						  closeOnConfirm:"false"
					
					});
				 }
				 },
			error:function(){
				swal({
					  title: "Error!",
					  text: "请求超时或系统出错！",
					  type: "error",
					  confirmButtonText: "OK"
					});
				}
		 });
    }
    
    function  addFocus(id) {
    	
		 $.ajax({
			 url:'<%=basePath%>user/addFocus/'+id,
			 type:'POST',
			 data:{},
			 dataType:'json',
			 success:function(json){
				 if(!json.success){
					 swal({
						  title: "Error!",
						  text: json.msg,
						  type: "error",
						  confirmButtonText: "OK"
						});
					}
				 else if(json.success&&!json.warning){
					 swal({
						  title: "Success!",
						  text: json.msg,
						  type: "success",
						  confirmButtonText: "OK",
						  closeOnConfirm:"false"
					
					});
				 }
				 else if(json.success&&json.warning){
					 swal({
						  title: "Warning!",
						  text: json.msg,
						  type: "warning",
						  confirmButtonText: "OK",
						  closeOnConfirm:"false"
					
					});
				 }
				 },
			error:function(){
				swal({
					  title: "Error!",
					  text: "请求超时或系统出错！",
					  type: "error",
					  confirmButtonText: "OK"
					});
				}
		 });
		  
    	//alert("已关注成功，查看关注列表~")
    	
    	
    }
    
	/* 前往支付 */
    function  toPay(id) {
    	window.location.href = '<%=basePath%>goods/buyId/'+id
    }
	
    function deleteCommentInGoods(id){
 		 $.ajax({
 			 url:'<%=basePath%>goods/deleteInGoodsComment',
 			 type:'GET',
 			 data:{id:id},
 			 dataType:'json',
 			 success:function(json){
 				 if(!json.success){
 					 swal({
 						  title: "Error!",
 						  text: "删除失败！",
 						  type: "error",
 						  confirmButtonText: "OK"
 						});
 					}
 				 else{
 					 swal({
 						  title: "Success!",
 						  text: "删除成功！",
 						  type: "success",
 						  confirmButtonText: "OK",
 						  closeOnConfirm:"false"
 					},
 					  function(isConfirm){
 					  if (isConfirm) {
 							 location.reload();
 					  } 
 					});
 				 }
 				 },
 			error:function(){
 				swal({
 					  title: "Error!",
 					  text: "请求超时或系统出错！",
 					  type: "error",
 					  confirmButtonText: "OK"
 					});
 				}
 		 });
 		   
 	   }
	
    </script>
    <style>
    	a.deleteComment{
    		color: darkgray;
    	}
    	
    	a.deleteComment:hover{
    		color:#E75451;
    		cursor:pointer;
    		text-decoration:none;
    	}
    	
    	img.close:hover{
    		cursor:pointer;
    	}
    	
    </style>
    </head>
<body ng-view="ng-view">
<!--

    描述：顶部
-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    
    <div class="nav">
    	<a href="<%=basePath%>goods/homeGoods">
             <img src="<%=basePath%>img/biaotou.jpg" class="biao">
        </a>
           <ul class="right1">
              <c:if test="${!empty cur_user}">
              <a href="<%=basePath%>user/home?pageNum=1">
                 <li>
				 <div class="userImg">
				 	<c:if test="${empty cur_user.imgUrl}">
	                    <img src="<%=basePath%>img/3.jpg" style="width: 100%;">
	                </c:if>
	                <c:if test="${!empty cur_user.imgUrl}">
	                    <img src="<%=basePath%>upload/${cur_user.imgUrl}" style="width: 100%;">
	                </c:if>
				</div>
				 </li>
			</a>
                 <li>
                     <a class="name">${cur_user.username}</a>
                 </li>
                 <!-- <li class="notification">
                     <i ng-click="showNotificationBox()" class="iconfont"></i>
                 </li> -->
                 <li class="changemore">
                     <a class="changeMoreVertShow()">
                         <i class="iconfont"></i>
                     </a>
                     <div class="more-vert">
                         <ul class="dropdown-content">
                             <li><a href="<%=basePath%>user/home?pageNum=1">个人中心</a></li>
                             <li><a href="<%=basePath%>user/shoppingCart">我的购物车</a></li>
                             <li><a href="<%=basePath%>user/allFocus">我的关注</a></li>
                             <li><a onclick="ChangeName()">更改用户名</a></li>
                             <li><a href="<%=basePath%>user/logout">退出登录</a></li>
                         </ul>
                     </div>
                 </li>
             </c:if>
             <c:if test="${empty cur_user}">
                 <li>
                     <a onclick="showLogin()" class="login">登录</a>
                 </li>
                 <li>
                     <a onclick="showSignup()" class="register">注册</a>
                 </li>
             </c:if>
          </ul>
    </div>
    <nav class="white nav1">
        <div class="nav-wrapper">
          <!--  
            <a href="<%=basePath%>goods/homeGoods" class="logo">
                <em class="em2">校园二手市场</em>
                <em class="em3"></em>
            </a>-->
            <div class="nav-wrapper search-bar">
                <form class="ng-pristine ng-invalid ng-invalid-required" action="<%=basePath%>goods/search">
                    <div class="input-field">
                        <input id="search" name="str" placeholder="搜点什么吧..."
                               class="ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                      	<input type="submit" class="btn" value="搜索" style="margin-top: -5px;"></input>
                        
                    </div>
                </form>
            </div>
            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="publish-btn">
                       <button onclick="showLogin()" data-toggle="tooltip" 
                                title="您需要先登录哦！" class="lighten-1 waves-effect waves-light btn" 	>
                            我要发布</button>
                    </li>
                </c:if>
                
                <c:if test="${!empty cur_user}">
                <li class="publish-btn">
                     <button data-position="bottom" class="lighten-1 waves-effect waves-light btn">
                         <a href="<%=basePath%>goods/publishGoods">我要发布</a>
                     </button>
                 </li>
                 </c:if>
                 <!--  
                 <li>
                     <a href="<%=basePath%>user/allGoods">我发布的商品</a>
                 </li>
				 -->
            </ul>
        </div>
    </nav>
</div>


<!-- 登录 -->
<div ng-controller="loginController" class="ng-scope"  onkeydown="keydown()">
    <div id="login-show" class="login stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
            	<!-- <div class="col s12 title"></div> -->

                   <img class="shawu" src="<%=basePath%>img/shawu01.jpg">
					<a onclick="showLogin()" >
                		<img class="close" src="<%=basePath%>img/delete.png">
                	</a>
               
                    <div class="input-field col s12 phone">
                        <input type="text" name="phone" id="login_phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机&nbsp;&nbsp;</label><div id="login_errorPhone" style="color:red;display:inline;"></div>
                    </div>
                    <div class="input-field col s12 password">
                        <input type="password" id="login_password"  name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码&nbsp;&nbsp;</label><div id="login_errorPassword" style="color:red;display:inline;"></div>
                      <!--   <a ng-click="showForget()" class="forget-btn">忘记密码？</a> -->
                    </div>
                    <button onclick="loginIn()" id="loginIn" class="waves-effect waves-light btn login-btn lighten-1">
                        <i class="iconfont left"></i>
                        <em>登录</em>
                    </button>
                    <div class="col s12 signup-area">
                        <em>没有账号？赶快</em>
                        <a onclick="showSignup()" class="signup-btn">注册</a>
                        <em>吧！</em>
                    </div>

            </div>
        </div>
    </div>
</div>
<!--

    描述：注册
-->
<div ng-controller="signupController" class="ng-scope"  onkeydown="keydown()">
    <div id="signup-show" class="signup stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
              
                   <img class="shawu" src="<%=basePath%>img/shawu01.jpg">
                <a onclick="showSignup()">
                	<img class="close" src="<%=basePath%>img/delete.png" style="position: relative;height: 20px;left: 320px;top: 10px;">
                </a>
                    <div class="input-field col s12 nick">
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12 phone1">
                        <input id="registerPhone" type="text" name="phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机&nbsp;&nbsp;</label><div id="errorPhone" style="color:red;display:inline;position:relative;top: 5px;"></div>
                           
                    </div>
                    <div class="input-field col s12 phone1">
                        <input type="text" id="registerQq" name="qq" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>邮箱&nbsp;&nbsp;</label><div id="errorQq" style="color:red;display:inline;position:relative;top: 5px;"></div>   
                    </div>
                    <div class="input-field col s12 password1">
                        <input id="registerPassword" type="password" name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码</label><div id="errorPassword" style="color:red;display:inline;position:relative;top: 5px;"></div>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button onclick="register()" id="register" class="waves-effect waves-light btn verify-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>点击注册</em>
                        </button>
                    </div>
                    <div ng-show="checkTelIsShow" class="login-area col s12">
                        <em>已有账号？去</em>
                        <a onclick="showLogin()">登录</a>
                    </div>

            </div>
        </div>
    </div>
</div>

<!--更改用户名-->
<div ng-controller="changeNameController" class="ng-scope">
    <div id="changeName" class="change-name stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <div class="col s12 title">
                    <h1>修改用户名</h1>
                </div>
                <form:form action="../../user/changeName" method="post" commandName="user" role="form">
                    <div class="input-field col s12" style="margin-top: -20px;">
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>修改用户名</label>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button class="waves-effect waves-light btn publish-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>确认</em>
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<!--显示商品详情-->
<div ng-controller="detailBoxController" class="detail-box stark-components z-depth-1 row ng-scope">
    <div class="col s12 path">
        <a href="<%=basePath%>goods/catelog/${catelog.id}">${catelog.name}</a>
        <em>></em>
        <a>${goodsExtend.goods.name}</a>
    </div>
    <div class="col s6">
        <div class="slider" style="height: 440px;">
            <!--<ul class="slides" style="height: 400px;">
                 <img src="<%=basePath%>upload/${goodsExtend.images[0].imgUrl}" /> -->
                 
            <div class="swiper-container" style="top: -50px;">
			    <div class="swiper-wrapper">
			    	<c:forEach items="${ImageList }" var="item">
			        <div class="swiper-slide"><img src="<%=basePath%>upload/${item.imgUrl}"/></div>
			        </c:forEach>
			    </div>
			    <!-- 如果需要导航按钮 -->
			    <div class="swiper-button-prev"></div>
			    <div class="swiper-button-next"></div>
			</div>
           <!--  </ul> -->
            <ul class="indicators" style="display:none;">
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
            </ul>
        </div>
    </div>
    <div class="col s6">
        <h1 class="item-name">${goodsExtend.goods.name}</h1>
        <h2 class="item-price">${goodsExtend.goods.price}</h2>
        <h2 class="publisher-info-title">原价：<span style="text-decoration:line-through;">${goodsExtend.goods.realPrice}</span></h2>
        <div class="item-public-info">
            <p class="bargain">可讲价</p>
            <p>
                <i class="iconfont1"></i>
                <em class="item-location">华南理工大学</em>
            </p>
        </div>
        <div class="publisher-info-title">
            <em>卖家信息</em><hr>
        </div>
        <c:if test="${empty cur_user}">
            <div class="item-contact">
                <p class="not-login">
                    <a onclick="showLogin()">登录</a>
                    <em>或</em>
                    <a onclick="showSignup()">注册</a>
                    <em>后查看联系信息</em>
                </p>
            </div>
        </c:if>
        <c:if test="${!empty cur_user}">
            <div class="item-contact">
               <div>
                   <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value">${seller.username}</div>
                </div>
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value"> ${ seller.phone } </div>
                </div>
               <div>
                <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <c:if test="${seller.qq!=null}">
                    <div class="value">${seller.qq}</div>
                    </c:if>
                    <c:if test="${seller.qq==null}">
                    <div class="value">该同学没留下QQ</div>
                    </c:if>
                    
                </div>
                <div>
              
               <input type="button" value="加入购物车" class="blue lighten-1 waves-effect waves-light btn" id="btn_cart" onclick="addShoppingCart(${goodsExtend.goods.id})"></input>
               <c:if test="${cur_user.id==goodsExtend.goods.userId}">
               <input type="button" value="在线支付" data-toggle="tooltip"  title="不可以购买自己的东西哦~" disabled="disabled" class="blue lighten-1 waves-effect waves-light btn" id="btn_buy"></input>
                </c:if>
                <c:if test="${cur_user.id!=goodsExtend.goods.userId}">
               <input type="button" value="在线支付"  class="blue lighten-1 waves-effect waves-light btn" id="btn_buy" onclick="toPay(${goodsExtend.goods.id})"></input>
                </c:if>
                </div> 
                </div>
        </c:if>
        <h1 class="item-pub-time">发布于 ${goodsExtend.goods.startTime}</h1>
    </div>
</div>
<div class="detail-box stark-components z-depth-1 row" style="margin-top:0px">
    <h1 class="title">商品描述</h1>
    <hr class="hr1" />
    <hr class="hr2" />
    <p class="section">描述：${goodsExtend.goods.describle}</p>
    <p class="section"></p>
    <p class="section">
        	联系我的时候，请说明是在“校园二手市场”上看见的哦~
    </p>
</div>
<div class="row detail-area">
    <div class="clo s12">
        <div ng-controller="commentController" class="comment stark-components z-depth-1 ng-scope">
            <h1 class="title">评论</h1>
            <hr class="hr1" />
            <hr class="hr2" />
            <c:forEach var="item" items="${CommentExtend.comments}"  >
            <div class="comment-collection">
                <div class="comment-item ng-scope">
                    <div class="comment-main-content">
               			<em class="name ng-binding">${item.user.username}:</em>
                        <em class="ng-hide">回复</em>
                        <em class="name ng-binding ng-hide">@:</em>
                        <em class="ng-binding" style="font-size: 18px;">${item.content}</em>
                    </div>
                    
                    	
                    
                    <div class="comment-function">
                        <em class="time ng-biinding">${item.createAt}</em>
                       <c:if test="${item.user.id == cur_user.id && cur_user!=null}">
                    	<div style="position: relative;top: -25px;text-align: right;padding-right: 220px;">
                    		<a class="deleteComment" onclick="deleteCommentInGoods(${item.id})">删除</a>
                    	</div>
                    	</c:if>
                       <!--  <a class="reply-or-delete">删除</a>
                        <a class="reply-or-delete">回复</a> -->
                    </div>
                </div>
            </div>
             </c:forEach>
          <form id="addCommentForm" class="form-horizontal" >
            <div class="comment-add row">
                <div class="input-field col s12">
                    <i class="iconfont prefix"></i>
                    <input id="goodsId" name="goods.id" value="${goodsExtend.goods.id}" type="hidden"/>
                    <input id="commentbox" type="text" name="content" class=""/>
                    <label for="commentbox">这里写下评论</label>
                    <c:if test="${!empty cur_user}">
                    <button type="button" class="waves-effect wave-light btn comment-submit" onclick="addComments()">确认</button>
                    </c:if>
                   <%--   <c:if test="${!empty cur_user} && ${cur_user.id!=goodsExtend.comments.userId}">
                    <button type="submit" class="waves-effect wave-light btn comment-submit">确认</button>
                    </c:if>
                     <c:if test="${!empty cur_user} && ${cur_user.id==goodsExtend.comments.userId}">
                    <button data-toggle="tooltip"  title="您已经评论过了哦！" disabled="disabled"  class="waves-effect wave-light btn comment-submit">确认</button>
                    </c:if> --%>
                     <c:if test="${empty cur_user}">
                    <button href="javacript:void(0);" data-toggle="tooltip"  title="您需要先登录哦！" disabled="disabled" class="waves-effect wave-light btn comment-submit">确认</button>
                    </c:if>
                   
                </div>
            </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>        
  var mySwiper = new Swiper ('.swiper-container', {
    
	  
	 effect : 'fade',
    direction: 'horizontal', // 垂直切换选项
    loop: true, // 循环模式选项
    
  
    // 如果需要前进后退按钮
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    }

  })        
  </script>
<script type="text/javascript">

$(document).ready(function(){
	  $("#commentbox").val("");
	});


/* 评论 */
function addComments(){
	
	if(!$("#commentbox").val()){
		swal({
			  title: "Warning!",
			  text: "请输入评论内容！",
			  type: "warning",
			  confirmButtonText: "OK",
			  closeOnConfirm:"false"
		});
		
	}
	else{
	
	$.ajax({
		url:'<%=basePath%>goods/addComments',
		type:'POST',
		data:$('#addCommentForm').serialize(),// 序列化表单值  
		dataType:'json',
	/* 	success:function(json){
			alert(1)
			alert(json.msg)
		},
		error:function(){
			alert('请求超时或系统出错!');
		} */
	});
	swal({
		  title: "Success!",
		  text: "评论成功！",
		  type: "success",
		  confirmButtonText: "OK",
		  closeOnConfirm:"false"
	},
	  function(isConfirm){
	  if (isConfirm) {
		  
			window.location.reload();
			
	  } 
	});
	}

}
</script>
</html>