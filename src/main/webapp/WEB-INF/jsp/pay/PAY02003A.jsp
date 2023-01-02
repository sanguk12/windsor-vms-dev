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
													<fmt:message key="PAY02001A.eventYM" />
												</td>
												<td class="td-input" colspan="3">
													<!-- 
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
													-->
													<nis:selectbox id="yearCDFrom_S" name="yearCDFrom_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCDFrom_S" name="monthCDFrom_S" defaultText="none" category="MONTHCD" />~
													<nis:selectbox id="yearCDTo_S" name="yearCDTo_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCDTo_S" name="monthCDTo_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY02001A.verifyStateCD" />
												</td>
												<td class="td-input">
													<select id="apprStateCD_S" name="apprStateCD_S"></select>
				                                </td>
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="PAY02001A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="PAY02001A.segmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="segmentCD_S" name="segmentCD_S" defaultText="all" category="SEGMENTCD" event="onchange" eventproc="getSubSegment(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY02001A.subSegmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="subSegmentCD_S" name="subSegmentCD_S" defaultText="all" category="SUBSEGMENTCD" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="PAY02001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY02001A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="MIL01001B.mileagePayTPCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="mileagePayTPCD" name="mileagePayTPCD" defaultText="all" category="MILEAGEPAYTPCD"/>
												</td>
				                            </tr>
				                            <!-- 
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="PAY02001A.payRate_YN" />
												</td>
												<td class="td-input">
													<select id="payRate_YN">
														<option value=""><fmt:message key="all"/></option>
														<option value="Y">Y</option>
													</select>
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY02001A.excPayTpCD_YN" />
												</td>
												<td class="td-input">
													<select id="excPayTpCD_YN">
														<option value=""><fmt:message key="all"/></option>
														<option value="Y">Y</option>
													</select>
				                                </td>
												<td class="td-cond">
													<fmt:message key="PAY02001A.gsvRate_YN" />
												</td>
												<td class="td-input">
													<select id="gsvRate_YN">
														<option value=""><fmt:message key="all"/></option>
														<option value="Y">Y</option>
													</select>
				                                </td>
				                            </tr>
				                             -->
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
						<input type="hidden" id="selectMileageID" name="selectMileageID" />
						<input type="hidden" id="diffNo" name="diffNo" value="9" /><!-- G1 -->
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
	.aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 130px; text-align:left;}
    .aw-column-3 {width: 80px; text-align:left;}
    .aw-column-4 {width: 60px; text-align:center;}
    .aw-column-5 {width: 100px; text-align:center;}
    .aw-column-6 {width: 150px; text-align:left;}
    .aw-column-7 {width: 70px; text-align:center;}
    .aw-column-8 {width: 100px; text-align:left;}
    .aw-column-9 {width: 100px; text-align:left;}
    .aw-column-10 {width: 70px; text-align:center;}
    .aw-column-11 {width: 100px; text-align:center;}
    .aw-column-12 {width: 100px; text-align:center;}
    .aw-column-13 {width: 100px; text-align:center;}
    .aw-column-14 {width: 80px; text-align:right;}
    .aw-column-15 {width: 100px; text-align:right;}
    .aw-column-16 {width: 100px; text-align:right;}
    .aw-column-17 {width: 100px; text-align:right;}
    .aw-column-18 {width: 100px; text-align:right;}
    .aw-column-19 {width: 100px; text-align:right;}
    .aw-column-20 {width: 100px; text-align:right;}
    .aw-column-21 {width: 100px; text-align:right;}
    .aw-column-22 {width: 100px; text-align:right;}
    .aw-column-23 {width: 100px; text-align:right;}
    .aw-column-24 {width: 100px; text-align:right;}
    .aw-column-25 {width: 100px; text-align:center;}
    .aw-column-26 {width: 80px; text-align:center;}
    .aw-column-27 {width: 80px; text-align:center;}
    .aw-column-28 {width: 150px; text-align:left;}
    .aw-column-29 {width: 150px; text-align:left;}
    .aw-column-30 {width: 150px; text-align:left;}
    .aw-column-31 {width: 80px; text-align:center;}
    .aw-column-32 {width: 80px; text-align:center;}
    
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
				//$("#yearCD_S").val("${params.clientDate}".substring(0,4));
				//$("#monthCD_S").val("${params.clientDate}".substring(4,6));
				$("#yearCDFrom_S").val(unformat("${params.agoYearDate}").substring(0,4));
				$("#monthCDFrom_S").val(unformat("${params.agoYearDate}").substring(4,6));
				$("#yearCDTo_S").val("${params.clientDate}".substring(0,4));
				$("#monthCDTo_S").val("${params.clientDate}".substring(4,6));
			}else{
				//$("#yearCD_S").val("${params.eventym}".substring(0,4));
				//$("#monthCD_S").val("${params.eventym}".substring(4,6));
				$("#yearCDFrom_S").val("${params.eventym}".substring(0,4));
				$("#monthCDFrom_S").val("${params.eventym}".substring(4,6));
				$("#yearCDTo_S").val("${params.eventym}".substring(0,4));
				$("#monthCDTo_S").val("${params.eventym}".substring(4,6));
			}
			
			$("#subSegmentCD_S").attr("disabled",true);
    		$("#subSegmentCD_S").addClass("input-readonly");
    		$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
    		getApprStateCD();
    		$("#apprStateCD_S").val("20");
    		
    		if("${params.eventym}"!=""){
    			Search();
    		}
		};

		${initScript}

		$("#yearCDFrom_S").change(function(){
			Search();
		});
		$("#monthCDFrom_S").change(function(){
			Search();
		});
		$("#yearCDTo_S").change(function(){
			Search();
		});
		$("#monthCDTo_S").change(function(){
			Search();
		});
	});
	
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
	
	function getApprStateCD() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "APPRSTATECD");
	  	table.setParameter("attrib02", "MNG");
     	table.request();
		
     	if(table.getCount() > 0) {
	     	$("#apprStateCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	     		$("#apprStateCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
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

	/*
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
		, apprCommt : _i++
		, verifyErrCommt : _i++
		, apprStateCDName_emp : _i++
		, verifyStateCDName : _i++
		, verifyStateCD : _i++
		, apprStateCD_emp : _i++
		, lapprLevelNo : _i++
		, levelNo : _i++
		, lastApprYN : _i++
		, guidPayRate : _i++
		, excPayTpCD : _i++
		, rowNum : _i++
    };
	*/
	var _i = 0;
	var _col = {
		checkbox : _i++
		, mileageID : _i++
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
		, targetRate : _i++
		, msTargetRate : _i++
		, tcontractQty : _i++
		, gsvAmt : _i++
		, gsvRate : _i++
		, contractAmt : _i++
		, contractTaxAmt : _i++
		, addContractAmt : _i++
		, addContractTaxAmt : _i++
		, keymanAmt : _i++
		, payRequestDate : _i++
		, mileageStateCDName : _i++
		, mileagePayTPCDName : _i++
		//, transferDate : _i++
		, commt : _i++
		, apprCommt : _i++
		, verifyErrCommt : _i++
		, apprStateCDName_emp : _i++
		, verifyStateCDName : _i++
		, verifyStateCD : _i++
		, apprStateCD_emp : _i++
		, lapprLevelNo : _i++
		, levelNo : _i++
		, lastApprYN : _i++
		, rowNum : _i++
		
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PAY0200301S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;mileageID;rageSphereCDName;officeCDName;empNm;venueCD;venueNm;venueGradCDName;"+
	  			"segmentCDName;subSegmentCDName;addrTpCD1Name;addrTpCD2Name;contractDateFrom;"+
	  			"contractDateTo;contractMonthCt;targetRate;msTargetRate;tcontractQty;"+
	  			"gsvAmt;gsvRate;contractAmt;contractTaxAmt;addContractAmt;addContractTaxAmt;"+
	  			"keymanAmt;payRequestDate;mileageStateCDName;mileagePayTPCDName;"+
	  			"commt;apprCommt;verifyErrCommt;apprStateCDName_emp;verifyStateCDName;verifyStateCD;"+
	  			"apprStateCD_emp;lapprLevelNo;levelNo;lastApprYN;"+
	  			"rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;num;num;num5;num5;"+
	  			"num;num;num;num;num;num;"+
	  			"num;str;str;str;"+
	  			"str;str;str;str;str;str;"+
	  			"str;str;str;str;"+
	  			"str;");
	  	//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("contractDateFrom", $("#yearCDFrom_S").val()+$("#monthCDFrom_S").val());
	  	table.setParameter("contractDateTo", $("#yearCDTo_S").val()+$("#monthCDTo_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
	  	//table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("mileagePayTPCD", $("#mileagePayTPCD").val());
	  	//table.setParameter("payRate_YN", $("#payRate_YN").val());
	  	//table.setParameter("excPayTpCD_YN", $("#excPayTpCD_YN").val());
	  	//table.setParameter("gsvRate_YN", $("#gsvRate_YN").val());
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
      			
      			var verifyStateCDName = "";
      			if(table.getData(_col.verifyStateCD,i) == "10") {
      				verifyStateCDName = table.getData(_col.verifyStateCDName,i);
          		}
          		else {
          			verifyStateCDName = "<a href=\"javascript:openVerifyState('"+table.getData(_col.mileageID,i)+"');\">"+table.getData(_col.verifyStateCDName,i)+"</a>";
          		}
      			
      			data[i] = [
					""
					, table.getData(_col.mileageID,i)
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
					, formatMonth(table.getData(_col.contractDateFrom,i))
					, formatMonth(table.getData(_col.contractDateTo,i))
					, table.getData(_col.contractMonthCt,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.msTargetRate,i)
					, table.getData(_col.tcontractQty,i)
					, table.getData(_col.gsvAmt,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.contractAmt,i)
					, table.getData(_col.contractTaxAmt,i)
					, table.getData(_col.addContractAmt,i)
					, table.getData(_col.addContractTaxAmt,i)
					, table.getData(_col.keymanAmt,i)
					, formatDate(table.getData(_col.payRequestDate,i))
					, table.getData(_col.mileageStateCDName,i)
					, table.getData(_col.mileagePayTPCDName,i)
					, table.getData(_col.commt,i)
					, table.getData(_col.apprCommt,i)
					, table.getData(_col.verifyErrCommt,i)
					, table.getData(_col.apprStateCDName_emp,i)
					, verifyStateCDName
					, table.getData(_col.verifyStateCD,i)
					, table.getData(_col.apprStateCD_emp,i)
					, table.getData(_col.lapprLevelNo,i)
					, table.getData(_col.levelNo,i)
					, table.getData(_col.lastApprYN,i)
      			];
      			
      			var gsvRate = Number(unformatNum(table.getData(_col.gsvRate,i)));
				var excPayTpCD = table.getData(_col.excPayTpCD,i);
				var guidPayRate = Number(unformatNum(table.getData(_col.guidPayRate,i)));
				var payRate = Number(unformatNum(table.getData(_col.payRate,i)));
				if(gsvRate > 10) {
					grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "#ffffff");
				}
      			
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/PAY0200303S");
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
	
	function openVerifyState(mileageID) {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PAY03003C"
				+"&mileageID="+mileageID
				+"&apprTpID="+$("#apprTpID").val()
		
		newWindow(url, "PAY03003C",600,350,"yes");
	}
	
	function Approval() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var mileageIDs = new Array();
		var lastApprYNs = new Array();
		var levelNos = new Array();
		var apprCommts = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				mileageIDs[count] = grid.getCellText(_col.mileageID, index[i]);
				lastApprYNs[count] = grid.getCellText(_col.lastApprYN, index[i]);
				levelNos[count] = grid.getCellText(_col.levelNo, index[i]);
				apprCommts[count] = grid.getCellText(_col.apprCommt, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//개별승인상태가 승인요청일 경우만 가능
				if(grid.getCellText(_col.apprStateCD_emp, index[i]) != "20") {
					alert("<fmt:message key="PAY02001A.msg1"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY02001A.msg2"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay02/approvalResultMileage_err");
		table.setAsync(false);
		table.setRequestMethod("POST");
		//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("mileageIDs", mileageIDs);
		table.setParameter("lastApprYNs", lastApprYNs);
		table.setParameter("levelNos", levelNos);
		table.setParameter("apprCommts", apprCommts);
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Reject() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var mileageIDs = new Array();
		var apprCommts = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				mileageIDs[count] = grid.getCellText(_col.mileageID, index[i]);
				apprCommts[count] = grid.getCellText(_col.apprCommt, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//개별승인상태가 승인요청일 경우만 가능
				if(grid.getCellText(_col.apprStateCD_emp, index[i]) != "20") {
					alert("<fmt:message key="PAY02001A.msg3"/>");
					return;
				}
				if(grid.getCellText(_col.apprCommt, index[i]) == "") {
					alert("<fmt:message key="PAY02001A.msg4"/>");
					setCellFocus(grid, _col.apprCommt, index[i]);
					return;
				}
			}
			
		}
		
		if(!confirm("<fmt:message key="PAY02001A.msg5"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay02/rejectResultMileage_err");
		table.setAsync(false);
		table.setRequestMethod("POST");
		//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("mileageIDs", mileageIDs);
		table.setParameter("apprCommts", apprCommts);
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
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
		table.setParameter("queryKey", "PAY0200302S");
		table.setParameter("contractDateFrom", $("#yearCDFrom_S").val()+$("#monthCDFrom_S").val());
	  	table.setParameter("contractDateTo", $("#yearCDTo_S").val()+$("#monthCDTo_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
	  	//table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("mileagePayTPCD", $("#mileagePayTPCD").val());
		
		var headerText = [
			"<fmt:message key="MIL01002A.mileageID"/>"
			, "<fmt:message key="MIL01002A.rageSphereCD"/>"
			, "<fmt:message key="MIL01002A.officeCD"/>"
			, "<fmt:message key="MIL01002A.empNm"/>"
			, "<fmt:message key="MIL01002A.venueCD"/>"
			, "<fmt:message key="MIL01002A.venueNm"/>"
			, "<fmt:message key="MIL01002A.venueGradCD"/>"
			, "<fmt:message key="MIL01002A.segmentCD"/>"
			, "<fmt:message key="MIL01002A.subSegmentCD"/>"
			, "<fmt:message key="MIL01002A.addrTpCD1"/>"
			, "<fmt:message key="MIL01002A.addrTpCD2"/>"
			, "<fmt:message key="MIL01002A.contractDateFrom"/>"
			, "<fmt:message key="MIL01002A.contractDateTo"/>"
			, "<fmt:message key="MIL01002A.contractMonthCt"/>"
			, "<fmt:message key="MIL01002A.targetRate"/>"
			, "<fmt:message key="MIL01002A.msTargetRate"/>"
			, "<fmt:message key="MIL01002A.tcontractQty"/>"
			, "<fmt:message key="MIL01002A.gsvAmt"/>"
			, "<fmt:message key="MIL01002A.gsvRate"/>"
			, "<fmt:message key="MIL01002A.contractAmt"/>"
			, "<fmt:message key="MIL01002A.contractTaxAmt"/>"
			, "<fmt:message key="MIL01002A.addContractAmt"/>"
			, "<fmt:message key="MIL01002A.addContractTaxAmt"/>"
			, "<fmt:message key="MIL01002A.keymanAmt"/>"
			, "<fmt:message key="MIL01002A.payRequestDate"/>"
			, "<fmt:message key="MIL01002A.mileageStateCD"/>"
			, "<fmt:message key="MIL01002A.mileagePayTPCD"/>"
			, "<fmt:message key="PAY02001A.commt"/>"
			, "<fmt:message key="PAY02001A.apprCommt"/>"
			, "<fmt:message key="PAY02001A.verifyErrCommt"/>"
			, "<fmt:message key="PAY02001A.apprStateCDName_emp"/>"
			, "<fmt:message key="PAY02001A.verifyStateCDName"/>"
			, "<fmt:message key="MIL01002A.eventYM"/>"
			, "<fmt:message key="MIL01002B.kindTpCD5"/>"
			, "<fmt:message key="MIL01002B.prdNm"/>"
			, "<fmt:message key="MIL01002B.factoryPrice"/>"
			, "<fmt:message key="MIL01002B.qtyUnitCD"/>"
			, "<fmt:message key="MIL01002B.contractQty"/>"
			, "<fmt:message key="MIL01002B.plnEnterQty"/>"
			, "<fmt:message key="MIL01002B.plnEnterUnitAmt"/>"
			, "<fmt:message key="MIL01002B.plnAddEnterUnitAmt"/>"
			, "<fmt:message key="MIL01002B.rltEnterQty"/>"
			, "<fmt:message key="MIL01002B.rltEnterUnitAmt"/>"
			, "<fmt:message key="MIL01002B.addEnterUnitAmt"/>"
			, "<fmt:message key="MIL01002B.payAmt"/>"
			, "<fmt:message key="MIL01002B.addPayAmt"/>"
		];
		
		table.setParameter("templateFile", "PAY02003A");
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
		, "<fmt:message key="MIL01002A.mileageID"/>"
		, "<fmt:message key="MIL01002A.rageSphereCD"/>"
  		, "<fmt:message key="MIL01002A.officeCD"/>"
  		, "<fmt:message key="MIL01002A.empNm"/>"
  		, "<fmt:message key="MIL01002A.venueCD"/>"
  		, "<fmt:message key="MIL01002A.venueNm"/>"
  		, "<fmt:message key="MIL01002A.venueGradCD"/>"
  		, "<fmt:message key="MIL01002A.segmentCD"/>"
  		, "<fmt:message key="MIL01002A.subSegmentCD"/>"
  		, "<fmt:message key="MIL01002A.addrTpCD1"/>"
  		, "<fmt:message key="MIL01002A.addrTpCD2"/>"
  		, "<fmt:message key="MIL01002A.contractDateFrom"/>"
  		, "<fmt:message key="MIL01002A.contractDateTo"/>"
  		, "<fmt:message key="MIL01002A.contractMonthCt"/>"
  		, "<fmt:message key="MIL01002A.targetRate"/>"
  		, "<fmt:message key="MIL01002A.msTargetRate"/>"
  		, "<fmt:message key="MIL01002A.tcontractQty"/>"
  		, "<fmt:message key="MIL01002A.gsvAmt"/>"
  		, "<fmt:message key="MIL01002A.gsvRate"/>"
  		, "<fmt:message key="MIL01002A.contractAmt"/>"
  		, "<fmt:message key="MIL01002A.contractTaxAmt"/>"
  		, "<fmt:message key="MIL01002A.addContractAmt"/>"
  		, "<fmt:message key="MIL01002A.addContractTaxAmt"/>"
  		, "<fmt:message key="MIL01002A.keymanAmt"/>"
  		, "<fmt:message key="MIL01002A.payRequestDate"/>"
  		, "<fmt:message key="MIL01002A.mileageStateCD"/>"
  		, "<fmt:message key="MIL01002A.mileagePayTPCD"/>"
		, "<fmt:message key="PAY02001A.commt"/>"
		, "<fmt:message key="PAY02001A.apprCommt"/>"
		, "<fmt:message key="PAY02001A.verifyErrCommt"/>"
		, "<fmt:message key="PAY02001A.apprStateCDName_emp"/>"
		, "<fmt:message key="PAY02001A.verifyStateCDName"/>"
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
							str, str, str, str, str, str, str, str
							, str, str, str, str, str
							, str, num, num, num5, num5
							, num, num, num, num, num, num
							, num, str, str, str
	                        , str, str, str, str, html
	                        ]);
	    grid.setCellEditable(false);
	    grid.setCellEditable(true, _col.apprCommt);
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
			$("#selectMileageID").val(this.getCellText(_col.mileageID,row));
			
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PAY03003B";
			newWindow(url, "PAY03003B",1000,450,"yes");
		};
		
    }
	
</script>