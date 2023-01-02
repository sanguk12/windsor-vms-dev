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
			<div id="wrapDiv">
			<div id="formDiv">
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
										<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
											<colgroup>
												<col style="width:80px;"></col>
												<col style="width:80px;"></col>
												<col style="width:200px;"></col>
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
														<fmt:message key="KEY01001C.keymanNm" />
													</td>
												</tr>
												<tr>
													<td class="td-input-rborder">
														<input type="text" id="venueCD" name="venueCD" style="min-width:80px;width:100%;" class="input-readonly" readonly />
													</td>
													<td class="td-input-rborder" colspan="2">
														<input type="text" id="venueNm" name="venueNm" style="min-width:420px;width:100%;" class="input-readonly" readonly />
													</td>
													<td class="td-input-rborder">
														<input type="text" id="keymanNm" name="keymanNm" style="min-width:130px;width:100%;" maxlength="30" class="input-readonly" readonly  />
													</td>
												</tr>
												<tr>
													<td class="td-cond" colspan="3">
														<fmt:message key="KEY01001B.addr" />
													</td>
													<td class="td-cond">
														<fmt:message key="KEY01001B.phoneNo" />
													</td>
												</tr>
												<tr>
													<td class="td-input-rborder" colspan="3">
														<input type="text" id="addr" name="addr" style="width:100%;min-width:620px;" maxlength="250" />
													</td>
													<td class="td-input-rborder">
														<input type="text" id="phoneNo" name="phoneNo" style="width:100%;min-width:180px;" maxlength="20" />
													</td>
												</tr>
												<tr>
													<td class="td-cond-required">
														<fmt:message key="KEY01001B.holderNm" />
													</td>
													<td class="td-cond-required">
														<fmt:message key="KEY01001B.bankCD" />
													</td>
													<td class="td-cond-required">
														<fmt:message key="KEY01001B.accountNo" />
													</td>
													<td class="td-cond">
														<fmt:message key="KEY01001B.birthDate" />
													</td>
												</tr>
												<tr>
													<td class="td-input-rborder">
														<input type="text" id="holderNm" name="holderNm" style="width:100%;min-width:80px;" class="input-readonly" readonly />
													</td>
													<td class="td-input-rborder">
														<input type="text" id="bankCD" name="bankCD" style="width:100%;min-width:230px;" class="input-readonly" readonly  />
													</td>
													<td class="td-input-rborder">
														<input type="text" id="accountNo" name="accountNo" style="width:100%;min-width:230px;" class="input-readonly" readonly  />
													</td>
													<td class="td-input-rborder">
														<input type="text" id="birthDate" name="birthDate" style="width:150px;" class="input-readonly" readonly />
														<input type="button" id="chkAcc" name="chkAcc" style="width:60px;" value="계좌변경" onClick="chkACC();"/>
													</td>
												</tr>
												<tr>
													<td class="td-cond" colspan="4">
														<fmt:message key="KEY01001B.note" />
													</td>
												</tr>
												<tr>
													<td class="td-input-rborder" colspan="4">
														<input type="text" id="note" name="note" style="width:100%;" maxlength="100" />
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<td height="1">
										<input type="hidden" id="requestSeq" name="requestSeq" />
										<input type="hidden" id="apprTpID" name="apprTpID" value="000001" /><!-- 키맨승인라인 -->
										<input type="hidden" id="chkBank" name="chkBank" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
				${appletDiv}
			</div>
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
			Search();
			
			//$("#birthDate").attr("readonly",true);
    		//$("#birthDate").addClass("input-readonly");
		};

		${initScript}
		
		$("#birthDate").change(function(){
			$("#birthDate").val(formatDate($("#birthDate").val()));
		});
		
	});
	
</script>

<script type="text/javascript">


	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/api/selectKeyman");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","venueCD;venueNm;keymanNm;addr;phoneNo;holderNm;bankCD;accountNo;birthDate;note;bankNm;");
	  	table.setParameter("format","str;str;str;str;str;str;str;str;str;str;str;");
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#venueCD").val(table.getData(0, 0));
      		$("#venueNm").val(table.getData(1, 0));
      		$("#keymanNm").val(table.getData(2, 0));
      		$("#addr").val(table.getData(3, 0));
      		$("#phoneNo").val(table.getData(4, 0));
      		$("#holderNm").val(table.getData(5, 0));
      		$("#bankCD").val(table.getData(10, 0));
      		$("#accountNo").val(table.getData(7, 0));
      		$("#birthDate").val(formatDate(table.getData(8, 0)));
      		$("#note").val(table.getData(9, 0));
      	}
      	
	}
	
	function chkACC() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=COM04001A"
      	appletDiv_set({"src":url+"&initAction=Search", "appPositionCD":"${params.appPositionCD}", "appDisRate":"100", "appDisUnitCD":"${params.appDisUnitCD}"});
		appletOpen();
		    
	}
	
	function Save() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/api/updateKeyman");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	var userID = "${params.userID}";
		
	  	table.setParameter("userID", userID);
	  	table.setParameter("keymanID", userID);
	  	table.setParameter("addr", $("#addr").val());
	  	table.setParameter("commt", $("#note").val());
	  	table.setParameter("phoneNo", $("#phoneNo").val());

	  	table.request();
      	
      	if (table.getData(0,0) == "S") {
      		alert(table.getData(1, 0));
      		Search();
      	}else{
      		alert(table.getData(0, 0));
      	}
	}
	
</script>