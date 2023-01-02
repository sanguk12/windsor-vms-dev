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
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1"> 		
						<!-- Standard Parameter - START -->
						<input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
						<input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
						<input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
						<input type="hidden" id="method" name="method">
						<!-- Standard Information - END -->
						
						<%@include file="../cms/functionbar.jsp" %>
                    </td>
                </tr>
                <tr>
					<td height="1">             
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:90px"></col>
											<col style="width:200px"></col>
											<col style="width:90px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-input" colspan="4">
													<input type="radio" class="radio" id="oldNewDiv" name="oldNewDiv" value="O" checked /><fmt:message key="COM01001C.oldAddr" />
													<input type="radio" class="radio" id="oldNewDiv" name="oldNewDiv" value="N" /><fmt:message key="COM01001C.newAddr" />
				                                </td>
				                            </tr>
				                            <tr id="oldTR">
												<td class="td-cond-required"><fmt:message key="searchWord" /></td>
												<td class="td-input" colspan="3">
													<input type="text" id="searchWord" name="searchWord" style="width:200px; ime-mode:active;" />
				                                </td>
				                            </tr>
				                            <tr id="newTR">
												<td class="td-cond-required"><fmt:message key="COM01001C.div" /></td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="searchSidoName" name="searchSidoName" style="width:100px;"defaultText="select" query="COM01001C01S" paramkey="x;" paramvalue="x;" />
													<nis:selectbox id="searchSiguName" name="searchSiguName" style="width:100px;"defaultText="select" query="COM01001C02S" paramkey="x;" paramvalue="x;" />
				                                </td>
				                            </tr>
				                            <tr id="newTR1">
												<td class="td-cond-required"><fmt:message key="COM01001C.dongName" /></td>
												<td class="td-input">
													<input type="text" id="searchDongName" name="searchDongName" style="width:150px; ime-mode:active;">
				                                </td>
				                                <td class="td-cond-required"><fmt:message key="COM01001C.jibon" /></td>
												<td class="td-input">
													<input type="text" id="searchJibon" name="searchJibon" style="width:100px;">
				                                </td>
				                            </tr>
				                            <tr id="newTR2">
				                                <td class="td-cond-required"><fmt:message key="COM01001C.doroName" /></td>
												<td class="td-input" colspan="3">
													<input type="text" id="searchDoroName" name="searchDoroName" style="width:150px; ime-mode:active;">
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
                        <span id="grid_new"></span>
                    </td>
                </tr>
                <tr>
                    <td height="5">
						<!-- Action Parameter - START -->
						<input type="hidden" name="initAction">
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

	#grid .aw-column-0 {width: 80px; }
	#grid .aw-column-1 {width: 100px; }
	#grid .aw-column-2 {width: 150px; }
	#grid .aw-column-3 {width: 100px; }
	#grid .aw-column-4 {width: 80px; text-align: center;}
	
	#grid_new .aw-column-0 {width: 250px; }
	#grid_new .aw-column-1 {width: 350px; }
	#grid_new .aw-column-2 {width: 80px; text-align: center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">
	
	// Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {

		window.onload = function() {
			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
			
			$("#oldTR").show();
			$("#newTR").hide();
			$("#newTR1").hide();
			$("#newTR2").hide();
			$("#grid_new").hide();
			
			$("#searchWord").focus();
			
			createGrid();
			grid.refresh();
		};

		${initScript}

		$("#searchWord").keypress(function() {
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		$("#searchDongName").keypress(function() {
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		$("#searchJibon").keypress(function() {
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		$("#searchDoroName").keypress(function() {
			if (event.keyCode==13){
				Search();
				return false;
			}
		});

		$(":input:radio[name=oldNewDiv]").change(function() {
			if(getRadioValue("oldNewDiv")=="O") {
				$("#oldTR").show();
				$("#newTR").hide();
				$("#newTR1").hide();
				$("#newTR2").hide();
				$("#grid").show();
				$("#grid_new").hide();
				createGrid();
				grid.refresh();
			}
			else if(getRadioValue("oldNewDiv")=="N") {
				$("#oldTR").hide();
				$("#newTR").show();
				$("#newTR1").show();
				$("#newTR2").show();
				$("#grid").hide();
				$("#grid_new").show();
				createGrid_new();
	   			grid_new.refresh();
			}
		});
		$("#searchSidoName").change(function() {
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/simpleAction/COM01001C02S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("outParamKey","code;name");
	        table.setParameter("format","str;str;");
		  	table.setParameter("searchSidoName", $("#searchSidoName").val());
	     	table.request();
	     	
	     	if($("#searchSidoName").val()=="세종특별자치시") {
	     		$("#searchSiguName").attr("disabled", true);
	     	}
	     	else {
	     		$("#searchSiguName").attr("disabled", false);
	     	}
			$("select[name='searchSiguName']").find('option').remove();
			$("#searchSiguName").get(0).options[0] = new Option("<fmt:message key="select"/>", "");
	   		for(var i=0; i<table.getCount(); i++){
	   			$("#searchSiguName").get(0).options[i+1] = new Option(table.getData(1,i), table.getData(0,i));
	   		}
	   		
		});
	});
	
	/****************************************
	* Button Action
	****************************************/
	
	function Choice() {
		if(getRadioValue("oldNewDiv")=="O") {
			var data = {
				"oldNewDiv":"O"
				, "addr1":grid.getCellText(0, grid.getCurrentRow())+' '+grid.getCellText(1, grid.getCurrentRow())+' '+grid.getCellText(2, grid.getCurrentRow())+' '+grid.getCellText(3, grid.getCurrentRow())
				, "sido":grid.getCellText(0, grid.getCurrentRow())
				, "gugun":grid.getCellText(1, grid.getCurrentRow())
				, "dong":grid.getCellText(2, grid.getCurrentRow())
				, "bunji":grid.getCellText(3, grid.getCurrentRow())
				, "zipCode":grid.getCellText(4, grid.getCurrentRow())
			};
		}
		else if(getRadioValue("oldNewDiv")=="N") {
			var data = {
				"oldNewDiv":"N"
				, "oldAddr":grid_new.getCellText(0, grid_new.getCurrentRow())
				, "newAddr":grid_new.getCellText(1, grid_new.getCurrentRow())
				, "zipCode":grid_new.getCellText(2, grid_new.getCurrentRow())
				, "sidoName":grid_new.getCellText(3, grid_new.getCurrentRow())
				, "siguName":grid_new.getCellText(4, grid_new.getCurrentRow())
				, "old_dongName":grid_new.getCellText(5, grid_new.getCurrentRow())
				, "old_bunji":grid_new.getCellText(6, grid_new.getCurrentRow())
				, "new_doroName":grid_new.getCellText(7, grid_new.getCurrentRow())
				, "new_bunji":grid_new.getCellText(8, grid_new.getCurrentRow())
			};
			//alert(data.zipCode+'\n'+data.oldAddr+'\n'+newAddr);
		}
		
		<c:if test="${!empty params.finalAction}"> 
			opener.${params.finalAction}(data);
		</c:if>
		window.close();
	}

	function Search() {
		showLoading();
		window.setTimeout(function() {
			Search_list();
		},100);
		window.setTimeout("hideLoading()", 100);
	}
	
	function Search_list() {
		if(getRadioValue("oldNewDiv")=="O") {
			if ($("#searchWord").val() == "") {
				alert("<fmt:message key="searchWord"/> <fmt:message key="info.required"/>");
				$("#searchWord").focus();
				return;
			}
			
			if($("#searchWord").val().length < 2){
				alert("<fmt:message key="COM01001C.msg1"/>");
				$("#searchWord").focus();
				return;
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/simpleAction/COM01001A02S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
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
	      				table.getData(4,i),
	      				formatZipCode(table.getData(0,i))
	      			];
	      		}
	      		grid.setCellData(data);
	      		grid.setRowCount(rowCount);
	      	}
	      	else {
	      		message("<fmt:message key="info.nullData"/>");
	      	}
	      	grid.refresh();
		}
		else if(getRadioValue("oldNewDiv")=="N") {
			if ($("#searchSidoName").val() == "") {
				alert("<fmt:message key="COM01001C.msg2"/>");
				$("#searchSidoName").focus();
				return;
			}
			if($("#searchSidoName").val()!="세종특별자치시") {
				if ($("#searchSiguName").val() == "") {
					alert("<fmt:message key="COM01001C.msg3"/>");
					$("#searchSiguName").focus();
					return;
				}
			}
			if ($("#searchDoroName").val() == "") {
				if ($("#searchDongName").val() == "") {
					alert("<fmt:message key="COM01001C.msg4"/>");
					$("#searchDongName").focus();
					return;
				}
				if($("#searchDongName").val().length < 2){
					alert("<fmt:message key="COM01001C.msg7"/>");
					$("#searchDongName").focus();
					return;
				}
				if ($("#searchJibon").val() == "") {
					alert("<fmt:message key="COM01001C.msg5"/>");
					$("#searchJibon").focus();
					return;
				}
				if($("#searchJibon").val().length < 2){
					alert("<fmt:message key="COM01001C.msg8"/>");
					$("#searchJibon").focus();
					return;
				}
			}
			else {
				alert("<fmt:message key="COM01001C.msg6"/>");
				$("#searchDongName").val("");
				$("#searchJibon").val("");
			}
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/simpleAction/COM01001C03S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
		  	table.setParameter("searchSidoName", $("#searchSidoName").val());
		  	table.setParameter("searchSiguName", $("#searchSiguName").val());
		  	table.setParameter("searchDongName", $("#searchDongName").val());
		  	table.setParameter("searchJibon", $("#searchJibon").val());
		  	table.setParameter("searchDoroName", $("#searchDoroName").val());
	      	table.request();
	      	
	      	grid_new.clear();
	      	createGrid_new();
	      	
	      	var rowCount = table.getCount();
	      	if (rowCount > 0) {
	      		var data = new Array();
	      		for (i=0; i < rowCount; i++) {
	      			data[i] = [
	      				table.getData(0,i)
	      				, table.getData(1,i)
	      				, formatZipCode(table.getData(2,i))
	      				, table.getData(3,i)
	      				, table.getData(4,i)
	      				, table.getData(5,i)
	      				, table.getData(6,i)
	      				, table.getData(7,i)
	      				, table.getData(8,i)
	      			];
	      		}
	      		grid_new.setCellData(data);
	      		grid_new.setRowCount(rowCount);
	      	}
	      	else {
	      		message("<fmt:message key="info.nullData"/>");
	      	}
	      	grid_new.refresh();
		}

	}
	
	function Close() {
		window.close();
	}
	
    /*****************************************************
	*	define data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="COM01001C.sido" />"
		, "<fmt:message key="COM01001C.gugun" />"
		, "<fmt:message key="COM01001C.dong" />"
		, "<fmt:message key="COM01001C.jibon" />"
		, "<fmt:message key="COM01001C.zipCode" />"
   	];
	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-row");
		grid.setStyle("width", "100%");
		grid.setStyle("height", "100%");
		grid.setCellEditable(false);
		
		grid.onRowDoubleClicked = function(event, row) {
			Choice();
		};
		
	}
	
	var columns_new = [
		"<fmt:message key="COM01001C.oldAddr" />"
		, "<fmt:message key="COM01001C.newAddr" />"
		, "<fmt:message key="COM01001C.zipCode" />"
   	];
	var grid_new = null;
	function createGrid_new() {
		grid_new = new AW.UI.Grid;
		grid_new.setId("grid_new");
		grid_new.setCellFormat([str, str, str]);
		for(var i=0;i<columns_new.length;i++){grid_new.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid_new.setHeaderText(columns_new);
		grid_new.setRowCount(0);
		grid_new.setColumnCount(columns_new.length);
		grid_new.setSelectorVisible(false);
		grid_new.setSelectionMode("single-row");
		grid_new.setStyle("width", "100%");
		grid_new.setStyle("height", "100%");
		grid_new.setCellEditable(false);
		
		grid_new.onRowDoubleClicked = function(event, row) {
			Choice();
		};
		
	}
	
</script>