<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		
		<%//@include file="/WEB-INF/jsp/sys/scripts.jsp" %>
		
		<!-- ActiveWidgets Module - START -->

		<link rel="stylesheet" type="text/css" href="${params.themeURL}/styles/aw.css" ></link>
		<script type="text/javascript" src="${contextPath}/scripts/aw/runtime/lib/aw.js" ></script>
		<script type="text/javascript" src="${contextPath}/scripts/aw/awConfig.js" ></script>
		
		<!-- ActiveWidgets Module - END -->
		
	</head>

	<body class="yui-skin-sam" ${bodyConfig}>
    	<form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="0">
			            <!-- Standard Parameter - START -->
			            <input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
			            <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
			            <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
			            <input type="hidden" id="method" name="method">
			            <!-- Standard Information - END -->
			        </td>
			    </tr>
			    <tr>
			    	<td id="contentBody" class="td-cond" height="*" valign="top">
			    		<div align="center">
			    		<br><br><br><br><br><br>
						<font size="7">AnyWorks/PRM 4</font>
						<br><br><br><br><br><br><br><br><br>
						<br><br><br><br><br>
						<font size="4">NuriInfos Co., Ltd.</font>
						</div>
					</td>
                </tr>
                <tr>
                    <td height="5">
			            <!-- Action Parameter - START -->
			            <input type="hidden" id="companyID" name="companyID" value="${params.companyID}">
						<input type="hidden" id="helpContentsID" name="helpContentsID">
			            <!-- Action Parameter - END -->
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>


<script type="text/javascript">

    /****************************************
    * Variable
    ****************************************/

	/****************************************
	* Function
	****************************************/
	function view(helpContentsID) {
		document.getElementById("helpContentsID").value = helpContentsID;
		Search();
	}
	
 	/****************************************
	* Button Action
	****************************************/
	function Search() {
		var table = new AW.XML.Table;	  
	  	table.setURL("simpleAction.do");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("actionKey","search");	// search, save (add, remove, modify, update)
	  	table.setParameter("resultType","XML");		// List, Map, XML
	  	table.setParameter("queryKey","system.helpContentsList.select");
	  	table.setParameter("helpContentsID", document.getElementById("helpContentsID").value);
	   	table.request();
	     	
	    var rowCount = table.getCount();
	    if (rowCount > 0) {
	    	document.getElementById("contentBody").innerHTML = table.getData(6,0);
	   	}
		else {
			alert('no contents');
		}
	}
</script>

<script type="text/javascript">
<!--
	<c:if test="${!empty params.initAction}">
		${params.initAction}();
	</c:if>
//-->
</script>	
