<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>${params.viewName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="Pragma" content="no-cache">
    <%@include file="../sys3/scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
<form name="form" method="post">
	<div id="wrapDiv" class="pd-l">
    	<div id="formDiv">
    		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
			            <%@include file="../sys3/cms/functionbar.jsp" %>
			            <input type="hidden" id="useYN" name="useYN"/>
			            <input type="hidden" id="activeFlg" name="activeFlg"/>
			            <input type="hidden" id="empID_YN" name="empID_YN"/>
			            <input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM01001B" />
                    </td>
                </tr>
                <tr>
					<td height="1">             
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
						        			<col style="width:100px;"></col>
						        			<col style="width:150px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:180px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
			                            <tr>
											<td class="td-cond">
												<fmt:message key="MDM01001A.dkmdTpCD" />
											</td>
											<td class="td-input">
												<nis:selectbox id="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" />
			                                </td>
			                                <td class="td-cond">
												<fmt:message key="MDM01001A.rageSphereCD" />
											</td>
											<td class="td-input">
												<nis:selectbox id="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" />
			                                </td>
			                                <td class="td-cond">
												<fmt:message key="MDM01001A.officeCD" />
											</td>
											<td class="td-input">
												<div id="officeCD_S_cond" style="float:left;">
													<select id="officeCD_S" style="width:100px;">
														<option value=""><fmt:message key="all" /></option>
													</select>
												</div>
			                                </td>
			                            </tr>
			                            <tr>
											<td class="td-cond">
												<fmt:message key="MDM01001A.empID" />
											</td>
											<td class="td-input">
												<input type="text" id="empID_S" style="width:100px;">
			                                </td>
			                                <td class="td-cond">
												<fmt:message key="MDM01001A.empNm" />
											</td>
											<td class="td-input">
												<input type="text" id="empNm_S" style="width:100px;">
			                                </td>
			                                <td class="td-cond">
												<fmt:message key="MDM01001A.empTpCD" />
											</td>
											<td class="td-input">
												<nis:selectbox id="empTpCD_S" defaultText="all" category="EMPTPCD" />
			                                </td>
			                            </tr>
			                            </tbody>
			                        </table>
                    			</td>
                   			</tr>
						</table>
                    </td>
                </tr>
                <tr>
                    <td height="*">
                        <table width="100%" height="100%" border="0" cellspacing="1" cellpadding="0">
                        	<colgroup>
                        		<col style="width:700px;"></col>
                        		<col></col>
                        	</colgroup>
                        	<tbody>
								<tr>
								  	<td height="*">
								  		<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
									  		<tr>
							                    <td height="*">
							                        <span id="grid"></span>
							                    </td>
							                </tr>
							                <tr>
							                    <td class="td-paging">
							                        <nis:paging id="grid" titleDisable="yes" callback="PagingSearch()"/>
							                    </td>
							                </tr>
								  		</table>
								  	</td>
									<td valign="top">
				                        <table border="0" cellpadding="0" cellspacing="0" style="border:#e1dcbe solid 1px; table-layout:fixed;">
				                            <colgroup>
				                            	<col style="width:100px;"></col>
				                            	<col style="width:300px;"></col>
				                            </colgroup>
				                            <tbody>
					                            <tr>
					                                <td class="td-cond-required">
					                                    <fmt:message key="MDM01001A.empID" />
					                                </td>
					                                <td class="td-input">
					                                    <input type="text" id="empID" style="width:150px; ime-mode:disabled;" maxlength="20" >
					                                	<div id="overLap"></div>
					                                </td>
					                            </tr>
					                            <tr>    
					                                <td class="td-cond-required">
					                                    <fmt:message key="MDM01001A.empNm" />
					                                </td>
					                                <td class="td-input">
					                                    <input type="text" id="empNm" style="width:150px;" maxlength="10" >
					                                </td>
					                            </tr>
					                            <tr>
					                                <td class="td-cond-required">
					                                    <fmt:message key="MDM01001A.empTpCD" />
					                                </td>
					                                <td class="td-input">                            
					                                    <nis:selectbox id="empTpCD" defaultText="select" category="EMPTPCD" />
					                                </td>
					                            </tr>
					                            <tr>     
					                                <td id="rageSphereCD_td" class="td-cond">
					                                    <fmt:message key="MDM01001A.rageSphereCD" />
					                                </td>
					                                <td class="td-input">
					                                    <nis:selectbox id="rageSphereCD" defaultText="select" category="RAGESPHERECD" />
					                                </td>
					                            </tr>
					                            <tr>
					                                <td id="officeCD_td" class="td-cond">
					                                    <fmt:message key="MDM01001A.officeCD" />
					                                </td>
					                                <td class="td-input">
					                                    <div id="officeCD_cond" style="float:left;">
															<select id="officeCD">
																<option value=""><fmt:message key="select" /></option>
															</select>
														</div>
					                                </td>
					                            </tr>
					                            <tr>     
					                                <td id="teamCD_td" class="td-cond">
					                                    <fmt:message key="MDM01001A.teamCD" />
					                                </td>
					                                <td class="td-input">                            
					                                    <div id="teamCD_cond" style="float:left;">
															<select id="teamCD">
																<option value=""><fmt:message key="select" /></option>
															</select>
														</div>
					                                </td>
					                            </tr>
					                            <tr>
					                                <td id="territoryCD_td" class="td-cond">
					                                    <fmt:message key="MDM01001A.territory" />
					                                </td>
					                                <td class="td-input">
					                                    <div id="territoryCD_cond" style="float:left;">
															<select id="territoryCD">
																<option value=""><fmt:message key="select" /></option>
															</select>
														</div>
					                                </td>
					                            </tr>
					                            <tr>     
					                                <td class="td-cond-required">
					                                    <fmt:message key="MDM01001A.dkmdTpCD" />
					                                </td>
					                                <td class="td-input">
					                                    <nis:selectbox id="dkmdTpCD" defaultText="select" category="DKMDTPCD" />
					                                </td>
					                            </tr>
					                            <tr>
					                                <td class="td-cond-required">
					                                    <fmt:message key="MDM01001A.emailAddr" />
					                                </td>
					                                <td class="td-input">
					                                    <input type="text" id="emailAddr" style="width:250px; ime-mode:disabled;" maxlength="50">
					                                </td>
					                            </tr>
					                            <tr>
					                                <td class="td-cond-required">
					                                    <fmt:message key="MDM01001A.workStatCD" />
					                                </td>
					                                <td class="td-input">
					                                	<nis:selectbox id="workStatCD" defaultText="select" category="WORKSTATCD" />
					                                </td>
					                            </tr>
					                            <tr>     
					                                <td class="td-cond-required">
					                                    <fmt:message key="MDM01001A.grpID" />
					                                </td>
					                                <td class="td-input">
					                                	<div id="grpID_cond" style="float:left;">
															<select id="grpID">
																<option value=""><fmt:message key="select" /></option>
															</select>
														</div>
					                                </td>
					                            </tr>
					                            <tr>
					                            	<td class="td-cond">
					                                    <fmt:message key="MDM01001A.userID" />
					                                </td>
					                                <td class="td-input">
					                                    <input type="text" id="userID" style="width:150px;" class="input-readonly" readonly="readonly">
					                                </td>
					                            </tr>
				                            </tbody>
				                        </table>
							         </td>
							     </tr>
						     </tbody>
						 </table>
                    </td>
                </tr>
                <tr>
					<td height="1">
					</td>
				</tr>
            </table>            
        </div>
        ${appletDiv}
    </div>
</form>    
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    .aw-row-selector {text-align: center}

    .aw-column-0 {width: 120px; }
	.aw-column-1 {width: 100px; }
	.aw-column-2 {width: 100px; }
	.aw-column-3 {width: 100px; }
	.aw-column-4 {width: 100px; text-align: center;}
	.aw-column-5 {width: 90px; text-align: center;}
	.aw-column-6 {width: 80px; text-align: center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">

    /****************************************
    * Function
    ****************************************/
    
    $(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			$("#grid_displayNum").val("100");
			
			changeGrpID();
			
			createGrid();
			grid.refresh();
			New();
			
			if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD_S").val("${params.dkmdTpCD}");
				$("#dkmdTpCD_S").attr("disabled", true);
				$("#dkmdTpCD_S").addClass("input-readonly");
				$("#dkmdTpCD").val("${params.dkmdTpCD}");
				$("#dkmdTpCD").attr("disabled", true);
				$("#dkmdTpCD").addClass("input-readonly");
			}
			
		};

		${initScript}
		
		$("#empID_S").keypress(function(){
			if (event.keyCode==13){
				Search();
			}
		});
		$("#empNm_S").keypress(function(){
			if (event.keyCode==13){
				Search();
			}
		});

	});
	
	$("#rageSphereCD_S").change(function() {
		if($("#rageSphereCD_S").val()=="") {
			$("#officeCD_S").val("");
			$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
			return;
		}
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "OFFICECD");
        table.setParameter("attrib02", $("#rageSphereCD_S").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='officeCD_S' style='width:100px;'><option value=''><fmt:message key="all"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            
            $("#officeCD_S").attr("disabled",false);
    		$("#officeCD_S").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#officeCD_S_cond").html(s);
	});
	
	$("#empTpCD").change(function() {
		changeEmpTpCD();
	});
	
	function changeEmpTpCD() {
		//영업
		if($("#empTpCD").val() == "20") {
			try{$("#rageSphereCD_td").addClass("td-cond-required")}catch(e){}
			try{$("#rageSphereCD").attr("disabled",false)}catch(e){}
			$("#rageSphereCD").removeClass("input-readonly");
		}
		//본사
		else {
			$("#rageSphereCD").val("");
	  		$("#officeCD").val("");
	  		$("#teamCD").val("");
	  		$("#territoryCD").val("");
	  		
			try{$("#rageSphereCD_td").removeClass("td-cond-required")}catch(e){}
			try{$("#rageSphereCD").attr("disabled",true)}catch(e){}
			try{$("#officeCD").attr("disabled",true)}catch(e){}
			try{$("#teamCD").attr("disabled",true)}catch(e){}
			try{$("#territoryCD").attr("disabled",true)}catch(e){}
			$("#rageSphereCD").addClass("input-readonly");
			$("#officeCD").addClass("input-readonly");
			$("#teamCD").addClass("input-readonly");
			$("#territoryCD").addClass("input-readonly");
		}
	}
	
	
	$("#rageSphereCD").change(function() {
		refresh_officeCD();
	});
	
	function refresh_officeCD() {
		if($("#rageSphereCD").val()=="") {
			$("#officeCD").val("");
			$("#officeCD").attr("disabled",true);
    		$("#officeCD").addClass("input-readonly");
    		$("#teamCD").val("");
			$("#teamCD").attr("disabled",true);
    		$("#teamCD").addClass("input-readonly");
    		$("#territoryCD").val("");
			$("#territoryCD").attr("disabled",true);
    		$("#territoryCD").addClass("input-readonly");
			return;
		}
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "OFFICECD");
        table.setParameter("attrib02", $("#rageSphereCD").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='officeCD' onchange='refresh_teamCD()'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            $("#officeCD").attr("disabled",false);
    		$("#officeCD").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#officeCD_cond").html(s);
        
        $("#teamCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#teamCD").attr("disabled",true);
   		$("#teamCD").addClass("input-readonly");
     	$("#territoryCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#territoryCD").attr("disabled",true);
   		$("#territoryCD").addClass("input-readonly");
	}
	
	
	function refresh_teamCD() {
		if($("#officeCD").val()=="") {
			$("#teamCD").val("");
			$("#teamCD").attr("disabled",true);
    		$("#teamCD").addClass("input-readonly");
    		$("#territoryCD").val("");
			$("#territoryCD").attr("disabled",true);
    		$("#territoryCD").addClass("input-readonly");
			return;
		}
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "TEAMCD");
        table.setParameter("attrib02", $("#officeCD").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='teamCD' onchange='refresh_territoryCD()'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            $("#teamCD").attr("disabled",false);
    		$("#teamCD").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#teamCD_cond").html(s);
        
        $("#territoryCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#territoryCD").attr("disabled",true);
   		$("#territoryCD").addClass("input-readonly");
	}
	
	function refresh_territoryCD() {
		if($("#teamCD").val()=="") {
			$("#territoryCD").val("");
			$("#territoryCD").attr("disabled",true);
    		$("#territoryCD").addClass("input-readonly");
			return;
		}
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "TERRITORYCD");
        table.setParameter("attrib02", $("#teamCD").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='territoryCD'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            $("#territoryCD").attr("disabled",false);
    		$("#territoryCD").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#territoryCD_cond").html(s);
        
	}
	
	function changeGrpID() {
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/CMP04001A05S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","grpID;grpName;");
        table.setParameter("dkmdTpCD", "${params.dkmdTpCD}");
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='grpID'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#grpID_cond").html(s);
	}
	
	//사번 중복 검사
	var overLap = new AW.UI.Button;
	overLap.setId("overLap");
	overLap.setControlText("<fmt:message key="button.Overlap" />");
	overLap.refresh();

	overLap.onControlClicked = function(event){
		if ($("#empID").val() == "") {
			alert("<fmt:message key="MDM01001A.msg1" />");
			$("#empID").attr("disabled", false);
			$("#empID").focus();
            return;
        } 
        
        if ($("#empID").val().length < 5){
			alert("<fmt:message key="MDM01001A.msg12" />");
			$("#empID").attr("disabled", false);
			$("#empID").focus();
			return;
		}	
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/MDM0100103S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        $("#empID").val($("#empID").val().toUpperCase());
        table.setParameter("empID", $("#empID").val());
        table.request();
	    
	    var rowCount = table.getCount();
	    if (rowCount > 0) {
	        if (table.getData(0,0) != '0'){
				alert("<fmt:message key="MDM01001A.msg13" />");
	            $("#empID").val("");
	            $("#empID").focus();
	            $("#empID_YN").val("N");
	        }
	        else {
				alert("<fmt:message key="MDM01001A.msg14" />");
	            $("#empID").attr("disabled", true);
	            $("#empID").addClass("input-readonly");
	            overLap.setControlVisible(false);
	            $("#empID_YN").val("Y");
	            $("#empNm").focus();
	        }
	    }
	    else  {
			alert("<fmt:message key="MDM01001A.msg15" />");
	    }
	}
	
	var _i_dt = 0;
	var _col_dt = {
		empID : _i_dt++
		, empNm : _i_dt++
		, empTpCD : _i_dt++
		, rageSphereCD : _i_dt++
		, officeCD : _i_dt++
 		, teamCD : _i_dt++
		, territoryCD : _i_dt++
		, dkmdTpCD : _i_dt++
		, emailAddr : _i_dt++
		, workStatCD : _i_dt++
 		, grpID : _i_dt++
 		, userID : _i_dt++
		, totalCount : _i_dt++
	};
	
    function Detail(empID) {
    	
		var table = new AW.XML.Table;	  
		table.setURL("${contextPath}/service/simpleAction/MDM0100102S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"empID;empNm;empTpCD;rageSphereCD;officeCD;"+
	  			"teamCD;territoryCD;dkmdTpCD;emailAddr;workStatCD;"+
	  			"grpID;userID;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;");
	  	table.setParameter("empID", empID);
      	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#empID").val(table.getData(_col_dt.empID,0));
      		$("#empNm").val(table.getData(_col_dt.empNm,0));
      		$("#empTpCD").val(table.getData(_col_dt.empTpCD,0));
      		$("#rageSphereCD").val(table.getData(_col_dt.rageSphereCD,0));
      		refresh_officeCD();
      		$("#officeCD").val(table.getData(_col_dt.officeCD,0));
      		refresh_teamCD();
      		$("#teamCD").val(table.getData(_col_dt.teamCD,0));
      		refresh_territoryCD();
      		$("#territoryCD").val(table.getData(_col_dt.territoryCD,0));
      		$("#dkmdTpCD").val(table.getData(_col_dt.dkmdTpCD,0));
      		$("#emailAddr").val(table.getData(_col_dt.emailAddr,0));
      		$("#workStatCD").val(table.getData(_col_dt.workStatCD,0));
      		$("#grpID").val(table.getData(_col_dt.grpID,0));
      		$("#userID").val(table.getData(_col_dt.userID,0));
      		changeEmpTpCD();
      		
      		overLap.setControlVisible(false);
	    	try{$("#empID").attr("readonly",true)}catch(e){}
	    	try{$("#empID").addClass("input-readonly")}catch(e){}
	    	$("#empID_YN").val("Y");
      		
      	}
      	else {
      		New();
      	}
	}
