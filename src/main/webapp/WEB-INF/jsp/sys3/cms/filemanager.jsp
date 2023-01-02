<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <%@include file="../scripts.jsp" %>
    </head>    
    <body>
    	<form name="form" method="post">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
	       		<colgroup>
	       			<col></col>
	       			<col style="width:110px"></col>
	       			<col style="width:80px"></col>
	       			<col></col>
	       		</colgroup>
	       		<tbody>
					<tr id="uploader">
						<td>
	                   		<span id="gridDisable_uploadFileDisplay"></span>
	                   		<img id="gridDisable_delete" src="${themeURL}/styles/delete_grid.png" hspace="3" style="vertical-align:middle;cursor:pointer" />
	                   		<input type="hidden" id="gridDisable_uploadFileDocLinkID" name="gridDisable_uploadFileDocLinkID" />
	                   		<input type="hidden" id="gridDisable_fileURL" name="gridDisable_fileURL" />
	                   		<input type="hidden" id="gridDisable_UUID" name="gridDisable_UUID" />
	                   		<input type="hidden" id="gridDisable_fileName" name="gridDisable_fileName" />
	                 	</td>
	               		<td height="25">
	                   		<div id="selectedFileDispflay">
	                       		<input type="text" id="progressReport" value="" style="width:200px;" readonly="readonly" />
	                     	</div>
	                 	</td>
	                 	<td> 
	                   		<div id="uploaderContainer">
	                       		<!-- <div id="uploaderOverlay" style="position:absolute; z-index:2"></div> -->
	                       		 <!-- <div id="uploaderUI" style="z-indez:1; width:73px; height:21px;"></div> -->
	                       		<div id="uploaderOverlay" style="width:73px; height:21px; background:url(${themeURL}/images/btn/select.png)"></div>
	                         	 <!-- <div id="selectFilesLink" style="z-index:1"><a id="selectLink" href="#"><img src="${themeURL}/images/btn/select.png"></a></div> -->                                
	                     	</div>
	                 	</td>
	                 	<td>
	                   		<div id="uploadFilesLink"><a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a></div>
	                 	</td>
	             	</tr>
	             	<tr>
		           		<td colspan="4" height="*">
		               		<span id="grid"></span>
		               		<iframe src="" id="downloadFrame" name="downloadFrame" style="width:0px;height:0px;"></iframe>
		           		</td>
		       		</tr>
	       		</tbody>
			</table>
		</form>
	</body>
</html>

<style type="text/css">
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    .aw-row-selector {text-align: center}

    .aw-column-0 {width: 200px; }
    .aw-column-1 {width: 100px; text-align:right;}
    .aw-column-2 {width: 50px; text-align: center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}

</style>

