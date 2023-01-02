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
											<col style="width:200px;"></col>
											<col style="width:200px;"></col>
											<col style="width:150px;"></col>
											<col style="width:200px;"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="KEY01004C.venueCD" />
												</td>
												<td class="td-cond" colspan="2">
													<fmt:message key="KEY01004C.venueNm" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01004C.keymanID" />
												</td>
												<td class="td-cond" colspan="2">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="venueCD" name="venueCD" style="width:130px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder" colspan="2">
													<input type="text" id="venueNm" name="venueNm" style="width:380px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="keymanID" name="keymanID" style="width:130px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder" colspan="2">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="KEY01004C.keymanNm" />
												</td>
<!-- 												<td class="td-cond-required"> -->
<!-- 													<fmt:message key="KEY01004C.keymanTpCD" /> -->
<!-- 												</td> -->
												<td class="td-cond-required">
													<fmt:message key="KEY01004C.regIDNo" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01004C.birthDate" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01004C.dutyCD" />
												</td>
												<td class="td-cond" colspan="2">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="keymanNm" name="keymanNm" style="width:130px;" maxlength="30" />
												</td>
<!-- 												<td class="td-input-rborder"> -->
<!-- 													<nis:selectbox id="keymanTypeCD" name="keymanTypeCD" defaultText="select" category="KEYMANTYPECD"  enable="false" cssClass="input-readonly" /> -->
<!-- 												</td> -->
												<td class="td-input-rborder">
												&nbsp;<span id="regIDNo"></span>
<!-- 													<input type="text" id="regIDNo" name="regIDNo" style="width:180px;" class="input-readonly" readonly  /> -->
												</td>
												<td class="td-input-rborder">
												&nbsp;<span id="birthDate"></span>
<!-- 													<input type="text" id="birthDate" name="birthDate" style="width:130px;" class="input-readonly" readonly /> -->
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="dutyCD" name="dutyCD" defaultText="select" category="DUTYCD" />
												</td>
												<td class="td-input-rborder" colspan="2">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required" colspan="3">
													<fmt:message key="KEY01004C.addr" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01004C.phoneNo" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01004C.emailAddr" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder" colspan="3">
													<input type="text" id="addr" name="addr" style="width:530px;" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="phoneNo" name="phoneNo" style="width:130px;" maxlength="11" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="emailAddr" name="emailAddr" style="width:180px;" maxlength="50" />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="KEY01004C.bankCD" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01004C.accountNo" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01004C.holderNm" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01004C.PKeymanYN" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01004C.activeYN" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													&nbsp;<span id="bankCDName"></span>
<!-- 													<nis:selectbox id="bankCD" name="bankCD" defaultText="select" category="BANKCD" /> -->
												</td>
												<td class="td-input-rborder">
													&nbsp;<span id="accountNo"></span>
<!-- 													<input type="text" id="accountNo" name="accountNo" style="width:180px;" /> -->
												</td>
												<td class="td-input-rborder">
													&nbsp;<span id="holderNm"></span>
													<input type="button" id="accountUpdate" name="accountUpdate" value="<fmt:message key='KEY01004C.button'/>" style="margin-left:80px;width:60px;font-weight:bold;"/>
<!-- 													<input type="text" id="holderNm" name="holderNm" style="width:180px;" /> -->
												</td>
												<td class="td-input-rborder">
													<select id="PkeymanYN">
														<option value="Y">Y</option>
														<option value="N">N</option>
													</select>
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="activeYN" name="activeYN" defaultText="none" category="ACTIVEYN" enable="false" cssClass="input-readonly"  />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond" colspan="4">
													<fmt:message key="KEY01004C.note" />
												</td>
												<td class="td-cond" colspan="2">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder" colspan="4">
													<input type="text" id="note" name="note" style="width:680px;" />
												</td>
												<td class="td-input-rborder" colspan="2">
												</td>
											</tr>
