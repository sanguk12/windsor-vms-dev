<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>${configure.viewDefaultTitle}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../scripts.jsp" %>
		<script type="text/javascript">
			
			var menuTreeStatus = "OPEN";
			
	        function reSizeFrame() {
	        	if(menuTreeStatus != "CLOSE"){
		            closeFrame();
	            } else {
	                openFrame();
	            }
	        }
	        
	        function closeFrame() {
	        	menuTreeStatus = "CLOSE";
	            $("#_menuTree1").hide();
	            $("#_menuTree2").hide();
// 	            $("#sideMenuBtn").css("left", "0px");
	            $("#hideMenuBtn").hide();
	            $("#showMenuBtn").show();
	        }

	        function openFrame() {
	        	menuTreeStatus = "OPEN";
	            $("#_menuTree1").show();
	            $("#_menuTree2").show();
// 	            $("#sideMenuBtn").css("left", "217px");
	            $("#hideMenuBtn").show();
	            $("#showMenuBtn").hide();
	        }

	        function menuTreeToggle() {
		        if(parent.getMenuTreeStatus() == "OPEN"){
	                closeFrame();
		        }   	
	        }
	        
	        function initMenuTreeToggle() {
		        if(parent.getMenuTreeStatus() == "OPEN"){
		        	$("#toggle").attr("src","${contextPath}${params.themeURL}/images/btn/side01_open.gif");
		        }
		        else {
		        	$("#toggle").attr("src","${contextPath}${params.themeURL}/images/btn/side01.gif");
		        }   	
	        }

	        function setMenuTreeToggle() {
		        if(parent.getMenuTreeStatus() == "OPEN"){
	                parent.setMenuTreeStatus('CLOSE');
	                $("#toggle").attr("src","${contextPath}${params.themeURL}/images/btn/side01.gif");

	                setCookie("NURIAF_MENUSTATUS", "CLOSE", 365);
		        }
		        else {
		        	parent.setMenuTreeStatus('OPEN');
	                $("#toggle").attr("src","${contextPath}${params.themeURL}/images/btn/side01_open.gif");
	                setCookie("NURIAF_MENUSTATUS", "OPEN", 365);
		        }   	
	        }
		    
		    function setCookie( name, value, expiredays ) { 
	    		var todayDate = new Date(); 
	    		todayDate.setDate( todayDate.getDate() + expiredays );
	    		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"; 
			}
		</script>
	</head>

    <body ${bodyConfig}>
    	<form id="form" method="post">
		    <table width="100%" height="100%" style="border-collapse:collapse; padding:0 23px 0 0;">
			    <tr>
			        <td id="_menuTree1" height="30" style="width:215px; height:30px; border-top:2px solid #5f7897; border-right:1px solid #5f7897;">
			            <table border="0" cellpadding="0" cellspacing="0" style="width:215px; height:30px;">
							<tr>
								<td class="side_tit_n" id="subMenuTitle" style="width:185px; padding:0px;"></td>
								<!-- 
								<td class="side_tit_n" style="width:30px; text-align:left;padding:0 5px 0 0;">
									<a href="#" onclick="setMenuTreeToggle();"><img id="toggle" src="${contextPath}${params.themeURL}/images/btn/side01.gif" ></a>
								</td>
								 -->
							</tr>
						</table>
			        </td>
			        <td width="*" rowspan="2">
			            <iframe id="_subworkspace" name="_subworkspace" style="margin:0px; overflow:auto; padding:0px; height:100%; width:100%;" frameborder='0' scrolling='auto'></iframe>
			        </td>
			    </tr>
			    <tr>
			    	<td id="_menuTree2" height="*" style="border-right:1px solid #5f7897;">
			    		<iframe id="_menuworkspace" name="_menuworkspace" style="margin:0px; overflow:auto; padding:0px; height:100%; width:215px;" frameborder='0' scrolling='auto' src="${contextPath}/service/menuConstruct/searchMenuTree/?mnuGrpID=${mnuGrpID}&openProgram=<c:if test="${!empty openProgram}">Y</c:if>&menuCloseYN=N"></iframe>
			    	</td>
			    </tr>
		    </table>
	    </form>
    </body>	
</html>


<script type="text/javascript">
	$(document).ready(function() {
		window.onload = function() {
			initMenuTreeToggle();
			openFrame();
			
			
			if("${params.displayMnuTp}" == "200"){
				$("#_menuTree1").remove();
            	$("#_menuTree2").remove();
	            $("#hideMenuBtn").remove();
	            $("#showMenuBtn").remove();
				//closeFrame();
			}
		};
		
		<c:if test="${!empty openProgram}">
			$("#_subworkspace").attr("src","${openProgram}");
		</c:if>
		
	});
</script>

<!--
<div id="sideMenuBtn" style="position:absolute; left:217px; top:33px;">
    <a href="#" onclick="reSizeFrame();"><img src="${contextPath}${params.themeURL}/images/btn/right.png" ></a>
</div>
 
<div id="hideMenuBtn" style="position:absolute; left:239px; top:48px; cursor: pointer;" onclick="javascript:displayMenu('hide');"><img src="/images/saas/left.png" /></div>
<div id="showMenuBtn" style="position:absolute; left:0px; top:48px; display:none; cursor: pointer;" onclick="javascript:displayMenu('show');"><img src="/images/saas/right.png" /></div>
-->
<div id="hideMenuBtn" style="position:absolute; left:205px; top:33px;">
    <a href="#" onclick="reSizeFrame();"><img src="${contextPath}${params.themeURL}/images/btn/left.png" ></a>
</div>
<div id="showMenuBtn" style="position:absolute; left:0px; top:33px; display:none;">
    <a href="#" onclick="reSizeFrame();"><img src="${contextPath}${params.themeURL}/images/btn/right.png" ></a>
</div>