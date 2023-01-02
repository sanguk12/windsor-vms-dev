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
											<col style="width:300px;"></col>
											<col style="width:100px;"></col>
											<col style="width:200px;"></col>
											<col style="width:120px;"></col>
										<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="PAY01005A.eventYM" />
												</td>
												<td class="td-input">
													<!-- 
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
													-->
													<nis:selectbox id="yearCDFrom_S" name="yearCDFrom_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCDFrom_S" name="monthCDFrom_S" defaultText="none" category="MONTHCD" />~
													<nis:selectbox id="yearCDTo_S" name="yearCDTo_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCDTo_S" name="monthCDTo_S" defaultText="none" category="MONTHCD" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="PAY01005A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
												</td>
												<td class="td-cond">
													<fmt:message key="PAY01005A.verifyStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="verifyStateCD_S" name="verifyStateCD_S" defaultText="none" category="VERIFYSTATECD" />
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="PAY01005A.addrTpCD1" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
												</td>
												<td class="td-cond">
													<fmt:message key="PAY01005A.addrTpCD2" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
												</td>
												<td class="td-cond">
													<fmt:message key="MIL01001B.mileagePayTPCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="mileagePayTPCD" name="mileagePayTPCD" defaultText="all" category="MILEAGEPAYTPCD"/>
												</td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="PAY01005A.venue" />
												</td>
												<td class="td-input">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
												</td>
												<td class="td-cond">
													<fmt:message key="PAY03003A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY03003A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
				                            </tr>
			                            </tbody>
			                        </table>
                    			</td>
                   			</tr>
						</table>
                    </td>
                </tr>
                <!-- 2014.08.13, taejoon.jang, 검증오류 작성기간 없앰
                <tr>
                	<td height="1">
                		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                			<colgroup>
			        			<col style="width:110px;"></col>
			        			<col></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="PAY01005A.resultWriteDate" />
									</td>
									<td class="tit_text01">
										<span id="resultWriteDate_S" />
	                                </td>
	                            </tr>
			        		</tbody>
		        		</table>
                	</td>
                </tr>
                 -->
                <tr>
					<td height="*" valign="top">
						<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
	                   		<tr>
	                   			<td width="40%">
									<span id="grid_rlt"></span>
								</td>
								<td width="*">
									<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" >
			                    		<tr>
			                    			<td height="1" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
						                            <colgroup>
									        			<col style="width:120px;"></col>
									        			<col style="width:120px;"></col>
									        			<col style="width:120px;"></col>
									        			<col style="width:120px;"></col>
									        			<col style="width:120px;"></col>
									        			<col></col>
									        		</colgroup>
							        				<tbody>
						                            	<tr>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.mileageID" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.venueCD" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.venueNm" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.contractDate" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.contractMonthCt" />
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-report-rborder" style="text-align:center;">
																&nbsp;<span id="mileageID"></span>
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
															<td class="td-report-rborder">
																&nbsp;<span id="contractMonthCt"></span>
															</td>
														</tr>
														<tr>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.targetRate" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.msTargetRate" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.tcontractQty" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.gsvAmt" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.gsvRate" />
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="targetRate"></span>
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
														</tr>
														<tr>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.contractAmt" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.contractTaxAmt" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.addContractAmt" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.addContractTaxAmt" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.payRequestDate" />
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="contractAmt"></span>
															</td>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="contractTaxAmt"></span>
															</td>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="addContractAmt"></span>
															</td>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="addContractTaxAmt"></span>
															</td>
															<td class="td-report-rborder" style="text-align:center;">
																&nbsp;<span id="payRequestDate"></span>
															</td>
														</tr>
														<tr>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.mileagePayTPCD" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.keyman" />
															</td>
															<td class="td-cond-report" colspan="3">
																<fmt:message key="PAY01005A.verifyStateCD" />
															</td>
			                            				</tr>
														<tr>
															<td class="td-report-rborder" style="text-align:center;">
																<nis:selectbox id="mileagePayTPCD" name="mileagePayTPCD" defaultText="none" category="MILEAGEPAYTPCD" style="height:17px;" event="" eventProc="" />
															</td>
															<td class="td-report-rborder" style="text-align:center;">
																&nbsp;<span id="keyman_btn"></span>
																<input type="hidden" id="keymanAmt" name="keymanAmt" />
															</td>
															<td class="td-report-rborder" colspan="3">
																&nbsp;<span id="verifyStateCDName"></span>
																<input type="hidden" id="verifyStateCD" name="verifyStateCD" />
															</td>
														</tr>
			                            				<tr>
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.commt" />
															</td>
															<td class="td-report-rborder" colspan="4">
																<input type="text" id="commt" name="commt" style="width:400px; height:17px;">
															</td>
														</tr>
														<tr style="height:100%">
															<td class="td-cond-report">
																<fmt:message key="PAY01005A.verifyErrCommt" />
															</td>
															<td class="td-report-rborder" colspan="4">
																&nbsp;<span id="verifyErrCommt"></span>
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
						<input type="hidden" id="incntTpCD" name="incntTpCD" value="VEN" />
						<input type="hidden" id="diffNo" name="diffNo" value="9" /><!-- G1 -->
						<input type="hidden" id="apprTpID" name="apprTpID" value="000002" /><!-- Result검증 승인라인 -->
						<!-- <input type="hidden" id="resultWriteYN" name="resultWriteYN" /> -->
						<input type="hidden" id="selectMileageID" name="selectMileageID" />
						<input type="hidden" id="stipulationAmt" name="stipulationAmt" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid_rlt .aw-column-0 {width: 80px; text-align:center;}
	#grid_rlt .aw-column-1 {width: 130px; text-align:center;}
    #grid_rlt .aw-column-2 {width: 60px; text-align:center;}
    #grid_rlt .aw-column-3 {width: 100px; text-align:left;}
    #grid_rlt .aw-column-4 {width: 170px; text-align:left;}
    #grid_rlt .aw-column-5 {width: 60px; text-align:center;}
    #grid_rlt .aw-column-6 {width: 60px; text-align:left;}
    
    #grid_prd .aw-column-0 {width: 80px; text-align:center;}
    #grid_prd .aw-column-1 {width: 100px; text-align:left;}
    #grid_prd .aw-column-2 {width: 120px; text-align:left;}
    #grid_prd .aw-column-3 {width: 80px; text-align:right;}
	#grid_prd .aw-column-4 {width: 60px; text-align:center;}
    #grid_prd .aw-column-5 {width: 80px; text-align:right;}
    #grid_prd .aw-column-6 {width: 60px; text-align:right;}
    #grid_prd .aw-column-7 {width: 80px; text-align:right;}
    #grid_prd .aw-column-8 {width: 85px; text-align:right;}
    #grid_prd .aw-column-9 {width: 70px; text-align:right;}
    #grid_prd .aw-column-10 {width: 80px; text-align:right;}
    #grid_prd .aw-column-11 {width: 80px; text-align:right;}
    #grid_prd .aw-column-12 {width: 80px; text-align:right;}
    #grid_prd .aw-column-13 {width: 90px; text-align:right;}
    #grid_prd .aw-column-14 {width: 50px; text-align:center;}

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
		$("#payRate").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid_rlt();
			grid_rlt.refresh();
			
			createGrid_prd();
			grid_prd.refresh();
			//btnSave.setControlDisabled(true);
			if("${params.eventym}"==""){
				$("#yearCDFrom_S").val(unformat("${params.agoYearDate}").substring(0,4));
				$("#monthCDFrom_S").val(unformat("${params.agoYearDate}").substring(4,6));
				$("#yearCDTo_S").val("${params.clientDate}".substring(0,4));
				$("#monthCDTo_S").val("${params.clientDate}".substring(4,6));
			}else{
				$("#yearCDFrom_S").val(unformat("${params.agoYearDate}").substring(0,4));
				$("#monthCDFrom_S").val(unformat("${params.agoYearDate}").substring(4,6));
				$("#yearCDTo_S").val("${params.clientDate}".substring(0,4));
				$("#monthCDTo_S").val("${params.clientDate}".substring(4,6));
			}
			
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
			$("#verifyStateCD_S").val("ERR");
			$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
