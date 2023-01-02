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
						<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD02001B" />
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
						        			<col style="width:300px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:300px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="RLT02001A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearFromCD_S" name="yearFromCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthFromCD_S" name="monthFromCD_S" defaultText="none" category="MONTHCD" /> -
													<nis:selectbox id="yearToCD_S" name="yearToCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthToCD_S" name="monthToCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT02001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT02001A.officeCD" />
												</td>
												<td class="td-input" colspan="5">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" style="width:80px;"  />
				                                </td>
				                            </tr>
				                            <tr>
				                              	<td class="td-cond">
													<fmt:message key="RLT02001A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" style="width:80px;" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT01001A.venue" />
												</td>
												<td class="td-input">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:80px;" />
												</td>
												<td class="td-cond">
													<fmt:message key="AD02002A.apprExpcCD" />
												</td>
												<td class="td-input" colspan="5">
													<nis:selectbox id="apprExpcCD_S" name="apprExpcCD_S" defaultText="all" category="APPREXPC" style="width:100px;" />
				                                </td>
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="AD01001A.payStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="payStateCD_S" name="payStateCD_S" defaultText="all" category="ADPAYSTATECD" style="width:80px;"  />
				                                </td>
												<td class="td-cond">
													<fmt:message key="AD01001A.apprStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="all" category="APPRSTATECD" style="width:80px;"  />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="AD01001A.contractStateCD" />
												</td>
												<td class="td-input" colspan="5">
													<nis:selectbox id="contractStateCD_S" name="contractStateCD_S" defaultText="all" category="CONTRACTSTATECD" style="width:80px;"  />
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
						<!-- row 클릭한 adSupportID -->
<!-- 						<input type="hidden" id="selectAdSupportID" name="selectAdSupportID" /> -->
						<!-- G1 -->
						<input type="hidden" id="diffNo" name="diffNo" value="9" />
						<!-- Plan/Result승인라인 -->
