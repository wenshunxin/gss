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
</head>
<body style="overflow-y:scroll" onload="getDetail();">
	<form id="formFir" action="" style="width:80%; padding-right:30px; margin: auto">
		<div id="creat-ponits">
			<dl>
				<dt class="float-l">监测点代码:</dt>
				<dd class="float-l">
					<input type="hidden" id="sid" name="sid" value="<%=sid%>"/>
					<input type="text" disabled id="stationCode" name="stationCode" value="<%=stationCode%>" disabled="disabled" class="BigInput">
				</dd>
			</dl>
			<dl class="creat-time">
				<dt class="float-l">建点年度(时间):</dt>
				<dd class="float-l">
					<input type="text" disabled id="buildingDate" name="buildingDate" value="" class="BigInput">
				</dd>
			</dl>
			<span class="icon-fir" style="cursor: pointer;"></span>
		</div>
        <table>
            <tbody>
                <tr>
                    <td rowspan="18">基本情况</td>
                    <td colspan="2" width="24%">省(区、市)名</td>
                    <td colspan="2" width="24%"><input type="text" disabled id="provinceName" name="provinceName" maxLength="50"></td>
                    <td colspan="2" width="25%">地(市、州、盟)名</td>
                    <td colspan="2" width="25%"><input type="text" disabled id="cityName" name="cityName" maxLength="50"></td>
                </tr>
                <tr>
                    <td colspan="2">县(旗、市、区)名</td>
                    <td colspan="2"><input type="text" disabled id="countyName" name="countyName" maxLength="50"></td>
                    <td colspan="2">乡(镇)名</td>
                    <td colspan="2"><input type="text" disabled id="townshipName" name="townshipName" maxLength="50"></td>
                </tr>
                <tr>
                    <td colspan="2">村名</td>
                    <td colspan="2"><input type="text" disabled id="villageName" name="villageName" maxLength="50"></td>
                    <td colspan="2">农户(地块)名</td>
                    <td colspan="2"><input type="text" disabled id="massifName" name="massifName" maxLength="50"></td>
                </tr>
                <tr>
                    <td colspan="2">县代码</td>
                    <td colspan="2"><input type="text" disabled id="countyCode" name="countyCode" maxLength="50"></td>
                    <td colspan="2">经度(°/′/″)</td>
                    <td colspan="2"><input type="text" disabled id="longitude" name="longitude"></td>
                </tr>
                <tr>
                    <td colspan="2">纬度(°/′/″)</td>
                    <td colspan="2"><input type="text" disabled id="latitude" name="latitude"></td>
                    <td colspan="2">常年降水量(mm)</td>
                    <td colspan="2"><input type="text" disabled id="annualPrecipitation" name="annualPrecipitation" class="easyui-validatebox" validType="number[]"></td>
                </tr>
                <tr>
                    <td colspan="2">常年有效积温(℃)</td>
                    <td colspan="2"><input type="text" disabled id="annualEffectiveTemperature" name="annualEffectiveTemperature" class="easyui-validatebox" validType="number[]"></td>
                    <td colspan="2">常年无霜期(天)</td>
                    <td colspan="2"><input type="text" disabled id="annualNoFrostDays" name="annualNoFrostDays" class="easyui-validatebox" validType="number[]"></td>
                </tr>
                <tr>
                    <td colspan="2">地形部位</td>
                    <td colspan="2"><input type="text" disabled id="terrainPosition" name="terrainPosition"  maxLength="50"></td>
                    <td colspan="2">地块坡度(°)</td>
                    <td colspan="2"><input type="text" disabled id="massifSlope" name="massifSlope" class="easyui-validatebox" validType="number[]"></td>
                </tr>
                <tr>
                    <td colspan="2">海拔高度(m)</td>
                    <td colspan="2"><input type="text" disabled id="altitude" name="altitude" class="easyui-validatebox" validType="number[]"></td>
                    <td colspan="2">潜水埋深(m)</td>
                    <td colspan="2"><input type="text" disabled id="divingDepth" name="divingDepth" class="easyui-validatebox" validType="number[]"></td>
                </tr>
                <tr>
                    <td colspan="2">障碍因素</td>
                    <td colspan="2"><input type="text" disabled id="obstacleFactor" name="obstacleFactor" maxLength="50"></td>
                    <td colspan="2">耕地地力水平</td>
                    <td colspan="2"><input type="text" disabled id="soilFertilityLevel" name="soilFertilityLevel" maxLength="50"></td>
                </tr>
                <tr>
                    <td colspan="2">灌溉能力</td>
                    <td colspan="2"><input type="text" disabled id="irrigationCapacity" name="irrigationCapacity" maxLength="50"></td>
                    <td colspan="2">排水能力</td>
                    <td colspan="2"><input type="text" disabled id="drainageCapacity" name="drainageCapacity" maxLength="50"></td>
                </tr>
                <tr>
                    <td colspan="2">地域分区</td>
                    <td colspan="2"><input type="text" disabled id="regionDivision" name="regionDivision" maxLength="50"></td>
                    <td colspan="2">熟制分区</td>
                    <td colspan="2"><input type="text" disabled id="cookedDivision" name="cookedDivision" maxLength="50"></td>
                </tr>
                <tr>
                    <td colspan="2">典型种植制度</td>
                    <td colspan="2"><input type="text" disabled id="plantRule" name="plantRule" maxLength="50"></td>
                    <td colspan="2">产量水平(kg/亩)</td>
                    <td colspan="2"><input type="text" disabled id="yieldLevel" name="yieldLevel" class="easyui-validatebox" validType="number[]"></td>
                </tr>
                <tr>
                    <td  rowspan="2" width="12%">常年施肥量(折纯，kg/亩)</td>
                    <td>化肥</td>
                    <td width="12%">N</td>
                    <td><input type="text" disabled id="chemicalFertilizeNNum" name="chemicalFertilizeNNum" class="easyui-validatebox" validType="number[]"></td>
                    <td width="12.5%">P<sub>2</sub>O<sub>5</sub></td>
                    <td><input type="text" disabled id="chemicalFertilizeP2o5Num" name="chemicalFertilizeP2o5Num" class="easyui-validatebox" validType="number[]"></td>
                    <td width="12%.5">K<sub>2</sub>O</td>
                    <td><input type="text" disabled id="chemicalFertilizeK2oNum" name="chemicalFertilizeK2oNum" class="easyui-validatebox" validType="number[]"></td>
                </tr>
                <tr>
                    <td>有机肥</td>
                    <td width="12%">N</td>
                    <td><input type="text" disabled id="organicFertilizerNNum" name="organicFertilizerNNum" class="easyui-validatebox" validType="number[]"></td>
                    <td width="12.5%">P<sub>2</sub>O<sub>5</sub></td>
                    <td><input type="text" disabled id="organicFertilizerP2o5Num" name="organicFertilizerP2o5Num" class="easyui-validatebox" validType="number[]"></td>
                    <td width="12.5%">K<sub>2</sub>O</td>
                    <td><input type="text" disabled id="organicFertilizerK2oNum" name="organicFertilizerK2oNum" class="easyui-validatebox" validType="number[]"></td>
                </tr>
                <tr>
                    <td colspan="2">田块面积(亩)</td>
                    <td colspan="2"><input type="text" disabled id="fieldArea" name="fieldArea" class="easyui-validatebox" validType="number[]"></td>
                    <td colspan="2">代表面积(万亩)</td>
                    <td colspan="2"><input type="text" disabled id="representativeArea" name="representativeArea" class="easyui-validatebox" validType="number[]"></td>
                </tr>
                <tr>
                    <td colspan="2">土壤代码</td>
                    <td colspan="2"><input type="text" disabled id="soilCode" name="soilCode" maxLength="50"></td>
                    <td colspan="2">成土母质</td>
                    <td colspan="2"><input type="text" disabled id="parentMaterial" name="parentMaterial" maxLength="50"></td>
                </tr>
                <tr>
                    <td colspan="2">土类</td>
                    <td colspan="2"><input type="text" disabled id="soilType" name="soilType" maxLength="50"></td>
                    <td colspan="2">亚类</td>
                    <td colspan="2"><input type="text" disabled id="subclass" name="subclass" maxLength="50"></td>
                </tr>
                <tr>
                    <td colspan="2">土属</td>
                    <td colspan="2"><input type="text" disabled id="soilGenus" name="soilGenus" maxLength="50"></td>
                    <td colspan="2">土种</td>
                    <td colspan="2"><input type="text" disabled id="soilSpecies" name="soilSpecies" maxLength="50"></td>
                </tr>
                <tr>
                    <td colspan="5">景观照片拍摄时间 :</td>
                    <td colspan="4">剖面照片拍摄时间 :</td>
                </tr>
                <tr>
                    <td colspan="5">
                    	<input type="text" disabled id="landscapeShotTime" class="aboutTime" name="landscapeShotTime"  readonly="readonly" style="width:205px">
                    </td>
                    <td colspan="4">
                    	<input type="text" disabled id="profileShotTime" class="aboutTime" name="profileShotTime" readonly="readonly" style="width:205px;">
                    </td>
                </tr>
            </tbody>
        </table>
		<div class="" style="width:50%; height:30px; line-height:30px; text-align:center; margin:20px auto; float:right;">
			监测单位:<input type="text" disabled id="monitorCompany" name="monitorCompany" style="width:80%; height:30px; line-height:30px; float:right; text-align:left;"  maxLength="50" class="BigInput"/>
		</div>
    </form>
	<script type="text/javascript">
		var sid ="<%=sid%>";
		var stationCode = "<%=stationCode%>";
	</script>
	<script type="text/javascript" src="./index.js"></script>
</body>
</html>
