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
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT03001B" />
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
								        			<col style="width:200px;"></col>
								        			<col style="width:100px;"></col>
								        			<col style="width:200px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond-required">
															<fmt:message key="RLT03001A.eventYM" />
														</td>
														<td class="td-input" colspan="3">
															<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" event="onchange" eventproc="getResultWriteDate();" />
															<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" event="onchange" eventproc="getResultWriteDate();" />
															<select id="diffNo" name="diffNo" ></select>
						                                </td>
														<td class="td-cond">
															<fmt:message key="RLT03001A.venueGradCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
														</td>
													</tr>
													<tr>
														<td class="td-cond">
															<fmt:message key="RLT03001A.segmentCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="segmentCD_S" name="segmentCD_S" defaultText="all" category="SEGMENTCD" event="onchange" eventproc="getSubSegment(this.value);" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="RLT03001A.subSegmentCD" />
														</td>
														<td class="td-input" colspan="3">
															<nis:selectbox id="subSegmentCD_S" name="subSegmentCD_S" defaultText="all" category="SUBSEGMENTCD" />
						                                </td>
													</tr>
													<tr>
														<td class="td-cond">
															<fmt:message key="RLT03001A.addrTpCD1" />
														</td>
														<td class="td-input">
															<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
														</td>
														<td class="td-cond">
															<fmt:message key="RLT03001A.addrTpCD2" />
														</td>
														<td class="td-input">
															<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
														</td>
														<td class="td-cond">
															<fmt:message key="RLT03001A.confirmYN" />
														</td>
														<td class="td-input">
															<nis:selectbox id="confirmYN_S" name="confirmYN_S" defaultText="all" category="USETYPE3CD" />
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
		                    <td class="td-paging">
		                        <nis:paging id="grid" titleDisable="no" callback="PagingSearch()"/>
		                    </td>
		                </tr>
						<tr>
							<td height="1">
								<input type="hidden" id="incntTpCD" name="incntTpCD" value="VEN" />
								<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
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
	.aw-column-1 {width: 60px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:left;}
    .aw-column-3 {width: 100px; text-align:left;}
    .aw-column-4 {width: 100px; text-align:left;}
    .aw-column-5 {width: 70px; text-align:center;}
    .aw-column-6 {width: 100px; text-align:center;}
    .aw-column-7 {width: 150px; text-align:left;}
    .aw-column-8 {width: 70px; text-align:center;}
    .aw-column-9 {width: 100px; text-align:left;}
    .aw-column-10 {width: 100px; text-align:left;}
    .aw-column-11 {width: 70px; text-align:center;}
    .aw-column-12 {width: 100px; text-align:center;}
    .aw-column-13 {width: 100px; text-align:right;}
    .aw-column-14 {width: 100px; text-align:right;}
    .aw-column-15 {width: 100px; text-align:right;}
    .aw-column-16 {width: 100px; text-align:center;}
    .aw-column-17 {width: 80px; text-align:right;}
    .aw-column-18 {width: 80px; text-align:right;}
    .aw-column-19 {width: 100px; text-align:center;}
    .aw-column-20 {width: 80px; text-align:right;}
    .aw-column-21 {width: 150px; text-align:left;}
    .aw-column-22 {width: 100px; text-align:center;}
    .aw-column-23 {width: 80px; text-align:center;}
    .aw-column-24 {width: 120px; text-align:center;}
    .aw-column-25 {width: 80px; text-align:center;}

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
			
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
    		$("#subSegmentCD_S").attr("disabled",true);
    		$("#subSegmentCD_S").addClass("input-readonly");
    		getDiffNo();
		};

		${initScript}

		$("#yearCD_S").change(function(){
			getDiffNo();
			Search();
		});
		$("#monthCD_S").change(function(){
			getDiffNo();
			Search();
		});
	});
	
	//등록된 G2차수 가져오기
	function getDiffNo() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/RLT0300105S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
     	table.request();
		
     	if(table.getCount() > 0) {
    		$("#diffNo").find("option").remove();
         	for(var i=0; i<table.getCount(); i++) {
         		$("#diffNo").append('<option value="'+table.getData(0,i)+'">'+table.getData(1,i)+'</option>');
       		}
		}
     	else {
     		$("#diffNo").find("option").remove().end().append('<option value=""><fmt:message key="nothing"/></option>');
     	}
	}
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getSubSegment(code) {
		if(code=="") {
			$("#subSegmentCD_S").val("");
			$("#subSegmentCD_S").attr("disabled",true);
    		$("#subSegmentCD_S").addClass("input-readonly");
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "SUBSEGMENTCD");
	  	table.setParameter("attrib02", code);
	  	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#subSegmentCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#subSegmentCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#subSegmentCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#subSegmentCD_S").attr("disabled",false);
    		$("#subSegmentCD_S").removeClass("input-readonly");
     	}
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
	function RegDiffNo() {
		appletOpen();
		$("#_detail")[0].contentWindow.New();
	}
	
	function Search() {
		$("#grid_pageNum").val("1");
		PagingSearch();
	}
	
	var _i = 0;
	var _col = {
		checkbox : _i++
		, programCDName : _i++
		, activityCDName : _i++
		, rageSphereCDName : _i++
		, officeCDName : _i++
		, empNm : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, tpayAmt : _i++
		, resultTQty : _i++
		, avgUnitAmt : _i++
		, resultTpCDName : _i++
		, targetRate : _i++
		, payRate : _i++
		, excPayTpCDName : _i++
		, gsvRate : _i++
		, commt : _i++
		, keymanNm : _i++
		, bankCDName : _i++
		, accountNo : _i++
		, confirmYNName : _i++
		, confirmYN : _i++
		, guidPayRate : _i++
		, excPayTpCD : _i++
		, payStateCD : _i++
		, rowNum : _i++
		, totalCount : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0300108S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;programCDName;activityCDName;rageSphereCDName;officeCDName;"+
	  			"empNm;venueCD;venueNm;venueGradCDName;segmentCDName;"+
	  			"subSegmentCDName;addrTpCD1Name;addrTpCD2Name;tpayAmt;resultTQty;"+
	  			"avgUnitAmt;resultTpCDName;targetRate;payRate;excPayTpCDName;gsvRate;"+
	  			"commt;keymanNm;bankCDName;accountNo;confirmYNName;"+
	  			"confirmYN;guidPayRate;excPayTpCD;payStateCD;rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;num;num;"+
	  			"num;str;num;num;str;num;"+
	  			"str;str;str;str;str;"+
	  			"str;num;str;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("confirmYN", $("#confirmYN_S").val());
	  	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
		// --- 그룹 권한에 따라 empId가 'MK'로 시작하는 담당자 이름은 보이지 않도록 수정 2016.04.20
		if(		   '${params.grpID}' == '000004' || '${params.grpID}' == '000003' || '${params.grpID}' == '000002' 
				|| '${params.grpID}' == '000026' || '${params.grpID}' == '000005'
				|| '${params.grpID}' == '000013' || '${params.grpID}' == '000016' || '${params.grpID}' == '000018'
				|| '${params.grpID}' == '000017' || '${params.grpID}' == '000023' || '${params.grpID}' == '000024'){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
		// ---
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
					, table.getData(_col.programCDName,i)
					, table.getData(_col.activityCDName,i)
					, table.getData(_col.rageSphereCDName,i)
					, table.getData(_col.officeCDName,i)
					, table.getData(_col.empNm,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.tpayAmt,i)
					, table.getData(_col.resultTQty,i)
					, table.getData(_col.avgUnitAmt,i)
					, table.getData(_col.resultTpCDName,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.payRate,i)
					, table.getData(_col.excPayTpCDName,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.commt,i)
					, table.getData(_col.keymanNm,i)
					, table.getData(_col.bankCDName,i)
					, table.getData(_col.accountNo,i)
					, table.getData(_col.confirmYNName,i)
					, table.getData(_col.confirmYN,i)
					, table.getData(_col.guidPayRate,i)
					, table.getData(_col.excPayTpCD,i)
					, table.getData(_col.payStateCD,i)
      			];
      			
      			var gsvRate = Number(table.getData(_col.gsvRate,i));
				var excPayTpCD = table.getData(_col.excPayTpCD,i);
				if(gsvRate > 10) {
					grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "#ffffff");
				}
				if(excPayTpCD == "YPAY") {
					grid.getCellTemplate(_col.excPayTpCDName, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.excPayTpCDName, i).setStyle("color", "#ffffff");
				}
      			
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      		//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/RLT0300110S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("outParamKey","totalCount;");
			table.setParameter("format","str;");
			table.request();
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo("grid", beginRowNum, endRowNum, table.getData(0,0));
		}
		else {
			message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
      	}
      	grid.refresh();
	}
	
	function ResultCreation() {
		if(!confirm("<fmt:message key="RLT03001A.msg6"/>")) {
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt03/resultCreation");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("incntTpCD", $("#incntTpCD").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Determine() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var venueCDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//확정여부가 'N'인경우만 확정가능
				if(grid.getCellText(_col.confirmYN, index[i]) == "Y") {
					alert("<fmt:message key="RLT03001A.msg1"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="RLT03001A.msg2"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt03/determineResult");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprStateCD", "50");		//승인상태:승인(50)
		table.setParameter("verifyStateCD", "OK");		//검증상태:검증완료(OK)
		table.setParameter("payStateCD", "10");			//지급상태:지급대기(10)
		table.setParameter("venueCDs", venueCDs);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function DetermineCancel() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var venueCDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//확정여부가 'Y'인경우만 확정취소가능
				if(grid.getCellText(_col.confirmYN, index[i]) == "N") {
					alert("<fmt:message key="RLT03001A.msg3"/>");
					return;
				}
				//지급상태가 '지급대기(10)'인경우만 확정취소가능
				if(grid.getCellText(_col.payStateCD, index[i]) != "10") {
					alert("<fmt:message key="RLT03001A.msg4"/>");
					return;
				}
			}
			
		}
		if(!confirm("<fmt:message key="RLT03001A.msg5"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt03/determineCancelResult");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprStateCD", "10");		//승인상태:등록(10)
		table.setParameter("verifyStateCD", "");
		table.setParameter("payStateCD", "");
		table.setParameter("venueCDs", venueCDs);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "RLT0300109S");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("confirmYN", $("#confirmYN_S").val());
	 	// --- 그룹 권한에 따라 empId가 'MK'로 시작하는 담당자 이름은 보이지 않도록 수정 2016.04.20
		if(		   '${params.grpID}' == '000004' || '${params.grpID}' == '000003' || '${params.grpID}' == '000002' 
				|| '${params.grpID}' == '000026' || '${params.grpID}' == '000005'
				|| '${params.grpID}' == '000013' || '${params.grpID}' == '000016' || '${params.grpID}' == '000018'
				|| '${params.grpID}' == '000017' || '${params.grpID}' == '000023' || '${params.grpID}' == '000024'){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
		// ---
		
		var headerText = [
			"<fmt:message key="RLT03001A.programCD"/>"
			, "<fmt:message key="RLT03001A.activityCD"/>"
			, "<fmt:message key="RLT03001A.venueCD"/>"
			, "<fmt:message key="RLT03001A.venueNm"/>"
			, "<fmt:message key="RLT03001A.venueGradCD"/>"
			, "<fmt:message key="RLT03001A.segmentCD"/>"
			, "<fmt:message key="RLT03001A.subSegmentCD"/>"
			, "<fmt:message key="RLT03001A.addrTpCD1"/>"
			, "<fmt:message key="RLT03001A.addrTpCD2"/>"
			, "<fmt:message key="RLT03001A.tpayAmt"/>"
			, "<fmt:message key="RLT03001A.resultTQty"/>"
			, "<fmt:message key="RLT03001A.avgUnitAmt"/>"
			, "<fmt:message key="RLT03001A.resultTpCD"/>"
			, "<fmt:message key="RLT03001A.targetRate"/>"
			, "<fmt:message key="RLT03001A.payRate"/>"
			, "<fmt:message key="RLT03001A.excPayTpCD"/>"
			, "<fmt:message key="RLT03001A.gsvRate"/>"
			, "<fmt:message key="RLT03001A.commt"/>"
			, "<fmt:message key="RLT03001A.keyman"/>"
			, "<fmt:message key="RLT03001A.bankCD"/>"
			, "<fmt:message key="RLT03001A.accountNo"/>"
			, "<fmt:message key="RLT03001A.confirmYN"/>"
			, "<fmt:message key="RLT03001A.kindTpCD5"/>"
			, "<fmt:message key="RLT03001A.prdNm"/>"
			, "<fmt:message key="RLT03001A.factoryPrice"/>"
			, "<fmt:message key="RLT03001A.qtyUnitCD"/>"
			, "<fmt:message key="RLT03001A.planQty"/>"
			, "<fmt:message key="RLT03001A.resultQty"/>"
			, "<fmt:message key="RLT03001A.resultUnitAmt"/>"
			, "<fmt:message key="RLT03001A.payAmt"/>"
		];
		
		table.setParameter("templateFile", "RLT03001A");
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
		""
		, "<fmt:message key="RLT03001A.programCD"/>"
		, "<fmt:message key="RLT03001A.activityCD"/>"
		, "<fmt:message key="RLT03001A.rageSphereCD"/>"
		, "<fmt:message key="RLT03001A.officeCD"/>"
		, "<fmt:message key="RLT03001A.empNm"/>"
		, "<fmt:message key="RLT03001A.venueCD"/>"
		, "<fmt:message key="RLT03001A.venueNm"/>"
		, "<fmt:message key="RLT03001A.venueGradCD"/>"
		, "<fmt:message key="RLT03001A.segmentCD"/>"
		, "<fmt:message key="RLT03001A.subSegmentCD"/>"
		, "<fmt:message key="RLT03001A.addrTpCD1"/>"
		, "<fmt:message key="RLT03001A.addrTpCD2"/>"
		, "<fmt:message key="RLT03001A.tpayAmt"/>"
		, "<fmt:message key="RLT03001A.resultTQty"/>"
		, "<fmt:message key="RLT03001A.avgUnitAmt"/>"
		, "<fmt:message key="RLT03001A.resultTpCD"/>"
		, "<fmt:message key="RLT03001A.targetRate"/>"
		, "<fmt:message key="RLT03001A.payRate"/>"
		, "<fmt:message key="RLT03001A.excPayTpCD"/>"
		, "<fmt:message key="RLT03001A.gsvRate"/>"
		, "<fmt:message key="RLT03001A.commt"/>"
		, "<fmt:message key="RLT03001A.keyman"/>"
		, "<fmt:message key="RLT03001A.bankCD"/>"
		, "<fmt:message key="RLT03001A.accountNo"/>"
		, "<fmt:message key="RLT03001A.confirmYN"/>"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
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
	                        , str, str, str, str, str
	                        , str, str, str, num, num
	                        , num, str, num, num, str, num
	                        , str, str, str, str, str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(8);
	    
	    grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellValue(false, _col.checkbox);
		
		grid.setHeaderTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.onHeaderClicked=function(event,col){
			if (col == _col.checkbox && this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(true, _col.checkbox);
			}
			else if (col == _col.checkbox && !this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(false, _col.checkbox);
			}
			return false;
		};
		
		// Cell startEdit BEGIN
        grid.onCellSelectedChanged = function(selected, col, row) {
            if (selected) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
                });
            }
        };

        grid.onCellClicked = function(event, col, row) {
            if (this.getCellSelected(col, row)) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
               });
            }
        };

		grid.onCellEditEnded = function(text, col, row) {
			this.setCellText(text, col, row);
			this.focus();
		};
		// Cell startEdit END
		
		//  BEGIN validating (Enter, Cell LoseFocus)
		grid.onCellValidating = function(text, col, row) {
	    };
	
	    grid.onCellValidated = function(text, col, row) {
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
		
		grid.onRowDoubleClicked = function(event, row){
			$("#selectVenueCD").val(this.getCellText(_col.venueCD,row));
			
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01002B";
	    	newWindow(url, "RLT01002B",770,340,"yes");
	    	
		};
		
    }
	
</script>