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
        <!--<style media="screen">
            body,
            html {
                height: 100%;
                width: 100%;
            }

        </style>-->
         <script>
            $(function(){
                $("#monitorYear").change(function(){
                    $("#form1").find("span:not('.spanNot')").html("");
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
                var url =contextPath+"/soilYearCharacterController/getSoilYearCharacter.act";
				var json = tools.requestJsonRs(url,param);
                // console.log( json)
                if(json.rtData.length==0){
                    $("#form1").find("span:not('.spanNot')").html("");
                }else{
                    for(var i = 0 ;i<json.rtData.length;i++){
                        var date=json.rtData[i].samplingDate;
                        for(var key in json.rtData[0]){
                            if(key=="samplingDate"){
                                $("span[name="+key+"]").eq(i).html(formatDate(date))
                            }else{
                                $("span[name="+key+"]").eq(i).html(json.rtData[i][key])
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
    <body style="overflow-y:auto;padding:0 20px;" onload="onload()">
    <form id="form1">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:40px;line-height:40px;">
            <tr width="100%;">
                <td style="text-align:center;">检测时间：<span class="SmallInput"  id="testingStartDate" name="testingStartDate"></span>至<span class="SmallInput"   id="testingEndDate" name="testingEndDate"></span></td>
            </tr>
        </table>

            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="soilPhysical">
                <tbody>
                    <tr>
                        <td colspan="2" class="ttleft" >监测点代码：</td>
                        <td colspan="3" class="ttLeft"><span class="spanNot"><%=stationCode%></span></td>
                        <td colspan="3" class="ttleft" >监测年度：</td>
                        <td colspan="3" class="ttLeft" >
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
                        <td colspan="2" class="ttleft" >采样地点：</td>
                        <td colspan="3" class="ttLeft"><span  id="samplingAddress" name="samplingAddress"></span></td>
                        <td colspan="3" class="ttleft">采样时间：</span></td>
                        <td colspan="6" class="ttLeft" ><span    id="samplingDate" name="samplingDate"></span></td>
                    </tr>
                    <tr>
                        <td colspan="11">每年度最后一季作物收获后、下季作物施肥前，采土测定并记载</td>
                    </tr>
                    <tr>
                        <td>处理</td>
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
                        <td>长期不施肥 <input type="hidden" id="dealType" name="dealType" value="1"></td>
                        <td><span id="topsoilDepth" name="topsoilDepth"  ></span></td>
                        <td><span id="bulkDensity" name="bulkDensity" ></span></td>
                        <td><span id="ph" name="ph" ></span></td>
                        <td><span id="organicMatterContent" name="organicMatterContent" ></span></td>
                        <td><span id="nContent" name="nContent" ></span></td>
                        <td><span id="effectiveKContent" name="effectiveKContent" ></span></td>
                        <td><span id="quickActingKContent" name="quickActingKContent" ></span></td>
                        <td><span id="slowActingKContent" name="slowActingKContent" ></span></td>
                        <td><span id="microorganism" name="microorganism" ></span></td>
                        <td><span id="ureaseActivity" name="ureaseActivity" ></span></td>
                    </tr>
                    <tr>
                        <td>当季不施肥区<input type="hidden" id="dealType" name="dealType" value="2"></td>
                        <td><span id="topsoilDepth" name="topsoilDepth" ></span></td>
                        <td><span id="bulkDensity" name="bulkDensity" ></span></td>
                        <td><span id="ph" name="ph" ></span></td>
                        <td><span id="organicMatterContent" name="organicMatterContent" ></span></td>
                        <td><span id="nContent" name="nContent" ></span></td>
                        <td><span id="effectiveKContent" name="effectiveKContent" ></span></td>
                        <td><span id="quickActingKContent" name="quickActingKContent" ></span></td>
                        <td><span id="slowActingKContent" name="slowActingKContent" ></span></td>
                        <td><span id="microorganism" name="microorganism" ></span></td>
                        <td><span id="ureaseActivity" name="ureaseActivity" ></span></td>
                    </tr>
                    <tr>
                        <td>常规施肥区<input type="hidden" id="dealType" name="dealType" value="3"></td>
                        <td><span id="topsoilDepth" name="topsoilDepth" ></span></td>
                        <td><span id="bulkDensity" name="bulkDensity" ></span></td>
                        <td><span id="ph" name="ph" ></span></td>
                        <td><span id="organicMatterContent" name="organicMatterContent" ></span></td>
                        <td><span id="nContent" name="nContent" ></span></td>
                        <td><span id="effectiveKContent" name="effectiveKContent" ></span></td>
                        <td><span id="quickActingKContent" name="quickActingKContent" ></span></td>
                        <td><span id="slowActingKContent" name="slowActingKContent" ></span></td>
                        <td><span id="microorganism" name="microorganism" ></span></td>
                        <td><span id="ureaseActivity" name="ureaseActivity" ></span></td>
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
