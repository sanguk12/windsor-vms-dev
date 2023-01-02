<c:choose> 
	<c:when test="${params.themeURL == 'null'}"> 
		<c:set var="themeURL" value="${contextPath}/scripts/theme/blue"/>
	</c:when> 
	<c:otherwise>
		<c:set var="themeURL" value="${contextPath}${params.themeURL}"/>
	</c:otherwise>
</c:choose>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
 
<!-- ActiveWidgets Module - START -->

	<link rel="stylesheet" type="text/css" href="${themeURL}/styles/aw.css" ></link>
	<script type="text/javascript" src="${contextPath}/scripts/aw/runtime/lib/aw.js" ></script>
	<script type="text/javascript" src="${contextPath}/scripts/aw/awConfig.js" ></script>
	
<!-- ActiveWidgets Module - END -->

<!-- Common Service - START -->

	<script type="text/javascript" src="${contextPath}/scripts/baseScript.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/basePopup.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/date.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/expiredSessionCheck.js"></script>
	
<!-- Common Service - END -->


<!-- YUI Module - START -->

	<!-- Loading Message Display & Panel - START -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/scripts/yui/build/fonts/fonts-min.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/scripts/yui/build/container/assets/skins/sam/container.css" />
	<script type="text/javascript" src="${contextPath}/scripts/yui/build/utilities/utilities.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/yui/build/container/container-min.js"></script>
	<!-- Loading Message Display & Panel - END -->
	
	
    <!-- Tab - START -->
	<link rel="stylesheet" type="text/css" href="${themeURL}/scripts/yui/build/tabview/assets/skins/sam/tabview.css" />
	<script type="text/javascript" src="${contextPath}/scripts/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script>
	<!-- v2.6 --> 
	<script type="text/javascript" src="${contextPath}/scripts/yui/build/element/element-beta-min.js"></script>
	<!-- v2.7 <script type="text/javascript" src="${contextPath}/scripts/yui/build/element/element-min.js"></script> -->
	<script type="text/javascript" src="${contextPath}/scripts/yui/build/tabview/tabview-min.js"></script>
	<!-- Tab - END -->
	
	<!-- Uploader - START, 2009-05-22 -->
	<!-- v2.6 -->
	<script type="text/javascript" src="${contextPath}/scripts/yui/build/uploader/uploader-experimental.js"></script>
	
	<!-- v2.7 <script type="text/javascript" src="${contextPath}/scripts/yui/build/uploader/uploader.js"></script> -->
	
<!-- YUI Module - END -->

<!-- jQuery - START -->

	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.8.2.min.js"></script>
	
	<script type="text/javascript" src="${contextPath}/scripts/jquery/ui/js/jquery-ui-1.10.1.custom.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/scripts/jquery/ui/css/humanity/jquery-ui-1.10.1.custom.css" />
	
	<!--
	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.6.1.min.js"></script> 
	 -->
	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery.alphanumeric.js"></script>
	
	<!-- 
	<link rel="stylesheet" type="text/css" href="${contextPath}/scripts/jquery/lightbox/css/style-projects-jquery.css" />
	 -->
    <script type="text/javascript" src="${contextPath}/scripts/jquery/lightbox/js/jquery.lightbox-0.5.js"></script>
    <link rel="stylesheet" type="text/css" href="${contextPath}/scripts/jquery/lightbox/css/jquery.lightbox-0.5.css" media="screen" />	
	<!-- jquery.form.min jquery form -->
	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery.form.min.js"></script>           
	
<style type="text/css">
	.file_input_textbox {
		float: left
	}

	.file_input_div {
		position: relative; 
		width: 73px; 
		height: 21px; 
		overflow: hidden;
	}
	
	.file_input_button {
		position: absolute; 
		top: 0px;
		background: url( "${themeURL}/images/btn/select.png" ) no-repeat;
		border: none;
	}
	
	.file_input_hidden {
		cursor: pointer;
		font-size: 45px; 
		position: absolute; 
		right: 0px; 
		top: 0px; 
		opacity: 0; 
		
		filter: alpha(opacity=0); 
		-ms-filter: "alpha(opacity=0)"; 
		-khtml-opacity: 0; 
		-moz-opacity: 0;
	}
	::-webkit-file-upload-button { cursor:pointer; }                          
