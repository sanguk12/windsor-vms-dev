//data[0:src, 1:appPositionCD(ALL, UP), 2:appDisRate, 3:appDisUnitCD(P,X)]]
var appletWidth = "100";
var appletHeight = "100";
var appletWidth_IE = "100";
var appletHeight_IE = "100";
var appletWidth_N = "98";
var appletHeight_N = "98";
var appletMode = "HIDE";

function appletDiv_init(){

	/*
	 * IE 와 Firefox 의 ScrollBar 표시영역 처리
	 */
//	try {
//		if (parseInt(navigator.appVersion)>3) {
//			if (navigator.appName=="Netscape") {
//				$("#layout").removeClass("pd-l");
//				$("#layout").addClass("pd");
//			}
//		}
//	}
//	catch(e){}
	
	try {
		$("#_detail").attr("src", $("#appSrc").val());
	}
	catch(e){}
	
	try {
		if($("#appletBody").length > 0){
			//$("#appletDiv").attr("innerHTML", $("#appletBody").attr("innerHTML"));
			document.getElementById("appletDiv").innerHTML = document.getElementById("appletBody").innerHTML;
		}
	}
	catch(e){}
	
	try {
		//window.setTimeout("appletDiv_HIDE()",1500);
		appletDiv_HIDE();
	}
	catch(e){}
}

function appletDiv_set(data){
	showLoading();
	$("#appPositionCD").val(data.appPositionCD);
	$("#appDisRate").val(data.appDisRate);
	$("#appDisUnitCD").val(data.appDisUnitCD);
	$("#_detail").attr("src", data.src);
	
	window.setTimeout(function() {
		try {
			if($("#appletBody").length > 0){
				//$("#appletDiv").attr("innerHTML", $("#appletBody").attr("innerHTML"));
				document.getElementById("appletDiv").innerHTML = document.getElementById("appletBody").innerHTML;
			}
		}
		catch(e){}
	}, 500);
	
	window.setTimeout("hideLoading()", 500);
}

function appletOpen(){
	appletDiv_SHOW();
}

function appletClose(){
	appletDiv_HIDE();
}

window.onresize = function(){
	//if($("#appletDiv").length > 0){
	if(document.getElementById("appletDiv")){
		//if($("#appletDiv").css("height") != "0%"){
		if(appletMode == "SHOW") {
			appletDiv_SHOW();
		}
	}
}

function appletDiv_SHOW(){
	appletMode = "SHOW";
	
	if($("#appPositionCD").val()=="ALL"){
		if($("#appDisUnitCD").val()=="P"){
			$("#_detail").attr("class", "");
			$("#formDiv").css({ "width":""+appletWidth+"%", "height":""+appletHeight+"%", "position":"absolute" });
			$("#appletDiv").css({ "width":""+appletWidth+"%", "height":"" +$("#appDisRate").val() +"%", "position":"absolute", "background-color":"#ffffff" });
		}
		else if($("#appDisUnitCD").val()=="X"){
			$("#_detail").attr("class", "");
			$("#formDiv").css({ "width":""+appletWidth+"%", "height":""+appletHeight+"px", "position":"absolute" });
			$("#appletDiv").css({ "width":""+appletWidth+"%", "height":""+ $("#appDisRate").val() +"px", "position":"absolute", "background-color":"#ffffff" });
		}
	}
	else if($("#appPositionCD").val()=="UP"){
		if($("#appDisUnitCD").val()=="P"){
			$("#_detail").attr("class", "applet-border");
			$("#formDiv").css({ "width":""+appletWidth+"%", "height":""+ (Number(appletHeight) - Number($("#appDisRate").val())) +"%", "position":"relative" });
			$("#appletDiv").css({ "width":""+appletWidth+"%", "height":""+ $("#appDisRate").val() +"%", "position":"relative" });
		}
		else if($("#appDisUnitCD").val()=="X"){
			$("#_detail").attr("class", "applet-border");
			$("#formDiv").css({ "width":""+appletWidth+"%", "height":""+ ($(document).height() - Number($("#appDisRate").val())) +"px", "position":"relative" });
			$("#appletDiv").css({ "width":""+appletWidth+"%", "height":""+ $("#appDisRate").val() +"px", "position":"relative" });
		}
	}
	$("#appletDiv").show();
}

function appletDiv_HIDE(){
	appletMode = "HIDE";
	
	appletWidth = appletWidth_IE;
	appletHeight = appletHeight_IE;
	
//	if (parseInt(navigator.appVersion)>3) {
//		if (navigator.appName=="Netscape") {
//			appletWidth = appletWidth_N;
//			appletHeight = appletHeight_N;
//		}
//		if (navigator.appName.indexOf("Microsoft")!=-1) {
//			appletWidth = appletWidth_IE;
//			appletHeight = appletHeight_IE;
//		}
//	}
	
	$("#wrapDiv").css({ "width":""+appletWidth+"%", "height":""+appletHeight+"%", "position":"relative"});
	$("#formDiv").css({ "width":""+appletWidth+"%", "height":""+appletHeight+"%", "position":"relative"});
	$("#appletDiv").css({ "width":""+appletWidth+"%", "height":"0%", "position":"relative"});
	
	//2011.06.29 taejoon.jang update : jquery-1.3.2=appletdiv:height:0% 제대로 작동, jquery-1.6.1=appletdiv:height:150px로 작동됨
	//--->그리하여, apppletMode추가함
	
	$("#appletDiv").hide();
	$("#appletBody").hide();
}