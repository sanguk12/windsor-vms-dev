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
											<col style="width:245px"></col>
											<col style="width:100px"></col>
											<col style="width:60px"></col>
											<col style="width:100px"></col>
											<col style="width:60px"></col>
											<col style="width:100px"></col>
											<col style="width:60px"></col>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required"><fmt:message key="ANL02005A.esltTbInfo"/>
												</td>
												<td class="td-input">
													<div id="esltTbInfo_cond" style="float:left;">
														<select id="esltTbInfo">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
												</td>
												<td class="td-cond-required"><fmt:message key="ANL02005A.branch"/>
												</td>
												<td class="td-input" colspan="7">
													<div id="branch_cond" style="float:left;">
													</div>
												</td>
											</tr>
											<tr>
												<td class="td-cond" colspan="2"><fmt:message key="ANL02005A.quarterUploadYn"/>
												</td>
												<td class="td-cond"><fmt:message key="ANL02005A.quarter1"/>
												</td>
												<td class="td-input">
													<input type="text" id="quarter1UseYn" style="width:50px;" class="input-readonly" disabled>
													<input type="hidden" id="quarter1UseYn_h">
			                               		</td>
												<td class="td-cond"><fmt:message key="ANL02005A.quarter2"/>
												</td>
												<td class="td-input">
													<input type="text" id="quarter2UseYn" style="width:50px;" class="input-readonly" disabled>
													<input type="hidden" id="quarter2UseYn_h">
			                               		</td>
												<td class="td-cond"><fmt:message key="ANL02005A.quarter3"/>
												</td>
												<td class="td-input">
													<input type="text" id="quarter3UseYn" style="width:50px;" class="input-readonly" disabled>
													<input type="hidden" id="quarter3UseYn_h">
			                               		</td>
												<td class="td-cond"><fmt:message key="ANL02005A.quarter4"/>
												</td>
												<td class="td-input">
													<input type="text" id="quarter4UseYn" style="width:50px;" class="input-readonly" disabled>
													<input type="hidden" id="quarter4UseYn_h">
			                               		</td>
											</tr>
											<tr>
												<td class="td-input" colspan="10">
													<div id="msg" style="color: red;font: bold;">
														<fmt:message key="ANL02005A.quarterMsg"/>
													</div>
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="uploadFile"/></td>
												<td class="td-input" colspan="9">
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
	 
	// 월Shipment Forecast|지점(ESLT_SH_FC)
	var fyData = new Array();
	var periodData = new Array();
	var branchData = new Array();
	var esltProductData = new Array();
	var productL2Data = new Array();
	var productL3Data = new Array();
	var forVolumeData = new Array();
	var outVolumeData = new Array();
	 
	// 월DC Forecast |지점(ESLT_DC_FC)
	var fyData2 = new Array();
	var periodData2 = new Array();
	var branchData2 = new Array();
	var dataTypeData2 = new Array();
	var productL2Data2 = new Array();
	var forVolumeData2 = new Array();
	var outVolumeData2 = new Array();
	 
	// 월채권 Forecast |지점(ESLT_CD_FC)
	var fyData3 = new Array();
	var periodData3 = new Array();
	var branchData3 = new Array();
	var dataTypeData3 = new Array();
	var forVolumeData3 = new Array();
	var outVolumeData3 = new Array();
	 
	 
	/****************************************
	 * Function
	 ****************************************/
	
	$(document).ready(function() {

		window.onload = function() {
			
		};
		
		${initScript}
		
		refresh_esltTbInfo();
		refresh_branch();
		refresh_quarter();
	});
	
	function refresh_esltTbInfo() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200501S");
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
	 
	function refresh_branch() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200502S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","branchCd;branchNm;");
        if("${params.grpID}" != '000001'){
	        table.setParameter("empID", "${params.userID}");
        }
        table.request();
        
        var rowCount = table.getCount();
       
        if (rowCount > 0) {
			if(rowCount == 1){
				var s = "<select id='branch' class='input-readonly' disabled>";
				for (i=0; i < rowCount; i++) {
				       s = s + '<option value="' + table.getData(0,0) + '">'+table.getData(1,0)+'</option>';
				}
        	}else{
        		var s = "<select id='branch'><option value=''><fmt:message key="select"/></option>";
				for (i=0; i < rowCount; i++) {
				       s = s + '<option value="' + table.getData(0,i) + '">'+table.getData(1,i)+'</option>';
				}
        	}
        }
        s = s + '</select>';
        
        $("#branch_cond").html(s);

	}
	
	function refresh_quarter() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200503S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","UesYnNm;UesYn;");
        table.request();
        
        var rowCount = table.getCount();
      
        if (rowCount > 0) {
        	$("#quarter1UseYn").val(table.getData(0,0));
        	$("#quarter2UseYn").val(table.getData(0,1));
        	$("#quarter3UseYn").val(table.getData(0,2));
        	$("#quarter4UseYn").val(table.getData(0,3));
        	
        	$("#quarter1UseYn_h").val(table.getData(1,0));
        	$("#quarter2UseYn_h").val(table.getData(1,1));
        	$("#quarter3UseYn_h").val(table.getData(1,2));
        	$("#quarter4UseYn_h").val(table.getData(1,3));
        }

	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function DownloadToInput() {
		
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02005A.msg1"/>");
			$("#esltTbInfo").focus();
			return;
		}
		
		form.action = "${contextPath}/service/anl02/downloadFile_ANL02005A?"+
					"esltTbInfo="+$("#esltTbInfo").val();
		form.target = "downloadFrame";
        form.submit();
        
    }
	
	function Save() {
		
		// DATA구분 Validation
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02005A.msg1" />")
			$("#esltTbInfo").focus();
			return;
		}
		
		// 지점 Validation
		if($("#branch").val() == ""){
			alert("<fmt:message key="ANL02005A.msg5" />")
			$("#branch").focus();
			return;
		}
		
		// 엑셀 업로드 안했을 시, "저장할 데이터가 없습니다."
		if(rowCount == "0"){
			alert("<fmt:message key="ANL02005A.msg2" />")
			return;
		}
		
		if($("#esltTbInfo").val() == "18"){
			
			for(var i=0; i<rowCount; i++) {
				if (fyData[i] == "") {alert("<fmt:message key="ANL02005A.msg3" />");return false;}
				if (periodData[i] == "") {alert("<fmt:message key="ANL02005A.msg4" />");return false;}
				if (esltProductData[i] == "") {alert("<fmt:message key="ANL02005A.msg6" />");return false;}
				if (productL2Data[i] == "") {alert("<fmt:message key="ANL02005A.msg7" />");return false;}
				if (productL3Data[i] == "") {alert("<fmt:message key="ANL02005A.msg8" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var branchs = new Array();
			var esltProducts = new Array();
			var productL2s = new Array();
			var productL3s = new Array();
			var forVolumes = new Array();
			var outVolumes = new Array();
			
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData[i];
				periods[count] = periodData[i];
				branchs[count] = $("#branch").val();
				esltProducts[count] = esltProductData[i];
				productL2s[count] = productL2Data[i];
				productL3s[count] = productL3Data[i];
				forVolumes[count] = forVolumeData[i];
				outVolumes[count] = outVolumeData[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02005A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("branchs", branchs);
			table.setParameter("esltProducts", esltProducts);
			table.setParameter("productL2s", productL2s);
			table.setParameter("productL3s", productL3s);
			table.setParameter("forVolumes", forVolumes);
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
			
			hideLoading();

		}else if($("#esltTbInfo").val() == "19"){
			
			for(i=0; i<rowCount; i++) {
				if (fyData2[i] == "") {alert("<fmt:message key="ANL02005A.msg3" />");return false;}
				if (periodData2[i] == "") {alert("<fmt:message key="ANL02005A.msg4" />");return false;}
				if (dataTypeData2[i] == "") {alert("<fmt:message key="ANL02005A.msg9" />");return false;}
				if (productL2Data2[i] == "") {alert("<fmt:message key="ANL02005A.msg7" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var branchs = new Array();
			var dataTypes = new Array();
			var productL2s = new Array();
			var forVolumes = new Array();
			var outVolumes = new Array();
			
			var count = 0;
			
			for (i = 0; i < rowCount; i++) {
				
				fys[count] = fyData2[i];
				periods[count] = periodData2[i];
				branchs[count] = $("#branch").val();
				dataTypes[count] = dataTypeData2[i];
				productL2s[count] = productL2Data2[i];
				forVolumes[count] = forVolumeData2[i];
				outVolumes[count] = outVolumeData2[i];
				
				count++;
				
			}
			 
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02005A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("branchs", branchs);
			table.setParameter("dataTypes", dataTypes);
			table.setParameter("productL2s", productL2s);
			table.setParameter("forVolumes", forVolumes);
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
			
			hideLoading();
			
		}else{
			
			for(i=0; i<rowCount; i++) {
				if (fyData3[i] == "") {alert("<fmt:message key="ANL02005.msg3" />");return false;}
				if (periodData3[i] == "") {alert("<fmt:message key="ANL02005.msg4" />");return false;}
				if (dataTypeData3[i] == "") {alert("<fmt:message key="ANL02005.msg10" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var branchs = new Array();
			var dataTypes = new Array();
			var forVolumes = new Array();
			var outVolumes = new Array();
			
			var count = 0;
			
			for (i = 0; i < rowCount; i++) {
				
				fys[count] = fyData3[i];
				periods[count] = periodData3[i];
				branchs[count] = $("#branch").val();
				dataTypes[count] = dataTypeData3[i];
				forVolumes[count] = forVolumeData3[i];
				outVolumes[count] = outVolumeData3[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02005A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("branchs", branchs);
			table.setParameter("dataTypes", dataTypes);
			table.setParameter("forVolumes", forVolumes);
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
		
		if (fileID != null && fileID != "") {
			showLoading();
	    	uploader.upload(fileID, "${contextPath}/service/anl02/extract_ANL02005A_Xls"
	    			, "POST"
	    			, {esltTbInfo:document.getElementById("esltTbInfo").value
	    			, quarter1UseYn_h:document.getElementById("quarter1UseYn_h").value
	    			, quarter2UseYn_h:document.getElementById("quarter2UseYn_h").value
	    			, quarter3UseYn_h:document.getElementById("quarter3UseYn_h").value
	    			, quarter4UseYn_h:document.getElementById("quarter4UseYn_h").value});
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
			if($("#esltTbInfo").val() == "18"){
				
				rowCount = fileData.fy.length;
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData[i] = fileData.fy[i];
		     			periodData[i] = fileData.period[i];
		     			esltProductData[i] = fileData.esltProduct[i];
		     			productL2Data[i] = fileData.productL2[i];
		     			productL3Data[i] = fileData.productL3[i];
		     			forVolumeData[i] = fileData.forVolume[i];
		     			outVolumeData[i] = fileData.outVolume[i];
		     		}
		     		
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
			
			}else if($("#esltTbInfo").val() == "19"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData2[i] = fileData.fy[i];
		     			periodData2[i] = fileData.period[i];
		     			dataTypeData2[i] = fileData.dataType[i];
		     			productL2Data2[i] = fileData.productL2[i];
		     			forVolumeData2[i] = fileData.forVolume[i];
		     			outVolumeData2[i] = fileData.outVolume[i];
		     			
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
		     			fyData3[i] = fileData.fy[i];
		     			periodData3[i] = fileData.period[i];
		     			dataTypeData3[i] = fileData.dataType[i];
		     			forVolumeData3[i] = fileData.forVolume[i];
		     			outVolumeData3[i] = fileData.outVolume[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
			}
		}
	}
</script>