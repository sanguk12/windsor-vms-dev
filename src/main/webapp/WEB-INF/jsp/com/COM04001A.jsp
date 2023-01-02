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
						<input type="hidden" id="p_eventYM" name="p_eventYM" value="${params.eventYM}">
			            <input type="hidden" id="p_venueCD" name="p_venueCD" value="${params.venueCD}">
					</td>
				</tr>
                <tr>
					<td height="*" valign="top">
						<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
	                   		<tr>	                   			
								<td width="*">
									<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" >
			                    		<tr>
			                    			<td height="1" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
						                            <colgroup>
									        			<col style="width:230px;"></col>
									        			<col style="width:130px;"></col>
									        			<col style="width:230px;"></col>
									        			<col style="width:230px;"></col>
									        			<col></col>
									        		</colgroup>
							        				<tbody>
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
															<td class="td-cond-required">
																<fmt:message key="KEY01001B.birthDate" />
															</td>
															<td class="td-cond">
															</td>
														</tr>
														<tr>
															<td class="td-input-rborder">
																<input type="text" id="holderNm" name="holderNm" maxlength="15" />
															</td>
															<td class="td-input-rborder">
																<nis:selectbox id="bankCD" name="bankCD" defaultText="select" category="BANKLIST" />
															</td>
															<td class="td-input-rborder">
																<input type="text" id="accountNo" name="accountNo" maxlength="25" />
															</td>
															<td class="td-input-rborder">
																<input type="text" id="birthDate" name="birthDate" maxlength="6"/>
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
			           </table>
			       </td>
				</tr>
			</table>
		</form>
	</body>
</html>

<script language="javascript">

	$(document).ready(function() {
		window.onload = function() {
			Search();
		}
	});	
	
	function Close() {
		parent.appletClose();
	}
	
	function Save() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/api/chkBankAcc");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("accountHolder", $("#holderNm").val());
	  	table.setParameter("accountHolder", $("#holderNm").val());
	  	table.setParameter("accountBankCode", $("#bankCD").val());
	  	table.setParameter("accountNumber", $("#accountNo").val());
	  	table.setParameter("residentNumber", $("#birthDate").val());
	  	var userID = "${params.userID}";
	  	table.setParameter("userID", userID);

	  	table.request();
      	
      	if (table.getData(0,0) == "S") {
      		alert(table.getData(1, 0));
      		$("#requestSeq").val("S");
      		$("#holderNm").attr("readonly",true);
    		$("#holderNm").addClass("input-readonly");
      		$("#bankCD").attr("disabled",true);
    		$("#bankCD").addClass("input-readonly");
      		$("#accountNo").attr("readonly",true);
    		$("#accountNo").addClass("input-readonly");
      		$("#birthDate").attr("readonly",true);
    		$("#birthDate").addClass("input-readonly");
    		parent.Search();
    		Close();
      	}else{
      		alert(table.getData(1, 0));
      	}
	}
	
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/ApiKeyman01S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","birthDate;bankCD;accountNo;holderNm;");
	  	table.setParameter("format","str;str;str;str;str;");
	  	var empID = "${params.userID}";
	  	table.setParameter("empID", empID);
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#birthDate").val(formatDate(table.getData(0, 0)));
      		$("#bankCD").val(table.getData(1, 0));
      		$("#accountNo").val(table.getData(2, 0));
      		$("#holderNm").val(table.getData(3, 0));
      	}
	}
</script>