<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<%
		String stationCode= request.getParameter("stationCode");
		String sid = request.getParameter("sid");
	%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
		<%@ include file="/header/header.jsp"%>
		<%@ include file="/header/easyui.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="stylesheet" href="./index.css">
	</head>
	<body>
        <div id="base-div">
            <%---------------------- 面包屑导航 --------------------%>
            <div id="top-div">
                <a href="<%=contextPath %>/monitor/index.jsp">监测点列表</a> > <label for=""><%=stationCode%></label>
            </div>
            <%---------------------- 下拉框 --------------------%>
            <div id="middle-div">
                <select >
            		<option value="MonDetail">监测点基本情况记载表</option>
            		<option value="Monsoil">监测点土壤剖面记载表</option>
    	        </select>
             </div>
            <%---------------------- 切换区 --------------------%>
            <div id="bottom-div">
                <iframe src="<%=contextPath %>/monitor/info/MonDetail.jsp?sid=<%=sid%>&stationCode=<%=stationCode%>" id="" name=""  width="100%" height="96%" frameborder="none" scrolling="no"></iframe>
            </div>
        </div>
	</body>
    <script type="text/javascript">
        window.onload = function(){
            $("select").change(function(){
                $("iframe").attr("src","<%=contextPath %>/monitor/info/" + this.value + ".jsp?sid=<%=sid%>&stationCode=<%=stationCode%>" )
            })
        }
    </script>
</html>
