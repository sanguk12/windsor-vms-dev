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
								d.config.target="${params.target}";		
								d.config.folderLinks = true;
								d.config.closeSameLevel=false;
								d.config.useCookies=false;
								<c:forEach items="${helpContentsChart}" var="item" varStatus="status">
									<c:choose>
										<c:when test="${status.count==1}">
											d.add("${item.helpContentsID}", -1, "${item.helpContentsName}", "${params.handler}('${item.helpContentsID}')");
										</c:when>
										<c:otherwise>
											d.add("${item.helpContentsID}", "${item.phelpContentsID}", "${item.helpContentsName}", "${params.handler}('${item.helpContentsID}')");
										</c:otherwise>
									</c:choose>	
								</c:forEach>		
								
								document.write(d);
								//d.openAll();
							//-->
							</script>
							<p><a href="javascript: d.openAll();"><img src="${contextPath}/images/menu/all_open.png"> 펼치기</a> | <a href="javascript: d.closeAll();"><img src="${contextPath}/images/menu/all_close.png"> 접기</a></p>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>