<script type="text/javascript">

	/****************************************
	* Variable
	****************************************/
    var maxRow = 0;
	var parameter = "";

    /****************************************
    * Function
    ****************************************/
    $(document).ready(function() {

		window.onload = function() {
			if ("${uploadEnable}".toUpperCase() == "NO" || "${uploadEnable}".toUpperCase() == "N") {
				 $("#uploader").hide();
			}
			
			if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
				$("#grid").hide();
				$("#gridDisable_delete").hide();
			}
			
		};

		${initScript}

		$("#gridDisable_delete").click(function() {
			removeRow(0);
		});
		
	});
    
    // 갤러리 이미지 표시
    function display_gallery() {
    	
    	if ("${galleryEnable}".toUpperCase() == "YES" || "${galleryEnable}".toUpperCase() == "Y") {
    		
			var content = "";
    		if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
    			
    			if("<spring:eval expression="@system['docLink.fileServer.using']"/>" == "Y") {
    				content = content +
        			"<li><a href='"+"<spring:eval expression="@system['docLink.fileServer.host']"/>"+$("#gridDisable_fileURL").val()+$("#gridDisable_UUID").val()+"' title='"+$("#gridDisable_fileName").val()+"'>"+
                    "<img src='"+"<spring:eval expression="@system['docLink.fileServer.host']"/>"+$("#gridDisable_fileURL").val()+$("#gridDisable_UUID").val()+"' width='72' height='72' alt=''\/><\/a><\/li>";
        		}
        		else {
        			content = content +
        			"<li><a href='${contextPath}/upload/"+$("#gridDisable_fileURL").val()+$("#gridDisable_UUID").val()+"' title='"+$("#gridDisable_fileName").val()+"'>"+
                    "<img src='${contextPath}/upload/"+$("#gridDisable_fileURL").val()+$("#gridDisable_UUID").val()+"' width='72' height='72' alt=''\/><\/a><\/li>";
        		}
    		}
    		else {
            	for (var i=0; i < maxRow; i++) {
            		if (grid.getCellText(_col.activeFlg,i) == 'U' &&
            			(grid.getCellText(_col.fileTypeCD,i).toUpperCase() == "GIF" ||
            			 grid.getCellText(_col.fileTypeCD,i).toUpperCase() == "JPG" ||
            			 grid.getCellText(_col.fileTypeCD,i).toUpperCase() == "PNG")) {
            			
            			if("<spring:eval expression="@system['docLink.fileServer.using']"/>" == "Y") {
            				content = content +
    	        			"<li><a href='"+"<spring:eval expression="@system['docLink.fileServer.host']"/>"+grid.getCellText(_col.fileURL,i)+grid.getCellText(_col.UUID,i)+"' title='"+grid.getCellText(_col.fileName,i)+"'>"+
    	                    "<img src='"+"<spring:eval expression="@system['docLink.fileServer.host']"/>"+grid.getCellText(_col.fileURL,i)+grid.getCellText(_col.UUID,i)+"' width='72' height='72' alt=''\/><\/a><\/li>";
                		}
                		else {
                			content = content +
    	        			"<li><a href='${contextPath}/upload/"+grid.getCellText(_col.fileURL,i)+grid.getCellText(_col.UUID,i)+"' title='"+grid.getCellText(_col.fileName,i)+"'>"+
    	                    "<img src='${contextPath}/upload/"+grid.getCellText(_col.fileURL,i)+grid.getCellText(_col.UUID,i)+"' width='72' height='72' alt=''\/><\/a><\/li>";
                		}

            		}
            	}
    		}
    		
       		$("#${id}_image", parent.document).html(content);
       		parent.event_${id}();
        	
		}
    }
    
    // F_DocLink.linkID 저장을 위한 docLinkID 추출
    function getDocLinkID() {
    	var docLinkID = new Array();
    	if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
    		docLinkID[0] = $("#gridDisable_uploadFileDocLinkID").val();
    	}
    	else {
    		var j=0;
	    	for (var i=0; i < maxRow; i++) {
	    		if (grid.getCellText(_col.activeFlg,i) == "U") {
	    			docLinkID[j++] = grid.getCellText(_col.docLinkID,i);
	    		}
	    	}
    	}
    	return docLinkID;
    }
    
    function getFileName() {
    	var fileName = new Array();
    	if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
    		fileName[0] =  $("#gridDisable_fileName").val();
    	}
    	else {
    		var j=0;
	    	for (var i=0; i < maxRow; i++) {
	    		if (grid.getCellText(_col.activeFlg,i) == "U") {
	    			fileName[j++] = grid.getCellText(_col.fileName,i);
	    		}
	    	}
    	}
    	return fileName;
    }
    
    // 파일삭제 (F_DocLink 테이블 데이터 삭제 + 파일삭제처리)
    function removeRow(row) {
    	if(!confirm("<fmt:message key="confirm.delete"/>")){
			return;
		}
    	
	    var req = new AW.XML.Table;
        req.setURL("${contextPath}/service/doclink/deleteFile");
        req.setAsync(false);
        req.setRequestMethod("POST");
        if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
        	req.setParameter("docLinkID",$("#gridDisable_uploadFileDocLinkID").val());
        }
        else {
        	req.setParameter("docLinkID",grid.getCellText(_col.docLinkID,row));
        }
        req.request();
        
        var rowCount = req.getCount();
        if (rowCount > 0) {
            if (req.getData(0,0) == 'S') {
				Search(parameter);
                
                try{
                	parent.Search();
                }catch(e){}
            }
            else {
            	alert("<fmt:message key="filemanager.msg1"/>");
            }
        }
        else {
            alert("<fmt:message key="filemanager.msg1"/>");
        }
    }
    
    // 파일 목록 조회
    function Search(param) {
    	parameter = param;
    	
    	if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
			 $("#grid").hide();
			 
			var table = new AW.XML.Table;
	        table.setURL("${contextPath}/service/simpleAction/SYS0004S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("linkDivCD", "${linkDivCD}");
	        
	        if (param.linkID == null) {
	        	table.setParameter("linkID", param);
	        }
	        else {
	        	table.setParameter("linkID", param.linkID);
	        }
	        if (param.linkID1 != null) {
	        	table.setParameter("linkID1", param.linkID1);
	        }
	        if (param.linkID2 != null) {
	        	table.setParameter("linkID2", param.linkID2);
	        }
	        if (param.linkID3 != null) {
	        	table.setParameter("linkID3", param.linkID3);
	        }
	        if (param.linkID4 != null) {
	        	table.setParameter("linkID4", param.linkID4);
	        }
	        if (param.linkID5 != null) {
	        	table.setParameter("linkID5", param.linkID5);
	        }
	        table.request();
	        
	        var url =  "";
	        var rowCount = table.getCount();
	        if (rowCount > 0) {
	        	$("#gridDisable_delete").show();
	        	
		        url =  "<a href=\"javascript:fileDownload('"+table.getData(0,0)+"');\">"+
	            "<img src=\"${contextPath}/images/filetype/"+table.getData(4,0)+".gif\" onerror=\"this.src='${contextPath}/images/filetype/unknown.gif'\" align=\"absmiddle\" /> "+table.getData(1,0)+
	            "</a>";
	        }
	        else {
	        	$("#gridDisable_delete").hide();
	        }
	        $("#gridDisable_uploadFileDisplay").html(url);
	        $("#gridDisable_uploadFileDocLinkID").val(table.getData(0,0));
	        
	        $("#gridDisable_fileURL").val(table.getData(2,0));
	        $("#gridDisable_UUID").val(table.getData(3,0));
	        $("#gridDisable_fileName").val(table.getData(1,0));
	        
	        
	        display_gallery();
		}
    	else {
    		$("#gridDisable_delete").hide();
    		
	        var table = new AW.XML.Table;
	        table.setURL("${contextPath}/service/simpleAction/SYS0004S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("linkDivCD", "${linkDivCD}");
	        
	        if (param.linkID == null) {
	        	table.setParameter("linkID", param);
	        }
	        else {
	        	table.setParameter("linkID", param.linkID);
	        }
	        if (param.linkID1 != null) {
	        	table.setParameter("linkID1", param.linkID1);
	        }
	        if (param.linkID2 != null) {
	        	table.setParameter("linkID2", param.linkID2);
	        }
	        if (param.linkID3 != null) {
	        	table.setParameter("linkID3", param.linkID3);
	        }
	        if (param.linkID4 != null) {
	        	table.setParameter("linkID4", param.linkID4);
	        }
	        if (param.linkID5 != null) {
	        	table.setParameter("linkID5", param.linkID5);
	        }
	        table.request();
	        
	        createGrid();
	        
	        maxRow = 0;
	        var rowCount = table.getCount();
	        if (rowCount > 0) {
	            var data = new Array();
	            for (var i=0; i < rowCount; i++) {
	                var fileUrl = 
			            "<a href=\"javascript:fileDownload('"+table.getData(0,i)+"');\">"+
			            "<img src=\"${contextPath}/images/filetype/"+table.getData(4,i)+".gif\" onerror=\"this.src='${contextPath}/images/filetype/unknown.gif'\" align=\"absmiddle\" /> "+table.getData(1,i)+
			            "</a>";
			            
	                data[i] = [
	                    fileUrl,
	                    table.getData(5,i),
	                    "",
	                    table.getData(0,i),
	                    "U",
	                    table.getData(3,i),
	                    table.getData(1,i),
	                    table.getData(4,i),
	                    table.getData(2,i)
	                ];
	            }
	            grid.setCellData(data);
	            grid.setRowCount(rowCount);
	            maxRow = rowCount;
	        }
	        
	        $("#uploadFilesLink").val("");
	        display_gallery();
	        
	        grid.refresh();
    	}
    }
    
    //파일등록 및 삭제 못하게함(taejoon-jang 2011.08.31)
    function disableUpdate() {
    	if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
    		$("#gridDisable_uploadFileDisplay").html("");
    		$("#selectedFileDispflay").hide();
    		$("#uploaderContainer").hide();
    		$("#uploadFilesLink").hide();
    	}
    	else {
    		columns = [
	           "<fmt:message key="filemanager.fileName"/>",
	           "<fmt:message key="filemanager.fileSize"/>"
	       ];
	    	
			$("#uploader").hide();
			createGrid();
			grid.refresh();
    	}
    }
    
    function ableUpdate() {
		if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
			$("#selectedFileDispflay").show();
    		$("#uploaderContainer").show();
    		$("#uploadFilesLink").show();
    	}
    	else {
	    	columns = [
	           "<fmt:message key="filemanager.fileName"/>",
	           "<fmt:message key="filemanager.fileSize"/>",
	           "<fmt:message key="filemanager.delete"/>"
	       ];
	    	
			$("#uploader").show();
			createGrid();
			grid.refresh();
    	}
    }
    
	function clear() {
    	if ("${uploadEnable}".toUpperCase() == "NO" || "${uploadEnable}".toUpperCase() == "N") {
    	}
    	else {
    		try {
	    		uploader.clearFileList();
    		} catch(e){}
    	}
    	if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
    		$("#gridDisable_fileName").val("");
    		$("#gridDisable_uploadFileDisplay").html("");
    	}
    	else {
    		createGrid();
        	grid.refresh();
    	}
    	$("#gridDisable_delete").hide();
    	
    }

