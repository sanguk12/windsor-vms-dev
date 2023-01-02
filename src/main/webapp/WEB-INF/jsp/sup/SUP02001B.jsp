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
						<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" >
							<tr>
								<td height="1" valign="top">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:180px;"></col>
											<col style="width:180px;"></col>
											<col style="width:180px;"></col>
											<col style="width:180px;"></col>
											<col style="width:180px;"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.supportID" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.venueCD" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.venueNm" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.contractDate" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.contractMonthCt" />
												</td>
												<td class="td-cond-report">
												</td>
											</tr>
											<tr>
												<td class="td-report-rborder">
													&nbsp;<span id="supportID"></span>
													<input type="hidden" id="empID" name="empID" />
												</td>
												<td class="td-report-rborder">
													&nbsp;<span id="venueCD"></span>
												</td>
												<td class="td-report-rborder">
													&nbsp;<span id="venueNm"></span>
												</td>
												<td class="td-report-rborder">
													&nbsp;<span id="contractDate"></span>
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="contractMonthCt"></span>
												</td>
												<td class="td-report-rborder">
												</td>
											</tr>
											<tr>
												<!-- <td class="td-cond-report">
													<fmt:message key="SUP02001B.apAmt" />
												</td> -->
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.msTargetRate" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.tcontractQty" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.gsvAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.gsvRate" />
												</td>
												<td class="td-cond-report">
												</td>
											</tr>
											<tr>
												<!-- <td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="apAmt"></span>
												</td> -->
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="msTargetRate"></span>
													<input type="hidden" id="apAmt" name="apAmt" />
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="tcontractQty"></span>
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="gsvAmt"></span>
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="gsvRate"></span>
												</td>
												<td class="td-report-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.stipulationAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.contractAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.diffAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.contractTaxAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.payRequestDate" />
												</td>
												<td class="td-cond-report">
												</td>
											</tr>
											<tr>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="stipulationAmt"></span>
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="contractAmt"></span>
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="diffAmt"></span>
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="contractTaxAmt"></span>
												</td>
												<td class="td-report-rborder">
													&nbsp;<span id="payRequestDate"></span>
												</td>
												<td class="td-report-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-report">
													<fmt:message key="SUP02001B.supportStateCD" />
												</td>
												<td class="td-cond-report" colspan="4">
													<fmt:message key="SUP02001B.commt" />
												</td>
												<td class="td-cond-report">
												</td>
											</tr>
											<tr>
												<td class="td-report-rborder">
													&nbsp;<span id="supportStateCDName"></span>
													<input type="hidden" id="supportStateCD" name="supportStateCD" />
												</td>
												<td class="td-report-rborder" colspan="6">
													<input type="text" id="commt" name="commt" style="width:200px; height:17px;" />
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
					            <td height="1" style="padding:10px 0 0 0;">
					                <table border="0" cellspacing="0" cellpadding="0" width="100%" >
					                    <colgroup>
					                        <col style="width:300px;"></col>
					                    </colgroup>
					                    <tbody>
					                        <tr>
					                            <td class="group-title">
					                            	<fmt:message key="SUP02001B.contractPrdContent"/>
					                            </td>
					                        </tr>
					                    </tbody>
					                </table>
					            </td>
					        </tr>
							<tr>
								<td height="*">
									<span id="grid_prd"></span>
								</td>
							</tr>
						</table>
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

    #grid_prd .aw-column-0 {width: 150px; text-align:left;}
    #grid_prd .aw-column-1 {width: 150px; text-align:left;}
    #grid_prd .aw-column-2 {width: 100px; text-align:right;}
	#grid_prd .aw-column-3 {width: 80px; text-align:center;}
    #grid_prd .aw-column-4 {width: 100px; text-align:right;}
    #grid_prd .aw-column-5 {width: 100px; text-align:right;}
    #grid_prd .aw-column-6 {width: 100px; text-align:right;}
    #grid_prd .aw-column-7 {width: 120px; text-align:right;}

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
		$("#payRate").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid_prd();
			grid_prd.refresh();
			
		};

		${initScript}
		
	});
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function Search() {
		Search_dtl();
	}
	
	var _i_dtl = 0;
	var _col_dtl = {
		supportID : _i_dtl++
		, venueCD : _i_dtl++
		, venueNm : _i_dtl++
		, contractDate : _i_dtl++
		, contractMonthCt : _i_dtl++
		, apAmt : _i_dtl++
		, msTargetRate : _i_dtl++
		, tcontractQty : _i_dtl++
		, gsvAmt : _i_dtl++
		, gsvRate : _i_dtl++
		, stipulationAmt : _i_dtl++
		, contractAmt : _i_dtl++
		, contractTaxAmt : _i_dtl++
		, payRequestDate : _i_dtl++
		, supportStateCDName : _i_dtl++
		, supportStateCD : _i_dtl++
		, commt : _i_dtl++
		, empID : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/SUP0200102S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"supportID;venueCD;venueNm;contractDate;"+
	  			"contractMonthCt;apAmt;msTargetRate;tcontractQty;gsvAmt;"+
	  			"gsvRate;stipulationAmt;contractAmt;contractTaxAmt;payRequestDate;"+
	  			"supportStateCDName;supportStateCD;commt;empID;");
	  	table.setParameter("format",
	  			"str;str;str;str;"+
	  			"num;num;num;num5;num;"+
	  			"num;num;num;num;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("supportID", parent.$("#selectSupportID").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var contractAmt = Number(unformatNum(table.getData(_col_dtl.contractAmt,0)));
			var stipulationAmt = Number(unformatNum(table.getData(_col_dtl.stipulationAmt,0)));
      		$("#supportID").text(table.getData(_col_dtl.supportID, 0));
      		$("#venue").text(table.getData(_col_dtl.venueCD, 0));
      		$("#venueCD").text(table.getData(_col_dtl.venueCD, 0));
      		$("#venueNm").text(table.getData(_col_dtl.venueNm, 0));
      		$("#contractDate").text(table.getData(_col_dtl.contractDate, 0));
      		$("#contractMonthCt").text(table.getData(_col_dtl.contractMonthCt, 0));
      		//$("#apAmt").text(table.getData(_col_dtl.apAmt, 0));
      		$("#apAmt").val(table.getData(_col_dtl.apAmt, 0));
      		$("#msTargetRate").text(table.getData(_col_dtl.msTargetRate, 0));
      		$("#tcontractQty").text(table.getData(_col_dtl.tcontractQty, 0));
      		$("#gsvAmt").text(table.getData(_col_dtl.gsvAmt, 0));
      		$("#gsvRate").text(table.getData(_col_dtl.gsvRate, 0));
      		$("#stipulationAmt").text(table.getData(_col_dtl.stipulationAmt, 0));
      		$("#diffAmt").text(formatNum(stipulationAmt - contractAmt));
      		$("#contractAmt").text(table.getData(_col_dtl.contractAmt, 0));
      		$("#contractTaxAmt").text(table.getData(_col_dtl.contractTaxAmt, 0));
      		$("#payRequestDate").text(formatDate(table.getData(_col_dtl.payRequestDate, 0)));
      		$("#supportStateCDName").text(table.getData(_col_dtl.supportStateCDName, 0));
      		$("#supportStateCD").val(table.getData(_col_dtl.supportStateCD, 0));
      		$("#commt").val(table.getData(_col_dtl.commt, 0));
      		$("#empID").val(table.getData(_col_dtl.empID, 0));
      		
			Search_prd();
      	}
	}
	
	var _i_prd = 0;
	var _col_prd = {
		kindTpCD5Name : _i_prd++
		, prdNm : _i_prd++
		, factoryPrice : _i_prd++
		, qtyUnitCDName : _i_prd++
		, contractQty : _i_prd++
		, enterQty : _i_prd++
		, enterUnitAmt : _i_prd++
		, payAmt : _i_prd++
		, prdCD : _i_prd++
    };
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/SUP0200103S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;contractQty;"+
	  			"enterQty;enterUnitAmt;payAmt;prdCD;");
	  	table.setParameter("format",
	  			"str;str;num;str;num5;"+
	  			"num;num;num;str;");
	  	table.setParameter("supportID", parent.$("#selectSupportID").val());
	  	table.request();
      	
