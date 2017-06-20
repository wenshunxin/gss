   $(document).ready(function(){
//		var date = new Date();
//		var times="&nbsp;&nbsp;&nbsp;&nbsp;今天是："+date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日";
//		$("#tipLeft").html(times);

		var load_time = null;
	    var down_time = null;
	    window.onload = function(){
	       flag = false;
	        //打开页面15分钟不操作就跳转
	       load_time = setTimeout(function(){
	    	   autoOutSystem();
	       },900000);
	    };
	    document.onmouseover=function(){
	       //停止时钟load_time
	       clearInterval(load_time);
	       if(null != down_time){
	           //停止时钟down_time
	           clearInterval(down_time);
	       }
	       //15分钟不操作就跳转
	       down_time = setTimeout(function(){
	    	   autoOutSystem();
	       },900000);

	   };
	   $("#mainFrame").on("load",function(){
			 $('#mainFrame').prop('contentWindow').document.onmouseover=function(){
				  //停止时钟load_time
			       clearInterval(load_time);
			       if(null != down_time){
			           //停止时钟down_time
			           clearInterval(down_time);
			       }
			       //15分钟不操作就跳转
			       down_time = setTimeout(function(){
			    	   autoOutSystem();
			       },900000);
			   }
		});
	   getMenuByPriv();
	});
	//退出系统
	function outSystem(){
		top.$.jBox.confirm("确定退出系统吗？","确认",function(v){
			if(v=="ok"){
				var url =contextPath+"/userController/doLoginOut.act";
				var json = tools.requestJsonRs(url);
				if(json.rtState){
					window.location=contextPath+"/index.jsp";
				}
			}
		});
        // $("#dialog").attr("src","dialog.jsp");
        // $("#dialog").show();
	}
	/**
	 * 自动退出系统
	 */
	function autoOutSystem(){
		var url =contextPath+"/userController/doLoginOut.act";
		var json = tools.requestJsonRs(url);
		if(json.rtState){
			window.location=contextPath+"/index.jsp";
		}
	}

	function iFrameHeight() {
		var ifm= document.getElementById("mainFrame");
		var subWeb = document.frames ? document.frames["mainFrame"].document : ifm.contentDocument;
		if(ifm != null && subWeb != null) {
		   ifm.height = $("#mainFrame").parent().height();
		}
	}

    function menuclick(obj){
		if($(obj).parent("li").find("ul").length>0){
			$(obj).parent("li").find(".child").toggle();
		}
	/*	$(obj).parent("li").siblings().each(function(){
			$($(this).find(".child")[0]).css("display","none");
		});*/
	}

  function openMenu(url,menuName){
        if(url==""){
            return;
        }
		// if($.browser.mozilla)
	    //  {
	    //      var $E = function(){var c=$E.caller; while(c.caller)c=c.caller; return c.arguments[0]};
	    //      __defineGetter__("event", $E);
	    //  }
		// if (window.event) {
	    //     event.cancelBubble = true;
	    // }else{
	    //     event.stopPropagation();
	    // }
		$("#mainFrame").attr("src",contextPath+url);
	}


	function getMenuByPriv(){
		var url =contextPath+"/userController/getUserPriv.act";
		var json = tools.requestJsonRs(url);
		if(json.rtState){
			var data = json.rtData;
			html="";
			for(var i=0;i<data.length;i++){
				if(data[i].parent==0){
					html+="<li class='item' ><div class='bottom_top' onclick=\"openMenu('"+data[i].url+"','"+data[i].name+"')\"><img src='../resource/images/sys/"+data[i].menuIcon+"'/>"+data[i].name+"</div><div class='bottom_bot' style='display: none;'>"
					+"<ul>";
					for(var j=0;j<data.length;j++){
						if(data[i].id==data[j].parent){
							html+="<li  class='bottom_bot_li' onclick=\"openMenu('"+data[j].url+"','"+data[j].name+"')\">"+data[j].name+"</li>";
						}
					}
					html+="</ul></div></li>";
				}
			}
			$(".bottom_ul").html(html);
                $(".item").eq(0).find(".bottom_top").addClass("active")
		}
	}
