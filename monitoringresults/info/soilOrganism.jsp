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
            }
        </style>
        <script>
           $(function(){
                $("#monitorYear").change(function(){
                    $("#form1").find("span").text("");
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
                    $("#form1").find("span").text("")
                }else{
                    for(var i = 0 ;i<json.rtData.length;i++){
                        var date=json.rtData[i].samplingDate;
                        for(var key in json.rtData[0]){
                            // console.log(key)
                            if(json.rtData[i][key]==null){
                                json.rtData[i][key]=""
                            }
                            if(key=="samplingDate"){
                                $("span[name="+key+"]").eq(i).text(formatDate(date))
                            }else{
                                $("span[name="+key+"]").eq(i).text(json.rtData[i][key])
                            }
                            
                        }
                    }  
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
    <body style="overflow-y:auto;overflow-x:auto;padding:0 20px;" onload="onload()">
        <form  id="form1" style="width:100%;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:40px;line-height:40px;">
            <tr>
                <td style="text-align:center;">检测时间：<span  id="testingStartDate" name="testingStartDate"></span>至<span  id="testingEndDate" name="testingEndDate"></span></td>
            </tr>
        </table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="soilOrganism">
                <tbody>
                    <tr>
                        <td colspan="3" class="tdleft" >监测点代码：</td>
                        <td colspan="3" class="tdLeft"><%=stationCode%></td>
                        <td colspan="4" class="tdleft" >监测年度：
                        <td colspan="5" class="tdLeft" >
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
                        <td colspan="3" class="tdleft" >采样地点：</td>
                        <td colspan="3" class="tdLeft" ><span  id="samplingAddress" name="samplingAddress"></span></td>
                        <td colspan="4" class="tdleft" >采样时间：</td>
                        <td colspan="5" class="tdLeft" ><span   id="samplingDate" name="samplingDate"></span></td>
                    </tr>
                    <tr>
                        <td colspan="15">五年(或试点结束后)增加监测内容</td>
                    </tr>
                    <tr>
                        <td rowspan="2" class="tdWidth"><div>处理</div></td>
                        <td colspan="4">耕层物理性状</td>
                        <td colspan="3">耕层化学性状</td>
                        <td colspan="7">中量元素</td>
                    </tr>
                    <tr>
                        <td>质地（国际制）</td>
                        <td colspan="2">盐分（g/kg）</td>
                        <td style="width:50px;">CEC（cmol/kg）</td>
                        <td>交换性钙cmol/kg</td>
                        <td colspan="2">交换性镁（cmol/kg）</td>
                        <td>有效硫（mg/kg）</td>
                        <td colspan="2">有效硅（mg/kg）</td>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>长期不肥区<input type="hidden" id="dealType" name="dealType" value="1"></td>
                        <td><span id="texture" name="texture" ></span></td>
                        <td colspan="2"><span id="salinity" name="salinity" ></span></td>
                        <td><span id="cec" name="cec" ></span></td>
                        <td><span id="exchangeableCa" name="exchangeableCa" ></span></td>
                        <td colspan="2"><span id="exchangeableMg" name="exchangeableMg"  ></span></td>
                        <td><span id="effectiveS" name="effectiveS" ></span></td>
                        <td colspan="2"><span id="effectiveSi" name="effectiveSi" ></span></td>
                        <td colspan="4"><span class="BigInput"></span></td>
                    </tr>
                    <tr>
                        <td>当季不施肥区<input type="hidden" id="dealType" name="dealType" value="2"></td>
                        <td><span id="texture" name="texture" ></span></td>
                        <td colspan="2"><span id="salinity" name="salinity" ></span></td>
                        <td><span id="cec" name="cec" ></span></td>
                        <td><span id="exchangeableCa" name="exchangeableCa" ></span></td>
                        <td colspan="2"><span id="exchangeableMg" name="exchangeableMg" ></span></td>
                        <td><span id="effectiveS" name="effectiveS" ></span></td>
                        <td colspan="2"><span id="effectiveSi" name="effectiveSi" ></span></td>
                        <td colspan="4"><span class="BigInput"></span></td>
                    </tr>
                    <tr>
                        <td>常规施肥区<input type="hidden" id="dealType" name="dealType" value="3"></td>
                       <td><span id="texture" name="texture" ></span></td>
                        <td colspan="2"><span id="salinity" name="salinity" ></span></td>
                        <td><span id="cec" name="cec" ></span></td>
                        <td><span id="exchangeableCa" name="exchangeableCa" ></span></td>
                        <td colspan="2"><span id="exchangeableMg" name="exchangeableMg"  ></span></td>
                        <td><span id="effectiveS" name="effectiveS" ></span></td>
                        <td colspan="2"><span id="effectiveSi" name="effectiveSi" ></span></td>
                        <td colspan="4"><span class="BigInput"></span></td>
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
                    <tr class="trData">
                        <td>长期不肥区 <input type="hidden" id="dealType" name="dealType" value="1"></td>
                        <td><span id="pContent" name="pContent" ></span></td>
                        <td><span id="kContent" name="kContent" ></span></td>
                        <td><span id="feContent" name="feContent" ></span></td>
                        <td><span id="mnContent" name="mnContent" ></span></td>
                        <td><span id="cuContent" name="cuContent" ></span></td>
                        <td><span id="znContent" name="znContent" ></span></td>
                        <td><span id="bContent" name="bContent" ></span></td>
                        <td><span id="moContent" name="moContent" ></span></td>
                        <td><span id="crContent" name="crContent" ></span></td>
                        <td><span id="cdContent" name="cdContent" ></span></td>
                        <td><span id="pbContent" name="pbContent" ></span></td>
                        <td><span id="asContent" name="asContent" ></span></td>
                        <td><span id="hgContent" name="hgContent" ></span></td>
                        <td><span id="snContent" name="snContent" ></span></td>
                    </tr>
                    <tr>
                        <td>当季不施肥区<input type="hidden" id="dealType" name="dealType" value="2"></td>
                        <td><span id="pContent" name="pContent" ></span></td>
                        <td><span id="kContent" name="kContent" ></span></td>
                        <td><span id="feContent" name="feContent" ></span></td>
                        <td><span id="mnContent" name="mnContent" ></span></td>
                        <td><span id="cuContent" name="cuContent" ></span></td>
                        <td><span id="znContent" name="znContent" ></span></td>
                        <td><span id="bContent" name="bContent" ></span></td>
                        <td><span id="moContent" name="moContent" ></span></td>
                        <td><span id="crContent" name="crContent" ></span></td>
                        <td><span id="cdContent" name="cdContent" ></span></td>
                        <td><span id="pbContent" name="pbContent" ></span></td>
                        <td><span id="asContent" name="asContent" ></span></td>
                        <td><span id="hgContent" name="hgContent" ></span></td>
                        <td><span id="snContent" name="snContent" ></span></td>
                    </tr>
                    <tr>
                        <td>常规施肥区<input type="hidden" id="dealType" name="dealType" value="3"></td>
                        <td><span id="pContent" name="pContent" ></span></td>
                        <td><span id="kContent" name="kContent" ></span></td>
                        <td><span id="feContent" name="feContent" ></span></td>
                        <td><span id="mnContent" name="mnContent" ></span></td>
                        <td><span id="cuContent" name="cuContent" ></span></td>
                        <td><span id="znContent" name="znContent" ></span></td>
                        <td><span id="bContent" name="bContent" ></span></td>
                        <td><span id="moContent" name="moContent" ></span></td>
                        <td><span id="crContent" name="crContent" ></span></td>
                        <td><span id="cdContent" name="cdContent" ></span></td>
                        <td><span id="pbContent" name="pbContent" ></span></td>
                        <td><span id="asContent" name="asContent" ></span></td>
                        <td><span id="hgContent" name="hgContent" ></span></td>
                        <td><span id="snContent" name="snContent" ></span></td>
                    </tr>
                </tbody>
            </table>
            <table border="0" cellpadding="0" align="center" cellspacing="0" width="100%" class="soilPhysicalBottom">
                <tr style="height:35px;line-height:35px;">
                  <td colspan="3" class="bottomr">检验单位：</td>
                  <td colspan="3" class="bottoml"><span  id="testCompany" name="testCompany"></span></td>
                </tr>
                <tr>
                    <td class="bottomr">批准人：</td>
                    <td class="bottoml"><span  id="approvalUserName" name="approvalUserName"></td>
                    <td class="bottomr">审核人：</td>
                    <td class="bottoml"><span  id="examineUserName" name="examineUserName"></td>
                    <td class="bottomr">编制人：</td>
                    <td ><span  id="formationUserName" name="formationUserName"></td>
                </tr>
                <tr>
                    <td class="bottomr">日期：</td>
                     <td class="bottoml"><span  id="approvalDate" name="approvalDate"></span></td>
                    <td class="bottomr">日期：</td>
                    <td class="bottoml"><span  id="examineDate" name="examineDate"></span></td>
                    <td class="bottomr">日期：</td>
                    <td class="bottoml"><span  id="formationDate" name="formationDate"></span></td>
                </tr>
            </table>
        </form>
    </body>
</html>