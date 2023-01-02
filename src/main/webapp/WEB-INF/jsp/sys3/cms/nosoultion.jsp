<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="bodyConfig" value="oncontextmenu='return false'; ondragstart='return true'; onselectstart='return true';"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link href="${contextPath}/scripts/theme/blue/styles/aw.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/scripts/theme/blue/theme.css" rel="stylesheet" type="text/css" />
		<script src="${contextPath}/scripts/aw/runtime/lib/aw.js"></script>
		
	</head>

	<body ${bodyConfig}>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
			<tr>
				<td align="center" valign="middle" style="vertical-align:middle; color:666; font-size:16px; font-weight:bold;  height:69px;">
					Not Using Soultion 
			   </td>
			</tr>
		</table>
	</body>
</html>