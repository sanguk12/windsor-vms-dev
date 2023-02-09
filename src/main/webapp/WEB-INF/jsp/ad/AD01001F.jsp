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
	<table border="0" cellpadding="0" cellspacing="0" width="95%" height="100%">
		<tr>
			<td height="1">
				<%@include file="../sys3/cms/standardParam.jsp" %>
				<%@include file="../sys3/cms/functionbar.jsp" %>
				<%@include file="../sys3/cms/calendar.jsp" %>
			</td>
		</tr>
		<tr>
			<td height="150">
				<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
					<tr>
						<td>
							<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
								<colgroup>
									<col style="width:90px;"></col>
									<col style="width:210px;"></col>
									<col style="width:100px;"></col>
									<col style="width:90px;"></col>
									<col style="width:130px;"></col>
									<col style="width:130px;"></col>
									<col style="width:120px;"></col>
									<col></col>
								</colgroup>
								<tbody>
								<tr>
									<td class="td-cond-required">
										<fmt:message key="AD01001B.venue" />
									</td>
									<td class="td-input" colspan="2">
										<nis:popup id="venue" nameID="venueNm" keyID="venueCD" style="width:100px;" />
									</td>
									<td class="td-cond">
										<fmt:message key="AD01001B.contractDivCD" />
									</td>
									<td class="td-input" colspan="2">
										&nbsp;<span id="contractDivCDNm"></span>
										<input type="hidden" id="contractDivCD" name="contractDivCD" />
									</td>
									<td class="td-cond">
										<fmt:message key="AD01001B.apprStateCD" />
									</td>
									<td class="td-input">
										&nbsp;<span id="apprStateCDName"></span>
										<input type="hidden" id="apprStateCD" name="apprStateCD" />
									</td>
<%--									<td class="td-cond">--%>
<%--										<fmt:message key="AD01001B.chainTargetRate" />--%>
<%--									</td>--%>
<%--									<td class="td-input" colspan="1">--%>
<%--										&nbsp;<span id="chainTargetRateNm"></span>--%>
<%--										<input type="hidden" id="chainTargetRate" name="chainTargetRate" />--%>
<%--									</td>--%>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="AD01001B.rageSphereCD" />
									</td>
									<td class="td-input" colspan="2">
										<nis:selectbox id="rageSphereCD" name="rageSphereCD" defaultText="none" category="RAGESPHERECD" />
									</td>
									<td class="td-cond">
										<fmt:message key="AD01001B.officeCD" />
									</td>
									<td class="td-input" colspan="2">
										<nis:selectbox id="officeCD" name="officeCD" defaultText="none" category="OFFICECD"/>
									</td>
									<td class="td-cond">
										<fmt:message key="AD01001B.perfDivCD" />
									</td>
									<td class="td-input">
										&nbsp;<span id="perfDivCDNm"></span>&nbsp;<span id="performance_btn"></span>
										<input type="hidden" id="perfDivCD" name="perfDivCD" />
									</td>
<%--									<td class="td-cond">--%>
<%--										<fmt:message key="AD01001B.prevTargetRate" />--%>
<%--									</td>--%>
<%--									<td class="td-input">--%>
<%--										&nbsp;<span id="prevTargetRateText"></span>--%>
<%--										<input type="hidden" id="prevTargetRate" name="prevTargetRate" />--%>
<%--									</td>--%>
								</tr>
								<tr>
									<td class="td-cond-required">
										<fmt:message key="AD01001B.startDT" />
									</td>
									<td class="td-input" colspan="2">
										<nis:selectbox id="startYearCD" name="startYearCD" defaultText="none" category="YEARCD"/>
										<nis:selectbox id="startMonthCD" name="startMonthCD" defaultText="none" category="MONTHCD"/>
									</td>
									<td class="td-cond-required">
										<fmt:message key="AD01001B.endDT" />
									</td>
									<td class="td-input" colspan="2">
										<nis:selectbox id="endYearCD" name="endYearCD" defaultText="blank" category="YEARCD"/>
										<nis:selectbox id="endMonthCD" name="endMonthCD" defaultText="blank" category="MONTHCD" />
									</td>
									<td class="td-cond">
										<fmt:message key="AD01001B.contractMonth" />
									</td>
									<td class="td-input">
										&nbsp;<span id="contractMonth"></span>
									</td>
								</tr>
								<tr>
									<td class="td-cond-required">
										<fmt:message key="AD01001B.inputFile" />
									</td>
									<td class="td-input" colspan="2">
										&nbsp;<span id="inputFile_btn"></span>
									</td>
									<td class="td-cond-required">
										<fmt:message key="AD01001B.evidenceFile" />
									</td>
									<td class="td-input" colspan="2">
										&nbsp;<span id="evidenceFile_btn"></span>
									</td>
									<td class="td-cond-required">
										<fmt:message key="AD01001B.confirmFile" />
									</td>
									<td class="td-input">
										&nbsp;<span id="confirmFile_btn"></span>
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
				<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
					<colgroup>
						<col style="width:100%;"></col>
						<!-- 			        			<col style="width:30%;"></col> -->
						<col></col>
					</colgroup>
					<tbody>
					<tr>
						<td height="100%" valign = "top">
							<table border="0" cellspacing="0" cellpadding="0" width="100%" height="80%">
								<colgroup>
									<col style="width:15%;"></col>
									<col style="width:85%;"></col>
									<col></col>
								</colgroup>
								<tbody>
								<tr>
									<td class="td-cond" style="text-align:center;">
										<fmt:message key="AD01001B.cost" />
									</td>
									<td class="td-cond" style="text-align:center;">
										<fmt:message key="AD01001B.amt" />
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="AD01001B.APContract" />
									</td>
									<td class="td-report">
										<input type="text" id="APContract" name="APContract" />
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="AD01001B.POSM" />
									</td>
									<td class="td-report">
										<input type="text" id="POSM" name="POSM" />
									</td>
								</tr>
								<tr style="display:none;">
									<td class="td-cond">
										<fmt:message key="AD01001B.threePercentIncentive" />
									</td>
									<td class="td-report">
										&nbsp;<span id="threePercentIncentive"></span>
										<input  type="hidden" id="real_threePercentIncentive" />
									</td>
								</tr>
								<tr style="display:none;">
									<td class="td-cond">
										<fmt:message key="AD01001B.total" />
									</td>
									<td class="td-report">
										&nbsp;<span id="total"></span>
										<input  type="hidden" id="real_total" />
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="AD01001B.commt" />
									</td>
									<td class="td-report">
										<textarea id="commt" name="commt" rows="5" style="width:100%;" maxlength="500" ></textarea>
									</td>
								</tr>
								<%--광고 프로그램--%>
								<tr>
									<td class="td-cond">
										<fmt:message key="AD01001B.ADProgram" />
									</td>
									<td class="td-report">
										<input type="text" id="adProgram" name="adProgram" disabled/>
									</td>
								</tr>
								<tr style="display:none;">
									<td class="td-cond-required">
										<fmt:message key="AD01001B.bu" />
									</td>
									<td class="td-input">
										<nis:selectbox id="buCD_S" name="buCD_S" style="width:150px;" defaultText="select" category="BUCD" event="onchange"/>
									</td>
								</tr>
								<tr>
									<td class="td-cond-required">
										<fmt:message key="AD01001B.requiredAD" />
									</td>
									<td class="td-report" id="requiredAD_td">
										<div id="requiredDiv1" style="width:100%;">
											<nis:selectbox id="requiredADCD1_S" name="requiredADCD1_S" style="width:150px;" defaultText="select" category="REQUIREDADCD" event="onchange" eventproc="selectRequiredAD(this,0);"/>
											<input type="text" id="amt1" name="amt1" style="text-align:right; width:50px; margin-left:10px;" onkeyup="selectAmt(this,0);">
											<%--위치작성--%>
											<input type="text" id="location1" name="location1" style="text-align:left; width:120px; margin-left:10px;" onkeyup="selectAmt(this,0);">
										</div>
										<div id="requiredDiv2" style="width:100%;">
											<nis:selectbox id="requiredADCD2_S" name="requiredADCD2_S" style="width:150px;" defaultText="select" category="REQUIREDADCD" event="onchange" eventproc="selectRequiredAD(this,1);"/>
											<input type="text" id="amt2" name="amt2" style="text-align:right; width:50px; margin-left:10px;" onkeyup="selectAmt(this,1);">
											<%--위치작성--%>
											<input type="text" id="location2" name="location2" style="text-align:left; width:120px; margin-left:10px;" onkeyup="selectAmt(this,0);">
										</div>
										<div id="requiredDiv3" style="width:100%;">
											<nis:selectbox id="requiredADCD3_S" name="requiredADCD3_S" style="width:150px;" defaultText="select" category="REQUIREDADCD" event="onchange" eventproc="selectRequiredAD(this,2);"/>
											<input type="text" id="amt3" name="amt3" style="text-align:right; width:50px; margin-left:10px;" onkeyup="selectAmt(this,2);">
											<%--위치작성--%>
											<input type="text" id="location3" name="location3" style="text-align:left; width:120px; margin-left:10px;" onkeyup="selectAmt(this,0);">
										</div>
									</td>
								</tr>

								<%--업소 활동--%>
								<tr>
									<td class="td-cond">
										<fmt:message key="AD01001B.venueActivity" />
									</td>
									<td class="td-report">
											<div id="venueActivityDiv1" style="width:100%;">
												<input type="text" id="venueActivity1" name="venueActivity1" disabled/>
											</div>
											<div id="venueActivityDiv2" style="width:100%;">
												<input type="text" id="venueActivity2" name="venueActivity2" disabled/>
											</div>
											<div id="venueActivityDiv3" style="width:100%;">
												<input type="text" id="venueActivity3" name="venueActivity3" disabled/>
											</div>
									</td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
	<!--  전년도 년월 -->
	<!-- 			<input type="hidden" id="compareStartYm"  name="compareStartYm"/> -->
	<!-- 			<input type="hidden" id="compareEndYm"  name="compareEndYm"/> -->
	<!--  prevYearInfo1 : 전년도 sum(M&E rawData)-->
	<input type="hidden" id="prevEfpSum" name="prevEfpSum" />
	<input type="hidden" id="prevDutySum" name="prevDutySum" />
	<input type="hidden" id="prevCogsSum" name="prevCogsSum" />
	<!--  prevYearInfo2 : 전년도 A&P Contract, A&P POSM-->
	<input type="hidden" id="prevAPamt" name="prevAPamt" />
	<input type="hidden" id="prevPosmAmt" name="prevPosmAmt" />
	<!--  prevYearInfo3 : sum(eu * qty)-->
	<input type="hidden" id="prevEuSum" name="prevEuSum" />
	<!--  prevYearInfo4  : 전년도 계약 개월 수 -->
	<input type="hidden" id="prevContractMonth" name="prevContractMonth" />
	<!--  prevYearInfo5 : 전년도 Sdx -->
	<input type="hidden" id="prevSdxMixRate" name="prevSdxMixRate" />
	<!--  prevYearInfo6 : 전년도 result tpayAmt sum -->
	<input type="hidden" id="prevPayAmtSum" name="prevPayAmtSum" />

	<!--  venueInfo2 : GSV -->
	<input type="hidden" id="compareGSVRate" name="compareGSVRate" />
	<input type="hidden" id="compareTargetRate" name="compareTargetRate" />
	<input type="hidden" id="compareMinVol" name="compareMinVol" />
	<input type="hidden" id="limitGsv" name="limitGsv" />
	<input type="hidden" id="compareChgCost" name="compareChgCost" />

	<!-- 업소 Local/Int'l W 구분  -->
	<input type="hidden" id="venueDivCD" name="venueDivCD" />
	<!-- AD계약번호  -->
	<input type="hidden" id="adSupportID" name="adSupportID" />
	<!-- 승인라인 Exception -->
	<input type="hidden" id="apprExpc" name="apprExpc" />
	<!-- Exception 사유 -->
	<input type="hidden" id="expcCommt" name="expcCommt" />
	<!-- M&E RawData 제품 Seq -->
	<input type="hidden" id="seq" name="seq" />
	<!-- 계약상태  -->
	<input type="hidden" id="contractStateCD" name="contractStateCD" />
	<!-- 체인 여부 -->
	<input type="hidden" id="chainYN" name="chainYN" />
	<!-- 체인 AD 계약 여부 -->
	<input type="hidden" id="chainADContractYN" name="chainADContractYN" />
	<!-- 체인 GSV -->
	<input type="hidden" id="chainGSV" name="chainGSV" />
	<!-- 체인 Result 여부 -->
	<input type="hidden" id="rltGSV" name="rltGSV" />
