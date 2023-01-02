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
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM08001B" />
								<input type="hidden" id="appSrc_upload" name="appSrc_upload" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM08001C" />
								<input type="hidden" id="appSrc_upload_del" name="appSrc_upload_del" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM08001D" />
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
														<td class="td-cond">
															<fmt:message key="MDM08001A.regDate" />
														</td>
														<td class="td-input">
															<nis:calendar id="regDate" value="${params.currentDate}"/> 
													    </td>
														<td class="td-cond"><fmt:message key="MDM02001A.venueCD"/>
														</td>
														<td class="td-input">
															<input type="text" id="venueCD" name="venueCD" style="width:120px;">
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
														<td class="td-input" >
															<nis:selectbox id="activeYN" name="activeYN" defaultText="all" category="ACTIVEYN" />
														</td>
														<td class="td-cond"><fmt:message key="MDM02001A.territoryCD"/>
														</td>
														<td class="td-input">
															<nis:popup id="territory" nameID="territoryCDName" keyID="territoryCD" value="${params.territoryCD}" />
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
		                		<iframe src="" id="downloadFrame" name="downloadFrame_insert" style="width:0px;height:0px;"></iframe>
		                		<iframe src="" id="downloadFrame" name="downloadFrame_delete" style="width:0px;height:0px;"></iframe>
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
    .aw-grid-header {text-align: center; border-right: 1px solid #aca899!important; background: #F3F4F6}
	.aw-row-selector {text-align: center}
	
    #grid .aw-column-0 {width: 120px; text-align:center;}
    #grid .aw-column-1 {width: 125px; text-align:center;}
    #grid .aw-column-2 {width: 90px; text-align:center;}
    #grid .aw-column-3 {width: 100px; text-align:center;}
    #grid .aw-column-4 {width: 60px; text-align:center;}
    #grid .aw-column-5 {width: 120px; text-align:center;}
    #grid .aw-column-6 {width: 100px; text-align:center;}
    #grid .aw-column-7 {width: 100px; text-align:center;}
    #grid .aw-column-8 {width: 100px; text-align:left;}
    #grid .aw-column-9 {width: 100px; text-align:left;}
    #grid .aw-column-10 {width: 110px; text-align:left;}
    #grid .aw-column-11 {width: 100px; text-align:left;}
    #grid .aw-column-12 {width: 80px; text-align:center;}
    #grid .aw-column-13 {width: 80px; text-align:center;}
    #grid .aw-column-14 {width: 100px; text-align:center;}
    #grid .aw-column-15 {width: 100px; text-align:center;}
    #grid .aw-column-16 {width: 110px; text-align:center;}
    #grid .aw-column-17 {width: 100px; text-align:center;}
    #grid .aw-column-18 {width: 50px; text-align:center;}
    #grid .aw-column-19 {width: 100px; text-align:center;}
    #grid .aw-column-20 {width: 100px; text-align:center;}
    #grid .aw-column-21 {width: 80px; text-align:center;}
    #grid .aw-column-22 {width: 80px; text-align:center;}
    #grid .aw-column-23 {width: 80px; text-align:center;}
    #grid .aw-column-24 {width: 100px; text-align:center;}
    #grid .aw-column-25 {width: 100px; text-align:left;}
    #grid .aw-column-26 {width: 100px; text-align:left;}
    #grid .aw-column-27 {width: 110px; text-align:center;}
    #grid .aw-column-28 {width: 100px; text-align:center;}
    #grid .aw-column-29 {width: 100px; text-align:left;}
    #grid .aw-column-30 {width: 100px; text-align:center;}
    #grid .aw-column-31 {width: 100px; text-align:center;}
    #grid .aw-column-32 {width: 100px; text-align:left;}
    #grid .aw-column-33 {width: 100px; text-align:center;}
    #grid .aw-column-34 {width: 100px; text-align:center;}
    #grid .aw-column-35 {width: 100px; text-align:center;}
    #grid .aw-column-36 {width: 100px; text-align:center;}
    #grid .aw-column-37 {width: 100px; text-align:center;}
    #grid .aw-column-38 {width: 100px; text-align:center;}
    #grid .aw-column-39 {width: 100px; text-align:center;}
    #grid .aw-column-40 {width: 100px; text-align:center;}
    #grid .aw-column-41 {width: 100px; text-align:center;}
    #grid .aw-column-42 {width: 100px; text-align:center;}
    #grid .aw-column-43 {width: 100px; text-align:center;}
    #grid .aw-column-44 {width: 100px; text-align:center;}
	
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
		
		window.onload = function() {
			
			$("#grid_displayNum").val("100");
			createGrid();
			grid.refresh();
			
			if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD").val("${params.dkmdTpCD}");
				$("#dkmdTpCD").attr("disabled", true);
				$("#dkmdTpCD").addClass("input-readonly");
			}
			
			getTerritoryName("territory", "territoryCD", "territoryCDName");
		};
		
		${initScript}
		
		$("#regDate").keypress(function(){
			if (event.keyCode == 13){
				Search();
			}
		});
		
		$("#venueCD").keypress(function(){
			if (event.keyCode == 13){
				Search();
			}
		});
		
		$("#venueNm").keypress(function(){
			if (event.keyCode == 13){
				Search();
			}
		});
		
		$("#territory").keypress(function(){
			if (event.keyCode == 13){
				getTerritoryName("territory", "territoryCD", "territoryCDName");
			}
		});
		
		$("#territory_popup").click(function(){
			openTerritoryPopup("closeTerritoryPopup");
		});
	
	});
	
	//Territory 팝업 close
	function closeTerritoryPopup(data) {
		$("#territory").val(data.territoryCD);
		$("#territoryCD").val(data.territoryCD);
        $("#territoryCDName").val(data.territoryCDName);
	}
	
	//신규
