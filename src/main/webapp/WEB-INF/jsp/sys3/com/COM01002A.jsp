<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>
	<style type="text/css">
		a:link,a:visited,a:active,a:hover {color:#666;text-decoration:none;}
	</style>
</head>

<body class="yui-skin-sam">
<form name="form" method="post">
<div id="wrapDiv" class="pd"><div id="formDiv">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
        	<td height="1">
			    <%@include file="../cms/standardParam.jsp" %>
			    <input type="hidden" id="initAction" name="initAction">
			    <%@include file="../cms/functionbar.jsp" %>
	   		</td>
		</tr>
		<tr>
			<td height="*">
				<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                	<tr>
                 		<td class="tb-border">
					     	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="table-layout:fixed;">
			                	<tr>
			                    	<td align="center" height="*" style="border:#e1dcbe solid 1px;">
			                        	 <iframe id="tree" name="tree" style="width:100%; height:100%;" frameborder="0" scrolling="auto" src="${contextPath}/sys3/com/COM01002B.page"></iframe>
			                    	</td>
			                	</tr>
			                	<tr>
			                    	<td align="center" height="25" valign="middle">
			                        	<p><a href='javascript: tree.d.openAll();'><img src="${contextPath}/images/menu/all_open.png"> <fmt:message key="COM01002A.expand"/></a> | <a href='javascript: tree.d.closeAll();'><img src="${contextPath}/images/menu/all_close.png"> <fmt:message key="COM01002A.collapse"/></a></p>
			                    	</td>
			                	</tr>
			            	</table>
			        	</td>
			    	</tr>
			 	</table>            
        	</td>
    	</tr>	
	</table>
</div></div>          
</form>
</body>
</html>

<script type="text/javascript">
    <!--

    /****************************************
    * Function
    ****************************************/
    // Only ModalDialog
    <c:if test="${params.modalDialog == 'Y'}"> 
        var opener = window.dialogArguments;
    </c:if>
            
    $(document).ready(function() {
		
		window.onload = function() {
		};
		
		${initScript}
		
	});
	
    /****************************************
    * Button Action
    ****************************************/
    function Confirm() {
        var publicID = new Array();
        var publicClassCD = new Array();
        var publicName = new Array();
        var j=0;

        var checkYN = top.tree.document.forms[0].checkYN;
        

        for (var i=0; i < checkYN.length; i++){
            
            if (checkYN[i].checked) {
                var data = new Array();
                data = checkYN[i].value.split(';');
                publicClassCD[j] = data[0];
                publicID[j] = data[1];
                publicName[j] = data[2];
                j++;
            }
        }
        
        <c:if test="${!empty params.finalAction}"> 
            opener.${params.finalAction}(publicID, publicClassCD, publicName);
        </c:if>
        window.close();
    }

    function Close() {
        window.close();
    }
</script>