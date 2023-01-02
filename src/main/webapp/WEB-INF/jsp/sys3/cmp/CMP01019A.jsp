<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
<form name="form" method="post">
<div id="wrapDiv"><div id="formDiv">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
        	<td height="1">
				<input type="hidden" name="mnuGrpID" value="${params.mnuGrpID}" />
				<input type="hidden" name="pgmID" value="${params.pgmID}" />
				<input type="hidden" name="viewID" value="${params.viewID}" />
				<input type="hidden" name="grpID" value="" />

				<%@include file="../cms/functionbar.jsp" %>
			</td>
		</tr>
		<tr>
        	<td height="1">
            	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                	<tr>
                  		<td class="tb-border">
				        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px; table-layout:fixed;">
								<colgroup>
				        			<col style="width:100px;"></col>
				        			<col style="width:320px;"></col>
				        			<col style="width:100px;"></col>
				        			<col></col>
				        		</colgroup>
				        		<tbody>
								<tr>
									<td class="td-cond-required">
										<fmt:message key="CMP01019A.systemLanguage" />
									</td>
									<td class="td-input">
										<input id="systemLanguageCD" style="width:120px;" class="input-readonly" readonly="readonly">
										<script>
											var btnInitLangDesc = new AW.UI.Button;
											btnInitLangDesc.setControlText("<fmt:message key="CMP01019A.msg10" />");
					                      	document.write(btnInitLangDesc);
					                      
					                      	btnInitLangDesc.onControlClicked = function(event) {		                           
					                      		initLangDesc();
					                      	};
										</script>
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01019A.tableID" />
									</td>
									<td class="td-input">
										<nis:selectbox id="tableID" defaultText="all" category="LANGTABLE" value="F_CODE" />
									</td>
								</tr>
								<tr>
									<td class="td-cond-required">
										<fmt:message key="CMP01019A.stdLang" />
									</td>
									<td class="td-input">
										<nis:selectbox id="stdLanguageCD" style="width:120px" defaultText="select" category="LANGUAGECD" />
									</td>
									<td class="td-cond-required">
										<fmt:message key="CMP01019A.targetLang" />
									</td>
									<td class="td-input">
										<nis:selectbox id="targetLanguageCD" style="width:120px" defaultText="select" category="LANGUAGECD" />
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01019A.searchWord" />
									</td>
									<td class="td-input" colspan="3">
										<input type="text" id="searchWord" style="width:200px">
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
            <td height="1" >
                <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    <colgroup>
                        <col style="width:150px;"></col> 
                        <col></col>
                        <col style="width:80px;"></col> 
                        <col style="width:160px;"></col>
                         <col style="width:80px;"></col>
                          <col style="width:80px;"></col>
                    </colgroup>
                    <tbody>
                        <tr>
                            <td class="group-title"><fmt:message key="CMP01019A.msg3" /></td>
                            <td>&nbsp;</td>
                            <td class="td-cond"><fmt:message key="CMP01019A.msg4" /></td>
                            <td class="td-input">
                                <input type="text" id="progressReport" style="width:150px;" readonly="readonly" />
                            </td>
                            <td class="td-input">
                            	<div id="uploaderOverlay" style="width:73px; height:21px; background:url(${themeURL}/images/btn/select.png)"></div>
                            </td>
                            <td class="td-input">
                            	<div id="uploadFilesLink"><a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a></div>
                            </td>
                        </tr>
                    </tbody>    
                </table>
            </td>           
        </tr>
        <tr>
            <td class="tb-border" height="*" valign="top">
                <span id="grid"></span>
            </td>
        </tr>
	</table>
