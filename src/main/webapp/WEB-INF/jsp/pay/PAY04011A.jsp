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
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:120px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="PAY04011A.payApprDate" />
												</td>
												<td class="td-input" colspan="5">
													<nis:calendar id="payApprDateFrom_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" /> - 
													<nis:calendar id="payApprDateTo_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" />
				                                </td>
				                                <!-- 
				                                <td class="td-cond">
													<fmt:message key="PAY04011A.payTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="payTpCD_S" name="payTpCD_S" defaultText="all" category="PAYTPCD" />
												</td>
												 -->
											</tr>
											<tr>	
												<td class="td-cond">
													<fmt:message key="PAY04011A.mileageStateCD" />
												</td>
												<td class="td-input">
													<select id="mileageStateCD_S" name="mileageStateCD_S"></select>
												</td>
												<td class="td-cond-report">
													<fmt:message key="PAY04006A.transferDate" />
												</td>
												<td class="td-input">
													<nis:calendar id="transferDate_S" name="transferDate_S"/>
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="MIL01001B.mileagePayTPCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="mileagePayTPCD" name="mileagePayTPCD" defaultText="all" category="MILEAGEPAYTPCD"/>
												</td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="PAY03003A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY03003A.officeCD" />
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
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
						<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
                            <colgroup>
			        			<col></col>
			        			<col style="width:100px;"></col>
			        			<col style="width:200px;"></col>
			        		</colgroup>
			        		<tbody>
	                            <tr>
	                            	<td></td>
	                            	<td class="td-cond-report">
										<fmt:message key="PAY04003A.transferDueDate" />
									</td>
									<td class="td-input">
										<nis:calendar id="transferDueDate" eventproc="" />
										<span id="applyDue_btn"></span>
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
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 35px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:left;}
    .aw-column-3 {width: 120px; text-align:left;}
    .aw-column-4 {width: 100px; text-align:center;}
    .aw-column-5 {width: 80px; text-align:center;}
    .aw-column-6 {width: 100px; text-align:center;}
    .aw-column-7 {width: 150px; text-align:left;}
    .aw-column-8 {width: 70px; text-align:center;}
    .aw-column-9 {width: 100px; text-align:left;}
    .aw-column-10 {width: 100px; text-align:left;}
    .aw-column-11 {width: 100px; text-align:center;}
    .aw-column-12 {width: 120px; text-align:center;}
    .aw-column-13 {width: 100px; text-align:center;}
    .aw-column-14 {width: 100px; text-align:center;}
    .aw-column-15 {width: 100px; text-align:center;}
    .aw-column-16 {width: 120px; text-align:right;}
    .aw-column-17 {width: 120px; text-align:right;}
    .aw-column-18 {width: 120px; text-align:right;}
    .aw-column-19 {width: 100px; text-align:center;}
    .aw-column-20 {width: 100px; text-align:left;}
    .aw-column-21 {width: 100px; text-align:left;}
    .aw-column-22 {width: 200px; text-align:left;}
    .aw-column-23 {width: 100px; text-align:center;}
    .aw-column-24 {width: 100px; text-align:center;}

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
		$("#stdAmt_S").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			$("#grid_displayNum").val("100");
			createGrid();
			grid.refresh();
			
			//앞뒤 1주일
			$("#payApprDateFrom_S").val("${params.agoWeekDate}");
			$("#payApprDateTo_S").val("${params.afterWeekDate}");
			$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
			getMileageStateCD();
    		$("#mileageStateCD_S").val("30");
		};

		${initScript}
		
	});
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}

	function getMileageStateCD() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "PAYSTATECD");
	  	table.setParameter("attrib02", "PAY");
     	table.request();
		
     	if(table.getCount() > 0) {
     		$("#mileageStateCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
			$("#mileageStateCD_S").find("option").remove();
	     	for(var i=0; i<table.getCount(); i++){
	     		$("#mileageStateCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   		}
		}
	}
	/*
	function getMileageStateCD() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "MILEAGEPAYSTATCD");
	  	table.setParameter("attrib03", "VELEX");
     	table.request();
		
     	if(table.getCount() > 0) {
// 	     	$("#mileageStateCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
			$("#mileageStateCD_S").find("option").remove();
	     	for(var i=0; i<table.getCount(); i++){
	     		$("#mileageStateCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   		}
		}
	}
	*/

	var _col_cd2 = {
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
	   			if(table.getData(_col_cd2.code,i)==code){
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd2.code,i)+'" checked="true">'+table.getData(_col_cd2.name,i)+'</option>');
	   			} else {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd2.code,i)+'">'+table.getData(_col_cd2.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#officeCD_S").attr("disabled",false);
    		$("#officeCD_S").removeClass("input-readonly");
     	}
	}

	var applyDue_btn = new AW.UI.Button;
	applyDue_btn.setId("applyDue_btn");
	applyDue_btn.setControlText("<fmt:message key="button.Apply" />");
	applyDue_btn.refresh();
	
	applyDue_btn.onControlClicked = function(event) {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				grid.setCellText($("#transferDueDate").val(), _col.transferDueDate, index[i]);
			}
		}
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
		, mileageID : _i++
		, rageSphereCDName : _i++
		, officeCDName : _i++
		, empNm : _i++
		, payTpCDName : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, contractDateFrom : _i++
		, contractDateTo : _i++
		, contractMonthCt : _i++
		, contractAmt : _i++
		, addContractAmt : _i++
		, keymanAmt : _i++
		, payApprDate : _i++
		, transferDueDate : _i++
		, transferDate : _i++
		, payCommt : _i++
		, mileagePayTPCDName : _i++
		, payStateCDName : _i++
		, payStateCD : _i++
		, payTpCD : _i++
		, rowNum : _i++
		, totalCount : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PAY0401101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;mileageID;rageSphereCDName;officeCDName;empNm;"+
	  			"payTpCDName;venueCD;venueNm;venueGradCDName;segmentCDName;"+
	  			"subSegmentCDName;addrTpCD1Name;addrTpCD2Name;contractDateFrom;contractDateTo;contractMonthCt;contractAmt;"+
	  			"addContractAmt;keymanAmt;payApprDate;transferDueDate;transferDate;payCommt;"+
	  			"mileagePayTPCDName;payStateCDName;payStateCD;payTpCD;rowNum;totalCount;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;str;num;"+
	  			"num;num;str;str;str;str;"+
	  			"str;str;str;str;str;str");
	  	table.setParameter("payApprDateFrom", unformat($("#payApprDateFrom_S").val()));
		table.setParameter("payApprDateTo", unformat($("#payApprDateTo_S").val()));
	  	//table.setParameter("payTpCD", $("#payTpCD_S").val());
	  	table.setParameter("mileageStateCD", $("#mileageStateCD_S").val());
	  	table.setParameter("transferDate", convertDate($("#transferDate_S").val()));
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("mileagePayTPCD", $("#mileagePayTPCD").val());
	  	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
					, table.getData(_col.mileageID,i)
					, table.getData(_col.rageSphereCDName,i)
					, table.getData(_col.officeCDName,i)
					, table.getData(_col.empNm,i)
					, table.getData(_col.payTpCDName,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, formatMonth(table.getData(_col.contractDateFrom,i))
					, formatMonth(table.getData(_col.contractDateTo,i))
					, table.getData(_col.contractMonthCt,i)
					, table.getData(_col.contractAmt,i)
					, table.getData(_col.addContractAmt,i)
					, table.getData(_col.keymanAmt,i)
					, formatDate(table.getData(_col.payApprDate,i))
					, formatDate(table.getData(_col.transferDueDate,i))
					, formatDate(table.getData(_col.transferDate,i))
					, table.getData(_col.payCommt,i)
					, table.getData(_col.mileagePayTPCDName,i)
					, table.getData(_col.payStateCDName,i)
					, table.getData(_col.payStateCD,i)
					, table.getData(_col.payTpCD,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo("grid", table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
		}
		else {
			message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
      	}
      	grid.refresh();
	}
	
	function FinishPay() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var mileageIDs = new Array();
		var payTpCDs = new Array();
		var payCommts = new Array();
		var transferDates = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				mileageIDs[count] = grid.getCellText(_col.mileageID, index[i]);
				payTpCDs[count] = grid.getCellText(_col.payTpCD, index[i]);
				payCommts[count] = grid.getCellText(_col.payCommt, index[i]);
				transferDates[count] = grid.getCellText(_col.transferDate, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }

		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//선지원상태가 지급승인, 보류일 경우만 가능
				var payStateCD = grid.getCellText(_col.payStateCD, index[i]);
				if(payStateCD != "30" && payStateCD != "50") {
					alert("<fmt:message key="PAY04011A.msg1"/>");
					return;
				}
				if(grid.getCellText(_col.transferDate, index[i]) == "") {
					alert("<fmt:message key="PAY04011A.msg2"/>");
					setCellFocus(grid, _col.transferDate, index[i]);
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY04011A.msg3"/>")) {
       		return;
       	}

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/finishPayMileage");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("mileageIDs", mileageIDs);
		table.setParameter("payTpCDs", payTpCDs);
		table.setParameter("payCommts", payCommts);
		table.setParameter("transferDates", transferDates);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function HoldPay() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var mileageIDs = new Array();
		var payCommts = new Array();
		var transferDueDates = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				mileageIDs[count] = grid.getCellText(_col.mileageID, index[i]);
				payCommts[count] = grid.getCellText(_col.payCommt, index[i]);
				transferDueDates[count] = grid.getCellText(_col.transferDueDate, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//선지원상태가 지급승인일 경우만 가능
				var payStateCD = grid.getCellText(_col.payStateCD, index[i]);
				if(payStateCD != "30") {
					alert("<fmt:message key="PAY04011A.msg4"/>");
					return;
				}
				if(grid.getCellText(_col.transferDueDate, index[i]) == "") {
					alert("<fmt:message key="PAY04011A.msg9"/>");
					setCellFocus(grid, _col.transferDueDate, index[i]);
					return;
				}
				if(grid.getCellText(_col.payCommt, index[i]) == "") {
					alert("<fmt:message key="PAY04011A.msg5"/>");
					setCellFocus(grid, _col.payComm, index[i]);
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY04011A.msg6"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/holdPayMileage");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("mileageIDs", mileageIDs);
		table.setParameter("transferDueDates", transferDueDates);
		table.setParameter("payCommts", payCommts);
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
		table.setParameter("queryKey", "PAY0401102S");
		table.setParameter("payApprDateFrom", unformat($("#payApprDateFrom_S").val()));
		table.setParameter("payApprDateTo", unformat($("#payApprDateTo_S").val()));
	  	//table.setParameter("payTpCD", $("#payTpCD_S").val());
	  	table.setParameter("mileageStateCD", $("#mileageStateCD_S").val());
	  	table.setParameter("transferDate", convertDate($("#transferDate_S").val()));
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("mileagePayTPCD", $("#mileagePayTPCD").val());
		
		var headerText = [
			"<fmt:message key="PAY04003A.eventYM"/>"
			, "<fmt:message key="PAY04003A.diffNo"/>"
			, "<fmt:message key="PAY04003A.incntTpCDName"/>"
			, "<fmt:message key="PAY04003A.activityCDName"/>"
			, "<fmt:message key="PAY04003A.programCDName"/>"
			, "<fmt:message key="PAY04003A.payApprDate"/>"
			, "<fmt:message key="PAY04003A.transferDueDate"/>"
			, "<fmt:message key="PAY04003A.transferDate"/>"
			, "<fmt:message key="PAY04011A.commt"/>"
			, "<fmt:message key="PAY04003A.dkmdTpCDName"/>"
			, "<fmt:message key="PAY04003A.rageSphereCDName"/>"
			, "<fmt:message key="PAY04003A.officeCDName"/>"
			, "<fmt:message key="PAY04003A.empNm"/>"
			, "<fmt:message key="PAY04003A.venueCD"/>"
			, "<fmt:message key="PAY04003A.venueNm"/>"
			, "<fmt:message key="PAY04003A.prdNm"/>"
			, "<fmt:message key="PAY04003A.keymanID"/>"
			, "<fmt:message key="PAY04003A.keymanNm"/>"
			, "<fmt:message key="PAY04003A.regIDNo"/>"
			, "<fmt:message key="PAY04003A.addr"/>"
			, "<fmt:message key="PAY04003A.phoneNo"/>"
			, "<fmt:message key="PAY04003A.bankCD"/>"
			, "<fmt:message key="PAY04003A.accountNo"/>"
			, "<fmt:message key="PAY04003A.holderNm"/>"
			, "<fmt:message key="PAY04003A.payAmt"/>"
		];
		
		table.setParameter("templateFile", "PAY04011A");
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
	
	function SavePayComm() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}

		var mileageIDs = new Array();
		var payTpCDs = new Array();
		var payCommts = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				mileageIDs[count] = grid.getCellText(_col.mileageID, index[i]);
				payTpCDs[count] = grid.getCellText(_col.payTpCD, index[i]);
				payCommts[count] = grid.getCellText(_col.payCommt, index[i]);
				count++;
			}
		}

		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				if(grid.getCellText(_col.payCommt, index[i]) == "") {
					alert("<fmt:message key="PAY04011A.msg7"/>");
					setCellFocus(grid, _col.payCommt, index[i]);
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY04011A.msg8"/>")) {
       		return;
       	}

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/savePayCommMileage");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("mileageIDs", mileageIDs);
		table.setParameter("payTpCDs", payTpCDs);
		table.setParameter("payCommts", payCommts);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}

	function PayDueDateSave(){
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}

		var payTpCDs = new Array();
		var mileageIDs = new Array();
		var transferDueDates = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				payTpCDs[count] = grid.getCellText(_col.payTpCD, index[i]);
				mileageIDs[count] = grid.getCellText(_col.mileageID, index[i]);
				transferDueDates[count] = grid.getCellText(_col.transferDueDate, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//지급상태가 지급승인인 경우만 가능
				var payStateCD = grid.getCellText(_col.payStateCD, index[i]);
				if(grid.getCellText(_col.transferDueDate, index[i]) == "") {
					alert("<fmt:message key="PAY04001A.msg7"/>");
					setCellFocus(grid, _col.transferDueDate, index[i]);
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY04001A.msg6"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/payDueDateSaveMileage");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("mileageIDs", mileageIDs);
		table.setParameter("payTpCDs", payTpCDs);
		table.setParameter("transferDueDates", transferDueDates);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		""
		, "<fmt:message key="PAY04011A.mileageID"/>"
		, "<fmt:message key="PAY04011A.rageSphereCD"/>"
		, "<fmt:message key="PAY04011A.officeCD"/>"
		, "<fmt:message key="PAY04011A.empNm"/>"
		, "<fmt:message key="PAY04011A.payTpCD"/>"
		, "<fmt:message key="PAY04011A.venueCD"/>"
		, "<fmt:message key="PAY04011A.venueNm"/>"
		, "<fmt:message key="PAY04011A.venueGradCD"/>"
		, "<fmt:message key="PAY04011A.segmentCD"/>"
		, "<fmt:message key="PAY04011A.subSegmentCD"/>"
		, "<fmt:message key="PAY04011A.addrTpCD1"/>"
		, "<fmt:message key="PAY04011A.addrTpCD2"/>"
		, "<fmt:message key="PAY04011A.contractDateFrom"/>"
		, "<fmt:message key="PAY04011A.contractDateTo"/>"
		, "<fmt:message key="PAY04011A.contractMonthCt"/>"
		, "<fmt:message key="PAY04011A.contractAmt"/>"
		, "<fmt:message key="PAY04011A.addContractAmt"/>"
		, "<fmt:message key="PAY04011A.keymanAmt"/>"
		, "<fmt:message key="PAY04011A.payApprDate"/>"
		, "<fmt:message key="PAY04011A.transferDueDate"/>"
		, "<fmt:message key="PAY04011A.transferDate"/>"
		, "<fmt:message key="PAY04011A.commt"/>"
		, "<fmt:message key="PAY04011A.mileagePayTPCDName"/>"
		, "<fmt:message key="PAY04011A.mileageStateCD"/>"
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
	                        , str, str, str, str, str, str, num, num
	                        , num, str, str, str, str
	                        , str, str, str, str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setCellEditable(true, _col.commt);
	    grid.setFixedLeft(8);
	    
	    grid.setCellImage("calendarGrid",_col.transferDate);
	    grid.setCellImage("calendarGrid",_col.transferDueDate);
    	var calendar = new AW.Templates.ImageText;
        var calImage = calendar.getContent("box/image");
        calImage.setTag("a");
        calImage.setAttribute("href", function(){
            return "javascript:pickDateForGrid(grid, _col.transferDate, grid.getCurrentRow())";
        });
    	grid.setCellTemplate(calendar, _col.transferDate);
    	var calendarDue = new AW.Templates.ImageText;
        var calImageDue = calendarDue.getContent("box/image");
        calImageDue.setTag("a");
        calImageDue.setAttribute("href", function(){
            return "javascript:pickDateForGrid(grid, _col.transferDueDate, grid.getCurrentRow())";
        });
    	grid.setCellTemplate(calendarDue, _col.transferDueDate);
	    
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
		
	    grid.onRowDoubleClicked = function(event, row){
		};
    }
	
</script>