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
<div id="wrapDiv"><div id="formDiv">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
        <tr>
            <td height="1">
				<input type="hidden" name="mnuConstructID" value="${params.mnuConstructID}" />
				<input type="hidden" name="mnuGrpID" value="${params.mnuGrpID}" />
				<input type="hidden" name="pgmID" value="${params.pgmID}" />
				<input type="hidden" name="viewID" value="${params.viewID}" />
				
				<%@include file="../cms/functionbar.jsp" %>
			</td>
		</tr>
		<tr>
			<td height="1">
            	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                	<tr>
                  		<td class="tb-border">
				        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
								<tr>
									<td class="td-cond" width="120">
										<fmt:message key="CMP01007D.mnuConstructID" />
									</td>
									<td class="td-input" width="*">
										${params.mnuConstructID}&nbsp;
									</td>
								</tr>
								<tr>
									<td class="td-cond-required">
										<fmt:message key="CMP01007D.mnuConstructName" />
									</td>
									<td class="td-input">
										<input type="text" id="mnuConstructName" name="mnuConstructName" value="${params.mnuConstructName}">
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01007D.useYN" />
									</td>
									<td class="td-input">
										<nis:radio id="useYN" name="useYN" category="USETYPE1CD" value="${params.useYN}" />
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01007D.remark" />
									</td>
									<td class="td-input">
										<textarea name="remark" cols="60" rows="9" bytesize="2000">${params.remark}</textarea>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div></div>
</form>
</body>
</html>

<script type="text/javascript">
	
	/****************************************
	* Variable
	****************************************/
	var servlet = "${contextPath}/service/menuConstruct";
	var saveType = "${params.saveType}";
	
	/****************************************
	* Function
	****************************************/
	$(function() {
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {
		
		window.onload = function() {
			
		};

		${initScript}

	});
	
	// Save(Insert/Update)
	function Save() {
		if(saveType=="insert") {
			fnSubmitConfirm(form, servlet, "insertMenuConstruct", "<fmt:message key="confirm.save" />");
		} else {
			fnSubmitConfirm(form, servlet, "updateMenuConstruct", "<fmt:message key="confirm.save" />");
		}
	}
	
	// Delete
	function Delete() {
		fnSubmitConfirm(form, servlet, "deleteMenuConstruct", "<fmt:message key="confirm.delete" />");
	}
	
	function Close() {
		fnClose();
	}
</script>