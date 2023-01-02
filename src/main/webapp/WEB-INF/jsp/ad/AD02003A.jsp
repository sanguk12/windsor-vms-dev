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
						        			<col style="width:180px;"></col>
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
												<td class="td-input" colspan="6">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" style="width:100px;"  />
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
												<td class="td-input" colspan="8">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:80px;" />
												</td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond">
													<fmt:message key="AD01001A.contractStateCD" />
												</td>
												<td class="td-input" colspan="10">
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
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="diffNo" name="diffNo" value="9" /><!-- G1 -->
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 100px; text-align:center;}
	.aw-column-1 {width: 150px; text-align:left;}
	.aw-column-2 {width: 60px; text-align:center;}
    .aw-column-3 {width: 90px; text-align:center;}
    .aw-column-4 {width: 140px; text-align:left;}
    .aw-column-5 {width: 140px; text-align:left;}
    .aw-column-6 {width: 150px; text-align:left;}
    .aw-column-7 {width: 120px; text-align:left;}
    .aw-column-8 {width: 120px; text-align:left;}
    .aw-column-9 {width: 60px; text-align:center;} 
    .aw-column-10 {width: 60px; text-align:center;} 
    .aw-column-11 {width: 60px; text-align:center;} 
	.aw-column-12 {width: 80px; text-align:center;} 
    .aw-column-13 {width: 100px; text-align:center;} 
    .aw-column-14 {width: 60px; text-align:center;} 
    .aw-column-15 {width: 100px; text-align:center;} 
    .aw-column-16 {width: 60px; text-align:center;} 
    .aw-column-17 {width: 100px; text-align:center;} 
    .aw-column-18 {width: 60px; text-align:center;} 
    .aw-column-19 {width: 60px; text-align:center;} 
    .aw-column-20 {width: 75px; text-align:center;} 
    .aw-column-21 {width: 75px; text-align:right;} 
    .aw-column-22 {width: 75px; text-align:right;} 
    .aw-column-23 {width: 90px; text-align:right;} 
    .aw-column-24 {width: 110px; text-align:right;} 
    .aw-column-25 {width: 75px; text-align:right;} 
    .aw-column-26 {width: 75px; text-align:right;} 
    .aw-column-27 {width: 110px; text-align:right;} 
    .aw-column-28 {width: 130px; text-align:right;} 
    .aw-column-29 {width: 130px; text-align:right;} 

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 var grid_displayNum = "100";
	 
	/****************************************
	 * Function
	 ****************************************/
	$(document).ready(function() {

		window.onload = function() {
			
			firstInit();
			
		};

		${initScript}

		$("#officeCD_S").change(function() {
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

		createGrid();
		grid.refresh();
		
		//지점 disable
		officeCDSetting();
		//행사년월 setting
		dateSetting();
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
		  adSupportID : _i++
		, expcCommt : _i++
		, eventYm : _i++
		, venueCD : _i++
		, venueNm : _i++
		, chainName : _i++
		, rageSphereNm : _i++
		, officeNm : _i++
		, territoryCD : _i++
 		, adHistory : _i++
		, venueGradCD : _i++
		, venueDivCD : _i++
		, buCDName : _i++
		, requiredADCD1Name : _i++
		, amt1 : _i++
		, requiredADCD2Name : _i++
		, amt2 : _i++
		, requiredADCD3Name : _i++
		, amt3 : _i++
		, contractStateCDNm : _i++
		, payStateCDNm : _i++
		, apAmt : _i++
		, posmAmt : _i++
		, gsv : _i++
		, prdTotalAmt : _i++
		, adSdxDep : _i++
		, apAmtPerGsv : _i++
		, resultGsv : _i++
		, resultTQty : _i++
		, resultSdxDep : _i++
		, rowNum : _i++
		, totalCount : _i++
    };
	
	//조회 기능
	function PagingSearch() {
		
		if (!validateDate()) return;
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0200301S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"adSupportID;expcCommt;eventYm;venueCD;venueNm;"+
	  			"chainName;rageSphereNm;officeNm;territoryCD;adHistory;"+
	  			"venueGradCD;venueDivCD;buCDName;requiredADCD1Name;amt1;" + 
	  			"requiredADCD2Name;amt2;requiredADCD3Name;amt3;contractStateCDNm;" +
	  			"payStateCDNm;apAmt;posmAmt;gsv;prdTotalAmt;"+
	  			"adSdxDep;apAmtPerGsv;resultGsv;resultTQty;resultSdxDep;"+
	  			"rowNum;totalCount;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;");
	  	
	  	table.setParameter("startDT", $("#yearFromCD_S").val() + $("#monthFromCD_S").val());
		table.setParameter("endDT", $("#yearToCD_S").val() + $("#monthToCD_S").val());
		table.setParameter("empID", "${params.empID}");
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("contractStateCD", $("#contractStateCD_S").val());
	  	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
	  	table.request();
	  	
      	createGrid();
      	
      	var rowCount = table.getCount();
      	var data = new Array();
      	var	adHistory = "";
      	
      	if (rowCount > 0) {
      		for (var i = 0; i < rowCount; i++) {
      			
           		adHistory = "<a href=\"javascript:openAdHistory('"+i+"');\">"+table.getData(_col.adHistory,i)+"</a>";
          			
      			data[i] = [
      				  table.getData(_col.adSupportID,i)
      				, table.getData(_col.expcCommt,i)
					, formatMonth(table.getData(_col.eventYm,i))
					, table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.chainName,i)
					, table.getData(_col.rageSphereNm,i)
					, table.getData(_col.officeNm,i)
      			    , table.getData(_col.territoryCD,i)
       			    , adHistory
					, table.getData(_col.venueGradCD,i)
					, table.getData(_col.venueDivCD,i)
					, table.getData(_col.buCDName,i)
					, table.getData(_col.requiredADCD1Name,i)
					, table.getData(_col.amt1,i)
					, table.getData(_col.requiredADCD2Name,i)
					, table.getData(_col.amt2,i)
					, table.getData(_col.requiredADCD3Name,i)
					, table.getData(_col.amt3,i)
					, table.getData(_col.contractStateCDNm,i)
					, table.getData(_col.payStateCDNm,i)
					, table.getData(_col.apAmt,i)
					, table.getData(_col.posmAmt,i)
					, table.getData(_col.gsv,i)
					, table.getData(_col.prdTotalAmt,i)
					, table.getData(_col.adSdxDep,i)
					, table.getData(_col.apAmtPerGsv,i)+'%'
					, table.getData(_col.resultGsv,i)
					, table.getData(_col.resultTQty,i)
					, table.getData(_col.resultSdxDep,i)
      			];
      			
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo("grid", beginRowNum, endRowNum, table.getData(_col.totalCount, 0));
		}
		else {
			message("<fmt:message key="info.nullData"/>");
			
			clearPageInfo("grid");
      	}
      	grid.refresh();
	}
	
	//업소 팝업 
	function closeMyVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
	//엑셀
	function Excel() {
		var table = new AW.XML.Table;
		
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "AD0200302S");
		table.setParameter("startDT", $("#yearFromCD_S").val() + $("#monthFromCD_S").val());
		table.setParameter("endDT", $("#yearToCD_S").val() + $("#monthToCD_S").val());
		table.setParameter("empID", "${params.empID}");
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("contractStateCD", $("#contractStateCD_S").val());
	  	
		var headerText = [
			"<fmt:message key="AD02003A.adSupportID"/>"
			, "<fmt:message key="AD02003A.expcCommt"/>"
			, "<fmt:message key="AD02003A.eventYm"/>"
			, "<fmt:message key="AD02003A.venueCD"/>"
			, "<fmt:message key="AD02003A.venueNm"/>"
			, "<fmt:message key="AD01001A.chain"/>"
			, "<fmt:message key="AD02003A.rageSphereCD"/>"
			, "<fmt:message key="AD02003A.officeCD"/>"
			, "<fmt:message key="AD02003A.territoryCD"/>"
			, "<fmt:message key="AD02003A.venueGradCD"/>"
			, "<fmt:message key="AD02003A.venueDivCD"/>"
			, "<fmt:message key="AD01001A.buCDName"/>"
			, "<fmt:message key="AD01001A.requiredADCD1Name"/>"
			, "<fmt:message key="AD01001A.amt"/>"
			, "<fmt:message key="AD01001A.requiredADCD2Name"/>"
			, "<fmt:message key="AD01001A.amt"/>"
			, "<fmt:message key="AD01001A.requiredADCD3Name"/>"
			, "<fmt:message key="AD01001A.amt"/>"
			, "<fmt:message key="AD02003A.contractStateCD"/>"
			, "<fmt:message key="AD02003A.payStateCD"/>"
			, "<fmt:message key="AD02003A.apAmt"/>"
			, "<fmt:message key="AD02003A.posmAmt"/>"
			, "<fmt:message key="AD02003A.gsv"/>"
			, "<fmt:message key="AD02003A.prdTotalAmt"/>"
			, "<fmt:message key="AD02003A.adSdxDep"/>"
			, "<fmt:message key="AD02003A.apAmtPerGsv"/>"
			, "<fmt:message key="AD02003A.resultGsv"/>"
			, "<fmt:message key="AD02003A.resultTQty"/>"
			, "<fmt:message key="AD02003A.resultSdxDep"/>"
		];
		
		table.setParameter("templateFile", "AD02003A");
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
		"<fmt:message key="AD02003A.adSupportID"/>"
		, "<fmt:message key="AD02003A.expcCommt"/>"
		, "<fmt:message key="AD02003A.eventYm"/>"
		, "<fmt:message key="AD02003A.venueCD"/>"
		, "<fmt:message key="AD02003A.venueNm"/>"
		, "<fmt:message key="AD01001A.chain"/>"
		, "<fmt:message key="AD02003A.rageSphereCD"/>"
		, "<fmt:message key="AD02003A.officeCD"/>"
		, "<fmt:message key="AD02003A.territoryCD"/>"
 		, "<fmt:message key="AD01001A.adHistory"/>"
		, "<fmt:message key="AD02003A.venueGradCD"/>"
		, "<fmt:message key="AD02003A.venueDivCD"/>"
		, "<fmt:message key="AD01001A.buCDName"/>"
		, "<fmt:message key="AD01001A.requiredADCD1Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.requiredADCD2Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.requiredADCD3Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD02003A.contractStateCD"/>"
		, "<fmt:message key="AD02003A.payStateCD"/>"
		, "<fmt:message key="AD02003A.apAmt"/>"
		, "<fmt:message key="AD02003A.posmAmt"/>"
		, "<fmt:message key="AD02003A.gsv"/>"
		, "<fmt:message key="AD02003A.prdTotalAmt"/>"
		, "<fmt:message key="AD02003A.adSdxDep"/>"
		, "<fmt:message key="AD02003A.apAmtPerGsv"/>"
		, "<fmt:message key="AD02003A.resultGsv"/>"
		, "<fmt:message key="AD02003A.resultTQty"/>"
		, "<fmt:message key="AD02003A.resultSdxDep"/>"
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
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);
	    for (var i = 0; i < columns.length; i++) {
	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
 	    grid.setFixedLeft(8);
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	    					str, str, str, str, str 
	    					, str , str, str, str, html
	    					, str, str, str, str, str
	    					, str, str, str, str, str
	    					, str, num, num, num, num1
	    					, num1, str, num, num1, num1
	    				   ]);
	    
	    grid.setCellEditable(false); 

		
    }
	
</script>