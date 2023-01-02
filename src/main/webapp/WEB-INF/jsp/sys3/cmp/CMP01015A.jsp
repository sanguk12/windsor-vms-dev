<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam">
   	<form name="form" method="post">
   		<div id="wrapDiv" class="pd">
    		<div id="formDiv">
           		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
               		<tr>
                   		<td height="1">
		            		<%@include file="../cms/standardParam.jsp" %>
		            		<input type="hidden" id="userID" name="userID" value="${params.userID}">
		            		
		            		<%@include file="../cms/functionbar.jsp" %>
		        		</td>
		    		</tr>
		    		<tr>
                   		<td height="*">
							<span id="grid"></span>
						</td>
               		</tr>
	           </table>
    	   </div>
       </div>
   </form>
</body>
</html>

<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 100px; text-align: center;}
	.aw-column-1 {width: 150px; }
	.aw-column-2 {width: 60px; text-align: center;}
	.aw-column-3 {width: 60px; text-align: right;}
	.aw-column-4 {width: 60px; text-align: right;}
	.aw-column-5 {width: 80px; text-align: right;}
	.aw-column-6 {width: 80px; text-align: right;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">

    /****************************************
    * Variable
    ****************************************/

	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {

		window.onload = function() {
			Search();
		};

		${initScript}
	});
    
	/****************************************
	* Button Action
	****************************************/
	function Close(){
	   window.close();
	}
	
	function Apply(){
	
	    var widgetID = new Array();
	    var activeFlg = new Array();
	    var width = new Array();
	    var height = new Array();
	    var x = new Array();
	    var y = new Array();
	    
	    for (var i=0; i<grid.getRowCount(); i++) {
	       widgetID[i] = grid.getCellText(_col.widgetID,i);
	       activeFlg[i] = grid.getCellValue(_col.activeFlg,i)?'U':'D';
	       width[i] = grid.getCellText(_col.width,i);
	       height[i] = grid.getCellText(_col.height,i);
	       x[i] = grid.getCellText(_col.x,i);
	       y[i] = grid.getCellText(_col.y,i);
	    }
	
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/widget/saveUserWidgetOwn");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("widgetID", widgetID);
	  	table.setParameter("activeFlg", activeFlg);
	  	table.setParameter("width", width);
	  	table.setParameter("height", height);
	  	table.setParameter("x", x);
	  	table.setParameter("y", y);
      	table.request();
      	
      	if (table.getData(0,0) == "S") {
      		opener._workspace.location.href="${contextPath}/service/widget/viewUserWidget";
      	}
      	else {
      	    alert(table.getData(1,0));
      	}
	}
	
	function Search(){
	
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/CMP0101401S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","widgetID;widgetName;width;height;x;y;activeFlg;");
	  	table.setParameter("userID", $("#userID").val());
      	table.request();
      	
      	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		var index = 0;
      		for (var i=0; i < rowCount; i++) {
      			if (partnerDivCD_S == "AC" && table.getData(0,i) == "000000007") continue;
      			data[index++] = [
      						table.getData(0,i),
      						table.getData(1,i),
      						"",
      						table.getData(2,i),
      						table.getData(3,i),
      						table.getData(4,i),
      						table.getData(5,i)
      					  ];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(index);
      		
      		for (var i=0; i<rowCount; i++){
      		    if (table.getData(6,i) == 'U') {
      		        grid.setCellValue(true, _col.activeFlg, i);
      		    }
      		}
      		
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	}
      	grid.refresh();
	}

	/*****************************************************
	*	Grid Setting
	*****************************************************/
    var _col = {
        "widgetID":0,
        "widgetName":1,
        "activeFlg":2,
        "width":3,
        "height":4,
        "x":5,
        "y":6
    };
    
	var columns = [
		"<fmt:message key="CMP01015A.widgetID"/>",
		"<fmt:message key="CMP01015A.widgetName"/>", 
		"<fmt:message key="CMP01015A.useYN"/>",
		"<fmt:message key="CMP01015A.width"/>",
		"<fmt:message key="CMP01015A.height"/>",
		"<fmt:message key="CMP01015A.x"/>",
		"<fmt:message key="CMP01015A.y"/>"
	];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setCellEditable(false);
		grid.setCellEditable(true,_col.width);
		grid.setCellEditable(true,_col.height);
		grid.setCellEditable(true,_col.x);
		grid.setCellEditable(true,_col.y);
		grid.setCellTemplate(new AW.Templates.CheckBox, _col.activeFlg);
		
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
        // Cell startEdit END
	}
</script>