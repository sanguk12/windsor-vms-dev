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
													<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					                           			<tr>
					                               			<td height="25" width="310">
					                                   			<div id="selectedFileDisplay">
					                                       			 <input type="text" id="progressReport" value="" style="width:300px; float: left; display: inline-block;" class="file_input_textbox" readonly="readonly" >
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
					                                   				<a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a>
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
					<td height="*" valign="top">
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
    .aw-grid-header {text-align: center; border-right: 1px solid #aca899!important; background: #F3F4F6}
	.aw-row-selector {text-align: center}
	
    #grid .aw-header-1 .aw-column-0 {text-align:center;} 
    #grid .aw-header-1 .aw-column-1 {width: 120px; text-align:left;}    
    #grid .aw-header-1 .aw-column-2 {text-align:center;}  
    #grid .aw-header-1 .aw-column-3 {text-align:center;} 
    #grid .aw-header-1 .aw-column-4 {text-align:center;}  
    #grid .aw-header-1 .aw-column-5 {text-align:center;} 
    #grid .aw-header-1 .aw-column-6 {text-align:center;} 
    #grid .aw-header-1 .aw-column-7 {text-align:center;} 
    #grid .aw-header-1 .aw-column-8 {text-align:center;} 
    #grid .aw-header-1 .aw-column-9 {text-align:center;}   
    #grid .aw-header-1 .aw-column-10 {text-align:center;}  
    #grid .aw-header-1 .aw-column-11 {text-align:center;}  
    #grid .aw-header-1 .aw-column-12 {text-align:center;}  
    #grid .aw-header-1 .aw-column-13 {text-align:center;}
    #grid .aw-header-1 .aw-column-14 {text-align:center;}  
    #grid .aw-header-1 .aw-column-15 {text-align:center;}
    #grid .aw-header-1 .aw-column-16 {text-align:center;}  
    #grid .aw-header-1 .aw-column-17 {text-align:center;}  
    #grid .aw-header-1 .aw-column-18 {text-align:center;}  
    #grid .aw-header-1 .aw-column-19 {text-align:center;}  
    #grid .aw-header-1 .aw-column-20 {text-align:center;}
    #grid .aw-header-1 .aw-column-21 {text-align:center;}
    #grid .aw-header-1 .aw-column-22 {text-align:center;}
    #grid .aw-header-1 .aw-column-23 {text-align:center;}
    #grid .aw-header-1 .aw-column-24 {text-align:center;}
    #grid .aw-header-1 .aw-column-25 {text-align:center;} 
    #grid .aw-header-1 .aw-column-26 {text-align:center;} 
    #grid .aw-header-1 .aw-column-27 {text-align:center;} 
    #grid .aw-header-1 .aw-column-28 {text-align:center;}
    #grid .aw-header-1 .aw-column-29 {text-align:center;}
    #grid .aw-header-1 .aw-column-30 {text-align:center;}
    #grid .aw-header-1 .aw-column-31 {text-align:center;}
    #grid .aw-header-1 .aw-column-32 {text-align:center;}
    #grid .aw-header-1 .aw-column-33 {text-align:center;}
    #grid .aw-header-1 .aw-column-34 {text-align:center;}

    #grid .aw-column-0 {width: 100px; text-align:center;}
    #grid .aw-column-1 {width: 120px; text-align:center;}
    #grid .aw-column-2 {width: 100px; text-align:left;}
    #grid .aw-column-3 {width: 100px; text-align:left;}
    #grid .aw-column-4 {width: 100px; text-align:center;}
    #grid .aw-column-5 {width: 100px; text-align:center;}
    #grid .aw-column-6 {width: 100px; text-align:center;}
    #grid .aw-column-7 {width: 100px; text-align:left;}
    #grid .aw-column-8 {width: 100px; text-align:left;}
    #grid .aw-column-9 {width: 100px; text-align:left;}
    #grid .aw-column-10 {width: 110px; text-align:left;}
    #grid .aw-column-11 {width: 100px; text-align:center;}
    #grid .aw-column-12 {width: 100px; text-align:center;}
    #grid .aw-column-13 {width: 100px; text-align:center;}
    #grid .aw-column-14 {width: 100px; text-align:center;}
    #grid .aw-column-15 {width: 100px; text-align:center;}
    #grid .aw-column-16 {width: 100px; text-align:center;}
    #grid .aw-column-17 {width: 100px; text-align:center;}
    #grid .aw-column-18 {width: 100px; text-align:center;}
    #grid .aw-column-19 {width: 100px; text-align:center;}
    #grid .aw-column-20 {width: 100px; text-align:left;}
    #grid .aw-column-21 {width: 100px; text-align:center;}
    #grid .aw-column-22 {width: 100px; text-align:center;}
    #grid .aw-column-23 {width: 100px; text-align:center;}
    #grid .aw-column-24 {width: 100px; text-align:left;}
    #grid .aw-column-25 {width: 100px; text-align:center;}
    #grid .aw-column-26 {width: 100px; text-align:center;}
    #grid .aw-column-27 {width: 100px; text-align:left;}
    #grid .aw-column-28 {width: 100px; text-align:center;}
    #grid .aw-column-29 {width: 100px; text-align:center;}
    #grid .aw-column-30 {width: 100px; text-align:left;}
    #grid .aw-column-31 {width: 100px; text-align:center;}
    #grid .aw-column-32 {width: 100px; text-align:center;}
    #grid .aw-column-33 {width: 100px; text-align:left;}
    #grid .aw-column-34 {width: 100px; text-align:center;}
    
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
					 $(this).find("requestDate").text()
					, $(this).find("mdDupYN").text()
					, $(this).find("venueNm").text()
					, $(this).find("territoryCDName").text()
					, $(this).find("phoneNo").text()
					, $(this).find("fasciaCDName").text()
					, $(this).find("venueGradCDName").text()
					, $(this).find("addrTpCD1Name").text()
					, $(this).find("addrTpCD2Name").text()
					, $(this).find("addrTpCD3Name").text()
					, $(this).find("newAddr2").text()
					, $(this).find("postCD").text()
					, $(this).find("siteCDName").text()
					, $(this).find("channelCDName").text()
					, $(this).find("subChannelCDName").text()
					, $(this).find("segmentCDName").text()
					, $(this).find("subSegmentCDName").text()
					, $(this).find("reserveSegmentCDName").text()
					, $(this).find("ageingCDName").text()
					, $(this).find("kegYNName").text()
					, $(this).find("mdVenueCD").text()
					, $(this).find("locationCDName").text()
					, $(this).find("legalCDName").text()
					, $(this).find("ws1SapCD").text()
					, $(this).find("ws1SapCDName").text()
					, $(this).find("branch1").text()
					, $(this).find("ws2SapCD").text()
					, $(this).find("ws2SapCDName").text()
					, $(this).find("branch2").text()
					, $(this).find("ws3SapCD").text()
					, $(this).find("ws3SapCDName").text()
					, $(this).find("branch3").text()
					, $(this).find("ws4SapCD").text()
					, $(this).find("ws4SapCDName").text()
					, $(this).find("branch4").text()
					
					, $(this).find("territoryCD").text()
					, $(this).find("fasciaCD").text()
					, $(this).find("venueGradCD").text()
					, $(this).find("addrTpCD1").text()
					, $(this).find("addrTpCD2").text()
					, $(this).find("addrTpCD3").text()
					, $(this).find("siteCD").text()
					, $(this).find("channelCD").text()
					, $(this).find("subChannelCD").text()
					, $(this).find("segmentCD").text()
					, $(this).find("subSegmentCD").text()
					, $(this).find("reserveSegmentCD").text()
					, $(this).find("ageingCD").text()
					, $(this).find("kegYN").text()
					, $(this).find("locationCD").text()
					, $(this).find("ws1CD").text()
					, $(this).find("ws2CD").text()
					, $(this).find("ws3CD").text()
					, $(this).find("ws4CD").text()
					, $(this).find("addrTpCD4").text()
					, $(this).find("newAddr1").text()
					, $(this).find("oldAddr1").text()
					, $(this).find("oldAddr2").text()
					, $(this).find("legalCD").text()
					
				];
				rowCount++;
			});
		});

		grid.setCellData(data);
		grid.setRowCount(rowCount);
		grid.refresh();
		
		//hideLoading();
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function Save() {
		var regExp1 = /^\d{2,3}-\d{3,4}-\d{4}$/,
			regExp2 = /^01[016789]$/;
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

			if (grid.getCellText(_col.requestDate, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg1" />"); 
 				setCellFocus(grid, _col.requestDate, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.mdDupYN, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg2" />"); 
 				setCellFocus(grid, _col.mdDupYN, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.venueNm, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg4" />"); 
 				setCellFocus(grid, _col.venueNm, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.territoryCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg5" />"); 
 				setCellFocus(grid, _col.territoryCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.fasciaCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg6" />"); 
 				setCellFocus(grid, _col.fasciaCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.venueGradCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg7" />"); 
 				setCellFocus(grid, _col.venueGradCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.siteCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg8" />"); 
 				setCellFocus(grid, _col.siteCDName, i); 
 				return;
 				                                                            
 			}
			
			if (grid.getCellText(_col.addrTpCD1Name, i) == "") {            
 				alert("<fmt:message key="MDM05001C.msg19" />");              
 				setCellFocus(grid, _col.addrTpCD1Name, i);                     
 				return;
 				
 			}
			
			if (grid.getCellText(_col.addrTpCD2Name, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg19" />"); 
 				setCellFocus(grid, _col.addrTpCD2Name, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.addrTpCD3Name, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg19" />"); 
 				setCellFocus(grid, _col.addrTpCD3Name, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.newAddr2, i) == "") {   
				alert("<fmt:message key="MDM05001C.msg19" />");     
				setCellFocus(grid, _col.newAddr2, i);            
				return;                                            
			}
			
			if (grid.getCellText(_col.postCD, i) == "") {   
				alert("<fmt:message key="MDM05001C.msg19" />");     
				setCellFocus(grid, _col.postCD, i);            
				return;                                            
			}                                               
			
			if (grid.getCellText(_col.channelCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg18" />"); 
 				setCellFocus(grid, _col.channelCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.subChannelCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg11" />"); 
 				setCellFocus(grid, _col.subChannelCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.segmentCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg9" />"); 
 				setCellFocus(grid, _col.segmentCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.subSegmentCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg10" />"); 
 				setCellFocus(grid, _col.subSegmentCDName, i); 
 				return;
 			}
			
// 			if (grid.getCellText(_col.reserveSegmentCD, i) == "") {
//  				alert("<fmt:message key="MDM05001C.msg12" />"); 
//  				setCellFocus(grid, _col.reserveSegmentCDName, i); 
//  				return;
//  		}

			if (grid.getCellText(_col.ageingCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg13" />"); 
 				setCellFocus(grid, _col.ageingCDName, i); 
 				return;
 			}
			
// 			if (grid.getCellText(_col.kegYN, i) == "") {
//  				alert("<fmt:message key="MDM05001C.msg14" />"); 
//  				setCellFocus(grid, _col.kegYNName, i); 
//  				return;
// 			}

			if (grid.getCellText(_col.locationCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg15" />"); 
 				setCellFocus(grid, _col.locationCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.legalCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg20" />"); 
 				setCellFocus(grid, _col.legalCDName, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.ws1SapCD, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg16" />"); 
 				setCellFocus(grid, _col.ws1SapCD, i); 
 				return;
 			}
			
			if (grid.getCellText(_col.ws1SapCDName, i) == "") {
 				alert("<fmt:message key="MDM05001C.msg17" />"); 
 				setCellFocus(grid, _col.ws1SapCDName, i); 
 				return;
 			}
			
			if(grid.getCellText(_col.phoneNo, i).length > 0) {
				
	 			if(!regExp1.test(grid.getCellText(_col.phoneNo, i))) {
	 				alert("<fmt:message key="MDM05001C.msg21" />")
	 				setCellFocus(grid, _col.phoneNo, i); 
	 				return;
	 			}
	 			
	  			if(regExp2.test(grid.getCellText(_col.phoneNo, i).substring(0,3))) {
	  				alert("<fmt:message key="MDM05001C.msg22" />")
	  				setCellFocus(grid, _col.phoneNo, i);
	  				return;
	  			}
	  			
	 		}
		}

		showLoading();
		
		var requestDates = new Array();
		var mdDupYNs = new Array();
		var venueNms = new Array();
		var territoryCDs = new Array();
		var phoneNos = new Array();
		var fasciaCDs = new Array();
		var venueGradCDs = new Array();
		var addrTpCD1s = new Array();
		var addrTpCD2s = new Array();
		var addrTpCD3s = new Array();
		var addrTpCD4s = new Array();
		var newAddr2s = new Array();
		var postCDs = new Array();
		var siteCDs = new Array();
		var channelCDs = new Array();
		var subChannelCDs = new Array();
		var segmentCDs = new Array();
		var subSegmentCDs = new Array();
		var reserveSegmentCDs = new Array();
		var ageingCDs = new Array();
		var kegYNs = new Array();
		var mdVenueCDs = new Array();
		var locationCDs = new Array();
		var ws1SapCDs = new Array();
		var ws2SapCDs = new Array();
		var ws3SapCDs = new Array();
		var ws4SapCDs = new Array();
		var ws1CDs = new Array();
		var ws2CDs = new Array();
		var ws3CDs = new Array();
		var ws4CDs = new Array();
		var newAddr1s = new Array();
		var oldAddr1s = new Array();
		var oldAddr2s = new Array();
		var legalCDs = new Array();
		
		var count = 0;
	
		for (var i = 0; i < index.length; i++) {
			requestDates[count]  = grid.getCellText(_col.requestDate, index[i]).replace(".", "").replace(".", "");
			mdDupYNs[count]  	 = grid.getCellText(_col.mdDupYN, index[i]);
			venueNms[count]      = grid.getCellText(_col.venueNm, index[i]).replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">");
			territoryCDs[count]  = grid.getCellText(_col.territoryCD, index[i]);
			phoneNos[count]  	 = grid.getCellText(_col.phoneNo, index[i]);
			fasciaCDs[count]  	 = grid.getCellText(_col.fasciaCD, index[i])
			venueGradCDs[count]  = grid.getCellText(_col.venueGradCD, index[i]);
			addrTpCD1s[count]    = grid.getCellText(_col.addrTpCD1, index[i]);
			addrTpCD2s[count]    = grid.getCellText(_col.addrTpCD2, index[i]);
			addrTpCD3s[count]    = grid.getCellText(_col.addrTpCD3, index[i]);
			//addrTpCD4s[count]    = grid.getCellText(_col.addrTpCD4, index[i]);
			newAddr2s[count]    = grid.getCellText(_col.newAddr2, index[i]);
			oldAddr2s[count]    = grid.getCellText(_col.oldAddr2, index[i]);
			postCDs[count]    	 = grid.getCellText(_col.postCD, index[i]);
			siteCDs[count]    	 = grid.getCellText(_col.siteCD, index[i]);
			channelCDs[count] = grid.getCellText(_col.channelCD, index[i]);
			subChannelCDs[count] = grid.getCellText(_col.subChannelCD, index[i]);
			segmentCDs[count]    = grid.getCellText(_col.segmentCD, index[i]);
			subSegmentCDs[count] = grid.getCellText(_col.subSegmentCD, index[i]);
			reserveSegmentCDs[count] = grid.getCellText(_col.reserveSegmentCD, index[i]);
			ageingCDs[count]        = grid.getCellText(_col.ageingCD, index[i]);
			kegYNs[count]        = grid.getCellText(_col.kegYN, index[i]);
			mdVenueCDs[count]        = grid.getCellText(_col.mdVenueCD, index[i]);
			locationCDs[count]        = grid.getCellText(_col.locationCD, index[i]);
			ws1SapCDs[count]      = grid.getCellText(_col.ws1SapCD, index[i]);
			ws2SapCDs[count]      = grid.getCellText(_col.ws2SapCD, index[i]);
			ws3SapCDs[count]      = grid.getCellText(_col.ws3SapCD, index[i]);
			ws4SapCDs[count]      = grid.getCellText(_col.ws4SapCD, index[i]);
			ws1CDs[count]      = grid.getCellText(_col.ws1CD, index[i]);
			ws2CDs[count]      = grid.getCellText(_col.ws2CD, index[i]);
			ws3CDs[count]      = grid.getCellText(_col.ws3CD, index[i]);
			ws4CDs[count]      = grid.getCellText(_col.ws4CD, index[i]);
			newAddr1s[count]    = grid.getCellText(_col.newAddr1, index[i]);
			oldAddr1s[count]    = grid.getCellText(_col.oldAddr1, index[i]);
			legalCDs[count]    = grid.getCellText(_col.legalCD, index[i]);
			count++;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mdm05/saveTmpVenueGrid");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("requestDates", requestDates)
		table.setParameter("mdDupYNs", mdDupYNs)
		table.setParameter("venueNms", venueNms)
		table.setParameter("territoryCDs", territoryCDs)
		table.setParameter("phoneNos", phoneNos)
		table.setParameter("fasciaCDs", fasciaCDs)
		table.setParameter("venueGradCDs", venueGradCDs)
		table.setParameter("addrTpCD1s", addrTpCD1s)
		table.setParameter("addrTpCD2s", addrTpCD2s) 
		table.setParameter("addrTpCD3s", addrTpCD3s) 
		table.setParameter("addrTpCD4s", addrTpCD4s)
		table.setParameter("newAddr2s", newAddr2s)
		table.setParameter("postCDs", postCDs)
		table.setParameter("siteCDs", siteCDs)
		table.setParameter("channelCDs", channelCDs)
		table.setParameter("subChannelCDs", subChannelCDs)
		table.setParameter("segmentCDs", segmentCDs)
		table.setParameter("subSegmentCDs", subSegmentCDs)
		table.setParameter("reserveSegmentCDs", reserveSegmentCDs)
		table.setParameter("ageingCDs", ageingCDs)
		table.setParameter("kegYNs", kegYNs)
		table.setParameter("mdVenueCDs", mdVenueCDs)
		table.setParameter("locationCDs", locationCDs)
		table.setParameter("ws1SapCDs", ws1SapCDs)
		table.setParameter("ws2SapCDs", ws2SapCDs)
		table.setParameter("ws3SapCDs", ws3SapCDs)
		table.setParameter("ws4SapCDs", ws4SapCDs)
		table.setParameter("ws1CDs", ws1CDs)
		table.setParameter("ws2CDs", ws2CDs)
		table.setParameter("ws3CDs", ws3CDs)
		table.setParameter("ws4CDs", ws4CDs)
		table.setParameter("newAddr1s", newAddr1s)
		table.setParameter("oldAddr1s", oldAddr1s)
		table.setParameter("oldAddr2s", oldAddr2s)
		table.setParameter("legalCDs", legalCDs)
		table.request();
		
		if (table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			parent.Search();
			parent.appletClose();
   		} else {
			alert(table.getData(1,0));
		}

		hideLoading();
		
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
				+"&viewID=MDM05001D"
				+"&finalAction="+finalAction
				+"&row="+row;
		
		newWindow(url, "MDM05001D",600,350,"yes");
	}
	
	function setChannelCD(row) {
		var result = "";
		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500110S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "SUBCHANNELCD");
 		table.setParameter("comCode", grid.getCellText(_col.subChannelCD, row));
 	  	table.request();
   	
 		if (table.getCount() > 0) {
 			result = table.getData(0,0);
 			return result;
 		}
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var grid = null;
	var _i = 0;
	var _col = {
		 requestDate : _i++ 
		, mdDupYN : _i++
		, venueNm : _i++   
		, territoryCDName : _i++
		, phoneNo : _i++
		
		, fasciaCDName : _i++
		, venueGradCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, addrTpCD3Name : _i++
		
		, newAddr2 : _i++
		, postCD 	: _i++
		, siteCDName  : _i++
		, channelCDName : _i++
		, subChannelCDName : _i++
		
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, reserveSegmentCDName : _i++
		, ageingCDName : _i++
		, kegYNName   : _i++
		
		, mdVenueCD   : _i++
		, locationCDName : _i++
		, legalCDName : _i++
		, ws1SapCD    : _i++
		, ws1SapCDName  : _i++
		
		, branch1     : _i++
		, ws2SapCD    : _i++
		, ws2SapCDName  : _i++
		, branch2     : _i++
		, ws3SapCD    : _i++
		
		, ws3SapCDName  : _i++
		, branch3     : _i++
		, ws4SapCD    : _i++
		, ws4SapCDName  : _i++
		, branch4    : _i++
		
		, territoryCD  : _i++
		, fasciaCD  : _i++  
		, venueGradCD  : _i++
		, addrTpCD1  : _i++
		, addrTpCD2  : _i++
		
		, addrTpCD3  : _i++
		, siteCD  :  _i++
		, channelCD  : _i++
		, subChannelCD  : _i++
		, segmentCD  : _i++
		
		, subSegmentCD  : _i++
		, reserveSegmentCD  : _i++
		, ageingCD  : _i++
		, kegYN   : _i++
		, locationCD  : _i++
		
		, ws1CD 	: _i++
		, ws2CD 	: _i++
		, ws3CD 	: _i++
		, ws4CD 	: _i++
		, addrTpCD4  : _i++
		
		, newAddr1 : _i++
		, oldAddr1 : _i++
		, oldAddr2 : _i++
		, legalCD : _i++
    };
	
 	var columns_header = [
 		  ""
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
		, "<fmt:message key="MDM05001A.mdDuplicateYN"/>"
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
		, "<fmt:message key="MDM05001B.legal"/>"
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
	
 		function display(){ 
 	        var span = this.getHeaderProperty("span");
 	        
 	        return span==0 ? "none" : null; 
 	    } 

 	    function width(){ 
 	        var span = this.getHeaderProperty("span");
 	        
 	        if (span == 1) { 
 	            return null; 
 	        } 
 	        
 	        var pos = this.getColumnProperty("position"); 
 	        var a = this.getColumnProperty("indices"); 
 	        var i, col, w = 0;
 	        
 	        for (i = 0; i < span; i++){ 
 	            col = a ? a[pos+i] : pos+i; // column index 
 	            w += this.getColumnProperty("width", col); 
 	        } 
 	        return w; 
 	    } 

 	    obj.setStyle("display", display); 
 	    obj.setStyle("width", width);
 	};
	
	function createGrid() {
		grid = new AW.Grid.Extended;
	    grid.setId("grid");
	    //grid.setSize(400, 200);
	    grid.setRowCount(0);
	    grid.defineHeaderProperty("span", 1);          
		grid.setHeaderTemplate(new AW.Grid.Header2);
		grid.setHeaderCount(2);   
		grid.setHeaderText(columns, 0);         
	    grid.setHeaderText(columns_header, 1);  
	   
	    for (var i = 0; i < columns.length; i++){
	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    
	    grid.setColumnCount(columns.length);
		
		grid.setHeaderIndices([1, 0]);     
	    
		grid.setHeaderSpan(0,  0, 1);
		grid.setHeaderSpan(0,  1, 1);  
		grid.setHeaderSpan(0,  2, 1);  
		grid.setHeaderSpan(0,  3, 1);	
		grid.setHeaderSpan(0,  4, 1);  
		
		grid.setHeaderSpan(2,  5, 1);  
		grid.setHeaderSpan(0,  6, 1);  
		grid.setHeaderSpan(5,  7, 1);  

		grid.setHeaderSpan(0,  8, 1);
		grid.setHeaderSpan(0,  9, 1);  
		grid.setHeaderSpan(0,  10, 1); 
		grid.setHeaderSpan(0,  11, 1);
		
		grid.setHeaderSpan(11,  12, 1);
		grid.setHeaderSpan(0,  13, 1);
		grid.setHeaderSpan(0,  14, 1); 
		grid.setHeaderSpan(0,  15, 1); 
		grid.setHeaderSpan(0,  16, 1);
		grid.setHeaderSpan(0,  17, 1);
		grid.setHeaderSpan(0,  18, 1); 
		grid.setHeaderSpan(0,  19, 1); 
		grid.setHeaderSpan(0,  20, 1); 
		grid.setHeaderSpan(0,  21, 1);
		grid.setHeaderSpan(0,  22, 1);
		
		grid.setHeaderSpan(3,  23, 1);
		grid.setHeaderSpan(0,  24, 1);
		grid.setHeaderSpan(0,  25, 1);
		grid.setHeaderSpan(3,  26, 1);
		grid.setHeaderSpan(0,  27, 1); 
		grid.setHeaderSpan(0,  28, 1); 
		grid.setHeaderSpan(3,  29, 1);
		grid.setHeaderSpan(0,  30, 1);
		grid.setHeaderSpan(0,  31, 1);
		grid.setHeaderSpan(3,  32, 1);
		grid.setHeaderSpan(0,  33, 1);
		grid.setHeaderSpan(0,  34, 1);
		
		grid.setStyle("width","100%");
		grid.setStyle("height","420px");
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setCellFormat([  str, str, str, str, str
						    , str, str, str, str, str
						    , str, str, str, str, str
						    , str, str, str, str, str
						    , str, str, str, str, str
						    , str, str, str, str, str
						    , str, str, str, str, str
						    , str
						    ]);
	    
 	   	grid.setCellEditable(false, _col.requestDate);
 	   	grid.setCellEditable(false, _col.mdDupYN);
 	   	grid.setCellEditable(true, _col.venueNm);
  		grid.setCellEditable(false, _col.territoryCDName);
 	   	grid.setCellEditable(true, _col.phoneNo);
  		grid.setCellEditable(false, _col.fasciaCDName);
  		grid.setCellEditable(false, _col.venueGradCDName);
  		grid.setCellEditable(false, _col.addrTpCD1Name);
  		grid.setCellEditable(false, _col.addrTpCD2Name);
  		grid.setCellEditable(false, _col.addrTpCD3Name);
 	   	grid.setCellEditable(true, _col.newAddr2);
  		grid.setCellEditable(false, _col.postCD);
  		grid.setCellEditable(false, _col.siteCDName);
  		grid.setCellEditable(false, _col.channelCDName);
  		grid.setCellEditable(false, _col.subChannelCDName);
  		grid.setCellEditable(false, _col.segmentCDName);
  		grid.setCellEditable(false, _col.subSegmentCDName);
  		grid.setCellEditable(false, _col.reserveSegmentCDName);
  		grid.setCellEditable(false, _col.ageingCDName);
  		grid.setCellEditable(false, _col.kegYNName);
  		grid.setCellEditable(false, _col.mdVenueCD);
  		grid.setCellEditable(false, _col.locationCDName);
  		grid.setCellEditable(false, _col.legalCDName);
  		grid.setCellEditable(false, _col.ws1SapCD);
  		grid.setCellEditable(false, _col.ws1SapCDName);
  		grid.setCellEditable(false, _col.branch1);
  		grid.setCellEditable(false, _col.ws2SapCD);
  		grid.setCellEditable(false, _col.ws2SapCDName);
  		grid.setCellEditable(false, _col.branch2);
  		grid.setCellEditable(false, _col.ws3SapCD);
  		grid.setCellEditable(false, _col.ws3SapCDName);
  		grid.setCellEditable(false, _col.branch3);
  		grid.setCellEditable(false, _col.ws4SapCD);
  		grid.setCellEditable(false, _col.ws4SapCDName);
  		grid.setCellEditable(false, _col.branch4);

 		grid.setCellTemplate(new AW.Templates.Combo, _col.mdDupYN);
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
		grid.setCellTemplate(new AW.Templates.Combo, _col.locationCDName);
		grid.setCellTemplate(new AW.Templates.Combo, _col.legalCDName);
		grid.setFixedLeft(5);

		grid.setPopupTemplate(function(col, row) {

			if (col == _col.mdDupYN) {
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
						grid.setCellText(value[i], _col.mdDupYN, row);
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
				
			}  else if (col == _col.channelCDName) {
				grid.setCellText("", _col.subChannelCDName, row);
				grid.setCellText("", _col.subChannelCD, row);
				grid.setCellText("", _col.segmentCDName, row);
				grid.setCellText("", _col.segmentCD, row);
				grid.setCellText("", _col.subSegmentCDName, row);
				grid.setCellText("", _col.subSegmentCD, row);
				
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
				
			}else if (col == _col.subChannelCDName) {
				grid.setCellText("", _col.segmentCDName, row);
				grid.setCellText("", _col.segmentCD, row);
				grid.setCellText("", _col.subSegmentCDName, row);
				grid.setCellText("", _col.subSegmentCD, row);
				
				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "SUBCHANNELCD");
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
				table.setParameter("attrib02", grid.getCellText(_col.subChannelCD,	row));
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
				table.setParameter("attrib02", grid.getCellText(_col.segmentCD,
						row));
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
				
			} else if (col == _col.locationCDName) {

				var table = new AW.XML.Table;
				table.setURL("${contextPath}/service/simpleAction/SYS0001S");
				table.setAsync(false);
				table.setRequestMethod("POST");
				table.setParameter("outParamKey", "comCode;codeName;");
				table.setParameter("codeDiv", "LOCATIONCD");
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
						grid.setCellText(value[i], _col.locationCD, row);
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
						grid.setCellText(value[i], _col.legalCD, row);
					} catch (e) {
					}
				};
			}

			return list;
		});

		grid.setCellImage("calendarGrid",_col.requestDate);
		var calendar = new AW.Templates.ImageText;
		var calImage = calendar.getContent("box/image");
		calImage.setTag("a");
		calImage.setAttribute("href", function(){
		   return "javascript:pickDateForGrid(grid, _col.requestDate,grid.getCurrentRow(), 'getRequestDate')";
		});
		grid.setCellTemplate(calendar, _col.requestDate);
		
		grid.setCellImage("searchGrid", _col.territoryCDName);
		var search_territoryCDName = new AW.Templates.ImageText;
		var search_territoryCDName_Image = search_territoryCDName
				.getContent("box/image");
		search_territoryCDName_Image.setTag("a");
		search_territoryCDName_Image.setAttribute("href", function() {
			return "javascript:openTerritoryPopup_grid('closeTerritoryPopup_grid', grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_territoryCDName, _col.territoryCDName);

		grid.setCellImage("searchGrid", _col.addrTpCD1Name);
		var search_addrTpCD1Name = new AW.Templates.ImageText;
		var search_addrTpCD1Name_Image = search_addrTpCD1Name.getContent("box/image");
		search_addrTpCD1Name_Image.setTag("a");
		search_addrTpCD1Name_Image.setAttribute("href",	function() {
			return "javascript:openAddrPopup_grid('closeAddrPopup_grid', grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_addrTpCD1Name, _col.addrTpCD1Name);

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
		search_ws4SapCDName_Image.setAttribute("href",	function() {
			return "javascript:openWSPopup_grid('closeWS4Popup_grid', grid.getCellText(_col.ws4SapCD, grid.getCurrentRow()), grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_ws4SapCDName, _col.ws4SapCDName);

		// Cell startEdit BEGIN
		grid.onCellSelectedChanged = function(selected, col, row) {
			
			if (selected) {
				this.setTimeout(function() {
					this.raiseEvent("editCurrentCell", {}, col, row);
				});
			}
		};

		grid.onCellClicked = function(event, col, row) {

			if (this.getCellSelected(col, row)) {
				this.setTimeout(function() {
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
			
			if (col == _col.venueCD) {
				if (text.length > 10) {
					this.setCellText(text.substring(0, 10), col, row);
				}
			}
			
			if (col == _col.venueNm) {
				if (text.length > 50) {
					this.setCellText(text.substring(0, 50), col, row);
				}
			}
		};

		grid.onCellValidated = function(text, col, row) {
		};
		//  END validated Action (Enter, Cell LoseFocus)
	}

	function closeTerritoryPopup_grid(data, row) {
		grid.setCellText(data.territoryCDName, _col.territoryCDName, row);
		grid.setCellText(data.territoryCD, _col.territoryCD, row);
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
		
   		if (!popupChk(row)) {
   			return false;
  		}
	}

	//address popup check & code mapping
 	function popupChk(row) {
   	
 		if (setAddrTpCD1(row) && setAddrTpCD2(row) && setAddrTpCD3(row)) {			
 			return true;
 		} else {
 			return false;
 		}
 	}
	
 	//시도 check
 	function setAddrTpCD1(row) {
 		var addrTpCD1_S = grid.getCellText(_col.addrTpCD1Name, row);
 		
 		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500107S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "ADDRTPCD1");
 		table.setParameter("attrib04", addrTpCD1_S);
 	  	table.request();
   	 
 		if (table.getCount() == 1) {			
 			grid.setCellText(table.getData(0,0), _col.addrTpCD1, row);
 			return true;
 		} else {
 			resetAddr(row);
 			alert("시도("+ addrTpCD1_S +")가 일치하지 않습니다.");
 			return false;
 		}
 	}
 	
 	//시군구 check
 	function setAddrTpCD2(row) {
 		var addrTpCD2_S = grid.getCellText(_col.addrTpCD2Name, row);
 		
 		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500107S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "ADDRTPCD2");
 		table.setParameter("attrib02", grid.getCellText(_col.addrTpCD1, row));
 		table.setParameter("attrib04", addrTpCD2_S);
 	  	table.request();
   	
 		if (table.getCount() == 1) {			
 			grid.setCellText(table.getData(0,0), _col.addrTpCD2, row);
 			return true;
 		} else {
 			resetAddr(row);
 			alert("시군구("+ addrTpCD2_S +")가  일치하지 않습니다.");
 			return false;
 		}
 	}
 	
 	//읍면동리 check
 	function setAddrTpCD3(row) {
 		var addrTpCD3_S = grid.getCellText(_col.addrTpCD3Name, row);
 		
 		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500107S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "ADDRTPCD3");
 		table.setParameter("attrib02", grid.getCellText(_col.addrTpCD2, row));
 		table.setParameter("attrib04", addrTpCD3_S);
 	  	table.request();
 	  	
 		if (table.getCount() == 1) {			
 			grid.setCellText(table.getData(0,0), _col.addrTpCD3, row);
 			return true;
 		} else {
 			resetAddr(row);
 			alert("읍면동리(" + addrTpCD3_S + ")가 일치하지 않습니다.");
 			return false;
 		}
 	}
 	
	// address reset
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

</script>

<script type="text/javascript">

	/**********************************************
	* fileupload setting
	*
	*********************************************/
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
	            url : "${contextPath}/service/mdm05/extractTmpVenueXls",
	            enctype : "multipart/form-data",
	            data : 
					{
	            	empID :"${params.empID}"
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