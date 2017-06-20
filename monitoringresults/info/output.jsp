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
        <link rel="stylesheet" href="index.css" />
        <%-- 年度监测info --%>
        <style media="screen">
            body,
            html {
                height:100%;
            }
        </style>
        <script>
            $(function(){
                 $("#monitorYear").change(function(){
                     $("#form1").find("span").text("");
                     onload();
                 })
            })
            // 数据展示
            function onload(){
                 var monitorYear = $("#monitorYear").val();
                // console.log(monitorYear)
                var param={
                    "stationSid":"<%=sid%>",
                    "monitorYear":monitorYear
                }
                var url =contextPath+"/yieldFertilizerController/getYieldFertilizerSummary.act";
				var json = tools.requestJsonRs(url,param);
                // console.log( json.rtData)
                bindJsonObj2Cntrl(json.rtData)
            }
        </script>
    </head>
    <body style="overflow-y:auto;" onload="onload()">
        <table border="0" cellpadding="0" cellspacing="0" id="w-tableHead" width="80%" style="height:35px;line-height:35px;margin:0 auto;">
            <tr>
                <td width="50%" style="text-align:center;">监测点代码：<span><%=stationCode%></span></td>
                <td width="50%" style="text-align:center;">检测年度：
                     <select id="monitorYear" name="monitorYear" class="BigSelect">
                        <% 
                            Calendar cl = Calendar.getInstance();
                            int year = cl.get(Calendar.YEAR);
                            for(int i=0;i<20;i++){
                        %>
                        <option value="<%=year-i %>"><%=year-i %></option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
        </table>
        <form id="form1">
            <table border="0" cellpadding="0" cellspacing="0" width="80%" id="outputTable" style="margin:0 auto;">
                <tbody> 
                    <tr>
                        <td colspan="3" >项目</td>
                        <td style="width:50%;">内容</td>
                    </tr>
                    <tr>
                        <td colspan="3">作物名称</td>
                        <td><span id="plantName" name="plantName"  ></span></td>
                    </tr>
                    <tr>
                        <td colspan="3">作物品种</td>
                        <td><span id="plantVarieties" name="plantVarieties" ></span></td>
                    </tr>
                    <tr>
                        <td colspan="3">生育期（天）</td>
                        <td><span id="growthStage" name="growthStage" ></span></td>
                    </tr>
                    <tr>
                        <td rowspan="2">大田期</td>
                        <td colspan="2">起始日期</td>
                        <td><span id="fieldStartDate" name="fieldStartDate" ></span></td>
                    </tr>
                    <tr>
                        <td colspan="2">结束日期</td>
                        <td><span id="fieldEndDate" name="fieldEndDate" ></span></td>
                    </tr>
                    <tr>
                        <td rowspan="6" style="width:25%;">作物产量（kg/亩）</td>
                        <td rowspan="2" style="width:12.5%;">长期不施肥区</td>
                        <td>果实</td>
                        <td><span id="longTermNoFruitNum" name="longTermNoFruitNum" ></span></td>
                    </tr>
                    <tr>
                        <td>茎叶</td>
                        <td><span id="longTermNoStemsLeavesNum" name="longTermNoStemsLeavesNum" ></span></td>
                    </tr>
                    <tr>
                        <td rowspan="2">当季不施肥区</td>
                        <td>果实</td>
                        <td><span id="seasonNoFruitNum" name="seasonNoFruitNum" ></span></td>
                    </tr>
                    <tr>
                        <td>茎叶</td>
                        <td><span id="seasonNoStemsLeavesNum" name="seasonNoStemsLeavesNum" ></span></td>
                    </tr>
                    <tr>
                        <td rowspan="2">常规施肥区</td>
                        <td>果实</td>
                        <td><span id="fertilizerFruitNum" name="fertilizerFruitNum" ></span></td>
                    </tr>
                    <tr>
                        <td>茎叶</td>
                        <td><span id="fertilizerStemsLeavesNum" name="fertilizerStemsLeavesNum" ></span></td>
                    </tr>
                    <tr>
                        <td class="w-borderTop" colspan="3">项目</td>
                        <td class="w-borderTop">内容</td>
                    </tr>
                    <tr>
                        <td rowspan="6">施肥折纯量（kg/亩）</td>
                        <td rowspan="3">有机肥</td>
                        <td>N</td>
                        <td><span id="organicFertilizerNNum" name="organicFertilizerNNum" ></span></td>
                    </tr>
                    <tr>
                        <td>P<sub>2</sub>O<sub>5</sub></td>
                        <td><span id="organicFertilizerP2o5Num" name="organicFertilizerP2o5Num" ></span></td>
                    </tr>
                    <tr>
                        <td>K<sub>2</sub>O</td>
                        <td><span id="organicFertilizerK2oNum" name="organicFertilizerK2oNum" ></span></td>
                    </tr>
                    <tr>
                        <td rowspan="3">化肥</td>
                        <td>N</td>
                        <td><span id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" ></span></td>
                    </tr>
                    <tr>
                        <td>P<sub>2</sub>O<sub>5</sub></td>
                        <td><span id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" ></span></td>
                    </tr>
                    <tr>
                        <td>K<sub>2</sub>O</td>
                        <td><span id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" ></span></td>
                    </tr>
                </tbody>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="80%;" style="margin:10px auto;margin-bottom:20px;" >
                <tr>
                    <td  style="text-align:center;width:50%;">填表日期：<span id="fillFormDate" name="fillFormDate"  ></span></td>
                    <td  style="text-align:center;width:50%;">填表人员：<span id="fillFormUserName" name="fillFormUserName" ></span></td>
                </tr>
            </table>
        </form>
    </body>
</html>
