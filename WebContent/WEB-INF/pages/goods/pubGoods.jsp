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
    <title>发布商品</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <link rel="stylesheet" href="<%=basePath%>fonts/iconfont.css" />
   <!-- bootstrap -->
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> 
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <!-- 图片上传即使预览插件 -->
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

	            描述：发布物品
        -->
        <div id="user_content">
            <div class="basic" style="background-color: white;width: 1000px;height: 580px;">
                
                    
                    <div class="changeinfo">
                        <span class="infol">物品名：</span>
                        <input value="" id="goodsName" style="background-color: white;" class="in_info" type="text" name="name" placeholder="请输入物品名"/>
                        <span class="infor" style="color: #F56D6B;margin-left: 5px;">(*必填)</span>
                    </div>
                    <div class="changeinfo">
                        <span class="infol">出售价格：</span>
                        <input value="" id="goodsPrice" style="background-color: white;" class="in_info" type="text" name="price" placeholder="请输入出售价格"/>
                        <span class="infor" style="color: #F56D6B;margin-left: 5px;">(*必填)</span>
                    </div>
                    <div class="changeinfo">
                        <span class="infol">原价：</span>
                        <input id="realPrice" style="background-color: white;" class="in_info" type="text" name="realPrice" placeholder="请输入商品原价"/>
                        <span id="checkphone" style="color:#61c5f7">(*选填,请如实填写)</span>
                    </div>
                    <div class="changeinfo">
                        <span class="infol">物品类别：</span>
                        <select id="catelogId" style="background-color: white;" class="in_info" name="catelogId">
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
                                        <textarea id="describle" name="describle" class="emoji-wysiwyg-editor"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class="changeinfo" style="position: absolute;top: 120px;right: -960px;">
                        <span class="infol">商品封面：</span>
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-6 col-sm-offset-1">
                                    <div class="form-group">
                                        <div class="col-sm-10">
                                            <input type="file" name="myfile" data-ref="imgUrl" multiple class="col-sm-10 myfile" value=""/>
                                            <input id="goodsImg" type="hidden" name="imgUrl" value="">
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a onclick="pubGoods()" class="setting-save" style="margin-top: 20px;background-color: #61c5f7;position: relative;right: 280px;top: 40px;padding: 12px 22px 12px 22px;">发布物品</a>
            
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
<script>
	function pubGoods(){
		
		
		if($("#goodsImg").val()==""){
			swal({
				 title: "请选择商品封面！",
				  type: "warning",
				  confirmButtonText: "OK",
				  closeOnConfirm: true
				  });		
		}
		if($("#goodsPrice").val()==""){
			swal({
				 title: "请输入商品出售价格！",
				  type: "warning",
				  confirmButtonText: "OK",
				  closeOnConfirm: true
				  });		
		}
		if($("#goodsName").val()==""){
			swal({
				 title: "请输入商品名！",
				  type: "warning",
				  confirmButtonText: "OK",
				  closeOnConfirm: true
				  });		
		}
		if($("#goodsName").val()!="" && $("#goodsPrice").val()!="" && $("#goodsImg").val()!="")
			{
			var goodsName=$("#goodsName").val();
			var goodsPrice=$("#goodsPrice").val();
			var realPrice=$("#realPrice").val();
			var catelogId=$("#catelogId option:selected").val();
			var describle=$("#describle").val();
			var goodsImg=$("#goodsImg").val();
			$.ajax({
				url:'<%=basePath%>goods/publishGoodsSubmit',
				type:'POST',
				data:{goodsName:goodsName,goodsPrice:goodsPrice,realPrice:realPrice,catelogId:catelogId,describle:describle,goodsImg:goodsImg},
				dataType:'json',
				success:function(json){
					if(json.success){
						swal({
							 title: "商品发布成功！",
							 text:"注意：该商品将在一个月后自动下架",
							  type: "success",
							  confirmButtonText: "OK",
							  closeOnConfirm: true
							  },
							  function(isConfirm){
								  if (isConfirm) {
									  window.location.href='<%=basePath%>/user/allGoods';
								  }
							  
							});
					}
					else{
						swal({
							 title: "商品发布失败！",
							  type: "warning",
							  confirmButtonText: "OK",
							  closeOnConfirm: true
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
					$('#viewModal').modal('hide');
				}
	   });
			
		
		}	
	}

</script>
<script>
	var imageData = new Array();//多图上传返回的图片属性接受数组
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
        var temp="imgUrl1"
        imageData.push(
            res.imgUrl
        );
        $("input[name='"+ref+"']").val(imageData[0]);
        //console.log(imageData);
        $("input[name='"+temp+"']").val(imageData[1]);
        console.log(imageData[1]);
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