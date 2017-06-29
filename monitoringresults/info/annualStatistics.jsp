<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String stationCode = request.getParameter("stationCode");
    String sid = request.getParameter("sid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@ include file="/header/header.jsp"%>
<%@ include file="/header/easyui.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="./index.css" />
<script src="<%=contextPath %>/resource/js/highcharts/highcharts.js"></script>
<script src="<%=contextPath %>/resource/js/highcharts/exporting.js"></script>
<script src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script>
<script type="text/javascript">
            function onload(){
                var param={
                    "stationSid":"<%=sid%>"
                }
                var url =contextPath+"/statisticsController/getSoilYearDatas.act?";
			    var json = tools.requestJsonRs(url,param);
                if(json.rtState){
            	   var data = json.rtData;
            	   var html="";
            	   for(var m=0;m<data.length;m++){
            	   		html+="<option value='"+m+"'>"+data[m].fieldDesc+"</option>";
            	   }
            		$("#category").html(html);
            		getLine();
                }
            }
            function getLine(){
            	var m = $("#category").val();
            	var showName = $("#category").find("option:selected").text();
            	var param={
                         "stationSid":"<%=sid%>"
					}
				var url = contextPath + "/statisticsController/getSoilYearDatas.act?";
				var json = tools.requestJsonRs(url, param);
				if (json.rtState) {
					var data = json.rtData;
					var yjz = data[m];
					var categories = [];
					var series = [];
					var first = {};
					var second = {};
					var third = {};
					var firstData = [];
					var secData = [];
					var thirdData = [];
					var category = yjz.fieldName;
					for (var i = 0; i < yjz.datas.length; i++) {
						var d = yjz.datas[i];
						categories.push(d.monitorYear);
						firstData.push(d[category + "_first"]);
						secData.push(d[category + "_second"]);
						thirdData.push(d[category + "_third"]);
					}
					first["name"] = "长期不施肥";
					first["data"] = firstData;
					second["name"] = "当季不施肥";
					second["data"] = secData;
					third["name"] = "常规施肥区";
					third["data"] = thirdData;
					series.push(first);
					series.push(second);
					series.push(third);
					var chart = new Highcharts.Chart('container', {
						chart: {
					            type: 'spline'
					    },
						title : {
							text : showName+'不同年份,不同施肥情况统计结果',
							x : -20
						},
						subtitle : {
							text : '',
							x : -20
						},
						xAxis : {
							categories : categories
						},
						yAxis : {
							title : {
								text : '数值'
							},
							plotLines : [ {
								value : 0,
								width : 1,
								color : '#808080'
							} ]
						},
						tooltip : {
							valueSuffix : '（g/kg）'
						},
						legend : {
							layout : 'vertical',
							align : 'right',
							verticalAlign : 'middle',
							borderWidth : 0
						},
						series : series
					});
				}

	}
</script>
</head>
<body onload="onload()" style="overflow-y: auto; overflow-x: auto; padding: 10px 20px;">
	<div id="categoryDiv" style="height:50px;line-height:50px;float:right;">
		<select id="category" onchange="getLine();" class="BigSelect">
		</select>
	</div>
	<div id="container" style="min-width: 400px; height: 400px"></div>
</body>
</html>
