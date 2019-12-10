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
    <meta charset="UTF-8">
    <title>个人中心</title>

    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="<%=basePath%>css/emoji.css" />
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <link href="<%=basePath%>css/mypage.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath%>fonts/iconfont.css" />
    <link rel="stylesheet" href="<%=basePath%>css/OwO.min.css" />
    <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/OwO.min.js"></script>
    
    
    <link rel="stylesheet" href="<%=basePath%>css/sweetalert.min.css" rel="stylesheet">
	<script type="text/javascript" src="<%=basePath%>js/sweetalert.min.js"></script>
   <script type="text/javascript">
   
   function viewPersonal(id){
	   $.ajax({
			url:'<%=basePath%>admin/getUser',
			type:'GET',
			data:{id:id},
			dataType:'json',
			success:function(json){
				if(json){
					$('#myviewform').find("input[name='phone']").val(json.phone);
					$('#myviewform').find("input[name='username']").val(json.username);
					$('#myviewform').find("input[name='qq']").val(json.qq);
					$('#myviewform').find("input[name='power']").val(json.power);
					$('#myviewform').find("input[name='createAt']").val(json.createAt);
					$('#viewModal').modal('toggle');
				}
			},
			error:function(){
				swal({
					  title: "Error!",
					  text: "请求超时或系统出错！",
					  type: "error",
					  confirmButtonText: "OK"
					});
				$('#viewModal').modal('hide');
			}
   });
  }
   
   function sendContext(){
	

	 
	 var context= $("#mycontext").val();
	 //var curuserName=$("#hidCurUserName").val();
	 $("#mycontext").val("");
      if(!context){
    	  swal({
			  title: "Error!",
			  text: "请输入内容！",
			  type: "error",
			  confirmButtonText: "OK"
			});
      }
      else{
    	  
	 $.ajax({
		 url:'<%=basePath%>user/insertSelective',
		 type:'POST',
		 data:{context:context},
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
				 //alert(json.noticeId);
				 location.reload();
				// var temp=$("<hr style='top: -70px;position: relative;'>"+"<div style='padding-bottom:10px' id="+json.noticeId+">"+"<div style='width: 60px;height: 60px;border-radius: 40px;overflow: hidden;position: relative;right: 100px;'><img style='width:100%' src="+curuserImg +">" + "</div><span style='font-size: 13px;font-weight: bold;color: dimgray;position: relative;top: -62px;'>" + curuserName + "</span>" + "<div style='font-size: 16px;color: black;position: relative;top: -63px;'>" + context + "</div>"+"<span style='text-align:right;color:#4fbef6;position:relative;top:-60px;font-size: 13px'>"+json.createAt+"</span>"+"</div>"+"<button class='reply' onclick='reply("+json.noticeId+")'>回复</button>"+"<div id='reply"+json.noticeId+"' class='publish' style='display:none;height: 120px;position: relative;top: -80px;left: 80px;margin-top: 15px;'>"+"<div style='display:block' id='inUserReply"+json.noticeId+"'>'"+"</div>")
		  		//$(".yes_share").prepend(temp);
				 
				
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
   }
   
   function sendInUserContext(commentId){
	   var curuserName=$("#hidCurUserName").val();
	   var curuserImg="<%=basePath%>upload/"+$("#hidCurUserImg").val();
		 var atuserId=$("#hiduserid"+commentId).val();
		 var content= $("#mycontext"+commentId).val();
		 $("#mycontext"+commentId).val("");
		 if(!content){
			 swal({
				  title: "Error!",
				  text: "请输入内容！",
				  type: "error",
				  confirmButtonText: "OK"
				});
		 }
		 else{
		 $.ajax({
			 url:'<%=basePath%>user/insertInUserSelective',
			 type:'POST',
			 data:{content:content,atuserId:atuserId,commentId:commentId},
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
					 //var replyId="'"+json.replyId+"'";
					 //var comId="'"+commentId+"'";
					 var tmp="<div id='UnderReply"+json.replyId+"'>"+"<div style='width: 30px;height: 30px;border-radius: 40px;overflow: hidden;position: relative;right:0px;top: -35px;'><img style='width:100%' src="+curuserImg +">" + "</div><span style='font-size: 13px;font-weight: bold;color: dimgray;position: relative;top: -68px;left:40px;margin-right: 20px;'>" + curuserName + "</span>" + "<span style='font-size: 16px;color: black;position: relative;top: -66px;left: 60px;'>" + content + "</span>"+"<div style='text-align:right;color:#4fbef6;position:relative;top:-60px;font-size: 13px;right: 405px;'>"+json.createAt+"</div>"+"<button class='indelete' onclick='deleteInUserReply("+"\""+json.replyId+"\""+","+"\""+commentId+"\""+")'>"+"删除</button>"+"</div>";
					 $("#inUserReply"+commentId).prepend(tmp);
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
	   }
   
   function deleteReply(id){
	   
	   swal({
			  title: "确定删除吗？",
			  text: "删除后，评论下的所有回复都将删除",
			  type: "warning",
			  confirmButtonText: "OK",
			  showCancelButton: true,
			  closeOnConfirm:"false"
		},
		  function(isConfirm){
		  if (isConfirm) {
			  $.ajax({
					 url:'<%=basePath%>user/deleteReply',
					 type:'GET',
					 data:{id:id},
					 dataType:'json',
					 success:function(json){
						 //location.reload();
						 $("div#"+id).remove();
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
		});

		 
		   
	   }
   
   function deleteInUserReply(id,underId){

	   
	   var commentId=$("#hidcommentid"+underId).val();
		 $.ajax({
			 url:'<%=basePath%>user/deleteInUserReply',
			 type:'GET',
			 data:{id:id,commentId:commentId},
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
					 $("div#UnderReply"+id).remove();
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
   
   $(function(){
       var options={
           bootstrapMajorVersion:1,    //版本
           currentPage:1,    //当前页数
           numberOfPages:5,    //最多显示Page页
           totalPages:10,    //所有数据可以显示的页数
           onPageClicked:function(e,originalEvent,type,page){
               console.log("e");
               console.log(e);
               console.log("originalEvent");
               console.log(originalEvent);
               console.log("type");
               console.log(type);
               console.log("page");
               console.log(page);
           }
       }
       //$("#page").bootstrapPaginator(options);
   })
   </script>
<style type="text/css">


	
	button.reply{
		color:white;
		background-color:#4fbef6;
		text-decoration: none;
		border: none;
		position: relative;
		top: -60px;
		left: 183px;
		width: 50px;
		border-radius: 10px;
	
	}
	button.reply:hover{
		border:none;
		cursor:pointer;
		text-decoration:none;
	}
	
	button.delete{
		color:white;
		background-color:#E75451;
		text-decoration: none;
		border: none;
		position: relative;
		top: -60px;
		left: 220px;
		width: 50px;
		border-radius: 10px;
	
	}
	button.delete:hover{
		border:none;
		text-decoration:none;
		cursor:pointer;
	}
	
	button.indelete{
		color:white;
		background-color:#E75451;
		text-decoration: none;
		border: none;
		position: relative;
		top: -90px;
		left: 290px;
		width: 50px;
		border-radius: 10px;
	
	}
	button.indelete:hover{
		border:none;
		text-decoration:none;
		cursor:pointer;
	}
	
	a.lookReply{
		color:#29A4E8;
	}
	
	a.lookReply:hover{
		border:none;
		text-decoration:none;
		cursor:pointer;
	}

</style>
</head>
<body>
<div class="pre-2" id="big_img">
    <img src="<%=basePath%>img/head_loading.gif" class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">
    <div id="user_area">
        <div id="home_header">
            <!-- <a href="<%=basePath%>goods/homeGoods">
                <h1 class="logo"></h1>
            </a> -->
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
                <span class="btn" data-toggle="modal" data-target="#myModal" style="width: 98%;background-color: rgb(79, 190, 246); color:rgba(255, 255, 255, 1);margin-top:0.5cm;">
                	我的信用积分：${cur_user.power}
                </span>
                
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
        <div id="user_content" style="position: relative;left: 60px;">
            <div class="share">
            	<!-- 顶部发布评论部分 -->
                <div class="publish">
	                <div style="width: 60px;height: 60px;border-radius: 40px;overflow: hidden;position: relative;right: 100px;top: 45px;">
		               	<c:if test="${empty cur_user.imgUrl}">
		                    <img src="<%=basePath%>img/3.jpg"  style="width:100%">
		                 </c:if>
		                 <c:if test="${!empty cur_user.imgUrl}">
		                    <img src="<%=basePath%>upload/${cur_user.imgUrl}" style="width:100%">
		                 </c:if>
	                </div>
	                     <div class="pub_content">
	                        <div class="text_pub lead emoji-picker-container">
	                            <textarea id="mycontext" name="context" class="OwO-textarea" data-type="original-input" style="width: 510px;min-height: 75px;line-height: 25px;color: #333;font-size: 16px;border-radius: 4px;border: 1px solid #ccc;"></textarea>
	                           <div class="OwO"></div>
	                        </div>
	                    </div>
	                 	 
	                 	  
	                    <div class="button">
	                        <!-- 
	                        	<span class="fa fa-image">
	                            ::before
	                            <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png" multiple/>
	                        </span>
	                         -->
	                        <div class="checkbox" style="width:135px;">
	                            <button onclick="sendContext()" style="position: relative;height: 70px;width: 80px;top: -150px;right:-60px;border-radius: 5px;"><span>发表</span><br><span>评论</span></button>
	                        </div>
	                    </div> 
                    
                </div>
                <!-- 
                	评论及回复信息展示
                -->
                <div class="share_content" style="position: relative;top: -55px;">
	                <c:if test="${notice==null}">
	                    <div class="no_share">
	                    <span>没有任何内容，去逛逛其它的吧！</span>
	                    </div>
	                </c:if>
	                
                   <c:if test="${notice!=null}">
                   <div>
                    	<p style="color: black;font-size: 22px;font-weight: lighter;position: relative;left: -110px;margin-bottom: 40px;">${noticeGrid.totalnum}&nbsp;&nbsp;求购信息</p>
                    </div>
                    <div class="yes_share">
                    
                    <div style="width: 550px;background-color: #D8DADB;height: 1px;margin-bottom: 40px;"></div>
                    <input id="hidCurUserName" type="hidden" value="${cur_user.username}">
                    <input id="hidCurUserImg" type="hidden" value="${cur_user.imgUrl}">
                    
                    
                     <c:forEach items="${noticeGrid.rows}" var="item" varStatus="status">
                     
                     
                     <div style="padding-bottom:10px" id="${item.id }">
                     <input id="hiduserid${item.id }" type="hidden" value="${item.userId }">
                     <input id="hidcommentid${item.id }" type="hidden" value="${item.id }">
                     <div style="width: 60px;height: 60px;border-radius: 40px;overflow: hidden;position: relative;right: 100px;">
	                     <c:if test="${empty item.user.imgUrl}">
		                    <img src="<%=basePath%>img/3.jpg"  style="width:100%">
		                 </c:if>
		                 <c:if test="${!empty item.user.imgUrl}">
		                    <img src="<%=basePath%>upload/${item.user.imgUrl}" style="width:100%">
		                 </c:if>
                     </div>
                   	 <span style="font-size: 13px;font-weight: bold;color: dimgray;position: relative;top: -62px;">${item.user.username}</span>
                     <div style="font-size: 16px;color: black;position: relative;top: -63px;">${item.context}</div>
                     
                     <span style="text-align:right;color:#4fbef6;position:relative;top:-60px;font-size: 13px;">${item.createAt}</span>
                     <!-- <div class="reply" style="width: 50px;text-align: center;border-radius: 10px;position: relative;top: -90px;left: 290px;"> -->
                    
                     <button class="reply" onclick="reply(${item.id})">回复</button>
      
                     <c:if test="${item.userId == cur_user.id}">
                     	<button class="delete" onclick="deleteReply(${item.id})">删除</button>
                     </c:if>
                     
                     <div style="display:block" id="inUserReply${item.id }">
                     <c:set var="temp" value="0"/>
                     <c:forEach items="${reply}" var="vreply" varStatus="replystatus">
                     
                     	
                     	<c:if test="${vreply.commentId == item.id}">
                     	<c:set var="temp" value="${temp+1 }"/>
                     		<c:if test="${temp<4}">
								<div id="UnderReply${vreply.id }">
	                     		<div style="width: 30px;height: 30px;border-radius: 40px;overflow: hidden;position: relative;right: 0px;top: -35px;">
					               	<c:if test="${empty vreply.user.imgUrl}">
					                    <img src="<%=basePath%>img/3.jpg"  style="width:100%">
					                 </c:if>
					                 <c:if test="${!empty vreply.user.imgUrl}">
					                    <img src="<%=basePath%>upload/${vreply.user.imgUrl}" style="width:100%">
					                 </c:if>
			                	</div>
			                	<span style="font-size: 13px;font-weight: bold;color: dimgray;position: relative;top: -68px;left:40px;margin-right: 20px;">${vreply.user.username}</span>
	                     		<span style="font-size: 16px;color: black;position: relative;top: -66px;left: 60px;">${vreply.content}</span>
	                     		
	                     		 
	                     		<div style="text-align:right;color:#4fbef6;position:relative;top:-60px;font-size: 13px;right: 405px;">${vreply.createAt}</div>
	                     		<c:if test="${vreply.userId == cur_user.id }">
	                     		
	                     	     	<button class="indelete" onclick='deleteInUserReply("${vreply.id}","${item.id}")' >删除</button>
	                     	     </c:if>
	                     	     </div>
                     	     </c:if>
                     	</c:if>
                     	
                     </c:forEach>
                     <c:if test="${item.replyNum > 3}">
                     <div style="position: relative;top: -70px;">
                     	<span>共<span style="font-weight: 800;font-size: 13px;">${ item.replyNum }</span>条回复</span>
                     	<span><a class="lookReply" onclick="showMoreReply(${item.id})">点击查看</a></span>
                     </div>
                     </c:if>
                     </div>
                     
                     <div style="display:none" id="detail${item.id }">
                     <c:forEach items="${reply}" var="vreply" varStatus="replystatus">
                     
                     	<c:if test="${vreply.commentId == item.id}">
                     		<div style="width: 30px;height: 30px;border-radius: 40px;overflow: hidden;position: relative;right: 0px;top: -35px;">
				               	<c:if test="${empty vreply.user.imgUrl}">
				                    <img src="<%=basePath%>img/3.jpg"  style="width:100%">
				                 </c:if>
				                 <c:if test="${!empty vreply.user.imgUrl}">
				                    <img src="<%=basePath%>upload/${vreply.user.imgUrl}" style="width:100%">
				                 </c:if>
		                	</div>
		                	<span style="font-size: 13px;font-weight: bold;color: dimgray;position: relative;top: -68px;left:40px;margin-right: 20px;">${vreply.user.username}</span>
                     		<span style="font-size: 16px;color: black;position: relative;top: -66px;left: 60px;">${vreply.content}</span>
                     		
                     		 
                     		<div style="text-align:right;color:#4fbef6;position:relative;top:-60px;font-size: 13px;right: 405px;">${vreply.createAt}</div>
                     		<c:if test="${vreply.userId == cur_user.id }">
                     	     	<button class="indelete" onclick='deleteInUserReply("${vreply.id}","${item.id}")' >删除</button>
                     	     </c:if>
                     	</c:if>
                     
                     </c:forEach>
                      
                     </div>
                     
                     
                  
                     
                     <div id="foldReply${item.id }" style="display:none;position: relative;top: -70px;">
           				  <span><a class="lookReply" onclick="showMoreReply(${item.id})">收起回复</a></span>
                     </div>
                     
                     <div id="reply${item.id }" class="publish" style="display:none;height: 120px;position: relative;top: -80px;left: 80px;margin-top: 15px;">
		                <div style="width: 60px;height: 60px;border-radius: 40px;overflow: hidden;position: relative;right: 100px;top: 45px;">
			               	<c:if test="${empty cur_user.imgUrl}">
			                    <img src="<%=basePath%>img/3.jpg"  style="width:100%">
			                 </c:if>
			                 <c:if test="${!empty cur_user.imgUrl}">
			                    <img src="<%=basePath%>upload/${cur_user.imgUrl}" style="width:100%">
			                 </c:if>
		                </div>
		                	
		                     <div class="pub_content">
		                        <div class="text_pub lead emoji-picker-container">
                          
				                      <div class="text_pub lead emoji-picker-container">
			                            <textarea id="mycontext${item.id }" name="context" class="OwO-textarea1" data-type="original-input" style="width: 510px;min-height: 75px;line-height: 25px;color: #333;font-size: 16px;border-radius: 4px;border: 1px solid #ccc;"></textarea>
			                           
			                        </div>
		                        </div>
		                    </div>
		                 	
		                    <div class="button">
								  <div class="checkbox" style="width:135px;">
		                            <button onclick="sendInUserContext(${item.id})" style="position: relative;height: 70px;width: 80px;top: -120px;right:-60px;border-radius: 5px;"><span>发表</span><br><span>评论</span></button>
		                        </div>
		                    </div> 
		                    
		                </div>
                     
                     <hr style="top: -70px;position: relative;"><br>
                     </div>
                     </c:forEach>
                     
                      <div id="page" style="center"></div>
                    <!--  <h1> 1 2 3 4 5 下一页 上一页</h1> -->
                    
                    </div>
                    <div style="text-align: right">
						<div class="pagination">
							<ul>
								<li><a>共:${noticeGrid.total}页</a></li>
								<li><a href="<%=basePath%>user/home?pageNum=1">首页</a></li>
								<li><a>第${noticeGrid.current }页</a></li>
								<c:if test="${noticeGrid.current ne 1 }">
									<li><a href="<%=basePath%>user/home?pageNum=${noticeGrid.current-1 }">上一页</a>
									</li>
								</c:if>
		
								<c:if test="${noticeGrid.current < noticeGrid.total }">
									<li><a href="<%=basePath%>user/home?pageNum=${noticeGrid.current+1 }">下一页</a>
									</li>
								</c:if>
								<li><a href="<%=basePath%>user/home?pageNum=${noticeGrid.total}">尾页</a></li>
							</ul>
						</div>
					</div>
                    </c:if>  
                </div>
            </div>
            <!--

                描述：最右侧，可能认识的人
            
            <div class="recommend">
                <div class="title">
                    <span class="text">可能认识的人</span>
                    <span class="change">换一组</span>
                    <span class="underline"></span>
                </div>
                <ul>
                <c:forEach items="${users}" var="item" varStatus="status">
                	<li>
                        <a href="#" class="head_img">
                            <img src="<%=basePath%>img/photo${status.index + 1}.jpg">
                        </a>
                        <span>${item.username}</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                  </c:forEach>
                    <%-- <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo1.jpg">
                        </a>
                        <span>Brudce</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo2.jpg">
                        </a>
                        <span>Graham</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo3.jpg">
                        </a>
                        <span>hly</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo4.jpg">
                        </a>
                        <span>Danger-XFH</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo5.jpg">
                        </a>
                        <span>Keithw</span>
                        <div class="fa fa-plus-square"></div>
                    </li> --%>
                </ul>
            </div>
            -->
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title middle" id="myModalLabel">查看用户信息</h4>
            </div>
            <div class="modal-body" style="height: 220px;">
	         <form id="myviewform">
	          <div class="form-group">
	            <label for="recipient-name" class="control-label col-sm-2" >名称:</label>
	            <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="username" readonly/>
	          </div>
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label col-sm-2">手机号:</label>
	            <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="phone" readonly/>
	          </div> 
	          </div>
	           <div class="form-group">
	            <label for="message-text" class="control-label col-sm-2">qq号:</label>
	            <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="qq" readonly/>
	          </div> 
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label col-sm-2">信用积分:</label>
	            <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="power" readonly/>
	          </div>
	           </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label col-sm-2">开户时间:</label>
	             <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="createAt" readonly/>
	          </div>
	           </div>
	        </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script>
var OwO_demo = new OwO({
    logo: 'OωO表情',
    container: $(".OwO")[0],
    target: $(".OwO-textarea")[0],
    api: '<%=basePath%>js/OwO.json',
    position: 'down',
    width: '100%',
    maxHeight: '250px'
});

	function reply(id){
		var height=$("#"+id).css("padding-bottom");
		var tHeight=height.substring(0,2);
		var nHeight=parseInt(tHeight);

        if($("#reply"+id).css("display")=='none'){
        	
    		nHeight+=10;
 
    		$("#"+id).css("padding-bottom",nHeight+"px");
            $("#reply"+id).css("display","block");
        }
        else{
        	nHeight-=10;
        	$("#"+id).css("padding-bottom",nHeight+"px");
            $("#reply"+id).css("display","none");
        }
        
	}
	
	function showMoreReply(id){

        if($("#detail"+id).css("display")=='none'){

        	$("#inUserReply"+id).css("display","none");
            $("#detail"+id).css("display","block");
            $("#foldReply"+id).css("display","block");
        }
        else{

        	$("#inUserReply"+id).css("display","block");
            $("#detail"+id).css("display","none");
            $("#foldReply"+id).css("display","none");
        }
	}
</script>
</body>
</html>