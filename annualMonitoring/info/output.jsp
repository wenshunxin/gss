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
                padding:0 25px 0 20px;
            }
        </style>
        <script>
            $(function(){
                $("#fieldStartDate,#fieldEndDate").datetimepicker({
                    language:"zh-CN",   
                    minView:"month",
                    format:"yyyy-mm-dd",
                    todayBtn: true,
                    todayHighlight : true,  
                    autoclose: true,
                    initialDate :new Date(),
                });

                $(" #fillFormDate").datetimepicker({
                    language:"zh-CN",   
                    minView:"month",
                    format:"yyyy-mm-dd",
                    todayBtn: true,
                    todayHighlight : true,  
                    autoclose: true,
                    pickerPosition: "top-right",
                    initialDate :new Date(),
                });
                $("#monitorYear").change(function(){
                    $("#form1").find("input").val("");
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
            /*ss
             *  表单提交
            */ 
            function save(){
                if($("#form1").form("validate")){
                    var param=tools.formToJson($("#form1"));
                    // console.log(param)
                    var monitorYear = $("#monitorYear").val();
                    var sid=$("#sid").val();
                    var url;
                    if(sid==""||sid==null){
                        url = contextPath+"/yieldFertilizerController/saveYieldFertilizerSummary.act?stationSid=<%=sid%>&stationCode=<%=stationCode%>&monitorYear="+monitorYear;
                    }else{
                        url = contextPath+"/yieldFertilizerController/updateYieldFertilizerSummary.act?stationSid=<%=sid%>&stationCode=<%=stationCode%>&monitorYear="+monitorYear;
                    }
                    var json = tools.requestJsonRs(url,param);
                    if(json.rtState){
                        top.$.jBox.tip(json.rtMsg,"success");
                        location.reload();
                    }else{
                        top.$.jBox.tip("系统异常！","error");
                    }
                }
            }
        </script>
    </head>
    <body style="overflow-y:auto;margin-bottom:20px;" onload="onload()">
        <table border="0" cellpadding="0" cellspacing="0" id="w-tableHead" width="80%" style="height:35px;line-height:35px;margin:0 auto;">
            <tr>
                <td width="33.3%">监测点代码：<span><%=stationCode%></span></td>
                <td width="33.3%">检测年度：
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
                <td width="33.3%" style="padding-right:0px;"><img style="cursor:pointer;"  src="<%=contextPath %>/resource/images/sys/save.png" alt="保存" title="保存" onclick="save()"></td>
            </tr>
        </table>
        <form id="form1">
            <table border="0" cellpadding="0"  cellspacing="0" width="80%" id="outputTable" style="margin:0 auto;">
                <tbody> 
                    <tr>
                        
                        <td colspan="3" >项目</td>
                        <td style="width:50%;">内容</td>
                    </tr>
                    <tr>
                        <td colspan="3">作物名称</td>
                        <td><input type="text" id="plantName" name="plantName" class="BigInputt easyui-validatebox" maxlength="50"></td>
                    </tr>
                    <tr>
                        <td colspan="3">作物品种</td>
                        <td><input type="text" id="plantVarieties" name="plantVarieties" class="BigInputt easyui-validatebox" maxlength="50"></td>
                    </tr>
                    <tr>
                        <td colspan="3">生育期（天）</td>
                        <td><input type="text" id="growthStage" name="growthStage" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td rowspan="2">大田期</td>
                        <td colspan="2">起始日期</td>
                        <td><input type="text" id="fieldStartDate" name="fieldStartDate" class="BigInputt easyui-validatebox" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td colspan="2">结束日期</td>
                        <td><input type="text" id="fieldEndDate" name="fieldEndDate" class="BigInputt easyui-validatebox" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td rowspan="6" style="width:25%;">作物产量（kg/亩）</td>
                        <td rowspan="2" style="width:12.5%;">长期不施肥区</td>
                        <td>果实</td>
                        <td><input type="text" id="longTermNoFruitNum" name="longTermNoFruitNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td>茎叶</td>
                        <td><input type="text" id="longTermNoStemsLeavesNum" name="longTermNoStemsLeavesNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td rowspan="2">当季不施肥区</td>
                        <td>果实</td>
                        <td><input type="text" id="seasonNoFruitNum" name="seasonNoFruitNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td>茎叶</td>
                        <td><input type="text" id="seasonNoStemsLeavesNum" name="seasonNoStemsLeavesNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td rowspan="2">常规施肥区</td>
                        <td>果实</td>
                        <td><input type="text" id="fertilizerFruitNum" name="fertilizerFruitNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td>茎叶</td>
                        <td><input type="text" id="fertilizerStemsLeavesNum" name="fertilizerStemsLeavesNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td class="w-borderTop" colspan="3">项目</td>
                        <td class="w-borderTop">内容</td>
                    </tr>
                    <tr>
                        <td rowspan="6">施肥折纯量（kg/亩）</td>
                        <td rowspan="3">有机肥</td>
                        <td>N</td>
                        <td><input type="text" id="organicFertilizerNNum" name="organicFertilizerNNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td>P<sub>2</sub>O<sub>5</sub></td>
                        <td><input type="text" id="organicFertilizerP2o5Num" name="organicFertilizerP2o5Num" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td>K<sub>2</sub>O</td>
                        <td><input type="text" id="organicFertilizerK2oNum" name="organicFertilizerK2oNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td rowspan="3">化肥</td>
                        <td>N</td>
                        <td><input type="text" id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td>P<sub>2</sub>O<sub>5</sub></td>
                        <td><input type="text" id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                    <tr>
                        <td>K<sub>2</sub>O</td>
                        <td><input type="text" id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" class="BigInputt easyui-validatebox" validType="number[]"></td>
                    </tr>
                </tbody>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="80%;" style="margin:10px auto;" class="">
                <tr>
                    <td  style="text-align:center;width:50%;">填表日期：<input type="text" id="fillFormDate" name="fillFormDate" class="BigInput easyui-validatebox" readonly="readonly" /></td>
                    <td  style="text-align:center;width:50%;">填表人员：<input type="text" id="fillFormUserName" name="fillFormUserName" class="BigInput" maxlength="50"/></td>
                </tr>
            </table>
            <input type="hidden" id="sid" name="sid"/>
        </form>
    </body>
</html>
