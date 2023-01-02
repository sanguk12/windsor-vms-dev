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
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                    		<tr>
                    			<td>
									<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:100px;"></col>
											<col style="width:150px;"></col>
											<col style="width:100px;"></col>
										<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="AD01001D.venueCD" />
												</td>
												<td class="td-input">
													&nbsp;<span id="venueCD"></span>
												</td>
				                            	<td class="td-cond">
													<fmt:message key="AD01001D.venueNm" />
												</td>
												<td class="td-input">
													&nbsp;<span id="venueNm"></span>
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
					<td height="*" valign="top">
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

	.aw-column-0 {width: 120px; text-align:center;}
    .aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:center;}
	.aw-column-3 {width: 100px; text-align:center;}
	.aw-column-4 {width: 100px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">
	
	//Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	 * Variable
	 ****************************************/
	 
	/****************************************
	 * Function
	 ****************************************/
	$(document).ready(function() {

		window.onload = function() {
			$("#venueCD").text("${params.venueCD}");
			$("#venueNm").text("${params.venueNm}");
			createGrid();
			grid.refresh();
			
			Search();
		};

		${initScript}

	});
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		contractDT : _i++
		, perfDivCDNm : _i++
		, payStateCDNm : _i++
		, contractStateCDNm : _i++
		, targetRate : _i++
    };
	
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/AD0100116S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"contractDT;perfDivCDNm;payStateCDNm;contractStateCDNm;targetRate;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;");
	  	table.setParameter("venueCD", $("#venueCD").text());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					table.getData(_col.contractDT,i)
					, table.getData(_col.perfDivCDNm,i)
					, table.getData(_col.payStateCDNm,i)
      			    , table.getData(_col.contractStateCDNm,i)
      			    , table.getData(_col.targetRate,i)+"%"
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
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="AD01001D.contractDT"/>"
		, "<fmt:message key="AD01001D.perfDivCD"/>"
		, "<fmt:message key="AD01001D.payStateCD"/>"
		, "<fmt:message key="AD01001D.contractStateCD"/>"
		, "<fmt:message key="AD01001D.targetRate"/>"
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
	                        str, str, str, str, str
	                        ]);
	    grid.setCellEditable(false);
		
    }
	
</script>