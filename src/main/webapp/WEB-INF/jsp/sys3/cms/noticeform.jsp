<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <%@include file="../scripts.jsp" %>
	</head>

    <body class="yui-skin-sam" ${bodyConfig}>
        <form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1">
						<!-- Standard Parameter - START -->
			            <input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
			            <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
			            <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
						<!-- Standard Information - END -->
			
						<!-- Function Bar - Title & Button -->
						<%@include file="../cms/functionbar.jsp" %>
						<%@include file="../cms/calendar.jsp" %>
					</td>
				</tr>
				<tr>
                    <td class="pd" height="1">
                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
						        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<tr>
											<td class="td-cond" width="80"><fmt:message key="searchWord" /></td>
											<td class="td-input" width="150">
												<input type="text" id="searchWord" name="searchWord" style="width:140px;" onkeypress="if (event.keyCode==13){Search(); return false;}">
											</td>
											<td class="td-cond" width="80">기간</td>
											<td class="td-input" width="280">
												<nis:calendar id="dateFrom" readOnly="yes" value="${params.firstDate}" eventproc="" /> -
												<nis:calendar id="dateTo" readOnly="yes" value="${params.currentDate}" eventproc="" />
											</td>
											<td class="td-cond" width="80">사용여부</td>
											<td class="td-input" width="*">
												<nis:selectbox id="useYN_cond" category="USETYPE1CD" defaultText="all" style="width:100px"/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
                <tr>
                    <td class="pd" height="*">
                        <span id="grid"></span>
                    </td>
                </tr>
                <tr>
                	<td class="pd" height="1" style="padding-top:20px;">
                		<table border="0" cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td class="group-title">팝업공지</td>
							</tr>
							<tr>
								<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <tr>
			                                <td class="td-cond" width="100">공지ID</td>
			                                <td class="td-input" width="150">
			                                    <input type="text" id="noticeID" class="input-readonly" style="width:100px" readonly="readonly">
			                                </td>
			                                <td class="td-cond" width="80">공지기간</td>
			                                <td class="td-input" width="280">
			                                    <nis:calendar id="startDate" cssClass="input-required" readOnly="yes" value="${params.currentDate}" eventproc="" /> -
												<nis:calendar id="endDate" cssClass="input-required" readOnly="yes" value="${params.currentDate}" eventproc="" /> 
			                                </td>
			                                <td class="td-cond" width="80">사용여부</td>
			                                <td class="td-input" width="*">
			                                    <nis:radio id="useYN" category="USETYPE1CD" value="Y"/> 
			                                </td>
			                            </tr>
			                            <tr>
			                                <td class="td-cond">공지이미지</td>
			                                <td class="td-input" colspan="3">
			                                	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
						                           <tr>
						                               <td height="25" width="310">
						                                   <div id="selectedFileDisplay">
						                                       <input type="text" cols="100" id="progressReport" value="" style="width:300px;" readOnly />
						                                   </div>
						                               </td>
						                               <td width="80"> 
						                                   <div id="uploaderContainer">
						                                       <div id="uploaderOverlay" style="position:absolute; z-index:2"></div>
						                                       <div id="selectFilesLink" style="z-index:1"><a id="selectLink" href="#"><img src="${themeURL}/images/btn/select.png"></a></div>                                
						                                   </div>
						                               </td>
						                               <td width="*">
						                                   <div id="uploadFilesLink"><a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a></div>
						                               </td>
						                           </tr>
						                           <tr>
								                       <td colspan="3" height="100">
								                           <span id="grid"></span>
								                           <iframe src="" id="downloadFrame" name="downloadFrame" style="width:0px;height:0px;"></iframe>
								                       </td>
								                   </tr>
						                       </table>
			                                    
			                                </td>
			                                <td class="td-cond">제목</td>
			                                <td class="td-input">
			                                     <input type="text" id="noticeTitle" class="input-required" style="width:150px" maxlength="100">
			                                </td>
			                            </tr>
			                            <tr>
			                                <td class="td-cond">공지공유대상</td>
			                                <td class="td-input" colspan="5">
			                                	<input type="text" id="publicName" name="publicName" class="board_box" style="background-color:#ECECEC; width:80%;" readonly="readonly"> 
						                        <a href="#" onclick="openPopupPublicSelector()"><img src="${themeURL}/images/btn/search_popup.gif" hspace="3" style="vertical-align:middle; cursor:pointer"></a>
			                                </td>
			                            </tr>
			                            <tr>
			                                <td class="td-cond">길이/위치</td>
			                                <td class="td-input" colspan="5">
			                                                                                    가로: <input type="text" id="width" style="width:50px; ime-mode:disabled;" >
			                                                                                    세로: <input type="text" id="height" style="width:50px; ime-mode:disabled;" > / 
			                                    X: <input type="text" id="x" style="width:50px; ime-mode:disabled;" >
			                                    Y: <input type="text" id="y" style="width:50px; ime-mode:disabled;" >
			                                </td>
			                            </tr>
			                        </table>
		                        </td>
							</tr>
						</table>
					</td>
				</tr>
			    <tr>
			        <td height="5">
			        	<input type="hidden" id="doclinkID">
			        	<input type="hidden" id="publicID">
				        <input type="hidden" id="publicClassCD">
			        </td>
			    </tr>
			</table>
	    </form>
    </body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    .aw-column-0 {width: 100px;}
    .aw-column-1 {width: 300px;}
    .aw-column-2 {width: 100px; text-align: center;}
    .aw-column-3 {width: 100px; text-align: center;}
    .aw-column-4 {width: 80px; text-align:center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
    
//-->
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		window.onload = function() {
			$("#searchWord").focus();
			New();
		};
	
		${initScript}
	});  

    function openPopupPublicSelector() {

        var url = "simpleCommand.do"+
                  "?mnuGrpID="+document.getElementById("mnuGrpID").value+
                  "&pgmID="+document.getElementById("pgmID").value+
                  "&viewID=COM04002D"+
                  "&boardID=0"+
                  "&articleID=0"+
                  "&finalAction=closePublicSelector";
                                            
        newWindow(url, "publicSelector", 400, 500, "no");
        //newWindow(url, "publicSelector", 400, 500, "yes");
    }

    function closePublicSelector(rtnPublicID, rtnPublicClassCD, rtnPublicName){
        var publicID = "";
        var publicClassCD = "";
        var publicName = "";
        for(var i=0; i < rtnPublicID.length; i++){
            if (i < rtnPublicID.length-1) {
                publicID = publicID + rtnPublicID[i]+';';
                publicClassCD = publicClassCD + rtnPublicClassCD[i]+';';
                publicName = publicName + rtnPublicName[i]+';';
            }
            else {
                publicID = publicID + rtnPublicID[i];
                publicClassCD = publicClassCD + rtnPublicClassCD[i];
                publicName = publicName + rtnPublicName[i];
            }
        }
        document.getElementById("publicName").value = publicName;
        document.getElementById("publicID").value = publicID;
        document.getElementById("publicClassCD").value = publicClassCD;
    }
    
    // 신규버튼 Action
    function New()
    {
        $("#noticeID").val("");
        $("#startDate").val("${params.currentDate}");
        $("#endDate").val("${params.currentDate}");
        setRadioValue(document.form.useYN,"Y");
        $("#progressReport").val("");
        $("#noticeTitle").val("");
        $("#publicName").val("");
        $("#width").val("600");
        $("#height").val("600");
        $("#x").val("0");
        $("#y").val("0");
        $("#doclinkID").val("");
        $("#publicID").val("");
        $("#publicClassCD").val("");
    }
    
    function Save() {
        
        if ($("#progressReport").val() == "") {
       		alert("공지 이미지를 먼저 업로드하십시오.");
       		return;
        }
        else if ($("#noticeTitle").val() == "") {
       		alert("제목을 먼저 입력하십시오.");
       		$("#noticeTitle").focus();
       		return;
        }
        else if ($("#publicID").val() == "") {
       		alert("공지공유대상을 먼저 입력하십시오.");
       		return;
        }
        
        var table = new AW.XML.Table;
        table.setURL("notice.do");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("method","saveNotice");
        table.setParameter("noticeID", $("#noticeID").val());
        table.setParameter("noticeTitle", $("#noticeTitle").val());
        table.setParameter("startDate", $("#startDate").val());
        table.setParameter("endDate", $("#endDate").val());
        table.setParameter("doclinkID", $("#doclinkID").val());
        table.setParameter("useYN", getRadioValue(document.form.useYN));
        table.setParameter("width", $("#width").val());
        table.setParameter("height", $("#height").val());
        table.setParameter("x", $("#x").val());
        table.setParameter("y", $("#y").val());
        table.setParameter("publicID", $("#publicID").val());
        table.setParameter("publicClassCD", $("#publicClassCD").val());
        table.setParameter("publicName", $("#publicName").val());
        table.request();
        
        if (table.getData(0,0) == 'S') {
            message(table.getData(1,0));
            $("#noticeID").val(table.getData(3,0));
            Search();
        }
        else
        {
           alert(table.getData(1,0));
        }
    }
    
    function Delete() 
    {
        if (confirm("<fmt:message key="confirm.delete"/>")) {
            
            var table = new AW.XML.Table;
            table.setURL("notice.do");
            table.setAsync(false);
            table.setRequestMethod("POST");
            table.setParameter("method","removeNotice");
            table.setParameter("noticeID", $("#noticeID").val());
            table.request();
            
            
            if (table.getData(0,0) == 'S') {
                message(table.getData(1,0));
                Search();
                New();
            }
            else
            {
               alert(table.getData(1,0));
            }
        }
    }
    
	function Search() {
	
		var table = new AW.XML.Table;
	  	table.setURL("simpleAction.do");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("returnType","List");
        table.setParameter("resultType","XML");
        table.setParameter("RFC","ZCWCOMMC05_WCM_156");
        table.setParameter("inParamKey","SEARCHWORD;DATEFROM;DATETO;USEYN;");
        table.setParameter("outParamKey","NOTICEID;NOTICETITLE;STARTDATE;ENDDATE;USEYN;DOCLINKID;FILENAME;WIDTH;HEIGHT;X;Y;");
        
        table.setParameter("SEARCHWORD", $("#searchWord").val());
        table.setParameter("DATEFROM", unformat($("#dateFrom").val()));
        table.setParameter("DATETO", unformat($("#dateTo").val()));
        table.setParameter("USEYN", $("#useYN_cond").val());
	  	table.request();

      	grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (i=0; i < rowCount; i++) {
      			data[i] = [
      				table.getData(0,i),
      				table.getData(1,i),
      				formatDate(unformat(table.getData(2,i))),
      				formatDate(unformat(table.getData(3,i))),
      				table.getData(4,i)=="Y"?"사용":"사용안함",
      				table.getData(5,i),
      				table.getData(6,i),
      				table.getData(7,i),
      				table.getData(8,i),
      				table.getData(9,i),
      				table.getData(10,i)
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	else {
			message("데이터가 존재하지 않습니다.");          	
      	}
      	grid.refresh();
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var grid = null;

	var columns = [
		"공지ID", "제목", "공지시작일", "공지종료일", "사용여부"
	];
	
	function createGrid() {
	
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str, str]);
		grid.setSelectorWidth(40);
		grid.getSelectorTemplate().setStyle("text-align", "right");
		grid.setSelectorVisible(true);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);
		grid.setHeaderHeight(20);
		grid.setHeaderText(columns);
		grid.setColumnCount(columns.length);
		grid.setStyle("width", "100%");
		grid.setStyle("height", "100%");
		
		
		grid.onRowDoubleClicked = function(event, row){
            $("#noticeID").val(this.getCellText(0,row));
            $("#noticeTitle").val(this.getCellText(1,row));
            $("#startDate").val(this.getCellText(2,row));
            $("#endDate").val(this.getCellText(3,row));
            setRadioValue(document.form.useYN, this.getCellText(4,row)=="사용"?"Y":"N");
            $("#doclinkID").val(this.getCellText(5,row));
            $("#progressReport").val(this.getCellText(6,row));
            $("#width").val(this.getCellText(7,row));
            $("#height").val(this.getCellText(8,row));
            $("#x").val(this.getCellText(9,row));
            $("#y").val(this.getCellText(10,row));

            var table = new AW.XML.Table;
    	  	table.setURL("simpleAction.do");
    	  	table.setAsync(false);
    	  	table.setRequestMethod("POST");
    	  	table.setParameter("returnType","List");
            table.setParameter("resultType","XML");
            table.setParameter("RFC","ZCWCOMMC05_WCM_158");
            table.setParameter("inParamKey","NOTICEID;");
            table.setParameter("outParamKey","PUBLICID;PUBLICCLASSCD;PUBLICNAME;");
            
            table.setParameter("NOTICEID", this.getCellText(0,row));
    	  	table.request();

    	  	var rowCount = table.getCount();
    	  	var publicID = "";
    	  	var publicClassCD = "";
    	  	var publicName = "";
          	if (rowCount > 0) {
          		var data = new Array();
          		for (var i=0; i < rowCount; i++) {
          			publicID = publicID + table.getData(0,i) + ";";
          			publicClassCD = publicClassCD + table.getData(1,i) + ";";
          			publicName = publicName + table.getData(2,i) + ";";
          		}
          		
          		$("#publicID").val(publicID);
          		$("#publicClassCD").val(publicClassCD);
          		$("#publicName").val(publicName);
          	}
          	else {
          		$("#publicID").val("");
          		$("#publicClassCD").val("");
          		$("#publicName").val("");
          	}
	    }
	}
    
    createGrid();
	grid.refresh();
	
