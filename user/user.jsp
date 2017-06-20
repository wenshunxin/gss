<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	Integer userLevel =(Integer)request.getSession().getAttribute("userLevel");
	String userCityCode =(String)request.getSession().getAttribute("cityCode");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@ include file="/header/header.jsp"%>
<%@ include file="/header/easyui.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
	src="<%=contextPath%>/city/js/chinaCity.js"></script>
</head>
<script>
var userLevel = '<%=userLevel%>';
var userCityCode = '<%=userCityCode%>';
function doInit(){
	getProvince();
	getRoleList();
	//setUserLevel();
	cityPrivSetting();
}
function saveUser(){
	if($("#form1").form("validate") && check()){
		var url = contextPath+"/userController/saveUser.act";
		var param=tools.formToJson($("#form1"));
		var province = $("#province").val();
		var city = $("#city").val();
		var county = $("#county").val();
		var cityCode="";
		if(county!=""){
			cityCode = county;
		}else if(city!=""){
			cityCode = city;
		}else if(province!=""){
			cityCode = province;
		}else{
			cityCode = "000000";
		}
		param["cityCode"] = cityCode;
		var json = tools.requestJsonRs(url,param);
		if(json.rtState){
			top.$.jBox.tip(json.rtMsg,"success");
			parent.datagrid.datagrid("reload");
			parent.$(".jbox-body").remove();
		}else{
			top.$.jBox.tip("系统异常！","error");
		}
	} 
}

function getRoleList(){
	var url = contextPath+"/roleController/getRoleDatagrid.act?rows=100&page=1";
	var json = tools.requestJsonRs(url);
	if(json.total>0){
		var html = "";
		for(var i=0;i<json.total;i++){
			var data = json.rows[i];
			html+="<option value='"+data.id+"'>"+data.name+"</option>";
		}
		$("#roleId").html(html);
	}
}

function check(){
	if($("#password").val()!=$("#rePassword").val()){
		$.jBox.tip("两次密码不匹配，请重新输入","error");
		$("#password").focus();
		$("#password").val("");
		$("#rePassword").val("");
		return false;
	}
/* 	var province = $("#province").val();
	var city = $("#city").val();
	var county = $("#county").val();
	if(province=="" && city=="" && county==""){
		$.jBox.tip("请选择省/市/县","error");
		return false;
	} */
	return true;
}

function setUserLevel(){
	var html="";
	if(userLevel=='0'){
		html="<option value='0'>部级</option><option value='1'>省级</option>";
	}else if(userLevel=='1'){
		html="<option value='2'>市级</option>";
	}else if(userLevel=='2'){
		html="<option value='3'>县级</option>";
	}else if(userLevel=='3'){
		html="";
	}else{
		html="";
	}
	$("#userLevel").html(html);
}
</script>
<body style="overflow-x: hidden; font-size: 12px; padding: 20px 0;"
	onload="doInit()">
	<form id="form1" name="form1" method="post"
		enctype="multipart/form-data">
		<table class='TableBlock' style='width: 90%; margin: 0 auto;'>
			<tr>
				<td class='TableData'>用户账号：</td>
				<td class='TableData'><input type='text' id='userId'
					name='userId' autocomplete="off"
					class='easyui-validatebox BigInput' required="true" /></td>
			</tr>
			<tr>
				<td class='TableData'>用户名：</td>
				<td class='TableData'><input type='text' id='userName'
					name='userName' autocomplete="off"
					class='easyui-validatebox BigInput' required="true" /></td>
			</tr>
			<tr>
				<td class='TableData'>用户级别：</td>
				<td class='TableData'>
					<select id="userLevel" name="userLevel"class="BigSelect">
						<option value='0'>部级</option>
						<option value='1'>省级</option>
						<option value='2'>市级</option>
						<option value='3'>县级</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class='TableData'>所属城市：</td>
				<td class='TableData'>省： <select name="province" id="province"
					onchange="getCity();" class="BigSelect">
						<option value="">请选择</option>
				</select> 市： <select name="city" id="city" onchange="getCounty();"
					class="BigSelect">
						<option value="">请选择</option>
				</select> 县： <select name="county" id="county" class="BigSelect">
						<option value="">请选择</option>
				</select>
				</td>
			</tr>
			<tr>
				<td class='TableData'>性别：</td>
				<td class='TableData'><select id='sex' name='sex'
					class='easyui-validatebox BigSelect' required="true">
						<option value='0'>男</option>
						<option value='1'>女</option>
				</select></td>
			</tr>
			<tr>
				<td class='TableData'>手机号：</td>
				<td class='TableData'><input type='text' id='userPhone'
					name='userPhone' autocomplete="off"
					class='easyui-validatebox BigInput' required="true"
					validType='mobile' /></td>
			</tr>
			<tr>
				<td class='TableData'>座机号：</td>
				<td class='TableData'><input type='text' id='userTelephone'
					name='userTelephone' autocomplete="off"
					class='easyui-validatebox BigInput' /></td>
			</tr>
			<tr>
				<td class='TableData'>公司名称：</td>
				<td class='TableData'><input type='text' id='companyName'
					name='companyName' autocomplete="off"
					class='easyui-validatebox BigInput' required="true" /></td>
			</tr>
			<tr>
				<td class='TableData'>用户邮箱：</td>
				<td class='TableData'><input type='text' id='userEmail'
					name='userEmail' autocomplete="off"
					class='easyui-validatebox BigInput' required="true"
					validType="email" /></td>
			</tr>
			<tr>
				<td class='TableData'>密码：</td>
				<td class='TableData' colspan='2'><span style='display: none;'><input
						type='password' /></span> <input type='password' id='password'
					name='password' class='easyui-validatebox BigInput' required="true" />
				</td>
			</tr>
			<tr>
				<td class='TableData'>确认密码：</td>
				<td class='TableData' colspan='2'><input type='password'
					id='rePassword' name='rePassword'
					class='easyui-validatebox BigInput' required="true" /></td>
			</tr>
			<tr>
				<td class='TableData'>所属角色：</td>
				<td class='TableData' colspan='2'><select id='roleId'
					name='roleId' class='easyui-validatebox BigSelect'>
				</select></td>
			</tr>

		</table>
	</form>
</body>
</html>