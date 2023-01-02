<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="bodyConfig" value="oncontextmenu='return false'; ondragstart='return true'; onselectstart='return true';"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>중복 아이디 로그인</title>
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
								중복 아이디 로그인
							</td>
						</tr>
						<tr>
							<td class="alert_mid" height="*">
								<table width="622" height="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td style="font-size:13px; text-align:center; min-height:100px;">	
											다른 컴퓨터에서 동일한 아이디로 접속하여 이 연결을 끊습니다.
										</td>
									</tr>
								</table>
							</td>
						</tr>
				        <tr>
							<td height="1" style="text-align:center; padding-bottom:20px; padding-top:10px;">
								<script type="text/javascript">
									var home = new AW.UI.Button;
									home.setControlText("Home");
									home.setControlImage("home");
									document.write(home);
									
									home.onControlClicked = function(event){
										top.location.href = "${contextPath}/sys/index.page";
									}
					             </script>
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