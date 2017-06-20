<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
        <%@ include file="/header/header.jsp"%>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <%-- 田间管理视频 --%>
    </head>
    <body>
        <div class="download" style="width: 100%;height: 100%;padding-top: 50px;box-sizing: border-box; ">
            <p style="text-align:center;font-size: 18px;">该监测点没有摄像设备！</p>
            <i style="display: block;text-align: center;font-size: 12px;margin-bottom: 20px;">（请点击确定返回列表页）</i>
            <p style="text-align: center;">
                <a href="javascript;" style="padding: 8px 12px;background:  #66A3FE;border-radius: 3px;color: #fff;" onclick="returns()">确定</a>
                <%-- <button onclick="returns()">确定</button> --%>
            </p>
        </div>
        <script type="text/javascript">
            function returns(){
                parent.location="<%=contextPath %>/automonitor/fieldManagement/index.jsp"
            }
        </script>
    </body>
</html>
