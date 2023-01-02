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
											<col style="width:150px"></col>
											<col style="width:245px"></col>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required"><fmt:message key="ANL02008A.esltTbInfo"/>
												</td>
												<td class="td-input">
													<div id="esltTbInfo_cond" style="float:left;">
														<select id="esltTbInfo">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
												</td>
												<td class="td-cond-required"><fmt:message key="ANL02008A.team"/>
												</td>
												<td class="td-input">
													<div id="team_cond" style="float:left;">
														<select id="team">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="ANL02008A.dataUploadYn"/>
												</td>
												<td class="td-input" colspan="3">
													<input type="text" id="dataUploadUseYn" style="width:50px;" class="input-readonly" disabled>
													<input type="hidden" id="dataUploadUseYn_h">
													<span id="msg" style="color: red;font: bold;">
														<fmt:message key="ANL02008A.dataUploadMsg"/>
													</span>
			                               		</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="uploadFile"/></td>
												<td class="td-input" colspan="3">
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
	 
	rowCount = 0;
	 
	// 월NTS Outlook|팀(ESLT_NTS_FC)
	var fyData = new Array();
	var periodData = new Array();
	var teamData = new Array();
	var marketData = new Array();
	var segmentData = new Array();
	var channelData = new Array();
	var companyData = new Array();
	var forVolumeData = new Array();
	var outVolumeData = new Array();
	 
	// 월NOTEG Outlook|팀(ESLT_NOTEG_FC)
	var fyData2 = new Array();
	var periodData2 = new Array();
	var teamData2 = new Array();
	var marketData2 = new Array();
	var forVolumeData2 = new Array();
	var outVolumeData2 = new Array();
	var forAmountData2 = new Array();
	var outAmountData2 = new Array();

	
	/****************************************
	 * Function
	 ****************************************/
	
	$(document).ready(function() {

		window.onload = function() {
			
		};
		
		${initScript}
		
		refresh_esltTbInfo();
		refresh_team();
		refresh_dataUpload();
		
	});
	
	function refresh_esltTbInfo() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200801S");
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
	
	function refresh_team() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200802S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","teamCd;teamNm;");
        if("${params.grpID}" != '000001'){
	        table.setParameter("empID", "${params.userID}");
        }
        table.request();
        
        var rowCount = table.getCount();
       
        if (rowCount > 0) {
			if(rowCount == 1){
				var s = "<select id='team' class='input-readonly' disabled>";
				for (i=0; i < rowCount; i++) {
				       s = s + '<option value="' + table.getData(0,0) + '">'+table.getData(1,0)+'</option>';
				}
        	}else{
        		var s = "<select id='team'><option value=''><fmt:message key="select"/></option>";
				for (i=0; i < rowCount; i++) {
				       s = s + '<option value="' + table.getData(0,i) + '">'+table.getData(1,i)+'</option>';
				}
        	}
        }
        s = s + '</select>';
        
        $("#team_cond").html(s);

	}
	
	function refresh_dataUpload() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200803S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","UesYnNm;UesYn;");
        table.request();
        
        var rowCount = table.getCount();
       
        if (rowCount > 0) {
        	$("#dataUploadUseYn").val(table.getData(0,0));
        	$("#dataUploadUseYn_h").val(table.getData(1,0));
        }

	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function DownloadToInput() {
		
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02008A.msg1"/>");
			$("#esltTbInfo").focus();
			return;
		}
		
		form.action = "${contextPath}/service/anl02/downloadFile_ANL02008A?"+
					"esltTbInfo="+$("#esltTbInfo").val();
		form.target = "downloadFrame";
        form.submit();
        
    }
	
	function Save() {
		
		// DATA구분 Validation
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02006A.msg1" />")
			$("#esltTbInfo").focus();
			return;
		}
		
		// Data 업로드 가능 여부
		if($("#dataUploadUseYn_h").val() == "N"){
			alert("<fmt:message key="ANL02008A.msg4" />")
			return;
		}
		
		// 지점 Validation
		if($("#branch").val() == ""){
			alert("<fmt:message key="ANL02006A.msg3" />")
			$("#branch").focus();
			return;
		}
		
		// 엑셀 업로드 안했을 시, "저장할 데이터가 없습니다."
		if(rowCount == "0"){
			alert("<fmt:message key="ANL02006A.msg2" />")
			return;
		}
		
		if($("#esltTbInfo").val() == "26"){
			
			for(var i=0; i<rowCount; i++) {
				if (fyData[i] == "") {alert("<fmt:message key="ANL02007A.msg4" />");return false;}
				if (periodData[i] == "") {alert("<fmt:message key="ANL02007A.msg5" />");return false;}
				if (marketData[i] == "") {alert("<fmt:message key="ANL02007A.msg6" />");return false;}
				if (segmentData[i] == "") {alert("<fmt:message key="ANL02007A.msg7" />");return false;}
				if (channelData[i] == "") {alert("<fmt:message key="ANL02007A.msg8" />");return false;}
				if (companyData[i] == "") {alert("<fmt:message key="ANL02007A.msg9" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var teams = new Array();
			var markets = new Array();
			var segments = new Array();
			var channels = new Array();
			var companys = new Array();
			var outVolumes = new Array();
			
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData[i];
				periods[count] = periodData[i];
				teams[count] = $("#team").val();
				markets[count] = marketData[i];
				segments[count] = segmentData[i];
				channels[count] = channelData[i];
				companys[count] = companyData[i];
				outVolumes[count] = outVolumeData[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02008A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("teams", teams);
			table.setParameter("markets", markets);
			table.setParameter("segments", segments);
			table.setParameter("channels", channels);
			table.setParameter("companys", companys);
			table.setParameter("outVolumes", outVolumes);
			table.setParameter("esltTbInfo", $("#esltTbInfo").val());
			
			table.request();

			if(table.getData(0,0) == "S") {
				//alert(table.getData(1,0));
				alert(rowCount + "개 행이 업로드 되었습니다.");
	   		}
			else {
				alert(table.getData(1,0));
			}

		}else{
			
			for(i=0; i<rowCount; i++) {
				if (fyData2[i] == "") {alert("<fmt:message key="ANL02007.msg4" />");return false;}
				if (periodData2[i] == "") {alert("<fmt:message key="ANL02007.msg5" />");return false;}
				if (marketData2[i] == "") {alert("<fmt:message key="ANL02007.msg6" />");return false;}
			}
			
			var fys = new Array();
			var periods = new Array();
			var teams = new Array();
			var markets = new Array();
			var outVolumes = new Array();
			var outAmounts = new Array();
			
			var count = 0;
			
			for (i = 0; i < rowCount; i++) {
				
				fys[count] = fyData2[i];
				periods[count] = periodData2[i];
				teams[count] = $("#team").val();
				markets[count] = marketData2[i];
				outVolumes[count] = outVolumeData2[i];
				outAmounts[count] = outAmountData2[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02008A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("teams", teams);
			table.setParameter("markets", markets);
			table.setParameter("outVolumes", outVolumes);
			table.setParameter("outAmounts", outAmounts);
			table.setParameter("esltTbInfo", $("#esltTbInfo").val());
			
			table.request();
			
			if(table.getData(0,0) == "S") {
				//alert(table.getData(1,0));
				alert(rowCount + "개 행이 업로드 되었습니다.");
	   		}
			else {
				alert(table.getData(1,0));
			}
			
		}
		
		hideLoading();
		
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
		//     ff = new Array({description:"All(*.*)", extensions:"*"},
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
		
		// Data 업로드 가능 여부
		if($("#dataUploadUseYn_h").val() == "N"){
			alert("<fmt:message key="ANL02008A.msg4" />")
			return;
		}
		
		if (fileID != null && fileID != "") {
	    	showLoading();
	    	uploader.upload(fileID, "${contextPath}/service/anl02/extract_ANL02008A_Xls"
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
			if($("#esltTbInfo").val() == "26"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData[i] = fileData.fy[i];
		     			periodData[i] = fileData.period[i];
		     			marketData[i] = fileData.market[i];
		     			segmentData[i] = fileData.segment[i];
		     			channelData[i] = fileData.channel[i];
		     			companyData[i] = fileData.company[i];
		     			outVolumeData[i] = fileData.outVolume[i];
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
		     			fyData2[i] = fileData.fy[i];
		     			periodData2[i] = fileData.period[i];
		     			marketData2[i] = fileData.market[i];
		     			outVolumeData2[i] = fileData.outVolume[i];
		     			outAmountData2[i] = fileData.outAmount[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
		     	
			}
		}
	}
</script>