</form>
</body>
</html>


<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid_inputFile .aw-column-0 {width: 300px;}
	#grid_inputFile .aw-column-1 {width: 100px; text-align:right;}
	#grid_inputFile .aw-column-2 {width: 50px; text-align:center;}

	#grid_evidenceFile .aw-column-0 {width: 300px;}
	#grid_evidenceFile .aw-column-1 {width: 100px; text-align:right;}
	#grid_evidenceFile .aw-column-2 {width: 50px; text-align:center;}

	#grid_prd .aw-column-0 {width: 180px; text-align:left;}
	#grid_prd .aw-column-1 {width: 200px; text-align:right;}
	#grid_prd .aw-column-2 {width: 50px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}

</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
			//var maxRow_inputFile = 0;
			//var maxRow_evidenceFile = 0;
	var maxRow_prd = 0;
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
		$("[id^=amt]").numeric();
	});

	$(document).ready(function() {
		window.onload = function() {
			$("#venue").attr("disabled", true);


			//createGrid_inputFile();
			//grid_inputFile.refresh();

			//createGrid_evidenceFile();
			//grid_evidenceFile.refresh();


			createGrid_prd();
			grid_prd.refresh();

			${initScript};

			$("#startYearCD").change(function(){
				if(dateChangeCheck("start")) {
					calculateDate();
					Search_prevYearInfo();
					Search_venueInfo();
					calculateAD();
				}
			});
			$("#startMonthCD").change(function(){
				if(dateChangeCheck("start")) {
					calculateDate();
					Search_prevYearInfo();
					Search_venueInfo();
					calculateAD();
				}
			});
			$("#endYearCD").change(function(){
				if(dateChangeCheck("end")) {
					calculateDate();
					Search_prevYearInfo();
					Search_venueInfo();
					calculateAD();
				}
			});
			$("#endMonthCD").change(function(){
				if(dateChangeCheck("end")) {
					calculateDate();
					Search_prevYearInfo();
					Search_venueInfo();
					calculateAD();
				}
			});
			$("#venue_popup").click(function(){
				openMyVenuePopup("closeMyVenuePopup");
			});

			$("#APContract").keyup(function(){
				calculateAD();
				setADProgram();
				setVenueActivity();
			});


			$("#POSM").keyup(function(){
				calculateAD();
			});
			$("#APContract").focus(function(){
				$(this).val(unformatNum($(this).val()));
			});
			$("#APContract").blur(function(){
				$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
				$(this).val(formatNum($(this).val()));
				setADProgram();
				setVenueActivity();
			});

			$("#POSM").focus(function(){
				$(this).val(unformatNum($(this).val()));
			});
			$("#POSM").blur(function(){
				$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
				$(this).val(formatNum($(this).val()));
			});

			// iframe parent 의 선택된 행 정보 가져온다.
			try{
				$("#adSupportID").val(window.parent.$("#selectAdSupportID").val());
				$("#venueCD").val(window.parent.$("#selectVenueCD").val());
			}catch(e){}

			pageInit();
		}
	});
	var performance_btn = new AW.UI.Button;
	performance_btn.setId("performance_btn");
	//performance_btn.setControlText("<fmt:message key="button.keymanReg" />");
	performance_btn.setControlText("실적확인");
	performance_btn.refresh();

	performance_btn.onControlClicked = function(event) {
		if($("#venueCD").val() != "") {
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD01001D"
					+"&venueCD="+$("#venueCD").val()+"&venueNm="+$("#venueNm").val();
			newWindow(url, "AD01001D",550,500,"yes");
		}
	}

	var inputFile_btn = new AW.UI.Button;
	inputFile_btn.setId("inputFile_btn");
	//inputFile_btn.setControlText("<fmt:message key="button.keymanReg" />");
	inputFile_btn.setControlText("파일첨부");
	inputFile_btn.refresh();

	inputFile_btn.onControlClicked = function(event) {
		var venueCD = $("#venueCD").val();
		var adSupportID = $("#adSupportID").val();
		var fileDivCD = "ADINPUT";

		if($("#venue").val() != "") {
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD01001C"
					+"&adSupportID="+adSupportID
					+"&venueCD="+venueCD
					+"&fileDivCD="+fileDivCD;

			newWindow(url, "AD01001C",600,350,"yes");
		}
	}

	var evidenceFile_btn = new AW.UI.Button;
	evidenceFile_btn.setId("evidenceFile_btn");
	//evidenceFile_btn.setControlText("<fmt:message key="button.keymanReg" />");
	evidenceFile_btn.setControlText("파일첨부");
	evidenceFile_btn.refresh();

	evidenceFile_btn.onControlClicked = function(event) {
		var venueCD = $("#venueCD").val();
		var adSupportID = $("#adSupportID").val();
		var fileDivCD = "ADEVIDENCE";

		if($("#venue").val() != "") {
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD01001E"
					+"&adSupportID="+adSupportID
					+"&venueCD="+venueCD
					+"&fileDivCD="+fileDivCD;

			newWindow(url, "AD01001E",600,350,"yes");
		}
	}

	var confirmFile_btn = new AW.UI.Button;
	confirmFile_btn.setId("confirmFile_btn");
	//confirmFile_btn.setControlText("<fmt:message key="button.keymanReg" />");
	confirmFile_btn.setControlText("파일첨부");
	confirmFile_btn.refresh();

	confirmFile_btn.onControlClicked = function(event) {
		var venueCD = $("#venueCD").val();
		var adSupportID = $("#adSupportID").val();
		var fileDivCD = "ADCONFIRM";

		if($("#venue").val() != "") {
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD01001C"
					+"&adSupportID="+adSupportID
					+"&venueCD="+venueCD
					+"&fileDivCD="+fileDivCD;

			newWindow(url, "AD01001C",600,350,"yes");
		}
	}


	var productCartPopup_btn = new AW.UI.Button;
	productCartPopup_btn.setId("productCartPopup_btn");
	productCartPopup_btn.setControlText("<fmt:message key="button.ProductCart" />");
	productCartPopup_btn.refresh();

	productCartPopup_btn.onControlClicked = function(event) {
		if($("#venue").val() != "") {
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=COM02001O"
					+"&venueCD="+ $("#venueCD").val() +"&finalAction="+"closeProductCartPopup";
			newWindow(url, "COM02001O",550,600,"yes");
		}else{
			alert("<fmt:message key="AD01001B.msg2" />");
			return;
		}
	}

	function closeMyVenuePopup(data) {
		$("#venue").val(data.venueCD);
		$("#venueCD").val(data.venueCD);
		$("#venueNm").val(data.venueNm);
		pageInit();
		Search_prevYearInfo();
		Search_venueInfo();
		selectBu();
		getRequiredAD($("#buCD_S").val());
		settingRequiredAD();
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
			grid_prd.setCellText(data.prdNm, _col_prd.prdNm, maxRow_prd-1);
			grid_prd.setCellText("0", _col_prd.prdQty, maxRow_prd-1);
			grid_prd.setCellText(data.EFP, _col_prd.EFP, maxRow_prd-1);
			grid_prd.setCellText(data.duty, _col_prd.duty, maxRow_prd-1);
			grid_prd.setCellText(data.COGS, _col_prd.COGS, maxRow_prd-1);
			grid_prd.setCellText(data.eu, _col_prd.eu, maxRow_prd-1);
			grid_prd.setCellText(data.sdxYN, _col_prd.sdxYN, maxRow_prd-1);
			grid_prd.setCellText(data.prdCD, _col_prd.prdCD, maxRow_prd-1);
			grid_prd.setCellText(data.seq, _col_prd.seq, maxRow_prd-1);
			grid_prd.setCellText("I", _col_prd.activeFlg, maxRow_prd-1);
			grid_prd.refresh();
		}
		$("#seq").val(data.seq);
		calculateAD();
	}

	function removeRow(row) {
		grid_prd.deleteRow(row);
		grid_prd.setCellText("D",_col_prd.activeFlg,row);
		calculateAD();
	}

	function pageInit(){
		$("#venue").attr("disabled", true);
		$("#rageSphereCD").attr("disabled", true);
		$("#officeCD").attr("disabled", true);
		btnContract.setControlDisabled(true);
		//상세 조회로 진입 시
		if($("#adSupportID").val() != ''){
			$("#venue_popup").hide();
			$("#performance_btn").show();
			$("#inputFile_btn").show();
			$("#evidenceFile_btn").show();
			$("#confirmFile_btn").show();
			$("#startYearCD").attr("disabled", false);
			$("#startMonthCD").attr("disabled", false);
			$("#endYearCD").attr("disabled", false);
			$("#endMonthCD").attr("disabled", false);
			$("#APContract").attr("disabled", false);
			$("#POSM").attr("disabled", true);
			$("#commt").attr("disabled", true);
			$("#adProgram").attr("disabled", true);
			$("#venueActivity1").attr("disabled", true);
			$("#venueActivity2").attr("disabled", true);
			$("#venueActivity3").attr("disabled", true);
			Search();
			search_targetRate();
			search_prevTargetRate();
			chainTargetRate();

		}else{
			maxRow_prd = 0;
			//New
			if($("#venueCD").val() == ''){
				$("#adSupportID").val('');
				$("#APContract").val(0);
				$("#POSM").val(0);
				$("#commt").val('');
				$("#adProgram").val('');
				$("#venue_popup").show();
				$("#apprStateCD").val('10');
				$("#apprStateCDName").text('등록');
				$("#startYearCD").val("${params.clientDate}".substring(0,4));
				$("#startMonthCD").val("${params.clientDate}".substring(4,6));
				$("#endYearCD").val("");
				$("#endMonthCD").val("");
				$("#buCD_S").val("");
				$("[id^=requiredADCD]").val("");
				$("[id^=amt]").val("");
				$("#performance_btn").hide();
				$("#inputFile_btn").hide();
				$("#evidenceFile_btn").hide();
				$("#confirmFile_btn").hide();
				$("#startYearCD").attr("disabled", true);
				$("#startMonthCD").attr("disabled", true);
				$("#endYearCD").attr("disabled", true);
				$("#endMonthCD").attr("disabled", true);
				//$("#uploaderOverlay_inputFile").hide();
				//$("#uploadFilesLink_inputFile").hide();
				//$("#uploaderOverlay_evidenceFile").hide();
				//$("#uploadFilesLink_evidenceFile").hide();
				$("#APContract").attr("disabled", true);
				$("#POSM").attr("disabled", true);
				$("#commt").attr("disabled", true);
				$("#adProgram").attr("disabled", true);
				$("#venueActivity1").attr("disabled", true);
				$("#venueActivity2").attr("disabled", true);
				$("#venueActivity3").attr("disabled", true);
				$("#buCD_S").attr("disabled", true);
				$("[id^=requiredADCD]").attr("disabled", true);
				$("[id^=amt]").attr("disabled", true);
				$("#APContract").val(0);
				$("#POSM").val(0);
				<!--  계약 개월 수 -->
				$("#contractMonth").text("0 개월");
				<!--  전년도 년월 -->
// 				$("#compareStartYm").val(0);
// 				$("#compareEndYm").val(0);
				<!--  prevYearInfo1 : 전년도 sum(M&E rawData)-->
				$("#prevEfpSum").val(0);
				$("#prevDutySum").val(0);
				$("#prevCogsSum").val(0);
				<!--  prevYearInfo2 : 전년도 A&P Contract, A&P POSM-->
				$("#prevAPamt").val(0);
				$("#prevPosmAmt").val(0);
				<!--  prevYearInfo3 : sum(eu * qty)-->
				$("#prevEuSum").val(0);
				<!--  prevYearInfo4  : 전년도 계약 개월 수 -->
				$("#prevContractMonth").val(0);
				<!--  prevYearInfo5 : 전년도 Sdx -->
				$("#prevSdxMixRate").val(0);
				<!--  prevYearInfo6 : 전년도 result tpayAmt sum -->
				$("#prevPayAmtSum").val(0);
				$("#targetRate").text('');
				calculateDate();
				createGrid_prd();
				grid_prd.refresh();
				calculateAD();
			}else{	//New -> after venue select
				$("#adSupportID").val('');
				$("#APContract").val(0);
				$("#POSM").val(0);
				$("#commt").val('');
				$("#adProgram").val('');
				$("#targetRate").text('');
				$("#venue_popup").show();
				$("#performance_btn").show();
				$("#inputFile_btn").hide();
				$("#evidenceFile_btn").hide();
				$("#confirmFile_btn").hide();
				$("#startYearCD").attr("disabled", false);
				$("#startMonthCD").attr("disabled", false);
				$("#endYearCD").attr("disabled", false);
				$("#endMonthCD").attr("disabled", false);
				$("#startYearCD").val("${params.clientDate}".substring(0,4));
				$("#startMonthCD").val("${params.clientDate}".substring(4,6));
				$("#endYearCD").val("");
				$("#endMonthCD").val("");
				//$("#uploaderOverlay_inputFile").show();
				//$("#uploadFilesLink_inputFile").show();
				//$("#uploaderOverlay_evidenceFile").show();
				//$("#uploadFilesLink_evidenceFile").show();
				$("#APContract").attr("disabled", false);
				$("#POSM").attr("disabled", true);
				$("#commt").attr("disabled", true);
				$("#adProgram").attr("disabled", true);
				$("#venueActivity1").attr("disabled", true);
				$("#venueActivity2").attr("disabled", true);
				$("#venueActivity3").attr("disabled", true);
				$("#buCD_S").attr("disabled", false);

				calculateDate();
				calculateAD();
			}
		}
	}

	function calculateAD(){
		var APContract = unformatNum($("#APContract").val()) == "" ? 0 : parseFloat(unformatNum($("#APContract").val()), "10");
		// var POSM = unformatNum($("#POSM").val()) == "" ? 0 : parseFloat(unformatNum($("#POSM").val()), "10");
		var contractMonth = parseFloat($("#contractMonth").text().slice(0,-3), "10");
		// var compareGSVRate = parseFloat($("#compareGSVRate").val(), "10");
		// var compareTargetRate = parseFloat($("#compareTargetRate").val(), "10");
		// var compareMinVol = parseFloat($("#compareMinVol").val(), "10");
		// var compareChgCost = parseFloat($("#compareChgCost").val(), "10");

		// var APContract = 0;
		var POSM = 0;
		// var contractMonth = 0;
		var compareGSVRate = 0;
		var compareTargetRate = 0;
		var compareMinVol = 0;
		var compareChgCost = 0;

		var totalInc = 0;
		var total = 0;

		var GSV1 = 0;
		var GSV2 = 0;
		var GSV3 = 0;

		var tradeSpend1 = 0;
		var tradeSpend2 = 0;
		var tradeSpend3 = 0;

		var duty1 = 0;
		var duty2 = 0;
		var duty3 = 0;

		var NSV1 = 0;
		var NSV2 = 0;
		var NSV3 = 0;

		var COGS1 = 0;
		var COGS2 = 0;
		var COGS3 = 0;

		var GP1 = 0;
		var GP2 = 0;
		var GP3 = 0;

		var APContract1 = 0;
		var APContract2 = 0;
		var APContract3 = 0;

		var APOthers1 = 0;
		var APOthers2 = 0;
		var APOthers3 = 0;

		var caap1 = 0;
		var caap2 = 0;
		var caap3 = 0;

		var euSum = 0;
		var bestEstimationMonth1 = 0;
		var bestEstimationMonth2 = 0;
		var bestEstimationMonth3 = 0;
		var bestEstimationMonth4 = 0;

		var gpRate1 = 0;
		var gpRate2 = 0;
		var gpRate3 = 0;
		var gpRate4 = 0;

		var costRate1 = 0;
		var costRate2 = 0;
		var costRate3 = 0;
		var costRate4 = 0;

		var totalVol = 0;
		var sdxPrdVol = 0;
		var sdxMixRate1 = 0;
		var sdxMixRate2 = 0;
		var sdxMixRate3 = 0;
		var sdxMixRate4 = 0;

		var totalCostRate1 = 0;
		var totalCostRate2 = 0;
		var totalCostRate3 = 0;
		var totalCostRate4 = 0;

		var caapPerNSV1 = 0;
		var caapPerNSV2 = 0;
		var caapPerNSV3 = 0;
		var caapPerNSV4 = 0;

		var mThan36MContract = 0;
		var adCostPerGSV = 0;
		var prevYearChgCost = 0;
		var minVolYN = 0;

		// for(var i=0;i<maxRow_prd;i++){
		// 	if(grid_prd.getCellText(_col_prd.activeFlg,i)!="D"){
		// 		GSV2 += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.prdQty, i )), "10")*(parseFloat(unformatNum(grid_prd.getCellText(_col_prd.EFP, i)), "10")*100000)/100000;
		// 		duty2 += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.prdQty, i )), "10")*(parseFloat(unformatNum(grid_prd.getCellText(_col_prd.duty, i)), "10")*100000)/100000;
		// 		COGS2 += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.prdQty, i )), "10")*(parseFloat(unformatNum(grid_prd.getCellText(_col_prd.COGS, i)), "10")*100000)/100000;
		// 		euSum += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.prdQty, i )), "10")*(parseFloat(unformatNum(grid_prd.getCellText(_col_prd.eu, i)), "10")*100000)/100000;
		// 		if(grid_prd.getCellText(_col_prd.sdxYN, i) == 'Y'){
		// 			sdxPrdVol += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.prdQty, i )), "10");
		// 		}
		// 		totalVol += parseFloat(unformatNum(grid_prd.getCellText(_col_prd.prdQty, i )), "10");
		// 	}
		// }
		$("#real_threePercentIncentive").val(formatNum(Math.floor(GSV2*0.035)));
		$("#real_total").val(formatNum(Math.floor((GSV2*0.035) + parseFloat(APContract*1000, "10") + parseFloat(POSM*1000, "10"))));



		// GSV1 = parseFloat($("#prevEfpSum").val(), "10");
		// GSV2 = GSV2/1000;
		// GSV3 = GSV2-GSV1;
		//
		// tradeSpend1 = parseFloat($("#prevPayAmtSum").val(), "10")*-1;
		// tradeSpend2 = GSV2*0.035*-1;
		// tradeSpend3 = tradeSpend2 - tradeSpend1;
		//
		// duty1 = parseFloat($("#prevDutySum").val(), "10");
		// duty2 = duty2/1000;
		// duty3 = duty2 - duty1;
		//
		// NSV1 = GSV1 + tradeSpend1 + duty1;
		// NSV2 = GSV2 + tradeSpend2 + duty2;
		// NSV3 = NSV2 - NSV1;
		//
		// COGS1 = parseFloat($("#prevCogsSum").val(), "10");
		// COGS2 = COGS2/1000;
		// COGS3 = COGS2 - COGS1;
		//
		// GP1 = NSV1 + COGS1;
		// GP2 = NSV2 + COGS2;
		// GP3 = GP2 - GP1;

		// APContract1 = parseFloat($("#prevAPamt").val(), "10")*-1;
		// APContract2 = APContract * -1;
		// APContract3 = APContract2 - APContract1;

		// APOthers1 = parseFloat($("#prevPosmAmt").val(), "10")*-1;
		// APOthers2 = POSM * -1;
		// APOthers3 = APOthers2 - APOthers1;

		// caap1 = GP1 + APContract1 + APOthers1;
		// caap2 = GP2 + APContract2 + APOthers2;
		// caap3 = caap2 - caap1;

		// bestEstimationMonth1 = parseFloat($("#prevContractMonth").val(), "10") != 0 ? parseFloat($("#prevEuSum").val(), "10") / parseFloat($("#prevContractMonth").val(), "10") : 0;
		// bestEstimationMonth2 = contractMonth != 0 ? euSum/contractMonth : 0;
		// bestEstimationMonth3 = bestEstimationMonth2 - bestEstimationMonth1;
		// bestEstimationMonth4 = bestEstimationMonth1 != 0 ? bestEstimationMonth3 / bestEstimationMonth1 * 100 : 0;
		//
		// gpRate1 = NSV1 != 0 ? GP1/NSV1 * 100 : 0;
		// gpRate2 = NSV2 != 0 ? GP2/NSV2 *100 : 0;
		// gpRate3 = gpRate2 - gpRate1;
		// gpRate4 = gpRate1 != 0 ? gpRate3 / gpRate1 * 100 : 0;
		//
		// costRate1 = GSV1 != 0 ? (tradeSpend1+APContract1+APOthers1)/GSV1*-1*100 : 0;
		// costRate2 = GSV2 != 0 ? (tradeSpend2+APContract2+APOthers2)/GSV2*-1*100 : 0;
		// costRate3 = costRate2 - costRate1;
		// costRate4 = costRate1 != 0 ? costRate3 / costRate1 * 100 : 0;
		//
		// sdxMixRate1 = $("#prevSdxMixRate").val();
		// sdxMixRate2 = totalVol != 0 ? sdxPrdVol / totalVol * 100 : 0;
		// sdxMixRate3 = sdxMixRate2 - sdxMixRate1;
		// sdxMixRate4 = sdxMixRate1 != 0 ? sdxMixRate3 / sdxMixRate1 * 100 : 0;
		//
		// totalCostRate1 = parseFloat($("#prevEuSum").val(), "10") != 0 ? (tradeSpend1 + duty1 + COGS1 + APContract1+APOthers1) / parseFloat($("#prevEuSum").val(), "10")*-1 : 0;
		// totalCostRate2 = euSum != 0 ? (tradeSpend2 + duty2 + COGS2 + APContract2+APOthers2) / euSum *-1 : 0;
		// totalCostRate3 = totalCostRate2 - totalCostRate1;
		// totalCostRate4 = totalCostRate1 != 0 ? totalCostRate3 / totalCostRate1 * 100 : 0;
		//
		// caapPerNSV1 = NSV1 != 0 ? caap1 / NSV1 * 100: 0;
		// caapPerNSV2 = NSV2 != 0 ? caap2 / NSV2 * 100: 0;
		// caapPerNSV3 = caapPerNSV2 - caapPerNSV1;
		// caapPerNSV4 = caapPerNSV1 != 0 ? caapPerNSV3 / caapPerNSV1 * 100 : 0;

		// mThan36MContract = APContract;
		// adCostPerGSV = GSV2 != 0 ? APContract / GSV2 * 100 : 0;
		// prevYearChgCost = costRate3;
		// minVolYN = bestEstimationMonth2;

		//(E열 * 입력수량) 전체합 * 0.035
		// 소숫점 수정 --Start
		$("#threePercentIncentive").text(formatNum(Math.floor(GSV2*0.035)));
		$("#total").text(formatNum(Math.floor((GSV2*0.035) + parseFloat(APContract, "10") + parseFloat(POSM, "10"))));
		$("#totalVol").text(formatNum(totalVol));
		$("#GSV1").text(formatNum(Math.floor(GSV1)));
		$("#GSV2").text(formatNum(Math.floor(GSV2)));
		$("#GSV3").text(formatNum(Math.floor(GSV3)));

		$("#tradeSpend1").text(formatNum(Math.floor(tradeSpend1)));
		$("#tradeSpend2").text(formatNum(Math.floor(tradeSpend2)));
		$("#tradeSpend3").text(formatNum(Math.floor(tradeSpend3)));

		$("#duty1").text(formatNum(Math.floor(duty1)));
		$("#duty2").text(formatNum(Math.floor(duty2)));
		$("#duty3").text(formatNum(Math.floor(duty3)));

		$("#NSV1").text(formatNum(Math.floor(NSV1)));
		$("#NSV2").text(formatNum(Math.floor(NSV2)));
		$("#NSV3").text(formatNum(Math.floor(NSV3)));

		$("#COGS1").text(formatNum(Math.floor(COGS1)));
		$("#COGS2").text(formatNum(Math.floor(COGS2)));
		$("#COGS3").text(formatNum(Math.floor(COGS3)));

		$("#GP1").text(formatNum(Math.floor(GP1)));
		$("#GP2").text(formatNum(Math.floor(GP2)));
		$("#GP3").text(formatNum(Math.floor(GP3)));

		$("#APContract1").text(formatNum(Math.floor(APContract1)));
		$("#APContract2").text(formatNum(Math.floor(APContract2)));
		$("#APContract3").text(formatNum(Math.floor(APContract3)));

		$("#APOthers1").text(formatNum(Math.floor(APOthers1)));
		$("#APOthers2").text(formatNum(Math.floor(APOthers2)));
		$("#APOthers3").text(formatNum(Math.floor(APOthers3)));

		$("#caap1").text(formatNum(Math.floor(caap1)));
		$("#caap2").text(formatNum(Math.floor(caap2)));
		$("#caap3").text(formatNum(Math.floor(caap3)));

		$("#bestEstimationMonth1").text(formatNum(Math.floor(bestEstimationMonth1*10)/10));
		$("#bestEstimationMonth2").text(formatNum(Math.floor(bestEstimationMonth2*10)/10));
		$("#bestEstimationMonth3").text(formatNum(Math.floor(bestEstimationMonth3*10)/10));
		$("#bestEstimationMonth4").text(formatNum(Math.floor(bestEstimationMonth4*10)/10)+"%");

		$("#gpRate1").text(formatNum(Math.floor(gpRate1*10)/10)+"%");
		$("#gpRate2").text(formatNum(Math.floor(gpRate2*10)/10)+"%");
		$("#gpRate3").text(formatNum(Math.floor(gpRate3*10)/10)+"%");
		$("#gpRate4").text(formatNum(Math.floor(gpRate4*10)/10)+"%");

		$("#costRate1").text(formatNum(Math.floor(costRate1*10)/10)+"%");
		$("#costRate2").text(formatNum(Math.floor(costRate2*10)/10)+"%");
		$("#costRate3").text(formatNum(Math.floor(costRate3*10)/10)+"%");
		$("#costRate4").text(formatNum(Math.floor(costRate4*10)/10)+"%");

		$("#sdxMixRate1").text(formatNum(Math.floor(sdxMixRate1*10)/10)+"%");
		$("#sdxMixRate2").text(formatNum(Math.floor(sdxMixRate2*10)/10)+"%");
		$("#sdxMixRate3").text(formatNum(Math.floor(sdxMixRate3*10)/10)+"%");
		$("#sdxMixRate4").text(formatNum(Math.floor(sdxMixRate4*10)/10)+"%");

		$("#totalCostRate1").text(formatNum(Math.floor(totalCostRate1)));
		$("#totalCostRate2").text(formatNum(Math.floor(totalCostRate2)));
		$("#totalCostRate3").text(formatNum(Math.floor(totalCostRate3)));
		$("#totalCostRate4").text(formatNum(Math.floor(totalCostRate4))+"%");

		$("#caapPerNSV1").text(formatNum(Math.floor(caapPerNSV1*10)/10)+"%");
		$("#caapPerNSV2").text(formatNum(Math.floor(caapPerNSV2*10)/10)+"%");
		$("#caapPerNSV3").text(formatNum(Math.floor(caapPerNSV3*10)/10)+"%");
		$("#caapPerNSV4").text(formatNum(Math.floor(caapPerNSV4*10)/10)+"%");


		$("#mThan36MContract").text(formatNum(mThan36MContract));
		$("#adCostPerGSV").text(formatNum(Math.floor(adCostPerGSV*10)/10)+"%");
		$("#prevYearChgCost").text(formatNum(Math.floor(prevYearChgCost*10)/10)+"%");
		$("#minVolYN").text(formatNum(Math.floor(minVolYN*10)/10));

		//$("#targetRate").text(isNumber(formatNum(Math.floor(GSV1*compareTargetRate)))? formatNum(Math.floor(GSV1*compareTargetRate)):"0");
		var expcCommt = "";
		if(APContract/contractMonth > 800 ) {
			$("#apprExpc").val('2');
		}else{
			$("#apprExpc").val('0');
		}

		//if( $("#apprStateCD").val() == "10" || $("#apprStateCD").val() == "40"){

		// if(mThan36MContract > 36000 || adCostPerGSV > compareGSVRate){
		// 	$("#apprExpc").val('2');
		//
		// 	if(mThan36MContract > 36000){
		// 		expcCommt += "비용 초과";
		// 	}
		//
		// 	if(adCostPerGSV > compareGSVRate){
		// 		if(expcCommt == ""){
		// 			expcCommt += "AD Cost/GSV 초과";
		// 		}else {
		// 			expcCommt += ", AD Cost/GSV 초과";
		// 		}
		// 	}
		//
		// 	if($("#contractDivCD").val() != "10"){
		// 		if(GSV1*compareTargetRate > GSV2){
		// 			$("#perfDivCD").val("20");
		// 			$("#perfDivCDNm").text("미실적");
		// 			if(expcCommt == ""){
		// 				expcCommt += "미실적 업소";
		// 			}else {
		// 				expcCommt += ", 미실적 업소";
		// 			}
		// 		}else{
		// 			$("#perfDivCD").val("10");
		// 			$("#perfDivCDNm").text("실적");
		// 		}
		// 	}else{
		// 		$("#perfDivCD").val("");
		// 		$("#perfDivCDNm").text("");
		// 	}
		//
		//
		// 	if ($("#chainYN").val() ==  "Y" && $("#chainADContractYN").val() == "Y") {
		// 		if ($("#chainTargetRate").val() < 90){
		// 			if(expcCommt == ""){
		// 				expcCommt += "체인계약 달성률 90% 미만";
		// 			}else {
		// 				expcCommt += ", 체인계약 달성률 90% 미만";
		// 			}
		// 		} else if($("#chainTargetRate").val() >= 90 && $("#chainTargetRate").val() < 100){
		// 			//$("#apprExpc").val('0');
		// 			if(expcCommt == ""){
		// 				expcCommt += "체인계약 달성률 90% 이상 100% 미만";
		// 			}else{
		// 				expcCommt += ", 체인계약 달성률 90% 이상 100% 미만";
		// 			}
		// 		} else {
		// 			//$("#apprExpc").val('0');
		// 			if (expcCommt == ""){
		// 				expcCommt += "No Exception(chain)";
		// 			} else{
		// 				expcCommt += ", No Exception(chain)";
		// 			}
		// 		}
		// 	}
		//
		// } else {
		// 	if($("#contractDivCD").val() != "10"){
		// 		if(GSV1*compareTargetRate > GSV2){
		// 			$("#perfDivCD").val("20");
		// 			$("#perfDivCDNm").text("미실적");
		// 			if(expcCommt == ""){
		// 				expcCommt += "미실적 업소";
		// 			}else {
		// 				expcCommt += ", 미실적 업소";
		// 			}
		// 		}else{
		// 			$("#perfDivCD").val("10");
		// 			$("#perfDivCDNm").text("실적");
		// 		}
		// 	}else{
		// 		$("#perfDivCD").val("");
		// 		$("#perfDivCDNm").text("");
		// 	}
		//
		// 	//직전계약 달성률에 따른 승인라인 조건
		// 	if($("#prevTargetRate").val() < 90){
		// 		$("#apprExpc").val('2');
		// 		if(expcCommt == ""){
		// 			expcCommt += "직전계약 달성률 90% 미만";
		// 		}else {
		// 			expcCommt += ", 직전계약 달성률 90% 미만";
		// 		}
		// 	} else if($("#prevTargetRate").val() >= 90 && $("#prevTargetRate").val() < 100){
		// 		$("#apprExpc").val('0');
		// 		if(expcCommt == ""){
		// 			expcCommt += "직전계약 달성률 90% 이상 100% 미만";
		// 		}else{
		// 			expcCommt += ", 직전계약 달성률 90% 이상 100% 미만";
		// 		}
		// 	} else {
		// 		$("#apprExpc").val('0');
		// 		if(expcCommt == ""){
		// 			expcCommt += "No Exception";
		// 		}else{
		// 			expcCommt += ", No Exception";
		// 		}
		// 	}
		//
		//
		// 	if ($("#chainYN").val() ==  "Y" && $("#chainADContractYN").val() == "Y") {
		// 		if ($("#chainTargetRate").val() < 90){
		// 			$("#apprExpc").val('2');
		// 			if(expcCommt == ""){
		// 				expcCommt += "체인계약 달성률 90% 미만";
		// 			}else {
		// 				expcCommt += ", 체인계약 달성률 90% 미만";
		// 			}
		// 		} else if($("#chainTargetRate").val() >= 90 && $("#chainTargetRate").val() < 100){
		// 			$("#apprExpc").val('0');
		// 			if(expcCommt == ""){
		// 				expcCommt += "체인계약 달성률 90% 이상 100% 미만";
		// 			}else{
		// 				expcCommt += ", 체인계약 달성률 90% 이상 100% 미만";
		// 			}
		// 		} else {
		// 			$("#apprExpc").val('0');
		// 			if (expcCommt == ""){
		// 				expcCommt += "No Exception(chain)";
		// 			} else{
		// 				expcCommt += ", No Exception(chain)";
		// 			}
		// 		}
		// 	}

			//exception 1 사용안함
// 				if(prevYearChgCost > compareChgCost || minVolYN < compareMinVol){
// 					$("#apprExpc").val('1');

// 					if(prevYearChgCost > compareChgCost){
// 						expcCommt += "전년 대비 Cost 초과";
// 					}

// 					if(minVolYN < compareMinVol){
// 						if(expcCommt == ""){
// 							expcCommt += "최소 VOL 미충족";
// 						}else {
// 							expcCommt += ", 최소 VOL 미충족";
// 						}
// 					}
// 				}else{
// 					$("#apprExpc").val('0');
// 					expcCommt += "No Exception";
// 				}
// 		}
// 		$("#expcCommt").val(expcCommt);
// 		//}

		if(mThan36MContract > 36000) $("#td_mThan36MContract").attr('style',"background-color:#FF0000; text-align:right;");
		else $("#td_mThan36MContract").attr('style',"background-color:#00FF00; text-align:right;");

		if(adCostPerGSV > compareGSVRate) $("#td_adCostPerGSV").attr('style',"background-color:#FF0000; text-align:right;");
		else $("#td_adCostPerGSV").attr('style',"background-color:#00FF00; text-align:right;");

		if(prevYearChgCost < compareChgCost) $("#td_prevYearChgCost").attr('style',"background-color:#00FF00; text-align:right;");
		//else $("#td_prevYearChgCost").attr('style',"background-color:#FF0000; text-align:right;");

		if(minVolYN > compareMinVol) $("#td_minVolYN").attr('style',"background-color:#00FF00; text-align:right;");
		//else $("#td_minVolYN").attr('style',"background-color:#FF0000; text-align:right;");

		grid_prd.refresh();
	}

	//날짜 유효성 체크
	function validateStartDate(){
		var startDate = $("#startYearCD").val() + $("#startMonthCD").val();
		var endDate = $("#endYearCD").val() + $("#endMonthCD").val();
		var clientDate = "${params.clientDate}";
		var flag = true;

		if($("#endYearCD").val() != "" && $("#endMonthCD").val() != ""){
			if(flag){
				if(startDate > endDate){
					alert("<fmt:message key="AD01001B.msg1"/>");
					//$("#startYearCD").val("${params.clientDate}".substring(0,4));
					//$("#startMonthCD").val("${params.clientDate}".substring(4,6));
					flag = false;
				}
			}
		}
		//운영 반영시 추가
		/* if(flag){
			if(clientDate < startDate){
				alert("<fmt:message key="AD01001B.msg4"/>");
				$("#startYearCD").val("${params.clientDate}".substring(0,4));
				$("#startMonthCD").val("${params.clientDate}".substring(4,6));
				flag = false;
			}
		} */

		if(flag){
			if(checkCurrContractDt()){
				alert("<fmt:message key="AD01001B.msg3"/>");
				flag=false;
			}
		}
		calculateDate();

		return flag;
	}

	//날짜 유효성 체크
	function validateEndDate(){
		var startDate = $("#startYearCD").val() + $("#startMonthCD").val();
		var endDate = $("#endYearCD").val() + $("#endMonthCD").val();
		var flag = true;

		if($("#endYearCD").val() != "" && $("#endMonthCD").val() != ""){
			if(startDate > endDate){
				alert("<fmt:message key="AD01001B.msg1"/>");
				$("#endYearCD").val(startDate.substring(0,4));
				$("#endMonthCD").val(startDate.substring(4,6));
				calculateDate();
				flag = false;
			}
		}
		if($("#endYearCD").val() != "" && $("#endMonthCD").val() != ""){
			if(flag){
				if(checkCurrContractDt()){
					alert("<fmt:message key="AD01001B.msg3"/>");
					flag=false;
				}
			}
		}
		calculateDate();

		return flag;
	}

	function checkCurrContractDt(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100110S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"adSupportId;");
		table.setParameter("format",
				"str;");

		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("startDt", $("#startYearCD").val() + $("#startMonthCD").val());
		if($("#endYearCD").val() != "" && $("#endMonthCD").val() != ""){
			table.setParameter("endDt", $("#endYearCD").val() + $("#endMonthCD").val());
		}
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			return true;
		}else{
			return false;
		}
	}


	function setADProgram(){
		if(($("#APContract").val()).replace(',','') > 90000){
			$("#adProgram").val("<fmt:message key="AD01001B.TLA"/>");
		} else if(($("#APContract").val()).replace(',','') > 1600){
			$("#adProgram").val("<fmt:message key="AD01001B.RLA"/>");
		} else if(($("#APContract").val()).replace(',','') >= 400){
			$("#adProgram").val("<fmt:message key="AD01001B.simpleAD"/>");
		} else if(($("#APContract").val()).replace(',','') > 0){
			$("#adProgram").val("");
		}

	}

	function setVenueActivity(){
		if(($("#APContract").val()).replace(',','') > 90000){
			$("#venueActivity3").val("<fmt:message key="AD01001B.venueActivity3"/>");
			$("#venueActivity2").val("<fmt:message key="AD01001B.venueActivity2"/>");
			$("#venueActivity1").val("<fmt:message key="AD01001B.venueActivity1"/>");
		} else if(($("#APContract").val()).replace(',','') > 1600){
			$("#venueActivity3").val("");
			$("#venueActivity2").val("<fmt:message key="AD01001B.venueActivity2"/>");
			$("#venueActivity1").val("<fmt:message key="AD01001B.venueActivity1"/>");
		} else if(($("#APContract").val()).replace(',','') >= 400){
			$("#venueActivity3").val("");
			$("#venueActivity2").val("");
			$("#venueActivity1").val("<fmt:message key="AD01001B.venueActivity1"/>");
		} else if(($("#APContract").val()).replace(',','') > 0){
			$("#venueActivity3").val("");
			$("#venueActivity2").val("");
			$("#venueActivity1").val("");
		}
	}

	function setCurrContracDt(checkEl, selDt){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100140S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"currContractEndDt;");
		table.setParameter("format",
				"str;");

		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("selDt", selDt);
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			var currContractYear = parseInt(table.getData(0,0).substring(0,4),'10');
			var currContractMonth = parseInt(table.getData(0,0).substring(4,6),'10');
			if(checkEl == "startDt"){
				if(currContractMonth == 12){
					$("#startYearCD").val((currContractYear+1).toString());
					$("#startMonthCD").val("01");
				}else if(currContractMonth > 8){
					$("#startYearCD").val(table.getData(0,0).substring(0,4));
					$("#startMonthCD").val((currContractMonth+1).toString());
				}else{
					$("#startYearCD").val(table.getData(0,0).substring(0,4));
					$("#startMonthCD").val("0" +(currContractMonth+1).toString());
				}
			}else{
				if(currContractMonth == 12){
					$("#endYearCD").val((currContractYear+1).toString());
					$("#endMonthCD").val("01");
				}else if(currContractMonth > 8){
					$("#endYearCD").val(table.getData(0,0).substring(0,4));
					$("#endMonthCD").val((currContractMonth+1).toString());
				}else{
					$("#endYearCD").val(table.getData(0,0).substring(0,4));
					$("#endMonthCD").val("0" +(currContractMonth+1).toString());
				}
			}
		}else{
			if(checkEl == "startDt"){
				$("#startYearCD").val("");
				$("#startMonthCD").val("");
			}else{
				$("#endYearCD").val("");
				$("#endMonthCD").val("");
			}
		}
	}
	function search_targetRate(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100111S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"targetRate;");
		table.setParameter("format",
				"str;");

		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("startDt", $("#startYearCD").val() + $("#startMonthCD").val());
		table.setParameter("endDt", $("#endYearCD").val() + $("#endMonthCD").val());
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#targetRate").text(formatNum(table.getData(0,0)) + "%");
		}else{
			$("#targetRate").text("0%");
		}
	}

	function checkPrevIncentive(){
		var table = new AW.XML.Table;
		var flag = false;
		table.setURL("${contextPath}/service/simpleAction/AD0100119S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"prevIncentive;");
		table.setParameter("format",
				"str;");

		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("startDt", $("#startYearCD").val() + $("#startMonthCD").val());
		table.setParameter("endDt", $("#endYearCD").val() + $("#endMonthCD").val());
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			if(table.getData(0,0) == null || table.getData(0,0) == '' || table.getData(0,0) == 'null'){
				flag = true;
			}else {
				if(table.getData(0,0) > 0){
					flag = false;
				}else{
					flag = true;
				}
			}
		}else{
			flag = true;
		}
		return flag;
	}

	function search_prevTargetRate(){
		var table = new AW.XML.Table;
		var flag = false;
		table.setURL("${contextPath}/service/simpleAction/AD0100120S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"prevTargetRate;");
		table.setParameter("format",
				"str;");

		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("startDt", $("#startYearCD").val() + $("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			if(table.getData(0,0) < 0){
				$("#prevTargetRate").val("N");
				$("#prevTargetRateText").text("기존 달성률 없음");
			}else{
				$("#prevTargetRate").val(table.getData(0,0));
				$("#prevTargetRateText").text("0");
			}
		}else{
			$("#prevTargetRate").val("N");
			$("#prevTargetRateText").text("기존 달성률 없음");
		}
	}

	//날짜계산
	function calculateDate(){
		var gap = 0;
// 		var compareStartYm = '';
// 		var compareEndYm = '';

// 		if(parseInt($("#startMonthCD").val()) > 6 ){
// 			compareStartYm = ((parseInt($("#startYearCD").val())-1).toString())+ '07';
// 			compareEndYm = (parseInt($("#startYearCD").val()).toString()) + '06';
// 		}else {
// 			compareStartYm = ((parseInt($("#startYearCD").val())-2).toString())+ '07';
// 			compareEndYm = ((parseInt($("#startYearCD").val())-1).toString()) + '06';
// 		}

		if($("#endYearCD").val() != "" && $("#endMonthCD").val() != ""){
			if($("#startYearCD").val() == $("#endYearCD").val()){
				$("#contractMonth").text(parseInt($("#endMonthCD").val(),'10') - parseInt($("#startMonthCD").val(),'10') + 1);
				$("#contractMonth").text($("#contractMonth").text()+" 개월");
			}else{
				var yearGap = parseInt($("#endYearCD").val())-parseInt($("#startYearCD").val());
				$("#contractMonth").text((yearGap * 12) + parseInt($("#endMonthCD").val(),'10') - parseInt($("#startMonthCD").val(),'10') + 1);
				$("#contractMonth").text($("#contractMonth").text()+" 개월");
			}
		}else{
			$("#contractMonth").text("0 개월");
		}
		//$("#compareStartYm").val(compareStartYm);
		//$("#compareEndYm").val(compareEndYm);
	}

	function dateChangeCheck(startEndChk) {
		var flag = true;

		if (startEndChk == "start") {
			if (!validateStartDate()) {
				flag = false;
			}
		} else if(startEndChk == "end"){
			if(!validateEndDate()) {
				flag = false;
			}
		} else {

			if(checkCurrContractDt()){
				alert("<fmt:message key="AD01001B.msg3"/>");
				flag=false;
			}
		}

		return flag;
	}

	//체인 업소 여부 조회
	function chainVenueCheck() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100121S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"chainCnt;");
		table.setParameter("format",
				"str;");
		table.setParameter("venueCD", $("#venueCD").val());
		table.request();

		var rowCount = table.getCount();


		if (rowCount > 0) {
			if (table.getData(0,0) > 0){
				$("#chainYN").val("Y");
			} else {
				$("#chainYN").val("N");
			}
		}
	}

	//체인 계약 여부 조회
	function chainADContractCheck() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100126S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey", "chainADContractCnt;");
		table.setParameter("format", "str;");
		table.setParameter("venueCD", $("#venueCD").val());
		table.request();

		var rowCount = table.getCount();

		if (rowCount > 0) {
			if (table.getData(0,0) > 0){
				$("#chainADContractYN").val("Y");
			} else {
				$("#chainADContractYN").val("N");
			}
		}
	}

	//계약 날짜 기준 chain GSV
	function Search_dateChainGSV() {
		var chainGSV = 0;

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100122S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey", "chainGSV;");
		table.setParameter("format", "str;");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("startDt",  $("#startYearCD").val() + $("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();

		if (rowCount > 0) {
			if (table.getData(0,0) > 0) {
				chainGSV = table.getData(0,0);

			} else {
				//계약 날짜 기준 chain GSV가 0일 경우
				chainGSV = Search_prevChainGSV(chainGSV);
			}
		}

		return chainGSV;
	}

	//직전 계약 기준 chain GSV
	function Search_prevChainGSV(chainGSV) {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100124S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey", "chainGSV;");
		table.setParameter("format", "str;");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("startDt",  $("#startYearCD").val() + $("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();

		if (rowCount > 0) {
			chainGSV = table.getData(0,0);
		}

		return chainGSV;
	}

	//계약 날짜 기준 Result GSV
	function Search_dateResultGSV() {
		var rltGSV = 0;

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100123S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey", "rltGsv;");
		table.setParameter("format", "str;");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("startDt",  $("#startYearCD").val() + $("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();

		if (rowCount > 0) {
			if (table.getData(0,0) > 0) {
				rltGSV = table.getData(0,0);
			} else {
				// 계약 날짜 result GSV 값이 0일 경우
				rltGSV = Search_prevResultGSV(rltGSV);
			}
		}

		return rltGSV;
	}

	//직전 계약 기준 Result GSV
	function Search_prevResultGSV(rltGSV) {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100125S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey", "rltGsv;");
		table.setParameter("format", "str;");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("startDt",  $("#startYearCD").val() + $("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();

		if (rowCount > 0) {
			rltGSV = table.getData(0,0);
		}

		return rltGSV;
	}

	function chainTargetRate() {

		chainVenueCheck();
		chainADContractCheck();

		$("#chainGSV").val(Search_dateChainGSV());
		$("#rltGSV").val(Search_dateResultGSV());

		if (($("#chainGSV").val() > 0)
				&& ($("#rltGSV").val() > 0)) {
			$("#chainTargetRate").val(unformatNum(Math.floor(($("#rltGSV").val()/$("#chainGSV").val()*100)*10)/10));
			$("#chainTargetRateNm").text("0");
		} else {
			$("#chainTargetRate").val("0");
			$("#chainTargetRateNm").text("0");
		}

	}

	/***************************************
	 * Button Action
	 ****************************************/
	function List(){
		//pageInit();
		parent.Search();
		parent.appletClose();
		$("#adSupportID").val('');
		$("#venue").val('');
		$("#venueCD").val('');
		$("#venueNm").val('');
		$("#venue_popup").show();
	}

	//계약서
	function Contract() {
		var table = new AW.XML.Table;
		var templateFile = "";

		if ($("#buCD_S").val() == "100") { //Local
			templateFile = "AD01001B";
		} else if($("#buCD_S").val() == "200") { //int'l
			templateFile = "AD01001B";
		} else if($("#buCD_S").val() == "300") { // beer
			templateFile = "AD01001B_Beer";
		} else {
			templateFile = "AD01001B";
		}

		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "AD0100118S");
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("templateFile", templateFile);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0,0) == "S") {
				form.action = "${contextPath}/service/simpleExport/download/?"+
						"tempFile="+table.getData(3,0)+
						"&downloadFile="+encodeURIComponent("광고계약서");
				form.target = "_self";
				form.submit();
			}
		}
	}


	function Save(){

		if($("#contractStateCD").val() == "10" || $("#contractStateCD").val() == "20" || $("#contractStateCD").val() == "30") {
			alert("<fmt:message key="AD02004A.msg3"/>");
			return;
		}

		if($("#apprStateCD").val() == "50") {
			if(!confirm("<fmt:message key="AD01001B.msg10"/>")) {
				return;
			}
		}
		<%--if(maxRow_prd == 0) {--%>
		<%--	alert("<fmt:message key="info.nullData.save"/>");--%>
		<%--	return;--%>
		<%--}--%>
		if($("#endYearCD").val()=="" || $("#endMonthCD").val()=="") {
			alert("<fmt:message key="AD01001B.msg5"/>");
			return;
		}

		<%--if(parseFloat($("#limitGsv").val())/1000>unformatNum($("#GSV2").text())){--%>
		<%--	alert("<fmt:message key="AD01001B.msg7"><fmt:param value='"+formatNum($("#limitGsv").val())+"' /></fmt:message>");--%>
		<%--	return;--%>
		<%--}--%>

		if($("#buCD_S").val() == ""){
			alert("<fmt:message key="AD01001B.msg11"/>");
			return;
		}

		if(!checkRequiredAD()){
			return;
		}

		if(!dateChangeCheck()) {
			return;
		}

		calculateDate();

		var prdCDs = new Array();
		var prdQtys = new Array();
		var activeFlgs = new Array();
		var prdTotalAmt = 0;
		var count = 0;
		for (var i=0; i<maxRow_prd; i++) {
			prdCDs[count] = grid_prd.getCellText(_col_prd.prdCD, i);
			prdQtys[count] = grid_prd.getCellText(_col_prd.prdQty, i);
			activeFlgs[count] = grid_prd.getCellText(_col_prd.activeFlg, i);
			count++;
		}

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ad01/saveAD");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("startDT", $("#startYearCD").val()+$("#startMonthCD").val());
		table.setParameter("endDT", $("#endYearCD").val()+$("#endMonthCD").val());
		table.setParameter("apprStateCD", $("#apprStateCD").val());
		table.setParameter("contractStateCD", $("#contractStateCD").val());
		table.setParameter("payStateCD", $("#payStateCD").val());
		table.setParameter("perfDivCD", $("#perfDivCD").val());
		table.setParameter("contractDivCD", $("#contractDivCD").val());
		table.setParameter("dkmdtpCD", "${params.dkmdTpCD}");
		table.setParameter("contractMonth", parseFloat($("#contractMonth").text().slice(0,-3), "10"));
		table.setParameter("apAmt", unformatNum($("#APContract").val())*1000);
		table.setParameter("posmAmt", unformatNum($("#POSM").val())*1000);
		table.setParameter("incAmt", unformatNum($("#real_threePercentIncentive").val()));
		table.setParameter("totalAmt", unformatNum($("#real_total").val()));
		table.setParameter("prdTotalAmt", unformatNum($("#totalVol").text()));
		table.setParameter("commt", $("#commt").val());
		table.setParameter("rageSphereCD", $("#rageSphereCD").val());
		table.setParameter("officeCD", $("#officeCD").val());
		table.setParameter("apprExpc", $("#apprExpc").val());
		table.setParameter("expcCommt", $("#expcCommt").val());
		table.setParameter("activeYN", 'N');
		table.setParameter("seq", $("#seq").val());
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("prdQtys", prdQtys);
		table.setParameter("activeFlgs", activeFlgs);
		table.setParameter("buCD", $("#buCD_S").val());
		table.setParameter("requiredADCD1", $("#requiredADCD1_S").val());
		table.setParameter("requiredADCD2", $("#requiredADCD2_S").val());
		table.setParameter("requiredADCD3", $("#requiredADCD3_S").val());
		table.setParameter("amt1", $("#amt1").val());
		table.setParameter("amt2", $("#amt2").val());
		table.setParameter("amt3", $("#amt3").val());
		table.setParameter("location1", $("#location1").val());
		table.setParameter("location2", $("#location2").val());
		table.setParameter("location3", $("#location3").val());
		table.setParameter("adProgram", $("#adProgram").val());
		table.setParameter("venueActivity1", $("#venueActivity1").val());
		table.setParameter("venueActivity2", $("#venueActivity2").val());
		table.setParameter("venueActivity3", $("#venueActivity3").val());
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			$("#adSupportID").val(table.getData(3,0));
			Search();
		}
		else {
			alert(table.getData(1,0));
		}

	}

	function Search(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100108S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"adSupportID;venueCD;venueNm;startDT;endDT;"+
				"apprStateCD;apprStateName;contractStateCD;contractStateName;contract" +
				"DivCD;"+
				"contractDivCDNm;perfDivCD;perfDivCDNm;contractMonth;APContract;" +
				"POSM;threePercentIncentive;total;totalVol;commt;"+
				"rageSphereCD;officeCD;apprExpc;seq;expcCommt;"+
				"buCD;requiredADCD1;requiredADCD2;requiredADCD3;amt1;"+
				"amt2;amt3;location1;location2;location3;adProgram;venueActivity1;venueActivity2;venueActivity3;");
		table.setParameter("format",
				"str;str;str;str;str;"+
				"str;str;str;str;str;"+
				"str;str;str;str;str;"+
				"str;str;str;str;str;"+
				"str;str;str;str;str;"+
				"str;str;str;str;str;"+
				"str;str;str;str;str;str;str;str;str;");

		table.setParameter("adSupportID", $("#adSupportID").val());
		table.request();
		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#adSupportID").val(table.getData(0,0));
			$("#venueCD").val(table.getData(1,0));
			$("#venue").val(table.getData(1,0));
			$("#venueNm").val(table.getData(2,0));
			$("#startYearCD").val(table.getData(3,0).substring(0,4));
			$("#startMonthCD").val(table.getData(3,0).substring(4,6));
			$("#endYearCD").val(table.getData(4,0).substring(0,4));
			$("#endMonthCD").val(table.getData(4,0).substring(4,6));
			$("#apprStateCD").val(table.getData(5,0));
			$("#apprStateCDName").text(table.getData(6,0));
			$("#contractStateCD").val(table.getData(7,0));
			$("#contractStateName").text(table.getData(8,0));
			$("#contractDivCD").val(table.getData(9,0));
			$("#contractDivCDNm").text(table.getData(10,0));
			$("#perfDivCD").val(table.getData(11,0));
			$("#perfDivCDNm").text(table.getData(12,0));
			$("#contractMonth").text(table.getData(13,0)+ " 개월");
			$("#APContract").val(formatNum(table.getData(14,0)/1000));
			//여기
			// setADProgram();
			// setVenueActivity();
			$("#POSM").val(formatNum(table.getData(15,0)/1000));
			$("#threePercentIncentive").val(table.getData(16,0));
			$("#total").val(table.getData(17,0));
			$("#totalVol").val(table.getData(18,0));
			$("#commt").val(table.getData(19,0));
			$("#rageSphereCD").val(table.getData(20,0));
			$("#officeCD").val(table.getData(21,0));
			$("#apprExpc").val(table.getData(22,0));
			$("#seq").val(table.getData(23,0));
			$("#expcCommt").val(table.getData(24,0));
			if($("#apprStateCD").val() == "50"){
				btnContract.setControlDisabled(false);
			}
			else {
				btnContract.setControlDisabled(true);
			}
			Search_prd();
			calculateDate();
			Search_venueInfo();
			Search_prevYearInfo();
			calculateAD();
			settingBu(table.getData(25,0));
			getRequiredAD(table.getData(25,0));	// 위치 변경x, selectbox 먼저 setting 후 이후의 값 설정
			$("#requiredADCD1_S").val(table.getData(26,0));
			$("#requiredADCD2_S").val(table.getData(27,0));
			$("#requiredADCD3_S").val(table.getData(28,0));
			$("#amt1").val(table.getData(29,0));
			$("#amt2").val(table.getData(30,0));
			$("#amt3").val(table.getData(31,0));
			$("#location1").val(table.getData(32,0));
			$("#location2").val(table.getData(33,0));
			$("#location3").val(table.getData(34,0));
			$("#adProgram").val(table.getData(35,0));
			$("#venueActivity1").val(table.getData(36,0));
			$("#venueActivity2").val(table.getData(37,0));
			$("#venueActivity3").val(table.getData(38,0));
			settingRequiredAD();
		}
	}

	function Search_prevYearInfo(){
		Search_prevYearInfo1();
		Search_prevYearInfo2();
		Search_prevYearInfo3();
		Search_prevYearInfo4();
		//Search_prevYearInfo5();
		//Search_prevYearInfo6();
		calculateAD();
	}
	function Search_prevYearInfo1(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100104S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"prevEfpSum;prevDutySum;prevCogsSum;");
		table.setParameter("format",
				"str;str;str;");

		//table.setParameter("compareStartYm", $("#compareStartYm").val());
		//table.setParameter("compareStartYear", ($("#compareStartYm").val()).substring(0,4));
		//table.setParameter("compareEndYm", $("#compareEndYm").val());
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("startDT", $("#startYearCD").val()+$("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#prevEfpSum").val(table.getData(0,0));
			$("#prevDutySum").val(table.getData(1,0));
			$("#prevCogsSum").val(table.getData(2,0));
		}else{
			$("#prevEfpSum").val(0);
			$("#prevDutySum").val(0);
			$("#prevCogsSum").val(0);
		}
	}
	function Search_prevYearInfo2(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100105S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"prevAPamt;prevPosmAmt;prevContractMonth;prevPayAmtSum;");
		table.setParameter("format",
				"str;str;str;str;");

		//table.setParameter("compareStartYm", $("#compareStartYm").val());
		//table.setParameter("compareEndYm", $("#compareEndYm").val());
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("startDT", $("#startYearCD").val()+$("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#prevAPamt").val(table.getData(0,0));
			$("#prevPosmAmt").val(table.getData(1,0));
			$("#prevContractMonth").val(table.getData(2,0));
			$("#prevPayAmtSum").val(table.getData(3,0));
		}else{
			$("#prevAPamt").val(0);
			$("#prevPosmAmt").val(0);
			$("#prevContractMonth").val(0);
			$("#prevPayAmtSum").val(0);
		}
	}
	function Search_prevYearInfo3(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100106S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"prevEuSum;");
		table.setParameter("format",
				"str;");

		//table.setParameter("compareStartYm", $("#compareStartYm").val());
		//table.setParameter("compareEndYm", $("#compareEndYm").val());
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("startDT", $("#startYearCD").val()+$("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#prevEuSum").val(table.getData(0,0));
		}else{
			$("#prevEuSum").val(0);
		}
	}
	function Search_prevYearInfo4(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100107S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"prevSdxMixRate;");
		table.setParameter("format",
				"str;");

		//table.setParameter("compareStartYm", $("#compareStartYm").val());
		//table.setParameter("compareEndYm", $("#compareEndYm").val());
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("startDT", $("#startYearCD").val()+$("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#prevSdxMixRate").val(table.getData(0,0));
		}else{
			$("#prevSdxMixRate").val(0);
		}
	}

	function Search_venueInfo(){
		Search_venueInfo1();
		Search_venueInfo2();
		search_prevTargetRate();
		chainTargetRate();
		calculateAD();
	}
	function Search_venueInfo1(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100113S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"rageSphereCD;officeCD;");
		table.setParameter("format",
				"str;str;");

		table.setParameter("empID", "${params.empID}");
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#rageSphereCD").val(table.getData(0,0));
			$("#officeCD").val(table.getData(1,0));
		}
	}
	function Search_venueInfo2(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100114S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"compareGSVRate;compareTargetRate;compareMinVol;limitGsv;compareChgCost;venueDivCD;");
		table.setParameter("format",
				"str;str;str;str;str;str;");

		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("startDT", $("#startYearCD").val()+$("#startMonthCD").val());
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#contractDivCDNm").text("재계약");
			$("#contractDivCD").val("20");
			$("#compareGSVRate").val(table.getData(0,0));
			$("#compareTargetRate").val(table.getData(1,0));
			$("#compareMinVol").val(table.getData(2,0));
			$("#limitGsv").val(table.getData(3,0));
			$("#compareChgCost").val(table.getData(4,0));
			$("#venueDivCD").val(table.getData(5,0));
		}else{
			$("#contractDivCDNm").text("신규");
			$("#contractDivCD").val("10");
			Search_venueInfo3();
		}
	}
	function Search_venueInfo3(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100115S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"compareGSVRate;compareTargetRate;compareMinVol;limitGsv;compareChgCost;venueDivCD");
		table.setParameter("format",
				"str;str;str;str;str;str;");

		table.setParameter("venueCD", $("#venueCD").val());

		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#compareGSVRate").val(table.getData(0,0));
			$("#compareTargetRate").val(table.getData(1,0));
			$("#compareMinVol").val(table.getData(2,0));
			$("#limitGsv").val(table.getData(3,0));
			$("#compareChgCost").val(table.getData(4,0));
			$("#venueDivCD").val(table.getData(5,0));
		}else{
			$("#compareGSVRate").val("0");
			$("#compareTargetRate").val("0");
			$("#compareMinVol").val("0");
			$("#limitGsv").val("0");
			$("#compareChgCost").val("0");
			$("#venueDivCD").val("");
		}
	}

	var _i_prd = 0;
	var _col_prd = {
		prdNm : _i_prd++
		, prdQty : _i_prd++
		, deleteBtn : _i_prd++
		, EFP : _i_prd++
		, duty : _i_prd++
		, COGS : _i_prd++
		, eu : _i_prd++
		, sdxYN : _i_prd++
		, prdCD : _i_prd++
		, seq : _i_prd++
		, activeFlg : _i_prd++
	};
	function Search_prd() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0100109S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"prdNm;prdQty;deleteBtn;EFP;duty;"+
				"COGS;eu;sdxYN;prdCD;seq;");
		table.setParameter("format",
				"str;num;str;str;str;"+
				"str;str;str;str;str;");
		table.setParameter("adSupportID", $("#adSupportID").val());
		table.setParameter("seq", $("#seq").val());
		table.request();

		createGrid_prd();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			var data = new Array();
			for (var i=0; i<rowCount; i++) {
				data[i] = [
					table.getData(_col_prd.prdNm,i)
					, table.getData(_col_prd.prdQty,i)
					, ""
					, table.getData(_col_prd.EFP,i)
					, table.getData(_col_prd.duty,i)
					, table.getData(_col_prd.COGS,i)
					, table.getData(_col_prd.eu,i)
					, table.getData(_col_prd.sdxYN,i)
					, table.getData(_col_prd.prdCD,i)
					, table.getData(_col_prd.seq,i)
					, "U"
				];
			}
			$("#seq").val(table.getData(_col_prd.seq, 0));

			grid_prd.setCellData(data);
			grid_prd.setRowCount(rowCount);

		}
		grid_prd.refresh();
		maxRow_prd = rowCount;
	}

	function checkADWriteYN(){
		var table = new AW.XML.Table;
		var flag = false;
		table.setURL("${contextPath}/service/simpleAction/AD0100117S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey", "adWriteYN;");
		table.setParameter("format", "str;");
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			if('Y' == table.getData(0,0)){
				flag = true;
			}else{
				flag = false;
			}
		}else{
			flag = false;
		}

		return flag;
	}


	/*****************************************************
	 *   Grid Setting
	 *****************************************************/
	var columns_prd = [
		"<fmt:message key="AD01001B.brand"/>"
		, "<fmt:message key="AD01001B.prdQty"/>"
		, "<fmt:message key="AD01001B.deleteBtn"/>"
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
		for(var i=0;i<columns_prd.length;i++){grid_prd.getHeaderTemplate(i).setStyle("text-align", "center");};
		grid_prd.setColumnCount(columns_prd.length);
		grid_prd.setCellFormat([str, num]);
		grid_prd.setCellEditable(true);
		grid_prd.setCellEditable(false, _col_prd.prdNm);
		grid_prd.setCellEditable(false, _col_prd.deleteBtn);

		grid_prd.setCellImage("deleteGrid",_col_prd.deleteBtn);
		var deleteFlag = new AW.Templates.Image;
		var delImage = deleteFlag.getContent("box/image");
		delImage.setTag("a");
		delImage.setAttribute("href", function(){
			return "javascript:removeRow(grid_prd.getCurrentRow())";
		});
		grid_prd.setCellTemplate(deleteFlag, _col_prd.deleteBtn);

		grid_prd.onCellEditStarted = function(text, col, row){
			if (col == _col_prd.prdQty) {
				this.setCellText(unformatNum(text), col, row);
			}
		};

		grid_prd.onCellEditEnded = function(text, col, row) {
			if (col == _col_prd.prdQty) {
				this.setCellText(formatNum(unformat(text)), col, row);
				calculateAD();
			}
		};

		grid_prd.onCellValidated = function(text, col, row) {
			if (col == _col_prd.prdQty) {
				this.setCellText(formatNum(unformat(text)), col, row);
				calculateAD();
			}
		};

		grid_prd.onCellValidating = function(text, col, row) {
			if (col == _col_prd.prdQty) {
				if(unformat(text).length > 6) {
					alert("<fmt:message key="info.validate.numlength"><fmt:param value='6'/></fmt:message>");
					this.setCellText(unformat(text).substring(0,6),col,row);
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
				this.setCellText(formatNum(unformat(text)), col, row);
			}
		};
	}

	/*****************************************************
	 *   필수광고물
	 *****************************************************/

	var _col_bu = {
		"code" : 0
		, "name" : 1
	}
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}

	function getRequiredAD(code) {
		if(code == "" || code == null){
			var venueDivCD = $("#venueDivCD").val();
			if(venueDivCD == "10") code = "200";
			else if(venueDivCD == "20" || venueDivCD == "40") code = "100";
			else if(venueDivCD == "30") code = "300";
			else if(venueDivCD == "50") code = "400";

		}

		var requiredADSelector = $("[id^=requiredADCD]");
		var amtSelector = $("[id^=amt]");

		// selectbox 초기화
		requiredADSelector.attr("disabled",false);
		amtSelector.attr("disabled",false);

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("languageCD", "${params.languageCD}");
		table.setParameter("codeDiv", "REQUIREDADCD");
		table.setParameter("attrib01", code);
		table.request();

		if(table.getCount() > 0) {
			requiredADSelector.find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
			for(var i=0; i<table.getCount(); i++){
				if(table.getData(_col_cd.code,i)==code){
					requiredADSelector.append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
				} else {
					requiredADSelector.append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
				}
			}
		}
	}

	function selectBu(){
		var venueDivCD = $("#venueDivCD").val();
		var buCD = "";
		if(venueDivCD == "10") buCD = "200";
		else if(venueDivCD == "20" || venueDivCD == "40") buCD = "100";
		else if(venueDivCD == "30") buCD = "300";
		else if(venueDivCD == "50") buCD = "400";

		var requiredADSelector = $("[id^=requiredADCD]");
		var amtSelector = $("[id^=amt]");

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("languageCD", "${params.languageCD}");
		table.setParameter("codeDiv", "BUCD");
		table.request();

		if(table.getCount() > 0) {
			$("#buCD_S").find("option").remove();
			for(var i=0; i<table.getCount(); i++){
				if(table.getData(_col_bu.code,i)==buCD){
					$("#buCD_S").append('<option value="'+table.getData(_col_bu.code,i)+'" checked="true">'+table.getData(_col_bu.name,i)+'</option>');
				}
			}
		}

		requiredADSelector.val("");
		amtSelector.val("");
		$("#requiredAD_td").children('div:eq(0)').find("select,input").attr("disabled",false);
		$("#requiredAD_td").children('div:gt(0)').find("select,input").attr("disabled",true);
	}

	function settingBu(code){
		if(code == "" || code == null){
			var venueDivCD = $("#venueDivCD").val();
			if(venueDivCD == "10") code = "200";
			else if(venueDivCD == "20" || venueDivCD == "40") code = "100";
			else if(venueDivCD == "30") code = "300";
			else if(venueDivCD == "50") code = "400";
		}
		var requiredADSelector = $("[id^=requiredADCD]");
		var amtSelector = $("[id^=amt]");

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("languageCD", "${params.languageCD}");
		table.setParameter("codeDiv", "BUCD");
		table.request();

		if(table.getCount() > 0) {
			$("#buCD_S").find("option").remove();
			for(var i=0; i<table.getCount(); i++){
				if(table.getData(_col_bu.code,i)==code){
					$("#buCD_S").append('<option value="'+table.getData(_col_bu.code,i)+'" checked="true">'+table.getData(_col_bu.name,i)+'</option>');
				}
			}
		}
	}

	function selectRequiredAD(obj, idx){
		var code = $(obj).val();
		if(code == ""){
			$("#requiredAD_td").children('div:gt('+idx+')').find("select,input").val("");
			$("#requiredAD_td").children('div:gt('+idx+')').find("select,input").attr("disabled",true);
		} else{
			// 중복확인
			$("[id^=requiredADCD]").each(function(index,item){
				if(index != idx && $(this).val() == code){
					$(obj).val("");
					$(obj).next().val("");
					return false;
				}
			});
		}
		$(obj).next().val("");
	}

	function selectAmt(obj, idx){
		if($(obj).val() != "" && $(obj).prev().val() != ""){
			$("#requiredAD_td").children("div").eq(idx+1).find("select,input").attr("disabled",false);
		}
	}

	function checkRequiredAD(){
		var flag = true;
		$("[id^=requiredADCD]").each(function(index,item){
			if(index == 0){
				if($(this).val() == "" || $(this).next().val() == ""){
					alert("<fmt:message key="AD01001B.msg12"/>");
					flag = false;
					return false;
				} else{
					if($(this).next().val() == "0"){
						alert("<fmt:message key="AD01001B.msg13"/>");
						flag = false;
						return false;
					}
				}
			} else{
				if(($(this).val() == "" && $(this).next().val() != "") || ($(this).val() != "" && $(this).next().val() == "")){
					alert("<fmt:message key="AD01001B.msg12"/>");
					flag = false;
					return false;
				} else{
					if($(this).next().val() == "0"){
						alert("<fmt:message key="AD01001B.msg13"/>");
						flag = false;
						return false;
					}
				}
			}
		});
		return flag;
	}

	function settingRequiredAD(){
		$("[id^=requiredADCD]").each(function(index,item){
			if($(this).val() == ""){
				$(this).attr("disabled", true);
				$(this).next().attr("disabled", true);
			}
		});
		$("[id^=requiredADCD]").each(function(index,item){
			if($(this).is(":disabled")){
				$(this).attr("disabled", false);
				$(this).next().attr("disabled", false);
				return false;
			}
		});
	}

</script>