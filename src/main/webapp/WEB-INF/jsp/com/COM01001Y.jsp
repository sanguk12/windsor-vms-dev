<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
    </head>

    <body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1"> 		
						<!-- Standard Parameter - START -->
						<input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
						<input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
						<input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
						<input type="hidden" id="method" name="method">
						<!-- Standard Information - END -->
						
						<input type="hidden" id="doclinkid" name="doclinkid" value="${params.doclinkid}">
						<!-- <input type="hidden" id="fileURL" name="fileURL" />
	                   	<input type="hidden" id="UUID" name="UUID" />
	                   	<input type="hidden" id="fileName" name="fileName" /> -->
						
						<%@include file="../sys3/cms/functionbar.jsp" %>
                    </td>
                </tr>
                <tr>
					<td height="*">             
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
				                            <tr>
												<td>
													<div id="OCRImg"></div>
				                                </td>
				                            </tr>
			                        </table>
                    			</td>
                   			</tr>
						</table>
                    </td>
                </tr>
                <tr>
                    <td height="5">
						<!-- Action Parameter - START -->
						<input type="hidden" name="initAction">
						<!-- Action Parameter - END -->
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>


<script type="text/javascript">
	
	// Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {

		window.onload = function() {
			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
		};

		${initScript}

		Search();
		
	});
	
	
	/****************************************
	* Button Action
	****************************************/
	
	function Search() {
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/YYS01001A02S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("companyID","000001");
        table.setParameter("doclinkid", $("#doclinkid").val());
        
        table.request();
        var content="";
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
        	
			if("<spring:eval expression="@system['docLink.fileServer.using']"/>" == "Y") {
				//content = "<img src='"+"<spring:eval expression="@system['docLink.fileServer.host']"/>"+table.getData(1,0)+table.getData(3,0)+"' width='72' height='72' alt=''\/>";
    		
				//var aaa= "<spring:eval expression="@system['docLink.fileServer.host']"/>";
				content = "<img src='<spring:eval expression="@system['docLink.fileServer.host']"/>"+table.getData(1,0)+table.getData(3,0)+"' width='796' height='450' alt=''\/>";
			
			}
    		else {
    			//content = "<img src='${contextPath}/upload/"++table.getData(1,0)+table.getData(3,0)++"' width='72' height='72' alt=''\/><\/a><\/li>";
    			content = "<img src='${contextPath}/upload/"+table.getData(1,0)+table.getData(3,0)+"' width='796' height='450' alt=''\/>"
    		}
        	
        }
        $("#OCRImg").html(content);
	}
	
	function Close() {
		window.close();
	}
	
</script>