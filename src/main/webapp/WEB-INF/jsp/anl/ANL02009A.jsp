<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
	</head>

	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            	<tr>
                    <td height="1">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
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
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
											<tr>
												<td class="td-cond-required"><fmt:message key="ANL03002A.fy"/>
												</td>
												<td class="td-input">
													<div id="fy_cond" style="float:left;">
														<select id="fy">
															
														</select>
													</div>
												</td>
												<td class="td-cond-required"><fmt:message key="ANL03002A.period"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="period" name="period" defaultText="select" category="ESLT_QUARTER2" />
													전체조회<input type="checkbox" id="allData" name="allData" class="checkbox" value="N">
												</td>
												<td class="td-cond-required"><fmt:message key="ANL03002A.ytd"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="ytd" name="ytd" defaultText="select" category="ESLT_PERIOD" />
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="ANL03002A.channel"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="channel" name="channel" defaultText="all" category="ESLT_CHANNEL" event="onchange" eventproc="getRegion(this.value);" />
				                                </td>
				                                <td class="td-cond"><fmt:message key="ANL03002A.region"/>
												</td>
				                                <td class="td-input">
													<div id="region_cond" style="float:left;">
														<select id="region">
															<option value=''><fmt:message key="all"/>
														</select>
													</div>
												</td>
												<td class="td-cond"><fmt:message key="ANL03002A.branch"/>
												</td>
												<td class="td-input">
													<div id="team_cond" style="float:left;">
														<select id="branch">
															<option value=''><fmt:message key="all"/>
														</select>
													</div>
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
					<td height="*" valign="top">
						<span id="grid"></span>
					</td>
				</tr>
				<tr>
					<td height="*" valign="top">
					</td>
				</tr>
				<tr>
					<td height="1">
						<iframe src="" id="downloadFrame" name="downloadFrame" style="width:0px;height:0px;"></iframe>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 70px; text-align:center;}
	.aw-column-1 {width: 60px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:left;}
    .aw-column-3 {width: 80px; text-align:center;}
    .aw-column-4 {width: 100px; text-align:left;}
    .aw-column-5 {width: 100px; text-align:left;}
    .aw-column-6 {width: 70px; text-align:center;}
    .aw-column-7 {width: 100px; text-align:center;}
    .aw-column-8 {width: 150px; text-align:left;}
    .aw-column-9 {width: 90px; text-align:center;}
    .aw-column-10 {width: 120px; text-align:left;}
    .aw-column-11 {width: 70px; text-align:center;}
    .aw-column-12 {width: 100px; text-align:left;}
    .aw-column-13 {width: 100px; text-align:left;}
    .aw-column-14 {width: 70px; text-align:center;}
    .aw-column-15 {width: 100px; text-align:center;}
    .aw-column-16 {width: 100px; text-align:center;}
    .aw-column-17 {width: 100px; text-align:right;}
    .aw-column-18 {width: 80px; text-align:right;}
    .aw-column-19 {width: 100px; text-align:left;}
    .aw-column-20 {width: 100px; text-align:left;}
    .aw-column-21 {width: 120px; text-align:left;}
    .aw-column-22 {width: 80px; text-align:right;}
    .aw-column-23 {width: 100px; text-align:right;}
    .aw-column-24 {width: 100px; text-align:right;}
    .aw-column-25 {width: 100px; text-align:right;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			setFyPeriod();
			if("${params.grpID}" != '000001'){
				set_channelRegion();
				$("#region").attr("disabled",true);
	    		$("#region").addClass("input-readonly");
				//$("#branch").attr("disabled",true);
	    		//$("#branch").addClass("input-readonly");
			}else{
				$("#region").attr("disabled",true);
	    		$("#region").addClass("input-readonly");
				$("#branch").attr("disabled",true);
	    		$("#branch").addClass("input-readonly");
			}
			
		};

		${initScript}

		refresh_fy();
		
		$("#allData").click(function(){
			if($("#allData").is(":checked")) {
				$("#allData").val("Y");
				$("#period").val("");
				$("#period").attr("disabled", true);
				$("#ytd").val("P12");
			}
			else {
				$("#allData").val("N");
				$("#period").attr("disabled", false);
				$("#ytd").val("");
			}
		});

	});
	
	function refresh_fy() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0300201S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='fy'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#fy_cond").html(s);

	}
	
	function getRegion(code) {
		if(code=="") {
			$("#region").val("");
			$("#region").attr("disabled",true);
    		$("#region").addClass("input-readonly");
    		$("#branch").val("");
			$("#branch").attr("disabled",true);
    		$("#branch").addClass("input-readonly");
			return;
		}
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200908S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","regionCode;regionName;");
        table.setParameter("channel", $("#channel").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='region' onchange='getTeam(this.value)'><option value=''><fmt:message key="all"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            
            $("#region").attr("disabled",false);
    		$("#region").removeClass("input-readonly");
    		$("#branch").val("");
			$("#branch").attr("disabled",true);
    		$("#branch").addClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#region_cond").html(s);
	}
	
	function getTeam(code) {
		if(code=="") {
    		$("#branch").val("");
			$("#branch").attr("disabled",true);
    		$("#branch").addClass("input-readonly");
			return;
		}
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200907S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","teamCode;teamName;");
        table.setParameter("channel", $("#channel").val());
        /* table.setParameter("empid", "${params.userID}"); */
        table.setParameter("region", code);
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='branch'><option value=''><fmt:message key="all"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value="' + table.getData(0,i) + '">'+table.getData(1,i)+'</option>';
            }
            
            $("#branch").attr("disabled",false);
    		$("#branch").removeClass("input-readonly");
            
        }
        s = s + '</select>';
        
        $("#team_cond").html(s);

	}
	
	function setFyPeriod() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0300202S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","fy;period;");
        table.request();
        
        $("#fy").val(table.getData(0,0));
        $("#period").val(table.getData(1,0));

	}
	
	function set_channelRegion() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0300210S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","channel;region;branch;emp1YN;");
        table.setParameter("empID", "${params.userID}");
        table.request();
        
        var rowCount = table.getCount();
       
        if (rowCount > 0) {
			$("#channel").val(table.getData(0,0));
			$("#channel").attr("disabled", true);
			$("#channel").addClass("input-readonly");
			
			getRegion(table.getData(0,0));
			$("#region").val(table.getData(1,0));
			$("#region").attr("disabled", true);
			$("#region").addClass("input-readonly");
			 getTeam(table.getData(1,0));
			$("#branch").val(table.getData(2,0));
			
			/* if(rowCount>=2){
				$("#branch").attr("disabled", false);
				$("#branch").addClass("input");
				
			}else {
				$("#branch").attr("disabled", true);
				$("#branch").addClass("input-readonly");	
			} */
			
			/* if(table.getData(3,0)=="N" || table.getData(3,0)==""){
				$("#branch").attr("disabled", true);
				$("#branch").addClass("input-readonly");
			} else if(table.getData(3,0)=="Y"){
				$("#branch").attr("disabled", false);
				$("#branch").addClass("input");
				
			} */
        }
        
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	function Excel() {
		showLoading();
		if(!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}

		var Lfy = $("#fy").val().substring(0,2)+($("#fy").val().substring(2,4)-1);
		
		if($("#fy").val() == "" || $("#fy").val() == null) {
			alert("회계년을 선택하십시오.");
			hideLoading();
			return ;
		}
		
		if($("#allData").val() != "Y") {
			if($("#period").val() == "" || $("#period").val() == null) {
				alert("회계월을 선택하십시오.");
				hideLoading();
				return ;
			}
		}
				
		if($("#ytd").val() == "" || $("#ytd").val() == null) {
			alert("YTD를 선택하십시오.");
			hideLoading();
			return ;
		}
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/anl03Sh/shExcelSearch");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("Lfy", Lfy);
	  	table.setParameter("fy", $("#fy").val());
	  	table.setParameter("period", $("#period").val());
	  	table.setParameter("ytd", $("#ytd").val());
	  	table.setParameter("channel", $("#channel").val());
	  	table.setParameter("region", $("#region").val());
	  	table.setParameter("branch", $("#branch").val());
	  	table.setParameter("allData", $("#allData").val());
		if($("#channel").val() == "" && $("#region").val() == "" && $("#branch").val() == "") {
			table.setParameter("allParam", "ALL");
		}
	  	table.request();
	  	
	  	if(table.getData(0,0) == "S") {
	  		DownloadToInput(table.getData(3,0));
	  	}
	  	else {
	  		alert(table.getData(1,0));
	  	}
	  	
	  	hideLoading();
	}
	
	function DownloadToInput(fileName) {
		
		form.action = "${contextPath}/service/anl02/downloadFileShipment?"+
					"fileName="+fileName;
		form.target = "downloadFrame";
        form.submit();
        
    }
	
</script>