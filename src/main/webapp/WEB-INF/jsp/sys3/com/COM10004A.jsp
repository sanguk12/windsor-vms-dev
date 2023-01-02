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
			
						<!-- Function Bar - Title & Button -->
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
											<td class="td-cond" width="80"><fmt:message key="searchWord" /></td>
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

<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 90px; text-align:center;}
	.aw-column-1 {width: 150px; }
	.aw-column-2 {width: 170px; }

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
		  "empCD":grid.getCellText(0, grid.getCurrentRow()),
		  "empName":grid.getCellText(1, grid.getCurrentRow()),
		  "empID":grid.getCellText(3, grid.getCurrentRow())
		};
		
		<c:if test="${!empty params.finalAction}"> 
			opener.${params.finalAction}(data);
		</c:if>
		
		window.close();
	}

	function Search() {
		
		var table = new AW.XML.Table;	  
	  	table.setURL("simpleAction.do");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("queryKey","common.employeePopup.select");
	  	table.setParameter("outParamKey","empCD;empName;partnerName;empID;");
	  	//사원코드;사원명;파트너명;사원ID;
	  	table.setParameter("searchWord", $("#searchWord").val());
	  	if ("${params.companyID_con}" != "") {
	  		table.setParameter("companyID_con", "${params.companyID_con}");
	  	}
	  	if ("${params.partnerID_con}" != "") {
	  		table.setParameter("partnerID", "${params.partnerID_con}");
	  	}
      	table.request();

      	grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (i=0; i < rowCount; i++) {
      			data[i] = [
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
	
	function Close() {
		window.close();
	}
	
    /*****************************************************
	*	define data formats define
	*****************************************************/
  
	var columns = [
		"<fmt:message key="empCD"/>",
		"<fmt:message key="empName"/>",
		"<fmt:message key="partnerName"/>"
	];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setHeaderText(columns);
		grid.setSize(200, 260);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setStyle("width","100%"); 
		grid.setStyle("height","100%");
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
	}
	
	createGrid();
	grid.refresh();
	
</script>
