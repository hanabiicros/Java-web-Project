<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css"/>
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js" ></script>
</head>
<body>

	<jsp:include page="main_top.jsp"></jsp:include>
	<jsp:include page="main_left.jsp"></jsp:include>
	<!--=============================================================================================================================================================================-->
	<!--main-container-part-->
	<div id="content" style="margin-right: 100px;margin-top: 40px;">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a title="主页" class="tip-bottom" href="<%=basePath%>admin/indexs"><i class="icon-home"></i>主页</a>
			</div>
		</div>
		<!--End-breadcrumbs-->

		<!-- 主要内容 -->
		<div class="container-fluid">
			<div class="quick-actions_homepage">
				<ul class="quick-actions">
					<li class="bg_lb">
						<a href="<%=basePath%>admin/userList?pageNum=1"> 
							<i class="icon-group"></i>
							用户管理
						</a>
					</li>
					<li class="bg_lg span3">
						<a href="<%=basePath%>admin/goodsList?pageNum=1"> 
						<i class="icon-signal"></i>商品管理
						</a>
					</li>
					<li class="bg_lo"><a
						href="<%=basePath%>admin/ordersList?pageNum=1"> <i
							class="icon-th"></i>订单管理
					</a></li>
					<li class="bg_ly"><a href="<%=basePath%>admin/purseList?pageNum=1"> 
					<i class="icon-inbox"></i>钱包管理
					</a></li>
					<li class="bg_ls dropdown">
						<a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" id="dropdownMenu1"> 
						<i class="icon-fullscreen"></i>
						系统设置
						</a>
						
						<ul class="dropdown-menu" style="background-color: #2E363F;width:100%" id="dropDownCur">
							<li style="width:100%;min-height: 40px;"><a href="<%=basePath%>admin/info" style="text-align: center;width:100%">个人信息</a></li>
							<li style="width:100%;min-height: 40px;"><a href="<%=basePath%>admin/modify" style="text-align: center;width:100%">修改密码</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<!--==================================================================================================================-->
	<jsp:include page="main_bottom.jsp"></jsp:include>

</body>

<script>
$("#dropdownMenu1").hover(
        function(){
            $("#dropDownCur").show();
    });//为了鼠标可以进入下拉框
    $("#dropDownCur").hover(function() {
        $(this).show();//鼠标进入下拉框
    }, function() {
        $(this).hide();//鼠标离开下拉框后，就会消失
    });
</script>
</html>
