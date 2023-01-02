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
						        			<col style="width:280px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:150px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
				                            	<!-- 
				                            	<td class="td-cond">
													<fmt:message key="ANL01002A.programCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="programCD_S" name="programCD_S" defaultText="all" category="PROGRAMCD" style="width:60px;" />
				                                </td>
				                                 -->
												<td class="td-cond-required">
													<fmt:message key="ANL01002A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCDFrom_S" name="yearCDFrom_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCDFrom_S" name="monthCDFrom_S" defaultText="none" category="MONTHCD" />~
													<nis:selectbox id="yearCDTo_S" name="yearCDTo_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCDTo_S" name="monthCDTo_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="MDM01001A.dkmdTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" style="width:60px;" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="ANL01002A.activityCD" />
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
				                                <td class="td-cond" style="display:none">
					                           		<fmt:message key="MDM03001B.kindTpCD2" />
				      							</td>
				      							<td class="td-input" style="display:none">
													<nis:selectbox id="kindTpCD2_S" defaultText="select" category="KINDTPCD2" />
	                           					</td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="ANL01003A.kindTpCD5" />
												</td>
												<td class="td-input">
													<nis:selectbox id="kindTpCD5_S" name="kindTpCD5_S" defaultText="all" category="KINDTPCD5" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL01002A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL01002A.officeCD" />
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
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
				                            	<td class="td-input">
													<nis:popup id="prdCD" nameID="prdNm" nameStyle="width:200px;" inputBoxDisable="yes"/>
					                           	</td>
					                           	<td class="td-cond">
													<fmt:message key="PAY05001A.venue" />
												</td>
												<td class="td-input" colspan="3">
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

	/*.aw-column-0 {width: 70px; text-align:center;}
	.aw-column-1 {width: 60px; text-align:center;}
	.aw-column-2 {width: 60px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:left;}
    .aw-column-4 {width: 70px; text-align:center;}*/
    .aw-column-0 {width: 100px; text-align:left;}
    .aw-column-1 {width: 100px; text-align:left;}
    .aw-column-2 {width: 70px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:center;}
    .aw-column-4 {width: 150px; text-align:left;}
    .aw-column-5 {width: 90px; text-align:center;}
    .aw-column-6 {width: 120px; text-align:left;}
    .aw-column-7 {width: 70px; text-align:center;}
    .aw-column-8 {width: 100px; text-align:left;}
    .aw-column-9 {width: 100px; text-align:left;}
    .aw-column-10 {width: 100px; text-align:center;}
    .aw-column-11 {width: 100px; text-align:center;}
    .aw-column-12 {width: 120px; text-align:center;}
    .aw-column-13 {width: 150px; text-align:center;}
    .aw-column-14 {width: 100px; text-align:left;}
    .aw-column-15 {width: 100px; text-align:right;}
    .aw-column-16 {width: 100px; text-align:right;}
    .aw-column-17 {width: 100px; text-align:right;}
    .aw-column-18 {width: 80px; text-align:right;}

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
			
			//$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			//$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			$("#yearCDFrom_S").val("${params.clientDate}".substring(0,4));
			$("#monthCDFrom_S").val("${params.clientDate}".substring(4,6));
			$("#yearCDTo_S").val("${params.clientDate}".substring(0,4));
			$("#monthCDTo_S").val("${params.clientDate}".substring(4,6));
			//getDiffNo();
			//$("#diffNo").attr("disabled", true);
			//$("#diffNo").addClass("input-readonly");
			setMonthBefore();
			if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD_S").val("${params.dkmdTpCD}");
				$("#dkmdTpCD_S").attr("disabled", true);
				$("#dkmdTpCD_S").addClass("input-readonly");
			}
			
    		$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
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
		$("#prdCD_popup").click(function(){
			openProductMultiPopup("closeProductMultiPopup");
		});

		$("#prdCD_clear").click(function() {
			$("#prdCD").val("");
			$("#prdNm").val("");
			//clear();
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
		/*
		$("#programCD_S").change(function(){
			//getDiffNo();
		});
		$("#yearCD_S").change(function(){
			if($("#programCD_S").val()=="G2") {
				getDiffNo();
			}
		});
		$("#monthCD_S").change(function(){
			if($("#programCD_S").val()=="G2") {
				getDiffNo();
			}
		});
		*/
	});
	
	//등록된 G2차수 가져오기
	/*
	function getDiffNo() {
		if($("#programCD_S").val()=="G2") {
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/simpleAction/RLT0300105S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	     	table.request();
			
	     	if(table.getCount() > 0) {
	     		$("#diffNo").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	         	for(var i=0; i<table.getCount(); i++) {
	         		$("#diffNo").append('<option value="'+table.getData(0,i)+'">'+table.getData(1,i)+'</option>');
	       		}
			}
	     	else {
	     		$("#diffNo").find("option").remove().end().append('<option value=""><fmt:message key="nothing"/></option>');
	     	}
	     	$("#diffNo").attr("disabled", false);
			$("#diffNo").removeClass("input-readonly");
		}
		else {
			$("#diffNo").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
			$("#diffNo").attr("disabled", true);
			$("#diffNo").addClass("input-readonly");
		}
	}
	*/

	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
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
	  	table.setParameter("yearMonthTemp", "${params.clientDate}".substring(0,6));
	  	table.setParameter("monthCnt", -2);
     	table.request();
		
     	if(table.getCount() > 0) {
     		var yearTemp = table.getData(0,0);
     		var monthTemp = table.getData(1,0);

     		$("#yearCDFrom_S").val(yearTemp);
			$("#monthCDFrom_S").val(monthTemp);
			//$("#yearCDTo_S").val(year);
			//$("#monthCDTo_S").val(month);
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
		//eventYM : _i++
		//, diffNo : _i++
		//, programCDName : _i++
		//, activityCDName : _i++
		//, dkmdTpCDName : _i++
		rageSphereCDName : _i++
		, officeCDName : _i++
		, empNm : _i++
		, venueCD : _i++
		, venueNm : _i++
		, wsSapCD : _i++
		, wsSapCDName : _i++
		, venueGradCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, addrTpCD3Name : _i++
		, addrTpCD4Name : _i++
		, kindTpCD5Name : _i++
		, resultQty : _i++
		, finalUnitAmt : _i++
		, euResultQty : _i++
		, eventCnt : _i++
		, rowNum : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/ANL0101101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"rageSphereCDName;officeCDName;empNm;venueCD;venueNm;"+
	  			"wsSapCD;wsSapCDName;venueGradCDName;segmentCDName;subSegmentCDName;"+
	  			"addrTpCD1Name;addrTpCD2Name;addrTpCD3Name;addrTpCD4Name;kindTpCD5Name;resultQty;"+
	  			"finalUnitAmt;euResultQty;eventCnt;rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;num;"+
	  			"num;num5;num;str;");
	  	table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	//table.setParameter("programCD", $("#programCD_S").val());
	  	//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("eventFromYM", $("#yearCDFrom_S").val()+$("#monthCDFrom_S").val());
	  	table.setParameter("eventToYM", $("#yearCDTo_S").val()+$("#monthCDTo_S").val());
	  	//table.setParameter("diffNo", $("#diffNo").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	if($("#prdCD").val()!=""){
	  		table.setParameter("prdCDs", $("#prdCD").val().split(";"));
	  	}
	  	table.setParameter("prdNm_S", $("#prdNm_S").val());
	  	table.setParameter("kindTpCD2_S", $("#kindTpCD2_S").val());
	  	table.setParameter("kindTpCD5_S", $("#kindTpCD5_S").val());
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
					table.getData(_col.rageSphereCDName,i)
					, table.getData(_col.officeCDName,i)
					, table.getData(_col.empNm,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.wsSapCD,i)
					, table.getData(_col.wsSapCDName,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.addrTpCD3Name,i)
					, table.getData(_col.addrTpCD4Name,i)
					, table.getData(_col.kindTpCD5Name,i)
					, table.getData(_col.resultQty,i)
					, table.getData(_col.finalUnitAmt,i)
					, table.getData(_col.euResultQty,i)
					, table.getData(_col.eventCnt,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);

			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/ANL0101102S");
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
		showLoading();
		if(!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "ANL0101101S");
		table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	//table.setParameter("programCD", $("#programCD_S").val());
	  	//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("eventFromYM", $("#yearCDFrom_S").val()+$("#monthCDFrom_S").val());
	  	table.setParameter("eventToYM", $("#yearCDTo_S").val()+$("#monthCDTo_S").val());
	  	//table.setParameter("diffNo", $("#diffNo").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	if($("#prdCD").val()!=""){
	  		table.setParameter("prdCDs", $("#prdCD").val().split(";"));
	  	}
	  	table.setParameter("prdNm_S", $("#prdNm_S").val());
	  	table.setParameter("kindTpCD2_S", $("#kindTpCD2_S").val());
	  	table.setParameter("kindTpCD5_S", $("#kindTpCD5_S").val());
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
			"<fmt:message key="ANL01002A.rageSphereCD"/>"
			, "<fmt:message key="ANL01002A.officeCD"/>"
			, "<fmt:message key="ANL01002A.empNm"/>"
			, "<fmt:message key="ANL01002A.venueCD"/>"
			, "<fmt:message key="ANL01002A.venueNm"/>"
			, "<fmt:message key="ANL01002A.wsSapCD"/>"
			, "<fmt:message key="ANL01002A.wsSapCDName"/>"
			, "<fmt:message key="ANL01002A.venueGradCD"/>"
			, "<fmt:message key="ANL01002A.segmentCD"/>"
			, "<fmt:message key="ANL01002A.subSegmentCD"/>"
			, "<fmt:message key="ANL01002A.addrTpCD1"/>"
			, "<fmt:message key="ANL01002A.addrTpCD2"/>"
			, "<fmt:message key="ANL01002A.addrTpCD3"/>"
			, "<fmt:message key="ANL01002A.addrTpCD4"/>"
			, "<fmt:message key="ANL01002A.kindTpCD5Name"/>"
			, "<fmt:message key="ANL01002A.resultQtyAvg"/>"
			, "<fmt:message key="ANL01002A.finalUnitAmt"/>"
			, "<fmt:message key="ANL01002A.euResultQty"/>"
			, "<fmt:message key="ANL01002A.eventCnt"/>"
		];
		
		table.setParameter("templateFile", "ANL01011A");
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
		
		hideLoading();
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="ANL01002A.rageSphereCD"/>"
		, "<fmt:message key="ANL01002A.officeCD"/>"
		, "<fmt:message key="ANL01002A.empNm"/>"
		, "<fmt:message key="ANL01002A.venueCD"/>"
		, "<fmt:message key="ANL01002A.venueNm"/>"
		, "<fmt:message key="ANL01002A.wsSapCD"/>"
		, "<fmt:message key="ANL01002A.wsSapCDName"/>"
		, "<fmt:message key="ANL01002A.venueGradCD"/>"
		, "<fmt:message key="ANL01002A.segmentCD"/>"
		, "<fmt:message key="ANL01002A.subSegmentCD"/>"
		, "<fmt:message key="ANL01002A.addrTpCD1"/>"
		, "<fmt:message key="ANL01002A.addrTpCD2"/>"
		, "<fmt:message key="ANL01002A.addrTpCD3"/>"
		, "<fmt:message key="ANL01002A.addrTpCD4"/>"
		, "<fmt:message key="ANL01002A.kindTpCD5Name"/>"
		, "<fmt:message key="ANL01002A.resultQtyAvg"/>"
		, "<fmt:message key="ANL01002A.finalUnitAmt"/>"
		, "<fmt:message key="ANL01002A.euResultQty"/>"
		, "<fmt:message key="ANL01002A.eventCnt"/>"
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
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                        str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str,num
	                        , num, str, str, str, num
	                        , num, num5, num, str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setCellEditable(true, _col.apprCommt);
	    grid.setFixedLeft(10);
	    
    }
	
</script>