</script>

<script type="text/javascript">

    /*****************************************************
    *   define grid / data formats define
    *****************************************************/
    var grid = null;
    
    var columns = [
		"<fmt:message key="filemanager.fileName"/>",
		"<fmt:message key="filemanager.fileSize"/>",
		"<fmt:message key="filemanager.delete"/>"
    ];
    
    var _col = {
    	"fileUrl":0,
    	"fileSize":1,
    	"deleteBtn":2,
    	"docLinkID":3,
    	"activeFlg":4,
    	"UUID":5,
    	"fileName":6,
    	"fileTypeCD":7,
    	"fileURL":8
    };
    
    function createGrid() {
    
        grid = new AW.UI.Grid;
        grid.setId("grid");
        for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
        grid.setSelectorVisible(true);
        grid.setSelectionMode("single-row");
        grid.setCellEditable(false);
        grid.setHeaderText(columns);
        grid.setColumnCount(columns.length);
       	grid.setStyle("width", "100%");
        grid.setStyle("height", "100%");
        grid.setCellFormat([html,str,str]);
        
        grid.setCellImage("deleteGrid",_col.deleteBtn);
        var deleteFlag = new AW.Templates.Image;
        var delImage = deleteFlag.getContent("box/image");
        delImage.setTag("a");
        delImage.setAttribute("href", function(){
            return "javascript:removeRow(grid.getCurrentRow())";
        });
        grid.setCellTemplate(deleteFlag, 2);
        
        grid.onHeaderClicked=function(){
            return ture;
        }
    }
    
    createGrid();
    grid.refresh();

