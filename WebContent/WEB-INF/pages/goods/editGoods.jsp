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
    <title>修改商品</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
	<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <link rel="stylesheet" href="<%=basePath%>fonts/iconfont.css" />
    
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	
	<link rel="stylesheet" href="<%=basePath%>css/fileinput.min.css">
    <script type="text/javascript" src="<%=basePath%>js/fileinput.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/zh.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/sweetalert.min.css" rel="stylesheet">
	<script type="text/javascript" src="<%=basePath%>js/sweetalert.min.js"></script>
    <style>
        .container{padding-top:10px}
    </style>
</head>
<style>
	a.setting-save:hover{
		border:none;
		text-decoration:none;
		color:white;
	}
</style>
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
	                    <img id="pic" src="<%=basePath%>img/3.jpg">
	                </c:if>
	                <c:if test="${!empty cur_user.imgUrl}">
	                    <img id="pic" src="<%=basePath%>upload/${cur_user.imgUrl}">
	                </c:if>
                </div>
                <div class="big_headimg">
                    <img src="">
                </div>
                <span class="name">${cur_user.username}</span><hr>
              <!--   <span class="school">莆田学院</span> -->
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

	            描述：发布物品
        -->
        <div id="user_content">
        		<div style="width: 1px;height: 580px;position: absolute;background-color: #5EADED;right: 515px;top: 120px;">
                </div>
            <div class="basic" style="background-color: white;width: 1000px;height: 580px;">
                <form:form id="goodsInfo" action="../../goods/editGoodsSubmit" method="post" role="form" enctype="multipart/form-data">
                    
                    <div class="changeinfo">
                        <span class="infol">物品名：</span>
                        <input id="goodsName" style="background-color: white;" class="in_info" type="text" name="name" placeholder="请输入物品名" value="${goodsExtend.goods.name}"/>
                        
                    </div>
                    <div class="changeinfo">
                        <span class="infol">出售价格：</span>
                        <input id="goodsPrice" style="background-color: white;" class="in_info" type="text" name="price" placeholder="请输入出售价格" value="${goodsExtend.goods.price}"/>
                       
                   </div>
                   <div class="changeinfo">
                        <span class="infol">原价：</span>
                        <input style="background-color: white;" class="in_info" type="text" name="realPrice" placeholder="请输入商品原价" value="${goodsExtend.goods.realPrice}"/>
                        
                     </div>
                     <div class="changeinfo">
                        <span class="infol">物品类别：</span>
                        <select id="selectCatelogId" style="background-color: white;" class="in_info" name="catelogId">
                            <option value="1">闲置数码</option>
                            <option value="2">校园代步</option>
                            <option value="3">电器日用</option>
                            <option value="4">图书教材</option>
                            <option value="5">美妆衣物</option>
                            <option value="6">运动棋牌</option>
                            <option value="7">票券小物</option>
                        </select>
                    </div>
                    <div class="changeinfo" id="dir">
                        <span class="infol">商品描述：</span>
                        <div class="sha">
                            <div class="publ">
                                <div class="pub_con">
                                    <div class="text_pu">
                                        <textarea name="describle" class="emoji-wysiwyg-editor" >${goodsExtend.goods.describle}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input id="catelogId" type="hidden" value="${goodsExtend.goods.catelogId}">
                    <input type="hidden" name="imgUrl" value="${goodsExtend.images[0].imgUrl}">
                    <input type="hidden" name="id" value="${goodsExtend.goods.id}">
                    <input type="hidden" name="startTime" value="${goodsExtend.goods.startTime}">
                    <input type="hidden" name="endTime" value="${goodsExtend.goods.endTime}">
                    <!--  
                    <div class="changeinfo" style="position: relative;top: -500px;left: 500px;">
                        <span class="infol">商品图片：</span>
                        
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-4 col-sm-offset-1">
                                    <div class="form-group">
                                        <div class="col-sm-10">
                                        	
                                            <img src="<%=basePath%>upload/${goodsExtend.images[0].imgUrl}" style="width:100%;max-height: 150px;"/>
                                            <input type="hidden" name="imgUrl" value="${goodsExtend.images[0].imgUrl}">
                                            <input type="hidden" name="id" value="${goodsExtend.goods.id}">
                                            <input type="hidden" name="startTime" value="${goodsExtend.goods.startTime}">
                                            <input type="hidden" name="endTime" value="${goodsExtend.goods.endTime}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>-->
                    <a class="setting-save" onclick="changeInfo()" style="margin-top: 20px;background-color: #06B6F6;position:relative;top:40px;right:530px;padding: 12px 22px 12px 22px;">提交修改</a>
                </form:form>
                
                <div>
                </div>
                <div style="position: relative;top: -620px;left: 500px;">
                	<div class="changeinfo">
                		<span class="infol" style="width: 150px;position: relative;left: 185px;top:100px">添加商品详情图片</span>
                		<p style="position: absolute;top: 130px;/*! right: 500px; */left: 215px;color: #5EADED;">(支持单张图片上传)</p>
                		<div class="container" style="margin-top: 180px;">
                            <div class="row">
                                <div class="col-sm-6 col-sm-offset-1">
                                    <div class="form-group">
                                        <div class="col-sm-10">
                                            <input type="file" name="myfile" data-ref="imgUrl" multiple class="col-sm-10 myfile" value=""/>
                                            <input id="goodsImgc" type="hidden" name="imgUrl" value="">
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <a class="setting-save" onclick="addImg()" style="background-color: #06B6F6;position: relative;top: 600px;left:-70px;padding: 12px 22px 12px 22px;">添加图片</a>
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
                    </li>
                </ul>
            </div>
            -->
        </div>
    </div>
