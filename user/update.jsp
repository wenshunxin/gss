<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
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
var id = '<%=id%>';
var phone="";
function doInit(){
	getProvince();
	getRoleList();
	getUserById();
}
function saveUser(){
	if($("#form1").form("validate") && check()){
		var url = contextPath+"/userController/updateUser.act";
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

function getUserById(){
	if(id!="null" && id!=null){
		var url = contextPath+"/userController/getUserById.act?id="+id;
		var json = tools.requestJsonRs(url);
		if(json.rtState){
			bindJsonObj2Cntrl(json.rtData);
			var jsonObj = getCityFullInfo(json.rtData.cityCode);
			if(jsonObj){
				$("#province").val(jsonObj.provinceCode);
				if(jsonObj.provinceCode){
					getCity();
					$("#city").val(jsonObj.cityCode);
				}
				if(jsonObj.cityCode){
					getCounty();
					$("#county").val(jsonObj.countyCode);
				}
			}
		}
	}
}
function check(){
	var province = $("#province").val();
	var city = $("#city").val();
	var county = $("#county").val();
/* 	if(province=="" && city=="" && county==""){
		$.jBox.tip("请选择省/市/县","error");
		return false;
	} */
	return true;
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
				<td class='TableData'><select id="userLevel" name="userLevel"
					class="BigSelect">
						<option value="0">部级</option>
						<option value="1">省级</option>
						<option value="2">市级</option>
						<option value="3">县级</option>
				</select></td>
			</tr>
			<tr>
				<td class='TableData'>所属城市：</td>
				<td class='TableData'>省： <select name="province" id="province"
					onchange="getCity();" class="BigSelect easyui-validatebox">
						<option value="">请选择</option>
				</select> 市： <select name="city" id="city" onchange="getCounty();"
					class="BigSelect easyui-validatebox">
						<option value="">请选择</option>
				</select> 县： <select name="county" id="county"
					class="BigSelect easyui-validatebox">
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
				<td class='TableData'>所属角色：</td>
				<td class='TableData' colspan='2'><select id='roleId'
					name='roleId' class='easyui-validatebox BigSelect'>

				</select></td>
			</tr>

		</table>
		<input type='hidden' id='sid' name='sid' value='<%=id %>' />
	</form>
</body>
</html>