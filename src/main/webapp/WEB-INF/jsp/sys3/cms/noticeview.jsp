<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.NOTICETITLE}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <%@include file="../scripts.jsp" %>
        <style type="text/css">
			<!--
			body {
				margin-left: 0px;
				margin-top: 0px;
				margin-right: 0px;
				margin-bottom: 0px;
			}
			.style1 {
				font-size: 11px;
				color: #FFFFFF;
			}
			-->
		</style>
		
		<script type="text/javascript">
			function notice_setCookie(name, value, expiredays ) { 
	            var todayDate = new Date(); 
	            todayDate.setDate( todayDate.getDate() + expiredays ); 
	            document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
			} 
	
			function notice_closeWin(){ 
		        if ($("#checkClose").is(":checked")) {
		        	notice_setCookie("${params.NOTICEID}", "done" , 1);  // 1=하루동안 공지창 열지 않음
		        }
				self.close(); 
			} 
		</script>
	</head>
    <body>
	    <table width="${params.WIDTH}" cellspacing="0" cellpadding="0">
		    <tr>
		        <td>
<!--		        	<img src="http://${params.wasUrl}/upload/${params.FILENAME}" width="${params.WIDTH}" height="${params.HEIGHT}" />-->
		        	<img src="doclink.do?method=downloadFile&docLinkID=${params.DOCLINKID}" width="${params.WIDTH}" height="${params.HEIGHT}" />
		        </td>
		    </tr>
		</table>
		<table width="${params.WIDTH}" cellspacing="0" cellpadding="0">
		    <tr>
		        <td height="20" bgcolor="#48ae92" align="center">
		        	<span style="font-weight:bold;">
		        		오늘은 이 창 닫기 <input type="checkbox" id="checkClose" class="checkbox" onclick="notice_closeWin()"/>
		        	</span>
		        </td>
		    </tr>
		</table>
    </body>
</html>