</script>   

<script type="text/javascript">

    /****************************************
    * Button Action
    ****************************************/
    
    var _i = 0;
	var _col = {
		rageSphereCDName : _i++
		, officeCDName : _i++
 		, teamCDName : _i++
		, territoryCDName : _i++
		, empID : _i++
		, empNm : _i++
		, empTpCDName : _i++
		, rageSphereCD : _i++
		, officeCD : _i++
 		, teamCD : _i++
		, territoryCD : _i++
		, empTpCD : _i++
		, rowNum : _i++
		, totalCount : _i++
	};
    
	function PagingSearch(){
    	
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/MDM0100101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","rageSphereCDName;officeCDName;teamCDName;territoryCDName;empID;"+
					"empNm;empTpCDName;rageSphereCD;officeCD;teamCD;"+
					"territoryCD;empTpCD;rowNum;totalCount;");
		table.setParameter("format","str;str;str;str;str;str;str;str;str;str;str;str;str;str");
		table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("empID", $("#empID_S").val());
	  	table.setParameter("empNm", $("#empNm_S").val());
	  	table.setParameter("empTpCD", $("#empTpCD_S").val());
		//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
        table.setParameter("displayNum", $("#grid_displayNum").val());
        //Paging Parameter - END
      	table.request();
      	