</div></div>
</form>
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    .aw-column-0 {width: 80px; }
    .aw-column-1 {width: 200px;}
    .aw-column-2 {width: 80px; }
    .aw-column-3 {width: 200px;}
    .aw-column-4 {width: 150px;}
    .aw-column-5 {width: 70px;}
    .aw-column-6 {width: 70px;}
    .aw-column-7 {width: 70px;}
    .aw-column-8 {width: 70px;}
        
    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">

	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {
		
		window.onload = function() {
			
			$("#systemLanguageCD").val("${params.systemLanguageCD}");
			$("#stdLanguageCD").val($("#systemLanguageCD").val());
			
			createGrid();
			grid.refresh();
			
			$("#targetLanguageCD").focus();
		};
	
		${initScript}
		
		$("#searchWord").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		
	});
	
	function initData() {
		for (var i=0; i < grid.getRowCount(); i++) {
			grid.setCellText(grid.getCellText(_col.targetPkDesc,i), _col.oldPkDesc, i);
		}
	}
	
	function initLangDesc() {
		
		if ($("#systemLanguageCD").val() == "") {
			alert("<fmt:message key="CMP01019A.msg11"/>");
			return;				
		}
  		
		var table = new AW.XML.Table;  
	  	table.setURL("${contextPath}/service/language/createLangDescription");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
		table.setParameter("systemLanguageCD", $("#systemLanguageCD").val());
		table.request();

		if (table.getData(0,0) == 'S'){
			message(table.getData(1,0));
			initData();
		}
		else {
			alert(table.getData(1,0));
		}
	}
</script>
	
