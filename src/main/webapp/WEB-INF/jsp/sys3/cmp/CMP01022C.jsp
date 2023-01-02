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
			//alert();
		};
		${initScript}	
		
	});
	
	/* 조직구분에 따른 체크표시
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
	*/
	function Search() {
		
        var table = new AW.XML.Table;     
        table.setURL("simpleAction.do");
        table.setAsync(false);
        table.setRequestMethod("POST");
        /*
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
        */
        table.setParameter("queryKey","commonservice.biz.smsRecSelector.select");
  		table.setParameter("outParamKey","porgID;orgID;orgName;companyID;checkYN;class;hpNo;");
        table.request();
        
        
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
              // alert(i+table.getData(5,i));
                if (i == 0)
                {
                    d.add(table.getData(1,i), -1, table.getData(2,i)+"<input type='checkbox' id='checkYN"+i+"' name='checkYN' class='checkbox' value='"+i+";"+table.getData(0,i)+";"+table.getData(1,i)+";"+table.getData(2,i)+";"+table.getData(5,i)+";"+table.getData(6,i)+"'>", "");
                }
                else 
                {
                    if (table.getData(5,i) == 'AC'){
                        d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i)+"<input type='checkbox' id='checkYN"+i+"' name='checkYN' class='checkbox' value='"+i+";"+table.getData(0,i)+";"+table.getData(1,i)+";"+table.getData(2,i)+";"+table.getData(5,i)+";"+table.getData(6,i)+"'>","","","",d.icon.agency);
                    }
                    else if (table.getData(5,i) == 'EMP'){
                        d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i)+"/"+formatTelNo(table.getData(6,i))+"<input type='checkbox' id='checkYN"+i+"' name='checkYN' class='checkbox' value='"+i+";"+table.getData(0,i)+";"+table.getData(1,i)+";"+table.getData(2,i)+";"+table.getData(5,i)+";"+table.getData(6,i)+"'>","","","",d.icon.user);
                    }
                    else{
                    	d.add(table.getData(1,i), table.getData(0,i), table.getData(2,i)+"<input type='checkbox' id='checkYN"+i+"' name='checkYN' class='checkbox' value='"+i+";"+table.getData(0,i)+";"+table.getData(1,i)+";"+table.getData(2,i)+";"+table.getData(5,i)+";"+table.getData(6,i)+"'>","","","","");
                    }    
                }
            }
        }
        //document.write(d);
        //document.getElementById("tree").innerHTML = d;
        $("#tree").attr("innerHTML",d);
        //alert(d);
        
        $("input:checkbox").click(function(){

        	//ROOT단계
            var data_root = new Array();
        	data_root = $("#"+this.id).val().split(';');
			var SEQ_root = parseInt(data_root[0])+1;
			//alert(SEQ_root);
			var CLASS_root = data_root[4];
			var OBJID_root = data_root[2];
			//alert(OBJID_root);
			var CHECK = "";
			
			if ($("#"+this.id).is(":checked")) {
				CHECK = "checked";
			}
			else {
				CHECK = "";
			}
			if (CLASS_root != 'EMP') {
				//ORGANIZATION or AGENCY Group 단계
				for (var i=SEQ_root; i < rowCount; i++) {
					var data1 = $("#checkYN"+i).val().split(';');
					var CLASS1= data1[4];
					var OBJID1 = data1[2];
					var POBJID1 = data1[1];
					var HP1 = data1[5];
					/*
					if(data1.length == 5){
						(data1[4]);
						HP = data1[4];
					}
					*/
					if(CLASS1 =="EMP"){ 
						if (OBJID_root == POBJID1 && HP1 != "") {
							$("#checkYN"+i).attr("checked",CHECK);
						}
					}else{
						if (OBJID_root == POBJID1){
							$("#checkYN"+i).attr("checked",CHECK);
							//ORG HQ or AC 단계
							for (var j=i+1; j < rowCount; j++) {
								var data2 = $("#checkYN"+j).val().split(';');
								var CLASS2= data2[4];
								var OBJID2 = data2[2];
								var POBJID2 = data2[1];
								var HP2 = data2[5];
								

								if(CLASS2 =="EMP"){ 
									if (OBJID1 == POBJID2 && HP2 != "") {
										$("#checkYN"+j).attr("checked",CHECK);
									}
								}else{
									if (OBJID1 == POBJID2){
										$("#checkYN"+j).attr("checked",CHECK);
										//EMP 단계
										for (var k=j+1; k < rowCount; k++) {
											var data3 = $("#checkYN"+k).val().split(';');
											var CLASS3= data3[4];
											var OBJID3 = data3[2];
											var POBJID3 = data3[1];
											var HP3 = data3[5];
	
											if(CLASS3 =="EMP"){
												if (OBJID2 == POBJID3 && HP3 != "") {
													$("#checkYN"+k).attr("checked",CHECK);
												}
											}/*else{
												if (OBJID2 == POBJID3){//ORG BRANCH 단계
													$("#checkYN"+k).attr("checked",CHECK);
													for (var l=k+1; l < rowCount; l++) {
														var data4 = $("#checkYN"+l).val().split(';');
														var CLASS4= data4[4];
														var OBJID4 = data4[2];
														var POBJID4 = data4[1];
														var HP4 = data4[5];
		
														if(CLASS4=="AC" || CLASS4 =="EMP"){
															if (OBJID3 == POBJID4 && HP4 != "") {
																$("#checkYN"+l).attr("checked",CHECK);
															}
															*
														}else{
															if (OBJID3 == POBJID4){
																for (var m=l+1; m < rowCount; m++) {
																	var data5 = $("#checkYN"+m).val().split(';');
																	var CLASS5= data5[3];
																	var OBJID5 = data5[1];
																	var POBJID5 = data5[1];
																	var HP5 = data5[4];
																	if(CLASS5=="AC" || CLASS5 =="EMP"){
																		if (OBJID4 == POBJID5 && HP5 != "") {
																			$("#checkYN"+m).attr("checked",CHECK);
																		}
																	}
																}	
															}
															*
														}			
													}
												}	
											}*/	 
										}
									}	
								}
								
							}
						}			
					}
				}//end for
			}//end if
        });
	}
</script>