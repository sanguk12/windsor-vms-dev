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
											<col style="width:150px;"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="KEY01001C.venueCD" />
												</td>
												<td class="td-cond" colspan="3">
													<fmt:message key="KEY01001C.venueNm" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001C.keymanID" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="venueCD" name="venueCD" style="width:130px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder" colspan="3">
													<input type="text" id="venueNm" name="venueNm" style="width:380px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="keymanID" name="keymanID" style="width:130px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="KEY01001C.keymanNm" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001C.keymanTpCD" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001C.regIDNo" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001C.birthDate" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001C.dutyCD" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="keymanNm" name="keymanNm" style="width:130px;" maxlength="50" />
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="keymanTypeCD" name="keymanTypeCD" defaultText="select" category="KEYMANTYPECD"  enable="false" cssClass="input-readonly" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="regIDNo" name="regIDNo" style="width:180px;" class="input-readonly" readonly  />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="birthDate" name="birthDate" style="width:130px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="dutyCD" name="dutyCD" defaultText="select" category="DUTYCD" />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required" colspan="4">
													<fmt:message key="KEY01001C.addr" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001C.phoneNo" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder" colspan="4">
													<input type="text" id="addr" name="addr" style="width:680px;" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="phoneNo" name="phoneNo" style="width:130px;" />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="KEY01001C.bankCD" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001C.accountNo" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001C.holderNm" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001C.PKeymanYN" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001C.activeYN" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<nis:selectbox id="bankCD" name="bankCD" defaultText="select" category="BANKCD" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="accountNo" name="accountNo" style="width:180px;" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="holderNm" name="holderNm" style="width:180px;" maxlength="50"/>
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
											</tr>
											<tr>
												<td class="td-cond" colspan="5">
													<fmt:message key="KEY01001C.note" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder" colspan="5">
													<input type="text" id="note" name="note" style="width:680px;" />
												</td>
												<td class="td-input-rborder">
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
						<input type="hidden" id="requestDate" name="requestDate" />
						<input type="hidden" id="requestTpCD" name="requestTpCD" value="CHG" />
						<input type="hidden" id="apprTpID" name="apprTpID" value="000001" /><!-- 키맨승인라인 -->
						<input type="hidden" id="myAppr" name="myAppr" />
						<input type="hidden" id="contractYN" name="contractYN" />
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
		
	});
	
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
		, bankCD : _i++
		, accountNo : _i++
		, holderNm : _i++
		, PkeymanYN : _i++
		, activeYN : _i++
		, note : _i++
		, contractYN : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0100107S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"venueCD;venueNm;keymanID;keymanNm;keymanTypeCD;"+
	  			"regIDNo;birthDate;dutyCD;addr;phoneNo;"+
	  			"bankCD;accountNo;holderNm;PkeymanYN;activeYN;"+
	  			"note;contractYN;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;date;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;");
	  	table.setParameter("keymanID", parent.$("#selectKeymanID").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#venueCD").val(table.getData(_col.venueCD, 0));
      		$("#venueNm").val(table.getData(_col.venueNm, 0));
      		$("#keymanID").val(table.getData(_col.keymanID, 0));
      		$("#keymanNm").val(table.getData(_col.keymanNm, 0));
      		$("#keymanTypeCD").val(table.getData(_col.keymanTypeCD, 0));
      		$("#regIDNo").val(formatIDNo(table.getData(_col.regIDNo, 0), ""));
      		$("#birthDate").val(formatDate(table.getData(_col.birthDate, 0)));
      		$("#dutyCD").val(table.getData(_col.dutyCD, 0));
      		$("#addr").val(table.getData(_col.addr, 0));
      		$("#phoneNo").val(table.getData(_col.phoneNo, 0));
      		$("#bankCD").val(table.getData(_col.bankCD, 0));
      		$("#accountNo").val(table.getData(_col.accountNo, 0));
      		$("#holderNm").val(table.getData(_col.holderNm, 0));
      		$("#PkeymanYN").val(table.getData(_col.PkeymanYN, 0));
      		$("#activeYN").val(table.getData(_col.activeYN, 0));
      		$("#note").val(table.getData(_col.note, 0));
      		$("#contractYN").val(table.getData(_col.contractYN, 0));
      		
      		$("#requestDate").val("${params.currentDate}");
      	}
      	
      	getMyAppr();
	}
	
	function Request() {
		if($("#contractYN").val() == "Y") {
			alert("<fmt:message key="KEY01001C.msg11"/>");
			return;
		}
		
		if($("#myAppr").val() == "") {
			alert("<fmt:message key="KEY01001C.msg9"/>");
			return;
		}
		
		if($("#venueCD").val()=="") {
			alert("<fmt:message key="KEY01001C.msg10"/>");
			$("#venueCD").focus();
			return;
		}
		if($("#keymanNm").val()=="") {
			alert("<fmt:message key="KEY01001C.msg1" />");
			$("#keymanNm").focus();
			return;
		}
		if($("#keymanTypeCD").val()=="") {
			alert("<fmt:message key="KEY01001C.msg2" />");
			$("#keymanTypeCD").focus();
			return;
		}
		if($("#regIDNo").val()=="") {
			alert("<fmt:message key="KEY01001C.msg3" />");
			$("#regIDNo").focus();
			return;
		}
		if($("#addr").val()=="") {
			alert("<fmt:message key="KEY01001C.msg4" />");
			$("#addr").focus();
			return;
		}
		if($("#bankCD").val()=="") {
			alert("<fmt:message key="KEY01001C.msg5" />");
			$("#bankCD").focus();
			return;
		}
		if($("#accountNo").val()=="") {
			alert("<fmt:message key="KEY01001C.msg6" />");
			$("#accountNo").focus();
			return;
		}
		if($("#holderNm").val()=="") {
			alert("<fmt:message key="KEY01001C.msg7" />");
			$("#holderNm").focus();
			return;
		}
		if($("#PkeymanYN").val()=="") {
			alert("<fmt:message key="KEY01001C.msg8" />");
			$("#PkeymanYN").focus();
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key01/saveKeymanID");
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
		table.setParameter("bankCD", $("#bankCD").val());
		table.setParameter("accountNo", $("#accountNo").val());
		table.setParameter("holderNm", $("#holderNm").val());
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