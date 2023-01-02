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
											<col style="width:130px;"></col>
											<col style="width:150px;"></col>
											<!-- <col style="width:100px;"></col> -->
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="MIL01001B.mileageID" />
												</td>
												<td class="td-cond-required" colspan="2">
													<fmt:message key="MIL01001B.venue" />
												</td>
												<td class="td-cond-required" colspan="2">
													<fmt:message key="MIL01001B.contractDate" />
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.contractMonthCt" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="mileageID" name="mileageID" style="width:120px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder" colspan="2">
													<nis:popup id="venue" nameID="venueNm" keyID="venueCD" style="width:100px;" />
												</td>
												<td class="td-input-rborder" colspan="2">
													<!-- 
													<nis:calendar id="contractDateFrom" cssClass="input-readonly" readOnly="yes" callback="calculateContractMonth();" /> - 
													<nis:calendar id="contractDateTo" cssClass="input-readonly" readOnly="yes" callback="calculateContractMonth();" />
													 -->
													<!-- 
													<nis:calendar id="contractDateFrom" callback="calculateContractMonth();" /> - 
													<nis:calendar id="contractDateTo" callback="calculateContractMonth();" />
													-->
													<nis:selectbox id="yearCDFrom" name="yearCDFrom" defaultText="none" category="YEARCD" event="onchange" eventproc="calculateContractMonth();"/>
													<nis:selectbox id="monthCDFrom" name="monthCDFrom" defaultText="none" category="MONTHCD"  event="onchange" eventproc="calculateContractMonth();"/> - 
													<nis:selectbox id="yearCDTo" name="yearCDTo" defaultText="none" category="YEARCD"  event="onchange" eventproc="calculateContractMonth();"/>
													<nis:selectbox id="monthCDTo" name="monthCDTo" defaultText="none" category="MONTHCD"  event="onchange" eventproc="calculateContractMonth();"/>
												</td>
												<td class="td-input-rborder">
													<input type="text" id="contractMonthCt" name="contractMonthCt" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<!-- 
												<td class="td-cond">
													<fmt:message key="MIL01001B.apAmt" />
												</td>
												 -->
												<td class="td-cond">
													<fmt:message key="MIL01001B.msTargetRate" />
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.tcontractQty" />
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.gsvAmt"/>
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.gsvRate"/>
												</td>
												<td class="td-cond-required" colspan="2">
													<fmt:message key="MIL01001B.payRequestDate" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<!-- 
												<td class="td-input-rborder">
													<input type="text" id="apAmt" name="apAmt" style="width:120px; ime-mode:disabled; text-align:right;" maxlength="13" />
												</td>
												 -->
												<td class="td-input-rborder">
													<input type="text" id="msTargetRate" name="msTargetRate" style="width:120px; ime-mode:disabled; text-align:right;" maxlength="3" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="tcontractQty" name="tcontractQty" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="gsvAmt" name="gsvAmt" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="gsvRate" name="gsvRate" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder" colspan="2">
													<!--
													<nis:calendar id="payRequestDate" cssClass="input-readonly" readOnly="yes" />
													-->
													<nis:calendar id="payRequestDate"/>
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="MIL01001B.contractAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.contractTaxAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.addContractAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.addContractTaxAmt" />
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.mileageStateCD" />
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.mileagePayTPCD" />
												</td>
												<!-- 
												<td class="td-cond">
													<fmt:message key="MIL01001B.keyman" />
												</td>
												<td class="td-cond">
												</td>
												 -->
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="contractAmt" name="contractAmt" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="contractTaxAmt" name="contractTaxAmt" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly/>
												</td>
												<td class="td-input-rborder">
													<input type="text" id="addContractAmt" name="addContractAmt" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="addContractTaxAmt" name="addContractTaxAmt" style="width:120px; ime-mode:disabled; text-align:right;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="mileageStateCD" name="mileageStateCD" defaultText="none" category="MILEAGESTATECD" enable="false" cssClass="input-readonly" />
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="mileagePayTPCD" name="mileagePayTPCD" defaultText="none" category="MILEAGEPAYTPCD"/>
												</td>
												<input type="hidden" id="keymanAmt" name="keymanAmt" />
												<!-- 
												<td class="td-input-rborder">
													<span id="keyman_btn"></span>
													<input type="hidden" id="keymanAmt" name="keymanAmt" />
												</td>
												<td class="td-input-rborder">
												</td>
												-->
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond" colspan="6">
													<fmt:message key="MIL01002B.commt" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder" colspan="6">
													<input type="text" id="commt" name="commt" style="width:90%; text-align:left;" />
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
					                            	<fmt:message key="MIL01001B.detailContent" />
					                            </td>
					                            <td style="text-align:right;">
					                   				<script type="text/javascript">
						                   				var productCartPopup = new AW.UI.Button;
								                      	productCartPopup.setControlText("<fmt:message key="button.ProductCart" />");
								                      	productCartPopup.setControlImage("addRow");
								                      	document.write(productCartPopup);
								                      
								                      	productCartPopup.onControlClicked = function(event) {		                            
									                      	openProductCartPopup("closeProductCartPopup",$("#venueCD").val());
								                      	};
							                   		</script>
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
						<input type="hidden" id="payTpCD" name="payTpCD" value="ORG" />
						<input type="hidden" id="stipulationAmt" name="stipulationAmt"/>
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
    #grid_prd .aw-column-7 {width: 100px; text-align:right;}
    #grid_prd .aw-column-8 {width: 100px; text-align:right;}
    #grid_prd .aw-column-9 {width: 120px; text-align:right;}
    #grid_prd .aw-column-10 {width: 50px; text-align:center;}

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
		try{$("#payRate").numeric();}catch(e){}
		//try{$("#apAmt").numeric();}catch(e){}
	 	try{$("#msTargetRate").numeric();}catch(e){}
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid_prd();
			grid_prd.refresh();
			
		};

		${initScript}
		
		$("#venue_popup").click(function(){
			//openMyVenuePopup("closeMyVenuePopup");
			openVenuePopup("closeVenuePopup");
		});
		$("#venue").keypress(function(){
			if (event.keyCode==13){
				//getMyVenueName("venue", "venueCD", "venueNm", "${params.territoryCD}");
				getVenueName("venue", "venueCD", "venueNm", "${params.territoryCD}");
			}
		});
		
		/*
		$("#apAmt").blur(function(){
			$("#apAmt").val(formatNum($("#apAmt").val()));
		});	
		$("#apAmt").focus(function(){
			$("#apAmt").val(unformatNum($("#apAmt").val()));
		});
		*/
		$("#contractAmt").blur(function(){
			$("#contractAmt").val(formatNum($("#contractAmt").val()));
		});	
		$("#contractAmt").focus(function(){
			$("#contractAmt").val(unformatNum($("#contractAmt").val()));
		});

		$("#yearCDFrom").change(function(){
			calculateContractAmt();
			calculateTContractQty();
			calculateAddContractAmt();
			calculateGsvRate();
		});
		$("#monthCDFrom").change(function(){
			calculateContractAmt();
			calculateTContractQty();
			calculateAddContractAmt();
			calculateGsvRate();
		});
		$("#yearCDTo").change(function(){
			calculateContractAmt();
			calculateTContractQty();
			calculateAddContractAmt();
			calculateGsvRate();
		});
		$("#monthCDTo").change(function(){
			calculateContractAmt();
			calculateTContractQty();
			calculateAddContractAmt();
			calculateGsvRate();
		});

		//지급금액 수정시 차액과 지급금액 세후가 변경 2016.10.10
		$("#contractAmt").keyup(function(){
			var contractTaxAmt = 0;
			var contractAmt = unformatNum($("#contractAmt").val());
			var stipulationAmt = unformatNum($("#stipulationAmt").val());
			if(contractAmt==""){
				contractAmt = 0;
			}

			if(stipulationAmt-contractAmt < 0) {
				alert("<fmt:message key="MIL01001B.msg11"/>");
				$("#contractAmt").val($("#stipulationAmt").val());
				$("#diffAmt").val(formatNum(0));
				$("#contractAmt").focus();
				return;
			}

			contractTaxAmt = parseFloat(contractAmt)*(1+0.0352);
			$("#contractTaxAmt").val(formatNum(Math.round(contractTaxAmt)));
			$("#diffAmt").val(formatNum(stipulationAmt-contractAmt));
		});
	});
	
	function closeVenuePopup(data) {
		$("#venue").val(data.venueCD);
		$("#venueCD").val(data.venueCD);
        $("#venueNm").val(data.venueNm);
	}
	
	//계약기간 개월수(장기 단기준리시)
	/*
	function calculateContractMonth() {
		if($("#contractDateFrom").val()=="") {
			return;
		}
		if($("#contractDateTo").val()=="") {
			return;
		}
		if(Number(unformat($("#contractDateFrom").val())) > Number(unformat($("#contractDateTo").val()))) {
			alert("<fmt:message key="MIL01001B.msg1"/>");
			$("#contractDateTo").val($("#contractDateFrom").val());
			$("#contractMonthCt").val("0");
			$("#contractDateTo").focus();
			return;
		}
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/COM03010S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("startDate", unformat($("#contractDateFrom").val()));
	  	table.setParameter("endDate", unformat($("#contractDateTo").val()));
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		if(table.getData(0,0)<3){
      			alert("<fmt:message key="MIL01001B.msg9" />");
      			$("#contractDateTo").val("");
    			$("#contractMonthCt").val("0");
    			$("#contractDateTo").focus();
      		}
      		else{
      			$("#contractMonthCt").val(table.getData(0,0));
      		}
      	}
      	else {
      		alert("<fmt:message key="MIL01001B.msg8" />");
      		$("#contractMonthCt").val("");
      	}
	}
	*/

	//계약기간 개월수(원본)
	function calculateContractMonth() {
		/*if($("#contractDateFrom").val()=="") {
			return;
		}
		if($("#contractDateTo").val()=="") {
			return;
		}*/
		/*if(Number(unformat($("#contractDateFrom").val())) > Number(unformat($("#contractDateTo").val()))) {
			alert("<fmt:message key="MIL01001B.msg1"/>");
			$("#contractDateTo").val($("#contractDateFrom").val());
			$("#contractMonthCt").val("0");
			$("#contractDateTo").focus();
			return;
		}*/
		if(Number($("#yearCDFrom").val()+$("#monthCDFrom").val()) > Number($("#yearCDTo").val()+$("#monthCDTo").val())) {
			alert("<fmt:message key="MIL01001B.msg1"/>");
			$("#yearCDTo").val($("#yearCDFrom").val());
			$("#monthCDTo").val($("#monthCDFrom").val());
			$("#contractMonthCt").val("1");
			$("#yearCDTo").focus();
			return;
		}
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/COM0301001S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("startMonth",$("#yearCDFrom").val()+$("#monthCDFrom").val());
	  	table.setParameter("endMonth", $("#yearCDTo").val()+$("#monthCDTo").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#contractMonthCt").val(table.getData(0,0));
      	}
      	else {
      		alert("<fmt:message key="MIL01001B.msg8" />");
      		$("#contractMonthCt").val("");
      	}
	}
	
	var keyman_btn = new AW.UI.Button;
	keyman_btn.setId("keyman_btn");
	keyman_btn.setControlText("<fmt:message key="button.keymanReg" />");
	keyman_btn.refresh();
	
	keyman_btn.onControlClicked = function(event) {
		if($("#selectMileageID").val() != "") {
			var contractAmt = unformat($("#addContractAmt").val());
			var venueCD = $("#venueCD").val();
			var mileageID = parent.$("#selectMileageID").val();
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MIL01001C&contractAmt="+contractAmt+"&venueCD="+venueCD+"&mileageID="+mileageID;
			newWindow(url, "MIL01001C",700,550,"yes");
		}
	}
	
	function New() {
		maxRow_prd = 0;
		$("#mileageID").val("");
		$("#venue").val("");
		$("#venueCD").val("");
		$("#venueNm").val("");
		//$("#contractDateFrom").val("");
		//$("#contractDateTo").val("");
		$("#yearCDFrom").val("${params.clientDate}".substring(0,4));
		$("#monthCDFrom").val("${params.clientDate}".substring(4,6));
		$("#yearCDTo").val("${params.clientDate}".substring(0,4));
		$("#monthCDTo").val("${params.clientDate}".substring(4,6));
		$("#contractMonthCt").val("1");
		//$("#apAmt").val("0");
		$("#msTargetRate").val("0");
		$("#tcontractQty").val("0");
		$("#gsvAmt").val("0");
		$("#gsvRate").val("0");
		$("#contractAmt").val("0");
		$("#contractTaxAmt").val("0");
		$("#addContractAmt").val("0");
		$("#addContractTaxAmt").val("0");
		$("#stipulationAmt").val("0");
		$("#diffAmt").val("0");
		$("#payRequestDate").val("");
		$("#mileageStateCD").val("10");
		$("#mileagePayTPCD").val("10");
		$("#commt").val("");
		
		$("#venue").attr("readonly", false);
		$("#venue").removeClass("input-readonly");
		$("#venue_popup").show();
		$("#keyman_btn").hide();
		createGrid_prd();
		grid_prd.refresh();
	}
	
	function closeProductCartPopup(data) {
		//중복되는 것 체크
    	var count=0;
    	for(var i=0; i<maxRow_prd; i++) {
    		if(grid_prd.getCellText(_col_prd.activeFlg,i)!="D") {
   				if(grid_prd.getCellText(_col_prd.prdCD, i) == data.prdCD) {
           			count++;
           		}
    		}
    	}
    	if(count==0) {
    		grid_prd.addRow(maxRow_prd++);
            grid_prd.setCellText(data.kindTpCD5Name, _col_prd.kindTpCD5Name, maxRow_prd-1);
            grid_prd.setCellText(data.prdNm, _col_prd.prdNm, maxRow_prd-1);
            grid_prd.setCellText(data.factoryPrice, _col_prd.factoryPrice, maxRow_prd-1);
            grid_prd.setCellText(data.qtyUnitCDName, _col_prd.qtyUnitCDName, maxRow_prd-1);
            grid_prd.setCellText("0", _col_prd.contractQty, maxRow_prd-1);
            grid_prd.setCellText("0", _col_prd.enterQty, maxRow_prd-1);
            grid_prd.setCellText("0", _col_prd.enterUnitAmt, maxRow_prd-1);
            grid_prd.setCellText("0", _col_prd.payAmt, maxRow_prd-1);
            grid_prd.setCellText("0", _col_prd.addEnterUnitAmt, maxRow_prd-1);
            grid_prd.setCellText("0", _col_prd.addPayAmt, maxRow_prd-1);
            grid_prd.setCellText(data.prdCD, _col_prd.prdCD, maxRow_prd-1);
            grid_prd.setCellText(data.eu, _col_prd.eu, maxRow_prd-1);
            grid_prd.setCellText("I", _col_prd.activeFlg, maxRow_prd-1);
            grid_prd.refresh();
            
            calculatePayAmt(maxRow_prd-1);
			calculateContractQty(maxRow_prd-1);
    	}
    }
	
	function CloseKeymanPopup() {
		var contractAmt = 0;
		var contractTaxAmt = 0;
		contractAmt = unformatNum($("#contractAmt").val());
		contractTaxAmt = unformatNum($("#contractTaxAmt").val());
		Search_dtl();
		
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
				calculatePayAmt(i);
				calculateContractQty(i);
				calculateAddPayAmt(i);
				calculateAddContractAmt(i);
			}
		}
		$("#contractAmt").val(formatNum(contractAmt));
		$("#contractTaxAmt").val(formatNum(contractTaxAmt));
	}
	
	function removeRow(row) {
		grid_prd.deleteRow(row);
		grid_prd.setCellText("D",_col_prd.activeFlg,row);
		calculatePayAmt(row);
		calculateContractQty(row);
		calculateAddPayAmt(row);
		calculateAddContractAmt(row);
    }
	
	//지급금액 계산
	function calculatePayAmt(row) {
		if(grid_prd.getCellText(_col_prd.enterQty, row)=="") {
			return;
		}
		if(grid_prd.getCellText(_col_prd.enterUnitAmt, row)=="") {
			return;
		}
		var enterQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.enterQty, row)));
		var enterUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.enterUnitAmt, row)));
		var payAmt = 0;
		payAmt = enterQty * enterUnitAmt;
		grid_prd.setCellText(formatNum(payAmt), _col_prd.payAmt, row);
		
		calculateContractAmt();
	}
	
	//지급금액합, 지급금액(세후)합 계산
	function calculateContractAmt() {
		var contractAmt = 0;
		var contractTaxAmt = 0;
		var contractMonthCt = parseFloat($("#contractMonthCt").val());
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
				contractAmt += parseFloat(unformat(grid_prd.getCellText(_col_prd.payAmt, i)));
			}
		}
		$("#contractAmt").val(formatNum(contractAmt*contractMonthCt));
		//약정금액과 지급금액을 같은값으로 저장함 나중에 지그금액은 수정할수잇또록 열어둠 2016.10.10
		$("#stipulationAmt").val(formatNum(contractAmt*contractMonthCt));
		//$("#diffAmt").val(0);
		contractTaxAmt = parseFloat(contractAmt)*(1+0.0352);
		$("#contractTaxAmt").val(formatNum(Math.round(contractTaxAmt*contractMonthCt)));
		
		calculateGsvAmt();
	}

	//지급금액 계산
	function calculateAddPayAmt(row) {
		if(grid_prd.getCellText(_col_prd.enterQty, row)=="") {
			return;
		}
		if(grid_prd.getCellText(_col_prd.addEnterUnitAmt, row)=="") {
			return;
		}
		var enterQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.enterQty, row)));
		var addEnterUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.addEnterUnitAmt, row)));
		var addPayAmt = 0;
		addPayAmt = enterQty * addEnterUnitAmt;
		grid_prd.setCellText(formatNum(addPayAmt), _col_prd.addPayAmt, row);
		
		calculateAddContractAmt();
	}
	
	//지급금액합, 지급금액(세후)합 계산
	function calculateAddContractAmt() {
		var addContractAmt = 0;
		var addContractTaxAmt = 0;
		var contractMonthCt = parseFloat($("#contractMonthCt").val());
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
				addContractAmt += parseFloat(unformat(grid_prd.getCellText(_col_prd.addPayAmt, i)));
			}
		}
		$("#addContractAmt").val(formatNum(addContractAmt*contractMonthCt));
		addContractTaxAmt = parseFloat(addContractAmt)*(1+0.0352);
		$("#addContractTaxAmt").val(formatNum(Math.round(addContractTaxAmt*contractMonthCt)));
	}

	//약정량(EU) 계산
	function calculateContractQty(row) {
		if(grid_prd.getCellText(_col_prd.enterQty, row)=="") {
			return;
		}
		if(grid_prd.getCellText(_col_prd.eu, row)=="") {
			return;
		}
		var enterQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.enterQty, row)));
		var eu = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.eu, row)));
		var contractQty = 0;
		
		