</div>
<script>
$(document).ready(function(){  
    var key=$("#catelogId").val();
    //根据值让option选中 
    $("#selectCatelogId option[value='"+key+"']").attr("selected","selected"); 
});
	function addImg(){
		if($("#goodsImgc").val()==""){
			swal({
				 title: "请选择要添加的图片！",
				  type: "warning",
				  confirmButtonText: "OK",
				  closeOnConfirm:"true"
				});
		}
		else{
			var imgUrl=$("#goodsImgc").val();
			$.ajax({
				url:'<%=basePath%>goods/editGoodsImgSubmit',
				type:'POST',
				data:{imgUrl:imgUrl},
				dataType:'json',
				success:function(json){
					if(json.success){
						swal({
							
							 title: "图片添加成功！",
							  type: "success",
							  confirmButtonText: "OK",
							  closeOnConfirm:"true"
							  },
							  function(isConfirm){
								  if (isConfirm) {
									  location.reload();
								  }
							  
							});
					}
					else{
						swal({
							
							 title: "图片添加失败！",
							  type: "error",
							  confirmButtonText: "OK",
							  closeOnConfirm:"true"			  
							});
					}
				}
			});
			
			
			
		}
	}
	
	function changeInfo(){
		if(!$("#goodsName").val()){
			swal({
				 title: "请输入商品名！",
				  type: "warning",
				  confirmButtonText: "OK",
				  closeOnConfirm:"true"
				});
		}
		else if(!$("#goodsPrice").val()){
			swal({
				 title: "请输入商品的出售价格！",
				  type: "warning",
				  confirmButtonText: "OK",
				  closeOnConfirm:"true"
				});
		}
		else{
			swal({
				 title: "商品信息修改成功！",
				  type: "success",
				  confirmButtonText: "OK",
				  closeOnConfirm:"true"
				  },
				  function(isConfirm){
					  if (isConfirm) {
						  $("#goodsInfo").submit();
					  }
				  
				});
		}
	}
</script>
<script>
	//var imageData = new Array();//多图上传返回的图片属性接受数组
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
        maxFileCount: 3, //表示允许同时上传的最大文件个数
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
        var res = data.response;
        $("input[name='"+ref+"']").val(res.imgUrl);
        //console.log(imageData);
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
    $('.myfile').on('filepreupload', function(event, data, previewId, index) {
        console.log("filepreupload");
    });
</script>
</body>
</html>