<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>${params.viewName}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@include file="../sys3/scripts.jsp"%>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<form name="form" method="post">
		<div id="wrapDiv">
			<div id="formDiv">
				<table border="0" cellpadding="0" cellspacing="0" width="100%"
					height="100%">
					<tr>
						<td height="1"><%@include
								file="../sys3/cms/standardParam.jsp"%>
							<%@include file="../sys3/cms/functionbar.jsp"%>
							<%@include file="../sys3/cms/calendar.jsp"%>
							<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM05001B" />
							<input type="hidden" id="appSrc_upload" name="appSrc_upload" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM05001C" />
						</td>
					</tr>
					<tr>
						<td height="1">
							<table border="0" cellspacing="0" cellpadding="0" width="100%">
								<tr>
									<td class="tb-border">
										<table border="0" cellpadding="0" cellspacing="0" width="100%"
											style="border: #e1dcbe solid 1px; table-layout: fixed;">
											<colgroup>
												<col style="width: 100px"></col>
												<col style="width: 250px"></col>
												<col style="width: 100px"></col>
												<col style="width: 180px"></col>
												<col style="width: 100px"></col>
												<col></col>
											</colgroup>
											<tbody>
												<tr>
													<td class="td-cond-required">
														<fmt:message key="MDM05001A.requestDate_S" />
													</td>
													<td class="td-input">
														<nis:calendar id="requestDateFrom_S" value="${params.firstDate}" cssClass="input-readonly" readOnly="yes" /> 
															- <nis:calendar id="requestDateTo_S" value="${params.lastDate}" cssClass="input-readonly" readOnly="yes" />
												    </td>
													<td class="td-cond">
														<fmt:message key="MDM05001A.requestStateCD" />
													</td>
													<td class="td-input">
														<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="all" category="APPRSTATECD" style="width:80px;" />
													</td>
													<td class="td-cond">
														<fmt:message key="MDM05001A.venueGradCD" />
													</td>
													<td class="td-input">
														<nis:selectbox id="venueGradCD" name="venueGradCD" defaultText="all" category="VENUEGRADCD" style="width:80px;" />
													</td>
												</tr>
												<tr>
													<td class="td-cond">
														<fmt:message key="MDM05001A.venueNm" />
													</td>
													<td class="td-input">
														<input type="text" id="venueNm"	name="venueNm" style="width: 150px;">
													</td>
													<td class="td-cond">
														<fmt:message key="MDM05001A.territoryCD" />
													</td>
													<td class="td-input" colspan="3">
														<nis:popup id="territory" nameID="territoryCDName" keyID="territoryCD" value="${params.territoryCD}"/>
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
							<nis:paging id="grid" titleDisable="yes" callback="PagingSearch()" />
						</td>
					</tr>
					<tr>
						<td height="1">
							<input type="hidden" id="selectVenueCD" name="selectVenueCD" /> 
							<iframe src="" id="downloadFrame" name="downloadFrame" style="width: 0px; height: 0px;"></iframe>
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
	
	.aw-grid-control {height: 100%;	width: 100%; margin: 0px;}
	.aw-grid-header {text-align: center; border-right: 1px solid #aca899 !important; background: #F3F4F6}
	.aw-row-selector {text-align: center}
	
	#grid .aw-header-1 .aw-column-0 {text-align: center;}
	#grid .aw-header-1 .aw-column-1 {text-align: center;}
	#grid .aw-header-1 .aw-column-2 {width: 120px; text-align: left;}
	#grid .aw-header-1 .aw-column-3 {text-align: center;}
	#grid .aw-header-1 .aw-column-4 {text-align: center;}
	#grid .aw-header-1 .aw-column-5 {text-align: center;}
	#grid .aw-header-1 .aw-column-6 {text-align: center;}
	#grid .aw-header-1 .aw-column-7 {text-align: center;}
	#grid .aw-header-1 .aw-column-8 {text-align: center;}
	#grid .aw-header-1 .aw-column-9 {text-align: center;}
	#grid .aw-header-1 .aw-column-10 {text-align: left;}
	#grid .aw-header-1 .aw-column-11 {text-align: left;}
	#grid .aw-header-1 .aw-column-12 {text-align: left;}
	#grid .aw-header-1 .aw-column-13 {text-align: left;}
	#grid .aw-header-1 .aw-column-14 {text-align: center;}
	#grid .aw-header-1 .aw-column-15 {text-align: left;}
	#grid .aw-header-1 .aw-column-16 {text-align: left;}
	#grid .aw-header-1 .aw-column-17 {text-align: center;}
	#grid .aw-header-1 .aw-column-18 {text-align: left;}
	#grid .aw-header-1 .aw-column-19 {text-align: left;}
	#grid .aw-header-1 .aw-column-20 {text-align: left;}
	#grid .aw-header-1 .aw-column-21 {text-align: left;}
	#grid .aw-header-1 .aw-column-22 {text-align: center;}
	#grid .aw-header-1 .aw-column-23 {text-align: center;}
	#grid .aw-header-1 .aw-column-24 {text-align: center;}
	#grid .aw-header-1 .aw-column-25 {text-align: center;}
	#grid .aw-header-1 .aw-column-26 {text-align: center;}
	#grid .aw-header-1 .aw-column-27 {text-align: center;}
	#grid .aw-header-1 .aw-column-28 {text-align: left;}
	#grid .aw-header-1 .aw-column-29 {text-align: left;}
	#grid .aw-header-1 .aw-column-30 {text-align: center;}
	#grid .aw-header-1 .aw-column-31 {text-align: center;}
	#grid .aw-header-1 .aw-column-32 {text-align: left;}
	#grid .aw-header-1 .aw-column-33 {text-align: center;}
	#grid .aw-header-1 .aw-column-34 {text-align: center;}
	#grid .aw-header-1 .aw-column-35 {text-align: left;}
	#grid .aw-header-1 .aw-column-36 {text-align: center;}
	#grid .aw-header-1 .aw-column-37 {text-align: center;}
	
	#grid .aw-column-0 {width: 100px; text-align: center;}
	#grid .aw-column-1 {width: 100px; text-align: center;}
	#grid .aw-column-2 {width: 120px; text-align: center;}
	#grid .aw-column-3 {width: 100px; text-align: center;}
	#grid .aw-column-4 {width: 100px; text-align: left;}
	#grid .aw-column-5 {width: 100px; text-align: left;}
	#grid .aw-column-6 {width: 100px; text-align: center;}
	#grid .aw-column-7 {width: 100px; text-align: center;}
	#grid .aw-column-8 {width: 100px; text-align: center;}
	#grid .aw-column-9 {width: 100px; text-align: left;}
	#grid .aw-column-10 {width: 100px; text-align: left;}
	#grid .aw-column-11 {width: 110px; text-align: left;}
	#grid .aw-column-12 {width: 100px; text-align: left;}
	#grid .aw-column-13 {width: 100px; text-align: center;}
	#grid .aw-column-14 {width: 100px; text-align: center;}
	#grid .aw-column-15 {width: 100px; text-align: center;}
	#grid .aw-column-16 {width: 100px; text-align: center;}
	#grid .aw-column-17 {width: 100px; text-align: center;}
	#grid .aw-column-18 {width: 100px; text-align: center;}
	#grid .aw-column-19 {width: 100px; text-align: center;}
	#grid .aw-column-20 {width: 100px; text-align: center;}
	#grid .aw-column-21 {width: 100px; text-align: center;}
	#grid .aw-column-22 {width: 100px; text-align: center;}
	#grid .aw-column-23 {width: 100px; text-align: center;}
	#grid .aw-column-24 {width: 140px; text-align: left;}
	#grid .aw-column-25 {width: 100px; text-align: center;}
	#grid .aw-column-26 {width: 100px; text-align: left;}
	#grid .aw-column-27 {width: 100px; text-align: center;}
	#grid .aw-column-28 {width: 100px; text-align: center;}
	#grid .aw-column-29 {width: 100px; text-align: left;}
	#grid .aw-column-30 {width: 100px; text-align: center;}
	#grid .aw-column-31 {width: 100px; text-align: center;}
	#grid .aw-column-32 {width: 100px; text-align: left;}
	#grid .aw-column-33 {width: 100px; text-align: center;}
	#grid .aw-column-34 {width: 100px; text-align: center;}
	#grid .aw-column-35 {width: 100px; text-align: left;}
	#grid .aw-column-36 {width: 100px; text-align: center;}
	#grid .aw-column-37 {width: 100px; text-align: lett;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script type="text/javascript">
	/****************************************
	 * Variable
	 ****************************************/
	 var grid_displayNum = "100";
	 var grid_pageNum = "1";

	/****************************************
	 * Function
	 ****************************************/

	$(function() {

		window.onload = function() {

			$("#grid_displayNum").val(grid_displayNum);
			createGrid();
			grid.refresh();

			getTerritoryName("territory", "territoryCD","territoryCDName");
			
			Search();
		};                    
                              
		${initScript}

		$("#venueNm").keypress(function() {
			if (event.keyCode == 13) {
				Search();
			}
		});
		
		$("#territory").keypress(function() {
			if (event.keyCode == 13) {
				getTerritoryName("territory", "territoryCD","territoryCDName");
			}
		});
	
		$("#territory_popup").click(function() {
			openTerritoryPopup("closeTerritoryPopup");
		});

	});
	
	//Date search check
	function validateDate() {
		var startDate = $("#requestDateFrom_S").val();
		var endDate = $("#requestDateTo_S").val();
		var flag = true;
		
		if (startDate > endDate) {
			alert("<fmt:message key="MDM05001A.msg1"/>");
		 	flag = false;
		}		
		
		return flag;
	}

	//Territory popup close
	function closeTerritoryPopup(data) {
		$("#territory").val(data.territoryCD);
		$("#territoryCD").val(data.territoryCD);
		$("#territoryCDName").val(data.territoryCDName);
	}

	//신규
	function New() {
		$("#selectVenueCD").val("");

		appletDiv_set({	"src" : $("#appSrc").val() + "&initAction=New",	"appPositionCD" : "${params.appPositionCD}","appDisRate" : "${params.appDisRate}","appDisUnitCD" : "${params.appDisUnitCD}"	});
		appletOpen();
	}

	//조회
	function Search() {
		$("#grid_pageNum").val(grid_pageNum);
		validateDate();
		PagingSearch();
	}

	
	function PagingSearch() {
		var data = new Array();
		var rowCount = 0;
		var beginRowNum = 0; 
		var endRowNum = 0;
		var table = new AW.XML.Table;
		
		table.setURL("${contextPath}/service/simpleAction/MDM0500101S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
				"requestDate;requestStateCDName;mdDupYN;tmpVenueCD;venueNm;"
			  + "territoryCDName;phoneNo;fasciaCDName;venueGradCDName;addrTpCD1Name;"
			  + "addrTpCD2Name;addrTpCD3Name;oldAddr2;postCD;siteCDName;"
			  + "channelCDName;subChannelCDName;segmentCDName;subSegmentCDName;reserveSegmentCDName;"
			  + "ageingCDName;kegYNName;mdVenueCD;locationCDName;requestCommt;"
			  + "ws1SapCD;ws1SapCDName;branch1;ws2SapCD;ws2SapCDName;"
			  + "branch2;ws3SapCD;ws3SapCDName;branch3;ws4SapCD;"
			  + "ws4SapCDName;branch4;venueCD;rowNum;");
		table.setParameter("format", 
				"str;str;str;str;str;"
			  + "str;str;str;str;str;" 
			  + "str;str;str;str;str;"
			  + "str;str;str;str;str;" 
			  + "str;str;str;str;str;"
			  + "str;str;str;str;str;" 
			  + "str;str;str;str;str;"
			  + "str;str;str;str;");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("requestDateFrom", convertDate($("#requestDateFrom_S").val()));
		table.setParameter("requestDateTo", convertDate($("#requestDateTo_S").val()));
		table.setParameter("apprStateCD", $("#apprStateCD_S").val());
		table.setParameter("venueGradCD", $("#venueGradCD").val());
		table.setParameter("venueNm", $("#venueNm").val());
		table.setParameter("territoryCD", $("#territoryCD").val());
		//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
		table.request();

		createGrid();
		
		rowCount = table.getCount();
		
		if (rowCount > 0) {
			
			for (i = 0; i < rowCount; i++) {
				
				data[i] = [ 
						  table.getData(_col.requestDate, i)
						, table.getData(_col.requestStateCDName, i)
						, table.getData(_col.mdDupYN, i)
						, table.getData(_col.tmpVenueCD, i)
						, table.getData(_col.venueNm, i)
						, table.getData(_col.territoryCDName, i)
						, table.getData(_col.phoneNo, i)
						, table.getData(_col.fasciaCDName, i)
						, table.getData(_col.venueGradCDName, i)
						, table.getData(_col.addrTpCD1Name, i)
						, table.getData(_col.addrTpCD2Name, i)
						, table.getData(_col.addrTpCD3Name, i)
						, table.getData(_col.oldAddr2, i)
						, table.getData(_col.postCD, i)
						, table.getData(_col.siteCDName, i)
						, table.getData(_col.channelCDName, i)
						, table.getData(_col.subChannelCDName, i)
						, table.getData(_col.segmentCDName, i)
						, table.getData(_col.subSegmentCDName, i)
						, table.getData(_col.reserveSegmentCDName, i)
						, table.getData(_col.ageingCDName, i)
						, table.getData(_col.kegYNName, i)
						, table.getData(_col.mdVenueCD, i)
						, table.getData(_col.locationCDName, i)
						, table.getData(_col.requestCommt, i)
						, table.getData(_col.ws1SapCD, i)
						, table.getData(_col.ws1SapCDName, i)
						, table.getData(_col.branch1, i)
						, table.getData(_col.ws2SapCD, i)
						, table.getData(_col.ws2SapCDName, i)
						, table.getData(_col.branch2, i)
						, table.getData(_col.ws3SapCD, i)
						, table.getData(_col.ws3SapCDName, i)
						, table.getData(_col.branch3, i)
						, table.getData(_col.ws4SapCD, i)
						, table.getData(_col.ws4SapCDName, i)
						, table.getData(_col.branch4, i)
						, table.getData(_col.venueCD, i)
						];
			}

			grid.setCellData(data);
			grid.setRowCount(rowCount);

			//totalCount
			beginRowNum = table.getData(_col.rowNum, 0);
			endRowNum = table.getData(_col.rowNum, rowCount - 1);
			
			table.setURL("${contextPath}/service/simpleAction/MDM0500103S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("outParamKey", "totalCount;");
			table.setParameter("format", "str;");
			table.request();

			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo('grid', beginRowNum, endRowNum, table.getData(0, 0));
			
		} else {
			message("<fmt:message key="info.nullData"/>");
			//Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
		}
		grid.refresh();
	}

	//입력용 파일받기
	function DownloadToInput() {
		form.action = "${contextPath}/service/mdm05/downloadFile";
		form.target = "downloadFrame";
		form.submit();
	}
	
	//업소목록엑셀
	function VenueListExcel() {
		
		showLoading();
		
		if (!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "MDM0500113S");
 		table.setParameter("territoryCD", $("#territoryCD").val());
		  	
			var headerText = [
				"<fmt:message key="MDM02001A.venueCD"/>"
				, "<fmt:message key="MDM02001A.venueNm"/>"
				, "<fmt:message key="MDM02001A.dkmdTpCD"/>"
				, "<fmt:message key="MDM02001A.territoryCD"/>"
				, "<fmt:message key="MDM02001A.venueGradCD"/>"
				, "<fmt:message key="MDM02001A.channelCD"/>"
				, "<fmt:message key="MDM02001A.subChannelCD"/>"
				, "<fmt:message key="MDM02001A.segmentCD"/>"
				, "<fmt:message key="MDM02001A.subSegmentCD"/>"
				, "<fmt:message key="MDM02001A.addrTpCD1"/>"
				, "<fmt:message key="MDM02001A.addrTpCD2"/>"
				, "<fmt:message key="MDM02001A.addrTpCD3"/>"
				, "<fmt:message key="MDM02001A.addrTpCD4"/>"
				, "<fmt:message key="MDM02001A.wsCD"/>"
				, "<fmt:message key="cc.wsCDName"/>"
				, "<fmt:message key="MDM02001A.wsSapCD"/>"
				, "<fmt:message key="MDM02001A.wsSapCDName"/>"
				, "<fmt:message key="MDM02001A.note1"/>"
				, "<fmt:message key="MDM02001A.note2"/>"
				, "<fmt:message key="MDM02001A.note3"/>"
				, "<fmt:message key="MDM02001A.note4"/>"
				, "<fmt:message key="MDM02001A.incntTpCDName"/>"
				, "<fmt:message key="MDM02001A.activeYN"/>"
				, "<fmt:message key="MDM02001A.venueDivCDName"/>"
			];
			
			table.setParameter("templateFile", "Venue_List");
			table.setParameter("headerText", headerText);
			table.request();
				
			if (table.getCount() > 0) {
				if (table.getData(0,0) == "S") {
				    form.action = "${contextPath}/service/simpleExport/download/?"+
				    		"tempFile="+table.getData(3,0)+
				    		"&downloadFile=Venue_List";
				    form.target = "_self";
				    form.submit();
				}
			}
			hideLoading();
	}

	//엑셀 업로드
	function ExcelUpload() {
		appletDiv_set({	"src" : $("#appSrc_upload").val(),"appPositionCD" : "${params.appPositionCD}","appDisRate" : "${params.appDisRate}","appDisUnitCD" : "${params.appDisUnitCD}"});
		appletOpen();
	}

	//엑셀
	function Excel() {
		
		showLoading();
		
		if (!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "MDM0500109S");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("requestDateFrom", convertDate($("#requestDateFrom_S").val()));
		table.setParameter("requestDateTo", convertDate($("#requestDateTo_S").val()));
		table.setParameter("apprStateCD", $("#apprStateCD_S").val());
		table.setParameter("venueGradCD", $("#venueGradCD").val());
		table.setParameter("venueNm", $("#venueNm").val());
		table.setParameter("territoryCD", $("#territoryCD").val());

		var headerText = [ 
						  "<fmt:message key="MDM05001A.requestDate"/>"
						, "<fmt:message key="MDM05002A.requestState"/>"
						, "<fmt:message key="MDM05001A.mdDuplicateYN"/>"
						, "<fmt:message key="MDM05001A.venueCD"/>"
						, "<fmt:message key="MDM05001A.venueNm"/>"
						, "<fmt:message key="MDM05001A.territoryCD"/>"
						, "<fmt:message key="MDM05001A.venuePhoneNumber"/>"
						, "<fmt:message key="MDM05001A.fasica"/>"
						, "<fmt:message key="MDM05001A.grade"/>"
						, "<fmt:message key="MDM05001A.addrTpCD1Name"/>"
						, "<fmt:message key="MDM05001A.addrTpCD2Name"/>"
						, "<fmt:message key="MDM05001A.addrTpCD3Name"/>"
						, "<fmt:message key="MDM05001A.addrTpCD4Name"/>"
						, "<fmt:message key="MDM05001A.postCD"/>"
						, "<fmt:message key="MDM05001A.newFullAddr"/>"
						, "<fmt:message key="MDM05001A.site"/>"
						, "<fmt:message key="MDM05001A.channel"/>"
						, "<fmt:message key="MDM05001A.subChannel"/>"
						, "<fmt:message key="MDM05001A.segment"/>"
						, "<fmt:message key="MDM05001A.subSegment"/>"
						, "<fmt:message key="MDM05001A.reserveSegment"/>"
						, "<fmt:message key="MDM05001A.aging"/>"
						, "<fmt:message key="MDM05001A.kegYN"/>"
						, "<fmt:message key="MDM05001A.mdVenueCD"/>"
						, "<fmt:message key="MDM05001A.locationYN"/>"
						, "<fmt:message key="MDM05003A.commt"/>"
						, "<fmt:message key="MDM05001A.wsSapCode"/>"
						, "<fmt:message key="MDM05001A.wsSapName"/>"
						, "<fmt:message key="MDM05001A.wsBranch"/>"
						, "<fmt:message key="MDM05001A.wsSapCode"/>"
						, "<fmt:message key="MDM05001A.wsSapName"/>"
						, "<fmt:message key="MDM05001A.wsBranch"/>"
						, "<fmt:message key="MDM05001A.wsSapCode"/>"
						, "<fmt:message key="MDM05001A.wsSapName"/>"
						, "<fmt:message key="MDM05001A.wsBranch"/>"
						, "<fmt:message key="MDM05001A.wsSapCode"/>"
						, "<fmt:message key="MDM05001A.wsSapName"/>"
						, "<fmt:message key="MDM05001A.wsBranch"/>" 
						];

		table.setParameter("templateFile", "MDM05001A");
		table.setParameter("headerText", headerText);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0, 0) == "S") {
				form.action = "${contextPath}/service/simpleExport/download/?"
						+ "tempFile=" + table.getData(3, 0)
						+ "&downloadFile=${params.viewName}";
				form.target = "_self";
				form.submit();
			}
		}
		hideLoading();
	}
	
	/*****************************************************
	 *	Grid Setting
	 *****************************************************/
	var grid = null;
	
	var _i = 0;
	var _col = {
		  requestDate : _i++
		, requestStateCDName : _i++
		, mdDupYN : _i++
		, tmpVenueCD : _i++
		, venueNm : _i++
		, territoryCDName : _i++
		, phoneNo : _i++
		, fasciaCDName : _i++
		, venueGradCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, addrTpCD3Name : _i++
		, oldAddr2 : _i++
		, postCD : _i++
		, siteCDName : _i++
		, channelCDName : _i++
		, subChannelCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, reserveSegmentCDName : _i++
		, ageingCDName : _i++
		, kegYNName : _i++
		, mdVenueCD : _i++
		, locationCDName : _i++
		, requestCommt : _i++
		, ws1SapCD : _i++
		, ws1SapCDName : _i++
		, branch1 : _i++
		, ws2SapCD : _i++
		, ws2SapCDName : _i++
		, branch2 : _i++
		, ws3SapCD : _i++
		, ws3SapCDName : _i++
		, branch3 : _i++
		, ws4SapCD : _i++
		, ws4SapCDName : _i++
		, branch4 : _i++
		, venueCD : _i++
		, rowNum : _i++
	};

	var columns_header = [ 
		  "" 
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, "<fmt:message key="MDM05001A.address"/>"
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, ""
		, "<fmt:message key="MDM05001A.ws1"/>"
		, ""
		, ""
		, "<fmt:message key="MDM05001A.ws2"/>"
		, ""
		, ""
		, "<fmt:message key="MDM05001A.ws3"/>"
		, ""
		, ""
		, "<fmt:message key="MDM05001A.ws4"/>"
		, ""
		, "" 
	];

	var columns = [ 
		  "<fmt:message key="MDM05001A.requestDate"/>"
		, "<fmt:message key="MDM05002A.requestState"/>"
		, "<fmt:message key="MDM05001A.mdDuplicateYN"/>"
		, "<fmt:message key="MDM05001A.venueCD"/>"
		, "<fmt:message key="MDM05001A.venueNm"/>"
		, "<fmt:message key="MDM05001A.territoryCD"/>"
		, "<fmt:message key="MDM05001A.venuePhoneNumber"/>"
		, "<fmt:message key="MDM05001A.fasica"/>"
		, "<fmt:message key="MDM05001A.grade"/>"
		, "<fmt:message key="MDM05001A.addrTpCD1Name"/>"
		, "<fmt:message key="MDM05001A.addrTpCD2Name"/>"
		, "<fmt:message key="MDM05001A.addrTpCD3Name"/>"
		, "<fmt:message key="MDM05001A.addrTpCD4Name"/>"
		, "<fmt:message key="MDM05001A.postCD"/>"
		, "<fmt:message key="MDM05001A.site"/>"
		, "<fmt:message key="MDM05001A.channel"/>"
		, "<fmt:message key="MDM05001A.subChannel"/>"
		, "<fmt:message key="MDM05001A.segment"/>"
		, "<fmt:message key="MDM05001A.subSegment"/>"
		, "<fmt:message key="MDM05001A.reserveSegment"/>"
		, "<fmt:message key="MDM05001A.aging"/>"
		, "<fmt:message key="MDM05001A.kegYN"/>"
		, "<fmt:message key="MDM05001A.mdVenueCD"/>"
		, "<fmt:message key="MDM05001A.locationYN"/>"
		, "<fmt:message key="MDM05003A.commt"/>"
		, "<fmt:message key="MDM05001A.wsSapCode"/>"
		, "<fmt:message key="MDM05001A.wsSapName"/>"
		, "<fmt:message key="MDM05001A.wsBranch"/>"
		, "<fmt:message key="MDM05001A.wsSapCode"/>"
		, "<fmt:message key="MDM05001A.wsSapName"/>"
		, "<fmt:message key="MDM05001A.wsBranch"/>"
		, "<fmt:message key="MDM05001A.wsSapCode"/>"
		, "<fmt:message key="MDM05001A.wsSapName"/>"
		, "<fmt:message key="MDM05001A.wsBranch"/>"
		, "<fmt:message key="MDM05001A.wsSapCode"/>"
		, "<fmt:message key="MDM05001A.wsSapName"/>"
		, "<fmt:message key="MDM05001A.wsBranch"/>" 
	];

	AW.Grid.Header2 = AW.Grid.Header.subclass();
	AW.Grid.Header2.create = function() {
		var obj = this.prototype;
		obj.element = AW.System.HTML.prototype.element;

		function display() {
			var span = this.getHeaderProperty("span");
			return span == 0 ? "none" : null;
		}

		function width() {
			var span = this.getHeaderProperty("span");
			
			if (span == 1) {
				return null;
			}
			
			var pos = this.getColumnProperty("position");
			var a = this.getColumnProperty("indices");
			var i, col, w = 0;
			
			for (i = 0; i < span; i++) {
				col = a ? a[pos + i] : pos + i; // column index 
				w += this.getColumnProperty("width", col);
			}
			
			return w;
		}

		obj.setStyle("display", display);
		obj.setStyle("width", width);
	};

	function createGrid() {
		var tempColumns = new Array();
		
		grid = new AW.Grid.Extended;
		grid.setId("grid");
		grid.defineHeaderProperty("span", 1);
		grid.setHeaderTemplate(new AW.Grid.Header2);
		grid.setHeaderCount(2);
		
		grid.onColumnWidthChanged = function() {
			this.getHeadersTemplate(1, "center").refresh();
		};

		grid.setHeaderText(columns, 0);
		grid.setHeaderText(columns_header, 1);
		grid.setColumnCount(columns.length);

		for (var i = 0; i < columns.length; i++) {
			grid.getHeaderTemplate(i).setStyle("text-align", "center");
		}

		grid.setHeaderIndices([ 1, 0 ]);

		grid.setHeaderSpan(0, 0, 1);
		grid.setHeaderSpan(0, 1, 1);
		grid.setHeaderSpan(0, 2, 1);
		grid.setHeaderSpan(0, 3, 1);
		grid.setHeaderSpan(0, 4, 1);
		grid.setHeaderSpan(0, 5, 1);

		grid.setHeaderSpan(4, 6, 1);
		grid.setHeaderSpan(0, 7, 1);
		grid.setHeaderSpan(0, 8, 1);
		grid.setHeaderSpan(0, 9, 1);

		grid.setHeaderSpan(5, 10, 1);
		grid.setHeaderSpan(0, 11, 1);
		grid.setHeaderSpan(0, 12, 1);
		grid.setHeaderSpan(0, 13, 1);
		grid.setHeaderSpan(0, 14, 1);

		grid.setHeaderSpan(11, 15, 1);
		grid.setHeaderSpan(0, 16, 1);
		grid.setHeaderSpan(0, 17, 1);
		grid.setHeaderSpan(0, 18, 1);
		grid.setHeaderSpan(0, 19, 1);
		grid.setHeaderSpan(0, 20, 1);
		grid.setHeaderSpan(0, 21, 1);
		grid.setHeaderSpan(0, 22, 1);
		grid.setHeaderSpan(0, 23, 1);
		grid.setHeaderSpan(0, 24, 1);
		
		grid.setHeaderSpan(0, 25, 1);
		grid.setHeaderSpan(3, 26, 1);
		grid.setHeaderSpan(0, 27, 1);
		
		grid.setHeaderSpan(0, 28, 1);
		grid.setHeaderSpan(3, 29, 1);
		grid.setHeaderSpan(0, 30, 1);
		
		grid.setHeaderSpan(0, 31, 1);
		grid.setHeaderSpan(3, 32, 1);
		grid.setHeaderSpan(0, 33, 1);
		
		grid.setHeaderSpan(0, 34, 1);
		grid.setHeaderSpan(3, 35, 1);
		grid.setHeaderSpan(0, 36, 1);
		grid.setHeaderSpan(0, 37, 1);

		grid.setStyle("width", "100%");
		grid.setStyle("height", "420px");
		grid.setFixedLeft(5);
		grid.setCellFormat([ str, str, str, str, str
					   	   , str, str, str, str, str
					   	   , str, str, str, str, str
					   	   , str, str, str, str, str
					   	   , str, str, str, str, str
					   	   , str, str, str, str, str
					   	   , str, str, str, str, str
					   	   , str, str 
					   	   ]);
		grid.setSelectorVisible(false);
		grid.setSelectorWidth(50);
		
		grid.setSelectorText(function(i) {
			return this.getRowPosition(i) + 1
		});
		
		grid.setHeaderHeight(20);
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);

		tempColumns = [ 0, 1, 2, 3, 4
					  , 5, 6, 7, 8, 9
					  , 10, 11, 12, 13, 14
					  , 15,	16, 17, 18, 19
					  , 20, 21, 22, 23, 24
					  , 25, 26, 27, 28, 29
					  , 30, 31,	32, 33, 34
					  , 35, 36 
					  ];
		grid.setColumnIndices(tempColumns);

		grid.onRowDoubleClicked = function(event, row) {

			$("#selectVenueCD").val(this.getCellText(_col.tmpVenueCD, row));

			appletDiv_set({ "src" : $("#appSrc").val() + "&initAction=Search","appPositionCD" : "${params.appPositionCD}","appDisRate" : "${params.appDisRate}","appDisUnitCD" : "${params.appDisUnitCD}"});
			appletOpen();
		}
	}
</script>