// 	function New() {
// 		$("#selectVenueCD").val("");
		
// 		appletDiv_set({"src":$("#appSrc").val()+"&initAction=New", "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
// 		appletOpen();
// 	}
	
	//조회
	function Search() {
		$("#grid_pageNum").val("1");
		PagingSearch();
	}
	
	
	function PagingSearch() {
		var data = new Array();
	 	var rowCount = 0;
	 	var beginRowNum = 0;
		var endRowNum = 0;
		var table = new AW.XML.Table;
		
		table.setURL("${contextPath}/service/simpleAction/MDM0800101S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
	  									"sellingAreaID;customerID;refNo;venueCD;country;"+
	  									"territoryCDNm;rageSphereCDNm;teamCDNm;repNm;repNm_KR;"+
										"customerNm;sellingAreaNm;legalCDNm;channelCDNm;subChannelCDNm;"+
										"segmentCDNm;subSegmentCDNm;reserveSegmentCDNm;kegYNNm;ageingCDNm;"+
										"siteCDNm;venueGradCDNm;addrTpCD1Nm;addrTpCD2Nm;addrTpCD3Nm;"+
										"oldAddr2;newAddr1;postCD;phoneNo;fasciaNm;"+
										"legacyFrontOfficeAccountNo;legacyBackOfficeAccountNo;ws1SapCDNm;ws2SapCDNm;ws3SapCDNm;"+
										"ws4SapCDNm;license;activeYNNm;createDate;sellingAreaCreatedDate;"+
										"lastModifiedDate;sellingAreaLastModifiedDate;lastModifiedBy;venueDivCDNm;rowNum;"  	
	  					  );
	  	table.setParameter("format",
	  								"str;str;str;str;str;"+
	  								"str;str;str;str;str;"+
	  								"str;str;str;str;str;"+
	  								"str;str;str;str;str;"+
	  								"str;str;str;str;str;"+
	  								"str;str;str;str;str;"+
	  								"str;str;str;str;str;"+
	  								"str;str;str;str;str;"+
	  								"str;str;str;str;str;"
	  						);
		table.setParameter("regDate", convertDate($("#regDate").val()));
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
      	
      	rowCount = table.getCount();
     	
      	if (rowCount > 0) {
      		for (i = 0; i < rowCount; i++) {
      			data[i] = [
      			    table.getData(_col.sellingAreaID, i)
					, table.getData(_col.customerID, i)
					, table.getData(_col.refNo, i)
					, table.getData(_col.venueCD, i)
					, table.getData(_col.country, i)
					, table.getData(_col.territoryCDNm, i)
					, table.getData(_col.rageSphereCDNm, i)
					, table.getData(_col.teamCDNm, i)
					, table.getData(_col.repNm, i)
					, table.getData(_col.repNm_KR, i)
					, table.getData(_col.customerNm, i)
					, table.getData(_col.sellingAreaNm, i)
					, table.getData(_col.legalCDNm, i)
					, table.getData(_col.channelCDNm, i)
					, table.getData(_col.subChannelCDNm, i)
					, table.getData(_col.segmentCDNm, i)
					, table.getData(_col.subSegmentCDNm, i)
					, table.getData(_col.reserveSegmentCDNm, i)
					, table.getData(_col.kegYNNm, i)
					, table.getData(_col.ageingCDNm, i)
					, table.getData(_col.siteCDNm, i)
					, table.getData(_col.venueGradCDNm, i)
					, table.getData(_col.addrTpCD1Nm, i)
					, table.getData(_col.addrTpCD2Nm, i)
					, table.getData(_col.addrTpCD3Nm, i)
					, table.getData(_col.oldAddr2, i)
					, table.getData(_col.newAddr1, i)
					, table.getData(_col.postCD, i)
					, table.getData(_col.phoneNo, i)
					, table.getData(_col.fasciaNm, i)
					, table.getData(_col.legacyFrontOfficeAccountNo, i)
					, table.getData(_col.legacyBackOfficeAccountNo, i)
					, table.getData(_col.ws1SapCDNm, i)
					, table.getData(_col.ws2SapCDNm, i)
					, table.getData(_col.ws3SapCDNm, i)
					, table.getData(_col.ws4SapCDNm, i)
					, table.getData(_col.license, i)
					, table.getData(_col.activeYNNm, i)
					, table.getData(_col.createDate, i)
					, table.getData(_col.sellingAreaCreatedDate, i)
					, table.getData(_col.lastModifiedDate, i)
					, table.getData(_col.sellingAreaLastModifiedDate, i)
					, table.getData(_col.lastModifiedBy, i)
					, table.getData(_col.venueDivCDNm, i)
      			];
      		}
			grid.setCellData(data);
			grid.setRowCount(rowCount);

			//totalCount
			beginRowNum = table.getData(_col.rowNum,0);
			endRowNum = table.getData(_col.rowNum,rowCount-1);
			
			table.setURL("${contextPath}/service/simpleAction/MDM0800103S");
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
	
	//입력용 파일받기(업소)
	function DownloadToInput_venueMerge() {
        form.action = "${contextPath}/service/mdm08/downloadFile_merge";
        form.target = "downloadFrame_insert";
        form.submit();
    }
	
	//입력용 파일받기(업소 삭제)
	function DownloadToInput_venueDelete() {
		form.action = "${contextPath}/service/mdm08/downloadFile_delete";
        form.target = "downloadFrame_delete";
        form.submit();
	}
	
	//엑셀 업로드
	function ExcelUploadNewVenueInsert() {
		appletDiv_set({"src":$("#appSrc_upload").val(), "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
		appletOpen();
	}
	
	//엑셀 업로드(업소삭제)
	function ExcelUploadNewVenueDelete() {
		appletDiv_set({"src":$("#appSrc_upload_del").val(), "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
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
		table.setParameter("queryKey", "MDM0800109S");
		table.setParameter("regDate", convertDate($("#regDate").val()));		
		table.setParameter("dkmdTpCD", $("#dkmdTpCD").val());
	  	table.setParameter("venueCD", $("#venueCD").val());
	  	table.setParameter("venueNm", $("#venueNm").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD").val());
	  	table.setParameter("activeYN", $("#activeYN").val());
	  	table.setParameter("territoryCD", $("#territoryCD").val());
	  	
		var headerText = [
							"<fmt:message key="MDM08001A.sellingAreaID"/>"
							,"<fmt:message key="MDM08001A.customerID"/>"
							,"<fmt:message key="MDM08001A.refNo"/>"
							,"<fmt:message key="MDM08001A.venueCD"/>"
							,"<fmt:message key="MDM08001A.country"/>"
							,"<fmt:message key="MDM08001A.territoryCD"/>"
							,"<fmt:message key="MDM08001A.rageSphereCD"/>"
							,"<fmt:message key="MDM08001A.teamCD"/>"
							,"<fmt:message key="MDM08001A.repNm"/>"
							,"<fmt:message key="MDM08001A.repNm_KR"/>"
							,"<fmt:message key="MDM08001A.customerNm"/>"
							,"<fmt:message key="MDM08001A.sellingAreaNm"/>"
							,"<fmt:message key="MDM08001A.legal"/>"
							,"<fmt:message key="MDM08001A.channelCD"/>"
							,"<fmt:message key="MDM08001A.subChannelCD"/>"
							,"<fmt:message key="MDM08001A.segmentCD"/>"
							,"<fmt:message key="MDM08001A.subSegmentCD"/>"
							,"<fmt:message key="MDM08001A.reserveSegmentCD"/>"
							,"<fmt:message key="MDM08001A.kegYN"/>"
							,"<fmt:message key="MDM08001A.ageingCD"/>"
							,"<fmt:message key="MDM08001A.siteCD"/>"
							,"<fmt:message key="MDM08001A.venueGradCD"/>"
							,"<fmt:message key="MDM08001A.addrTpCD1"/>"
							,"<fmt:message key="MDM08001A.addrTpCD2"/>"
							,"<fmt:message key="MDM08001A.addrTpCD3"/>"
							,"<fmt:message key="MDM08001A.addrTpCD4"/>"
							,"<fmt:message key="MDM08001A.addrTpCD5"/>"
							,"<fmt:message key="MDM08001A.postalCD"/>"
							,"<fmt:message key="MDM08001A.phoneNo"/>"
							,"<fmt:message key="MDM08001A.fasciaCD"/>"
							,"<fmt:message key="MDM08001A.legacyFrontOfficeAccountNo"/>"
							,"<fmt:message key="MDM08001A.legacyBackOfficeAccountNo"/>"
							,"<fmt:message key="MDM08001A.draught"/>"
							,"<fmt:message key="MDM08001A.spirits"/>"
							,"<fmt:message key="MDM08001A.wine"/>"
							,"<fmt:message key="MDM08001A.packaged"/>"
							,"<fmt:message key="MDM08001A.license"/>"
							,"<fmt:message key="MDM08001A.activeYN"/>"
							,"<fmt:message key="MDM08001A.createDate"/>"
							,"<fmt:message key="MDM08001A.sellingAreaCreatedDt"/>"
							,"<fmt:message key="MDM08001A.lastModifiedDt"/>"
							,"<fmt:message key="MDM08001A.sellingAreaLastModifiedDt"/>"
							,"<fmt:message key="MDM08001A.lastModifiedBy"/>"
							,"<fmt:message key="MDM08001A.venueDivCD"/>"
		];
		
		table.setParameter("templateFile", "MDM08001A");
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
	
	//동기화
	function Synchronize() {
		
		showLoading();
		
		if (!confirm("<fmt:message key="MDM08001A.msg1"/>")) {
			hideLoading();
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mdm08/venueSynchronize");
		table.setAsync(false); 
		table.setRequestMethod("POST");
	  	table.setParameter("userID", "${params.empID}");
	  	table.setParameter("regDate", convertDate($("#regDate").val()));
	  	table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("venueNm", $("#venueNm").val());
		table.setParameter("venueGradCD", $("#venueGradCD").val());
		table.setParameter("activeYN", $("#activeYN").val());
		table.setParameter("territoryCD", $("#territoryCD").val());
	  	
		table.request();

		if (table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		} else {
			alert(table.getData(1,0));
		}
		
		hideLoading();
	}
	
	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var _i = 0;
	
	var _col = {
		sellingAreaID                 : _i++
		, customerID                  : _i++
		, refNo                       : _i++
		, venueCD                     : _i++
		, country                     : _i++
		, territoryCDNm               : _i++
		, rageSphereCDNm              : _i++
		, teamCDNm                    : _i++
		, repNm                       : _i++
		, repNm_KR                    : _i++
		, customerNm                  : _i++
		, sellingAreaNm               : _i++
		, legalCDNm                	  : _i++
		, channelCDNm                 : _i++
		, subChannelCDNm              : _i++
		, segmentCDNm                 : _i++
		, subSegmentCDNm              : _i++
		, reserveSegmentCDNm          : _i++
		, kegYNNm                     : _i++
		, ageingCDNm                  : _i++
		, siteCDNm                    : _i++
		, venueGradCDNm               : _i++
		, addrTpCD1Nm                 : _i++
		, addrTpCD2Nm                 : _i++
		, addrTpCD3Nm                 : _i++
		, oldAddr2                    : _i++
		, newAddr1                    : _i++
		, postCD 	                  : _i++
		, phoneNo                     : _i++
		, fasciaNm                    : _i++
		, legacyFrontOfficeAccountNo  : _i++
		, legacyBackOfficeAccountNo   : _i++
		, ws1SapCDNm            	  : _i++
		, ws2SapCDNm                  : _i++
		, ws3SapCDNm                  : _i++
		, ws4SapCDNm                  : _i++
		, license                     : _i++
		, activeYNNm                  : _i++
		, createDate                  : _i++
		, sellingAreaCreatedDate      : _i++
		, lastModifiedDate            : _i++
		, sellingAreaLastModifiedDate : _i++
		, lastModifiedBy   			  : _i++
		, venueDivCDNm   			  : _i++
		, rowNum 					  : _i++
	};
	
	var columns = [
	       		"<fmt:message key="MDM08001A.sellingAreaID"/>"
	       		,"<fmt:message key="MDM08001A.customerID"/>"
	       		,"<fmt:message key="MDM08001A.refNo"/>"
	       		,"<fmt:message key="MDM08001A.venueCD"/>"
	       		,"<fmt:message key="MDM08001A.country"/>"
	       		,"<fmt:message key="MDM08001A.territoryCD"/>"
	       		,"<fmt:message key="MDM08001A.rageSphereCD"/>"
	       		,"<fmt:message key="MDM08001A.teamCD"/>"
	       		,"<fmt:message key="MDM08001A.repNm"/>"
	       		,"<fmt:message key="MDM08001A.repNm_KR"/>"
	       		,"<fmt:message key="MDM08001A.customerNm"/>"
	       		,"<fmt:message key="MDM08001A.sellingAreaNm"/>"
	       		,"<fmt:message key="MDM08001A.legal"/>"
	       		,"<fmt:message key="MDM08001A.channelCD"/>"
	       		,"<fmt:message key="MDM08001A.subChannelCD"/>"
	       		,"<fmt:message key="MDM08001A.segmentCD"/>"
	       		,"<fmt:message key="MDM08001A.subSegmentCD"/>"
	       		,"<fmt:message key="MDM08001A.reserveSegmentCD"/>"
	       		,"<fmt:message key="MDM08001A.kegYN"/>"
	       		,"<fmt:message key="MDM08001A.ageingCD"/>"
	       		,"<fmt:message key="MDM08001A.siteCD"/>"
	       		,"<fmt:message key="MDM08001A.venueGradCD"/>"
	       		,"<fmt:message key="MDM08001A.addrTpCD1"/>"
	       		,"<fmt:message key="MDM08001A.addrTpCD2"/>"
	       		,"<fmt:message key="MDM08001A.addrTpCD3"/>"
	       		,"<fmt:message key="MDM08001A.addrTpCD5"/>"
	       		,"<fmt:message key="MDM08001A.addrTpCD4"/>"
	       		,"<fmt:message key="MDM08001A.postalCD"/>"
	       		,"<fmt:message key="MDM08001A.phoneNo"/>"
	       		,"<fmt:message key="MDM08001A.fasciaCD"/>"
	       		,"<fmt:message key="MDM08001A.legacyFrontOfficeAccountNo"/>"
	       		,"<fmt:message key="MDM08001A.legacyBackOfficeAccountNo"/>"
	       		,"<fmt:message key="MDM08001A.draught"/>"
	       		,"<fmt:message key="MDM08001A.spirits"/>"
	       		,"<fmt:message key="MDM08001A.wine"/>"
	       		,"<fmt:message key="MDM08001A.packaged"/>"
	       		,"<fmt:message key="MDM08001A.license"/>"
	       		,"<fmt:message key="MDM08001A.activeYN"/>"
	       		,"<fmt:message key="MDM08001A.createDate"/>"
	       		,"<fmt:message key="MDM08001A.sellingAreaCreatedDt"/>"
	       		,"<fmt:message key="MDM08001A.lastModifiedDt"/>"
	       		,"<fmt:message key="MDM08001A.sellingAreaLastModifiedDt"/>"
	       		,"<fmt:message key="MDM08001A.lastModifiedBy"/>"
	       		,"<fmt:message key="MDM08001A.venueDivCD"/>"
	       	];
	       	
	var grid = null;
       	
  	function createGrid() {
 		//grid = new AW.Grid.Extended;
 		grid = new AW.UI.Grid;
 	    grid.setId("grid");
 	    grid.setCellFormat([  str, str, str, str, str
 	              			, str, str, str, str, str
 	              			, str, str, str, str, str
 	              			, str, str, str, str, str
 	              			, str, str, str, str, str
 	              			, str, str, str, str, str
 	              			, str, str, str, str, str
 	              			, str, str, str, str, str
 	              			, str, str, str, str, str
 	              	    ]); 
 	    for (var i = 0; i < columns.length; i++) {
 	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
 	    }
 	    grid.setHeaderText(columns);
 	    grid.setRowCount(0);
 	    grid.setColumnCount(columns.length);
 	    grid.setSelectorVisible(false);
 		grid.setSelectionMode("single-row");
 		
 		grid.setCellEditable(false);

//  		grid.onRowDoubleClicked = function(event, row) {
//  			$("#selectVenueCD").val(this.getCellText(_col.venueCD, row));

//  			appletDiv_set({ "src" : $("#appSrc").val() + "&initAction=Search","appPositionCD" : "${params.appPositionCD}","appDisRate" : "${params.appDisRate}","appDisUnitCD" : "${params.appDisUnitCD}"});
//  			appletOpen();
//  		}
     }
</script>