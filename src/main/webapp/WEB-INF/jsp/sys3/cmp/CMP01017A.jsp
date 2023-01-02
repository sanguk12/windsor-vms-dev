<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
        <%@include file="../scripts.jsp" %>
    </head>

    <body class="yui-skin-sam">
        <form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1" colspan="2">	
						<!-- Standard Parameter - START -->
						<input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
			            <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
			            <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
			            <input type="hidden" id="method" name="method">
						<!-- Standard Information - END -->
				
						<!-- Function Set - Button -->
						<%@include file="../cms/functionbar.jsp" %>
                    </td>
                </tr>
                <tr>
                    <td class="pd tb-border" valign="top">
                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
			                <tr>
							    <td width="250" height="*" class="tree-border">
									<iframe id="_tree" name="_tree" width="100%" height="100%" frameborder='0' scrolling='auto' 
									        src="helpcontents.do?method=initHelpContentsList&mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01016C&phelpContentsID=&useYN=Y&handler=javascript:parent.Search"></iframe>
								</td>
			                    <td width="*" class="tree-border-r">
									<iframe id="_helpContents" name="_helpContents" width="100%" height="100%" frameborder='0' scrolling='auto' 
									        src="simpleCommand.do?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01017B"></iframe>                    
			                    </td>                    
						    </tr>
						</table>
					</td>
				</tr>			    
                <tr>
                    <td height="5" colspan="2">
                    </td>
                </tr>
			</table>
		</form>
	</body>
</html>

<script type="text/javascript">

	function Search(helpContentsID){
		document.getElementById("_helpContents").contentWindow.document.getElementById("helpContentsID").value = helpContentsID;
        document.getElementById("_helpContents").contentWindow.Search();
	}
	
	function Pdf(){
        alert('준비중...');
	}
	
	function Close(){
        window.close();
	}
	
	
</script>

<script type="text/javascript">
<!--
	<c:if test="${!empty params.initAction}">
		${params.initAction}();
	</c:if>
//-->
</script>	
