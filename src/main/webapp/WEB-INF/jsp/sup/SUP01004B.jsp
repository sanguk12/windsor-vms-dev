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
													<fmt:message key="SUP01002B.supportID" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.venueCD" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.venueNm" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.contractDate" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.contractMonthCt" />
												</td>
												<td class="td-cond-report">
												</td>
											</tr>
											<tr>
												<td class="td-report-rborder">
													&nbsp;<span id="supportID"></span>
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
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.apAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.msTargetRate" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.tcontractQty" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.gsvAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.gsvRate" />
												</td>
												<td class="td-cond-report">
												</td>
											</tr>
											<tr>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="apAmt"></span>
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="msTargetRate"></span>
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
													<fmt:message key="SUP01002B.stipulationAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.contractAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.diffAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.contractTaxAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.payRequestDate" />
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
													<fmt:message key="SUP01002B.subtractAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.targetRate" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.addAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.addTaxAmt" />
												</td>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.addPayRequestDate" />
												</td>
												<td class="td-cond-report">
												</td>
											</tr>
											<tr>
												<td id="subtractAmt_td" class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="subtractAmt"></span>
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="targetRate"></span>
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="addAmtLink"></span>
													<input type="hidden" id="addAmt" name="addAmt" />
												</td>
												<td class="td-report-rborder" style="text-align:right;">
													&nbsp;<span id="addTaxAmt"></span>
												</td>
												<td class="td-report-rborder">
													&nbsp;<span id="addPayRequestDate"></span>
												</td>
												<td class="td-report-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-report">
													<fmt:message key="SUP01002B.supportStateCD" />
												</td>
												<td class="td-cond-report" colspan="4">
													<fmt:message key="SUP01002B.commt" />
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
													&nbsp;<span id="commt"></span>
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
					                        <col style="width:49%;"></col>
					                        <col style="width:2%;"></col>
					                        <col></col>
					                    </colgroup>
					                    <tbody>
					                        <tr>
					                            <td class="group-title">
					                            	<fmt:message key="SUP01002B.prdContent"/>
					                            </td>
					                            <td></td>
					                            <td class="group-title">
					                            	<fmt:message key="SUP01002B.subtractContent"/>
					                            </td>
					                        </tr>
					                    </tbody>
					                </table>
					            </td>
					        </tr>
					        <tr>
								<td height="*">
									<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
					                    <colgroup>
					                        <col style="width:49%;"></col>
					                        <col style="width:2%;"></col>
					                        <col></col>
					                    </colgroup>
					                    <tbody>
					                    	<tr>
					                    		<td>
					                    			<span id="grid_prd"></span>
				                    			</td>
				                    			<td></td>
				                    			<td>
				                    				<span id="grid_sub"></span>
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
						<input type="hidden" id="addAmtYN" name="addAmtYN" />
						<input type="hidden" id="payTpCD" name="payTpCD" value="ADD" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

    #grid_prd .aw-column-0 {width: 80px; text-align:left;}
    #grid_prd .aw-column-1 {width: 100px; text-align:left;}
    #grid_prd .aw-column-2 {width: 80px; text-align:right;}
	#grid_prd .aw-column-3 {width: 60px; text-align:center;}
    #grid_prd .aw-column-4 {width: 80px; text-align:right;}
    #grid_prd .aw-column-5 {width: 80px; text-align:right;}
    #grid_prd .aw-column-6 {width: 80px; text-align:right;}
    #grid_prd .aw-column-7 {width: 100px; text-align:right;}
    
    #grid_sub .aw-column-0 {width: 80px; text-align:center;}
    #grid_sub .aw-column-1 {width: 80px; text-align:left;}
    #grid_sub .aw-column-2 {width: 100px; text-align:left;}
    #grid_sub .aw-column-3 {width: 80px; text-align:right;}
	#grid_sub .aw-column-4 {width: 60px; text-align:center;}
    #grid_sub .aw-column-5 {width: 80px; text-align:right;}
    #grid_sub .aw-column-6 {width: 80px; text-align:right;}
    #grid_sub .aw-column-7 {width: 80px; text-align:right;}
    #grid_sub .aw-column-8 {width: 100px; text-align:right;}

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
			
			createGrid_sub();
			grid_sub.refresh();
			
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
		, subtractAmt : _i_dtl++
		, payRequestDate : _i_dtl++
		, targetRate : _i_dtl++
		, addAmt : _i_dtl++
		, addTaxAmt : _i_dtl++
		, addPayRequestDate : _i_dtl++
		, supportStateCDName : _i_dtl++
		, commt : _i_dtl++
		, supportStateCD : _i_dtl++
		, addAmtYN : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/SUP0100202S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"supportID;venueCD;venueNm;contractDate;"+
	  			"contractMonthCt;apAmt;msTargetRate;tcontractQty;gsvAmt;"+
	  			"gsvRate;stipulationAmt;contractAmt;contractTaxAmt;subtractAmt;"+
	  			"payRequestDate;targetRate;addAmt;addTaxAmt;addPayRequestDate;"+
	  			"supportStateCDName;commt;supportStateCD;addAmtYN;");
	  	table.setParameter("format",
	  			"str;str;str;str;"+
	  			"num;num;num;num5;num;"+
	  			"num;num;num;num;num;"+
	  			"str;num;num;num;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("supportID", parent.$("#selectSupportID").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#supportID").text(table.getData(_col_dtl.supportID, 0));
      		$("#venue").text(table.getData(_col_dtl.venueCD, 0));
      		$("#venueCD").text(table.getData(_col_dtl.venueCD, 0));
      		$("#venueNm").text(table.getData(_col_dtl.venueNm, 0));
      		$("#contractDate").text(table.getData(_col_dtl.contractDate, 0));
      		$("#contractMonthCt").text(table.getData(_col_dtl.contractMonthCt, 0));
      		$("#apAmt").text(table.getData(_col_dtl.apAmt, 0));
      		$("#msTargetRate").text(table.getData(_col_dtl.msTargetRate, 0));
      		$("#tcontractQty").text(table.getData(_col_dtl.tcontractQty, 0));
      		$("#gsvAmt").text(table.getData(_col_dtl.gsvAmt, 0));
      		$("#gsvRate").text(table.getData(_col_dtl.gsvRate, 0));
      		$("#stipulationAmt").text(table.getData(_col_dtl.stipulationAmt, 0));
      		$("#contractAmt").text(table.getData(_col_dtl.contractAmt, 0));
      		$("#contractTaxAmt").text(table.getData(_col_dtl.contractTaxAmt, 0));
      		$("#subtractAmt").text(table.getData(_col_dtl.subtractAmt, 0));
      		
  			var contractAmt = Number(unformatNum(table.getData(_col_dtl.contractAmt,0)));
			var subtractAmt = Number(unformatNum(table.getData(_col_dtl.subtractAmt,0)));
			var stipulationAmt = Number(unformatNum(table.getData(_col_dtl.stipulationAmt,0)));
  			if(contractAmt < subtractAmt) {
  				$("#subtractAmt_td").css("background","#ff0000");
  	     		$("#subtractAmt").css("color","#ffffff");
  			}
  			else {
  				$("#subtractAmt_td").css("background","#ffffff");
  	     		$("#subtractAmt").css("color","#000000");
  			}
      		
      		$("#payRequestDate").text(formatDate(table.getData(_col_dtl.payRequestDate, 0)));
      		$("#targetRate").text(table.getData(_col_dtl.targetRate, 0));
      		
      		if(table.getData(_col_dtl.addAmtYN, 0) == "Y") {
      			var addAmtLink = "<a href='javascript:updateAddPay();' style='cursor:pointer;'>"+table.getData(_col_dtl.addAmt, 0)+"</a>";
          		$("#addAmtLink").html(addAmtLink);
      		}
      		else {
      			$("#addAmtLink").text(table.getData(_col_dtl.addAmt, 0));
      		}
      		$("#addAmt").val(table.getData(_col_dtl.addAmt, 0));
      		$("#addTaxAmt").text(table.getData(_col_dtl.addTaxAmt, 0));
      		$("#addPayRequestDate").text(formatDate(table.getData(_col_dtl.addPayRequestDate, 0)));
      		$("#supportStateCDName").text(table.getData(_col_dtl.supportStateCDName, 0));
      		$("#commt").text(table.getData(_col_dtl.commt, 0));
      		$("#supportStateCD").val(table.getData(_col_dtl.supportStateCD, 0));
      		$("#addAmtYN").val(table.getData(_col_dtl.addAmtYN, 0));
      		$("#diffAmt").text(formatNum(stipulationAmt - contractAmt));
      		
			Search_prd();
			Search_sub();
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
		, resultUnitAmt : _i_prd++
		, payAmt : _i_prd++
		, prdCD : _i_prd++
		, eu : _i_prd++
    };
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/SUP0100203S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;contractQty;"+
	  			"enterQty;resultUnitAmt;payAmt;deleteBtn;prdCD;"+
	  			"eu;");
	  	table.setParameter("format",
	  			"str;str;num;str;num5;"+
	  			"num;num;num;str;str;"+
	  			"str;");
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
					, table.getData(_col_prd.resultUnitAmt,i)
					, table.getData(_col_prd.payAmt,i)
					, table.getData(_col_prd.prdCD,i)
					, table.getData(_col_prd.eu,i)
      			];
      		}
      		grid_prd.setCellData(data);
      		grid_prd.setRowCount(rowCount);
      		
      	}
      	grid_prd.refresh();
	}
	
	var _i_sub = 0;
	var _col_sub = {
		eventYM : _i_sub++
		, kindTpCD5Name : _i_sub++
		, prdNm : _i_sub++
		, factoryPrice : _i_sub++
		, qtyUnitCDName : _i_sub++
		, planQty : _i_sub++
		, resultQty : _i_sub++
		, resultUnitAmt : _i_sub++
		, payAmt : _i_sub++
		, prdCD : _i_sub++
    };
	function Search_sub() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/SUP0100204S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"eventYM;kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;"+
	  			"planQty;resultQty;resultUnitAmt;payAmt;prdCD;");
	  	table.setParameter("format",
	  			"str;str;str;num;str;"+
	  			"num;num;num;num;str;");
	  	table.setParameter("supportID", parent.$("#selectSupportID").val());
	  	table.setParameter("venueCD", $("#venueCD").text());
	  	table.request();
      	