<!-- 						<input type="hidden" id="apprTpID" name="apprTpID" value="000000" /> -->
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

	.aw-column-0 {width: 30px; text-align:center;}
    .aw-column-1 {width: 110px; text-align:left;}
	.aw-column-2 {width: 70px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:center;}
    .aw-column-4 {width: 140px; text-align:left;}
    .aw-column-5 {width: 140px; text-align:left;}
    .aw-column-6 {width: 140px; text-align:left;}
    .aw-column-7 {width: 120px; text-align:left;}
    .aw-column-8 {width: 75px; text-align:center;}
    .aw-column-9 {width: 75px; text-align:center;}
    .aw-column-10 {width: 75px; text-align:right;}
    .aw-column-11 {width: 90px; text-align:right;}
    .aw-column-12 {width: 90px; text-align:right;}
    .aw-column-13 {width: 90px; text-align:right;} 
    .aw-column-14 {width: 90px; text-align:right;} 
    .aw-column-15 {width: 90px; text-align:right;} 
    .aw-column-16 {width: 90px; text-align:right;} 
    .aw-column-17 {width: 90px; text-align:right;} 
    .aw-column-18 {width: 200px; text-align:left;} 
    .aw-column-19 {width: 80px; text-align:center;}
    .aw-column-20 {width: 80px; text-align:center;}
    .aw-column-21 {width: 60px; text-align:center;}
    .aw-column-22 {width: 100px; text-align:center;}
    .aw-column-23 {width: 60px; text-align:center;}
    .aw-column-24 {width: 100px; text-align:center;}
    .aw-column-25 {width: 60px; text-align:center;}
    .aw-column-26 {width: 100px; text-align:left;}
    .aw-column-27 {width: 60px; text-align:center;}
    .aw-column-28 {width: 100px; text-align:left;}
    .aw-column-29 {width: 80px; text-align:center;}
    .aw-column-30 {width: 80px; text-align:center;}
    .aw-column-31 {width: 80px; text-align:center;}
    .aw-column-32 {width: 80px; text-align:center;}
    .aw-column-33 {width: 80px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 var grid_displayNum = "100"; 
	 var myApprID = "000004";   //AD 승인라인
	 var myADApprExID = "000006"; // AD Exception2
	 var grpID = "000028"; //권한ID 3rd Party
	 
	/****************************************
	 * Function
	 ****************************************/
	$(document).ready(function() {

		window.onload = function() {
			
			firstInit();
			Search();
		};

		${initScript}

		$("#officeCD_S").change(function() {
			Search();
		});
		
		$("#yearFromCD_S").change(function() {
			Search();
		});
		
		$("#monthFromCD_S").change(function() {
			Search();
		});
		
		$("#yearToCD_S").change(function() {
			Search();
		});

		$("#monthToCD_S").change(function() {
			Search();
		});
		
		$("#venue_S_popup").click(function() {
			openMyVenuePopup("closeMyVenuePopup");
		});
		
		$("#venue_S").keypress(function() {
			
			if (event.keyCode == 13) {
				getVenueName("venue_S", "venueCD_S", "venueNm_S");
				
				if ($("#venueCD_S").val() != "") {
					Search();
				}
			}
		});
	});
	
	
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	
	//권역에 따른 지점
	function getOfficeCD(code) {
		
		if (code == "") {
			officeCDSetting();
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
     	
     	if (table.getCount() > 0) {
	     	$("#officeCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	
	     	for (var i = 0; i < table.getCount(); i++) {
	     		
	   			if (table.getData(_col_cd.code,i) == code) {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   				
	   			} else {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#officeCD_S").attr("disabled",false);
    		$("#officeCD_S").removeClass("input-readonly");
     	}
	}
	
	//승인라인
	function getMyADAppr(apprTpID) {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03006S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprTpID", apprTpID);
		table.request();
		
		if (table.getCount() > 0) {
	 		if (apprTpID == myADApprExID) {
				$("#myADApprEx2").text(table.getData(0,0));
			} else {
				$("#myAppr").text(table.getData(0,0));
			}
		}
	}
	
	//날짜 유효성 check
	function validateDate(){
		var startDate = $("#yearFromCD_S").val() + $("#monthFromCD_S").val(); 
		var endDate = $("#yearToCD_S").val() + $("#monthToCD_S").val(); 
		var clientDate = "${params.clientDate}";
		var flag = true;
		
		if (startDate > endDate) {
			alert("<fmt:message key="AD01001B.msg1"/>");
			dateSetting();
			flag = false;
		}
		return flag;
	}
	
	//행사년월 setting
	function dateSetting() {
		$("#yearFromCD_S").val("${params.clientDate}".substring(0,4));
		$("#monthFromCD_S").val(1);
		$("#yearToCD_S").val("${params.clientDate}".substring(0,4));
		$("#monthToCD_S").val("${params.clientDate}".substring(4,6));		
	}
	
	//지점 setting
	function officeCDSetting() {
		$("#officeCD_S").val("");
		$("#officeCD_S").attr("disabled",true);
		$("#officeCD_S").addClass("input-readonly");
	}

	//초기 setting
	function firstInit() {
		$("#grid_displayNum").val(grid_displayNum);
		$("#apprStateCD_S option:eq(5)").prop("selected", true); //승인
		$("#apprExpcCD_S option:eq(2)").prop("selected", true); //Exception1
		
		createGrid();
		grid.refresh();
		
		getMyADAppr(myApprID);
		getMyADAppr(myADApprExID);

		//지점 disable
		officeCDSetting();
		//행사년월 setting
		dateSetting();
	}
	
	//업소 팝업 
	function closeMyVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	//조회
	function Search() {
		$("#grid_pageNum").val("1");
	
		PagingSearch();
	}
	
	var _i = 0;
	
	var _col = {
		checkbox : _i++
		, expccommt : _i++
		, contractDivCD : _i++
		, venueCD : _i++
		, venueNM : _i++
		, chainName : _i++
		, rageSphereName : _i++
		, officeName : _i++
		, startDT : _i++
		, endDT : _i++
		, contractMonth : _i++
		, apAmt : _i++
		, adCostPerGSV : _i++
		, monthApAmt : _i++
		, totalGSV : _i++  
		, monthGSV : _i++ 
		, totalVolume : _i++ 
		, monthVolume : _i++  
		, commt : _i++
		, contractStateName : _i++
		, payStateName : _i++
		, buCDName : _i++ 
		, requiredADCD1Name : _i++
		, amt1 : _i++
		, requiredADCD2Name : _i++
		, amt2 : _i++
		, requiredADCD3Name : _i++
		, amt3 : _i++
		, apprCommt : _i++
		, resultStateName : _i++
 		, adHistory : _i++
		, file1 : _i++
		, file2 : _i++
		, file3 : _i++
		, resultStateCD : _i++
		, adSupportID : _i++
		, apprExpc : _i++
		, file1Cnt : _i++
		, file2Cnt : _i++
		, file3Cnt : _i++
		, rowNum : _i++
    };
	
	//조회 기능
	function PagingSearch() {

		if (!validateDate()) return;
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0200201S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;expccommt;contractDivCD;venueCD;venueNM;"+
	  			"chainName;rageSphereName;officeName;startDT;endDT;"+
	  			"contractMonth;apAmt;adCostPerGSV;monthApAmt;totalGSV;"+
	  			"monthGSV;totalVolume;monthVolume;commt;contractStateName;"+
	  			"payStateName;buCDName;requiredADCD1Name;amt1;requiredADCD2Name;"+
				"amt2;requiredADCD3Name;amt3;apprCommt;resultStateName;"+
	  			"adHistory;file1;file2;file3;resultStateCD;"+
	  			"adSupportID;apprExpc;file1Cnt;file2Cnt;file3Cnt;"+
	  			"rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;");
	  	
		table.setParameter("startDT", $("#yearFromCD_S").val() + $("#monthFromCD_S").val());
		table.setParameter("endDT", $("#yearToCD_S").val() + $("#monthToCD_S").val());
		table.setParameter("empID", "${params.empID}");
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("payStateCD", $("#payStateCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("contractStateCD", $("#contractStateCD_S").val());
	  	table.setParameter("apprExpc", $("#apprExpcCD_S").val());
	  	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
	  	table.request();
	  	
      	createGrid();
      	
      	var rowCount = table.getCount();
    	var data = new Array();
    	var	apprStateName = "",
			adHistory = "",
			file1 = "",
			file2 = "",
			file3 = "";
      	
      	if (rowCount > 0) {
      		
      		for (var i = 0; i < rowCount; i++) {

      			resultStateName = "<a href=\"javascript:openApprState('"+i+"');\">"+table.getData(_col.resultStateName,i)+"</a>";
      		 	adHistory = "<a href=\"javascript:openAdHistory('"+i+"');\">"+table.getData(_col.adHistory,i)+"</a>";
      		   	file1 = "<a href=\"javascript:openFilePopUp('"+i+"','ADINPUT');\">"+table.getData(_col.file1,i)+"</a>";
      		   	file2 = "<a href=\"javascript:openFilePopUp('"+i+"','ADEVIDENCE');\">"+table.getData(_col.file2,i)+"</a>";
      		   	file3 = "<a href=\"javascript:openFilePopUp('"+i+"','ADCONFIRM');\">"+table.getData(_col.file3,i)+"</a>";
      			
      			data[i] = [
					""
					, table.getData(_col.expccommt,i)
					, table.getData(_col.contractDivCD,i)
					, table.getData(_col.venueCD,i)
					, table.getData(_col.venueNM,i)
					, table.getData(_col.chainName,i)
					, table.getData(_col.rageSphereName,i)
					, table.getData(_col.officeName,i)
					, formatMonth(table.getData(_col.startDT, i))
					, formatMonth(table.getData(_col.endDT, i))
      			    , table.getData(_col.contractMonth,i)
					, table.getData(_col.apAmt,i)
					, table.getData(_col.adCostPerGSV,i) + "%"
					, table.getData(_col.monthApAmt,i)
					, table.getData(_col.totalGSV,i)
					, table.getData(_col.monthGSV,i)
					, table.getData(_col.totalVolume,i)
					, table.getData(_col.monthVolume,i)
					, table.getData(_col.commt,i)
					, table.getData(_col.contractStateName,i)
					, table.getData(_col.payStateName,i)
					, table.getData(_col.buCDName,i)
					, table.getData(_col.requiredADCD1Name,i)
					, table.getData(_col.amt1,i)
					, table.getData(_col.requiredADCD2Name,i)
					, table.getData(_col.amt2,i)
					, table.getData(_col.requiredADCD3Name,i)
					, table.getData(_col.amt3,i)
					, table.getData(_col.apprCommt,i)
					, resultStateName
 					, adHistory
					, file1
					, file2
					, file3
					, table.getData(_col.resultStateCD,i)
					, table.getData(_col.adSupportID,i)
					, table.getData(_col.apprExpc,i)
      			];
      			
      			//승인라인 Exception(_col.apprExpc)에 따라 컬럼 색 적용
      			var apprExpc = table.getData(_col.apprExpc, i);
				
     			if (apprExpc == 2) { // Exception 2
   					grid.getCellTemplate(_col.resultStateName, i).setStyle("background", "#BCF5A9");
   				}
      			
      			if (table.getData(_col.file1Cnt, i) > 0) {
      				grid.getCellTemplate(_col.file1, i).setStyle("background", "#B2CCFF");
      			}
      			
      			if (table.getData(_col.file2Cnt, i) > 0) {
      				grid.getCellTemplate(_col.file2, i).setStyle("background", "#B2CCFF");
      			}
      			
      			if (table.getData(_col.file3Cnt, i) > 0) { 
      				grid.getCellTemplate(_col.file3, i).setStyle("background", "#B2CCFF");
      			}
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			
			table.setURL("${contextPath}/service/simpleAction/AD0200202S");
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
			
			clearPageInfo("grid");
      	}
      	grid.refresh();
	}
	
	//계약완료
	function FinishContract() {
		var index = grid.getRowIndices();
		var venueCDs = new Array();
		var adSupportIDs = new Array();
		var apprExpcs = new Array();
		var count = 0;
		
		if (index == "") {
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		for (var i = 0; i < index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				adSupportIDs[count] = grid.getCellText(_col.adSupportID, index[i]);
				apprExpcs[count] = grid.getCellText(_col.apprExpc, index[i]);
				count++;
			}
		}
		
		if (count == 0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		if (!confirm("<fmt:message key="AD02002A.msg1"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ad02/finishContractAD");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("adSupportIDs", adSupportIDs);
		table.setParameter("apprExpcs", apprExpcs);
		
		table.request();

		if (table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search();
   		} else {
			alert(table.getData(1,0));
		}		
	} 
	
	//지급완료
	function FinishPay() {
		var index = grid.getRowIndices();
		var venueCDs = new Array();
		var adSupportIDs = new Array();
		var count = 0;
		
		if (index == "") {
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		for (var i = 0; i < index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				adSupportIDs[count] = grid.getCellText(_col.adSupportID, index[i]);
				count++;
			}
		}
		
		if (count == 0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for (var i = 0; i < index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//계약상태가 계약해지일 경우
				if(grid.getCellText(_col.payStateName, index[i]) == "10") {
					alert("<fmt:message key="AD02002A.msg5"/>");
					return;
				}
			}
		}
		
		if (!confirm("<fmt:message key="AD02002A.msg2"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ad02/finishPayAD");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("adSupportIDs", adSupportIDs);
		
		table.request();

		if (table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search();
   		} else {
			alert(table.getData(1,0));
		}		
		
	}

	
	//엑셀
	function Excel() {
		var table = new AW.XML.Table;
		
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "AD0200203S");
		table.setParameter("startDT", $("#yearFromCD_S").val() + $("#monthFromCD_S").val());
		table.setParameter("endDT", $("#yearToCD_S").val() + $("#monthToCD_S").val());
		table.setParameter("empID", "${params.empID}");
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("payStateCD", $("#payStateCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("contractStateCD", $("#contractStateCD_S").val());
	  	table.setParameter("apprExpc", $("#apprExpcCD_S").val());
	  	
		var headerText = [
			 "<fmt:message key="AD01001A.contractDivCD"/>"
			, "<fmt:message key="AD01001A.venueCD"/>"			
			/* 22.07.20 엑셀파일 수정 */
			, "<fmt:message key="AD02003A.adSupportID"/>"
			, "<fmt:message key="AD01001A.venueNm"/>"
 			, "<fmt:message key="AD01001A.chain"/>"
			, "<fmt:message key="AD01001A.rageSphereCD"/>"
			, "<fmt:message key="AD01001A.officeCD"/>"
			, "<fmt:message key="AD01001A.startDT"/>"
			, "<fmt:message key="AD01001A.endDT"/>"
			, "<fmt:message key="AD01001A.contractCnt"/>"
			, "<fmt:message key="AD01001B.APContract"/>"
			, "<fmt:message key="AD01001B.adCostPerGSV"/>"
			, "<fmt:message key="AD02002A.monthAdAmt"/>"
			, "<fmt:message key="AD02002A.totalGSV"/>"
			, "<fmt:message key="AD02002A.monthGSV"/>"
			, "<fmt:message key="AD02002A.totalVolume"/>"
			, "<fmt:message key="AD02002A.monthVolume"/>"
			, "<fmt:message key="AD02001A.comment"/>"
			, "<fmt:message key="AD01001A.contractStateCD"/>"
			, "<fmt:message key="AD01001A.payStateCD"/>"
			, "<fmt:message key="AD01001A.buCDName"/>"
			, "<fmt:message key="AD01001A.requiredADCD1Name"/>"
			, "<fmt:message key="AD01001A.amt"/>"
			, "<fmt:message key="AD01001A.requiredADCD2Name"/>"
			, "<fmt:message key="AD01001A.amt"/>"
			, "<fmt:message key="AD01001A.requiredADCD3Name"/>"
			, "<fmt:message key="AD01001A.amt"/>"
			, "<fmt:message key="AD02002A.apprCommt"/>"
			, "<fmt:message key="AD01001A.exceptionCommt"/>"
			, "<fmt:message key="AD02001A.resultTpCD"/>"
		];
		
		table.setParameter("templateFile", "AD02002A");
		table.setParameter("headerText", headerText);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0,0) == "S") {
			    form.action = "${contextPath}/service/simpleExport/download/?"+
			    		"tempFile="+table.getData(3,0)+
			    		"&downloadFile="+encodeURIComponent("${params.viewName}");
			    form.target = "_self";
			    form.submit();
			}
		}
	}
	
	//승인상태 팝업	
	function openApprState(i) {
		var venueCD = grid.getCellText(_col.venueCD,i);
      	var adSupportID = grid.getCellText(_col.adSupportID,i);
     	var apprExpc = grid.getCellText(_col.apprExpc,i);
     	var apprTpIDEx = (apprExpc == "2") ? myADApprExID : myApprID; 
      	
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD01002B"
				+"&adSupportID="+adSupportID
				+"&venueCD="+venueCD
				+"&apprTpID="+apprTpIDEx 
		
		newWindow(url, "AD01002B",600,350,"yes");
	}
	

	//첨부 파일 팝업 
	function openFilePopUp(rowNum, fileDivCD) {
		
		if (fileDivCD !="ADCONFIRM" && '${params.grpID}' == grpID){
			alert("<fmt:message key="AD02002A.msg7"/>");
			return;
		}
		
		var venueCD = grid.getCellText(_col.venueCD, rowNum);
   		var adSupportID = grid.getCellText(_col.adSupportID, rowNum);
   		//var viewID = (fileDivCD !== "ADEVIDENCE") ? "AD01001C" : "AD01001E"; //AD01001C : 첨부파일 업로드 화면, AD01001E : 첨부파일 보기 화면
   		var viewID = "AD01001C"; //AD01001C : 첨부파일 업로드 화면, AD01001E : 첨부파일 보기 화면
   		
   	//	if (fileDivCD =="ADCONFIRM" && '${params.grpID}' == grpID){
   	//		viewID = "AD01001C";
   	//	}

		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}"
			+"&viewID="+viewID
			+"&adSupportID="+adSupportID
			+"&venueCD="+venueCD
			+"&fileDivCD="+fileDivCD
		
		newWindow(url, viewID,600,350,"yes");
	}
	
	//히스토리 팝업	
	function openAdHistory(i) {
		var venueCD = grid.getCellText(_col.venueCD,i);
      	var adSupportID = grid.getCellText(_col.adSupportID,i);
      	
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD01002C"
				+"&adSupportID="+adSupportID
				+"&venueCD="+venueCD
		
		newWindow(url, "AD01002C", 740, 350, "yes");
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		""
		, "<fmt:message key="AD01001A.exceptionCommt"/>"
		, "<fmt:message key="AD01001A.contractDivCD"/>"
		, "<fmt:message key="AD01001A.venueCD"/>"
		, "<fmt:message key="AD01001A.venueNm"/>"
		, "<fmt:message key="AD01001A.chain"/>"
		, "<fmt:message key="AD01001A.rageSphereCD"/>"
		, "<fmt:message key="AD01001A.officeCD"/>"
		, "<fmt:message key="AD01001A.startDT"/>"
		, "<fmt:message key="AD01001A.endDT"/>"
		, "<fmt:message key="AD01001A.contractCnt"/>"
		, "<fmt:message key="AD01001B.APContract"/>"
		, "<fmt:message key="AD01001B.adCostPerGSV"/>"
		, "<fmt:message key="AD02002A.monthAdAmt"/>"
		, "<fmt:message key="AD02002A.totalGSV"/>"
		, "<fmt:message key="AD02002A.monthGSV"/>"
		, "<fmt:message key="AD02002A.totalVolume"/>"
		, "<fmt:message key="AD02002A.monthVolume"/>"
		, "<fmt:message key="AD02001A.comment"/>"
		, "<fmt:message key="AD01001A.contractStateCD"/>"
		, "<fmt:message key="AD01001A.payStateCD"/>"
		, "<fmt:message key="AD01001A.buCDName"/>"
		, "<fmt:message key="AD01001A.requiredADCD1Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.requiredADCD2Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.requiredADCD3Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD02002A.apprCommt"/>"
		, "<fmt:message key="AD02001A.resultTpCD"/>"
 		, "<fmt:message key="AD01001A.adHistory"/>"
		, "<fmt:message key="AD01001A.file1"/>"
		, "<fmt:message key="AD01001A.file2"/>"
		, "<fmt:message key="AD01001A.file3"/>"
	];

	var grid = null;
	
	//그리드 생성
	function createGrid() {
		grid = new AW.Grid.Extended;
		
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-cell");
	    grid.setHeaderText(columns);
	    
	    for (var i=0;i<columns.length;i++) {
	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    
	    grid.setColumnCount(columns.length);
		grid.setCellFormat([
	    					  str, str, str, str, str
	    					, str, str, str, str, str
	    					, str, num, str, num, num
	    					, num, num, num, str, str
	    					, str, str, str, str, str
	    					, html, str, html, html, html
	    					, html]);
	    
	    grid.setCellEditable(false); 

	    //checkBox
	    grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellValue(false, _col.checkbox);
		grid.setHeaderTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		
		grid.onHeaderClicked = function(event,col) {
			
			if (col == _col.checkbox && this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(true, _col.checkbox);
			}
			else if (col == _col.checkbox && !this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(false, _col.checkbox);
			}
			return false;
		};
		
		//그리드 row 클릭
	    grid.onRowDoubleClicked = function(event, row){
			appletOpen();
			$("#_detail")[0].contentWindow.$("#adSupportID").val(grid.getCellText(_col.adSupportID, row));
			$("#_detail")[0].contentWindow.pageInit();
	    }
		
    }
	
</script>