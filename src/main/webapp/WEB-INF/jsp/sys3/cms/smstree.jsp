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
                    <td valign="top" id="tree">
			        </td>
			    </tr>
			</table>        
	   </form>
	</body>
</html>

<script type="text/javascript">
    var rowCount = 0;

	$(document).ready(function() {

		window.onload = function() {
			
		};

		${initScript}	

		$(".checkbox").click(function(){
			
			var data_root = $("#"+this.id).val().split(';');
			var OTYPE_root = data_root[0];
			var OBJID_root = data_root[1];
			var CHECK = "";
			if ($("#"+this.id).is(":checked")) {
				CHECK = "checked";
			}
			else {
				CHECK = "";
			}
			
			if (OTYPE_root == 'O') {
				for (var i=0; i < rowCount; i++) {
					var data1 = $("#checkYN"+i).val().split(';');
					var OTYPE1 = data1[0];
					var OBJID1 = data1[1];
					var ORGEH1 = data1[6];
					
					if (ORGEH1 == OBJID_root && OTYPE1 == "P") {
						$("#checkYN"+i).attr("checked",CHECK);
					}
					else if (ORGEH1 == OBJID_root && OTYPE1 == "O") {
						$("#checkYN"+i).attr("checked",CHECK);
						for (var j=0; j < rowCount; j++) {
							var data2 = $("#checkYN"+j).val().split(';');
							var OTYPE2 = data2[0];
							var OBJID2 = data2[1];
							var ORGEH2 = data2[6];
							
							if (ORGEH2 == OBJID1 && OTYPE2 == "P") {
								$("#checkYN"+j).attr("checked",CHECK);
							}
							else if (ORGEH2 == OBJID1 && OTYPE2 == "O") {
								$("#checkYN"+j).attr("checked",CHECK);
								for (var k=0; k < rowCount; k++) {
									var data3 = $("#checkYN"+k).val().split(';');
									var OTYPE3 = data3[0];
									var OBJID3 = data3[1];
									var ORGEH3 = data3[6];
									
									if (ORGEH3 == OBJID2 && OTYPE3 == "P") {
										$("#checkYN"+k).attr("checked",CHECK);
									}
									else if (ORGEH3 == OBJID2 && OTYPE3 == "O") {
										$("#checkYN"+k).attr("checked",CHECK);
										for (var l=0; l < rowCount; l++) {
											var data4 = $("#checkYN"+l).val().split(';');
											var OTYPE4 = data4[0];
											var OBJID4 = data4[1];
											var ORGEH4 = data4[6];
											
											if (ORGEH4 == OBJID3 && OTYPE4 == "P") {
												$("#checkYN"+l).attr("checked",CHECK);
											}
											
										}
									}
								}
							}
						}
					}
				}
			}
		});
	});
	
	// 조직구분에 따른 체크표시
	function selectLPTYP(LPTYP_con, CHECK_con){
		
		for (var i=0; i < rowCount; i++) {
			var data = $("#checkYN"+i).val().split(';');
			var OTYPE = data[0];
			var OBJID = data[1];
			var LPTYP = data[3];
			
			if (LPTYP == LPTYP_con && OTYPE == "P") {
				$("#checkYN"+i).attr("checked",CHECK_con);
			}
		}
	}
	
	function Search() {
		
        var table = new AW.XML.Table;     
        table.setURL("simpleAction.do");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("returnType","List");
        table.setParameter("resultType","XML");
        table.setParameter("RFC","ZCWCMC01_0008");
        table.setParameter("inParamKey","ACT_OBJID;ACT_PERNR;ACT_BEGDA;I_TYPE;");
        table.setParameter("outParamKey","OTYPE;OBJID;NAME;LPTYP;LPTYP_T;HP;ORGEH;ORGEH_T;");
        table.setParameter("ACT_OBJID","");
        table.setParameter("ACT_PERNR","${params.userID}");
        table.setParameter("ACT_BEGDA",unformat("${params.currentDate}"));
        table.setParameter("I_TYPE","${params.authLevelCD}");
        <c:if test="${params.authLevelCD == '10' || params.authLevelCD == '20'}">
        	table.setParameter("ACT_OBJID","20010338");
        	table.setParameter("ACT_PERNR","");
		</c:if>
        table.request();
        
        <!--
        //id, pid, name, url, title, target, icon, iconOPne, open,
        d = new dTree('d');
        d.config.target="_self";     
        d.config.folderLinks = true;
        d.config.closeSameLevel=false;
        d.config.useCookies=false;
        
        rowCount = 0;
        rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
                if (i == 0)
                {
                    d.add(table.getData(1,i), -1, table.getData(2,i)+"<input type='checkbox' id='checkYN"+i+"' name='checkYN' class='checkbox' value='"+table.getData(0,i)+";"+table.getData(1,i)+";"+table.getData(2,i)+";"+table.getData(3,i)+";"+table.getData(4,i)+";"+unformat(table.getData(5,i))+";"+table.getData(6,i)+";"+table.getData(7,i)+"'>", "");
                }
                else 
                {
                    if (table.getData(0,i) == 'O'){
                        d.add(table.getData(1,i), table.getData(6,i), table.getData(2,i)+"<input type='checkbox' id='checkYN"+i+"' name='checkYN' class='checkbox' value='"+table.getData(0,i)+";"+table.getData(1,i)+";"+table.getData(2,i)+";"+table.getData(3,i)+";"+table.getData(4,i)+";"+unformat(table.getData(5,i))+";"+table.getData(6,i)+";"+table.getData(7,i)+"'>","","","",d.icon.agency);
                    }
                    else if (table.getData(0,i) == 'P'){
                        d.add(table.getData(1,i), table.getData(6,i), table.getData(2,i)+"/"+table.getData(4,i)+"/"+formatTelNo(unformat(table.getData(5,i)))+"<input type='checkbox' id='checkYN"+i+"' name='checkYN' class='checkbox' value='"+table.getData(0,i)+";"+table.getData(1,i)+";"+table.getData(2,i)+";"+table.getData(3,i)+";"+table.getData(4,i)+";"+unformat(table.getData(5,i))+";"+table.getData(6,i)+";"+table.getData(7,i)+"'>","","","",d.icon.user);
                    }
                }
            }
        }
        //document.write(d);
        document.getElementById("tree").innerHTML = d;
	}
</script>