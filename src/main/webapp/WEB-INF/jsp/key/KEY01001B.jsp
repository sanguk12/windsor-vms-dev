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
													<fmt:message key="KEY01001B.venueCD" />
												</td>
												<td class="td-cond" colspan="2">
													<fmt:message key="KEY01001B.venueNm" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001B.requestTpCD" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001B.keymanID" />
												</td>
												<td class="td-cond">
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
													<nis:selectbox id="requestTpCD" name="requestTpCD" defaultText="none" category="REQUESTTPCD" enable="false" cssClass="input-readonly" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="keymanID" name="keymanID" style="width:130px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="KEY01001B.keymanNm" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001B.keymanTpCD" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001B.regIDNo" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001B.birthDate" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001B.dutyCD" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<input type="text" id="keymanNm" name="keymanNm" style="width:130px;" maxlength="50" />
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="keymanTypeCD" name="keymanTypeCD" defaultText="none" category="KEYMANTYPECD" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="regIDNo" name="regIDNo" style="width:180px;" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="birthDate" name="birthDate" style="width:130px;" maxlength="8"/>
												</td>
												<td class="td-input-rborder">
													<nis:selectbox id="dutyCD" name="dutyCD" defaultText="select" category="DUTYCD" />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required" colspan="4">
													<fmt:message key="KEY01001B.addr" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001B.phoneNo" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder" colspan="4">
													<input type="text" id="addr" name="addr" style="width:680px;" maxlength="250" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="phoneNo" name="phoneNo" style="width:130px;" maxlength="20" />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="KEY01001B.bankCD" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001B.accountNo" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001B.holderNm" />
												</td>
												<td class="td-cond-required">
													<fmt:message key="KEY01001B.PKeymanYN" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001B.requestDate" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder">
													<nis:selectbox id="bankCD" name="bankCD" defaultText="select" category="BANKCD" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="accountNo" name="accountNo" style="width:180px;" maxlength="25" />
												</td>
												<td class="td-input-rborder">
													<input type="text" id="holderNm" name="holderNm" style="width:180px;" maxlength="50" />
												</td>
												<td class="td-input-rborder">
													<select id="PkeymanYN">
														<option value=""><fmt:message key="select" /></option>
														<option value="Y">Y</option>
														<option value="N">N</option>
													</select>
												</td>
												<td class="td-input-rborder">
													<input type="text" id="requestDate" name="requestDate" style="width:130px;" class="input-readonly" readonly />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond" colspan="4">
													<fmt:message key="KEY01001B.note" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001B.requestStateCD" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder" colspan="4">
													<input type="text" id="note" name="note" style="width:680px;" maxlength="100" />
												</td>
												<td class="td-input-rborder">
													&nbsp;<span id="requestStateCDName"></span>
													<input type="hidden" id="requestStateCD" name="requestStateCD" />
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
											<tr>
												<td class="td-cond" colspan="4">
													<fmt:message key="KEY01001B.accreErrCommt" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY01001B.accreDate" />
												</td>
												<td class="td-cond">
												</td>
											</tr>
											<tr>
												<td class="td-input-rborder" colspan="4">
													&nbsp;<span id="accreErrCommt"></span>
												</td>
												<td class="td-input-rborder">
													&nbsp;<span id="accreDate"></span>
												</td>
												<td class="td-input-rborder">
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1">
									<input type="hidden" id="requestSeq" name="requestSeq" />
									<input type="hidden" id="ageGap" name="ageGap" />
									<input type="hidden" id="apprTpID" name="apprTpID" value="000001" /><!-- 키맨승인라인 -->
									<input type="hidden" id="myAppr" name="myAppr" />
									<input type="hidden" id="contractYN" name="contractYN" />
								</td>
							</tr>
						</table>
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
			
			$("#birthDate").attr("readonly",true);
    		$("#birthDate").addClass("input-readonly");
		};

		${initScript}
		
		$("#keymanTypeCD").change(function(){
			$("#regIDNo").val("");
			$("#birthDate").val("");
		});
		
		$("#regIDNo").focus(function(){
			$("#regIDNo").val(unformat($("#regIDNo").val()));
			if($("#keymanTypeCD").val() == "10") {
				$("#regIDNo").attr("maxlength","13");
			} else {
				$("#regIDNo").attr("maxlength","10");
			}
		});
		$("#regIDNo").blur(function(){
			var regIDNo = $("#regIDNo").val();
			if($("#keymanTypeCD").val() == "10") {
				$("#regIDNo").val(formatIDNo(regIDNo, ""));
			} else {
				$("#regIDNo").val(formatBizRegNo(regIDNo));
			}
		});
		
		$("#regIDNo").change(function(){
			if($("#keymanTypeCD").val() == "10") {
				if($("#requestTpCD").val() == "NEW" && $("#keymanTypeCD").val() == "10"){
					birthCk();
				}
			}
			else {
				$("#birthDate").val("");
			}
		});
		
		$("#birthDate").change(function(){
			$("#birthDate").val(formatDate($("#birthDate").val()));
		});
		
	});
	
	//미성년자체크
	function birthCk() {
		var currentDate = "${params.currentDate}";
		var birthDate = unformat($("#regIDNo").val()).substring(0,6);
		var yearFront = "";
		var nineteenOrTwenty = unformat($("#regIDNo").val()).substring(6,7);
		if(nineteenOrTwenty=="1" || nineteenOrTwenty=="2" 
				|| nineteenOrTwenty=="5" || nineteenOrTwenty=="6") { //외국인 경우 추가 2014.10.02
			yearFront = "19";
		}
		else if(nineteenOrTwenty=="3" || nineteenOrTwenty=="4"
				|| nineteenOrTwenty=="7" || nineteenOrTwenty=="8") { //외국인 경우 추가 2014.10.02
			yearFront = "20";
		}
		birthDate = yearFront+birthDate;
		$("#birthDate").val(formatDate(birthDate));
		
		//만나이 구하기
		var bday=parseInt(birthDate.substring(6,8)); 
		var bmo=(parseInt(birthDate.substring(4,6))-1); 
		var byr=parseInt(birthDate.substring(0,4)); 
		var byr;
		var age;
		var now = new Date();
		tday=now.getDate();
		tmo=(now.getMonth());
		tyr=(now.getFullYear());
		if((tmo > bmo)||(tmo==bmo & tday>=bday)) { 
			age=byr;
		}
		else {
			//age=byr+1;
			age=byr;
		}
		var manAge = 0;
		manAge = tyr-age;
		$("#ageGap").val(manAge);
	}
	
	function New() {
		btnRequest.setControlDisabled(false);
		btnDelete.setControlDisabled(true);
		
		$("#venueCD").val(parent.$("#selectVenueCD").val());
		$("#venueNm").val(parent.$("#selectVenueNm").val());
		$("#requestTpCD").val("NEW");
		$("#keymanID").val("");
		$("#keymanNm").val("");
		$("#keymanTypeCD").val("10");
		$("#regIDNo").val("");
		$("#birthDate").val("");
		$("#dutyCD").val("");
		$("#addr").val("");
		$("#phoneNo").val("");
		$("#bankCD").val("");
		$("#accountNo").val("");
		$("#holderNm").val("");
		$("#PkeymanYN").val("");
		$("#requestDate").val("${params.currentDate}");
		$("#note").val("");
		$("#requestStateCDName").text("");
		$("#accreErrCommt").text("");
		$("#accreDate").text("");
		$("#requestStateCD").val("");
		$("#requestSeq").val("");
		
		getMyAppr();
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
		, requestTpCD : _i++
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
		, requestDate : _i++
		, note : _i++
		, requestStateCDName : _i++
		, accreErrCommt : _i++
		, accreDate : _i++
		, requestSeq : _i++
		, requestStateCD : _i++
		, contractYN : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0100104S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"venueCD;venueNm;requestTpCD;keymanID;keymanNm;"+
	  			"keymanTypeCD;regIDNo;birthDate;dutyCD;addr;"+
	  			"phoneNo;bankCD;accountNo;holderNm;PkeymanYN;"+
	  			"requestDate;note;requestStateCDName;accreErrCommt;accreDate;"+
	  			"requestSeq;requestStateCD;contractYN;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"date;str;str;str;str;"+
	  			"str;str;str;");
	  	table.setParameter("keymanID", parent.$("#selectKeymanID").val());
		table.setParameter("requestDate", parent.$("#selectRequestDate").val());
		table.setParameter("requestSeq", parent.$("#selectRequestSeq").val());
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#venueCD").val(table.getData(_col.venueCD, 0));
      		$("#venueNm").val(table.getData(_col.venueNm, 0));
      		$("#requestTpCD").val(table.getData(_col.requestTpCD, 0));
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
      		$("#requestDate").val(formatDate(table.getData(_col.requestDate, 0)));
      		$("#note").val(table.getData(_col.note, 0));
      		$("#requestStateCD").val(table.getData(_col.requestStateCD, 0));
      		$("#contractYN").val(table.getData(_col.contractYN, 0));
      		
      		if(table.getData(_col.requestStateCD, 0) == "10") {
	      		$("#requestStateCDName").text(table.getData(_col.requestStateCDName, 0));
      		}
      		else {
      			$("#requestStateCDName").html("<a href='javascript:openRequestState();'>"+table.getData(_col.requestStateCDName, 0)+"</a>");
      		}
      		
      		$("#accreErrCommt").text(table.getData(_col.accreErrCommt, 0));
      		$("#accreDate").text(formatDate(table.getData(_col.accreDate, 0)));
      		$("#requestSeq").val(table.getData(_col.requestSeq, 0));
      	}
      	
      	getMyAppr();
	}
	
	function openRequestState() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=KEY01001D"
				+"&keymanID="+$("#keymanID").val()
				+"&requestDate="+unformat($("#requestDate").val())
				+"&requestSeq="+$("#requestSeq").val();
		
		newWindow(url, "KEY01001D",600,350,"yes");
	}
	
	function Request() {
		if($("#contractYN").val() == "Y") {
			alert("<fmt:message key="KEY01001B.msg19"/>");
			return;
		}
		if($("#myAppr").val() == "") {
			alert("<fmt:message key="KEY01001B.msg17"/>");
			return;
		}
		
		if($("#requestTpCD").val() == "CHG") {
			//승인요청, 반려, 인증오류인 경우에만 저장
			if($("#requestStateCD").val() != "10" && $("#requestStateCD").val() != "30" && $("#requestStateCD").val() != "50") {
				alert("<fmt:message key="KEY01001B.msg1"/>");
				return;
			}
		}
		
		if($("#venueCD").val()=="") {
			alert("<fmt:message key="KEY01001B.msg18"/>");
			$("#venueCD").focus();
			return;
		}
		if($("#keymanNm").val()=="") {
			alert("<fmt:message key="KEY01001B.msg2"/>");
			$("#keymanNm").focus();
			return;
		}
		if($("#keymanTypeCD").val()=="") {
			alert("<fmt:message key="KEY01001B.msg3"/>");
			$("#keymanTypeCD").focus();
			return;
		}
		if($("#regIDNo").val()=="") {
			alert("<fmt:message key="KEY01001B.msg4"/>");
			$("#regIDNo").focus();
			return;
		}
		if($("#keymanTypeCD").val() == "10") {
			if(unformat($("#regIDNo").val()).length !="13") {
				alert("<fmt:message key="KEY01001B.msg16"/>");
				$("#regIDNo").focus();
				return;
			}
		} else if ($("#keymanTypeCD").val() != "10") {
			if(unformat($("#regIDNo").val()).length !="10") {
				alert("<fmt:message key="KEY01001B.msg16"/>");
				$("#regIDNo").focus();
				return;
			}
		}
		if($("#addr").val()=="") {
			alert("<fmt:message key="KEY01001B.msg6"/>");
			$("#addr").focus();
			return;
		}
		if($("#bankCD").val()=="") {
			alert("<fmt:message key="KEY01001B.msg8"/>");
			$("#bankCD").focus();
			return;
		}
		if($("#accountNo").val()=="") {
			alert("<fmt:message key="KEY01001B.msg9"/>");
			$("#accountNo").focus();
			return;
		}
		if($("#holderNm").val()=="") {
			alert("<fmt:message key="KEY01001B.msg10"/>");
			$("#holderNm").focus();
			return;
		}
		if($("#PkeymanYN").val()=="") {
			alert("<fmt:message key="KEY01001B.msg11"/>");
			$("#PkeymanYN").focus();
			return;
		}
		
		if($("#keymanTypeCD").val() == "10") {
			birthCk();
			if(Number($("#ageGap").val()) < 20) {
				alert("[경고] 만 20세 미만의 미성년자 입니다.\n만 20세 미만의 고객은 등록이 불가능 합니다.");
				return;
			}
			if(Number($("#ageGap").val()) >= 70) {
				if($("#requestTpCD").val() == "NEW" && $("#keymanTypeCD").val() == "10") { 
					if($("#note").val() == "") {
	// 					alert("비고를 입력해 주시기 바랍니다.");
						alert("<fmt:message key="KEY01001B.msg12"/>");
						$("#note").focus();
						return;
					}
				}
				alert("[주의] 만 70세 이상의 고령자 입니다.\n- 고령자 고객은 업주인 경우에만 고객으로 등록이 가능합니다.\n- 업주임을 증명하기 위한 사업자등록증 사본을 발렉스에 제출 하여야 합니다.\n- 비고란에 고객의 재직여부를 확인할 수 있는 내용을 작성하여야 합니다.\n- 업소 고객이 아닌 가족, 친지, 배우자는 고객 등록을 할 수 없습니다. (자사 자금세탁방지규정 참고)");
			}
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
		table.setParameter("requestSeq", $("#requestSeq").val());
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			parent.$("#selectKeymanID").val(table.getData(3,0));
			parent.$("#selectRequestDate").val(table.getData(4,0));
			parent.$("#selectRequestSeq").val(table.getData(5,0));
			Search();
			parent.Search_key01();
			parent.Search_key02();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Delete() {
		//승인요청, 반려, 인증오류인 경우에만 저장
		if($("#requestStateCD").val() != "10" && $("#requestStateCD").val() != "30" && $("#requestStateCD").val() != "50") {
			alert("<fmt:message key="KEY01001B.msg15"/>");
// 			alert("상태가 승인요청, 반려, 인증오류인 경우에만 삭제가능합니다.");
			return;
		}
		if(!confirm("<fmt:message key="confirm.delete"/>")){
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key01/deleteKeymanID");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("keymanID", $("#keymanID").val());
		table.setParameter("requestDate", $("#requestDate").val());
		table.setParameter("requestSeq", $("#requestSeq").val());
		table.request();

		alert(table.getData(1,0));
		if(table.getData(0,0) == "S") {
			parent.Search_key01();
			parent.Search_key02();
			parent.appletClose();
   		}
	}
	
	function List() {
		parent.appletClose();
	}
	
</script>