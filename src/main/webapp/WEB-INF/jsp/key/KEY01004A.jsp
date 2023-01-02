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
			<div id="wrapDiv">
          		<div id="formDiv">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            	<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/functionbar.jsp" %>
								<%@include file="../sys3/cms/calendar.jsp" %>
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=KEY01004B" />
								<input type="hidden" id="appSrc2" name="appSrc2" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=KEY01004C" />
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
								        			<col style="width:300px;"></col>
								        			<col style="width:100px;"></col>
								        			<col style="width:250px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond">
															<fmt:message key="KEY01004A.venueGradCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
						                                </td>
														<td class="td-cond">
															<fmt:message key="KEY01004A.addrTpCD1" />
														</td>
														<td class="td-input">
															<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY01004A.addrTpCD2" />
														</td>
														<td class="td-input">
															<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
						                                </td>
						                            </tr>
						                            <tr>
														<td class="td-cond">
															<fmt:message key="KEY01004A.venue" />
														</td>
														<td class="td-input">
															<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
						                                </td>
														<td class="td-cond-required">
															<fmt:message key="KEY01004A.requestDate" />
														</td>
														<td class="td-input">
															<nis:calendar id="requestDateFrom_S" cssClass="input-readonly" readOnly="yes" /> -
															<nis:calendar id="requestDateTo_S" cssClass="input-readonly" readOnly="yes" />
						                                </td>
						                                <td class="td-cond">
						                                	<fmt:message key="MDM02001A.activeYN"/>
														</td>
														<td class="td-input">
															<nis:selectbox id="activeYN" name="activeYN" defaultText="all" category="ACTIVEYN" />
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
		                		<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
		                			<tr>
		                				<td width="40%" height="*" valign="top">
											<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
						                   		<tr>
						                   			<td>
														<span id="grid"></span>
													</td>
												</tr>
											</table>
										</td>
										<td width="*">
											<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
						                   		<tr>
						                   			<td class="tit_text01" height="20" valign="top">
														&nbsp;<fmt:message key="KEY01004A.key01" />
													</td>
						                   		</tr>
						                   		<tr>
						                   			<td>
														<span id="grid_key01"></span>
													</td>
												</tr>
												<tr>
													<td height="10">
													</td>
												</tr>
												<tr>
						                   			<td class="tit_text01" height="20" valign="top">
														&nbsp;<fmt:message key="KEY01004A.key02" />
													</td>
						                   		</tr>
												<tr>
													<td>
														<span id="grid_key02"></span>
													</td>
												</tr>
											</table>
										</td>
		                			</tr>
		                		</table>
		                	</td>
						</tr>
						<tr>
							<td height="1">
								<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
								<input type="hidden" id="selectVenueNm" name="selectVenueNm" />
								<input type="hidden" id="selectKeymanID" name="selectKeymanID" />
								<input type="hidden" id="selectRequestDate" name="selectRequestDate" />
								<input type="hidden" id="selectRequestSeq" name="selectRequestSeq" />
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

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid .aw-column-0 {width: 80px; text-align:center;}
    #grid .aw-column-1 {width: 100px; }
	#grid .aw-column-2 {width: 60px; text-align:center;}
    #grid .aw-column-3 {width: 100px; }
    #grid .aw-column-4 {width: 80px; text-align:center;}
    
    #grid_key01 .aw-column-0 {width: 90px; text-align:center;}
    #grid_key01 .aw-column-1 {width: 80px; text-align:center;}
	#grid_key01 .aw-column-2 {width: 80px; text-align:center;}
    #grid_key01 .aw-column-3 {width: 130px; text-align:center;}
    #grid_key01 .aw-column-4 {width: 150px; }
    #grid_key01 .aw-column-5 {width: 100px; text-align:center;}
    #grid_key01 .aw-column-6 {width: 60px; text-align:center;}
    #grid_key01 .aw-column-7 {width: 100px; text-align:center;}
    #grid_key01 .aw-column-8 {width: 90px; text-align:center;}
    #grid_key01 .aw-column-9 {width: 80px; text-align:center;}
    #grid_key01 .aw-column-10 {width: 60px; text-align:center;}
    
    #grid_key02 .aw-column-0 {width: 80px; text-align:center;}
    #grid_key02 .aw-column-1 {width: 80px; text-align:center;}
	#grid_key02 .aw-column-2 {width: 80px; text-align:center;}
    #grid_key02 .aw-column-3 {width: 80px; text-align:center;}
    #grid_key02 .aw-column-4 {width: 80px; text-align:center;}
    #grid_key02 .aw-column-5 {width: 130px; text-align:center;}
    #grid_key02 .aw-column-6 {width: 150px; }
    #grid_key02 .aw-column-7 {width: 100px; text-align:center;}
    #grid_key02 .aw-column-8 {width: 60px; text-align:center;}
    #grid_key02 .aw-column-9 {width: 100px; text-align:center;}
    #grid_key02 .aw-column-10 {width: 90px; text-align:center;}
    #grid_key02 .aw-column-11 {width: 80px; text-align:center;}
    #grid_key02 .aw-column-12 {width: 60px; text-align:center;}

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
			
			createGrid_key01();
			grid_key01.refresh();
			
			createGrid_key02();
			grid_key02.refresh();
			
			$("#requestDateFrom_S").val("${params.agoWeekDate}");
			$("#requestDateTo_S").val("${params.currentDate}");
			
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
    		$("#activeYN").val("Y");
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
		//$("#selectVenueCD").val(data.venueCD);
		//$("#selectVenueNm").val(data.venueNm);
	}
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getAddrTpCD2(code) {
		if(code == "") {
			$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "ADDRTPCD2");
	  	table.setParameter("attrib02", code);
     	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#addrTpCD2_S").attr("disabled",false);
    		$("#addrTpCD2_S").removeClass("input-readonly");
		}
     	else {
     		$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
     	}
	}
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD2Name : _i++
		, activeYNName : _i++
    };
	function Search() {	// 첫번째 그리드 
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0100401S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"venueCD;venueNm;venueGradCDName;subSegmentCDName;addrTpCD2Name;activeYNName;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;str;");
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("activeYN", $("#activeYN").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
      			    table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.activeYNName,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	}
      	grid.refresh();
      	
      	//2015.01.20. taejoon.jang, 업소선택후 조회하면 로직에 맞지 않아 리마크  
      	//2015.02.13. jihye.han, 업소팝업으로 신규 넘어가지않게 수정 후 주석해제
      	$("#selectVenueCD").val("");
      	$("#selectVenueNm").val("");
      	
      	createGrid_key01();
		grid_key01.refresh();
		
      	createGrid_key02();
		grid_key02.refresh();
		
	}
	
	var _i_key01 = 0;
	var _col_key01 = {
		keymanID : _i_key01++
		, keymanNm : _i_key01++
		, keymanTypeCDName : _i_key01++
		, regIDNo : _i_key01++
		, addr : _i_key01++
		, phoneNo : _i_key01++
		, bankCD : _i_key01++
		, accountNo : _i_key01++
		, holderNm : _i_key01++
		, pKeymanYN : _i_key01++
		, activeYNName : _i_key01++
    };
	function Search_key01() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0100402S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"keymanID;keymanNm;keymanTypeCDName;regIDNo;addr;"+
	  			"phoneNo;bankCD;accountNo;holderNm;pKeymanYN;activeYNName;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;str;");
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
	  	table.request();
      	
