<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String stationCode = request.getParameter("stationCode");
    String sid = request.getParameter("sid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
        <%@ include file="/header/header.jsp"%>
        <%@ include file="/header/easyui.jsp"%>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="stylesheet" href="index.css"/>
        <%-- 年度监测info --%>
        <style media="screen">
            body,
            html {
                height:100%;
                padding:0 25px 0 20px;
            }
            .breadcrumb > li + li:before {
                color: #CCCCCC;
                content: "> ";
                padding: 0 5px;
            }
            .breadcrumb{
                background:#fff;
                padding:10px 0;
                margin:5px 0;
            }
            #middle-div{
                margin-bottom: 20px;
                font-size: 20px;
            }
            #middle-div select{
                padding: 0 10px;
                appearance:none;
                -moz-appearance:none;
                -webkit-appearance:none;
                background: url("../../resource/easyui/themes/metro/images/xiala.png") no-repeat scroll 99% center transparent;
            }
        </style>
        <script>
            $(function(){
                changeIframe();   
            })
            /*
                select 选中进行iframe 切换
            */ 
            function changeIframe(){
                $("#w-select").change(function(){
                    if($(this).val()=="1"){
                       $("#mainFrame").attr("src","<%=contextPath %>/annualMonitoring/info/applyFertilizer.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }else if($(this).val()=="2"){
                        $("#mainFrame").attr("src","<%=contextPath %>/annualMonitoring/info/output.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }else if($(this).val()=="3"){
                        $("#mainFrame").attr("src","<%=contextPath %>/annualMonitoring/info/soilPhysical.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }else{
                        $("#mainFrame").attr("src","<%=contextPath %>/annualMonitoring/info/Monpro.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }
                })
            }
            /*
                跳转到检测点列表
            */ 
            function CheckPointsList(){
                window.location="<%=contextPath %>/annualMonitoring/index.jsp"
            }
        </script>
    </head>
    <body id="doinHeight" style="overflow:auto;">
        <div style="height:15%;">
            <div class="w-head">
                <!--<span onclick="CheckPointsList()" style="cursor:pointer">监测点列表</span>
                >
                <span>监测点1</span>-->
                <ol class="breadcrumb">
                    <li><a href="<%=contextPath %>/annualMonitoring/index.jsp">监测点列表</a></li>
                    <li class="active"><%=stationCode%></li>
                </ol>
            </div>
            <div id="middle-div">
                <select name="select"  id="w-select" class="BigSelect" style="width:100%;font-size:20px;height:35px;line-height:28px;"   >
                    <option value="0">监测点田间生产情况记载表</option>
                    <option value="1">施肥明细情况记载表</option>
                    <option value="2">产量与施肥量汇总表</option>
                    <option value="3">监测点土壤理化性状记载表</option>
                </select>
            </div>
            
            <!--<select id="w-select" class="easyui-combobox" name="dept" style="width:200px;">   
                <option value="1">施肥明细情况记载表</option>   
                <option value="2">产量与施肥量汇总表</option>   
            </select>  -->
            </div>
        <div  id="divHeight" style="position:absolute;top:120px;left:0;bottom:0px;right:0;">
            <iframe  id="mainFrame" name="mainFrame" frameborder="0" width="100%" height="100%"  src="<%=contextPath %>/annualMonitoring/info/Monpro.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>">
      		</iframe>
        </div>
    </body>
</html>