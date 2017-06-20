<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
	String name =(String)request.getSession().getAttribute("userName");

%>
<html>
<head>
<%@ include file="/header/header.jsp"%>
<title>审贷汇后台欢迎页</title>
<script>
function doInit(){
	messageMsg("<%=name%>:欢迎您登录审贷汇后台管理系统!","content","info",400);
}

</script>
</head>

<body onload="doInit()">

	<center>
	<div id="content" style="padding-top: 30px;"></div>
	</center>
</body>
</html>
