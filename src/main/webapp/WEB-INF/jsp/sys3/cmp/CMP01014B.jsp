<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../scripts.jsp" %>
        
        <!-- Mocha - START -->
        <link rel="stylesheet" href="/scripts/mocha/css/content.css" type="text/css" />
        <link rel="stylesheet" href="/scripts/mocha/css/ui.css" type="text/css" />
        
        <script type="text/javascript" src="/scripts/mocha/scripts/mootools-1.2-core.js"></script>
        <script type="text/javascript" src="/scripts/mocha/scripts/mootools-1.2-more.js"></script> 
        
        <script type="text/javascript" src="/scripts/mocha/scripts/excanvas-compressed.js"></script>
        <script type="text/javascript" src="/scripts/mocha/scripts/mocha.js" charset="utf-8"></script>
        <!-- Mocha - END -->
        
		<script type="text/javascript">
            
            var myWidget_${params.widgetID} = function(){
                new MochaUI.Window({
		            id: "${params.widgetID}",
		            title: "${params.titleScript}",
		            loadMethod: '${params.loadMethod}',
		            contentURL: '${contextPath}/service/widget/getContent/?widgetID=${params.widgetID}',
		            width: ${params.width},
		            height: ${params.height},
		            y: ${params.y},
		            x: ${params.x}
		          })
            };
            

            window.addEvent('domready', function(){
                myWidget_${params.widgetID}();
            });
            
        </script>
        
	</head>

	<body>
    	
    </body>
</html>
