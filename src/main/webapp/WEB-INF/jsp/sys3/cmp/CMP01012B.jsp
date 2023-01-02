<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@include file="../scripts.jsp" %>
		<link href="${contextPath}/css/treeview/dtree.css" rel="StyleSheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/treeview/dtree.js"></script>
		<style type="text/css">
		<!-- body {margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-bottom: 0px;}	//-->
		</style>
	</head>
	<body ${bodyConfig}>
		<form name="form" method="post">
            <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="left_treetd" valign="top">
						<div class="dtree">
							<script type="text/javascript">
							<!--
								//id, pid, name, url, title, target, icon, iconOPne, open,
								d = new dTree('d');
								d.config.target="${params.target}";		
								d.config.folderLinks = true;
								d.config.closeSameLevel=false;
								d.config.useCookies=false;
								
								if("${params.classCD }"!="") {
									d.add("ROOT", -1, "<fmt:message key="CMP01012A.class" />", "${params.handler}('ROOT','${params.classCD }','<fmt:message key="CMP01012A.class" />')");
									
								} else {
									d.add("ROOT", -1, "<fmt:message key="CMP01012A.class" />", "${params.handler}('ROOT','ROOT','<fmt:message key="CMP01012A.class" />')");
								}
								<c:forEach items="${classChart}" var="item" varStatus="status">
									d.add("${item.classID}", "${item.pclassID}", "${item.className}", "${params.handler}('${item.classID}','${item.classCD}','${item.className}')");
								</c:forEach>		
								
								document.write(d);
								//d.openAll();
							//-->
							</script>
							<p><a href="javascript: d.openAll();">Expand all</a> | <a href="javascript: d.closeAll();">Collapse all</a></p>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>