</style>
	
	
<!-- jQuery - END -->

<!-- applet - START -->
	<script type="text/javascript" src="${contextPath}/scripts/applet.js"></script>
<!-- applet - END -->

<!-- Program Common Module - START -->

	<link rel="stylesheet" type="text/css" href="${themeURL}/theme.css" ></link>
	<script type="text/javascript" src="${contextPath}/scripts/formatter.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/basePopup.js"></script>
	
<!-- Program Common Module - END -->

<!--  FusionCharts - START -->
	<script type="text/javascript" src="${contextPath}/scripts/FusionCharts.js"></script>
<!--  FusionCharts - END -->

<script type="text/javascript">

	<c:if test="${params.menuCloseYN != 'N'}">
		try{parent.menuTreeToggle();}catch(e){}
	</c:if>
	try{parent.InitSessionTimer();}catch(e){}
	
	var _contextPath = "${contextPath}";
	
	/*
	var partnerDivCD_S = "${params.partnerDivCD_S}";
	var salOrgCD_S = "${params.salOrgCD_S}";
	var salOffCD_S = "${params.salOffCD_S}";
	var prtnrID_S = "${params.prtnrID_S}";
	var prtnrNm_S = "${params.prtnrNm_S}";
	*/
	$(function() {
		try{$("form").css("display","inline");}catch(e){}
		
		try{$("#dateFrom").numeric();}catch(e){}
		try{$("#dateTo").numeric();}catch(e){}
		try{$("#dateFrom").attr("maxlength","8");}catch(e){}
		try{$("#dateTo").attr("maxlength","8");}catch(e){}
		/*
		try{$("#prtnrID").alphanumeric();}catch(e){}
		try{$("#empID").alphanumeric();}catch(e){}
		try{$("#bizRegNo").numeric();}catch(e){}
		try{$("#faxNo").numeric();}catch(e){}
		try{$("#hpNo").numeric();}catch(e){}
		try{$("#telNo").numeric();}catch(e){}

		try{$("#prtnrID").attr("maxlength","20");}catch(e){}
		try{$("#empID").attr("maxlength","20");}catch(e){}
		try{$("#bizRegNo").attr("maxlength","10");}catch(e){}
		try{$("#emailAddr").attr("maxlength","40");}catch(e){}
		try{$("#faxNo").attr("maxlength","11");}catch(e){}
		try{$("#hpNo").attr("maxlength","11");}catch(e){}
		try{$("#telNo").attr("maxlength","11");}catch(e){}
		try{$("#salOffCD").val("${params.salOffCD_S}");}catch(e){}
		try{$("#prtnrID").val("${params.prtnrID_S}");}catch(e){}
		try{$("#prtnrNm").val("${params.prtnrNm_S}");}catch(e){}
		
		try{
			if ($("#prtnrID").val() == "") {
				$("#prtnrID").focus();
			}
		}catch(e){}
		
		try {
			if (partnerDivCD_S == 'AC') {
				try{$("#salOffCD").attr("disabled",true)}catch(e){}
				try{$("#prtnrID").attr("readonly",true)}catch(e){}
				try{$("#prtnrID").addClass("input-readonly")}catch(e){}
				try{$("#prtnrID_popup").hide()}catch(e){}
				try{$("#prtnrID_clear").hide()}catch(e){}
			}
		}catch(e){}
		*/
	});

	document.onkeydown = mykeyhandler;
	function mykeyhandler() {
		//if ((window.event && window.event.keyCode == 123) //F12
		//	|| 
		if ((window.event.srcElement.readOnly && window.event && window.event.keyCode == 8)) { //readonly & backspac
			window.event.cancelBubble = true;
			window.event.returnValue = false;
			return false;
		}
	};
</script>

<!-- DHTML Module - START -->

    <script type="text/javascript" src="${themeURL}/scripts/dhtml/js/separateFiles/dhtmlSuite-common.js-uncompressed.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/yui/yui.js"></script>

<!-- DHTML Module - END -->
