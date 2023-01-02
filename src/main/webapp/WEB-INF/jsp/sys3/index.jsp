<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@ include file="taglib.jsp"%>

<!DOCTYPE html>
<html lang="ko">

<head>
  	<title>NuriAF SYSTEM 3</title>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  	<link href="${contextPath}/css/login.css" rel="stylesheet" type="text/css">
  	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.7.2.min.js"></script>
	<script src="${contextPath}/scripts/baseScript.js" type="text/javascript"></script>
  	
	<script type="text/javascript">
  	
	  	$(document).ready(function() {
			
			window.onload = function() {
				if("${message}" != "") alert("${message}");
				
				var memoryID = "";
		     	try {
			     	memoryID = getCookie("NURIAF_USERID");
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
				document.form.userID.focus();
			};	
		});
	    
	    function login() {

	    	// 아이디 기억하기
		    if (document.form.memoryID.checked) {
				setCookie("NURIAF_USERID", document.getElementById("userID").value, 365);
		    }
		    else {
			    setCookie("NURIAF_USERID", "", 365);
		    }

		    if ($("#userID").val() == "") {
				alert("아이디를 먼저 입력하십시오.");
				$("#userID").focus();
				return;
		    }
		    else if ($("#passwd").val() == "") {
		    	alert("비밀번호를 먼저 입력하십시오.");
				$("#passwd").focus();
				return;
		    }
		    /*
		    else if ($("#companyCD").val() == "") {
		    	alert("회사코드를 먼저 입력하십시오.");
				$("#companyCD").focus();
				return;
		    }
		    */
	
		    /*
			if (this.name != 'awp4web') {
		    	var win;
		
		        appVer=navigator.appVersion.substring(25,22);
		
		    	userwidth = (screen.width - 17);
		    	//userwidth = (screen.width - 10);
		    	userheight = (screen.height - 83);
		
		    	if (appVer=="5.5" || appVer=="6.0") {  // 버전이 6.0 이거나 5.5 일때
	
			    	try {
			    		win = window.open('','awp4web','channelmode=0,left=0,top=0,width='+userwidth+',height='+userheight+',fullscreen=0,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=auto,resizable=1');
			        }
			        catch(e){
				    	alert("이미 AnyWorks PRM 4 시스템 사용중 입니다.");
				        return;
			        }
			
			        document.form.action = "auth.do";
			        document.form.target = "awp4web";
			        document.form.method.value = "login";
			        document.form.submit();
			    	  
			    	self.opener=self;
			    	opener.close();
		
				} else if ( appVer == "7.0" || appVer == "8.0" || appVer == "9.0" ) {
	
					try {
			    		win = window.open("", "awp4web", "left=0,top=0,width="+userwidth+",height="+userheight+",scrollbars=yes,resizable=yes");
					}
			        catch(e){
				    	alert("이미 AnyWorks PRM 4 시스템 사용중 입니다.");
				        return;
			        }
			
			    	document.form.action = "auth.do";
			        document.form.target = "awp4web";
			        document.form.method.value = "login";
			        document.form.submit();
			          
			    	top.window.opener = top;
			    	top.window.open('','_parent', '');
			    	top.window.close();
		    	}
	
		    	else {
		    	
		    		try { 
			    	    win = window.open("", "awp4web", "left=0,top=0,width="+userwidth+",height="+userheight+",scrollbars=yes,resizable=yes");
		    		}
			    	catch(e){
				        alert("이미 AnyWorks PRM 4 시스템 사용중 입니다.");
				        return;
			         }
			    	
			    	 document.form.action = "auth.do";
			         document.form.target = "awp4web";
			         document.form.method.value = "login";
			         document.form.submit();

			         window.close();
				}
			}
			else {
			*/
				document.form.action = "${contextPath}/service/auth/login";
		        document.form.method.value = "login";
		        document.form.submit();
			//}
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
	<div id="wrapperbg">
		<div id="wrapper">
	    	<div id="wrap">
	        	<div id="header">
	            	<h1><img alt="AnyWorks PRM 5" src="${contextPath}/images/login/title.png"></H1>
	        	</div>
	        
	        	<div id="content">
		        	<form id="form" name="form" method="post">
		        		<input type="hidden" id="companyCD" name="companyCD" value="000001">
		            	<div id="login">                
		                	<div id="lbody">
		                		<ul>
		                    		<li class="r25">아이디 <input type="text" id="userID" name="userID" class="input_txt" ime-mode:disabled;"></li>
		                    		<li>비밀번호 <input type="password" id="passwd" name="passwd" class="input_txt" onkeypress="if (event.keyCode==13) {login(); return false;}"></li>
		                    	</ul>
		                	</div>
		                	<div id="btn"><a href="javascript:login();""><img alt="Login Button" src="${contextPath}/images/login/login_btn.gif"></a></div>
		            	</div>
		            	<div id="id_chk">
		            		<input type="checkbox" id="memoryID" name="memoryID"> <label>Remember ID</label> 
		            	</div>
		            </form>
		        </div>
	        
	        	<div id="footer">
	        		<div>AnyWorks PRM 5 관련문의 : 02-890-7261</div>
	            	<div class="mt25">Copyrightⓒ2012 NuriInfo co.,LTD. ALL rights reserved.</div>
	        	</div>
	  		</div>
		</div>
	</div> 
</body>
</html>