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
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
											<col style="width:100px"></col>
											<col style="width:150px"></col>
											<col style="width:100px"></col>
											<col style="width:200px"></col>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required"><fmt:message key="ANL03002A.fy"/>
												</td>
												<td class="td-input">
													<div id="fy_cond" style="float:left;">
														<select id="fy">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
												</td>
												<td class="td-cond-required"><fmt:message key="ANL03002A.period"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="period" name="period" defaultText="select" category="ESLT_QUARTER2" />
													<span>전체조회</span><input type="checkbox" id="periodChk" name="periodChk" class="checkbox" />
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
															<option value=""><fmt:message key="all" /></option>
														</select>
													</div>
												</td>
												<td class="td-cond"><fmt:message key="ANL03002A.team"/>
												</td>
												<td class="td-input">
													<div id="team_cond" style="float:left;">
														<select id="team">
															<option value=""><fmt:message key="all" /></option>
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
					<td height="*">
						<span id="grid"></span>
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

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 
	rowCount = 0;
	 
	 
	/****************************************
	 * Function
	 ****************************************/
	
	$(document).ready(function() {

		window.onload = function() {
			setFyPeriod();
			
			if("${params.grpID}" != '000001'){
				set_channelRegion();
				$("#region").attr("disabled",true);
	    		$("#region").addClass("input-readonly");
			}else{
				$("#region").attr("disabled",true);
	    		$("#region").addClass("input-readonly");
				$("#team").attr("disabled",true);
	    		$("#team").addClass("input-readonly");
			}
		};
		
		${initScript}
		
		refresh_fy();
		
		$("#periodChk").click(function(){
			if($("#periodChk").is(":checked")) {
				$("#period").val("");
				$("#period").attr("disabled", true);
				$("#ytd").val("P12");
			}
			else {
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
    		$("#team").val("");
			$("#team").attr("disabled",true);
    		$("#team").addClass("input-readonly");
			return;
		}
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0200906S");
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
    		$("#team").val("");
			$("#team").attr("disabled",true);
    		$("#team").addClass("input-readonly");
        }else{
        	$("#region").attr("disabled",false);
    		$("#region").removeClass("input-readonly");
    		$("#team").val("");
			$("#team").attr("disabled",true);
    		$("#team").addClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#region_cond").html(s);
	}
	
	function getTeam(code) {
		if(code=="") {
    		$("#team").val("");
			$("#team").attr("disabled",true);
    		$("#team").addClass("input-readonly");
			return;
		}
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0300205S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","teamCode;teamName;");
        table.setParameter("channel", $("#channel").val());
        table.setParameter("region", code);
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='team'><option value=''><fmt:message key="all"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            
            $("#team").attr("disabled",false);
    		$("#team").removeClass("input-readonly");
            
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
	
	function set_channelRegion() {;
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/ANL0300204S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","channel;region;team;emp1YN;");
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
			$("#team").val(table.getData(2,0));
			
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

		if($("#fy").val() == "" || $("#fy").val() == null) {
			alert("<fmt:message key="ANL03002A.msg1"/>");
			hideLoading();
			$("#fy").focus();
			return ;
		}
		
		if(!$("input:checked[id='periodChk']").is(":checked")) {
			if($("#period").val() == "" || $("#period").val() == null) {
				alert("<fmt:message key="ANL03002A.msg2"/>");
				hideLoading();
				$("#period").focus();
				return ;
			}
		}
				
		if($("#ytd").val() == "" || $("#ytd").val() == null) {
			alert("<fmt:message key="ANL03002A.msg3"/>");
			hideLoading();
			$("#ytd").focus();
			return ;
		}
		
		var Lfy = $("#fy").val().substring(0,2)+($("#fy").val().substring(2,4)-1);
		var period;
		
		if($("#period").val() == "Q1"){
			period = "P01";
		}else if($("#period").val() == "Q2"){
			period = "P04";
		}else if($("#period").val() == "Q3"){
			period = "P07";
		}else{
			period = "P10";
		}
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/anl03Dp/dpExcelSearch");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("Lfy", Lfy);
	  	table.setParameter("fy", $("#fy").val());
	  	
	  	
	  	table.setParameter("period", period);
	  	table.setParameter("period2", $("#period").val());
	  	table.setParameter("ytd", $("#ytd").val());
	  	table.setParameter("channel", $("#channel").val());
	  	table.setParameter("region", $("#region").val());
	  	table.setParameter("team", $("#team").val());
	  	if ($("input:checked[id='periodChk']").is(":checked")) {
	  		table.setParameter("periodChk", "Y");
        }else{
        	table.setParameter("periodChk", "N");
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

</script>

<script type="text/javascript">

	/**********************************************
	* fileupload setting
	**********************************************/
	
	function DownloadToInput(fileName) {
		
		form.action = "${contextPath}/service/anl03Dp/downloadFileDepletion?"+"fileName="+fileName;
		form.target = "downloadFrame";
        form.submit();
        
    }
</script>