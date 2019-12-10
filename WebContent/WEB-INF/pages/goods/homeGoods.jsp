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
	<script type="text/javascript" src="<%=basePath%>js/top.js" ></script>
   
    <style>
    	a.hideusername:hover{
    		cursor:pointer;
    	}
    	
    	img.close:hover{
    		cursor:pointer;
    	}
    	
    </style>

<body ng-view="ng-view" >
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
                     <a href="#">
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
                      	<input type="submit" class="btn" value="搜索"></input>
                        
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
                     <button data-position="bottom" class="red lighten-1 waves-effect waves-light btn">
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
<!--
<c:if test="${!empty cur_user}">
	<h1 style="position: absolute;top: 200px;">登录成功</h1>
</c:if>
-->
<!--
    描述：登录
-->
<div ng-controller="loginController" class="ng-scope" onkeydown="keydown()">
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
                        <label>手机&nbsp;&nbsp;<div id="login_errorPhone" style="color:red;display:inline;"></div></label>
                    </div>
                    <div class="input-field col s12 password">
                        <input type="password" id="login_password"  name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码&nbsp;&nbsp;<div id="login_errorPassword" style="color:red;display:inline;"></div></label>
                      <!--   <a ng-click="showForget()" class="forget-btn">忘记密码？</a> -->
                    </div>
                    <button type="button" onclick="loginIn()" id="loginIn" class="waves-effect waves-light btn login-btn lighten-1">
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
<div ng-controller="signupController" class="ng-scope" onkeydown="keydown()">
    <div id="signup-show" class="signup stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
              
                   <img class="shawu" src="<%=basePath%>img/shawu01.jpg">
                   
                <a onclick="showSignup()">
                	<img class="close" src="<%=basePath%>img/delete.png" style="position: relative;height: 20px;left: 320px;top: 10px;">
                </a>
                
                    <div class="input-field col s12 nick">
                        <input id="registerName" type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12 phone1">
                        <input id="registerPhone" type="text" name="phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机&nbsp;&nbsp;</label><div id="errorPhone" style="color:red;display:inline;position:relative;top: 5px;"></div>
                           
                    </div>
                    <div class="input-field col s12 password1">
                        <input id="registerPassword" type="password" name="password" required="required" pattern="^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9~!@&%#_]{8,16}$" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required ng-valid-pattern" />
                        <label>密码</label><div id="errorPassword" style="color:red;display:inline;position:relative;top: 5px;"></div>
                    </div>
                    <div class="input-field col s12 phone1">
                        <input type="text" id="registerQq" name="qq" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>邮箱&nbsp;&nbsp;</label><div id="errorQq" style="color:red;display:inline;position:relative;top: 5px;"></div>   
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button type="button" onclick="register()" id="register" class="waves-effect waves-light btn verify-btn lighten-1">
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
                <div>
                	<a class="hideusername" style="height: 20px;position: relative;left: 270px;top: -40px;" onclick="ChangeName()"><img src="<%=basePath%>img/delete.png" style="width:8%"></a>
                </div>
                <form action="<%=basePath%>user/changeName" method="post"  role="form">
                    <div class="input-field col s12" style="margin-top: -20px;"> 
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>修改用户名</label>
                         
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                   <button class="waves-effect waves-light btn publish-btn red lighten-1" style="left: 59%;">
                            <i class="iconfont left"></i>
                            <em>确认</em>
                        </button>   
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--
    描述：左侧导航条
