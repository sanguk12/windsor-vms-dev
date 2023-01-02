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
											<col style="width:150px;"></col>
											<col style="width:150px;"></col>
											<col style="width:150px;"></col>
											<col style="width:250px;"></col>
											<col style="width:150px;"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="LTC02001B.supportID" />
												</td>
												<td class="td-cond-required" colspan="2">
													<fmt:message key="LTC02001B.venue" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="LTC02001B.contractDate" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC02001B.contractMonthCt" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="supportID" name="supportID" style="width:120px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder" colspan="2">
													<nis:popup id="venue" nameID="venueNm" keyID="venueCD" style="width:100px;" />
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="contractDateFrom_yearCD" name="contractDateFrom_yearCD" defaultText="none" category="YEARCD" enable="false" cssClass="input-readonly" />
													<nis:selectbox id="contractDateFrom_monthCD" name="contractDateFrom_monthCD" defaultText="none" category="MONTHCD" enable="false" cssClass="input-readonly" /> - 
													<nis:selectbox id="contractDateTo_yearCD" name="contractDateTo_yearCD" defaultText="none" category="YEARCD" enable="false" cssClass="input-readonly" />
													<nis:selectbox id="contractDateTo_monthCD" name="contractDateTo_monthCD" defaultText="none" category="MONTHCD" enable="false" cssClass="input-readonly" />
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="contractMonthCt" name="contractMonthCt" defaultText="none" category="CONTRACTMONTHCT" enable="false" cssClass="input-readonly"/>
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="LTC02001B.minContractQty" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="LTC02001B.targetRate" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="LTC02001B.addPayRate" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC02001B.threeMonthAvgQty"/>
												</td>
												<td class="td-cond">
													<fmt:message key="LTC02001B.tcontractQty"/>
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="minContractQty" name="minContractQty" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly  />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="targetRate" name="targetRate" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly  />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="addPayRate" name="addPayRate" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly  />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="threeMonthAvgTQty" name="threeMonthAvgTQty" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="tcontractQty" name="tcontractQty" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="LTC02001B.tcontractAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC02001B.exPayAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC02001B.tpayAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC02001B.gsvRate" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC02001B.threeMonthAvgRate" />
												</td>
												
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="tcontractAmt" name="tcontractAmt" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="exPayAmt" name="exPayAmt" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="tpayAmt" name="tpayAmt" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="gsvRate" name="gsvRate" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="threeMonthAvgRate" name="threeMonthAvgRate" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond" colspan="3">
													<fmt:message key="LTC02001B.commt" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC02001B.apprStateCD" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC02001B.apprStateCD_emp" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder" colspan="3">
													<input type="text" id="commt" name="commt" style="width:430px; text-align:left;"/>
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="apprStateCD" name="apprStateCD" defaultText="none" category="LTCSTATECD" enable="false" cssClass="input-readonly" />
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="apprStateCD_emp" name="apprStateCD_emp" defaultText="none" category="APPRSTATECD" enable="false" cssClass="input-readonly" />
												</td>
												<td class="td-input-rborder">
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
					                        <col></col>
					                    </colgroup>
					                    <tbody>
					                        <tr>
					                            <td class="group-title">
					                            	<fmt:message key="LTC02001B.detailContent" />
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
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="lastApprYN" name="lastApprYN" />
						<input type="hidden" id="levelNo" name="levelNo" />
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
    #grid_prd .aw-column-8 {width: 100px; text-align:right;}
    #grid_prd .aw-column-9 {width: 100px; text-align:right;}
    #grid_prd .aw-column-10 {width: 100px; text-align:right;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	var maxRow_prd = 0;
	 
	/****************************************
	 * Function
	 ****************************************/
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid_prd();
			grid_prd.refresh();
		};

		${initScript}
		
	});
	
	function calculatePayAmt(row) {
		if(grid_prd.getCellText(_col_prd.enterQty, row)=="") {
			return;
		}
		if(grid_prd.getCellText(_col_prd.enterUnitAmt, row)=="") {
			return;
		}
		var enterQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.enterQty, row)));
		var enterUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.enterUnitAmt, row)));
		var contractAmt = 0;
		contractAmt = enterQty * enterUnitAmt;
		grid_prd.setCellText(formatNum(contractAmt), _col_prd.contractAmt, row);
		
		calculateNsv(row);
	}
	
	//nsv, gp, gp(%) 계산
	function calculateNsv(row) {
		var enterQty = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.enterQty, row)));
		var gsv_prd = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.gsv_prd, row)));
		var duty_prd = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.duty_prd, row)));
		var wsdc_prd = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.wsdc_prd, row)));
		var cogs_prd = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.cogs_prd, row)));
		var contractAmt = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.contractAmt, row)));
		
		var gsv = 0.0;
		var duty = 0.0;
		var wsdc = 0.0;
		var cogs = 0.0;
		
		var nsv = 0.0;
		var gp = 0.0;
		var gpRate = 0.0;
		
		gsv = gsv_prd * enterQty;
		duty = duty_prd * enterQty;
		wsdc = wsdc_prd * enterQty;
		cogs = cogs_prd * enterQty;
		
		nsv = Math.round((gsv - duty - wsdc - contractAmt) * 10) / 10;
		gp = Math.round((nsv - cogs) * 10) / 10;
		
		if(nsv == 0.0) {
			gpRate = 0.0;
		} else {
			gpRate = Math.round((gp / nsv) * 1000) / 10;
		}
		
		grid_prd.setCellText(formatNum(nsv), _col_prd.nsv, row);
		grid_prd.setCellText(formatNum(gp), _col_prd.gp, row);
		grid_prd.setCellText(formatNum(gpRate), _col_prd.gpRate, row);
		
	}
	
	//당월Plan 총수량 계산
	function calculateTContractQty() {
		var tcontractQty = 0;
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
				tcontractQty += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.enterQty, i)));
			}
		}
		$("#tcontractQty").val(formatNum(tcontractQty));
		
		calculateThreeMonthAvgRate();
	}
	
	//지급액 계산
	function calculateTContractAmt() {
		var tcontractAmt = 0;
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
				tcontractAmt += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.contractAmt, i)));
			}
		}
		$("#tcontractAmt").val(formatNum(tcontractAmt));
		
		calculateGsvRate();	
	}
	
	//vs GSV 계산
	function calculateGsvRate() {
		//gsv
		var gsv = 0.0;
		//총지급액
		var tcontractAmt = parseFloat(unformatNum($("#tcontractAmt").val()));
		//제품별 plan수량
		var enterQty = 0;
		//제품별 출고가
		var factoryPrice = 0;
		//제품별 plan수량*출고가
		var enterQty_factoryPrice = 0;
		
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			enterQty = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.enterQty, i)));
			factoryPrice = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.factoryPrice, i)));
			enterQty_factoryPrice += enterQty * factoryPrice;
		}
		gsv = (enterQty_factoryPrice==0)?0:((tcontractAmt*(1+0.0352)) / enterQty_factoryPrice) * 100;
		$("#gsvRate").val(Math.round(gsv * 10) / 10);
	}
	
	function setThreeMonthAvgTQty() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0200107S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","threeMonthAvgTQty;");
	  	table.setParameter("format", "num;");
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#threeMonthAvgTQty").val(table.getData(0,0));
      	}
	}
	
	//3개월평균대비 계산
	function calculateThreeMonthAvgRate() {
		if($("#selectVenueCD").val()!=""){
			//당월plan수량 합
			var tcontractQty = 0;
			//3개월평균수량
			var threeMonthAvgTQty = 0;
			//3개월평균대비수량
			var threeMonthAvgRate = 0;
		
			tcontractQty = parseFloat(unformatNum($("#tcontractQty").val()));
			threeMonthAvgTQty = parseFloat(unformatNum($("#threeMonthAvgTQty").val()));
			
			if(threeMonthAvgTQty > 0) {
				threeMonthAvgRate = Math.round(tcontractQty / threeMonthAvgTQty * 100);
			}
			else {
				threeMonthAvgRate = 0;
			}
			$("#threeMonthAvgRate").val(formatNum(threeMonthAvgRate));
		}
	}
	
	function calculateExPayAmt(){
		if($("#addPayRate").val()==0){
			return;
		}
		var tcontractAmt = 0;
		var addPayRate = 0;
		var contractMonthCt = 0;
		var exPayAmt = 0;
		
		tcontractAmt = parseFloat(unformatNum($("#tcontractAmt").val()));
		addPayRate = parseFloat(unformatNum($("#addPayRate").val()));
		contractMonthCt = parseFloat(unformatNum($("#contractMonthCt").val()));
		exPayAmt = Math.round(tcontractAmt*addPayRate/100*contractMonthCt);
		
		$("#exPayAmt").val(formatNum(exPayAmt));
	}

