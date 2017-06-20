<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String stationCode = request.getParameter("stationCode");
    String sid = request.getParameter("sid");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@ include file="/header/header.jsp"%>
    <title>Document</title>
    <style media="screen">
        body,
        html {
            height: 100%;
            width: 100%;
        }
        body{
            font: normal 14px verdana;
            color:#333;
            overflow-y: scroll;
            padding:0 20px;
        }
        table{
            width:100%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        td{
            text-align:center;
            border:1px solid #DDDAD5;
            height: 40px;
        }
    </style>
</head>
<body onload="getSumTableDetail()">
    <form action="">
        <table>
            <thead>
                <tr>
                    <td>项目</td>
                    <td>年份</td>
                    <td>长期不施肥</td>
                    <td>当季不施肥区</td>
                    <td>常规施肥区</td>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </form>
    <script type="text/javascript">
        (function($){
            function getSumTableDetail(){
                var url = contextPath+"/statisticsController/getSoil5yearDatas.act?stationSid=<%=sid%>";
                $.ajax({
                   url: url,
                   type: "POST",
                   contentType : 'application/json;charset=utf-8', //设置请求头信息
                   dataType:"json",
                   success: function(data){
                      var json = data;
                      var tbody = $("tbody");
                      if(json.rtState && json.rtData){
                          for(var k in json.rtData){
                              var jsonRtData = json.rtData[k];
                              var jsonDatasDatas = jsonRtData.datas;
                              var jsonName = jsonRtData.fieldName;
                              var tr ="<tr>" + "<td rowspan=" + jsonDatasDatas.length + ">" + jsonRtData.fieldDesc +"</td>";
                                for(var m in jsonDatasDatas){
                                    if(m == 0){
                                        tr = tr +
                                        "<td>" + jsonDatasDatas[m].monitorYear  +"</td>" +
                                        "<td>" + jsonDatasDatas[m][jsonName +  "_first" ]  +"</td>" +
                                        "<td>" + jsonDatasDatas[m][jsonName + "_second" ] + "</td>" +
                                        "<td>" + jsonDatasDatas[m][jsonName + "_third" ] +"</td>"
                                    }else{
                                        tr = tr +
                                        "<tr>"+
                                            "<td>" + jsonDatasDatas[m].monitorYear  +"</td>" +
                                            "<td>" + jsonDatasDatas[m][jsonName +  "_first" ] + "</td>" +
                                            "<td>" + jsonDatasDatas[m][jsonName + "_second" ] + "</td>" +
                                            "<td>" + jsonDatasDatas[m][jsonName + "_third" ] + "</td>"+
                                        "</tr>"
                                    }
                                }
                                if(jsonDatasDatas.length < 1){
                                    tr = tr +
                                    "<td></td>" +
                                    "<td></td>" +
                                    "<td></td>" +
                                    "<td></td>"
                                }
                                tr = tr + "</tr>"
                                tbody.append(tr);
                                $("td").each(function(){
                                    if($(this).text()==null||$(this).text()=="null"){
                                        $(this).text("")
                                    }
                                });
                          }
                       }else{
                           top.$.jBox.tip("系统异常！","error");
                       }
                   },
                   error: function(res){
                       top.$.jBox.tip("系统异常！","error");
                   }
                });
            }
            window.getSumTableDetail = getSumTableDetail;
        })(jQuery)
    </script>
</body>
</html>
