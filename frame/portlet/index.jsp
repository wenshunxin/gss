<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<%@ include file="/header/header.jsp"%>
		<%@ include file="/header/easyui.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<style media="screen">
			body,
			html {
				height: 100%;
				width: 100%;
			}
			.tabs{
				box-sizing: border-box;
			}
			.tabs>p{
				line-height: 60px;
				float: left;
				margin-bottom: 0;
				font-size: 18px;
				color: #666;
				margin-right: 62px;
				padding: 0 10px;
				cursor: pointer;
			}
			.tabs>p:hover{
				border-bottom: 4px solid  #66A3FE;
				color: #333;
			}
			.tabs .active{
				border-bottom: 4px solid  #66A3FE;
				color: #333;
			}
		</style>
	</head>
	<body>
		<div class="" style="height: 100%;width: 100%;position: relative;">
			<div class="tabs" style="height: 64px;padding: 0 46px;">
				<p class="active">地图显示</p>
				<p>列表显示</p>
			</div>
			<div class="" style="position: absolute;left: 0;top:64px;bottom: 0;right: 0;">
				<iframe id="monitor" frameborder="0" width="100%" height="100%" src="<%=contextPath %>/monitor/map.jsp">
			   </iframe>
			</div>
		</div>
		<script type="text/javascript">
			$(".tabs>p").on("click",function(){
				$(this).addClass("active").siblings().removeClass("active");
				if($(this).text() == "地图显示"){
					$("#monitor").attr("src","<%=contextPath %>/monitor/map.jsp")
				}else if($(this).text() == "列表显示"){
					$("#monitor").attr("src","<%=contextPath %>/monitor/index.jsp")
				}
			})
			window.addEventListener("message", function(e){
				$(".tabs p:last-child").addClass("active").siblings().removeClass("active");
				$("#monitor").attr("src",e.data)
			})
		</script>
	</body>
</html>
