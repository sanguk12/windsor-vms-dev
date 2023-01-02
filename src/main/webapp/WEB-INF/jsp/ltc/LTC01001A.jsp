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
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=LTC01001B" />
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
														<td class="td-cond-required">
															<fmt:message key="LTC01001A.contractDate" />
														</td>
														<td class="td-input">
															<nis:selectbox id="contractDateFrom_yearCD" name="contractDateFrom_yearCD" defaultText="none" category="YEARCD"/>
															<nis:selectbox id="contractDateFrom_monthCD" name="contractDateFrom_monthCD" defaultText="none" category="MONTHCD"/> - 
															<nis:selectbox id="contractDateTo_yearCD" name="contractDateTo_yearCD" defaultText="none" category="YEARCD"/>
															<nis:selectbox id="contractDateTo_monthCD" name="contractDateTo_monthCD" defaultText="none" category="MONTHCD"/>
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="LTC01001A.apprStateCD" />
														</td>
														<td class="td-input" colspan="3">
															<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="all" category="LTCSTATECD" />
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond">
															<fmt:message key="LTC01001A.rageSphereCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="LTC01001A.officeCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="LTC01001A.venue" />
														</td>
														<td class="td-input">
															<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
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
		                	<td height="1">
		                		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                					<colgroup>
			        					<col style="width:60px;"></col>			        			
			        					<col></col>
			        				</colgroup>
			        				<tbody>
			        					<tr>
											<td class="tit_text01">
												<fmt:message key="LTC01001A.myAppr" />
											</td>
											<td class="tit_text01">
												<span id="myAppr" />
	                                		</td>	                                
	                            		</tr>
			        				</tbody>
		        				</table>		        				
                			</td>                	
                		</tr>
		                <tr>
							<td height="*" valign="top">
								<span id="grid"></span>
							</td>
						</tr>
						<tr>
                    		<td class="td-paging">
                        		<nis:paging id="grid" titleDisable="no" callback="PagingSearch()"/>
                    		</td>
                		</tr>
						<tr>
							<td height="1">
								<input type="hidden" id="selectSupportID" name="selectSupportID" />
								<input type="hidden" id="apprTpID" name="apprTpID" value="000000" /><!-- Plan/Result 승인라인 -->
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

	.aw-column-0 {width: 35px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:center;}
    .aw-column-3 {width: 150px; text-align:left;}
    .aw-column-4 {width: 70px; text-align:center;}
    .aw-column-5 {width: 100px; text-align:left;}
    .aw-column-6 {width: 100px; text-align:left;}
    .aw-column-7 {width: 70px; text-align:center;}
    .aw-column-8 {width: 100px; text-align:center;}
    .aw-column-9 {width: 100px; text-align:center;}
    .aw-column-10 {width: 100px; text-align:center;}
    .aw-column-11 {width: 80px; text-align:center;} 
    .aw-column-12 {width: 100px; text-align:right;}
    .aw-column-13 {width: 100px; text-align:right;}
    .aw-column-14 {width: 100px; text-align:right;}
    .aw-column-15 {width: 80px; text-align:right;}
    .aw-column-16 {width: 100px; text-align:right;}
    .aw-column-17 {width: 100px; text-align:right;}
    .aw-column-18 {width: 70px; text-align:center;}

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
			
			$("#grid_displayNum").val("100");
			createGrid();
			grid.refresh();
			if("${params.eventym}"==""){
				var contractDateTo_clientDate = getContractDate("${params.clientDate}");
			    $("#contractDateFrom_yearCD").val("${params.clientDate}".substring(0,4));
				$("#contractDateFrom_monthCD").val("${params.clientDate}".substring(4,6));
			    $("#contractDateTo_yearCD").val(contractDateTo_clientDate.substring(0,4));
				$("#contractDateTo_monthCD").val(contractDateTo_clientDate.substring(4,6));
			}else{
				var contractDateTo_eventym = getContractDate("${params.eventym}");
				$("#contractDateFrom_yearCD").val("${params.eventym}".substring(0,4));
				$("#contractDateFrom_monthCD").val("${params.eventym}".substring(4,6));
				$("#contractDateTo_yearCD").val(contractDateTo_eventym.substring(0,4));
				$("#contractDateTo_monthCD").val(contractDateTo_eventym.substring(4,6));
			}
			getMyAppr();
			
			if("${params.eventym}"!=""){
				$("#apprStateCD_S").val("40");
				Search();
			}
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
	
	function getContractDate(date){
		var yyyy = parseInt(date.substring(0,4),'10');
		var mm = parseInt(date.substring(4,6),'10')+2;
		var year_s,month_s;
		if(mm>12){
			yyyy=yyyy+1;
			mm=mm-12;
			year_s=yyyy.toString();
			month_s=mm.toString();
		}else{
			year_s=yyyy.toString();
			month_s=mm.toString();
		}
		if (month_s.length < 2){month_s = '0' + month_s;}
		
		return year_s+month_s;
	}
	
	function getMyAppr() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03006S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.request();
		
		if(table.getCount() > 0) {
			$("#myAppr").text(table.getData(0,0));
		}
	}
	
	var _col_cd = {
			"code" : 0
			, "name" : 1
		}
	
	function getOfficeCD(code) {
		if(code=="") {
			$("#officeCD_S").val("");
			$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "OFFICECD");
	  	table.setParameter("attrib02", code);
	  	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#officeCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#officeCD_S").attr("disabled",false);
    		$("#officeCD_S").removeClass("input-readonly");
     	}
	}
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	function Search() {
		$("#grid_pageNum").val("1");
		PagingSearch();
	}
	
	var _i = 0;
	var _col = {
		checkbox : _i++
		, supportID : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCD : _i++
		, segmentCD : _i++
		, subSegmentCD : _i++
		, addrTpCD1 : _i++
		, addrTpCD2 : _i++
		, contractDateFrom : _i++
		, contractDateTo : _i++
		, contractMonthCt : _i++
		, minContractQty : _i++
		, targetRate : _i++
		, addPayRate : _i++
		, gsvRate : _i++
		, tcontractAmt : _i++
		, tpayAmt : _i++
		, apprStateCDNm : _i++
		, apprStateCD : _i++
		, rowNum : _i++
		, totalCount : _i++
    }; 
	function PagingSearch() {
		if($("#contractDateFrom_yearCD").val()+$("#contractDateFrom_monthCD").val()>$("#contractDateTo_yearCD").val()+$("#contractDateTo_monthCD").val()){
			alert("<fmt:message key="LTC01001A.msg8"/>");
			return;
		}
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0100101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;supportID;venueCD;venueNm;venueGradCD;"+
	  			"segmentCD;subSegmentCD;addrTpCD1;addrTpCD2;contractDateFrom;"+
	  			"contractDateTo;contractMonthCt;minContractQty;targetRate;addPayRate;"+
	  			"gsvRate;tcontractAmt;tpayAmt;apprStateCDNm;apprStateCD;"+
	  			"rowNum;totalCount;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;num;num;num5;num;"+
	  			"num;num;num;str;str;"+
	  			"str;str;");
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("contractDateFrom", $("#contractDateFrom_yearCD").val()+$("#contractDateFrom_monthCD").val());
	  	table.setParameter("contractDateTo", $("#contractDateTo_yearCD").val()+$("#contractDateTo_monthCD").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("venue_S", $("#venue_S").val());
	  	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
	  	table.request();
      	
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
					, table.getData(_col.supportID,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCD,i)
					, table.getData(_col.segmentCD,i)
					, table.getData(_col.subSegmentCD,i)
					, table.getData(_col.addrTpCD1,i)
					, table.getData(_col.addrTpCD2,i)
					, table.getData(_col.contractDateFrom,i).substring(0,4)+"."+table.getData(_col.contractDateFrom,i).substring(4,6)
					, table.getData(_col.contractDateTo,i).substring(0,4)+"."+table.getData(_col.contractDateTo,i).substring(4,6)
					, table.getData(_col.contractMonthCt,i)
					, table.getData(_col.minContractQty,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.addPayRate,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.tcontractAmt,i)
					, table.getData(_col.tpayAmt,i)
					, table.getData(_col.apprStateCDNm,i)
					, table.getData(_col.apprStateCD,i)
      			];
			}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
            setPageInfo('grid', table.getData(_col.rowNum, 0), table.getData(_col.rowNum, rowCount - 1), table.getData(_col.totalCount, 0));
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	}
      	grid.refresh();
	}
	
	function New() {
		$("#selectSupportID").val("");
		$("#_detail")[0].contentWindow.New();
		appletOpen();
	}
	
	function RequestApp(){
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var supportIDs = new Array();
		var count = 0;
		for (var i=0;i<index.length;i++){
			if (grid.getCellValue(_col.checkbox, index[i])){
				supportIDs[count] = grid.getCellText(_col.supportID, index[i]);
				count++;
			}
		}
		
		if(count==0) {
			alert("<fmt:message key="info.validate.gridSelect"/>");
			return;
		}
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//상태가 등록일 경우만 가능
				if(grid.getCellText(_col.apprStateCD, index[i]) != "10") {
					alert("<fmt:message key="LTC01001A.msg1"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="LTC01001A.msg2"/>")){
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ltc01/requestApp");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("supportIDs", supportIDs);
		table.setParameter("apprStateCD", "20");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("empID", "${params.empID}");
		table.request();
		
		if(table.getData(0,0) == "S"){
			message(table.getData(1,0));
			Search();
		}else {
			alert(table.getData(1,0));
		}
	}
	
	function ClearRequestApp(){
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var supportIDs = new Array();
		var count = 0;
		for (var i=0;i<index.length;i++){
			if (grid.getCellValue(_col.checkbox, index[i])){
				supportIDs[count] = grid.getCellText(_col.supportID, index[i]);
				count++;
			}
		}
		
		if(count==0) {
			alert("<fmt:message key="info.validate.gridSelect"/>");
			return;
		}
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//상태가 승인요청일 경우만 가능
				if(grid.getCellText(_col.apprStateCD, index[i]) != "20") {
					alert("<fmt:message key="LTC01001A.msg3"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="LTC01001A.msg4"/>")){
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ltc01/clearRequestApp");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("supportIDs", supportIDs);
		table.setParameter("apprStateCD", "10");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("empID", "${params.empID}");
		table.request();
		
		if(table.getData(0,0) == "S"){
			message(table.getData(1,0));
			Search();
		}else {
			alert(table.getData(1,0));
		}
			
	}
	
	function Excel() {
		if($("#contractDateFrom_yearCD").val()+$("#contractDateFrom_monthCD").val()>$("#contractDateTo_yearCD").val()+$("#contractDateTo_monthCD").val()){
			alert("<fmt:message key="LTC01001A.msg8"/>");
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "LTC0100108S");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("contractDateFrom", $("#contractDateFrom_yearCD").val()+$("#contractDateFrom_monthCD").val());
	  	table.setParameter("contractDateTo", $("#contractDateTo_yearCD").val()+$("#contractDateTo_monthCD").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("venue_S", $("#venue_S").val());
	  	
		var headerText = [
			"<fmt:message key="LTC01001A.supportID"/>"
			, "<fmt:message key="LTC01001A.venueCD"/>"
			, "<fmt:message key="LTC01001A.venueNm"/>"
			, "<fmt:message key="LTC01001A.venueGradCD"/>"
			, "<fmt:message key="LTC01001A.segmentCD"/>"
			, "<fmt:message key="LTC01001A.subSegmentCD"/>"
			, "<fmt:message key="LTC01001A.addrTpCD1"/>"
			, "<fmt:message key="LTC01001A.addrTpCD2"/>"
			, "<fmt:message key="LTC01001A.contractDateFrom"/>"
			, "<fmt:message key="LTC01001A.contractDateTo"/>"
			, "<fmt:message key="LTC01001A.contractMonthCt"/>"
			, "<fmt:message key="LTC01001A.threeMonthAvgTQty"/>"
			, "<fmt:message key="LTC01001A.minContractQty"/>"
			, "<fmt:message key="LTC01001A.targetRate"/>"
			, "<fmt:message key="LTC01001A.addPayRate"/>"
			, "<fmt:message key="LTC01001A.gsvRate"/>"
			, "<fmt:message key="LTC01001A.tcontractAmt"/>"
			, "<fmt:message key="LTC01001A.tpayAmt"/>"
			, "<fmt:message key="LTC01001A.apprStateCD"/>"
			, "<fmt:message key="LTC01001B.kindTpCD5"/>"
			, "<fmt:message key="LTC01001B.prdNm"/>"
			, "<fmt:message key="LTC01001B.factoryPrice"/>"
			, "<fmt:message key="LTC01001B.threeMonthAvgQty"/>"
			, "<fmt:message key="LTC01001B.qtyUnitCD"/>"
			, "<fmt:message key="LTC01001B.enterQty"/>"
			, "<fmt:message key="LTC01001B.enterUnitAmt"/>"
			, "<fmt:message key="LTC01001B.contractAmt"/>" 
			, "<fmt:message key="LTC01001B.NSV"/>"
			, "<fmt:message key="LTC01001B.GP"/>"
			, "<fmt:message key="LTC01001B.GPRate"/>"
			];

		table.setParameter("templateFile", "LTC01001A");
		table.setParameter("headerText", headerText);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0, 0) == "S") {
				form.action = "${contextPath}/service/simpleExport/download/?"
						+ "tempFile=" + table.getData(3, 0)
						+ "&downloadFile=${params.viewName}";
				form.target = "_self";
				form.submit();
			}
		}
	}
	
	function ContractCancel(){
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var supportIDs = new Array();
		var count = 0;
		for (var i=0;i<index.length;i++){
			if (grid.getCellValue(_col.checkbox, index[i])){
				supportIDs[count] = grid.getCellText(_col.supportID, index[i]);
				count++;
			}
		}
		
		if(count==0) {
			alert("<fmt:message key="info.validate.gridSelect"/>");
			return;
		}
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//상태가 승인일 경우만 가능
				if(grid.getCellText(_col.apprStateCD, index[i]) != "50") {
					alert("<fmt:message key="LTC01001A.msg6"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="LTC01001A.msg7"/>")){
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ltc01/contractCancel");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("supportIDs", supportIDs);
		table.setParameter("apprStateCD", "20");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("empID", "${params.empID}");
		table.request();
		
		if(table.getData(0,0) == "S"){
			message(table.getData(1,0));
			Search();
		}else {
			alert(table.getData(1,0));
		}
	}

	/*****************************************************
	 *	define grid / data formats define
	 *****************************************************/
	var columns = [ "", "<fmt:message key="LTC01001A.supportID"/>",
			"<fmt:message key="LTC01001A.venueCD"/>",
			"<fmt:message key="LTC01001A.venueNm"/>",
			"<fmt:message key="LTC01001A.venueGradCD"/>",
			"<fmt:message key="LTC01001A.segmentCD"/>",
			"<fmt:message key="LTC01001A.subSegmentCD"/>",
			"<fmt:message key="LTC01001A.addrTpCD1"/>",
			"<fmt:message key="LTC01001A.addrTpCD2"/>",
			"<fmt:message key="LTC01001A.contractDateFrom"/>",
			"<fmt:message key="LTC01001A.contractDateTo"/>",
			"<fmt:message key="LTC01001A.contractMonthCt"/>",
			"<fmt:message key="LTC01001A.minContractQty"/>",
			"<fmt:message key="LTC01001A.targetRate"/>",
			"<fmt:message key="LTC01001A.addPayRate"/>",
			"<fmt:message key="LTC01001A.gsvRate"/>",
			"<fmt:message key="LTC01001A.tcontractAmt"/>",
			"<fmt:message key="LTC01001A.tpayAmt"/>",
			"<fmt:message key="LTC01001A.apprStateCD"/>" ];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
		grid.setId("grid");
		grid.setRowCount(0);
		grid.setStyle("width", "100%");
		grid.setStyle("height", "100%");
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-row");
		grid.setHeaderText(columns);
		for (var i = 0; i < columns.length; i++) {
			grid.getHeaderTemplate(i).setStyle("text-align", "center");
		}
		grid.setColumnCount(columns.length);
		grid.setCellFormat([ str, str, str, str, str, str, str, str, str, str,
				str, num, num, num, num, num, num, str ]);
		grid.setCellEditable(false);
		grid.setFixedLeft(4);

		grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellValue(false, _col.checkbox);

		grid.setHeaderTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.onHeaderClicked = function(event, col) {
			if (col == _col.checkbox && this.getHeaderValue(_col.checkbox, 0)) {
				this.setCellValue(true, _col.checkbox);
			} else if (col == _col.checkbox
					&& !this.getHeaderValue(_col.checkbox, 0)) {
				this.setCellValue(false, _col.checkbox);
			}
			return false;
		};

		grid.onRowDoubleClicked = function(event, row) {
			$("#selectSupportID").val(this.getCellText(_col.supportID, row));
			$("#_detail")[0].contentWindow.Search();
			appletOpen();
		};

	}
</script>