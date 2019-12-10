<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head></head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
</head>

<body>
	<!--sidebar-menu-->
	<div id="sidebar">
		<ul>
			<li class="submenu"><a href="#"><i class="fa fa-user"></i>
					<span>用户管理</span> </a>
				<ul>
					<li><a href="<%=basePath%>admin/userList?pageNum=1"><i class="fa fa-angle-right"></i><span>用户列表</span></a></li>
					<%-- <li><a href="<%=basePath%>admin/user/user_add.jsp">添加用户</a></li> --%>
				</ul>
			</li>
			<li class="submenu"><a href="#"><i class="fa fa-truck"></i>
					<span>商品管理</span> </a>
				<ul>
					<li><a href="<%=basePath%>admin/goodsList?pageNum=1"><i class="fa fa-angle-right"></i><span>商品列表</span></a></li>
					<%-- <li><a href="<c:url value="/back/agent/addForm"/>">添加商品</a></li> --%>
				</ul>
			</li>
			<li class="submenu"><a href="#"><i class="fa fa-shopping-cart"></i>
					<span>订单管理</span> </a>
				<ul>
					<li><a href="<%=basePath%>admin/ordersList?pageNum=1"><i class="fa fa-angle-right"></i><span>订单列表</span></a></li>
					<%-- <li><a href="<c:url value="/back/house/addForm"/>">添加订单</a></li> --%>
				</ul>
			</li>
			<li class="submenu"><a href="#"><i class="fa fa-credit-card"></i>
					<span>钱包管理</span> </a>
				<ul>
					<li><a href="<%=basePath%>admin/purseList?pageNum=1"><i class="fa fa-angle-right"></i><span>钱包列表</span></a></li>
					<%-- <li><a href="<%=basePath%>admin/purseList?pageNum=1">审核管理</a></li> --%>
				</ul>
			</li>
			<li class="submenu"><a href="#"><i class="fa fa-gear"></i>
					<span>系统设置</span> </a>
				<ul>
					<li><a href="<%=basePath%>admin/info"><i class="fa fa-angle-right"></i><span>个人信息</span></a></li>
					<li><a href="<%=basePath%>admin/modify"><i class="fa fa-angle-right"></i><span>修改密码</span></a></li>
				</ul>
			</li>
		</ul>
	</div>
</body>
</html>
