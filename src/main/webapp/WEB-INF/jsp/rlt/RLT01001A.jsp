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
											<col style="width:200px;"></col>
											<col style="width:100px;"></col>
											<col style="width:200px;"></col>
											<col style="width:100px;"></col>
										<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="RLT01001A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" event="onchange" eventproc="getResultWriteDate();" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" event="onchange" eventproc="getResultWriteDate();" />
				                                </td>
				                            	<td class="td-cond">
													<fmt:message key="RLT01001A.activityCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
												</td>
												<td class="td-cond">
													<fmt:message key="RLT01001A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="RLT01001A.addrTpCD1" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
												</td>
												<td class="td-cond">
													<fmt:message key="RLT01001A.addrTpCD2" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
												</td>
												<td class="td-cond">
													<fmt:message key="RLT01001A.apprStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="none" category="APPRSTATECD" />
												</td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="RLT01001A.venue" />
												</td>
												<td class="td-input" colspan="5">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
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
                		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                			<colgroup>
			        			<col style="width:110px;"></col>
			        			<col style="width:200px;"></col>
			        			<col></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="RLT01001A.resultWriteDate" />
									</td>
									<td class="tit_text01">
										<span id="resultWriteDate_S" />
	                                </td>
	                                <td class="tit_text01" >
										<fmt:message key="RLT01001A.msg8" />
	                                </td>
	                            </tr>
			        		</tbody>
		        		</table>
                	</td>
                </tr>
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
									        			<col style="width:130px;"></col>
									        			<col style="width:130px;"></col>
									        			<col style="width:130px;"></col>
									        			<col style="width:110px;"></col>
									        			<col></col>
									        		</colgroup>
							        				<tbody>
						                            	<tr>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.programCD" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.activityCD" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.venueCD" />
															</td>
															<td class="td-cond-report" colspan="2">
																<fmt:message key="RLT01001A.venueNm" />
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-report-rborder">
																&nbsp;<span id="programCDName"></span>
																<input type="hidden" id="programCD" name="programCD" />
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="activityCDName"></span>
																<input type="hidden" id="activityCD" name="activityCD" />
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="venueCD"></span>
															</td>
															<td class="td-report-rborder" colspan="2">
																&nbsp;<span id="venueNm"></span>
															</td>
														</tr>
														<!-- 	<tr>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.planQty" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.resultTQty" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.targetRate" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.payRate" />
															</td>
															<td id="excPayTpCD_td" class="td-cond-report">
																<fmt:message key="RLT01001A.excPayTpCD" />
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="planTQty"></span>
																<input type="hidden" id="planBtlTQty" name="planBtlTQty" />
															</td>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="resultTQty"></span>
																<input type="hidden" id="resultBtlTQty" name="resultBtlTQty" />
															</td>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="targetRate"></span>
															</td>
															<td class="td-report-rborder" style="text-align:right;"> -->
<!-- 																&nbsp;<span id="payRate"></span> -->
<!-- 																&nbsp;<span id="payRate"></span> -->
																<!-- 
																<input type="text" id="payRate" name="payRate" style="width:100px; height:17px; ime-mode:disabled; text-align:right;" maxlength="5" onchange="setPayRate();calculateTpayAmt();" />
																 -->
<!-- 																<input type="hidden" id="guidPayRate" name="guidPayRate" />
															</td>
															<td class="td-report-rborder">
																<nis:selectbox id="excPayTpCD" name="excPayTpCD" defaultText="select" category="EXCPAYTPCD" style="height:17px;" event="onchange" eventProc="changeExcPayTpCD(this.value);calculateTpayAmt();" />
															</td>
														</tr>-->
														<tr>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.tpayAmt" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.resultTpCD" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.gsvRate" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.keyman" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.apprStateCD" />
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="tpayAmt"></span>
																<input type="hidden" id="payAmt_keyman" name="payAmt_keyman" />
															</td>
															<td class="td-report-rborder" style="text-align:center;">
																<nis:selectbox id="resultTpCD" name="resultTpCD" defaultText="none" category="RESULTTPCD" style="height:17px;" event="onchange" eventProc="changeResultTpCD(this.value);" />
															</td>
															<td id="gsvRate_td" class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="gsvRate"></span>
															</td>
															<td class="td-report-rborder" style="text-align:center;">
																&nbsp;<span id="keyman_btn"></span>
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="apprStateCDName"></span>
																<input type="hidden" id="apprStateCD" name="apprStateCD" />
															</td>
														</tr>
			                            				<tr>
			                            						<td class="td-cond-report">
																<fmt:message key="RLT01001A.resultTQty" />
															</td>
			                            						<td class="td-report-rborder" style="text-align:right;">
																&nbsp;<span id="resultTQty"></span>
																<input type="hidden" id="resultBtlTQty" name="resultBtlTQty" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="RLT01001A.commt" />
															</td>
															<td class="td-report-rborder" colspan="2">
																<input type="text" id="commt" name="commt" style="width:320px; height:17px;" maxlength="100" />
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
						<input type="hidden" id="apprTpID" name="apprTpID" value="000000" /><!-- Plan/Result승인라인 -->
						<input type="hidden" id="resultWriteYN" name="resultWriteYN" />
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="officeCD" name="officeCD" />
						<input type="hidden" id="ltcTotalEnterQty" name="ltcTotalEnterQty" />
						<input type="hidden" id="ltcTotalResultQty" name="ltcTotalResultQty" />
						<input type="hidden" id="contractDateFrom" name="contractDateFrom" />
						<input type="hidden" id="contractDateTo" name="contractDateTo" />
						<input type="hidden" id="ltcSupportID" name="ltcSupportID" />
						<input type="hidden" id="incentive_keyman" name="incentive_keyman" />
						<input type="hidden" id="tincentive" name="tincentive" />
						<input type="hidden" id="ltcFlg" name="ltcFlg" />
						<input type="hidden" id="LocalRmnamt" name="LocalRmnamt" />
						<input type="hidden" id="InterRmnamt" name="InterRmnamt" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid_rlt .aw-column-0 {width: 60px; text-align:center;}
	#grid_rlt .aw-column-1 {width: 100px; text-align:left;}
    #grid_rlt .aw-column-2 {width: 80px; text-align:center;}
    #grid_rlt .aw-column-3 {width: 100px; text-align:left;}
    #grid_rlt .aw-column-4 {width: 60px; text-align:center;}
    #grid_rlt .aw-column-5 {width: 100px; text-align:center;}
    #grid_rlt .aw-column-6 {width: 120px; text-align:right;}
    
    #grid_prd .aw-column-0 {width: 90px; text-align:left;}
    #grid_prd .aw-column-1 {width: 110px; text-align:left;}
    #grid_prd .aw-column-2 {width: 90px; text-align:right;}
	#grid_prd .aw-column-3 {width: 80px; text-align:center;}
