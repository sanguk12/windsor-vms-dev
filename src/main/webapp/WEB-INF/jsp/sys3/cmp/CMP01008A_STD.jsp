<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<form name="form" method="post">
		<div id="wrapDiv">
        	<div id="formDiv">
           		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
               		<tr>
                   		<td height="1"> 		
							<%@include file="../cms/standardParam.jsp" %>
							<input type="hidden" id="currentUserID" name="currentUserID">
		            		<input type="hidden" id="uniqueYN" name="uniqueYN" value="N">
							<%@include file="../cms/functionbar.jsp" %>
                   		</td>
               		</tr>
               		<tr>
                   		<td height="1">
                   			<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                   				<tr>
                   					<td class="tb-border">
					        			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
					        				<colgroup>
							        			<col style="width:80px;"></col>
							        			<col></col>
							        		</colgroup>
							        		<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01008A.searchWord" />
												</td>
												<td class="td-input">
													<input type="text" id="searchWord" name="searchWord" style="width:200px;" onkeypress="if (event.keyCode==13){Search(); return false;}">
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
               		<tr>
                   		<td height="*"> 
		 					<span id="grid"></span>
                   		</td>
               		</tr>
	                <tr>
                   		<td height="1"> 			
		 					<div id="tabs" class="yui-navset" style="margin-top: 5px;">
					    		<ul class="yui-nav">
					        		<li class="selected"><a href="#tab1"><em><fmt:message key="CMP01008A.basic"/></em></a></li>
					        		<li ><a href="#tab2"><em><fmt:message key="CMP01008A.organization"/></em></a></li>
					        		<li ><a href="#tab3"><em><fmt:message key="CMP01008A.individual"/></em></a></li>
					    		</ul>
					    		<div class="yui-content">
					        		<div id="tab1">
		                        		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
		                        			<colgroup>
				                        		<col style="width:80px"></col>
				                        		<col style="width:200px"></col>
												<col style="width:80px"></col>
												<col style="width:180px"></col>
												<col style="width:80px"></col>
												<col></col>
							        		</colgroup>
							        		<tbody>
		                            		<tr>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01008A.userID" />
				                                </td>
				                                <td class="td-input">
				                                    <input type="text" id="userID" name="userID" style="width:100px; maxlength="20">
				                                    <div id="overLap"></div>
				                                </td>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01008A.userName" />
				                                </td>
				                                <td class="td-input">
				                                   <input type="text" id="userName" name="userName" style="width:140px;">
				                                </td>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01008A.passwd" />
				                                </td>
				                                <td class="td-input">
				                                    <input type="password" id="passwd" name="passwd" style="width:100px; maxlength="20">
				                                    <script type="text/javascript">
					                                    var initPW = new AW.UI.Button;
					                                    initPW.setControlText("<fmt:message key="button.Init" />");
					                                    document.write(initPW);
					                                    
					                                    initPW.onControlClicked = function(event){
						                                    $("#passwd").val("INIT");
					                                    }
				                                    </script> 
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01008A.grpName" />
				                                </td>
				                                <td class="td-input">
				                                   <nis:selectbox id="grpID" name="grpID" defaultText="select" query="CMP0100901S" paramkey="companyID;x;" paramvalue="${params.companyID};x;" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.mnuConstructName" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:selectbox id="mnuConstructID" name="mnuConstructID" defaultText="select" query="CMP0100701S" paramkey="companyID;x;" paramvalue="${params.companyID};x;" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.useYN" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:radio id="useYN" name="useYN" category="USETYPE2CD" value="Y" />
				                                </td>
				                            </tr>
				                            </tbody>
				                        </table>
					        		</div>
							        <div id="tab2">
							            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
							            	<colgroup>
				                        		<col style="width:80px"></col>
				                        		<col style="width:150px"></col>
												<col style="width:80px"></col>
												<col style="width:230px"></col>
												<col style="width:80px"></col>
												<col></col>
							        		</colgroup>
							        		<tbody>
				                            <tr>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01008A.authLevel" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:selectbox id="authLevelCD" defaultText="select" category="AUTHLEVELCD" />
				                                </td>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01008A.company" />
				                                </td>
				                                <td class="td-input">
				                                   <nis:selectbox id="companyID" defaultText="select" query="commonservice.auth.companyCombo.select" paramkey="x;" paramvalue="x;" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.organization" />
				                                </td>
				                                <td class="td-input">
				                                	<nis:popup id="orgCD" nameID="orgName" keyID="orgID"/>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.partnerDiv" />
				                                </td>
				                                <td class="td-input">
				                                   <nis:selectbox id="partnerDivCD" style="width:100px;" defaultText="select" category="PARTNERDIVCD" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.partner" />
				                                </td>
				                                <td class="td-input">
				                                	<nis:popup id="partnerCD" nameID="partnerName" keyID="partnerID"/>
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.employee" />
				                                </td>
				                                <td class="td-input">
				                                	<nis:popup id="empCD" nameID="empName" keyID="empID"/>
				                                </td>
				                            </tr>
				                            </tbody>
				                        </table>
							        </div>
				                    <div id="tab3">
				                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
				                        	<colgroup>
				                        		<col style="width:80px"></col>
				                        		<col style="width:200px"></col>
												<col style="width:80px"></col>
												<col style="width:200px"></col>
												<col style="width:80px"></col>
												<col></col>
							        		</colgroup>
							        		<tbody>
				                            <tr>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.theme" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:selectbox id="themeCD" defaultText="select" category="THEMECD" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.timezone" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:selectbox id="timezoneCD" defaultText="select" category="TIMEZONECD" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.language" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:selectbox id="languageCD" defaultText="select" category="LANGUAGECD" />
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.currency" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:selectbox id="currencyCD" defaultText="select" category="CURRENCYCD" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.locale" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:selectbox id="localeCD" defaultText="select" category="LOCALECD" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.dateFormat" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:selectbox id="dateFormatCD" defaultText="select" category="DATEFORMATCD" />
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01008A.amtFormat" />
				                                </td>
				                                <td class="td-input" colspan="5">
				                                    <nis:selectbox id="amtFormatCD" defaultText="select" category="AMTFORMATCD" />
				                                </td>
				                            </tr>
				                            </tbody>
				                        </table>
				                    </div>
							    </div>
							</div>
				 			<script type="text/javascript">
				                var tabView = new YAHOO.widget.TabView('tabs');
				            </script>
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
    
    .aw-column-0 {width: 120px;}
    .aw-column-1 {width: 120px;}
    .aw-column-2 {width: 120px;}
    .aw-column-3 {width: 120px; text-align:center;}
    .aw-column-4 {width: 80px; text-align:center;}
    .aw-column-5 {width: 140px; text-align:center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}

