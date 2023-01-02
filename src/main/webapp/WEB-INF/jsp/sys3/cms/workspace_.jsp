<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@ include file="../taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <title><fmt:message key="application.title" /></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=divice-width, height=device-height" />
		<%@ include file="../scripts.jsp"%>
		<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery.debouncedresize.js"></script>
	 	
		<script type="text/javascript">
			
			$(document).ready(function () {
        	
	        	var viewportwidth;
		   		var viewportheight;
		   		
		   		/*
			    * Browser Check
			    */
			    var BrowserDetect = {
			    		init: function () {
			    			this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
			    			this.version = this.searchVersion(navigator.userAgent)
			    				|| this.searchVersion(navigator.appVersion)
			    				|| "an unknown version";
			    			this.OS = this.searchString(this.dataOS) || "an unknown OS";
			    		},
			    		searchString: function (data) {
			    			for (var i=0;i<data.length;i++)	{
			    				var dataString = data[i].string;
			    				var dataProp = data[i].prop;
			    				this.versionSearchString = data[i].versionSearch || data[i].identity;
			    				if (dataString) {
			    					if (dataString.indexOf(data[i].subString) != -1)
			    						return data[i].identity;
			    				}
			    				else if (dataProp)
			    					return data[i].identity;
			    			}
			    		},
			    		searchVersion: function (dataString) {
			    			var index = dataString.indexOf(this.versionSearchString);
			    			if (index == -1) return;
			    			return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
			    		},
			    		dataBrowser: [
			    			{
			    				string: navigator.userAgent,
			    				subString: "Chrome",
			    				identity: "Chrome"
			    			},
			    			{ 	string: navigator.userAgent,
			    				subString: "OmniWeb",
			    				versionSearch: "OmniWeb/",
			    				identity: "OmniWeb"
			    			},
			    			{
			    				string: navigator.vendor,
			    				subString: "Apple",
			    				identity: "Safari",
			    				versionSearch: "Version"
			    			},
			    			{
			    				prop: window.opera,
			    				identity: "Opera"
			    			},
			    			{
			    				string: navigator.vendor,
			    				subString: "iCab",
			    				identity: "iCab"
			    			},
			    			{
			    				string: navigator.vendor,
			    				subString: "KDE",
			    				identity: "Konqueror"
			    			},
			    			{
			    				string: navigator.userAgent,
			    				subString: "Firefox",
			    				identity: "Firefox"
			    			},
			    			{
			    				string: navigator.vendor,
			    				subString: "Camino",
			    				identity: "Camino"
			    			},
			    			{		// for newer Netscapes (6+)
			    				string: navigator.userAgent,
			    				subString: "Netscape",
			    				identity: "Netscape"
			    			},
			    			{
			    				string: navigator.userAgent,
			    				subString: "MSIE",
			    				identity: "Explorer",
			    				versionSearch: "MSIE"
			    			},
			    			{
			    				string: navigator.userAgent,
			    				subString: "Gecko",
			    				identity: "Mozilla",
			    				versionSearch: "rv"
			    			},
			    			{ 		// for older Netscapes (4-)
			    				string: navigator.userAgent,
			    				subString: "Mozilla",
			    				identity: "Netscape",
			    				versionSearch: "Mozilla"
			    			}
			    		],
			    		dataOS : [
			    			{
			    				string: navigator.platform,
			    				subString: "Win",
			    				identity: "Windows"
			    			},
			    			{
			    				string: navigator.platform,
			    				subString: "Mac",
			    				identity: "Mac"
			    			},
			    			{
			    				   string: navigator.userAgent,
			    				   subString: "iPhone",
			    				   identity: "iPhone/iPad"
			    		    },
			    		    {
			    				   string: navigator.userAgent,
			    				   subString: "iPad",
			    				   identity: "iPhone/iPad"
			    		    },
			    			{
			    				string: navigator.platform,
			    				subString: "Linux",
			    				identity: "Linux"
			    			}
			    		]

			    	};
			    
			    BrowserDetect.init();
			    
		   		
		   		// the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
		   		  
		   		if (typeof window.innerWidth != 'undefined') {
		   			viewportwidth = window.innerWidth;
		   		    viewportheight = window.innerHeight;
		   		    
		   		    if (BrowserDetect.OS == "iPhone/iPad" || BrowserDetect.browser == "Chrome") {
		   		    	$("#app_menubar").css("margin-top", "7px");
					}
					else {
						$("#app_menubar").css("margin-top", "8px");
					}
		   		}
		   		  
		   		// IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
		   		 
		   		else if (typeof document.documentElement != 'undefined'
		   			&& typeof document.documentElement.clientWidth !=
		   		    'undefined' && document.documentElement.clientWidth != 0)
		   		{
		   			viewportwidth = document.documentElement.clientWidth;
		   		    viewportheight = document.documentElement.clientHeight;
		   		    
		   		 	$("#app_menubar").css("margin-top", "10px");
		   		}
		   		  
		   		// older versions of IE
		   		  
		   		else
		   		{
		   			viewportwidth = document.getElementsByTagName('body')[0].clientWidth;
		   		    viewportheight = document.getElementsByTagName('body')[0].clientHeight;
		   		    
		   		 	$("#app_menubar").css("margin-top", "10px");
		   		}
		   		
		   		$("#app_workspace").css("height", viewportheight-120+"px");
		   		
		   		
		   		// Windows Resize            
	            $(window).on("debouncedresize", function(event) {
	            	initWorkspace();
	            });
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
			
			function initWorkspace() {
	    		
	    		var viewportwidth;
		   		var viewportheight;
		   		  
		   		// the more standards compliant browsers (mozilla/netscape/opera/IE7) use window.innerWidth and window.innerHeight
		   		  
		   		if (typeof window.innerWidth != 'undefined') {
		   			viewportwidth = window.innerWidth;
		   		    viewportheight = window.innerHeight;
		   		}
		   		  
		   		// IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
		   		 
		   		else if (typeof document.documentElement != 'undefined'
		   			&& typeof document.documentElement.clientWidth !=
		   		    'undefined' && document.documentElement.clientWidth != 0)
		   		{
		   			viewportwidth = document.documentElement.clientWidth;
		   		    viewportheight = document.documentElement.clientHeight;
		   		}
		   		  
		   		// older versions of IE
		   		  
		   		else
		   		{
		   			viewportwidth = document.getElementsByTagName('body')[0].clientWidth;
		   		    viewportheight = document.getElementsByTagName('body')[0].clientHeight;
		   		}
	            
		   		$("#app_workspace").css("height", viewportheight-120+"px");
	    		
	    	}
	        
		</script>
    </head>
    <body style="overflow:hidden" class="top_bg yui-skin-sam"  ${bodyConfig}>
    	<div style="margin-left:auto; margin-right:auto; width:100%; height:100%;">
    		<div style="height:120px;">
		        <%@ include file="../cms/menubar.jsp" %>
			</div>
			<div id="app_workspace" style="height:500px;">
		    <c:choose>
		        <c:when test="${configure.menuStyle == 'WATERFALL'}">
                    <iframe id="_workspace" name="_workspace" style="width:100%; height:100%;" frameborder='0' scrolling='auto' src="${contextPath}/${configure.mainPageViewUrl}/?mnuConstructID=${params.mnuConstructID}"></iframe>
                </c:when>
                <c:otherwise>
                    <iframe id="_workspace" name="_workspace" style="width:100%; height:100%;" frameborder='0' scrolling='no' src="${contextPath}/${configure.mainPageViewUrl}/?mnuConstructID=${params.mnuConstructID}"></iframe>
                </c:otherwise>
		    </c:choose>
        	</div>
        </div>
    </body>
</html>