/*     #grid_prd .aw-column-4 {width: 80px; text-align:right;} */
/*     #grid_prd .aw-column-5 {width: 80px; text-align:right;} */
    #grid_prd .aw-column-4 {width: 80px; text-align:right;}
    #grid_prd .aw-column-5 {width: 80px; text-align:right;}
    #grid_prd .aw-column-6 {width: 80px; text-align:right;}
    #grid_prd .aw-column-7 {width: 120px; text-align:right;}
    #grid_prd .aw-column-8 {width: 120px; text-align:right;}
    #grid_prd .aw-column-9 {width: 100px; text-align:right;}
    #grid_prd .aw-column-10 {width: 100px; text-align:right;}
    #grid_prd .aw-column-11 {width: 100px; text-align:right;}
    #grid_prd .aw-column-12 {width: 100px; text-align:right;}

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
		//$("#payRate").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid_rlt();
			grid_rlt.refresh();
			
			createGrid_prd();
			grid_prd.refresh();
			
			btnSave.setControlDisabled(true);
			btnResultCreation.setControlDisabled(true);
			
			if("${params.eventym}"==""){
				$("#yearCD_S").val("${params.clientDate}".substring(0,4));
				$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			}else{
				$("#yearCD_S").val("${params.eventym}".substring(0,4));
				$("#monthCD_S").val("${params.eventym}".substring(4,6));
			}
			
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
			$("#apprStateCD_S").val("10");
			getResultWriteYN();
			getResultWriteDate();
			
			if("${params.eventym}"!=""){
				$("#apprStateCD_S").val("40");
    			Search();
    		}
		};

		${initScript}
		
		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
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
	
	//초과분구분 set
	//YPAY:초과분지급이면, 빨간바탕처리
	function changeExcPayTpCD(val) {
		/* 
		if(val == "YPAY") {
			$("#excPayTpCD").css("background","ff0000");
			$("#excPayTpCD").css("color","ffffff");
		}
		else {
			$("#excPayTpCD").css("background","ffffff");
			$("#excPayTpCD").css("color","000000");
		}
		 */
	}
	
	//실적구분 set
	//RFID이면 rfid수량을 result수량으로 하고, result수량 수정금지
	function changeResultTpCD(val) {
		if(val == "10") {
			for(var i=0; i<grid_prd.getRowCount(); i++) {
				grid_prd.setCellText(grid_prd.getCellText(_col_prd.rfidQty, i), _col_prd.inputQty, i);
			}
			grid_prd.setCellEditable(false, _col_prd.inputQty);
		}
		else {
			grid_prd.setCellEditable(true, _col_prd.inputQty);
		}
	}
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
	function getResultWriteYN() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "02");		//01:plan,02:result
		table.request();
		
		if(table.getCount() > 0) {
			$("#resultWriteYN").val(table.getData(0,0));
			if(table.getData(0,0) == "Y") {
				btnSave.setControlDisabled(false);
				btnResultCreation.setControlDisabled(false);
			}
			else {
				btnSave.setControlDisabled(true);
				btnResultCreation.setControlDisabled(true);
			}
		}
	}
	
	function getResultWriteDate() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03002S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "02");		//01:plan,02:result
		table.request();
		
		var s = "";
	  	if (table.getCount() > 0) {
	  		s = "<select id='resultWriteDate_S' name='resultWriteDate_S'>";
		  	for (var i=0; i < table.getCount(); i++) {
		  		s += "<option>"+table.getData(0,i)+"</option>";
		  	}
	  	}
	  	else {
	  		 s = "<select id='resultWriteDate_S' name='resultWriteDate_S'><option value=''><fmt:message key="nothing"/></option>";
	  	}
	  	s += "</select>";
	  	$("#resultWriteDate_S").html(s);
	}
	
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
		if($("#selectVenueCD").val() != "") {
			var tpayAmt = unformat($("#tpayAmt").text());
			var venueCD = $("#venueCD").text();
			var diffNo = $("#diffNo").val();
			var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
			var apprStateCD = $("#apprStateCD").val();
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01001C"
					+"&tpayAmt="+tpayAmt+"&venueCD="+venueCD+"&diffNo="+diffNo+"&eventYM="+eventYM
					+"&apprStateCD="+apprStateCD;
			newWindow(url, "RLT01001C",700,550,"yes");
		}
	}
	
	function New() {
		$("#programCDName").text("");
		$("#activityCDName").text("");
		$("#venueCD").text("");
		$("#venueNm").text("");
		//$("#planTQty").text("0");
		$("#resultTQty").text("0");
		//$("#planBtlTQty").text("0");
		$("#resultBtlTQty").text("0");
		//$("#targetRate").text("0");
		//$("#payRate").text("0");
		//$("#payRate").val("0");
		//$("#payRate").css("background","#ffffff");
 		//$("#payRate").css("color","#00000");
		//$("#guidPayRate").val("0");
		//$("#excPayTpCD").val("");
		//changeExcPayTpCD("");
		$("#tpayAmt").text("0");
		$("#resultTpCD").val("");
		changeResultTpCD("");
		$("#gsvRate").text("0");
		$("#apprStateCDName").text("");
		$("#apprStateCD").val("");
		$("#commt").val("");
		$("#programCD").val("");
		$("#activityCD").val("");
		
		$("#gsvRate_td").css("background","#ffffff");
		$("#gsvRate").css("color","#00000");
		
		createGrid_prd();
		grid_prd.refresh();
	}
	
	function calculateResultQty(row) {
		if(grid_prd.getCellText(_col_prd.inputQty, row)==""){
			grid_prd.setCellText("0", _col_prd.inputQty, row);
		}
		if(grid_prd.getCellText(_col_prd.inputAmt, row)==""){
			grid_prd.setCellText("0", _col_prd.inputAmt, row);
		}
		var inputQty = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.inputQty, row)));
		var qtyUnitCDName = grid_prd.getCellText(_col_prd.qtyUnitCDName, row);
		var unit = grid_prd.getCellText(_col_prd.unit,row);
		
		if(qtyUnitCDName=='AC'){
			grid_prd.setCellText(formatNum(Math.round(inputQty / unit * 10)/10),_col_prd.resultQty, row);
		}else{
			grid_prd.setCellText(formatNum(inputQty), _col_prd.resultQty, row);
		}
		calculateResultUnitAmt(row);
	}
	
	function calculateResultUnitAmt(row) {
		var resultQty = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.resultQty, row)));
		var inputAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.inputAmt, row)));
		if(inputAmt==0 || resultQty==0){
			grid_prd.setCellText(0, _col_prd.resultUnitAmt, row);
		}else{
			if(resultQty<1){
				grid_prd.setCellText(formatNum(Math.floor(inputAmt*resultQty)),_col_prd.resultUnitAmt, row);
			}else{
				grid_prd.setCellText(formatNum(Math.floor(inputAmt/resultQty)),_col_prd.resultUnitAmt, row);
			}
		}
		calculateTotalAmt(row);
	}
	
	//총액(인센티브 금액) 계산
	function calculateTotalAmt(row) {
		if(grid_prd.getCellText(_col_prd.resultQty, row)==""){
			grid_prd.setCellText("0", _col_prd.resultQty, row);
		}
		var inputAmt = parseFloat(unformatNum(grid_prd.getCellText(_col_prd.inputAmt, row)));
		var totalAmt = 0;
		if(parseFloat(grid_prd.getCellText(_col_prd.resultQty, row)) != 0){			
			totalAmt = Math.floor(inputAmt * 0.03);
		}
			grid_prd.setCellText(formatNum(totalAmt), _col_prd.totalAmt, row);
		
		calculateIncomeTax(row);
	}
	
	//소득세 계산
	function calculateIncomeTax(row) {
		var totalAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.totalAmt, row)));
		var incomeTax = 0;
		incomeTax = Math.floor(totalAmt * 0.03/10)*10;
		grid_prd.setCellText(formatNum(incomeTax), _col_prd.incomeTax, row);
		
		calculateResidentTax(row);
	}
	
	//주민세 계산
	function calculateResidentTax(row) {
		var incomeTax = parseFloat(unformat(grid_prd.getCellText(_col_prd.incomeTax, row)));
		var residentTax = 0;
		residentTax = Math.floor(incomeTax * 0.1/10)*10;
		grid_prd.setCellText(formatNum(residentTax), _col_prd.residentTax, row);
		
		calculateWithholdingTax(row);
	}
	
	//원천징수세액 계산
	function calculateWithholdingTax(row) {
		var incomeTax = parseFloat(unformat(grid_prd.getCellText(_col_prd.incomeTax, row)));
		var residentTax = parseFloat(unformat(grid_prd.getCellText(_col_prd.residentTax, row)));
		var withholdingTax = 0;
		withholdingTax = incomeTax + residentTax;
		grid_prd.setCellText(formatNum(withholdingTax), _col_prd.withholdingTax, row);
		
		calculatePayAmt(row);
	}
	
	//keyman 지급액 계산
	function calculatePayAmt(row) {
		var totalAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.totalAmt, row)));
		var withholdingTax = parseFloat(unformat(grid_prd.getCellText(_col_prd.withholdingTax, row)));
		var payAmt = 0;
		payAmt = totalAmt-withholdingTax;
		grid_prd.setCellText(formatNum(payAmt), _col_prd.payAmt, row);
		
		setLimitQtyFlag(row);
	}
	
	//제품 분류 별 목표 수량 미 달성 시 limitQtyFlag 변환 처리
	function setLimitQtyFlag(row){
		var kindTpCD5 = grid_prd.getCellText(_col_prd.kindTpCD5, row);
		var limitQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.limitQty, row)));
		var resultQty = 0;
		
		for(var i=0; i<grid_prd.getRowCount();i++){
			if(kindTpCD5 == grid_prd.getCellText(_col_prd.kindTpCD5, i)){
				resultQty +=  parseFloat(unformatNum(grid_prd.getCellText(_col_prd.resultQty, i)));
			}
		}
		
		for(var i=0; i<grid_prd.getRowCount();i++){
			if(resultQty < limitQty){
				if(kindTpCD5 == grid_prd.getCellText(_col_prd.kindTpCD5, i)){
					grid_prd.setCellText('N',_col_prd.limitQtyFlag, i);
					grid_prd.setCellText(0, _col_prd.totalAmt, i);
					grid_prd.setCellText(0, _col_prd.incomeTax, i);
					grid_prd.setCellText(0, _col_prd.residentTax, i);
					grid_prd.setCellText(0, _col_prd.withholdingTax, i);
					grid_prd.setCellText(0, _col_prd.payAmt, i);
				}
			}else{
				if(kindTpCD5 == grid_prd.getCellText(_col_prd.kindTpCD5, i)){
					if(grid_prd.getCellText(_col_prd.limitQtyFlag, i)=="N"){					
						grid_prd.setCellText('Y',_col_prd.limitQtyFlag, i);
						calculateTotalAmt(i);
					}
				}
			}    
		}
		calculateTpayAmt();
	}
	
	//지급금액 계산
	//120%초과 초과분미지급이면, (실적지급액 * 지급률) / 달성률 * 1.2
	//120%초과 초과분지급이면(선택인경우도 지급), 실적지급액 * 지급률
	//2019.04 달성률에 따른 지급율로 RESULT단가 수정 하기로 변경 12%초과 지급 없음.
	//2019.08 계산로직 수정
	
	function calculateTpayAmt() {
			 var tpayAmt = 0;
			 
			 for(var i=0; i<grid_prd.getRowCount(); i++) {
					 tpayAmt += parseFloat(unformat(grid_prd.getCellText(_col_prd.payAmt, i)));
			}
			 
			 $("#tpayAmt").text(formatNum(Math.round(tpayAmt)));
			 
			 calculateGsvRate();
			 calculateResultTQty();
	}
	
	//당월Result 총수량 계산
	function calculateResultTQty() {
		var resultTQty = 0;
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			resultTQty += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.inputQty, i)));
		}
		$("#resultTQty").text(formatNum(resultTQty));
	}
	
	//달성률 계산 - 사용안함
	/*
	function calculateTargetRate() {
		var targetRate = 0;
		//var resultTQty = parseFloat(unformat($("#resultTQty").text()));
		var planTQty = parseFloat(unformat($("#planTQty").text()));
		var resultBtlTQty = parseFloat(unformat($("#resultBtlTQty").val()));
		var planBtlTQty = parseFloat(unformat($("#planBtlTQty").val()));
		//if(planTQty==0) {
		if(planBtlTQty==0) {
			targetRate = 0;
		}else if(resultBtlTQty==0){
			targetRate = 0;
		}else {
			//targetRate = (resultTQty / planTQty) * 100;
			targetRate = (resultBtlTQty / planBtlTQty) * 100;
		}
		$("#targetRate").text(Math.round(targetRate));
		
		getPayRate();
		setExcPayTpCD();
		calculateTpayAmt();
	}
	*/
	
	//지급율 가져오기-사용안함
	/*
	function getPayRate() {
		var activityCD = $("#activityCD").val();
		if(activityCD == 20){
	     	$("#guidPayRate").val("100");
	     	//$("#payRate").val("100");
	     	$("#payRate").text("100");
		}else{
			var table = new AW.XML.Table;
			//table.setURL("${contextPath}/service/simpleAction/COM03007S");
			table.setURL("${contextPath}/service/simpleAction/COM03016S");
			table.setAsync(false);
			table.setRequestMethod("POST");
		  	table.setParameter("targetRate", $("#targetRate").text());
	     	table.request();
	     	$("#guidPayRate").val(table.getData(0,0));
	     	//$("#payRate").val(table.getData(0,0));
	     	$("#payRate").text(table.getData(0,0));
		}
     	
     	setPayRate();
	}
	*/
	
	//사용안함
	/*
	function setPayRate() {
		var activityCD = $("#activityCD").val();
     	if(activityCD == 20){
    		//$("#payRate").val("100");
    		$("#payRate").text("100");
    	}
     	
		//if($("#payRate").val() == "") {
     	//	$("#payRate").val("0");
     	//}
		if($("#payRate").text() == "") {
     		$("#payRate").text("0");
     	}
		else {
			//if(parseFloat(unformatNum($("#payRate").val())) > 100) {
			if(parseFloat(unformatNum($("#payRate").text())) > 100) {
				alert("<fmt:message key="RLT01001A.msg7"/>");
				//$("#payRate").val("100");
				$("#payRate").text("100");
			}
		}
		
		var guidPayRate = parseFloat(unformatNum($("#guidPayRate").val()));
     	//var payRate = parseFloat(unformatNum($("#payRate").val()));
     	var payRate = parseFloat(unformatNum($("#payRate").text()));
     	
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
		$("#excPayTpCD").val("");
		changeExcPayTpCD("");
		$("#excPayTpCD").attr("disabled",true);
		$("#excPayTpCD").addClass("input-readonly");
		$("#excPayTpCD_td").removeClass("td-cond-report-required");
		/* 
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
		 */
	
	/*
	function calculateTpayAmt() {
		var payAmt = 0;
		var tpayAmt = 0;
		//var payRate = parseFloat(unformat($("#payRate").val())) / 100;
		//var payRate = parseFloat(unformat($("#payRate").text())) / 100;
		//var targetRate = parseFloat(unformat($("#targetRate").text())) / 100;
		
		for(var i=0; i<grid_prd.getRowCount(); i++) {

			var resultQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.resultQty, i)));
			var tempUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.planUnitAmt, i))) * payRate;
			var tempAmt = resultQty * tempUnitAmt;// * payRate;

			grid_prd.setCellText(tempUnitAmt, _col_prd.resultUnitAmt, i);
			grid_prd.setCellText(tempAmt, _col_prd.payAmt, i);
			payAmt += parseFloat(unformat(grid_prd.getCellText(_col_prd.payAmt, i)));
		}
		*/
		/* 
		if($("#excPayTpCD").val() == "NPAY") {
			tpayAmt = (payAmt * payRate) / targetRate * 1.2;
		}
		else {
			tpayAmt = payAmt * payRate;
		}
		$("#tpayAmt").text(formatNum(Math.round(tpayAmt)));
		 
		$("#tpayAmt").text(formatNum(Math.round(payAmt)));
		
		calculateGsvRate();
		//calculateNGsvRate();
	}
		*/
	
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
	
	/*
	function calculateNGsvRate() {
		var gsv = 0;
		var unitamt = 0;
		var resultQty = 0;
		var lTotalGsv = 0;
		var lNgsv = 0;
		var iTotalGsv = 0;
		var iNgsv = 0;
		var venueNGSV = 0;
		var kindtpcd = "";
		 
		for(var i=0; i<grid_prd.getRowCount(); i++) {
		gsv = parseFloat(unformat(grid_prd.getCellText(_col_prd.gsv, i)));
		unitamt = parseFloat(unformat(grid_prd.getCellText(_col_prd.resultUnitAmt, i)));
		resultQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.resultQty, i)));
		
		totalgsv += resultQty * unitamt;
		ngsv += resultQty * gsv;
		
		}
		if(totalgsv == 0 || ngsv == 0){
			venueNGSV = venueNGSV +" %";
			$("#venueNGSV").text(venueNGSV);
		}else{
			venueNGSV = Math.round(totalgsv/ngsv*100);
			venueNGSV = venueNGSV +" %";
			$("#venueNGSV").text(venueNGSV);
		}
		 
		for(var i=0; i<grid_prd.getRowCount(); i++) {
			kindtpcd = parseFloat(unformat(grid_prd.getCellText(_col_prd.kindtpcd, i)));
			gsv = parseFloat(unformat(grid_prd.getCellText(_col_prd.gsv, i)));
			unitamt = parseFloat(unformat(grid_prd.getCellText(_col_prd.resultUnitAmt, i)));
			resultQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.resultQty, i)));
		
			if(kindtpcd == '10'){
				lTotalGsv += resultQty * unitamt;
				lNgsv += resultQty * gsv;
			}else{
				iTotalGsv += resultQty * unitamt;
				iNgsv += resultQty * gsv;
			}
		}
		if(lTotalGsv == 0 || lNgsv == 0){
			venueNGSV = "0 %";
			$("#LvenueNGSV").text(venueNGSV);
		}else{
			var LocalRmnamt = $("#LocalRmnamt").val();
			lTotalGsv += parseFloat(unformat(LocalRmnamt));
			venueNGSV = Math.round(lTotalGsv/lNgsv*100);
			venueNGSV = venueNGSV +" %";
			$("#LvenueNGSV").text(venueNGSV);
		}
		
		if(iTotalGsv == 0 || iNgsv == 0){
			venueNGSV = "0 %";
			$("#IvenueNGSV").text(venueNGSV);
		}else{
			var interRmnamt = $("#InterRmnamt").val();
			iTotalGsv += parseFloat(unformat(interRmnamt));
			venueNGSV = Math.round(iTotalGsv/iNgsv*100);
			venueNGSV = venueNGSV +" %";
			$("#IvenueNGSV").text(venueNGSV);
		}
		
		
	}
	*/
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

	function PayHistory() {
		if(grid_rlt.getCellText(_col_rlt.venueCD, grid_rlt.getSelectedRows()) == ""){
			alert("업소를 선택하여 주십시오.");
			return;
		}
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var venueCD = grid_rlt.getCellText(_col_rlt.venueCD, grid_rlt.getSelectedRows());
		var venueNm = grid_rlt.getCellText(_col_rlt.venueNm, grid_rlt.getSelectedRows());

		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=ANL01009A"
			+"&diffNo="+diffNo+"&eventYM="+eventYM+"&venueCD="+venueCD+"&venueNm="+venueNm;
		
		newWindow(url, "ANL01009A",1080,750,"yes");
	}

	function ApprovalHistory(){
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PLN02001B"
			+"&diffNo="+diffNo+"&eventYM="+eventYM+"&rltYN=Y";
		
		newWindow(url, "PLN02001B",1080,520,"yes");
	}
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function ResultCreation() {
		showLoading();
		if(!confirm("<fmt:message key="RLT01001A.msg6"/>")) {
			hideLoading();
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt01/resultCreationVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("incntTpCD", $("#incntTpCD").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			hideLoading();
			Search();
   		}
		else {
			hideLoading();
			alert(table.getData(1,0));
		}
		hideLoading();
	}
	
	function Search() {
		Search_rlt();
	}
	
	var _i_rlt = 0;
	var _col_rlt = {
		programCDName : _i_rlt++
		, activityCDName : _i_rlt++
		, venueCD : _i_rlt++
		, venueNm : _i_rlt++
		, venueGradCDName : _i_rlt++
		, addrTpCD2Name : _i_rlt++
		, keymanAmt : _i_rlt++
		, chgID : _i_rlt++
		, officeCD : _i_rlt++
    };
	function Search_rlt() {
		getResultWriteYN();
		getResultWriteDate();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0100103S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"programCDName;activityCDName;venueCD;venueNm;venueGradCDName;"+
	  			"addrTpCD2Name;keymanAmt;chgID;officeCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;num;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD").val());
	  	table.request();
      	
