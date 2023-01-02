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
						d.config.target="_menuconstruct";
						d.config.folderLinks = true;
						d.config.closeSameLevel=false;
						d.config.useCookies=false;
						d.add("ROOT", -1, "${params.viewName}", "${contextPath}/service/menuConstruct/listMenuConstruct/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01007B", "${params.viewName}");
						<c:forEach items="${menuConstructTreeView}" var="item" varStatus="status">
							<c:choose>
								<c:when test="${item.pcode eq 'ROOT'}">
									d.add("${item.code}", "${item.pcode}", "${item.name}", "${contextPath}/service/menuConstruct/listMenuConstructGroup/?mnuConstructID=${item.code}&mnuConstructName=${item.name}&pmnuGrpID=ROOT&pmnuGrpName=ROOT&mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01007E", "${item.name}");
								</c:when>
								<c:otherwise>
									d.add("${item.code}", "${item.pcode}", "${item.name}", "${contextPath}/service/menuConstruct/listMenuConstructGroup/?mnuConstructID=${item.mnuConstructID}&mnuConstructName=${item.mnuConstructName}&pmnuGrpID=${item.mnuGrpID}&pmnuGrpName=${item.name}&mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01007E", "${item.name}");
								</c:otherwise>
							</c:choose>
						</c:forEach>
						document.write(d);
					//-->
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