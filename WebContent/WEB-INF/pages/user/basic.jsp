<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String imgurl=application.getAttribute("imgurl")+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人设置</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <link rel="stylesheet" href="<%=basePath%>fonts/iconfont.css" />
     <!-- bootstrap -->
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/iscroll-zoom.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/hammer.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/lrz.all.bundle.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.photoClip.min.js"></script>
	
	<link rel="stylesheet" href="<%=basePath%>css/fileinput.min.css">
    <script type="text/javascript" src="<%=basePath%>js/fileinput.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/zh.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/sweetalert.min.css" rel="stylesheet">
	<script type="text/javascript" src="<%=basePath%>js/sweetalert.min.js"></script>
	
<style>
	a.setting-save:hover{
		border:none;
		text-decoration:none;
		color:white;
	}
</style>
</head>
<body style="background-color: #f6f8fa">
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
              <!--   <span class="school">清华大学</span> -->
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
        <div id="user_content" style="position: relative;top: 70px;background-color: white;">
            <div class="basic" style="top: -60px;position: relative;">
                <form:form id="userInfo" action="../user/updateInfo" method="post" enctype="multipart/form-data" commandName="user" role="form">
                    
                    <!--  <input type="hidden" name="lastLogin" value="${sessionScope.cur_user }">-->
                    <div class="changeinfo" style="margin-bottom: 350px;position: relative;">
                    	<span class="infol">头像：</span>
                    	<div class="userImage" style="position: relative;margin-top: 10px;top: 30px;width: 400px;left: 100px;">
                        	<input type="file" name="myfile" data-ref="imgUrl" class="col-sm-10 myfile" value=""/>
                        	<input id="userImg" type="hidden" name="imgUrl" value="${cur_user.imgUrl}">
                        	
                    	</div>
                    <!--
                        <span class="infol">头像：</span>
                        <input type="file" name="myfile" data-ref="imgUrl" class="col-sm-10 myfile" value=""/>
                        <input type="hidden" name="imgUrl" value="">
                          
                        <p class="upload_view" id="view"></p>
                        <button class="open" type="button" onsubmit="return false">上传图片</button>
						<div id="upload_D">
							<div class="upload_frame">
								<div class="upload_title">
									<span class="upload_title_left">请选择图片</span>
									<span class="upload_title_right"><img src="<%=basePath%>img/x.jpg"></span>
								</div>
								<div class="upload_fileBtn">
									图片上传
									<input type="file" id="file"/>
									<label for="file">选择图片</label>
								</div>
								<div class="upload_content">
									<div id="clipArea"></div>
									<div class="upload_content_right">
										<p class="upload_view"></p>
										<button id="clipBtn" type="button" onsubmit="return false">保存修改</button>
										<label for="file">重新选图片</label>
									</div>
								</div>
							</div>
						</div>-->
                    </div>
                    <div style="position: absolute;top: 10px;left: 550px;">
                    <div class="changeinfo">
                        <span class="infol">昵称：</span>
                        <input style="background-color: white;position: absolute;" class="in_info" type="text" name="username" placeholder="请输入昵称" value="${cur_user.username}"/>
                    </div>
                    <div class="changeinfo">
                        <span class="infol">开通时间：</span>
                        <input style="position: absolute;" class="in_info" type="text" name="createAt" value="${cur_user.createAt}" readonly="true"/>
                    </div>
                    <div class="changeinfo">
                        <span class="infol">手机号码：</span>
                        <input style="position: absolute;" class="in_info" type="text" name="phone" value="${cur_user.phone}" readonly="true"/>
                        <span id="checkphone" style="color:#61c5f7;position: absolute;right: -280px;top: 220px;">已验证</span>
                    </div>
                    <div class="changeinfo">
                        <span class="infol">QQ：</span>
                        <input style="background-color: white;position: absolute;" class="in_info" type="text" name="qq" placeholder="请输入QQ" value="${cur_user.qq}"/>
                    </div>
                    </div>
                    <!-- 
                    <div class="changeinfo">
                        <span class="infol">lastLogin：</span>
                        <input style="background-color: white;" class="in_info" type="text" name="lastLogin" placeholder="请输入" value="${cur_user.lastLogin}"/>
                    </div>
                     -->
                    <a onclick="saveInfo()" class="setting-save" style="background-color:#61c5f7;color:white;position: relative;left: 260px;top: 30px;padding: 12px 22px 12px 22px;">保存修改</a>
                </form:form>
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
                    <li>
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
                        <span>策马奔腾hly</span>
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
                    </li>
                </ul>
            </div>
             -->
        </div>
    </div>
