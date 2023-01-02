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
						        			<col style="width:110px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="PAY05002A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCDFrom_S" name="yearCDFrom_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCDFrom_S" name="monthCDFrom_S" defaultText="none" category="MONTHCD" />~
													<nis:selectbox id="yearCDTo_S" name="yearCDTo_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCDTo_S" name="monthCDTo_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY05002A.dkmdTpCDName" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD_S" name="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY05002A.activityCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD2" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="PAY05002A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY05002A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY05002A.verifyStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="verifyStateCD_S" name="verifyStateCD_S" defaultText="all" category="VERIFYSTATECD" />
				                                </td>
				                            </tr>
				                            <tr>    
												<td class="td-cond">
													<fmt:message key="PAY05002A.payStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="payStateCD_S" name="payStateCD_S" defaultText="all" category="PAYSTATECD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY05002A.venue" />
												</td>
												<td class="td-input">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY05001A.mileageYN" />
												</td>
												<td class="td-input">
													<nis:selectbox id="mileageYN" name="mileageYN" defaultText="all" category="USETYPE2CD" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="PAY05002A.brandNm" />
												</td>
												<td class="td-input">
													<input type="text" id="prdNm_S" name="prdNm_S">
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY05002A.brandSelect" />
												</td>
				                            	<td class="td-input" colspan="3">
													<nis:popup id="prdCD" nameID="prdNm" nameStyle="width:200px;" inputBoxDisable="yes"/>
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
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 80px; text-align:center;}
	.aw-column-1 {width: 80px; text-align:center;}
	.aw-column-2 {width: 100px; text-align:left;}
    .aw-column-3 {width: 90px; text-align:left;}
    .aw-column-4 {width: 90px; text-align:left;}
    .aw-column-5 {width: 70px; text-align:center;}
    .aw-column-6 {width: 90px; text-align:center;}
    .aw-column-7 {width: 150px; text-align:left;}
    .aw-column-8 {width: 70px; text-align:center;}
    .aw-column-9 {width: 100px; text-align:left;}
    .aw-column-10 {width: 100px; text-align:left;}
    .aw-column-11 {width: 70px; text-align:center;}
    .aw-column-12 {width: 100px; text-align:center;}
    .aw-column-13 {width: 120px; text-align:center;}
    .aw-column-14 {width: 120px; text-align:left;} 
    .aw-column-15 {width: 60px; text-align:right;}
    .aw-column-16 {width: 70px; text-align:right;}
    .aw-column-17 {width: 60px; text-align:center;}
    .aw-column-18 {width: 70px; text-align:right;}
    .aw-column-19 {width: 70px; text-align:right;}
    .aw-column-20 {width: 70px; text-align:right;}
    .aw-column-21 {width: 80px; text-align:center;}
    .aw-column-22 {width: 80px; text-align:right;}
    .aw-column-23 {width: 80px; text-align:right;}
    .aw-column-24 {width: 80px; text-align:right;}
    .aw-column-25 {width: 80px; text-align:right;}
	.aw-column-26 {width: 80px; text-align:right;}
    .aw-column-27 {width: 70px; text-align:center;}
    .aw-column-28 {width: 70px; text-align:right;}
    .aw-column-29 {width: 70px; text-align:right;}
    .aw-column-30 {width: 120px; text-align:left;}
    .aw-column-31 {width: 100px; text-align:center; }
    .aw-column-32 {width: 100px; text-align:center; }
    .aw-column-33 {width: 150px; text-align:left; }
    .aw-column-34 {width: 100px; text-align:left;}
    .aw-column-35 {width: 100px; text-align:left;}
    .aw-column-36 {width: 90px; text-align:center;}
    .aw-column-37 {width: 80px; text-align:center;}
    .aw-column-38 {width: 120px; text-align:center;}
    .aw-column-39 {width: 100px; text-align:center; }
    
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

			if("${params.eventYM}" != ""){
				setMonthBefore();
			}else{
				$("#yearCDFrom_S").val("${params.clientDate}".substring(0,4));
				$("#monthCDFrom_S").val("${params.clientDate}".substring(4,6));
				$("#yearCDTo_S").val("${params.clientDate}".substring(0,4));
				$("#monthCDTo_S").val("${params.clientDate}".substring(4,6));
				btnClose.setStyle("display","none");
			}
    		
			if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD_S").val("${params.dkmdTpCD}");
				$("#dkmdTpCD_S").attr("disabled", true);
				$("#dkmdTpCD_S").addClass("input-readonly");
			}
    		
    		$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");

    		if("${params.venueCD}" != ""){
    			$("#venue_S").val("${params.venueCD}");
    			$("#venueCD_S").val("${params.venueCD}");
    			$("#venueNm_S").val("${params.venueNm}");
    			$("#prdCD").val("${params.prdCD};");
            	$("#prdNm").val("${params.prdNm}");
            	Search();
    		}
		};

		${initScript}

		/*
		$("#yearCDFrom_S").change(function(){
			Search();
		});
		$("#monthCDFrom_S").change(function(){
			Search();
		});
		*/

		$("#yearCDTo_S").change(function(){
			Search();
		});
		$("#monthCDTo_S").change(function(){
			Search();
		});
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
		$("#prdCD_popup").click(function(){
			openProductMultiPopup("closeProductMultiPopup");
		});

		$("#prdCD_clear").click(function() {
			$("#prdCD").val("");
			$("#prdNm").val("");
			//clear();
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

	function closeProductMultiPopup(data,j){
		var prdCDTemp = "";
		var prdNmTemp = "";
		for(var i=0;i<j;i++){
			prdCDTemp = prdCDTemp + data[i].prdCD + ";";
			prdNmTemp = prdNmTemp + data[i].prdNm + ";";
		}
		if(j>0){
			$("#prdCD").val(prdCDTemp);
			if(j == 1){
				$("#prdNm").val(data[0].prdNm);
			}else{
        		$("#prdNm").val(data[0].prdNm+" 외 "+(j-1)+"건 선택");
			}
		}
		else{
			$("#prdCD").val("");
        	$("#prdNm").val("");
		}
        //clear();
	}

	function clear() {
  		createGrid();
  		grid.refresh();
	}

	function setMonthBefore() {
		var table = new AW.XML.Table;
		var year = "${params.eventYM}".substring(0,4);
		var month = "${params.eventYM}".substring(4,6);
		table.setURL("${contextPath}/service/simpleAction/COM03002A02S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
	  			"lastMonthYear;lastMonthMon");
	  	table.setParameter("format",
	  			"str;str");
	  	table.setParameter("yearMonthTemp", "${params.eventYM}");
	  	table.setParameter("monthCnt", -11);
     	table.request();
		
     	if(table.getCount() > 0) {
     		var yearTemp = table.getData(0,0);
     		var monthTemp = table.getData(1,0);

     		$("#yearCDFrom_S").val(yearTemp);
			$("#monthCDFrom_S").val(monthTemp);
			$("#yearCDTo_S").val(year);
			$("#monthCDTo_S").val(month);
		}
	}

	function months_between(fromYearMonth, toYearMonth){
		var cnt = 0;
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/ANL0101103S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
	  			"cnt;");
	  	table.setParameter("format",
	  			"str");
	  	table.setParameter("fromYearMonth", fromYearMonth);
	  	table.setParameter("toYearMonth", toYearMonth);
     	table.request();
     	if(table.getCount() > 0) {
     		cnt = table.getData(0,0);
			//$("#yearCDTo_S").val(year);
			//$("#monthCDTo_S").val(month);
		}
     	return cnt;
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
		  eventYM : _i++
		, dkmdTpCDName : _i++
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
		, payAmt : _i++
		//, mileagePayAmt : _i++
		//, totalPayAmt : _i++
		, targetQty : _i++
		, sdxTpCDName : _i++
		, targetRate : _i++
		, gsvRate : _i++
		, commt : _i++
		, verifyStateCDName : _i++
		, payStateCDName : _i++ 
		, payCommt : _i++ 
		, transferDueDate : _i++
		, transferDate : _i++
		, keymanName : _i++
		, bankCDName : _i++
		, accountNo : _i++
		, holderNm : _i++
		, sdxTpCD : _i++
		, rowNum : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/ANL0101001S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"eventYM;dkmdTpCDName;activityCDName;rageSphereCDName;officeCDName;empNm;"+
	  			"venueCD;venueNm;venueGradCDName;segmentCDName;subSegmentCDName;"+
	  			"addrTpCD1Name;addrTpCD2Name;kindTpCD5Name;prdNm;eu;"+
	  			"factoryPrice;qtyUnitCDName;planQty;planUnitAmt;rfidQty;"+
	  			"resultTpCDName;resultQty;resultUnitAmt;guidAmt;payAmt;"+
	  			"targetQty;sdxTpCDName;targetRate;gsvRate;commt;"+
	  			"verifyStateCDName;payStateCDName;payCommt;transferDueDate;transferDate;keymanName;"+
	  			"bankCDName;accountNo;holderNm;sdxTpCD;rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;num5;"+
	  			"num;str;num;num;num;"+
	  			"str;num;num;num;num;"+
	  			"num5;str;num;num;str;"+
	  			"str;str;str;str;str;str;"+
	  			"str;str;str;str;str;");
	  	table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	table.setParameter("eventFromYM", $("#yearCDFrom_S").val()+$("#monthCDFrom_S").val());
	  	table.setParameter("eventToYM", $("#yearCDTo_S").val()+$("#monthCDTo_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("verifyStateCD", $("#verifyStateCD_S").val());
	  	table.setParameter("payStateCD", $("#payStateCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("mileageYN", $("#mileageYN").val());
	  	if($("#prdCD").val()!=""){
	  		table.setParameter("prdCDs", $("#prdCD").val().split(";"));
	  	}
	  	table.setParameter("prdNm_S", $("#prdNm_S").val());
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
					  formatMonth(table.getData(_col.eventYM,i))
					, table.getData(_col.dkmdTpCDName,i)
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
					, table.getData(_col.payAmt,i)
					//, table.getData(_col.mileagePayAmt,i)
					//, table.getData(_col.totalPayAmt,i)
					, table.getData(_col.targetQty,i)
					, table.getData(_col.sdxTpCDName,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.commt,i)
					, table.getData(_col.verifyStateCDName,i)
					, table.getData(_col.payStateCDName,i)
					, table.getData(_col.payCommt,i)
					, formatDate(table.getData(_col.transferDueDate,i))
					, formatDate(table.getData(_col.transferDate,i))
					, table.getData(_col.keymanName,i)
					, table.getData(_col.bankCDName,i)
					, table.getData(_col.accountNo,i)
					, table.getData(_col.holderNm,i)
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
      			
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      		//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/ANL0101002S");
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
	
	
	function Excel() {
		var cnt = months_between($("#yearCDFrom_S").val()+$("#monthCDFrom_S").val(),$("#yearCDTo_S").val()+$("#monthCDTo_S").val());
		if(cnt>12){
			alert("<fmt:message key="ANL01002A.msg2"/>");
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "ANL0101001S");
		table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
		table.setParameter("eventFromYM", $("#yearCDFrom_S").val()+$("#monthCDFrom_S").val());
		table.setParameter("eventToYM", $("#yearCDTo_S").val()+$("#monthCDTo_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("verifyStateCD", $("#verifyStateCD_S").val());
	  	table.setParameter("payStateCD", $("#payStateCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("mileageYN", $("#mileageYN").val());
	  	if($("#prdCD").val()!=""){
	  		table.setParameter("prdCDs", $("#prdCD").val().split(";"));
	  	}
	  	table.setParameter("prdNm_S", $("#prdNm_S").val());
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
				  "<fmt:message key="PAY05002A.eventYM"/>"
				, "<fmt:message key="PAY05002A.dkmdTpCDName"/>"
				, "<fmt:message key="PAY05002A.activityCD"/>"
				, "<fmt:message key="PAY05002A.rageSphereCD"/>"
				, "<fmt:message key="PAY05002A.officeCD"/>"
				, "<fmt:message key="PAY05002A.empNm"/>"
				, "<fmt:message key="PAY05002A.venueCD"/>"
				, "<fmt:message key="PAY05002A.venueNm"/>"
				, "<fmt:message key="PAY05002A.venueGradCD"/>"
				, "<fmt:message key="PAY05002A.segmentCD"/>"
				, "<fmt:message key="PAY05002A.subSegmentCD"/>"
				, "<fmt:message key="PAY05002A.addrTpCD1"/>"
				, "<fmt:message key="PAY05002A.addrTpCD2"/>"
				, "<fmt:message key="PAY05002A.kindTpCD5"/>"
				, "<fmt:message key="PAY05002A.prdNm"/>"
				, "<fmt:message key="PAY05002A.eu"/>"
				, "<fmt:message key="PAY05002A.factoryPrice"/>"
				, "<fmt:message key="PAY05002A.qtyUnitCD"/>"
				, "<fmt:message key="PAY05002A.planQty"/>"
				, "<fmt:message key="PAY05002A.planUnitAmt"/>"
				, "<fmt:message key="PAY05002A.rfidQty"/>"
				, "<fmt:message key="PAY05002A.resultTpCD"/>"
				, "<fmt:message key="PAY05002A.resultQty"/>"
				, "<fmt:message key="PAY05002A.resultUnitAmt"/>"
				, "<fmt:message key="PAY05002A.guidAmt"/>"
				, "<fmt:message key="PAY05002A.payAmt"/>"
				//, "<fmt:message key="PAY05002A.mileagePayAmt"/>"
				//, "<fmt:message key="PAY05002A.totalPayAmt"/>"
				, "<fmt:message key="PAY05002A.targetQty"/>"
				, "<fmt:message key="PAY05002A.sdxTpCD"/>"
				, "<fmt:message key="PAY05002A.targetRate"/>"
				, "<fmt:message key="PAY05002A.gsvRate"/>"
				, "<fmt:message key="PAY05002A.commt"/>"
				, "<fmt:message key="PAY05002A.verifyStateCD"/>"
				, "<fmt:message key="PAY05002A.payStateCD"/>"
				, "<fmt:message key="PAY05002A.payCommt"/>"
				, "<fmt:message key="PAY05002A.transferDueDate"/>"
				, "<fmt:message key="PAY05002A.transferDate"/>"
				/*
				, "<fmt:message key="PAY05002A.keymanName"/>"
				, "<fmt:message key="PAY05002A.bankCDName"/>"
				, "<fmt:message key="PAY05002A.accountNo"/>"
				, "<fmt:message key="PAY05002A.holderNm"/>"
				*/
		];
		
		table.setParameter("templateFile", "ANL01010A");
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

	function Close(){
		window.close();
	}
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
			  "<fmt:message key="PAY05002A.eventYM"/>"
			, "<fmt:message key="PAY05002A.dkmdTpCDName"/>"
			, "<fmt:message key="PAY05002A.activityCD"/>"
			, "<fmt:message key="PAY05002A.rageSphereCD"/>"
			, "<fmt:message key="PAY05002A.officeCD"/>"
			, "<fmt:message key="PAY05002A.empNm"/>"
			, "<fmt:message key="PAY05002A.venueCD"/>"
			, "<fmt:message key="PAY05002A.venueNm"/>"
			, "<fmt:message key="PAY05002A.venueGradCD"/>"
			, "<fmt:message key="PAY05002A.segmentCD"/>"
			, "<fmt:message key="PAY05002A.subSegmentCD"/>"
			, "<fmt:message key="PAY05002A.addrTpCD1"/>"
			, "<fmt:message key="PAY05002A.addrTpCD2"/>"
			, "<fmt:message key="PAY05002A.kindTpCD5"/>"
			, "<fmt:message key="PAY05002A.prdNm"/>"
			, "<fmt:message key="PAY05002A.eu"/>"
			, "<fmt:message key="PAY05002A.factoryPrice"/>"
			, "<fmt:message key="PAY05002A.qtyUnitCD"/>"
			, "<fmt:message key="PAY05002A.planQty"/>"
			, "<fmt:message key="PAY05002A.planUnitAmt"/>"
			, "<fmt:message key="PAY05002A.rfidQty"/>"
			, "<fmt:message key="PAY05002A.resultTpCD"/>"
			, "<fmt:message key="PAY05002A.resultQty"/>"
			, "<fmt:message key="PAY05002A.resultUnitAmt"/>"
			, "<fmt:message key="PAY05002A.guidAmt"/>"
			, "<fmt:message key="PAY05002A.payAmt"/>"
			//, "<fmt:message key="PAY05002A.mileagePayAmt"/>"
			//, "<fmt:message key="PAY05002A.totalPayAmt"/>"
			, "<fmt:message key="PAY05002A.targetQty"/>"
			, "<fmt:message key="PAY05002A.sdxTpCD"/>"
			, "<fmt:message key="PAY05002A.targetRate"/>"
			, "<fmt:message key="PAY05002A.gsvRate"/>"
			, "<fmt:message key="PAY05002A.commt"/>"
			, "<fmt:message key="PAY05002A.verifyStateCD"/>"
			, "<fmt:message key="PAY05002A.payStateCD"/>"
			, "<fmt:message key="PAY05002A.payCommt"/>"
			, "<fmt:message key="PAY05002A.transferDueDate"/>"
			, "<fmt:message key="PAY05002A.transferDate"/>"
			/*
			, "<fmt:message key="PAY05002A.keymanName"/>"
			, "<fmt:message key="PAY05002A.bankCDName"/>"
			, "<fmt:message key="PAY05002A.accountNo"/>"
			, "<fmt:message key="PAY05002A.holderNm"/>"
			*/
	];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(true);
		grid.setSelectorWidth(40);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
	    grid.setSelectionMode("single-cell");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
							  str, str, str, str, str, str, str, str, str, str, str
							, str, str, str, str, num5, num, str, num, num, num
							, str, num, num, num, num, num5, str, num, num, str 
							//, str, str, str, str, str, str, str, str, str]);
							, str, str, str, str, str]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(7);
	    
    }
	
</script>