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
					        table.setParameter("queryKey","commonservice.biz.organizationSelector.select");
					        table.setParameter("companyID",'${companyID}');
					        table.setParameter("orgID",'${orgID}');
					        table.setParameter("partnerID",'${partnerID}');
					        table.setParameter("orgName","${orgName}");
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
					            var data = new Array();
					            for (var i=0; i < rowCount; i++) {
					                if (i == 0)
					                {
					                    // 0:orgID, 1:porgID, 2:orgName, 3:seq, 4:orgCD, 5:companyID, 6:partnerID
					                    //d.add(table.getData(0,i), -1, table.getData(2,i), "javascript:setOrganization('"+table.getData(5,i)+"','"+table.getData(6,i)+"','"+table.getData(4,i)+"','"+table.getData(2,i)+"')");
					                    d.add(table.getData(0,i), -1, table.getData(2,i), "<c:if test="${params.authLevelCD == '10'}">javascript:parent.setOrganization('','','','Organization')</c:if>");
					                }
					                else 
					                {
					                    d.add(table.getData(0,i), table.getData(1,i), table.getData(2,i), "javascript:parent.setOrganization('"+table.getData(5,i)+"','"+table.getData(6,i)+"','"+table.getData(4,i)+"','"+table.getData(2,i)+"')");
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