// 		contractQty = Math.round(enterQty * eu);
		contractQty = Math.round(enterQty * eu * 100000)/100000;
		
		grid_prd.setCellText(formatNum(contractQty), _col_prd.contractQty, row);
		
		calculateTContractQty();
	}
	
	//약정량(EU)합 계산
	function calculateTContractQty() {
		var tcontractQty = 0;
		var contractMonthCt = parseFloat($("#contractMonthCt").val());
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
// 				tcontractQty += parseFloat(unformat(grid_prd.getCellText(_col_prd.contractQty, i)));
				tcontractQty += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.contractQty, i)));
			}
		}
		
		$("#tcontractQty").val(formatNum(Math.round(tcontractQty * contractMonthCt * 100000)/100000));
	}
	
	//GSV(원) 계산
	function calculateGsvAmt() {
		var gsvAmt = 0;
		var enterQty = 0;
		var factoryPrice = 0;
		var enterQty_factoryPrice = 0;
		var contractMonthCt = parseFloat($("#contractMonthCt").val());
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
				enterQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.enterQty, i)));
				factoryPrice = parseFloat(unformat(grid_prd.getCellText(_col_prd.factoryPrice, i)));
				enterQty_factoryPrice += enterQty * factoryPrice;
			}
		}
		$("#gsvAmt").val(formatNum(enterQty_factoryPrice*contractMonthCt));
		
		calculateGsvRate();
	}
	
	//vs GSV 계산
	function calculateGsvRate() {
		var gsvRate = 0;
		var contractAmt = parseFloat(unformat($("#contractAmt").val()));
		var gsvAmt = parseFloat(unformat($("#gsvAmt").val()));
		if(gsvAmt != 0) {
			gsvRate = ((contractAmt*(1+0.0352)) / gsvAmt) * 100;
			$("#gsvRate").val(Math.round(gsvRate));
		}
		else {
			$("#gsvRate").val("0");
		}
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
		mileageID : _i_dtl++
		, venueCD : _i_dtl++
		, venueNm : _i_dtl++
		, contractDateFrom : _i_dtl++
		, contractDateTo : _i_dtl++
		, contractMonthCt : _i_dtl++
		, apAmt : _i_dtl++
		, msTargetRate : _i_dtl++
		, tcontractQty : _i_dtl++
		, gsvAmt : _i_dtl++
		, gsvRate : _i_dtl++
		, stipulationAmt : _i_dtl++
		, contractAmt : _i_dtl++
		, contractTaxAmt : _i_dtl++
		, addContractAmt : _i_dtl++
		, addContractTaxAmt : _i_dtl++
		, payRequestDate : _i_dtl++
		, mileageStateCD : _i_dtl++
		, mileagePayTPCD : _i_dtl++
		, keymanAmt : _i_dtl++
		, commt : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MIL0100102S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"mileageID;venueCD;venueNm;contractDateFrom;contractDateTo;"+
	  			"contractMonthCt;apAmt;msTargetRate;tcontractQty;gsvAmt;"+
	  			"gsvRate;stipulationAmt;contractAmt;contractTaxAmt;addContractAmt;addContractTaxAmt;payRequestDate;"+
	  			"mileageStateCD;mileagePayTPCD;keymanAmt;commt;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"num;num;num;num5;num;"+
	  			"num;num;num;num;num;num;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("mileageID", parent.$("#selectMileageID").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var stipulationAmt = unformatNum(table.getData(_col_dtl.stipulationAmt, 0));
          	var contractAmt = unformatNum(table.getData(_col_dtl.contractAmt, 0));
      		$("#mileageID").val(table.getData(_col_dtl.mileageID, 0));
      		$("#venue").val(table.getData(_col_dtl.venueCD, 0));
      		$("#venueCD").val(table.getData(_col_dtl.venueCD, 0));
      		$("#venueNm").val(table.getData(_col_dtl.venueNm, 0));
      		//$("#contractDateFrom").val(formatDate(table.getData(_col_dtl.contractDateFrom, 0)));
      		//$("#contractDateTo").val(formatDate(table.getData(_col_dtl.contractDateTo, 0)));
      		$("#yearCDFrom").val(table.getData(_col_dtl.contractDateFrom, 0).substring(0,4));
			$("#monthCDFrom").val(table.getData(_col_dtl.contractDateFrom, 0).substring(4,6));
			$("#yearCDTo").val(table.getData(_col_dtl.contractDateTo, 0).substring(0,4));
			$("#monthCDTo").val(table.getData(_col_dtl.contractDateTo, 0).substring(4,6));
      		$("#contractMonthCt").val(table.getData(_col_dtl.contractMonthCt, 0));
      		//$("#apAmt").val(table.getData(_col_dtl.apAmt, 0));
      		$("#msTargetRate").val(table.getData(_col_dtl.msTargetRate, 0));
      		$("#tcontractQty").val(table.getData(_col_dtl.tcontractQty, 0));
      		$("#gsvAmt").val(table.getData(_col_dtl.gsvAmt, 0));
      		$("#gsvRate").val(table.getData(_col_dtl.gsvRate, 0));
      		$("#stipulationAmt").val(table.getData(_col_dtl.stipulationAmt, 0));
      		$("#contractAmt").val(table.getData(_col_dtl.contractAmt, 0));
      		$("#contractTaxAmt").val(table.getData(_col_dtl.contractTaxAmt, 0));
      		$("#addContractAmt").val(table.getData(_col_dtl.addContractAmt, 0));
      		$("#addContractTaxAmt").val(table.getData(_col_dtl.addContractTaxAmt, 0));
      		$("#payRequestDate").val(formatDate(table.getData(_col_dtl.payRequestDate, 0)));
      		$("#mileageStateCD").val(table.getData(_col_dtl.mileageStateCD, 0));
      		$("#mileagePayTPCD").val(table.getData(_col_dtl.mileagePayTPCD, 0));
      		$("#keymanAmt").val(table.getData(_col_dtl.keymanAmt, 0));
      		$("#diffAmt").val(stipulationAmt - contractAmt);
      		$("#commt").val(table.getData(_col_dtl.commt, 0));
      		
      		$("#venue").attr("readonly", true);
    		$("#venue").addClass("input-readonly");
      		$("#venue_popup").hide();
      		$("#keyman_btn").show();
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
		, addEnterUnitAmt : _i_prd++
		, payAmt : _i_prd++
		, addPayAmt : _i_prd++
		, deleteBtn : _i_prd++
		, prdCD : _i_prd++
		, eu : _i_prd++
		, activeFlg : _i_prd++
    };
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MIL0100103S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;contractQty;"+
	  			"enterQty;enterUnitAmt;addEnterUnitAmt;payAmt;addPayAmt;deleteBtn;prdCD;"+
	  			"eu;");
	  	table.setParameter("format",
	  			"str;str;num;str;num5;"+
	  			"num;num;num;num;num;str;str;"+
	  			"num5;");
	  	table.setParameter("mileageID", parent.$("#selectMileageID").val());
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
					, table.getData(_col_prd.addEnterUnitAmt,i)
					, table.getData(_col_prd.payAmt,i)
					, table.getData(_col_prd.addPayAmt,i)
					, ""
					, table.getData(_col_prd.prdCD,i)
					, table.getData(_col_prd.eu,i)
					, "U"
      			];
      		}
      		grid_prd.setCellData(data);
      		grid_prd.setRowCount(rowCount);
      		
      	}
      	grid_prd.refresh();
      	
		maxRow_prd = rowCount;
	}
	
	function Save() {
		//등록, 지급반려, 보류인 경우에만 저장(2014.08.06, taejoon.jang, 보류추가)
		if($("#mileageStateCD").val() != "10" && $("#mileageStateCD").val() != "40") {
			alert("<fmt:message key="MIL01001B.msg2"/>");
			return;
		}
		if(maxRow_prd == 0) {
			alert("<fmt:message key="info.nullData.save"/>");
			return;
		}
		if($("#venueCD").val()=="") {
			alert("<fmt:message key="KEY01001A.msg1"/>");
			$("#venueCD").focus();
			return;
		}
		/*
		if($("#contractDateFrom").val()=="") {
			alert("<fmt:message key="MIL01001B.msg3"/>");
			$("#contractDateFrom").focus();
			return;
		}
		if($("#contractDateTo").val()=="") {
			alert("<fmt:message key="MIL01001B.msg4"/>");
			$("#contractDateTo").focus();
			return;
		}
		*/
		if($("#payRequestDate").val()=="") {
			alert("<fmt:message key="MIL01001B.msg5"/>");
			$("#payRequestDate").focus();
			return;
		}

		if($("#diffAmt").val() < 0) {
			alert("<fmt:message key="MIL01001B.msg11"/>");
			$("#contractAmt").focus();
			return;
		}

		//수정시 지급금액과 키맨등록에서 등록된 키맨별 지급금액의 합이 일치하지 않으면 저장 불가능
		if(parent.$("#selectMileageID").val() != "") {
			var keymanAmt = Number(unformat($("#keymanAmt").val()));
			var addContractAmt = Number(unformat($("#addContractAmt").val()));
			/*
			if(addContractAmt != keymanAmt) {
				alert("<fmt:message key="MIL01001B.msg6"/>");
				return;
			}
			*/
		}
		
		var prdCDs = new Array();
		var factoryPrices = new Array();
		var contractQtys = new Array();
		var enterQtys = new Array();
		var enterUnitAmts = new Array();
		var addEnterUnitAmts = new Array();
		var payAmts = new Array();
		var addPayAmts = new Array();
		var activeFlgs = new Array();
		var count = 0;
		for (var i=0; i<maxRow_prd; i++) {
			prdCDs[count] = grid_prd.getCellText(_col_prd.prdCD, i);
			factoryPrices[count] = grid_prd.getCellText(_col_prd.factoryPrice, i);
			contractQtys[count] = grid_prd.getCellText(_col_prd.contractQty, i);
			enterQtys[count] = grid_prd.getCellText(_col_prd.enterQty, i);
			enterUnitAmts[count] = grid_prd.getCellText(_col_prd.enterUnitAmt, i);
			addEnterUnitAmts[count] = grid_prd.getCellText(_col_prd.addEnterUnitAmt, i);
			payAmts[count] = grid_prd.getCellText(_col_prd.payAmt, i);
			addPayAmts[count] = grid_prd.getCellText(_col_prd.addPayAmt, i);
			activeFlgs[count] = grid_prd.getCellText(_col_prd.activeFlg, i);
			count++;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mil01/saveMileage");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("mileageID", parent.$("#selectMileageID").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("venueCD", $("#venueCD").val());
		//table.setParameter("contractDateFrom", $("#contractDateFrom").val());
		//table.setParameter("contractDateTo", $("#contractDateTo").val());
		table.setParameter("contractDateFrom", $("#yearCDFrom").val()+$("#monthCDFrom").val());
		table.setParameter("contractDateTo", $("#yearCDTo").val()+$("#monthCDTo").val());
		table.setParameter("contractMonthCt", $("#contractMonthCt").val());
		//table.setParameter("apAmt", unformatNum($("#apAmt").val()));
		table.setParameter("msTargetRate", $("#msTargetRate").val());
		table.setParameter("tcontractQty", $("#tcontractQty").val());
		table.setParameter("gsvAmt", $("#gsvAmt").val());
		table.setParameter("gsvRate", $("#gsvRate").val());
		table.setParameter("contractAmt", $("#contractAmt").val());
		table.setParameter("contractTaxAmt", $("#contractTaxAmt").val());
		table.setParameter("addContractAmt", $("#addContractAmt").val());
		table.setParameter("addContractTaxAmt", $("#addContractTaxAmt").val());
		table.setParameter("stipulationAmt", $("#stipulationAmt").val());
		table.setParameter("payRequestDate", $("#payRequestDate").val());
		table.setParameter("mileageStateCD", $("#mileageStateCD").val());
		table.setParameter("mileagePayTPCD", $("#mileagePayTPCD").val());
		table.setParameter("commt", $("#commt").val());
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("factoryPrices", factoryPrices);
		table.setParameter("contractQtys", contractQtys);
		table.setParameter("enterQtys", enterQtys);
		table.setParameter("enterUnitAmts", enterUnitAmts);
		table.setParameter("addEnterUnitAmts", addEnterUnitAmts);
		table.setParameter("payAmts", payAmts);
		table.setParameter("addPayAmts", addPayAmts);
		table.setParameter("activeFlgs", activeFlgs);
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			parent.$("#selectMileageID").val(table.getData(3,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Delete() {
		//등록, 지급반려, 보류인 경우에만 삭제가능(2014.08.06, taejoon.jang, 보류추가)
		if($("#mileageStateCD").val() != "10" && $("#mileageStateCD").val() != "40") {
			alert("<fmt:message key="MIL01001B.msg7"/>");
			return;
		}
		if(!confirm("<fmt:message key="confirm.delete"/>")){
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mil01/deleteMileage");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("mileageID", parent.$("#selectMileageID").val());
		table.setParameter("payTpCD", $("#payTpCD").val());
		table.request();

		alert(table.getData(1,0));
		if(table.getData(0,0) == "S") {
			top.appCountFun();
			List();
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
		"<fmt:message key="MIL01001B.kindTpCD5"/>"
		, "<fmt:message key="MIL01001B.prdNm"/>"
		, "<fmt:message key="MIL01001B.factoryPrice"/>"
		, "<fmt:message key="MIL01001B.qtyUnitCD"/>"
		, "<fmt:message key="MIL01001B.contractQty"/>"
		, "<fmt:message key="MIL01001B.enterQty"/>"
		, "<fmt:message key="MIL01001B.enterUnitAmt"/>"
		, "<fmt:message key="MIL01001B.addEnterUnitAmt"/>"
		, "<fmt:message key="MIL01001B.payAmt"/>"
		, "<fmt:message key="MIL01001B.addPayAmt"/>"
		, "<fmt:message key="MIL01001B.deleteBtn"/>"
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
	                        , num, num, num, num, num, str, str
	                        , num5]);
	    grid_prd.setCellEditable(true);
	    grid_prd.setCellEditable(false, _col_prd.kindTpCD5Name);
	    grid_prd.setCellEditable(false, _col_prd.prdNm);
	    grid_prd.setCellEditable(false, _col_prd.factoryPrice);
	    grid_prd.setCellEditable(false, _col_prd.qtyUnitCDName);
	    grid_prd.setCellEditable(false, _col_prd.contractQty);
	    grid_prd.setCellEditable(false, _col_prd.payAmt);
	    grid_prd.setCellEditable(false, _col_prd.addPayAmt);
	    grid_prd.setCellEditable(false, _col_prd.deleteBtn);
	    
		grid_prd.setCellImage("deleteGrid",_col_prd.deleteBtn);
	    var deleteFlag = new AW.Templates.Image;
	    var delImage = deleteFlag.getContent("box/image");
	    delImage.setTag("a");
	    delImage.setAttribute("href", function(){
	    	return "javascript:removeRow(grid_prd.getCurrentRow())";
	    });
	    grid_prd.setCellTemplate(deleteFlag, _col_prd.deleteBtn);
	    
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
	    		calculateContractQty(row);
	    		calculateAddPayAmt(row);
	    		calculateAddContractAmt(row);
	    	}
	    	else if(col == _col_prd.enterUnitAmt) {
	    		this.setCellText(formatNum(unformat(text)), col, row);
	    		calculatePayAmt(row);
	    	}
	    	else if(col == _col_prd.addEnterUnitAmt) {
	    		this.setCellText(formatNum(unformat(text)), col, row);
	    		calculateAddPayAmt(row);
	    	}
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
    }
	
</script>