<!-- 											<tr> -->
<!-- 												<td class="td-cond-required"> -->
<!-- 													<fmt:message key="KEY01004B.LicenceChkYn" /> -->
<!-- 													<input type="checkbox" id="LicenceChkYn" name="LicenceChkYn" class="checkbox" value="N"> -->
<!-- 												</td> -->
<!-- 												<td class="td-input-rborder" colspan="4"> -->
<!-- 													<fmt:message key="KEY01004B.LicenceChkYnCommt" /> -->
<!-- 												</td> -->
<!-- 												<td class="td-input-rborder"> -->
<!-- 												</td> -->
<!-- 											</tr> -->
										</tbody>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1">
						<input type="hidden" id="keymanTypeCD" name="keymanTypeCD"/>
						<input type="hidden" id="requestDate" name="requestDate" />
						<input type="hidden" id="requestTpCD" name="requestTpCD" value="CHG" />
						<input type="hidden" id="apprTpID" name="apprTpID" value="000001" /><!-- 키맨승인라인 -->
						<input type="hidden" id="myAppr" name="myAppr" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
		$("#regIDNo").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
		};

		${initScript}
		
// 		$("#LicenceChkYn").click(function(){
// 			if($("#LicenceChkYn").is(":checked")) {
// 				$("#LicenceChkYn").val("Y");
// 			}
// 			else {
// 				$("#LicenceChkYn").val("N");
// 			}
// 		});
		
		$("#phoneNo").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		$("#phoneNo").on("focusout", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		$("#accountUpdate").click( function(){
			accountUpdate();
		});
			
		
	});
	
	//계좌 변경 API 팝업
	function accountUpdate(){
		alert("현재 지원하지 않는 기능입니다.");
	}
	
	//승인라인체크
	function getMyAppr() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03006S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.request();
		
		if(table.getCount() > 0) {
			$("#myAppr").val(table.getData(0,0));
		}
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		venueCD : _i++
		, venueNm : _i++
		, keymanID : _i++
		, keymanNm : _i++
		, keymanTypeCD : _i++
		, regIDNo : _i++
		, birthDate : _i++
		, dutyCD : _i++
		, addr : _i++
		, phoneNo : _i++
		, emailAddr : _i++
		, bankCD : _i++
		, bankCDName : _i++
		, accountNo : _i++
		, holderNm : _i++
		, PkeymanYN : _i++
		, activeYN : _i++
		, note : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0100407S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"venueCD;venueNm;keymanID;keymanNm;keymanTypeCD;"+
	  			"regIDNo;birthDate;dutyCD;addr;phoneNo;"+
	  			"emailAddr;bankCD;bankCDName;accountNo;holderNm;"+
	  			"PkeymanYN;activeYN;note;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;date;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;");
	  	table.setParameter("keymanID", parent.$("#selectKeymanID").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#venueCD").val(table.getData(_col.venueCD, 0));
      		$("#venueNm").val(table.getData(_col.venueNm, 0));
      		$("#keymanID").val(table.getData(_col.keymanID, 0));
      		$("#keymanNm").val(table.getData(_col.keymanNm, 0));
      		$("#keymanTypeCD").val(table.getData(_col.keymanTypeCD, 0));
      		$("#regIDNo").text(formatIDNo(table.getData(_col.regIDNo, 0), ""));
      		$("#birthDate").text(formatDate(table.getData(_col.birthDate, 0)));
      		$("#dutyCD").val(table.getData(_col.dutyCD, 0));
      		$("#addr").val(table.getData(_col.addr, 0));
      		$("#phoneNo").val(table.getData(_col.phoneNo, 0));
      		$("#emailAddr").val(table.getData(_col.emailAddr, 0));
      		$("#bankCDName").text(table.getData(_col.bankCDName, 0));
      		$("#accountNo").text(table.getData(_col.accountNo, 0));
      		$("#holderNm").text(table.getData(_col.holderNm, 0));
      		$("#PkeymanYN").val(table.getData(_col.PkeymanYN, 0));
      		$("#activeYN").val(table.getData(_col.activeYN, 0));
      		$("#note").val(table.getData(_col.note, 0));
      		
      		$("#requestDate").val("${params.currentDate}");
      	}
      	
      	getMyAppr();
	}
	
	function Request() {
		
		if($("#myAppr").val() == "") {
			alert("<fmt:message key="KEY01004C.msg9"/>");
			return;
		}
		
		if($("#venueCD").val()=="") {
			alert("<fmt:message key="KEY01004C.msg10"/>");
			$("#venueCD").focus();
			return;
		}
		if($("#keymanNm").val()=="") {
			alert("<fmt:message key="KEY01004C.msg1" />");
			$("#keymanNm").focus();
			return;
		}
// 		if($("#keymanTypeCD").val()=="") {
// 			alert("<fmt:message key="KEY01004C.msg2" />");
// 			$("#keymanTypeCD").focus();
// 			return;
// 		}
// 		if($("#regIDNo").val()=="") {
// 			alert("<fmt:message key="KEY01004C.msg3" />");
// 			$("#regIDNo").focus();
// 			return;
// 		}
		if($("#dutyCD").val()=="") {
			alert("<fmt:message key="KEY01004C.msg15"/>");
			$("#dutyCD").focus();
			return;
		}
		if($("#addr").val()=="") {
			alert("<fmt:message key="KEY01004C.msg4" />");
			$("#addr").focus();
			return;
		}
		if($("#phoneNo").val()=="") {
			alert("<fmt:message key="KEY01004C.msg11"/>");
			$("#phoneNo").focus();
			return;
		}
// 		if("010"!=$("#phoneNo").val().substring(0,3)){
// 			alert("<fmt:message key="KEY01004C.msg12"/>");
// 			$("#phoneNo").focus();
// 			return;
// 		}
		if(10 >$("#phoneNo").val().length){
			alert("<fmt:message key="KEY01004C.msg12"/>");
			$("#phoneNo").focus();
			return;
		}
// 		if($("#emailAddr").val()=="") {
// 			alert("<fmt:message key="KEY01004C.msg13"/>");
// 			$("#emailAddr").focus();
// 			return;
// 		}
		var filter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		if($("#emailAddr").val()!="") {
			if(!filter.test($("#emailAddr").val())){
				alert("<fmt:message key="KEY01004C.msg14"/>");
				$("#emailAddr").focus();
				return;
			}
		}
// 		if(!filter.test($("#emailAddr").val())){
// 			alert("<fmt:message key="KEY01004C.msg14"/>");
// 			$("#emailAddr").focus();
// 			return;
// 		}
// 		if($("#bankCD").val()=="") {
// 			alert("<fmt:message key="KEY01004C.msg5" />");
// 			$("#bankCD").focus();
// 			return;
// 		}
// 		if($("#accountNo").val()=="") {
// 			alert("<fmt:message key="KEY01004C.msg6" />");
// 			$("#accountNo").focus();
// 			return;
// 		}
// 		if($("#holderNm").val()=="") {
// 			alert("<fmt:message key="KEY01004C.msg7" />");
// 			$("#holderNm").focus();
// 			return;
// 		}
		if($("#PkeymanYN").val()=="") {
			alert("<fmt:message key="KEY01004C.msg8" />");
			$("#PkeymanYN").focus();
			return;
		}		
// 		if($("#LicenceChkYn").val() != "Y") {
// 			$("#LicenceChkYn").focus();
// 			alert("<fmt:message key="KEY01004B.LicenceChkMsg"/>");
// 			return ;		
// 		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key01/saveKeymanID_m");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("requestTpCD", $("#requestTpCD").val());
		table.setParameter("keymanID", $("#keymanID").val());
		table.setParameter("keymanNm", $("#keymanNm").val());
		table.setParameter("keymanTypeCD", $("#keymanTypeCD").val());
		table.setParameter("regIDNo", unformat($("#regIDNo").val()));
		table.setParameter("birthDate", unformat($("#birthDate").val()));
		table.setParameter("dutyCD", $("#dutyCD").val());
		table.setParameter("addr", $("#addr").val());
		table.setParameter("phoneNo", $("#phoneNo").val());
		table.setParameter("emailAddr", $("#emailAddr").val());
// 		table.setParameter("bankCD", $("#bankCD").val());
// 		table.setParameter("accountNo", $("#accountNo").val());
// 		table.setParameter("holderNm", $("#holderNm").val());
		table.setParameter("PkeymanYN", $("#PkeymanYN").val());
		table.setParameter("requestDate", unformat($("#requestDate").val()));
		table.setParameter("note", $("#note").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("requestStateCD", "10");
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			parent.Search_key01();
			parent.Search_key02();
			List();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function List() {
		parent.appletClose();
	}

</script>