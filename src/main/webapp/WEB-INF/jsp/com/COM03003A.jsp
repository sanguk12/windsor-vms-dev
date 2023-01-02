<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<%@include file="../sys3/scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<form name="form" method="post">
	<div id="wrapDiv">
    	<div id="formDiv">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="padding-bottom:5px;">
                <tr>
                    <td height="1">
						<%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
                    </td>
                </tr>
                <tr>
					<td height="1">             
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:100px"></col>
											<col style="width:250px"></col>
											<col style="width:150px"></col>
											<col></col>
										</colgroup>
										<tbody>
				                            <tr>
					                  			<td class="td-cond-required">
													<fmt:message key="PAY04002A.period" />
												</td>
												<td class="td-input">
													<nis:selectbox id="startYearCD_S" name="startYearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="startMonthCD_S" name="startMonthCD_S" defaultText="none" category="MONTHCD" /> ~
													<nis:selectbox id="endYearCD_S" name="endYearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="endMonthCD_S" name="endMonthCD_S" defaultText="none" category="MONTHCD" />
				                                 	<!-- 
				                                	<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />	
				                                	 -->
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
                    <td height="*">
                        <span id="grid"></span>
                    </td>
                </tr>
                <!-- <tr>
                    <td class="td-paging">
                        <nis:paging id="grid" titleDisable="no" callback="PagingSearch()"/>
                    </td>
                </tr> -->
		  </table>
       </div>
  	</div>
  	</form>
</body>
</html>

