<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<%@include file="../scripts.jsp" %>
		<script type="text/javascript">
			function Search() {
				// linkID 가 여러개 일 때
				/*
				var parameter = {
					"linkID":"00000005",
					"linkID1":"",
					"linkID2":"",
					"linkID3":"",
					"linkID4":"",
					"linkID5":""
				};
				*/
				
				// linkID 가 하나 일 때
				var parameter = "00000005";
				
				$("#_filemanager")[0].contentWindow.Search(parameter);
			}
			
			function Save() {
				alert($("#_filemanager")[0].contentWindow.getDocLinkID());
			}
		</script>
	</head>
	<body>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
			<tr>
				<td height="1">
					<a href="#" onclick="Search()">Search</a>
					<a href="#" onclick="Save()">Save</a>
				</td>
			</tr>
			<tr>
				<td height="*">
					<nis:filemanager id="filemanager" width="800" height="200" linkDivCD="SUBJECT" uploadEnable="yes" gridEnable="yes" galleryEnable="yes" />
				</td>
			</tr>
		</table>
	</body>
</html>