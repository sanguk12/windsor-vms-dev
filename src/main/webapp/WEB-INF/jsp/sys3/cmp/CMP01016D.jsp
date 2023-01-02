<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@include file="../scripts.jsp" %>
		
		<link href="${contextPath}/css/treeview/dtree.css" rel="StyleSheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/treeview/dtree.js"></script>
				
	</head>
	<body style="background-color:#f2f2f2">
		<form name="form" method="post">
		    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="background-color:#f2f2f2">
                <tr>
                    <td valign="top">
			            <script>
			                var table = new AW.XML.Table;     
					        table.setURL("simpleAction.do");
					        table.setAsync(false);
					        table.setRequestMethod("POST");
					        table.setParameter("actionKey","search");   // search, save (add, remove, modify, update)
					        table.setParameter("resultType","XML");     // List, Map, XML, CSV
					        table.setParameter("queryKey","system.helpContentsChart.select");
					        table.setParameter("phelpContentsID","");
					        table.request();
					    
					        <!--
					        //id, pid, name, url, title, target, icon, iconOPne, open,
					        d = new dTree('d');
					        d.config.target="_self";     
					        d.config.folderLinks = true;
					        d.config.closeSameLevel=false;
					        d.config.useCookies=false;
					        
					        var rowCount = table.getCount();
					        if (rowCount > 0) {
					            for (var i=0; i < rowCount; i++) {
					            	if (i == 0){
					                    // 0:helpContentsID, 1:phelpContentsID, 2:helpContentsName, 3:seq, 4:helpContentsCD
					                    d.add(table.getData(0,i), -1, table.getData(2,i), "javascript:parent.setPHelpContents('"+table.getData(0,i)+"','"+table.getData(2,i)+"')");
					                }
					                else {
					                    d.add(table.getData(0,i), table.getData(1,i), table.getData(2,i), "javascript:parent.setPHelpContents('"+table.getData(0,i)+"','"+table.getData(2,i)+"')");
					                }
					            }
					        }
					        //-->
					        document.write(d);
					        d.openAll();
					        //-->
			            </script>
			        </td>
			    </tr>
			</table>        
	   </form>
	</body>
</html>