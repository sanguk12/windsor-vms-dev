<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		<%@include file="../sys3/scripts.jsp" %>
	</head>

	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" id="form" method="post" enctype="multipart/form-data">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            	<tr>
                    <td height="1">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
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
												<td class="td-cond"><fmt:message key="uploadFile"/></td>
												<td class="td-input">
													<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					                           			<tr>
					                               			<td height="25" width="310">
					                                   			<div id="selectedFileDisplay">
					                                       			<input type="text" cols="100" id="progressReport" value="" style="width:300px;" class="file_input_textbox" readonly="readonly" >
					                                   			</div>
					                               			</td>
					                               			<td width="75"> 
					                                   			<div id="uploaderContainer" class="file_input_div">
                                                             		<input type="button" class="file_input_button" />
                                                             		<input type="file" name="fileuploader" id="fileuploader" class="file_input_hidden">                                
					                                   			</div>
					                               			</td>
					                               			<td width="*">
					                                   			<div id="uploadFilesLink">
					                                   				<a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a>
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
					<td height="*">
						<span id="grid"></span>
					</td>
				</tr>
				<tr>
					<td height="1">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 100px; text-align:center;}
    .aw-column-1 {width: 150px; text-align:left;}
    .aw-column-2 {width: 80px; text-align:center;}
    .aw-column-3 {width: 120px; text-align:left;}
    .aw-column-4 {width: 80px; text-align:center;}
    .aw-column-5 {width: 100px; text-align:left;}
    .aw-column-6 {width: 100px; text-align:left;}
    .aw-column-7 {width: 100px; text-align:left;}
    .aw-column-8 {width: 100px; text-align:left;}
    .aw-column-9 {width: 100px; text-align:left;}
    .aw-column-10 {width: 120px; text-align:left;}
    .aw-column-11 {width: 150px; text-align:left;}
    .aw-column-12 {width: 150px; text-align:left;}
    .aw-column-13 {width: 120px; text-align:left;}
    .aw-column-14 {width: 180px; text-align:left;}
    .aw-column-15 {width: 150px; text-align:left;}
    .aw-column-16 {width: 150px; text-align:left;}
    .aw-column-17 {width: 150px; text-align:left;}
    .aw-column-18 {width: 150px; text-align:left;}
    .aw-column-19 {width: 100px; text-align:left;}
    .aw-column-20 {width: 100px; text-align:center;}
    .aw-column-21 {width: 60px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	$(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			grid.refresh();
			
		};

		${initScript}

	});
	
	function SetGridData(xmlData) {
	
		var data = new Array();
		var rowCount = 0;

		createGrid();

		$(xmlData).find("rows").each(function(i) {
			$(this).children().each(function(j) {
				data[j] = [
					$(this).find("venueCD").text()
					, $(this).find("venueNm").text()
					, $(this).find("dkmdTpCDName").text()
					, $(this).find("territoryCDName").text()
					, $(this).find("venueGradCDName").text()
					, $(this).find("channelCDName").text()
					, $(this).find("subChannelCDName").text()
					, $(this).find("segmentCDName").text()
					, $(this).find("subSegmentCDName").text()
					, $(this).find("addrTpCD1Name").text()
					, $(this).find("addrTpCD2Name").text()
					, $(this).find("addrTpCD3Name").text()
					, $(this).find("addrTpCD4Name").text()
					, $(this).find("wsCDName").text()
					, $(this).find("wsSapCDName").text()
					, $(this).find("note1").text()
					, $(this).find("note2").text()
					, $(this).find("note3").text()
					, $(this).find("note4").text()
					, $(this).find("incntTpCDName").text()
					, $(this).find("venueDivCDName").text()
					, $(this).find("activeYNName").text()
					
					, $(this).find("dkmdTpCD").text()
					, $(this).find("territoryCD").text()
					, $(this).find("venueGradCD").text()
					, $(this).find("channelCD").text()
					, $(this).find("subChannelCD").text()
					, $(this).find("segmentCD").text()
					, $(this).find("subSegmentCD").text()
					, $(this).find("addrTpCD1").text()
					, $(this).find("addrTpCD2").text()
					, $(this).find("addrTpCD3").text()
					, $(this).find("addrTpCD4").text()
					, $(this).find("wsCD").text()
					, $(this).find("wsSapCD").text()
					, $(this).find("incntTpCD").text()
					, $(this).find("venueDivCD").text()
					, $(this).find("activeYN").text()
				];
				rowCount++;
			});
		});

		grid.setCellData(data);
		grid.setRowCount(rowCount);
		grid.refresh();
		
		hideLoading();
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		venueCD : _i++
		, venueNm : _i++
		, dkmdTpCDName : _i++
		, territoryCDName : _i++
		, venueGradCDName : _i++
		, channelCDName : _i++
		, subChannelCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, addrTpCD3Name : _i++
		, addrTpCD4Name : _i++
		, wsCDName : _i++
		, wsSapCDName : _i++
		, note1 : _i++
		, note2 : _i++
		, note3 : _i++
		, note4 : _i++
		, incntTpCDName : _i++
		, venueDivCDName : _i++
		, activeYNName : _i++
		
		, dkmdTpCD : _i++
		, territoryCD : _i++
		, venueGradCD : _i++
		, channelCD : _i++
		, subChannelCD : _i++
		, segmentCD : _i++
		, subSegmentCD : _i++
		, addrTpCD1 : _i++
		, addrTpCD2 : _i++
		, addrTpCD3 : _i++
		, addrTpCD4 : _i++
		, wsCD : _i++
		, wsSapCD : _i++
		, incntTpCD : _i++
		, venueDivCD : _i++
		, activeYN : _i++
    };
	function Save() {
		if(grid.getRowCount()==0) {
			alert("<fmt:message key="msg.upload"/>");
			return;
		}
		
		var index = grid.getRowIndices();
		if (index == '') {
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellText(_col.venueNm, i) == "") {alert("<fmt:message key="MDM02001B.msg4" />"); setCellFocus(grid, _col.venueNm, i); return;}
			if (grid.getCellText(_col.dkmdTpCD, i) == "") {alert("<fmt:message key="MDM02001B.msg5" />"); setCellFocus(grid, _col.dkmdTpCDName, i); return;}
			if (grid.getCellText(_col.territoryCD, i) == "") {alert("<fmt:message key="MDM02001B.msg6" />"); setCellFocus(grid, _col.territoryCDName, i); return;}
			if (grid.getCellText(_col.venueGradCD, i) == "") {alert("<fmt:message key="MDM02001B.msg7" />"); setCellFocus(grid, _col.venueGradCDName, i); return;}
			if (grid.getCellText(_col.channelCD, i) == "") {alert("<fmt:message key="MDM02001B.msg8" />"); setCellFocus(grid, _col.channelCDName, i); return;}
			if (grid.getCellText(_col.subChannelCD, i) == "") {alert("<fmt:message key="MDM02001B.msg9" />"); setCellFocus(grid, _col.subChannelCDName, i); return;}
			if (grid.getCellText(_col.segmentCD, i) == "") {alert("<fmt:message key="MDM02001B.msg10" />"); setCellFocus(grid, _col.segmentCDName, i); return;}
			if (grid.getCellText(_col.subSegmentCD, i) == "") {alert("<fmt:message key="MDM02001B.msg11" />"); setCellFocus(grid, _col.subSegmentCDName, i); return;}
			if (grid.getCellText(_col.addrTpCD1, i) == "") {alert("<fmt:message key="MDM02001B.msg12" />"); setCellFocus(grid, _col.addrTpCD1Name, i); return;}
			if (grid.getCellText(_col.addrTpCD2, i) == "") {alert("<fmt:message key="MDM02001B.msg13" />"); setCellFocus(grid, _col.addrTpCD2Name, i); return;}
// 			if (grid.getCellText(_col.addrTpCD3, i) == "") {alert("<fmt:message key="MDM02001B.msg14" />"); setCellFocus(grid, _col.addrTpCD3Name, i); return;}
			if (grid.getCellText(_col.wsCD, i) == "") {alert("<fmt:message key="MDM02001B.msg15" />"); setCellFocus(grid, _col.wsCDName, i); return;}
			if (grid.getCellText(_col.wsSapCD, i) == "") {alert("<fmt:message key="MDM02001B.msg16" />"); setCellFocus(grid, _col.wsSapCDName, i); return;}
			if (grid.getCellText(_col.incntTpCD, i) == "") {alert("<fmt:message key="MDM02001B.msg21" />"); setCellFocus(grid, _col.incntTpCDName, i); return;}
			if (grid.getCellText(_col.venueDivCD, i) == "") {alert("<fmt:message key="MDM02001B.msg24" />"); setCellFocus(grid, _col.venueDivCDName, i); return;}
			if (grid.getCellText(_col.activeYN, i) == "") {alert("<fmt:message key="MDM02001B.msg22" />"); setCellFocus(grid, _col.activeYNName, i); return;}
		}

		showLoading();
		
		var venueCDs = new Array();
		var venueNms = new Array();
		var dkmdTpCDs = new Array();
		var territoryCDs = new Array();
		var venueGradCDs = new Array();
		var channelCDs = new Array();
		var subChannelCDs = new Array();
		var segmentCDs = new Array();
		var subSegmentCDs = new Array();
		var addrTpCD1s = new Array();
		var addrTpCD2s = new Array();
		var addrTpCD3s = new Array();
		var addrTpCD4s = new Array();
		var wsCDs = new Array();
		var wsSapCDs = new Array();
		var note1s = new Array();
		var note2s = new Array();
		var note3s = new Array();
		var note4s = new Array();
		var incntTpCDs = new Array();
		var venueDivCDs = new Array();
		var activeYNs = new Array();
		var count = 0;
	
		for (var i = 0; i < index.length; i++) {
			venueCDs[count]      = grid.getCellText(_col.venueCD, index[i]);
			venueNms[count]      = grid.getCellText(_col.venueNm, index[i]).replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">");
			dkmdTpCDs[count]     = grid.getCellText(_col.dkmdTpCD, index[i]);
			territoryCDs[count]  = grid.getCellText(_col.territoryCD, index[i]);
			venueGradCDs[count]  = grid.getCellText(_col.venueGradCD, index[i]);
			channelCDs[count]    = grid.getCellText(_col.channelCD, index[i]);
			subChannelCDs[count] = grid.getCellText(_col.subChannelCD, index[i]);
			segmentCDs[count]    = grid.getCellText(_col.segmentCD, index[i]);
			subSegmentCDs[count] = grid.getCellText(_col.subSegmentCD, index[i]);
			addrTpCD1s[count]    = grid.getCellText(_col.addrTpCD1, index[i]);
			addrTpCD2s[count]    = grid.getCellText(_col.addrTpCD2, index[i]);
			addrTpCD3s[count]    = grid.getCellText(_col.addrTpCD3, index[i]);
			addrTpCD4s[count]    = grid.getCellText(_col.addrTpCD4, index[i]);
			wsCDs[count]         = grid.getCellText(_col.wsCD, index[i]);
			wsSapCDs[count]      = grid.getCellText(_col.wsSapCD, index[i]);
			note1s[count]        = grid.getCellText(_col.note1, index[i]);
			note2s[count]        = grid.getCellText(_col.note2, index[i]);
			note3s[count]        = grid.getCellText(_col.note3, index[i]);
			note4s[count]        = grid.getCellText(_col.note4, index[i]);
			incntTpCDs[count]    = grid.getCellText(_col.incntTpCD, index[i]);
			venueDivCDs[count]   = grid.getCellText(_col.venueDivCD, index[i]);
			activeYNs[count]     = grid.getCellText(_col.activeYN, index[i]);
			count++;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mdm02/saveVenueGrid");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("venueNms", venueNms);
		table.setParameter("dkmdTpCDs", dkmdTpCDs);
		table.setParameter("territoryCDs", territoryCDs);
		table.setParameter("venueGradCDs", venueGradCDs);
		table.setParameter("channelCDs", channelCDs);
		table.setParameter("subChannelCDs", subChannelCDs);
		table.setParameter("segmentCDs", segmentCDs);
		table.setParameter("subSegmentCDs", subSegmentCDs);
		table.setParameter("addrTpCD1s", addrTpCD1s);
		table.setParameter("addrTpCD2s", addrTpCD2s);
		table.setParameter("addrTpCD3s", addrTpCD3s);
		table.setParameter("addrTpCD4s", addrTpCD4s);
		table.setParameter("wsCDs", wsCDs);
		table.setParameter("wsSapCDs", wsSapCDs);
		table.setParameter("note1s", note1s);
		table.setParameter("note2s", note2s);
		table.setParameter("note3s", note3s);
		table.setParameter("note4s", note4s);
		table.setParameter("incntTpCDs", incntTpCDs);
		table.setParameter("venueDivCDs", venueDivCDs);
		table.setParameter("activeYNs", activeYNs);
		table.request();
		
		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
   		}
		else {
			alert(table.getData(1,0));
		}
		
		hideLoading();
	}


	function List() {
		parent.Search();
		parent.appletClose();
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="MDM02001A.venueCD"/>"
		, "<fmt:message key="MDM02001A.venueNm"/>"
		, "<fmt:message key="MDM02001A.dkmdTpCD"/>"
		, "<fmt:message key="MDM02001A.territoryCD"/>"
		, "<fmt:message key="MDM02001A.venueGradCD"/>"
		, "<fmt:message key="MDM02001A.channelCD"/>"
		, "<fmt:message key="MDM02001A.subChannelCD"/>"
		, "<fmt:message key="MDM02001A.segmentCD"/>"
		, "<fmt:message key="MDM02001A.subSegmentCD"/>"
		, "<fmt:message key="MDM02001A.addrTpCD1"/>"
		, "<fmt:message key="MDM02001A.addrTpCD2"/>"
		, "<fmt:message key="MDM02001A.addrTpCD3"/>"
		, "<fmt:message key="MDM02001A.addrTpCD4"/>"
		, "<fmt:message key="MDM02001A.wsCDName"/>"
		, "<fmt:message key="MDM02001A.wsSapCDName"/>"
		, "<fmt:message key="MDM02001A.note1"/>"
		, "<fmt:message key="MDM02001A.note2"/>"
		, "<fmt:message key="MDM02001A.note3"/>"
		, "<fmt:message key="MDM02001A.note4"/>"
		, "<fmt:message key="MDM02001A.incntTpCDName"/>"
		, "<fmt:message key="MDM02001A.venueDivCDName"/>"
		, "<fmt:message key="MDM02001A.activeYN"/>"
    ];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
	    grid.setId("grid");
	    grid.setSize(400, 200);
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-cell");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                          str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , str
	                        ]);
	    grid.setCellEditable(true);
	    grid.setCellEditable(false, _col.dkmdTpCDName);
	    grid.setCellEditable(false, _col.territoryCDName);
	    grid.setCellEditable(false, _col.venueGradCDName);
	    grid.setCellEditable(false, _col.channelCDName);
	    grid.setCellEditable(false, _col.subChannelCDName);
	    grid.setCellEditable(false, _col.segmentCDName);
	    grid.setCellEditable(false, _col.subSegmentCDName);
	    grid.setCellEditable(false, _col.addrTpCD1Name);
	    grid.setCellEditable(false, _col.addrTpCD2Name);
	    grid.setCellEditable(false, _col.addrTpCD3Name);
	    grid.setCellEditable(false, _col.addrTpCD4Name);
	    grid.setCellEditable(false, _col.wsCDName);
	    grid.setCellEditable(false, _col.wsSapCDName);
	    grid.setCellEditable(false, _col.incntTpCDName);
	    grid.setCellEditable(false, _col.venueDivCDName);
	    grid.setCellEditable(false, _col.activeYNName);
		
	    grid.setCellTemplate(new AW.Templates.Combo, _col.dkmdTpCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.venueGradCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.channelCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.subChannelCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.segmentCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.subSegmentCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.addrTpCD1Name);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.addrTpCD2Name);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.addrTpCD3Name);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.wsCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.incntTpCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.venueDivCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.activeYNName);
	    grid.setFixedLeft(2);
	    
		grid.setPopupTemplate(function(col, row) {
			
			if (col == _col.dkmdTpCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","DKMDTPCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value    = new Array();
	            var text     = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","90px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.dkmdTpCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.venueGradCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","VENUEGRADCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.venueGradCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.channelCDName) {
				grid.setCellText("", _col.subChannelCDName, row);
				grid.setCellText("", _col.subChannelCD, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","CHANNELCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.channelCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.subChannelCDName) {
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","SUBCHANNELCD");
	            table.setParameter("attrib02", grid.getCellText(_col.channelCD, row));
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.subChannelCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.segmentCDName) {
				grid.setCellText("", _col.subSegmentCDName, row);
				grid.setCellText("", _col.subSegmentCD, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","SEGMENTCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.segmentCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.subSegmentCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","SUBSEGMENTCD");
	            table.setParameter("attrib02", grid.getCellText(_col.segmentCD, row));
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.subSegmentCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.addrTpCD1Name) {
				grid.setCellText("", _col.addrTpCD2Name, row);
				grid.setCellText("", _col.addrTpCD2, row);
				grid.setCellText("", _col.addrTpCD3Name, row);
				grid.setCellText("", _col.addrTpCD3, row);
				grid.setCellText("", _col.addrTpCD4Name, row);
				grid.setCellText("", _col.addrTpCD4, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","ADDRTPCD1");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.addrTpCD1, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.addrTpCD2Name) {
				grid.setCellText("", _col.addrTpCD3Name, row);
				grid.setCellText("", _col.addrTpCD3, row);
				grid.setCellText("", _col.addrTpCD4Name, row);
				grid.setCellText("", _col.addrTpCD4, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","ADDRTPCD2");
	            table.setParameter("attrib02", grid.getCellText(_col.addrTpCD1, row));
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.addrTpCD2, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.addrTpCD3Name) {
				grid.setCellText("", _col.addrTpCD4Name, row);
				grid.setCellText("", _col.addrTpCD4, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","ADDRTPCD3");
	            table.setParameter("attrib02", grid.getCellText(_col.addrTpCD2, row));
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.addrTpCD3, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.wsCDName) {
				grid.setCellText("", _col.wsSapCDName, row);
				grid.setCellText("", _col.wsSapCD, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","WSCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.wsCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.incntTpCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","INCNTTPCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.incntTpCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.venueDivCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","VENUEDIVCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.venueDivCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.activeYNName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","ACTIVEYN");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.activeYN, row);
	            	}
	            	catch(e){}
	            };
			}
			
			
            return list;
        });
        
		grid.setCellImage("searchGrid", _col.territoryCDName);
		var search_territoryCDName = new AW.Templates.ImageText;
		var search_territoryCDName_Image = search_territoryCDName.getContent("box/image");
		search_territoryCDName_Image.setTag("a");
		search_territoryCDName_Image.setAttribute("href", function() {
			return "javascript:openTerritoryPopup_grid('closeTerritoryPopup_grid', grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_territoryCDName, _col.territoryCDName);
		
		grid.setCellImage("searchGrid", _col.addrTpCD4Name);
		var search_addrTpCD4Name = new AW.Templates.ImageText;
		var search_addrTpCD4Name_Image = search_addrTpCD4Name.getContent("box/image");
		search_addrTpCD4Name_Image.setTag("a");
		search_addrTpCD4Name_Image.setAttribute("href", function() {
			return "javascript:openAddrPopup_grid('closeAddrPopup_grid', grid.getCellText(_col.addrTpCD1, grid.getCurrentRow()), grid.getCellText(_col.addrTpCD2, grid.getCurrentRow()),  grid.getCellText(_col.addrTpCD3, grid.getCurrentRow()), grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_addrTpCD4Name, _col.addrTpCD4Name);
		
		grid.setCellImage("searchGrid", _col.wsSapCDName);
		var search_wsSapCDName = new AW.Templates.ImageText;
		var search_wsSapCDName_Image = search_wsSapCDName.getContent("box/image");
		search_wsSapCDName_Image.setTag("a");
		search_wsSapCDName_Image.setAttribute("href", function() {
			return "javascript:openWSPopup_grid('closeWSPopup_grid', grid.getCellText(_col.wsCD, grid.getCurrentRow()), grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_wsSapCDName, _col.wsSapCDName);
	
        
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

		grid.onCellEditEnded = function(text, col, row) {
			this.setCellText(text, col, row);
			this.focus();
		};
		// Cell startEdit END
		
		//  BEGIN validating (Enter, Cell LoseFocus)
		grid.onCellValidating = function(text, col, row) {
			if(col == _col.venueCD) {
				if(text.length>10) {
					this.setCellText(text.substring(0,10),col,row);
				}
			}
			if(col == _col.venueNm) {
				if(text.length>50) {
					this.setCellText(text.substring(0,50),col,row);
				}
			}
	    };
	
	    grid.onCellValidated = function(text, col, row) {
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
    }
	
	function closeTerritoryPopup_grid(data, row) {
		grid.setCellText(data.territoryCDName , _col.territoryCDName , row );
		grid.setCellText(data.territoryCD     , _col.territoryCD     , row );
	}
	
	function closeAddrPopup_grid(data, row) {
		grid.setCellText(data.addrTpCD1Name , _col.addrTpCD1Name , row);
		grid.setCellText(data.addrTpCD1     , _col.addrTpCD1     , row);
		grid.setCellText(data.addrTpCD2Name , _col.addrTpCD2Name , row);
		grid.setCellText(data.addrTpCD2     , _col.addrTpCD2     , row);
		grid.setCellText(data.addrTpCD3Name , _col.addrTpCD3Name , row);
		grid.setCellText(data.addrTpCD3     , _col.addrTpCD3     , row);
		grid.setCellText(data.addrTpCD4Name , _col.addrTpCD4Name , row);
		grid.setCellText(data.addrTpCD4     , _col.addrTpCD4     , row);
	}
	
	function closeWSPopup_grid(data, row) {
		grid.setCellText(data.wsCDName      , _col.wsCDName    , row);
		grid.setCellText(data.wsCD          , _col.wsCD        , row);
		grid.setCellText(data.wsSapCDName   , _col.wsSapCDName , row);
		grid.setCellText(data.wsSapCD       , _col.wsSapCD     , row);
	}

</script>

<script type="text/javascript">

	/**********************************************
	* fileupload setting
	**********************************************/
	
	$("#fileuploader").change(function(e) {
		var name = $("#fileuploader")[0].value;
		$("#progressReport").val(name.substring(name.lastIndexOf('\\')+1));
	});
	
	function upload() {
		if ($("#fileuploader").val() == "") {
			alert("파일을 선택해 주세요.");
		}
		else {
	        
			var linkIDVal = $("#articleID").val();
			$("#linkID").val(linkIDVal);
			
	        $("#form").ajaxForm({
	            url : "${contextPath}/service/mdm02/extractVenueXls",
	            enctype : "multipart/form-data",
	            data : 
					{
	            	userID:"${params.empID}"
	            	},
	            error : function(){
			        this.progressReport = document.getElementById("progressReport");
			        this.progressReport.value = "Upload error.";        	
			    	alert("Upload error..");
	            },
				xhr: function() {
					var xhr = $.ajaxSettings.xhr();
					xhr.upload.onprogress = function(e) {
						var percent = Math.round(e.loaded * 100 / e.total) + "%";
						if (percent == "100%") percent = "Complete!!";
						$("#progressReport").val(percent);
					}
					return xhr;
				},            
	            success : function(data){
 					$("#fileuploader").val("");

 					SetGridData(data);
				
			  		this.progressReport = document.getElementById("progressReport");
			        this.progressReport.value = "Complete!!";
			  		
	            }
	        });
	 
	        $("#form").submit() ;
	     	
		}
	}
	
	
</script>