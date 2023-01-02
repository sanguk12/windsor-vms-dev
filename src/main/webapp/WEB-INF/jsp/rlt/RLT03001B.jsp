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
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:100px;"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="RLT03001B.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="select" category="YEARCD" event="onchange" eventproc="getResultWriteDate();" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="select" category="MONTHCD" event="onchange" eventproc="getResultWriteDate();" />
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
						<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
							<tr>
								<td width="55%" height="*">
									<span id="grid"></span>
								</td>
								<td valign="top">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:100px;"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="RLT03001B.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD" name="yearCD" defaultText="select" category="YEARCD" event="onchange" eventproc="getResultWriteDate();" />
													<nis:selectbox id="monthCD" name="monthCD" defaultText="select" category="MONTHCD" event="onchange" eventproc="getResultWriteDate();" />
				                                </td>
			                                </tr>
			                                <tr>
				                            	<td class="td-cond">
													<fmt:message key="RLT03001B.diffNo" />
												</td>
												<td class="td-input">
													<input type="text" id="diffNo" name="diffNo" style="width:100px; ime-mode:disabled; text-align:right;" maxlength="1" disabled class="input-readonly"/>
												</td>
											</tr>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="RLT03001B.applyDate" />
												</td>
												<td class="td-input">
													<nis:calendar id="applyDateFrom" cssClass="input-readonly" readOnly="yes" value="" eventproc="" /> -
													<nis:calendar id="applyDateTo" cssClass="input-readonly" readOnly="yes" value="" eventproc="" />
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
					<td height="1">
						<input type="hidden" id="selectEventYM" name="selectEventYM" />
						<input type="hidden" id="selectDiffNo" name="selectDiffNo" />
						<input type="hidden" id="activeFlg" name="activeFlg" />
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
    .aw-column-1 {width: 90px; text-align:center;}
    .aw-column-2 {width: 150px; text-align:center;}
	.aw-column-3 {width: 150px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
		$("#diffNo").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			grid.refresh();
			
			if(parent.$("#yearCD_S").val()=="") {
				$("#yearCD_S").val("${params.clientDate}".substring(0,4));
				$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			}
			else {
				$("#yearCD_S").val(parent.$("#yearCD_S").val());
				$("#monthCD_S").val(parent.$("#monthCD_S").val());
			}
			
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
		eventYM : _i++
		, diffNo : _i++
		, applyDateFrom : _i++
		, applyDateTo : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0300101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"eventYM;diffNo;applyDateFrom;applyDateTo");
	  	table.setParameter("format",
	  			"str;str;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					formatMonth(table.getData(_col.eventYM,i))
					, table.getData(_col.diffNo,i)
					, formatDate(table.getData(_col.applyDateFrom,i))
      			    , formatDate(table.getData(_col.applyDateTo,i))
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
      	
      	New();
	}
	
	var _i_dtl = 0;
	var _col_dtl = {
		eventYM : _i_dtl++
		, diffNo : _i_dtl++
		, applyDateFrom : _i_dtl++
		, applyDateTo : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0300103S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
				"eventYM;diffNo;applyDateFrom;applyDateTo");
		table.setParameter("format",
				"str;str;str;str;");
	  	table.setParameter("eventYM", $("#selectEventYM").val());
	  	table.setParameter("diffNo", $("#selectDiffNo").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#yearCD").val(table.getData(_col_dtl.eventYM, 0).substring(0,4));
      		$("#monthCD").val(table.getData(_col_dtl.eventYM, 0).substring(4,6));
      		$("#diffNo").val(table.getData(_col_dtl.diffNo, 0));
      		$("#applyDateFrom").val(formatDate(table.getData(_col_dtl.applyDateFrom, 0)));
      		$("#applyDateTo").val(formatDate(table.getData(_col_dtl.applyDateTo, 0)));
      		
      		$("#yearCD").attr("disabled", true);
    		$("#yearCD").addClass("input-readonly");
    		$("#monthCD").attr("disabled", true);
    		$("#monthCD").addClass("input-readonly");
      	}
	}
	
	function New() {
		$("#activeFlg").val("I");
		$("#selectEventYM").val("");
		$("#selectDiffNo").val("");
		$("#yearCD").val($("#yearCD_S").val());
		$("#monthCD").val($("#monthCD_S").val());
		$("#yearCD").attr("disabled", false);
		$("#yearCD").removeClass("input-readonly");
		$("#monthCD").attr("disabled", false);
		$("#monthCD").removeClass("input-readonly");
		$("#diffNo").val("");
		$("#applyDateFrom").val("");
		$("#applyDateTo").val("");
	}
	
	function Save() {
		if($("#applyDateFrom").val() == "") {
			alert("<fmt:message key="RLT03001B.msg1"/>");
			$("#applyDateFrom").focus();
			return;
		}
		if($("#applyDateTo").val() == "") {
			alert("<fmt:message key="RLT03001B.msg2"/>");
			$("#applyDateTo").focus();
			return;
		}
		if(Number(unformat($("#applyDateFrom").val())) > Number(unformat($("#applyDateTo").val()))) {
			alert("<fmt:message key="RLT03001B.msg3"/>");
			$("#applyDateTo").val($("#applyDateFrom").val());
			$("#applyDateTo").focus();
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt03/saveResultDiffNo_G2");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD").val()+$("#monthCD").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("applyDateFrom", $("#applyDateFrom").val());
		table.setParameter("applyDateTo", $("#applyDateTo").val());
		table.setParameter("activeFlg", $("#activeFlg").val());
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
			Search_dtl();
			parent.getDiffNo();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Delete() {
		if($("#selectDiffNo").val() == "") {
			alert("<fmt:message key="RLT03001B.msg4"/>");
			return;
		}
		if(!confirm("<fmt:message key="info.validate.gridSelectDelete"/>")){
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt03/deleteResultDiffNo_G2");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#selectEventYM").val());
		table.setParameter("diffNo", $("#selectDiffNo").val());
		table.request();

		alert(table.getData(1,0));
		if(table.getData(0,0) == "S") {
			Search();
			New();
			parent.getDiffNo();
   		}
	}
	
	function List() {
		parent.appletClose();
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="RLT03001B.eventYM"/>"
		, "<fmt:message key="RLT03001B.diffNo"/>"
		, "<fmt:message key="RLT03001B.applyDateFrom"/>"
		, "<fmt:message key="RLT03001B.applyDateTo"/>"
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
	                        str, str, str, str
	                        ]);
	    grid.setCellEditable(false);
		
	    grid.onRowDoubleClicked = function(event, row){
	    	$("#activeFlg").val("U");
	    	$("#selectEventYM").val(unformat(this.getCellText(_col.eventYM,row)));
	    	$("#selectDiffNo").val(this.getCellText(_col.diffNo,row));
	    	Search_dtl();
		};
    }
	
</script>