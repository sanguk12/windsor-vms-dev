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

	.aw-column-0 {width: 90px; text-align:left;}
    .aw-column-1 {width: 110px; text-align:left;}
    .aw-column-2 {width: 80px; text-align:right;}
	.aw-column-3 {width: 60px; text-align:center;}
    .aw-column-4 {width: 100px; text-align:right;}
    .aw-column-5 {width: 70px; text-align:right;}
    .aw-column-6 {width: 90px; text-align:right;}
    .aw-column-7 {width: 90px; text-align:right;}
    .aw-column-8 {width: 90px; text-align:right;}
    .aw-column-9 {width: 90px; text-align:right;}
    .aw-column-10 {width: 90px; text-align:right;}

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
		kindTpCD5Name : _i++
		, prdNm : _i++
		, factoryPrice : _i++
		, qtyUnitCDName : _i++
		, threeMonthAvgQty : _i++
		, planQty : _i++
		, planUnitAmt : _i++
		, payAmt : _i++
		, nsv : _i++
		, gp : _i++
		, gpRate : _i++
		, prdCD : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0100802S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;threeMonthAvgQty;"+
	  			"planQty;planUnitAmt;payAmt;nsv;gp;"+
	  			"gpRate;prdCD;");
	  	table.setParameter("format",
	  			"str;str;num;str;num;"+
	  			"num;num;num;num1;num1;"+
	  			"num1;str;");
	  	table.setParameter("eventYM", opener.$("#yearCD_S").val()+opener.$("#monthCD_S").val());
	  	table.setParameter("venueCD", opener.$("#selectVenueCD").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					table.getData(_col.kindTpCD5Name,i)
					, table.getData(_col.prdNm,i)
					, table.getData(_col.factoryPrice,i)
      			    , table.getData(_col.qtyUnitCDName,i)
					, table.getData(_col.threeMonthAvgQty,i)
					, table.getData(_col.planQty,i)
					, table.getData(_col.planUnitAmt,i)
					, table.getData(_col.payAmt,i)
					, table.getData(_col.nsv, i)
					, table.getData(_col.gp, i)
					, table.getData(_col.gpRate, i)
					, table.getData(_col.prdCD,i)
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
		"<fmt:message key="PLN01008B.kindTpCD5"/>"
		, "<fmt:message key="PLN01008B.prdNm"/>"
		, "<fmt:message key="PLN01008B.factoryPrice"/>"
		, "<fmt:message key="PLN01008B.qtyUnitCDName"/>"
		, "<fmt:message key="PLN01008B.threeMonthAvgQty"/>"
		, "<fmt:message key="PLN01008B.planQty"/>"
		, "<fmt:message key="PLN01008B.planUnitAmt"/>"
		, "<fmt:message key="PLN01008B.payAmt"/>"
		, "<fmt:message key="PLN01008B.NSV"/>"
		, "<fmt:message key="PLN01008B.GP"/>"
		, "<fmt:message key="PLN01008B.GPRate"/>"
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
	                        str, str, num, str, num
	                        , num, num, num, num1, num1
	                        , num1
	                        ]);
	    grid.setCellEditable(false);
		
    }
	
</script>