</script>

<script type="text/javascript">

	YAHOO.util.Event.onDOMReady(function () { 
		var uiLayer = YAHOO.util.Dom.getRegion('selectLink');
		var overlay = YAHOO.util.Dom.get('uploaderOverlay');
		YAHOO.util.Dom.setStyle(overlay, 'width', uiLayer.right-uiLayer.left + "px");
		YAHOO.util.Dom.setStyle(overlay, 'height', uiLayer.bottom-uiLayer.top + "px");
	});

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
    }
    
    // When contentReady event is fired, you can call methods on the uploader.
    function handleContentReady () {
        // Allows the uploader to send log messages to trace, as well as to YAHOO.log
        uploader.setAllowLogging(true);
        
        // Disallows multiple file selection in "Browse" dialog.
        uploader.setAllowMultipleFiles(false);
        
        // New set of file filters.
        var ff = new Array({description:"Images", extensions:"*.jpg;*.png;*.gif"}
                           );
                           
        // Apply new set of file filters to the uploader.
        uploader.setFileFilters(ff);
    }

    // Actually uploads the files. Since we are only allowing one file
    // to be selected, we use the upload function, in conjunction with the id 
    // of the selected file (returned by the fileSelect event). We are also including
    // the text of the variables specified by the user in the input UI.

    function upload() {
    if (fileID != null) {
        /*
        uploader.upload(fileID, "http://www.yswfblog.com/upload/upload.php", 
                        "POST", 
                        {});
        */
        uploader.upload(fileID, "${contextPath}/doclink.do?method=insertFileForYUI", 
                        "POST", 
                        {linkDivCD:"NOTICE",
                         linkID:document.getElementById("noticeID").value});
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
        var fileData = event.data.split(';');
        if (fileData[0] == 'S') {
        	$("#doclinkID").val(fileData[4]);
        	this.progressReport.value = fileData[2];
        }
        else if (fileData[0] == 'E') {
            if (fileData[1] != "") {
                alert(fileData[1]);
            }
            else {
            	alert('File Upload Error.');
            }
        }
    } 
    
    function fileDownload(docLinkID) {
    	if($("#doclinkID").val() == ''){
			alert('다운로드할 첨부파일이 없습니다.');
			return;
        }
        
        url = "doclink.do?method=downloadFile&docLinkID="+docLinkID;
        form.action = url;
        form.target = "downloadFrame";
        form.submit();
    }
    
</script>