// 			getResultWriteYN();
// 			getResultWriteDate();

			if("${params.eventym}"!=""){
				$("#apprStateCD_S").val("40");
    			Search();
    		}
			
		};

		${initScript}
		
		$("#yearCDFrom_S").change(function(){
			Search();
		});
		$("#monthCDfrom_S").change(function(){
			Search();
		});
		$("#yearCDTo_S").change(function(){
			Search();
		});
		$("#monthCDTo_S").change(function(){
			Search();
		});
		$("#venue_S_popup").click(function(){
			openVenuePopup("closeVenuePopup");
		});
		$("#venue_S").keypress(function(){
			if (event.keyCode==13){
				getVenueName("venue_S", "venueCD_S", "venueNm_S");
				if($("#venueCD_S").val()!="") {
					Search();
				}
			}
		});
	});

	var _col_cd2 = {
		"code" : 0
		, "name" : 1
	}
	function getOfficeCD(code) {
		if(code=="") {
			$("#officeCD_S").val("");
			$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "OFFICECD");
	  	table.setParameter("attrib02", code);
	  	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#officeCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd2.code,i)==code){
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd2.code,i)+'" checked="true">'+table.getData(_col_cd2.name,i)+'</option>');
	   			} else {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd2.code,i)+'">'+table.getData(_col_cd2.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#officeCD_S").attr("disabled",false);
    		$("#officeCD_S").removeClass("input-readonly");
     	}
	}

	//초과분구분 set
	//YPAY:초과분지급이면, 빨간바탕처리
	function changeExcPayTpCD(val) {
		if(val == "YPAY") {
			$("#excPayTpCD").css("background","ff0000");
			$("#excPayTpCD").css("color","ffffff");
		}
		else {
			$("#excPayTpCD").css("background","ffffff");
			$("#excPayTpCD").css("color","000000");
		}
	}
	
	//실적구분 set
	//RFID이면 rfid수량을 result수량으로 하고, result수량 수정금지
	/*
	function changeResultTpCD(val) {
		if(val == "10") {
			for(var i=0; i<grid_prd.getRowCount(); i++) {
				grid_prd.setCellText(grid_prd.getCellText(_col_prd.rfidQty, i), _col_prd.resultQty, i);
			}
			grid_prd.setCellEditable(false, _col_prd.resultQty);
		}
		else {
			grid_prd.setCellEditable(true, _col_prd.resultQty);
		}
	}
	*/
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
// 	function getResultWriteYN() {
// 		var table = new AW.XML.Table;
// 		table.setURL("${contextPath}/service/simpleAction/COM03001S");
// 		table.setAsync(false);
// 		table.setRequestMethod("POST");
// 		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
// 		table.setParameter("planResultTpCD", "02");		//01:plan,02:result
// 		table.request();
		
// 		if(table.getCount() > 0) {
// 			$("#resultWriteYN").val(table.getData(0,0));
// 			if(table.getData(0,0) == "Y") {
// 				btnSave.setControlDisabled(false);
// 			}
// 			else {
// 				btnSave.setControlDisabled(true);
// 			}
// 		}
// 	}
	
// 	function getResultWriteDate() {
// 		var table = new AW.XML.Table;
// 		table.setURL("${contextPath}/service/simpleAction/COM03002S");
// 		table.setAsync(false);
// 		table.setRequestMethod("POST");
// 		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
// 		table.setParameter("planResultTpCD", "02");		//01:plan,02:result
// 		table.request();
		
