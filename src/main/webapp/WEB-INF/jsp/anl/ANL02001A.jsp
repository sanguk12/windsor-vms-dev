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
												<td class="td-cond-required"><fmt:message key="ANL02001A.esltTbInfo"/>
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
	 
	 // 지점정보
	 var branchData = new Array();
	 var regionData = new Array();
	 var channelData = new Array();
	 var dispseqData = new Array();
	 var empidData = new Array();
	 var empid1Data = new Array();
	 var useynData = new Array();
	 
	 // 거래처정보
	 var customerCdData = new Array();
	 var branchData2 = new Array();
	 
	 // 제품정보
	 var productL7Data = new Array();
	 var productL2Data = new Array();
	 var productL3Data = new Array();
	 var productL6Data = new Array();
	 var esltProductData = new Array();
	 var esltProduct2Data = new Array();
	 
	 // 대표품목조회
	 var dataLv2 = new Array();
	 var esltProductData2 = new Array();
	 var dispSeqData = new Array();
	 
	/****************************************
	 * Function
	 ****************************************/
	
	$(document).ready(function() {

		window.onload = function() {
			
		};
		
		${initScript}
		
		refresh_esltTbInfo();

	});
	
	function refresh_esltTbInfo() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200101S");
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
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function DownloadToInput() {
		
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02001A.msg1"/>");
			$("#esltTbInfo").focus();
			return;
		}
		
		form.action = "${contextPath}/service/anl02/downloadFile_ANL02001A?"+
					"esltTbInfo="+$("#esltTbInfo").val();
		form.target = "downloadFrame";
        form.submit();
        
    }
	
	function Save() {
		
		// DATA구분 Validation
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02001A.msg1" />")
			$("#esltTbInfo").focus();
			return;
		}
		
		// 엑셀 업로드 안했을 시, "저장할 데이터가 없습니다."
		if(rowCount == "0"){
			alert("<fmt:message key="ANL02001A.msg3" />")
			return;
		}
		
		if($("#esltTbInfo").val() == "1"){
			
			for(var i=0; i<rowCount; i++) {
				if (branchData[i] == "") {alert("<fmt:message key="ANL02001A.msg2" />");return false;}
			}
			
			showLoading();
			
			var branchs = new Array();
			var regions = new Array();
			var channels = new Array();
			var dispseqs = new Array();
			var empids = new Array();
			var empid1s = new Array();
			var useyns = new Array();
			
			var count = 0;
			
			for(var i=0; i<rowCount; i++) {
				
				branchs[count] = branchData[i];
				regions[count] = regionData[i];
				channels[count] = channelData[i];
				dispseqs[count] = dispseqData[i];
				empids[count] = empidData[i];
				empid1s[count] = empid1Data[i];
				useyns[count] = useynData[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02001A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("branchs", branchs);
			table.setParameter("regions", regions);
			table.setParameter("channels", channels);
			table.setParameter("dispseqs", dispseqs);
			table.setParameter("empids", empids);
			table.setParameter("empid1s", empid1s);
			table.setParameter("useyns", useyns);
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

		}else if($("#esltTbInfo").val() == "2"){
			
			for(var i=0; i<rowCount; i++) {
				if (customerCdData[i] == "") {alert("<fmt:message key="ANL02001A.msg4" />");return false;}
			}
			
			showLoading();
			
			var customerCds = new Array();
			var branchs = new Array();
			
			var count = 0;

			for (var i = 0; i < rowCount; i++) {
				
				customerCds[count] = customerCdData[i];
				branchs[count] = branchData2[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02001A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("customerCds", customerCds);
			table.setParameter("branchs", branchs);
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
			
		}else if($("#esltTbInfo").val() == "3"){
			
			for(var i=0; i<rowCount; i++) {
				if (productL7Data[i] == "") {alert("<fmt:message key="ANL02001A.msg5" />");return false;}
			}
			
			showLoading();
			
			var productL7s = new Array();
			var productL2s = new Array();
			var productL3s = new Array();
			var productL6s = new Array();
			var esltProducts = new Array();
			var esltProduct2s = new Array();
			
			var count = 0;

			for (var i = 0; i < rowCount; i++) {
				
				productL7s[count] = productL7Data[i];
				productL2s[count] = productL2Data[i];
				productL3s[count] = productL3Data[i];
				productL6s[count] = productL6Data[i];
				esltProducts[count] = esltProductData[i];
				esltProduct2s[count] = esltProduct2Data[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02001A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("productL7s", productL7s);
			table.setParameter("productL2s", productL2s);
			table.setParameter("productL3s", productL3s);
			table.setParameter("productL6s", productL6s);
			table.setParameter("esltProducts", esltProducts);
			table.setParameter("esltProduct2s", esltProduct2s);
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
				if (esltProductData2[i] == "") {alert("<fmt:message key="ANL02001A.msg6" />");return false;}
			}
			
			showLoading();
			
			var dataLv2s = new Array();
			var esltProducts = new Array();
			var dispSeqs = new Array();
			
			var count = 0;

			for (var i = 0; i < rowCount; i++) {
				
				dataLv2s[count] = dataLv2[i];
				esltProducts[count] = esltProductData2[i];
				dispSeqs[count] = dispSeqData[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02001A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("dataLv2s", dataLv2s);
			table.setParameter("esltProducts", esltProducts);
			table.setParameter("dispSeqs", dispSeqs);
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
	    	uploader.upload(fileID, "${contextPath}/service/anl02/extract_ANL02001A_Xls"
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
      	
		if($("#esltTbInfo").val() == "1"){
			
			rowCount = fileData.branch.length;
			
			var data = new Array(new Array(), new Array());
	     	if(rowCount > 0) {
	     		for(var i = 0; i < rowCount; i++) {
					branchData[i] = fileData.branch[i];
					regionData[i] = fileData.region[i];
					channelData[i] = fileData.channel[i];
					dispseqData[i] = fileData.dispseq[i];
					empidData[i] = fileData.empid[i];
					empid1Data[i] = fileData.empid1[i];
					useynData[i] = fileData.useyn[i];
	     		}
	     		
	     	}else {
	      		message('<fmt:message key="info.nullData"/>');
	      		alert(fileData.errorCode);
	      	}
		
		}else if($("#esltTbInfo").val() == "2"){
			
			rowCount = fileData.customerCd.length;
			
			var data = new Array(new Array(), new Array());
	     	if(rowCount > 0) {
	     		for(var i = 0; i < rowCount; i++) {
	     			customerCdData[i] = fileData.customerCd[i];
	    			branchData2[i] = fileData.branch[i];
	     		}
	     	}else {
	      		message('<fmt:message key="info.nullData"/>');
	      		alert(fileData.errorCode);
	      	}
			
		}else if($("#esltTbInfo").val() == "3"){
			
			rowCount = fileData.productL7.length;
			
			var data = new Array(new Array(), new Array());
	     	if(rowCount > 0) {
	     		for(var i = 0; i < rowCount; i++) {
	     			productL7Data[i] = fileData.productL7[i];
	    			productL2Data[i] = fileData.productL2[i];
	    			productL3Data[i] = fileData.productL3[i];
	    			productL6Data[i] = fileData.productL6[i];
	    			esltProductData[i] = fileData.esltProduct[i];
	    			esltProduct2Data[i] = fileData.esltProduct2[i];
	     		}
	     	}else {
	      		message('<fmt:message key="info.nullData"/>');
	      		alert(fileData.errorCode);
	      	}
		
		}else{
			
			rowCount = fileData.esltProduct.length;
			
			var data = new Array(new Array(), new Array());
	     	if(rowCount > 0) {
	     		for(var i = 0; i < rowCount; i++) {
	     			dataLv2[i] = fileData.dataLv2[i];
	     			esltProductData2[i] = fileData.esltProduct[i];
	    			dispSeqData[i] = fileData.dispSeq[i];
	     		}
	     	}else {
	      		message('<fmt:message key="info.nullData"/>');
	      		alert(fileData.errorCode);
	      	}
			
		}
      		
	}
</script>