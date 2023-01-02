<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../scripts.jsp" %>
		<style type="text/css">
			<!--
			body {margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-bottom: 0px;}
			-->
		</style>
		<script type="text/javascript">
			function ViewContent(url){
				parent.content.location.href = url;
			}
			
			function ToggleMenu(item) {
				if(null == document.getElementById(item)){
					return;
				}
				
				obj = document.getElementsByTagName("tr");
				for(var i=0;i<obj.length;i++) {
					if(obj[i].id.length>0) {
						obj[i].style.display="none";
					}
					if(obj[i].id==item && obj[i].style.display!="none") {
						obj[i].style.display="none";
					} else if(obj[i].id==item && obj[i].style.display!="block") {
						obj[i].style.display="block";
					}
				}
				
			}
		</script>
	</head>
	<body class="yui-skin-sam">
		<table width="100%" height="498"  border="0" cellpadding="0" cellspacing="0">
			<tr>
			  <td width="5">&nbsp;</td>
			  <td width="184" valign="top" background="${contextPath}/images/menu/imgMnuBg.gif"><table width="184"  border="0" cellspacing="0" cellpadding="0">
			    <tr>
			      <td width="184" height="8"><img src="${contextPath}/images/menu/imgMnuTl01.gif" width="184" height="8"></td>
			    </tr>
			    <tr>
			      <td height="67" valign="top" background="${contextPath}/images/menu/imgMnuTl.gif">
					<table width="179"  border="0" cellpadding="0" cellspacing="0">
			        <tr>
			          <td width="179" height="37" valign="bottom" style="padding:0px 12px 5px 0px; text-align:right"><a href="#" class="txWhite02">LAYOUT</a></td>
			        </tr>
			      </table>
			      <table width="174"  border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom:5px; ">
			        <tr>
			          <td width="3"><img src="${contextPath}/images/menu/imgMnuOffice01.gif" width="3" height="3"></td>
			          <td height="3" colspan="2" background="${contextPath}/images/menu/imgMnuOffice02.gif"></td>
			          <td width="3"><img src="${contextPath}/images/menu/imgMnuOffice03.gif" width="3" height="3"></td>
			        </tr>
			        <tr>
			          <td background="${contextPath}/images/menu/imgMnuOffice04.gif"><img src="${contextPath}/images/menu/imgMnuOffice04.gif" width="3" height="3"></td>
			          <td width="5" valign="top" bgcolor="#b5e375"><img src="${contextPath}/images/menu/lblGreen.gif" width="3" height="5" class="lbl03"> </td>
			          <td width="163" bgcolor="#b5e375" class="txGreen" style="padding-top:2px;">${paramMenu.pmnuGrpName}</td>
			          <td background="${contextPath}/images/menu/imgMnuOffice05.gif"><img src="${contextPath}/images/menu/imgMnuOffice05.gif" width="3" height="3"></td>
			        </tr>
			        <tr>
			          <td height="3"><img src="${contextPath}/images/menu/imgMnuOffice06.gif" width="3" height="3"></td>
			          <td colspan="2" background="${contextPath}/images/menu/imgMnuOffice07.gif"></td>
			          <td><img src="${contextPath}/images/menu/imgMnuOffice08.gif" width="3" height="3"></td>
			        </tr>
			      </table></td>
			    </tr>
			  </table>
			    <table width="174"  border="0" cellspacing="0" cellpadding="0" style="margin-left:5px; ">
			    <tr>
			      <td width="174"><img src="${contextPath}/images/menu/imgMnuBox01.gif" width="174" height="3"></td>
			    </tr>
			    <tr>
			      <td align="left" background="${contextPath}/images/menu/imgMnuBox02.gif" style="padding:8px 13px 8px 13px;">
						<table width="148"  border="0" cellspacing="0" cellpadding="0">							
							<c:set var="count" value="0"/>
							<c:forEach items="${menuList}" var="menu" varStatus="status">
								<c:choose>
									<c:when test="${menu.mnuType eq 'MENUGROUP'}">
										<c:set var="divID" value="${menu.mnuGrpID}"/>
										<tr><td height="1" bgcolor="d9d9d9" ></td></tr>
										<tr>
											<td width="148" class="tblMnuTh" onclick="fnToggleMenu('${divID}')" style="cursor:pointer;">
												<img src="${contextPath}/images/menu/lblBlue02.gif" width="9" height="9" class="lbl01" >${menu.mnuGrpName }												
											</td>
										</tr>
									</c:when>
									<c:when test="${menu.mnuType eq 'MENU'}">
										<tr id="${divID}" style="display:none">
											<td class="tblMnuTd"><a href="${contextPath}/${menu.url}&mnuGrpID=${menu.pmnuGrpID}&pgmID=${menu.pgmID}" class="mnu02" onfocus="this.blur();" target="SubContent">- ${menu.mnuGrpName}</a></td>
										</tr>
									</c:when>
								</c:choose>
								<c:set var="count" value="${status.count}" />
							</c:forEach>
							<c:if test="${count==0}">
							<tr>
								<td width="148" class="tblMnuTh">
									<img src="${contextPath}/images/menu/lblBlue02.gif" width="9" height="9" class="lbl01" ><fmt:message key="failure.auth" />
								</td>
							</tr>
							</c:if>
						</table>
			      </td>
			    </tr>
			    <tr>
			      <td><img src="${contextPath}/images/menu/imgMnuBox03.gif" width="174" height="4"></td>
			    </tr>
			  </table></td>
			  <td width="21" valign="top"><img src="${contextPath}/images/imgBox01.gif" width="21" height="193"></td>
			</tr>
		</table>
	</body>
</html>