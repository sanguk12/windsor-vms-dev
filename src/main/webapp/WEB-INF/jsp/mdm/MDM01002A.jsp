<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title><fmt:message key="application.title" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
		<link href="${contextPath}/css/treeview/dtree.css" rel="StyleSheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/treeview/dtree.js"></script>
	</head>
	
	<body onload="fnMessage('${params.MSG}');" class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
		        	<td height="1">
						<%@include file="../sys3/cms/standardParam.jsp" %>
				        <%@include file="../sys3/cms/functionbar.jsp" %>
		       		</td>
		       	</tr>
		       	<tr>
		            <td valign="top">
		            	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
		                	<tr>
			                	<td width="200" height="*" class="tree-border" valign="top">
			                    	<iframe id="_tree" name="_tree" width="100%" height="100%" frameborder='0' scrolling='auto' 
						        		src="${contextPath}/service/mdm01/listTree/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM01002C"></iframe>
								</td>
								<td width="*" height="*" rowspan="2" valign="top">
									<iframe id="_appr" name="_appr" width="100%" height="100%" frameborder="0" scrolling="no" src="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM01002B"></iframe>
								</td>		
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<script type="text/javascript">
    
	/****************************************
	* Function
	****************************************/
	$(function() {
	});
	
	$(document).ready(function() {
		
		window.onload = function() {
		
		};
	
		${initScript}
	
	});

    /****************************************
    * Button Action
    ****************************************/
    
    function New() {
        $("#_appr")[0].contentWindow.New();
    }
    
    function Save() {
         $("#_appr")[0].contentWindow.Save();
    }
    
    function Delete() {
    	$("#_appr")[0].contentWindow.Delete();
    }
    
</script>