</div>
<!--  <script>
	$(function(){
		//document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
		var clipArea = new bjj.PhotoClip("#clipArea", {
			size: [300, 300],// 截取框的宽和高组成的数组。默认值为[260,260]
			outputSize: [300, 300], // 输出图像的宽和高组成的数组。默认值为[0,0]，表示输出图像原始大小
			//outputType: "jpg", // 指定输出图片的类型，可选 "jpg" 和 "png" 两种种类型，默认为 "jpg"
			file: "#file", // 上传图片的<input type="file">控件的选择器或者DOM对象
			view: ".upload_view", // 显示截取后图像的容器的选择器或者DOM对象
			ok: "#clipBtn", // 确认截图按钮的选择器或者DOM对象
			loadStart: function() {
				// 开始加载的回调函数。this指向 fileReader 对象，并将正在加载的 file 对象作为参数传入
				$('.cover-wrap').fadeIn();
				console.log("照片读取中");
			},
			loadComplete: function() {
				 // 加载完成的回调函数。this指向图片对象，并将图片地址作为参数传入
				console.log("照片读取完成");
			},
			//loadError: function(event) {}, // 加载失败的回调函数。this指向 fileReader 对象，并将错误事件的 event 对象作为参数传入
			clipFinish: function(dataURL) {
				 // 裁剪完成的回调函数。this指向图片对象，会将裁剪出的图像数据DataURL作为参数传入
				console.log(dataURL);
			}
		});
		
		$(".upload_title_right").click(function(){
			$("#upload_D").fadeOut();
		});
		
		$(".open").click(function(){
			$("#upload_D").fadeIn();
		});
	})
		
</script>-->
<script>
	function saveInfo(){
		
		swal({
			 title: "修改成功！",
			  type: "success",
			  confirmButtonText: "OK",
			  closeOnConfirm: true
			  },
			  function(isConfirm){
				  if (isConfirm) {
					  //if($("#userImg").val()==""){
						  //$("#userImg").val(img);
					  //}
					  $("#userInfo").submit();
				  }
			  
			});
	}

</script>
<script>
    $(".myfile").fileinput({
        uploadUrl:"<%=basePath%>goods/uploadFile",//上传的地址
        uploadAsync:true, //默认异步上传
        showUpload: false, //是否显示上传按钮,跟随文本框的那个
        showRemove : false, //显示移除按钮,跟随文本框的那个
        showCaption: true,//是否显示标题,就是那个文本框
        showPreview : true, //是否显示预览,不写默认为true
        dropZoneEnabled: true,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
        //minImageWidth: 50, //图片的最小宽度
        //minImageHeight: 50,//图片的最小高度
        //maxImageWidth: 1000,//图片的最大宽度
        //maxImageHeight: 1000,//图片的最大高度
        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
        //minFileCount: 0,
        maxFileCount: 1, //表示允许同时上传的最大文件个数
        enctype: 'multipart/form-data',
        validateInitialCount:true,
        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
        msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        allowedFileTypes: ['image'],//配置允许文件上传的类型
        allowedPreviewTypes : [ 'image' ],//配置所有的被预览文件类型
        allowedPreviewMimeTypes : [ 'jpg', 'png', 'gif' ],//控制被预览的所有mime类型
        language : 'zh'
    })
    //异步上传返回结果处理
    $('.myfile').on('fileerror', function(event, data, msg) {
        console.log("fileerror");
        console.log(data);
    });
    //异步上传返回结果处理
    $(".myfile").on("fileuploaded", function (event, data, previewId, index) {
        console.log("fileuploaded");
        var ref=$(this).attr("data-ref");
        $("input[name='"+ref+"']").val(data.response.imgUrl);
        var url="http://125.216.250.129:8080/squirrel/upload/"+data.response.imgUrl;
        //localStorage.setItem("imgurl",url); 
        //var urlname = localStorage["imgurl"] 
        //$("#pic").attr('src',urlname);
        
    });

    //同步上传错误处理
    $('.myfile').on('filebatchuploaderror', function(event, data, msg) {
        console.log("filebatchuploaderror");
        console.log(data);
    });

    //同步上传返回结果处理
    $(".myfile").on("filebatchuploadsuccess", function (event, data, previewId, index) {
        console.log("filebatchuploadsuccess");
        console.log(data);
    });

    //上传前
    $('.myfile1').on('filepreupload', function(event, data, previewId, index) {
        console.log("filepreupload");
    });
</script>
<!-- 
<script>
$(function(){
	var urlname = localStorage["imgurl"] 
    $("#pic").attr('src',urlname);
})
</script>
 -->
</body>
</html>