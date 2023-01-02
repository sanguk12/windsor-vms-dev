<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <%@include file="../sys3/scripts.jsp" %>
    </head>
    
    <body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post"> 
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td height="1" valign="top">
						<%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
					</td>
				</tr>
				<tr>
					<td height="*" valign="top">
						<table border="0" cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td class="tb-border" height="1" valign="top">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
										<colgroup>
											<col style="width:8%;"></col>
											<col style="width:10%;"></col>
											<col style="width:8%;"></col>
											<col style="width:8%;"></col>
											<col style="width:8%;"></col>
											<col style="width:10%;"></col>
											<col style="width:8%;"></col>
											<col style="width:8%;"></col>
											<col style="width:10%;"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM02001B.venueCD"/>
												</td>
												<td class="td-input" colspan="3">
													<input type="text" id="venueCD" name="venueCD" style="width:130px;" maxlength="10" class="input-readonly" readonly/>
													&nbsp;<span id="inputVenueinfo_btn"></span>
												</td>
												<td class="td-cond"><fmt:message key="MDM05001A.venueNm"/>
												</td>
												<td class="td-input" colspan="2">
													<input type="text" id="venueNm" name="venueNm" style="width:150px;" maxlength="50"/>
												</td>
												<td class="td-cond"><fmt:message key="MDM05001B.aging"/>
												</td>
												<td class="td-input" colspan="4">
													<nis:selectbox id="agingCD" name="agingCD" defaultText="select" category="AGEINGCD" style="width:130px;"/>	<!-- event="onchange" eventproc="getSegment(this.value);"  -->
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="MDM02001B.territoryCD"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:popup id="territory" nameID="territoryCDName" keyID="territoryCD" />
												</td>
												<td class="td-cond"><fmt:message key="MDM02001B.activeYN"/>
												</td>
												<td class="td-input" colspan="2">
													<nis:radio id="activeYN" name="activeYN" category="ACTIVEYN" />
												</td>
												<td class="td-cond"><fmt:message key="MDM02001B.venueGradCD"/>
												</td>
												<td class="td-input" colspan="4">
													<nis:selectbox id="venueGradCD" name="venueGradCD" defaultText="select"  query="SYS0001S" paramkey="codeDiv;attrib01;" paramvalue="VENUEGRADCD;C;" style="width:130px;" />
												</td>
											</tr>
												<tr>
												<td class="td-cond"><fmt:message key="MDM05001B.jibunAddrTpCD"/>
												</td>
												<td class="td-input" colspan="6">
													<input type="text" id="addrTpCD1Name_j" name="addrTpCD1Name_j" class="input-readonly" style="width:130px;" readonly />
													<input type="text" id="addrTpCD2Name_j" name="addrTpCD2Name_j" class="input-readonly" style="width:130px;" readonly />
													<input type="text" id="addrTpCD3Name_j" name="addrTpCD3Name_j" class="input-readonly" style="width:130px;" readonly />
													<input type="text" id="oldAddr2" name="oldAddr2" class="input" style="width:150px;" />
													<img id="addr_popup" src="/images/common/search_popup.gif" hspace="3" style="vertical-align:middle;cursor:pointer" />
												</td>
												<td class="td-cond"><fmt:message key="MDM05001B.ReserveSegment"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="reserveSegmentCD" name="reserveSegmentCD" defaultText="select" category="RESERVESEGMENTCD" style="width:130px;"/>	<!-- event="onchange" eventproc="getSegment(this.value);"  -->
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="MDM05001B.roadAddrTpCD"/>
												</td>
												<td class="td-input" colspan="6">
													<input type="text" id="postCD" name="newPostCD" class="input-readonly" style="width:130px;" />
													<input type="text" id="newAddr" name="newAddr" class="input" style="width:426px;" />
												</td>
												<td class="td-cond"><fmt:message key="MDM05001B.fascia"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="fasciaCD" name="fasciaCD" defaultText="select" category="FASCIACD" style="width:130px;"/>	<!-- event="onchange" eventproc="getSegment(this.value);"  -->
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="MDM02001B.channelCD"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="channelCD" name="channelCD" defaultText="select" category="CHANNELCD" event="onchange" eventproc="getSubChannel(this.value);" style="width:130px;" />
												</td>
												<td class="td-cond"><fmt:message key="MDM02001B.subChannelCD"/>
												</td>
												<td class="td-input" colspan="2">
													<nis:selectbox id="subChannelCD" name="subChannelCD" defaultText="select" category="SUBCHANNELCD" event="onchange" eventproc="getSegment(this.value);" style="width:150px;"/>	<!-- event="onchange" eventproc="getSegment(this.value);"  -->
												</td>
												<td class="td-cond"><fmt:message key="MDM05001B.site"/>
												</td>
												<td class="td-input" colspan="4">
													<nis:selectbox id="siteCD" name="siteCD" defaultText="select" category="SITECD" style="width:130px;"/>	<!-- event="onchange" eventproc="getSegment(this.value);"  -->
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="MDM02001B.segmentCD"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="segmentCD" name="segmentCD" defaultText="select" category="SEGMENTCD" event="onchange" eventproc="getSubSegment(this.value);" style="width:130px;" />
												</td>
												<td class="td-cond"><fmt:message key="MDM02001B.subSegmentCD"/>
												</td>
												<td class="td-input" colspan="2">
													<nis:selectbox id="subSegmentCD" name="subSegmentCD" defaultText="select" category="SUBSEGMENTCD" style="width:150px;"/>
												</td>
												<td class="td-cond"><fmt:message key="MDM02001B.incntTpCD"/>
												</td>
												<td class="td-input"  colspan="4">
													<nis:selectbox id="incntTpCD" name="incntTpCD" defaultText="select" category="INCNTTPCD" style="width:130px;"/>
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="MDM05001B.existingLocationYN"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="locationCD" name="locationCD" defaultText="select" category="LOCATIONCD" event="onchange" eventproc="getMdVenueCD(this.value);" style="width:130px;"/>
												</td>
												<td class="td-cond"><fmt:message key="MDM05001A.mdVenueCD"/>
												</td>
												<td class="td-input">
													<input type="text" id="mdVenueCD" name="mdVenueCD" style="width:130px;" maxlength="10" class="input-readonly"/>
												</td>
												<td class="td-cond"><fmt:message key="MDM05001B.mdDuplicateYN"/>
												</td>
												<td class="td-input" colspan="2">
													<nis:radio id="mdDupYN" name="mdDupYN" category="ACTIVEYN" />
												</td>
												<td class="td-cond"><fmt:message key="MDM05001B.legal"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="legalCD" name="legalCD" defaultText="select" category="LEGALCD" event="onchange" eventproc="getVenueGradeCD(this.value);" style="width:130px;" />
											<!-- 	<nis:selectbox id="venueDivCD" name="venueDivCD" defaultText="select" category="VENUEDIVCD" style="width:130px;" /> -->
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="MDM05001B.kegYN"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:radio id="kegYN" name="kegYN" category="ACTIVEYN" />
												</td>
												<td class="td-cond"><fmt:message key="MDM05001B.phoneNo"/>
												</td>
												<td class="td-input" colspan="7">
													<input type="text" id="phoneNo" name="phoneNo" style="width:150px" />
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="MDM05001B.WS1"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="ws1CD" name="ws1CD" defaultText="select" category="WSCD" event="onchange" eventproc="chgWs1CD(this.value);" style="width:130px;" />
													<input type="hidden" id="ws1SapCD" name="ws1SapCD" />
													<input type="text" id="ws1SapCDName" name="ws1SapCDName" class="input-readonly" style="width:210px;" readonly />
													<img id="ws1_popup" src="/images/common/search_popup.gif" hspace="3" style="vertical-align:middle;cursor:pointer" />
												</td>
												<td class="td-cond" style="width:120px;" ><fmt:message key="MDM05001B.WS2"/>
												</td>
												<td class="td-input" colspan="7">
													<nis:selectbox id="ws2CD" name="ws2CD" defaultText="select" category="WSCD" event="onchange" eventproc="chgWs2CD(this.value);" style="width:130px;" />
													<input type="hidden" id="ws2SapCD" name="ws2SapCD" />
													<input type="text" id="ws2SapCDName" name="ws2SapCDName" class="input-readonly" style="width:210px;" readonly />
													<img id="ws2_popup" src="/images/common/search_popup.gif" hspace="3" style="vertical-align:middle;cursor:pointer" />
												</td>
											</tr>
											<tr>
												<td class="td-cond"><fmt:message key="MDM05001B.WS3"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="ws3CD" name="ws3CD" defaultText="select" category="WSCD" event="onchange" eventproc="chgWs3CD(this.value);" style="width:130px;" />
													<input type="hidden" id="ws3SapCD" name="ws3SapCD" />
													<input type="text" id="ws3SapCDName" name="ws3SapCDName" class="input-readonly" style="width:210px;" readonly />
													<img id="ws3_popup" src="/images/common/search_popup.gif" hspace="3" style="vertical-align:middle;cursor:pointer" />
												</td>
												<td class="td-cond"><fmt:message key="MDM05001B.WS4"/>
												</td>
												<td class="td-input" colspan="7">
													<nis:selectbox id="ws4CD" name="ws4CD" defaultText="select" category="WSCD" event="onchange" eventproc="chgWs4CD(this.value);" style="width:130px;" />
													<input type="hidden" id="ws4SapCD" name="ws4SapCD" />
													<input type="text" id="ws4SapCDName" name="ws4SapCDName" class="input-readonly" style="width:210px;" readonly />
													<img id="ws4_popup" src="/images/common/search_popup.gif" hspace="3" style="vertical-align:middle;cursor:pointer" value="4" />
												</td>
											</tr>
											<tr>
				                                <td class="td-cond" style="height:100%"><fmt:message key="MDM02001B.note1"/>
				                                </td>
				                                <td class="td-textarea" colspan="11">
				                                    <textarea id="note1" name="note1" style="width:100%; height:55px;"></textarea>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond" style="height:100%"><fmt:message key="MDM02001B.note2"/>
				                                </td>
				                                <td class="td-textarea" colspan="11">
				                                    <textarea id="note2" name="note2" style="width:100%; height:55px;"></textarea>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond" style="height:100%"><fmt:message key="MDM02001B.note3"/>
				                                </td>
				                                <td class="td-textarea" colspan="11">
				                                    <textarea id="note3" name="note3" style="width:100%; height:55px;"></textarea>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond" style="height:100%"><fmt:message key="MDM02001B.note4"/>
				                                </td>
				                                <td class="td-textarea" colspan="11">
				                                    <textarea id="note4" name="note4" style="width:100%; height:55px;"></textarea>
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
					<td height="1">
						<input type="hidden" id="addrTpCD1_j" name="addrTpCD1_j" />
						<input type="hidden" id="addrTpCD2_j" name="addrTpCD2_j" />
						<input type="hidden" id="addrTpCD3_j" name="addrTpCD3_j" />
						<input type="hidden" id="oldAddr1" name="oldAddr1" />
					
						<input type="hidden" id="newAddr1" name="newAddr1" />
						<input type="hidden" id="newAddr2" name="newAddr2" />	
					
						<input type="hidden" id="activeFlg" name="activeFlg" />
						<input type="hidden" id="dkmdTpCD" name="dkmdTpCD" />
						<input type="hidden" id="requestStateCD" name="requestStateCD" />
						<input type="hidden" id="printYN" name="printYN" />
						<input type="hidden" id="saveChk" name="saveChk" />
						<input type="hidden" id="tmpVenueCD" name="tmpVenueCD" />
						<input type="hidden" id="selPopupVenueCD" name="selPopupVenueCD" />
						
						<input type="hidden" id="sellingAreaID" name="sellingAreaID" />
						<input type="hidden" id="refNo" name="refNo" />
						<input type="hidden" id="customerID" name="customerID" />
						<input type="hidden" id="customerNm" name="customerNm" />
						<input type="hidden" id="country" name="country" />
						<input type="hidden" id="rageSphereCD" name="rageSphereCD" />
						<input type="hidden" id="teamCD" name="teamCD" />
						<input type="hidden" id="repNm" name="repNm" />
						<input type="hidden" id="repNm_KR" name="repNm_KR" />
						<input type="hidden" id="sellingAreaNm" name="sellingAreaNm" />
						<input type="hidden" id="legacyFrontOfficeAccountNo" name="legacyFrontOfficeAccountNo" />
						<input type="hidden" id="legacyBackOfficeAccountNo" name="legacyBackOfficeAccountNo" />
						<input type="hidden" id="license" name="license" />
						<input type="hidden" id="createDate" name="createDate" />
						<input type="hidden" id="sellingAreaCreatedDate" name="sellingAreaCreatedDate" />
						<input type="hidden" id="lastModifiedDate" name="lastModifiedDate" />
						<input type="hidden" id="sellingAreaLastModifiedDate" name="sellingAreaLastModifiedDate" />
						<input type="hidden" id="lastModifiedBy" name="lastModifiedBy" />
						<input type="hidden" id="commt" name="commt" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<script type="text/javascript">
	//document.domain 〓 "127.0.0.1:7001";
	
    /****************************************
    * Function
    ****************************************/
     
    $(function() {
	});
	
	$(document).ready(function() {
		
		$("#incntTpCD").attr("disabled",true);
		$("#incntTpCD").addClass("input-readonly");
		
		window.onload = function() {
			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
		};

		${initScript}
		
		$("#territory").keypress(function(){
			if (event.keyCode==13){
				getTerritoryName("territory", "territoryCD", "territoryCDName");
			}
		});
		$("#territory_popup").click(function(){
			openTerritoryPopup("closeTerritoryPopup");
		});
		$("#addr_popup").click(function(){
			openAddrPopup('closeAddrPopUp');
		});
		
		$("#legalCD").click(function(a){
			getVenueGradeCD();
		});
		
		$("#ws1_popup").click(function(a){
			openWSPopup("closeWS1Popup", "ws1CD");
		});
		
		$("#ws2_popup").click(function(a){
			openWSPopup("closeWS2Popup", "ws2CD");
		});
		
		$("#ws3_popup").click(function(a){
			openWSPopup("closeWS3Popup", "ws3CD");
		});
		
		$("#ws4_popup").click(function(a){
			openWSPopup("closeWS4Popup", "ws4CD");
		});
		
		$("#addrTpCD4Name").keypress(function(){
			if (event.keyCode==13){				
				//popupChk();				
				return false;
			}
		});		
	});
	

	var inputVenueinfo_btn = new AW.UI.Button;
	inputVenueinfo_btn.setId("inputVenueinfo_btn");
	inputVenueinfo_btn.setControlText("업소찾기");
	inputVenueinfo_btn.refresh();
	
	inputVenueinfo_btn.onControlClicked = function(event) {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM06001D"
					+"&finalAction="+"closeInputVenueInfoPopup";
		
		
		newWindow(url, "MDM06001D", 900, 700,"yes");
	}
	
	//address popup check & code mapping
 	function popupChk() {
   	
 		if(setAddrTpCD1() && setAddrTpCD2() && setAddrTpCD3()) {			
 			return true;
 		}else{
 			return false;
 		}
 	}
 	
	//시도 check
 	function setAddrTpCD1() {
 		var addrTpCD1Name_j = $("#addrTpCD1Name_j").val();
 		
 		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500107S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "ADDRTPCD1");
 		table.setParameter("attrib04", addrTpCD1Name_j);
 	  	table.request();
   	
 		if (table.getCount() == 1) {			
 			$("#addrTpCD1_j").val(table.getData(0,0));
 			$("#addrTpCD1Name_j").val(table.getData(1,0));
 			return true;
 		} else {
 			resetAddr();
 			alert("시도("+ addrTpCD1Name_j +")가 일치하지 않습니다.");
 			return false;
 		}
 	}
 	
	//시군구 check
 	function setAddrTpCD2() {
 		var addrTpCD2_arr = $("#addrTpCD2Name_j").val().split(' ');
 		
 		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500107S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "ADDRTPCD2");
 		table.setParameter("attrib04", addrTpCD2_arr[0]);
 	  	table.request();
   	
 		if (table.getCount() == 1) {			
 			$("#addrTpCD2_j").val(table.getData(0,0));
 			$("#addrTpCD2Name_j").val(table.getData(1,0));
 			return true;
 		} else {
 			resetAddr();
 			alert("시군구("+ addrTpCD2_arr[0] +")가  일치하지 않습니다.");
 			return false;
 		}
 	}
 	
	//읍면동리 check
 	function setAddrTpCD3() {
 		var addrTpCD3Name_j = $("#addrTpCD3Name_j").val();
 		
 		var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/MDM0500107S");
 		table.setAsync(false);
 		table.setRequestMethod("POST");
 		table.setParameter("codeDiv", "ADDRTPCD3");
 		table.setParameter("attrib04", addrTpCD3Name_j);
 	  	table.request();
 	  	
 		if (table.getCount() == 1) {			
 			$("#addrTpCD3_j").val(table.getData(0,0));
 			$("#addrTpCD3Name_j").val(table.getData(1,0));
 			return true;
 		} else {
 			resetAddr();
 			alert("읍면동리(" + addrTpCD3Name_j + ")가 일치하지 않습니다.");
 			return false;
 		}
 	}
 	
	// address reset
 	function resetAddr() {
 		$("#newAddr").val("");
 		$("#newAddr1").val("");
 		$("#newAddr2").val("");
		$("#oldAddr1").val("");
		$("#postCD").val("");
		$("#addrTpCD1Name_j").val("");
		$("#addrTpCD1_j").val("");
		$("#addrTpCD2Name_j").val("");
		$("#addrTpCD2_j").val("");
		$("#addrTpCD3Name_j").val("");
		$("#addrTpCD3_j").val("");
		$("#oldAddr2").val("");
 	}
 	
	function closeTerritoryPopup(data) {
		$("#territory").val(data.territoryCD);
		$("#territoryCD").val(data.territoryCD);
        $("#territoryCDName").val(data.territoryCDName);
	}
	
	function closeWS1Popup(data) {
		$("#ws1CD").val(data.wsCD);
		$("#ws1SapCD").val(data.wsSapCD);
		$("#ws1SapCDName").val(data.wsSapCDName);
	}
	
	function closeWS2Popup(data) {
		$("#ws2CD").val(data.wsCD);
		$("#ws2SapCD").val(data.wsSapCD);
		$("#ws2SapCDName").val(data.wsSapCDName);
	}
	
	function closeWS3Popup(data) {
		$("#ws3CD").val(data.wsCD);
		$("#ws3SapCD").val(data.wsSapCD);
		$("#ws3SapCDName").val(data.wsSapCDName);
	}
	
	function closeWS4Popup(data) {
		$("#ws4CD").val(data.wsCD);
		$("#ws4SapCD").val(data.wsSapCD);
		$("#ws4SapCDName").val(data.wsSapCDName);
	}
	
	function chgWs1CD(val) {
		$("#ws1SapCD").val("");
		$("#ws1SapCDName").val("");
	}
	
	function chgWs2CD(val) {
		$("#ws2SapCD").val("");
		$("#ws2SapCDName").val("");
	}
	
	function chgWs3CD(val) {
		$("#ws3SapCD").val("");
		$("#ws3SapCDName").val("");
	}
	
	function chgWs4CD(val) {
		$("#ws4SapCD").val("");
		$("#ws4SapCDName").val("");
	}
		
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getSubChannel(code) {

		if (code == "") {
			selectBoxReset("channel");
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "SUBCHANNELCD");
	  	table.setParameter("attrib02", code);
     	table.request();
		
     	if(table.getCount() > 0) {
	     	$("#subChannelCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#subChannelCD").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#subChannelCD").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#subChannelCD").attr("disabled",false);
    		$("#subChannelCD").removeClass("input-readonly");
		}
    	$("#segmentCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#segmentCD").attr("disabled",true);
   		$("#segmentCD").addClass("input-readonly");
   		$("#subSegmentCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#subSegmentCD").attr("disabled",true);
   		$("#subSegmentCD").addClass("input-readonly");
	}
	
	function getSegment(code) {
		
		if (code == "") {
			selectBoxReset("subChannel");
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "SEGMENTCD");
	  	table.setParameter("attrib02", code);
     	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#segmentCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#segmentCD").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#segmentCD").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#segmentCD").attr("disabled",false);
    		$("#segmentCD").removeClass("input-readonly");
     	}
     	$("#subSegmentCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#subSegmentCD").attr("disabled",true);
   		$("#subSegmentCD").addClass("input-readonly");
	}
	
	function getSubSegment(code) {
		
		if (code === "") {
			selectBoxReset("segment");
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "SUBSEGMENTCD");
	  	table.setParameter("attrib02", code);
     	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#subSegmentCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#subSegmentCD").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#subSegmentCD").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#subSegmentCD").attr("disabled",false);
    		$("#subSegmentCD").removeClass("input-readonly");
     	}
	}
	
	function selectBoxReset(code) {
		
		if(code == "channel") {
			$("#subChannelCD").val("");
			$("#subChannelCD").attr("disabled",true);
			$("#subChannelCD").addClass("input-readonly");
		}

		if(code == "channel" || code == "subChannel") {
			$("#segmentCD").val("");
			$("#segmentCD").attr("disabled",true);
			$("#segmentCD").addClass("input-readonly");
		}
		
		if(code == "subChannel" || code == "segment") {
			$("#subSegmentCD").val("");
			$("#subSegmentCD").attr("disabled",true);
			$("#subSegmentCD").addClass("input-readonly");
		}
			
	}
	
	function getVenueGradeCD(code) {
		var gradeDivCD = "";
		
		$("#venueGradCD").val("");
		
		//legalCD
		switch(code) {
			case "10" :
				gradeDivCD = "LOCALGRADCD";
				break;
			case "20" :
				gradeDivCD = "INTGRADCD";
				break;
			case "30" :
				gradeDivCD = "BEERGRADCD";
				break;
			case "40" :
				gradeDivCD = "RESERVEGRADCD";
				break;
			default :  		
				gradeDivCD = "LOCALGRADCD";
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("codeDiv", gradeDivCD);
     	table.request();
     	
    	if(table.getCount() > 0) {
	     	$("#venueGradCD").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#venueGradCD").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#venueGradCD").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
     	}
	}
	
	function openAddrPopup(finalAction, rowNum){
		
		window.name='mainwin';
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}"
				+"&viewID=MDM05001D"
				+"&finalAction="+finalAction
				+"&territoryCD="+"${params.territoryCD}"
				+"&rowNum="+rowNum;
		
		newWindow(url, "MDM05001D",600,350,"yes");
	}
	

	function closeAddrPopUp(data) {
		var detail_r = "",
	 	detail_j = "";

		$("#postCD").val(data.zipNo);
	
		detail_r  = data.buldSlno > 0 ? data.buldMnnm + "-" + data.buldSlno : data.buldMnnm;
		$("#newAddr").val(data.roadFullAddr + " " +  detail_r + " " + data.addrDetail);
		$("#newAddr1").val(data.roadFullAddr);
		$("#newAddr2").val(detail_r + " " + data.addrDetail);
	   
		$("#oldAddr1").val(data.jibunAddr);
		$("#addrTpCD1Name_j").val(data.siNm);
		$("#addrTpCD2Name_j").val(data.sggNm);
		$("#addrTpCD3Name_j").val(data.emdNm);
		detail_j = data.lnbrSlno > 0 ? data.lnbrMnnm + "-" + data.lnbrSlno : data.lnbrMnnm;
		$("#oldAddr2").val(detail_j + " " + data.addrDetail);
		
		if(!popupChk()) {
			return;
		}
	}
	
	function closeInputVenueInfoPopup(data) {
		$("#selPopupVenueCD").val(data.venueCD);
		Search();
	}
	
	function setTerritoryCD() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("codeDiv", "TERRITORYCD");
	  	table.setParameter("comCode", "${params.territoryCD}");
     	table.request();
     	
     	if(table.getCount() > 0) {
     		$("#territory").val(table.getData(0,0));
     		$("#territoryCD").val(table.getData(0,0));
     		$("#territoryCDName").val(table.getData(1,0));
     	}	
	}
	
	function setLegalCD() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/MDM0500112S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("empID", "${params.empID}");
     	table.request();
     	
     	if(table.getCount() > 0) {
   			$("#legalCD").val(table.getData(0,0));
     	}	
	}
	
	
	function getMdVenueCD(code) {
 		if(code == 30) {
			$("#mdVenueCD").attr("disabled",false);
    		$("#mdVenueCD").removeClass("input-readonly");
		}else {
			$("#mdVenueCD").val("");
			$("#mdVenueCD").attr("disabled",true);
    		$("#mdVenueCD").addClass("input-readonly");
		}
 		
 	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	//수정
	function Update() {
		$("#activeFlg").val("I");
		$("#venueCD").val("");
		$("#venueNm").val("");
		$("#agingCD").val("");
		$("#dkmdTpCD").val("${params.dkmdTpCD}");
		setTerritoryCD();
		$("#reserveSegmentCD").val("");
		$("#venueGradCD").val("");
		setRadioValue("activeYN", "Y");
		setRadioValue("kegYN", "N");
		
		$("#newAddr").val("");
		$("#newAddr1").val("");
		$("#newAddr2").val("");
 		$("#oldAddr1").val("");
		$("#postCD").val("");
		
		$("#locationCD").val("");
		$("#mdVenueCD").val("");
		$("#mdVenueCD").attr("disabled",true);
		$("#mdVenueCD").addClass("input-readonly");
		
		resetAddr();
		
		$("#fasciaCD").val("");
		
		$("#channelCD").val("");
		$("#subChannelCD").val("");
		$("#subChannelCD").attr("disabled",true);
		$("#subChannelCD").addClass("input-readonly");
		$("#siteCD").val("");
		
		$("#segmentCD").val("");
		$("#segmentCD").attr("disabled",true);
		$("#segmentCD").addClass("input-readonly");
		$("#subSegmentCD").val("");
		$("#subSegmentCD").attr("disabled",true);
		$("#subSegmentCD").addClass("input-readonly");
		$("#phoneNo").val("");
		
		$("#incntTpCD").val("VEN");
		$("#incntTpCD").attr("disabled",true);
		$("#incntTpCD").addClass("input-readonly");
		
// 		setLegalCD();
// 		getVenueGradeCD($("#legalCD").val());
		
		setRadioValue("mdDupYN", "N");
		
		$("#ws1CD").val("");
		$("#ws1SapCD").val("");
		$("#ws1SapCDName").val("");
		$("#ws1SapCD").attr("disabled",true);
		$("#ws1SapCD").addClass("input-readonly");

		$("#ws2CD").val("");
		$("#ws2SapCD").val("");
		$("#ws2SapCDName").val("");
		$("#ws2SapCD").attr("disabled",true);
		$("#ws2SapCD").addClass("input-readonly");

		$("#ws3CD").val("");
		$("#ws3SapCD").val("");
		$("#ws3SapCDName").val("");
		$("#ws3SapCD").attr("disabled",true);
		$("#ws3SapCD").addClass("input-readonly");

		$("#ws4CD").val("");
		$("#ws4SapCD").val("");
		$("#ws4SapCDName").val("");
		$("#ws4SapCD").attr("disabled",true);
		$("#ws4SapCD").addClass("input-readonly");
		
		$("#note1").val("");
		$("#note2").val("");
		$("#note3").val("");
		$("#note4").val("");
		
		$("#sellingAreaID").val("");
		$("#refNo").val("");
		$("#customerID").val("");
		$("#customerNm").val("");
		$("#country").val("");
		$("#rageSphereCD").val("");
		$("#teamCD").val("");
		$("#repNm").val("");
		$("#repNm_KR").val("");
		$("#sellingAreaNm").val("");
		$("#legacyFrontOfficeAccountNo").val("");
		$("#legacyBackOfficeAccountNo").val("");
		$("#license").val("");
		$("#createDate").val("");
		$("#sellingAreaCreatedDate").val("");
		$("#lastModifiedDate").val("");
		$("#sellingAreaLastModifiedDate").val("");
		$("#lastModifiedBy").val("");
		$("#commt").val("");
	}
    
    var _i = 0;
    var _col = {
    	  venueCD                 		: _i++
	    , venueNm                 		: _i++
	    , agingCD                 		: _i++
	    , dkmdTpCD                		: _i++
	    , territoryCD             		: _i++
	    , territoryCDName         		: _i++
	    , reserveSegmentCD        		: _i++
	    , venueGradCD				    : _i++
	    , activeYN                      : _i++
	    , kegYN                         : _i++
		, newAddr 						: _i++
	    , addrTpCD1                     : _i++
	    , addrTpCD2                     : _i++
	    , addrTpCD3                     : _i++
// 	    , addrTpCD4                     : _i++
	    , addrTpCD1Name                 : _i++
	    , addrTpCD2Name                 : _i++
	    , addrTpCD3Name                 : _i++
// 	    , addrTpCD4Name                 : _i++
	    , locationCD                    : _i++
	    , fasciaCD                      : _i++
	    , channelCD                     : _i++
	    , subChannelCD                  : _i++
	    , siteCD                        : _i++
	    , segmentCD                     : _i++
	    , subSegmentCD                  : _i++
	    , phoneNo                       : _i++
	    , incntTpCD                     : _i++
		, legalCD                       : _i++
	    , mdDupYN                       : _i++
	    , ws1CD                         : _i++
	    , ws1SapCD                      : _i++
	    , ws1SapCDName                  : _i++
	    , ws2CD                         : _i++
	    , ws2SapCD                      : _i++
	    , ws2SapCDName                  : _i++
	    , ws3CD                         : _i++
	    , ws3SapCD                      : _i++
	    , ws3SapCDName                  : _i++
	    , ws4CD                         : _i++
	    , ws4SapCD                      : _i++
	    , ws4SapCDName                  : _i++
	    , note1                         : _i++
	    , note2                         : _i++
	    , note3                         : _i++
	    , note4                         : _i++
	    , requestStateCD                : _i++
	    , printYN                       : _i++
	    , postCD                        : _i++
	    , oldAddr1                      : _i++
	    , newAddr1                      : _i++
	    , oldAddr2                      : _i++
   		, newAddr2                      : _i++
   		, mdVenueCD                     : _i++
   		, sellingAreaID                 : _i++     
   		, refNo                         : _i++     
   		, customerID                    : _i++     
   		, customerNm                    : _i++     
   		, country                       : _i++     
   		, rageSphereCD                  : _i++     
   		, teamCD                        : _i++     
   		, repNm                         : _i++     
   		, repNm_KR                      : _i++     
   		, sellingAreaNm                 : _i++     
   		, legacyFrontOfficeAccountNo    : _i++     
   		, legacyBackOfficeAccountNo     : _i++     
   		, license                       : _i++     
   		, createDate                    : _i++     
   		, sellingAreaCreatedDate        : _i++     
   		, lastModifiedDate              : _i++     
   		, sellingAreaLastModifiedDate   : _i++     
   		, lastModifiedBy                : _i++     
   		, commt                         : _i++     
    };
    
    function Search() {
    	var query = parent.$("#selectVenueCD").val().length > 0 ? "MDM0600102S" : "MDM0600103S";
    	var venueCD_param = parent.$("#selectVenueCD").val().length > 0 ? parent.$("#selectVenueCD").val() : $("#selPopupVenueCD").val();
    	var requestDate_param = parent.$("#selectVenueCD").val().length > 0 ? convertDate(parent.$("#selectRequestDate").val()) : convertDate("${params.currentDate}");
    	var activeFlg_param = parent.$("#selectVenueCD").val().length > 0 ? "U" : "I";
    	
    	
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/" + query);
    	table.setAsync(false);
    	table.setRequestMethod("POST");
    	table.setParameter("venueCD", venueCD_param);
    	table.setParameter("requestDate", requestDate_param);
    	table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#activeFlg").val(activeFlg_param);
			$("#venueCD").val(table.getData(_col.venueCD,0));
			$("#venueNm").val(table.getData(_col.venueNm,0));
			$("#agingCD").val(table.getData(_col.agingCD,0));
			$("#dkmdTpCD").val(table.getData(_col.dkmdTpCD,0));
			$("#territory").val(table.getData(_col.territoryCD,0));
			$("#territoryCD").val(table.getData(_col.territoryCD,0));
			$("#territoryCDName").val(table.getData(_col.territoryCDName,0));
			$("#reserveSegmentCD").val(table.getData(_col.reserveSegmentCD,0));
			$("#venueGradCD").val(table.getData(_col.venueGradCD,0));
			setRadioValue("activeYN",table.getData(_col.activeYN,0));
			setRadioValue("kegYN",table.getData(_col.kegYN,0));
 			$("#newAddr").val(table.getData(_col.newAddr,0));
			$("#fasciaCD").val(table.getData(_col.fasciaCD,0));
 			$("#addrTpCD1_j").val(table.getData(_col.addrTpCD1,0));
 			$("#addrTpCD2_j").val(table.getData(_col.addrTpCD2,0));
 			$("#addrTpCD3_j").val(table.getData(_col.addrTpCD3,0));
 			$("#addrTpCD1Name_j").val(table.getData(_col.addrTpCD1Name,0));
 			$("#addrTpCD2Name_j").val(table.getData(_col.addrTpCD2Name,0));
 			$("#addrTpCD3Name_j").val(table.getData(_col.addrTpCD3Name,0));
			$("#siteCD").val(table.getData(_col.siteCD,0));
			$("#channelCD").val(table.getData(_col.channelCD,0));
			getSubChannel(table.getData(_col.channelCD,0));
			$("#subChannelCD").val(table.getData(_col.subChannelCD,0));
			getSegment(table.getData(_col.subChannelCD,0));
			$("#segmentCD").val(table.getData(_col.segmentCD,0));
			getSubSegment(table.getData(_col.segmentCD,0));
			$("#subSegmentCD").val(table.getData(_col.subSegmentCD,0));
 			$("#locationCD").val(table.getData(_col.locationCD,0));
			$("#phoneNo").val(table.getData(_col.phoneNo,0));
			$("#incntTpCD").val(table.getData(_col.incntTpCD,0));
// 			$("#venueDivCD").val(table.getData(_col.venueDivCD,0));
			$("#legalCD").val(table.getData(_col.legalCD,0));
			setRadioValue("mdDupYN",table.getData(_col.mdDupYN,0));
			$("#ws1CD").val(table.getData(_col.ws1CD,0));
			$("#ws1SapCD").val(table.getData(_col.ws1SapCD,0));
			$("#ws1SapCDName").val(table.getData(_col.ws1SapCDName,0));
			$("#ws2CD").val(table.getData(_col.ws2CD,0));
			$("#ws2SapCD").val(table.getData(_col.ws2SapCD,0));
			$("#ws2SapCDName").val(table.getData(_col.ws2SapCDName,0));
			$("#ws3CD").val(table.getData(_col.ws3CD,0));
			$("#ws3SapCD").val(table.getData(_col.ws3SapCD,0));
			$("#ws3SapCDName").val(table.getData(_col.ws3SapCDName,0));
			$("#ws4CD").val(table.getData(_col.ws4CD,0));
			$("#ws4SapCD").val(table.getData(_col.ws4SapCD,0));
			$("#ws4SapCDName").val(table.getData(_col.ws4SapCDName,0));
			$("#note1").val(table.getData(_col.note1,0));
			$("#note2").val(table.getData(_col.note2,0));
			$("#note3").val(table.getData(_col.note3,0));
			$("#note4").val(table.getData(_col.note4,0));
			$("#requestStateCD").val(table.getData(_col.requestStateCD,0));
			$("#printYN").val(table.getData(_col.printYN,0));
			$("#postCD").val(table.getData(_col.postCD,0));
			$("#oldAddr1").val(table.getData(_col.oldAddr1,0));
			$("#newAddr1").val(table.getData(_col.newAddr1,0));
			$("#oldAddr2").val(table.getData(_col.oldAddr2,0));
			$("#newAddr2").val(table.getData(_col.newAddr2,0));
			$("#mdVenueCD").val(table.getData(_col.mdVenueCD,0));
			$("#sellingAreaID").val(table.getData(_col.sellingAreaID,0));
			$("#refNo").val(table.getData(_col.refNo,0));
			$("#customerID").val(table.getData(_col.customerID,0));
			$("#customerNm").val(table.getData(_col.customerNm,0));
			$("#country").val(table.getData(_col.country,0));
			$("#rageSphereCD").val(table.getData(_col.rageSphereCD,0));
			$("#teamCD").val(table.getData(_col.teamCD,0));
			$("#repNm").val(table.getData(_col.repNm,0));
			$("#repNm_KR").val(table.getData(_col.repNm_KR,0));
			$("#sellingAreaNm").val(table.getData(_col.sellingAreaNm,0));
			$("#legacyFrontOfficeAccountNo").val(table.getData(_col.legacyFrontOfficeAccountNo,0));
			$("#legacyBackOfficeAccountNo").val(table.getData(_col.legacyBackOfficeAccountNo,0));
			$("#license").val(table.getData(_col.license,0));
			$("#createDate").val(table.getData(_col.createDate,0));
			$("#sellingAreaCreatedDate").val(table.getData(_col.sellingAreaCreatedDate,0));
			$("#lastModifiedDate").val(table.getData(_col.lastModifiedDate,0));
			$("#sellingAreaLastModifiedDate").val(table.getData(_col.sellingAreaLastModifiedDate,0));
			$("#lastModifiedBy").val(table.getData(_col.lastModifiedBy,0));
			$("#commt").val(table.getData(_col.commt,0));
			
			getMdVenueCD(table.getData(_col.locationCD,0));
			
			if (!parent.$("#selectVenueCD").val().length > 0) {
				
				if (getRadioValue("activeYN") == "N") {
					$("#territory").val("");
					$("#territoryCD").val("");
					$("#territoryCDName").val("");
				}
			}
			
			
	  		$("#venueCD").attr("readonly",true);
			$("#venueCD").addClass("input-readonly");
			
			$("#subChannelCD").attr("disabled",false);
			$("#subChannelCD").removeClass("input-readonly");
			$("#segmentCD").attr("disabled",false);
			$("#segmentCD").removeClass("input-readonly");
			$("#subSegmentCD").attr("disabled",false);
			$("#subSegmentCD").removeClass("input-readonly");
			
			if ($("#activeFlg").val() == "U") {
				$("#inputVenueinfo_btn").hide();
			} 
		}
	}
    
	function Save() {
		var regExp1= /^\d{2,3}-\d{3,4}-\d{4}$/,
			regExp2= /^01[016789]$/;
		
// 		if($("#venueNm").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg1"/>");
// 			$("#venueNm").focus();
// 			return;
// 		}
// 		if($("#territoryCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg3"/>");
// 			$("#territoryCD").focus();
// 			return;
// 		}
// 		if($("#venueGradCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg4"/>");
// 			$("#venueGradCD").focus();
// 			return;
// 		}
// 		if($("#channelCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg5"/>");
// 			$("#channelCD").focus();
// 			return;
// 		}
// 		if($("#subChannelCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg6"/>");
// 			$("#subChannelCD").focus();
// 			return;
// 		}
// 		if($("#segmentCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg7"/>");
// 			$("#segmentCD").focus();
// 			return;
// 		}
// 		if($("#subSegmentCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg8"/>");
// 			$("#subSegmentCD").focus();
// 			return;
// 		}
// 		if($("#addrTpCD1_r").val() == "" && 
// 				$("#addrTpCD1_j").val() == "" ) {
// 			alert("<fmt:message key="MDM05001B.msg9"/>");
// 			$("#addrTpCD4Name_r").focus();
// 			return;
// 		}
// 		if($("#agingCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg10"/>");
// 			$("#agingCD").focus();
// 			return;
// 		}
// 		if($("#reserveSegmentCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg11"/>");
// 			$("#reserveSegmentCD").focus();
// 			return;
// 		}
// 		if($("#locationCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg12"/>");
// 			$("#locationCD").focus();
// 			return;
// 		}
// 		if($("#fasciaCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg13"/>");
// 			$("#fasciaCD").focus();
// 			return;
// 		}	
// 		if($("#siteCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg14"/>");
// 			$("#siteCD").focus();
// 			return;
// 		}
//  		if($("#incntTpCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg15"/>");
// 			$("#incntTpCD").focus();
// 			return;
// 		}
// 		if($("#legalCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg16"/>");
// 			$("#legalCD").focus();
// 			return;
// 		}
// 		if($("#ws1CD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg18"/>");
// 			$("#ws1CD").focus();
// 			return;
// 		}
// 		if($("#ws1SapCD").val() == "") {
// 			alert("<fmt:message key="MDM05001B.msg19"/>");
// 			$("#ws1SapCD").focus();
// 			return;
// 		}
		
		if($("#printYN").val() == "Y") {
			alert("<fmt:message key="MDM05001B.msg20"/>");
			return;
		} else {
			if($("#requestStateCD").val() == "50" || $("#requestStateCD").val() == "40" ) {
				$("#saveChk").val("Y");
			}
		}
		
		if($("#phoneNo").val().length > 0) {
			if(!regExp1.test($("#phoneNo").val())) {
 				alert("<fmt:message key="MDM05001B.msg21"/>");
 				$("#phoneNo").focus();
 				return;
 			}
  			if(regExp2.test($("#phoneNo").val().substring(0,3))) {
  				alert("<fmt:message key="MDM05001B.msg22"/>");
  				$("#phoneNo").focus();
  				return;
  			}						
 		}
// 		if($("#locationCD").val() == "30") {
// 			if($("#mdVenueCD").val() == "") {
// 				alert("<fmt:message key="MDM05001B.msg24"/>");
// 				$("#mdVenueCD").focus();
// 				return;
// 			}
// 		}	
		//승인 후 수정 시 reset 체크
// 		if($("#requestStateCD").val() == "50") {
// 			$("#saveChk").val("Y");
// 		}

// 		if($("#requestStateCD").val() == "20" || 
// 				$("#requestStateCD").val() == "30") {
// 			alert("<fmt:message key="MDM05001B.msg23"/>");
// 			return;
// 		}

		if(!venueCheck()) {
			alert("해당 업소가  승인요청, 승인중, 승인  상태입니다.");
			return;
		}
		
		
		var table = new AW.XML.Table;     
		table.setURL("${contextPath}/service/mdm06/modifyTmpVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("venueNm", $("#venueNm").val());
		table.setParameter("ageingCD", $("#agingCD").val());
		table.setParameter("dkmdTpCD", $("#dkmdTpCD").val());
		table.setParameter("territoryCD", $("#territoryCD").val());
		
		table.setParameter("reserveSegmentCD", $("#reserveSegmentCD").val());
		table.setParameter("venueGradCD", $("#venueGradCD").val());
		table.setParameter("activeYN", getRadioValue("activeYN"));
		table.setParameter("kegYN", getRadioValue("kegYN"));
		table.setParameter("addrTpCD1", $("#addrTpCD1_j").val());
		
		table.setParameter("addrTpCD2", $("#addrTpCD2_j").val());
		table.setParameter("addrTpCD3", $("#addrTpCD3_j").val());
		//table.setParameter("addrTpCD4", $("#addrTpCD4_r").val());
		table.setParameter("newAddr2", $("#newAddr2").val());
		table.setParameter("oldAddr2", $("#oldAddr2").val());
		
		table.setParameter("newAddr1", $("#newAddr1").val());
		table.setParameter("oldAddr1", $("#oldAddr1").val());
		table.setParameter("postCD", $("#postCD").val());
		table.setParameter("locationCD", $("#locationCD").val());
		table.setParameter("mdVenueCD", $("#mdVenueCD").val());
		
		table.setParameter("fasciaCD", $("#fasciaCD").val());
		table.setParameter("channelCD", $("#channelCD").val());
		table.setParameter("subChannelCD", $("#subChannelCD").val());
		table.setParameter("siteCD", $("#siteCD").val());
		table.setParameter("segmentCD", $("#segmentCD").val());
		
		table.setParameter("subSegmentCD", $("#subSegmentCD").val());
		table.setParameter("phoneNo", $("#phoneNo").val());
		table.setParameter("incntTpCD", $("#incntTpCD").val());
// 		table.setParameter("venueDivCD", $("#venueDivCD").val());
		table.setParameter("legalCD", $("#legalCD").val());
		
		table.setParameter("mdDupYN", getRadioValue("mdDupYN"));
		table.setParameter("ws1CD", $("#ws1CD").val());
		table.setParameter("ws1SapCD", $("#ws1SapCD").val());
		table.setParameter("ws2CD", $("#ws2CD").val());
		table.setParameter("ws2SapCD", $("#ws2SapCD").val());
		
		table.setParameter("ws3CD", $("#ws3CD").val());
		table.setParameter("ws3SapCD", $("#ws3SapCD").val());
		table.setParameter("ws4CD", $("#ws4CD").val());
		table.setParameter("ws4SapCD", $("#ws4SapCD").val());
		table.setParameter("note1", $("#note1").val());
		
		table.setParameter("note2", $("#note2").val());
		table.setParameter("note3", $("#note3").val());
		table.setParameter("note4", $("#note4").val());
		table.setParameter("printYN", $("#printYN").val());
		table.setParameter("saveChk", $("#saveChk").val());
		
		table.setParameter("activeFlg", $("#activeFlg").val());
		table.setParameter("requestDate", convertDate("${params.currentDate}"));
		table.setParameter("sellingAreaID", $("#sellingAreaID").val());
		table.setParameter("refNo", $("#refNo").val());
		table.setParameter("customerID", $("#customerID").val());
		
		table.setParameter("customerNm", $("#customerNm").val());
		table.setParameter("country", $("#country").val());
		table.setParameter("rageSphereCD", $("#rageSphereCD").val());
		table.setParameter("teamCD", $("#teamCD").val());
		table.setParameter("repNm", $("#repNm").val());
		
		table.setParameter("repNm_KR", $("#repNm_KR").val());
		table.setParameter("sellingAreaNm", $("#sellingAreaNm").val());
		table.setParameter("legacyFrontOfficeAccountNo", $("#legacyFrontOfficeAccountNo").val());
		table.setParameter("legacyBackOfficeAccountNo", $("#legacyBackOfficeAccountNo").val());
		table.setParameter("license", $("#license").val());
		
		table.setParameter("createDate", $("#createDate").val());
		table.setParameter("sellingAreaCreatedDate", $("#sellingAreaCreatedDate").val());
		table.setParameter("lastModifiedDate", $("#lastModifiedDate").val());
		table.setParameter("sellingAreaLastModifiedDate", $("#sellingAreaLastModifiedDate").val());
		table.setParameter("lastModifiedBy", $("#lastModifiedBy").val());
		
		table.setParameter("commt", $("#commt").val());
		///table.setParameter("requestStateCD", $("#requestStateCD").val());
		table.request();
		
		if (table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Update();
			//parent.$("#selectVenueCD").val(table.getData(3,0));
			//Search();
		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function List() {
		parent.Search();
		parent.appletClose();
	}
	
	function venueCheck() {
		var venueCD_param1 = parent.$("#selectVenueCD").val().length > 0 ? parent.$("#selectVenueCD").val() : $("#venueCD").val();
    	var requestDate_param2 = parent.$("#selectVenueCD").val().length > 0 ? convertDate(parent.$("#selectRequestDate").val()) : convertDate("${params.currentDate}");
		var flag = false;

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/MDM0600110S");
		table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","cnt;");
	  	table.setParameter("format", "str;");
	  	table.setParameter("venueCD", venueCD_param1);
	  	table.setParameter("requestDate",  requestDate_param2);
	  	table.setParameter("empID",  "${params.empID}");
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		if (table.getData(0,0) > 0) {
				flag = false;
      		}else {
	      		flag = true;
      		}
      	}
		
		return flag;
	}
	
	
	
</script>