</script>

<script type="text/javascript">
	
	/*
	YAHOO.util.Event.onDOMReady(function () { 
		var uiLayer = YAHOO.util.Dom.getRegion('selectLink');
		var overlay = YAHOO.util.Dom.get('uploaderOverlay');
		YAHOO.util.Dom.setStyle(overlay, 'width', uiLayer.right-uiLayer.left + "px");
		YAHOO.util.Dom.setStyle(overlay, 'height', uiLayer.bottom-uiLayer.top + "px");
	});
	*/

    // Custom URL for the uploader swf file (same folder).
    YAHOO.widget.Uploader.SWFURL = "${contextPath}/scripts/yui/build/uploader/assets/uploader.swf";

    // Instantiate the uploader and write it to its placeholder div.
    var uploader = new YAHOO.widget.Uploader( "uploaderOverlay" );
    //var uploader = new YAHOO.widget.Uploader("uploaderUI");
    
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
        var fileType = "${fileType}";
        var ff = new Array({description:"All(*.*)", extensions:"*"});
        
        if(fileType.toUpperCase()=="IMG" ) {
        	ff = new Array({description:"jgp, png, gif", extensions:"*.jpg;*.png;*.gif"});
        }
        else if(fileType.toUpperCase()=="MP4" ) {
        	ff = new Array({description:"mp4", extensions:"*.mp4"});
        }
        else if(fileType.toUpperCase()=="XLS" ) {
        	ff = new Array({description:"xls", extensions:"*.xls"});
        }
        else if(fileType.toUpperCase()=="XLSX" ) {
        	ff = new Array({description:"xls, xlsx", extensions:"*.xls;*.xlsx"});
        }
        
                           
        // Apply new set of file filters to the uploader.
        uploader.setFileFilters(ff);
    }

    // Actually uploads the files. Since we are only allowing one file
    // to be selected, we use the upload function, in conjunction with the id 
    // of the selected file (returned by the fileSelect event). We are also including
    // the text of the variables specified by the user in the input UI.

    function upload() {
	    if (fileID != null) {
	    	if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
	    		var req = new AW.XML.Table;
	            req.setURL("${contextPath}/service/doclink/deleteFile");
	            req.setAsync(false);
	            req.setRequestMethod("POST");
	            req.setParameter("docLinkID", $("#gridDisable_uploadFileDocLinkID").val());
	            req.request();
	    	}
	    	
	        uploader.upload(fileID, "${contextPath}/service/doclink/insertFileForYUI", 
	                        "POST", 
	                        {linkDivCD:"${linkDivCD}",
	                         linkID:"${linkID}"});
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
        //this.progressReport.value = "Upload complete.";
    	this.progressReport.value = "";
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
        var fileData = event.data.split(';');
        if (fileData[0] == 'S') {
        	alert("<fmt:message key="filemanager.msg2"/>");
        	
        	if ("${gridEnable}".toUpperCase() == "NO" || "${gridEnable}".toUpperCase() == "N") {
				$("#grid").hide();
				
		        var fileUrl = 
                "<a href=\"javascript:fileDownload('"+fileData[4]+"');\">"+
                "<img src=\"${contextPath}/images/filetype/"+fileData[1]+".gif\" onerror=\"this.src='${contextPath}/images/filetype/unknown.gif'\" align=\"absmiddle\" /> "+fileData[2]+
                "</a>";
                $("#gridDisable_uploadFileDisplay").html(fileUrl);
                $("#gridDisable_fileName").val(fileData[2]);
                $("#gridDisable_uploadFileDocLinkID").val(fileData[4]);
                
			}
        	else {
        		grid.addRow(maxRow++);
                //maxRow = 1;
                var fileUrl = 
                "<a href=\"javascript:fileDownload('"+fileData[4]+"');\">"+
                "<img src=\"${contextPath}/images/filetype/"+fileData[1]+".gif\" onerror=\"this.src='${contextPath}/images/filetype/unknown.gif'\" align=\"absmiddle\" /> "+fileData[2]+
                "</a>";
                grid.setCellText(fileUrl, _col.fileUrl, maxRow-1);
                grid.setCellText(formatNum(Math.round(parseFloat(fileData[3])/1024)+"")+"k", _col.fileSize, maxRow-1);
                grid.setCellText(fileData[4], _col.docLinkID, maxRow-1);
                grid.setCellText('U', _col.activeFlg, maxRow-1);
                
                grid.setCellText(fileData[5], _col.UUID, maxRow-1);
                grid.setCellText(fileData[2], _col.fileName, maxRow-1);
                grid.setCellText(fileData[1], _col.fileTypeCD, maxRow-1);
                grid.setCellText(fileData[6], _col.fileURL, maxRow-1);
        	}
        	
            display_gallery();
        }
        else if (fileData[0] == 'E') {
            alert('File Upload Error.');
        }
    } 
    
    function fileDownload(docLinkID) {
        url = "${contextPath}/service/doclink/downloadFile?docLinkID="+docLinkID;
        form.action = url;
        form.target = "downloadFrame";
        form.submit();
    }
    
</script>