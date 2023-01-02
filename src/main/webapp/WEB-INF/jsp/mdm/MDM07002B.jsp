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

	.aw-column-0 {width: 100px; text-align:left;}
    .aw-column-1 {width: 80px; text-align:center;}
    .aw-column-2 {width: 80px; text-align:center;}
	.aw-column-3 {width: 80px; text-align:center;}
    .aw-column-4 {width: 130px; text-align:center;}
    .aw-column-5 {width: 150px; text-align:left;}

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
	$(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
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
		apprGrpNm : _i++
		, empID : _i++
		, empNm : _i++
		, apprStateCDName : _i++
		, apprDate : _i++
		, commt : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MDM0500203S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"apprGrpNm;empID;empNm;apprStateCDName;apprDate;"+
	  			"commt;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;");
	  	table.setParameter("venueCD", "${params.venueCD}");
	  	table.setParameter("apprTpID", "${params.apprTpID}");
	  	table.setParameter("gbn", "${params.gbn}");
	  	table.request();
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					table.getData(_col.apprGrpNm,i)
					, table.getData(_col.empID,i)
					, table.getData(_col.empNm,i)
      			    , table.getData(_col.apprStateCDName,i)
					, table.getData(_col.apprDate,i)
					, table.getData(_col.commt,i)
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
		"<fmt:message key="RLT01001B.apprGrpNm"/>"
		, "<fmt:message key="RLT01001B.empID"/>"
		, "<fmt:message key="RLT01001B.empNm"/>"
		, "<fmt:message key="RLT01001B.apprStateCD"/>"
		, "<fmt:message key="RLT01001B.apprDate"/>"
		, "<fmt:message key="RLT01001B.commt"/>"
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
	                        , str
	                        ]);
	    grid.setCellEditable(false);
		
    }
	
</script>