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
						        			<col style="width:250px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:300px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="KEY01002A.requestDate" />
												</td>
												<td class="td-input">
													<nis:calendar id="requestDateFrom_S" cssClass="input-readonly" readOnly="yes" /> -
													<nis:calendar id="requestDateTo_S" cssClass="input-readonly" readOnly="yes" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="KEY01002A.venue" />
												</td>
												<td class="td-input">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="KEY01002A.keymanNm" />
												</td>
												<td class="td-input">
													<input type="text" id="keymanNm_S" style="width:100px;">
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="KEY01002A.requestStateCD" />
												</td>
												<td class="td-input" colspan="5">
													<select id="requestStateCD_S" name="requestStateCD_S" ></select>
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
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 80px; text-align:center;}
	.aw-column-1 {width: 80px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:center;}
    .aw-column-3 {width: 150px; text-align:left;}
    .aw-column-4 {width: 100px; text-align:center;}
    .aw-column-5 {width: 100px; text-align:left;}
    .aw-column-6 {width: 80px; text-align:center;}
    .aw-column-7 {width: 80px; text-align:center;}
    .aw-column-8 {width: 250px; text-align:left;}
    .aw-column-9 {width: 100px; text-align:center;}
    .aw-column-10 {width: 80px; text-align:center;}
    .aw-column-11 {width: 120px; text-align:center;}
    .aw-column-12 {width: 100px; text-align:left;}
    .aw-column-13 {width: 80px; text-align:center;}
    .aw-column-14 {width: 80px; text-align:center;}
    .aw-column-15 {width: 100px; text-align:center;}

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
			createGrid();
			grid.refresh();
			
			$("#requestDateFrom_S").val("${params.agoWeekDate}");
			$("#requestDateTo_S").val("${params.currentDate}");
			
			getRequestStateCD();
		};

		${initScript}
		
		$("#venue_S_popup").click(function(){
			openVenuePopup("closeVenuePopup");
		});
		$("#venue_S").keypress(function(){
			if (event.keyCode==13){
				getVenueName("venue_S", "venueCD_S", "venueNm_S");
				if($("#venueCD_S").val()!="") {
					Search();
				}
			}
		});
	});
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	
	function getRequestStateCD() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "REQUESTSTATECD");
// 	  	table.setParameter("attrib03", "VELEX");
     	table.request();
		
     	if(table.getCount() > 0) {
	     	$("#requestStateCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	     		$("#requestStateCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   		}
		}
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		requestDate : _i++
		, requestTpCDName : _i++
		, venueCD : _i++
		, venueNm : _i++
		, keymanID : _i++
		, keymanNm : _i++
		, keymanTypeCDName : _i++
		, birthDate : _i++
		, addr : _i++
		, phoneNo : _i++
		, bankCDName : _i++
		, accountNo : _i++
		, holderNm : _i++
		, pKeymanYN : _i++
		, requestStateCDName : _i++
		, requestTpCD : _i++
		, keymanTypeCD : _i++
		, bankCD : _i++
		, requestStateCD : _i++
		, licenceChkYn : _i++
    };
	
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0100201S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"requestDate;requestTpCDName;venueCD;venueNm;keymanID;"+
	  			"keymanNm;keymanTypeCDName;birthDate;addr;phoneNo;"+
	  			"bankCDName;accountNo;holderNm;pKeymanYN;requestStateCDName;"+
	  			"requestTpCD;keymanTypeCD;bankCD;requestStateCD;licenceChkYn;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;");
	  	table.setParameter("requestDateFrom", convertDate($("#requestDateFrom_S").val()));
	  	table.setParameter("requestDateTo", convertDate($("#requestDateTo_S").val()));
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("keymanNm", $("#keymanNm_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("requestStateCD", $("#requestStateCD_S").val());
	  	table.request();
      	
	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			data[i] = [
					formatDate(table.getData(_col.requestDate,i))
					, table.getData(_col.requestTpCDName,i)
					, table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.keymanID,i)
      			    , table.getData(_col.keymanNm,i)
					, table.getData(_col.keymanTypeCDName,i)
					, formatDate(table.getData(_col.birthDate,i))
					, table.getData(_col.addr,i)
					, table.getData(_col.phoneNo,i)
					, table.getData(_col.bankCDName,i)
					, table.getData(_col.accountNo,i)
					, table.getData(_col.holderNm,i)
					, table.getData(_col.pKeymanYN,i)
					, table.getData(_col.requestStateCDName,i)
					, table.getData(_col.licenceChkYn,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	
      	}
      	
      	grid.refresh();
	}
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "KEY0100201S");
		table.setParameter("requestDateFrom", convertDate($("#requestDateFrom_S").val()));
	  	table.setParameter("requestDateTo", convertDate($("#requestDateTo_S").val()));
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("keymanNm", $("#keymanNm_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("requestStateCD", $("#requestStateCD_S").val());
	  	
		var headerText = [
				"<fmt:message key="KEY01002A.requestDate"/>"
				, "<fmt:message key="KEY01002A.requestTpCD"/>"
				, "<fmt:message key="KEY01002A.venueCD"/>"
				, "<fmt:message key="KEY01002A.venueNm"/>"
				, "<fmt:message key="KEY01002A.keymanID"/>"
				, "<fmt:message key="KEY01002A.keymanNm"/>"
				, "<fmt:message key="KEY01002A.keymanTpCD"/>"
				, "<fmt:message key="KEY01002A.birthDate"/>"
				, "<fmt:message key="KEY01002A.addr"/>"
				, "<fmt:message key="KEY01002A.phoneNo"/>"
				, "<fmt:message key="KEY01002A.bankCD"/>"
				, "<fmt:message key="KEY01002A.accountNo"/>"
				, "<fmt:message key="KEY01002A.holderNm"/>"
				, "<fmt:message key="KEY01002A.pKeymanYN"/>"
				, "<fmt:message key="KEY01002A.requestStateCD"/>"
				, "<fmt:message key="KEY01002A.licenceChkYn"/>"
		];
		
		table.setParameter("templateFile", "KEY01002A");
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
	
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		  "<fmt:message key="KEY01002A.requestDate"/>"
		, "<fmt:message key="KEY01002A.requestTpCD"/>"
		, "<fmt:message key="KEY01002A.venueCD"/>"
		, "<fmt:message key="KEY01002A.venueNm"/>"
		, "<fmt:message key="KEY01002A.keymanID"/>"
		, "<fmt:message key="KEY01002A.keymanNm"/>"
		, "<fmt:message key="KEY01002A.keymanTpCD"/>"
		, "<fmt:message key="KEY01002A.birthDate"/>"
		, "<fmt:message key="KEY01002A.addr"/>"
		, "<fmt:message key="KEY01002A.phoneNo"/>"
		, "<fmt:message key="KEY01002A.bankCD"/>"
		, "<fmt:message key="KEY01002A.accountNo"/>"
		, "<fmt:message key="KEY01002A.holderNm"/>"
		, "<fmt:message key="KEY01002A.pKeymanYN"/>"
		, "<fmt:message key="KEY01002A.requestStateCD"/>"
		, "<fmt:message key="KEY01002A.licenceChkYn"/>"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-cell");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                          str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str 
	                        , str 
	                        ]);
	    grid.setCellEditable(false);
// 	    grid.setFixedLeft(5);
		
    }
	
</script>