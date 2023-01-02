<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><fmt:message key="application.title" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../scripts.jsp" %>
		<link href="<c:out value="${contextPath}" />/css/treeview/dtree.css" rel="StyleSheet" type="text/css" />
		<script type="text/javascript" src="<c:out value="${contextPath}" />/scripts/treeview/dtree.js"></script>
		<style type="text/css">
		<!-- body {margin-left: 0px;margin-top: 20px;margin-right: 0px;margin-bottom: 0px;}	//-->
		</style>
	</head>
	<body class="tblContentTdBg01">
		<form name="form" method="post">
			<table width="150" height="100%" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td width="4" height="26"><img src="<c:out value="${contextPath}" />/images/treeview/layout/imgRoot01.gif" width="4" height="26"></td>
					<td width="141" background="<c:out value="${contextPath}" />/images/treeview/layout/imgRoot02.gif" class="txBlue" style="padding:3px 0 0 5px;">${param.viewName}</td>
					<td width="4" ><img src="<c:out value="${contextPath}" />/images/treeview/layout/imgRoot03.gif" width="4" height="26"></td>
				</tr>
				<tr>
					<td background="<c:out value="${contextPath}" />/images/treeview/layout/imgRoot04.gif">&nbsp;</td>
					<td height="100%">
						<fieldset align="left" style="WIDTH:142px; HEIGHT:100%; OVERFLOW: auto; border:1px none #FFFFFF;margin-left: 0px;margin-right: 0px;">
							<div class="dtree">
							<script type="text/javascript">
							<!--
								//id, pid, name, url, title, target, icon, iconOPne, open,
								d = new dTree('d');
								d.config.target="Content";		
								d.config.folderLinks = true;
								d.config.closeSameLevel=false;
								d.config.useCookies=false;
								d.add("ROOT", -1, "${param.viewName}", "${contextPath}/menuconstruct.do?method=listMenuConstruct&mnuGrpID=${param.mnuGrpID}&pgmID=${param.pgmID}&viewID=MenuConstructList", "${param.viewName}");
								<c:forEach items="${menuConstructTreeView}" var="item" varStatus="status">
									<c:choose>
										<c:when test="${item.pcode eq 'ROOT'}">
											d.add("${item.code}", "${item.pcode}", "${item.name}", "${contextPath}/menuconstruct.do?method=initGroup&mnuConstructID=${item.code}&mnuConstructName=${item.name}&pmnuGrpID=ROOT&pmnuGrpName=ROOT&mnuGrpID=${param.mnuGrpID}&pgmID=${param.pgmID}&viewID=MenuConstructGroup", "${item.name}");
										</c:when>
										<c:otherwise>
											d.add("${item.code}", "${item.pcode}", "${item.name}", "${contextPath}/menuconstruct.do?method=initGroup&mnuConstructID=${item.mnuConstructID}&mnuConstructName=${item.mnuConstructName}&pmnuGrpID=${item.code}&pmnuGrpName=${item.name}&mnuGrpID=${param.mnuGrpID}&pgmID=${param.pgmID}&viewID=MenuConstructGroup", "${item.name}");
										</c:otherwise>
									</c:choose>
								</c:forEach>		
								document.write(d);
							//-->
							</script>
							</div>
						</fieldset>
					</td>
					<td background="<c:out value="${contextPath}" />/images/treeview/layout/imgRoot05.gif" >&nbsp;</td>
				</tr>
				<tr>
					<td><img src="<c:out value="${contextPath}" />/images/treeview/layout/imgRoot06.gif" width="4" height="5"></td>
					<td background="<c:out value="${contextPath}" />/images/treeview/layout/imgRoot07.gif"></td>
					<td><img src="<c:out value="${contextPath}" />/images/treeview/layout/imgRoot08.gif" width="4" height="5"></td>
				</tr>
				<tr>
					<td colspan="3" align="right" height="30">
						<input type="button" name="btnReload" class="btnBlue02" onclick="document.location.reload();" onfocus="this.blur();" value="<fmt:message key="button.Reload" />" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>