/**
 * 用于登录和注册时验证账户以及发送表单
 */

function showLogin() {
        if($("#signup-show").css("display")=='block'){
            $("#signup-show").css("display","none");
        }
        if($("#login-show").css("display")=='none'){
            $("#login-show").css("display","block");
        }else{
            $("#login-show").css("display","none");
        }
    }
function showSignup() {
    if($("#login-show").css("display")=='block'){
        $("#login-show").css("display","none");
    }
    if($("#signup-show").css("display")=='none'){
        $("#signup-show").css("display","block");
    }else{
        $("#signup-show").css("display","none");
    }
}
function ChangeName() {
    if($("#changeName").css("display")=='none'){
        $("#changeName").css("display","block");
    }else{
        $("#changeName").css("display","none");
    }
}

function getRealPath(){
    var localObj = window.location;
	  var contextPath = localObj.pathname.split("/")[1];
	  var basePath = localObj.protocol + "//" + localObj.host + "/"+ contextPath;
     return basePath ;
 }
$(document).ready(function(){
            //异步验证

	var basePath=getRealPath();
	
            $("#registerPhone").bind('input propertychange',function(){
              var phone=$(this).val();
              $.ajax({
    				url:basePath+'/user/registerPhone',
    				type:'POST',
    				data:{phone:phone},
    				dataType:'json',
    				success:function(json){
    					if(!json.success||!json.flag){
    						 $("#errorPhone").html(json.msg);
    						 $("#register").attr("disabled",true);
    					}else{
    						 $("#errorPhone").empty();
    						 $("#register").attr("disabled",false);
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
               
            });
            
            $("#registerPassword").bind('input propertychange',function(){
            	var password=$(this).val();
            	$.ajax({
    				url:basePath+'/user/registerPassword',
    				type:'POST',
    				data:{password:password},
    				dataType:'json',
    				success:function(json){
    					if(!json.success){
    						 $("#errorPassword").text("必须包含一个大写，一个小写字母，且长度为8~16");
    						 $("#register").attr("disabled",true);
    					}else{
    						 $("#errorPassword").empty();
    						 $("#register").attr("disabled",false);
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
               
            });
        
            $("#registerQq").bind('input propertychange',function(){
            	var qq=$(this).val();
            	$.ajax({
    				url:basePath+'/user/registerQq',
    				type:'POST',
    				data:{qq:qq},
    				dataType:'json',
    				success:function(json){
    					if(!json.success){
    						 $("#errorQq").text("您输入的邮箱格式不正确");
    						 $("#register").attr("disabled",true);
    					}else{
    						 $("#errorQq").empty();
    						 $("#register").attr("disabled",false);
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
               
            });
        });




function loginIn(){
	
	var basePath=getRealPath();
	var phone=$("#login_phone").val();
    var password=$("#login_password").val();
    if(!phone){
    	swal({
    		title:"Warning!",
    		text:"请输入手机号！",
    		type:"warning",
    		confirmButtonText:"OK"
    	})
    }
    else if(!password){
    	swal({
    		title:"Warning!",
    		text:"请输入密码！",
    		type:"warning",
    		confirmButtonText:"OK"
    	})
    }
    else{
    $.ajax({
			url:basePath+'/user/password',
			type:'POST',
			data:{phone:phone,password:password},
			dataType:'json',
			success:function(json){
			if(json.success==false||json.flag==true){
				//alert("账号或密码有误！");
				swal({
					  title: "Error!",
					  text: "账号或密码有误！",
					  type: "error",
					  confirmButtonText: "OK"
					});
				//if(json.flag){
					// $("#errorPassword").html("请核对账号密码，再重新输入!");
					 //$("#loginIn").attr("disabled",true);
				//}else{
					// $("#errorPassword").empty();
					 //$("#loginIn").attr("disabled",false);
				//}
			}
			else{
				//alert("登录成功！");
				swal({
					  title: "Success!",
					  text: "登录成功！",
					  type: "success",
					  confirmButtonText: "OK",
					  closeOnConfirm:"false"
				},
				  function(isConfirm){
				  if (isConfirm) {
					  window.location.href=basePath+"/goods/homeGoods";
				  } 
				});
				
			//	if(json.flag){
			//	 $("#errorPassword").html("请输入的密码有误!");
				// $("#loginIn").attr("disabled",true);
	//		}if(json.flag==false){
		//		 $("#login_errorPhone").html("您输入的在账号有误!");
			//	 $("#loginIn").attr("disabled",true);
			//}
			}
			},
			error:function(json){
				swal({
					  title: "Error!",
					  text: "系统出错啦！",
					  type: "error",
					  confirmButtonText: "OK"
					});
			}
		});
    }
     
  } 

function keydown(){
	if (event.keyCode==13){  
	      loginIn(); //调用登录按钮的登录事件 
	    } 
}

function register(){
	
	var basePath=getRealPath();
	
	var username=$("#registerName").val();
	var phone=$("#registerPhone").val();
    var password=$("#registerPassword").val();
    var qq=$("#registerQq").val();
    if(!username){
    	swal({
    		title:"Warning!",
    		text:"请输入昵称！",
    		type:"warning",
    		confirmButtonText:"OK"
    	})
    }
    
    else if(!phone){
    	swal({
    		title:"Warning!",
    		text:"请输入手机号！",
    		type:"warning",
    		confirmButtonText:"OK"
    	})
    }
    else if(!qq){
    	swal({
    		title:"Warning!",
    		text:"请输入邮箱！",
    		type:"warning",
    		confirmButtonText:"OK"
    	})
    }
    else if(!password){
    	swal({
    		title:"Warning!",
    		text:"请输入密码！",
    		type:"warning",
    		confirmButtonText:"OK"
    	})
    }
    else{
    	//alert(qq);
    $.ajax({
			url:basePath+'/user/addUser',
			type:'POST',
			data:{username:username,phone:phone,qq:qq,password:password},
			dataType:'json',
			success:function(json){
			if(json.success==false){
				//alert("账号或密码有误！");
				swal({
					  title: "Error!",
					  text: json.msg,
					  type: "error",
					  confirmButtonText: "OK"
					});
				//if(json.flag){
					// $("#errorPassword").html("请核对账号密码，再重新输入!");
					 //$("#loginIn").attr("disabled",true);
				//}else{
					// $("#errorPassword").empty();
					 //$("#loginIn").attr("disabled",false);
				//}
			}
			else{
				//alert("登录成功！");
				swal({
					  title: "Success!",
					  text: "注册成功，请稍后手动登录",
					  type: "success",
					  confirmButtonText: "OK",
					  closeOnConfirm:"false"
				},
				  function(isConfirm){
				  if (isConfirm) {
					  window.location.href=basePath+"/goods/homeGoods";
				  } 
				});
				
			//	if(json.flag){
			//	 $("#errorPassword").html("请输入的密码有误!");
				// $("#loginIn").attr("disabled",true);
	//		}if(json.flag==false){
		//		 $("#login_errorPhone").html("您输入的在账号有误!");
			//	 $("#loginIn").attr("disabled",true);
			//}
			}
			},
			error:function(json){
				swal({
					  title: "Error!",
					  text: "系统出错啦！",
					  type: "error",
					  confirmButtonText: "OK"
					});
			}
		});
    }
  } 