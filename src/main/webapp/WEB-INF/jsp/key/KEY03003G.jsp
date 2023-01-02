<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 키맨문서보관변경 화면 -->
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
							</td>
						</tr>
						<tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:120px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
								        			<tr>
						                            	<td class="td-cond">
						                            		<fmt:message key="KEY03003G.keyman" />
														</td>
														<td class="td-input">
															<input type="text" id="keymanCd" name="keymanCd" style="width:80px; text-align: center;" class="input-readonly" readonly="readonly"/>
															<input type="text" id="keymanNm" name="keymanNm" style="width:80px;" class="input-readonly" readonly="readonly"/>
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond">
						                            		<fmt:message key="KEY03003G.keymanDocMngFl" />
														</td>
														<td class="td-input"> 
															<nis:selectbox id="docMngFl" name="docMngFl" defaultText="none" category="DOCMNGFL" />
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
							<td height="*" valign="top">
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
	
	//Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	 * Variable
	 ****************************************/
	 
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
	* Button Action
	****************************************/
	
	function Save() {
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key03/updateKeymanDocMngFl");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("keymanID", $("#keymanCd").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("docMngFl", $("#docMngFl").val());
		
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			window.close();
   		} else {
			alert(table.getData(1,0));
		}
		
	}
	
	function Close() {
		
		window.close();
		
	}
	
	function Search(){
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/KEY0300304S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey", "keymanid;keymannm;docmngfl;");
        table.setParameter("format", "str;str;str;");
        table.setParameter("keymanID", "${params.keymanCd}");
        table.request();
        
        var rowCount = table.getCount();
      	if (rowCount == 1) {
      		$("#keymanCd").val(table.getData(0,0));
      		$("#keymanNm").val(table.getData(1,0));
      		$("#docMngFl").val(table.getData(2,0));
      	}
      	
	}
</script>