//-->
</style>


<script type="text/javascript">

	/****************************************
	 * Function
	 ****************************************/
	$(function() {
		try{$("#userID").alphanumeric();}catch(e){}
	 	try{$("#passwd").alphanumeric();}catch(e){}
	});
		
	$(document).ready(function() {
		
		window.onload = function() {
			$("#searchWord").focus();
			Search();
			New();
		};
	
		${initScript}

		$("#userID").keypress(function(){
			if (event.keyCode==13){
				$("#userName").focus();
				return false;
			}
		});

		$("#userID").blur(function(){
			$("#userID").val($("#userID").val().toUpperCase());
		});

		
		$("#orgCD").keypress(function(){
			if (event.keyCode==13){
				$("#partnerDivCD").focus();
				return false;
			}
		});

		$("#orgCD").blur(function(){
			if ($("#companyID").val() == "" && $("#orgCD").val() != "") {
	            alert("<fmt:message key="CMP01008A.msg8"/>");
	            $("#orgCD").val("");
	            $("#companyID").focus();
	            return;
	        }
			getOrgName("orgCD","orgName","orgID", $("#companyID").val());
		});

		$("#orgCD_popup").click(function(){
			// 회사 선택 후 조직 지정함
	        if ($("#companyID").val() == "") {
	            alert('<fmt:message key="CMP01008A.msg8"/>');
	            $("#companyID").focus();
	            return;
	        }
			openOrgPopup("closeOrgPopup");
		});

		$("#partnerCD").keypress(function(){
			if (event.keyCode==13){
				$("#empCD").focus();
				return false;
			}
		});

		$("#partnerCD").blur(function(){

			if ($("#partnerCD").val() != "") {
				if ($("#companyID").val() == "") {
		            alert("<fmt:message key="CMP01008A.msg8"/>");
		            $("#partnerCD").val("");
		            $("#companyID").focus();
		            return;
		        }
				else if ($("#partnerDivCD").val() == "") {
		            alert("<fmt:message key="CMP01008A.msg9"/>");
		            $("#partnerCD").val("");
		            $("#partnerDivCD").focus();
		            return;
		        }
			}
			getPartnerName("partnerCD","partnerName","partnerID", $("#partnerDivCD").val(), $("#companyID").val());
		});

		$("#partnerCD_popup").click(function(){

			if ($("#companyID").val() == "") {
	            alert("<fmt:message key="CMP01008A.msg8"/>");
	            $("#companyID").focus();
	            return;
	        }
			else if ($("#partnerDivCD").val() == "") {
	            alert("<fmt:message key="CMP01008A.msg9"/>");
	            $("#partnerDivCD").focus();
	            return;
	        }
			openPartnerPopup("closePartnerPopup");
		});

		$("#empCD").keypress(function(){
			if (event.keyCode==13){
				$("#empName").focus();
				return false;
			}
		});

		$("#empCD").blur(function(){
			if ($("#empCD").val() != "") {
				if ($("#companyID").val() == "") {
		            alert("<fmt:message key="CMP01008A.msg8"/>");
		            $("#empCD").val("");
		            $("#companyID").focus();
		            return;
		        }
				else if ($("#partnerCD").val() == "") {
		            alert("<fmt:message key="CMP01008A.msg10"/>");
		            $("#empCD").val("");
		            $("#partnerCD").focus();
		            return;
		        }
			}
			
			getEmpName("empCD","empName","empID", $("#partnerID").val(), $("#companyID").val());
		});

		$("#empCD_popup").click(function(){
			if ($("#companyID").val() == "") {
	            alert("<fmt:message key="CMP01008A.msg8"/>");
	            $("#companyID").focus();
	            return;
	        }
			else if ($("#partnerCD").val() == "") {
	            alert("<fmt:message key="CMP01008A.msg10"/>");
	            $("#partnerCD").focus();
	            return;
	        }
			openEmpPopup("closeEmpPopup");
		});
			
	});

    function closeOrgPopup(data) {
    	$("#orgCD").val(data.orgCD);
        $("#orgName").val(data.orgName);
        $("#orgID").val(data.orgID);
    }

    function closePartnerPopup(data) {
    	$("#partnerCD").val(data.partnerCD);
        $("#partnerName").val(data.partnerName);
        $("#partnerID").val(data.partnerID);
    }
    
    function closeEmpPopup(data) {
        $("#empCD").val(data.empCD);
        $("#empName").val(data.empName);
        $("#empID").val(data.empID);
    }


    //중복확인 버튼 생성
     var overLap = new AW.UI.Button;
     overLap.setId("overLap");
     overLap.setControlText("<fmt:message key="button.Overlap"/>");
     overLap.refresh();
      
     overLap.onControlClicked = function(event){
        
        if ($("#userID").val() == '') {
            alert('<fmt:message key="CMP01008A.msg5"/>');
            return;
        }
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0100801S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","count;");
        table.setParameter("regUserID", $("#userID").val());
        table.request();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            if (table.getData(0,0) != '0') {
                $("#uniqueYN").val('N');
                alert('<fmt:message key="CMP01008A.msg1"/>');
                $("#userID").val('');
                $("#userID").focus();
            }
            else {
                $("#uniqueYN").val('Y');
                $("#currentUserID").val($("#userID").val());
                alert('<fmt:message key="CMP01008A.msg2"/>');
                $("#userName").focus();
            }
        }
        else {
            $("#uniqueYN").val('N');
            alert('<fmt:message key="CMP01008A.msg3"/>');
        }
     }


    function New() {
        
        overLap.setControlVisible(true); //setStyle("visibility","visible");
        document.getElementById("userID").readOnly = false;
        $("#uniqueYN").val("N");
        
        $("#userID").val("");
        $("#userName").val("");
        $("#passwd").val("");
        setRadioValue("useYN","Y");
        $("#mnuConstructID").val("");
        $("#grpID").val("");
        $("#authLevelCD").val("");
        $("#companyID").val("");
        $("#partnerDivCD").val("");
        $("#orgCD").val("");
        $("#orgID").val("");
        $("#orgName").val("");
        $("#partnerCD").val("");
        $("#partnerID").val("");
        $("#partnerName").val("");
        $("#empCD").val("");
        $("#empID").val("");
        $("#empName").val("");
        $("#themeCD").val("blue");
        $("#timezoneCD").val("GP0900");
        $("#languageCD").val("KOREAN");
        $("#currencyCD").val("KR");
        $("#localeCD").val("KOREA");
        
        $("#dateFormatCD").val("YYYYMMDD");
        $("#amtFormatCD").val("#,##0");

    }
    
    function Save() {
    	
        if ($("#uniqueYN").val() == 'N'){
            alert('<fmt:message key="CMP01008A.msg4"/>');
            return;
        }
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/user/saveUser");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("userID", $("#userID").val());
        table.setParameter("userName", $("#userName").val());
        table.setParameter("passwd", $("#passwd").val());
        table.setParameter("grpID", $("#grpID").val());
        table.setParameter("mnuConstructID", $("#mnuConstructID").val());
        table.setParameter("useYN", getRadioValue("useYN"));
        table.setParameter("authLevelCD", $("#authLevelCD").val());
        table.setParameter("companyID", $("#companyID").val());
        table.setParameter("orgID", $("#orgID").val());
        table.setParameter("partnerID", $("#partnerID").val());
        table.setParameter("empID", $("#empID").val());
        table.setParameter("themeCD", $("#themeCD").val());
        table.setParameter("timezoneCD", $("#timezoneCD").val());
        table.setParameter("languageCD", $("#languageCD").val());
        table.setParameter("currencyCD", $("#currencyCD").val());
        table.setParameter("localeCD", $("#localeCD").val());
        table.setParameter("dateFormatCD", $("#dateFormatCD").val());
        table.setParameter("amtFormatCD", $("#amtFormatCD").val());
        table.request();
        
        if (table.getData(0,0) == 'S') {
            message(table.getData(1,0));
            Search();
        }
        else {
           alert(table.getData(1,0));
        }
    }
    
    function Delete() {
        
        if (confirm("<fmt:message key="confirm.delete"/>")) {
            
            var table = new AW.XML.Table;
            table.setURL("${contextPath}/service/user/removeUser");
            table.setAsync(false);
            table.setRequestMethod("POST");
            table.setParameter("userID", $("#userID").val());
            table.setParameter("grpID", $("#grpID").val());
            table.request();
            
            if (table.getData(0,0) == 'S') {
                message(table.getData(1,0));
                Search();
                New();
            }
            else {
               alert(table.getData(1,0));
            }
        }
    }
    
    // MenuConstruct Auth Popup
    function openMenuAuthPopup(userID, mnuConstructID) {
        if(mnuConstructID!="") {
            var param = "/initAuthMenuConstruct/?";
            param += "userID="+userID;
            param += "&mnuConstructID="+mnuConstructID;
            param += "&mnuGrpID=${params.mnuGrpID}";
            param += "&pgmID=${params.pgmID}";
            param += "&viewID=CMP01009C";
            newWindow("${contextPath}/service/auth"+param, "CMP01009C", 760, 557, "no");
        } else {
            alert("<fmt:message key="infos.selected" />");
        }
    }
    
    function Search() {

        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0100802S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","userID;userName;grpName;mnuConstructName;useYN;passwd;mnuConstructID;");
        table.setParameter("searchWord", $("#searchWord").val());
        table.request();

        if (grid != null) grid.clear();
        createGrid();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
                data[i] = [
                    table.getData(0,i),
                    table.getData(1,i),
                    table.getData(2,i),
                    table.getData(3,i),
                    table.getData(4,i),
                    ((table.getData(6,i)!='')?"<fmt:message key="button.MenuAuthSetting"/>":""),
                    table.getData(6,i)
                ];
                if (table.getData(6,i) != '')
                {
                    grid.setCellLink("javascript:openMenuAuthPopup('"+table.getData(0,i)+"', '"+table.getData(6,i)+"');", 5, i);
                }                            
            }
            grid.setCellData(data);
            grid.setRowCount(rowCount);
        } else {
            message("<fmt:message key="info.nullData"/>");
        }
        grid.refresh();
    }
    
    /*****************************************************
    *   Grid Setting
    *****************************************************/
    var grid = null;
    
    var columns = [
        "<fmt:message key="CMP01008A.userID"/>",
        "<fmt:message key="CMP01008A.userName"/>",
        "<fmt:message key="CMP01008A.grpName"/>",
        "<fmt:message key="CMP01008A.mnuConstructName"/>",
        "<fmt:message key="CMP01008A.useYN"/>",
        "<fmt:message key="button.MenuAuthSetting" />"
    ];
    
    function createGrid() {
    
        grid = new AW.UI.Grid;
        grid.setId("grid");
        grid.setSelectorWidth(40);
        grid.getSelectorTemplate().setStyle("text-align", "right");
        grid.setSelectorVisible(true);
        grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
        grid.setSelectionMode("single-cell");
        grid.setCellEditable(false);
        grid.setHeaderText(columns);
        for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
        grid.setColumnCount(columns.length);
        grid.setCellFormat([str, str, str, str, str, str]);
        
        grid.setCellTemplate(new AW.Templates.Link, 5);
        
        grid.onRowDoubleClicked = function(event, row){
        
            var table = new AW.XML.Table;
	        table.setURL("${contextPath}/service/simpleAction/CMP0100803S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("outParamKey","userID;userName;passwd;useYN;mnuConstructID;grpID;authLevelCD;companyID;partnerDivCD;"+
	    	        "orgID;orgName;partnerID;partnerName;empID;empName;themeCD;timezoneCD;languageCD;currencyCD;localeCD;"+
	    	        "orgCD;partnerCD;empCD;dateFormatCD;amtFormatCD;");
	        table.setParameter("userID_con", this.getCellText(0,row));
	        table.request();
	        
	        var rowCount = table.getCount();
	        if (rowCount > 0) {
	            overLap.setControlVisible(false); //("visibility","hidden");
	            document.getElementById("userID").className = 'input-readonly';
	            document.getElementById("userID").readOnly = true;
	            $("#uniqueYN").val('Y');
	            
	            $("#userID").val(table.getData(0,0));
	            $("#userName").val(table.getData(1,0));
	            $("#passwd").val(table.getData(2,0));
                setRadioValue("useYN",table.getData(3,0));
                $("#mnuConstructID").val(table.getData(4,0));
                $("#grpID").val(table.getData(5,0));
                $("#authLevelCD").val(table.getData(6,0));
                $("#companyID").val(table.getData(7,0));
                $("#partnerDivCD").val(table.getData(8,0));
                $("#orgID").val(table.getData(9,0));
                $("#orgName").val(table.getData(10,0));
                $("#partnerID").val(table.getData(11,0));
                $("#partnerName").val(table.getData(12,0));
                $("#empID").val(table.getData(13,0));
                $("#empName").val(table.getData(14,0));
                $("#themeCD").val(table.getData(15,0));
                $("#timezoneCD").val(table.getData(16,0));
                $("#languageCD").val(table.getData(17,0));
                $("#currencyCD").val(table.getData(18,0));
                $("#localeCD").val(table.getData(19,0));
                $("#orgCD").val(table.getData(20,0));
                $("#partnerCD").val(table.getData(21,0));
                $("#empCD").val(table.getData(22,0));
                $("#dateFormatCD").val(table.getData(23,0));
                $("#amtFormatCD").val(table.getData(24,0));
	        }
        }
    }
</script>
