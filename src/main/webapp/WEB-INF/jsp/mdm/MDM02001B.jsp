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
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:100px"></col>
											<col style="width:250px"></col>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM02001B.venueCD"/>
												</td>
												<td class="td-input">
													<input type="text" id="venueCD" name="venueCD" style="width:130px;" maxlength="10"/>
													<div id="overLap"></div>
												</td>
												<td class="td-cond-required"><fmt:message key="MDM02001B.venueNm"/>
												</td>
												<td class="td-input">
													<input type="text" id="venueNm" name="venueNm" style="width:150px;" maxlength="50"/>
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM02001B.dkmdTpCD"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD" name="dkmdTpCD" defaultText="select" category="DKMDTPCD" style="width:130px;"/>
												</td>
												<td class="td-cond-required"><fmt:message key="MDM02001B.territoryCD"/>
												</td>
												<td class="td-input">
													<nis:popup id="territory" nameID="territoryCDName" keyID="territoryCD" />
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM02001B.venueGradCD"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD" name="venueGradCD" defaultText="select" category="VENUEGRADCD" style="width:130px;" />
												</td>
												<td class="td-cond-required"><fmt:message key="MDM02001B.activeYN"/>
												</td>
												<td class="td-input">
													<nis:radio id="activeYN" name="activeYN" category="ACTIVEYN" />
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM02001B.addrTpCD"/>
												</td>
												<td class="td-input" colspan="3">
												 	
													<input type="hidden" id="addrTpCD1" name="addrTpCD1" />
													<input type="hidden" id="addrTpCD2" name="addrTpCD2" />
													<input type="hidden" id="addrTpCD3" name="addrTpCD3" />
													<input type="hidden" id="addrTpCD4" name="addrTpCD4" />
													
													<input type="text" id="addrTpCD1Name" name="addrTpCD1Name" class="input-readonly" style="width:130px;" readonly />
													<input type="text" id="addrTpCD2Name" name="addrTpCD2Name" class="input-readonly" style="width:130px;" readonly />
													<input type="text" id="addrTpCD3Name" name="addrTpCD3Name" class="input-readonly" style="width:130px;" readonly />
													<input type="text" id="addrTpCD4Name" name="addrTpCD4Name" class="input" style="width:200px;" />
													
													<img id="addr_popup" src="/images/common/search_popup.gif" hspace="3" style="vertical-align:middle;cursor:pointer" />
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM02001B.channelCD"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="channelCD" name="channelCD" defaultText="select" category="CHANNELCD" event="onchange" eventproc="getSubChannel(this.value);" style="width:130px;" />
												</td>
												<td class="td-cond-required"><fmt:message key="MDM02001B.subChannelCD"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="subChannelCD" name="subChannelCD" defaultText="select" category="SUBCHANNELCD" style="width:150px;"/>	<!-- event="onchange" eventproc="getSegment(this.value);"  -->
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM02001B.segmentCD"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="segmentCD" name="segmentCD" defaultText="select" category="SEGMENTCD" event="onchange" eventproc="getSubSegment(this.value);" style="width:130px;" />
												</td>
												<td class="td-cond-required"><fmt:message key="MDM02001B.subSegmentCD"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="subSegmentCD" name="subSegmentCD" defaultText="select" category="SUBSEGMENTCD" style="width:150px;"/>
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM02001B.WS"/>
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="wsCD" name="wsCD" defaultText="select" category="WSCD" event="onchange" eventproc="chgWsCD(this.value);" style="width:130px;" />
													<input type="hidden" id="wsSapCD" name="wsSapCD" />
													<input type="text" id="wsSapCDName" name="wsSapCDName" class="input-readonly" style="width:210px;" readonly />
													<img id="ws_popup" src="/images/common/search_popup.gif" hspace="3" style="vertical-align:middle;cursor:pointer" />
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM02001B.incntTpCD"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="incntTpCD" name="incntTpCD" defaultText="select" category="INCNTTPCD" style="width:130px;" />
												</td>
												<td class="td-cond-required"><fmt:message key="MDM02001A.venueDivCDName"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="venueDivCD" name="venueDivCD" defaultText="select" category="VENUEDIVCD" style="width:130px;" />
												</td>
											</tr>
											<tr>
				                                <td class="td-cond" style="height:100%"><fmt:message key="MDM02001B.note1"/>
				                                </td>
				                                <td class="td-textarea" colspan="3">
				                                    <textarea id="note1" name="note1" style="width:100%; height:60px;"></textarea>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond" style="height:100%"><fmt:message key="MDM02001B.note2"/>
				                                </td>
				                                <td class="td-textarea" colspan="3">
				                                    <textarea id="note2" name="note2" style="width:100%; height:60px;"></textarea>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond" style="height:100%"><fmt:message key="MDM02001B.note3"/>
				                                </td>
				                                <td class="td-textarea" colspan="3">
				                                    <textarea id="note3" name="note3" style="width:100%; height:60px;"></textarea>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond" style="height:100%"><fmt:message key="MDM02001B.note4"/>
				                                </td>
				                                <td class="td-textarea" colspan="3">
				                                    <textarea id="note4" name="note4" style="width:100%; height:60px;"></textarea>
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
						<input type="hidden" id="uniqueYN" name="uniqueYN" value="N" />
						<input type="hidden" id="activeFlg" name="activeFlg" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<script type="text/javascript">
	
    /****************************************
    * Function
    ****************************************/
     
    $(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
		};

		${initScript}
		
		$("#venueCD").change(function(){
			$("#uniqueYN").val("N");
		});
		$("#territory").keypress(function(){
			if (event.keyCode==13){
				getTerritoryName("territory", "territoryCD", "territoryCDName");
			}
		});
		$("#territory_popup").click(function(){
			openTerritoryPopup("closeTerritoryPopup");
		});
		$("#addr_popup").click(function(){						
			openAddrPopup("closeAddrPopup", "addrTpCD1", "addrTpCD2", "addrTpCD3", "addrTpCD4Name");	
		});
		
		$("#ws_popup").click(function(){
			openWSPopup("closeWSPopup", "wsCD");
		});
		
		$("#addrTpCD4Name").keypress(function(){
			if (event.keyCode==13){				
				popupChk();				
				return false;
			}
		});		
	});
	
	function popupChk() {
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM02001G01S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("addrTpCD1", $("#addrTpCD1").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2").val());
	  	table.setParameter("addrTpCD3", $("#addrTpCD3").val());
	  	table.setParameter("addrTpCD4", $("#addrTpCD4Name").val());
	  	table.setParameter("displayNum" , "10");
	  	table.setParameter("pageNum"  , "1");
	  	table.request();
     	
		if(table.getCount() == 1) {			
			
			$("#addrTpCD1").val(table.getData(7,0));
			$("#addrTpCD2").val(table.getData(8,0));
			$("#addrTpCD3").val(table.getData(9,0));
			$("#addrTpCD4").val(table.getData(10,0));
			$("#addrTpCD1Name").val(table.getData(3,0));
			$("#addrTpCD2Name").val(table.getData(4,0));
			$("#addrTpCD3Name").val(table.getData(5,0));
			$("#addrTpCD4Name").val(table.getData(6,0));	
			
		}else{			
			openAddrPopup("closeAddrPopup", "addrTpCD1", "addrTpCD2", "addrTpCD3", "addrTpCD4Name");
		}
	}
	
	function closeTerritoryPopup(data) {
		$("#territory").val(data.territoryCD);
		$("#territoryCD").val(data.territoryCD);
        $("#territoryCDName").val(data.territoryCDName);
	}
	
	function closeAddrPopup(data) {
			$("#addrTpCD1").val(data.addrTpCD1);
			$("#addrTpCD2").val(data.addrTpCD2);
			$("#addrTpCD3").val(data.addrTpCD3);
			$("#addrTpCD4").val(data.addrTpCD4);
			$("#addrTpCD1Name").val(data.addrTpCD1Name);
			$("#addrTpCD2Name").val(data.addrTpCD2Name);
			$("#addrTpCD3Name").val(data.addrTpCD3Name);
			$("#addrTpCD4Name").val(data.addrTpCD4Name);			
	}
	
	function closeWSPopup(data) {
		$("#wsCD").val(data.wsCD);
		$("#wsSapCD").val(data.wsSapCD);
		$("#wsSapCDName").val(data.wsSapCDName);
	}
	
	function chgWsCD(val) {
		$("#wsSapCD").val("");
		$("#wsSapCDName").val("");
	}
	
	var overLap = new AW.UI.Button;
	overLap.setId("overLap");
	overLap.setControlText("<fmt:message key="button.Overlap"/>");
	overLap.refresh();

	overLap.onControlClicked = function(event) {
		if($("#venueCD").val()=="") {
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/MDM0200103S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("venueCD", $("#venueCD").val());
		table.request();
	
		var rowCount = table.getCount();
		if (rowCount > 0) {
			if (table.getData(0,0) != "0") {
				$("uniqueYN").val("N");
				alert("<fmt:message key="MDM02001B.msg1"/>");
				$("#venueCD").val("");
				$("#venueCD").focus();
			}
			else {
				$("#uniqueYN").val("Y");
				alert("<fmt:message key="MDM02001B.msg2"/>");
			}
		}
	}
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getSubChannel(code) {
		if(code=="") {
			$("#subChannelCD").val("");
			$("#subChannelCD").attr("disabled",true);
    		$("#subChannelCD").addClass("input-readonly");
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
	}
	
	function getSegment(code) {
		if(code=="") {
			$("#segmentCD").val("");
			$("#segmentCD").attr("disabled",true);
    		$("#segmentCD").addClass("input-readonly");
    		$("#subSegmentCD").val("");
			$("#subSegmentCD").attr("disabled",true);
    		$("#subSegmentCD").addClass("input-readonly");
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
		if(code=="") {
			$("#subSegmentCD").val("");
			$("#subSegmentCD").attr("disabled",true);
    		$("#subSegmentCD").addClass("input-readonly");
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
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function New() {
		overLap.setControlVisible(true);
		$("#activeFlg").val("I");
		$("#venueCD").val("");
		$("#venueCD").attr("readonly",false);
		$("#venueCD").removeClass("input-readonly");
		$("#venueNm").val("");
		$("#dkmdTpCD").val("");
		if("${params.dkmdTpCD}" != "DK") {
			$("#dkmdTpCD").val("${params.dkmdTpCD}");
			$("#dkmdTpCD").attr("disabled", true);
			$("#dkmdTpCD").addClass("input-readonly");
		}
		$("#territory").val("");
		$("#territoryCDName").val("");
		$("#territoryCD").val("");
		$("#venueGradCD").val("");
		setRadioValue("activeYN", "Y");
		$("#addrTpCD1").val("");
		$("#addrTpCD2").val("");
		$("#addrTpCD2").attr("disabled",true);
		$("#addrTpCD2").addClass("input-readonly");
		
		$("#addrTpCD3").val("");
		$("#addrTpCD3").attr("disabled",true);
		$("#addrTpCD3").addClass("input-readonly");
				
		$("#addrTpCD4").val("");
		$("#addrTpCD4Name").val("");
		$("#addrTpCD4").attr("disabled",true);
		$("#addrTpCD4").addClass("input-readonly");
		
		$("#channelCD").val("");
		$("#subChannelCD").val("");
		$("#subChannelCD").attr("disabled",true);
		$("#subChannelCD").addClass("input-readonly");

		$("#subSegmentCD").val("");
		$("#subSegmentCD").attr("disabled",true);
		$("#subSegmentCD").addClass("input-readonly");
		$("#wsCD").val("");
		$("#wsSapCD").val("");
		$("#wsSapCDName").val("");
		$("#wsSapCD").attr("disabled",true);
		$("#wsSapCD").addClass("input-readonly");
		$("#note1").val("");
		$("#note2").val("");
		$("#note3").val("");
		$("#note4").val("");
		$("uniqueYN").val("N");
		$("#incntTpCD").val("");
		$("#venueDivCD").val("");
	}
    
    var _i = 0;
    var _col = {
   		venueCD : _i++
   		, venueNm : _i++
   		, dkmdTpCD : _i++
   		, territoryCD : _i++
   		, territoryCDName : _i++
   		, venueGradCD : _i++
   		, channelCD : _i++
   		, subChannelCD : _i++
   		, segmentCD : _i++
   		, subSegmentCD : _i++
   		, addrTpCD1 : _i++
   		, addrTpCD2 : _i++
   		, addrTpCD3 : _i++
   		, addrTpCD4 : _i++
   		, addrTpCD1Name : _i++
   		, addrTpCD2Name : _i++
   		, addrTpCD3Name : _i++
   		, addrTpCD4Name : _i++
   		, wsCD : _i++
   		, wsSapCD : _i++
   		, wsSapCDName : _i++
   		, note1 : _i++
   		, note2 : _i++
   		, note3 : _i++
   		, note4 : _i++
   		, activeYN : _i++
   		, incntTpCD : _i++
   		, venueDivCDName : _i++
    };
    function Search() {
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/MDM0200102S");
    	table.setAsync(false);
    	table.setRequestMethod("POST");
    	table.setParameter("venueCD", parent.$("#selectVenueCD").val());
    	table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#activeFlg").val("U");
			$("#venueCD").val(table.getData(_col.venueCD,0));
			$("#venueNm").val(table.getData(_col.venueNm,0));
			$("#dkmdTpCD").val(table.getData(_col.dkmdTpCD,0));
			if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD").attr("disabled", true);
				$("#dkmdTpCD").addClass("input-readonly");
			}
			$("#territory").val(table.getData(_col.territoryCD,0));
			$("#territoryCD").val(table.getData(_col.territoryCD,0));
			$("#territoryCDName").val(table.getData(_col.territoryCDName,0));
			$("#venueGradCD").val(table.getData(_col.venueGradCD,0));
			$("#channelCD").val(table.getData(_col.channelCD,0));
			getSubChannel(table.getData(_col.channelCD,0));
			$("#subChannelCD").val(table.getData(_col.subChannelCD,0));
			$("#segmentCD").val(table.getData(_col.segmentCD,0));
			getSubSegment(table.getData(_col.segmentCD,0));
			$("#subSegmentCD").val(table.getData(_col.subSegmentCD,0));
			$("#addrTpCD1").val(table.getData(_col.addrTpCD1,0));
			$("#addrTpCD2").val(table.getData(_col.addrTpCD2,0));
			$("#addrTpCD3").val(table.getData(_col.addrTpCD3,0));
			$("#addrTpCD4").val(table.getData(_col.addrTpCD4,0));
			$("#addrTpCD1Name").val(table.getData(_col.addrTpCD1Name,0));
			$("#addrTpCD2Name").val(table.getData(_col.addrTpCD2Name,0));
			$("#addrTpCD3Name").val(table.getData(_col.addrTpCD3Name,0));
			$("#addrTpCD4Name").val(table.getData(_col.addrTpCD4Name,0));
			$("#wsCD").val(table.getData(_col.wsCD,0));
			$("#wsSapCD").val(table.getData(_col.wsSapCD,0));
			$("#wsSapCDName").val(table.getData(_col.wsSapCDName,0));
			$("#note1").val(table.getData(_col.note1,0));
			$("#note2").val(table.getData(_col.note2,0));
			$("#note3").val(table.getData(_col.note3,0));
			$("#note4").val(table.getData(_col.note4,0));
			setRadioValue("activeYN",table.getData(_col.activeYN,0));
			$("#incntTpCD").val(table.getData(_col.incntTpCD,0));
			$("#venueDivCD").val(table.getData(_col.venueDivCDName,0));
			
	  		overLap.setControlVisible(false);
	  		$("#venueCD").attr("readonly",true);
			$("#venueCD").addClass("input-readonly");
			
			$("#subChannelCD").attr("disabled",false);
			$("#subChannelCD").removeClass("input-readonly");
			$("#subSegmentCD").attr("disabled",false);
			$("#subSegmentCD").removeClass("input-readonly");
			$("#wsCD").attr("disabled",false);
			$("#wsCD").removeClass("input-readonly");
			$("#wsSapCD").attr("disabled",false);
			$("#wsSapCD").removeClass("input-readonly");
			
		}
	}
    
	function Save() {
		if($("#activeFlg").val() == "I") {
			if($("#uniqueYN").val()=="N") {
				alert("<fmt:message key="MDM02001B.msg3"/>");
				return;
			}
		}
		if($("#venueNm").val() == "") {
			alert("<fmt:message key="MDM02001B.msg4"/>");
			$("#venueNm").focus();
			return;
		}
		if($("#dkmdTpCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg5"/>");
			$("#dkmdTpCD").focus();
			return;
		}
		if($("#territoryCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg6"/>");
			$("#territoryCD").focus();
			return;
		}
		if($("#venueGradCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg7"/>");
			$("#venueGradCD").focus();
			return;
		}
		if($("#channelCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg8"/>");
			$("#channelCD").focus();
			return;
		}
		if($("#subChannelCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg9"/>");
			$("#subChannelCD").focus();
			return;
		}
		if($("#segmentCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg10"/>");
			$("#segmentCD").focus();
			return;
		}
		if($("#subSegmentCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg11"/>");
			$("#subSegmentCD").focus();
			return;
		}
		
		if($("#addrTpCD1").val() == "") {
			alert("<fmt:message key="MDM02001B.msg23"/>");
			$("#addrTpCD4Name").focus();
			return;
		}
		
		if($("#wsCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg15"/>");
			$("#wsCD").focus();
			return;
		}
		if($("#wsSapCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg16"/>");
			$("#wsSapCD").focus();
			return;
		}
		if($("#incntTpCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg21"/>");
			$("#incntTpCD").focus();
			return;
		}
		if($("#venueDivCD").val() == "") {
			alert("<fmt:message key="MDM02001B.msg24"/>");
			$("#venueDivCD").focus();
			return;
		}
		var table = new AW.XML.Table;     
		table.setURL("${contextPath}/service/mdm02/saveVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("venueCD", $("#venueCD").val());
		table.setParameter("venueNm", $("#venueNm").val());
		table.setParameter("dkmdTpCD", $("#dkmdTpCD").val());
		table.setParameter("territoryCD", $("#territoryCD").val());
		table.setParameter("venueGradCD", $("#venueGradCD").val());
		table.setParameter("channelCD", $("#channelCD").val());
		table.setParameter("subChannelCD", $("#subChannelCD").val());
		table.setParameter("segmentCD", $("#segmentCD").val());
		table.setParameter("subSegmentCD", $("#subSegmentCD").val());
		table.setParameter("addrTpCD1", $("#addrTpCD1").val());
		table.setParameter("addrTpCD2", $("#addrTpCD2").val());
		table.setParameter("addrTpCD3", $("#addrTpCD3").val());
		table.setParameter("addrTpCD4", $("#addrTpCD4").val());
		table.setParameter("wsCD", $("#wsCD").val());
		table.setParameter("wsSapCD", $("#wsSapCD").val());
		table.setParameter("note1", $("#note1").val());
		table.setParameter("note2", $("#note2").val());
		table.setParameter("note3", $("#note3").val());
		table.setParameter("note4", $("#note4").val());
		table.setParameter("activeYN", getRadioValue("activeYN"));
		table.setParameter("activeFlg", $("#activeFlg").val());
		table.setParameter("incntTpCD", $("#incntTpCD").val());
		table.setParameter("venueDivCD", $("#venueDivCD").val());
		table.request();
		
		if (table.getData(0,0) == "S") {
			parent.$("#selectVenueCD").val(table.getData(3,0));
			message(table.getData(1,0));
			Search();
		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function List() {
		parent.Search();
		parent.appletClose();
	}
	
</script>