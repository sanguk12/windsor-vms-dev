<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
	</head>

	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            	<tr>
                    <td height="1">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
						<input type="hidden" id="fileName" name="fileName"/>
					</td>
				</tr>
				<tr>
                	<td height="1">
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required"><fmt:message key="ANL02004A.fy"/>
												</td>
												<td class="td-input">
													<div id="fy_cond" style="float:left;">
														<select id="fy">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="ANL02004A.esltTbInfo"/>
												</td>
												<td class="td-input">
													<div id="esltTbInfo_cond" style="float:left;">
														<select id="esltTbInfo">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="uploadFile"/></td>
												<td class="td-input">
													<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					                           			<tr>
					                               			<td height="25" width="310">
					                                   			<div id="selectedFileDisplay">
					                                       			<input type="text" cols="100" id="progressReport" value="" style="width:300px;" readonly="readonly" >
					                                   			</div>
					                               			</td>
					                               			<td width="*">
					                               			<!-- <td width="75"> --> 
					                                   			<div id="uploaderContainer">
						                                       		<div id="uploaderOverlay" style="width:73px; height:21px; background:url(${themeURL}/images/btn/select.png)"></div>                                
					                                   			</div>
					                               			</td>
					                               			<!-- 
					                               			<td width="*">
					                                   			<div id="uploadFilesLink"><a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a></div>
					                               			</td>
					                               			 -->
					                           			</tr>
					                       			</table>
												</td>
											</tr>
			                            </tbody>
			                        </table>
                    			</td>
                   			</tr>
						</table>
                    </td>
                </tr>
                <tr>
					<td height="*" valign="top">
					</td>
				</tr>
				<tr>
					<td height="1">
						<iframe src="" id="downloadFrame" name="downloadFrame" style="width:0px;height:0px;"></iframe>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 
	 var rowCount = 0;
	 
	 // 월Shiment목표|지점(ESLT_SH_TG)
	 var fyData = new Array();
	 var periodData = new Array();
	 var branchData = new Array();
	 var productL7Data = new Array();
	 var volumeData = new Array();
	 
	 // 월DC목표|지점(ESLT_DC_TG)
	 var fyData2 = new Array();
	 var periodData2 = new Array();
	 var branchData2 = new Array();
	 var dataTypeData2 = new Array();
	 var productL2Data2 = new Array();
	 var volumeData2 = new Array();
	 
	 // 월채권목표|지점(ESLT_CD_TG)
	 var fyData3 = new Array();
	 var periodData3 = new Array();
	 var branchData3 = new Array();
	 var periodTypeData3 = new Array();
	 var branchTypeData3 = new Array();
	 var ratioData3 = new Array();
	 
	 // 월NTS목표|팀(ESLT_NTS_TG)
	 var fyData4 = new Array();
	 var periodData4 = new Array();
	 var teamData4 = new Array();
	 var marketData4 = new Array();
	 var segmentData4 = new Array();
	 var channelData4 = new Array();
	 var companyData4 = new Array();
	 var volumeData4 = new Array();
	 
	 // 월NOTEG목표|팀(ESLT_NOTEG_TG)
	 var fyData5 = new Array();
	 var periodData5 = new Array();
	 var teamData5 = new Array();
	 var marketData5 = new Array();
	 var volumeData5 = new Array();
	 var amountData5 = new Array();

	 
	/****************************************
	 * Function
	 ****************************************/
	
	$(document).ready(function() {

		window.onload = function() {
			setFyPeriod();
		};
		
		${initScript}
		
		refresh_esltTbInfo();
		refresh_fy();
		
	});
	
	function refresh_esltTbInfo() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200401S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "ESLTTBINFO");
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='esltTbInfo'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#esltTbInfo_cond").html(s);

	}
	
	function refresh_fy() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200402S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='fy'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#fy_cond").html(s);

	}
	
	function setFyPeriod() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200403S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","fy;period;");
        table.request();
        
        $("#fy").val(table.getData(0,0));
        $("#period").val(table.getData(1,0));

	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function DownloadToInput() {
		
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02004A.msg1"/>");
			$("#esltTbInfo").focus();
			return;
		}
		
		form.action = "${contextPath}/service/anl02/downloadFile_ANL02004A?"+
					"esltTbInfo="+$("#esltTbInfo").val();
		form.target = "downloadFrame";
        form.submit();
        
    }
	
	function Save() {
		
		// DATA구분 Validation
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02004A.msg1" />")
			$("#esltTbInfo").focus();
			return;
		}
		
		// 엑셀 업로드 안했을 시, "저장할 데이터가 없습니다."
		if(rowCount == "0"){
			alert("<fmt:message key="ANL02004A.msg2" />")
			return;
		}
		
		if($("#esltTbInfo").val() == "13"){
			
			for(var i=0; i<rowCount; i++) {
				if (fyData[i] == "") {alert("<fmt:message key="ANL02004A.msg3" />");return false;}
				if (periodData[i] == "") {alert("<fmt:message key="ANL02004A.msg4" />");return false;}
				if (branchData[i] == "") {alert("<fmt:message key="ANL02004A.msg5" />");return false;}
				if (productL7Data[i] == "") {alert("<fmt:message key="ANL02004A.msg6" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var branchs = new Array();
			var productL7s = new Array();
			var volumes = new Array();
			 
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData[i];
				periods[count] = periodData[i];
				branchs[count] = branchData[i];
				productL7s[count] = productL7Data[i];
				volumes[count] = volumeData[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02004A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("branchs", branchs);
			table.setParameter("productL7s", productL7s);
			table.setParameter("volumes", volumes);
			table.setParameter("esltTbInfo", $("#esltTbInfo").val());
			
			table.request();

			if(table.getData(0,0) == "S") {
				//alert(table.getData(1,0));
				alert(rowCount + "개 행이 업로드 되었습니다.");
	   		}
			else {
				alert(table.getData(1,0));
			}
			
			hideLoading();

		}else if($("#esltTbInfo").val() == "14"){
			
			for(var i=0; i<rowCount; i++) {
				if (fyData2[i] == "") {alert("<fmt:message key="ANL02004A.msg3" />");return false;}
				if (periodData2[i] == "") {alert("<fmt:message key="ANL02004A.msg4" />");return false;}
				if (branchData2[i] == "") {alert("<fmt:message key="ANL02004A.msg5" />");return false;}
				if (dataTypeData2[i] == "") {alert("<fmt:message key="ANL02004A.msg7" />");return false;}
				if (productL2Data2[i] == "") {alert("<fmt:message key="ANL02004A.msg8" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var branchs = new Array();
			var dataTypes = new Array();
			var productL2s = new Array();
			var volumes = new Array();
			 
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData2[i];
				periods[count] = periodData2[i];
				branchs[count] = branchData2[i];
				dataTypes[count] = dataTypeData2[i];
				productL2s[count] = productL2Data2[i];
				volumes[count] = volumeData2[i];
				
				count++;
				
			}
			 
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02004A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("branchs", branchs);
			table.setParameter("dataTypes", dataTypes);
			table.setParameter("productL2s", productL2s);
			table.setParameter("volumes", volumes);
			table.setParameter("esltTbInfo", $("#esltTbInfo").val());
			
			table.request();

			if(table.getData(0,0) == "S") {
				//alert(table.getData(1,0));
				alert(rowCount + "개 행이 업로드 되었습니다.");
	   		}
			else {
				alert(table.getData(1,0));
			}
			
			hideLoading();
			
		}else if($("#esltTbInfo").val() == "15"){
			
			for(var i=0; i<rowCount; i++) {
				if (fyData3[i] == "") {alert("<fmt:message key="ANL02004A.msg3" />");return false;}
				if (periodData3[i] == "") {alert("<fmt:message key="ANL02004A.msg4" />");return false;}
				if (branchData3[i] == "") {alert("<fmt:message key="ANL02004A.msg5" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var branchs = new Array();
			var periodTypes = new Array();
			var branchTypes = new Array();
			var ratios = new Array();
			 
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData3[i];
				periods[count] = periodData3[i];
				branchs[count] = branchData3[i];
				periodTypes[count] = periodTypeData3[i];
				branchTypes[count] = branchTypeData3[i];
				ratios[count] = ratioData3[i];
				
				count++;
				
			}
			 
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02004A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("branchs", branchs);
			table.setParameter("periodTypes", periodTypes);
			table.setParameter("branchTypes", branchTypes);
			table.setParameter("ratios", ratios);
			table.setParameter("esltTbInfo", $("#esltTbInfo").val());
			
			table.request();

			if(table.getData(0,0) == "S") {
				//alert(table.getData(1,0));
				alert(rowCount + "개 행이 업로드 되었습니다.");
	   		}
			else {
				alert(table.getData(1,0));
			}
			
			hideLoading();
			
		}else if($("#esltTbInfo").val() == "16"){
			
			for(var i=0; i<rowCount; i++) {
				if (fyData4[i] == "") {alert("<fmt:message key="ANL02004.msg3" />");return false;}
				if (periodData4[i] == "") {alert("<fmt:message key="ANL02004.msg4" />");return false;}
				if (teamData4[i] == "") {alert("<fmt:message key="ANL02004.msg9" />");return false;}
				if (marketData4[i] == "") {alert("<fmt:message key="ANL02004A.msg10" />");return false;}
				if (segmentData4[i] == "") {alert("<fmt:message key="ANL02004A.msg11" />");return false;}
				if (channelData4[i] == "") {alert("<fmt:message key="ANL02004A.msg12" />");return false;}
				if (companyData4[i] == "") {alert("<fmt:message key="ANL02004A.msg13" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var teams = new Array();
			var markets = new Array();
			var segments = new Array();
			var channels = new Array();
			var companys = new Array();
			var volumes = new Array();
			 
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData4[i];
				periods[count] = periodData4[i];
				teams[count] = teamData4[i];
				markets[count] = marketData4[i];
				segments[count] = segmentData4[i];
				channels[count] = channelData4[i];
				companys[count] = companyData4[i];
				volumes[count] = volumeData4[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02004A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("teams", teams);
			table.setParameter("markets", markets);
			table.setParameter("segments", segments);
			table.setParameter("channels", channels);
			table.setParameter("companys", companys);
			table.setParameter("volumes", volumes);
			table.setParameter("esltTbInfo", $("#esltTbInfo").val());
			
			table.request();

			if(table.getData(0,0) == "S") {
				//alert(table.getData(1,0));
				alert(rowCount + "개 행이 업로드 되었습니다.");
	   		}
			else {
				alert(table.getData(1,0));
			}
			
			hideLoading();
				
		}else{
			
			for(var i=0; i<rowCount; i++) {
				if (fyData5[i] == "") {alert("<fmt:message key="ANL02004.msg3" />");return false;}
				if (periodData5[i] == "") {alert("<fmt:message key="ANL02004.msg4" />");return false;}
				if (teamData5[i] == "") {alert("<fmt:message key="ANL02004.msg9" />");return false;}
				if (marketData5[i] == "") {alert("<fmt:message key="ANL02004A.msg14" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var teams = new Array();
			var markets = new Array();
			var volumes = new Array();
			var amounts = new Array();
			 
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData5[i];
				periods[count] = periodData5[i];
				teams[count] = teamData5[i];
				markets[count] = marketData5[i];
				volumes[count] = volumeData5[i];
				amounts[count] = amountData5[i];
				
				count++;
				
			}
			 
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02004A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("teams", teams);
			table.setParameter("markets", markets);
			table.setParameter("volumes", volumes);
			table.setParameter("amounts", amounts);
			table.setParameter("esltTbInfo", $("#esltTbInfo").val());
			
			table.request();

			if(table.getData(0,0) == "S") {
				//alert(table.getData(1,0));
				alert(rowCount + "개 행이 업로드 되었습니다.");
	   		}
			else {
				alert(table.getData(1,0));
			}
			
			hideLoading();
			
		}
		
	}
	
</script>

<script type="text/javascript">

	/**********************************************
	* fileupload setting
	**********************************************/
	
	// Custom URL for the uploader swf file (same folder).
	YAHOO.widget.Uploader.SWFURL = "${contextPath}/scripts/yui/build/uploader/assets/uploader.swf";
	
	// Instantiate the uploader and write it to its placeholder div.
	var uploader = new YAHOO.widget.Uploader( "uploaderOverlay" );
	
	uploader.addListener('contentReady', handleContentReady);
	uploader.addListener('fileSelect', onFileSelect)
	uploader.addListener('uploadStart', onUploadStart);
	uploader.addListener('uploadProgress', onUploadProgress);
	uploader.addListener('uploadCancel', onUploadCancel);
	uploader.addListener('uploadComplete', onUploadComplete);
	uploader.addListener('uploadCompleteData', onUploadResponse);
	uploader.addListener('uploadError', onUploadError);
	uploader.addListener('rollOver', handleRollOver);
	uploader.addListener('rollOut', handleRollOut);
	uploader.addListener('click', handleClick);
	    
	// Variable for holding the selected file id.
	var fileID;
	
	// When the mouse rolls over the uploader, this function
	// is called in response to the rollOver event.
	// It changes the appearance of the UI element below the Flash overlay.
	function handleRollOver () {
	    YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('selectLink'), 'color', "#FFFFFF");
	    YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('selectLink'), 'background-color', "#000000");
	}
	
	// On rollOut event, this function is called, which changes the appearance of the
	// UI element below the Flash layer back to its original state.
	function handleRollOut () {
	    YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('selectLink'), 'color', "#0000CC");
	    YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('selectLink'), 'background-color', "#FFFFFF");
	}
	
	// When the Flash layer is clicked, the "Browse" dialog is invoked.
	// The click event handler allows you to do something else if you need to.
	function handleClick () {
		clear();
	}
	
	// When contentReady event is fired, you can call methods on the uploader.
	function handleContentReady () {
	    // Allows the uploader to send log messages to trace, as well as to YAHOO.log
	    uploader.setAllowLogging(true);
	    
	    // Disallows multiple file selection in "Browse" dialog.
	    uploader.setAllowMultipleFiles(false);
	    
	    // New set of file filters.
		//     var ff = new Array({description:"All(*.*)", extensions:"*"},
		//             		   {description:"Images", extensions:"*.jpg;*.png;*.gif"},
		//                        {description:"Videos", extensions:"*.avi;*.mov;*.mpg"});
	    
	    var ff = new Array({description:"Excel", extensions:"*.xls;*.xlsx"});
	                       
	    // Apply new set of file filters to the uploader.
	    uploader.setFileFilters(ff);
	}
	
	// Actually uploads the files. Since we are only allowing one file
	// to be selected, we use the upload function, in conjunction with the id 
	// of the selected file (returned by the fileSelect event). We are also including
	// the text of the variables specified by the user in the input UI.
	function upload() {
		
		// DATA구분 Validation
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02001A.msg1" />")
			$("#esltTbInfo").focus();
			return;
		}
		
		if (fileID != null && fileID != "") {
	    	showLoading();
	    	uploader.upload(fileID, "${contextPath}/service/anl02/extract_ANL02004A_Xls"
	    			, "POST"
	    			, {esltTbInfo:document.getElementById("esltTbInfo").value});
	    }
	    
	}
	
	// Fired when the user selects files in the "Browse" dialog
	// and clicks "Ok". Here, we set the value of the progress
	// report textfield to reflect the fact that a file has been
	// selected.
	
	function onFileSelect(event) {
	    for (var file in event.fileList) {
	        if(YAHOO.lang.hasOwnProperty(event.fileList, file)) {
	            fileID = event.fileList[file].id;
	        }
	    }
	    
	    this.progressReport = document.getElementById("progressReport");
	    this.progressReport.value = "Selected " + event.fileList[fileID].name;
	    $("#fileName").val(event.fileList[fileID].name);
	    
	    upload();
	    
	}
	
	
	// When the upload starts, we inform the user about it via
	// the progress report textfield. 
	function onUploadStart(event) {
	    this.progressReport.value = "Starting upload...";
	}
	
	// As upload progresses, we report back to the user via the
	// progress report textfield.
	function onUploadProgress(event) {
	    prog = Math.round(100*(event["bytesLoaded"]/event["bytesTotal"]));
	    this.progressReport.value = prog + "% uploaded...";
	}
	
	// Report back to the user that the upload has completed.
	function onUploadComplete(event) {
		this.progressReport.value = $("#fileName").val();
	    //this.progressReport.value = "Upload complete.";
	}
	
	// Report back to the user if there has been an error.
	function onUploadError(event) {
	    this.progressReport.value = "Upload error.";
	}
	
	// Do something if an upload is canceled.
	function onUploadCancel(event) {
	
	}
	
	function onUploadResponse(event) {
		
		hideLoading();
		
		eval("var fileData = " + event.data);	
      	
		if(fileData.errorCode == "E"){
			alert(fileData.errorMessage);
			$("#progressReport").val("");
			return;
		}else{
		
			if($("#esltTbInfo").val() == "13"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData[i] = fileData.fy[i];
		     			periodData[i] = fileData.period[i];
		     			branchData[i] = fileData.branch[i];
		     			productL7Data[i] = fileData.productL7[i];
		     			volumeData[i] = fileData.volume[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
			
			}else if($("#esltTbInfo").val() == "14"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData2[i] = fileData.fy[i];
		     			periodData2[i] = fileData.period[i];
		     			branchData2[i] = fileData.branch[i];
		     			dataTypeData2[i] = fileData.dataType[i];
		     			productL2Data2[i] = fileData.productL2[i];
		     			volumeData2[i] = fileData.volume[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
		     	
			}else if($("#esltTbInfo").val() == "15"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData3[i] = fileData.fy[i];
		     			periodData3[i] = fileData.period[i];
		     			branchData3[i] = fileData.branch[i];
		     			periodTypeData3[i] = fileData.periodType[i];
		     			branchTypeData3[i] = fileData.branchType[i];
		     			ratioData3[i] = fileData.ratio[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
		     	
			}else if($("#esltTbInfo").val() == "16"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData4[i] = fileData.fy[i];
		     			periodData4[i] = fileData.period[i];
		     			teamData4[i] = fileData.team[i];
		     			marketData4[i] = fileData.market[i];
		     			segmentData4[i] = fileData.segment[i];
		     			channelData4[i] = fileData.channel[i];
		     			companyData4[i] = fileData.company[i];
		     			volumeData4[i] = fileData.volume[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
		     	
			}else{
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData5[i] = fileData.fy[i];
		     			periodData5[i] = fileData.period[i];
		     			teamData5[i] = fileData.team[i];
		     			marketData5[i] = fileData.market[i];
		     			volumeData5[i] = fileData.volume[i];
		     			amountData5[i] = fileData.amount[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
			}
		}
	}
</script>