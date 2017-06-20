<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 String name =(String)request.getSession().getAttribute("userName");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@ include file="/header/header.jsp"%>
<%@ include file="/header/easyui.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>耕地质量监测信息管理平台</title>
<link href="<%=contextPath %>/frame/menu.css" rel="stylesheet" />
<link href="<%=contextPath %>/resource/css/frame.css" rel="stylesheet" />
<link rel="stylesheet" href="aside.css" />
<script src="<%=contextPath %>/frame/frame.js"></script>
<script>
$(function(){
	$("#tabs").tabs({
		width:$("#tabs").parent().width(),
		height:$("#tabs").parent().height()
	});
});
$(function(){
				$(".bottom_top").on("mouseover",function(){
					if($(this).text()=="监测点信息"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/monitor.png");
					}else if($(this).text()=="自动监测"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/automonitor.png");
					}else if($(this).text()=="年度监测"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/annualMonitoring.png");
					}else if($(this).text()=="五年监测"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/fiveYearMonitoring.png");
					}else if($(this).text()=="监测结果"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/monitoringresults.png");
					}
				})
				$(".bottom_top").on("mouseout",function(){
					if($(this).text()=="监测点信息"  && !($(this).hasClass("active"))){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/monitor1.png");
					}else if($(this).text()=="自动监测"  && !($(this).hasClass("active"))){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/automonitor1.png");
					}else if($(this).text()=="年度监测"  && !($(this).hasClass("active"))){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/annualMonitoring1.png");
					}else if($(this).text()=="五年监测"  && !($(this).hasClass("active"))){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/fiveYearMonitoring1.png");
					}else if($(this).text()=="监测结果"  && !($(this).hasClass("active"))){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/monitoringresults1.png");
					}
				})
				$(".bottom_top").click(function(){
					// console.log($(this).text())
					if($(this).text()=="监测点信息"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/monitor.png");
					}else if($(this).text()=="自动监测"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/automonitor.png");
					}else if($(this).text()=="年度监测"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/annualMonitoring.png");
					}else if($(this).text()=="五年监测"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/fiveYearMonitoring.png");
					}else if($(this).text()=="监测结果"){
						$(this).find("img").attr("src","<%=contextPath %>/resource/images/sys/monitoringresults.png");
					}
					$(this).siblings().css("display","block");
					$(this).parent().siblings().find(".bottom_top").siblings().css("display","none")
					$(this).addClass("active")
					$(this).parent(".item").siblings().find(".bottom_top").removeClass("active");
					$(".bottom_bot_li").removeClass("active1");

					for(var i=0,len=$(".item").length;i<len;i++){
						if(!($(".item").eq(i).find(".bottom_top").hasClass("active")) && $(".item").eq(i).find(".bottom_top").text() == "监测点信息"){
							$(".item").eq(i).find(".bottom_top").find("img").attr("src","<%=contextPath %>/resource/images/sys/monitor1.png");
						}else if(!($(".item").eq(i).find(".bottom_top").hasClass("active")) && $(".item").eq(i).find(".bottom_top").text() == "自动监测"){
							$(".item").eq(i).find(".bottom_top").find("img").attr("src","<%=contextPath %>/resource/images/sys/automonitor1.png");
						}else if(!($(".item").eq(i).find(".bottom_top").hasClass("active")) && $(".item").eq(i).find(".bottom_top").text() == "年度监测"){
							$(".item").eq(i).find(".bottom_top").find("img").attr("src","<%=contextPath %>/resource/images/sys/annualMonitoring1.png");
						}else if(!($(".item").eq(i).find(".bottom_top").hasClass("active")) && $(".item").eq(i).find(".bottom_top").text() == "五年监测"){
							$(".item").eq(i).find(".bottom_top").find("img").attr("src","<%=contextPath %>/resource/images/sys/fiveYearMonitoring1.png");
						}else if(!($(".item").eq(i).find(".bottom_top").hasClass("active")) && $(".item").eq(i).find(".bottom_top").text() == "监测结果"){
							$(".item").eq(i).find(".bottom_top").find("img").attr("src","<%=contextPath %>/resource/images/sys/monitoringresults1.png");
						}
					}
					// if($(this).siblings().is(':hidden')){
					// 	$(this).children("span").css("transform","rotate(-90deg)");
					// }else{
					// 	$(this).children("span").css("transform","rotate(0)");
					// }
				});
				$(".bottom_bot_li").click(function(){
			                    // $(".bottom_bot_li").each(function(i){
								//
			                    //     $(".bottom_bot_li").eq(i).children("b").hide();
			                    //     //  $(".bottom_bot_li").eq(i).css("background","#307856");
			                    // });
								// // $(this).css("background","#2c654a");
								// // $(this).siblings().css("background","#307856");
					$(this).addClass("active1").siblings().removeClass("active1");
					$(this).parent().parent().siblings().addClass("active")
					$(this).parent().parent().parent().siblings().find(".bottom_top").removeClass("active")
				});
			});
</script>
</head>
	<body class="easyui-layout" onResize="change()">
	  <%-- <iframe src="" width="" height="" style="position: absolute;top: 200px;left: 500px;z-index: 1991;display: none;" id="dialog"></iframe> --%>
		 <div region="north"  style="height: 78px;overflow:hidden;border: 0;background: #66A3FE;">
			 <h3 style="margin: 0;line-height: 39px;color: #fff;float: left;cursor: default;line-height: 78px;margin-left: 35px;font-size:32px;">耕地质量监测信息管理平台</h3>
			 <div class="" style="float: right;line-height: 78px;">
				 <p style="margin-right: 44px;float: left;margin-bottom:0;font-size: 18px;cursor: default;color: #fff;"><%=name%></p>
				 <a href="#" style="margin-right: 35px;float: right;margin-top: 30px;" onclick="outSystem()"><img src="out.png" alt=""></a>
			 </div>
		 </div>
		 <div region="west"  style="width:260px;padding-top:5px;background:#2A2D33;border:0;">
		 	<div style="width:280px;height:100%;overflow-y:scroll;position:absolute;">
		     	<div id="aside">
				<div class="bottom">
					<ul class="bottom_ul">

					</ul>
				</div>
			</div>
		 	</div>
		 </div>
		  <div region="center" style="text-align:center;border-top:0;height:auto;">
		  	  <%--  <iframe  id="mainFrame" name="mainFrame" frameborder="0" width="100%" height="100%" onLoad="iFrameHeight();" src="<%=contextPath %>/frame/portlet/index.jsp">
		  		</iframe> --%>
		        <iframe  id="mainFrame" name="mainFrame" frameborder="0" width="100%" height="100%" onLoad="iFrameHeight();"  src="<%=contextPath %>/frame/portlet/index.jsp">
		  		</iframe>
		  </div>
		  <script type="text/javascript">
				function change(){
					$("iframe").attr("height",$(window).height() - 80)
				}
		  </script>
	</body>
</html>
