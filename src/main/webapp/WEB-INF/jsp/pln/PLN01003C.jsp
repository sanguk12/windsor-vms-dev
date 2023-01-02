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
						<input type="hidden" id="p_eventYM" name="p_eventYM" value="${params.eventYM}">
			            <input type="hidden" id="p_venueCD" name="p_venueCD" value="${params.venueCD}">
					</td>
				</tr>
                <tr>
					<td height="*" valign="top">
						<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
	                   		<tr>	                   			
								<td width="*">
									<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" >
			                    		<tr>
			                    			<td height="1" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
						                            <colgroup>
									        			<col style="width:130px;"></col>
									        			<col style="width:130px;"></col>
									        			<col style="width:130px;"></col>
									        			<col style="width:110px;"></col>
									        			<col></col>
									        		</colgroup>
							        				<tbody>
						                            	<tr>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.programCD" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.activityCD" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.venueCD" />
															</td>
															<td class="td-cond-report" colspan="2">
																<fmt:message key="PLN01002A.venueNm" />
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-report-rborder">
																&nbsp;<span id="programCDName"></span>
																<input type="hidden" id="programCD" name="programCD" />
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="activityCDName"></span>
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="venueCD"></span>
															</td>
															<td class="td-report-rborder" colspan="2">
																&nbsp;<span id="venueNm"></span>
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.threeMonthAvgTQty" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.qty" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.tpayAmt" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.gsvRate" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.threeMonthAvgRate" />
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="threeMonthAvgTQty"></span>
															</td>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="planTQty"></span>
															</td>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="tpayAmt"></span>
															</td>
															<td id="gsvRate_td" class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="gsvRate"></span>
															</td>
															<td id="threeMonthAvgRate_td" class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="threeMonthAvgRate"></span>
															</td>
			                            				</tr>
			                            				<tr>
															<td id="keyman_td" class="td-cond-report">
																<fmt:message key="PLN01002A.keyman" />
															</td>
															<td class="td-report-rborder" colspan="2">
																<nis:selectbox id="keymanID" name="keymanID" defaultText="select" query="COM03005S" paramkey="venueCD;x;" paramvalue=";x;" style="height:17px;" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.apprStateCD" />
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="apprStateCDName"></span>
																<input type="hidden" id="apprStateCD" name="apprStateCD" />
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.commt" />
															</td>
															<td class="td-report-rborder" colspan="4">
																<input type="text" id="commt" name="commt" style="width:100%; height:17px;" maxlength="100" />
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
						</table>
					</td>
				</tr>
				<tr>
					<td height="1">
						<input type="hidden" id="planWriteYN" name="planWriteYN" />
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid_pln .aw-column-0 {width: 35px; text-align:center;}
	#grid_pln .aw-column-1 {width: 60px; text-align:center;}
	#grid_pln .aw-column-2 {width: 100px; text-align:left;}
    #grid_pln .aw-column-3 {width: 60px; text-align:center;}
    #grid_pln .aw-column-4 {width: 100px; text-align:left;}
    #grid_pln .aw-column-5 {width: 60px; text-align:center;}
    #grid_pln .aw-column-6 {width: 100px; text-align:left;}
    #grid_pln .aw-column-7 {width: 120px; text-align:right;}
    
    #grid_prd .aw-column-0 {width: 100px; text-align:left;}
    #grid_prd .aw-column-1 {width: 120px; text-align:left;}
    #grid_prd .aw-column-2 {width: 80px; text-align:right;}
	#grid_prd .aw-column-3 {width: 70px; text-align:center;}
    #grid_prd .aw-column-4 {width: 90px; text-align:right;}
    #grid_prd .aw-column-5 {width: 80px; text-align:right;}
    #grid_prd .aw-column-6 {width: 110px; text-align:right;}
    #grid_prd .aw-column-7 {width: 110px; text-align:right;}

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
			
			createGrid_prd();
			grid_prd.refresh();	
			
			if("${params.eventYM}"!=""){
				Search_dtl();
    		}
		};

		${initScript}	
		
		
	});	

	function Close() {
		window.close();
	}
	
	//지급금액 계산
	function calculatePayAmt(row) {
		var planQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.planQty, row)));
		var planUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.planUnitAmt, row)));
		var payAmt = 0;
		payAmt = planQty * planUnitAmt;
		grid_prd.setCellText(formatNum(payAmt), _col_prd.payAmt, row);
		
		calculateTpayAmt();
		calculateGsvRate();
	}
	
	//당월Plan 총수량 계산
	function calculatePlanTQty() {
		var planTQty = 0;
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			planTQty += parseFloat(unformat(grid_prd.getCellText(_col_prd.planQty, i)));
		}
		$("#planTQty").text(formatNum(planTQty));
		
		calculateThreeMonthAvgRate();
	}
	
	//당월Plan 총지급액 계산
	function calculateTpayAmt() {
		var tpayAmt = 0;
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			tpayAmt += parseFloat(unformat(grid_prd.getCellText(_col_prd.payAmt, i)));
		}
		$("#tpayAmt").text(formatNum(tpayAmt));
	}
	
	//vs GSV 계산
	function calculateGsvRate() {
		//gsv
		var gsv = 0;
		//총지급액
		var tpayAmt = parseFloat(unformat($("#tpayAmt").text()));
		//제품별 plan수량
		var planQty = 0;
		//제품별 출고가
		var factoryPrice = 0;
		//제품별 plan수량*출고가
		var planQty_factoryPrice = 0;
		
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			planQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.planQty, i)));
			factoryPrice = parseFloat(unformat(grid_prd.getCellText(_col_prd.factoryPrice, i)));
			planQty_factoryPrice += planQty * factoryPrice;
		}
		gsv = (planQty_factoryPrice==0)?0:((tpayAmt*(1+0.0352)) / planQty_factoryPrice) * 100;
		$("#gsvRate").text(Math.round(gsv));
		
		setGsvRate_td($("#gsvRate").text());
	}
	
	//gsvRate td
	function setGsvRate_td(val) {
		val = parseFloat(unformatNum(val));
		if(Math.round(val) > 10) {
			$("#gsvRate_td").attr("style","text-align:right; background:#ff0000;");
			$("#gsvRate").attr("style","color:#ffffff;");
		}
		else {
			$("#gsvRate_td").attr("style","text-align:right; background:#ffffff;");
			$("#gsvRate").attr("style","color:#00000;");
		}
	}
	
	//3개월평균대비 계산
	function calculateThreeMonthAvgRate() {
		//당월plan수량 합
		var planTQty = 0;
		//3개월평균수량
		var threeMonthAvgTQty = 0;
		//3개월평균대비수량
		var threeMonthAvgRate = 0;
		
		planTQty = parseFloat(unformat($("#planTQty").text()));
		threeMonthAvgTQty = parseFloat(unformat($("#threeMonthAvgTQty").text()));
		
		if(threeMonthAvgTQty > 0) {
			threeMonthAvgRate = Math.round(planTQty / threeMonthAvgTQty * 100);
		}
		else {
			threeMonthAvgRate = 0;
		}
		$("#threeMonthAvgRate").text(formatNum(threeMonthAvgRate));
		
		setThreeMonthAvgRate_td(threeMonthAvgRate);
	}
	
	//threeMonthAvgRate td
	function setThreeMonthAvgRate_td(val) {
		val = parseFloat(unformat(val));
		if(val < 90 || val > 120) {
			$("#threeMonthAvgRate_td").attr("style","text-align:right; background:#ff0000;");
			$("#threeMonthAvgRate").attr("style","color:#ffffff;");
		}
		else {
			$("#threeMonthAvgRate_td").attr("style","text-align:right; background:#ffffff;");
			$("#threeMonthAvgRate").attr("style","color:#00000;");
		}
	}

	/****************************************
	* Button Action
	****************************************/
	var _i_dtl = 0;
	var _col_dtl = {
		programCDName : _i_dtl++
		, activityCDName : _i_dtl++
		, venueCD : _i_dtl++
		, venueNm : _i_dtl++
		, threeMonthAvgTQty : _i_dtl++
		, planTQty : _i_dtl++
		, tpayAmt : _i_dtl++
		, gsvRate : _i_dtl++
		, threeMonthAvgRate : _i_dtl++
		, keymanID : _i_dtl++
		, apprStateCDName : _i_dtl++
		, apprStateCD : _i_dtl++
		, commt : _i_dtl++
		, programCD : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0100202S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"programCDName;activityCDName;venueCD;venueNm;threeMonthAvgTQty;"+
	  			"planTQty;tpayAmt;gsvRate;threeMonthAvgRate;keymanID;"+
	  			"apprStateCDName;apprStateCD;commt;programCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;num;"+
	  			"num;num;num;num;str;"+
	  			"str;str;str;str;");	  	
	  	table.setParameter("eventYM", "${params.eventYM}");
	  	table.setParameter("venueCD", "${params.venueCD}");
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		//keyman 리스트 가져오기
      		var table_t = new AW.XML.Table;
    		table_t.setURL("${contextPath}/service/simpleAction/COM03005S");
    		table_t.setAsync(false);
    		table_t.setRequestMethod("POST");
    	  	table_t.setParameter("venueCD", "${params.venueCD}");
         	table_t.request();
         	if(table_t.getCount() > 0) {
    	     	$("#keymanID").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	     	for(var i=0; i<table_t.getCount(); i++){
   	   				$("#keymanID").append('<option value="'+table_t.getData(0,i)+'">'+table_t.getData(1,i)+'</option>');
    	   		}
         	}
         	else {
         		$("#keymanID").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
         	}
      		
      		$("#programCDName").text(table.getData(_col_dtl.programCDName, 0));
      		$("#activityCDName").text(table.getData(_col_dtl.activityCDName, 0));
      		$("#venueCD").text(table.getData(_col_dtl.venueCD, 0));
      		$("#venueNm").text(table.getData(_col_dtl.venueNm, 0));
      		$("#threeMonthAvgTQty").text(table.getData(_col_dtl.threeMonthAvgTQty, 0));
      		$("#planTQty").text(table.getData(_col_dtl.planTQty, 0));
      		$("#tpayAmt").text(table.getData(_col_dtl.tpayAmt, 0));
      		$("#gsvRate").text(table.getData(_col_dtl.gsvRate, 0));
      		setGsvRate_td(table.getData(_col_dtl.gsvRate, 0));
      		$("#threeMonthAvgRate").text(table.getData(_col_dtl.threeMonthAvgRate, 0));
      		setThreeMonthAvgRate_td(table.getData(_col_dtl.threeMonthAvgRate, 0));
      		$("#keymanID").val(table.getData(_col_dtl.keymanID, 0));
      		
      		if(table.getData(_col_dtl.apprStateCD, 0) == "10") {
	      		$("#apprStateCDName").text(table.getData(_col_dtl.apprStateCDName, 0));
      		}
      		else {
      			$("#apprStateCDName").html("<a href='javascript:openApprState();'>"+table.getData(_col_dtl.apprStateCDName, 0)+"</a>");
      		}
      		
      		$("#apprStateCD").val(table.getData(_col_dtl.apprStateCD, 0));
      		$("#commt").val(table.getData(_col_dtl.commt, 0));
      		$("#programCD").val(table.getData(_col_dtl.programCD, 0));
      		
      		//program이 G2일때 keyman필수, 그외엔 선택불가
      		if(table.getData(_col_dtl.programCD, 0) == "G2") {
      			$("#keyman_td").removeClass("td-cond-report");
      			$("#keyman_td").addClass("td-cond-report-required");
      			$("#keymanID").attr("disabled",false);
        		$("#keymanID").removeClass("input-readonly");
      		}
      		else {
      			$("#keyman_td").addClass("td-cond-report");
      			$("#keyman_td").removeClass("td-cond-report-required");
      			$("#keymanID").attr("disabled",true);
        		$("#keymanID").addClass("input-readonly");
      		}
      		
      		Search_prd();
      	}
	}
	
	function openApprState() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PLN01002B"
				+"&eventYM=${params.eventYM}&venueCD=${params.venueCD}";
		
		newWindow(url, "PLN01002B",680,350,"yes");
	}
	
	var _i_prd = 0;
	var _col_prd = {
		kindTpCD5Name : _i_prd++
		, prdNm : _i_prd++
		, factoryPrice : _i_prd++
		, qtyUnitCDName : _i_prd++
		, threeMonthAvgQty : _i_prd++
		, planQty : _i_prd++
		, planUnitAmt : _i_prd++
		, payAmt : _i_prd++
		, prdCD : _i_prd++
    };
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0100203S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;threeMonthAvgQty;"+
	  			"planQty;planUnitAmt;payAmt;prdCD;");
	  	table.setParameter("format",
	  			"str;str;num;str;num;"+
	  			"num;num;num;str;");
	  	table.setParameter("eventYM", "${params.eventYM}");
	  	table.setParameter("venueCD", "${params.venueCD}");
	  	
	  	table.request();
      	