<style type="text/css">
<!--
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}
/*  
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
    .aw-column-14 {width: 100px; text-align:center;}
    .aw-column-15 {width: 200px; text-align:left;}
    .aw-column-16 {width: 80px; text-align:center;}
*/
    .aw-column-0 {width: 100px; text-align:left;}
    .aw-column-1 {width: 100px; text-align:left;}
    .aw-column-2 {width: 100px; text-align:left;}
    .aw-column-3 {width: 70px; text-align:center;}
    .aw-column-4 {width: 100px; text-align:center;}
    .aw-column-5 {width: 150px; text-align:left;}
    .aw-column-6 {width: 70px; text-align:center;}
    .aw-column-7 {width: 100px; text-align:right;}
    .aw-column-8 {width: 100px; text-align:right;}
    .aw-column-9 {width: 120px; text-align:left;}
    .aw-column-10 {width: 100px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">

	// Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	 * Variable
	 ****************************************/
	
	/****************************************
	* Function
	****************************************/
    $(function() {
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			//$("#grid_displayNum").val("100");
			createGrid();
			grid.refresh();
			
			//venueCDs = opener.venueCDsArray;
			//payCommts = opener.payCommtsArray;
			setMonthBefore();
			getPayStateCD();
			$("#payStateCD_S").val("60");
			setApproval();
			Search();
		};
		
		${initScript}
		
	});

	//승인을 위한 배열(제품단위로 묶음)
	var prdCDs = new Array();
	var prdCDVenueCDs = new Array();
	var venueCDAlls = new Array();
	var payCommts = new Array();

	//화면에 표시하기위한 배열들(업소단위로 묶음)
	var venueCDs = new Array();
	var payAmts = new Array();
	var programCDNames = new Array();
	var activityCDNames = new Array();
	var rageSphereCDNames = new Array();
	var officeCDNames = new Array();
	var empNms = new Array();
	var venueNms = new Array();
	var venueGradCDNames = new Array();
	var payStateCDNames = new Array();
	var payStateCDs = new Array();

	var _col_cd = {
		"code" : 0
		, "name" : 1
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

	function setApproval(){
		var index = opener.grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < opener.grid.getRowCount(); i++){
				index[i] = i;
			}
		}

		var venueCDTemps = new Array();
		var count = 0;
		var countCenueCD = 0;
		for (var i=0; i<index.length; i++) {
			if (opener.grid.getCellValue(opener._col.checkbox, index[i])) {
				prdCDs[count] = opener.grid.getCellText(opener._col.prdCD, index[i]);
				prdCDVenueCDs[count] = opener.grid.getCellText(opener._col.prdCD, index[i])+opener.grid.getCellText(opener._col.venueCD, index[i]);
				venueCDAlls[count] = opener.grid.getCellText(opener._col.venueCD, index[i]);
				payCommts[count] = opener.grid.getCellText(opener._col.payCommt, index[i]);
				if(count == 0){
					venueCDTemps[countCenueCD] = opener.grid.getCellText(opener._col.venueCD, index[i]);
					countCenueCD++;
				}
				else{
					var countTemp = 0;
					for(var j = 0; j < countCenueCD; j++){
						if(opener.grid.getCellText(opener._col.venueCD, index[i])==venueCDTemps[j]){
							countTemp++;
						}
						if(countTemp == 0){
							venueCDTemps[countCenueCD] = opener.grid.getCellText(opener._col.venueCD, index[i]);
							countCenueCD++;
						}
					}
				}
				count++;
			}
		}
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/COM03003A01S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"activityCDName;rageSphereCDName;officeCDName;empNm;"+
	  			"venueCD;venueNm;venueGradCDName;"+
	  			"periodPayAmt;payAmt;"+
	  			"payCommt;"+
	  			"payStateCDName;"+
	  			"payStateCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;"+
	  			"str;str;str;"+
	  			"num;num;"+
	  			"str;"+
	  			"str;"+
	  			"str;");
	  	table.setParameter("eventYM","${params.eventYM}");
	  	//table.setParameter("diffNo","${params.diffNo}");
	  	//table.setParameter("startYearCD_S", $("#startYearCD_S").val());
		//table.setParameter("startMonthCD_S", $("#startMonthCD_S").val());
		//table.setParameter("endYearCD_S", $("#endYearCD_S").val());
		//table.setParameter("endMonthCD_S", $("#endMonthCD_S").val());
		table.setParameter("payStateCD", "${params.payStateCD}");
	  	table.setParameter("prdCDs", prdCDVenueCDs);
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
					  table.getData(_col.activityCDName,i)
					, table.getData(_col.rageSphereCDName,i)
					, table.getData(_col.officeCDName,i)
					, table.getData(_col.empNm,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, 0
					, table.getData(_col.tpayAmt,i)
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

      	var index_ = grid.getRowCount();
		count = 0;
		for (var i=0; i<index_; i++) {
			venueCDs[count] = grid.getCellText(_col.venueCD, i);
			payCommts[count] = grid.getCellText(_col.payCommt, i);
			payAmts[count] = grid.getCellText(_col.tpayAmt, i);
			programCDNames[count] = grid.getCellText(_col.programCDName, i);
			activityCDNames[count] = grid.getCellText(_col.activityCDName, i);
			rageSphereCDNames[count] = grid.getCellText(_col.rageSphereCDName, i);
			officeCDNames[count] = grid.getCellText(_col.officeCDName, i);
			empNms[count] = grid.getCellText(_col.empNm, i);
			venueNms[count] = grid.getCellText(_col.venueNm, i);
			venueGradCDNames[count] = grid.getCellText(_col.venueGradCDName, i);
			payStateCDNames[count] = grid.getCellText(_col.payStateCDName, i);
			payStateCDs[count] = grid.getCellText(_col.payStateCD, i);
			count++;
		}
      	/*
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}

		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (opener.grid.getCellValue(opener._col.checkbox, index[i])) {
				if(count == 0){
					venueCDs[count] = opener.grid.getCellText(opener._col.venueCD, index[i]);
					payCommts[count] = opener.grid.getCellText(opener._col.payCommt, index[i]);
					payAmts[count] = opener.grid.getCellText(opener._col.tpayAmt, index[i]);
					programCDNames[count] = opener.grid.getCellText(opener._col.programCDName, index[i]);
					activityCDNames[count] = opener.grid.getCellText(opener._col.activityCDName, index[i]);
					rageSphereCDNames[count] = opener.grid.getCellText(opener._col.rageSphereCDName, index[i]);
					officeCDNames[count] = opener.grid.getCellText(opener._col.officeCDName, index[i]);
					empNms[count] = opener.grid.getCellText(opener._col.empNm, index[i]);
					venueNms[count] = opener.grid.getCellText(opener._col.venueNm, index[i]);
					venueGradCDNames[count] = opener.grid.getCellText(opener._col.venueGradCDName, index[i]);
					payStateCDNames[count] = opener.grid.getCellText(opener._col.payStateCDName, index[i]);
					payStateCDs[count] = opener.grid.getCellText(opener._col.payStateCD, index[i]);
					count++;
				}
				else{
					if(venueCDs[count-1] != opener.grid.getCellText(opener._col.venueCD, index[i])){
						venueCDs[count] = opener.grid.getCellText(opener._col.venueCD, index[i]);
						payCommts[count] = opener.grid.getCellText(opener._col.payCommt, index[i]);
						payAmts[count] = opener.grid.getCellText(opener._col.tpayAmt, index[i]);
						programCDNames[count] = opener.grid.getCellText(opener._col.programCDName, index[i]);
						activityCDNames[count] = opener.grid.getCellText(opener._col.activityCDName, index[i]);
						rageSphereCDNames[count] = opener.grid.getCellText(opener._col.rageSphereCDName, index[i]);
						officeCDNames[count] = opener.grid.getCellText(opener._col.officeCDName, index[i]);
						empNms[count] = opener.grid.getCellText(opener._col.empNm, index[i]);
						venueNms[count] = opener.grid.getCellText(opener._col.venueNm, index[i]);
						venueGradCDNames[count] = opener.grid.getCellText(opener._col.venueGradCDName, index[i]);
						payStateCDNames[count] = opener.grid.getCellText(opener._col.payStateCDName, index[i]);
						payStateCDs[count] = opener.grid.getCellText(opener._col.payStateCD, index[i]);
						count++;
					}
				}
			}
		}
		*/
		
	}
	/****************************************
	* Button Action
	****************************************/

	function setMonthBefore() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03002A02S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
	  			"lastMonthYear;lastMonthMon");
	  	table.setParameter("format",
	  			"str;str");
	  	table.setParameter("yearMonthTemp", "${params.eventYM}");
     	table.request();
		
     	if(table.getCount() > 0) {
     		var yearTemp = table.getData(0,0);
     		var monthTemp = table.getData(1,0);

     		$("#startYearCD_S").val(yearTemp);
			$("#startMonthCD_S").val(monthTemp);
			$("#endYearCD_S").val(yearTemp);
			$("#endMonthCD_S").val(monthTemp);
		}
	}

	function Approval() {
		if(!confirm("<fmt:message key="PAY04005A.msg2"/>")) {
       		return;
       	}

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay04/approvalPayBrand");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", "${params.eventYM}");
		table.setParameter("diffNo", "${params.diffNo}");
		table.setParameter("venueCDs", venueCDAlls);
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("payCommts", payCommts);;
		table.request();
		if(table.getData(0,0) == "S") {
			opener.top.appCountFun();
			opener.message(table.getData(1,0));
			opener.Search();
   		}
		else {
			alert(table.getData(1,0));
		}
        
        window.close();
	}
	

	function Search() {
		//$("#grid_pageNum").val("1");
		PagingSearch();
	}

	var _i = 0;
	var _col = {
		/*checkbox : _i++
		, programCDName : _i++
		, 
		*/
		  activityCDName : _i++
		, rageSphereCDName : _i++
		, officeCDName : _i++
		, empNm : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, periodPayAmt :  _i++
		, tpayAmt :  _i++
		, payCommt : _i++
		, payStateCDName : _i++
		, payStateCD : _i++
    };
	
	function PagingSearch(){
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/COM03003A01S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	/*
	  	table.setParameter("outParamKey",
	  			"checkbox;programCDName;activityCDName;rageSphereCDName;officeCDName;"+
	  			"empNm;venueCD;venueNm;venueGradCDName;segmentCDName;"+
	  			"subSegmentCDName;addrTpCD1Name;addrTpCD2Name;tpayAmt;"+
	  			"payCommt;payStateCDName;payStateCD;rowNum;"+
	  			"totalCount;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;num;num;"+
	  			"str;str;str;"+
	  			"str;");
	  	*/
	  	table.setParameter("outParamKey",
	  			//"checkbox;programCDName;activityCDName;rageSphereCDName;officeCDName;"+
	  			"activityCDName;rageSphereCDName;officeCDName;"+
	  			"empNm;venueCD;venueNm;venueGradCDName;periodPayAmt;tpayAmt;"+
	  			"payCommt;payStateCDName;payStateCD;");
	  	table.setParameter("format",
	  			//"str;str;str;str;str;"+
	  			"str;str;str;"+
	  			"str;str;str;str;num;num;"+
	  			"str;str;str;"+
	  			"str;");
	  	table.setParameter("venueCDs",venueCDs);
	  	table.setParameter("eventYM","");
	  	//table.setParameter("diffNo","${params.diffNo}");
	  	table.setParameter("startYearCD_S", $("#startYearCD_S").val());
		table.setParameter("startMonthCD_S", $("#startMonthCD_S").val());
		table.setParameter("endYearCD_S", $("#endYearCD_S").val());
		table.setParameter("endMonthCD_S", $("#endMonthCD_S").val());
		table.setParameter("payStateCD", $("#payStateCD_S").val());
		table.setParameter("prdCDs", prdCDVenueCDs);
		//table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	 	// --- 그룹 권한에 따라 empId가 'MK'로 시작하는 담당자 이름은 보이지 않도록 수정 2016.04.20
		if(		   '${params.grpID}' == '000004' || '${params.grpID}' == '000003' || '${params.grpID}' == '000002' 
				|| '${params.grpID}' == '000026' || '${params.grpID}' == '000005'
				|| '${params.grpID}' == '000013' || '${params.grpID}' == '000016' || '${params.grpID}' == '000018'
				|| '${params.grpID}' == '000017' || '${params.grpID}' == '000023' || '${params.grpID}' == '000024'){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
      	//Paging Parameter - START
		//table.setParameter("pageNum", $("#grid_pageNum").val());
        //table.setParameter("displayNum", $("#grid_displayNum").val());
        //Paging Parameter - END
      	table.request();
      	
//       	if (grid != null) grid.clear();
      	createGrid();
      		
   		var rowCount = venueCDs.length;
       	if (rowCount > 0) {
       		var data = new Array();
       		var tpayAmtSum = 0;
       		var periodPayAmtSum = 0;
       		for (var i=0; i < rowCount; i++) {
       			var periodPayAmt = 0;
       			var payAmt = "";
       			for(var j=0; j < table.getCount(); j++){
       				if(venueCDs[i] == table.getData(_col.venueCD,j)){
       					payAmt = payAmts[i];
       					periodPayAmt = table.getData(_col.periodPayAmt,j);
       				}
       			}
				if(periodPayAmt == ""){
					periodPayAmt = 0;
       			}
				if(payAmt == ""){
					payAmt = 0;
       			}
       			data[i] = [
   						  activityCDNames[i]
   						, rageSphereCDNames[i]
   						, officeCDNames[i]
   						, empNms[i]
   	      			    , venueCDs[i]
   						, venueNms[i]
   						, venueGradCDNames[i]
   						, periodPayAmt
   						, payAmt
   						, payCommts[i]
   						, payStateCDNames[i]
   						, payStateCDs[i]
   	      			];
       			tpayAmtSum = tpayAmtSum + parseFloat(unformatNum(payAmt));
       			periodPayAmtSum = periodPayAmtSum + parseFloat(unformatNum(periodPayAmt));
    		}
    		grid.setCellData(data);
    		grid.setRowCount(rowCount);
    		grid.setFooterText("합계", _col.venueGradCDName);
    		grid.setFooterText(formatNum(tpayAmtSum), _col.tpayAmt);
    		grid.setFooterText(formatNum(periodPayAmtSum), _col.periodPayAmt);
      		//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
      		//setPageInfo('grid', table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
       	} else {
      		////Paging Function: clearPageInfo(Grid Name);
            //clearPageInfo('grid');
      		message("<fmt:message key="info.nullData"/>");
      	
      	}
      	grid.refresh();
	}
	
	function Cancel() {
		window.close();
	}
	
    /*****************************************************
	*	Grid
	*****************************************************/
    
	var columns = [
	            /*
	             ""
	       		,"<fmt:message key="PAY04001A.programCD"/>"
	       		, 
	       		*/
	       		 "<fmt:message key="PAY04001A.activityCD"/>"
	       		, "<fmt:message key="PAY04001A.rageSphereCD"/>"
	       		, "<fmt:message key="PAY04001A.officeCD"/>"
	       		, "<fmt:message key="PAY04001A.empNm"/>"
	       		, "<fmt:message key="PAY04001A.venueCD"/>"
	       		, "<fmt:message key="PAY04001A.venueNm"/>"
	       		, "<fmt:message key="PAY04001A.venueGradCD"/>"
	       		, "기간내 지급액"
	       		, "<fmt:message key="PAY04001A.tpayAmt"/>"
	       		/*, "<fmt:message key="PAY04001A.payCommt"/>"
	       		, "<fmt:message key="PAY04001A.payStateCDName"/>"*/
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
	    /*
	    grid.setCellFormat([
	                          str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, num
	                        , str, str
	                        ]);
	    */
	    grid.setCellFormat([
	                          //str, str, str, str, str
	                          str, str, str
	                        , str, str, str, str
	                        , num, num
	                        ]);
	    grid.setCellEditable(false);
	    //grid.setCellEditable(true, _col.payCommt);
	    grid.setFixedLeft(8);
	    grid.getCellTemplate(_col.tpayAmt).setStyle("color", "#ff0000");
	    grid.getCellTemplate(_col.periodPayAmt).setStyle("color", "#0000ff");
	    /*
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
		*/
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
		//footer
		grid.setFooterVisible(true);
        grid.setFooterCount(1);
    }
	
</script>