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
		<div id="wrapDiv">
    		<div id="formDiv">
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
							        			<col style="width:200px;"></col>
							        			<col style="width:100px;"></col>
							        			<col></col>
							        		</colgroup>
							        		<tbody>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="CMP01010A.grpIDFrom" />
												</td>
												<td class="td-input">
													<nis:selectbox id="grpIDFrom" style="width:150px" defaultText="select" queryKey="CMP0100901S" paramKey="" paramValue="" valuePosition="0;1;" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="CMP01010A.grpIDTo" />
												</td>
												<td class="td-input">
													<nis:selectbox id="grpIDTo" style="width:150px" defaultText="select" queryKey="CMP0100901S" paramKey="" paramValue="" valuePosition="0;1;" />
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
				</table>
			</div>
		</div>
	</form>
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    .aw-column-0 {width: 30px; text-align:center;}
    .aw-column-1 {width: 160px; text-align:center;}
    .aw-column-2 {width: 200px;}
    
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
			createGrid();
			grid.refresh();
			
			$("#grpIDFrom").focus();
		};
	
		${initScript}
		
		$("#grpIDFrom").change(function() {
			grid.clear();
			createGrid();
			grid.refresh();
		});
		
		$("#grpIDTo").change(function() {
			grid.clear();
			createGrid();
			grid.refresh();
		});
	});

    function Apply() {

    	if ($("#grpIDFrom").val() == "") {
			alert("<fmt:message key="CMP01010A.msg1" />");
			$("#grpIDFrom").focus();
			return;
		}
    	else if ($("#grpIDTo").val() == "") {
			alert("<fmt:message key="CMP01010A.msg2" />");
			$("#grpIDTo").focus();
			return;
		}
    	else if ($("#grpIDFrom").val() == $("#grpIDTo").val()) {
			alert("<fmt:message key="CMP01010A.msg3" />");
			$("#grpIDTo").focus();
			return;
		}        	

		var userID = new Array();
		var j=0;
        for (var i=0; i < grid.getRowCount(); i++) {
            if (grid.getCellValue(0,i)) {
	            userID[j] = grid.getCellText(1,i);
	            j++;
            }
        }

        if (j == 0) {
			alert("<fmt:message key="CMP01010A.msg4" />");
			return;
        }
		
		var table = new AW.XML.Table;  
	  	table.setURL("${contextPath}/service/auth/applyGroupUser");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
		table.setParameter("userIDs", userID);
		table.setParameter("grpID", $("#grpIDTo").val());
		table.setParameter("pgrpID", $("#grpIDFrom").val());
		table.request();

		if (table.getData(0,0) == 'S'){
			message(table.getData(1,0));
			Search();
		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Search() {

		if ($("#grpIDFrom").val() == "") {
			alert("<fmt:message key="CMP01010A.msg1" />");
			$("#grpIDFrom").focus();
			return;
		}
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0101001S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
        table.setParameter("outParamKey","grpID;userID;userName;");
	  	table.setParameter("grpID", $("#grpIDFrom").val());
      	table.request();

      	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
      			    "",
      				table.getData(1,i),
      				table.getData(2,i)
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
  		grid.refresh();
	}
	
	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var grid = null;

	var columns = [
		"",
		"<fmt:message key="CMP01010A.userID" />",
		"<fmt:message key="CMP01010A.userName" />"
	];
	
	function createGrid() {
	
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setCellFormat([str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);
		grid.setHeaderText(columns);
		grid.setColumnCount(columns.length);
		grid.setCellTemplate(new AW.Templates.CheckBox, 0);
		grid.setCellValue(false,0);
	}
</script>