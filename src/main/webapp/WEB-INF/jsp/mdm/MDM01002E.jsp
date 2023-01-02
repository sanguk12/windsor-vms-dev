<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
	</head>
	
	<body class="yui-skin-sam" onload="fnMessage('${params.msg}');" ${bodyConfig}>
		<div id="wrapDiv">
			<div id="formDiv">
				<form name="form" method="post">
				    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
						<tr>
				        	<td height="1">	
								<%@include file="../sys3/cms/standardParam.jsp" %>
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM01002F" />
							</td>
						</tr>
						<tr>
							<td height="*">
								<span id="grid"></span>
							</td>
						</tr>
						<tr>
							<td height="1">
								<input type="hidden" id="apprTpID" name="apprTpID" value="${params.apprTpID }" />
								<input type="hidden" id="apprTpNm" name="apprTpNm" value="${params.apprTpNm }" />
								<input type="hidden" id="papprGrpID" name="papprGrpID" value="${params.papprGrpID }" />
								<input type="hidden" id="papprGrpNm" name="papprGrpNm" value="${params.papprGrpNm }" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			${appletDiv}
		</div>
	</body>
</html>

<style type="text/css">

    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    .aw-row-selector {text-align: center}
    
    .aw-column-0 {width: 35px; text-align:center;}
    .aw-column-1 {width: 120px; text-align:center;}
    .aw-column-2 {width: 120px; text-align:center;}
    .aw-column-3 {width: 200px;}
    .aw-column-4 {width: 120px; text-align:center;}
    .aw-column-5 {width: 150px; text-align:center;}
    .aw-column-6 {width: 80px; text-align:right;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
    
</style>

<script type="text/javascript">

    /****************************************
    * Variable
    ****************************************/
	var servlet = "${contextPath}/service/mdm01";
	
	/****************************************
	* Function
	****************************************/
	$(function() {
	});
	
	$(document).ready(function() {
		
		window.onload = function() {
			Search();
		};
		
		
		${initScript}
	
	});
	
	function New() {
		$("#selectApprGrpID").val("");
		$("#_detail")[0].contentWindow.New();
		appletOpen();
	}
	
	var _i = 0;
	var _col = {
		checkbox : _i++
		, papprGrpID : _i++
		, apprGrpID : _i++
		, apprGrpNm : _i++
		, empID : _i++
		, empNm : _i++
		, sortSeq : _i++
		, delCount : _i++
	};
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MDM0100203S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("apprTpID", $("#apprTpID").val());
	  	table.setParameter("papprGrpID", $("#papprGrpID").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (i=0; i < rowCount; i++) {
      			data[i] = [
      			    ""
      				, table.getData(_col.papprGrpID,i)
      				, table.getData(_col.apprGrpID,i)
      				, table.getData(_col.apprGrpNm,i)
      				, table.getData(_col.empID,i)
      				, table.getData(_col.empNm,i)
      				, table.getData(_col.sortSeq,i)
      				, table.getData(_col.delCount,i)
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
	function Delete() {
		var index = grid.getRowIndices();
		if (index == '') {
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
        var apprGrpIDs = new Array();
		var count = 0;
		for(var i=0; i < index.length; i++) {
            if (grid.getCellValue(_col.checkbox, index[i])) {
            	if(grid.getCellText(_col.delCount, index[i]) != "0") {
            		var msg = "'"+grid.getCellText(_col.apprGrpNm, index[i])+"' "+"<fmt:message key="MDM01002E.msg1"/>";
            		if(confirm(msg)) {
            			apprGrpIDs[count] = grid.getCellText(_col.apprGrpID, index[i]);
                    	count++;
            		}
            		else {
            			return;
            		}
            	}
            	else {
            		apprGrpIDs[count] = grid.getCellText(_col.apprGrpID, index[i]);
                	count++;
            	}
            }
		}
		
		if(count==0){
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		var table = new AW.XML.Table;     
		table.setURL("${contextPath}/service/mdm01/deleteApprGrp");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("apprGrpIDs", apprGrpIDs);
		table.setParameter("apprTpID", $("#apprTpID").val());
        table.request();
		
        alert(table.getData(1,0));
    	if(table.getData(0,0)=="S") {
			appletClose();
    		Search();
			parent.document._tree.location.reload();
        }
	}
	
	/*****************************************************
	*	Grid Setting
	*****************************************************/

	var columns = [
		""
		, "<fmt:message key="MDM01002E.papprGrpID"/>"
		, "<fmt:message key="MDM01002E.apprGrpID"/>"
		, "<fmt:message key="MDM01002E.apprGrpNm"/>"
		, "<fmt:message key="MDM01002E.empID"/>"
		, "<fmt:message key="MDM01002E.empNm"/>"
		, "<fmt:message key="MDM01002E.sortSeq"/>"
	];
	
	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str, str, str, num]);
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(true);
		grid.setSelectorWidth(40);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setHeaderHeight(20);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setSelectionMode("single-row");
		grid.setStyle("width","100%");
		grid.setStyle("height","100%");
		grid.setCellEditable(false);
		
	    grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
        grid.setCellValue(false, _col.checkbox);
    
		grid.onRowDoubleClicked = function(event, row){
			$("#_detail")[0].contentWindow.$("#apprGrpID").val(this.getCellText(_col.apprGrpID, row));
			$("#_detail")[0].contentWindow.Search();
			appletOpen();
	    }
	}
</script>