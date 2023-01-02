<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="taglib.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="scripts.jsp" %>
		
		<!-- Mocha - START -->
		<link rel="stylesheet" href="${contextPath}/scripts/mocha/css/content.css" type="text/css" />
        <link rel="stylesheet" href="${contextPath}/scripts/mocha/css/ui.css" type="text/css" />
        
        <script type="text/javascript" src="${contextPath}/scripts/mocha/scripts/mootools-1.2-core.js"></script>
        <script type="text/javascript" src="${contextPath}/scripts/mocha/scripts/mootools-1.2-more.js"></script> 
        
        <script type="text/javascript" src="${contextPath}/scripts/mocha/scripts/excanvas-compressed.js"></script>
        <script type="text/javascript" src="${contextPath}/scripts/mocha/scripts/mocha.js" charset="utf-8"></script>
        <!-- Mocha - END -->
        
        <script type="text/javascript">
        
        	top.menuBarTabStyleChange();

            <c:forEach items="${widgetList}" var="widget" varStatus="status">
                var myWidget_${widget.widgetID} = function(){
                    new MochaUI.Window({
                      id:"${widget.widgetID}",
	                  title:"${widget.titleScriptLang}",
	                  loadMethod:'${widget.loadMethod}',
	                  contentURL:'${contextPath}/service/widget/getContent/?widgetID=${widget.widgetID}&userID=${params.userID}',
	                  width: ${widget.width},
	                  height: ${widget.height},
	                  y:${widget.y},
	                  x:${widget.x},
	                  onResize: function(){},
	                  onBlur:function(){}
	                  //,onCloseComplete: function(){closeWidget('${widget.widgetID}');}
                    })
                };
            </c:forEach>


            window.addEvent('domready', function(){
                <c:forEach items="${widgetList}" var="widget" varStatus="status">
                    myWidget_${widget.widgetID}();
                </c:forEach>
		    });
		    
		    
// 		    function closeWidget(widgetID) {
// 		        var req = new AW.HTTP.Request;
// 		        req.setURL("${contextPath}/service/widget/removeUserWidget");
// 		        req.setAsync(true);
// 		        req.setRequestMethod("POST");
// 		        req.setParameter("widgetID", widgetID);
// 		        req.request();
// 		    }
		    
	    </script>

	</head>
	
    <body class="yui-skin-sam" ${bodyConfig}>
    </body>
</html>