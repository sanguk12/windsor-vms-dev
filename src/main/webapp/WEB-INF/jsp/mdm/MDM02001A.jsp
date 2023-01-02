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
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM02001B" />
								<input type="hidden" id="appSrc_upload" name="appSrc_upload" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM02001C" />
							</td>
						</tr>
		                <tr>
		                	<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
													<col style="width:100px"></col>
													<col style="width:150px"></col>
													<col style="width:100px"></col>
													<col style="width:180px"></col>
													<col style="width:100px"></col>
													<col></col>
												</colgroup>
												<tbody>
													<tr>
														<td class="td-cond"><fmt:message key="MDM02001A.dkmdTpCD"/>
														</td>
														<td class="td-input">
															<nis:selectbox id="dkmdTpCD" name="dkmdTpCD" defaultText="all" category="DKMDTPCD" />
														</td>
														<td class="td-cond"><fmt:message key="MDM02001A.venueCD"/>
														</td>
														<td class="td-input">
															<input type="text" id="venueCD" name="venueCD" style="width:150px;">
														</td>
														<td class="td-cond"><fmt:message key="MDM02001A.venueNm"/>
														</td>
														<td class="td-input">
															<input type="text" id="venueNm" name="venueNm" style="width:150px;">
														</td>
													</tr>
													<tr>
														<td class="td-cond"><fmt:message key="MDM02001A.venueGradCD"/>
														</td>
														<td class="td-input">
															<nis:selectbox id="venueGradCD" name="venueGradCD" defaultText="all" category="VENUEGRADCD" />
														</td>
														<td class="td-cond"><fmt:message key="MDM02001A.activeYN"/>
														</td>
														<td class="td-input">
															<nis:selectbox id="activeYN" name="activeYN" defaultText="all" category="ACTIVEYN" />
														</td>
														<td class="td-cond"><fmt:message key="MDM02001A.territoryCD"/>
														</td>
														<td class="td-input">
															<nis:popup id="territory" nameID="territoryCDName" keyID="territoryCD" />
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
		                <tr>
		                    <td class="td-paging">
		                        <nis:paging id="grid" titleDisable="yes" callback="PagingSearch()"/>
		                    </td>
		                </tr>
		                <tr>
		                	<td height="1">
		                		<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
		                		<iframe src="" id="downloadFrame" name="downloadFrame" style="width:0px;height:0px;"></iframe>
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
    .aw-column-1 {width: 150px; text-align:left;}
    .aw-column-2 {width: 80px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:center;}
    .aw-column-4 {width: 80px; text-align:center;}
    .aw-column-5 {width: 100px; text-align:center;}
    .aw-column-6 {width: 100px; text-align:center;}
    .aw-column-7 {width: 100px; text-align:center;}
    .aw-column-8 {width: 100px; text-align:center;}
    .aw-column-9 {width: 100px; text-align:left;}
    .aw-column-10 {width: 120px; text-align:left;}
    .aw-column-11 {width: 150px; text-align:left;}
    .aw-column-12 {width: 180px; text-align:left;}
    .aw-column-13 {width: 120px; text-align:center;}
    .aw-column-14 {width: 150px; text-align:left;}
    .aw-column-15 {width: 100px; text-align:center;}
    .aw-column-16 {width: 150px; text-align:left;}
    .aw-column-17 {width: 150px; text-align:left;}
    .aw-column-18 {width: 150px; text-align:left;}
    .aw-column-19 {width: 150px; text-align:left;}
    .aw-column-20 {width: 150px; text-align:left;}
    .aw-column-22 {width: 100px; text-align:center;}
    .aw-column-23 {width: 100px; text-align:center;}
    .aw-column-24 {width: 80px; text-align:center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
    
</style>

<script type="text/javascript">

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
			
			if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD").val("${params.dkmdTpCD}");
				$("#dkmdTpCD").attr("disabled", true);
				$("#dkmdTpCD").addClass("input-readonly");
			}
			
		};
		
		${initScript}
		
		$("#venueCD").keypress(function(){
			if (event.keyCode==13){
				Search();
			}
		});
		$("#venueNm").keypress(function(){
			if (event.keyCode==13){
				Search();
			}
		});
		$("#territory").keypress(function(){
			if (event.keyCode==13){
				getTerritoryName("territory", "territoryCD", "territoryCDName");
			}
		});
		$("#territory_popup").click(function(){
			openTerritoryPopup("closeTerritoryPopup");
		});
	
	});
	
	function closeTerritoryPopup(data) {
		$("#territory").val(data.territoryCD);
		$("#territoryCD").val(data.territoryCD);
        $("#territoryCDName").val(data.territoryCDName);
	}
	
	function New() {
		$("#selectVenueCD").val("");
		
		appletDiv_set({"src":$("#appSrc").val()+"&initAction=New", "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
		appletOpen();
	}
	
	function Search() {
		$("#grid_pageNum").val("1");
		PagingSearch();
	}
	
	var _i = 0;
	var _col = {
		venueCD : _i++
		, venueNm : _i++
		, dkmdTpCDName : _i++
		, territoryCDName : _i++
		, venueGradCDName : _i++
		, channelCDName : _i++
		, subChannelCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, addrTpCD3Name : _i++
		, addrTpCD4Name : _i++
		, wsCD : _i++
		, wsCDName : _i++
		, wsSapCD : _i++
		, wsSapCDName : _i++
		, note1 : _i++
		, note2 : _i++
		, note3 : _i++
		, note4 : _i++
		, incntTpCDName : _i++
		, activeYNName : _i++
		, venueDivCDName : _i++
		, rowNum : _i++
	};
	function PagingSearch() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/MDM0200101S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
	  			"venueCD;venueNm;dkmdTpCDName;territoryCDName;venueGradCDName;"+
	  			"channelCDName;subChannelCDName;segmentCDName;subSegmentCDName;addrTpCD1Name;"+
	  			"addrTpCD2Name;addrTpCD3Name;addrTpCD4Name;wsCD;wsCDName;wsSapCD;"+
	  			"wsSapCDName;note1;note2;note3;note4;"+
	  			"incntTpCDName;activeYNName;venueDivCDName;rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;");
		table.setParameter("dkmdTpCD", $("#dkmdTpCD").val());
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("venueNm", $("#venueNm").val());
		table.setParameter("venueGradCD", $("#venueGradCD").val());
		table.setParameter("activeYN", $("#activeYN").val());
		table.setParameter("territoryCD", $("#territoryCD").val());
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
      		for (i=0; i < rowCount; i++) {
      			data[i] = [
      			    table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.dkmdTpCDName,i)
					, table.getData(_col.territoryCDName,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.channelCDName,i)
					, table.getData(_col.subChannelCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.addrTpCD3Name,i)
					, table.getData(_col.addrTpCD4Name,i)
					, table.getData(_col.wsCD,i)
					, table.getData(_col.wsCDName,i)
					, table.getData(_col.wsSapCD,i)
					, table.getData(_col.wsSapCDName,i)
					, table.getData(_col.note1,i)
					, table.getData(_col.note2,i)
					, table.getData(_col.note3,i)
					, table.getData(_col.note4,i)
					, table.getData(_col.incntTpCDName,i)
					, table.getData(_col.activeYNName,i)
					, table.getData(_col.venueDivCDName,i)
      			];
      		}
      		
			grid.setCellData(data);
			grid.setRowCount(rowCount);
			
			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/MDM0200105S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("outParamKey","totalCount;");
			table.setParameter("format","str;");
			table.request();
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo('grid', beginRowNum, endRowNum, table.getData(0,0));
      	}
      	else {
			message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
      	}
      	grid.refresh();
	}
	
	function DownloadToInput() {
        form.action = "${contextPath}/service/mdm02/downloadFile";
        form.target = "downloadFrame";
        form.submit();
    }
	
	function ExcelUpload() {
		appletDiv_set({"src":$("#appSrc_upload").val(), "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
		appletOpen();
	}
	
	function Excel() {
		showLoading();
		if(!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "MDM0200101S");
		table.setParameter("dkmdTpCD", $("#dkmdTpCD").val());
	  	table.setParameter("venueCD", $("#venueCD").val());
	  	table.setParameter("venueNm", $("#venueNm").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD").val());
	  	table.setParameter("activeYN", $("#activeYN").val());
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
		
		table.setParameter("templateFile", "MDM02001A");
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
	*	Grid Setting
	*****************************************************/

	var columns = [
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
		, "<fmt:message key="MDM02001A.wsCDName"/>"
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
	
	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
		grid.setId("grid");
		grid.setCellFormat([  str, str, str, str, str
		                    , str, str, str, str, str
		                    , str, str, str, str ]);
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(true);
		grid.setSelectorWidth(40);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setHeaderHeight(20);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setSelectionMode("single-row");
		grid.setStyle("width","100%");
		grid.setStyle("height","100%");
		grid.setCellEditable(false);
		grid.setFixedLeft(2);
		
		grid.onRowDoubleClicked = function(event, row){
			$("#selectVenueCD").val(this.getCellText(_col.venueCD, row));
			
			appletDiv_set({"src":$("#appSrc").val()+"&initAction=Search", "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
			appletOpen();
	    }
	}
</script>