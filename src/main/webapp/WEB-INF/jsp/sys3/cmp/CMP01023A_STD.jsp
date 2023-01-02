<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
<form name="form" method="post">
<div id="wrapDiv" class="pd-l"><div id="formDiv">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
        	<td height="1">
				<%@include file="../cms/standardParam.jsp" %>
				<%@include file="../cms/functionbar.jsp" %>
			</td>
		</tr>
		<tr>
        	<td height="1">
            	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
            		<tr>
                        <td class="group-title"><fmt:message key="CMP01023A.msg1" /></td>
                    </tr>
                	<tr>
                  		<td class="tb-border">
				        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px; table-layout:fixed;">
								<colgroup>
				        			<col style="width:70px;"></col>
				        			<col style="width:30px;"></col>
				        			<col style="width:85px;"></col>
				        			<col style="width:70px;"></col>
				        			<col style="width:100px;"></col>
				        			<col style="width:30px;"></col>
				        			<col style="width:95px;"></col>
				        			<col style="width:30px;"></col>
				        			<col style="width:80px;"></col>
				        			<col style="width:30px;"></col>
				        			<col style="width:70px;"></col>
				        			<col style="width:30px;"></col>
				        			<col style="width:85px;"></col>
				        			<col></col>
				        		</colgroup>
				        		<tbody>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01023A.useYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="passwdRuleYN1" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.passwdMinNumbers" />
									</td>
									<td class="td-input">
										<input type="text" id="passwdMinNumbers1" style="width:50px; text-align:right;">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.upperCaseYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="upperCaseYN1" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.lowerCaseYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="lowerCaseYN1" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.numberYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="numberYN1" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.specialLettersYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="specialLettersYN1" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.compositionCnt" />
									</td>
									<td class="td-input">
										<input type="text" id="compositionCnt1" style="width:50px; text-align:right;">
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01023A.useYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="passwdRuleYN2" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.passwdMinNumbers" />
									</td>
									<td class="td-input">
										<input type="text" id="passwdMinNumbers2" style="width:50px; text-align:right;">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.upperCaseYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="upperCaseYN2" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.lowerCaseYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="lowerCaseYN2" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.numberYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="numberYN2" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.specialLettersYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="specialLettersYN2" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.compositionCnt" />
									</td>
									<td class="td-input">
										<input type="text" id="compositionCnt2" style="width:50px; text-align:right;">
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
            		<tr>
                        <td class="group-title"><fmt:message key="CMP01023A.msg2" /></td>
                    </tr>
                	<tr>
                  		<td class="tb-border">
				        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px; table-layout:fixed;">
								<colgroup>
				        			<col style="width:70px;"></col>
				        			<col style="width:30px;"></col>
				        			<col style="width:200px;"></col>
				        			<col></col>
				        		</colgroup>
				        		<tbody>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01023A.useYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="passwdUsageLimitRuleYN" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.passwdUsageLimitCnt" />
									</td>
									<td class="td-input">
										<input type="text" id="passwdUsageLimitCnt" style="width:50px; text-align:right;">
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
            		<tr>
                        <td class="group-title"><fmt:message key="CMP01023A.msg3" /></td>
                    </tr>
                	<tr>
                  		<td class="tb-border">
				        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px; table-layout:fixed;">
								<colgroup>
				        			<col style="width:70px;"></col>
				        			<col style="width:30px;"></col>
				        			<col style="width:200px;"></col>
				        			<col></col>
				        		</colgroup>
				        		<tbody>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01023A.useYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="passwdChgMonthRuleYN" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.passwdChgMonthCnt" />
									</td>
									<td class="td-input">
										<input type="text" id="passwdChgMonthCnt" style="width:50px; text-align:right;">
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01023A.useYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="accountBlockMonthRuleYN" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.accountBlockMonthCnt" />
									</td>
									<td class="td-input">
										<input type="text" id="accountBlockMonthCnt" style="width:50px; text-align:right;">
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
        	<td height="*"></td>
        </tr>
	</table>
</div></div>
</form>
</body>
</html>


<script type="text/javascript">

	$(function() {
		$("#passwdMinNumbers1").numeric();
		$("#compositionCnt1").numeric();
		$("#passwdMinNumbers2").numeric();
		$("#compositionCnt2").numeric();
		$("#passwdUsageLimitCnt").numeric();
		$("#passwdChgMonthCnt").numeric();
		$("#accountBlockMonthCnt").numeric();
	});

	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {
		
		window.onload = function() {
			Search();
		};
	
		${initScript}
		
	});
	
</script>
	
