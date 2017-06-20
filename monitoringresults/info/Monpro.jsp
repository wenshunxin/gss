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
    <style media="screen">
        *{
            padding:0;
            margin:0;
        }
        body{
            font: normal 14px verdana;
            color:#333;
        }
        table{
            width:100%;
            min-width: 800px;
            margin: auto;
            border-collapse: collapse;
        }
        td{
            text-align:center;
            border:1px solid #DDDAD5;
            /*layout:fixed;*/
            height: 40px;
            line-height: 36px;
        }
        input{
            width:100%;
            height:100%;
            border:none;
            outline:none;
            text-align: center;
        }
		dl,ul,li,dt,dd{
		    font-weight: normal;
		}
		.creat-ponits{
		    height: 30px;
		    margin-top:10px;
		    margin-bottom: 20px;
		}
		.creat-ponits dt, .creat-ponits dd{
		    height: 26px;
		    line-height: 26px;
		}
		.creat-ponits dt{
		    width: 110px;
		    text-align: center;
		}
		.creat-ponits dd{
		    width:80%;
		    width: -moz-calc(100% - 110px);
		    width: -webkit-calc(100% - 110px);
		    width: calc(100% - 110px);
		}
		.creat-ponits dd input{
		    width: calc(100% - 40px);
		    border: none;
		    outline: none;
		}
		.creat-ponits dl{
		    width:40%;
		    margin-left: 5%;
		    float: left;
		    display: inline-block;
		}
		.float-l{
		    float: left;
		}
		.float-r{
		    float: right;
		}
		.BigSelect{
			width: 200px;
			display: block;
			margin: auto;
			/*position: absolute;
			left:50%;
			top:0;
			transform: translateX(-50%);
			opacity: 0;*/
		}
		.monitorYearSpan{
			width: 200px;
			height:26px;
			margin: auto;
			text-align: center;
			display: block;
			border: 1px solid #ccc;
		}

    </style>
</head>
<body onload="getDetail()" style="overflow-y:scroll;">
	<form id="formFir" class="" action="index.html" method="post" style="width:80%; padding-right:15px; margin:auto;">
		<div class="creat-ponits">
			<dl>
				<dt class="float-l">监测点代码 :</dt>
				<dd class="float-l">
					<span id="stationCode" name="stationCode" style="display:block; text-align:center;"><%=stationCode%></span>
				</dd>
			</dl>
			<dl class="creat-time">
				<dt class="float-l">监测年度 :</dt>
				<dd class="float-l" style="position:relative">
					<%-- <label class="monitorYearSpan BigInput"></label> --%>
					<select id="monitorYear" name="monitorYear" class="BigSelect" onChange="getDetail()">
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
				</dd>
			</dl>
		</div>
	    <table>
	        <tbody>
	            <tr>
	                <td colspan="2">项目</td>
	                <td colspan="1" width="50%">内容</td>
	            </tr>
	            <tr>
	                <td colspan="2">作物名称</td>
	                <td><span id="plantName" name="plantName"></span></td>
	            </tr>
	            <tr>
	                <td colspan="2">品种</td>
	                <td><span id="plantVarieties" name="plantVarieties"></span></td>
	            </tr>
	            <tr>
	                <td colspan="2">播种期</td>
	                <td><span id="sowingDate" name="sowingDate"></span></td>
	            </tr>
	            <tr>
	                <td colspan="2">收获期</td>
	                <td><span id="harvestDate" name="harvestDate"></span></td>
	            </tr>
	            <tr>
	                <td colspan="2">播种方式</td>
	                <td><span id="sowingType" name="sowingType"></span></td>
	            </tr>
	            <tr>
	                <td colspan="2">耕作情况</td>
	                <td><span id="farmingInfo" name="farmingInfo"></span></td>
	            </tr>
	            <tr>
	                <td rowspan="6" style="width:100px;">灌溉水及降雨</td>
	                <td>降雨量(mm)</td>
	                <td><span id="rainfall" name="rainfall"></span></td>
	            </tr>
	            <tr>
	                <td>灌溉设施</td>
	                <td><span id="irrigationFacilities" name="irrigationFacilities"></span></td>
	            </tr>
	            <tr>
	                <td>灌溉方式</td>
	                <td><span id="irrigationMode" name="irrigationMode"></span></td>
	            </tr>
	            <tr>
	                <td>灌水量(m<sup>3</sup>)</td>
	                <td><span id="irrigationNum" name="irrigationNum"></span></td>
	            </tr>
	            <tr>
	                <td>排水方式</td>
	                <td><span id="drainageMode" name="drainageMode"></span></td>
	            </tr>
	            <tr>
	                <td>排水效果</td>
	                <td><span id="drainageEffect" name="drainageEffect"></span></td>
	            </tr>
	            <tr>
	                <td rowspan="3">自然灾害</td>
	                <td>种类</td>
	                <td><span id="naturalDisasterType" name="naturalDisasterType"></span></td>
	            </tr>
	            <tr>
	                <td>发生时间</td>
	                <td><span id="naturalDisasterTime" name="naturalDisasterTime"></span></td>
	            </tr>
	            <tr>
	                <td>危害程度</td>
	                <td><span id="naturalDisasterDegree" name="naturalDisasterDegree"></span></td>
	            </tr>
	            <tr>
	                <td rowspan="5">病虫害发生</td>
	                <td>种类</td>
	                <td><span id="diseasesPestsType" name="diseasesPestsType"></span></td>
	            </tr>
	            <tr>
	                <td>发生时间</td>
	                <td><span id="diseasesPestsTime" name="diseasesPestsTime"></span></td>
	            </tr>
	            <tr>
	                <td>危害程度</td>
	                <td><span id="diseasesPestsDegree" name="diseasesPestsDegree"></span></td>
	            </tr>
	            <tr>
	                <td>防治方法</td>
	                <td><span id="diseasesPestsMethod" name="diseasesPestsMethod"></span></td>
	            </tr>
	            <tr>
	                <td>防治效果</td>
	                <td><span id="diseasesPestsEffect" name="diseasesPestsEffect"></span></td>
	            </tr>
	        </tbody>
	    </table>
		<div class="creat-ponits">
			<dl>
				<dt class="float-l">监测单位 :</dt>
				<dd class="float-l">
					<span id="monitorCompany" name="monitorCompany"></span>
				</dd>
			</dl>
			<dl class="creat-time">
				<dt class="float-l">监测人员 :</dt>
				<dd class="float-l">
					<span id="monitorUserName" name="monitorUserName"></span>
					<input type="hidden" id="sid" name="sid">
				</dd>
			</dl>
		</div>
	</form>
	<script type="text/javascript">
		(function($){
			var icon = $(".icon-fir");
			var stationCode="<%=stationCode%>";
			var BigSelect = $(".BigSelect");
			function getDetail(){
				BigSelect.prev("label").text(BigSelect.val());
				var url=contextPath+"/productionInfoController/getProductionInfo.act?stationSid=<%=sid%>&monitorYear="+ $("#monitorYear").val();
			    var json = tools.requestJsonRs(url);
				$("span").text("")
			    if(json.rtState){
			        bindJsonObj2Cntrl(json.rtData);
					$("#stationCode").text(stationCode);
			    }else{
			        $.jBox.tip("获取信息失败");
			    }
			}
			window.getDetail = getDetail;
		})(jQuery)
	</script>
</body>
</html>
