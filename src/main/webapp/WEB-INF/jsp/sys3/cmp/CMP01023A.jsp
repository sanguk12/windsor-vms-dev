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
				        			<col style="width:85px;"></col>
				        			<col></col>
				        		</colgroup>
				        		<tbody>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01023A.passwdMinNumbers" />
									</td>
									<td class="td-input">
										<input type="text" id="passwdMinNumbers" style="width:50px; text-align:right;">
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
										<input type="checkbox" id="passwdChgRuleYN" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.passwdChgCnt" />
									</td>
									<td class="td-input">
										<input type="text" id="passwdChgCnt" style="width:50px; text-align:right;">
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01023A.useYN" />
									</td>
									<td class="td-input">
										<input type="checkbox" id="accountBlockRuleYN" class="checkbox">
									</td>
									<td class="td-cond">
										<fmt:message key="CMP01023A.accountBlockCnt" />
									</td>
									<td class="td-input">
										<input type="text" id="accountBlockCnt" style="width:50px; text-align:right;">
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
		$("#passwdMinNumbers").numeric();
		$("#passwdUsageLimitCnt").numeric();
		$("#passwdChgCnt").numeric();
		$("#accountBlockCnt").numeric();
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
        		"passwdMinNumbers;passwdUsageLimitCnt;passwdUsageLimitRuleYN;passwdChgCnt;passwdChgRuleYN;"+
        		"accountBlockCnt;accountBlockRuleYN;");
      	table.request();

      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#passwdMinNumbers").val(table.getData(0,0));
      		
      		$("#passwdUsageLimitCnt").val(table.getData(1,0));
      		if (table.getData(2,0) == "Y") {
      			$("#passwdUsageLimitRuleYN").attr("checked",true);
      		}
      		else {
      			$("#passwdUsageLimitRuleYN").attr("checked",false);
      		}
      		
      		$("#passwdChgCnt").val(table.getData(3,0));
      		if (table.getData(4,0) == "Y") {
      			$("#passwdChgRuleYN").attr("checked",true);
      		}
      		else {
      			$("#passwdChgRuleYN").attr("checked",false);
      		}
      		
      		$("#accountBlockCnt").val(table.getData(5,0));
      		if (table.getData(6,0) == "Y") {
      			$("#accountBlockRuleYN").attr("checked",true);
      		}
      		else {
      			$("#accountBlockRuleYN").attr("checked",false);
      		}
      		
      	}
	}
	
    function Save() {

		var table = new AW.XML.Table;  
	  	table.setURL("${contextPath}/service/security/savePasswordPolicy");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
		table.setParameter("passwdMinNumbers", $("#passwdMinNumbers").val());
		table.setParameter("passwdUsageLimitCnt", $("#passwdUsageLimitCnt").val());
		table.setParameter("passwdUsageLimitRuleYN", ($("#passwdUsageLimitRuleYN").attr("checked")?'Y':'N'));
		table.setParameter("passwdChgCnt", $("#passwdChgCnt").val());
		table.setParameter("passwdChgRuleYN", ($("#passwdChgRuleYN").attr("checked")?'Y':'N'));
		table.setParameter("accountBlockCnt", $("#accountBlockCnt").val());
		table.setParameter("accountBlockRuleYN", ($("#accountBlockRuleYN").attr("checked")?'Y':'N'));
		table.request();

		if (table.getData(0,0) == 'S'){
			message(table.getData(1,0));
		}
		else {
			alert(table.getData(1,0));
		}
	}
    
</script>