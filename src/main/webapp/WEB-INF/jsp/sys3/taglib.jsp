<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/FCKeditor.tld" prefix="FCK" %>
<%//@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>
<%@ taglib uri="/WEB-INF/tlds/NuriAF3.tld" prefix="nis" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="bodyConfig" value="oncontextmenu='return true'; ondragstart='return true'; onselectstart='return true';"/>
<c:set var="initScript" value="appletDiv_init();"/>
<c:set var="appletDiv" value="<div id='appletDiv'><iframe id='_detail' name='_detail' width='100%' height='100%' class='applet-border' frameborder='0' scrolling='auto' ></iframe></div>"/>