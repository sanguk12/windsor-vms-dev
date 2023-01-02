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
											<col style="width:150px;"></col>
											<col style="width:150px;"></col>
											<col style="width:100px;"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="LTC01001B.supportID" />
												</td>
												<td class="td-cond-required" colspan="2">
													<fmt:message key="LTC01001B.venue" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="LTC01001B.contractDate" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC01001B.contractMonthCt" />
												</td>
												<td class="td-cond" colspan="2">
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
													<!-- plan등록 고려하여 calendar에서 년월(yyyymm)로 변경 -->
													<nis:selectbox id="yearCD" name="yearCD" defaultText="none" category="YEARCD" event="onchange" eventproc="calculateContractDate();"/>
													<nis:selectbox id="monthCD" name="monthCD" defaultText="none" category="MONTHCD" event="onchange" eventproc="calculateContractDate();"/>
													<!-- <nis:calendar id="contractDateFrom" callback="calculateContractDate();" cssClass="input-readonly" readOnly="yes" /> - 
													<input type="text" id="contractDateTo" name="contractDateTo" style="width:80px;" class="input-readonly" readOnly/> -->
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="contractMonthCt" name="contractMonthCt" defaultText="none" category="CONTRACTMONTHCT" event="onchange" eventproc="calculateContractDate();"/>
												</td>
												<td class="td-input-rborder" colspan="2">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="LTC01001B.minContractQty" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="LTC01001B.targetRate" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="LTC01001B.addPayRate" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC01001B.threeMonthAvgQty"/>
												</td>
												<td class="td-cond">
													<fmt:message key="LTC01001B.tcontractQty"/>
												</td>
												<td class="td-cond" colspan="2">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="minContractQty" name="minContractQty" style="width:120px; ime-mode:disabled; text-align:right;" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="targetRate" name="targetRate" style="width:120px; ime-mode:disabled; text-align:right;" maxlength="3"/>
												</td>
												<td class="td-input-rborder">
													<input type="text" id="addPayRate" name="addPayRate" style="width:120px; ime-mode:disabled; text-align:right;" maxlength="3"/>
												</td>
												<td class="td-input-rborder">
													<input type="text" id="threeMonthAvgTQty" name="threeMonthAvgTQty" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="tcontractQty" name="tcontractQty" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder" colspan="2">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="LTC01001B.tcontractAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC01001B.exPayAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC01001B.tpayAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC01001B.gsvRate" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC01001B.threeMonthAvgRate" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC01001B.apprStateCD" />
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
													<nis:selectbox id="apprStateCD" name="apprStateCD" defaultText="none" category="LTCSTATECD" enable="false" cssClass="input-readonly" />
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
					                            	<fmt:message key="LTC01001B.detailContent" />
					                            </td>
					                            <td style="text-align:right;">
					                            	<script type="text/javascript">
						                   				var updatePlanPopup = new AW.UI.Button;
						                   				updatePlanPopup.setControlText("<fmt:message key="LTC01001B.updatePlanBtn" />");
						                   				updatePlanPopup.setControlImage("update");
						                   				updatePlanPopup.setId("updatePlanPopupBtn");
					                   					document.write(updatePlanPopup);
								                      
								                      	updatePlanPopup.onControlClicked = function(event) {		
								                      		if($("#contractMonthCt").val()==3){
								                      			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=LTC01001C"
								                      					+ "&supportID=" + $("#supportID").val();
								                      			newWindow(url, "LTC01001C",1200,600,"yes");
								                      		}else{
								                      			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=LTC01001D"
							                      					+ "&supportID=" + $("#supportID").val();
							                      				newWindow(url, "LTC01001D",1150,800,"yes");
								                      		}
								                      	};
							                   		</script>
							                   		<!-- 
					                   				<script type="text/javascript">
						                   				var productCartPopup = new AW.UI.Button;
								                      	productCartPopup.setControlText("<fmt:message key="button.ProductCart" />");
								                      	productCartPopup.setControlImage("addRow");
								                      	productCartPopup.setId("productCartPopupBtn");
								                      	document.write(productCartPopup);
								                      
								                      	productCartPopup.onControlClicked = function(event) {		
								                      		if($("#selectVenueCD").val() == "") {
								                      			alert("<fmt:message key="LTC01001B.msg1" />");
								                      			return;
								                      		}
								                      		openProductCartPopupForLTC("closeProductCartPopup",$("#selectVenueCD").val());
								                      	};
							                   		</script>
							                   		 -->
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
						<!-- plan등록 고려하여 calendar에서 년월(yyyymm)로 변경 -->
						<input type="hidden" id="contractDateFrom" name="contractDateFrom" />
						<input type="hidden" id="contractDateTo" name="contractDateTo" />
						<input type="hidden" id="contractValidateFlag" name="contractValidateFlag" />
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
    #grid_prd .aw-column-11 {width: 50px; text-align:center;}

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
	 $(function() {
			try{$("#minContractQty").numeric();}catch(e){}
			try{$("#targetRate").numeric();}catch(e){}
		 	try{$("#addPayRate").numeric();}catch(e){}
		});
	$(document).ready(function() {

		window.onload = function() {
			createGrid_prd();
			grid_prd.refresh();
			updatePlanPopup.setControlDisabled(true);
		};

		${initScript}
		
		$("#venue_popup").click(function(){
			openMyVenuePopup("closeMyVenuePopup");
		});
		$("#venue").keypress(function(){
			if (event.keyCode==13){
				getMyVenueName("venue", "venueCD", "venueNm", "${params.territoryCD}");
			}
		});
		
		$("#addPayRate").blur(function(){
			calculateExPayAmt();
		});
		
		$("#addPayRate").change(function(){
			calculateExPayAmt();
		});
		$("#contractMonthCt").change(function(){
			calculateExPayAmt();
		});
	});
	
	function closeMyVenuePopup(data) {
		$("#venue").val(data.venueCD);
		$("#venueCD").val(data.venueCD);
        $("#venueNm").val(data.venueNm);
        $("#selectVenueCD").val(data.venueCD);
        $("#threeMonthAvgTQty").val("0");
		$("#tcontractQty").val("0");
		$("#tcontractAmt").val("0");
		$("#tpayAmt").val("0");
		$("#gsvRate").val("0");
		$("#threeMonthAvgRate").val("0");
        createGrid_prd();
		grid_prd.refresh();
        setThreeMonthAvgTQty();
        if(data.venueCD!=""){
        	Search_newPrd(data.venueCD);
        }
        contractValidateCheck(data.venueCD,$("#contractDateFrom").val(),$("#contractDateTo").val());
	}
	
	function New() {
		$("#supportID").val("");
		$("#venue").val("");
		$("#venueCD").val("");
		$("#venueNm").val("");
		$("#yearCD").val("${params.clientDate}".substring(0,4));
		$("#monthCD").val("${params.clientDate}".substring(4,6));
		//$("#contractDateFrom").val("${params.currentDate}");
		//$("#contractDateTo").val(calculateDate("${params.currentDate}","3"));
		$("#contractMonthCt").val("3");
		$("#minContractQty").val("30");
		$("#targetRate").val("70");
		$("#addPayRate").val("0");
		$("#threeMonthAvgTQty").val("0");
		$("#tcontractQty").val("0");
		$("#tcontractAmt").val("0");
		$("#exPayAmt").val("0");
		$("#tpayAmt").val("0");
		$("#gsvRate").val("0");
		$("#threeMonthAvgRate").val("0");
		$("#apprStateCD").val("10");
		$("#contractValidateFlag").val("N");
		$("#venue").attr("readonly", false);
		$("#venue").removeClass("input-readonly");
		$("#venue_popup").show();
		//$("#updatePlanPopupBtn").attr("disabled", true);
		updatePlanPopup.setControlDisabled(true);
		$("#yearCD").attr("disabled", false);
		$("#yearCD").removeClass("input-readonly");
		$("#monthCD").attr("disabled", false);
		$("#monthCD").removeClass("input-readonly");
		$("#contractMonthCt").attr("disabled", false);
		$("#contractMonthCt").removeClass("input-readonly");
		$("#minContractQty").attr("readonly", false);
		$("#minContractQty").removeClass("input-readonly");
		$("#targetRate").attr("readonly", false);
		$("#targetRate").removeClass("input-readonly");
		$("#addPayRate").attr("readonly", false);
		$("#addPayRate").removeClass("input-readonly");
		//$("#productCartPopupBtn").show();
		createGrid_prd();
		grid_prd.refresh();
		calculateContractDate();
		Search_newPrd();
	}

	//날짜계산
	function calculateDate(yearCD, monthCD, m){
		var yyyy = parseInt(yearCD);
		var mm = parseInt(monthCD,"10")+parseInt(m)-1;
		
		if(mm>12){
			yearCD=(yyyy+1).toString();
			monthCD=(mm-12).toString();
		}else{
			yearCD=yyyy.toString();
			monthCD=mm.toString();
		}
		
		if (monthCD.length < 2){monthCD = '0' + monthCD;} 
		
		return yearCD+monthCD;
	}
	//약정기간 계산
	function calculateContractDate() {
		var yearCD = $("#yearCD").val();
		var monthCD = $("#monthCD").val();
		$("#contractDateFrom").val(yearCD+monthCD);
		$("#contractDateTo").val(calculateDate(yearCD,monthCD,$("#contractMonthCt").val()));
		if($("#selectVenueCD").val()!=""){
			setThreeMonthAvgTQty();
			contractValidateCheck($("#selectVenueCD").val(),$("#contractDateFrom").val(),$("#contractDateTo").val());
		}
	}
	
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
			tcontractQty += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.enterQty, i)));
		}
		$("#tcontractQty").val(formatNum(tcontractQty));
		
		calculateThreeMonthAvgRate();
	}
	
	//지급액 계산
	function calculateTContractAmt() {
		var tcontractAmt = 0;
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			tcontractAmt += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.contractAmt, i)));
		}
		$("#tcontractAmt").val(formatNum(tcontractAmt));
		calculateGsvRate();	
		calculateExPayAmt();
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
	  	table.setURL("${contextPath}/service/simpleAction/LTC0100107S");
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
	function contractValidateCheck(venueCD,dateFrom,dateTo){
		if(venueCD==""){
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/LTC0100109S");
		table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","contractValidateFlag;");
	  	table.setParameter("format", "str;");
	  	table.setParameter("venueCD", venueCD);
	  	table.setParameter("dateFrom", dateFrom);
	  	table.setParameter("dateTo", dateTo);
	  	table.request();
	  	
	  	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#contractValidateFlag").val(table.getData(0,0));
      		if(table.getData(0,0)!="Y"){
      			alert("<fmt:message key="LTC01001B.msg10"/>");
      		}
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
		$("#contractValidateFlag").val("Y");
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
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0100102S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"supportID;venueCD;venueNm;contractDateFrom;contractDateTo;"+
	  			"contractMonthCt;minContractQty;targetRate;addPayRate;threeMonthAvgTQty;"+
	  			"tcontractQty;tcontractAmt;tpayAmt;gsvRate;threeMonthAvgRate;"+
	  			"apprStateCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"num;num;num;num;num;"+
	  			"num;num;num;num;num;"+
	  			"str;");
	  	table.setParameter("supportID", parent.$("#selectSupportID").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#supportID").val(table.getData(_col_dtl.supportID, 0));
      		$("#venue").val(table.getData(_col_dtl.venueCD, 0));
      		$("#venueCD").val(table.getData(_col_dtl.venueCD, 0));
      		$("#venueNm").val(table.getData(_col_dtl.venueNm, 0));
      		$("#yearCD").val(table.getData(_col_dtl.contractDateFrom, 0).substring(0,4));
      		$("#monthCD").val(table.getData(_col_dtl.contractDateFrom, 0).substring(4,6));
      		$("#contractDateFrom").val(table.getData(_col_dtl.contractDateFrom, 0));
      		$("#contractDateTo").val(table.getData(_col_dtl.contractDateTo, 0));
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
      		
      		$("#venue").attr("readonly", true);
    		$("#venue").addClass("input-readonly");
      		$("#venue_popup").hide();
      		
      		if($("#apprStateCD").val()!="10"&&$("#apprStateCD").val()!="40"){
      			$("#yearCD").attr("disabled", true);
    			$("#yearCD").addClass("input-readonly");
    			$("#monthCD").attr("disabled", true);
    			$("#monthCD").addClass("input-readonly");
    			$("#contractMonthCt").attr("disabled", true);
    			$("#contractMonthCt").addClass("input-readonly");
      			$("#minContractQty").attr("readonly", true);
    			$("#minContractQty").addClass("input-readonly");
      			$("#targetRate").attr("readonly", true);
    			$("#targetRate").addClass("input-readonly");
      			$("#addPayRate").attr("readonly", true);
    			$("#addPayRate").addClass("input-readonly");
      		}else{
      			$("#yearCD").attr("disabled", false);
    			$("#yearCD").removeClass("input-readonly");
    			$("#monthCD").attr("disabled", false);
    			$("#monthCD").removeClass("input-readonly");
    			$("#contractMonthCt").attr("disabled", false);
    			$("#contractMonthCt").removeClass("input-readonly");
      			$("#minContractQty").attr("readonly", false);
    			$("#minContractQty").removeClass("input-readonly");
      			$("#targetRate").attr("readonly", false);
    			$("#targetRate").removeClass("input-readonly");
      			$("#addPayRate").attr("readonly", false);
    			$("#addPayRate").removeClass("input-readonly");
      		}
      		if($("#apprStateCD").val()!="50"){
      			//$("#updatePlanPopupBtn").attr("diabled", true);
      			updatePlanPopup.setControlDisabled(true);
          	}else{
          		//$("#updatePlanPopupBtn").attr("diabled", false);
          		updatePlanPopup.setControlDisabled(false);
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
	  	table.setURL("${contextPath}/service/simpleAction/LTC0100103S");
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
      		if($("#apprStateCD").val()!="10"&&$("#apprStateCD").val()!="40"){
      			grid_prd.setCellEditable(false, _col_prd.enterQty);
      			grid_prd.setCellEditable(false, _col_prd.enterUnitAmt);
      			grid_prd.getCellTemplate(_col_prd.enterQty).setStyle("background", "#ececec");
				grid_prd.getCellTemplate(_col_prd.enterUnitAmt).setStyle("background", "#ececec");
      		}else{
      			grid_prd.setCellEditable(true, _col_prd.enterQty);
      			grid_prd.setCellEditable(true, _col_prd.enterUnitAmt);
      			grid_prd.getCellTemplate(_col_prd.enterQty).setStyle("background", "");
				grid_prd.getCellTemplate(_col_prd.enterUnitAmt).setStyle("background", "");
      		}
      	}
      	grid_prd.refresh();
      	
	}
	
	function Search_newPrd(venueCD) {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0100110S");
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
	  	table.setParameter("venueCD", venueCD);
	  	table.request();
      	
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
					, "0"
					, "0"
					, "0"
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
	    			calculateTContractQty();
      			}
      		}
      	}
      	grid_prd.refresh();
      	
	}
	
	function Save() {
		if($("#apprStateCD").val()!="10" && $("#apprStateCD").val()!="40"){
			alert("<fmt:message key="LTC01001B.msg3"/>");
			return;
		}
		if($("#venueCD").val()=="") {
			alert("<fmt:message key="LTC01001B.msg1"/>");
			$("#venueCD").focus();
			return;
		}
		if($("#contractDateFrom").val()=="") {
			alert("<fmt:message key="LTC01001B.msg2"/>");
			$("#contractDateFrom").focus();
			return;
		}
		if($("#contractValidateFlag").val()=="N") {
			alert("<fmt:message key="LTC01001B.msg10"/>");
			return;
		}
		if($("#minContractQty").val()=="") {
			alert("<fmt:message key="LTC01001B.msg4"/>");
			$("#minContractQty").focus();
			return;
		}
		if($("#targetRate").val()=="") {
			alert("<fmt:message key="LTC01001B.msg5"/>");
			$("#targetRate").focus();
			return;
		}
		if($("#addPayRate").val()=="") {
			alert("<fmt:message key="LTC01001B.msg6"/>");
			$("#addPayRate").focus();
			return;
		}
		
		var prdCDs = new Array();
		var factoryPrices = new Array();
		var threeMonthAvgQtys = new Array();
		var enterQtys = new Array();
		var enterUnitAmts = new Array();
		var contractAmts = new Array();
		for (var i=0; i<grid_prd.getRowCount(); i++) {
			prdCDs[i] = grid_prd.getCellText(_col_prd.prdCD, i);
			factoryPrices[i] = grid_prd.getCellText(_col_prd.factoryPrice, i);
			threeMonthAvgQtys[i] = grid_prd.getCellText(_col_prd.threeMonthAvgQty, i);
			enterQtys[i] = grid_prd.getCellText(_col_prd.enterQty, i);
			enterUnitAmts[i] = grid_prd.getCellText(_col_prd.enterUnitAmt, i);
			contractAmts[i] = grid_prd.getCellText(_col_prd.contractAmt, i);
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ltc01/saveSupport");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("supportID", parent.$("#selectSupportID").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("contractDateFrom", $("#contractDateFrom").val());
		table.setParameter("contractDateTo", $("#contractDateTo").val());
		table.setParameter("contractMonthCt", $("#contractMonthCt").val());
		table.setParameter("minContractQty", $("#minContractQty").val());
		table.setParameter("targetRate", $("#targetRate").val());
		table.setParameter("addPayRate", $("#addPayRate").val());
		table.setParameter("threeMonthAvgTQty", $("#threeMonthAvgTQty").val());
		table.setParameter("tcontractQty", $("#tcontractQty").val());
		table.setParameter("tcontractAmt", $("#tcontractAmt").val());
		table.setParameter("tpayAmt", $("#tpayAmt").val());
		table.setParameter("gsvRate", $("#gsvRate").val());
		table.setParameter("threeMonthAvgRate", $("#threeMonthAvgRate").val());
		table.setParameter("apprStateCD", "10");
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("factoryPrices", factoryPrices);
		table.setParameter("threeMonthAvgQtys", threeMonthAvgQtys);
		table.setParameter("enterQtys", enterQtys);
		table.setParameter("enterUnitAmts", enterUnitAmts);
		table.setParameter("contractAmts", contractAmts);
		table.request();
		
		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			parent.$("#selectSupportID").val(table.getData(3,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Delete() {
		if($("#apprStateCD").val()!="10" && $("#apprStateCD").val()!="40"){
			alert("<fmt:message key="LTC01001B.msg9"/>");
			return;
		}
		if(!confirm("<fmt:message key="confirm.delete"/>")){
       		return;
       	}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ltc01/deleteSupport");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("supportID", parent.$("#selectSupportID").val());
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			List();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function List() {
		$("#selectVenueCD").val("");
		parent.Search();
		parent.appletClose();
	}

	/*****************************************************
	*	define grid_rlt / data formats define
	*****************************************************/
	var columns_prd = [
		"<fmt:message key="LTC01001B.kindTpCD5"/>"
		, "<fmt:message key="LTC01001B.prdNm"/>"
		, "<fmt:message key="LTC01001B.factoryPrice"/>"
		, "<fmt:message key="LTC01001B.qtyUnitCD"/>"
		, "<fmt:message key="LTC01001B.threeMonthAvgQty"/>"
		, "<fmt:message key="LTC01001B.enterQty"/>"
		, "<fmt:message key="LTC01001B.enterUnitAmt"/>"
		, "<fmt:message key="LTC01001B.contractAmt"/>"
		, "<fmt:message key="LTC01001B.NSV"/>"
		, "<fmt:message key="LTC01001B.GP"/>"
		, "<fmt:message key="LTC01001B.GPRate"/>"
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
	                        , num, str, num, num, num
	                        , num]);
	    grid_prd.setCellEditable(true);
	    grid_prd.setCellEditable(false, _col_prd.kindTpCD5Name);
	    grid_prd.setCellEditable(false, _col_prd.prdNm);
	    grid_prd.setCellEditable(false, _col_prd.factoryPrice);
	    grid_prd.setCellEditable(false, _col_prd.qtyUnitCDName);
	    grid_prd.setCellEditable(false, _col_prd.threeMonthAvgQty);
	    grid_prd.setCellEditable(false, _col_prd.contractAmt);
	    grid_prd.setCellEditable(false, _col_prd.nsv);
	    grid_prd.setCellEditable(false, _col_prd.gp);
	    grid_prd.setCellEditable(false, _col_prd.gpRate);
	    
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