<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <%@include file="../scripts.jsp" %>
    <link href="${contextPath}/css/treeview/dtree.css" rel="StyleSheet" type="text/css" />
    <script type="text/javascript" src="${contextPath}/scripts/treeview/dtree.js"></script>
    <script type="text/javascript">
	    var _subworkspaceURL = "";
		var itemCount = 0;
	</script>
</head>

<body>
	<div id="left" style="width:100%; height:100%;">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
		    	<td height="*" valign="top">
		    	    <div class="dtree">
						<script type="text/javascript">
							<!--
					
							//id, pid, name, url, title, target, icon, iconOpne, open, iconCommand
					
							d = new dTree('d');
							d.config.target="_subworkspace";		
							d.config.folderLinks = true;
							d.config.closeSameLevel = false;
							d.config.useCookies = false;
							
							<c:set var="_subworkspaceURL" value=""/>
		
							<c:forEach items="${tree}" var="item" varStatus="status">
								<c:choose>
									<c:when test="${status.count == 1}">
										<c:set var="subMenuTitle" value="${item.name}"/>
										<c:set var="mnuGrpID" value="${item.code}"/>
										d.add('${item.code}','${item.pcode}','',
									</c:when>
									<c:otherwise>
										d.add('${item.code}','${item.pcode}','${item.name}',
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${empty item.URL}">
										'','');
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${status.count==1}">
												'','');
											</c:when>
											<c:otherwise>
												'${contextPath}${item.URL}<c:if test="${!empty item.code}">mnuGrpID=${item.pcode}&pgmID=${item.code}</c:if>','${item.name}','',<c:choose><c:when test="${item.openWindowYN=='Y'}">d.icon.window</c:when><c:otherwise>''</c:otherwise></c:choose>,'','',"<c:if test="${item.openWindowYN=='Y'}">popupWindow('${contextPath}/service/simpleCommand/?mnuGrpID=${item.pcode}&pgmID=${item.code}','${item.code}',1024,600,'yes','${item.name}')</c:if>");
												<c:if test="${item.kind=='M' && _subworkspaceURL==''}">
													<c:set var="_subworkspaceURL" value="${item.URL}mnuGrpID=${item.pcode}&pgmID=${item.code}"/>
												</c:if>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								itemCount = ${status.count};
							</c:forEach>
							
							document.write(d);

							<c:if test="${empty params.openProgram}">
								parent._subworkspace.location.href = "${contextPath}${_subworkspaceURL}"+"&menuCloseYN=N";
							</c:if>
							
							d.openAll();
	
							parent.document.getElementById("subMenuTitle").innerHTML = '${subMenuTitle}';
							top.menuBarTabStyleChange('${mnuGrpID}');
							//-->
						</script>
						<div width="100%" align="left">
							<p><a href="javascript: d.openAll();"><img src="${contextPath}/images/menu/all_open.png"> <fmt:message key="menutree.expand"/></a> | <a href="javascript: d.closeAll();"><img src="${contextPath}/images/menu/all_close.png"> <fmt:message key="menutree.collapse"/></a></p>
						</div>
					</div>
			    </td>
		 	</tr>
		</table>
	</div>
</body>
</html>