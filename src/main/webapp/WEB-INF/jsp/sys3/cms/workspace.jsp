<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@ include file="../taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>
        	<c:choose>
		        <c:when test="${params.displayMnuTp == '300'}">
                          <fmt:message key="application.title.eslt" />
                   </c:when>
                   <c:otherwise>
                          <fmt:message key="application.title" />
                   </c:otherwise>
		    </c:choose>
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@ include file="../scripts.jsp"%>
		
		<script type="text/javascript">
			$(document).ready(function() {
				window.onload = function() {
					if("${message}" != "") alert("${message}");
					
					if("${params.initPasswdYN}"=="Y") {
						YAHOO.example.container.panel = new YAHOO.widget.Panel("openChangePasswd", { width:"400px", autofillheight:"body", visible:false, draggable:false, close:false, modal:true, zIndex:1000, x:10, y:10} );
						var url = "${contextPath}/service/simpleCommand/?mnuGrpID=ETC&pgmID=CMP01020&viewID=CMP01020A&workspaceOpen=Y";
						var body =
					        "<table width='350'>"+
					        "    <tr>"+
					        "        <td align='center'>"+
					        "            <iframe id='list' name='list' style='width:350px; height:250px; background-color:#f2f2f2;' frameborder='0' scrolling='auto' "+
					        "                    src='"+url+"'></iframe>"+
					        "       </td>"+
					        "   </tr>"+
					        "</table>";
					    YAHOO.example.container.panel.setHeader("비밀번호변경");
					    YAHOO.example.container.panel.setBody(body);
					    YAHOO.example.container.panel.render(document.body);
						YAHOO.example.container.panel.show();
					}
					
				};
			});
		
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
		
			var menuTreeToggle="CLOSE";
			try {
				menuTreeToggle = getCookie("NURIAF_MENUSTATUS");
	     	}
	     	catch (e) {
	     		menuTreeToggle = "CLOSE";
	     	}
			function getMenuTreeStatus(){return menuTreeToggle;}
			function setMenuTreeStatus(value){menuTreeToggle=value;}
	        
		</script>
    </head>
    <c:choose>
        <c:when test="${params.companyID == '000001'}">
    		<body style="overflow:hidden" class="top_bg yui-skin-sam"  ${bodyConfig}>
	        	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            <tr>
		                <td height="30">
					        <%@ include file="../cms/menubar.jsp" %>
					    </td>
					</tr>
					<tr>
						<td height="*">
							<iframe id="_workspace" name="_workspace" style="width:100%; height:100%;" frameborder='0' scrolling='no' src="${contextPath}/${configure.mainPageViewUrl}/?mnuConstructID=${params.mnuConstructID}"></iframe>
							<!-- 
						    <c:choose>
						        <c:when test="${configure.menuStyle == 'WATERFALL'}">
		                            <iframe id="_workspace" name="_workspace" style="width:100%; height:100%;" frameborder='0' scrolling='auto' src="${contextPath}/${configure.mainPageViewUrl}/?mnuConstructID=${params.mnuConstructID}"></iframe>
			                    </c:when>
			                    <c:otherwise>
		                            <iframe id="_workspace" name="_workspace" style="width:100%; height:100%;" frameborder='0' scrolling='no' src="${contextPath}/${configure.mainPageViewUrl}/?mnuConstructID=${params.mnuConstructID}"></iframe>
			                    </c:otherwise>
						    </c:choose>
					     	-->
						</td>
		            </tr>
		        </table>
	        </body>
        </c:when>
        <c:when test="${params.companyID == '000002'}">
        	<body style="overflow:hidden" class="yui-skin-sam"  ${bodyConfig}>
	        	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            <tr>
		                <td height="1">
					        <%@ include file="../cms/menubar.jsp" %>
					    </td>
					</tr>
					<tr>
						<td height="*">
							<iframe id="_workspace" name="_workspace" style="width:100%; height:100%;" frameborder='0' scrolling='auto' src="${contextPath}/${configure.mainPageViewUrl}/?mnuConstructID=${params.mnuConstructID}"></iframe>
						</td>
		            </tr>
		        </table>
	        </body>
        </c:when>
    </c:choose>
</html>

<script type="text/javascript">
	function urlfunction_workspace(url) {
		var result;
		result = urlFunction(url);
	}
</script>