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
		<form name="form" id="form" method="post" enctype="multipart/form-data">
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
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="uploadFile"/>
												</td>
												<td class="td-input">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
					                           			<tr>
					                               			<td height="25" width="310">
					                                   			<div id="selectedFileDisplay">
					                                       			 <input type="text" id="progressReport" value="" style="width:300px;float: left; display: inline-block;" class="file_input_textbox" readonly="readonly" >
					                                   			</div>
					                               			</td>
					                               			<td width="75"> 
					                                   			<div id="uploaderContainer" class="file_input_div">
                                                             		<input type="button" class="file_input_button" />
                                                             		<input type="file" name="fileuploader" id="fileuploader" class="file_input_hidden">                                
					                                   			</div>
					                               			</td>
					                               			<td width="*">
					                                   			<div id="uploadFilesLink">
					                                   				<a id="uploadLink" onclick="upload(); return false;" href="#">
					                                   					<img src="${themeURL}/images/btn/upload.png">
					                                   				</a>
					                                   			</div>
					                               			</td>
					                           			</tr>
					                       			</table>
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

    #grid .aw-column-0 {width: 120px; text-align:center;}
    #grid .aw-column-1 {width: 120px; text-align:center;}
    #grid .aw-column-2 {width: 100px; text-align:center;}
    #grid .aw-column-3 {width: 100px; text-align:center;}
    #grid .aw-column-4 {width: 100px; text-align:center;}
    #grid .aw-column-5 {width: 150px; text-align:left;}
    #grid .aw-column-6 {width: 150px; text-align:left;}
    #grid .aw-column-7 {width: 150px; text-align:left;}
    #grid .aw-column-8 {width: 100px; text-align:center;}
    #grid .aw-column-9 {width: 100px; text-align:center;}
    #grid .aw-column-10 {width: 110px; text-align:left;}
    #grid .aw-column-11 {width: 180px; text-align:left;}
    #grid .aw-column-12 {width: 100px; text-align:center;}
    #grid .aw-column-13 {width: 100px; text-align:center;}
    #grid .aw-column-14 {width: 100px; text-align:center;}
    #grid .aw-column-15 {width: 100px; text-align:center;}
    #grid .aw-column-16 {width: 100px; text-align:center;}
    #grid .aw-column-17 {width: 100px; text-align:center;}
    #grid .aw-column-18 {width: 100px; text-align:center;}
    #grid .aw-column-19 {width: 100px; text-align:center;}
    #grid .aw-column-20 {width: 100px; text-align:center;}
    #grid .aw-column-21 {width: 100px; text-align:center;}
    #grid .aw-column-22 {width: 100px; text-align:left;}
    #grid .aw-column-23 {width: 100px; text-align:left;}
    #grid .aw-column-24 {width: 100px; text-align:left;}
    #grid .aw-column-25 {width: 100px; text-align:left;}
    #grid .aw-column-26 {width: 160px; text-align:left;}
    #grid .aw-column-27 {width: 100px; text-align:center;}
    #grid .aw-column-28 {width: 100px; text-align:center;}
    #grid .aw-column-29 {width: 100px; text-align:center;}
    #grid .aw-column-30 {width: 180px; text-align:center;}
    #grid .aw-column-31 {width: 180px; text-align:center;}
    #grid .aw-column-32 {width: 100px; text-align:left;}
    #grid .aw-column-33 {width: 100px; text-align:left;}
    #grid .aw-column-34 {width: 100px; text-align:left;}
    #grid .aw-column-35 {width: 100px; text-align:left;}
    #grid .aw-column-36 {width: 100px; text-align:center;}
    #grid .aw-column-37 {width: 100px; text-align:center;}
    #grid .aw-column-38 {width: 150px; text-align:center;}
    #grid .aw-column-39 {width: 150px; text-align:center;}
    #grid .aw-column-40 {width: 150px; text-align:center;}
    #grid .aw-column-41 {width: 180px; text-align:center;}
    #grid .aw-column-42 {width: 100px; text-align:center;}
    #grid .aw-column-43 {width: 100px; text-align:center;}
    #grid .aw-column-44 {width: 100px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	$(function() {
		
		window.onload = function() {
			createGrid();
			grid.refresh();
		};
		
		${initScript}
	});
	
	function SetGridData(xmlData) {
		var data = new Array();
		var rowCount = 0;

		createGrid();
		
		$(xmlData).find("rows").each(function(i) {
			$(this).children().each(function(j) {
				data[j] = [
						$(this).find("sellingAreaID").text()
						, $(this).find("customerID").text()
						, $(this).find("refNo").text()
						, $(this).find("venueCD").text()
						, $(this).find("country").text()
						, $(this).find("territoryCDName").text()
						, $(this).find("rageSphereCDName").text()
						, $(this).find("teamCDName").text()
						, $(this).find("repNm").text()
						, $(this).find("repNm_KR").text()
						
						, $(this).find("customerNm").text()
						, $(this).find("sellingAreaNm").text()
						, $(this).find("legalCDName").text()
						, $(this).find("channelCDName").text()
						, $(this).find("subChannelCDName").text()
						, $(this).find("segmentCDName").text()
						, $(this).find("subSegmentCDName").text()
						, $(this).find("reserveSegmentCDName").text()
						, $(this).find("kegYNName").text()
						, $(this).find("ageingCDName").text()
						
						, $(this).find("siteCDName").text()
						, $(this).find("venueGradCDName").text()
						, $(this).find("addrTpCD1Name").text()
						, $(this).find("addrTpCD2Name").text()
						, $(this).find("addrTpCD3Name").text()
						, $(this).find("oldAddr2").text()
						, $(this).find("newAddr1").text()
						, $(this).find("postCD").text()
						, $(this).find("phoneNo").text()
						, $(this).find("fasciaCDName").text()
						
						, $(this).find("legacyFrontOfficeAccountNo").text()
						, $(this).find("legacyBackOfficeAccountNo").text()
						, $(this).find("ws1SapCDName").text()
						, $(this).find("ws2SapCDName").text()
						, $(this).find("ws3SapCDName").text()
						, $(this).find("ws4SapCDName").text()
						, $(this).find("license").text()
						, $(this).find("activeYNName").text()
						, $(this).find("createDate").text()
						, $(this).find("sellingAreaCreatedDate").text()
						
						, $(this).find("lastModifiedDate").text()
						, $(this).find("sellingAreaLastModifiedDate").text()
						, $(this).find("lastModifiedBy").text()
						, $(this).find("venueDivCDName").text()
						, $(this).find("territoryCD").text()
						, $(this).find("rageSphereCD").text()
						, $(this).find("teamCD").text()
						, $(this).find("legalCD").text()
						, $(this).find("channelCD").text()
						, $(this).find("subChannelCD").text()
						, $(this).find("segmentCD").text()
						
						, $(this).find("subSegmentCD").text()
						, $(this).find("reserveSegmentCD").text()
						, $(this).find("kegYN").text()
						, $(this).find("ageingCD").text()
						, $(this).find("siteCD").text()
						, $(this).find("venueGradCD").text()
						, $(this).find("addrTpCD1").text()
						, $(this).find("addrTpCD2").text()
						, $(this).find("addrTpCD3").text()
						, $(this).find("fasciaCD").text()
						
						, $(this).find("ws1SapCD").text()
						, $(this).find("ws2SapCD").text()
						, $(this).find("ws3SapCD").text()
						, $(this).find("ws4SapCD").text()
						, $(this).find("activeYN").text()
						, $(this).find("newAddr2").text()
						, $(this).find("ws1CD").text()
						, $(this).find("ws2CD").text()
						, $(this).find("ws3CD").text()
						, $(this).find("ws4CD").text()
						, $(this).find("venueDivCD").text()
							
				];
				rowCount++;
			});
		});
		grid.setCellData(data);
		grid.setRowCount(rowCount);
		grid.refresh();
		
		hideLoading();
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	
	function Save() {
		var index = grid.getRowIndices();
		
		if (grid.getRowCount() == 0) {
			alert("<fmt:message key="msg.upload"/>");
			return;
		}
		
		if (index == '') {
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		for (var i = 0; i < index.length; i++) {

			if (grid.getCellText(_col.sellingAreaID, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg1" />"); 
 				setCellFocus(grid, _col.sellingAreaID, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.customerID, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg2" />"); 
 				setCellFocus(grid, _col.customerID, i); 
 				return;
 			}
			
			
			if (grid.getCellText(_col.refNo, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg3" />"); 
 				setCellFocus(grid, _col.refNo, i); 
 				return;
 			}
			
			
			if (grid.getCellText(_col.venueCD, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg4" />"); 
 				setCellFocus(grid, _col.venueCD, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.country, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg5" />"); 
 				setCellFocus(grid, _col.country, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.territoryCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg6" />"); 
 				setCellFocus(grid, _col.territoryCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.rageSphereCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg7" />"); 
 				setCellFocus(grid, _col.rageSphereCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.teamCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg8" />"); 
 				setCellFocus(grid, _col.teamCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.repNm, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg9" />"); 
 				setCellFocus(grid, _col.repNm, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.repNm_KR, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg10" />"); 
 				setCellFocus(grid, _col.repNm_KR, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.customerNm, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg11" />"); 
 				setCellFocus(grid, _col.customerNm, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.sellingAreaNm, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg12" />"); 
 				setCellFocus(grid, _col.sellingAreaNm, i); 
 				return;
 			}
			
// 			if (grid.getCellText(_col.legalCDName, i) == "") {
//  				alert("<fmt:message key="MDM08001C.msg13" />"); 
//  				setCellFocus(grid, _col.legalCDName, i); 
//  				return;
//  			}
			
			if (grid.getCellText(_col.channelCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg14" />"); 
 				setCellFocus(grid, _col.channelCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.subChannelCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg15" />"); 
 				setCellFocus(grid, _col.subChannelCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.segmentCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg16" />"); 
 				setCellFocus(grid, _col.segmentCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.subSegmentCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg17" />"); 
 				setCellFocus(grid, _col.subSegmentCDName, i); 
 				return;
 			}
			
// 			if (grid.getCellText(_col.reserveSegmentCDName, i) == "") {
//  				alert("<fmt:message key="MDM08001C.msg18" />"); 
//  				setCellFocus(grid, _col.reserveSegmentCDName, i); 
//  				return;
//  			}
			
			if (grid.getCellText(_col.ageingCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg19" />"); 
 				setCellFocus(grid, _col.ageingCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.siteCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg20" />"); 
 				setCellFocus(grid, _col.siteCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.venueGradCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg21" />"); 
 				setCellFocus(grid, _col.venueGradCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.addrTpCD1Name, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg22" />"); 
 				setCellFocus(grid, _col.addrTpCD1Name, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.addrTpCD2Name, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg22" />"); 
 				setCellFocus(grid, _col.addrTpCD2Name, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.addrTpCD3Name, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg22" />"); 
 				setCellFocus(grid, _col.addrTpCD3Name, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.postCD, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg22" />"); 
 				setCellFocus(grid, _col.postCD, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.fasciaCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg23" />"); 
 				setCellFocus(grid, _col.fasciaCDName, i); 
 				return;
 			}
			
// 			if (grid.getCellText(_col.legacyFrontOfficeAccountNo, i) == "") {
//  				alert("<fmt:message key="MDM08001C.msg24" />"); 
//  				setCellFocus(grid, _col.legacyFrontOfficeAccountNo, i); 
//  				return;
//  			}
			
			
// 			if (grid.getCellText(_col.legacyBackOfficeAccountNo, i) == "") {
//  				alert("<fmt:message key="MDM08001C.msg25" />"); 
//  				setCellFocus(grid, _col.legacyBackOfficeAccountNo, i); 
//  				return;
//  			}
			
			if (grid.getCellText(_col.ws1SapCDName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg26" />"); 
 				setCellFocus(grid, _col.ws1SapCDName, i); 
 				return;
 			}
			
// 			if (grid.getCellText(_col.license, i) == "") {
//  				alert("<fmt:message key="MDM08001C.msg27" />"); 
//  				setCellFocus(grid, _col.license, i); 
//  				return;
//  			}
			
			if (grid.getCellText(_col.activeYNName, i) == "") {
 				alert("<fmt:message key="MDM08001C.msg28" />"); 
 				setCellFocus(grid, _col.activeYNName, i); 
 				return;
 			}
			
// 			if (grid.getCellText(_col.sellingAreaCreatedDate, i) == "") {
//  				alert("<fmt:message key="MDM08001C.msg29" />"); 
//  				setCellFocus(grid, _col.sellingAreaCreatedDate, i); 
//  				return;
//  			}
			
// 			if (grid.getCellText(_col.lastModifiedDate, i) == "") {
//  				alert("<fmt:message key="MDM08001C.msg30" />"); 
//  				setCellFocus(grid, _col.lastModifiedDate, i); 
//  				return;
//  			}
			
// 			if (grid.getCellText(_col.sellingAreaLastModifiedDate, i) == "") {
//  				alert("<fmt:message key="MDM08001C.msg31" />"); 
//  				setCellFocus(grid, _col.sellingAreaLastModifiedDate, i); 
//  				return;
//  			}
			
			
// 			if (grid.getCellText(_col.lastModifiedBy, i) == "") {
//  				alert("<fmt:message key="MDM08001C.msg32" />"); 
//  				setCellFocus(grid, _col.lastModifiedBy, i); 
//  				return;
//  			}
			
		
		}

		//showLoading();
		var sellingAreaIDs               = new Array();
		var customerIDs                  = new Array();
		var refNos                       = new Array();
		var venueCDs                     = new Array();
		var countrys                     = new Array();
		var territoryCDs                 = new Array();
		var rageSphereCDs                = new Array();
		var teamCDs                      = new Array();
		var repNms                       = new Array();
		var repNm_KRs                    = new Array();
		
		var customerNms                  = new Array();
		var sellingAreaNms               = new Array();
		var legalCDs                     = new Array();
		var channelCDs                   = new Array();
		var subChannelCDs                = new Array();
		var segmentCDs                   = new Array();
		var subSegmentCDs                = new Array();
		var reserveSegmentCDs            = new Array();
		var kegYNs                       = new Array();
		var ageingCDs                    = new Array();
		
		var siteCDs                      = new Array();
		var venueGradCDs                 = new Array();
		var addrTpCD1s                   = new Array();
		var addrTpCD2s                   = new Array();
		var addrTpCD3s                   = new Array();
		var oldAddr2s                    = new Array();
		var newAddr1s                    = new Array();
		var postCDs                      = new Array();
		var phoneNos                     = new Array();
		var fasciaCDs                    = new Array();
		
		var legacyFrontOfficeAccountNos  = new Array();
		var legacyBackOfficeAccountNos   = new Array();
		var ws1SapCDs                    = new Array();
		var ws2SapCDs                    = new Array();
		var ws3SapCDs                    = new Array();
		var ws4SapCDs                    = new Array();
		var licenses                     = new Array();
		var activeYNs                    = new Array();
		var createDates                  = new Array();
		var sellingAreaCreatedDates      = new Array(); 
		
		var lastModifiedDates            = new Array();
		var sellingAreaLastModifiedDates = new Array();
		var lastModifiedBys              = new Array();
		var newAddr2s                    = new Array();
		var ws1CDs                       = new Array();
		var ws2CDs                       = new Array();
		var ws3CDs                       = new Array();
		var ws4CDs                       = new Array();
		var venueDivCDs                  = new Array();
		
		
		var count = 0;
	
		for (var i = 0; i < index.length; i++) {
			sellingAreaIDs[count]               = grid.getCellText(_col.sellingAreaID, index[i]);
			customerIDs[count]                  = grid.getCellText(_col.customerID, index[i]);
			refNos[count]                       = grid.getCellText(_col.refNo, index[i]);
			venueCDs[count]                     = grid.getCellText(_col.venueCD, index[i]);
			countrys[count]                     = grid.getCellText(_col.country, index[i]);
			territoryCDs[count]                 = grid.getCellText(_col.territoryCD, index[i]);
			rageSphereCDs[count]                = grid.getCellText(_col.rageSphereCD, index[i]);
			teamCDs[count]                      = grid.getCellText(_col.teamCD, index[i]);
			repNms[count]                       = grid.getCellText(_col.repNm, index[i]);
			repNm_KRs[count]                    = grid.getCellText(_col.repNm_KR, index[i]);
			
			customerNms[count]                  = grid.getCellText(_col.customerNm, index[i]);
			sellingAreaNms[count]               = grid.getCellText(_col.sellingAreaNm, index[i]);
			legalCDs[count]                  	= grid.getCellText(_col.legalCD, index[i]);
			channelCDs[count]                   = grid.getCellText(_col.channelCD, index[i]);
			subChannelCDs[count]                = grid.getCellText(_col.subChannelCD, index[i]);
			segmentCDs[count]                   = grid.getCellText(_col.segmentCD, index[i]);
			subSegmentCDs[count]                = grid.getCellText(_col.subSegmentCD, index[i]);
			reserveSegmentCDs[count]            = grid.getCellText(_col.reserveSegmentCD, index[i]);
			kegYNs[count]                       = grid.getCellText(_col.kegYN, index[i]);
			ageingCDs[count]                    = grid.getCellText(_col.ageingCD, index[i]);
			
			siteCDs[count]                      = grid.getCellText(_col.siteCD, index[i]);
			venueGradCDs[count]                 = grid.getCellText(_col.venueGradCD, index[i]);
			addrTpCD1s[count]                   = grid.getCellText(_col.addrTpCD1, index[i]);
			addrTpCD2s[count]                   = grid.getCellText(_col.addrTpCD2, index[i]);
			addrTpCD3s[count]                   = grid.getCellText(_col.addrTpCD3, index[i]);
			oldAddr2s[count]                   = grid.getCellText(_col.oldAddr2, index[i]);
			newAddr1s[count]                    = grid.getCellText(_col.newAddr1, index[i]);
			postCDs[count]                      = grid.getCellText(_col.postCD, index[i]);
			phoneNos[count]                     = grid.getCellText(_col.phoneNo, index[i]);
			fasciaCDs[count]                    = grid.getCellText(_col.fasciaCD, index[i]);
			
			legacyFrontOfficeAccountNos[count]  = grid.getCellText(_col.legacyFrontOfficeAccountNo, index[i]);
			legacyBackOfficeAccountNos[count]   = grid.getCellText(_col.legacyBackOfficeAccountNo, index[i]);
			ws1SapCDs[count]                     = grid.getCellText(_col.ws1SapCD, index[i]);
			ws2SapCDs[count]                     = grid.getCellText(_col.ws2SapCD, index[i]);
			ws3SapCDs[count]                        = grid.getCellText(_col.ws3SapCD, index[i]);
			ws4SapCDs[count]                    = grid.getCellText(_col.ws4SapCD, index[i]);
			licenses[count]                     = grid.getCellText(_col.license, index[i]);
			activeYNs[count]                    = grid.getCellText(_col.activeYN, index[i]);
			createDates[count]                  = unformat(grid.getCellText(_col.createDate, index[i]));
			sellingAreaCreatedDates[count]      = unformat(grid.getCellText(_col.sellingAreaCreatedDate, index[i]));
			
			lastModifiedDates[count]            = unformat(grid.getCellText(_col.lastModifiedDate, index[i]));
			sellingAreaLastModifiedDates[count] = unformat(grid.getCellText(_col.sellingAreaLastModifiedDate, index[i]));
			lastModifiedBys[count]              = grid.getCellText(_col.lastModifiedBy, index[i]);
			ws1CDs[count]                     = grid.getCellText(_col.ws1CD, index[i]);
			ws2CDs[count]                     = grid.getCellText(_col.ws2CD, index[i]);
			ws3CDs[count]                        = grid.getCellText(_col.ws3CD, index[i]);
			ws4CDs[count]                    = grid.getCellText(_col.ws4CD, index[i]);
			venueDivCDs[count]                    = grid.getCellText(_col.venueDivCD, index[i]);
			count++;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mdm08/saveTmpVenueGrid");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("sellingAreaIDs", sellingAreaIDs);
		table.setParameter("customerIDs", customerIDs);
		table.setParameter("refNos", refNos);
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("countrys", countrys);
		table.setParameter("territoryCDs", territoryCDs);
		table.setParameter("rageSphereCDs", rageSphereCDs);
		table.setParameter("teamCDs", teamCDs);
		table.setParameter("repNms", repNms);
		table.setParameter("repNm_KRs", repNm_KRs);
		
		table.setParameter("customerNms", customerNms);
		table.setParameter("sellingAreaNms", sellingAreaNms);
		table.setParameter("legalCDs", legalCDs);
		table.setParameter("channelCDs", channelCDs);
		table.setParameter("subChannelCDs", subChannelCDs);
		table.setParameter("segmentCDs", segmentCDs);
		table.setParameter("subSegmentCDs", subSegmentCDs);
		table.setParameter("reserveSegmentCDs", reserveSegmentCDs);
		table.setParameter("kegYNs", kegYNs);
		table.setParameter("ageingCDs", ageingCDs);
		
		table.setParameter("siteCDs", siteCDs);
		table.setParameter("venueGradCDs", venueGradCDs);
		table.setParameter("addrTpCD1s", addrTpCD1s);
		table.setParameter("addrTpCD2s", addrTpCD2s);
		table.setParameter("addrTpCD3s", addrTpCD3s);
		table.setParameter("oldAddr2s", oldAddr2s);
		table.setParameter("newAddr1s", newAddr1s);
		table.setParameter("postCDs", postCDs);
		table.setParameter("phoneNos", phoneNos);
		table.setParameter("fascias", fasciaCDs);
		
		table.setParameter("legacyFrontOfficeAccountNos", legacyFrontOfficeAccountNos);
		table.setParameter("legacyBackOfficeAccountNos", legacyBackOfficeAccountNos);
		table.setParameter("ws1SapCDs", ws1SapCDs);
		table.setParameter("ws2SapCDs", ws2SapCDs);
		table.setParameter("ws3SapCDs", ws3SapCDs);
		table.setParameter("ws4SapCDs", ws4SapCDs);
		table.setParameter("licenses", licenses);
		table.setParameter("activeYNs", activeYNs);
		table.setParameter("createDates", createDates);
		table.setParameter("sellingAreaCreatedDates", sellingAreaCreatedDates);
		
		table.setParameter("lastModifiedDates", lastModifiedDates);
		table.setParameter("sellingAreaLastModifiedDates", sellingAreaLastModifiedDates);
		table.setParameter("lastModifiedBys", lastModifiedBys);
		table.setParameter("ws1CDs", ws1CDs);
		table.setParameter("ws2CDs", ws2CDs);
		table.setParameter("ws3CDs", ws3CDs);
		table.setParameter("ws4CDs", ws4CDs);
		table.setParameter("venueDivCDs", venueDivCDs);
		table.request();
		
		if (table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			grid.clear();
			createGrid();
			grid.refresh();
			this.progressReport = document.getElementById("progressReport");
	        this.progressReport.value = "";
// 			parent.Search();
// 			parent.appletClose();
   		} else {
			alert(table.getData(1,0));
		}
		
		//hideLoading();
	}


	function List() {
		parent.Search();
		parent.appletClose();
	}
	
	function getRequestDate() {
		
	}
	
	function openAddrPopup_grid(finalAction, row) {
		window.name='mainwin';
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}"
				+ "&viewID=MDM05001D"
				+ "&finalAction=" + finalAction
				+ "&row=" + row;
		
		newWindow(url, "MDM05001D", 600, 350,"yes");
	}
	
	function closeWS1Popup_grid(data, row) {
		grid.setCellText(data.wsCD, _col.ws1CD, row);
		grid.setCellText(data.wsSapCD, _col.ws1SapCD, row);
		grid.setCellText(data.wsSapCDName, _col.ws1SapCDName, row);
	}

	function closeWS2Popup_grid(data, row) {
		grid.setCellText(data.wsCD, _col.ws2CD, row);
		grid.setCellText(data.wsSapCD, _col.ws2SapCD, row);
		grid.setCellText(data.wsSapCDName, _col.ws2SapCDName, row);
	}

	function closeWS3Popup_grid(data, row) {
		grid.setCellText(data.wsCD, _col.ws3CD, row);
		grid.setCellText(data.wsSapCD, _col.ws3SapCD, row);
		grid.setCellText(data.wsSapCDName, _col.ws3SapCDName, row);
	}

	function closeWS4Popup_grid(data, row) {
		grid.setCellText(data.wsCD, _col.ws4CD, row);
		grid.setCellText(data.wsSapCD, _col.ws4SapCD, row);
		grid.setCellText(data.wsSapCDName, _col.ws4SapCDName, row);
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var _i = 0;
	var _col = {
			sellingAreaID                 : _i++
			, customerID                  : _i++
			, refNo                       : _i++
			, venueCD                     : _i++
			, country                     : _i++
			, territoryCDName             : _i++
			, rageSphereCDName            : _i++
			, teamCDName                  : _i++
			, repNm                       : _i++
			, repNm_KR                    : _i++
			
			, customerNm                  : _i++
			, sellingAreaNm               : _i++
			, legalCDName                 : _i++
			, channelCDName               : _i++
			, subChannelCDName            : _i++
			, segmentCDName               : _i++
			, subSegmentCDName            : _i++
			, reserveSegmentCDName        : _i++
			, kegYNName                   : _i++
			, ageingCDName                : _i++
			
			, siteCDName                  : _i++
			, venueGradCDName             : _i++
			, addrTpCD1Name               : _i++
			, addrTpCD2Name               : _i++
			, addrTpCD3Name               : _i++
			, oldAddr2                    : _i++
			, newAddr1               	  : _i++
			, postCD                      : _i++
			, phoneNo                     : _i++
			, fasciaCDName                : _i++
			
			, legacyFrontOfficeAccountNo  : _i++
			, legacyBackOfficeAccountNo   : _i++
			, ws1SapCDName                : _i++
			, ws2SapCDName                : _i++
			, ws3SapCDName                : _i++
			, ws4SapCDName                : _i++
			, license                     : _i++
			, activeYNName                : _i++
			, createDate                  : _i++
			, sellingAreaCreatedDate      : _i++
			
			, lastModifiedDate            : _i++
			, sellingAreaLastModifiedDate : _i++
			, lastModifiedBy              : _i++
			, venueDivCDName              : _i++
			, territoryCD				  : _i++
			, rageSphereCD				  : _i++
			, teamCD				      : _i++
			, legalCD				  	  : _i++
			, channelCD					  : _i++
			, subChannelCD				  : _i++
			, segmentCD					  : _i++
			
			, subSegmentCD				  : _i++
			, reserveSegmentCD			  : _i++
			, kegYN						  : _i++
			, ageingCD					  : _i++
			, siteCD 					  : _i++
			
			, venueGradCD				  : _i++
			, addrTpCD1					  : _i++
			, addrTpCD2					  : _i++
			, addrTpCD3					  : _i++
			, fasciaCD					  : _i++
			
			, ws1SapCD					  : _i++
			, ws2SapCD					  : _i++
			, ws3SapCD					  : _i++
			, ws4SapCD					  : _i++
			, activeYN					  : _i++
			
			, newAddr2					  : _i++
			, ws1CD					  	  : _i++
			, ws2CD					      : _i++
			, ws3CD					  	  : _i++
			, ws4CD					      : _i++
			, venueDivCD 		      		: _i++
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
		,"<fmt:message key="MDM08001A.addrTpCD4"/>"
		,"<fmt:message key="MDM08001A.oldAddr2"/>"
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
 		
		grid = new AW.Grid.Extended;
	    grid.setId("grid"); 
	    grid.setRowCount(0);
	    grid.setColumnCount(columns.length);
	    grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setHeaderText(columns);
		for (var i = 0; i < columns.length; i++) {
	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    grid.setCellFormat([  str, str, str, str, str
  							, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str, str, str
				  			, str, str, str
	              	    ]); 
	    
		grid.setCellEditable(true);
 		grid.setCellEditable(false, _col.territoryCDName);
 		grid.setCellEditable(false, _col.rageSphereCDName);
 		grid.setCellEditable(false, _col.teamCDName);
 		grid.setCellEditable(false, _col.addrTpCD1Name);
 		grid.setCellEditable(false, _col.addrTpCD1Name);
 		grid.setCellEditable(false, _col.addrTpCD2Name);
 		grid.setCellEditable(false, _col.addrTpCD3Name);
 		grid.setCellEditable(false, _col.postCD);
 		grid.setCellEditable(false, _col.ws1SapCDName);
 		grid.setCellEditable(false, _col.ws2SapCDName);
 		grid.setCellEditable(false, _col.ws3SapCDName);
 		grid.setCellEditable(false, _col.ws4SapCDName);
 		grid.setCellEditable(false, _col.createDate);
 		grid.setCellEditable(false, _col.sellingAreaCreatedDate);
 		grid.setCellEditable(false, _col.lastModifiedDate);
 		grid.setCellEditable(false, _col.sellingAreaLastModifiedDate);
		
		grid.setCellTemplate(new AW.Templates.Combo, _col.legalCDName);
  	    grid.setCellTemplate(new AW.Templates.Combo, _col.fasciaCDName);                             
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.venueGradCDName);                          
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.siteCDName);                               
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.channelCDName); 
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.subChannelCDName);                         
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.segmentCDName);                            
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.subSegmentCDName);                         
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.reserveSegmentCDName);                     
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.ageingCDName);                              
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.kegYNName);   
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.activeYNName); 
 	    grid.setCellTemplate(new AW.Templates.Combo, _col.venueDivCDName); 
	    
		grid.setPopupTemplate(function(col, row) {
			
			if (col == _col.territoryCDName) {
				
				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "TERRITORYCD");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "50px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.fasciaCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.legalCDName) {
				
				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "LEGALCD");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "50px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.legalCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.fasciaCDName) {
				
				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "FASCIACD");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "50px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.fasciaCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.venueGradCDName) {
				
				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "VENUEGRADCD");
				table.setParameter("attrib01", "C");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "50px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.venueGradCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.siteCDName) {
				
				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "SITECD");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "50px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.siteCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.channelCDName) {
				
				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "CHANNELCD");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "100px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.channelCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.subChannelCDName) {

				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "SUBCHANNELCD");
				table.setParameter("attrib02", grid.getCellText(_col.channelCD,	row));
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "100px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.subChannelCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.segmentCDName) {
				
				grid.setCellText("", _col.subSegmentCDName, row);
				grid.setCellText("", _col.subSegmentCD, row);

				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "SEGMENTCD");
				table.setParameter("attrib02", grid.getCellText(_col.subChannelCD, row));
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "100px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.segmentCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.subSegmentCDName) {
				
				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "SUBSEGMENTCD");
				table.setParameter("attrib02", grid.getCellText(_col.segmentCD,	row));
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "100px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.subSegmentCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.reserveSegmentCDName) {

				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "RESERVESEGMENTCD");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "100px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.reserveSegmentCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.ageingCDName) {

				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "AGEINGCD");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "100px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.ageingCD, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.kegYNName) {

				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "ACTIVEYN");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "100px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.kegYN, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.activeYNName) {

				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "ACTIVEYN");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "100px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.activeYN, row);
					} catch (e) {
					}
				};
				
			} else if (col == _col.venueDivCDName) {

				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "VENUEDIVCD");
				table.request();

				var rowCount = table.getCount();
				var value = new Array();
				var text = new Array();

				if (rowCount > 0) {
					for (var i = 0; i < rowCount; i++) {
						value[i] = table.getData(0, i);
						text[i] = table.getData(1, i);
					}
				}

				var list = new AW.UI.List;
				list.setStyle("width", "100px");
				list.setStyle("height", "100px");
				list.setItemText(text);
				list.setAttribute("value", value);
				list.setItemCount(text.length);

				list.onItemMouseDown = function(event, i) {
					try {
						AW.$popup.hidePopup();
						var text = this.getItemText(i);
						var value = this.getAttribute("value");
						grid.setCellText(text, col, row);
						grid.setCellText(value[i], _col.venueDivCD, row);
					} catch (e) {
					}
				};
			}
			
            return list;
        });
        
		
		grid.setCellImage("searchGrid", _col.territoryCDName);
		var search_territoryCDName = new AW.Templates.ImageText;
		var search_territoryCDName_Image = search_territoryCDName.getContent("box/image");
		search_territoryCDName_Image.setTag("a");
		search_territoryCDName_Image.setAttribute("href",function() {
			return "javascript:openTerritoryPopup_grid('closeTerritoryPopup_grid', grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_territoryCDName, _col.territoryCDName);

		grid.setCellImage("searchGrid", _col.addrTpCD1Name);
		var search_addrTpCD1Name = new AW.Templates.ImageText;
		var search_addrTpCD1Name_Image = search_addrTpCD1Name.getContent("box/image");
		search_addrTpCD1Name_Image.setTag("a");
		search_addrTpCD1Name_Image.setAttribute("href", function() {
			return "javascript:openAddrPopup_grid('closeAddrPopup_grid', grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_addrTpCD1Name, _col.addrTpCD1Name);

		grid.setCellImage("calendarGrid",_col.createDate);
    	var calendar = new AW.Templates.ImageText;
        var calImage = calendar.getContent("box/image");
        calImage.setTag("a");
        calImage.setAttribute("href", function(){
            return "javascript:pickDateForGrid(grid, _col.createDate,grid.getCurrentRow())";
        });
    	grid.setCellTemplate(calendar, _col.createDate);
    	
    	grid.setCellImage("calendarGrid",_col.sellingAreaCreatedDate);
    	var calendar = new AW.Templates.ImageText;
        var calImage = calendar.getContent("box/image");
        calImage.setTag("a");
        calImage.setAttribute("href", function(){
            return "javascript:pickDateForGrid(grid, _col.sellingAreaCreatedDate,grid.getCurrentRow())";
        });
    	grid.setCellTemplate(calendar, _col.sellingAreaCreatedDate);
    	
    	grid.setCellImage("calendarGrid",_col.lastModifiedDate);
    	var calendar = new AW.Templates.ImageText;
        var calImage = calendar.getContent("box/image");
        calImage.setTag("a");
        calImage.setAttribute("href", function(){
            return "javascript:pickDateForGrid(grid, _col.lastModifiedDate,grid.getCurrentRow())";
        });
    	grid.setCellTemplate(calendar, _col.lastModifiedDate);
    	
    	grid.setCellImage("calendarGrid",_col.sellingAreaLastModifiedDate);
    	var calendar = new AW.Templates.ImageText;
        var calImage = calendar.getContent("box/image");
        calImage.setTag("a");
        calImage.setAttribute("href", function(){
            return "javascript:pickDateForGrid(grid, _col.sellingAreaLastModifiedDate,grid.getCurrentRow())";
        });
    	grid.setCellTemplate(calendar, _col.sellingAreaLastModifiedDate);


		grid.setCellImage("searchGrid", _col.ws1SapCDName);
		var search_ws1SapCDName = new AW.Templates.ImageText;
		var search_ws1SapCDName_Image = search_ws1SapCDName.getContent("box/image");
		search_ws1SapCDName_Image.setTag("a");
		search_ws1SapCDName_Image.setAttribute("href", function() {
			return "javascript:openWSPopup_grid('closeWS1Popup_grid', grid.getCellText(_col.ws1SapCD, grid.getCurrentRow()), grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_ws1SapCDName, _col.ws1SapCDName);

		grid.setCellImage("searchGrid", _col.ws2SapCDName);
		var search_ws2SapCDName = new AW.Templates.ImageText;
		var search_ws2SapCDName_Image = search_ws2SapCDName.getContent("box/image");
		search_ws2SapCDName_Image.setTag("a");
		search_ws2SapCDName_Image.setAttribute("href", function() {
			return "javascript:openWSPopup_grid('closeWS2Popup_grid', grid.getCellText(_col.ws2SapCD, grid.getCurrentRow()), grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_ws2SapCDName, _col.ws2SapCDName);

		grid.setCellImage("searchGrid", _col.ws3SapCDName);
		var search_ws3SapCDName = new AW.Templates.ImageText;
		var search_ws3SapCDName_Image = search_ws3SapCDName.getContent("box/image");
		search_ws3SapCDName_Image.setTag("a");
		search_ws3SapCDName_Image.setAttribute("href",	function() {
			return "javascript:openWSPopup_grid('closeWS3Popup_grid', grid.getCellText(_col.ws3SapCD, grid.getCurrentRow()), grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_ws3SapCDName, _col.ws3SapCDName);

		grid.setCellImage("searchGrid", _col.ws4SapCDName);
		var search_ws4SapCDName = new AW.Templates.ImageText;
		var search_ws4SapCDName_Image = search_ws4SapCDName.getContent("box/image");
		search_ws4SapCDName_Image.setTag("a");
		search_ws4SapCDName_Image.setAttribute("href", function() {
			return "javascript:openWSPopup_grid('closeWS4Popup_grid', grid.getCellText(_col.ws4SapCD, grid.getCurrentRow()), grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_ws4SapCDName, _col.ws4SapCDName);

    	
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
			if(col == _col.venueCD) {
				if(text.length>10) {
					this.setCellText(text.substring(0,10),col,row);
				}
			}
			if(col == _col.venueNm) {
				if(text.length>50) {
					this.setCellText(text.substring(0,50),col,row);
				}
			}
	    };
	
	    grid.onCellValidated = function(text, col, row) {
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
	    
    }
	
 	function closeTerritoryPopup_grid(data, row) {
		grid.setCellText(data.territoryCDName , _col.territoryCDName , row);
		grid.setCellText(data.territoryCD     , _col.territoryCD     , row);
		grid.setCellText(data.rageSphereCDName, _col.rageSphereCDName, row);
		grid.setCellText(data.rageSphereCD    , _col.rageSphereCD    , row);
		grid.setCellText(data.teamCDName      , _col.teamCDName      , row);
		grid.setCellText(data.teamCD     	  , _col.teamCD     	 , row); 
	}
	
 	function closeAddrPopup_grid(data) {
		var detail_r = "",
			detail_j = "",
			row = data.row;

		detail_r  = data.buldSlno > 0 ? data.buldMnnm + "-" + data.buldSlno : data.buldMnnm;
		detail_j = data.lnbrSlno > 0 ? data.lnbrMnnm + "-" + data.lnbrSlno : data.lnbrMnnm;
		
		
		grid.setCellText(data.siNm, _col.addrTpCD1Name, row);
		grid.setCellText(data.sggNm, _col.addrTpCD2Name, row);
		grid.setCellText(data.emdNm, _col.addrTpCD3Name, row);
		grid.setCellText(detail_r + " " + data.addrDetail, _col.newAddr2, row);
		grid.setCellText(detail_j + " " + data.addrDetail, _col.oldAddr2, row);
		grid.setCellText(data.zipNo, _col.postCD, row);
 		grid.setCellText(data.roadFullAddr, _col.newAddr1, row);
  		grid.setCellText(data.jibunAddrs, _col.oldAddr1, row);
		
   		if(!popupChk(row)) {
   			return false;
  		}
	}

 	function popupChk(row) {
   	
 		if(setAddrTpCD1(row) && setAddrTpCD2(row) && setAddrTpCD3(row)) {			
 			return true;
 		}else{
 			return false;
 		}
 	}
 	
 	function setAddrTpCD1(row) {
 		var addrTpCD1_S = grid.getCellText(_col.addrTpCD1Name, row);
 		
 		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500107S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "ADDRTPCD1");
 		table.setParameter("attrib04", addrTpCD1_S);
 	  	table.request();
   	
 		if(table.getCount() == 1) {			
 			grid.setCellText(table.getData(0,0), _col.addrTpCD1, row);
 			return true;
 		}else{
 			resetAddr(row);
 			alert("시도("+ addrTpCD1_S +")가 일치하지 않습니다.");
 			return false;
 		}
 	}
 	
 	function setAddrTpCD2(row) {
 		var addrTpCD2_S = grid.getCellText(_col.addrTpCD2Name, row);
 		
 		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500107S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "ADDRTPCD2");
 		table.setParameter("attrib04", addrTpCD2_S);
 	  	table.request();
   	
 		if(table.getCount() == 1) {			
 			grid.setCellText(table.getData(0,0), _col.addrTpCD2, row);
 			return true;
 		}else{
 			resetAddr(row);
 			alert("시군구("+ addrTpCD2_S +")가  일치하지 않습니다.");
 			return false;
 		}
 	}
 	
 	function setAddrTpCD3(row) {
 		var addrTpCD3_S = grid.getCellText(_col.addrTpCD3Name, row);
 		
 		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500107S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "ADDRTPCD3");
 		table.setParameter("attrib04", addrTpCD3_S);
 	  	table.request();
 	  	
 		if(table.getCount() == 1) {			
 			grid.setCellText(table.getData(0,0), _col.addrTpCD3, row);
 			return true;
 		}else{
 			resetAddr(row);
 			alert("읍면동리(" + addrTpCD3_S + ")가 일치하지 않습니다.");
 			return false;
 		}
 	}
 	
 	function resetAddr(row) {
 		grid.setCellText("", _col.addrTpCD1, row);
 		grid.setCellText("", _col.addrTpCD1Name, row);
 		grid.setCellText("", _col.addrTpCD2, row);
 		grid.setCellText("", _col.addrTpCD2Name, row);
 		grid.setCellText("", _col.addrTpCD3, row);
 		grid.setCellText("", _col.addrTpCD3Name, row);
 		grid.setCellText("", _col.newAddr1, row);
 		grid.setCellText("", _col.newAddr2, row);
 		grid.setCellText("", _col.oldAddr1, row);
 		grid.setCellText("", _col.oldAddr2, row);
 		grid.setCellText("", _col.postCD, row);
 	}
 	
	/**********************************************
	* fileupload setting
	**********************************************/
	
	$("#fileuploader").change(function(e) {
		var name = $("#fileuploader")[0].value;
		
		$("#progressReport").val(name.substring(name.lastIndexOf('\\')+1));
		
	});
	
	function upload() {
		
		if ($("#fileuploader").val() == "") {
			alert("파일을 선택해 주세요.");
		} else {
	        
			var linkIDVal = $("#articleID").val();
			$("#linkID").val(linkIDVal);
			
	        $("#form").ajaxForm({
	            url : "${contextPath}/service/mdm08/extractVenueXls",
	            enctype : "multipart/form-data",
	            data : 
					{
	            	userID:"${params.empID}"
	            	},
	            error : function(){
			        this.progressReport = document.getElementById("progressReport");
			        this.progressReport.value = "Upload error.";        	
			    	alert("Upload error..");
	            },
				xhr: function() {
					var xhr = $.ajaxSettings.xhr();
					xhr.upload.onprogress = function(e) {
						var percent = Math.round(e.loaded * 100 / e.total) + "%";
						if (percent == "100%") percent = "Complete!!";
						$("#progressReport").val(percent);
					}
					return xhr;
				},            
	            success : function(data){
 					$("#fileuploader").val("");

 					SetGridData(data);
				
			  		this.progressReport = document.getElementById("progressReport");
			        this.progressReport.value = "Complete!!";
			  		
	            }
	        });
	 
	        $("#form").submit() ;
	     	
		}
	}
	
</script>