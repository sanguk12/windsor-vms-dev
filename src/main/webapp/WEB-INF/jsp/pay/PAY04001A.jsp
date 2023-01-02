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
				                            </tr>
											<tr>
				                                <td class="td-cond">
													<fmt:message key="PAY04001A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
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
    .aw-column-17 {width: 200px; text-align:left;}
    .aw-column-18 {width: 80px; text-align:center;}

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
    		$("#payStateCD_S").val("10");
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
	  			"payApprDate;transferDueDate;payCommt;payStateCDName;payStateCD;"+
	  			"rowNum;totalCount;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;num;num;"+
	  			"str;str;str;str;str;"+
	  			"str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("stdAmt", unformatNum($("#stdAmt_S").val()));
	  	table.setParameter("payStateCD", $("#payStateCD_S").val());
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
      			
      			var payAmt_keyman = "";
      			payAmt_keyman = "<a href=\"javascript:openKeymanPopup('"+table.getData(_col.venueCD,i)+"','"+table.getData(_col.payStateCD,i)+"');\">"+table.getData(_col.payAmt_keyman,i)+"</a>";
      			
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
					, payAmt_keyman
					, formatDate(table.getData(_col.payApprDate,i))
					, formatDate(table.getData(_col.transferDueDate,i))
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
	
	function openKeymanPopup(venueCD, payStateCD) {
		var diffNo = $("#diffNo").val();
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PAY04001B"
				+"&venueCD="+venueCD+"&diffNo="+diffNo+"&eventYM="+eventYM
				+"&payStateCD="+payStateCD;
		newWindow(url, "PAY04001B",900,600,"yes");
	}
	
	function CloseKeymanPopup() {
		Search();
	}
	
	function ApplicationPay() {
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
				//지급상태가 지급대기, 반려, 보류일 경우만 가능
				var payStateCD = grid.getCellText(_col.payStateCD, index[i]);
				if(payStateCD != "10" && payStateCD != "40" && payStateCD != "50") {
					alert("<fmt:message key="PAY04001A.msg1"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY04001A.msg2"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/applicationPayVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("diffNo", $("#diffNo").val());
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
	
	function ReVerifyReq() {
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
				//지급상태가 지급대기, 반려, 보류일 경우만 가능
				var payStateCD = grid.getCellText(_col.payStateCD, index[i]);
				if(payStateCD != "10" && payStateCD != "40" && payStateCD != "50") {
					alert("<fmt:message key="PAY04001A.msg3"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY04001A.msg4"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/reVerifyReq");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("diffNo", $("#diffNo").val());
		
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
					alert("<fmt:message key="PAY04001A.msg5"/>");
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
		, "<fmt:message key="PAY04001A.transferDueDate"/>"
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
	                        , str, str, str, num, html
	                        , str, str, str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setCellEditable(true, _col.payCommt);
	    grid.setFixedLeft(8);

	    grid.setCellImage("calendarGrid",_col.transferDueDate);
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
		
	    grid.onRowDoubleClicked = function(event, row){
		};
    }
	
</script>