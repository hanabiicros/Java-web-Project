<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的购物车</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="<%=basePath%>css/emoji.css" />
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <link rel="stylesheet" href="<%=basePath%>fonts/iconfont.css" />
     <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="<%=basePath%>css/sweetalert.min.css" rel="stylesheet">
	<script type="text/javascript" src="<%=basePath%>js/sweetalert.min.js"></script>
   
   <style>
   		a:hover{
   			text-decoration:none;
   		}
   </style>
</head>
<body>
<div class="pre-2" id="big_img">
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif" class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">
    <div id="user_area">
        <div id="home_header">
            
            <a href="<%=basePath%>goods/homeGoods">
                 <img src="<%=basePath%>img/biaotou.jpg"  style="height: 65px;" >
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
                        <li class="shoppingcart">
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

                    描述：购物车展示
                -->
               
                <div class="share_content">
                    <c:if test="${empty goodsAndImage}">
                        <div class="no_share">
                            <span>没有任何内容，去逛逛吧！</span>
                        </div>
                    </c:if>
                    <c:if test="${!empty goodsAndImage}">
                        <form method="post" id="form" action="<%=basePath%>goods/buyIds">
                            <div class="w750">
                            	<ul class="shopping_title">
                            		<li class="f1">
                            			<a id="j_selectall" href="javascript:void(0)" class="check checkall checkon" onclick="checkall()"></a>
                            		全选</li>
                            		<li class="f2">商品信息</li>
                            		<li class="f3">金额</li>
                            		<li class="f4">操作</li>
                            	</ul>
                            	<div class="fn-shop">
                            		<div class="shopping_list">
                            			<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            				<c:forEach var="items" items="${goodsAndImage}">
                            				<tbody>
                            					<tr>
                            						<td class="row1">
                            							<a href="javascript:void(0)" class="check checknow checkon" id="${items.goods.id}">选中</a>
                            							<input type="hidden" value="${items.goods.price }">
                            						</td>
                            						<td class="row_img">
                            							<a href="<%=basePath%>goods/goodsId/${items.goods.id}">
						                                    <img src="../upload/${items.images[0].imgUrl}">
						                                </a>
                            						</td>
                            						<td class="row_name">
                            							<div class="rname">${items.goods.name}</div>
                            						</td>
                            						<td class="row3">
                            							<span class="red">￥${items.goods.price}</span>
                            							
                            						</td>
                            						<td>
                            							<span><a>移入收藏</a></span>
                            							<span><a onclick="deleteGoodsInShoppingCart(${items.goods.id})">删除</a></span>
                            						</td>
                            					</tr>
                            					<tr>
                            					</tr>
                            				</tbody>
                            				</c:forEach>
                            			</table>
                            		</div>
                            	</div>
                            	<!--  
                                <a href="<%=basePath%>goods/goodsId/${items.goods.id}" class="head_img">
                                    <img src="../upload/${items.images[0].imgUrl}">
                                </a>
                                <span class="name" style="margin-left:30px;">${items.goods.name}</span>
                                <span class="text" style="overflow: hidden; outline: none;">${items.goods.describle}</span>
                                <div class="box">
                                    <div class="box_content">
                                        <div class="left_shadow"></div>
                                        <div class="left" index="1" style="display: none;"><</div>
                                        <div class="right_shadow"></div>
                                        <div class="left" index="3" style="display: none;">></div>
                                        <img src="../upload/${items.images[0].imgUrl}" index="2">
                                        <span class="com" style="display: none;left: 396.733px;"></span>
                                    </div>
                                    <c:if test="${items.goods.status == 1 && items.goods.endTime > date}">
                                    <div class="interact">
                                        <span class="fa fa-heart fa-lg" style="color: #F6492F;"><a href="<%=basePath%>goods/goodsId/${items.goods.id}">前往购买</a></span>
                                        <span class="fa fa-heart-o fa-lg"><a href="<%=basePath%>user/deleteFocus/${items.goods.id}">取消关注</a></span>
                                    </div>
                                    </c:if>
                                    <c:if test="${items.goods.status == 0}">
                                    	<div class="interact">
                                    		<span style="color: #939cac;">抱歉，您关注的该商品已被购买或下架，请<a href="<%=basePath%>user/deleteFocus/${items.goods.id}" style="color: #F6492F;">取消关注</a></span>
                                    	</div>
                                    </c:if>
                                    <c:if test="${items.goods.status == 1 && items.goods.endTime < date}">
                                    	<div class="interact">
                                    		<span style="color: #939cac;">抱歉，您关注的该商品已过期，请<a href="<%=basePath%>user/deleteFocus/${items.goods.id}" style="color: #F6492F;">取消关注</a></span>
                                    	</div>
                                    </c:if>
                                    <br>
                                </div>
                            </div>
                            -->
                        </div>
                        <div>
                        	<div class="shopping_total">
                        		<div class="shopping_total_right">
                        			<a class="total_btn fn-checkout" onclick="account()">结&nbsp;&nbsp;算<span id="total_num"></span></a>
                        			<div class="subtotal">
                        				<p>
                        					<span class="cartsum">合计：</span>
                        					<span class="price">￥<span id="total_price">0</span></span>
                        				</p>
                        			</div>
                        		</div>
                        		
                        	</div>
                        </div>
                        <input type="hidden" value="" id="goodsIds" name="goodsIds">
                        <input type="hidden" value="" id="totalPrice" name="totalPrice">
                        </form>
                    </c:if>
                </div>
            </div>
          </div>
     </div>
