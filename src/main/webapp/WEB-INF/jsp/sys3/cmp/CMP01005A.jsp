<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../scripts.jsp" %>

	</head>

    <body onload="init();" class="yui-skin-sam" ${bodyConfig}>
        <form name="form" method="post" action="company.do">
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
                    </td>
                </tr>
                <tr>
                    <td class="pd" height="1">
                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
						        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
										<tr>
											<td class="td-cond" width="80"><fmt:message key="searchWord" /></td>
											<td class="td-input" width="*">
												<input type="text" id="searchWord" name="searchWord" style="width:200px;" onkeypress="if (event.keyCode==13){Search(); return false;}">
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
                    <td height="5"> 	
						<!-- Action Parameter - START -->
						<input type="hidden" id="companyID" name="companyID">
						<input type="hidden" id="initAction" name="initAction">
						
						<!-- Excel -->
						<input type="hidden" id="actionKey" name="actionKey">
			            <input type="hidden" id="resultType" name="resultType">
			            <input type="hidden" id="queryKey" name="queryKey">
			            <input type="hidden" id="fileName" name="fileName">
			            
			            <!-- PDF -->
			            <input type="hidden" id="report" name="report">
			            <input type="hidden" id="format" name="format">
						
						<!-- Action Parameter - END -->
                    </td>
                </tr>
            </table>
		</form>
	</body>
</html>

<!-- grid format -->
<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 80px; text-align: center;}
	.aw-column-1 {width: 120px; }
	.aw-column-2 {width: 80px; text-align: center;}
	.aw-column-3 {width: 120px; text-align: center;}
	.aw-column-4 {width: 110px; }
	.aw-column-5 {width: 110px; }
	.aw-column-6 {width: 80px; text-align: center;}
	.aw-column-7 {width: 300px; }

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">
	/****************************************
	* Function
	****************************************/
	function init(){
		if ("${resultMsg.code}" != "") {
			message("${resultMsg.message}");
		} 
	}

	/****************************************
	* Button Action
	****************************************/

	function Excel() {
        document.form.action = "simpleAction.do";
        document.form.target = "_self";
        document.getElementById("actionKey").value = "search";
        document.getElementById("resultType").value = "EXCEL";
        document.getElementById("queryKey").value = "commonservice.auth.companyList.select";
        document.getElementById("fileName").value = "CompanyList";
        document.form.submit();
	}
	
	function New() {
		document.form.action = "simpleCommand.do";
		document.form.target = "_self";
		document.getElementById("viewID").value = "CMP01005B";
		document.getElementById("initAction").value = "";
		document.form.submit();
	}
	
	function Pdf() {
        
	    var winprops = getWindowOpenParam(1000,700,"yes");
	    var win = window.open("", "reportviewer", winprops);
	            
        document.form.action = "simpleReport.do";
        document.form.target = "reportviewer";
        document.getElementById("report").value = "companyListReport";
        document.getElementById("format").value = "pdf";
        document.form.submit();
	}
		
	function Search() {
	
		var table = new AW.XML.Table;	  
	  	table.setURL("simpleAction.do");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("actionKey","search");
	  	table.setParameter("resultType","XML");
	  	table.setParameter("queryKey","commonservice.auth.companyList.select");
	  	table.setParameter("searchWord", $("#searchWord").val());
      	table.request();
      	
      	grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	
      	if (rowCount > 0) {
      		var data = new Array();
      		for (i=0; i < rowCount; i++) {
      			data[i] = [
						table.getData(1,i),
						table.getData(2,i),
						table.getData(3,i),
						formatBizRegNo(table.getData(4,i)),
      			   		table.getData(5,i),
      			   		table.getData(6,i),
      			   		formatZipCode(table.getData(7,i)),
      			   		table.getData(8,i),
      			   		table.getData(0,i) //companyID
      			   	];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	}
      	grid.refresh();
	}

	
	/*****************************************************
	*	define data formats define
	*****************************************************/
	var grid = null;
  
	var columns = [
		"<fmt:message key="companyCD"/>", "<fmt:message key="companyName"/>", "<fmt:message key="reprName"/>", 
		"<fmt:message key="bizRegNo"/>", "<fmt:message key="telNo"/>1", "<fmt:message key="telNo"/>2", 
		"<fmt:message key="zipCode"/>", "<fmt:message key="addr"/>"
	];
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str, str, str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorWidth(40);
		grid.setSelectorVisible(true);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setHeaderHeight(20);
		grid.setSelectionMode("single-row");
		grid.setStyle("width","100%"); 
		grid.setStyle("height","100%");
		grid.setCellEditable(false);
		
		grid.onRowDoubleClicked = function(event, row) {
			document.form.action = "simpleCommand.do";
			document.form.target = "_self";
			document.getElementById("viewID").value = "CMP01005B";
			document.getElementById("initAction").value = "Search";
			document.getElementById("companyID").value = grid.getCellText(8,row);
			document.form.submit();
		};
	}
	
	createGrid();
	grid.refresh();
</script>

<script type="text/javascript">
<!--
	<c:if test="${!empty params.initAction}">
		${params.initAction}();
	</c:if>
//-->
</script>	
