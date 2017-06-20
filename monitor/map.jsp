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

		</style>
	</head>
	<body>
		<div class="" style="width: 100%;height: 100%;position: relative;">
			<div class="" id="amap" style="width: 100%;height: 100%;"></div>
			<img src="return.png" alt="" style="width: 50px;height:50px;position: absolute;right: 30px;top: 20px;cursor: pointer;" id="returns"></div>
			<script type="text/javascript" src="http://maps.google.cn/maps/api/js?key=AIzaSyA1nKQUml4rI2eY5c7Wekr4nBcu84WwjiA"></script>
			<script type="text/javascript">
				var map;
				function initMap() {
					map = new google.maps.Map(document.getElementById('amap'), {
						center: {
							lat: 44.2443,
							lng: 7.769689
						},
						mapTypeId: google.maps.MapTypeId.SATELLITE,
						disableDefaultUI: true,
						zoom: 10
					});
				};
				initMap()
				markerList();
				//移动地图到中心点
				function setMapCenter(myLatLng) {
					map.setCenter(myLatLng);
				}
				function markerList() {
					$.ajax({
						url: contextPath + "/monitorStationInfoController/getMonitorStationInfoDatagrid.act?rows=99999",
						type: "post",
						success: function (data) {
							// console.log(data.rows);
							if (data.rows.length) {
								var points = [],
									maks = [],
									alllong = [],
									alllat = [];

								$.each(data.rows, function (k, v) {
									if (v.longitude && v.latitude) {
										var long = v.longitude.split("°")[0] * 1 + ((v.longitude.split("°")[1]).split("′")[0]) / 60 * 1 + (((v.longitude.split("°")[1]).split("′")[1]).split("″")[0]) / 3600 * 1;
										var lat = v.latitude.split("°")[0] * 1 + ((v.longitude.split("°")[1]).split("′")[0]) / 60 * 1 + (((v.longitude.split("°")[1]).split("′")[1]).split("″")[0]) / 3600 * 1;
										alllong.push(long);
										alllat.push(lat);
										var Marker = new google.maps.Marker({
											position: new google.maps.LatLng(lat, long),
											title: v.stationCode
										})
										maks.push(Marker);
									}
								})

								// 标注点击事件
								for (var i = 0, len = maks.length; i < len; i++) {
									(function (i) {
										maks[i].setMap(map)
										maks[i].addListener("click", function () {
											// console.log(i)
											parent.postMessage("<%=contextPath %>/monitor/info/index.jsp?sid=" + data.rows[i].sid + "&stationCode=" + data.rows[i].stationCode, "/");
											// window.location = "<%=contextPath %>/monitor/info/index.jsp?sid=" + data.rows[i].sid + "&stationCode=" + data.rows[i].stationCode;
										})
									})(i)
								}
								//计算中心点
								alllong.sort(),
								alllat.sort()
								var ln = (alllong[0] * 1 + alllong[alllong.length - 1] * 1) / 2;
								var la = (alllat[0] * 1 + alllat[alllat.length - 1] * 1) / 2;
								map.setCenter(new google.maps.LatLng(la, ln));
								//返回中心点
								$("#returns").on("click", function () {
									map.setCenter(new google.maps.LatLng(la, ln));
									map.setZoom(10)
								})
							}else {
								return;
							}
						}
					})
				}
			</script>

		</body>
	</html>
