<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.8.2.min.js"></script>
	<script src="${contextPath}/scripts/baseScript.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			document.location.href = "https://diageo.okta.com/oauth2/v1/authorize?client_id=0oabkogt3womvgCOZ2p7&response_type=code&scope=openid+email&redirect_uri=https%3a%2f%2fvmsdk.co.kr%2fsmart%2fservice%2fauth%2fokta%2flogin&state=state-296bc9a0-a2a2-4a57-be1a-d0e2fd9bb601&nonce=g5ly497e8ps";
		});
	</script>
</head>
</html>