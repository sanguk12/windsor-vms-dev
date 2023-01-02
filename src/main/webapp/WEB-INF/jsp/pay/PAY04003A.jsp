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
						        			<col style="width:150px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="PAY04001A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY04001A.dkmdTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD_S" name="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY04001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY04001A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
				                            </tr>
											<tr>
				                                <td class="td-cond">
													<fmt:message key="PAY04001A.stdAmt" />
												</td>
												<td class="td-input">
													<input type="text" id="stdAmt_S" name="stdAmt_S" style="width:180px; ime-mode:disabled; text-align:right;" maxlength="13" value="0" />
				                                </td>
				                            	<td class="td-cond">
													<fmt:message key="PAY04001A.payStateCD" />
												</td>
												<td class="td-input">
													<select id="payStateCD_S" name="payStateCD_S"></select>
				                                </td>
				                                <td class="td-cond-report">
													<fmt:message key="PAY04003A.transferDate" />
												</td>
												<td class="td-input" colspan="3">
													<nis:calendar id="transferDate_S" name="transferDate_S"/>
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
									<td class="td-cond-report">
										<fmt:message key="PAY04003A.transferDate" />
									</td>
									<td class="td-input">
										<nis:calendar id="transferDate" eventproc="" />
										<span id="apply_btn"></span>
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
						<input type="hidden" id="diffNo" name="diffNo" value="9" /><!-- G1 -->
						<input type="hidden" id="apprTpID_bef" name="apprTpID_bef" value="000000" /><!-- Plan/Result승인라인 -->
						<input type="hidden" id="apprTpID" name="apprTpID" value="000002" /><!-- Result검증 승인라인 -->
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
    .aw-column-13 {width: 120px; text-align:right;}
    .aw-column-14 {width: 120px; text-align:right;}
    .aw-column-15 {width: 100px; text-align:center;}
    .aw-column-16 {width: 100px; text-align:left;}
    .aw-column-17 {width: 100px; text-align:left;}
    .aw-column-18 {width: 200px; text-align:left;}
    .aw-column-19 {width: 80px; text-align:center;}

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
			
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));
    		$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
    		getPayStateCD();
    		$("#payStateCD_S").val("30");
		};

		${initScript}

		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
			Search();
		});
		$("#stdAmt_S").keypress(function(){
			if (event.keyCode==13){
				Search();
			}
		});
		$("#stdAmt_S").focus(function(){
			$("#stdAmt_S").val(unformatNum($("#stdAmt_S").val()));
		});
		$("#stdAmt_S").blur(function(){
			$("#stdAmt_S").val(formatNum($("#stdAmt_S").val()));
		});
		
	});
	
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
	
	var apply_btn = new AW.UI.Button;
	apply_btn.setId("apply_btn");
	apply_btn.setControlText("<fmt:message key="button.Apply" />");
	apply_btn.refresh();
	
	apply_btn.onControlClicked = function(event) {
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
				grid.setCellText($("#transferDate").val(), _col.transferDate, index[i]);
			}
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
	
	function getPayStateCD() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "PAYSTATECD");
	  	table.setParameter("attrib02", "PAY");
     	table.request();
		
     	if(table.getCount() > 0) {
			$("#payStateCD_S").find("option").remove();
	     	for(var i=0; i<table.getCount(); i++){
	     		$("#payStateCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
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
		, payAmt_keyman : _i++
		, payApprDate : _i++
		, transferDueDate : _i++
		, transferDate : _i++
		, payCommt : _i++
		, payStateCDName : _i++
		, payStateCD : _i++
		, rowNum : _i++
		, totalCount : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PAY0400101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;programCDName;activityCDName;rageSphereCDName;officeCDName;"+
	  			"empNm;venueCD;venueNm;venueGradCDName;segmentCDName;"+
	  			"subSegmentCDName;addrTpCD1Name;addrTpCD2Name;tpayAmt;payAmt_keyman;"+
	  			"payApprDate;transferDueDate;transferDate;payCommt;payStateCDName;"+
	  			"payStateCD;rowNum;totalCount;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;num;num;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("stdAmt", unformatNum($("#stdAmt_S").val()));
	  	table.setParameter("payStateCD", $("#payStateCD_S").val());
	  	table.setParameter("transferDate", convertDate($("#transferDate_S").val()));
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
					, table.getData(_col.payAmt_keyman,i)
					, formatDate(table.getData(_col.payApprDate,i))
					, formatDate(table.getData(_col.transferDueDate,i))
					, formatDate(table.getData(_col.transferDate,i))
					, table.getData(_col.payCommt,i)
					, table.getData(_col.payStateCDName,i)
					, table.getData(_col.payStateCD,i)
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
		
		var venueCDs = new Array();
		var payCommts = new Array();
		var transferDueDates = new Array();
		var transferDates = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				payCommts[count] = grid.getCellText(_col.payCommt, index[i]);
				transferDueDates[count] = grid.getCellText(_col.transferDueDate, index[i]);
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
				//지급상태가 지급승인인 경우만 가능
				var payStateCD = grid.getCellText(_col.payStateCD, index[i]);
				if(payStateCD != "30") {
					alert("<fmt:message key="PAY04003A.msg1"/>");
					return;
				}
				if(grid.getCellText(_col.transferDate, index[i]) == "") {
					alert("<fmt:message key="PAY04003A.msg3"/>");
					$("#transferDate").focus();
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY04003A.msg2"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/finishPayVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("payCommts", payCommts);
		table.setParameter("transferDueDates", transferDueDates);
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
		
		var venueCDs = new Array();
		var payCommts = new Array();
		var transferDueDates = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
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
				//지급상태가 지급승인인 경우만 가능
				var payStateCD = grid.getCellText(_col.payStateCD, index[i]);
				if(payStateCD != "30" && payStateCD != "20" && payStateCD != "10") {
					alert("<fmt:message key="PAY04003A.msg4"/>");
					return;
				}
				if(grid.getCellText(_col.transferDueDate, index[i]) == "") {
					alert("<fmt:message key="PAY04003A.msg9"/>");
					setCellFocus(grid, _col.transferDueDate, index[i]);
					return;
				}
				if(grid.getCellText(_col.payCommt, index[i]) == "") {
					alert("<fmt:message key="PAY04003A.msg5"/>");
					setCellFocus(grid, _col.payCommt, index[i]);
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY04003A.msg6"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/holdPayVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("apprTpID_bef", $("#apprTpID_bef").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("payCommts", payCommts);
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
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "PAY0400301S");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("stdAmt", unformatNum($("#stdAmt_S").val()));
	  	table.setParameter("payStateCD", $("#payStateCD_S").val());
	  	table.setParameter("transferDate", convertDate($("#transferDate_S").val()));
		
		var headerText = [
			"<fmt:message key="PAY04003A.eventYM"/>"
			, "<fmt:message key="PAY04003A.diffNo"/>"
			, "<fmt:message key="PAY04003A.incntTpCDName"/>"
			, "<fmt:message key="PAY04003A.activityCDName"/>"
			, "<fmt:message key="PAY04003A.programCDName"/>"
			, "<fmt:message key="PAY04003A.payApprDate"/>"
			, "<fmt:message key="PAY04003A.transferDueDate"/>"
			, "<fmt:message key="PAY04003A.transferDate"/>"
			, "<fmt:message key="PAY04001A.payCommt"/>"
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
		
		table.setParameter("templateFile", "PAY04003A");
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
		
		var venueCDs = new Array();
		var payCommts = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
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
				//지급상태가 지급승인인 경우만 가능
				var payStateCD = grid.getCellText(_col.payStateCD, index[i]);
// 				if(payStateCD != "30") {
// 					alert("<fmt:message key="PAY04003A.msg4"/>");
// 					return;
// 				}
				//지급의견필수 메세지
				if(grid.getCellText(_col.payCommt, index[i]) == "") {
					alert("<fmt:message key="PAY04003A.msg7"/>");
					setCellFocus(grid, _col.payCommt, index[i]);
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY04003A.msg8"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/savePayCommVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("venueCDs", venueCDs);
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
		
		var venueCDs = new Array();
		var payCommts = new Array();
		var transferDueDates = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
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
		table.setURL("${contextPath}/service/pay04/payDueDateSave");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("venueCDs", venueCDs);
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
		, "<fmt:message key="PAY04001A.programCD"/>"
		, "<fmt:message key="PAY04001A.activityCD"/>"
		, "<fmt:message key="PAY04001A.rageSphereCD"/>"
		, "<fmt:message key="PAY04001A.officeCD"/>"
		, "<fmt:message key="PAY04001A.empNm"/>"
		, "<fmt:message key="PAY04001A.venueCD"/>"
		, "<fmt:message key="PAY04001A.venueNm"/>"
		, "<fmt:message key="PAY04001A.venueGradCD"/>"
		, "<fmt:message key="PAY04001A.segmentCD"/>"
		, "<fmt:message key="PAY04001A.subSegmentCD"/>"
		, "<fmt:message key="PAY04001A.addrTpCD1"/>"
		, "<fmt:message key="PAY04001A.addrTpCD2"/>"
		, "<fmt:message key="PAY04001A.tpayAmt"/>"
		, "<fmt:message key="PAY04001A.payAmt_keyman"/>"
		, "<fmt:message key="PAY04001A.payApprDate"/>"
		, "<fmt:message key="PAY04003A.transferDueDate"/>"
		, "<fmt:message key="PAY04003A.transferDate"/>"
		, "<fmt:message key="PAY04001A.payCommt"/>"
		, "<fmt:message key="PAY04001A.payStateCDName"/>"
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
	                        , str, str, str, num, num
	                        , str, str, str, str, str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setCellEditable(true, _col.payCommt);
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