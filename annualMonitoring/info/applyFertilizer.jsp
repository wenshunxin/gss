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
            
        </style>
        <script type="text/javascript">
            $(function(){
                $(".inputDate").datetimepicker({
                    language:"zh-CN",   
                    minView:"month",
                    format:"yyyy-mm-dd",
                    todayBtn: true,
                    todayHighlight : true,  
                    autoclose: true,
                    disable:true,
                    initialDate :new Date(),
                });
               
                $(" #fillFormDate").datetimepicker({
                    language:"zh-CN",   
                    minView:"month",
                    format:"yyyy-mm-dd",
                    todayBtn: true,
                    todayHighlight : true,  
                    autoclose: true,
                    editable:false,
                    pickerPosition: "top-right",
                    initialDate :new Date(),
                });
                // 选择年份
                $("#monitorYear").change(function(){
                    $("#form1").find("input").val("");//清空input内容
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
                     $("#form1").find("input").val("");
                }else{
                    for(var i = 0 ;i<json.rtData.length;i++){
                        var date=json.rtData[i].fertilizerDate;
                        var fillFormDate=json.rtData[i].fillFormDate;
                        for(var key in json.rtData[0]){
                            if(key=="fertilizerDate"){
                                $("input[name="+key+"]").eq(i).val(formatDate(date))
                            }else if(key=="fillFormDate"){
                                $("input[name="+key+"]").eq(i).val(formatDate(fillFormDate))
                            }else{
                                $("input[name="+key+"]").eq(i).val(json.rtData[i][key])
                            }
                        };
                    }  
                }
            }
            /*
                上报数据保存
            */ 
			function save(){
                if($("#form1").form("validate")){
                    var param = $("#form1").serializeJson();
                    // console.log(param);
                    var monitorYear = $("#monitorYear").val();
                    // console.log(monitorYear)
                    var url =contextPath+"/fertilizerInfoController/saveFertilizerInfo.act?stationSid=<%=sid%>&stationCode=<%=stationCode%>&monitorYear="+monitorYear;
                    $.ajax({
                            url: url,
                            type: "POST",
                            contentType : 'application/json;charset=utf-8', //设置请求头信息
                            dataType:"json",
                            data: param,
                            success: function(data){
                            var json = data;
                            if(json.rtState){
                                    top.$.jBox.tip(json.rtMsg,"success");
                                    location.reload();
                                }else{
                                    top.$.jBox.tip("系统异常！","error");
                                }
                            },
                            error: function(res){
                                top.$.jBox.tip("系统异常！","error");
                            }
		            });
                }
			}

            /*
                时间戳转化为日期 2017-10-10
            */ 
            function formatDate(nows) { 
                if(nows==null || nows=="" || nows==undefined){
                    return ""
                }
                var now=new Date(nows); 
                var year=now.getFullYear(); 
                var month=(now.getMonth()+1)<10?"0"+(now.getMonth()+1):now.getMonth()+1; 
                var date=now.getDate()<10?"0"+now.getDate():now.getDate(); 
                return year+"-"+month+"-"+date; 
            }
		</script>
    </head>
    <body onload="onload()" style="overflow-y:auto;overflow-x:auto;">
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
                <td ><img onclick="save()" style="cursor:pointer;" src="<%=contextPath %>/resource/images/sys/save.png" alt="保存" title="保存"></td>
            </tr>
        </table>
        <form id="form1" >
            <table border="0" cellpadding="0" cellspacing="0" id="applyTable">
                <tbody>
                    <tr>
                        <td rowspan="3" style="width:40px;">施肥日期</td>
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
                        <td><input type="text" id="fertilizerDate"  name="fertilizerDate" class="SmallInputt inputDate easyui-validatebox" readonly="readonly"></td>
                        <td><input type="text" id="organicFertilizerTypeName"  name="organicFertilizerTypeName"  class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="organicFertilizerNNum"  name="organicFertilizerNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerNum" name="organicFertilizerNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeNum" name="chemicalFertilizeNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                    </tr>
                    <tr>
                        <td><input type="text" id="fertilizerDate"  name="fertilizerDate" class="SmallInputt inputDate easyui-validatebox" readonly="readonly"></td>
                        <td><input type="text" id="organicFertilizerTypeName"  name="organicFertilizerTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="organicFertilizerNNum"  name="organicFertilizerNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerNum" name="organicFertilizerNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeNum" name="chemicalFertilizeNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                    </tr>
                    <tr>
                       <td><input type="text" id="fertilizerDate"  name="fertilizerDate" class="SmallInputt inputDate easyui-validatebox" readonly="readonly"></td>
                        <td><input type="text" id="organicFertilizerTypeName"  name="organicFertilizerTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="organicFertilizerNNum"  name="organicFertilizerNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerNum" name="organicFertilizerNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeNum" name="chemicalFertilizeNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                    </tr>
                    <tr>
                        <td><input type="text" id="fertilizerDate"  name="fertilizerDate" class="SmallInputt inputDate easyui-validatebox" readonly="readonly"></td>
                        <td><input type="text" id="organicFertilizerTypeName"  name="organicFertilizerTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="organicFertilizerNNum"  name="organicFertilizerNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerNum" name="organicFertilizerNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeNum" name="chemicalFertilizeNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                    </tr>
                    <tr>
                      <td><input type="text" id="fertilizerDate"  name="fertilizerDate" class="SmallInputt inputDate easyui-validatebox" readonly="readonly"></td>
                        <td><input type="text" id="organicFertilizerTypeName"  name="organicFertilizerTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="organicFertilizerNNum"  name="organicFertilizerNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerNum" name="organicFertilizerNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeNum" name="chemicalFertilizeNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                    </tr>
                    <tr>
                       <td><input type="text" id="fertilizerDate"  name="fertilizerDate" class="SmallInputt inputDate easyui-validatebox" readonly="readonly"></td>
                        <td><input type="text" id="organicFertilizerTypeName"  name="organicFertilizerTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="organicFertilizerNNum"  name="organicFertilizerNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerP2o5Num"  name="organicFertilizerP2o5Num"  class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerK2oNum"  name="organicFertilizerK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="organicFertilizerNum" name="organicFertilizerNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeTypeName" name="chemicalFertilizeTypeName" class="SmallInputt easyui-validatebox" maxlength="50"></td>
                        <td><input type="text" id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                        <td><input type="text" id="chemicalFertilizeNum" name="chemicalFertilizeNum" class="SmallInputt easyui-validatebox" validType="number"></td>
                    </tr>
                </tbody>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%;" style="margin-top:20px;" class="">
                <tr>
                    <td  style="text-align:center;width:50%;">填表日期：<input type="text" id="fillFormDate" name="fillFormDate" class="BigInput easyui-validatebox" readonly="readonly" /></td>
                    <td  style="text-align:center;width:50%;">填表人员：<input type="text" id="fillFormUserName" name="fillFormUserName" class="BigInput" maxlength="50"/></td>
                </tr>
            </table>
        </form>
        <div style="height:10px;"></div>
    </body>
</html>