</div>
<script>


	$(document).ready(function(){
		var totalSum = 0
		
		$('.checkon').each(function(key,value){
			if(!$(this).hasClass('checkall')){
				totalSum = totalSum + parseFloat($(this).next().val())
			}
			
		})
		
		
		$("span#total_price").text(totalSum);
		$("#totalPrice").val(totalSum)
	})
	
	function deleteGoodsInShoppingCart(goodsId){
		$.ajax({
			 url:'<%=basePath%>goods/deleteShoppingGoods',
			 type:'POST',
			 data:{goodsId:goodsId},
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
				 else{
					 swal({
						  title: "Success!",
						  text: json.msg,
						  type: "success",
						  confirmButtonText: "OK"
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
	
	function account(){
		
		var goodsIds = new Array();
		$('.checkon').each(function(key,value){
			if(!$(this).hasClass('checkall')){
			goodsIds[key] = $(this).attr("id");
			}
			else{
				goodsIds[key] ="-1"
			}
		})
		if(goodsIds[0]=="-1"){
			goodsIds = goodsIds.slice(1)
		}
		var Ids = goodsIds.join(',')
		$("#goodsIds").val(Ids);
		
		//$("span#total_price").text(totalSum);
		//alert(totalSum);
		$("#form").submit();
	}
	
	$('a.checknow').click(function(e){  
        
       // alert($(this).attr("id"));   
        var totalSum = 0
        var checkall = true
		//alert($(event.target).attr("id"))
		//console.log($(this))
		if($(this).hasClass('checkon')){
			$(this).removeClass("checkon")
		}
		else{
			$(this).addClass("checkon")
		}
        
        if($('a.checkall').hasClass('checkon'))
        {
        	$('a.checkall').removeClass("checkon")
		}
        
		$('.checknow').each(function(key,value){
			
			if(!$(this).hasClass('checkon')){
				checkall = false
			}
			
		})
		if(checkall==true){
			if(!$('a.checkall').hasClass('checkon'))
	        {
	        	$('a.checkall').addClass("checkon")
			}
		}
        
		$('.checkon').each(function(key,value){
			if(!$(this).hasClass('checkall')){
			totalSum = totalSum + parseFloat($(this).next().val())
			}
		})
		
		$("span#total_price").text(totalSum)
		$("#totalPrice").val(totalSum)
		
	});  
	
	function checkall(){
		 var totalSum = 0
		$('a.check').each(function(key,value){
			if(!$(this).hasClass('checkon')){
				$(this).addClass("checkon")
			}
		})
		$('.checkon').each(function(key,value){
			if(!$(this).hasClass('checkall')){
			totalSum = totalSum + parseFloat($(this).next().val())
			}
		})
		
		$("span#total_price").text(totalSum);
		 $("#totalPrice").val(totalSum)
	}
</script>
</body>
</html>