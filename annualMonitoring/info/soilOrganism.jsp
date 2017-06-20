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
                $("#samplingDate,#testingStartDate,#testingEndDate").datetimepicker({
                    language:"zh-CN",   
                    minView:"month",
                    format:"yyyy-mm-dd",
                    todayBtn: true,
                    todayHighlight : true,  
                    autoclose: true,
                    initialDate :new Date(),
                });
            })
            /*
                数据提交函数
            */ 
            function save(){
                var param = $("#form1").serializeJson();
                //检测起始时间
                var testingStartDate = $("#testingStartDate").val();
                //检测结束时间
                var testingEndDate =$("#testingEndDate").val();
                // console.log(monitorYear)
                var monitorYear =$("#monitorYear").val();
                //检测地点
                var samplingAddress =$("#samplingAddress").val();
                //采样时间
                var samplingDate = $("#samplingDate").val();
                var url =contextPath+"/soil5yearCharacterController/saveSoil5yearCharacter.act?stationSid=<%=sid%>&stationCode=<%=stationCode%>&monitorYear="+monitorYear+"&testingStartDate="+testingStartDate+"&testingEndDate="+testingEndDate+"&samplingAddress="+samplingAddress+"&samplingDate="+samplingDate;
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
        </script>
    </head>
    <body style="overflow-y:auto;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:40px;line-height:40px;">
            <tr>
                <td style="text-align:right;width:40%;padding-right:30px;">检测时间：</td>
                <td style="text-align:left;width:30%;"><input type="text" class="SmallInput"  id="testingStartDate" name="testingStartDate"/>至<input type="text" class="SmallInput"  id="testingEndDate" name="testingEndDate"/></td>
                <td style="text-align:right;width:30%;"><img src="<%=contextPath %>/resource/images/sys/save.png" alt="保存" title="保存" onclick="save()"></td>
            </tr>
        </table>
        <form  id="form1" style="width:100%;">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="soilOrganism">
                <tbody>
                    <tr>
                        <td colspan="6">监测点代码：<span><%=stationCode%></span></td>
                        <td colspan="9">监测年度：
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
                        <td colspan="6" style="padding-left:80px;">采样地点：<input type="text" name="samplingAddress" id="samplingAddress" class="SmallInput"/></td>
                        <td colspan="9" style="padding-left:32px;">采样时间：<input type="text" name="samplingDate" id="samplingDate" class="SmallInput"  id="annual"/></td>
                    </tr>
                    <tr>
                        <td colspan="15">五年(或试点结束后)增加监测内容</td>
                    </tr>
                    <tr>
                        <td rowspan="2" style="width:100px;">处理</td>
                        <td colspan="4">耕层物理性状</td>
                        <td colspan="3">耕层化学性状</td>
                        <td colspan="7">中量元素</td>
                    </tr>
                    <tr>
                        <td>质地（国际制）</td>
                        <td colspan="2">盐分（g/kg</td>
                        <td style="width:50px;">CEC（cmol/kg）</td>
                        <td>交换性钙cmol/kg</td>
                        <td colspan="2">交换性镁cmol/kg</td>
                        <td>有效硫mg/kg</td>
                        <td colspan="2">有效硅mg/kg</td>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>长期不肥区<input type="hidden" id="dealType" name="dealType" value="1"></td>
                        <td><input type="text" id="texture" name="texture" class="SmallInput"/></td>
                        <td colspan="2"><input type="text" id="salinity" name="salinity" class="SmallInput"/></td>
                        <td><input type="text" id="cec" name="cec" class="SmallInput"/></td>
                        <td><input type="text" id="exchangeableCa" name="exchangeableCa" class="SmallInput"/></td>
                        <td colspan="2"><input id="exchangeableMg" name="exchangeableMg" type="text" class="SmallInput"/></td>
                        <td><input type="text" id="effectiveS" name="effectiveS" class="SmallInput"/></td>
                        <td colspan="2"><input type="text" id="effectiveSi" name="effectiveSi" class="SmallInput"/></td>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>当季不施肥区<input type="hidden" id="dealType" name="dealType" value="2"></td>
                        <td><input type="text" id="texture" name="texture" class="SmallInput"/></td>
                        <td colspan="2"><input type="text" id="salinity" name="salinity" class="SmallInput"/></td>
                        <td><input type="text" id="cec" name="cec" class="SmallInput"/></td>
                        <td><input type="text" id="exchangeableCa" name="exchangeableCa" class="SmallInput"/></td>
                        <td colspan="2"><input id="exchangeableMg" name="exchangeableMg" type="text" class="SmallInput"/></td>
                        <td><input type="text" id="effectiveS" name="effectiveS" class="SmallInput"/></td>
                        <td colspan="2"><input type="text" id="effectiveSi" name="effectiveSi" class="SmallInput"/></td>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>常规施肥区<input type="hidden" id="dealType" name="dealType" value="3"></td>
                       <td><input type="text" id="texture" name="texture" class="SmallInput"/></td>
                        <td colspan="2"><input type="text" id="salinity" name="salinity" class="SmallInput"/></td>
                        <td><input type="text" id="cec" name="cec" class="SmallInput"/></td>
                        <td><input type="text" id="exchangeableCa" name="exchangeableCa" class="SmallInput"/></td>
                        <td colspan="2"><input id="exchangeableMg" name="exchangeableMg" type="text" class="SmallInput"/></td>
                        <td><input type="text" id="effectiveS" name="effectiveS" class="SmallInput"/></td>
                        <td colspan="2"><input type="text" id="effectiveSi" name="effectiveSi" class="SmallInput"/></td>
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
                        <td><input type="text" id="pContent" name="pContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="kContent" name="kContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="feContent" name="feContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="mnContent" name="mnContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="cuContent" name="cuContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="znContent" name="znContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="bContent" name="bContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="moContent" name="moContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="crContent" name="crContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="cdContent" name="cdContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="pbContent" name="pbContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="asContent" name="asContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="hgContent" name="hgContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="snContent" name="snContent" class="SmallInput Smallinput"/></td>
                    </tr>
                    <tr>
                        <td>当季不施肥区</td>
                        <td><input type="text" id="pContent" name="pContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="kContent" name="kContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="feContent" name="feContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="mnContent" name="mnContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="cuContent" name="cuContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="znContent" name="znContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="bContent" name="bContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="moContent" name="moContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="crContent" name="crContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="cdContent" name="cdContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="pbContent" name="pbContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="asContent" name="asContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="hgContent" name="hgContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="snContent" name="snContent" class="SmallInput Smallinput"/></td>
                    </tr>
                    <tr>
                        <td>常规施肥区</td>
                        <td><input type="text" id="pContent" name="pContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="kContent" name="kContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="feContent" name="feContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="mnContent" name="mnContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="cuContent" name="cuContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="znContent" name="znContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="bContent" name="bContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="moContent" name="moContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="crContent" name="crContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="cdContent" name="cdContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="pbContent" name="pbContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="asContent" name="asContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="hgContent" name="hgContent" class="SmallInput Smallinput"/></td>
                        <td><input type="text" id="snContent" name="snContent" class="SmallInput Smallinput"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>