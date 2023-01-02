<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>
</head>

<body onload="fnMessage('${params.msg}');" ${bodyConfig}>
<form name="form" method="post">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
        	<td height="1">	
				<input type="hidden" name="mnuGrpID" value="${params.mnuGrpID}">
				<input type="hidden" name="pgmID" value="${params.pgmID}">
				<input type="hidden" name="viewID" value="${params.viewID}">
				<div id="tmp"></div>
			</td>
		</tr>
		<tr>
			<td height="*">
				<span id="grid"></span>
			</td>
		</tr>
		<tr>
			<td height="1">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
                          <tr>
                              <td class="td-cond" width="100"><fmt:message key="CMP01007B.menuConstructCopy" /></td>
                              <td class="td-input" width="*">
                              	<input type="text" name="mnuConstructName" class="gray"  style="width:200px;">&nbsp;<span id="copyButton"></span>
                               </td>
                           </tr>
                       </table>
                   </td>
               </tr>
		</table>
</form>
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    .aw-column-0 {width: 35px; text-align:center;}
    .aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 160px;}
    .aw-column-3 {width: 100px; text-align:center;}
    .aw-column-4 {width: 200px;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">

    /****************************************
    * Variable
    ****************************************/
	var servlet = "${contextPath}/service/menuConstruct";
	var WIDTH=600;
	var HEIGHT=300;
	
	/****************************************
	* Function
	****************************************/
	$(function() {
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {
		
		window.onload = function() {
			Search();
		};
	
	});
	
	// Insert
	function Insert() {
		var queryString = "/detailMenuConstruct/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01007D";
		newWindow(servlet+queryString, "InsertMenuConstruct", WIDTH, HEIGHT, "no");
	}
	
	// Delete
	function Delete() {
		if(grid.getRowCount() > 0) {
			document.all.tmp.innerHTML="";
			for(var i=0; i < grid.getRowCount(); i++) {
			    if (grid.getCellValue(0,i)) {
				    document.all.tmp.innerHTML+="<input type=\"hidden\" name=\"mnuConstructIDs\" value=\""+grid.getCellText(1, i)+"\"/>";
				}
			}
			fnSubmitConfirm(form, servlet, "deleteListMenuConstruct", "<fmt:message key="confirm.delete" />");
		}
	}
	
	// Detail Open
	function Detail(mnuConstructID) {
		var queryString = "/detailMenuConstruct/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01007D&mnuConstructID="+mnuConstructID;
		newWindow(servlet+queryString, mnuConstructID, WIDTH, HEIGHT, "no");
	}
	
	function Save() {
		alert("<fmt:message key="info.menuConstruct" />");
	}
	
	function Search() {
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0100701S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","mnuConstructID;mnuConstructName;useYN;remark;");
	  	table.request();
      	
	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (i=0; i < rowCount; i++) {
      			data[i] = [
      			    '',
      				table.getData(0,i),
      				table.getData(1,i),
      				table.getData(2,i),
      				table.getData(3,i)
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
    var copyButton = new AW.UI.Button;

    copyButton.setId("copyButton");
    copyButton.setControlText("<fmt:message key="button.Copy"/>");
    copyButton.setControlImage("Copy");
    copyButton.refresh();
    
    copyButton.onClick = function(){
        if (document.form.mnuConstructName.value == '') {
            alert('<fmt:message key="CMP01007B.msg1"/>');
            document.form.mnuConstructName.focus();
            return false;
        }
        
        var copyMenuConstructID = new Array();
        if(grid.getRowCount() > 0) {
            for(var i=0; i < grid.getRowCount(); i++) {
                if (grid.getCellValue(0,i)) {
                    copyMenuConstructID[copyMenuConstructID.length] = grid.getCellText(1, i);
                }
            }
            
            if (copyMenuConstructID.length > 1) {
                alert('<fmt:message key="CMP01007B.msg2"/>');
            }
            else if (copyMenuConstructID.length == 1) {
                alert('<fmt:message key="CMP01007B.msg3"/>');
                
                var table = new AW.XML.Table;
		        table.setURL("${contextPath}/service/menuConstruct/copyMenuConstruct");
		        table.setAsync(false);
		        table.setRequestMethod("POST");
		        table.setParameter("mnuConstructID",copyMenuConstructID[0]);
                table.setParameter("mnuConstructName",document.form.mnuConstructName.value);
		        table.request();
		        
		        alert(table.getData(1,0));
		        if (table.getData(0,0) == 'S') {
		            Search();
		            document.form.mnuConstructName.value = '';
		        }
            }
            else {
                alert('<fmt:message key="CMP01007B.msg4"/>');
            }
        }
    }

	
	/*****************************************************
	*	Grid Setting
	*****************************************************/

	var columns = [
		"",
		"<fmt:message key="CMP01007B.mnuConstructID"/>",
		"<fmt:message key="CMP01007B.mnuConstructName"/>",
		"<fmt:message key="CMP01007B.useYN"/>",
		"<fmt:message key="CMP01007B.remark"/>"
	];
	
	var grid = null;
	
	function createGrid() {
	
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setSelectorWidth(40);
		grid.setSelectorVisible(true);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);
		grid.setHeaderText(columns);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setColumnCount(columns.length);
		grid.setCellFormat([str, str, str, str, str]);
		
	    grid.setCellTemplate(new AW.Templates.CheckBox, 0);
        grid.setCellValue(false, 0);
    
		grid.onRowDoubleClicked = function(event, rowIndex){
			Detail(this.getCellText(1, rowIndex));
	    }
	}
</script>