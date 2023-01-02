<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="bodyConfig" value="oncontextmenu='return false'; ondragstart='return true'; onselectstart='return true';"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>권한 없음 오류</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link href="${contextPath}/scripts/theme/blue/styles/aw.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/scripts/theme/blue/theme.css" rel="stylesheet" type="text/css" />
		<script src="${contextPath}/scripts/aw/runtime/lib/aw.js"></script>
	
	</head>

	<body ${bodyConfig}>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
			<tr>
				<td align="center" valign="middle">
					<table border="0" cellpadding="0" cellspacing="0" width="622">
				    	<tr>
				    		<td class="alert_tit" style="background:url(${contextPath}/scripts/theme/blue/images/common/alert_top.png) no-repeat;" height="1">
								권한 없음 오류
							</td>
						</tr>
						<tr>
							<td class="alert_mid" height="*">
								<table width="622" height="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td style="font-size:13px; text-align:center; min-height:100px;">	
											<fmt:message key="cms.noauthority.information"/>
										</td>
									</tr>
								</table>
							</td>
						</tr>
				        <tr>
							<td height="1" style="text-align:center; padding-bottom:20px; padding-top:10px;">
					             <input type="button" id="home" name="home" class="tit_text01" onclick="getHome();" value="Home" style="width:100px; cursor:pointer;" />
							</td>
						</tr>
						<tr>
							<td height="1"><img src="${contextPath}/scripts/theme/blue/images/common/alert_bottom.png"></td>
						</tr>
			   	    </table>
			   </td>
			</tr>
		</table>
	</body>
</html>

<script type="text/javascript">

	function getHome() {
		top._workspace.location.href = "${contextPath}/service/widget/viewUserWidget";
	}
	
</script>