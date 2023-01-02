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
													<fmt:message key="PLN01002A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" event="onchange" eventproc="getPlanWriteDate();" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" event="onchange" eventproc="getPlanWriteDate();" />
												</td>
												<td class="td-cond">
													<fmt:message key="PLN01002A.activityCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" style="width:90px" />
												</td>
												<td class="td-cond">
													<fmt:message key="PLN01002A.apprStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="none" category="APPRSTATECD" />
												</td>
											</tr>
											<tr style="display:none">
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD"  />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2"  />
												</td>
												<td class="td-input">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" />
												</td>
												<td class="td-input">
													<nis:selectbox id="programCD_S" name="programCD_S" defaultText="all" category="PROGRAMCD"  />
												</td>
												<td class="td-input"></td>
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
			        			<col style="width:100px;"></col>
			        			<col></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="PLN01002A.planWriteDate" />
									</td>
									<td class="tit_text01">
										<span id="planWriteDate_S" />
	                                </td>
	                                <td class="tit_text01">
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
	                   			<td width="27.7%">
									<span id="grid_pln"></span>
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
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.apprStateCD" />
															</td>
																<td class="td-cond-report">
																<fmt:message key="PLN01007A.NSV" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01007A.GP" />
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01007A.GPPcnt" />
															</td>
			                            				</tr>
			                            				<tr>
			                            					<td class="td-report-rborder" >
																<nis:selectbox id="keymanID" name="keymanID" defaultText="select" query="COM03005S" paramkey="venueCD;x;" paramvalue=";x;" style="height:17px;width:120px;" />
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="apprStateCDName"></span>
																<input type="hidden" id="apprStateCD" name="apprStateCD" />
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="nsv"></span>
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="gp"></span>
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="gpPcnt"></span>
															</td>
			                            				</tr>
			                            				<tr>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.commt" />
															</td>
															<td class="td-report-rborder" colspan="4">
																<input type="text" id="commt" name="commt" style="width:400px; height:17px;" maxlength="100" />
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
						<!-- <input type="hidden" id="apprTpID" name="apprTpID" value="000000" />Plan/Result승인라인 -->
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
	#grid_pln .aw-column-1 {width: 100px; text-align:left;}			
	#grid_pln .aw-column-2 {width: 100px; text-align:left;}			
    #grid_pln .aw-column-3 {width: 120px; text-align:right;}		
    #grid_pln .aw-column-4 {width: 60px; text-align:center;}		
    #grid_pln .aw-column-5 {width: 60px; text-align:center;}		
    #grid_pln .aw-column-6 {width: 60px; text-align:center;}		
    #grid_pln .aw-column-7 {width: 100px; text-align:left;}			 
    
    #grid_prd .aw-column-0 {width: 90px; text-align:left;}
    #grid_prd .aw-column-1 {width: 110px; text-align:left;}
    #grid_prd .aw-column-2 {width: 90px; text-align:right;}
	#grid_prd .aw-column-3 {width: 80px; text-align:center;}
    #grid_prd .aw-column-4 {width: 100px; text-align:right;}
    #grid_prd .aw-column-5 {width: 80px; text-align:right;}
    #grid_prd .aw-column-6 {width: 120px; text-align:right;}
    #grid_prd .aw-column-7 {width: 120px; text-align:right;}
    #grid_prd .aw-column-8 {width: 120px; text-align:right;}
    #grid_prd .aw-column-9 {width: 120px; text-align:right;}
    #grid_prd .aw-column-10 {width: 120px; text-align:right;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable1
	 ****************************************/
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid_pln();
			grid_pln.refresh();
			
			createGrid_prd();
			grid_prd.refresh();
			
			btnSave.setControlDisabled(false);
			btnCopyLastMonPlan.setControlDisabled(true);
			
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
			
			getPlanWriteYN();
			getPlanWriteDate();
			
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
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
	function getPlanWriteYN() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "01");		//01:plan_업소단위,02:result_업소단위,03:plan_브랜드단위,04:result_브랜드단위
		table.request();
		
		if(table.getCount() > 0) {
			$("#planWriteYN").val(table.getData(0,0));
			if(table.getData(0,0) == "Y") {
				btnSave.setControlDisabled(false);
				btnCopyLastMonPlan.setControlDisabled(false);
			}
			else {
				btnSave.setControlDisabled(false);
				btnCopyLastMonPlan.setControlDisabled(true);
			}
		}
	}
	
	function getPlanWriteDate() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03002S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "01");		//01:plan_업소단위,02:result_업소단위,03:plan_브랜드단위,04:result_브랜드단위
		table.request();
		
		var s = "";
	  	if (table.getCount() > 0) {
	  		s = "<select id='planWriteDate_S' name='planWriteDate_S'>";
		  	for (var i=0; i < table.getCount(); i++) {
		  		s += "<option>"+table.getData(0,i)+"</option>";
		  	}
	  	}
	  	else {
	  		 s = "<select id='planWriteDate_S' name='planWriteDate_S'><option value=''><fmt:message key="nothing"/></option>";
	  	}
	  	s += "</select>";
	  	$("#planWriteDate_S").html(s);
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
	
	function New() {
		$("#programCDName").text("");
  		$("#activityCDName").text("");
  		$("#venueCD").text("");
  		$("#venueNm").text("");
  		$("#threeMonthAvgTQty").text("0");
  		$("#planTQty").text("0");
  		$("#tpayAmt").text("0");
  		$("#gsvRate").text("0");
  		$("#threeMonthAvgRate").text("0");
  		$("#keymanID").val("");
  		$("#apprStateCDName").text("");
  		$("#apprStateCD").val("");
  		$("#commt").val("");
  		$("#programCD").val("");

  		
		$("#gsvRate_td").attr("style","text-align:right; background:#ffffff;");
		$("#gsvRate").attr("style","color:#00000;");
		$("#threeMonthAvgRate_td").attr("style","text-align:right; background:#ffffff;");
		$("#threeMonthAvgRate").attr("style","color:#00000;");
		$("#keymanID").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
		
  		createGrid_prd();
		grid_prd.refresh();
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
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function Search() {
		Search_pln();
	}
	
	var _i_pln = 0;
	var _col_pln = {
		  checkbox : _i_pln++
		, activityCDName : _i_pln++
		, venueNm : _i_pln++
		, tpayAmt : _i_pln++
		, programCDName : _i_pln++
		, venueCD : _i_pln++
		, venueGradCDName : _i_pln++
		, addrTpCD2Name : _i_pln++
		, chgID : _i_pln++
    };
	
	//Plan작성기간 상세조회 
	function Search_pln() {
		getPlanWriteYN();
		getPlanWriteDate();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0100701S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;activityCDName;venueNm;tpayAmt;programCDName;venueCD;venueGradCDName;"+
	  			"addrTpCD2Name;chgID;");
	  	table.setParameter("format",
	  			"str;str;str;num;str;str;str;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("programCD", $("#programCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.request();
      	
// 	  	if (grid_pln != null) grid_pln.clear();
      	createGrid_pln();
      	
      	var rowCount = table.getCount();
      	
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
					, table.getData(_col_pln.activityCDName,i)
					, table.getData(_col_pln.venueNm,i)
					, table.getData(_col_pln.tpayAmt,i)
					, table.getData(_col_pln.programCDName,i)
      			    , table.getData(_col_pln.venueCD,i)
					, table.getData(_col_pln.venueGradCDName,i)
					, table.getData(_col_pln.addrTpCD2Name,i)
				];
      		 	if(table.getData(_col_pln.chgID,i) != ""){			// 상태가 승인일 경우 굵은글씨로 표시.
      				grid_pln.getCellTemplate(_col_pln.activityCDName,i).setStyle("font-weight", "bold");
      				grid_pln.getCellTemplate(_col_pln.venueNm,i).setStyle("font-weight", "bold");
      				grid_pln.getCellTemplate(_col_pln.tpayAmt,i).setStyle("font-weight", "bold");
					grid_pln.getCellTemplate(_col_pln.programCDName,i).setStyle("font-weight", "bold");
      				grid_pln.getCellTemplate(_col_pln.venueCD,i).setStyle("font-weight", "bold");
      				grid_pln.getCellTemplate(_col_pln.venueGradCDName,i).setStyle("font-weight", "bold");
      				grid_pln.getCellTemplate(_col_pln.addrTpCD2Name,i).setStyle("font-weight", "bold");
          		} 
      		}
      		grid_pln.setCellData(data);
      		grid_pln.setRowCount(rowCount);
      	}
      	grid_pln.refresh();
      	
      	New();
	}
	
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
		, nsv : _i_dtl++
		, gp : _i_dtl++
		, gpPcnt : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0100702S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"programCDName;activityCDName;venueCD;venueNm;threeMonthAvgTQty;"+
	  			"planTQty;tpayAmt;gsvRate;threeMonthAvgRate;keymanID;"+
	  			"apprStateCDName;apprStateCD;commt;programCD;nsv;gp;gpPcnt");
	  	table.setParameter("format",
	  			"str;str;str;str;num;"+
	  			"num;num;num;num;str;"+
	  			"str;str;str;str;"+
	  			"num;num;num;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	
      	if (rowCount > 0) {
      		//keyman 리스트 가져오기
      		var table_t = new AW.XML.Table;
    		table_t.setURL("${contextPath}/service/simpleAction/COM03005S");
    		table_t.setAsync(false);
    		table_t.setRequestMethod("POST");
    	  	table_t.setParameter("venueCD", $("#selectVenueCD").val());
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
      	/* 	$("#nsv").val(table.getData(_col_dtl.nsv, 0));
      		$("#gp").val(table.getData(_col_dtl.gp, 0));
      		$("#gpPcnt").val(table.getData(_col_dtl.gpPcnt, 0)); */
      		
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
      		
      		/*	plan승인처리가 미등록, 등록, 반려가 아닌경우에는 수정 불가
     			(10:등록, 40:반려)
     		*/
     		if($("#planWriteYN").val()=="Y") {
	     		var apprStateCD = table.getData(_col_dtl.apprStateCD, 0);
				if(apprStateCD!="10" && apprStateCD!="40") {
					btnSave.setControlDisabled(false);
				}
				else {
					btnSave.setControlDisabled(false);
				}
     		}
      		Search_prd();
      	}
	}
	
	function openApprState() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PLN01002B"
				+"&eventYM="+$("#yearCD_S").val()+$("#monthCD_S").val()
				+"&venueCD="+$("#selectVenueCD").val();
		
		newWindow(url, "PLN01002B",600,350,"yes");
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
		, nsv : _i_prd++
		, gp : _i_prd++
		, gpPcnt : _i_prd++
    };
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0100703S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;threeMonthAvgQty;"+
	  			"planQty;planUnitAmt;payAmt;nsv;gp;gpPcnt;prdCD;");
	  	table.setParameter("format",
	  			"str;str;num;str;num;"+
	  			"num;num;num;num;num;num;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
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
	
	function Save() {
		//등록, 반려인 경우에만 저장
		if($("#apprStateCD").val() != "10" && $("#apprStateCD").val() != "40") {
			alert("<fmt:message key="PLN01002A.msg1"/>");
			return;
		}
		
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
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln01/savePlanVenueWrite");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("venueCD", $("#selectVenueCD").val());
		table.setParameter("apprStateCD", $("#apprStateCD").val());
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
	
	function CopyLastMonPlan() {
		var venueCDs = new Array();
		var count = 0;
		for (var i=0; i<grid_pln.getRowCount(); i++) {
			if (grid_pln.getCellValue(_col_pln.checkbox, i)) {
				venueCDs[count] = grid_pln.getCellText(_col_pln.venueCD, i);
				count++;
			}
		}
		if(count==0) {
			alert("<fmt:message key="info.noSelect"/>");
			return;
		}
		if(!confirm("<fmt:message key="PLN01002A.msg5"/>")) {
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln01/copyBefMonPlanVenueWrite");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("venueCDs", venueCDs);
		table.request();
		
		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search_dtl();
   		}
		else {
			alert(table.getData(1,0));
		}
	}

	function PayHistory() {
		if(grid_pln.getCellText(_col_pln.venueCD, grid_pln.getSelectedRows()) == ""){
			alert("업소를 선택하여 주십시오.");
			return;
		}
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var venueCD = grid_pln.getCellText(_col_pln.venueCD, grid_pln.getSelectedRows());
		var venueNm = grid_pln.getCellText(_col_pln.venueNm, grid_pln.getSelectedRows());

		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=ANL01009A"
			+"&diffNo="+diffNo+"&eventYM="+eventYM+"&venueCD="+venueCD+"&venueNm="+venueNm;
		
		newWindow(url, "ANL01009A",1080,750,"yes");
	}

	function ApprovalHistory(){
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PLN02001B"
			+"&diffNo="+diffNo+"&eventYM="+eventYM;
		
		newWindow(url, "PLN02001B",1080,520,"yes");
	}
	/*****************************************************
	*	define grid_pln / data formats define
	*****************************************************/
	var columns_pln = [
		""
		, "<fmt:message key="PLN01002A.activityCD"/>"
		, "<fmt:message key="PLN01002A.venueNm"/>"
		, "<fmt:message key="PLN01002A.tpayAmt"/>"
		, "<fmt:message key="PLN01002A.programCD"/>"
		, "<fmt:message key="PLN01002A.venueCD"/>"
		, "<fmt:message key="PLN01002A.venueGradCD"/>"
		, "<fmt:message key="PLN01002A.addrTpCD2"/>"
		
	];

	var grid_pln = null;
	
	function createGrid_pln() {
		grid_pln = new AW.UI.Grid;
	    grid_pln.setId("grid_pln");
	    grid_pln.setRowCount(0);
	    grid_pln.setStyle("width","100%");
	    grid_pln.setStyle("height","100%");
	    grid_pln.setSelectorVisible(false);
	    grid_pln.setSelectionMode("single-row");
	    grid_pln.setHeaderText(columns_pln);
	    for(var i=0;i<columns_pln.length;i++){grid_pln.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_pln.setColumnCount(columns_pln.length);
	    grid_pln.setCellFormat([
	                        str, str, str, num, str
	                        , str, str, str
	                        ]);
	    grid_pln.setCellEditable(false);
	    
	    grid_pln.setCellTemplate(new AW.Templates.CheckBox, _col_pln.checkbox);
		grid_pln.setCellValue(false, _col_pln.checkbox);
		
		grid_pln.setHeaderTemplate(new AW.Templates.CheckBox, _col_pln.checkbox);
		grid_pln.setCellTemplate(new AW.Templates.CheckBox, _col_pln.checkbox);
		grid_pln.onHeaderClicked=function(event,col){
			if (col == _col_pln.checkbox && this.getHeaderValue(_col_pln.checkbox,0)) {
				this.setCellValue(true, _col_pln.checkbox);
			}
			else if (col == _col_pln.checkbox && !this.getHeaderValue(_col_pln.checkbox,0)) {
				this.setCellValue(false, _col_pln.checkbox);
			}
			return false;
		};
	    
	    grid_pln.onRowDoubleClicked = function(event, row){
	    	$("#selectVenueCD").val(this.getCellText(_col_pln.venueCD,row));
	    	Search_dtl();
		};
    }
	
	var columns_prd = [
		  "<fmt:message key="PLN01002A.kindTpCD5"/>"
		, "<fmt:message key="PLN01002A.prdNm"/>"
		, "<fmt:message key="PLN01002A.factoryPrice"/>"
		, "<fmt:message key="PLN01002A.qtyUnitCD"/>"
		, "<fmt:message key="PLN01002A.threeMonthAvgQty"/>"
		, "<fmt:message key="PLN01002A.planQty"/>"
		, "<fmt:message key="PLN01002A.planUnitAmt"/>"
		, "<fmt:message key="PLN01002A.payAmt"/>"
		, "<fmt:message key="PLN01007A.NSV"/>"
		, "<fmt:message key="PLN01007A.GP"/>"
		, "<fmt:message key="PLN01007A.GPPcnt"/>"
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
	                        , num, num, num
	                        , num, num, num]);
	    grid_prd.setCellEditable(true);
	    grid_prd.setCellEditable(false, _col_prd.kindTpCD5Name);
	    grid_prd.setCellEditable(false, _col_prd.prdNm);
	    grid_prd.setCellEditable(false, _col_prd.factoryPrice);
	    grid_prd.setCellEditable(false, _col_prd.qtyUnitCDName);
	    grid_prd.setCellEditable(false, _col_prd.threeMonthAvgQty);
	    grid_prd.setCellEditable(false, _col_prd.payAmt);
	    grid_prd.setFixedLeft(0); 
	    
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