// 	  	if (grid_prd != null) grid_prd.clear();
      	createGrid_prd();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					table.getData(_col_prd.kindTpCD5Name,i)
					, table.getData(_col_prd.prdNm,i)
					, table.getData(_col_prd.factoryPrice,i)
      			    , table.getData(_col_prd.qtyUnitCDName,i)
					, table.getData(_col_prd.contractQty,i)
					, table.getData(_col_prd.enterQty,i)
					, table.getData(_col_prd.enterUnitAmt,i)
					, table.getData(_col_prd.payAmt,i)
					, table.getData(_col_prd.prdCD,i)
      			];
      		}
      		grid_prd.setCellData(data);
      		grid_prd.setRowCount(rowCount);
      		
      	}
      	grid_prd.refresh();
	}
	
	function Approval() {
		//지급요청인 경우에만 승인
		if($("#supportStateCD").val() != "20") {
			alert("<fmt:message key="SUP02001B.msg1"/>");
			return;
		}
		if(!confirm("<fmt:message key="SUP02001B.msg2"/>")) {
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/sup02/approvalSupport");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("supportID", parent.$("#selectSupportID").val());
		table.setParameter("supportStateCD", "30");		//30:지급승인
		table.setParameter("commt", $("#commt").val());
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Reject() {
		//지급요청인 경우에만 승인
		if($("#supportStateCD").val() != "20") {
			alert("<fmt:message key="SUP02001B.msg3"/>");
			return;
		}
		if($("#commt").val() == "") {
			alert("<fmt:message key="SUP02001B.msg4"/>");
   			$("#commt").focus();
   			return;
   		}
		if(!confirm("<fmt:message key="SUP02001B.msg5"/>")) {
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/sup02/rejectSupport");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("supportID", parent.$("#selectSupportID").val());
		table.setParameter("supportStateCD", "40");		//40:지급반려
		table.setParameter("commt", $("#commt").val());
		//mail
		table.setParameter("payRequestDate", $("#payRequestDate").text());
		table.setParameter("empID", $("#empID").val());
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function List() {
		parent.Search();
		parent.appletClose();
	}

	/*****************************************************
	*	define grid_rlt / data formats define
	*****************************************************/
	var columns_prd = [
		"<fmt:message key="SUP02001B.kindTpCD5"/>"
		, "<fmt:message key="SUP02001B.prdNm"/>"
		, "<fmt:message key="SUP02001B.factoryPrice"/>"
		, "<fmt:message key="SUP02001B.qtyUnitCD"/>"
		, "<fmt:message key="SUP02001B.contractQty"/>"
		, "<fmt:message key="SUP02001B.enterQty"/>"
		, "<fmt:message key="SUP02001B.enterUnitAmt"/>"
		, "<fmt:message key="SUP02001B.payAmt"/>"
	];
	var grid_prd = null;
	function createGrid_prd() {
		grid_prd = new AW.UI.Grid;
	    grid_prd.setId("grid_prd");
	    grid_prd.setRowCount(0);
	    grid_prd.setStyle("width","100%");
	    grid_prd.setStyle("height","100%");
	    grid_prd.setSelectorVisible(false);
	    grid_prd.setSelectionMode("single-cell");
	    grid_prd.setHeaderText(columns_prd);
	    for(var i=0;i<columns_prd.length;i++){grid_prd.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_prd.setColumnCount(columns_prd.length);
	    grid_prd.setCellFormat([
	                        str, str, num, str, num5
	                        , num, num, num, str]);
	    grid_prd.setCellEditable(false);
    }
	
</script>