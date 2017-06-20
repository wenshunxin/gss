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
        <%-- 年度监测 --%>
        <style media="screen">
            body,
            html {
                height: 100%;
                padding:0 25px 0 20px;
            }

        </style>
         <script>
            $(function(){
                $("#testingStartDate,#testingEndDate,#samplingDate").datetimepicker({
                    language:"zh-CN",   
                    minView:"month",
                    format:"yyyy-mm-dd",
                    todayBtn: true,
                    todayHighlight : true,  
                    autoclose: true,
                    initialDate :new Date(),
                });
                $(".inputDate").datetimepicker({
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
                    $("#form1").find("input:not('.hidden')").val("");
                    onload();
                })
            });

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
                // console.log(param)
                var url =contextPath+"/soilYearCharacterController/getSoilYearCharacter.act";
				var json = tools.requestJsonRs(url,param);
                // console.log( json)
                if(json.rtData.length==0){
                    $("#form1").find("input:not('.hidden')").val("");
                }else{
                    for(var i = 0 ;i<json.rtData.length;i++){
                        var date=json.rtData[i].samplingDate;
                        for(var key in json.rtData[0]){
                            if(key=="samplingDate"){
                                $("input[name="+key+"]").eq(i).val(formatDate(date))
                            }else{
                                $("input[name="+key+"]").eq(i).val(json.rtData[i][key])
                            } 
                        } 
                    }  
                }
            }
            /*
                表单提交数据
            */ 
            function save(){
                if($("#form1").form("validate")){
                    //表单提交数据
                    var param = $("#form1").serializeJson();
                    // console.log(monitorYear)
                    var monitorYear = $("#monitorYear").val();
                    // console.log(monitorYear)
                    var url =contextPath+"/soilYearCharacterController/saveSoilYearCharacter.act?stationSid=<%=sid%>&stationCode=<%=stationCode%>"+"&monitorYear="+monitorYear;
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
                var now=new Date(nows); 
                var year=now.getFullYear(); 
                var month=(now.getMonth()+1)<10?"0"+(now.getMonth()+1):now.getMonth()+1; 
                var date=now.getDate()<10?"0"+now.getDate():now.getDate(); 
                return year+"-"+month+"-"+date; 
            }
        </script>
    </head>
    <body style="overflow-y:auto; overflow-x:auto;"  onload="onload()">
        
    <form id="form1">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:40px;line-height:40px;border-bottom:0;" class="soilPhysicalTop"> 
            <tr>
                <td style="text-align:center;width:90%;">检测时间：<input id="testingStartDate" name="testingStartDate" type="text" class="BigInput easyui-validatebox" readonly="readonly"  id="startannual"/>至<input id="testingEndDate" name="testingEndDate" type="text" class="BigInput easyui-validatebox" readonly="readonly" /></td>
                <td style="text-align:right;width:10%;"><img style="cursor:pointer;"  src="<%=contextPath %>/resource/images/sys/save.png" alt="保存" title="保存" onclick="save()"></td>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" width="100%"  class="soilPhysical "> 
             <tbody>
             <tr>
                  <td colspan="2" class="tdright" >监测点代码：</td>
                  <td colspan="3" class="tdRight"><span><%=stationCode%></span></td>
                  <td colspan="3" class="tdright" >监测年度：</td>
                  <td colspan="3" class="tdRight">
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
              <tr>
                  <td colspan="2"  class="tdright">采样地点：</td>
                  <td colspan="3" class="tdRight"><input type="text" class="SmallInputpp SmallInputppp easyui-validatebox" id="samplingAddress" name="samplingAddress" maxlength="50"/></td>
                  <td colspan="3"  class="tdright" >采样时间：</td>
                  <td colspan="3" class="tdRight"><input type="text" class="SmallInputppData SmallInputpp easyui-validatebox"   id="samplingDate" name="samplingDate" readonly="readonly" /></td>
              </tr>
                    <tr>
                        <td colspan="11">每年度最后一季作物收获后、下季作物施肥前，采土测定并记载</td>
                    </tr>
                    <tr>
                        <td class="tdWidth"><div>处理</div></td>
                        <td>耕层厚度（cm）</td>
                        <td>容重(g/cm3)</td>
                        <td>pH</td>
                        <td>有机质（g/kg）</td>
                        <td>全氮（g/kg）</td>
                        <td>有效磷（mg/kg）</td>
                        <td>速效钾（mg/kg）</td>
                        <td>缓效钾（mg/kg）</td>
                        <td style="color:red;">土壤微生物总量</td>
                        <td style="color:red;">土壤脲酶活性</td>
                    </tr>
                    <tr>
                        <td>长期不施肥 <input type="hidden" id="dealType" class="hidden" name="dealType" value="1"></td>
                        <td><input type="text" id="topsoilDepth" name="topsoilDepth" class="SmallInputp inputLeft easyui-validatebox"   /></td>
                        <td><input type="text" id="bulkDensity" name="bulkDensity" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="ph" name="ph" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="organicMatterContent" name="organicMatterContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="nContent" name="nContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="effectiveKContent" name="effectiveKContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="quickActingKContent" name="quickActingKContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="slowActingKContent" name="slowActingKContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="microorganism" name="microorganism" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="ureaseActivity" name="ureaseActivity" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                    </tr>
                    <tr>
                        <td>当季不施肥区<input type="hidden" id="dealType" class="hidden" name="dealType" value="2"></td>
                         <td><input type="text" id="topsoilDepth" name="topsoilDepth" class="SmallInputp inputLeft easyui-validatebox"   /></td>
                        <td><input type="text" id="bulkDensity" name="bulkDensity" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="ph" name="ph" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="organicMatterContent" name="organicMatterContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="nContent" name="nContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="effectiveKContent" name="effectiveKContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="quickActingKContent" name="quickActingKContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="slowActingKContent" name="slowActingKContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="microorganism" name="microorganism" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="ureaseActivity" name="ureaseActivity" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                    </tr>
                    <tr>
                        <td>常规施肥区<input type="hidden" id="dealType" class="hidden" name="dealType" value="3"></td>
                          <td><input type="text" id="topsoilDepth" name="topsoilDepth" class="SmallInputp inputLeft easyui-validatebox"   /></td>
                        <td><input type="text" id="bulkDensity" name="bulkDensity" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="ph" name="ph" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="organicMatterContent" name="organicMatterContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="nContent" name="nContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="effectiveKContent" name="effectiveKContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="quickActingKContent" name="quickActingKContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="slowActingKContent" name="slowActingKContent" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="microorganism" name="microorganism" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="ureaseActivity" name="ureaseActivity" class="SmallInputp inputLeft easyui-validatebox" validType="number"/></td>
                    </tr>
                </tbody>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="soilPhysicallbottom" style="margin-top:20px;">
                <tr>
                    <td colspan="3" class="ddright">检验单位：</td>
                    <td colspan="3" class="ddleft"><input type="text" class="BigInput" id="testCompany" name="testCompany" maxlength="50"></td>
                </tr>
                <tr>
                    <td class="ddright">批准人：</td>
                    <td class="ddleft"><input type="text" class="BigInput bottom" id="approvalUserName" name="approvalUserName" maxlength="50"></td>
                    <td class="ddright">审核人：</td>
                    <td class="ddleft"><input type="text" class="BigInput bottom" id="examineUserName" name="examineUserName" maxlength="50"></td>
                    <td class="ddright">编制人：</td>
                    <td class="ddleft"><input type="text" class="BigInput bottom" id="formationUserName" name="formationUserName" maxlength="50"></td>
                </tr>
                <tr>
                    <td class="ddright">日期：</td>
                    <td class="ddleft"><input type="text" class="BigInput bottom inputDate easyui-validatebox" readonly="readonly" id="approvalDate" name="approvalDate"></td>
                    <td class="ddright">日期：</td>
                    <td class="ddleft"><input type="text" class="BigInput bottom inputDate easyui-validatebox" readonly="readonly" id="examineDate" name="examineDate"></td>
                    <td class="ddright">日期：</td>
                    <td class="ddleft"><input type="text" class="BigInput bottom inputDate easyui-validatebox" readonly="readonly" id="formationDate" name="formationDate"></td>
                </tr>
            </table>
        </form>
        <div style="height:10px;"></div>
    </body>
</html>
