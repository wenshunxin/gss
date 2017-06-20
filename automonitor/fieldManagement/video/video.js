$(function(){
    // 检查插件是否已经安装过
	if (-1 == WebVideoCtrl.I_CheckPluginInstall()) {
		alert("您还未安装过插件，双击开发包目录里的WebComponents.exe安装！");
		return;
	}

	// 初始化插件参数及插入插件
	WebVideoCtrl.I_InitPlugin('100%' , '100%', {
        iWndowType: 1
	});
	WebVideoCtrl.I_InsertOBJECTPlugin("divPlugin");
	// WebVideoCtrl.I_WriteOBJECT_XHTML()

	// 检查插件是否最新
	if (-1 == WebVideoCtrl.I_CheckPluginVersion()) {
		alert("检测到新的插件版本，双击开发包目录里的WebComponents.exe升级！");
		return;
	}
})

// 获取通道
function getChannelInfo() {
	var szIP = $("#ip").val(),
		oSel = $("#channels").empty(),
		nAnalogChannel = 0;

	if ("" == szIP) {
		return;
	}

	// 模拟通道
	WebVideoCtrl.I_GetAnalogChannelInfo(szIP, {
		async: false,
		success: function (xmlDoc) {
			var oChannels = $(xmlDoc).find("VideoInputChannel");
			nAnalogChannel = oChannels.length;

			$.each(oChannels, function (i) {
				var id = parseInt($(this).find("id").eq(0).text(), 10),
					name = $(this).find("name").eq(0).text();
				if ("" == name) {
					name = "Camera " + (id < 9 ? "0" + id : id);
				}
				oSel.append("<option value='" + id + "' bZero='false'>" + name + "</option>");
			});
			showOPInfo(szIP + " 获取模拟通道成功！");
		},
		error: function () {
			showOPInfo(szIP + " 获取模拟通道失败！");
		}
	});
	// 数字通道
	WebVideoCtrl.I_GetDigitalChannelInfo(szIP, {
		async: false,
		success: function (xmlDoc) {
			var oChannels = $(xmlDoc).find("InputProxyChannelStatus");

			$.each(oChannels, function (i) {
				var id = parseInt($(this).find("id").eq(0).text(), 10),
					name = $(this).find("name").eq(0).text(),
					online = $(this).find("online").eq(0).text();
				if ("false" == online) {// 过滤禁用的数字通道
					return true;
				}
				if ("" == name) {
					name = "IPCamera " + ((id - nAnalogChannel) < 9 ? "0" + (id - nAnalogChannel) : (id - nAnalogChannel));
				}
				oSel.append("<option value='" + id + "' bZero='false'>" + name + "</option>");
			});
			showOPInfo(szIP + " 获取数字通道成功！");
		},
		error: function () {
			showOPInfo(szIP + " 获取数字通道失败！");
		}
	});
	// 零通道
	WebVideoCtrl.I_GetZeroChannelInfo(szIP, {
		async: false,
		success: function (xmlDoc) {
			var oChannels = $(xmlDoc).find("ZeroVideoChannel");

			$.each(oChannels, function (i) {
				var id = parseInt($(this).find("id").eq(0).text(), 10),
					name = $(this).find("name").eq(0).text();
				if ("" == name) {
					name = "Zero Channel " + (id < 9 ? "0" + id : id);
				}
				if ("true" == $(this).find("enabled").eq(0).text()) {// 过滤禁用的零通道
					oSel.append("<option value='" + id + "' bZero='true'>" + name + "</option>");
				}
			});
			showOPInfo(szIP + " 获取零通道成功！");
		},
		error: function () {
			showOPInfo(szIP + " 获取零通道失败！");
		}
	});
}

// 开始预览
function clickStartRealPlay() {
	var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex),
		szIP = $("#ip").val(),
		iStreamType = parseInt($("#streamtype").val(), 10),
		iChannelID = parseInt($("#channels").val(), 10),
		bZeroChannel = $("#channels option").eq($("#channels").get(0).selectedIndex).attr("bZero") == "true" ? true : false,
		szInfo = "";

	if ("" == szIP) {
		return;
	}

	if (oWndInfo != null) {// 已经在播放了，先停止
		WebVideoCtrl.I_Stop();
	}

	var iRet = WebVideoCtrl.I_StartRealPlay(szIP, {
		iStreamType: iStreamType,
		iChannelID: iChannelID,
		bZeroChannel: bZeroChannel
	});

	if (0 == iRet) {
		szInfo = "开始预览成功！";
	} else {
		szInfo = "开始预览失败！";
	}

	showOPInfo(szIP + " " + szInfo);
}