// 		var s = "";
// 	  	if (table.getCount() > 0) {
// 	  		s = "<select id='resultWriteDate_S' name='resultWriteDate_S'>";
// 		  	for (var i=0; i < table.getCount(); i++) {
// 		  		s += "<option>"+table.getData(0,i)+"</option>";
// 		  	}
// 	  	}
// 	  	else {
// 	  		 s = "<select id='resultWriteDate_S' name='resultWriteDate_S'><option value=''><fmt:message key="nothing"/></option>";
// 	  	}
// 	  	s += "</select>";
// 	  	$("#resultWriteDate_S").html(s);
// 	}
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getAddrTpCD2(code) {
		if(code == "") {
			$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "ADDRTPCD2");
	  	table.setParameter("attrib02", code);
     	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#addrTpCD2_S").attr("disabled",false);
    		$("#addrTpCD2_S").removeClass("input-readonly");
		}
     	else {
     		$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
     	}
	}

	var keyman_btn = new AW.UI.Button;
	keyman_btn.setId("keyman_btn");
	keyman_btn.setControlText("<fmt:message key="button.keymanReg" />");
	keyman_btn.refresh();
	
	keyman_btn.onControlClicked = function(event) {
		if($("#selectMileageID").val() != "") {
			var contractAmt = unformat($("#addContractAmt").text());
			var venueCD = $("#venueCD").text();
			var mileageID = $("#selectMileageID").val();
			var verifyStateCD = $("#verifyStateCD").val();
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MIL01002C&contractAmt="+contractAmt+"&venueCD="+venueCD+"&mileageID="+mileageID+"&verifyStateCD="+verifyStateCD;
			newWindow(url, "MIL01002C",700,550,"yes");
		}
	}

	/*
	var keyman_btn = new AW.UI.Button;
	keyman_btn.setId("keyman_btn");
	keyman_btn.setControlText("<fmt:message key="button.keymanReg" />");
	keyman_btn.refresh();
	
	keyman_btn.onControlClicked = function(event) {
		if($("#selectMileageID").val() != "") {
			var tpayAmt = unformat($("#tpayAmt").text());
			var venueCD = $("#venueCD").text();
			var diffNo = $("#diffNo").val();
			//var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
			var verifyStateCD = $("#verifyStateCD").val();
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01001C"
					+"&tpayAmt="+tpayAmt+"&venueCD="+venueCD+"&diffNo="+diffNo+"&eventYM="+eventYM
					+"&verifyStateCD="+verifyStateCD+"&resultWriteYN=N";
			newWindow(url, "RLT01001C",700,550,"yes");
		}
	}
	*/
	
	function New() {
		maxRow_prd = 0;
		$("#mileageID").text("");
  		$("#venueCD").text("");
  		$("#venueNm").text("");
  		$("#contractDate").text("");
  		$("#contractMonthCt").text("");
  		$("#targetRate").text("0");
  		$("#msTargetRate").text("0");
  		$("#tcontractQty").text("0");
  		$("#gsvAmt").text("0");
  		$("#gsvRate").text("0");
  		//$("#stipulationAmt").text(table.getData(_col_dtl.stipulationAmt, 0));
  		$("#contractAmt").text("0");
  		$("#contractTaxAmt").text("0");
  		$("#addContractAmt").text("0");
  		$("#addContractTaxAmt").text("0");
  		$("#payRequestDate").text("");
  		//$("#mileageStateCD").text(table.getData(_col_dtl.mileageStateCD, 0));
  		$("#mileagePayTPCD").val("");
  		$("#keymanAmt").val(0);
  		//$("#diffAmt").text(stipulationAmt - contractAmt);
  		$("#commt").val("");
  		$("#verifyErrCommt").text("");
  		
  		$("#keyman_btn").show();
  		$("#verifyStateCD").val("");
      	$("#verifyStateCDName").text("");
		
		$("#gsvRate_td").css("background","#ffffff");
		$("#gsvRate").css("color","#00000");
		
		createGrid_prd();
		grid_prd.refresh();
	}
	
	//지급금액 계산
	/*
	function calculatePayAmt(row) {
		var resultQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.resultQty, row)));
		var resultUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.resultUnitAmt, row)));
		var payAmt = 0;
		payAmt = resultQty * resultUnitAmt;
		grid_prd.setCellText(formatNum(payAmt), _col_prd.payAmt, row);
		
		calculateTargetRate();
	}
	
	//당월Result 총수량 계산
	function calculateResultTQty() {
		var resultTQty = 0;
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			resultTQty += parseFloat(unformat(grid_prd.getCellText(_col_prd.resultQty, i)));
		}
		$("#resultTQty").text(formatNum(resultTQty));
	}
	
	//달성률 계산
	function calculateTargetRate() {
		var targetRate = 0;
		var resultTQty = parseFloat(unformat($("#resultTQty").text()));
		var planTQty = parseFloat(unformat($("#planTQty").text()));
		if(planTQty==0) {
			targetRate = 0;
		}
		else {
			targetRate = (resultTQty / planTQty) * 100;
		}
		$("#targetRate").text(Math.round(targetRate));
		
		getPayRate();
		setExcPayTpCD();
		calculateTpayAmt();
	}
	
	//지급율 가져오기
	function getPayRate() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03007S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("targetRate", $("#targetRate").text());
     	table.request();
     	$("#guidPayRate").val(table.getData(0,0));
     	$("#payRate").val(table.getData(0,0));
     	
     	setPayRate();
	}
	
	function setPayRate() {
		if($("#payRate").val() == "") {
     		$("#payRate").val("0");
     	}
		else {
			if(parseFloat(unformatNum($("#payRate").val())) > 100) {
				alert("<fmt:message key="RLT01001A.msg7"/>");
				$("#payRate").val("100");
			}
		}
		
		var guidPayRate = parseFloat(unformatNum($("#guidPayRate").val()));
     	var payRate = parseFloat(unformatNum($("#payRate").val()));
     	
     	if(payRate > guidPayRate) {
     		$("#payRate").css("background","#ff0000");
     		$("#payRate").css("color","#ffffff");
     	}
     	else if(payRate == guidPayRate) {
     		$("#payRate").css("background","#ffffff");
     		$("#payRate").css("color","#00000");
     	}
     	else {
     		$("#payRate").css("background","#00ff00");
     		$("#payRate").css("color","#000000");
     	}
	}
	
	//초과분지급구분 set
	function setExcPayTpCD() {
		var targetRate = parseFloat(unformat($("#targetRate").text()));
		if(targetRate <= 120) {
			$("#excPayTpCD").val("");
			changeExcPayTpCD("");
			$("#excPayTpCD").attr("disabled",true);
			$("#excPayTpCD").addClass("input-readonly");
			$("#excPayTpCD_td").removeClass("td-cond-report-required");
		}
		else {
			$("#excPayTpCD").attr("disabled",false);
			$("#excPayTpCD").removeClass("input-readonly");
			$("#excPayTpCD_td").addClass("td-cond-report-required");
		}
	}
	
	//지급금액 계산
	//120%초과 초과분미지급이면, (실적지급액 * 지급률) / 달성률 * 1.2
	//120%초과 초과분지급이면(선택인경우도 지급), 실적지급액 * 지급률
	function calculateTpayAmt() {
		var payAmt = 0;
		var tpayAmt = 0;
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			payAmt += parseFloat(unformat(grid_prd.getCellText(_col_prd.payAmt, i)));
		}
		var payRate = parseFloat(unformat($("#payRate").val())) / 100;
		var targetRate = parseFloat(unformat($("#targetRate").text())) / 100;
		
		if($("#excPayTpCD").val() == "NPAY") {
			tpayAmt = (payAmt * payRate) / targetRate * 1.2;
		}
		else {
			tpayAmt = payAmt * payRate;
		}
		$("#tpayAmt").text(formatNum(Math.round(tpayAmt)));
		
		calculateGsvRate();
	}
	
	//vs GSV 계산
	function calculateGsvRate() {
		//gsv
		var gsv = 0;
		//총지급액
		var tpayAmt = parseFloat(unformat($("#tpayAmt").text()));
		//제품별 result수량
		var resultQty = 0;
		//제품별 출고가
		var factoryPrice = 0;
		//제품별 result수량*출고가
		var resultQty_factoryPrice = 0;
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			resultQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.resultQty, i)));
			factoryPrice = parseFloat(unformat(grid_prd.getCellText(_col_prd.factoryPrice, i)));
			resultQty_factoryPrice += resultQty * factoryPrice;
		}
		gsv = (resultQty_factoryPrice==0)?0:((tpayAmt*(1+0.0352)) / resultQty_factoryPrice) * 100;
		$("#gsvRate").text(Math.round(gsv));
		
		setGsvRate_td($("#gsvRate").text());
	}
	
	//gsvRate td
	function setGsvRate_td(val) {
		val = parseFloat(unformatNum(val));
		if(val > 10) {
			$("#gsvRate_td").css("background","#ff0000");
     		$("#gsvRate").css("color","#ffffff");
		}
		else {
			$("#gsvRate_td").css("background","#ffffff");
     		$("#gsvRate").css("color","#00000");
		}
	}
	*/
	//지급금액 계산
	function calculatePayAmt(row) {
		if(grid_prd.getCellText(_col_prd.rltEnterQty, row)=="") {
			return;
		}
		if(grid_prd.getCellText(_col_prd.rltEnterUnitAmt, row)=="") {
			return;
		}
		var rltEnterQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.rltEnterQty, row)));
		var rltEnterUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.rltEnterUnitAmt, row)));
		var payAmt = 0;
		payAmt = rltEnterQty * rltEnterUnitAmt;
		grid_prd.setCellText(formatNum(payAmt), _col_prd.payAmt, row);
		
		calculateContractAmt();
	}
	
	//지급금액합, 지급금액(세후)합 계산
	function calculateContractAmt() {
		var contractAmt = 0;
		var planContractAmt = 0;
		var contractTaxAmt = 0;
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
				contractAmt += parseFloat(unformat(grid_prd.getCellText(_col_prd.payAmt, i)));
				planContractAmt += (parseFloat(unformat(grid_prd.getCellText(_col_prd.plnEnterQty, i))) * parseFloat(unformat(grid_prd.getCellText(_col_prd.rltEnterUnitAmt, i))));
			}
		}
		$("#contractAmt").text(formatNum(contractAmt));
		//약정금액과 지급금액을 같은값으로 저장함 나중에 지그금액은 수정할수잇또록 열어둠 2016.10.10
		$("#stipulationAmt").val(formatNum(contractAmt));
		//$("#diffAmt").val(0);
		contractTaxAmt = parseFloat(contractAmt)*(1+0.0352);
		$("#contractTaxAmt").text(formatNum(Math.round(contractTaxAmt)));
		if(planContractAmt != 0){
			$("#targetRate").text(Math.round(contractAmt/planContractAmt*100)+"");
		}
		else{
			$("#targetRate").text("0");
		}
		
		calculateGsvAmt();
	}

	//지급금액 계산
	function calculateAddPayAmt(row) {
		if(grid_prd.getCellText(_col_prd.rltEnterQty, row)=="") {
			return;
		}
		if(grid_prd.getCellText(_col_prd.addEnterUnitAmt, row)=="") {
			return;
		}
		var rltEnterQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.rltEnterQty, row)));
		var addEnterUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.addEnterUnitAmt, row)));
		var addPayAmt = 0;
		addPayAmt = rltEnterQty * addEnterUnitAmt;
		grid_prd.setCellText(formatNum(addPayAmt), _col_prd.addPayAmt, row);
		calculateAddContractAmt();
	}
	
	//지급금액합, 지급금액(세후)합 계산
	function calculateAddContractAmt() {
		var addContractAmt = 0;
		var addContractTaxAmt = 0;
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
				addContractAmt += parseFloat(unformat(grid_prd.getCellText(_col_prd.addPayAmt, i)));
			}
		}
		$("#addContractAmt").text(formatNum(addContractAmt));
		addContractTaxAmt = parseFloat(addContractAmt)*(1+0.0352);
		$("#addContractTaxAmt").text(formatNum(Math.round(addContractTaxAmt)));
	}

	//약정량(EU) 계산
	function calculateContractQty(row) {
		if(grid_prd.getCellText(_col_prd.rltEnterQty, row)=="") {
			return;
		}
		if(grid_prd.getCellText(_col_prd.eu, row)=="") {
			return;
		}
		var rltEnterQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.rltEnterQty, row)));
		var eu = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.eu, row)));
		var contractQty = 0;
		
		