<script type="text/javascript">

	/****************************************
	* Button
	****************************************/	
	function Search() {

		if ($("#stdLanguageCD").val() == "") {
			alert("<fmt:message key="CMP01019A.msg1" />");
			$("#stdLanguageCD").focus();
			return;
		}
		else if ($("#targetLanguageCD").val() == "") {
			alert("<fmt:message key="CMP01019A.msg2" />");
			$("#targetLanguageCD").focus();
			return;
		}
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0101901S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
        table.setParameter("outParamKey",
        		"stdLanguageCD;stdPkDesc;targetLanguageCD;targetPkDesc;tableID;"+
        		"pkID1;pkID2;pkID3;companyDiv;companyID;");
	  	table.setParameter("tableID", $("#tableID").val());
	  	table.setParameter("stdLanguageCD", $("#stdLanguageCD").val());
	  	table.setParameter("targetLanguageCD", $("#targetLanguageCD").val());
	  	table.setParameter("searchWord", $("#searchWord").val());
      	table.request();

      	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
      			    table.getData(0,i),
      				table.getData(1,i),
      				table.getData(2,i),
      				table.getData(3,i),
      				table.getData(4,i),
      				table.getData(5,i),
      				table.getData(6,i),
      				table.getData(7,i),
      				table.getData(8,i),
      				table.getData(9,i),
      				table.getData(3,i)
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
  		grid.refresh();
	}
	
    function Save() {

		var languageCD = new Array();
		var pkDesc = new Array();
		var tableID = new Array();
		var pkID1 = new Array();
		var pkID2 = new Array();
		var pkID3 = new Array();
		var companyIDs = new Array();
		
		var j=0;
        for (var i=0; i < grid.getRowCount(); i++) {
            if (grid.getCellText(_col.targetPkDesc,i) != grid.getCellText(_col.oldPkDesc,i)) {
	            languageCD[j] = grid.getCellText(_col.targetLanguageCD,i);
	            pkDesc[j] = grid.getCellText(_col.targetPkDesc,i);
	            tableID[j] = grid.getCellText(_col.tableID,i);
	            pkID1[j] = grid.getCellText(_col.pkID1,i);
	            pkID2[j] = grid.getCellText(_col.pkID2,i);
	            pkID3[j] = grid.getCellText(_col.pkID3,i);
	            companyIDs[j] = grid.getCellText(_col.companyID,i);
	            j++;
            }
        }

		var table = new AW.XML.Table;  
	  	table.setURL("${contextPath}/service/language/saveLangDescription");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
		table.setParameter("languageCD_info", languageCD);
		table.setParameter("pkDesc", pkDesc);
		table.setParameter("tableID", tableID);
		table.setParameter("pkID1", pkID1);
		table.setParameter("pkID2", pkID2);
		table.setParameter("pkID3", pkID3);
		table.setParameter("companyIDs", companyIDs);
		table.request();

		if (table.getData(0,0) == 'S'){
			message(table.getData(1,0));
			initData();
		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Excel() {
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "CMP0101901S");
		table.setParameter("tableID", $("#tableID").val());
	  	table.setParameter("stdLanguageCD", $("#stdLanguageCD").val());
	  	table.setParameter("targetLanguageCD", $("#targetLanguageCD").val());
	  	table.setParameter("searchWord", $("#searchWord").val());
		
		var headerText = [
			"<fmt:message key="CMP01019A.stdLang" />",
			"<fmt:message key="CMP01019A.stdLangDesc" />",
			"<fmt:message key="CMP01019A.targetLang" />",
			"<fmt:message key="CMP01019A.targetLangDesc" />",
			"<fmt:message key="CMP01019A.tableID" />",
			"<fmt:message key="CMP01019A.pkID1" />",
			"<fmt:message key="CMP01019A.pkID2" />",
			"<fmt:message key="CMP01019A.pkID3" />",
			"<fmt:message key="CMP01019A.pkID4" />"
		];
		
		table.setParameter("templateFile", "CMP01019A");
		table.setParameter("headerText", headerText);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0,0) == "S") {
			    form.action = "${contextPath}/service/simpleExport/download/?"+
			    		"tempFile="+table.getData(3,0)+
			    		"&downloadFile=${params.viewName}";
			    form.target = "_self";
			    form.submit();
			}
		}
	}
	
	
	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var _col = {
		stdLanguageCD:0,
		stdPkDesc:1,
		targetLanguageCD:2,
		targetPkDesc:3,
		tableID:4,
		pkID1:5,
		pkID2:6,
		pkID3:7,
		companyDiv:8,
		companyID:9,
		oldPkDesc:10
	};
	
	var grid = null;

	var columns = [
		"<fmt:message key="CMP01019A.stdLang" />",
		"<fmt:message key="CMP01019A.stdLangDesc" />",
		"<fmt:message key="CMP01019A.targetLang" />",
		"<fmt:message key="CMP01019A.targetLangDesc" />",
		"<fmt:message key="CMP01019A.tableID" />",
		"<fmt:message key="CMP01019A.pkID1" />",
		"<fmt:message key="CMP01019A.pkID2" />",
		"<fmt:message key="CMP01019A.pkID3" />",
		"<fmt:message key="CMP01019A.companyDiv" />"
	];
	
	function createGrid() {
	
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str, str, str, str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setCellEditable(false);
		grid.setHeaderText(columns);
		grid.setColumnCount(columns.length);
		grid.setCellEditable(true, _col.targetPkDesc);
		
		// Cell startEdit BEGIN
	    grid.onCellSelectedChanged = function(selected, col, row) { 
	        if (selected) { 
	            this.setTimeout(function(){ 
	               this.raiseEvent("editCurrentCell", {}, col, row); 
	            }); 
	        } 
	    };
	      
	    grid.onCellClicked = function(event, col, row) { 
	        if (this.getCellSelected(col, row)) { 
	            this.setTimeout(function(){
	               this.raiseEvent("editCurrentCell", {}, col, row); 
	           }); 
	        }
	    }; 
	    
	    grid.onCellEditStarted = function(text, col, row){
	        
	    };
	      
	    grid.onCellEditEnded = function(text, col, row){
	    	this.setCellText(text, col, row);
	    };
	    // Cell startEdit END

	}
</script>


<script type="text/javascript">

