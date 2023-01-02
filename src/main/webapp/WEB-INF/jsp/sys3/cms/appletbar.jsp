<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>

<div id="btn">
	<div id="tit" style="text-align:left;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr class="applet-functionbar-title"  style="background:url(images/common/bk_tit1.gif) repeat-x; line-height:30px; padding:0 0 0 20px; height:30px; width:300px; vertical-align:middle;">
				<td valign="middle" >
					<img src="${params.themeURL}/images/common/stit_point.gif"> 
					<c:choose>
	                    <c:when test="${params.viewTitle == ''}">
	                        ${params.viewName}
	                    </c:when>
	                    <c:otherwise>
	                        ${params.viewTitle}
	                    </c:otherwise>
	                </c:choose>
                </td>
                <td align="right" >
					<script type="text/javascript">
                           var appletbarClose = new AW.UI.Button;
                           appletbarClose.setControlText("x");
                           document.write(appletbarClose);
                           
                           appletbarClose.onControlClicked = function(event) {
								try {
									parent.appletClose();
									parent.Search();
								} catch(e){}
								
								try {
									window.close();
								} catch(e){}
                           };
					</script>
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
							<c:when test="${function.funcCode == 'Search' || function.funcCode == 'Save'}">
								showLoading();
								window.setTimeout("${function.command}()", 500);
								window.setTimeout("hideLoading()", 500);
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