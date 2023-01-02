<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="bodyConfig" value="oncontextmenu='return false'; ondragstart='return true'; onselectstart='return true';"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><fmt:message key="application.title" /></title>
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
								Information
               				</td>
						</tr>
						<tr>
							<td class="alert_mid" height="*">
								<table width="622" height="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td style="font-size:13px; text-align:center; min-height:100px;">	
											<fmt:message key="cms.nosession.information"/>
                						</td>
									</tr>
								</table>
							</td>
						</tr>
				        <tr>
							<td height="1" style="text-align:center; padding-bottom:20px; padding-top:10px;">
			            		<input type="button" id="login" name="login" class="tit_text01" onclick="getLogin();" value="Login" style="width:100px; cursor:pointer;" />
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
	
	function getCookie(name) { 
		var nameOfCookie = name + "="; 
		var x = 0; 
		while ( x <= document.cookie.length ) { 
			var y = (x+nameOfCookie.length); 
		    if (document.cookie.substring( x, y ) == nameOfCookie ) { 
				if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
					endOfCookie = document.cookie.length; 
					return unescape( document.cookie.substring( y, endOfCookie ) ); 
				} 
				x = document.cookie.indexOf( " ", x ) + 1; 
			if ( x == 0 ) 
				break; 
		} 
		return ""; 
	}

	function getLogin() {
		
		var url = "";
		url = getCookie("urlType");
		
		if(url == "mobile") {
			document.location.href = "${contextPath}/mobile/index.page";
		}else if(url == "eslt") {
			document.location.href = "${contextPath}/eslt/index.page";
		}else{
			document.location.href = "${contextPath}/index.page";			
		}
		
	}
	
</script>