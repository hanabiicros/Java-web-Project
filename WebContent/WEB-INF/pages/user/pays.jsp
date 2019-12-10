<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>确认订单</title>

<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
<link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
<link rel="stylesheet" href="<%=basePath%>css/user.css" />
<link rel="stylesheet" href="<%=basePath%>fonts/iconfont.css" />

<!-- bootstrap -->
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>

<!--订单编号随机数（有可能重复，得处理）  -->
<script type="text/javascript">
	window.onload = function() {
		var o = document.getElementsByClassName('order-num');

		o[0].value = fRandomBy(00000000, 99999999);
	}
	function fRandomBy(under, over) {
		switch (arguments.length) {
		case 1:
			return parseInt(Math.random() * under + 1);
		case 2:
			return parseInt(Math.random() * (over - under + 1) + under);
		default:
			return 0;
		}
	}
</script>


</head>
<body>
	<div class="pre-2" id="big_img">
		<img
			src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif"
			class="jcrop-preview jcrop_preview_s">
	</div>
	<div id="cover" style="min-height: 639px;">
		<div id="user_area">
			<div id="home_header">
				<a href="<%=basePath%>goods/homeGoods">
                 <img src="<%=basePath%>img/biaotou.jpg"  style="height: 65px;">
           		 </a> 
			</div>
			<!--

            描述：左侧个人中心栏
        -->
			<div id="user_nav">
				<div class="user_info">
					<div class="head_img">
						<c:if test="${empty cur_user.imgUrl}">
	                    <img  src="<%=basePath%>img/3.jpg">
	                </c:if>
	                <c:if test="${!empty cur_user.imgUrl}">
	                    <img src="<%=basePath%>upload/${cur_user.imgUrl}">
	                </c:if>
					</div>
					<div class="big_headimg">
						<img src="">
					</div>
					<span class="name">${cur_user.username}</span>
					<hr>
					<!--   <span class="school">莆田学院</span> -->
				   <a class="btn" style="width: 98%;background-color: rgb(79, 190, 246);color:rgba(255, 255, 255, 1);" href="<%=basePath%>user/myPurse">我的钱包：￥${myPurse.balance}</a>
                <input type="hidden" value="${myPurse.recharge}" id="recharge"/>
                <input type="hidden" value="${myPurse.withdrawals}" id="withdrawals"/>
               <span class="btn" data-toggle="modal" data-target="#myModal"style="width: 98%; background-color: rgb(79, 190, 246); color: rgba(255, 255, 255, 1); margin-top: 0.5cm;">我的信用积分：${cur_user.power}</span>

				</div>
				<div class="home_nav">
					<ul>
					<a href="<%=basePath%>user/home?pageNum=1">
                        <li class="buyInfo">
                            <div>
                            <i class="iconfont icon-Notice" style="font-size: 30px;"></i>
                        </div>
                            <span>求购信息</span>
                            <strong></strong>
                        </li>
                    </a>
						<a href="<%=basePath%>orders/myOrders">
                        <li class="notice">
                            <div>
                            <i class="iconfont icon-emaxcitygerenxinxitubiaoji03" style="font-size: 30px;"></i>
                        </div>
                            <span>订单中心</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/shoppingCart">
                        <li class="notice">
                            <div>
                            <i class="iconfont icon-gouwuche" style="font-size: 30px;"></i>
                        </div>
                            <span>购物车</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allFocus">
                        <li class="fri">
                           <div>
                            <i class="iconfont icon-focus" style="font-size: 30px;"></i>
                        </div>
                            <span>关注列表</span>
                            <strong></strong>
                        </li>
                    </a>
                    
                    <a href="<%=basePath%>goods/publishGoods">
                        <li class="store">
                            <div>
                            <i class="iconfont icon-ic-published" style="font-size: 30px;"></i>
                        </div>
                            <span>发布物品</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allGoods">
                        <li class="second">
                            <div>
                            <i class="iconfont icon-goods" style="font-size: 30px;"></i>
                        </div>
                            <span>我的闲置</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/basic">
                        <li class="set">
                            <div>
                            <i class="iconfont icon-setting" style="font-size: 30px;"></i>
                        </div>
                            <span>个人设置</span>
                            <strong></strong>
                        </li>
                    </a>
					</ul>
				</div>
			</div>
			<!--

            描述：右侧内容区域
        -->
			<div id="user_content">

				<div class="share">

					<!--

                    描述：购物车商品展示
                -->
					<h1 style="text-align: center">确认订单</h1>
					<hr />
					<div class="share_content">
						<div class="story">
							<form class="form-horizontal" role="form" action="<%=basePath%>orders/addOrdersbyGoodsIds" >
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
								<tbody>
									<tr>
										<th scope="col" class="th_img">&nbsp;</th>
										<th scope="col" class="th_name">商品名称</th>
										<th scope="col">金额</th>
									</tr>
									
									<c:forEach var="items" items="${goodsAndImage}">
	                   					<tr>
	                   						<td class="img">
	                   							<a href="<%=basePath%>goods/goodsId/${items.goods.id}">
	                                 				<img src="../upload/${items.images[0].imgUrl}" width="70" height="70">
	                            	 			</a>
	                   						</td>
	                   						<td class="name" style="margin: 0;">
	                   							<div class="rname">${items.goods.name}</div>
	                   						</td>
	                   						<td style="text-align: left;">
	                   							<span>${items.goods.price}</span>
	                   						</td>
	                   					</tr>
                   					</c:forEach>
                   				</tbody>
                   				</table>
                   				<div id="shipment_sub_0_0_div" class="sub">
                   					<div class="sub_right">
                   						<p style="margin: 0 65px 20px;">
                   							<span class="tab">店铺合计：</span>
                   							<span class="price red"> ${totalPrice} </span>
                   						</p>
                   					</div>
                   				</div>
                   				<input type="hidden" value="${goodsNum}" name="goodsNum">
                   				<input type="hidden" value="${goodsIds}" name="goodsIds">
                   				<input type="hidden" value="${totalPrice}" name="orderPrice">
                   				<div class="form-group">
									<div class="col-sm-offset-4 col-sm-8">
									    <a href="<%=basePath%>user/shoppingCart" class="btn btn-danger">返回购物车</a>
										<c:if test="${myPurse.balance >= totalPrice}"><button type="submit" class="btn btn-info">立即支付</button></c:if>
										<c:if test="${myPurse.balance < totalPrice}"><button disabled="disabled" class="btn btn-danger">余额不足，请充值！</button></c:if>
										
									</div>
								</div> 
							<!-- 
							<h4 style="position: relative;left: 190px;">订单编号： <input class="order-num" type="text" style="border:0px;" value="" name="orderNum"/>  <input name="goodsId" type="hidden" value="${goodsExtend.goods.id}"/> </h4>
								<div class="form-group">
									<label for="firstname" class="col-sm-4 control-label" style="margin-top: 10px;right: 9px;">图片:</label>
									<div class="col-sm-6">
                							<img style="height:150px;weight:150px;margin-top: 10px;" src="<%=basePath%>upload/${goodsExtend.images[0].imgUrl}" />
									</div>
									<label for="firstname" class="col-sm-4 control-label" style="margin-top: 10px;">名称：</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" disabled="disabled" style="border:0px;background:#F6F6F6; margin-top: 10px;" value="${goodsExtend.goods.name}" >
									</div>
									<label for="firstname" class="col-sm-4 control-label" style="margin-top: 10px;">价格：</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" style="border:0px;background:#F6F6F6;margin-top: 10px; " value="${goodsExtend.goods.price}" name="orderPrice">
									</div>
									<label for="firstname" class="col-sm-4 control-label" style="margin-top: 10px;">备注：</label>
									<div class="col-sm-6">
										<input style="margin-top: 10px;" type="text" class="form-control" 
											placeholder="请输入备注（收获人信息 地址 联系方式等）" value="" name="orderInformation">
									</div>
								</div>
								<hr />
								-->
							</form>
						</div>
					</div>
				</div>
				<!--

                描述：最右侧，可能认识的人
            
				<div class="recommend">
					<div class="title">
						<span class="text">可能认识的人</span> <span class="change">换一组</span> <span
							class="underline"></span>
					</div>
					<ul>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo1.jpg">
						</a> <span>Brudce</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo2.jpg">
						</a> <span>Graham</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo3.jpg">
						</a> <span>hly</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo4.jpg">
						</a> <span>Danger-XFH</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo5.jpg">
						</a> <span>Keithw</span>
							<div class="fa fa-plus-square"></div></li>
					</ul>
				</div>
				-->
			</div>
		</div>
	</div>
</body>
</html>