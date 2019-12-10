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
<title>订单中心</title>

<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
<link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
<link rel="stylesheet" href="<%=basePath%>css/user.css" />
<link rel="stylesheet" href="<%=basePath%>fonts/iconfont.css" />
<!-- bootstrap -->
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/sweetalert.min.css" rel="stylesheet">
	<script type="text/javascript" src="<%=basePath%>js/sweetalert.min.js"></script>

<script type="text/javascript">

	function ordersDeliver(orderId){
		$.ajax({
			 url:'<%=basePath%>orders/deliver/'+orderId,
			 type:'POST',
			 data:{},
			 dataType:'json',
			 success:function(json){
				 if(!json.success){
					 swal({
						  title: "Error!",
						  text: "发货失败，请稍后重试",
						  type: "error",
						  confirmButtonText: "OK"
						});
					}
				 else{
					 swal({
						  title: "Success!",
						  text: "发货成功，邮件已发送至对方，请等待对方确认收货~",
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
		
		function ordersReceipt(orderId,orderPrice){
			
			$.ajax({
				 url:'<%=basePath%>orders/receipt',
				 type:'POST',
				 data:{orderId:orderId,orderPrice:orderPrice},
				 dataType:'json',
				 success:function(json){
					 if(!json.success){
						 swal({
							  title: "Error!",
							  text: "收货失败，请稍后重试",
							  type: "error",
							  confirmButtonText: "OK"
							});
						}
					 else{
						 swal({
							  title: "Success!",
							  text: "收货成功，感谢您的信任~",
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

</head>
<body style="background-color: #f6f8fa;">
	<div class="pre-2" id="big_img">
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif" class="jcrop-preview jcrop_preview_s">
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
	                    <img src="<%=basePath%>img/3.jpg">
	                </c:if>
	                <c:if test="${!empty cur_user.imgUrl}">
	                    <img src="<%=basePath%>upload/${cur_user.imgUrl}">
	                </c:if>
                </div>
                <div class="big_headimg">
                    <img src="">
                </div>
                <span class="name">${cur_user.username}</span><hr>

                  <a class="btn" style="width: 98%;background-color: rgb(79, 190, 246);color:rgba(255, 255, 255, 1);" href="<%=basePath%>user/myPurse">我的钱包：￥${myPurse.balance}</a>
                <input type="hidden" value="${myPurse.recharge}" id="recharge"/>
                <input type="hidden" value="${myPurse.withdrawals}" id="withdrawals"/>
               <span class="btn" data-toggle="modal" data-target="#myModal" style="width: 98%;background-color: rgb(79, 190, 246); color:rgba(255, 255, 255, 1);margin-top:0.5cm;">我的信用积分：${cur_user.power}</span>
                
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

                    描述：订单展示
                -->
					
					<div class="share_content">
						  <c:if test="${empty orders and empty ordersOfSell}">
                        <div class="no_share">
                            <span>没有任何内容，去逛逛其它的吧！</span>
                        </div>
                    </c:if>
					 <c:if test="${!empty orders or !empty ordersOfSell}">
						<div class="story">

							<div class="container">
								<!-- Nav tabs -->
								<ul class="nav nav-tabs" role="tablist" style="width: 46%">
									<!-- <li class="nav-item"><a class="nav-link active"
										data-toggle="tab" href="#home">全部订单</a></li> -->
									<li class="nav-item"><a class="nav-link active" data-toggle="tab"
										href="#orders_my" >我买的</a></li>
									<li class="nav-item" ><a class="nav-link" data-toggle="tab"
										href="#orders_other" >我卖的</a></li>
								</ul>

								<!-- Tab panes -->
								<div class="tab-content" style="width: 46%">
									<!-- <div id="home" class="container tab-pane active"
										style="width: 100%">
										<br>
										<from>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit, sed do eiusmod tempor incididunt ut labore et dolore
											magna aliqua.</p>
										</from>
									</div> -->
									<!-- 买家订单中心 -->
									<div id="orders_my" class="container tab-pane active"
										style="width: 100%">
										<br>
										<form class="form-horizontal" role="form">
											<div class="table-responsive">
												<table class="table">
												<c:forEach var="items" items="${orders}">
													<thead>
													<tr>
													</tr>
														<tr>
														  <th >订单编号</th>
														  <th>${items.id}</th>
														  <th>操作</th>
														  <th>
															
															<c:if test="${items.orderState==1}"><input type="button" value="待发货" class="btn btn-info"/></c:if>
															<c:if test="${items.orderState==2}"><input type="button" value="收&nbsp&nbsp&nbsp&nbsp货" onclick="ordersReceipt(${items.id},${items.orderPrice})" class="btn btn-info"/></c:if>
															<c:if test="${items.orderState==3}"><input type="button" value="已完成" class="btn btn-info"/></c:if>
															
															
															</th>
														</tr>
														<tr>
															<th style="border-bottom: none;border-top: none;"></th>
															<th style="border-bottom: none;border-top: none;">名称</th>
															<th style="border-bottom: none;border-top: none;">价格</th>
															<th style="border-bottom: none;border-top: none;">备注</th>
															
														</tr>
													</thead>
													<tbody>
													<c:forEach var="goodsItems" items="${items.goods}">
                                            			<tr>
                                            				<td style="border-bottom: none;border-top: none;"></td>
															<td style="border-bottom: none;border-top: none;">${goodsItems.name}</td>
															<td style="border-bottom: none;border-top: none;">${goodsItems.price}</td>
															
															<td style="border-bottom: none;border-top: none;">${items.orderInformation}</td>
														</tr>
                    								</c:forEach> 	
                    								</c:forEach>
													</tbody>
												</table>
											</div>

										</form>
									</div>
									<!-- 卖家订单中心 -->
									<div id="orders_other" class="container tab-pane fade"
										style="width: 100%">
										<br>
										<form class="form-horizontal" role="form">
											<div class="table-responsive">
												<table class="table">
												<c:forEach var="items" items="${ordersOfSell}">
													<thead>
													<tr>
													</tr>
														<tr class="text-center">
														  <th>订单编号</th>
														  <th>${items.id}</th>
														  <th>操作</th>
														  <th>
															
															<c:if test="${items.orderState==1}"><input type="button" value="发&nbsp&nbsp&nbsp&nbsp货" onclick="ordersDeliver(${items.id})" class="btn btn-info"/></c:if>
															<c:if test="${items.orderState==2}"><input type="button" value="待收货"  class="btn btn-info"/></c:if>
															<c:if test="${items.orderState==3}"><input type="button" value="已完成" class="btn btn-info"/></c:if>
															
															
															</th>
														</tr>
														<tr>
															<th style="border-bottom: none;border-top: none;"></th>
															<th style="border-bottom: none;border-top: none;">名称</th>
															<th style="border-bottom: none;border-top: none;">价格</th>
															<th style="border-bottom: none;border-top: none;">备注</th>
															
														</tr>
													</thead>
													<tbody>
													
                                            		
													<c:forEach var="sellgoodsItems" items="${items.goods}">
														<tr>
                                            				<td style="border-bottom: none;border-top: none;"></td>
															<td style="border-bottom: none;border-top: none;">${sellgoodsItems.name}</td>
															<td style="border-bottom: none;border-top: none;">${sellgoodsItems.price}</td>
															
															<td style="border-bottom: none;border-top: none;">${items.orderInformation}</td>
															
														</tr>
													</c:forEach>
                    					</c:forEach>
												 </tbody>
												</table>
											</div>

										</form>
									</div>
								</div>
							</div>
						</div>

						     </c:if>
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