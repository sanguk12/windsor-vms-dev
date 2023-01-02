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
											<col style="width:470px"></col>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required"><fmt:message key="ANL02003A.fy"/>
												</td>
												<td class="td-input">
													<div id="fy_cond" style="float:left;">
														<select id="fy">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
												</td>
												<td class="td-cond-required"><fmt:message key="ANL02003A.period"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="period" name="period" defaultText="all" category="ESLT_PERIOD" />
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="ANL02003A.esltTbInfo"/>
												</td>
												<td class="td-input" colspan="3">
													<div id="esltTbInfo_cond" style="float:left;">
														<select id="esltTbInfo">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
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
	 
	 var rowCount = 0;
	 
	 // 월Shipment실적|도매상(ESLT_SH_ACT)
	 var fyData = new Array();
	 var periodData = new Array();
	 var customercdData = new Array();
	 var productL7Data = new Array();
	 var productL8Data = new Array();
	 var volumeData = new Array();
	 var amountData = new Array();
	 
	 // 월DC실적|도매상(ESLT_DC_ACT)
	 var fyData2 = new Array();
	 var periodData2 = new Array();
	 var customercdData2 = new Array();
	 var productL2Data2 = new Array();
	 var productL7Data2 = new Array();
	 var volumeData2 = new Array();
	 
	 // 월DC예상실적|지점(ESLT_DC_FCACT)
	 var fyData3 = new Array();
	 var periodData3 = new Array();
	 var branchData3 = new Array();
	 var datatypeData3 = new Array();
	 var productL2Data3 = new Array();
	 var volumeData3 = new Array();
	
	 // 월채권금액|도매상(ESLT_CD_ACT)
	 var fyData4 = new Array();
	 var periodData4 = new Array();
	 var customercdData4 = new Array();
	 var datatypeData4 = new Array();
	 var volumeData4 = new Array();
	
	 // 월NTS실적|주소(ESLT_NTS_ACT)
	 var fyData5 = new Array();
	 var periodData5 = new Array();
	 var cityData5 = new Array();
	 var subcity1Data5 = new Array();
	 var subcity2Data5 = new Array();
	 var marketData5 = new Array();
	 var segmentData5 = new Array();
	 var channelData5 = new Array();
	 var companyData5 = new Array();
	 var volumeData5 = new Array();
	
	 // 월NOTEG실적|주소(ESLT_NOTEG_ACT)
	 var fyData6 = new Array();
	 var periodData6 = new Array();
	 var venueIDData6 = new Array();
	 var cityData6 = new Array();
	 var subCity1Data6 = new Array();
	 var subCity2Data6 = new Array();
	 var marketData6 = new Array();
	 var productL7Data6 = new Array();
	 var volumeData6 = new Array();
	 var amountData6 = new Array();
	 
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
    	table.setURL("${contextPath}/service/simpleAction/ANL0200301S");
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
    	table.setURL("${contextPath}/service/simpleAction/ANL0200302S");
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
    	table.setURL("${contextPath}/service/simpleAction/ANL0200303S");
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
			alert("<fmt:message key="ANL02003A.msg1"/>");
			$("#esltTbInfo").focus();
			return;
		}
		
		form.action = "${contextPath}/service/anl02/downloadFile_ANL02003A?"+
					"esltTbInfo="+$("#esltTbInfo").val();
		form.target = "downloadFrame";
        form.submit();
        
    }
	
	function Save() {
		
		// DATA구분 Validation
		if($("#esltTbInfo").val() == ""){
			alert("<fmt:message key="ANL02003A.msg1" />")
			$("#esltTbInfo").focus();
			return;
		}
		
		// 엑셀 업로드 안했을 시, "저장할 데이터가 없습니다."
		if(rowCount == "0"){
			alert("<fmt:message key="ANL02003A.msg2" />")
			return;
		}
		
		if($("#esltTbInfo").val() == "7"){
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var customercds = new Array();
			var productL7s = new Array();
			var productL8s = new Array();
			var volumes = new Array();
			var amounts = new Array();
			
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData[i];
				periods[count] = periodData[i];
				customercds[count] = customercdData[i];
				productL7s[count] = productL7Data[i];
				productL8s[count] = productL8Data[i];
				volumes[count] = volumeData[i];
				amounts[count] = amountData[i];
				
				count++;
				
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02003A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("customercds", customercds);
			table.setParameter("productL7s", productL7s);
			table.setParameter("productL8s", productL8s);
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

		}else if($("#esltTbInfo").val() == "8"){
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var customercds = new Array();
			var productL2s = new Array();
			var productL7s = new Array();
			var volumes = new Array();
			
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData2[i];
				periods[count] = periodData2[i];
				customercds[count] = customercdData2[i];
				productL2s[count] = productL2Data2[i];
				productL7s[count] = productL7Data2[i];
				volumes[count] = volumeData2[i];
				
				count++;
				
			}
			 
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02003A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("customercds", customercds);
			table.setParameter("productL2s", productL2s);
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
			
		}else if($("#esltTbInfo").val() == "9"){
			
			for(var i=0; i<rowCount; i++) {
				if (fyData3[i] == "") {alert("<fmt:message key="ANL02003A.msg3" />");return false;}
				if (periodData3[i] == "") {alert("<fmt:message key="ANL02003A.msg4" />");return false;}
				if (branchData3[i] == "") {alert("<fmt:message key="ANL02003A.msg5" />");return false;}
				if (datatypeData3[i] == "") {alert("<fmt:message key="ANL02003A.msg6" />");return false;}
				if (productL2Data3[i] == "") {alert("<fmt:message key="ANL02003A.msg7" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var branchs = new Array();
			var datatypes = new Array();
			var productL2s = new Array();
			var volumes = new Array();
			 
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData3[i];
				periods[count] = periodData3[i];
				branchs[count] = branchData3[i];
				datatypes[count] = datatypeData3[i];
				productL2s[count] = productL2Data3[i];
				volumes[count] = volumeData3[i];
				
				count++;
				
			}
			 
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02003A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("branchs", branchs);
			table.setParameter("datatypes", datatypes);
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
			
		}else if($("#esltTbInfo").val() == "10"){
			
			for(var i=0; i<rowCount; i++) {
				if (fyData4[i] == "") {alert("<fmt:message key="ANL02003A.msg3" />");return false;}
				if (periodData4[i] == "") {alert("<fmt:message key="ANL02003A.msg4" />");return false;}
				if (customercdData4[i] == "") {alert("<fmt:message key="ANL02003A.msg8" />");return false;}
				if (datatypeData4[i] == "") {alert("<fmt:message key="ANL02003A.msg9" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var customercds = new Array();
			var datatypes = new Array();
			var volumes = new Array();
			 
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData4[i];
				periods[count] = periodData4[i];
				customercds[count] = customercdData4[i];
				datatypes[count] = datatypeData4[i];
				volumes[count] = volumeData4[i];
				
				count++;
				
			}
			 
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02003A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("customercds", customercds);
			table.setParameter("datatypes", datatypes);
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
				
		}else if($("#esltTbInfo").val() == "11"){
			
			for(var i=0; i<rowCount; i++) {
				if (fyData5[i] == "") {alert("<fmt:message key="ANL02003A.msg3" />");return false;}
				if (periodData5[i] == "") {alert("<fmt:message key="ANL02003A.msg4" />");return false;}
				if (cityData5[i] == "") {alert("<fmt:message key="ANL02003A.msg10" />");return false;}
				if (subcity1Data5[i] == "") {alert("<fmt:message key="ANL02003A.msg11" />");return false;}
				if (subcity2Data5[i] == "") {alert("<fmt:message key="ANL02003A.msg12" />");return false;}
				if (marketData5[i] == "") {alert("<fmt:message key="ANL02003A.msg13" />");return false;}
				if (segmentData5[i] == "") {alert("<fmt:message key="ANL02003A.msg14" />");return false;}
				if (channelData5[i] == "") {alert("<fmt:message key="ANL02003A.msg15" />");return false;}
				if (companyData5[i] == "") {alert("<fmt:message key="ANL02003A.msg16" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var citys = new Array();
			var subcity1s = new Array();
			var subcity2s = new Array();
			var markets = new Array();
			var segments = new Array();
			var channels = new Array();
			var companys = new Array();
			var volumes = new Array();
			 
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData5[i];
				periods[count] = periodData5[i];
				citys[count] = cityData5[i];
				subcity1s[count] = subcity1Data5[i];
				subcity2s[count] = subcity2Data5[i];
				markets[count] = marketData5[i];
				segments[count] = segmentData5[i];
				channels[count] = channelData5[i];
				companys[count] = companyData5[i];
				volumes[count] = volumeData5[i];
				
				count++;
				
			}
			 
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02003A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("citys", citys);
			table.setParameter("subcity1s", subcity1s);
			table.setParameter("subcity2s", subcity2s);
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
				if (venueIDData6[i] == "") {alert("<fmt:message key="ANL02003A.msg17" />");return false;}
				if (cityData6[i] == "") {alert("<fmt:message key="ANL02003A.msg10" />");return false;}
				if (subCity1Data6[i] == "") {alert("<fmt:message key="ANL02003A.msg11" />");return false;}
				if (subCity2Data6[i] == "") {alert("<fmt:message key="ANL02003A.msg12" />");return false;}
			}
			
			showLoading();
			
			var fys = new Array();
			var periods = new Array();
			var venueIDs = new Array();
			var citys = new Array();
			var subCity1s = new Array();
			var subCity2s = new Array();
			var markets = new Array();
			var productL7s = new Array();
			var volumes = new Array();
			var amounts = new Array();
			 
			var count = 0;
			
			for (var i = 0; i < rowCount; i++) {
				
				fys[count] = fyData6[i];
				periods[count] = periodData6[i];
				venueIDs[count] = venueIDData6[i];
				citys[count] = cityData6[i];
				subCity1s[count] = subCity1Data6[i];
				subCity2s[count] = subCity2Data6[i];
				markets[count] = marketData6[i];
				productL7s[count] = productL7Data6[i];
				volumes[count] = volumeData6[i];
				amounts[count] = amountData6[i];
				
				count++;
				
			}
			 
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/anl02/save_ANL02003A");
			table.setAsync(false);
			table.setRequestMethod("POST");
			
			table.setParameter("fy_S", $("#fy").val());
			table.setParameter("period_S", $("#period").val());
			table.setParameter("fys", fys);
			table.setParameter("periods", periods);
			table.setParameter("venueIDs", venueIDs);
			table.setParameter("citys", citys);
			table.setParameter("subCity1s", subCity1s);
			table.setParameter("subCity2s", subCity2s);
			table.setParameter("markets", markets);
			table.setParameter("productL7s", productL7s);
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
	    	uploader.upload(fileID, "${contextPath}/service/anl02/extract_ANL02003A_Xls"
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
			if($("#esltTbInfo").val() == "7"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData[i] = fileData.fy[i];
		     			periodData[i] = fileData.period[i];
		     			customercdData[i] = fileData.customercd[i];
		     			productL7Data[i] = fileData.productL7[i];
		     			productL8Data[i] = fileData.productL8[i];
		     			volumeData[i] = fileData.volume[i];
		     			amountData[i] = fileData.amount[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
			
			}else if($("#esltTbInfo").val() == "8"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData2[i] = fileData.fy[i];
		     			periodData2[i] = fileData.period[i];
		     			customercdData2[i] = fileData.customercd[i];
		     			productL2Data2[i] = fileData.productL2[i];
		     			productL7Data2[i] = fileData.productL7[i];
		     			volumeData2[i] = fileData.volume[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
		     	
			}else if($("#esltTbInfo").val() == "9"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData3[i] = fileData.fy[i];
		     			periodData3[i] = fileData.period[i];
		     			branchData3[i] = fileData.branch[i];
		     			datatypeData3[i] = fileData.datatype[i];
		     			productL2Data3[i] = fileData.productL2[i];
		     			volumeData3[i] = fileData.volume[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
		     	
			}else if($("#esltTbInfo").val() == "10"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData4[i] = fileData.fy[i];
		     			periodData4[i] = fileData.period[i];
		     			customercdData4[i] = fileData.customercd[i];
		     			datatypeData4[i] = fileData.datatype[i];
		     			volumeData4[i] = fileData.volume[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
		     	
			}else if($("#esltTbInfo").val() == "11"){
				
				rowCount = fileData.fy.length;
				
				var data = new Array(new Array(), new Array());
		     	if(rowCount > 0) {
		     		for(var i = 0; i < rowCount; i++) {
		     			fyData5[i] = fileData.fy[i];
		     			periodData5[i] = fileData.period[i];
		     			cityData5[i] = fileData.city[i];
		     			subcity1Data5[i] = fileData.subcity1[i];
		     			subcity2Data5[i] = fileData.subcity2[i];
		     			marketData5[i] = fileData.market[i];
		     			segmentData5[i] = fileData.segment[i];
		     			channelData5[i] = fileData.channel[i];
		     			companyData5[i] = fileData.company[i];
		     			volumeData5[i] = fileData.volume[i];
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
		     			fyData6[i] = fileData.fy[i];
		     			periodData6[i] = fileData.period[i];
		     			venueIDData6[i] = fileData.venueID[i];
		     			cityData6[i] = fileData.city[i];
		     			subCity1Data6[i] = fileData.subCity1[i];
		     			subCity2Data6[i] = fileData.subCity2[i];
		     			marketData6[i] = fileData.market[i];
		     			productL7Data6[i] = fileData.productL7[i];
		     			volumeData6[i] = fileData.volume[i];
		     			amountData6[i] = fileData.amount[i];
		     		}
		     	}else {
		      		message('<fmt:message key="info.nullData"/>');
		      		alert(fileData.errorCode);
		      	}
			}
		}
      		
	}
</script>