//     YAHOO.util.Event.onDOMReady(function () { 
//         var uiLayer = YAHOO.util.Dom.getRegion('selectLink');
//         var overlay = YAHOO.util.Dom.get('uploaderOverlay');
//         YAHOO.util.Dom.setStyle(overlay, 'width', uiLayer.right-uiLayer.left + "px");
//         YAHOO.util.Dom.setStyle(overlay, 'height', uiLayer.bottom-uiLayer.top + "px");
//     });

    // Custom URL for the uploader swf file (same folder).
    YAHOO.widget.Uploader.SWFURL = "${contextPath}/scripts/yui/build/uploader/assets/uploader.swf";

    // Instantiate the uploader and write it to its placeholder div.
    var uploader = new YAHOO.widget.Uploader( "uploaderOverlay" );
    
    // Add event listeners to various events on the uploader.
    // Methods on the uploader should only be called once the 
    // contentReady event has fired.
    
    uploader.addListener('contentReady', handleContentReady);
    uploader.addListener('fileSelect', onFileSelect)
    uploader.addListener('uploadStart', onUploadStart);
    uploader.addListener('uploadProgress', onUploadProgress);
    uploader.addListener('uploadCancel', onUploadCancel);
    uploader.addListener('uploadComplete', onUploadComplete);
    uploader.addListener('uploadCompleteData', onUploadResponse);
    uploader.addListener('uploadError', onUploadError);
    //uploader.addListener('rollOver', handleRollOver);
    //uploader.addListener('rollOut', handleRollOut);
    //uploader.addListener('click', handleClick);
        
    // Variable for holding the selected file id.
    var fileID;
    
    // When the mouse rolls over the uploader, this function
    // is called in response to the rollOver event.
    // It changes the appearance of the UI element below the Flash overlay.
    /*
    function handleRollOver () {
        YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('selectLink'), 'color', "#FFFFFF");
        YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('selectLink'), 'background-color', "#000000");
    }
    */
    
    // On rollOut event, this function is called, which changes the appearance of the
    // UI element below the Flash layer back to its original state.
    /*
    function handleRollOut () {
        YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('selectLink'), 'color', "#0000CC");
        YAHOO.util.Dom.setStyle(YAHOO.util.Dom.get('selectLink'), 'background-color', "#FFFFFF");
    }
    */
    
    // When the Flash layer is clicked, the "Browse" dialog is invoked.
    // The click event handler allows you to do something else if you need to.
    /*
    function handleClick () {
    }
    */
    
    // When contentReady event is fired, you can call methods on the uploader.
    function handleContentReady () {
        // Allows the uploader to send log messages to trace, as well as to YAHOO.log
        uploader.setAllowLogging(true);
        
        // Disallows multiple file selection in "Browse" dialog.
        uploader.setAllowMultipleFiles(false);
        
        // New set of file filters.
        /*
        var ff = new Array({description:"Images", extensions:"*.jpg;*.png;*.gif"},
                           {description:"Videos", extensions:"*.avi;*.mov;*.mpg"},
                           {description:"All(*.*)", extensions:"*"});
        */
        var ff = new Array({description:"Excel", extensions:"*.xls"});
                           
        // Apply new set of file filters to the uploader.
        uploader.setFileFilters(ff);
    }

    // Actually uploads the files. Since we are only allowing one file
    // to be selected, we use the upload function, in conjunction with the id 
    // of the selected file (returned by the fileSelect event). We are also including
    // the text of the variables specified by the user in the input UI.

    function upload() {
        if (fileID != null && fileID != "") {
            /*
            if ($("#agencyID").val() == "") {
                alert("벤더를 선택하세요.");
                return;
            }
            */
            showLoading();
            /*
            uploader.upload(fileID, "${contextPath}/doclink.do?method=insertFileForYUI", 
                            "POST", 
                            {linkDivCD:"${linkDivCD}",
                             linkID:"${linkID}"});
            */
            uploader.upload(fileID, "${contextPath}/service/language/uploadLangDescription", 
                    "POST", {companyID:"${params.companyID}", uploadUserID:"${params.userID}"});
        }
        else {
            alert("<fmt:message key="CMP01019A.msg7"/>");
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
        this.progressReport.value = "Upload complete.";
    }
    
    // Report back to the user if there has been an error.
    function onUploadError(event) {
        this.progressReport.value = "Upload error.";
    }
    
    // Do something if an upload is canceled.
    function onUploadCancel(event) {

    }
    
    // When the data is received back from the server, display it to the user
    // in the server data text area.
    function onUploadResponse(event) {
        //this.serverData = document.getElementById("serverData");
        //this.serverData.value = event.data;
        hideLoading();
        var fileData = event.data.split(';');
        var errorMsg = "<fmt:message key="CMP01019A.msg8"/>\n";
        switch (fileData[0]) {
            case "S":
                alert('<fmt:message key="CMP01019A.msg9"/>');
                Search();
                break;
            case "E":
                alert(errorMsg+"("+fileData[1]+")");
                break;
            default :
                alert(errorMsg+"("+fileData[0]+")");
        }
    } 
    
</script>