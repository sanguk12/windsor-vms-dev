<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><fmt:message key="application.title" /></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>
	<link href="${contextPath}/css/treeview/dtree.css" rel="StyleSheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/scripts/treeview/dtree.js"></script>
</head>

<body onload="fnMessage('${params.MSG}');" class="yui-skin-sam" ${bodyConfig}>
<form name="form" method="post">
<div id="wrapDiv"><div id="formDiv">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
        	<td height="1">
				<%@include file="../cms/standardParam.jsp" %>
		        <%@include file="../cms/functionbar.jsp" %>
       		</td>
       	</tr>
       	<tr>
            <td valign="top">
            	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                	<tr>
	                	<td width="200" height="*" class="tree-border" valign="top">
	                    	<iframe id="_tree" name="_tree" width="100%" height="100%" frameborder='0' scrolling='auto' 
				        		src="${contextPath}/service/menuConstruct/init/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01007C"></iframe>
						</td>
						<td width="*" height="*" rowspan="2" valign="top">
							<iframe id="_menuconstruct" name="_menuconstruct" width="100%" height="100%" frameborder="0" scrolling="no" src="${contextPath}/service/menuConstruct/listMenuConstruct/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01007B"></iframe>
						</td>		
					</tr>
					<tr>
						<td height="1" style="text-align:center;">
							<script type="text/javascript">
	                           var reload = new AW.UI.Button;
	                           reload.setControlText("<fmt:message key="CMP01007A.msg1"/>");
	                           document.write(reload);
	                            
	                           reload.onControlClicked = function(event) {
	                        	   document.location.reload();
	                           };
	                       </script>
                       </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>${appletDiv}</div> 
</form>
</body>
</html>

<script type="text/javascript">
    
	/****************************************
	* Function
	****************************************/
	$(function() {
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {
		
		window.onload = function() {
		
		};
	
		${initScript}
	
	});

    /****************************************
    * Button Action
    ****************************************/
    
    function Insert()
    {
        $("#_menuconstruct")[0].contentWindow.Insert();
        //_menuconstruct.Insert();
    }
    
    function Save()
    {
         $("#_menuconstruct")[0].contentWindow.Save();
        //_menuconstruct.Save();
    }
    
    function Delete()
    {
    	$("#_menuconstruct")[0].contentWindow.Delete();
        //_menuconstruct.Delete();
    }
    
    
</script>