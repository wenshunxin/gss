<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int userId = (Integer)request.getSession().getAttribute("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@ include file="/header/header.jsp"%>
<%@ include file="/header/easyui.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="<%=contextPath %>/user/user.js"></script>
<script>
var datagrid;

function doInit(){
	var url = contextPath+"/userController/getUserDatagrid.act";
	datagrid = $('#datagrid').datagrid({
		url:url,
		pagination:true,
		singleSelect:false,
		toolbar:'#toolbar',//工具条对象
		checkbox:true,
		border:false,
		idField:'sid',//主键列
		fitColumns:true,//列是否进行自动宽度适应
		columns:[[
			{field:'sid',checkbox:true,title:'ID',width:10},
			{field:'userId',title:'用户账号',width:200},
			{field:'userName',title:'用户姓名',width:200},
			{field:'sex',title:'性别',width:50,align:'center',formatter:function(e,rowData,index){
				if(rowData.sex==0){
					return "男";
				}else if(rowData.sex==1){
					return "女";
				}
			}},
			{field:'userPhone',title:'手机号',width:200},
			{field:'companyName',title:'公司名称',width:200},
			{field:'userLevel',title:'用户级别',width:200,formatter:function(e,rowData,index){
				if(rowData.userLevel==0){
					return "部级";
				}else if(rowData.userLevel==1){
					return "省级";
				}else if(rowData.userLevel==2){
					return "市级";
				}else if(rowData.userLevel==3){
					return "县级";
				}
			}},
			{field:'cityCode',title:'行政代码',width:200},
			{field:'cityFullName',title:'城市名称',width:200},
			{field:'roleName',title:'所属角色',width:200},
			{field:'1',title:'操作',width:300,formatter:function(e,rowData,index){
				return "<a href='javascript:void(0);' onclick='eidtUser("+rowData.sid+")'>修改</a>&nbsp;&nbsp;&nbsp;&nbsp;<a <a href='javascript:void(0);' onclick='deleteUser("+rowData.sid+")'>删除</a>";
			}}
		]]
	});
}

function addUser(){
	$.jBox("iframe:user.jsp", {
		title:"添加用户",
		top:0,
	    width: 650,
	    height: 450,
	    buttons:{"确定":1,'关闭': 2},
	    submit: function (v, h, f) {
            if (v == 1) {
            	saveUser();
            	return false;
            }
            else if(v==2){
            	return true;
            }
        }

	  });
}
function eidtUser(id){
	$.jBox("iframe:update.jsp?id="+id, {
		title:"修改用户",
		top:0,
	    width: 650,
	    height: 400,
	    buttons:{"确定":1,'关闭': 2},
	    submit: function (v, h, f) {
            if (v == 1) {
            	saveUser();
            	return false;
            }
            else if(v==2){
            	return true;
            }
        }

	  });
}
function deleteUser(id){
	$.jBox.confirm("确定删除该用户信息吗","确认",function(v){
		if(v=="ok"){
			var url = contextPath+"/userController/deleteUserById.act?id="+id;
			var json = tools.requestJsonRs(url);
			if(json.rtState){
				top.$.jBox.tip(json.rtMsg,"success");
				datagrid.datagrid("reload");
				datagrid.datagrid("unselectAll");
			}
		}
	});
}

function clearPwd(){
	var ids = getSelectItem();
	if(ids.length>0){
		$.jBox.confirm("确定清空选中用户的密码吗","确认",function(v){
			if(v=="ok"){
				var url = contextPath+"/userController/clearPwd.act?sids="+ids;
				var json = tools.requestJsonRs(url);
				if(json.rtState){
					top.$.jBox.tip(json.rtMsg,"success");
					datagrid.datagrid("reload");
					datagrid.datagrid("unselectAll");
				}
			}
		});
	}else{
		$.jBox.tip("至少选中一个用户","info");
	}
}

/**
 * 获取选中值
 */
function getSelectItem(){
	var selections = datagrid.datagrid('getSelections');
	var ids = "";
	for(var i=0;i<selections.length;i++){
		ids+=selections[i].sid;
		if(i!=selections.length-1){
			ids+=",";
		}
	}
	return ids;
}
</script>
</head>
<body onload="doInit();" style="overflow: hidden; font-size: 12px">
	<table id="datagrid" fit="true"></table>
	<div id="toolbar">
		<div class="moduleHeader">
			<b>用户管理</b>
		</div>
		<form id="form1" name="form1" method="post">
			<div style="margin: 10px 10px;" id="searchDiv">
				<input type="button" class="btn btn-success" onclick="addUser();"
					value="新建用户" /> <input type="button" class="btn btn-warning"
					onclick="clearPwd();" value="清空密码" />
			</div>
		</form>
	</div>
</body>
</html>