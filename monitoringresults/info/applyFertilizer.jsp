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
            /*body,
            html {
                /*height:100%;
                width: 100%;
            }*/
            
        </style>
        <script type="text/javascript">
            $(function(){
                $("#monitorYear").change(function(){
                    $("#form1").find("span").html("");
                    onload();
                })
            })
            /*
                展示数据
            */ 
            function onload(){
                var monitorYear = $("#monitorYear").val();
                // console.log(monitorYear)
                var param={
                    "stationSid":"<%=sid%>",
                    "monitorYear":monitorYear
                }
                var url =contextPath+"/fertilizerInfoController/getFertilizerInfo.act";
				var json = tools.requestJsonRs(url,param);
                // console.log( json.rtData)
                if(json.rtData.length==0){
                    $("#form1").find("span").html("")
                }else{
                    for(var i = 0 ;i<json.rtData.length;i++){
                        var date=json.rtData[i].fertilizerDate;
                        var fillFormDate=json.rtData[i].fillFormDate;
                        // console.log(fillFormDate)
                        for(var key in json.rtData[0]){
                            if(key=="fertilizerDate"){
                                $("span[name="+key+"]").eq(i).html(formatDate(date))
                            }else if(key=="fillFormDate"){
                                $("span[name=fillFormDate]").eq(i).html(formatDate(fillFormDate))
                            }else{
                                $("span[name="+key+"]").eq(i).html(json.rtData[i][key])
                            } 
                        };
                    }  
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
        <table border="0" cellpadding="0" cellspacing="0" id="w-tableHead" width="100%" style="height:35px;line-height:35px;">
            <tr>
                <td>监测点代码：<span id="stationCode"><%=stationCode%></span></td>
                <td>检测年度：
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
                <td ></td>
            </tr>
        </table>
        <form id="form1" >
            <table border="0" cellpadding="0" cellspacing="0" id="applyTable">
                <tbody>
                    <tr>
                        <td rowspan="3" class="tdWidth"><div>施肥日期</div></td>
                        <td colspan="5">有机肥</td>
                        <td colspan="5">化肥</td>
                    </tr>
                    <tr> 
                        <td rowspan="2">品种</td>
                        <td colspan="3">养分含量（%）</td>
                        <td rowspan="2">实物量（kg/亩）</td>
                        <td rowspan="2">品种</td>
                        <td colspan="3">养分含量（%）</td>
                        <td rowspan="2">实物量（kg/亩）</td>
                    </tr>
                    <tr>
                        <td>N</td>
                        <td>P<sub>2</sub>O<sub>5</sub></td>
                        <td>K<sub>2</sub>O</td>
                        <td>N</td>
                        <td>P<sub>2</sub>O<sub>5</sub></td>
                        <td>K<sub>2</sub>O</td>
                    </tr>
                    <tr>
                        <td><span id="fertilizerDate"  name="fertilizerDate" ></span></td>
                        <td><span id="organicFertilizerTypeName"  name="organicFertilizerTypeName" ></span></td>
                        <td><span id="organicFertilizerNNum"  name="organicFertilizerNNum" ></span></td>
                        <td><span id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  ></span></td>
                        <td><span id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" ></span></td>
                        <td><span id="organicFertilizerNum" name="organicFertilizerNum" ></span></td>
                        <td><span id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" ></span></td>
                        <td><span id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" ></span></td>
                        <td><span id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" ></span></td>
                        <td><span id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" ></span></td>
                        <td><span id="chemicalFertilizeNum" name="chemicalFertilizeNum" ></span></td>
                    </tr>
                    <tr>
                        <td><span id="fertilizerDate"  name="fertilizerDate" ></span></td>
                        <td><span id="organicFertilizerTypeName"  name="organicFertilizerTypeName" ></span></td>
                        <td><span id="organicFertilizerNNum"  name="organicFertilizerNNum" ></span></td>
                        <td><span id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  ></span></td>
                        <td><span id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" ></span></td>
                        <td><span id="organicFertilizerNum" name="organicFertilizerNum" ></span></td>
                        <td><span id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" ></span></td>
                        <td><span id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" ></span></td>
                        <td><span id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" ></span></td>
                        <td><span id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" ></span></td>
                        <td><span id="chemicalFertilizeNum" name="chemicalFertilizeNum" ></span></td>
                    </tr>
                    <tr>
                        <td><span id="fertilizerDate"  name="fertilizerDate" ></span></td>
                        <td><span id="organicFertilizerTypeName"  name="organicFertilizerTypeName" ></span></td>
                        <td><span id="organicFertilizerNNum"  name="organicFertilizerNNum" ></span></td>
                        <td><span id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  ></span></td>
                        <td><span id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" ></span></td>
                        <td><span id="organicFertilizerNum" name="organicFertilizerNum" ></span></td>
                        <td><span id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" ></span></td>
                        <td><span id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" ></span></td>
                        <td><span id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" ></span></td>
                        <td><span id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" ></span></td>
                        <td><span id="chemicalFertilizeNum" name="chemicalFertilizeNum" ></span></td>
                    </tr>
                    <tr>
                          <td><span id="fertilizerDate"  name="fertilizerDate" ></span></td>
                        <td><span id="organicFertilizerTypeName"  name="organicFertilizerTypeName" ></span></td>
                        <td><span id="organicFertilizerNNum"  name="organicFertilizerNNum" ></span></td>
                        <td><span id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  ></span></td>
                        <td><span id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" ></span></td>
                        <td><span id="organicFertilizerNum" name="organicFertilizerNum" ></span></td>
                        <td><span id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" ></span></td>
                        <td><span id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" ></span></td>
                        <td><span id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" ></span></td>
                        <td><span id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" ></span></td>
                        <td><span id="chemicalFertilizeNum" name="chemicalFertilizeNum" ></span></td>
                    </tr>
                    <tr>
                       <td><span id="fertilizerDate"  name="fertilizerDate" ></span></td>
                        <td><span id="organicFertilizerTypeName"  name="organicFertilizerTypeName" ></span></td>
                        <td><span id="organicFertilizerNNum"  name="organicFertilizerNNum" ></span></td>
                        <td><span id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  ></span></td>
                        <td><span id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" ></span></td>
                        <td><span id="organicFertilizerNum" name="organicFertilizerNum" ></span></td>
                        <td><span id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" ></span></td>
                        <td><span id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" ></span></td>
                        <td><span id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" ></span></td>
                        <td><span id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" ></span></td>
                        <td><span id="chemicalFertilizeNum" name="chemicalFertilizeNum" ></span></td>
                    </tr>
                    <tr>
                       <td><span id="fertilizerDate"  name="fertilizerDate" ></span></td>
                        <td><span id="organicFertilizerTypeName"  name="organicFertilizerTypeName" ></span></td>
                        <td><span id="organicFertilizerNNum"  name="organicFertilizerNNum" ></span></td>
                        <td><span id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  ></span></td>
                        <td><span id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" ></span></td>
                        <td><span id="organicFertilizerNum" name="organicFertilizerNum" ></span></td>
                        <td><span id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" ></span></td>
                        <td><span id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" ></span></td>
                        <td><span id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" ></span></td>
                        <td><span id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" ></span></td>
                        <td><span id="chemicalFertilizeNum" name="chemicalFertilizeNum" ></span></td>
                    </tr>
                </tbody>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%;" style="margin:10px 0 20px 0;">
                <tr>
                    <td  style="text-align:center;width:50%;">填表日期：<span id="fillFormDate" name="fillFormDate" ></span></td>
                    <td  style="text-align:center;width:50%;">填表人员：<span id="fillFormUserName" name="fillFormUserName"></span></td>
                </tr>
            </table>
        </form>
    </body>
</html>
