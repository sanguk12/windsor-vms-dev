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
	<body>
		<form name="form" method="post">
            <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="left_treetd" valign="top">
						<div class="dtree">
							<script type="text/javascript">
							<!--
								//id, pid, name, url, title, target, icon, iconOPne, open,
								d = new dTree('d');
                                d.config.folderLinks = true;
                                d.config.closeSameLevel=false;
                                d.config.useCookies=true;
                                d.add("ROOT", -1, "${params.viewName}", "javascript:parent.SetValue('ROOT','ROOT');parent.Search();", "${params.viewName}");
                                <c:forEach items="${codeTreeView}" var="item" varStatus="status">
                                    d.add("${item.comCode}", "${item.codeDiv}", "${item.codeName}", "javascript:parent.SetValue('${item.comCode}','${item.codeName}');parent.Search();", "${item.codeName}");
                                </c:forEach>        
                                document.write(d);
                                d.openAll();
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