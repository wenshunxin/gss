<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/header/header.jsp"%>
<title>耕地质量监测信息管理平台</title>
<link href="<%=contextPath %>/resource/css/login.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript">

// function delCookie(name) { //删除cookie
// 	 setCookie(name, "", -1);
// }
// /**
//  * 设置cookie
//  * @param name  名称
//  * @param value 值
//  * @param Days  时间
//  */
// function setCookie(name, value, Days) {
// 	var exp = new Date();
// 	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);//天数
// 	document.cookie = name + "=" + escape(value) + ";path=/;expires="
// 			+ exp.toGMTString();
// }
// function login(){
// 	var userId=$("#userId").val();
// 	var password=$("#password").val();
// 	var url =contextPath+"/userController/doLogin.act";
// 	var json = tools.requestJsonRs(url,"userId="+userId+"&password="+password);
// 	if(json.rtState){
// 		if ($('#checkboxid').is(':checked') == true) {
// 		    setCookie('userId',userId, 15);
// 		    setCookie("password", password, 15);
// 		}else {
// 		    var name=getCookie("userId");
//             var password=getCookie("password");
//             if(name!=null||password!=null){
//             	delCookie("userId");
//             	delCookie("password");
//             }
// 	    }
// 		window.location="<%=contextPath %>/frame/index.jsp";
// 	}else{
// 		$("#tips").html("用户名密码错误！");
// 		$("#password").val();
// 		$("#password").focus();
//
// 	}
// }
// $(function() {
// 	var userName=getCookie("userId");
//     var password=getCookie("password");
//     if (userName!=null && password!=null) {
// 		$("#userId").val(userName);
// 		$("#password").val(password);
//     }
// });
function loginss() {
	var userId=$("#userId").val(),
	password=$("#password").val();
	$.ajax({
		url:contextPath+"/userController/doLogin.act",
		data:{
			userId:userId,
			password:password
		},
		type: "post",
		success: function (data) {
			if(data.rtState){
				window.location="<%=contextPath %>/frame/index.jsp";
			}else{
				alert(data.rtMsg);
			}
		}
	})
}

		function keylogin(event) {

			if(event.keyCode == 13 || event.which == 13){
				loginss();
			}
		}


</script>
</head>
<body onkeydown="keylogin(event)">

	<div class="" style="width: 100%;height: 100%;position: relative;padding-top:110px;box-sizing: border-box;">
		<%-- <h1 style="text-align: center;color: #fff;font-size: 70px;">黑&nbsp;土&nbsp;地&nbsp;耕&nbsp;地&nbsp;质&nbsp;量&nbsp;监&nbsp;测&nbsp;平&nbsp;台</h1> --%>
		<div class="" style="width: 782px;height: 60px;background: url(headName.png) no-repeat;margin: 50px auto 0;">

		</div>
		<div class="" style="width: 50%;margin:0 auto;position: relative;">
			<img src="login.png" alt="" style="display: block;width: 100%;">
			<div class="" style="position: absolute;left: 50%;width: 40%;top: 20%;">
				<h3 style="margin-bottom: 30px;"><strong>登录</strong></h3>
				<input type="text" name="" value="" style="width: 100%;height: 30px;line-height: 30px;margin-bottom: 30px;text-indent: 18px;border: 0;border-bottom: 2px solid #efefef;font-size: 16px;" placeholder="请输入用户名" id="userId">
				<input type="password" name="" value="" style="width: 100%;height: 30px;line-height: 30px;margin-bottom: 30px;text-indent: 18px;border: 0;border-bottom: 2px solid #efefef;font-size: 16px;" placeholder="请输入密码" id="password">
				<div class="" style="text-align: center;">
					<input type="button" value="登录" style="width: 50%;height: 35px;line-height: 35px;border-radius: 15px;background: #66A3FE;border: 0;color: #fff;font-size: 18px;" onclick="loginss()">
				</div>
			</div>
		</div>
	</div>
</body>
</html>
