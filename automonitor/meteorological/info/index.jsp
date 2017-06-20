<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		String sid = request.getParameter("sid");
		String stationCode = request.getParameter("stationCode");
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
        <%@ include file="/header/header.jsp"%>
        <%@ include file="/header/easyui.jsp"%>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <%-- 气象条件info --%>
        <style media="screen">
            body,
            html {
                height: 100%;
                width: 100%;
            }

        </style>
   <script>
var datagrid;
var stationCode =  '<%=stationCode%>',
sid =  '<%=sid%>';
var  deviceNum;
var paramIds;
Date.prototype.format = function(format) //author: meizz
{
  var o = {
    "M+" : this.getMonth()+1, //month
    "d+" : this.getDate(),    //day
    "h+" : this.getHours(),   //hour
    "m+" : this.getMinutes(), //minute
    "s+" : this.getSeconds(), //second
    "q+" : Math.floor((this.getMonth()+3)/3),  //quarter
    "S" : this.getMilliseconds() //millisecond
  }
  if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
    (this.getFullYear()+"").substr(4 - RegExp.$1.length));
  for(var k in o)if(new RegExp("("+ k +")").test(format))
    format = format.replace(RegExp.$1,
      RegExp.$1.length==1 ? o[k] :
        ("00"+ o[k]).substr((""+ o[k]).length));
  return format;
}

$(function(){

    $("#startDate").datetimepicker({
        language:"zh-CN",
        minView:"month",
        format:"yyyy-mm-dd",
        todayBtn: true,
        todayHighlight : true,
        autoclose: true,
        endDate :new Date()
    });

    $("#endDate").datetimepicker({
        language:"zh-CN",
        minView:"month",
        format:"yyyy-mm-dd",
        todayBtn: true,
        todayHighlight : true,
        autoclose: true,
        endDate :new Date()
    });


    var date = new Date();
    var endDate = date.format("yyyy-MM-dd");

    var sdate = new Date();
    sdate.setDate(sdate.getDate() - 7);
    var startDate = sdate.format("yyyy-MM-dd");

    $("#startDate").val(startDate);
    $("#endDate").val(endDate);

});

function setColumn(){
	deviceNum = getDeviceInfo();
	if(deviceNum==""){
		return;
	}
	var url = contextPath+"/autoMonitorController/getDeviceParam.act?deviceNum="+deviceNum;
	var json = tools.requestJsonRs(url);
	if(json.rtState){
		var columns = [];
		for(var i=0;i<json.rtData.headList.length;i++){
			var data = json.rtData.headList[i];
			var column={};
			column["field"]=data.paramId;
			column["title"]=data.paramName;
			column["width"]=200;
			column["align"]="center";
			columns.push(column);
		}
		datagrid.datagrid("options").columns.push(columns);
		datagrid.datagrid("options").frozenColumns.push([{
			field:"date",
			title:"日期",
			width:200,
			align:"center"
		}])
		return json.rtData.paramIds;
	}
}



function doInit(){
	datagrid = $('#datagrid').datagrid();
	paramIds = setColumn();
	if(deviceNum==""){
		paramIds="1";
		deviceNum ="00000000000000";
	}
	var startDate =$("#startDate").val();
	var endDate =$("#endDate").val();
	 var url=contextPath+"/autoMonitorController/getDeviceData.act?paramIds="+paramIds+"&deviceNum="+deviceNum+"&startDate="+startDate+"&endDate="+endDate;
	datagrid = $('#datagrid').datagrid({
		url:url,
		pagination:true,
		singleSelect:true,
		toolbar:'#toolbar',//工具条对象
		//checkbox:true,
		border:false,
		striped:true,
		fitColumns:false//列是否进行自动宽度适应
	});
}


function getDeviceInfo(){
	var url = contextPath+"/monitorStationDeviceController/getMonitorStationDevice.act";
	var param={};
	param["stationSid"]=sid;
	param["deviceType"]="气象站";
	var json = tools.requestJsonRs(url,param);
	if(json.rtState){
		if(json.rtData.length>0){
			return json.rtData[0].deviceNum;
		}else{
			return "";
		}
	}else{
		return "";
	}
}


function doSearch(){
	  var startDate =$("#startDate").val();
	  var endDate =$("#endDate").val();
	  var url=contextPath+"/autoMonitorController/getDeviceData.act?paramIds="+paramIds+"&deviceNum="+deviceNum+"&startDate="+startDate+"&endDate="+endDate;
	  datagrid.datagrid('options').url=url;
	  datagrid.datagrid("reload");
}

</script>
</head>
<body onload="doInit();" style="overflow: hidden; font-size: 12px;">
	<div class="" style="width: 100%;height: 100%;padding: 10px;box-sizing: border-box;background: #F3F3F3;">
		<div class="" style="width: 100%;height: 100%;">
			<table id="datagrid" fit="true"></table>
			<div class="" id="toolbar" style="height: 100px;">
				<div>
					<p style="margin-bottom: 0;float: left;line-height: 50px;margin-left: 20px;font-size: 16px;"><a href="<%=contextPath %>/automonitor/meteorological/index.jsp">气象条件列表</a></p>
					<p style="margin-bottom: 0;float: left;line-height: 50px;">&nbsp;>&nbsp;</p>
					<p style="margin-bottom: 0;float: left;line-height: 50px;font-size: 16px;color: #666;"><%=stationCode%></p>
				</div>
				<div style="clear: both;width: 100%;height: 50px;padding-left: 30px;">
					<form id="form1">
						<div>日期：<input type="text" class="SmallInput" id="startDate" name="startDate"/> -
								<input type="text" class="SmallInput" id="endDate" name="endDate"/>

							<input type="button" class="btn" value="查询" onclick="doSearch();" style="background: #66A3FE;color: #fff;"/>
							<input type="button" class="btn" value="刷新" onclick="doSearch();" style="background: #66A3FE;color: #fff;"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
