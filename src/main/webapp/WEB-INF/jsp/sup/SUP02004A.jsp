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
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=SUP02004B" />
							</td>
						</tr>
						<tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:120px;"></col>
								        			<col style="width:300px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond-required">
															<fmt:message key="SUP02002A.payRequestDate" />
														</td>
														<td class="td-input">
															<nis:calendar id="payRequestDateFrom_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" /> - 
															<nis:calendar id="payRequestDateTo_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" />
														</td>
														 <td class="td-cond">
															<fmt:message key="SUP02002A.supportStateCD" />
														</td>
														<td class="td-input">
															<select id="supportStateCD_S" name="supportStateCD_S" ></select>
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
							<td height="1">
								<input type="hidden" id="selectSupportID" name="selectSupportID" />
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

	.aw-column-0 {width: 100px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:left;}
	.aw-column-2 {width: 120px; text-align:left;}
	.aw-column-3 {width: 80px; text-align:center;}
    .aw-column-4 {width: 100px; text-align:center;}
    .aw-column-5 {width: 150px; text-align:left;}
    .aw-column-6 {width: 50px; text-align:center;}
    .aw-column-7 {width: 100px; text-align:left;}
    .aw-column-8 {width: 100px; text-align:left;}
    .aw-column-9 {width: 70px; text-align:center;}
    .aw-column-10 {width: 100px; text-align:center;}
    .aw-column-11 {width: 100px; text-align:center;}
    .aw-column-12 {width: 100px; text-align:center;}
    .aw-column-13 {width: 80px; text-align:right;}
    .aw-column-14 {width: 100px; text-align:right;}
    .aw-column-15 {width: 100px; text-align:right;}
    .aw-column-16 {width: 100px; text-align:right;}
    .aw-column-17 {width: 100px; text-align:right;}
    .aw-column-18 {width: 100px; text-align:right;}
    .aw-column-19 {width: 100px; text-align:right;}
    .aw-column-20 {width: 100px; text-align:right;}
    .aw-column-21 {width: 100px; text-align:right;}
    .aw-column-22 {width: 100px; text-align:right;}
    .aw-column-23 {width: 80px; text-align:right;}
    .aw-column-24 {width: 100px; text-align:right;}
    .aw-column-25 {width: 100px; text-align:right;}
    .aw-column-26 {width: 100px; text-align:center;}
    .aw-column-27 {width: 80px; text-align:center;}
    .aw-column-28 {width: 100px; text-align:center;}
    .aw-column-29 {width: 120px; text-align:left;}

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
			
			//앞뒤 1주일
			if("${params.eventym}"==""){
			    $("#payRequestDateFrom_S").val("${params.agoWeekDate}");
			}else{
				$("#payRequestDateFrom_S").val("${params.eventym}");
			}
			
			$("#payRequestDateTo_S").val("${params.afterWeekDate}");
			getSupportStateCD();
			
			$("#supportStateCD_S").val("20");
			if("${params.eventym}"!=""){
    			Search();
    		}
			
		};

		${initScript}

	});
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getSupportStateCD() {
     	var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "SUPPORTSTATECD");
	  	table.setParameter("attrib02", "MNG");
	  	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#supportStateCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
   				$("#supportStateCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   		}
     	}
     	else {
     		$("#supportStateCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
     	}
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		supportID : _i++
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
		, contractDateFrom : _i++
		, contractDateTo : _i++
		, contractMonthCt : _i++
		, apAmt : _i++
		, msTargetRate : _i++
		, tcontractQty : _i++
		, gsvAmt : _i++
		, gsvRate : _i++
		, stipulationAmt : _i++
		, contractAmt : _i++
		, contractTaxAmt : _i++
		, subtractAmt : _i++
		, targetRate : _i++
		, addAmt : _i++
		, addTaxAmt : _i++
		, payRequestDate : _i++
		, supportStateCDName : _i++
		, transferDate : _i++
		, commt : _i++
		, supportStateCD : _i++
		
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/SUP0200201S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"supportID;rageSphereCDName;officeCDName;empNm;venueCD;"+
	  			"venueNm;venueGradCDName;"+
	  			"segmentCDName;subSegmentCDName;addrTpCD1Name;addrTpCD2Name;contractDateFrom;"+
	  			"contractDateTo;contractMonthCt;apAmt;msTargetRate;tcontractQty;"+
	  			"gsvAmt;gsvRate;stipulationAmt;contractAmt;contractTaxAmt;"+
	  			"subtractAmt;targetRate;addAmt;addTaxAmt;payRequestDate;"+
	  			"supportStateCDName;transferDate;commt;supportStateCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;num;num;num;num5;"+
	  			"num;num;num;num;num;"+
	  			"num;num;num;num;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("payRequestDateFrom", unformat($("#payRequestDateFrom_S").val()));
	  	table.setParameter("payRequestDateTo", unformat($("#payRequestDateTo_S").val()));
	  	table.setParameter("supportStateCD", $("#supportStateCD_S").val());
	  	table.setParameter("periodShortTerm", 3);
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
					table.getData(_col.supportID,i)
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
					, formatDate(table.getData(_col.contractDateFrom,i))
					, formatDate(table.getData(_col.contractDateTo,i))
					, table.getData(_col.contractMonthCt,i)
					, table.getData(_col.apAmt,i)
					, table.getData(_col.msTargetRate,i)
					, table.getData(_col.tcontractQty,i)
					, table.getData(_col.gsvAmt,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.stipulationAmt,i)
					, table.getData(_col.contractAmt,i)
					, table.getData(_col.contractTaxAmt,i)
					, table.getData(_col.subtractAmt,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.addAmt,i)
					, table.getData(_col.addTaxAmt,i)
					, formatDate(table.getData(_col.payRequestDate,i))
					, table.getData(_col.supportStateCDName,i)
					, formatDate(table.getData(_col.transferDate,i))
					, table.getData(_col.commt,i)
					, table.getData(_col.supportStateCD,i)
      			];
			}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	else {
			message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
      	}
      	grid.refresh();
	}
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "SUP0200201S");
		table.setParameter("payRequestDateFrom", unformat($("#payRequestDateFrom_S").val()));
	  	table.setParameter("payRequestDateTo", unformat($("#payRequestDateTo_S").val()));
	  	table.setParameter("supportStateCD", $("#supportStateCD_S").val());
	  	table.setParameter("periodShortTerm", 3);
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
			"<fmt:message key="SUP02002A.supportID"/>"
			, "<fmt:message key="SUP02002A.rageSphereCD"/>"
			, "<fmt:message key="SUP02002A.officeCD"/>"
			, "<fmt:message key="SUP02002A.empNm"/>"
			, "<fmt:message key="SUP02002A.venueCD"/>"
			, "<fmt:message key="SUP02002A.venueNm"/>"
			, "<fmt:message key="SUP02002A.venueGradCD"/>"
			, "<fmt:message key="SUP02002A.segmentCD"/>"
			, "<fmt:message key="SUP02002A.subSegmentCD"/>"
			, "<fmt:message key="SUP02002A.addrTpCD1"/>"
			, "<fmt:message key="SUP02002A.addrTpCD2"/>"
			, "<fmt:message key="SUP02002A.contractDateFrom"/>"
			, "<fmt:message key="SUP02002A.contractDateTo"/>"
			, "<fmt:message key="SUP02002A.contractMonthCt"/>"
			, "<fmt:message key="SUP02002A.apAmt"/>"
			, "<fmt:message key="SUP02002A.msTargetRate"/>"
			, "<fmt:message key="SUP02002A.tcontractQty"/>"
			, "<fmt:message key="SUP02002A.gsvAmt"/>"
			, "<fmt:message key="SUP02002A.gsvRate"/>"
			, "<fmt:message key="SUP02002A.stipulationAmt"/>"
			, "<fmt:message key="SUP02002A.contractAmt"/>"
			, "<fmt:message key="SUP02002A.contractTaxAmt"/>"
			, "<fmt:message key="SUP02002A.subtractAmt"/>"
			, "<fmt:message key="SUP02002A.targetRate"/>"
			, "<fmt:message key="SUP02002A.addAmt"/>"
			, "<fmt:message key="SUP02002A.addTaxAmt"/>"
			, "<fmt:message key="SUP02002A.payRequestDate"/>"
			, "<fmt:message key="SUP02002A.supportStateCD"/>"
			, "<fmt:message key="SUP02002A.transferDate"/>"
			, "<fmt:message key="SUP02002A.commt"/>"
		];
		
		table.setParameter("templateFile", "SUP02002A");
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
   		"<fmt:message key="SUP02002A.supportID"/>"
   		, "<fmt:message key="SUP02002A.rageSphereCD"/>"
   		, "<fmt:message key="SUP02002A.officeCD"/>"
   		, "<fmt:message key="SUP02002A.empNm"/>"
		, "<fmt:message key="SUP02002A.venueCD"/>"
		, "<fmt:message key="SUP02002A.venueNm"/>"
		, "<fmt:message key="SUP02002A.venueGradCD"/>"
		, "<fmt:message key="SUP02002A.segmentCD"/>"
		, "<fmt:message key="SUP02002A.subSegmentCD"/>"
		, "<fmt:message key="SUP02002A.addrTpCD1"/>"
		, "<fmt:message key="SUP02002A.addrTpCD2"/>"
		, "<fmt:message key="SUP02002A.contractDateFrom"/>"
		, "<fmt:message key="SUP02002A.contractDateTo"/>"
		, "<fmt:message key="SUP02002A.contractMonthCt"/>"
		, "<fmt:message key="SUP02002A.apAmt"/>"
		, "<fmt:message key="SUP02002A.msTargetRate"/>"
		, "<fmt:message key="SUP02002A.tcontractQty"/>"
		, "<fmt:message key="SUP02002A.gsvAmt"/>"
		, "<fmt:message key="SUP02002A.gsvRate"/>"
		, "<fmt:message key="SUP02002A.stipulationAmt"/>"
		, "<fmt:message key="SUP02002A.contractAmt"/>"
		, "<fmt:message key="SUP02002A.contractTaxAmt"/>"
		, "<fmt:message key="SUP02002A.subtractAmt"/>"
		, "<fmt:message key="SUP02002A.targetRate"/>"
		, "<fmt:message key="SUP02002A.addAmt"/>"
		, "<fmt:message key="SUP02002A.addTaxAmt"/>"
		, "<fmt:message key="SUP02002A.payRequestDate"/>"
		, "<fmt:message key="SUP02002A.supportStateCD"/>"
		, "<fmt:message key="SUP02002A.transferDate"/>"
		, "<fmt:message key="SUP02002A.commt"/>"
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
	                        , str, str
	                        , str, str, str, str, str
	                        , str, num, num, num, num5
	                        , num, num, num, num, num
	                        , num, num, num, num, str
	                        , str, str, str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(6);
		
		grid.onRowDoubleClicked = function(event, row){
			$("#selectSupportID").val(this.getCellText(_col.supportID,row));
			$("#_detail")[0].contentWindow.Search();
			appletOpen();
		};
		
    }
	
</script>