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
                /*width: 100%;*/
                padding:0 25px 0 20px;
            }
            
        </style>
        <script>
            $(function(){
                $("#samplingDate,#testingStartDate,#testingEndDate").datetimepicker({
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
                // console.log(param)
                var url =contextPath+"/soil5yearCharacterController/getSoil5yearCharacter.act";
				var json = tools.requestJsonRs(url,param);
                // console.log( json)
                if(json.rtData.length==0){
                    $("#form1").find("input:not('.hidden')").val("")
                }else{
                    for(var i = 0 ;i<json.rtData.length;i++){
                        // var date=json.rtData[i].fertilizerDate;
                        for(var key in json.rtData[0]){
                            $("input[name="+key+"]").eq(i).val(json.rtData[i][key])
                        } 
                    }  
                }
            }

            /*
                数据提交函数
            */ 
            function save(){
                if($("#form1").form("validate")){
                    var param = $("#form1").serializeJson();
                    var monitorYear=$("#monitorYear").val();
                    var url =contextPath+"/soil5yearCharacterController/saveSoil5yearCharacter.act?stationSid=<%=sid%>&stationCode=<%=stationCode%>"+"&monitorYear="+monitorYear;
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
        </script>
    </head>
    <body style="overflow-y:auto;margin-bottom:20px;overflow-x:auto;" onload="onload()">
        <div class="w-head">
                <!--<span onclick="CheckPointsList()" style="cursor:pointer">监测点列表</span>
                >
                <span>监测点1</span>-->
                <ol class="breadcrumb">
                    <li><a href="<%=contextPath %>/fiveYearMonitoring/index.jsp">五年监测点列表</a></li>
                    <li class="active"><%=stationCode%></li>
                </ol>
            </div>
    <form  id="form1" style="width:100%;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:40px;line-height:40px;" class="soilOrganismTop">
            <tr>
                <td style="text-align:center;width:90%;">检测时间：<input type="text" class="BigInput easyui-validatebox" readonly="readonly"  id="testingStartDate" name="testingStartDate"/>至<input type="text" class="BigInput easyui-validatebox" readonly="readonly"  id="testingEndDate" name="testingEndDate"/></td>
                <td style="text-align:right;width:10%;"><img style="cursor:pointer;"  src="<%=contextPath %>/resource/images/sys/save.png" alt="保存" title="保存" onclick="save()"></td>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="soilOrganism">
            <tbody>
            <tr>
                <td colspan="3" class="tdright">监测点代码：</td>
                <td colspan="3" align="left" class="tdRight"><%=stationCode%></td>
                <td colspan="4" class="tdright">监测年度：
                <td colspan="5" class="tdRight" >
                    <select  name="monitorYear" class="BigSelect" id="monitorYear">
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
                <td colspan="3"  class="tdright">采样地点：</td>
                <td colspan="3" class="tdRight"><input type="text"  style="text-align: left;" name="samplingAddress" id="samplingAddress" class="SmallInputtt SmallInputttw"/></td>
                <td colspan="4"  class="tdright">采样时间：</td>
                <td colspan="5" class="tdRight" ><input type="text" style="text-align: left;" name="samplingDate" id="samplingDate" class="SmallInputtt SmallInputttt easyui-validatebox" readonly="readonly"  id="annual"/></td>
            </tr>
        <!--</table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="soilOrganism">-->
                
                    
                    <tr>
                        <td colspan="15">五年(或试点结束后)增加监测内容</td>
                    </tr>
                    <tr>
                        <td rowspan="2" class="tdWidth" style="width:100px;"><div>处理</div></td>
                        <td colspan="4">耕层物理性状</td>
                        <td colspan="3">耕层化学性状</td>
                        <td colspan="7">中量元素</td>
                    </tr>
                    <tr>
                        <td>质地（国际制）</td>
                        <td colspan="2">盐分（g/kg）</td>
                        <td style="width:50px;">CEC（cmol/kg）</td>
                        <td>交换性钙（cmol/kg）</td>
                        <td colspan="2">交换性镁（cmol/kg）</td>
                        <td>有效硫（mg/kg）</td>
                        <td colspan="2">有效硅（mg/kg）</td>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td style="width:100px;">长期不肥区<input type="hidden" class="hidden" id="dealType" name="dealType" value="1" /></td>
                       <td><input type="text" id="texture" name="texture" class="SmallInputt easyui-validatebox" maxlength="50"/></td>
                        <td colspan="2"><input type="text" id="salinity" name="salinity" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="cec" name="cec" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="exchangeableCa" name="exchangeableCa" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td colspan="2"><input id="exchangeableMg" name="exchangeableMg" type="text" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="effectiveS" name="effectiveS" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td colspan="2"><input type="text" id="effectiveSi" name="effectiveSi" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td colspan="4"></td>
                     </tr>
                    <tr>
                        <td>当季不施肥区<input type="hidden" class="hidden" id="dealType" name="dealType" value="2" /></td>
                       <td><input type="text" id="texture" name="texture" class="SmallInputt easyui-validatebox" maxlength="50"/></td>
                        <td colspan="2"><input type="text" id="salinity" name="salinity" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="cec" name="cec" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="exchangeableCa" name="exchangeableCa" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td colspan="2"><input id="exchangeableMg" name="exchangeableMg" type="text" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="effectiveS" name="effectiveS" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td colspan="2"><input type="text" id="effectiveSi" name="effectiveSi" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>常规施肥区<input type="hidden" id="dealType" class="hidden" name="dealType" value="3" /></td>
                       <td><input type="text" id="texture" name="texture" class="SmallInputt easyui-validatebox" maxlength="50"/></td>
                        <td colspan="2"><input type="text" id="salinity" name="salinity" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="cec" name="cec" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="exchangeableCa" name="exchangeableCa" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td colspan="2"><input id="exchangeableMg" name="exchangeableMg" type="text" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="effectiveS" name="effectiveS" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td colspan="2"><input type="text" id="effectiveSi" name="effectiveSi" class="SmallInputt easyui-validatebox" validType="number"/></td>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td rowspan="2">处理</td>
                        <td colspan="2">全量元素（g/kg）</td>
                        <td colspan="6">有效性微量元素（mg/kg）</td>
                        <td colspan="6">土壤环境质量（mg/kg）</td>
                    </tr>
                    <tr>
                        <td>全磷</td>
                        <td>全钾</td>
                        <td>铁</td>
                        <td>锰</td>
                        <td>铜</td>
                        <td>锌</td>
                        <td>硼</td>
                        <td>钼</td>
                        <td>铬</td>
                        <td>镉</td>
                        <td>铅</td>
                        <td>砷</td>
                        <td>汞</td>
                        <td>镍</td>
                    </tr>
                    <tr>
                        <td>长期不肥区 </td>
                        <td><input type="text" id="pContent" name="pContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="kContent" name="kContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="feContent" name="feContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="mnContent" name="mnContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="cuContent" name="cuContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="znContent" name="znContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="bContent" name="bContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="moContent" name="moContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="crContent" name="crContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="cdContent" name="cdContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="pbContent" name="pbContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="asContent" name="asContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="hgContent" name="hgContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="snContent" name="snContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                    </tr>
                    <tr>
                        <td>当季不施肥区</td>
                        <td><input type="text" id="pContent" name="pContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="kContent" name="kContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="feContent" name="feContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="mnContent" name="mnContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="cuContent" name="cuContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="znContent" name="znContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="bContent" name="bContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="moContent" name="moContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="crContent" name="crContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="cdContent" name="cdContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="pbContent" name="pbContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="asContent" name="asContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="hgContent" name="hgContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="snContent" name="snContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                    </tr>
                    <tr>
                        <td>常规施肥区</td>
                        <td><input type="text" id="pContent" name="pContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="kContent" name="kContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="feContent" name="feContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="mnContent" name="mnContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="cuContent" name="cuContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="znContent" name="znContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="bContent" name="bContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="moContent" name="moContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="crContent" name="crContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="cdContent" name="cdContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="pbContent" name="pbContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="asContent" name="asContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="hgContent" name="hgContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
                        <td><input type="text" id="snContent" name="snContent" class="SmallInputt  easyui-validatebox" validType="number"/></td>
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