</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function Search() {
		Search_dtl();
		Search_prd();
	}
	
	var _i_dtl = 0;
	var _col_dtl = {
		supportID : _i_dtl++
		, venueCD : _i_dtl++
		, venueNm : _i_dtl++
		, contractDateFrom : _i_dtl++
		, contractDateTo : _i_dtl++
		, contractMonthCt : _i_dtl++
		, minContractQty : _i_dtl++
		, targetRate : _i_dtl++
		, addPayRate : _i_dtl++
		, threeMonthAvgTQty : _i_dtl++
		, tcontractQty : _i_dtl++
		, tcontractAmt : _i_dtl++
		, tpayAmt : _i_dtl++
		, gsvRate : _i_dtl++
		, threeMonthAvgRate : _i_dtl++
		, apprStateCD : _i_dtl++
		, apprStateCD_emp : _i_dtl++
		, commt : _i_dtl++
		, lastApprYN : _i_dtl++
		, levelNo : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0200102S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"supportID;venueCD;venueNm;contractDateFrom;contractDateTo;"+
	  			"contractMonthCt;minContractQty;targetRate;addPayRate;threeMonthAvgTQty;"+
	  			"tcontractQty;tcontractAmt;tpayAmt;gsvRate;threeMonthAvgRate;"+
	  			"apprStateCD;apprStateCD_emp;commt;lastApprYN;levelNo;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"num;num;num;num;num;"+
	  			"num;num;num;num;num;"+
	  			"str;str;str;str;str;");
	  	table.setParameter("supportID", parent.$("#selectSupportID").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#supportID").val(table.getData(_col_dtl.supportID, 0));
      		$("#venue").val(table.getData(_col_dtl.venueCD, 0));
      		$("#venueCD").val(table.getData(_col_dtl.venueCD, 0));
      		$("#venueNm").val(table.getData(_col_dtl.venueNm, 0));
      		$("#contractDateFrom_yearCD").val(table.getData(_col_dtl.contractDateFrom, 0).substring(0,4));
			$("#contractDateFrom_monthCD").val(table.getData(_col_dtl.contractDateFrom, 0).substring(4,6));
		    $("#contractDateTo_yearCD").val(table.getData(_col_dtl.contractDateTo, 0).substring(0,4));
			$("#contractDateTo_monthCD").val(table.getData(_col_dtl.contractDateTo, 0).substring(4,6));
      		$("#contractMonthCt").val(table.getData(_col_dtl.contractMonthCt, 0));
      		$("#minContractQty").val(table.getData(_col_dtl.minContractQty, 0));
      		$("#targetRate").val(table.getData(_col_dtl.targetRate, 0));
      		$("#addPayRate").val(table.getData(_col_dtl.addPayRate, 0));
      		$("#threeMonthAvgTQty").val(table.getData(_col_dtl.threeMonthAvgTQty, 0));
      		$("#tcontractQty").val(table.getData(_col_dtl.tcontractQty, 0));
      		$("#tcontractAmt").val(table.getData(_col_dtl.tcontractAmt, 0));
      		$("#tpayAmt").val(table.getData(_col_dtl.tpayAmt, 0));
      		$("#gsvRate").val(table.getData(_col_dtl.gsvRate, 0));
      		$("#threeMonthAvgRate").val(table.getData(_col_dtl.threeMonthAvgRate, 0));
      		$("#apprStateCD").val(table.getData(_col_dtl.apprStateCD, 0));
      		$("#apprStateCD_emp").val(table.getData(_col_dtl.apprStateCD_emp, 0));
      		$("#commt").val(table.getData(_col_dtl.commt, 0));
      		$("#lastApprYN").val(table.getData(_col_dtl.lastApprYN, 0));
      		$("#levelNo").val(table.getData(_col_dtl.levelNo, 0));
      		
      		$("#venue").attr("readonly", true);
    		$("#venue").addClass("input-readonly");
      		$("#venue_popup").hide();
      		
      		if($("#apprStateCD_emp").val()!="20"){
      			$("#commt").attr("readonly", true);
    			$("#commt").addClass("input-readonly");
      		}else{
      			$("#commt").attr("readonly", false);
    			$("#commt").removeClass("input-readonly");
      		}
      	}
	}
	
	var _i_prd = 0;
	var _col_prd = {
		kindTpCD5Name : _i_prd++
		, prdNm : _i_prd++
		, factoryPrice : _i_prd++
		, qtyUnitCDName : _i_prd++
		, threeMonthAvgQty : _i_prd++
		, enterQty : _i_prd++
		, enterUnitAmt : _i_prd++
		, contractAmt : _i_prd++
		, nsv : _i_prd++
		, gp : _i_prd++
		, gpRate : _i_prd++
		, prdCD : _i_prd++
		, gsv_prd : _i_prd++
		, duty_prd : _i_prd++
		, wsdc_prd : _i_prd++
		, cogs_prd : _i_prd++
    };
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0200103S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;threeMonthAvgQty;" + 
	  			"enterQty;enterUnitAmt;contractAmt;nsv;gp;"+
	  			"gpRate;prdCD;gsv;"+
	  			"duty;wsdc;cogs;");
	  	table.setParameter("format",
	  			"str;str;num;str;num;"+
	  			"num;num;num;num;num;"+
	  			"num;str;num;"+
	  			"num;num;num;");
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
      			    , table.getData(_col_prd.threeMonthAvgQty,i)
					, table.getData(_col_prd.enterQty,i)
					, table.getData(_col_prd.enterUnitAmt,i)
					, table.getData(_col_prd.contractAmt,i)
					, ""
					, ""
					, ""
					, table.getData(_col_prd.prdCD,i)
					, table.getData(_col_prd.gsv_prd,i)
					, table.getData(_col_prd.duty_prd,i)
					, table.getData(_col_prd.wsdc_prd,i)
					, table.getData(_col_prd.cogs_prd,i)
      			];
      		}
      		
      		grid_prd.setCellData(data);
      		grid_prd.setRowCount(rowCount);
      		if (rowCount > 0) {
      			for (var i=0; i<rowCount; i++) {
      				calculateNsv(i);
      				calculatePayAmt(i);
      			}
	    		calculateTContractQty();
	    		calculateExPayAmt();
      		}
      	}
      	grid_prd.refresh();
      	
		maxRow_prd = rowCount;
	}
	
	function List() {
		parent.Search();
		parent.appletClose();
	}
	
	function Approval() {
		if($("#apprStateCD_emp").val()!="20"){
			alert("<fmt:message key="LTC02001B.msg1"/>");
			return;
		}
		
		if(!confirm("<fmt:message key="LTC02001B.msg2"/>")){
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ltc02/approvalSupport");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("supportID", $("#supportID").val());
		table.setParameter("lastApprYN", $("#lastApprYN").val());
		table.setParameter("levelNo", $("#levelNo").val());
		table.setParameter("commt", $("#commt").val());
		table.setParameter("apprStateCD", $("#apprStateCD").val());
		
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
		if($("#apprStateCD_emp").val()!="20"){
			alert("<fmt:message key="LTC02001B.msg3"/>");
			return;
		}
		
		if($("#commt").val()==""){
			alert("<fmt:message key="LTC02001B.msg4"/>");
			$("#commt").focus();
			return;
		}
		
		if(!confirm("<fmt:message key="LTC02001B.msg5"/>")){
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ltc02/rejectSupport");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("supportID", $("#supportID").val());
		table.setParameter("lastApprYN", $("#lastApprYN").val());
		table.setParameter("levelNo", $("#levelNo").val());
		table.setParameter("commt", $("#commt").val());
		table.setParameter("apprStateCD", $("#apprStateCD").val());
		table.request();
		
		if(table.getData(0,0) == "S") {
			//top.appCountFun();
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}

	/*****************************************************
	*	define grid_rlt / data formats define
	*****************************************************/
	var columns_prd = [
		"<fmt:message key="LTC02001B.kindTpCD5"/>"
		, "<fmt:message key="LTC02001B.prdNm"/>"
		, "<fmt:message key="LTC02001B.factoryPrice"/>"
		, "<fmt:message key="LTC02001B.qtyUnitCD"/>"
		, "<fmt:message key="LTC02001B.threeMonthAvgQty"/>"
		, "<fmt:message key="LTC02001B.enterQty"/>"
		, "<fmt:message key="LTC02001B.enterUnitAmt"/>"
		, "<fmt:message key="LTC02001B.contractAmt"/>"
		, "<fmt:message key="LTC02001B.NSV"/>"
		, "<fmt:message key="LTC02001B.GP"/>"
		, "<fmt:message key="LTC02001B.GPRate"/>"
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
	                        str, str, num, str, num
	                        , num, num, num, num, num
	                        , num, num, str]);
	    grid_prd.setCellEditable(false);
	    
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
			if (col == _col_prd.enterQty || col == _col_prd.enterUnitAmt) {
				this.setCellText(unformatNum(text), col, row);
			}
		};
		
		grid_prd.onCellValidating = function(text, col, row) {
			if (col == _col_prd.enterQty) {
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
			else if(col == _col_prd.enterUnitAmt) {
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
	    	if (col == _col_prd.enterQty) {
	    		this.setCellText(formatNum(unformat(text)), col, row);
	    		calculatePayAmt(row);
	    		calculateTContractQty();
	    	}
	    	else if(col == _col_prd.enterUnitAmt) {
	    		this.setCellText(formatNum(unformat(text)), col, row);
	    		calculatePayAmt(row);
	    		calculateTContractAmt();
	    	}
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
    }
	
</script>