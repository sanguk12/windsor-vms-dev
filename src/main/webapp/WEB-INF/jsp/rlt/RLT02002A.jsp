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
						        			<col style="width:120px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="RLT02002A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT02002A.activityCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="RLT02002A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
				                                </td>
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="RLT02002A.segmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="segmentCD_S" name="segmentCD_S" defaultText="all" category="SEGMENTCD" event="onchange" eventproc="getSubSegment(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT02002A.subSegmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="subSegmentCD_S" name="subSegmentCD_S" defaultText="all" category="SUBSEGMENTCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT02002A.overGuidAmt" />
												</td>
												<td class="td-input">
				                                	<select id="overGuidAmt_S" name="overGuidAmt_S">
				                                     	<option value=""><fmt:message key="all"/></option>
				                                     	<option value="Y">Y</option>
													</select>
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="RLT02002A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT02002A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="RLT02002A.kindTpCD5" />
												</td>
												<td class="td-input">
													<nis:selectbox id="kindTpCD5_S" name="kindTpCD5_S" defaultText="all" category="KINDTPCD5" />
				                                </td>
				                            </tr>
				                            <tr>    
												<td class="td-cond">
													<fmt:message key="RLT02002A.apprStateCD" />
												</td>
												<td class="td-input">
													<select id="apprStateCD_S" name="apprStateCD_S"></select>
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT02002A.sdxTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="sdxTpCD_S" name="sdxTpCD_S" defaultText="all" category="SDXTPCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PLN02001A.dkmdTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD_S" name="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="RLT02002A.plnRltCompareYN" />
												</td>
												<td class="td-input" colspan="5">
													<nis:selectbox id="plnRltCompareYN" name="plnRltCompareYN" defaultText="all" category="USETYPE2CD" />
													<!--
													<select id="plnRltCompareYN">
														<option value=""><fmt:message key="all"/></option>
														<option value="Y">Y</option>
													</select>
													-->
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
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="selectPrdCD" name="selectPrdCD" />
						<input type="hidden" id="apprTpID" name="apprTpID" value="000000" /><!-- Plan/Result승인라인 -->
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
	.aw-column-1 {width: 80px; text-align:left;}
    .aw-column-2 {width: 90px; text-align:left;}
    .aw-column-3 {width: 90px; text-align:left;}
    .aw-column-4 {width: 70px; text-align:center;}
    .aw-column-5 {width: 70px; text-align:center;}
    .aw-column-6 {width: 120px; text-align:left;}
    .aw-column-7 {width: 70px; text-align:center;}
    .aw-column-8 {width: 100px; text-align:left;}
    .aw-column-9 {width: 100px; text-align:left;}
    .aw-column-10 {width: 70px; text-align:center;}
    .aw-column-11 {width: 100px; text-align:center;}
    .aw-column-12 {width: 120px; text-align:center;}
    .aw-column-13 {width: 120px; text-align:left;} 
    .aw-column-14 {width: 60px; text-align:right;}
    .aw-column-15 {width: 70px; text-align:right;}
    .aw-column-16 {width: 60px; text-align:center;}
    .aw-column-17 {width: 70px; text-align:right;}
    .aw-column-18 {width: 70px; text-align:right;}
    .aw-column-19 {width: 70px; text-align:right;}
    .aw-column-20 {width: 80px; text-align:left;}
    .aw-column-21 {width: 80px; text-align:right;}
    .aw-column-22 {width: 80px; text-align:right;}
    .aw-column-23 {width: 80px; text-align:right;}
    .aw-column-24 {width: 130px; text-align:right;}
    .aw-column-25 {width: 80px; text-align:right;}
	.aw-column-26 {width: 80px; text-align:right;}
    .aw-column-27 {width: 70px; text-align:center;}
    .aw-column-28 {width: 70px; text-align:right;}
    .aw-column-29 {width: 70px; text-align:right;}
    .aw-column-30 {width: 120px; text-align:left;}
    .aw-column-31 {width: 120px; text-align:left; }
    .aw-column-32 {width: 70px; text-align:center; }
    .aw-column-33 {width: 70px; text-align:center; }

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
				$("#yearCD_S").val("${params.clientDate}".substring(0,4));
				$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			}else{
				$("#yearCD_S").val("${params.eventym}".substring(0,4));
				$("#monthCD_S").val("${params.eventym}".substring(4,6));
			}
			
			$("#subSegmentCD_S").attr("disabled",true);
    		$("#subSegmentCD_S").addClass("input-readonly");
    		$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
    		getApprStateCD();
    		$("#apprStateCD_S").val("20");
    		
    		if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD_S").val("${params.dkmdTpCD}");
				$("#dkmdTpCD_S").attr("disabled", true);
				$("#dkmdTpCD_S").addClass("input-readonly");
			}
    		
    		if("${params.eventym}"!=""){
    			Search();
    		}
		};

		${initScript}

		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
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
	
	var _i = 0;
	var _col = {
		checkbox : _i++
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
		, kindTpCD5Name : _i++
		, prdNm : _i++
		, eu : _i++
		, factoryPrice : _i++
		, qtyUnitCDName : _i++
		, planQty : _i++
		, planUnitAmt : _i++
		, rfidQty : _i++
		, resultTpCDName : _i++
		, resultQty : _i++
		, resultUnitAmt : _i++
		, guidAmt : _i++
		, planPayAmt : _i++
		, payAmt : _i++
		, targetQty : _i++
		, sdxTpCDName : _i++
		, targetRate : _i++
		, gsvRate : _i++
		, commt : _i++
		, apprCommt : _i++
		, apprStateCDName_emp : _i++
		, apprStateCDName : _i++
		, apprStateCD : _i++
		, apprStateCD_emp : _i++
		, lapprLevelNo : _i++
		, levelNo : _i++
		, lastApprYN : _i++
		, prdCD : _i++
		, sdxTpCD : _i++
		, rowNum : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0200201S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;activityCDName;rageSphereCDName;officeCDName;empNm;"+
	  			"venueCD;venueNm;venueGradCDName;segmentCDName;subSegmentCDName;"+
	  			"addrTpCD1Name;addrTpCD2Name;kindTpCD5Name;prdNm;eu;"+
	  			"factoryPrice;qtyUnitCDName;planQty;planUnitAmt;rfidQty;"+
	  			"resultTpCDName;resultQty;resultUnitAmt;guidAmt;planPayAmt;payAmt;"+
	  			"targetQty;sdxTpCDName;targetRate;gsvRate;commt;"+
	  			"apprCommt;apprStateCDName_emp;apprStateCDName;apprStateCD;apprStateCD_emp;"+
	  			"lapprLevelNo;levelNo;lastApprYN;prdCD;sdxTpCD;"+
	  			"rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;num5;"+
	  			"num;str;num;num;num;"+
	  			"str;num;num;num;num;num;"+
	  			"num5;str;num;num;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("apprTpID", $("#apprTpID").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("overGuidAmt", $("#overGuidAmt_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("kindTpCD5", $("#kindTpCD5_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("sdxTpCD", $("#sdxTpCD_S").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("plnRltCompareYN", $("#plnRltCompareYN").val());
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
      			
      			var apprStateCDName = "";
      			if(table.getData(_col.apprStateCD,i) == "10") {
      				apprStateCDName = table.getData(_col.apprStateCDName,i);
          		}
          		else {
          			apprStateCDName = "<a href=\"javascript:openApprState('"+i+"');\">"+table.getData(_col.apprStateCDName,i)+"</a>";
          		}
      			
      			data[i] = [
					table.getData(_col.checkbox,i)
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
					, table.getData(_col.kindTpCD5Name,i)
					, table.getData(_col.prdNm,i)
					, table.getData(_col.eu,i)
					, table.getData(_col.factoryPrice,i)
					, table.getData(_col.qtyUnitCDName,i)
					, table.getData(_col.planQty,i)
					, table.getData(_col.planUnitAmt,i)
					, table.getData(_col.rfidQty,i)
					, table.getData(_col.resultTpCDName,i)
					, table.getData(_col.resultQty,i)
					, table.getData(_col.resultUnitAmt,i)
					, table.getData(_col.guidAmt,i)
					, table.getData(_col.planPayAmt,i)
					, table.getData(_col.payAmt,i)
					, table.getData(_col.targetQty,i)
					, table.getData(_col.sdxTpCDName,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.commt,i)
					, table.getData(_col.apprCommt,i)
					, table.getData(_col.apprStateCDName_emp,i)
					, apprStateCDName
					, table.getData(_col.apprStateCD,i)
					, table.getData(_col.apprStateCD_emp,i)
					, table.getData(_col.lapprLevelNo,i)
					, table.getData(_col.levelNo,i)
					, table.getData(_col.lastApprYN,i)
					, table.getData(_col.prdCD,i)
					, table.getData(_col.sdxTpCD,i)
      			];
      			
      			var resultUnitAmt = parseInt(unformat(table.getData(_col.resultUnitAmt,i)));
      			var guidAmt = parseInt(unformat(table.getData(_col.guidAmt,i)));
      			
      			if(resultUnitAmt > guidAmt) {
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("background", "");
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("color", "");	
      			}

      			var sdxTpCD = table.getData(_col.sdxTpCD,i);
      			if(sdxTpCD == "3LT") {
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("background", "");
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("color", "");	
      			}
      			
      			var targetRate = parseInt(unformat(table.getData(_col.targetRate,i)));
      			
      			if(targetRate < 70 || targetRate > 150) {
      				grid.getCellTemplate(_col.targetRate, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.targetRate, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.targetRate, i).setStyle("background", "");
      				grid.getCellTemplate(_col.targetRate, i).setStyle("color", "");
      			}
      			
      			var gsvRate = parseInt(unformat(table.getData(_col.gsvRate,i)));
      			if(gsvRate > 30) {
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "");
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "");	
      			}

      			var planPayAmt = Number(unformatNum(table.getData(_col.planPayAmt,i)));
				var payAmt =  Number(unformatNum(table.getData(_col.payAmt,i)));
				if(planPayAmt>payAmt){
		     		grid.getCellTemplate(_col.payAmt, i).setStyle("color", "#0000ff");
		     	}
		     	if(planPayAmt<payAmt){
		     		grid.getCellTemplate(_col.payAmt, i).setStyle("color", "#ff0000");
		     	}
      			
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/RLT0200206S");
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
	
	function openApprState(i) {
		$("#selectVenueCD").val(grid.getCellText(_col.venueCD,i));
      	$("#selectPrdCD").val(grid.getCellText(_col.prdCD,i));
      	
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01003B"
			+"&eventYM="+$("#yearCD_S").val()+$("#monthCD_S").val()
			+"&venueCD="+$("#selectVenueCD").val()
			+"&prdCD="+$("#selectPrdCD").val()
			+"&apprTpID="+$("#apprTpID").val();
		
		newWindow(url, "RLT01003B",600,350,"yes");
	}
	
	function Approval() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var prdCDs = new Array();
		var venueCDs = new Array();
		var lastApprYNs = new Array();
		var levelNos = new Array();
		var apprCommts = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				prdCDs[count] = grid.getCellText(_col.prdCD, index[i]);
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
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
					alert("<fmt:message key="PLN02001A.msg1"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PLN02001A.msg2"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt02/approvalResultBrand");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("venueCDs", venueCDs);
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
		
		var venueCDs = new Array();
		var prdCDs = new Array();
		var apprCommts = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				prdCDs[count] = grid.getCellText(_col.prdCD, index[i]);
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
					alert("<fmt:message key="PLN02001A.msg3"/>");
					return;
				}
				if(grid.getCellText(_col.apprCommt, index[i]) == "") {
					alert("<fmt:message key="PLN02001A.msg4"/>");
					setCellFocus(grid, _col.apprCommt, index[i]);
					return;
				}
			}
			
		}
		
		if(!confirm("<fmt:message key="PLN02001A.msg5"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt02/rejectResultBrand");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("prdCDs", prdCDs);
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
		table.setParameter("queryKey", "RLT0200205S");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("apprTpID", $("#apprTpID").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("overGuidAmt", $("#overGuidAmt_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("kindTpCD5", $("#kindTpCD5_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("sdxTpCD", $("#sdxTpCD_S").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("plnRltCompareYN", $("#plnRltCompareYN").val());
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
				"<fmt:message key="RLT02002A.activityCD"/>"
				, "<fmt:message key="RLT02002A.rageSphereCD"/>"
				, "<fmt:message key="RLT02002A.officeCD"/>"
				, "<fmt:message key="RLT02002A.empNm"/>"
				, "<fmt:message key="RLT02002A.venueCD"/>"
				, "<fmt:message key="RLT02002A.venueNm"/>"
				, "<fmt:message key="RLT02002A.venueGradCD"/>"
				, "<fmt:message key="RLT02002A.segmentCD"/>"
				, "<fmt:message key="RLT02002A.subSegmentCD"/>"
				, "<fmt:message key="RLT02002A.addrTpCD1"/>"
				, "<fmt:message key="RLT02002A.addrTpCD2"/>"
				, "<fmt:message key="RLT02002A.kindTpCD5"/>"
				, "<fmt:message key="RLT02002A.prdNm"/>"
				, "<fmt:message key="RLT02002A.eu"/>"
				, "<fmt:message key="RLT02002A.factoryPrice"/>"
				, "<fmt:message key="RLT02002A.qtyUnitCD"/>"
				, "<fmt:message key="RLT02002A.planQty"/>"
				, "<fmt:message key="RLT02002A.planUnitAmt"/>"
				, "<fmt:message key="RLT02002A.rfidQty"/>"
				, "<fmt:message key="RLT02002A.resultTpCD"/>"
				, "<fmt:message key="RLT02002A.resultQty"/>"
				, "<fmt:message key="RLT02002A.resultUnitAmt"/>"
				, "<fmt:message key="RLT02002A.guidAmt"/>"
				, "<fmt:message key="RLT02002A.payAmt"/>"
				, "<fmt:message key="RLT02002A.targetQty"/>"
				, "<fmt:message key="RLT02002A.sdxTpCD"/>"
				, "<fmt:message key="RLT02002A.targetRate"/>"
				, "<fmt:message key="RLT02002A.gsvRate"/>"
				, "<fmt:message key="RLT02002A.commt"/>"
				, "<fmt:message key="RLT02002A.apprCommt"/>"
				, "<fmt:message key="RLT02002A.apprStateCD_emp"/>"
				, "<fmt:message key="RLT02002A.apprStateCDName"/>"
		];
		
		table.setParameter("templateFile", "RLT02002A");
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

	function PayHistory() {
		if(grid.getCellText(_col.prdCD, grid.getSelectedRows()) == ""){
			alert("상품을 선택하여 주십시오.");
			return;
		}
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var venueCD = grid.getCellText(_col.venueCD, grid.getSelectedRows());
		var venueNm = grid.getCellText(_col.venueNm, grid.getSelectedRows());
		var prdCD = grid.getCellText(_col.prdCD, grid.getSelectedRows());
		var prdNm = grid.getCellText(_col.prdNm, grid.getSelectedRows());

		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=ANL01010A"
			+"&diffNo="+diffNo+"&eventYM="+eventYM+"&venueCD="+venueCD+"&venueNm="+venueNm+"&prdCD="+prdCD+"&prdNm="+prdNm;
		
		newWindow(url, "ANL01010A",1080,540,"yes");
	}

	function ApprovalHistory(){
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var rageSphereCD_pop = $("#rageSphereCD_S").val();
		var officeCD_pop = $("#officeCD_S").val();
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PLN02002B"
			+"&diffNo="+diffNo+"&eventYM="+eventYM+"&rltYN=Y"+"&rageSphereCD_pop="+rageSphereCD_pop+"&officeCD_pop="+officeCD_pop;
		
		newWindow(url, "PLN02002B",1080,520,"yes");
	}
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
			""
			, "<fmt:message key="RLT02002A.activityCD"/>"
			, "<fmt:message key="RLT02002A.rageSphereCD"/>"
			, "<fmt:message key="RLT02002A.officeCD"/>"
			, "<fmt:message key="RLT02002A.empNm"/>"
			, "<fmt:message key="RLT02002A.venueCD"/>"
			, "<fmt:message key="RLT02002A.venueNm"/>"
			, "<fmt:message key="RLT02002A.venueGradCD"/>"
			, "<fmt:message key="RLT02002A.segmentCD"/>"
			, "<fmt:message key="RLT02002A.subSegmentCD"/>"
			, "<fmt:message key="RLT02002A.addrTpCD1"/>"
			, "<fmt:message key="RLT02002A.addrTpCD2"/>"
			, "<fmt:message key="RLT02002A.kindTpCD5"/>"
			, "<fmt:message key="RLT02002A.prdNm"/>"
			, "<fmt:message key="RLT02002A.eu"/>"
			, "<fmt:message key="RLT02002A.factoryPrice"/>"
			, "<fmt:message key="RLT02002A.qtyUnitCD"/>"
			, "<fmt:message key="RLT02002A.planQty"/>"
			, "<fmt:message key="RLT02002A.planUnitAmt"/>"
			, "<fmt:message key="RLT02002A.rfidQty"/>"
			, "<fmt:message key="RLT02002A.resultTpCD"/>"
			, "<fmt:message key="RLT02002A.resultQty"/>"
			, "<fmt:message key="RLT02002A.resultUnitAmt"/>"
			, "<fmt:message key="RLT02002A.guidAmt"/>"
			, "<fmt:message key="RLT02002A.planAmtStd"/>"
			, "<fmt:message key="RLT02002A.payAmt"/>"
			, "<fmt:message key="RLT02002A.targetQty"/>"
			, "<fmt:message key="RLT02002A.sdxTpCD"/>"
			, "<fmt:message key="RLT02002A.targetRate"/>"
			, "<fmt:message key="RLT02002A.gsvRate"/>"
			, "<fmt:message key="RLT02002A.commt"/>"
			, "<fmt:message key="RLT02002A.apprCommt"/>"
			, "<fmt:message key="RLT02002A.apprStateCD_emp"/>"
			, "<fmt:message key="RLT02002A.apprStateCDName"/>"
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
							str, str, str, str, str, str, str, str, str, str
							, str, str, str, str, num5, num, str, num, num, num
							, str, num, num, num, num, num, num5, str, num, num, str 
							, str, str, html]);
	    grid.setCellEditable(false);
	    grid.setCellEditable(true, _col.apprCommt);
	    grid.setFixedLeft(7);
	    
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
		};
    }
	
</script>