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
        <%-- 田间管理视频 --%>
        <style media="screen">
            body,
            html {
                height: 100%;
                width: 100%;
            }

        </style>
    </head>
    <body>
		<div class="" style="width: 100%;height: 100%;padding: 30px;box-sizing: border-box;">
			<div class="" id='divPlugin' style="width: 100%;height: 100%;">

			</div>
			<iframe src="" width="300px" height="200px" style="position: absolute;top: 50%;left: 50%;margin-left: -150px;margin-top: -100px;display: none;border: 0;" id="suiji"></iframe>


		</div>
        <script type="text/javascript" src="webVideoCtrl.js"></script>
        <script type="text/javascript" src="demo.js"></script>
		<script type="text/javascript">
		var stationCode =  '<%=stationCode%>',
		sid =  '<%=sid%>';
		if (-1 == WebVideoCtrl.I_CheckPluginInstall()) {
			$("#suiji").show().attr("src","download.jsp");
		}else{
			WebVideoCtrl.I_InitPlugin('100%' , '100%', {
		        iWndowType: 1
			});
			WebVideoCtrl.I_InsertOBJECTPlugin("divPlugin");
			if (-1 == WebVideoCtrl.I_CheckPluginVersion()) {
				$("#suiji").show().attr("src","download.jsp");
			}else{
				getDeviceInfo();
			}
		}


		function getDeviceInfo(){
			var url = contextPath+"/monitorStationDeviceController/getMonitorStationDevice.act";
			var param={};
			param["stationSid"]=sid;
			param["deviceType"]="摄像";
			var json = tools.requestJsonRs(url,param);
			// console.log(json)
			if(json.rtState){
				if(json.rtData.length>0){
					// console.log(json.rtData[0]);
					var data=json.rtData[0];
					setTimeout(function () {
						var iRet = WebVideoCtrl.I_Login(data.ip, 1, data.port, data.userName, data.password, {
							success: function (xmlDoc) {
								console.log("登陆成功");
								yulan();
							},
							error: function () {
								console.log("登陆失败")
							}
						});
						if (-1 == iRet) {
							console.log( " 已登录过！");
						}

						function yulan(){
							var a = WebVideoCtrl.I_StartRealPlay("bjtcxt.xicp.net", {
								iStreamType: 1,
								iChannelID: data.token,
								bZeroChannel: false
							});

							if (0 == a) {
								console.log( "开始预览成功！");
							} else {
								console.log("开始预览失败！");
							}
						}
					},0)
				}else{
					$("#suiji").show().attr("src","no.jsp");
				}
			}
		}

		</script>
    </body>
</html>
