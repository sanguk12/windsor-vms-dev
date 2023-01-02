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
			<div id="wrapDiv">
          		<div id="formDiv">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            	<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/functionbar.jsp" %>
								<%@include file="../sys3/cms/calendar.jsp" %>
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=SUP01004B" />
							</td>
						</tr>
						<tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:120px;"></col>
								        			<col style="width:300px;"></col>
								        			<col style="width:120px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond-required">
															<fmt:message key="SUP01002A.contractDate" />
														</td>
														<td class="td-input">
															<nis:calendar id="contractDateFrom_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" /> - 
															<nis:calendar id="contractDateTo_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" />
														</td>
														<td class="td-cond">
															<fmt:message key="SUP01002A.payRequestDate" />
														</td>
														<td class="td-input">
															<nis:calendar id="payRequestDate_S" />
														</td>
					                                </tr>
					                                <tr>
					                                	<td class="td-cond">
															<fmt:message key="SUP01002A.contractOverYN" />
														</td>
														<td class="td-input">
															<select id="contractOverYN">
																<option value=""><fmt:message key="all" /></option>
																<option value="Y">Y</option>
															</select>
														</td>
						                                <td class="td-cond">
															<fmt:message key="SUP01002A.addSupportStateCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="supportStateCD_S" name="supportStateCD_S" defaultText="all" category="SUPPORTSTATECD" />
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
								<input type="hidden" id="selectSupportID" name="selectSupportID" />
							</td>
						</tr>
					</table>
				</div>
				${appletDiv}
			</div>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 35px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:center;}
    .aw-column-3 {width: 150px; text-align:left;}
    .aw-column-4 {width: 70px; text-align:center;}
    .aw-column-5 {width: 100px; text-align:left;}
    .aw-column-6 {width: 100px; text-align:left;}
    .aw-column-7 {width: 70px; text-align:center;}
    .aw-column-8 {width: 100px; text-align:center;}
    .aw-column-9 {width: 100px; text-align:center;}
    .aw-column-10 {width: 100px; text-align:center;}
    .aw-column-11 {width: 80px; text-align:right;}
    .aw-column-12 {width: 100px; text-align:right;}
    .aw-column-13 {width: 100px; text-align:right;}
    .aw-column-14 {width: 100px; text-align:right;}
    .aw-column-15 {width: 100px; text-align:right;}
    .aw-column-16 {width: 100px; text-align:right;}
    .aw-column-17 {width: 100px; text-align:right;}
    .aw-column-18 {width: 100px; text-align:right;}
    .aw-column-19 {width: 100px; text-align:right;}
    .aw-column-10 {width: 100px; text-align:right;}
    .aw-column-21 {width: 80px; text-align:right;}
    .aw-column-22 {width: 100px; text-align:right;}
    .aw-column-23 {width: 100px; text-align:right;}
    .aw-column-24 {width: 100px; text-align:center;}
    .aw-column-25 {width: 80px; text-align:center;}
    .aw-column-26 {width: 100px; text-align:center;}
    .aw-column-27 {width: 120px; text-align:left;}

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
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			grid.refresh();
			
			//1년전부터
			if("${params.eventym}"==""){
			    $("#contractDateFrom_S").val("${params.agoYearDate}");
			}else{
				$("#contractDateFrom_S").val("${params.eventym}");
			}
			$("#contractDateTo_S").val("${params.currentDate}");
			
			if("${params.eventym}"!=""){
				$("#supportStateCD_S").val("40");
    			Search();
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
		checkbox : _i++
		, supportID : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, contractDateFrom : _i++
		, contractDateTo : _i++
		, contractMonthCt : _i++
		, apAmt : _i++
		, msTargetRate : _i++
		, tcontractQty : _i++
		, gsvAmt : _i++
		, gsvRate : _i++
		, stipulationAmt : _i++
		, contractAmt : _i++
		, contractTaxAmt : _i++
		, subtractAmt : _i++
		, targetRate : _i++
		, addAmt : _i++
		, addTaxAmt : _i++
		, payRequestDate : _i++
		, supportStateCDName : _i++
		, transferDate : _i++
		, commt : _i++
		, supportStateCD : _i++
		, requestPayYN : _i++
		
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/SUP0100201S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;supportID;venueCD;venueNm;venueGradCDName;"+
	  			"segmentCDName;subSegmentCDName;addrTpCD1Name;addrTpCD2Name;contractDateFrom;"+
	  			"contractDateTo;contractMonthCt;apAmt;msTargetRate;tcontractQty;"+
	  			"gsvAmt;gsvRate;stipulationAmt;contractAmt;contractTaxAmt;"+
	  			"subtractAmt;targetRate;addAmt;addTaxAmt;payRequestDate;"+
	  			"supportStateCDName;transferDate;commt;supportStateCD;requestPayYN;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;num;num;num;num5;"+
	  			"num;num;num;num;num;"+
	  			"num;num;num;num;str;"+
	  			"str;str;str;str;str;");
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	table.setParameter("contractDateFrom", unformat($("#contractDateFrom_S").val()));
	  	table.setParameter("contractDateTo", unformat($("#contractDateTo_S").val()));
	  	table.setParameter("payRequestDate", unformat($("#payRequestDate_S").val()));
	  	table.setParameter("supportStateCD", $("#supportStateCD_S").val());
	  	table.setParameter("contractOverYN", $("#contractOverYN").val());
	  	table.setParameter("periodShortTerm", 3);
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
					, table.getData(_col.supportID,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, formatDate(table.getData(_col.contractDateFrom,i))
					, formatDate(table.getData(_col.contractDateTo,i))
					, table.getData(_col.contractMonthCt,i)
					, table.getData(_col.apAmt,i)
					, table.getData(_col.msTargetRate,i)
					, table.getData(_col.tcontractQty,i)
					, table.getData(_col.gsvAmt,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.stipulationAmt,i)
					, table.getData(_col.contractAmt,i)
					, table.getData(_col.contractTaxAmt,i)
					, table.getData(_col.subtractAmt,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.addAmt,i)
					, table.getData(_col.addTaxAmt,i)
					, formatDate(table.getData(_col.payRequestDate,i))
					, table.getData(_col.supportStateCDName,i)
					, formatDate(table.getData(_col.transferDate,i))
					, table.getData(_col.commt,i)
					, table.getData(_col.supportStateCD,i)
					, table.getData(_col.requestPayYN,i)
      			];
      			
      			//지급금액보다 차감누계금액이 큰경우 빨강
      			var contractAmt = Number(unformatNum(table.getData(_col.contractAmt,i)));
				var subtractAmt = Number(unformatNum(table.getData(_col.subtractAmt,i)));
				if(contractAmt < subtractAmt) {
					grid.getCellTemplate(_col.subtractAmt, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.subtractAmt, i).setStyle("color", "#ffffff");
				}
			}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
	function New() {
		$("#selectSupportID").val("");
		$("#_detail")[0].contentWindow.New();
		appletOpen();
	}
	
	function RequestPay() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var supportIDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				supportIDs[count] = grid.getCellText(_col.supportID, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//추가지급금액이 있는 경우에만 지급요청가능
				if(grid.getCellText(_col.requestPayYN, index[i]) != "Y") {
					alert("<fmt:message key="SUP01002A.msg1"/>");
					return;
				}
				//상태가 등록인 경우만 지급요청가능
				if(grid.getCellText(_col.supportStateCD, index[i]) != "10") {
					alert("<fmt:message key="SUP01002A.msg2"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="SUP01002A.msg3"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/sup01/requestPaySupport_add");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("supportStateCD", "20");
		table.setParameter("supportIDs", supportIDs);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function ClearRequestPay() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var supportIDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				supportIDs[count] = grid.getCellText(_col.supportID, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//상태가 지급요청인 경우만 취소가능
				if(grid.getCellText(_col.supportStateCD, index[i]) != "20") {
					alert("<fmt:message key="SUP01002A.msg4"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="SUP01002A.msg5"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/sup01/clearRequestPaySupport_add");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("supportStateCD", "10");
		table.setParameter("supportIDs", supportIDs);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "SUP0100106S");
		table.setParameter("empID", "${params.empID}");
	  	table.setParameter("contractDateFrom", unformat($("#contractDateFrom_S").val()));
	  	table.setParameter("contractDateTo", unformat($("#contractDateTo_S").val()));
	  	table.setParameter("payRequestDate", unformat($("#payRequestDate_S").val()));
	  	table.setParameter("supportStateCD", $("#supportStateCD_S").val());
	  	table.setParameter("periodShortTerm", 3);
	  	
		var headerText = [
			"<fmt:message key="SUP01002A.supportID"/>"
			, "<fmt:message key="SUP01002A.venueCD"/>"
			, "<fmt:message key="SUP01002A.venueNm"/>"
			, "<fmt:message key="SUP01002A.venueGradCD"/>"
			, "<fmt:message key="SUP01002A.segmentCD"/>"
			, "<fmt:message key="SUP01002A.subSegmentCD"/>"
			, "<fmt:message key="SUP01002A.addrTpCD1"/>"
			, "<fmt:message key="SUP01002A.addrTpCD2"/>"
			, "<fmt:message key="SUP01002A.contractDateFrom"/>"
			, "<fmt:message key="SUP01002A.contractDateTo"/>"
			, "<fmt:message key="SUP01002A.contractMonthCt"/>"
			, "<fmt:message key="SUP01002A.apAmt"/>"
			, "<fmt:message key="SUP01002A.msTargetRate"/>"
			, "<fmt:message key="SUP01002A.tcontractQty"/>"
			, "<fmt:message key="SUP01002A.gsvAmt"/>"
			, "<fmt:message key="SUP01002A.gsvRate"/>"
			, "<fmt:message key="SUP01002A.stipulationAmt"/>"
			, "<fmt:message key="SUP01002A.contractAmt"/>"
			, "<fmt:message key="SUP01002A.contractTaxAmt"/>"
			, "<fmt:message key="SUP01002A.keymanAmt"/>"
			, "<fmt:message key="SUP01002A.payRequestDate"/>"
			, "<fmt:message key="SUP01002A.supportStateCD"/>"
			, "<fmt:message key="SUP01002A.transferDate"/>"
			, "<fmt:message key="SUP01002A.commt"/>"
			, "<fmt:message key="SUP01002A.kindTpCD5"/>"
			, "<fmt:message key="SUP01002A.prdNm"/>"
			, "<fmt:message key="SUP01002A.factoryPrice"/>"
			, "<fmt:message key="SUP01002A.qtyUnitCD"/>"
			, "<fmt:message key="SUP01002A.tcontractQty"/>"
			, "<fmt:message key="SUP01002A.enterQty"/>"
			, "<fmt:message key="SUP01002A.enterUnitAmt"/>"
			, "<fmt:message key="SUP01002A.payAmt"/>"
		];
		
		table.setParameter("templateFile", "SUP01001A");
		table.setParameter("headerText", headerText);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0,0) == "S") {
			    form.action = "${contextPath}/service/simpleExport/download/?"+
			    		"tempFile="+table.getData(3,0)+
			    		"&downloadFile=${params.viewName}";
			    form.target = "_self";
			    form.submit();
			}
		}
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		""
   		, "<fmt:message key="SUP01002A.supportID"/>"
		, "<fmt:message key="SUP01002A.venueCD"/>"
		, "<fmt:message key="SUP01002A.venueNm"/>"
		, "<fmt:message key="SUP01002A.venueGradCD"/>"
		, "<fmt:message key="SUP01002A.segmentCD"/>"
		, "<fmt:message key="SUP01002A.subSegmentCD"/>"
		, "<fmt:message key="SUP01002A.addrTpCD1"/>"
		, "<fmt:message key="SUP01002A.addrTpCD2"/>"
		, "<fmt:message key="SUP01002A.contractDateFrom"/>"
		, "<fmt:message key="SUP01002A.contractDateTo"/>"
		, "<fmt:message key="SUP01002A.contractMonthCt"/>"
		, "<fmt:message key="SUP01002A.apAmt"/>"
		, "<fmt:message key="SUP01002A.msTargetRate"/>"
		, "<fmt:message key="SUP01002A.tcontractQty"/>"
		, "<fmt:message key="SUP01002A.gsvAmt"/>"
		, "<fmt:message key="SUP01002A.gsvRate"/>"
		, "<fmt:message key="SUP01002A.stipulationAmt"/>"
		, "<fmt:message key="SUP01002A.contractAmt"/>"
		, "<fmt:message key="SUP01002A.contractTaxAmt"/>"
		, "<fmt:message key="SUP01002A.subtractAmt"/>"
		, "<fmt:message key="SUP01002A.targetRate"/>"
		, "<fmt:message key="SUP01002A.addAmt"/>"
		, "<fmt:message key="SUP01002A.addTaxAmt"/>"
		, "<fmt:message key="SUP01002A.payRequestDate"/>"
		, "<fmt:message key="SUP01002A.supportStateCD"/>"
		, "<fmt:message key="SUP01002A.transferDate"/>"
		, "<fmt:message key="SUP01002A.commt"/>"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
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
	                        , str, str, str, str, str
	                        , str, num, num, num, num5
	                        , num, num, num, num, num
	                        , num, num, num, num, str
	                        , str, str, str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(4);
	    
	    grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellValue(false, _col.checkbox);
		
		grid.setHeaderTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.onHeaderClicked=function(event,col){
			if (col == _col.checkbox && this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(true, _col.checkbox);
			}
			else if (col == _col.checkbox && !this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(false, _col.checkbox);
			}
			return false;
		};
		
		grid.onRowDoubleClicked = function(event, row){
			$("#selectSupportID").val(this.getCellText(_col.supportID,row));
			$("#_detail")[0].contentWindow.Search();
			appletOpen();
		};
		
    }
	
</script>