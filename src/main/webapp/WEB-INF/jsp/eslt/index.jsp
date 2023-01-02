<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@ include file="../sys3/taglib.jsp"%>

<!DOCTYPE html>
<html lang="ko">

	<head>
	  	<title><fmt:message key="application.title.eslt" /></title>
	  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	  	<link href="${contextPath}/css/login.css" rel="stylesheet" type="text/css">
	  	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.8.2.min.js"></script>
		<script src="${contextPath}/scripts/baseScript.js" type="text/javascript"></script>
	  	
		<script type="text/javascript">
	  	
		  	$(document).ready(function() {
				
				window.onload = function() {
					if("${message}" != "") alert("${message}");
					
					var locUrl = location.href;
					var host = window.location.host;
					if(host == "kiaad.co.kr" || host == "www.kiaad.co.kr") {
						document.location.href = "${contextPath}/eslt/index_ad_eslt.page";
					}
					else if(host == "kiatl.co.kr" || host == "www.kiatl.co.kr") {
						document.location.href = "${contextPath}/eslt/index_tl_eslt.page";
					}
					else if(host == "kiamp.co.kr" || host == "www.kiamp.co.kr") {
						document.location.href = "${contextPath}/eslt/index_mp_eslt.page";
					}
					else if(host == "kiadx.co.kr" || host == "www.kiadx.co.kr") {
						document.location.href = "${contextPath}/eslt/index_dx_eslt.page";
					}
					else {
						document.location.href = "${contextPath}/eslt/index_dk_eslt.page";
					}
				};	
			});
		    
		</script>
	</head>

</html>