-->
<div ng-controller="sidebarController" class="sidebar stark-components ng-scope">
    <li ng-class="{true: 'active'}[isAll]">
        <a href="<%=basePath%>goods/catelog" class="index">
            <i class="fa fa-fire"></i>
            <em>最新发布</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isDigital]">
        <a href="<%=basePath%>goods/catelog/1" class="digital">
            <i class="fa fa-mobile" ></i>
            <em>闲置数码</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isRide]">
        <a href="<%=basePath%>goods/catelog/2" class="ride">
            <!--  <img src="<%=basePath%>img/ride.png"/>-->
            <i class="fa fa-bicycle bicycle"></i>
            <em>校园代步</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isCommodity]">
        <a href="<%=basePath%>goods/catelog/3" class="commodity">
            <i class="fa fa-camera"></i>
            <em>电器日用</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isBook]">
        <a href="<%=basePath%>goods/catelog/4" class="book">
            <i class="fa fa-book"></i>
            <em>图书教材</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isMakeup]">
        <a href="<%=basePath%>goods/catelog/5" class="makeup">
            <i class="fa fa-female"></i>
            <em>美妆衣物</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSport]">
        <a href="<%=basePath%>goods/catelog/6" class="sport">
            <i class="fa fa-futbol-o"></i>
            <em>运动棋牌</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="<%=basePath%>goods/catelog/7" class="smallthing">
            
            <i class="fa fa-ticket"></i>
            <em>票券小物</em>
        </a>
    </li>
    <div class="info" style="margin-top:15px">
        <a href="#">关于我们</a><em>-</em>
        <a href="#">联系我们</a>
        <p>©2019 校园二手市场</p>
    </div>
</div>
<!--

    描述：右侧显示部分
-->
<div class="main-content">
    <!--

        描述：右侧banner（图片）部分
    -->
    <div class="slider-wapper">
        <div class="slider">
            <!--<ul class="slides">
                <img src="<%=basePath%>img/lun02.jpg"/>
            </ul>-->
            <div class="swiper-container">
			    <div class="swiper-wrapper">
			        <div class="swiper-slide"><img src="<%=basePath%>img/lun01.jpg"/></div>
			        <div class="swiper-slide"><img src="<%=basePath%>img/lun02.jpg"/></div>
			        <div class="swiper-slide"><img src="<%=basePath%>img/lun03.jpg"/></div>
			    </div>
			    <!-- 如果需要导航按钮 -->
			    <div class="swiper-button-prev"></div>
			    <div class="swiper-button-next"></div>
			</div>
        </div>
    </div>
    
    <!--

        描述：最新发布
    -->
    <div class="index-title">
        <a href="<%=basePath%>goods/catelog">最新发布</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                        	<img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>斌哥认证</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <!--

        描述：闲置数码
    -->
    <div class="index-title1">
        <a href="<%=basePath%>goods/catelog/1">闲置数码</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo1 stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods1}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>斌哥认证</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <!--

        描述：校园代步
    -->
    <div class="index-title1">
        <a href="<%=basePath%>goods/catelog/2">校园代步</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo1 stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods2}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>斌哥认证</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title1">
        <a href="<%=basePath%>goods/catelog/3">电器日用</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo1 stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods3}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>斌哥认证</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title1">
        <a href="<%=basePath%>goods/catelog/4">图书教材</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo1 stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods4}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>斌哥认证</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title1">
        <a href="<%=basePath%>goods/catelog/5">美妆衣物</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo1 stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods5}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>斌哥认证</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title1">
        <a href="<%=basePath%>goods/catelog/6">运动棋牌</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo1 stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods6}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>斌哥认证</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title1">
        <a href="<%=basePath%>goods/catelog/7">票券小物</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo1 stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods7}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>斌哥认证</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<script>        
  var mySwiper = new Swiper ('.swiper-container', {
    
	  
	 effect : 'fade',
    direction: 'horizontal', // 垂直切换选项
    loop: true, // 循环模式选项
    
  
    // 如果需要前进后退按钮
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    }, 
    autoplay: true,
    autoplay: {

        disableOnInteraction: false

    }

  });     
  
  new Top({
	  s:200,
  });
  
</script>
<script type="text/javascript">
	//if(1${sessionScope.login}==10){
		//alert("登录成功");
	//}
	//var cc="${cur_user.username}";
	//console.log(cc+"==============");
</script>
</body>
</html>