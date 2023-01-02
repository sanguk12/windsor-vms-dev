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
													<fmt:message key="PAY01002A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                 <td class="td-cond">
													<fmt:message key="PAY01002A.activityCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY01002A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
				                                </td>
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="PAY01002A.segmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="segmentCD_S" name="segmentCD_S" defaultText="all" category="SEGMENTCD" event="onchange" eventproc="getSubSegment(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY01002A.subSegmentCD" />
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="subSegmentCD_S" name="subSegmentCD_S" defaultText="all" category="SUBSEGMENTCD" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="PAY01002A.addrTpCD1" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PAY01002A.addrTpCD2" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="PAY01002A.verifyStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="verifyStateCD_S" name="verifyStateCD_S" defaultText="all" category="VERIFYSTATECD" />
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
			        			<col style="width:60px;"></col>
			        			<col></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="PAY01002A.myAppr" />
									</td>
									<td class="tit_text01">
										<span id="myAppr" />
	                                </td>
	                            </tr>
			        		</tbody>
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
<!-- 						<input type="hidden" id="resultWriteYN" name="resultWriteYN" /> -->
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="diffNo" name="diffNo" value="9" /><!-- G1 -->
						<input type="hidden" id="apprTpID" name="apprTpID" value="000002" /><!-- Result검증 승인라인 -->
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 35px; text-align:center;}
	.aw-column-1 {width: 70px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:center;}
    .aw-column-3 {width: 70px; text-align:center;}
    .aw-column-4 {width: 120px; text-align:left;}
    .aw-column-5 {width: 70px; text-align:center;}
    .aw-column-6 {width: 100px; text-align:left;}
    .aw-column-7 {width: 100px; text-align:left;}
    .aw-column-8 {width: 70px; text-align:center;}
    .aw-column-9 {width: 100px; text-align:center;}
    .aw-column-10 {width: 100px; text-align:right;}
    .aw-column-11 {width: 100px; text-align:right;}
    .aw-column-12 {width: 100px; text-align:right;}
    .aw-column-13 {width: 80px; text-align:center;}
    .aw-column-14 {width: 80px; text-align:right;}
    .aw-column-15 {width: 80px; text-align:right;}
    .aw-column-16 {width: 100px; text-align:center;}
    .aw-column-17 {width: 80px; text-align:right;}
    .aw-column-18 {width: 150px; text-align:left;}
    .aw-column-19 {width: 100px; text-align:right;}
    .aw-column-20 {width: 200px; text-align:left;}
    .aw-column-21 {width: 80px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

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
			
			createGrid();
			grid.refresh();
			
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			$("#subSegmentCD_S").attr("disabled",true);
    		$("#subSegmentCD_S").addClass("input-readonly");
    		$("#verifyStateCD_S").val("10");
//     		getResultWriteYN();
			getMyAppr();
		};

		${initScript}

		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
			Search();
		});
	});
	
	//Result작성기간 유무판단
// 	function getResultWriteYN() {
// 		var table = new AW.XML.Table;
// 		table.setURL("${contextPath}/service/simpleAction/COM03001S");
// 		table.setAsync(false);
// 		table.setRequestMethod("POST");
// 		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
// 		table.setParameter("planResultTpCD", "02");		//01:plan,02:result
// 		table.request();
		