<script type="text/javascript">

	/****************************************
	* Button
	****************************************/	
	function Search() {

		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0102301S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
        table.setParameter("outParamKey",
        		"passwdMinNumbers1;upperCaseYN1;lowerCaseYN1;numberYN1;specialLettersYN1;"+
        		"compositionCnt1;passwdRuleYN1;passwdMinNumbers2;upperCaseYN2;lowerCaseYN2;"+
        		"numberYN2;specialLettersYN2;compositionCnt2;passwdRuleYN2;passwdUsageLimitCnt;"+
        		"passwdUsageLimitRuleYN;passwdChgMonthCnt;passwdChgMonthRuleYN;accountBlockMonthCnt;accountBlockMonthRuleYN;");
      	table.request();

      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#passwdMinNumbers1").val(table.getData(0,0));
      		if (table.getData(1,0) == "Y") {
      			$("#upperCaseYN1").attr("checked",true);
      		}
      		else {
      			$("#upperCaseYN1").attr("checked",false);
      		}
      		if (table.getData(2,0) == "Y") {
      			$("#lowerCaseYN1").attr("checked",true);
      		}
      		else {
      			$("#lowerCaseYN1").attr("checked",false);
      		}
      		if (table.getData(3,0) == "Y") {
      			$("#numberYN1").attr("checked",true);
      		}
      		else {
      			$("#numberYN1").attr("checked",false);
      		}
      		if (table.getData(4,0) == "Y") {
      			$("#specialLettersYN1").attr("checked",true);
      		}
      		else {
      			$("#specialLettersYN1").attr("checked",false);
      		}
      		$("#compositionCnt1").val(table.getData(5,0));
      		if (table.getData(6,0) == "Y") {
      			$("#passwdRuleYN1").attr("checked",true);
      		}
      		else {
      			$("#passwdRuleYN1").attr("checked",false);
      		}
      		
      		$("#passwdMinNumbers2").val(table.getData(7,0));
      		if (table.getData(8,0) == "Y") {
      			$("#upperCaseYN2").attr("checked",true);
      		}
      		else {
      			$("#upperCaseYN2").attr("checked",false);
      		}
      		if (table.getData(9,0) == "Y") {
      			$("#lowerCaseYN2").attr("checked",true);
      		}
      		else {
      			$("#lowerCaseYN2").attr("checked",false);
      		}
      		if (table.getData(10,0) == "Y") {
      			$("#numberYN2").attr("checked",true);
      		}
      		else {
      			$("#numberYN2").attr("checked",false);
      		}
      		if (table.getData(11,0) == "Y") {
      			$("#specialLettersYN2").attr("checked",true);
      		}
      		else {
      			$("#specialLettersYN2").attr("checked",false);
      		}
      		$("#compositionCnt2").val(table.getData(12,0));
      		if (table.getData(13,0) == "Y") {
      			$("#passwdRuleYN2").attr("checked",true);
      		}
      		else {
      			$("#passwdRuleYN2").attr("checked",false);
      		}
      		
      		$("#passwdUsageLimitCnt").val(table.getData(14,0));
      		if (table.getData(15,0) == "Y") {
      			$("#passwdUsageLimitRuleYN").attr("checked",true);
      		}
      		else {
      			$("#passwdUsageLimitRuleYN").attr("checked",false);
      		}
      		
      		$("#passwdChgMonthCnt").val(table.getData(16,0));
      		if (table.getData(17,0) == "Y") {
      			$("#passwdChgMonthRuleYN").attr("checked",true);
      		}
      		else {
      			$("#passwdChgMonthRuleYN").attr("checked",false);
      		}
      		
      		$("#accountBlockMonthCnt").val(table.getData(18,0));
      		if (table.getData(19,0) == "Y") {
      			$("#accountBlockMonthRuleYN").attr("checked",true);
      		}
      		else {
      			$("#accountBlockMonthRuleYN").attr("checked",false);
      		}
      		
      	}
	}
	
    function Save() {

		var table = new AW.XML.Table;  
	  	table.setURL("${contextPath}/service/security/savePasswordPolicy");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
		table.setParameter("passwdMinNumbers1", $("#passwdMinNumbers1").val());
		table.setParameter("upperCaseYN1", ($("#upperCaseYN1").attr("checked")?'Y':'N'));
		table.setParameter("lowerCaseYN1", ($("#lowerCaseYN1").attr("checked")?'Y':'N'));
		table.setParameter("numberYN1", ($("#numberYN1").attr("checked")?'Y':'N'));
		table.setParameter("specialLettersYN1", ($("#specialLettersYN1").attr("checked")?'Y':'N'));
		table.setParameter("compositionCnt1", $("#compositionCnt1").val());
		table.setParameter("passwdRuleYN1", ($("#passwdRuleYN1").attr("checked")?'Y':'N'));
		table.setParameter("passwdMinNumbers2", $("#passwdMinNumbers2").val());
		table.setParameter("upperCaseYN2", ($("#upperCaseYN2").attr("checked")?'Y':'N'));
		table.setParameter("lowerCaseYN2", ($("#lowerCaseYN2").attr("checked")?'Y':'N'));
		table.setParameter("numberYN2", ($("#numberYN2").attr("checked")?'Y':'N'));
		table.setParameter("specialLettersYN2", ($("#specialLettersYN2").attr("checked")?'Y':'N'));
		table.setParameter("compositionCnt2", $("#compositionCnt2").val());
		table.setParameter("passwdRuleYN2", ($("#passwdRuleYN2").attr("checked")?'Y':'N'));
		table.setParameter("passwdUsageLimitCnt", $("#passwdUsageLimitCnt").val());
		table.setParameter("passwdUsageLimitRuleYN", ($("#passwdUsageLimitRuleYN").attr("checked")?'Y':'N'));
		table.setParameter("passwdChgMonthCnt", $("#passwdChgMonthCnt").val());
		table.setParameter("passwdChgMonthRuleYN", ($("#passwdChgMonthRuleYN").attr("checked")?'Y':'N'));
		table.setParameter("accountBlockMonthCnt", $("#accountBlockMonthCnt").val());
		table.setParameter("accountBlockMonthRuleYN", ($("#accountBlockMonthRuleYN").attr("checked")?'Y':'N'));
		table.request();

		if (table.getData(0,0) == 'S'){
			message(table.getData(1,0));
		}
		else {
			alert(table.getData(1,0));
		}
	}
    
</script>