<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><fmt:message key="application.title" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@include file="../scripts.jsp" %>
        
	</head>
	<body>
		<form name="form" method="post">
			<input type="hidden" name="isView" value="${params.isView}" />
			<input type="hidden" name="linkDivCD" value="${params.linkDivCD}" />
			<input type="hidden" name="linkID" value="${params.linkID}" />
			<span id="grid"></span><div id="tmp"></div>
			<table width="100%" cellspacing="0" cellpadding="0">
				<tr><td align="right">
					<c:if test="${params.isView=='true'}">
					<nis:button preset="widget" id="AttachFile" eventproc="FileUpload();" />
					<nis:button preset="widget" id="DetachFile" eventproc="FileDelete();" />
					</c:if>			
				</td></tr>
			</table>
			<iframe src="" id="downloadFrame" name="downloadFrame" style="width:0px;height:0px;"></iframe>
		</form>
	</body>
</html>

<style type="text/css">
<!--
    body {margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-bottom: 0px;}
    .aw-grid-control {margin: 0px; font-size:12px; font-family:"Dodum,Arial,Tahoma";}
    .aw-ui-button {font-size:12px; font-family:"Dodum,Arial,Tahoma";}
    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript" language="javascript">
	var servlet = "${contextPath}/doclink.do";
	// Upload
	function FileUpload() {
		newWindow(servlet+"?method=uploadFileInit&linkDivCD=${params.linkDivCD}&linkID=${params.linkID}", "fileUpload", "600", "300", "no");
	}
	
	// Delete
	function FileDelete() {
		var rowCount = grid.getRowCount();
		var docLinks = new Array();
		
		var selectedIndex = grid.getSelectedRows();
		if(selectedIndex.length>0) {
			for(var i=0;i<selectedIndex.length;i++) {
				docLinks[i] = grid.getCellText(2,selectedIndex[i]);
			}
		} else {
			alert("<fmt:message key="infos.selected" />");
		}
		
		var table = new AW.XML.Table;
	  	table.setURL(servlet);
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("docLinks", docLinks);
	  	table.setParameter("mnuGrpID", "${params.mnuGrpID}");
	  	table.setParameter("pgmID", "${params.pgmID}");
	  	table.setParameter("viewID", "${params.viewID}");
	  	table.setParameter("method", "deleteListFile");
      	table.request();

      	Search();
	}
	
	// Download
	function FileDownload(docLinkID) {
		url = servlet+"?method=downloadFile&docLinkID="+docLinkID;
		form.action = url;
		form.target = "downloadFrame";
		form.submit();
	}
	
	function Search() {
		var message = "";
		if(arguments.length<=0) {
			message = "";
		}
		fnSubmitConfirm(form, servlet, "listFile", message);
	}
	
	var keyIndex = 2;
	var fixedLeft = 0;
	var gridWidth = "100%";
	var gridHeight = "100px";
	var headerHeight = 20;
	var rowHeight = 25;
	var cellEditable = true;
	var selectionMode = "multi-row-marker"; // single-cell, single-row, multi-row, multi-row-marker
	var grid = new AW.Grid.Extended; grid.setId("grid");grid.setRowHeight(rowHeight);
	
	/* Grid Layout Design */
	grid.setColumnWidth(500,  0); grid.getCellTemplate(0).setStyle("text-align", "left");
	grid.setColumnWidth(130, 1); grid.getCellTemplate(1).setStyle("text-align", "right");
	grid.setColumnWidth(0, 2); grid.getCellTemplate(2).setStyle("text-align", "left");
	
	/* set row selection */
	grid.setSelectionMode(selectionMode); grid.setStyle("width", "100%"); grid.setFixedLeft(fixedLeft);
	
	/* set cell Edit(true/false, cell number) */
	grid.setCellEditable(cellEditable);
	
	/* set Height Design */
	grid.setHeaderHeight(headerHeight);
	
	/* column Setting */
	var columns = [
		"<fmt:message key="fileName"/>",
		"<fmt:message key="fileSize"/>", ""
	];
	grid.setHeaderText(columns);grid.setColumnCount(columns.length);for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	grid.setStyle("width", gridWidth);
	grid.setStyle("height", gridHeight);
	
	/* data and data format Setting */
	var disagreeData = [
	<c:forEach items="${docLinkList}" var="file" varStatus="status">
		[
			"<a href=\"javascript:FileDownload('${file.docLinkID}');\">"+
			"<img src=\"${contextPath}/images/filetype/${file.fileTypeCD}.gif\" onerror=\"this.src='${contextPath}/images/filetype/unknown.gif'\" align=\"absmiddle\" /> ${file.fileName}"+
			"</a>",
			"${file.fileSize}",
			"${file.docLinkID}"
		],
	</c:forEach>
		["", "", ""]
	];grid.setCellData(disagreeData);grid.setRowCount(disagreeData.length-1);
	grid.setCellFormat([html, string, string]);
	grid.refresh();
</script>