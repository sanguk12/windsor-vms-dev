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

<body>
<form name="form" method="post">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
    	<tr>
        	<td valign="top">
		    	<script>
		        	var table = new AW.XML.Table;     
			        table.setURL("${contextPath}/service/simpleAction/COM0100201S");
			        table.setAsync(false);
			        table.setRequestMethod("POST");
			        table.setParameter("outParamKey",
			        		"porgID;orgID;orgName;companyID;partnerID;checkYN;class;");
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
			                	/*
			                    * 0:porgID, 1:orgID, 2:orgName, 3:companyID, 4:partnerID, 5:checkYN, 
			                    * 6:class (
			                    *	H:HQ
			                    *	O:Office
			                    *	B:Office 지사
			                    *   T:Store
			                    *   S:Store 지사
			                    *   A:매장
			                    *   U:User
			                    *	)
			                    */
			                    d.add(table.getData(1,i), -1, table.getData(2,i), "");
			                }
			                else 
			                {
			                	if (table.getData(5,i) == 'Y'){
			                       if (table.getData(6,i) == 'H'){
			                           d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i)+"<input type='checkbox' id='checkYN' name='checkYN' class='checkbox' value='"+table.getData(6,i)+';'+table.getData(4,i)+';<'+table.getData(2,i)+">'>", "");
			                       }
			                       else if (table.getData(6,i) == 'O' || table.getData(6,i) == 'T'){
                                       d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i)+"<input type='checkbox' id='checkYN' name='checkYN' class='checkbox' value='"+table.getData(6,i)+';'+table.getData(4,i)+';<'+table.getData(2,i)+">'>", "","","",d.icon.hq);
                                   }
			                       else if (table.getData(6,i) == 'B' || table.getData(6,i) == 'S'){
                                       d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i)+"<input type='checkbox' id='checkYN' name='checkYN' class='checkbox' value='"+table.getData(6,i)+';'+table.getData(4,i)+';<'+table.getData(2,i)+">'>", "","","",d.icon.team);
                                   }
                                   else if (table.getData(6,i) == 'A'){
                                       d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i)+"<input type='checkbox' id='checkYN' name='checkYN' class='checkbox' value='"+table.getData(6,i)+';'+table.getData(4,i)+';<'+table.getData(2,i)+">'>", "","","",d.icon.agency);
                                   }
                                   else if (table.getData(6,i) == 'U'){
                                       d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i)+"<input type='checkbox' id='checkYN' name='checkYN' class='checkbox' value='"+table.getData(6,i)+';'+table.getData(4,i)+';'+table.getData(2,i)+"'>", "","","",d.icon.user);
                                   }
			                       else {
			                           d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i)+"<input type='checkbox' id='checkYN' name='checkYN' class='checkbox' value='"+table.getData(6,i)+';'+table.getData(4,i)+';'+table.getData(2,i)+"'>", "");
			                       }
			                    }
			                    else {
			                       d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i), "");
			                    }
			                }
			            }
			        }
			        document.write(d);
			        //-->
		            </script>
		        </td>
		    </tr>
		</table>        
   </form>
</body>
</html>