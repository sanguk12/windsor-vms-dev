<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@ include file="sys3/taglib.jsp"%>

<!DOCTYPE html>
<html lang="ko">

	<head>
	  	<title><fmt:message key="application.title" /></title>
	  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	  	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.8.2.min.js"></script>
		<script src="${contextPath}/scripts/baseScript.js" type="text/javascript"></script>
		 <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
	  	<link href="${contextPath}/images/login_dk/login.css" rel="stylesheet" type="text/css">
	  	
		<script type="text/javascript">
		 var onloadCallback = function() {
			 grecaptcha.render('html_element', {
		          'sitekey' : '6LcwQIIUAAAAACfS66dZdS11K9axsA8woxYdfzJs',
		          'callback' : function(response) {
	                    document.getElementById('recaptchaResponse').value = response;
	                },
	              'theme' : 'light'
		        });
		};
		  	$(document).ready(function() {
				
				window.onload = function() {
					/* 
					if("${chk}" == "Y"){
						document.getElementById("html_element").style.display="block";
						alert("다회 로그인 인증에 실패 하였습니다. 로봇 여부를 체크해 주세요.");
					}else{
					};
					 */
						document.getElementById("html_element").style.display="none";
					if("${message}" != "") alert("${message}");
					
					var memoryID = "";
			     	try {
				     	memoryID = getCookie("NURIAF_USERID_DK");
			     	}
			     	catch (e) {
				     	memoryID = "";
			     	}
			     	
			     	if (memoryID != "") {
						document.getElementById("userID").value = memoryID;
						document.form.memoryID.checked = true;
						document.form.passwd.focus();
			     	}
			     	else {
				     	document.form.userID.focus();
			     	}
				};
				
				$("#btn_login").click(function(){
					login();
				});
			});
		    
		    function login() {
			    if (document.form.memoryID.checked) {
					setCookie("NURIAF_USERID_DK", document.getElementById("userID").value, 365);
			    }
			    else {
				    setCookie("NURIAF_USERID_DK", "", 365);
			    }
	
			    if ($("#userID").val() == "") {
					alert("<fmt:message key="index.msg01"/>");
					$("#userID").focus();
					return;
			    }
			    else if ($("#passwd").val() == "") {
			    	alert("<fmt:message key="index.msg02"/>");
					$("#passwd").focus();
					return;
			    }
			    
			    setCookie("urlType", "kia", 1);
				document.form.action = "${contextPath}/service/auth/login";
		        document.form.method.value = "login";
		        document.form.submit();
		   	}
	
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
	
		    
		    function setCookie( name, value, expiredays ) { 
	    		var todayDate = new Date(); 
	    		todayDate.setDate( todayDate.getDate() + expiredays );
	    		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"; 
			}
		    
		</script>
	</head>
	
	
	<body>
		<div class="wrapper">
			<div class="wrap">
				<div class="img"></div>
				<h1><img src="${contextPath}/images/login_dk/title.gif" alt="DIAGEO Customer Incentive Management System" /></h1>
				<div class="login">
					<h2><img src="${contextPath}/images/login_dk/login.png" alt="LOGIN" /></h2>
					<form id="form" name="form" method="post">
						<section>
							<input type="hidden" id="companyID" name="companyID" value="000001" />
							<input type="hidden" id="dkmdTpCD" name="dkmdTpCD" value="DK" />
							<input type="hidden" id="displayMnuTp" name="displayMnuTp" value="100" /> 
							<div><img src="${contextPath}/images/login_dk/id.png" alt="id" class="pr12 mr5"/><span><input id="userID" name="userID" class="input_txt" style="ime-mode:disabled;"></span></div>
							<div class="mt5"><img src="${contextPath}/images/login_dk/pw.png" alt="password" class="mr5" /><span><input id="passwd" name="passwd" type="password" class="input_txt" onkeypress="if (event.keyCode==13) {login(); return false;}" autocomplete="off"></span></div>
							<div class="btn"><img id="btn_login" src="${contextPath}/images/login_dk/btn_login.png" alt="pw" /></div>
							<div class="check"><input id="memoryID" name="memoryID" type="checkbox" value="ID저장"> ID 저장</div>
							<div id="html_element" class="g-recaptcha" ></div>
						</section>
					</form>
					<form:hidden path="recaptchaResponse"/>
				</div>
				<div>
				<div class="footer">
					<b>02) 2112-1400</b> 서울특별시 강남구 테헤란로 152
				</div>
				</div>
			</div>
		</div>
	</body>
	
</html>