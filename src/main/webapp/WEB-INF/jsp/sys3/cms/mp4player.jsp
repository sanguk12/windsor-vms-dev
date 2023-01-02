<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<!DOCTYPE html>

<html lang="ko">

	<head>
		<meta charset="utf-8">
	    
	    <script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.8.2.min.js"></script>
	    <script src="${contextPath}/scripts/videoplayer/js/mediaelement-and-player.min.js""></script>
	    <link rel="stylesheet" href="${contextPath}/scripts/videoplayer/css/style.css"></link>
	    
	     <style type="text/css">
			html, body { margin: 0;	padding: 0; }
		</style>
	</head>
	
	<body>
		<video 
			width="<%=request.getParameter("width")!=null?request.getParameter("width"):"600"%>" 
			height="<%=request.getParameter("height")!=null?request.getParameter("height"):"320"%>" 
			type="video/mp4" src="<%=request.getParameter("mp4URL")%>" 
			poster="<%=request.getParameter("posterURL")%>" 
		/>
	</body>
</html>

<script type="text/javascript">

	/****************************************
	 * Variable
	 ****************************************/

    /****************************************
    * Function
    ****************************************/
     
	$(document).ready(function() {
		
        window.onload = function() {
        	
        	$("video").mediaelementplayer({
    			alwaysShowControls: false
    			, videoVolume: "horizontal"
    			, features: ["playpause","progress","volume"]		//features: ["playpause","progress","volume","fullscreen"]
    		});
        	
        }
        
	});
	
</script>