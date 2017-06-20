<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<%@ include file="/header/header.jsp"%>
		<%@ include file="/header/easyui.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<%-- 年度监测 --%>
		<style media="screen">
			body,
			html {
				height: 100%;
				width: 100%;
			}
			html {
				font-family: "微软雅黑";
				box-sizing: border-box;
			}
			.listhead {
				box-sizing: border-box;
				height: 72px;
				width: 100%;
				padding: 18px 32px;
			}
			.listhead>div:first-child>input,.listhead>div:first-child>button{
				float: left;
			}
			.listmain {
				position: absolute;
				left: 0;
				top: 72px;
				bottom: 0;
				right: 0;
				background: #F3F3F3;
				padding: 10px 30px;
			}
			.lists {
				list-style: none;
				padding: 0;
			}
			.lists li {
				box-sizing: border-box;
				height: 68px;
				background: #fff;
				margin-bottom: 10px;
				padding: 24px 0 24px 40px;
				line-height: 20px;
				font-size: 16px;
				color: #333;
			}
			.lists li img {
				display: block;
				float:left;
				margin-right: 34px;
				width: 20px;
				height: 20px;
			}
			.lists li p{
				margin-bottom: 0;
			}
			.lists li>p:first-of-type{
				float:left;
				margin-right: 122px;
				width: 30%;
			}
			.lists li>p:nth-of-type(2){
				float:left;
			}
			.lists li>p:last-of-type{
				float: right;
				margin-right: 42px;
				color: #3D70BB;
			}
		</style>
		<link rel="stylesheet" href="<%=contextPath %>/resource/css/page.css">
	</head>
	<body>
		<div class="" style="width: 100%;height: 100%;position: relative;">
			<div class="listhead">
				<div class="" style="float: left;">
					<input type="text" placeholder="请输入监测点编号" style="width: 400px;border: 0;height: 36px;line-height:36px;font-size:14px;background: #EBEBEB;text-indent:14px;border-bottom-left-radius: 3px;border-top-left-radius: 3px;padding: 0;" id="stationCodeSerch" onkeyup="keyserch()">
						<button style="width: 36px;height: 36px;background: #BDC2CA;border-bottom-right-radius: 3px;border-top-right-radius: 3px;border: 0;" onclick="keyserch()"><img src="<%=contextPath %>/resource/images/focusing.png" alt="" style="width: 18px;height: 18px;"></button>
					</div>
				</div>
                    <div class="listmain">
                        <ul class="lists">
                            <%-- <li>
                                <img src="./soil.png" alt="" style="">
                                <p>监测点编号：007</p>
                                <p>土壤类别：黑黏土</p>
                                <p><a href="<%=contextPath %>/monitor/info/index.jsp">查看</a></p>
                            </li> --%>
                        </ul>
				<div class="page" id="page" style="float: right;">

				</div>
                    </div>
				</div>

				<div class="" id="jbox">
					<div class="" style="">
						<label for="stationCode" style="width: 100px;text-align: right;line-height: 50px;">监测点编号：</label>
						<input type="text" name="stationCode" value="" id="stationCode">
					</div>
					<div class="" style="">
						<label for="soilCategory" style="width: 100px;text-align: right;line-height: 50px;">土壤类型：</label>
						<input type="text" name="soilCategory" value="" id="soilCategory">
					</div>
				</div>
				<script type="text/javascript" src="<%=contextPath %>/resource/js/page.js">

				</script>
				<script type="text/javascript">
					$.ajax({
						url:contextPath+"/monitorStationInfoController/getMonitorStationInfoDatagrid.act?rows=99999",
						type:"post",
						success: function (data) {
							// console.log(data);
							if(data.rows.length){
							   options = {
								  "id": "page", //显示页码的元素
								  "data": data.rows, //需要显示的数据
								  "maxshowpageitem": 5, //最多显示的页码个数
								  "pagelistcount": 6, //每页显示数据个数
								  "callBack": function(result) {
									  // console.log(result);
									  var li=""
									  $.each(result,function(k,v){
										  li+="<li>"
											  +"<img src='"+contextPath+"/resource/images/soil.png' />"
											  +"<p>监测点编号："+v.stationCode+"</p>"
											  +"<p>土壤类型："+v.soilCategory+"</p>"
											  +"<p onclick=info("+v.sid+",'"+v.stationCode+"') style='cursor: pointer;'>查看</p>"
											  +"</li>"
									  })
									  $(".lists").html(li)
								  }
							  }; //只需设置options参数，即可使用插件
							  page.init(data.rows.length, 1, options); //插件初始化
						  }else{
								  $(".lists").html("<li style='text-align:center;'>没有监测点</li>")
						  }
						}
					})

					function info(sid,stationCode) {
						window.location="info/index.jsp?sid="+sid+"&stationCode="+stationCode;
					}
					function keyserch() {
						var stationCodeSerch=$("#stationCodeSerch").val();
						$.ajax({
							url:contextPath+"/monitorStationInfoController/getMonitorStationInfoDatagrid.act?rows=99999",
							data:{
								stationCode:stationCodeSerch
							},
							type:"post",
							success: function (data) {
								// console.log(data);
								if(data.rows.length){
									options = {
									   "id": "page", //显示页码的元素
									   "data": data.rows, //需要显示的数据
									   "maxshowpageitem": 5, //最多显示的页码个数
									   "pagelistcount": 6, //每页显示数据个数
									   "callBack": function(result) {
										   // console.log(result);
										   var li=""
										   $.each(result,function(k,v){
											   li+="<li>"
												   +"<img src='"+contextPath+"/resource/images/soil.png' />"
												   +"<p>监测点编号："+v.stationCode+"</p>"
												   +"<p>土壤类型："+v.soilCategory+"</p>"
												   +"<p onclick=info("+v.sid+",'"+v.stationCode+"') style='cursor: pointer;'>查看</p>"
												   +"</li>"
										   })
										   $(".lists").html(li)
									   }
								   }; //只需设置options参数，即可使用插件
								   page.init(data.rows.length, 1, options); //插件初始化
							   }else{
									   $(".lists").html("<li style='text-align:center;'>没有满足条件的监测点</li>")
							   }
							}
						})
					}
				</script>
			</body>
		</html>
