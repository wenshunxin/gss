var iconFir = $(".icon-fir"),iconSec = $(".icon-sec");
var inputFir = iconFir.parents("#formFir").find("input[type='text']");
var inputSec = iconSec.parents("#creat-ponits-1");
var stateFir = true,stateSec = true;
//获取土壤基本信息
function getDetail(){
    var url=contextPath+"/monitorStationInfoController/getmonitorStationInfoById.act?sid="+sid;
    var json = tools.requestJsonRs(url);
    if(json.rtState){
        bindJsonObj2Cntrl(json.rtData);
    }
}
//修改基本信息
function saveInfo(){
    if($("#formFir").form("validate")){
        var url=contextPath+"/monitorStationInfoController/updatemonitorStationInfo.act";
        var param=tools.formToJson($("#formFir"));
        var json = tools.requestJsonRs(url,param);
        if(json.rtState){
            $.jBox.tip(json.rtMsg,"success");
            iconFir.css("background-image","url(../../resource/easyui/themes/metro/images/modify.png)");
            inputFir.attr("disabled","disabled");
            stateFir = !stateFir;
        }else{
            $.jBox.tip("保存失败");
        }
    }
}

function getDetailSecond(){
    var url=contextPath+"/soilProfileCharacterController/getSoilProfileCharacterByStationId.act?stationSid="+sid;
    var json = tools.requestJsonRs(url);
    var everyOneTr = $("tr:not(:first)");
    var i,m,k;
    if(json.rtState){
        for(i in json.rtData){
            for(k in everyOneTr){
                 m = everyOneTr.eq(k).find("input[type='text']").eq(i).attr('name');
                everyOneTr.eq(k).find("input[type='text']").eq(i).val(json.rtData[i][m])
            }
        }
        $("#samplingTime").val(json.rtData[0].samplingTime)
        $("#testingTime").val(json.rtData[0].testingTime)
        $("#monitorCompany").val(json.rtData[0].monitorCompany)
        $("#testingCompany").val(json.rtData[0].testingCompany)
    }
}

function saveInfoSecond(){
    if($("#formSec").form("validate")){
        var url =contextPath+"/soilProfileCharacterController/saveSoilProfileCharacter.act?stationSid="+sid+"&stationCode="+$("#stationCode").text();
        var param = $("#formSec").serializeJson();
        $.ajax({
           url: url,
           type: "POST",
           contentType : 'application/json;charset=utf-8', //设置请求头信息
           dataType:"json",
           data: param,
           success: function(data){
              var json = data;
              if(json.rtState){
                   $.jBox.tip(json.rtMsg,"success");
                   iconSec.css("background-image","url(../../resource/easyui/themes/metro/images/modify.png)");
                   inputSec.next("#formSec").find("input[type='text']").attr("disabled","disabled");
                   stateSec = !stateSec;
                //    location.reload();
               }else{
                   $.jBox.tip("系统异常！","error");
               }
           },
           error: function(res){
               $.jBox.tip("系统异常！","error");
           }
        });
    }
}

$(".aboutTime").datetimepicker({
    language:"zh-CN",
    minView:"month",
    format:"yyyy-mm-dd",
    todayBtn: true,
    todayHighlight : true,
    autoclose: true,
    pickerPosition: "top-right",
    initialDate :new Date(),
});

iconFir.on("click",function(){
    if(stateFir){
        $(this).css("background-image","url(../../resource/easyui/themes/metro/images/save.png)");
        inputFir.removeAttr("disabled");
        stateFir = !stateFir;
    }else{
        saveInfo()
    }
})

iconSec.on("click",function(){
    if(stateSec){
        $(this).css("background-image","url(../../resource/easyui/themes/metro/images/save.png)");
        inputSec.next("#formSec").find("input[type='text']").removeAttr("disabled");
        inputSec.find("input[type='text']").removeAttr("disabled");
        stateSec = !stateSec;
    }else{
        saveInfoSecond()
    }
})
