<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>

<html>
<head>
<title><fmt:message key="application.title" /></title>
<%@include file="../scripts.jsp" %>
<script language="javascript">
	function onLoad() {
		top.location.href="${contextPath}/sys3/cms/nosession.page";
	}
</script>
</head>
<body onload="onLoad();">
</body>
</html>