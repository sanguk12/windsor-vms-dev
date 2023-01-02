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
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="RLT01003A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" event="onchange" eventproc="getResultWriteDate();" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" event="onchange" eventproc="getResultWriteDate();" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT01003A.activity" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="RLT01003A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
				                                </td>
				                                
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="RLT01003A.addrTpCD1" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT01003A.addrTpCD2" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="RLT01003A.apprStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="none" category="APPRSTATECD" />
				                                </td>
				                            </tr>
				                            <tr>
												<td class="td-cond">
													<fmt:message key="RLT01003A.venue" />
												</td>
												<td class="td-input" colspan="5">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
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
                		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                			<colgroup>
			        			<col style="width:100px;"></col>
			        			<col style="width:200px;"></col>
			        			<col></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="RLT01003A.resultWriteDate" />
									</td>
									<td class="tit_text01">
										<span id="resultWriteDate_S" />
	                                </td>
	                                <td class="tit_text01" >
										<fmt:message key="RLT01003A.msg6" />
	                                </td>
                            	</tr>
			        		</tbody>
		        		</table>
                	</td>
                </tr>
                <tr>
					<td height="*" valign="top">
						<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
	                   		<tr>
								<td>
									<span id="grid"></span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1">
						<input type="hidden" id="incntTpCD" name="incntTpCD" value="PRD" />
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="selectPrdCD" name="selectPrdCD" />
						<input type="hidden" id="apprTpID" name="apprTpID" value="000000" /><!-- Plan/Result승인라인 -->
						<input type="hidden" id="resultWriteYN" name="resultWriteYN" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 35px; }
    .aw-column-1 {width: 70px; text-align:center; }
    .aw-column-2 {width: 70px; text-align:center; }
	.aw-column-3 {width: 120px; text-align:left; }
    .aw-column-4 {width: 70px; text-align:center; }
    .aw-column-5 {width: 100px; text-align:left; }
    .aw-column-6 {width: 100px; text-align:left; }
    .aw-column-7 {width: 70px; text-align:center; }
    .aw-column-8 {width: 100px; text-align:center; }
    .aw-column-9 {width: 120px; text-align:center; }
    .aw-column-10 {width: 120px; text-align:left; }
    .aw-column-11 {width: 60px; text-align:right;}
    .aw-column-12 {width: 70px; text-align:right;}
    .aw-column-13 {width: 60px; text-align:center;}
    .aw-column-14 {width: 70px; text-align:right;}
    .aw-column-15 {width: 70px; text-align:right;}
    .aw-column-16 {width: 70px; text-align:right;}
    .aw-column-17 {width: 80px; text-align:left;}
    .aw-column-18 {width: 80px; text-align:right;}
    .aw-column-19 {width: 80px; text-align:right;}
    .aw-column-20 {width: 80px; text-align:right;}
    .aw-column-21 {width: 80px; text-align:right;}
    .aw-column-22 {width: 80px; text-align:right;}
	.aw-column-23 {width: 70px; text-align:center;}
    .aw-column-24 {width: 70px; text-align:right;}
    .aw-column-25 {width: 70px; text-align:right;}
    .aw-column-26 {width: 120px; text-align:left;}
    .aw-column-27 {width: 70px; text-align:center;}
    .aw-column-28 {width: 80px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	var maxRow = 0;
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			grid.refresh();
			
			btnSave.setControlDisabled(true);
			btnResultCreation.setControlDisabled(true);
			
			if("${params.eventym}"==""){
				$("#yearCD_S").val("${params.clientDate}".substring(0,4));
				$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			}else{
				$("#yearCD_S").val("${params.eventym}".substring(0,4));
				$("#monthCD_S").val("${params.eventym}".substring(4,6));
			}
			
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
    		$("#apprStateCD_S").val("10");
    		getResultWriteYN();
			getResultWriteDate();
			
			if("${params.eventym}"!=""){
				$("#apprStateCD_S").val("40");
    			Search();
    		}
		};

		${initScript}
		
		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
			Search();
		});
		$("#venue_S_popup").click(function(){
			openVenuePopup("closeVenuePopup");
		});
		$("#venue_S").keypress(function(){
			if (event.keyCode==13){
				getVenueName("venue_S", "venueCD_S", "venueNm_S");
				if($("#venueCD_S").val()!="") {
					Search();
				}
			}
		});
	});
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
	function getResultWriteYN() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "02");		//01:plan,02:result
		table.request();
		
		if(table.getCount() > 0) {
			$("#resultWriteYN").val(table.getData(0,0));
			if(table.getData(0,0) == "Y") {
				btnSave.setControlDisabled(false);
				btnResultCreation.setControlDisabled(false);
			}
			else {
				btnSave.setControlDisabled(true);
				btnResultCreation.setControlDisabled(true);
			}
		}
	}
	
	function getResultWriteDate() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03002S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "02");		//01:plan,02:result
		table.request();
		
		var s = "";
	  	if (table.getCount() > 0) {
	  		s = "<select id='resultWriteDate_S' name='resultWriteDate_S'>";
		  	for (var i=0; i < table.getCount(); i++) {
		  		s += "<option>"+table.getData(0,i)+"</option>";
		  	}
	  	}
	  	else {
	  		 s = "<select id='resultWriteDate_S' name='resultWriteDate_S'><option value=''><fmt:message key="nothing"/></option>";
	  	}
	  	s += "</select>";
	  	$("#resultWriteDate_S").html(s);
	}
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getAddrTpCD2(code) {
		if(code == "") {
			$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "ADDRTPCD2");
	  	table.setParameter("attrib02", code);
     	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#addrTpCD2_S").attr("disabled",false);
    		$("#addrTpCD2_S").removeClass("input-readonly");
		}
     	else {
     		$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
     	}
	}
	
	
	//가이드금액 계산
	function calculateGuidAmt(row) {
		var resultQty = parseInt(unformat(grid.getCellText(_col.resultQty, row)));
		var prdCD = grid.getCellText(_col.prdCD, row);
		
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/RLT0100303S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","guidAmt;");
		table.setParameter("format","num;");								
        table.setParameter("prdCD",prdCD);
        table.setParameter("resultQty",resultQty);
        table.request();
		
        var rowCount = table.getCount();
      	if (rowCount == 1) {
	        grid.setCellText(table.getData(0,0), _col.guidAmt, row);  
	        
      	} else {
      		grid.setCellText("0", _col.guidAmt, row); 
      	}
      	
        var resultUnitAmt = parseInt(unformat(grid.getCellText(_col.resultUnitAmt, row)));
		var guidAmt = parseInt(unformat(grid.getCellText(_col.guidAmt, row)));
      	
   		if(resultUnitAmt > guidAmt) {
			grid.getCellTemplate(_col.resultUnitAmt, row).setStyle("background", "#ff0000");
			grid.getCellTemplate(_col.resultUnitAmt, row).setStyle("color", "#ffffff");
			
		} else {
			grid.getCellTemplate(_col.resultUnitAmt, row).setStyle("background", "");
			grid.getCellTemplate(_col.resultUnitAmt, row).setStyle("color", "");
		}
      	calculatePayAmt(row);
	}
	
	//지급금액 계산
	function calculatePayAmt(row) {
		var resultQty = parseInt(unformat(grid.getCellText(_col.resultQty, row)));
		var resultUnitAmt = parseFloat(unformat(grid.getCellText(_col.resultUnitAmt, row)));
		var payAmt = 0;
		payAmt = resultQty * resultUnitAmt;
		grid.setCellText(formatNum(payAmt), _col.payAmt, row);
		
		calculateTargetQty(row);
	}
	
	//달성량 계산
	function calculateTargetQty(row) {
		var resultQty = parseInt(unformat(grid.getCellText(_col.resultQty, row)));
		var eu = parseFloat(unformatNum(grid.getCellText(_col.eu, row)));
		var targetQty = 0;
		
// 		targetQty = Math.round(resultQty * eu);
		targetQty = Math.round(resultQty * eu * 100000)/100000;
		
		grid.setCellText(formatNum(targetQty), _col.targetQty, row);
		
		calculateSdxTpCD(row);
	}
	
	//SDX구분 계산
	function calculateSdxTpCD(row) {
		var resultQty = parseInt(unformat(grid.getCellText(_col.resultQty, row)));
		if(grid.getCellText(_col.sdxYN, row) == "Y") {
			if(resultQty == "1" || resultQty == "2"){
				var table = new AW.XML.Table;
		    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		        table.setAsync(false);
		        table.setRequestMethod("POST");
		        table.setParameter("outParamKey","comCode;codeName;");
		        table.setParameter("codeDiv", "SDXTPCD");
		        table.setParameter("comCode", "3LT");
		        table.request();
				
		        var rowCount = table.getCount();
		      	if (rowCount > 0) {
		      		for (var i=0; i < rowCount; i++) {
		      			
						grid.setCellText(table.getData(0,i), _col.sdxTpCD, row);
						grid.setCellText(table.getData(1,i), _col.sdxTpCDName, row);
		      		}
		      	}
				
				grid.getCellTemplate(_col.sdxTpCDName, row).setStyle("background", "#ff0000");
  				grid.getCellTemplate(_col.sdxTpCDName, row).setStyle("color", "#ffffff");
			}
			else {
				grid.setCellText("", _col.sdxTpCD, row);
				grid.setCellText("", _col.sdxTpCDName, row);
				
				grid.getCellTemplate(_col.sdxTpCDName, row).setStyle("background", "#ececec");
				grid.getCellTemplate(_col.sdxTpCDName, row).setStyle("color", "");
	 		}	
		}
		else {
			grid.setCellText("", _col.sdxTpCD, row);
			grid.setCellText("", _col.sdxTpCDName, row);
			
			grid.getCellTemplate(_col.sdxTpCDName, row).setStyle("background", "#ececec");
			grid.getCellTemplate(_col.sdxTpCDName, row).setStyle("color", "");
 		}	
		
		calculateTargetRate(row);
	}
	
	//달성률 계산
	function calculateTargetRate(row) {
		var resultQty = parseInt(unformat(grid.getCellText(_col.resultQty, row)));
		var planQty = parseInt(unformat(grid.getCellText(_col.planQty, row)));
		var targetRate = 0;
		if(planQty==0) {
			targetRate = 0;
		}
		else {
			targetRate = (resultQty / planQty) * 100;
		}
		grid.setCellText(Math.round(targetRate), _col.targetRate, row);
		
		if(targetRate != "0" && (targetRate < "70" || targetRate > "150")) {
			grid.getCellTemplate(_col.targetRate, row).setStyle("background", "#ff0000");
			grid.getCellTemplate(_col.targetRate, row).setStyle("color", "#ffffff");
			
		} else {
			grid.getCellTemplate(_col.targetRate, row).setStyle("background", "");
			grid.getCellTemplate(_col.targetRate, row).setStyle("color", "");
		}
		
		calculateGsvRate(row);
	}
	
	//vs GSV 계산
	function calculateGsvRate(row) {

		var gsv = 0;
		var payAmt = parseFloat(unformat(grid.getCellText(_col.payAmt, row)));
		var resultQty = parseFloat(unformat(grid.getCellText(_col.resultQty, row)));
		var factoryPrice = parseFloat(unformat(grid.getCellText(_col.factoryPrice, row)));
		var resultQty_factoryPrice = resultQty * factoryPrice;
		
		if(resultQty_factoryPrice == 0) {
			gsv = 0;
		} else {
			gsv = ((payAmt*(1+0.0352)) / (resultQty_factoryPrice)) *100 ;
		}
        grid.setCellText(Math.round(gsv), _col.gsvRate, row);  
        
        if(Math.round(gsv) > 30) {
			grid.getCellTemplate(_col.gsvRate, row).setStyle("background", "#ff0000");
			grid.getCellTemplate(_col.gsvRate, row).setStyle("color", "#ffffff");
		}
        else {
			grid.getCellTemplate(_col.gsvRate, row).setStyle("background", "");
			grid.getCellTemplate(_col.gsvRate, row).setStyle("color", "");
		}
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	function ResultCreation() {
		
		if(!confirm("<fmt:message key="RLT01003A.msg4"/>")) {
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt01/resultCreationBrand");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	var _i = 0;
	var _col = {
		checkbox : _i++		
		, activityCDName : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, segmentCDame : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, kindTpCD5Name : _i++
		, prdNm : _i++
		, eu : _i++
		, factoryPrice : _i++
		, qtyUnitCDName : _i++
		, planQty : _i++
		, planUnitAmt : _i++
		, rfidQty : _i++
		, resultTpCDName : _i++
		, resultQty : _i++
		, resultUnitAmt : _i++
		, guidAmt : _i++
		, payAmt : _i++
		, targetQty : _i++
		, sdxTpCDName : _i++
		, targetRate : _i++
		, gsvRate : _i++
		, commt : _i++
		, keymanName : _i++
		, apprStateCDName : _i++
		, activeFlg : _i++
		, sdxYN : _i++
		, prdCD : _i++
		, resultTpCD : _i++
		, sdxTpCD : _i++
		, apprStateCD : _i++
		, keymanID : _i++
		, bankCD : _i++
		, accountNo : _i++
		, holderNm : _i++
		, chgID : _i++
    };
	function Search() {
		getResultWriteYN();
		getResultWriteDate();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0100301S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;activityCDName;venueCD;venueNm;venueGradCDName;segmentCDame;"+
	  			"subSegmentCDName;addrTpCD1Name;addrTpCD2Name;kindTpCD5Name;prdNm;"+
	  			"eu;factoryPrice;qtyUnitCDName;planQty;planUnitAmt;"+
	  			"rfidQty;resultTpCDName;resultQty;resultUnitAmt;guidAmt;"+
	  			"payAmt;targetQty;sdxTpCDName;targetRate;gsvRate;"+
	  			"commt;keymanName;apprStateCDName;activeFlg;sdxYN;"+
	  			"prdCD;resultTpCD;sdxTpCD;apprStateCD;keymanID;"+
	  			"bankCD;accountNo;holderNm;chgID;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"num5;num;str;num;num;"+
	  			"num;str;num;num;num;"+
	  			"num;num5;str;num;num;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			var apprStateCDName = "";
      			if(table.getData(_col.apprStateCD,i) == "10") {
      				apprStateCDName = table.getData(_col.apprStateCDName,i);
          		}
          		else {
          			apprStateCDName = "<a href=\"javascript:openApprState('"+i+"');\">"+table.getData(_col.apprStateCDName,i)+"</a>";
          		}
      			
      			data[i] = [
					table.getData(_col.checkbox,i)       	
					, table.getData(_col.activityCDName,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDame,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.kindTpCD5Name,i)
					, table.getData(_col.prdNm,i)
					, table.getData(_col.eu,i)
					, table.getData(_col.factoryPrice,i)
					, table.getData(_col.qtyUnitCDName,i)
					, table.getData(_col.planQty,i)
					, table.getData(_col.planUnitAmt,i)
					, table.getData(_col.rfidQty,i)
					, table.getData(_col.resultTpCDName,i)
					, table.getData(_col.resultQty,i)
					, table.getData(_col.resultUnitAmt,i)
					, table.getData(_col.guidAmt,i)
					, table.getData(_col.payAmt,i)
					, table.getData(_col.targetQty,i)
					, table.getData(_col.sdxTpCDName,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.commt,i)
					, table.getData(_col.keymanName,i)
					, apprStateCDName
					, table.getData(_col.activeFlg,i)
					, table.getData(_col.sdxYN,i)
					, table.getData(_col.prdCD,i)
					, table.getData(_col.resultTpCD,i)
					, table.getData(_col.sdxTpCD,i)
					, table.getData(_col.apprStateCD,i)
					, table.getData(_col.keymanID,i)
					, table.getData(_col.bankCD,i)
					, table.getData(_col.accountNo,i)
					, table.getData(_col.holderNm,i)
      			];
      			
      			var resultTpCD = table.getData(_col.resultTpCD,i);
      			var apprStateCD = table.getData(_col.apprStateCD,i);
      			
      			if($("#resultWriteYN").val()=="Y") {
      				if(apprStateCD!="10" && apprStateCD!="40") {
		      			grid.setPopupTemplate(new AW.Templates.Text, _col.resultTpCDName, i);
		      			grid.setPopupTemplate(new AW.Templates.Text, _col.keymanName, i);
		      			
		      			grid.getCellTemplate(_col.resultTpCDName, i).setStyle("background", "#ececec");
		      			grid.getCellTemplate(_col.keymanName, i).setStyle("background", "#ececec");
      				}
	      			if(resultTpCD == "10"){
	      				grid.setCellText(table.getData(_col.rfidQty, i), _col.resultQty, i);
	      				grid.setCellEditable(false, _col.resultQty, i);
	      			} else {
	      				grid.setCellEditable(true, _col.resultQty, i);
	      			}
      			} else {
      				grid.setPopupTemplate(new AW.Templates.Text, _col.resultTpCDName, i);
      				grid.setPopupTemplate(new AW.Templates.Text, _col.keymanName, i);
      				
      				grid.getCellTemplate(_col.resultTpCDName, i).setStyle("background", "#ececec");
      				grid.getCellTemplate(_col.keymanName, i).setStyle("background", "#ececec");
      				
      				grid.setCellEditable(false, _col.resultQty, i);
      			}
      			
      			var resultUnitAmt = parseInt(unformat(table.getData(_col.resultUnitAmt,i)));
      			var guidAmt = parseInt(unformat(table.getData(_col.guidAmt,i)));
      			if(resultUnitAmt > guidAmt) {
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("background", "");
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("color", "");
      			}

      			var sdxTpCD = table.getData(_col.sdxTpCD,i);
      			if(sdxTpCD == "3LT") {
      				grid.setPopupTemplate(new AW.Templates.Text, _col.sdxTpCDName, i);
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("color", "#ffffff");
      			} else {
      				grid.setPopupTemplate(new AW.Templates.Text, _col.sdxTpCDName, i);
          			grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("background", "#ececec");
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("color", "");
      			}
      			
      			var targetRate = parseInt(unformat(table.getData(_col.targetRate,i)));
      			if(targetRate != 0 && (targetRate < 70 || targetRate > 150)) {
      				grid.getCellTemplate(_col.targetRate, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.targetRate, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.targetRate, i).setStyle("background", "");
      				grid.getCellTemplate(_col.targetRate, i).setStyle("color", "");
      			}
      			
      			var gsvRate = parseInt(unformat(table.getData(_col.gsvRate,i)));
      			if(gsvRate > 30) {
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "");
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "");
      			}

      			if(table.getData(_col.chgID,i) != ""){
      				grid.getCellTemplate(_col.activityCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.venueCD,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.venueNm,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.venueGradCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.segmentCDame,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.subSegmentCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.addrTpCD1Name,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.addrTpCD2Name,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.kindTpCD5Name,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.prdNm,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.eu,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.factoryPrice,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.qtyUnitCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.planQty,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.planUnitAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.rfidQty,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.resultTpCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.resultQty,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.resultUnitAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.guidAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.payAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.targetQty,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.sdxTpCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.targetRate,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.gsvRate,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.commt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.keymanName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.apprStateCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.activeFlg,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.sdxYN,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.prdCD,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.resultTpCD,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.sdxTpCD,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.apprStateCD,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.keymanID,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.bankCD,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.accountNo,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.holderNm,i).setStyle("font-weight", "bold");
          		}
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
      	
      	maxRow = rowCount;
	}
	
	function openApprState(i) {
		$("#selectVenueCD").val(grid.getCellText(_col.venueCD,i));
      	$("#selectPrdCD").val(grid.getCellText(_col.prdCD,i));
		
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01003B"
				+"&eventYM="+$("#yearCD_S").val()+$("#monthCD_S").val()
				+"&venueCD="+$("#selectVenueCD").val()
				+"&prdCD="+$("#selectPrdCD").val()
				+"&apprTpID="+$("#apprTpID").val();
		
		newWindow(url, "RLT01003B",600,350,"yes");
	}
	
	function nextFocus(obj, col, row) {
		
    	obj.setCurrentColumn(col);
    	obj.setCurrentRow(row);
        obj.setTimeout(function(){ 
        	obj.raiseEvent("editCurrentCell", {}, col, row); 
        });
        
    }
	
	function Save() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				if(grid.getCellText(_col.activeFlg, index[i])!="D") {
					//등록, 반려인 경우에만 저장
					if (grid.getCellText(_col.apprStateCD, index[i]) != "10" && grid.getCellText(_col.apprStateCD, index[i]) != "40") {
						alert("<fmt:message key="RLT01003A.msg2"/>");
						return;
					}
					if (grid.getCellText(_col.keymanID, index[i]) == "") {alert("<fmt:message key="RLT01003A.msg3" />"); setCellFocus(grid, _col.keymanName, index[i]); return;}
				}
				
				var resultUnitAmt = parseInt(unformat(grid.getCellText(_col.resultUnitAmt, index[i])));
				var guidAmt = parseInt(unformat(grid.getCellText(_col.guidAmt, index[i])));
				var sdxYN = grid.getCellText(_col.sdxYN, index[i]);
				var resultQty = parseInt(unformat(grid.getCellText(_col.resultQty, index[i])));
				var targetRate = parseInt(unformat(grid.getCellText(_col.targetRate, index[i])));
				var gsvRate = parseInt(unformat(grid.getCellText(_col.gsvRate, index[i])));
				
				if(resultUnitAmt > guidAmt ||
					(sdxYN == "Y" && (resultQty == "1" || resultQty == "2")) || 
					(targetRate != "0" && (targetRate < "70" || targetRate > "150")) ||
					gsvRate > "30") {
					if(grid.getCellText(_col.commt, index[i]) == "") {
						alert("<fmt:message key="RLT01003A.msg5" />");
						setCellFocus(grid, _col.commt, index[i]);
						return;
					}
				}
			}
		}
		
		var venueCDs = new Array();
		var prdCDs = new Array();
		
		var venueNMs = new Array();
		var prdNMs = new Array();
		
		
		var factoryPrices = new Array();
		var sdxYNs = new Array();
		var rfidQtys = new Array();
		var resultTpCDs = new Array();
		var resultQtys = new Array();
		var resultUnitAmts = new Array();
		var guidAmts = new Array();
		var payAmts = new Array();
		var targetQtys = new Array();
		var sdxTpCDs = new Array();
		var targetRates = new Array();
		var gsvRates = new Array();
		var commts = new Array();
		var keymanIDs = new Array();
		var bankCDs = new Array();
		var accountNos = new Array();
		var holderNms = new Array();
		var apprStateCDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				
				venueNMs[count] = grid.getCellText(_col.venueNm, index[i]);
				prdNMs[count] = grid.getCellText(_col.prdNm, index[i]);
				
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				prdCDs[count] = grid.getCellText(_col.prdCD, index[i]);
				factoryPrices[count] = grid.getCellText(_col.factoryPrice, index[i]);
				sdxYNs[count] = grid.getCellText(_col.sdxYN, index[i]);
				rfidQtys[count] = grid.getCellText(_col.rfidQty, index[i]);
				resultTpCDs[count] = grid.getCellText(_col.resultTpCD, index[i]);
				resultQtys[count] = grid.getCellText(_col.resultQty, index[i]);
				resultUnitAmts[count] = grid.getCellText(_col.resultUnitAmt, index[i]);
				guidAmts[count] = grid.getCellText(_col.guidAmt, index[i]);
				payAmts[count] = grid.getCellText(_col.payAmt, index[i]);
				targetQtys[count] = grid.getCellText(_col.targetQty, index[i]);
				sdxTpCDs[count] = grid.getCellText(_col.sdxTpCD, index[i]);
				targetRates[count] = grid.getCellText(_col.targetRate, index[i]);
				gsvRates[count] = grid.getCellText(_col.gsvRate, index[i]);
				commts[count] = grid.getCellText(_col.commt, index[i]);
				keymanIDs[count] = grid.getCellText(_col.keymanID, index[i]);
				bankCDs[count] = grid.getCellText(_col.bankCD, index[i]);
				accountNos[count] = grid.getCellText(_col.accountNo, index[i]);
				holderNms[count] = grid.getCellText(_col.holderNm, index[i]);
				apprStateCDs[count] = grid.getCellText(_col.apprStateCD, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt01/saveResultWriteBrand");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("venueCDs", venueCDs);
		
		table.setParameter("venueNMs", venueNMs);
		table.setParameter("prdNMs", prdNMs);
		
		table.setParameter("apprStateCDs", apprStateCDs);
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("factoryPrices", factoryPrices);
		table.setParameter("sdxYNs", sdxYNs);
		table.setParameter("rfidQtys", rfidQtys);
		table.setParameter("resultTpCDs", resultTpCDs);
		table.setParameter("resultQtys", resultQtys);
		table.setParameter("resultUnitAmts", resultUnitAmts);
		table.setParameter("guidAmts", guidAmts);
		table.setParameter("payAmts", payAmts);
		table.setParameter("targetQtys", targetQtys);
		table.setParameter("sdxTpCDs", sdxTpCDs);
		table.setParameter("targetRates", targetRates);
		table.setParameter("gsvRates", gsvRates);
		table.setParameter("commts", commts);
		table.setParameter("keymanIDs", keymanIDs);
		table.setParameter("bankCDs", bankCDs);
		table.setParameter("accountNos", accountNos);
		table.setParameter("holderNms", holderNms);
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
			
			for (var i = 0; i < grid.getRowCount(); i++){
				
				if((grid.getCellText(_col.venueCD, index[i])+grid.getCellText(_col.prdCD, index[i])==table.getData(2,0)))
				{
					
					nextFocus(grid, _col.resultUnitAmt, index[i]);
					
				};
			}
			
		}
	}

	function PayHistory() {
		if(grid.getCellText(_col.prdCD, grid.getSelectedRows()) == ""){
			alert("상품을 선택하여 주십시오.");
			return;
		}
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var venueCD = grid.getCellText(_col.venueCD, grid.getSelectedRows());
		var venueNm = grid.getCellText(_col.venueNm, grid.getSelectedRows());
		var prdCD = grid.getCellText(_col.prdCD, grid.getSelectedRows());
		var prdNm = grid.getCellText(_col.prdNm, grid.getSelectedRows());

		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=ANL01010A"
			+"&diffNo="+diffNo+"&eventYM="+eventYM+"&venueCD="+venueCD+"&venueNm="+venueNm+"&prdCD="+prdCD+"&prdNm="+prdNm;
		
		newWindow(url, "ANL01010A",1080,750,"yes");
	}

	function ApprovalHistory(){
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PLN02002B"
			+"&diffNo="+diffNo+"&eventYM="+eventYM+"&rltYN=Y";
		
		newWindow(url, "PLN02002B",1080,520,"yes");
	}
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	
	var columns = [
		""
	    , "<fmt:message key="RLT01003A.activity"/>"
       	, "<fmt:message key="RLT01003A.venueCD"/>"
		, "<fmt:message key="RLT01003A.venueNm"/>"
		, "<fmt:message key="RLT01003A.venueGradCD"/>"
		, "<fmt:message key="RLT01003A.segmentCD"/>"
		, "<fmt:message key="RLT01003A.subSegmentCD"/>"
		, "<fmt:message key="RLT01003A.addrTpCD1"/>"
		, "<fmt:message key="RLT01003A.addrTpCD2"/>"
		, "<fmt:message key="RLT01003A.kindTpCD5"/>"
		, "<fmt:message key="RLT01003A.prdNm"/>"
		, "<fmt:message key="RLT01003A.eu"/>"
		, "<fmt:message key="RLT01003A.factoryPrice"/>"
		, "<fmt:message key="RLT01003A.qtyUnitCD"/>"
		, "<fmt:message key="RLT01003A.planQty"/>"
		, "<fmt:message key="RLT01003A.planUnitAmt"/>"
		, "<fmt:message key="RLT01003A.rfidQty"/>"
		, "<fmt:message key="RLT01003A.resultTpCD"/>"
		, "<fmt:message key="RLT01003A.resultQty"/>"
		, "<fmt:message key="RLT01003A.resultUnitAmt"/>"
		, "<fmt:message key="RLT01003A.guidAmt"/>"
		, "<fmt:message key="RLT01003A.payAmt"/>"
		, "<fmt:message key="RLT01003A.targetQty"/>"
		, "<fmt:message key="RLT01003A.sdxTpCD"/>"
		, "<fmt:message key="RLT01003A.targetRate"/>"
		, "<fmt:message key="RLT01003A.gsvRate"/>"
		, "<fmt:message key="RLT01003A.commt"/>"
		, "<fmt:message key="RLT01003A.keymanID"/>"
		, "<fmt:message key="RLT01003A.apprStateCD"/>"
		
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
	    grid.setCellFormat([
	                        str, str, str, str, str, str, str, str, str, str, str
	                        , num5, num, str, num, num, num, str, num, num, num
	                        , num, num5, str, num, num, str, str, html]);
	    grid.setCellEditable(false);
	    grid.setCellEditable(true, _col.resultQty);
	    grid.setCellEditable(true, _col.resultUnitAmt);
	    grid.setCellEditable(true, _col.commt);
	    grid.setFixedLeft(4);
	    
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
	    
	    grid.setCellTemplate(new AW.Templates.Combo, _col.resultTpCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.sdxTpCDName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.keymanName);
	    
		grid.setPopupTemplate(function(col, row) {
			
			if (col == _col.resultTpCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","RESULTTPCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.resultTpCD, row);
			            if(grid.getCellText(_col.resultTpCD, row) == "10"){
		      				grid.setCellText(grid.getCellText(_col.rfidQty, row), _col.resultQty, row);
		      				grid.setCellEditable(false, _col.resultQty, row);
		      			} else {
		      				grid.setCellEditable(true, _col.resultQty, row);
		      			}
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.sdxTpCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","SDXTPCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","200px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.sdxTpCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.keymanName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/COM03005S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","keymanID;keymanNm_full;bankCD;accountNo;holderNm;");
	            table.setParameter("venueCD",grid.getCellText(_col.venueCD,row));
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	            var bankCD = new Array();
	            var accountNo = new Array();
	            var holderNm = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              		bankCD[i] = table.getData(2,i);
	              		accountNo[i] = table.getData(3,i);
	              		holderNm[i] = table.getData(4,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","220px");
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.keymanID, row);
			            grid.setCellText(bankCD[i], _col.bankCD, row);
			            grid.setCellText(accountNo[i], _col.accountNo, row);
			            grid.setCellText(holderNm[i], _col.holderNm, row);
	            	}
	            	catch(e){}
	            };
			}
			
            return list;
        });
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
        
        grid.onCellEditStarted = function(text, col, row){
	        if (col == _col.resultQty) {
	            this.setCellText(unformatNum(text), col, row);
	        }
	    };

		grid.onCellEditEnded = function(text, col, row) {
			this.setCellText(text, col, row);
			this.focus();
		};
		// Cell startEdit END
		
		//  BEGIN validating (Enter, Cell LoseFocus)
		grid.onCellValidating = function(text, col, row) {
			if(col == _col.resultQty) {
				if (!isNumber(text)) {
				    alert('<fmt:message key="error.format" />');
				    this.setCellText("",col,row);
				}
	           	else if (parseFloat(text) < 0) {
					alert('<fmt:message key="error.noMinusNum" />');
					this.setCellText("",col,row);
				}
			}
			if(col == _col.keymanName) {
				calculatePayAmt(row);
			}
	    };
	
	    grid.onCellValidated = function(text, col, row) {
	    	if (col == _col.resultQty) {
	            this.setCellText(formatNum(text), col, row);
	            calculateGuidAmt(row);
	        }
	    	
	    	if (col == _col.resultUnitAmt) {
	            this.setCellText(formatNum(text), col, row);
	            calculateGuidAmt(row);
	        }
	    	
	    	if (col == _col.keymanName) {
	            this.setCellText(formatNum(text), col, row);
	            
	        }
	    	
	    	this.setCellText("U", _col.activeFlg, row);
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
	    
	    grid.onRowDoubleClicked = function(event, row){
		};
    }

</script>