//       	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
      						table.getData(_col.rageSphereCDName,i),
      						table.getData(_col.officeCDName,i),
      						table.getData(_col.teamCDName,i),
      						table.getData(_col.territoryCDName,i),
      						table.getData(_col.empID,i),
      						table.getData(_col.empNm,i),
      						table.getData(_col.empTpCDName,i)
      					  ];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      		//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
      		setPageInfo('grid', table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
      	} else {
      		////Paging Function: clearPageInfo(Grid Name);
            clearPageInfo('grid');
      		message("<fmt:message key="info.nullData"/>");
      	}
      	
      	grid.refresh();
	}
    
    function Search(){
    	
    	$("#grid_pageNum").val("1");
    	PagingSearch();
    	New();
	}
    
	function New() {
		
		overLap.setControlVisible(true);
		$("#empID").val("");
		$("#empID_YN").val("N");
  		$("#empNm").val("");
  		$("#empTpCD").val("");
  		$("#rageSphereCD").val("");
  		$("#officeCD").val("");
  		$("#teamCD").val("");
  		$("#territoryCD").val("");
  		
  		if("${params.dkmdTpCD}" != "DK") {
			$("#dkmdTpCD_S").val("${params.dkmdTpCD}");
			$("#dkmdTpCD_S").attr("disabled", true);
			$("#dkmdTpCD_S").addClass("input-readonly");
			$("#dkmdTpCD").val("${params.dkmdTpCD}");
			$("#dkmdTpCD").attr("disabled", true);
			$("#dkmdTpCD").addClass("input-readonly");
		} else {
	  		$("#dkmdTpCD").val("");
		}
  		
  		$("#emailAddr").val("");
  		$("#workStatCD").val("");
  		$("#grpID").val("");
  		$("#userID").val("");
  		
    	try{$("#empID").removeClass("input-readonly")}catch(e){}
  		try{$("#rageSphereCD_td").removeClass("td-cond-required")}catch(e){}
		try{$("#empID").attr("readonly",false)}catch(e){}
		try{$("#empID").attr("disabled",false)}catch(e){}
		$("#rageSphereCD").attr("disabled",false);
		$("#rageSphereCD").removeClass("input-readonly");
		$("#officeCD").attr("disabled",true);
		$("#officeCD").addClass("input-readonly");
		$("#teamCD").attr("disabled",true);
		$("#teamCD").addClass("input-readonly");
		$("#territoryCD").attr("disabled",true);
		$("#territoryCD").addClass("input-readonly");
  		
	}
	
	function Save() {
		
   		if ($("#empID_YN").val() == "N"){
	   		alert("<fmt:message key="MDM01001A.msg16" />");
	   		return false;
   		}
		
		if ($("#empNm").val() == "") {
			alert("<fmt:message key="MDM01001A.msg2" />");
			return;
		}
		if ($("#empTpCD").val() == "") {
			alert("<fmt:message key="MDM01001A.msg3" />");
			return;
		}
		
		if($("#empTpCD").val() == "20"){
			if ($("#rageSphereCD").val() == "") {
				alert("<fmt:message key="MDM01001A.msg8" />");
				return;
			}
		}
		
		if ($("#dkmdTpCD").val() == "") {
			alert("<fmt:message key="MDM01001A.msg4" />");
			return;
		}
		if ($("#emailAddr").val() == "") {
			alert("<fmt:message key="MDM01001A.msg5" />");
			return;
		}
		if ($("#workStatCD").val() == "") {
			alert("<fmt:message key="MDM01001A.msg6" />");
			return;
		}
		if ($("#grpID").val() == "") {
			alert("<fmt:message key="MDM01001A.msg7" />");
			return;
		}
		
		if($("#workStatCD").val() == "01"){
			$("#useYN").val("Y");
			$("#activeFlg").val("U");
		} else if($("#workStatCD").val() == "02"){
			$("#useYN").val("N");
			$("#activeFlg").val("D");
		} 
	
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/mdm01/saveEmployee");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	$("#empID").val($("#empID").val().toUpperCase());
	  	table.setParameter("empID", $("#empID").val());
	  	table.setParameter("empNm", $("#empNm").val());
	  	table.setParameter("empTpCD", $("#empTpCD").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD").val());
	  	table.setParameter("officeCD", $("#officeCD").val());
	  	table.setParameter("teamCD", $("#teamCD").val());
	  	table.setParameter("territoryCD", $("#territoryCD").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD").val());
	  	table.setParameter("emailAddr", $("#emailAddr").val());
	  	table.setParameter("workStatCD", $("#workStatCD").val());
	  	table.setParameter("useYN", $("#useYN").val());
	  	table.setParameter("activeFlg", $("#activeFlg").val());
	  	table.setParameter("grpID", $("#grpID").val());
      	table.request();
      	
      	if (table.getData(0,0) == "S") {
      		message(table.getData(1,0));
      		Search();
      		$("#empID").attr("readonly", true);
      	}
      	else{
      	    alert(table.getData(1,0));
      	}
	}
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "MDM0100102S");
        table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("empID", $("#empID_S").val());
	  	table.setParameter("empNm", $("#empNm_S").val());
	  	table.setParameter("empTpCD", $("#empTpCD_S").val());
		
		var headerText = [
			"<fmt:message key="MDM01001A.dkmdTpCD"/>",
       		"<fmt:message key="MDM01001A.empID"/>",
			"<fmt:message key="MDM01001A.empNm"/>",
			"<fmt:message key="MDM01001A.empTpCode"/>",
			"<fmt:message key="MDM01001A.empTpCDName"/>",
			"<fmt:message key="MDM01001A.rageSphereCode"/>",
			"<fmt:message key="MDM01001A.rageSphereCDName"/>",
			"<fmt:message key="MDM01001A.officeCode"/>",
			"<fmt:message key="MDM01001A.officeCDName"/>",
			"<fmt:message key="MDM01001A.teamCode"/>",
			"<fmt:message key="MDM01001A.teamCDName"/>",
			"<fmt:message key="MDM01001A.territoryCode"/>",
			"<fmt:message key="MDM01001A.territoryCDName"/>",
			"<fmt:message key="MDM01001A.emailAddr"/>",
			"<fmt:message key="MDM01001A.workStatCode"/>",
			"<fmt:message key="MDM01001A.workStatCDName"/>",
			"<fmt:message key="MDM01001A.grpCode"/>",
			"<fmt:message key="MDM01001A.grpName"/>"
		];
		
		table.setParameter("templateFile", "MDM01001A");
		table.setParameter("headerText", headerText);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0,0) == "S") {
			    form.action = "${contextPath}/service/simpleExport/download/?"+
			    		"tempFile="+table.getData(3,0)+
			    		"&downloadFile=${params.viewName}";
			    form.target = "_self";
			    form.submit();
			}
		}
	}
	
	function ExcelUpload() {
		$("#_detail")[0].contentWindow.New();
		appletOpen();
	}
	
</script>


<script type="text/javascript">
    
    /*****************************************************
    *   Grid Setting
    *****************************************************/

	  
	var columns = [
		"<fmt:message key="MDM01001A.rageSphereCD"/>",
		"<fmt:message key="MDM01001A.officeCD"/>", 
		"<fmt:message key="MDM01001A.teamCD"/>", 
		"<fmt:message key="MDM01001A.territory"/>", 
		"<fmt:message key="MDM01001A.empID"/>", 
		"<fmt:message key="MDM01001A.empNm"/>", 
		"<fmt:message key="MDM01001A.empTpCD"/>"
	];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str, str, str, str]);
		grid.setHeaderText(columns);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);
		
		grid.onRowDoubleClicked = function(event, row){
			Detail(this.getCellText(_col.empID,row));
		};
	}
        
</script>