// 	  	if (grid_rlt != null) grid_rlt.clear();
      	createGrid_rlt();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#officeCD").val(table.getData(_col_rlt.officeCD, 0));      		
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					table.getData(_col_rlt.programCDName,i)
					, table.getData(_col_rlt.activityCDName,i)
      			    , table.getData(_col_rlt.venueCD,i)
					, table.getData(_col_rlt.venueNm,i)
					, table.getData(_col_rlt.venueGradCDName,i)
					, table.getData(_col_rlt.addrTpCD2Name,i)
					, table.getData(_col_rlt.keymanAmt,i)
					, table.getData(_col_rlt.chgID,i)
					, table.getData(_col_rlt.officeCD,i)
      			];
      			if(table.getData(_col_rlt.chgID,i) != ""){
      				grid_rlt.getCellTemplate(_col_rlt.programCDName,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.activityCDName,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.venueCD,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.venueNm,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.venueGradCDName,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.addrTpCD2Name,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.keymanAmt,i).setStyle("font-weight", "bold");
          		}
      		}
      		grid_rlt.setCellData(data);
      		grid_rlt.setRowCount(rowCount);
      	}
      	grid_rlt.refresh();
      	
      	New();
	}
	
	var _i_dtl = 0;
	var _col_dtl = {
		programCDName : _i_dtl++
		, activityCDName : _i_dtl++
		, venueCD : _i_dtl++
		, venueNm : _i_dtl++
		//, planTQty : _i_dtl++
		, resultTQty : _i_dtl++
		//, targetRate : _i_dtl++
		//, payRate : _i_dtl++
		//, excPayTpCD : _i_dtl++
		, tpayAmt : _i_dtl++
		, resultTpCD : _i_dtl++
		, gsvRate : _i_dtl++
		, apprStateCDName : _i_dtl++
		, apprStateCD : _i_dtl++
		, programCD : _i_dtl++
		, activityCD : _i_dtl++
		, payAmt_keyman : _i_dtl++
		//, guidPayRate : _i_dtl++
		, commt : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0100104S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"programCDName;activityCDName;venueCD;venueNm;"+//"planTQty;"+
	  			"resultTQty;"+
	  			//"targetRate;payRate;excPayTpCD;"+
	  			"tpayAmt;"+
	  			"resultTpCD;gsvRate;apprStateCDName;apprStateCD;programCD;"+
	  			"activityCD;payAmt_keyman;"+
	  			//"guidPayRate;"+
	  			"commt;");
	  	table.setParameter("format",
	  			"str;str;str;str;" + //"num;"+
	  			"num;"+
	  			//"num;num;str;"+
	  			"num;"+
	  			"str;num;str;str;str;"+
	  			"str;str;"+
	  			//"num;"+
	  			"str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#programCDName").text(table.getData(_col_dtl.programCDName, 0));
      		$("#activityCDName").text(table.getData(_col_dtl.activityCDName, 0));
      		$("#venueCD").text(table.getData(_col_dtl.venueCD, 0));
      		$("#venueNm").text(table.getData(_col_dtl.venueNm, 0));
      		//$("#planTQty").text(table.getData(_col_dtl.planTQty, 0));
      		$("#resultTQty").text(table.getData(_col_dtl.resultTQty, 0));
      		//$("#targetRate").text(table.getData(_col_dtl.targetRate, 0));
      		//$("#payRate").val(table.getData(_col_dtl.payRate, 0));
      		//$("#payRate").text(table.getData(_col_dtl.payRate, 0));
      		//$("#guidPayRate").val(table.getData(_col_dtl.guidPayRate, 0));
      		//setPayRate();
      		//$("#excPayTpCD").val(table.getData(_col_dtl.excPayTpCD, 0));
      		//setExcPayTpCD();
      		//changeExcPayTpCD(table.getData(_col_dtl.excPayTpCD, 0));
      		$("#tpayAmt").text(table.getData(_col_dtl.tpayAmt, 0));
      		$("#resultTpCD").val(table.getData(_col_dtl.resultTpCD, 0));
      		$("#gsvRate").text(table.getData(_col_dtl.gsvRate, 0));
      		setGsvRate_td(table.getData(_col_dtl.gsvRate, 0));
      		
      		if(table.getData(_col_dtl.apprStateCD, 0) == "10") {
	      		$("#apprStateCDName").text(table.getData(_col_dtl.apprStateCDName, 0));
      		}
      		else {
      			$("#apprStateCDName").html("<a href='javascript:openApprState();'>"+table.getData(_col_dtl.apprStateCDName, 0)+"</a>");
      		}
      		
      		$("#apprStateCD").val(table.getData(_col_dtl.apprStateCD, 0));
      		$("#programCD").val(table.getData(_col_dtl.programCD, 0));
      		$("#activityCD").val(table.getData(_col_dtl.activityCD, 0));
      		$("#payAmt_keyman").val(table.getData(_col_dtl.payAmt_keyman, 0));
      		$("#commt").val(table.getData(_col_dtl.commt, 0));
      		
			/*	result 승인처리가 미등록, 등록, 반려가 아닌경우에는 수정 불가
			("":미등록, 10:등록, 40:반려)
			*/
			var apprStateCD = table.getData(_col_dtl.apprStateCD, 0);
			if($("#resultWriteYN").val()=="Y") {
				if(apprStateCD!="" && apprStateCD!="10" && apprStateCD!="40") {
					btnSave.setControlDisabled(true);
				}
				else {
					btnSave.setControlDisabled(false);
				}
 			}
			
			//선지원(20)인 경우 keyman 미등록
			if(table.getData(_col_dtl.activityCD, 0) == "20") {
				$("#keyman_btn").hide();
			}
			else {
				$("#keyman_btn").show();
			}
			
			Search_prd();
      	}
	}
	
	function CloseKeymanPopup() {
		Search_keymanAmt();
	}
	
	function Search_keymanAmt() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0100104S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"payAmt_keyman;");
	  	table.setParameter("format",
	  			"num;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#payAmt_keyman").val(table.getData(0, 0));
      	}
	}
	
	function openApprState() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01001B"
				+"&eventYM="+$("#yearCD_S").val()+$("#monthCD_S").val()
				+"&venueCD="+$("#selectVenueCD").val()
				+"&diffNo="+$("#diffNo").val()
				+"&apprTpID="+$("#apprTpID").val();
		
		newWindow(url, "RLT01001B",600,350,"yes");
	}
	
	var _i_prd = 0;
	var _col_prd = {
		kindTpCD5Name : _i_prd++
		, prdNm : _i_prd++
		, factoryPrice : _i_prd++
		, qtyUnitCDName : _i_prd++
		//, planQty : _i_prd++
		//, rfidQty : _i_prd++
		, inputQty : _i_prd++
		, inputAmt : _i_prd++
		, resultQty : _i_prd++
		, resultUnitAmt : _i_prd++
		, payAmt : _i_prd++
		, incomeTax : _i_prd++
		, residentTax : _i_prd++
		, withholdingTax : _i_prd++
		, totalAmt : _i_prd++
		, prdCD : _i_prd++
		, unit : _i_prd++
		, planUnitAmt : _i_prd++
		, gsv : _i_prd++
		, kindtpcd : _i_prd++
		, kindTpCD5 : _i_prd++
		, limitQty : _i_prd++
		, limitQtyFlag : _i_prd++
    };
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0100105S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;"+
	  			"inputQty;inputAmt;resultQty;resultUnitAmt;payAmt;incomeTax;"+
	  			"residentTax;withholdingTax;totalAmt;prdCD;"+
	  			"unit;planUnitAmt;gsv;kindtpcd;kindTpCD5;limitQty;");
	  	table.setParameter("format",
	  			"str;str;num;str;"+
	  			"num;num;str;num;num;num;"+
	  			"num;num;num;str;"+
	  			"num;num;str;str;str;num;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
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
					//, table.getData(_col_prd.planQty,i)
					//, table.getData(_col_prd.rfidQty,i)
					, table.getData(_col_prd.inputQty,i)
					, table.getData(_col_prd.inputAmt,i)
					, table.getData(_col_prd.resultQty,i)
					, table.getData(_col_prd.resultUnitAmt,i)
					, table.getData(_col_prd.payAmt,i)
					, table.getData(_col_prd.incomeTax,i)
					, table.getData(_col_prd.residentTax,i)
					, table.getData(_col_prd.withholdingTax,i)
					, table.getData(_col_prd.totalAmt,i)
					, table.getData(_col_prd.prdCD,i)
					, table.getData(_col_prd.unit,i)
					, table.getData(_col_prd.planUnitAmt,i)
					, table.getData(_col_prd.gsv,i)
					, table.getData(_col_prd.kindtpcd,i)
					, table.getData(_col_prd.kindTpCD5,i)
					, table.getData(_col_prd.limitQty,i)
					, 'N'
      			];
      		}
      		grid_prd.setCellData(data);
      		grid_prd.setRowCount(rowCount);
      	}
      	grid_prd.refresh();
      	for (var i=0; i<rowCount; i++) {
      		calculateResultQty(i);
      	}
      	changeResultTpCD($("#resultTpCD").val());
	}
	
	function Save() {
		//등록, 반려인 경우에만 저장
		if($("#apprStateCD").val() != "10" && $("#apprStateCD").val() != "40") {
			alert("<fmt:message key="RLT01001A.msg1"/>");
			return;
		}
		
		if(grid_prd.getRowCount() == 0) {
			alert("<fmt:message key="info.nullData.save"/>");
			return;
		}
		
		//달성율120%초과
		//var targetRate = parseFloat(unformat($("#targetRate").text()));
		var gsvRate = parseFloat(unformat($("#gsvRate").text()));
		/* 
		if(targetRate > 120) {
			if($("#excPayTpCD").val() == "") {
				alert("<fmt:message key="RLT01001A.msg3"/>");
				$("#excPayTpCD").focus();
				return;
			}
		}
		 */
		//지급율이 가이드금액보다 크거나, 120%초과가 초과분지급이거나, GSV 항목이 붉은색 조건에 해당하는 경우는 Comment항목이 필수
		//var payRate = parseFloat(unformat($("#payRate").val()));
		//var payRate = parseFloat(unformat($("#payRate").text()));
		//var guidPayRate = parseFloat(unformat($("#guidPayRate").val()));
		//if(payRate > guidPayRate || $("#excPayTpCD").val()=="YPAY" || gsvRate > 10) {
// 		if(payRate > guidPayRate && guidPayRate < 70) {
// 			if($("#commt").val() == "") {
// 				alert("<fmt:message key="RLT01001A.msg4"/>");
// 				$("#commt").focus();
// 				return;
// 			}
// 		}
		//선지원(20)이 아닌경우
		if($("#activityCD").val() != "20") {
			var payAmt_keyman = parseFloat(unformat($("#payAmt_keyman").val()));
			var tpayAmt = parseFloat(unformat($("#tpayAmt").text()));
			if(payAmt_keyman != tpayAmt) {
				alert("<fmt:message key="RLT01001A.msg2"/>");
				return;
			}
		}
		
		var prdCDs = new Array();
		var rfidQtys = new Array();
		var resultQtys = new Array();
		var inputQtys = new Array();
		var inputAmts = new Array();
		var resultUnitAmts = new Array();
		var payAmts = new Array();
		var incomeTaxs = new Array();
		var residentTaxs = new Array();
		var withholdingTaxs = new Array();
		var totalAmts = new Array();
		var kindTpCD5s = new Array();
		var limitQtys = new Array();
		var limitQtyFlags = new Array();
		var count = 0;
		for (var i=0; i<grid_prd.getRowCount(); i++) {
			prdCDs[count] = grid_prd.getCellText(_col_prd.prdCD, i);
			rfidQtys[count] = "0";
			resultQtys[count] = grid_prd.getCellText(_col_prd.resultQty, i);
			inputQtys[count] = grid_prd.getCellText(_col_prd.inputQty, i);
			inputAmts[count] = grid_prd.getCellText(_col_prd.inputAmt, i);
			resultUnitAmts[count] = grid_prd.getCellText(_col_prd.resultUnitAmt, i);
			payAmts[count] = grid_prd.getCellText(_col_prd.payAmt, i);
			incomeTaxs[count] = grid_prd.getCellText(_col_prd.incomeTax, i);
			residentTaxs[count] = grid_prd.getCellText(_col_prd.residentTax, i);
			withholdingTaxs[count] = grid_prd.getCellText(_col_prd.withholdingTax, i);
			totalAmts[count] = grid_prd.getCellText(_col_prd.totalAmt, i);
			kindTpCD5s[count] = grid_prd.getCellText(_col_prd.kindTpCD5, i);
			limitQtys[count] = grid_prd.getCellText(_col_prd.limitQty, i);
			limitQtyFlags[count] = grid_prd.getCellText(_col_prd.limitQtyFlag, i);
			count++;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt01/saveResultWriteVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("venueCD", $("#selectVenueCD").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("apprStateCD", $("#apprStateCD").val());
		table.setParameter("resultTQty", $("#resultTQty").text());
		table.setParameter("targetRate", "0");
		table.setParameter("guidPayRate", "0");
		//table.setParameter("payRate", $("#payRate").val());
		table.setParameter("payRate", "0");
		//table.setParameter("excPayTpCD", $("#excPayTpCD").val());
		table.setParameter("excPayTpCD", "YPAY");
		table.setParameter("tpayAmt", $("#tpayAmt").text());
		table.setParameter("resultTpCD", $("#resultTpCD").val());
		table.setParameter("gsvRate", $("#gsvRate").text());
		table.setParameter("commt", $("#commt").val());
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("rfidQtys", rfidQtys);
		table.setParameter("inputQtys", inputQtys);
		table.setParameter("inputAmts", inputAmts);
		table.setParameter("resultQtys", resultQtys);
		table.setParameter("resultUnitAmts", resultUnitAmts);
		table.setParameter("payAmts", payAmts);
		table.setParameter("incomeTaxs", incomeTaxs);
		table.setParameter("residentTaxs", residentTaxs);
		table.setParameter("withholdingTaxs", withholdingTaxs);
		table.setParameter("totalAmts", totalAmts);
		table.setParameter("kindTpCD5s", kindTpCD5s);
		table.setParameter("limitQtys", limitQtys);
		table.setParameter("limitQtyFlags", limitQtyFlags);
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			for (var i=0; i<grid_rlt.getRowCount(); i++) {
				var venueCD = grid_rlt.getCellValue(_col_dtl.venueCD,i);
				//업소의  result 저장성공하면 글씨체를 굵게변결
				if(venueCD == $("#selectVenueCD").val()){
					grid_rlt.getCellTemplate(_col_rlt.programCDName,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.activityCDName,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.venueCD,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.venueNm,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.venueGradCDName,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.addrTpCD2Name,i).setStyle("font-weight", "bold");
      				grid_rlt.getCellTemplate(_col_rlt.keymanAmt,i).setStyle("font-weight", "bold");
				}
			}
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
		"<fmt:message key="RLT01001A.programCD"/>"
		, "<fmt:message key="RLT01001A.activityCD"/>"
		, "<fmt:message key="RLT01001A.venueCD"/>"
		, "<fmt:message key="RLT01001A.venueNm"/>"
		, "<fmt:message key="RLT01001A.venueGradCD"/>"
		, "<fmt:message key="RLT01001A.addrTpCD2"/>"
		, "<fmt:message key="RLT01001A.keymanAmt"/>"
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
	                        , str, num
	                        ]);
	    grid_rlt.setCellEditable(false);
	    
	    grid_rlt.onRowDoubleClicked = function(event, row){
	    	$("#selectVenueCD").val(this.getCellText(_col_rlt.venueCD,row));
	    	Search_dtl();
		};
    }
	
	var columns_prd = [
		"<fmt:message key="RLT01001A.kindTpCD5"/>"
		, "<fmt:message key="RLT01001A.prdNm"/>"
		, "<fmt:message key="RLT01001A.factoryPrice"/>"
		, "<fmt:message key="RLT01001A.qtyUnitCD"/>"
		//, "<fmt:message key="RLT01001A.planQty"/>"
		//, "<fmt:message key="RLT01001A.rfidQty"/>"
		, "<fmt:message key="RLT01001A.inputQty"/>"
		, "<fmt:message key="RLT01001A.inputAmt"/>"
		, "<fmt:message key="RLT01001A.resultQty"/>"
		, "<fmt:message key="RLT01001A.resultUnitAmt"/>"
		, "<fmt:message key="RLT01001A.payAmt"/>"
		, "<fmt:message key="RLT01001A.incomeTax"/>"
		, "<fmt:message key="RLT01001A.residentTax"/>"
		, "<fmt:message key="RLT01001A.withholdingTax"/>"
		, "<fmt:message key="RLT01001A.totalAmt"/>"
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
	                        str, str, num, str, num, num, str
	                        , num, num, num, num
	                        , num, num]);
	    grid_prd.setCellEditable(true);
	    grid_prd.setCellEditable(false, _col_prd.kindTpCD5Name);
	    grid_prd.setCellEditable(false, _col_prd.prdNm);
	    grid_prd.setCellEditable(false, _col_prd.factoryPrice);
	    grid_prd.setCellEditable(false, _col_prd.qtyUnitCDName);
	    grid_prd.setCellEditable(false, _col_prd.payAmt);
	    grid_prd.setCellEditable(false, _col_prd.resultQty);
	    grid_prd.setCellEditable(false, _col_prd.resultUnitAmt);
	    grid_prd.setCellEditable(false, _col_prd.incomeTax);
	    grid_prd.setCellEditable(false, _col_prd.residentTax);
	    grid_prd.setCellEditable(false, _col_prd.withholdingTax);
	    grid_prd.setCellEditable(false, _col_prd.totalAmt);
	    
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
			if (col == _col_prd.inputQty || col == _col_prd.inputAmt) {
				this.setCellText(unformatNum(text), col, row);
			}
		};
		
		grid_prd.onCellValidating = function(text, col, row) {
			if (col == _col_prd.inputQty) {
				if(unformat(text).length > 6) {
	    			//alert("<fmt:message key="info.validate.numlength"><fmt:param value='5'/></fmt:message>");
					//this.setCellText(unformat(text).substring(0,6),col,row);
					//return;
				}
			if (parseFloat(unformat(text)) < 0) {
					alert("<fmt:message key="error.noMinusNum" />");
					this.setCellText("0",col,row);
					return;
				}
			if (!isDecimal(unformat(text))) {
			    alert("<fmt:message key="error.noNum" />");
			    this.setCellText("0",col,row);
			    return;
			}
			}
			else if(col == _col_prd.inputAmt) {
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
	    	if (col == _col_prd.inputQty) {
	    		this.setCellText(formatNum(unformat(text)), col, row);
	    		calculateResultQty(row);
	    	}
	    	else if(col == _col_prd.inputAmt) {
	    		this.setCellText(formatNum(unformat(text)), col, row);
	    		calculateResultQty(row);
	    	}
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
    }
	
</script>