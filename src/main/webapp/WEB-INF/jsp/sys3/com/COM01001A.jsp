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
					<td class="pd" height="1">             
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <tr>
											<td class="td-cond-required" width="80"><fmt:message key="searchWord" /></td>
											<td class="td-input" width="*">
												<input type="text" id="searchWord" style="width:200px;">
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

	.aw-column-0 {width: 80px; }
	.aw-column-1 {width: 100px; }
	.aw-column-2 {width: 250px; }
	.aw-column-3 {width: 80px; text-align: center;}

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
			
			$("#searchWord").focus();
		};

		${initScript}

		$("#searchWord").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
	});
	
	/****************************************
	* Button Action
	****************************************/
	
	function Choice() {
		var data = {
			"zipCode":grid.getCellText(3, grid.getCurrentRow()),
			"addr1":grid.getCellText(0, grid.getCurrentRow())+' '+grid.getCellText(1, grid.getCurrentRow())+' '+grid.getCellText(2, grid.getCurrentRow())
		};
		
		<c:if test="${!empty params.finalAction}"> 
			opener.${params.finalAction}(data);
		</c:if>
		window.close();
	}

	function Search() {
		
		if ($("#searchWord").val() == "") {
			alert("<fmt:message key="searchWord"/> <fmt:message key="info.required"/>");
			return;
		}
		
		if($("#searchWord").val().length < 2){
			alert("검색어를 두자 이상 입력하시기 바랍니다.")
			return;
		}
		
		var table = new AW.XML.Table;	  
	  	table.setURL("simpleAction.do");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("actionKey","search");
	  	table.setParameter("resultType","XML");
	  	table.setParameter("queryKey","commonservice.common.addressPopup.select");
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
      				formatZipCode(table.getData(0,i))
      				];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
	function Close() {
		window.close();
	}
	
    /*****************************************************
	*	define data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="sido"/>",
		"<fmt:message key="gugun"/>",
		"<fmt:message key="dong"/>",
		"<fmt:message key="zipCode"/>"
	];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setHeaderText(columns);
		grid.setSize(200, 260);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setStyle("width", "100%");
		grid.setStyle("height", "100%");
		grid.setCellEditable(false);
		
		grid.onRowDoubleClicked = function(event, row) {
			Choice();
		};
		
		// event : enter key
		var keyEvent = grid.getEvent("onkeypress");
	    grid.setEvent("onkeypress", function(e, rowIndex) {    	
			if(event.keyCode==13){
				Choice();
			} else {
				keyEvent.call(this, event);
				event.returnValue = false;
			}
	    });
		/*
	    grid.setEvent("onkeypress", function(e, rowIndex) {    	
			if(event.keyCode==13){
				Choice();
			}
	    });
	    */
	}
	
	createGrid();
	grid.refresh();
	
</script>
