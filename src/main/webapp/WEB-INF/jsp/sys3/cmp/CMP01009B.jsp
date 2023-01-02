<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>
</head>

<body ${bodyConfig}>
	<form name="form" method="post">
		<div id="wrapDiv">
        	<div id="formDiv">
         		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		        	<tr>
	                    <td height="1">
							<input type="hidden" name="mnuGrpID" value="${params.mnuGrpID}" />
							<input type="hidden" name="pgmID" value="${params.pgmID}" />
							<input type="hidden" name="viewID" value="${params.viewID}" />
							<input type="hidden" name="grpID" value="${params.regGrpID}" />
							
							<%@include file="../cms/functionbar.jsp" %>
						</td>
					</tr>
					<tr>
	                    <td height="1">
	                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
	                    		<tr>
	                    			<td class="tb-border">
							        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
							        		<colgroup>
							        			<col style="width:100px;"></col>
							        			<col></col>
							        		</colgroup>
											<tbody>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="CMP01009B.grpName" /></td>
												<td class="td-input">
													<input type="text" id="grpName" name="grpName" style="width:200px" value="${params.grpName_view}">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01009B.mnuConstructName" />
												</td>
												<td class="td-input">
													<nis:selectbox id="mnuConstructID" name="mnuConstructID" style="width:200px" defaultText="select" data="${mnuConstructID}" value="${params.mnuConstructID}" />
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01009B.dkmdTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD" name="dkmdTpCD" style="width:200px" defaultText="select" category="DKMDTPCD" value="${params.dkmdTpCD_I}" />
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01009B.remark" />
												</td>
												<td class="td-input">
													<textarea name="remark" cols="65" rows="8" bytesize="2000">${params.remark}</textarea>
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
			</div>
	    </div>
	</form>
</body>
</html>

<script type="text/javascript">

	$(document).ready(function() {
		
		window.onload = function() {
			fnMessage('${params.msg}', 'CloseReload'); 
			$("#grpName").focus();
		};
	
		${initScript}
	});

	var servlet = "${contextPath}/service/group";
	var saveType = "${params.saveType}";
	var message = ["<fmt:message key="info.inputRequired" />", "<fmt:message key="info.required" />"];
	var ctrls = ["grpName"];
	var replaceCtrls=[];
	
	function Save() {
		
		if ($("#grpName").val() == "") {
			alert("<fmt:message key="CMP01009B.msg1" />");
			return;
		}
		else if ($("#mnuConstructID").val() == "") {
			alert("<fmt:message key="CMP01009B.msg2" />");
			return;
		}
// 		else if ($("#mnuConstructID2").val() == "") {
// 			alert("<fmt:message key="CMP01009B.msg3" />");
// 			return;
// 		}
				
		if(saveType=="insert") {
			fnSubmitConfirm(form, servlet, "insertGroup", "<fmt:message key="confirm.save" />");
		} else {
			fnSubmitConfirm(form, servlet, "updateGroup", "<fmt:message key="confirm.save" />");
		}
	}
	
	// Group Delete
	function Delete() {
		fnSubmitConfirm(form, servlet, "deleteGroup", "<fmt:message key="confirm.delete" />");
	}
	
	function Close() {
		fnClose();
	}
	
	// Group Overlap
	function Overlap() {
		
	}
</script>