// 		if(table.getCount() > 0) {
// 			$("#resultWriteYN").val(table.getData(0,0));
// 			if(table.getData(0,0) == "Y") {
// 				btnRequestApp.setControlDisabled(false);
// 				btnClearRequestApp.setControlDisabled(false);
// 			}
// 			else {
// 				btnRequestApp.setControlDisabled(true);
// 				btnClearRequestApp.setControlDisabled(true);
// 			}
// 		}
// 	}
	
	//나의 승인라인가져오기
	function getMyAppr() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03006S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.request();
		
		if(table.getCount() > 0) {
			$("#myAppr").text(table.getData(0,0));
		}
	}
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getSubSegment(code) {
		if(code=="") {
			$("#subSegmentCD_S").val("");
			$("#subSegmentCD_S").attr("disabled",true);
    		$("#subSegmentCD_S").addClass("input-readonly");
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
	     	$("#subSegmentCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#subSegmentCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#subSegmentCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#subSegmentCD_S").attr("disabled",false);
    		$("#subSegmentCD_S").removeClass("input-readonly");
     	}
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		checkbox : _i++
		, programCDName : _i++
		, activityCDName : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, tpayAmt : _i++
		, resultTQty : _i++
		, avgUnitAmt : _i++
		, resultTpCDName : _i++
		, targetRate : _i++
		, payRate : _i++
		, excPayTpCDName : _i++
		, gsvRate : _i++
		, commt : _i++
		, payAmt_keyman : _i++
		, verifyErrCommt : _i++
		, verifyStateCDName : _i++
		, verifyStateCD : _i++
		, resultTpCD : _i++
		, guidPayRate : _i++
		, excPayTpCD : _i++
		, activityCD : _i++
    };
	function Search() {
// 		getResultWriteYN();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PAY0100201S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;programCDName;activityCDName;venueCD;venueNm;"+
	  			"venueGradCDName;segmentCDName;subSegmentCDName;addrTpCD1Name;addrTpCD2Name;"+
	  			"tpayAmt;resultTQty;avgUnitAmt;resultTpCDName;targetRate;"+
	  			"payRate;excPayTpCDName;gsvRate;commt;payAmt_keyman;"+
	  			"verifyErrCommt;verifyStateCDName;verifyStateCD;resultTpCD;"+
	  			"guidPayRate;excPayTpCD;activityCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"num;num;num;str;num;"+
	  			"num;str;num;str;num;"+
	  			"str;str;str;str;num;"+
	  			"str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("verifyStateCD", $("#verifyStateCD_S").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			var verifyStateCDName = "";
      			if(table.getData(_col.verifyStateCD,i) == "10") {
      				verifyStateCDName = table.getData(_col.verifyStateCDName,i);
          		}
          		else {
          			verifyStateCDName = "<a href=\"javascript:openApprState('"+table.getData(_col.venueCD,i)+"');\">"+table.getData(_col.verifyStateCDName,i)+"</a>";
          		}
      			
      			data[i] = [
					""
					, table.getData(_col.programCDName,i)
					, table.getData(_col.activityCDName,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.tpayAmt,i)
					, table.getData(_col.resultTQty,i)
					, table.getData(_col.avgUnitAmt,i)
					, table.getData(_col.resultTpCDName,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.payRate,i)
					, table.getData(_col.excPayTpCDName,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.commt,i)
					, table.getData(_col.payAmt_keyman,i)
					, table.getData(_col.verifyErrCommt,i)
					, verifyStateCDName
					, table.getData(_col.verifyStateCD,i)
					, table.getData(_col.resultTpCD,i)
					, table.getData(_col.guidPayRate,i)
					, table.getData(_col.excPayTpCD,i)
					, table.getData(_col.activityCD,i)
      			];
				
				var gsvRate = Number(table.getData(_col.gsvRate,i));
				var excPayTpCD = table.getData(_col.excPayTpCD,i);
				var guidPayRate = Number(table.getData(_col.guidPayRate,i));
				var payRate = Number(table.getData(_col.payRate,i));
				if(gsvRate > 10) {
					grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "#ffffff");
				}
				if(excPayTpCD == "YPAY") {
					grid.getCellTemplate(_col.excPayTpCDName, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.excPayTpCDName, i).setStyle("color", "#ffffff");
				}
		     	if(payRate > guidPayRate) {
		     		grid.getCellTemplate(_col.payRate, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.payRate, i).setStyle("color", "#ffffff");
		     	}
		     	else if(payRate < guidPayRate) {
		     		grid.getCellTemplate(_col.payRate, i).setStyle("background", "#00ff00");
					grid.getCellTemplate(_col.payRate, i).setStyle("color", "#00000");
		     	}
			}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
	function openApprState(venueCD) {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01001B"
				+"&eventYM="+$("#yearCD_S").val()+$("#monthCD_S").val()
				+"&venueCD="+venueCD
				+"&diffNo="+$("#diffNo").val()
				+"&apprTpID="+$("#apprTpID").val()
		
		newWindow(url, "RLT01001B",600,350,"yes");
	}
	
	function RequestApp() {
		if($("#myAppr").text() == "") {
			alert("<fmt:message key="PAY01002A.msg1"/>");
			return;
		}
	
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var venueCDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//검증상태가 등록일 경우만 가능
				if(grid.getCellText(_col.verifyStateCD, index[i]) != "10") {
					alert("<fmt:message key="PAY01002A.msg2"/>");
					return;
				}
				//선지원(20)이 아닌경우
				if(grid.getCellText(_col.activityCD, index[i]) != "20") {
					var payAmt_keyman = parseFloat(unformat(grid.getCellText(_col.payAmt_keyman, index[i])));
					var tpayAmt = parseFloat(unformat(grid.getCellText(_col.tpayAmt, index[i])));
					if(payAmt_keyman != tpayAmt) {
						setCellFocus(grid, _col.payAmt_keyman, index[i]);
						alert("<fmt:message key="PAY01002A.msg3"/>");
						return;
					}
				}
				//지급율이 가이드금액보다 크거나, 120%초과가 초과분지급이거나, GSV 항목이 붉은색 조건에 해당하는 경우는 Comment항목이 필수
				var payRate = parseFloat(unformat(grid.getCellText(_col.payRate, index[i])));
				var guidPayRate = parseFloat(unformat(grid.getCellText(_col.guidPayRate, index[i])));
				var gsvRate = parseFloat(unformat(grid.getCellText(_col.gsvRate, index[i])));
				if(payRate > guidPayRate || $("#excPayTpCD").val()=="YPAY" || gsvRate > 10) {
					if(grid.getCellText(_col.commt, index[i]) == "") {
						setCellFocus(grid, _col.commt, index[i]);
						alert("<fmt:message key="PAY01002A.msg7"/>");
						return;
					}
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY01002A.msg4"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay01/requestAppResultVenue_err");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("verifyStateCD", "20");
		table.setParameter("venueCDs", venueCDs);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function ClearRequestApp() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var venueCDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//승인상태가 승인요청인 경우만 취소가능
				if(grid.getCellText(_col.verifyStateCD, index[i]) != "20") {
					alert("<fmt:message key="PAY01002A.msg5"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PAY01002A.msg6"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pay01/clearRequestAppResultVenue_err");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("verifyStateCD", "10");
		table.setParameter("venueCDs", venueCDs);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "PAY0100203S");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("verifyStateCD", $("#verifyStateCD_S").val());
	  	
		var headerText = [
			"<fmt:message key="PAY01002A.programCD"/>"
			, "<fmt:message key="PAY01002A.activityCD"/>"
	   		, "<fmt:message key="PAY01002A.venueCD"/>"
	   		, "<fmt:message key="PAY01002A.venueNm"/>"
	   		, "<fmt:message key="PAY01002A.venueGradCD"/>"
	   		, "<fmt:message key="PAY01002A.segmentCD"/>"
	   		, "<fmt:message key="PAY01002A.subSegmentCD"/>"
	   		, "<fmt:message key="PAY01002A.addrTpCD1"/>"
	   		, "<fmt:message key="PAY01002A.addrTpCD2"/>"
	   		, "<fmt:message key="PAY01002A.tpayAmt"/>"
	   		, "<fmt:message key="PAY01002A.resultTQty"/>"
	   		, "<fmt:message key="PAY01002A.avgUnitAmt"/>"
	   		, "<fmt:message key="PAY01002A.resultTpCDName"/>"
	   		, "<fmt:message key="PAY01002A.targetRate"/>"
	   		, "<fmt:message key="PAY01002A.payRate"/>"
	   		, "<fmt:message key="PAY01002A.excPayTpCDName"/>"
	   		, "<fmt:message key="PAY01002A.gsvRate"/>"
	   		, "<fmt:message key="PAY01002A.commt"/>"
	   		, "<fmt:message key="PAY01002A.payAmt_keyman"/>"
	   		, "<fmt:message key="PAY01002A.verifyErrCommt"/>"
	   		, "<fmt:message key="PAY01002A.verifyStateCD"/>"
       		, "<fmt:message key="PAY01002A.kindTpCD5"/>"
       		, "<fmt:message key="PAY01002A.prdNm"/>"
       		, "<fmt:message key="PAY01002A.factoryPrice"/>"
       		, "<fmt:message key="PAY01002A.qtyUnitCD"/>"
       		, "<fmt:message key="PAY01002A.planQty"/>"
       		, "<fmt:message key="PAY01002A.resultQty"/>"
       		, "<fmt:message key="PAY01002A.resultUnitAmt"/>"
       		, "<fmt:message key="PAY01002A.payAmt"/>"
		];
		
		table.setParameter("templateFile", "PAY01002A");
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
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		""
		, "<fmt:message key="PAY01002A.programCD"/>"
		, "<fmt:message key="PAY01002A.activityCD"/>"
		, "<fmt:message key="PAY01002A.venueCD"/>"
		, "<fmt:message key="PAY01002A.venueNm"/>"
		, "<fmt:message key="PAY01002A.venueGradCD"/>"
		, "<fmt:message key="PAY01002A.segmentCD"/>"
		, "<fmt:message key="PAY01002A.subSegmentCD"/>"
		, "<fmt:message key="PAY01002A.addrTpCD1"/>"
		, "<fmt:message key="PAY01002A.addrTpCD2"/>"
		, "<fmt:message key="PAY01002A.tpayAmt"/>"
		, "<fmt:message key="PAY01002A.resultTQty"/>"
		, "<fmt:message key="PAY01002A.avgUnitAmt"/>"
		, "<fmt:message key="PAY01002A.resultTpCDName"/>"
		, "<fmt:message key="PAY01002A.targetRate"/>"
		, "<fmt:message key="PAY01002A.payRate"/>"
		, "<fmt:message key="PAY01002A.excPayTpCDName"/>"
		, "<fmt:message key="PAY01002A.gsvRate"/>"
		, "<fmt:message key="PAY01002A.commt"/>"
		, "<fmt:message key="PAY01002A.payAmt_keyman"/>"
		, "<fmt:message key="PAY01002A.verifyErrCommt"/>"
		, "<fmt:message key="PAY01002A.verifyStateCD"/>"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                        str, str, str, str, str
	                        , str, str, str, str, str
	                        , num, num, num, str, num
	                        , num, str, num, str, num
	                        , str, html
	                        ]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(5);
	    
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
		
		grid.onRowDoubleClicked = function(event, row){
			$("#selectVenueCD").val(this.getCellText(_col.venueCD,row));
			
	    	var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01002B";
	    	newWindow(url, "RLT01002B",770,340,"yes");
	    	
		};
		
    }
	
</script>