// 	  	if (grid_key01 != null) grid_key01.clear();
      	createGrid_key01();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			data[i] = [
					table.getData(_col_key01.keymanID,i)
      			    , table.getData(_col_key01.keymanNm,i)
					, table.getData(_col_key01.keymanTypeCDName,i)
					, formatIDNo(table.getData(_col_key01.regIDNo,i), "")
					, table.getData(_col_key01.addr,i)
					, table.getData(_col_key01.phoneNo,i)
					, table.getData(_col_key01.bankCD,i)
					, table.getData(_col_key01.accountNo,i)
					, table.getData(_col_key01.holderNm,i)
					, table.getData(_col_key01.pKeymanYN,i)
					, table.getData(_col_key01.activeYNName,i)
      			];
      		}
      		grid_key01.setCellData(data);
      		grid_key01.setRowCount(rowCount);
      	}
      	
      	grid_key01.refresh();
	}
	
	var _i_key02 = 0;
	var _col_key02 = {
		requestDate : _i_key02++
		, requestTpCDName : _i_key02++
		, keymanID : _i_key02++
		, keymanNm : _i_key02++
		, keymanTypeCDName : _i_key02++
		, regIDNo : _i_key02++
		, addr : _i_key02++
		, phoneNo : _i_key02++
		, bankCD : _i_key02++
		, accountNo : _i_key02++
		, holderNm : _i_key02++
		, pKeymanYN : _i_key02++
		, requestStateCDName : _i_key02++
		, requestSeq : _i_key02++
    };
	function Search_key02() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0100403S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"requestDate;requestTpCDName;keymanID;keymanNm;keymanTypeCDName;"+
	  			"regIDNo;addr;phoneNo;bankCD;accountNo;"+
	  			"holderNm;pKeymanYN;requestStateCDName;requestSeq;");
	  	table.setParameter("format",
	  			"date;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("requestDateFrom", convertDate($("#requestDateFrom_S").val()));
	  	table.setParameter("requestDateTo", convertDate($("#requestDateTo_S").val()));
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
	  	table.request();
      	
// 	  	if (grid_key02 != null) grid_key02.clear();
      	createGrid_key02();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			data[i] = [
					table.getData(_col_key02.requestDate,i)
      			    , table.getData(_col_key02.requestTpCDName,i)
					, table.getData(_col_key02.keymanID,i)
					, table.getData(_col_key02.keymanNm,i)
					, table.getData(_col_key02.keymanTypeCDName,i)
					, formatIDNo(table.getData(_col_key02.regIDNo,i), "")
					, table.getData(_col_key02.addr,i)
					, table.getData(_col_key02.phoneNo,i)
					, table.getData(_col_key02.bankCD,i)
					, table.getData(_col_key02.accountNo,i)
					, table.getData(_col_key02.holderNm,i)
					, table.getData(_col_key02.pKeymanYN,i)
					, table.getData(_col_key02.requestStateCDName,i)
					, table.getData(_col_key02.requestSeq,i)
      			];
      		}
      		grid_key02.setCellData(data);
      		grid_key02.setRowCount(rowCount);
      		
      	}
      	grid_key02.refresh();
	}
	
	function New() {
		if($("#selectVenueCD").val() == "") {
			alert("<fmt:message key="KEY01004A.msg1"/>");
			return;
		}
		
		appletDiv_set({"src":$("#appSrc").val()+"&initAction=New", "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
		appletOpen();
	}
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
       	"<fmt:message key="KEY01004A.venueCD"/>"
		, "<fmt:message key="KEY01004A.venueNm"/>"
		, "<fmt:message key="KEY01004A.venueGradCD"/>"
		, "<fmt:message key="PLN01001A.subSegmentCDName"/>"
		, "<fmt:message key="KEY01004A.addrTpCD2"/>"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                        str, str, str, str, str
	                        ]);
	    grid.setCellEditable(false);
	    
		grid.onRowDoubleClicked = function(event, row){
		  	$("#selectVenueCD").val(this.getCellText(_col.venueCD,row));
		  	$("#selectVenueNm").val(this.getCellText(_col.venueNm,row));
		  	
		  	Search_key01();
		  	Search_key02();
		};
		
    }
	
	var columns_key01 = [
   	    "<fmt:message key="KEY01004A.keymanID"/>"
        , "<fmt:message key="KEY01004A.keymanNm"/>"
   		, "<fmt:message key="KEY01004A.keymanTpCD"/>"
   		, "<fmt:message key="KEY01004A.regIDNo"/>"
   		, "<fmt:message key="KEY01004A.addr"/>"
   		, "<fmt:message key="KEY01004A.phoneNo"/>"
   		, "<fmt:message key="KEY01004A.bankCD"/>"
   		, "<fmt:message key="KEY01004A.accountNo"/>"
   		, "<fmt:message key="KEY01004A.holderNm"/>"
   		, "<fmt:message key="KEY01004A.pKeymanYN"/>"
   		, "<fmt:message key="KEY01004A.activeYN"/>"
   		
   	];
   	var grid_key01 = null;
   	function createGrid_key01() {
   		grid_key01 = new AW.UI.Grid;
   	    grid_key01.setId("grid_key01");
   	    grid_key01.setRowCount(0);
   	    grid_key01.setStyle("width","100%");
   	    grid_key01.setStyle("height","100%");
   	    grid_key01.setSelectorVisible(false);
   	    grid_key01.setSelectionMode("single-row");
   	    grid_key01.setHeaderText(columns_key01);
   	    for(var i=0;i<columns_key01.length;i++){grid_key01.getHeaderTemplate(i).setStyle("text-align", "center");}
   	    grid_key01.setColumnCount(columns_key01.length);
   	    grid_key01.setCellFormat([
   	                        str, str, str, str, str, str, str, str, str, str, str]);
   	    grid_key01.setCellEditable(false);
   	    
   	    grid_key01.onRowDoubleClicked = function(event, row){
   	    	$("#selectKeymanID").val(this.getCellText(_col_key01.keymanID,row));
   	    	
			appletDiv_set({"src":$("#appSrc2").val()+"&initAction=Search", "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
			appletOpen();
   	    	
   		};
       }
	
	var columns_key02 = [
		"<fmt:message key="KEY01004A.requestDate"/>"
		, "<fmt:message key="KEY01004A.requestTpCD"/>"
		, "<fmt:message key="KEY01004A.keymanID"/>"
		, "<fmt:message key="KEY01004A.keymanNm"/>"
		, "<fmt:message key="KEY01004A.keymanTpCD"/>"
		, "<fmt:message key="KEY01004A.regIDNo"/>"
		, "<fmt:message key="KEY01004A.addr"/>"
		, "<fmt:message key="KEY01004A.phoneNo"/>"
		, "<fmt:message key="KEY01004A.bankCD"/>"
		, "<fmt:message key="KEY01004A.accountNo"/>"
		, "<fmt:message key="KEY01004A.holderNm"/>"
		, "<fmt:message key="KEY01004A.pKeymanYN"/>"
		, "<fmt:message key="KEY01004A.requestStateCD"/>"
	];
	var grid_key02 = null;
	function createGrid_key02() {
		grid_key02 = new AW.UI.Grid;
	    grid_key02.setId("grid_key02");
	    grid_key02.setRowCount(0);
	    grid_key02.setStyle("width","100%");
	    grid_key02.setStyle("height","100%");
	    grid_key02.setSelectorVisible(false);
	    grid_key02.setSelectionMode("single-row");
	    grid_key02.setHeaderText(columns_key02);
	    for(var i=0;i<columns_key02.length;i++){grid_key02.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_key02.setColumnCount(columns_key02.length);
	    grid_key02.setCellFormat([
	                        str, str, str, str, str, str, str, str, str, str, str, str, html, str]);
	    grid_key02.setCellEditable(false);
	    
	    grid_key02.onRowDoubleClicked = function(event, row){
	    	$("#selectKeymanID").val(this.getCellText(_col_key02.keymanID,row));
	    	$("#selectRequestDate").val(unformat(this.getCellText(_col_key02.requestDate,row)));
	    	$("#selectRequestSeq").val(this.getCellText(_col_key02.requestSeq,row));
			
	    	appletDiv_set({"src":$("#appSrc").val()+"&initAction=Search", "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
			appletOpen();
		};
    }

</script>