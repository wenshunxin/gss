<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@ include file="/header/header.jsp"%>
<%@ include file="/header/easyui.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=contextPath%>/resource/css/category.css" rel="stylesheet" />
<script src="<%=contextPath %>/category/category.js"></script>
<script>
function doInit(){
	getParentCategory();
}
</script>
</head>
<body onload="doInit();">
	<div id="containor">
		<div id="parent">
			<div class="ctrlArea">
				<input type="button" class='btn btn-success' value="添加主分类"
					onclick="addParentCategory();" />
			</div>
			<div id="parentList" class="listArea"></div>

		</div>
		<div id="child">
			<div id="childCtrl" class="ctrlArea"></div>
			<div id="childList" class="listArea">
				<span class='tips'>请选择左侧主分类</span>
			</div>
		</div>
	</div>
</body>
</html>