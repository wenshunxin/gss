<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		String stationCode= request.getParameter("stationCode");
		String sid = request.getParameter("sid");
	%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<%@ include file="/header/header.jsp"%>
    <%@ include file="/header/easyui.jsp"%>
    <link rel="stylesheet" href="./index.css">
	<script type="text/javascript">
		var sid ="<%=sid%>";
		var stationCode = "<%=stationCode%>";
	</script>
</head>
<body style="overflow-y:scroll" onload="getDetailSecond()">
	<div id="creat-ponits-1">
		<dl>
			<dt class="float-l">监测点代码:</dt>
			<dd class="float-r">
				<input type="hidden" id="sid" name="sid" value="<%=sid%>"/>
				<span type="text" id="stationCode" style="display:block; width:90%; text-align:center;" class="float-l"><%=stationCode%></span>
				<span class="icon-sec" style="cursor:pointer;"></span>
			</dd>
		</dl>
	</div>
	<form id="formSec" class="" style="width:80%; padding-right:30px; margin:auto;">
	    <table style="margin-bottom:20px;">
	        <tbody>
	            <tr>
	                <td colspan="2">项目</td>
	                <td colspan="5"width="60%">发生层次</td>
	            </tr>
	            <tr>
	                <td colspan="2">层次代号</td>
	                <td style="position:relative">
						<input type="text" disabled name="levelCode" maxLength="50" value="" >
						<sub style="width:30%; position:absolute; left:50%; bottom:10%;">
							<input type="text" name="" value="1" style="width:30px; background:transparent">
						</sub>
					</td>
	                <td><input type="text" disabled name="levelCode" maxLength="50"></td>
	                <td><input type="text" disabled name="levelCode" maxLength="50"></td>
	                <td><input type="text" disabled name="levelCode" maxLength="50"></td>
	                <td><input type="text" disabled name="levelCode" maxLength="50"></td>
	            </tr>
	            <tr>
	                <td colspan="2">层次名称</td>
					<td><input type="text" disabled name="levelName" maxLength="50"></td>
	                <td><input type="text" disabled name="levelName" maxLength="50"></td>
	                <td><input type="text" disabled name="levelName" maxLength="50"></td>
	                <td><input type="text" disabled name="levelName" maxLength="50"></td>
	                <td><input type="text" disabled name="levelName" maxLength="50"></td>
	            </tr>
	            <tr>
	                <td colspan="2">层次深度</td>
					<td><input type="text" disabled name="levelDepth" maxLength="50"></td>
	                <td><input type="text" disabled name="levelDepth" maxLength="50"></td>
	                <td><input type="text" disabled name="levelDepth" maxLength="50"></td>
	                <td><input type="text" disabled name="levelDepth" maxLength="50"></td>
	                <td><input type="text" disabled name="levelDepth" maxLength="50"></td>
	            </tr>
	           <tr>
	                <td rowspan="6" style="width:26px;">剖面描述</td>
	                <td>颜色</td>
	                <td><input type="text" disabled name="profileColor" maxLength="50"></td>
	                <td><input type="text" disabled name="profileColor" maxLength="50"></td>
	                <td><input type="text" disabled name="profileColor" maxLength="50"></td>
	                <td><input type="text" disabled name="profileColor" maxLength="50"></td>
	                <td><input type="text" disabled name="profileColor" maxLength="50"></td>
	            </tr>
	            <tr>
	                <td>结构</td>
	                <td><input type="text" disabled name="profileStructure" maxLength="50"></td>
	                <td><input type="text" disabled name="profileStructure" maxLength="50"></td>
	                <td><input type="text" disabled name="profileStructure" maxLength="50"></td>
	                <td><input type="text" disabled name="profileStructure" maxLength="50"></td>
	                <td><input type="text" disabled name="profileStructure" maxLength="50"></td>
	            </tr>
	              <tr>
	                <td>紧实度</td>
	                <td><input type="text" disabled name="profileCompactness" maxLength="50"></td>
	                <td><input type="text" disabled name="profileCompactness" maxLength="50"></td>
	                <td><input type="text" disabled name="profileCompactness" maxLength="50"></td>
	                <td><input type="text" disabled name="profileCompactness" maxLength="50"></td>
	                <td><input type="text" disabled name="profileCompactness" maxLength="50"></td>
	            </tr>
	            <tr>
	                <td>容重(g/cm<sup>3</sup>)</td>
	                <td><input type="text" disabled name="profileBulkdensity" maxLength="50" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="profileBulkdensity" maxLength="50" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="profileBulkdensity" maxLength="50" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="profileBulkdensity" maxLength="50" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="profileBulkdensity" maxLength="50" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>新生体</td>
	                <td><input type="text" disabled name="profileNewborn" maxLength="50"></td>
	                <td><input type="text" disabled name="profileNewborn" maxLength="50"></td>
	                <td><input type="text" disabled name="profileNewborn" maxLength="50"></td>
	                <td><input type="text" disabled name="profileNewborn" maxLength="50"></td>
	                <td><input type="text" disabled name="profileNewborn" maxLength="50"></td>
	            </tr>
	            <tr>
	                <td>植物根系</td>
	                <td><input type="text" disabled name="profilePlantRoot" maxLength="50"></td>
	                <td><input type="text" disabled name="profilePlantRoot" maxLength="50"></td>
	                <td><input type="text" disabled name="profilePlantRoot" maxLength="50"></td>
	                <td><input type="text" disabled name="profilePlantRoot" maxLength="50"></td>
	                <td><input type="text" disabled name="profilePlantRoot" maxLength="50"></td>
	            </tr>
	            <tr>
	                <td rowspan="5">机械组成</td>
	                <td>D>2mm (%)</td>
	                <td><input type="text" disabled name="soilGrainDiameterFirst" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterFirst" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterFirst" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterFirst" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterFirst" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>2mm≥D>0.02mm(%)</td>
	                <td><input type="text" disabled name="soilGrainDiameterSecond" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterSecond" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterSecond" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterSecond" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterSecond" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>0.02mm≥D>0.002mm(%)</td>
	                <td><input type="text" disabled name="soilGrainDiameterThird" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterThird" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterThird" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterThird" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterThird" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>D<0.002mm(%)</td>
	                <td><input type="text" disabled name="soilGrainDiameterFourth" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterFourth" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterFourth" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterFourth" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="soilGrainDiameterFourth" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>质地命名</td>
	                <td><input type="text" disabled name="textureNaming" maxlength="50"></td>
	                <td><input type="text" disabled name="textureNaming" maxlength="50"></td>
	                <td><input type="text" disabled name="textureNaming" maxlength="50"></td>
	                <td><input type="text" disabled name="textureNaming" maxlength="50"></td>
	                <td><input type="text" disabled name="textureNaming" maxlength="50"></td>
	            </tr>
	            <tr>
	                <td rowspan="7">化学性质</td>
	                <td>有机质(g.Kg-1)</td>
	                <td><input type="text" disabled name="organicMatterContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="organicMatterContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="organicMatterContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="organicMatterContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="organicMatterContent" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>全  氮(g.Kg-1)</td>
	                <td><input type="text" disabled name="nContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="nContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="nContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="nContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="nContent" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>全  磷(g.Kg-1)</td>
	                <td><input type="text" disabled name="pContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="pContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="pContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="pContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="pContent" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>全  钾(g.Kg-1)</td>
	                <td><input type="text" disabled name="kContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="kContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="kContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="kContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="kContent" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>pH</td>
	                <td><input type="text" disabled name="ph" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="ph" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="ph" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="ph" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="ph" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>碳酸钙(g.Kg-1)</td>
	                <td><input type="text" disabled name="caco3Content" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="caco3Content" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="caco3Content" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="caco3Content" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="caco3Content" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>阳离子交换量(cmol.Kg-1)</td>
	                <td><input type="text" disabled name="cationContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="cationContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="cationContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="cationContent" class="easyui-validatebox" validType="number[]"></td>
	                <td><input type="text" disabled name="cationContent" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	        </tbody>
		</table>
		<div id="time-and-company"  style="width: 80%; float: right;">
			<ul>
				<li>
					<label for="">取样时间 :</label>
					<div>
						<input type="text" disabled  id="samplingTime" class="aboutTime BigInput" name="samplingTime" readonly="readonly">
					</div>
				</li>
				<li>
					<label for="">检测时间 :</label>
					<div>
						<input type="text" disabled  id="testingTime" class="aboutTime BigInput" name="testingTime" readonly="readonly">
					</div>
				</li>
			</ul>
			<ul>
				<li>
					<label for="">监测单位 :</label>
					<div>
						<input type="text" disabled  id="monitorCompany" name="monitorCompany"  class="BigInput">
					</div>
				</li>
				<li>
					<label for="">检测单位 :</label>
					<div>
						<input type="text" disabled  id="testingCompany" name="testingCompany"  class="BigInput">
					</div>
				</li>
			</ul>
		</div>
	</form>
	<script type="text/javascript" src="./index.js"></script>
</body>
</html>