// 	  	if (grid_sub != null) grid_sub.clear();
      	createGrid_sub();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					formatMonth(table.getData(_col_sub.eventYM,i))
					, table.getData(_col_sub.kindTpCD5Name,i)
					, table.getData(_col_sub.prdNm,i)
					, table.getData(_col_sub.factoryPrice,i)
      			    , table.getData(_col_sub.qtyUnitCDName,i)
					, table.getData(_col_sub.planQty,i)
					, table.getData(_col_sub.resultQty,i)
					, table.getData(_col_sub.resultUnitAmt,i)
					, table.getData(_col_sub.payAmt,i)
					, table.getData(_col_sub.prdCD,i)
      			];
      		}
      		grid_sub.setCellData(data);
      		grid_sub.setRowCount(rowCount);
      		
      	}
      	grid_sub.refresh();
	}
	
	function InsertAddPay() {
		if($("#addAmtYN").val()!="N") {
			alert("<fmt:message key="SUP01002B.msg1"/>");
			return;
		}
		var subtractAmt = parseFloat(unformat($("#subtractAmt").text()));
		var contractAmt = parseFloat(unformat($("#contractAmt").text()));
// 		if(contractAmt >= subtractAmt) {
// 			alert("<fmt:message key="SUP01002B.msg4"/>");
// 			return;
// 		}
		
		//추가지급금액(차감누계 - 지급금액)
		var mainAddAmt = parseFloat(unformat($("#subtractAmt").text())) - parseFloat(unformat($("#contractAmt").text()));
		var venueCD = $("#venueCD").text();
		var supportID = parent.$("#selectSupportID").val();
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=SUP01004C&mainAddAmt="+mainAddAmt+"&venueCD="+venueCD+"&supportID="+supportID;
		newWindow(url, "SUP01004C",700,570,"yes");
	}
	
	function updateAddPay() {
		//추가지급금액(추가금액)
		var mainAddAmt = parseFloat(unformat($("#addAmt").val()));
		var venueCD = $("#venueCD").text();
		var supportID = parent.$("#selectSupportID").val();
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=SUP01004C&mainAddAmt="+mainAddAmt+"&venueCD="+venueCD+"&supportID="+supportID;
		newWindow(url, "SUP01004C",700,570,"yes");
	}
	
	function DeleteAddPay() {
		if($("#addAmtYN").val()=="N") {
			alert("<fmt:message key="SUP01002B.msg3"/>");
			return;
		}
		//상태가 등록,지급반려인경우만 추가지급삭제
		if($("#supportStateCD").val()!="10" && $("#supportStateCD").val()!="40") {
			alert("<fmt:message key="SUP01002B.msg2"/>");
			return;
		}
		if(!confirm("<fmt:message key="confirm.delete"/>")){
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/sup01/deleteSupportKeyman_add");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("supportID", parent.$("#selectSupportID").val());
		table.setParameter("payTpCD", $("#payTpCD").val());
		table.request();

		if(table.getData(0,0) == "S") {
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
		"<fmt:message key="SUP01002B.kindTpCD5"/>"
		, "<fmt:message key="SUP01002B.prdNm"/>"
		, "<fmt:message key="SUP01002B.factoryPrice"/>"
		, "<fmt:message key="SUP01002B.qtyUnitCD"/>"
		, "<fmt:message key="SUP01002B.tcontractQty"/>"
		, "<fmt:message key="SUP01002B.enterQty"/>"
		, "<fmt:message key="SUP01002B.resultUnitAmt"/>"
		, "<fmt:message key="SUP01002B.payAmt"/>"
	];
	var grid_prd = null;
	function createGrid_prd() {
		grid_prd = new AW.Grid.Extended;
	    grid_prd.setId("grid_prd");
	    grid_prd.setRowCount(0);
	    grid_prd.setStyle("width","100%");
	    grid_prd.setStyle("height","100%");
	    grid_prd.setSelectorVisible(false);
	    grid_prd.setSelectionMode("single-row");
	    grid_prd.setHeaderText(columns_prd);
	    for(var i=0;i<columns_prd.length;i++){grid_prd.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_prd.setColumnCount(columns_prd.length);
	    grid_prd.setCellFormat([
	                        str, str, num, str, num5
	                        , num, num, num]);
	    grid_prd.setCellEditable(false);
	    grid_prd.setFixedLeft(2);
    }
	
	var columns_sub = [
		"<fmt:message key="SUP01002B.eventYM"/>"
		, "<fmt:message key="SUP01002B.kindTpCD5"/>"
		, "<fmt:message key="SUP01002B.prdNm"/>"
		, "<fmt:message key="SUP01002B.factoryPrice"/>"
		, "<fmt:message key="SUP01002B.qtyUnitCD"/>"
		, "<fmt:message key="SUP01002B.planTQty"/>"
		, "<fmt:message key="SUP01002B.resultTQty"/>"
		, "<fmt:message key="SUP01002B.resultUnitAmt"/>"
		, "<fmt:message key="SUP01002B.payAmt"/>"
	];
	var grid_sub = null;
	function createGrid_sub() {
		grid_sub = new AW.Grid.Extended;
		grid_sub.setId("grid_sub");
		grid_sub.setRowCount(0);
		grid_sub.setStyle("width","100%");
		grid_sub.setStyle("height","100%");
		grid_sub.setSelectorVisible(false);
		grid_sub.setSelectionMode("single-row");
		grid_sub.setHeaderText(columns_sub);
		for(var i=0;i<columns_sub.length;i++){grid_sub.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid_sub.setColumnCount(columns_sub.length);
		grid_sub.setCellFormat([
							str, str, str, num, str
							, num, num, num, num]);
		grid_sub.setCellEditable(false);
		grid_sub.setFixedLeft(1);
	}
	
</script>