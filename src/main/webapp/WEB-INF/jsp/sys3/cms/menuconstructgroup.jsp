<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><fmt:message key="application.title" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../scripts.jsp" %>
	</head>
	<frameset name="MenuConstructGroupFrame" rows="50%,50%" framespacing="0" frameborder="no" border="0">
		<frame src="${contextPath}/menuconstruct.do?method=listMenuConstructGroup&mnuConstructID=${param.mnuConstructID}&mnuConstructName=${param.mnuConstructName}&pmnuGrpID=${param.pmnuGrpID}&pmnuGrpName=${param.pmnuGrpName}&mnuGrpID=${param.mnuGrpID}&pgmID=${param.pgmID}&viewID=MenuConstructGroupList" id="mnuGrp" name="mnuGrp" scrolling="no" noresize  marginwidth="0" marginheight="0">
		<frame src="${contextPath}/menuconstruct.do?method=listMenuConstructGroupProgram&mnuConstructID=${param.mnuConstructID}&pmnuGrpID=${param.pmnuGrpID}&mnuGrpID=${param.mnuGrpID}&pgmID=${param.pgmID}&viewID=MenuConstructGroupProgram" id="mnuGrpPgm" name="mnuGrpPgm" scrolling="no" noresize marginwidth="0" marginheight="0">
	</frameset>
</html>