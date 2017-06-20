<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@ include file="/header/header.jsp"%>
<%@ include file="/header/easyui.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	function sendMessage(){
		var message = $("#message").val();
		var url=contextPath+"/demonController/send.act";
		var param={};
		param["message"]=message;
		var json = tools.requestJsonRs(url,param);
		if(json.rtState){
			$.jBox.tip(json.rtMsg);
		}else{
			$.jBox.tip(json.rtMsg);
		}
	}
	function receiveMessage(){
		var url=contextPath+"/demonController/receive.act";
		var json = tools.requestJsonRs(url);
		if(json.rtState){
			$("#messageContainor").html(json.rtData);
		}
	}

</script>
</head>
<body style="overflow: hidden; font-size: 12px">
	消息：<input type="text" id="message" name="message" class="BigInput"/>
	<br/>
	<input type="button" class="btn btn-success" value="发送" onclick="sendMessage()"/>
	<input type="button" class="btn btn-success" value="接收" onclick="receiveMessage()"/>
	<div id="messageContainor">
	
	</div>
</body>
</html>