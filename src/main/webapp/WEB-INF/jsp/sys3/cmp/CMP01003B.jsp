<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<form name="form" method="post">
		<div id="wrapDiv">
         	<div id="formDiv">
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
	                    			<td class="tb-border">
							        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
							        		<colgroup>
							        			<col style="width:100px"></col>
							        			<col style="width:185px"></col>
							        			<col style="width:100px"></col>
							        			<col></col>
							        		</colgroup>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="CMP01003B.codeDiv" />
												</td>
												<td class="td-input">
													<input type="hidden" id="codeDiv" name="codeDiv" value="${params.codeDiv}" />
													<input type="text" id="codeDivName" name="codeDivName" class="input-readonly" style="width:140px;" value="${params.codeDivName}">
												</td>
												<td class="td-cond-required">
													<fmt:message key="CMP01003B.comCode" />
												</td>
												<td class="td-input">
													<input type="text" id="comCode" name="comCode" style="width:100px;" value="${params.comCode}">
													<input type="hidden" id="orgComCode" name="orgComCode" value="${params.comCode}">
													<script type="text/javascript">
														var overLap = new AW.UI.Button;
													     overLap.setControlText("<fmt:message key="button.Overlap" />");
													     document.write(overLap);
													     overLap.onControlClicked = function(event){
													    	 Overlap();
													     }
													</script>
												</td>
											</tr>
											<tr>
												<td class="td-cond-required">
													<fmt:message key="CMP01003B.codeName" />
												</td>
												<td class="td-input" colspan="3">
													<input type="text" id="codeName" name="codeName" style="width:140px;" value="${params.codeName}">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003B.codeDesc" />
												</td>
												<td class="td-input" colspan="3">
													<input type="text" id="codeDesc" name="codeDesc" value="${params.codeDesc}" style="width:140px;">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003B.seq" />
												</td>
												<td class="td-input">
													<input type="text" id="seq" name="seq" style="width:140px; text-align:right;" value="${params.seq}">
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01003B.useYN" />
												</td>
												<td class="td-input">
													<nis:selectbox id="useYN" name="useYN" defaultText="none" category="USETYPE2CD" value="${params.useYN}" />
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003B.remark" />
												</td>
												<td class="td-input" colspan="3">
													<textarea id="remark" name="remark" cols="70" rows="6" bytesize="250">${params.remark}</textarea>
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend01" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib01" name="attrib01" style="width:140px;" value="${params.attrib01}">
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend02" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib02" name="attrib02" style="width:140px;" value="${params.attrib02}">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend03" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib03" name="attrib03" style="width:140px;" value="${params.attrib03}">
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend04" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib04" name="attrib04" style="width:140px;" value="${params.attrib04}">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend05" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib05" name="attrib05" style="width:140px;" value="${params.attrib05}">
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend06" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib06" name="attrib06" style="width:140px;" value="${params.attrib06}">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend07" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib07" name="attrib07" style="width:140px;" value="${params.attrib07}">
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend08" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib08" name="attrib08" style="width:140px;" value="${params.attrib08}">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend09" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib09" name="attrib09" style="width:140px;" value="${params.attrib09}">
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend10" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib10" name="attrib10" style="width:140px;" value="${params.attrib10}">
												</td>
											</tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend11" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib11" name="attrib11" style="width:140px;" value="${params.attrib11}">
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01003B.extend12" />
												</td>
												<td class="td-input">
													<input type="text" id="attrib12" name="attrib12" style="width:140px;" value="${params.attrib12}">
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
			${appletDiv}	
	    </div>            
	</form>
</body>
</html>

<script type="text/javascript">

	$(function() {
		try{$("#comCode").alphanumeric();}catch(e){}
		try{$("#seq").numeric();}catch(e){}
	});
	
	$(document).ready(function() {
		
		window.onload = function() {
			
			fnMessage('${params.msg}', 'CloseReload');
			
			$("#comCode").focus();
			
			if("${params.saveType}" != "insert") {
				if($("#codeDiv").val() == "ROOT") {
					$("#comCode").attr("readonly", true);
					$("#comCode").addClass("input-readonly");
					overLap.setControlVisible(false);
				}
				else {
					$("#comCode").attr("readonly", false);
					$("#comCode").removeClass("input-readonly");
					overLap.setControlVisible(true);
				}
			}
		};
	
		${initScript}
	});

	var servlet = "${contextPath}/service/code";
	var saveType = "${params.saveType}";
	var notExist = false;
	var overlapMessage = "";
	
	var message = ["<fmt:message key="info.inputRequired" />", "<fmt:message key="info.required" />"];
	var ctrls = ["comCode", "codeName"];
	var replaceCtrls=["seq"];
	
	// Code Save(Insert/Update)
	function Save() {
		if(saveType=="insert") {
			if(!notExist){
				alert("<fmt:message key="CMP01003B.msg1" />");
				return;
			}
			fnSubmitConfirm(form, servlet, "insertCode", "<fmt:message key="confirm.save" />");
		}
		else {
			fnSubmitConfirm(form, servlet, "updateCode", "<fmt:message key="confirm.save" />");
		}
	}
	
	// Code Delete
	function Delete() {
		fnSubmitConfirm(form, servlet, "deleteCode", "<fmt:message key="confirm.delete" />");
	}
	
	function Close() {
		fnClose();
	}
	
	// Code Overlap
	function Overlap() {
		
		var comCode = $("#comCode").val();
		var codeDiv = $("#codeDiv").val();
		
		if(comCode.length > 0) {
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/simpleAction/CMP0100302S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("comCode", comCode);
			table.setParameter("codeDiv", codeDiv);
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