// 	  	if (grid_prd != null) grid_prd.clear();
      	createGrid_prd();
      	
      	//2014.08.05, taejoon.jang, G2plan수량,단가입력못하는 제품
      	var noEditPrd = [
      		  "000053"
      		, "000054"
      		, "000055"
      		, "000056"
      		, "000057"
      		, "000045"
      	];
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					table.getData(_col_prd.kindTpCD5Name,i)
					, table.getData(_col_prd.prdNm,i)
					, table.getData(_col_prd.factoryPrice,i)
      			    , table.getData(_col_prd.qtyUnitCDName,i)
					, table.getData(_col_prd.threeMonthAvgQty,i)
					, table.getData(_col_prd.planQty,i)
					, table.getData(_col_prd.planUnitAmt,i)
					, table.getData(_col_prd.payAmt,i)
					, table.getData(_col_prd.prdCD,i)
      			];
      			
      			if($("#programCD").val()=="G2") {
      				var prdCD = table.getData(_col_prd.prdCD,i);
      				for(var j=0; j<noEditPrd.length; j++) {
      					if(prdCD == noEditPrd[j]) {
      						grid_prd.setCellEditable(false, _col_prd.planQty, i);
      						grid_prd.setCellEditable(false, _col_prd.planUnitAmt, i);
      						grid_prd.getCellTemplate(_col_prd.planQty, i).setStyle("background", "#ececec");
      						grid_prd.getCellTemplate(_col_prd.planUnitAmt, i).setStyle("background", "#ececec");
      					}
      				}
      			}
      		}
      		grid_prd.setCellData(data);
      		grid_prd.setRowCount(rowCount);
      	}
      	grid_prd.refresh();
	}
	
	function PlanChg() {		
		
		if(grid_prd.getRowCount() == 0) {
			alert("<fmt:message key="info.nullData.save"/>");
			return;
		}
		
		if($("#programCD").val() == "G2") {
			if($("#keymanID").val() == "") {
				alert("<fmt:message key="PLN01002A.msg2"/>");
				$("#keymanID").focus();
				return;
			}
		}
		
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			if (grid_prd.getCellText(_col_prd.planQty, i) == "") {alert("<fmt:message key="PLN01002A.msg3" />"); setCellFocus(grid_prd, _col_prd.planQty, i); return;}
			if (grid_prd.getCellText(_col_prd.planUnitAmt, i) == "") {alert("<fmt:message key="PLN01002A.msg4" />"); setCellFocus(grid_prd, _col_prd.planUnitAmt, i); return;}
		}
		
		var prdCDs = new Array();
		var planQtys = new Array();
		var planUnitAmts = new Array();
		var payAmts = new Array();
		var count = 0;
		for (var i=0; i<grid_prd.getRowCount(); i++) {
			prdCDs[count] = grid_prd.getCellText(_col_prd.prdCD, i);
			planQtys[count] = grid_prd.getCellText(_col_prd.planQty, i);
			planUnitAmts[count] = grid_prd.getCellText(_col_prd.planUnitAmt, i);
			payAmts[count] = grid_prd.getCellText(_col_prd.payAmt, i);
			count++;
		}
		
		if(!confirm("Plan변경 반영 시 기존 승인 된 내역이 모두 초기화 되어 승인라인의 재승인이 필요합니다. 진행하시겠습니까?")) {
       		return;
       	}

		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln03/savePlanVenueChg");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", "${params.eventYM}");
		table.setParameter("venueCD", "${params.venueCD}");
		table.setParameter("apprStateCD", $("#apprStateCD").val());  // 플랜변경 시 고정값.
		table.setParameter("threeMonthAvgTQty", $("#threeMonthAvgTQty").text());
		table.setParameter("planTQty", $("#planTQty").text());
		table.setParameter("tpayAmt", $("#tpayAmt").text());
		table.setParameter("gsvRate", $("#gsvRate").text());
		table.setParameter("threeMonthAvgRate", $("#threeMonthAvgRate").text());
		table.setParameter("keymanID", $("#keymanID").val());
		table.setParameter("commt", $("#commt").val());
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("planQtys", planQtys);
		table.setParameter("planUnitAmts", planUnitAmts);
		table.setParameter("payAmts", payAmts);
		
		table.setParameter("userID", "${params.userID}");
		table.request();

		if(table.getData(0,0) == "S") {			
			alert(table.getData(1,0));
			opener.Search();
			window.close();
   		}
		else {
			alert(table.getData(1,0));
		}
	}	
	
	/*****************************************************
	*	define grid_pln / data formats define
	*****************************************************/
	var columns_prd = [
		"<fmt:message key="PLN01002A.kindTpCD5"/>"
		, "<fmt:message key="PLN01002A.prdNm"/>"
		, "<fmt:message key="PLN01002A.factoryPrice"/>"
		, "<fmt:message key="PLN01002A.qtyUnitCD"/>"
		, "<fmt:message key="PLN01002A.threeMonthAvgQty"/>"
		, "<fmt:message key="PLN01002A.planQty"/>"
		, "<fmt:message key="PLN01002A.planUnitAmt"/>"
		, "<fmt:message key="PLN01002A.payAmt"/>"
	];
	var grid_prd = null;
	function createGrid_prd() {
		grid_prd = new AW.Grid.Extended;
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
	                        str, str, num, str, num
	                        , num, num, num]);
	    grid_prd.setCellEditable(true);
	    grid_prd.setCellEditable(false, _col_prd.kindTpCD5Name);
	    grid_prd.setCellEditable(false, _col_prd.prdNm);
	    grid_prd.setCellEditable(false, _col_prd.factoryPrice);
	    grid_prd.setCellEditable(false, _col_prd.qtyUnitCDName);
	    grid_prd.setCellEditable(false, _col_prd.threeMonthAvgQty);
	    grid_prd.setCellEditable(false, _col_prd.payAmt);
	    grid_prd.setFixedLeft(2);
	    
     	// Cell startEdit BEGIN
        grid_prd.onCellSelectedChanged = function(selected, col, row) {
            if (selected) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
                });
            }
        };

        grid_prd.onCellClicked = function(event, col, row) {
            if (this.getCellSelected(col, row)) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
               });
            }
        };

		grid_prd.onCellEditEnded = function(text, col, row) {
			this.setCellText(text, col, row);
			this.focus();
		};
		// Cell startEdit END
		
		//  BEGIN validating (Enter, Cell LoseFocus)
		grid_prd.onCellEditStarted = function(text, col, row){
			if (col == _col_prd.planQty || col == _col_prd.planUnitAmt) {
				this.setCellText(unformatNum(text), col, row);
			}
		};
		
		grid_prd.onCellValidating = function(text, col, row) {
			if (col == _col_prd.planQty) {
				if(unformat(text).length > 5) {
	    			alert("<fmt:message key="info.validate.numlength"><fmt:param value='5'/></fmt:message>");
					this.setCellText(unformat(text).substring(0,5),col,row);
					return;
				}
				if (!isDecimal(unformat(text))) {
				    alert("<fmt:message key="error.noNum" />");
				    this.setCellText("0",col,row);
				    return;
				}
	    		else if (parseFloat(unformat(text)) < 0) {
					alert("<fmt:message key="error.noMinusNum" />");
					this.setCellText("0",col,row);
					return;
				}
			}
			else if(col == _col_prd.planUnitAmt) {
				if(unformat(text).length > 13) {
	    			alert("<fmt:message key="info.validate.numlength"><fmt:param value='13'/></fmt:message>");
					this.setCellText(unformat(text).substring(0,13),col,row);
					return;
				}
				if (!isDecimal(unformat(text))) {
				    alert("<fmt:message key="error.noNum" />");
				    this.setCellText("0",col,row);
				    return;
				}
	    		else if (parseFloat(unformat(text)) < 0) {
					alert("<fmt:message key="error.noMinusNum" />");
					this.setCellText("0",col,row);
					return;
				}
			}
	    };
	
	    grid_prd.onCellValidated = function(text, col, row) {
	    	if (col == _col_prd.planQty) {
	    		this.setCellText(formatNum(unformat(text)), col, row);
	    		calculatePayAmt(row);
	    		calculatePlanTQty();
	    	}
	    	else if(col == _col_prd.planUnitAmt) {
	    		this.setCellText(formatNum(unformat(text)), col, row);
	    		calculatePayAmt(row);
	    	}
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
    }
	
</script>