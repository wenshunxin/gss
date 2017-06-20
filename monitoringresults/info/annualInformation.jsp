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
        <link rel="stylesheet" href="./index.css"/>
        <%-- 年度监测info --%>
        <style media="screen">
            /*body,
            html {
                /*height:100%;
                width: 100%;
            }*/
            
        </style>
        <script type="text/javascript">

            /*
                展示数据
            */ 
            function onload(){
                // console.log(monitorYear)
                var param={
                    "stationSid":"<%=sid%>"
                }
                var url =contextPath+"/statisticsController/getSoilYearDatas.act?";
			    var json = tools.requestJsonRs(url,param);
                var obj =json.rtData;
                var html="";
                for(var i=0;i<obj.length;i++){
                    var txt=obj[i].datas;
                    html="<tr>"
                        +"<td rowspan='"+txt.length+"'>"+obj[i].fieldDesc
                        +"</td>";                   
                    var text="";
                    for(var j=0;j<txt.length;j++){
                       text=text+""
                            +"<td>"+txt[j].monitorYear
                            +"</td><td>"+txt[j][obj[i].fieldName+"_first"]
                            +"</td><td>"+txt[j][obj[i].fieldName+"_second"]
                            +"</td><td>"+txt[j][obj[i].fieldName+"_third"]
                            +"</td>";
                            break;                    
                    }
                    if(txt.length<1){
                        text=text+""
                            +"<td>"
                            +"</td><td>"
                            +"</td><td>"
                            +"</td><td>"
                            +"</td>";
                    }
                    for(var j=1;j<txt.length;j++){
                    text=text+"<tr>"
                        +"<td>"+txt[j].monitorYear
                        +"</td><td>"+txt[j][obj[i].fieldName+"_first"]
                        +"</td><td>"+txt[j][obj[i].fieldName+"_second"]
                        +"</td><td>"+txt[j][obj[i].fieldName+"_third"]
                        +"</td></tr>";                  
                    }
                    html+=text;
                    html+="</tr>";
                    $("#annualInfo").append(html);
                    $("td").each(function(){
                        if($(this).text()==null||$(this).text()=="null"){
                            $(this).text("")
                        }
                    });                  
                }
            }
            // 时间戳转化日期2017-10-10
            function formatDate(nows) { 
                if(nows==""||nows==null){
                    return ""
                }
                var now=new Date(nows); 
                var year=now.getFullYear(); 
                var month=(now.getMonth()+1)<10?"0"+(now.getMonth()+1):now.getMonth()+1; 
                var date=now.getDate()<10?"0"+now.getDate():now.getDate(); 
                // console.log(year+"-"+month+"-"+date)
                return year+"-"+month+"-"+date; 
            }

		</script>
    </head>
    <body onload="onload()" style="overflow-y:auto;overflow-x:auto;padding:0 20px;">
        <form id="form1">
        <table border="1" cellpadding="0" cellspacing="0" id="annualInfo" width="100%">
            <tr>
                <td>项目</td>
                <td>年份</td>
                <td>长期不肥区</td>
                <td>当季不施肥区</td>
                <td>常规施肥区</td>
            </tr>
        </table>
        </form>
    </body>
</html>
