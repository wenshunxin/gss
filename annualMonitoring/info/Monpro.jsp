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
    <%@ include file="/header/easyui.jsp"%>
    <style media="screen">
        *{
            padding:0;
            margin:0;
        }
        body{
            font: normal 14px verdana;
            color:#333;
            padding:0 10px;
        }
        table{
            width:100%;
            margin: auto;
            border-collapse: collapse;
        }
        form td{
            text-align:center;
            border:1px solid #DDDAD5;
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
		    height: 24px;
		    line-height: 24px;
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
		.icon-fir{
			width:26px;
			height:26px;
			display: block;
			float: right;
			background-size: 100% 100%;
			background: url("../../resource/images/sys/save.png")
		}
		.aboutTime, .aboutTime1{
			width:225px;
		}
		.BigSelect{
			width: 200px;
			display: block;
			margin: auto;
		}
    </style>
</head>
<body onload="getDetail()" style="overflow-y:scroll;">
	<form id="formFir" class="" action="index.html" method="post" style="width: 80%; padding-right:15px; margin: auto;">
		<div class="creat-ponits">
			<dl>
				<dt class="float-l">监测点代码 :</dt>
				<dd class="float-l">
					<span id="stationCode" style="display:block; text-align:center;"><%=stationCode%></span>
				</dd>
			</dl>
			<dl class="creat-time">
				<dt class="float-l">监测年度 :</dt>
				<dd class="float-l">
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
			<span class="icon-fir" style="cursor: pointer;"></span>
		</div>
	    <table>
	        <tbody>
	            <tr>
	                <td colspan="2">项目</td>
	                <td colspan="1" width="50%">内容</td>
	            </tr>
	            <tr>
	                <td colspan="2">作物名称</td>
	                <td><input type="text"  id="plantName" name="plantName"></td>
	            </tr>
	            <tr>
	                <td colspan="2">品种</td>
	                <td><input type="text"  id="plantVarieties" name="plantVarieties"></td>
	            </tr>
	            <tr>
	                <td colspan="2">播种期</td>
	                <td><input type="text"  id="sowingDate" class="aboutTime1" name="sowingDate" readonly="readonly"></td>
	            </tr>
	            <tr>
	                <td colspan="2">收获期</td>
	                <td><input type="text"  id="harvestDate" class="aboutTime1" name="harvestDate" readonly="readonly"></td>
	            </tr>
	            <tr>
	                <td colspan="2">播种方式</td>
	                <td><input type="text"  id="sowingType" name="sowingType"></td>
	            </tr>
	            <tr>
	                <td colspan="2">耕作情况</td>
	                <td><input type="text"  id="farmingInfo" name="farmingInfo"></td>
	            </tr>
	            <tr>
	                <td rowspan="6" style="width:100px;">灌溉水及降雨</td>
	                <td>降雨量(mm)</td>
	                <td><input type="text"  id="rainfall" name="rainfall" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>灌溉设施</td>
	                <td><input type="text"  id="irrigationFacilities" name="irrigationFacilities"></td>
	            </tr>
	            <tr>
	                <td>灌溉方式</td>
	                <td><input type="text"  id="irrigationMode" name="irrigationMode"></td>
	            </tr>
	            <tr>
	                <td>灌水量(m<sup>3</sup>)</td>
	                <td><input type="text"  id="irrigationNum" name="irrigationNum" class="easyui-validatebox" validType="number[]"></td>
	            </tr>
	            <tr>
	                <td>排水方式</td>
	                <td><input type="text"  id="drainageMode" name="drainageMode"></td>
	            </tr>
	            <tr>
	                <td>排水效果</td>
	                <td><input type="text"  id="drainageEffect" name="drainageEffect"></td>
	            </tr>
	            <tr>
	                <td rowspan="3">自然灾害</td>
	                <td>种类</td>
	                <td><input type="text"  id="naturalDisasterType" name="naturalDisasterType"></td>
	            </tr>
	            <tr>
	                <td>发生时间</td>
	                <td><input type="text"  id="naturalDisasterTime"  name="naturalDisasterTime"></td>
	            </tr>
	            <tr>
	                <td>危害程度</td>
	                <td><input type="text"  id="naturalDisasterDegree" name="naturalDisasterDegree"></td>
	            </tr>
	            <tr>
	                <td rowspan="5">病虫害发生</td>
	                <td>种类</td>
	                <td><input type="text"  id="diseasesPestsType" name="diseasesPestsType"></td>
	            </tr>
	            <tr>
	                <td>发生时间</td>
	                <td><input type="text"  id="diseasesPestsTime" name="diseasesPestsTime"></td>
	            </tr>
	            <tr>
	                <td>危害程度</td>
	                <td><input type="text"  id="diseasesPestsDegree" name="diseasesPestsDegree"></td>
	            </tr>
	            <tr>
	                <td>防治方法</td>
	                <td><input type="text"  id="diseasesPestsMethod" name="diseasesPestsMethod"></td>
	            </tr>
	            <tr>
	                <td>防治效果</td>
	                <td><input type="text"  id="diseasesPestsEffect" name="diseasesPestsEffect"></td>
	            </tr>
	        </tbody>
	    </table>
		<div class="creat-ponits">
			<dl>
				<dt class="float-l">监测单位 :</dt>
				<dd class="float-l">
					<input type="text"  id="monitorCompany" name="monitorCompany" value="" class="BigInput" style="text-align:left;">
				</dd>
			</dl>
			<dl class="creat-time">
				<dt class="float-l">监测人员 :</dt>
				<dd class="float-l">
					<input type="text"  id="monitorUserName" name="monitorUserName" value="" class="BigInput" style="text-align:left;">
					<input type="hidden" id="sid" name="sid">
				</dd>
			</dl>
		</div>
	</form>
	<script type="text/javascript">
		(function($){
			var icon = $(".icon-fir");
			var stationCode="<%=stationCode%>";
			function getDetail(){
				$("input").val("");
				var url=contextPath+"/productionInfoController/getProductionInfo.act?stationSid=<%=sid%>&monitorYear="+ $("#monitorYear").val();
			    var json = tools.requestJsonRs(url);
			    if(json.rtState){
			        bindJsonObj2Cntrl(json.rtData);
					$("#stationCode").val(stationCode)
			    }else{
			        $.jBox.tip("获取信息失败");
			    }
			}

			window.getDetail = getDetail;

			function saveDetail(){
				var url=contextPath+"/productionInfoController/saveProductionInfo.act?stationSid=<%=sid%>&stationCode=<%=stationCode%>";//保存信息
				if($("#sid").val()){
					url = contextPath+"/productionInfoController/updateProductionInfo.act?stationSid=<%=sid%>&stationCode=<%=stationCode%>"//修改信息
				}
				var param=tools.formToJson($("#formFir"));
 		        var json = tools.requestJsonRs(url,param);

				if(json.rtState){
					$.jBox.tip(json.rtMsg, "success");
			    }else{
			        $.jBox.tip("保存失败");
			    }
			}

			$(".aboutTime1").datetimepicker({
			    language:"zh-CN",
			    minView:"month",
			    format:"yyyy-mm-dd",
			    todayBtn: true,
			    todayHighlight : true,
			    autoclose: true,
			    pickerPosition: "bottom",
			    initialDate :new Date(),
			});
			icon.on("click", function(){
				saveDetail()
			})
		})(jQuery)
	</script>
</body>
</html>