// 		contractQty = Math.round(rltEnterQty * eu);
		contractQty = Math.round(rltEnterQty * eu * 100000)/100000;
		
		grid_prd.setCellText(formatNum(contractQty), _col_prd.contractQty, row);
		
		calculateTContractQty();
	}
	
	//약정량(EU)합 계산
	function calculateTContractQty() {
		var tcontractQty = 0;
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
// 				tcontractQty += parseFloat(unformat(grid_prd.getCellText(_col_prd.contractQty, i)));
				tcontractQty += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.contractQty, i)));
			}
		}
		
		$("#tcontractQty").text(formatNum(Math.round(tcontractQty * 100000)/100000));
	}
	
	//GSV(원) 계산
	function calculateGsvAmt() {
		var gsvAmt = 0;
		var rltEnterQty = 0;
		var factoryPrice = 0;
		var rltEnterQty_factoryPrice = 0;
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i) != "D") {
				rltEnterQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.rltEnterQty, i)));
				factoryPrice = parseFloat(unformat(grid_prd.getCellText(_col_prd.factoryPrice, i)));
				rltEnterQty_factoryPrice += rltEnterQty * factoryPrice;
			}
		}
		$("#gsvAmt").text(formatNum(rltEnterQty_factoryPrice));
		
		calculateGsvRate();
	}
	
	//vs GSV 계산
	function calculateGsvRate() {
		var gsvRate = 0;
		var contractAmt = parseFloat(unformat($("#contractAmt").text()));
		var gsvAmt = parseFloat(unformat($("#gsvAmt").text()));
		if(gsvAmt != 0) {
			gsvRate = ((contractAmt*(1+0.0352)) / gsvAmt) * 100;
			$("#gsvRate").text(Math.round(gsvRate)+"");
		}
		else {
			$("#gsvRate").text("0");
		}
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function Search() {
		Search_rlt();
	}
	
	var _i_rlt = 0;
	var _col_rlt = {
		mileageID : _i_rlt++
		, contractDate : _i_rlt++
		, contractMonthCt : _i_rlt++
		, venueCD : _i_rlt++
		, venueNm : _i_rlt++
		, venueGradCDName : _i_rlt++
		, addrTpCD2Name : _i_rlt++
    };
	function Search_rlt() {
// 		getResultWriteYN();
// 		getResultWriteDate();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PAY0100501S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"mileageID;contractDate;contractMonthCt;venueCD;venueNm;venueGradCDName;"+
	  			"addrTpCD2Name;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;str;"+
	  			"str;");
	  	//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("contractDateFrom", $("#yearCDFrom_S").val()+$("#monthCDFrom_S").val());
	  	table.setParameter("contractDateTo", $("#yearCDTo_S").val()+$("#monthCDTo_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	//table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("verifyStateCD", $("#verifyStateCD_S").val());
	  	table.setParameter("apprTpID", $("#apprTpID").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("mileagePayTPCD", $("#mileagePayTPCD").val());
	  	table.request();
      	
// 	  	if (grid_rlt != null) grid_rlt.clear();
      	createGrid_rlt();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					table.getData(_col_rlt.mileageID,i)
					, table.getData(_col_rlt.contractDate,i)
					, table.getData(_col_rlt.contractMonthCt,i)
      			    , table.getData(_col_rlt.venueCD,i)
					, table.getData(_col_rlt.venueNm,i)
					, table.getData(_col_rlt.venueGradCDName,i)
					, table.getData(_col_rlt.addrTpCD2Name,i)
      			];
      		}
      		grid_rlt.setCellData(data);
      		grid_rlt.setRowCount(rowCount);
      	}
      	grid_rlt.refresh();
      	
      	New();
	}

	/*
	var _i_dtl = 0;
	var _col_dtl = {
		programCDName : _i_dtl++
		, activityCDName : _i_dtl++
		, venueCD : _i_dtl++
		, venueNm : _i_dtl++
		, planTQty : _i_dtl++
		, resultTQty : _i_dtl++
		, targetRate : _i_dtl++
		, payRate : _i_dtl++
		, excPayTpCD : _i_dtl++
		, tpayAmt : _i_dtl++
		, resultTpCD : _i_dtl++
		, gsvRate : _i_dtl++
		, verifyStateCDName : _i_dtl++
		, verifyStateCD : _i_dtl++
		, programCD : _i_dtl++
		, activityCD : _i_dtl++
		, payAmt_keyman : _i_dtl++
		, guidPayRate : _i_dtl++
		, commt : _i_dtl++
		, verifyErrCommt : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PAY0100502S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"programCDName;activityCDName;venueCD;venueNm;planTQty;"+
	  			"resultTQty;targetRate;payRate;excPayTpCD;tpayAmt;"+
	  			"resultTpCD;gsvRate;verifyStateCDName;verifyStateCD;programCD;"+
	  			"activityCD;payAmt_keyman;guidPayRate;commt;verifyErrCommt;");
	  	table.setParameter("format",
	  			"str;str;str;str;num;"+
	  			"num;num;num;str;num;"+
	  			"str;num;str;str;str;"+
	  			"str;str;num;str;str;");
	  	//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#programCDName").text(table.getData(_col_dtl.programCDName, 0));
      		$("#activityCDName").text(table.getData(_col_dtl.activityCDName, 0));
      		$("#venueCD").text(table.getData(_col_dtl.venueCD, 0));
      		$("#venueNm").text(table.getData(_col_dtl.venueNm, 0));
      		$("#planTQty").text(table.getData(_col_dtl.planTQty, 0));
      		$("#resultTQty").text(table.getData(_col_dtl.resultTQty, 0));
      		$("#targetRate").text(table.getData(_col_dtl.targetRate, 0));
      		$("#payRate").val(table.getData(_col_dtl.payRate, 0));
      		$("#guidPayRate").val(table.getData(_col_dtl.guidPayRate, 0));
      		setPayRate();
      		$("#excPayTpCD").val(table.getData(_col_dtl.excPayTpCD, 0));
      		setExcPayTpCD();
      		changeExcPayTpCD(table.getData(_col_dtl.excPayTpCD, 0));
      		$("#tpayAmt").text(table.getData(_col_dtl.tpayAmt, 0));
      		$("#resultTpCD").val(table.getData(_col_dtl.resultTpCD, 0));
      		$("#gsvRate").text(table.getData(_col_dtl.gsvRate, 0));
      		setGsvRate_td(table.getData(_col_dtl.gsvRate, 0));
      		
      		if(table.getData(_col_dtl.verifyStateCD, 0) == "10") {
	      		$("#verifyStateCDName").text(table.getData(_col_dtl.verifyStateCDName, 0));
      		}
      		else {
      			$("#verifyStateCDName").html("<a href='javascript:openVerifyState();'>"+table.getData(_col_dtl.verifyStateCDName, 0)+"</a>");
      		}
      		
      		$("#verifyStateCD").val(table.getData(_col_dtl.verifyStateCD, 0));
      		$("#programCD").val(table.getData(_col_dtl.programCD, 0));
      		//$("#activityCD").val(table.getData(_col_dtl.activityCD, 0));
      		$("#payAmt_keyman").val(table.getData(_col_dtl.payAmt_keyman, 0));
      		$("#commt").val(table.getData(_col_dtl.commt, 0));
      		$("#verifyErrCommt").text(table.getData(_col_dtl.verifyErrCommt, 0));
      		
			//	result 검증상태가 등록, 반려, 검증오류가 아닌경우에는 수정 불가
			//(10:등록, 40:반려, ERR:검증오류)
			//
			var verifyStateCD = table.getData(_col_dtl.verifyStateCD, 0);
// 			if($("#resultWriteYN").val()=="Y") {
				if(verifyStateCD!="10" && verifyStateCD!="40" && verifyStateCD!="ERR") {
					btnSave.setControlDisabled(true);
				}
				else {
					btnSave.setControlDisabled(false);
				}
// 			}
			
			//선지원(20)인 경우 keyman 미등록
			//if(table.getData(_col_dtl.activityCD, 0) == "20") {
				//$("#keyman_btn").hide();
			//}
			//else {
				//$("#keyman_btn").show();
			//}
			
			Search_prd();
      	}
	}
	*/
	var _i_dtl = 0;
	var _col_dtl = {
		mileageID : _i_dtl++
		, venueCD : _i_dtl++
		, venueNm : _i_dtl++
		, contractDate : _i_dtl++
		, contractMonthCt : _i_dtl++
		, targetRate : _i_dtl++
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
		, verifyStateCDName : _i_dtl++
		, verifyStateCD : _i_dtl++
		, verifyErrCommt : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PAY0100502S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"mileageID;venueCD;venueNm;contractDate;"+
	  			"contractMonthCt;targetRate;msTargetRate;tcontractQty;gsvAmt;"+
	  			"gsvRate;stipulationAmt;contractAmt;contractTaxAmt;addContractAmt;addContractTaxAmt;payRequestDate;"+
	  			"mileageStateCD;mileagePayTPCD;keymanAmt;commt;verifyStateCDName;verifyStateCD;verifyErrCommt;");
	  	table.setParameter("format",
	  			"str;str;str;str;"+
	  			"num;num;num5;num5;num;"+
	  			"num;num;num;num;num;num;str;"+
	  			"str;str;str;str;str;str;str;");
	  	table.setParameter("mileageID", $("#selectMileageID").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var stipulationAmt = unformatNum(table.getData(_col_dtl.stipulationAmt, 0));
          	var contractAmt = unformatNum(table.getData(_col_dtl.contractAmt, 0));
      		$("#mileageID").text(table.getData(_col_dtl.mileageID, 0));
      		//$("#venue").text(table.getData(_col_dtl.venueCD, 0));
      		$("#venueCD").text(table.getData(_col_dtl.venueCD, 0));
      		$("#venueNm").text(table.getData(_col_dtl.venueNm, 0));
      		$("#contractDate").text(formatDate(table.getData(_col_dtl.contractDate, 0)));
      		$("#contractMonthCt").text(table.getData(_col_dtl.contractMonthCt, 0));
      		$("#targetRate").text(table.getData(_col_dtl.targetRate, 0));
      		$("#msTargetRate").text(table.getData(_col_dtl.msTargetRate, 0));
      		$("#tcontractQty").text(table.getData(_col_dtl.tcontractQty, 0));
      		$("#gsvAmt").text(table.getData(_col_dtl.gsvAmt, 0));
      		$("#gsvRate").text(table.getData(_col_dtl.gsvRate, 0));
      		//$("#stipulationAmt").text(table.getData(_col_dtl.stipulationAmt, 0));
      		$("#contractAmt").text(table.getData(_col_dtl.contractAmt, 0));
      		$("#contractTaxAmt").text(table.getData(_col_dtl.contractTaxAmt, 0));
      		$("#addContractAmt").text(table.getData(_col_dtl.addContractAmt, 0));
      		$("#addContractTaxAmt").text(table.getData(_col_dtl.addContractTaxAmt, 0));
      		$("#payRequestDate").text(formatDate(table.getData(_col_dtl.payRequestDate, 0)));
      		//$("#mileageStateCD").text(table.getData(_col_dtl.mileageStateCD, 0));
      		$("#mileagePayTPCD").val(table.getData(_col_dtl.mileagePayTPCD, 0));
      		$("#keymanAmt").val(table.getData(_col_dtl.keymanAmt, 0));
      		//$("#diffAmt").text(stipulationAmt - contractAmt);
      		$("#commt").val(table.getData(_col_dtl.commt, 0));
      		$("#verifyErrCommt").text(table.getData(_col_dtl.verifyErrCommt, 0));
      		
      		$("#keyman_btn").show();
      		$("#verifyStateCD").val(table.getData(_col_dtl.verifyStateCD, 0));
      		if(table.getData(_col_dtl.verifyStateCD, 0) == "10") {
	      		$("#verifyStateCDName").text(table.getData(_col_dtl.verifyStateCDName, 0));
      		}
      		else {
      			$("#verifyStateCDName").html("<a href='javascript:openVerifyState();'>"+table.getData(_col_dtl.verifyStateCDName, 0)+"</a>");
      		}
      		Search_prd();
      	}
	}
	/*
	var _i_prd = 0;
	var _col_prd = {
		eventYM : _i_prd++	
		, kindTpCD5Name : _i_prd++
		, prdNm : _i_prd++
		, factoryPrice : _i_prd++
		, qtyUnitCDName : _i_prd++
		, contractQty : _i_prd++
		, plnEnterQty : _i_prd++
		, plnEnterUnitAmt : _i_prd++
		, plnAddEnterUnitAmt : _i_prd++
		, rltEnterQty : _i_prd++
		, rltEnterUnitAmt : _i_prd++
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
	  	table.setURL("${contextPath}/service/simpleAction/MIL0100203S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"eventYM;kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;contractQty;"+
	  			"plnEnterQty;plnEnterUnitAmt;plnAddEnterUnitAmt;rltEnterQty;rltEnterUnitAmt;addEnterUnitAmt;payAmt;addPayAmt;deleteBtn;prdCD;"+
	  			"eu;");
	  	table.setParameter("format",
	  			"eventYM;str;str;num;str;num5;"+
	  			"num;num;num;num;num;num;num;num;str;str;"+
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
					formatMonth(table.getData(_col_prd.eventYM,i))
					, table.getData(_col_prd.kindTpCD5Name,i)
					, table.getData(_col_prd.prdNm,i)
					, table.getData(_col_prd.factoryPrice,i)
      			    , table.getData(_col_prd.qtyUnitCDName,i)
					, table.getData(_col_prd.contractQty,i)
					, table.getData(_col_prd.plnEnterQty,i)
					, table.getData(_col_prd.plnEnterUnitAmt,i)
					, table.getData(_col_prd.plnAddEnterUnitAmt,i)
					, table.getData(_col_prd.rltEnterQty,i)
					, table.getData(_col_prd.rltEnterUnitAmt,i)
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
	*/
	
	function CloseKeymanPopup() {
		Search_keymanAmt();
	}
	
	function Search_keymanAmt() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PAY0100502S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"keymanAmt;");
	  	table.setParameter("format",
	  			"num;");
	  	//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("mileageID", $("#selectMileageID").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#keymanAmt").val(table.getData(0, 0));
      	}
	}

	/*
	function openVerifyState() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01001B"
				+"&eventYM="+$("#yearCD_S").val()+$("#monthCD_S").val()
				+"&venueCD="+$("#selectVenueCD").val()
				+"&diffNo="+$("#diffNo").val()
				+"&apprTpID="+$("#apprTpID").val();
		
		newWindow(url, "RLT01001B",600,350,"yes");
	}
	*/

	function openVerifyState() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PAY03003C"
				+"&mileageID="+$("#selectMileageID").val()
				+"&apprTpID="+$("#apprTpID").val()
		
		newWindow(url, "PAY03003C",600,350,"yes");
	}

	/*
	var _i_prd = 0;
	var _col_prd = {
		kindTpCD5Name : _i_prd++
		, prdNm : _i_prd++
		, factoryPrice : _i_prd++
		, qtyUnitCDName : _i_prd++
		, planQty : _i_prd++
		, rfidQty : _i_prd++
		, resultQty : _i_prd++
		, resultUnitAmt : _i_prd++
		, payAmt : _i_prd++
		, prdCD : _i_prd++
    };
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PAY0100503S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;planQty;"+
	  			"rfidQty;resultQty;resultUnitAmt;payAmt;prdCD;");
	  	table.setParameter("format",
	  			"str;str;num;str;num;"+
	  			"num;num;num;num;str;");
	  	//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("mileageID", $("#selectMileageID").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
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
					, table.getData(_col_prd.planQty,i)
					, table.getData(_col_prd.rfidQty,i)
					, table.getData(_col_prd.resultQty,i)
					, table.getData(_col_prd.resultUnitAmt,i)
					, table.getData(_col_prd.payAmt,i)
					, table.getData(_col_prd.prdCD,i)
      			];
      		}
      		grid_prd.setCellData(data);
      		grid_prd.setRowCount(rowCount);
      	}
      	grid_prd.refresh();
      	
      	changeResultTpCD($("#resultTpCD").val());
	}
	*/
	var _i_prd = 0;
	var _col_prd = {
		eventYM : _i_prd++	
		, kindTpCD5Name : _i_prd++
		, prdNm : _i_prd++
		, factoryPrice : _i_prd++
		, qtyUnitCDName : _i_prd++
		, contractQty : _i_prd++
		, plnEnterQty : _i_prd++
		, plnEnterUnitAmt : _i_prd++
		, plnAddEnterUnitAmt : _i_prd++
		, rltEnterQty : _i_prd++
		, rltEnterUnitAmt : _i_prd++
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
	  	table.setURL("${contextPath}/service/simpleAction/PAY0100503S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"eventYM;kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;contractQty;"+
	  			"plnEnterQty;plnEnterUnitAmt;plnAddEnterUnitAmt;rltEnterQty;rltEnterUnitAmt;addEnterUnitAmt;payAmt;addPayAmt;deleteBtn;prdCD;"+
	  			"eu;");
	  	table.setParameter("format",
	  			"eventYM;str;str;num;str;num5;"+
	  			"num;num;num;num;num;num;num;num;str;str;"+
	  			"num5;");
	  	table.setParameter("mileageID", $("#selectMileageID").val());
	  	table.request();
      	
// 	  	if (grid_prd != null) grid_prd.clear();
      	createGrid_prd();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					formatMonth(table.getData(_col_prd.eventYM,i))
					, table.getData(_col_prd.kindTpCD5Name,i)
					, table.getData(_col_prd.prdNm,i)
					, table.getData(_col_prd.factoryPrice,i)
      			    , table.getData(_col_prd.qtyUnitCDName,i)
					, table.getData(_col_prd.contractQty,i)
					, table.getData(_col_prd.plnEnterQty,i)
					, table.getData(_col_prd.plnEnterUnitAmt,i)
					, table.getData(_col_prd.plnAddEnterUnitAmt,i)
					, table.getData(_col_prd.rltEnterQty,i)
					, table.getData(_col_prd.rltEnterUnitAmt,i)
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
      	
		//maxRow_prd = rowCount;
      	maxRow_prd = rowCount;
	}
	
	function Save() {
		//등록, 반려, 검증오류인 경우에만 저장
		if($("#verifyStateCD").val() != "10" && $("#verifyStateCD").val() != "40" && $("#verifyStateCD").val() != "ERR") {
			alert("<fmt:message key="PAY01005A.msg1"/>");
			return;
		}
		
		if(grid_prd.getRowCount() == 0) {
			alert("<fmt:message key="info.nullData.save"/>");
			return;
		}
		
		//지급율120%초과, gsv10%이상
		var targetRate = parseFloat(unformat($("#targetRate").text()));
		var gsvRate = parseFloat(unformat($("#gsvRate").text()));
		/*
		if(targetRate > 120) {
			if($("#excPayTpCD").val() == "") {
				alert("<fmt:message key="PAY01005A.msg3"/>");
				$("#excPayTpCD").focus();
				return;
			}
		}
		*/
		//지급율이 가이드금액보다 크거나, 120%초과가 초과분지급이거나, GSV 항목이 붉은색 조건에 해당하는 경우는 Comment항목이 필수
		var payRate = parseFloat(unformat($("#payRate").val()));
		var guidPayRate = parseFloat(unformat($("#guidPayRate").val()));
		/*
		if(payRate > guidPayRate || $("#excPayTpCD").val()=="YPAY" || gsvRate > 10) {
			if($("#commt").val() == "") {
				alert("<fmt:message key="PAY01005A.msg4"/>");
				$("#commt").focus();
				return;
			}
		}
		*/
		//선지원(20)이 아닌경우

		//if($("#activityCD").val() != "20") {
			var payAmt_keyman = parseFloat(unformat($("#keymanAmt").val()));
			var tpayAmt = parseFloat(unformat($("#addContractAmt").text()));
			if(payAmt_keyman != tpayAmt) {
				alert("<fmt:message key="PAY01005A.msg2"/>");
				return;
			}
		//}
		
		var eventYMs = new Array();
		var prdCDs = new Array();
		var rltEnterQtys = new Array();
		var rltEnterUnitAmts = new Array();
		var addEnterUnitAmts = new Array();
		var payAmts = new Array();
		var addPayAmts = new Array();
		var contractQtys = new Array();
		var factoryPrices = new Array();
		var count = 0;
		for (var i=0; i<grid_prd.getRowCount(); i++) {
			eventYMs[count] = unformat(grid_prd.getCellText(_col_prd.eventYM, i));
			prdCDs[count] = grid_prd.getCellText(_col_prd.prdCD, i);
			rltEnterQtys[count] = grid_prd.getCellText(_col_prd.rltEnterQty, i);
			rltEnterUnitAmts[count] = grid_prd.getCellText(_col_prd.rltEnterUnitAmt, i);
			addEnterUnitAmts[count] = grid_prd.getCellText(_col_prd.addEnterUnitAmt, i);
			payAmts[count] = grid_prd.getCellText(_col_prd.payAmt, i);
			addPayAmts[count] = grid_prd.getCellText(_col_prd.addPayAmt, i);
			contractQtys[count] = grid_prd.getCellText(_col_prd.contractQty, i);
			factoryPrices[count] = grid_prd.getCellText(_col_prd.factoryPrice, i);
			count++;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay01/saveResultWriteMileage_err");
		table.setAsync(false);
		table.setRequestMethod("POST");
		//keymanAmtmileagePayTPCDcontractAmtcontractTaxAmtaddContractAmtaddContractTaxAmt
		table.setParameter("mileageID", $("#selectMileageID").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("verifyStateCD", $("#verifyStateCD").val());
		table.setParameter("contractAmt", $("#contractAmt").text());
		table.setParameter("contractTaxAmt", $("#contractTaxAmt").text());
		table.setParameter("addContractAmt", $("#addContractAmt").text());
		table.setParameter("addContractTaxAmt", $("#addContractTaxAmt").text());
		table.setParameter("mileagePayTPCD", $("#mileagePayTPCD").val());
		table.setParameter("commt", $("#commt").val());
		table.setParameter("eventYMs", eventYMs);
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("rltEnterQtys", rltEnterQtys);
		table.setParameter("rltEnterUnitAmts", rltEnterUnitAmts);
		table.setParameter("addEnterUnitAmts", addEnterUnitAmts);
		table.setParameter("payAmts", payAmts);
		table.setParameter("addPayAmts", addPayAmts);
		table.setParameter("contractQtys", contractQtys);
		table.setParameter("factoryPrices", factoryPrices);
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search_dtl();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	/*****************************************************
	*	define grid_rlt / data formats define
	*****************************************************/
	var columns_rlt = [
		"<fmt:message key="PAY01005A.mileageID"/>"
		, "<fmt:message key="PAY01005A.contractDate"/>"
		, "<fmt:message key="PAY01005A.contractMonthCt"/>"
		, "<fmt:message key="PAY01005A.venueCD"/>"
		, "<fmt:message key="PAY01005A.venueNm"/>"
		, "<fmt:message key="PAY01005A.venueGradCD"/>"
		, "<fmt:message key="PAY01005A.addrTpCD2"/>"
	];

	var grid_rlt = null;
	function createGrid_rlt() {
		grid_rlt = new AW.UI.Grid;
	    grid_rlt.setId("grid_rlt");
	    grid_rlt.setRowCount(0);
	    grid_rlt.setStyle("width","100%");
	    grid_rlt.setStyle("height","100%");
	    grid_rlt.setSelectorVisible(false);
	    grid_rlt.setSelectionMode("single-row");
	    grid_rlt.setHeaderText(columns_rlt);
	    for(var i=0;i<columns_rlt.length;i++){grid_rlt.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_rlt.setColumnCount(columns_rlt.length);
	    grid_rlt.setCellFormat([
	                        str, str, str, str, str
	                        , str, str
	                        ]);
	    grid_rlt.setCellEditable(false);
	    
	    grid_rlt.onRowDoubleClicked = function(event, row){
	    	$("#selectMileageID").val(this.getCellText(_col_rlt.mileageID,row));
	    	Search_dtl();
		};
    }
	
	var columns_prd = [
     		"<fmt:message key="MIL01002B.eventYM"/>"
     		, "<fmt:message key="MIL01002B.kindTpCD5"/>"
     		, "<fmt:message key="MIL01002B.prdNm"/>"
     		, "<fmt:message key="MIL01002B.factoryPrice"/>"
     		, "<fmt:message key="MIL01002B.qtyUnitCD"/>"
     		, "<fmt:message key="MIL01002B.contractQty"/>"
     		, "<fmt:message key="MIL01002B.plnEnterQty"/>"
     		, "<fmt:message key="MIL01002B.plnEnterUnitAmt"/>"
     		, "<fmt:message key="MIL01002B.plnAddEnterUnitAmt"/>"
     		, "<fmt:message key="MIL01002B.rltEnterQty"/>"
     		, "<fmt:message key="MIL01002B.rltEnterUnitAmt"/>"
     		, "<fmt:message key="MIL01002B.addEnterUnitAmt"/>"
     		, "<fmt:message key="MIL01002B.payAmt"/>"
     		, "<fmt:message key="MIL01002B.addPayAmt"/>"
     	//	, "<fmt:message key="MIL01002B.deleteBtn"/>"
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
           str, str, str, num, str, num5
           , num, num, num, num, num, num, num, num, str, str
           , num5
           ]);
	    grid_prd.setCellEditable(true);
	    grid_prd.setCellEditable(false, _col_prd.kindTpCD5Name);
	    grid_prd.setCellEditable(false, _col_prd.prdNm);
	    grid_prd.setCellEditable(false, _col_prd.factoryPrice);
	    grid_prd.setCellEditable(false, _col_prd.qtyUnitCDName);
	    grid_prd.setCellEditable(false, _col_prd.contractQty);
	    grid_prd.setCellEditable(false, _col_prd.plnEnterQty);
	    grid_prd.setCellEditable(false, _col_prd.plnEnterUnitAmt);
	    grid_prd.setCellEditable(false, _col_prd.plnAddEnterUnitAmt);
	    grid_prd.setCellEditable(false, _col_prd.rltEnterQty);
	    grid_prd.setCellEditable(false, _col_prd.rltEnterUnitAmt);
	    
	    grid_prd.setCellEditable(false, _col_prd.payAmt);
	    grid_prd.setCellEditable(false, _col_prd.addPayAmt);
	    grid_prd.setCellEditable(false, _col_prd.deleteBtn);
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
			if (col == _col_prd.rltEnterQty || col == _col_prd.enterUnitAmt) {
				this.setCellText(unformatNum(text), col, row);
			}
		};
		
		grid_prd.onCellValidating = function(text, col, row) {
			if (col == _col_prd.rltEnterQty) {
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
	    	if (col == _col_prd.rltEnterQty) {
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