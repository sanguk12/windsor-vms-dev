<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><fmt:message key="application.title" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@include file="../scripts.jsp" %>
        <style type="text/css">
		<!--
			body {margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-bottom: 0px;}
			.aw-grid-control {margin: 0px; font-size:12px; font-family:"Dodum,Arial,Tahoma";}
			.aw-ui-button {font-size:12px; font-family:"Dodum,Arial,Tahoma";}
			.aw-grid-cell {border-right: 1px solid threedlightshadow;}
			.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
		//-->
		</style>
	</head>
	<body onload="fnMessage('${fileUpload.msg}', 'CloseReload');">
		<form name="frm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="linkDivCD" value="${param.linkDivCD}" />
			<input type="hidden" name="linkID" value="${param.linkID}" />
			<table width="100%" height="200" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="7"><img src="${contextPath}/images/fileupdown/imgPopBox01.gif" width="7" height="7"></td>
					<td height="7" background="${contextPath}/images/fileupdown/imgPopBox02.gif"></td>
					<td width="7"><img src="${contextPath}/images/fileupdown/imgPopBox03.gif" width="9" height="7"></td>
				</tr>
				<tr>
					<td height="250" background="${contextPath}/images/fileupdown/imgPopBox04.gif">&nbsp;</td>
					<td valign="top" bgcolor="#fafafa" style="padding:10px; ">
						<table width="100%"  border="0" cellspacing="0" cellpadding="0" style="margin:6px 0px 24px 0px;">
							<tr>
								<td>
									<input type="file" name="url0" class="txtFull"/><br>
									<div id="tmp"></div>
								</td>
							</tr>
						</table>
					</td>
					<td background="${contextPath}/images/fileupdown/imgPopBox05.gif">&nbsp;</td>
				</tr>
				<tr>
					<td><img src="${contextPath}/images/fileupdown/imgPopBox06.gif" width="7" height="10"></td>
					<td height="10" background="${contextPath}/images/fileupdown/imgPopBox07.gif"></td>
					<td><img src="${contextPath}/images/fileupdown/imgPopBox08.gif" width="9" height="10"></td>
				</tr>
			</table>
			<table width="100%" cellspacing="0" cellpadding="0">
				<tr><td align="center">
					<nis:button preset="widget" id="Add" eventproc="Add();" />
					<nis:button preset="widget" id="Upload" eventproc="Upload();" />
					<nis:button preset="widget" id="Close" eventproc="Close();" />
				</td></tr>
			</table>
		</form>
	</body>
</html>
<script type="text/javascript" language="javascript">
	var servlet = "${contextPath}/doclink.do";
	// Upload
	function Upload() {
		try {
			fnSubmitConfirm(frm, servlet, "insertFile", "<fmt:message key="confirm.upload" />");
		} catch(e) {
			alert("<fmt:message key="infos.selected" />");
			return false;
		}
	}
	
	var index = 1;
	function Add() {
		if(document.getElementById("url"+(index-1)).value!="") {
			if(index<=9) {
				document.all.tmp.outerHTML+="<input type=\"file\" name=\"url"+index+"\" class=\"txtFull\"/><br>";
				index++;
			}
		} else {
			alert("<fmt:message key="infos.selected" />");
		}
	}
	
	function Close() {
		fnClose();
	}
	
	function IsImage(obj) {
		var chgImg = new Image();
		chgImg.src=obj.value;
		document.all.preview.src=chgImg.src;
	}
</script>