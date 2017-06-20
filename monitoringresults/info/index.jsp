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
                padding:0 10px;
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
                       $("#mainFrame").attr("src","<%=contextPath %>/monitoringresults/info/applyFertilizer.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }else if($(this).val()=="2"){
                        $("#mainFrame").attr("src","<%=contextPath %>/monitoringresults/info/output.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }else if($(this).val()=="3"){
                        $("#mainFrame").attr("src","<%=contextPath %>/monitoringresults/info/soilPhysical.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }else if($(this).val()=="4"){
                        $("#mainFrame").attr("src","<%=contextPath %>/monitoringresults/info/soilOrganism.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }else if($(this).val()=="5"){
                        $("#mainFrame").attr("src","<%=contextPath %>/monitoringresults/info/annualInformation.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }else if($(this).val()=="6"){
                        $("#mainFrame").attr("src","<%=contextPath %>/monitoringresults/info/fiveannualInformation.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }else{
                        $("#mainFrame").attr("src","<%=contextPath %>/monitoringresults/info/Monpro.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>")
                    }
                })
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
                    <li><a href="<%=contextPath %>/monitoringresults/index.jsp">监测点列表</a></li>
                    <li class="active"><%=stationCode%></li>
                </ol>
            </div>
            <select name="select"  id="w-select" class="BigSelect" style="width:100%;font-size:20px;height:35px;line-height:28px;padding:0 10px;"   >
                <option value="0">监测点田间生产情况记载表</option>
                <option value="1">施肥明细情况记载表</option>
                <option value="2">产量与施肥量汇总表</option>
                <option value="3">监测点土壤理化性状记载表</option>
                <option value="4">5年壤理化性状表</option>
                <option value="5">土壤年度信息统计</option>
                <option value="6">土壤5年度信息统计</option>
            </select>
            <!--<select id="w-select" class="easyui-combobox" name="dept" style="width:200px;">   
                <option value="1">施肥明细情况记载表</option>   
                <option value="2">产量与施肥量汇总表</option>   
            </select>  -->
            </div>
        <div  id="divHeight" style="position:absolute;top:120px;left:0;bottom:0px;right:0;">
            <iframe  id="mainFrame" name="mainFrame" frameborder="0" width="100%" height="100%"  src="<%=contextPath %>/monitoringresults/info/Monpro.jsp?stationCode=<%=stationCode%>&sid=<%=sid%>">
      		</iframe>
        </div>
    </body>
</html>
