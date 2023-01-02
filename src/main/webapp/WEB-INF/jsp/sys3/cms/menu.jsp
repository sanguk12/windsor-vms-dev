<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><fmt:message key="application.title" /></title>
		<%@include file="../scripts.jsp" %>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	</head>
	<frameset name="ContentFrame" cols="210,*" framespacing="0" frameborder="no" border="0">
		<frame src="${contextPath}/MenuConstruct.do?method=subMenuList&pmnuGrpID=${param.pmnuGrpID}" id="SubMenu" name="SubMenu" scrolling="no" noresize  marginwidth="0" marginheight="0">
		<frame src="" id="Content" name="SubContent" scrolling="SubContent" noresize marginwidth="0" marginheight="0">
	</frameset>
</html>