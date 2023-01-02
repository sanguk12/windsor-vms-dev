<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>

<div id="btn" style="width:100%;">
	<div id="tit">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr style="padding-top:5px;" valign="top">
				<td class="group-title td-input" style="width:500px;">
					<c:choose>
	                    <c:when test="${params.viewTitle == ''}">
	                        ${params.viewName}
	                    </c:when>
	                    <c:otherwise>
	                        ${params.viewTitle}
	                    </c:otherwise>
	                </c:choose>
				</td>
				<td class="tit_text01" style="text-align:right; padding-right:30px;" id="messagebar">
				</td>
			</tr>
		</table>
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td style="height:8px;"></td>
		</tr>
		<tr>
			<td align="right">
				<c:forEach items="${funcList}" var="function" varStatus="status">
					<script type="text/javascript">
				  	var ${"btn"}${function.funcCode} = new AW.UI.Button;
					//${"btn"}${function.funcCode}.setId("${function.funcCode}");
					${"btn"}${function.funcCode}.setControlText("${function.funcName}");
					${"btn"}${function.funcCode}.setControlImage("${function.icon}");
					document.write(${"btn"}${function.funcCode});
					
					${"btn"}${function.funcCode}.onControlClicked = function(event){
						<c:choose>
							<c:when test="${function.funcCode == 'Search' || function.funcCode == 'Save' || function.funcCode == 'Excel'}">
								/*progress bar
								showLoading();
								window.setTimeout("${function.command}()", 500);
								window.setTimeout("hideLoading()", 500);
								*/
								${function.command}();
							</c:when>
							<c:otherwise>
								${function.command}();
							</c:otherwise>
						</c:choose>
						try{parent.InitSessionTimer();}catch(e){}						
					}
					</script>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td height="2"></td>
		</tr>
	</table>
</div>