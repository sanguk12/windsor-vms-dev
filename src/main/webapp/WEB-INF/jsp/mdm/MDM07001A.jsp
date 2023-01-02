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
					</td>
				</tr>
			<tr>
				<td height="1">
					<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr>
							<td class="tb-border">
								<table border="0" cellpadding="0" cellspacing="0" width="100%"
									style="border: #e1dcbe solid 1px; table-layout: fixed;">
									<colgroup>
										<col style="width: 100px"></col>
										<col style="width: 180px"></col>
										<col style="width: 100px"></col>
										<col style="width: 180px"></col>
										<col style="width: 100px"></col>
										<col style="width: 120px"></col>
										<col style="width: 100px"></col>
										<col></col>
									</colgroup>
									<tbody>
										<tr>
											<td class="td-cond">
												<fmt:message key="MDM02001A.venueCD" />
											</td>
											<td class="td-input">
												<input type="text" id="venueCD" name="venueCD" style="width: 150px;">
											</td>
											<td class="td-cond">
												<fmt:message key="MDM02001A.venueNm" />
											</td>
											<td class="td-input">
												<input type="text" id="venueNm" name="venueNm" style="width: 150px;">
											</td>
											<td class="td-cond">
												<fmt:message key="MDM02001A.venueGradCD" />
											</td>
											<td class="td-input">
												<nis:selectbox id="venueGradCD" name="venueGradCD" defaultText="all" category="VENUEGRADCD" />
											</td>
											<td class="td-cond">
												<fmt:message key="MDM02001A.activeYN" />
												</td>
											<td class="td-input">
												<nis:selectbox id="activeYN" name="activeYN" defaultText="all" category="ACTIVEYN" /></td>
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
						<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
	                   		<tr>
	                   			<td width="48%">
									<span id="grid"></span>
								</td>
								<td width="4%" align="center">
									<img src="${contextPath}/images/ico/btn_arrow_right.gif" onclick="Add();" style="cursor:hand;" alt="<fmt:message key="button.Add" />"><br><br>
									<img src="${contextPath}/images/ico/btn_arrow_left.gif" onclick="Remove();" style="cursor:hand;" alt="<fmt:message key="button.Remove" />">
								</td>
								<td width="*">
									<span id="grid_remove"></span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1">
						<input type="hidden" id="apprTpID" name="apprTpID" value="000007" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid .aw-column-0  {width: 35px; text-align:center;}
	#grid .aw-column-1  {width: 80px; text-align:center;}
    #grid .aw-column-2  {width: 100px; text-align:left;}
    #grid .aw-column-3  {width: 60px; text-align:center;}
    #grid .aw-column-4  {width: 100px; text-align:center;}
    #grid .aw-column-5  {width: 100px; text-align:center;}
    #grid .aw-column-6  {width: 100px; text-align:center;}
    #grid .aw-column-7  {width: 100px; text-align:center;}
    #grid .aw-column-8  {width: 100px; text-align:center;}
    #grid .aw-column-9  {width: 100px; text-align:center;}
    #grid .aw-column-10 {width: 100px; text-align:center;}
    #grid .aw-column-11 {width: 100px; text-align:center;}
    #grid .aw-column-12 {width: 100px; text-align:center;}
    #grid .aw-column-13 {width: 100px; text-align:center;}
    
    #grid_remove .aw-column-0  {width: 35px; text-align:center;}
	#grid_remove .aw-column-1  {width: 80px; text-align:center;}
    #grid_remove .aw-column-2  {width: 100px; text-align:left;}
    #grid_remove .aw-column-3  {width: 60px; text-align:center;}
    #grid_remove .aw-column-4  {width: 100px; text-align:center;}
    #grid_remove .aw-column-5  {width: 100px; text-align:center;}
    #grid_remove .aw-column-6  {width: 100px; text-align:center;}
    #grid_remove .aw-column-7  {width: 100px; text-align:center;}
    #grid_remove .aw-column-8  {width: 100px; text-align:center;}
    #grid_remove .aw-column-9  {width: 100px; text-align:center;}
    #grid_remove .aw-column-10 {width: 100px; text-align:center;}
    #grid_remove .aw-column-11 {width: 100px; text-align:center;}
    #grid_remove .aw-column-12 {width: 100px; text-align:center;}
    #grid_remove .aw-column-13 {width: 100px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	var maxRow = 0;
	var maxRow_remove = 0;
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			
			$("#activeYN").val("Y");	
			createGrid();
			grid.refresh();
			
			createGrid_remove();
			grid_remove.refresh();
			
			Search();
			
		};

		${initScript}
		
		$("#venueCD").keypress(function(){
			if (event.keyCode==13){
				Search();
			}
		});
		$("#venueNm").keypress(function(){
			if (event.keyCode==13){
				Search();
			}
		});
		$("#territory").keypress(function(){
			if (event.keyCode==13){
				getTerritoryName("territory", "territoryCD", "territoryCDName");
			}
		});
		$("#territory_popup").click(function(){
			openTerritoryPopup("closeTerritoryPopup");
		});
		
	});
	
	//Territory 팝업 close
	function closeTerritoryPopup(data) {
		$("#territory").val(data.territoryCD);
		$("#territoryCD").val(data.territoryCD);
        $("#territoryCDName").val(data.territoryCDName);
	}
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		checkbox : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++            
		, addrTpCD2Name : _i++            
		, addrTpCD3Name : _i++            
		, oldAddr2 : _i++
		, postCD : _i++
		, ws1SapCD : _i++                 
		, ws1SapCDName : _i++             
		, branch1 : _i++         
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MDM0700101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;venueCD;venueNm;venueGradCDName;subSegmentCDName;"+
	  			"addrTpCD1Name;addrTpCD2Name;addrTpCD3Name;oldAddr2;postCD;"+
	  			"ws1SapCD;ws1SapCDName;branch1;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;");
	  	table.setParameter("dkmdTpCD", "DK");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("venueNm", $("#venueNm").val());
		table.setParameter("venueGradCD", $("#venueGradCD").val());
		table.setParameter("activeYN", $("#activeYN").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.addrTpCD3Name,i)
					, table.getData(_col.oldAddr2,i)
					, table.getData(_col.postCD,i)
					, table.getData(_col.ws1SapCD,i)
					, table.getData(_col.ws1SapCDName,i)
					, table.getData(_col.branch1,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
      	
      	maxRow = rowCount;
      	Search_remove();
	}
	
	var _i_remove = 0;
	var _col_remove = {
		checkbox : _i_remove++
		, venueCD : _i_remove++
		, venueNm : _i_remove++
		, venueGradCDName : _i_remove++
		, subSegmentCDName : _i_remove++
		, addrTpCD1Name : _i_remove++            
		, addrTpCD2Name : _i_remove++            
		, addrTpCD3Name : _i_remove++            
		, oldAddr2 : _i_remove++
		, postCD  : _i_remove++
		, ws1SapCD : _i_remove++                 
		, ws1SapCDName : _i_remove++             
		, branch1 : _i_remove++         
		, activeFlg : _i_remove++
    };
	function Search_remove() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MDM0700102S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;venueCD;venueNm;venueGradCDName;subSegmentCDName;"+
	  			"addrTpCD1Name;addrTpCD2Name;addrTpCD3Name;oldAddr2;postCD;"+
	  			"ws1SapCD;ws1SapCDName;branch1;activeFlg;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("dkmdTpCD", "DK");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("venueNm", $("#venueNm").val());
		table.setParameter("venueGradCD", $("#venueGradCD").val());
		table.setParameter("activeYN", $("#activeYN").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.request();
      	
// 	  	if (grid_remove != null) grid_remove.clear();
      	createGrid_remove();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
					, table.getData(_col_remove.venueCD,i)
					, table.getData(_col_remove.venueNm,i)
      			    , table.getData(_col_remove.venueGradCDName,i)
					, table.getData(_col_remove.subSegmentCDName,i)
					, table.getData(_col_remove.addrTpCD1Name,i)
					, table.getData(_col_remove.addrTpCD2Name,i)
					, table.getData(_col_remove.addrTpCD3Name,i)
					, table.getData(_col_remove.oldAddr2,i)
					, table.getData(_col_remove.postCD,i)
					, table.getData(_col_remove.ws1SapCD,i)
					, table.getData(_col_remove.ws1SapCDName,i)
					, table.getData(_col_remove.branch1,i)
					, "U"
      			];
      		}
      		grid_remove.setCellData(data);
      		grid_remove.setRowCount(rowCount);
      	}
      	grid_remove.refresh();
      	
      	maxRow_remove = rowCount;
	}
	
	function Add() {
		message("<fmt:message key="MDM07001A.msg1" />");
		
		showLoading();
		window.setTimeout(function() {
			ActionAdd();
			hideLoading();
		}, 700);
	}
	
	function ActionAdd() {
		var index = grid.getRowIndices();
		if (index == "") {
			index = new Array();
			for (var i = 0; i < maxRow; i++) {
				index[i] = i;
			}
		}
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				grid_remove.addRow(maxRow_remove++);
				grid_remove.setCellText(grid.getCellText(_col.venueCD, index[i]), _col_remove.venueCD, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.venueNm, index[i]), _col_remove.venueNm, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.venueGradCDName, index[i]), _col_remove.venueGradCDName, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.subSegmentCDName, index[i]), _col_remove.subSegmentCDName, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.addrTpCD1Name, index[i]), _col_remove.addrTpCD1Name, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.addrTpCD2Name, index[i]), _col_remove.addrTpCD2Name, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.addrTpCD3Name, index[i]), _col_remove.addrTpCD3Name, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.oldAddr2, index[i]), _col_remove.oldAddr2, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.postCD, index[i]), _col_remove.postCD, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.ws1SapCD, index[i]), _col_remove.ws1SapCD, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.ws1SapCDName, index[i]), _col_remove.ws1SapCDName, maxRow_remove-1);
				grid_remove.setCellText(grid.getCellText(_col.branch1, index[i]), _col_remove.branch1, maxRow_remove-1);
				grid_remove.setCellText("I", _col_remove.activeFlg, maxRow_remove-1);
			}
		}
		
		for(var i=index.length-1; i >= 0; i--) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				grid.deleteRow(index[i]);
			}
		}
	}

	function Remove(){
		message("<fmt:message key="MDM07001A.msg2" />");
		
		var index_remove = grid_remove.getRowIndices();
		if (index_remove == ""){
			index_remove = new Array();
			for (var i = 0; i < maxRow_remove; i++){
				index_remove[i] = i;
			}
		}
		
		for(var i=0; i<index_remove.length; i++) {
			if (grid_remove.getCellValue(_col_remove.checkbox, index_remove[i])) {
				grid.addRow(maxRow++);
				grid.setCellText(grid_remove.getCellText(_col_remove.venueCD, index_remove[i]), _col.venueCD, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.venueNm, index_remove[i]), _col.venueNm, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.venueGradCDName, index_remove[i]), _col.venueGradCDName, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.subSegmentCDName, index_remove[i]), _col.subSegmentCDName, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.addrTpCD1Name, index_remove[i]), _col.addrTpCD1Name, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.addrTpCD2Name, index_remove[i]), _col.addrTpCD2Name, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.addrTpCD3Name, index_remove[i]), _col.addrTpCD3Name, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.oldAddr2, index_remove[i]), _col.oldAddr2, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.postCD, index_remove[i]), _col.postCD, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.ws1SapCD, index_remove[i]), _col.ws1SapCD, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.ws1SapCDName, index_remove[i]), _col.ws1SapCDName, maxRow-1);
				grid.setCellText(grid_remove.getCellText(_col_remove.branch1, index_remove[i]), _col.branch1, maxRow-1);
			}
		}
		
		for(var i=index_remove.length-1; i >= 0; i--) {
			if (grid_remove.getCellValue(_col_remove.checkbox, index_remove[i])) {
				grid_remove.setCellText("D", _col_remove.activeFlg, index_remove[i]);
				grid_remove.deleteRow(index_remove[i]);
			}
		}
	}

	
	function Save() {
		if(maxRow_remove == 0) {
			alert("<fmt:message key="info.validate.gridSelect"/>");
			return;
		}
		var venueCDs = new Array(); 
		var activeFlgs = new Array(); 
		var count = 0;
		for (var i=0; i<maxRow_remove; i++) {
			venueCDs[count] = grid_remove.getCellText(_col_remove.venueCD, i);
			activeFlgs[count] = grid_remove.getCellText(_col_remove.activeFlg, i);
			count++;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mdm07/saveRmTmpVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("activeFlgs", activeFlgs);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}

	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		""
		, "<fmt:message key="MDM07001A.venueCD"/>"
		, "<fmt:message key="MDM07001A.venueNm"/>"
		, "<fmt:message key="MDM07001A.venueGradCDName"/>"
		, "<fmt:message key="MDM07001A.subSegmentCDName"/>"
		, "<fmt:message key="MDM05001A.addrTpCD1Name"/>"
		, "<fmt:message key="MDM05001A.addrTpCD2Name"/>"
		, "<fmt:message key="MDM05001A.addrTpCD3Name"/>"
		, "<fmt:message key="MDM05001A.addrTpCD4Name"/>"
		, "<fmt:message key="MDM05001A.postCD"/>"
		, "<fmt:message key="MDM05001A.wsSapCode"/>"
		, "<fmt:message key="MDM05001A.wsSapName"/>"
		, "<fmt:message key="MDM05001A.wsBranch"/>"
	];
	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                        str, str, str, str, str, 
	                        str, str, str, str, str,
	                        str, str, str
	                        ]);
	    grid.setCellEditable(false);
	    
	    grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellValue(false, _col.checkbox);
		
		grid.setHeaderTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.onHeaderClicked=function(event,col){
			if (col == _col.checkbox && this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(true, _col.checkbox);
			}
			else if (col == _col.checkbox && !this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(false, _col.checkbox);
			}
			return false;
		};
		
    }
	
	var columns_remove = [
		""
		, "<fmt:message key="MDM07001A.venueCD"/>"
		, "<fmt:message key="MDM07001A.venueNm"/>"
		, "<fmt:message key="MDM07001A.venueGradCDName"/>"
		, "<fmt:message key="MDM07001A.subSegmentCDName"/>"
		, "<fmt:message key="MDM05001A.addrTpCD1Name"/>"
		, "<fmt:message key="MDM05001A.addrTpCD2Name"/>"
		, "<fmt:message key="MDM05001A.addrTpCD3Name"/>"
		, "<fmt:message key="MDM05001A.addrTpCD4Name"/>"
		, "<fmt:message key="MDM05001A.postCD"/>"
		, "<fmt:message key="MDM05001A.wsSapCode"/>"
		, "<fmt:message key="MDM05001A.wsSapName"/>"
		, "<fmt:message key="MDM05001A.wsBranch"/>"
	];
	var grid_remove = null;
	function createGrid_remove() {
		grid_remove = new AW.UI.Grid;
	    grid_remove.setId("grid_remove");
	    grid_remove.setRowCount(0);
	    grid_remove.setStyle("width","100%");
	    grid_remove.setStyle("height","100%");
	    grid_remove.setSelectorVisible(false);
	    grid_remove.setSelectionMode("single-row");
	    grid_remove.setHeaderText(columns_remove);
	    for(var i=0;i<columns_remove.length;i++){grid_remove.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_remove.setColumnCount(columns_remove.length);
	    grid_remove.setCellFormat([
			str, str, str, str, str, 
			str, str, str, str, str,
			str, str, str
		]);
	    grid_remove.setCellEditable(false);
	    
	    grid_remove.setCellTemplate(new AW.Templates.CheckBox, _col_remove.checkbox);
		grid_remove.setCellValue(false, _col_remove.checkbox);
		
		grid_remove.setHeaderTemplate(new AW.Templates.CheckBox, _col_remove.checkbox);
		grid_remove.setCellTemplate(new AW.Templates.CheckBox, _col_remove.checkbox);
		grid_remove.onHeaderClicked=function(event,col){
			if (col == _col_remove.checkbox && this.getHeaderValue(_col_remove.checkbox,0)) {
				this.setCellValue(true, _col_remove.checkbox);
			}
			else if (col == _col_remove.checkbox && !this.getHeaderValue(_col_remove.checkbox,0)) {
				this.setCellValue(false, _col_remove.checkbox);
			}
			return false;
		};
		
    }

</script>