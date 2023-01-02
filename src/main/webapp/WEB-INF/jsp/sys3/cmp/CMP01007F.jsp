<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>
       <script src="${contextPath}/scripts/baseValidation.js" type="text/javascript"></script>
	<style type="text/css">
	<!--
		body {margin-left: 0px;margin-top: 1px;margin-right: 0px;margin-bottom: 0px;}
	-->
	</style>
</head>

<body onload="fnMessage('${params.msg}', 'CloseReload');" class="yui-skin-sam" ${bodyConfig}>
<form name="frm" method="post">
<div id="wrapDiv"><div id="formDiv">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
        <tr>
            <td height="1">
				<input type="hidden" name="pmnuGrpID" value="${params.pmnuGrpID}" />
				<input type="hidden" name="mnuConstructID" value="${params.mnuConstructID}" />
				<input type="hidden" name="mnuConstructName" value="${params.mnuConstructName}" />
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
										<fmt:message key="CMP01007F.mnuConstructName" />
									</td>
									<td class="td-input" width="*">
										${params.mnuConstructName}
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01007F.pmnuGrpName" />
									</td>
									<td class="td-input">
										${params.pmnuGrpName}
										<input type="hidden" name="pmnuGrpName" value="${params.pmnuGrpName}" />
									</td>
								</tr>
								<tr>
									<td class="td-cond-required">
										<fmt:message key="CMP01007F.mnuGrpID" />
									</td>
									<td class="td-input">
										<input type="text" id="mnuGrpID2" name="mnuGrpID2" value="${params.mnuGrpID2}" style="width:100px; ime-mode:disabled;" <c:if test="${params.saveType!='insert'}">readonly="readonly"</c:if>>
										<c:if test="${params.saveType=='insert'}">
											<script type="text/javascript">
												var overLap = new AW.UI.Button;
											     overLap.setControlText("<fmt:message key="CMP01007F.msg1" />");
											     document.write(overLap);
											     overLap.onControlClicked = function(event){
											    	 Overlap();
											     }
											</script>
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="td-cond-required">
										<fmt:message key="CMP01007F.mnuGrpName" />
									</td>
									<td class="td-input">
										<input type="text" name="mnuGrpName" style="width:300px" value="${params.mnuGrpName}">
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01007F.seq" />
									</td>
									<td class="td-input">
										<input type="text" id="seq" name="seq" style="width:100px; ime-mode:disabled;" value="${params.seq}">
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01007F.url" />
									</td>
									<td class="td-input">
										<input type="text" name="url" style="width:350px; ime-mode:disabled;" value="${params.url}">
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01007F.useYN" />
									</td>
									<td class="td-input">
										<nis:radio id="useYN" name="useYN" category="USETYPE1CD" value="${params.useYN}" />
									</td>
								</tr>
								<tr>
									<td class="td-cond">
										<fmt:message key="CMP01007F.displayYN" />
									</td>
									<td class="td-input">
										<nis:radio id="displayYN" name="displayYN" category="USETYPE2CD" value="${params.displayYN}" />
									</td>
								</tr>
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

	/****************************************
	* Variable
	****************************************/
	var servlet = "${contextPath}/service/menuConstruct";
	var saveType = "${params.saveType}";
	var replaceCtrls=["seq"];
	
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
	
	// MenuConstructGroup Save(Insert/Update)
	function Save() {
		
		if ($("#mnuGrpID2").val() == "") {
			alert("<fmt:message key="info.inputRequired" />");
			return;
		}
		else if ($("#mnuGrpName").val() == "") {
			alert("<fmt:message key="info.required" />");
			return;
		}
		
		if(saveType=="insert") {
			fnSubmitConfirm(frm, servlet, "insertMenuConstructGroup", "<fmt:message key="confirm.save" />");
		} else {
			fnSubmitConfirm(frm, servlet, "updateMenuConstructGroup", "<fmt:message key="confirm.save" />");
		}
	}
	
	// MenuConstructGroup Delete
	function Delete() {
		if(saveType!="insert") {
			replaceValue(replaceCtrls);
			fnSubmitConfirm(frm, servlet, "deleteMenuConstructGroup", "<fmt:message key="confirm.delete" />");
		}
	}
	
	function Close() {
		fnClose();
	}
	
	function Overlap() {
		var mnuGrpID = document.frm.mnuGrpID2.value;
		var mnuConstructID = document.frm.mnuConstructID.value;
		if(mnuGrpID.length>0) {
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/simpleAction/CMP0100724S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("mnuConstructID", mnuConstructID);
			table.setParameter("mnuGrpID", mnuGrpID);
			table.request();
			if(table.getData(0,0)!="NOTEXIST") {
				notExist = false;
				alert("<fmt:message key="error.exist" />");
			} else {
				notExist = true;
				alert("<fmt:message key="error.notExist" />");
			}
		} else {
			alert("<fmt:message key="infos.required" />");
		}
	}
</script>