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
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MIL01002B" />
							</td>
						</tr>
						<tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:120px;"></col>
								        			<col style="width:280px;"></col>
								        			<col style="width:100px;"></col>
								        			<col style="width:200px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond-required">
															<fmt:message key="MIL01002A.contractDate" />
														</td>
														<td class="td-input">
														<!-- 
															<nis:calendar id="contractDateFrom_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" /> - 
															<nis:calendar id="contractDateTo_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" />
														-->
															<nis:selectbox id="yearCDFrom_S" name="yearCDFrom_S" defaultText="none" category="YEARCD" />
															<nis:selectbox id="monthCDFrom_S" name="monthCDFrom_S" defaultText="none" category="MONTHCD" />~
															<nis:selectbox id="yearCDTo_S" name="yearCDTo_S" defaultText="none" category="YEARCD" />
															<nis:selectbox id="monthCDTo_S" name="monthCDTo_S" defaultText="none" category="MONTHCD" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="MIL01002A.payRequestDate" />
														</td>
														<td class="td-input">
															<nis:calendar id="payRequestDate_S" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="MIL01002A.mileageStateCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="mileageStateCD_S" name="mileageStateCD_S" defaultText="all" category="MILEAGESTATECD" />
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond">
															<fmt:message key="MIL03001A.rageSphereCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="MIL03001A.officeCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="MIL03001A.venue" />
														</td>
														<td class="td-input">
															<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
														</td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond">
															<fmt:message key="MIL01001B.mileagePayTPCD" />
														</td>
														<td class="td-input" colspan="5">
															<nis:selectbox id="mileagePayTPCD" name="mileagePayTPCD" defaultText="all" category="MILEAGEPAYTPCD"/>
														</td>
						                            </tr>
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
												<fmt:message key="PLN01003A.myAppr" />
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
								<input type="hidden" id="selectMileageID" name="selectMileageID" />
								<input type="hidden" id="apprTpID" name="apprTpID" value="000003" /><!-- Plan/Result승인라인 -->
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

	.aw-column-0 {width: 35px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:center;}
    .aw-column-3 {width: 150px; text-align:left;}
    .aw-column-4 {width: 70px; text-align:center;}
    .aw-column-5 {width: 100px; text-align:left;}
    .aw-column-6 {width: 100px; text-align:left;}
    .aw-column-7 {width: 70px; text-align:center;}
    .aw-column-8 {width: 100px; text-align:center;}
    .aw-column-9 {width: 100px; text-align:center;}
    .aw-column-10 {width: 100px; text-align:center;}
    .aw-column-11 {width: 80px; text-align:right;}
    .aw-column-12 {width: 100px; text-align:right;}
    .aw-column-13 {width: 110px; text-align:right;}
    .aw-column-14 {width: 100px; text-align:right;}
    .aw-column-15 {width: 100px; text-align:right;}
    .aw-column-16 {width: 100px; text-align:right;}
    .aw-column-17 {width: 100px; text-align:right;}
    .aw-column-18 {width: 100px; text-align:right;}
    .aw-column-19 {width: 100px; text-align:right;}
    .aw-column-20 {width: 100px; text-align:right;}
    .aw-column-21 {width: 100px; text-align:right;}
    .aw-column-22 {width: 100px; text-align:right;}
    .aw-column-23 {width: 100px; text-align:center;}
    .aw-column-24 {width: 80px; text-align:center;}
    .aw-column-25 {width: 80px; text-align:center;}
    .aw-column-26 {width: 100px; text-align:center;}
    .aw-column-27 {width: 150px; text-align:left;}

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
			
			//1년전부터
			/*
			if("${params.eventym}"==""){
			    $("#contractDateFrom_S").val("${params.agoYearDate}");
			}else{
				$("#contractDateFrom_S").val("${params.eventym}");
			}
			$("#contractDateTo_S").val("${params.currentDate}");
			*/
			$("#yearCDFrom_S").val(unformat("${params.agoYearDate}").substring(0,4));
			$("#monthCDFrom_S").val(unformat("${params.agoYearDate}").substring(4,6));
			$("#yearCDTo_S").val("${params.clientDate}".substring(0,4));
			$("#monthCDTo_S").val("${params.clientDate}".substring(4,6));
			
			if("${params.eventym}"!=""){
				$("#mileageStateCD_S").val("40");
    			Search();
    		}
			getMyAppr();
		};

		${initScript}

		
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
	
	var _col_cd = {
			"code" : 0
			, "name" : 1
		}
	
	function getOfficeCD(code) {
		if(code=="") {
			$("#officeCD_S").val("");
			$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
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
     	
     	if(table.getCount() > 0) {
	     	$("#officeCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#officeCD_S").attr("disabled",false);
    		$("#officeCD_S").removeClass("input-readonly");
     	}
	}
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}

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
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		checkbox : _i++
		, mileageID : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, contractDateFrom : _i++
		, contractDateTo : _i++
		, contractMonthCt : _i++
		, dueTargetRate : _i++
		, targetRate : _i++
		, msTargetRate : _i++
		, tcontractQty : _i++
		, gsvAmt : _i++
		, gsvRate : _i++
		, contractAmt : _i++
		, contractTaxAmt : _i++
		, addContractAmt : _i++
		, addContractTaxAmt : _i++
		, keymanAmt : _i++
		, payRequestDate : _i++
		, mileageStateCDName : _i++
		, mileagePayTPCDName : _i++
		//, transferDate : _i++
		, commt : _i++
		, mileageStateCD : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MIL0100201S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;mileageID;venueCD;venueNm;venueGradCDName;"+
	  			"segmentCDName;subSegmentCDName;addrTpCD1Name;addrTpCD2Name;contractDateFrom;"+
	  			"contractDateTo;contractMonthCt;dueTargetRate;targetRate;msTargetRate;tcontractQty;"+
	  			"gsvAmt;gsvRate;contractAmt;contractTaxAmt;addContractAmt;addContractTaxAmt;"+
	  			"keymanAmt;payRequestDate;mileageStateCDName;mileagePayTPCDName;commt;"+
	  			"mileageStateCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;num;num;num;num5;num5;"+
	  			"num;num;num;num;num;num;"+
	  			"num;str;str;str;str;"+
	  			"str;");
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("contractDateFrom", $("#yearCDFrom_S").val()+$("#monthCDFrom_S").val());
	  	table.setParameter("contractDateTo", $("#yearCDTo_S").val()+$("#monthCDTo_S").val());
	  	//table.setParameter("contractDateFrom", unformat($("#contractDateFrom_S").val()));
	  	//table.setParameter("contractDateTo", unformat($("#contractDateTo_S").val()));
	  	table.setParameter("payRequestDate", unformat($("#payRequestDate_S").val()));
	  	table.setParameter("mileageStateCD", $("#mileageStateCD_S").val());
		table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("venue_S", $("#venue_S").val());
	  	table.setParameter("mileagePayTPCD", $("#mileagePayTPCD").val());
	  	/*장기단기 분리시 밑의 주석을 풀어줘야함, 기준이 3개월일경우 숫자 3을 입력하면됨*/
	  	//table.setParameter("periodLongTerm", 3);
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
					, table.getData(_col.mileageID,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, formatMonth(table.getData(_col.contractDateFrom,i))
					, formatMonth(table.getData(_col.contractDateTo,i))
					, table.getData(_col.contractMonthCt,i)
					, table.getData(_col.dueTargetRate,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.msTargetRate,i)
					, table.getData(_col.tcontractQty,i)
					, table.getData(_col.gsvAmt,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.contractAmt,i)
					, table.getData(_col.contractTaxAmt,i)
					, table.getData(_col.addContractAmt,i)
					, table.getData(_col.addContractTaxAmt,i)
					, table.getData(_col.keymanAmt,i)
					, formatDate(table.getData(_col.payRequestDate,i))
					, table.getData(_col.mileageStateCDName,i)
					, table.getData(_col.mileagePayTPCDName,i)
					, table.getData(_col.commt,i)
					, table.getData(_col.mileageStateCD,i)
      			];
			}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
	function New() {
		$("#selectMileageID").val("");
		$("#_detail")[0].contentWindow.New();
		appletOpen();
	}
	
	function RequestApp() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var mileageIDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				mileageIDs[count] = grid.getCellText(_col.mileageID, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//상태가 등록일 경우만 가능
				if(grid.getCellText(_col.mileageStateCD, index[i]) != "10") {
					alert("<fmt:message key="MIL01002A.msg1"/>");
					return;
				}
				var keymanAmt = Number(unformat(grid.getCellValue(_col.keymanAmt, index[i])));
				var addContractAmt = Number(unformat(grid.getCellValue(_col.addContractAmt, index[i])));
				if(addContractAmt != keymanAmt) {
					setCellFocus(grid, _col.keymanAmt, index[i]);
					alert("<fmt:message key="MIL01002A.msg2"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="MIL01002A.msg3"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mil01/requestPayMileageRlt");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("mileageStateCD", "20");
		table.setParameter("mileageIDs", mileageIDs);
		table.setParameter("apprTpID", $("#apprTpID").val());
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
	
	function ClearRequestApp() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var mileageIDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				mileageIDs[count] = grid.getCellText(_col.mileageID, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//상태가 지급요청인 경우만 취소가능
				if(grid.getCellText(_col.mileageStateCD, index[i]) != "20") {
					alert("<fmt:message key="MIL01002A.msg4"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="MIL01002A.msg5"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mil01/clearRequestPayMileageRlt");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("mileageStateCD", "10");
		table.setParameter("mileageIDs", mileageIDs);
		table.setParameter("apprTpID", $("#apprTpID").val());
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
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "MIL0100206S");

		table.setParameter("empID", "${params.empID}");
		table.setParameter("contractDateFrom", $("#yearCDFrom_S").val()+$("#monthCDFrom_S").val());
	  	table.setParameter("contractDateTo", $("#yearCDTo_S").val()+$("#monthCDTo_S").val());
	  	//table.setParameter("contractDateFrom", unformat($("#contractDateFrom_S").val()));
	  	//table.setParameter("contractDateTo", unformat($("#contractDateTo_S").val()));
	  	table.setParameter("payRequestDate", unformat($("#payRequestDate_S").val()));
	  	table.setParameter("mileageStateCD", $("#mileageStateCD_S").val());
		table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("venue_S", $("#venue_S").val());
	  	table.setParameter("mileagePayTPCD", $("#mileagePayTPCD").val());
	  	/*장기단기 분리시 밑의 주석을 풀어줘야함, 기준이 3개월일경우 숫자 3을 입력하면됨*/
	  	//table.setParameter("periodLongTerm", 3);
	  	
		table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("venue_S", $("#venue_S").val());
	  	
		var headerText = [
			"<fmt:message key="MIL01002A.mileageID"/>"
			, "<fmt:message key="MIL01002A.venueCD"/>"
			, "<fmt:message key="MIL01002A.venueNm"/>"
			, "<fmt:message key="MIL01002A.venueGradCD"/>"
			, "<fmt:message key="MIL01002A.segmentCD"/>"
			, "<fmt:message key="MIL01002A.subSegmentCD"/>"
			, "<fmt:message key="MIL01002A.addrTpCD1"/>"
			, "<fmt:message key="MIL01002A.addrTpCD2"/>"
			, "<fmt:message key="MIL01002A.contractDateFrom"/>"
			, "<fmt:message key="MIL01002A.contractDateTo"/>"
			, "<fmt:message key="MIL01002A.contractMonthCt"/>"
			, "<fmt:message key="MIL01002A.dueTargetRate"/>"
			, "<fmt:message key="MIL01002A.targetRate"/>"
			, "<fmt:message key="MIL01002A.msTargetRate"/>"
			, "<fmt:message key="MIL01002A.tcontractQty"/>"
			, "<fmt:message key="MIL01002A.gsvAmt"/>"
			, "<fmt:message key="MIL01002A.gsvRate"/>"
			, "<fmt:message key="MIL01002A.contractAmt"/>"
			, "<fmt:message key="MIL01002A.contractTaxAmt"/>"
			, "<fmt:message key="MIL01002A.addContractAmt"/>"
			, "<fmt:message key="MIL01002A.addContractTaxAmt"/>"
			, "<fmt:message key="MIL01002A.keymanAmt"/>"
			, "<fmt:message key="MIL01002A.payRequestDate"/>"
			, "<fmt:message key="MIL01002A.mileageStateCD"/>"
			, "<fmt:message key="MIL01002A.mileagePayTPCD"/>"
			, "<fmt:message key="MIL01002A.commt"/>"
			, "<fmt:message key="MIL01002A.eventYM"/>"
			, "<fmt:message key="MIL01002B.kindTpCD5"/>"
			, "<fmt:message key="MIL01002B.prdNm"/>"
			, "<fmt:message key="MIL01002B.factoryPrice"/>"
			, "<fmt:message key="MIL01002B.qtyUnitCD"/>"
			, "<fmt:message key="MIL01002B.contractQty"/>"
			, "<fmt:message key="MIL01002B.plnEnterQty"/>"
			, "<fmt:message key="MIL01002B.plnEnterUnitAmt"/>"
			, "<fmt:message key="MIL01002B.plnAddEnterUnitAmt"/>"
			, "<fmt:message key="MIL01002B.rltEnterQty"/>"
			, "<fmt:message key="MIL01002B.rltEnterUnitAmt"/>"
			, "<fmt:message key="MIL01002B.addEnterUnitAmt"/>"
			, "<fmt:message key="MIL01002B.payAmt"/>"
			, "<fmt:message key="MIL01002B.addPayAmt"/>"
		];
		
		table.setParameter("templateFile", "MIL01002A");
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
   		, "<fmt:message key="MIL01002A.mileageID"/>"
		, "<fmt:message key="MIL01002A.venueCD"/>"
		, "<fmt:message key="MIL01002A.venueNm"/>"
		, "<fmt:message key="MIL01002A.venueGradCD"/>"
		, "<fmt:message key="MIL01002A.segmentCD"/>"
		, "<fmt:message key="MIL01002A.subSegmentCD"/>"
		, "<fmt:message key="MIL01002A.addrTpCD1"/>"
		, "<fmt:message key="MIL01002A.addrTpCD2"/>"
		, "<fmt:message key="MIL01002A.contractDateFrom"/>"
		, "<fmt:message key="MIL01002A.contractDateTo"/>"
		, "<fmt:message key="MIL01002A.contractMonthCt"/>"
		, "<fmt:message key="MIL01002A.dueTargetRate"/>"
		, "<fmt:message key="MIL01002A.targetRate"/>"
		, "<fmt:message key="MIL01002A.msTargetRate"/>"
		, "<fmt:message key="MIL01002A.tcontractQty"/>"
		, "<fmt:message key="MIL01002A.gsvAmt"/>"
		, "<fmt:message key="MIL01002A.gsvRate"/>"
		, "<fmt:message key="MIL01002A.contractAmt"/>"
		, "<fmt:message key="MIL01002A.contractTaxAmt"/>"
		, "<fmt:message key="MIL01002A.addContractAmt"/>"
		, "<fmt:message key="MIL01002A.addContractTaxAmt"/>"
		, "<fmt:message key="MIL01002A.keymanAmt"/>"
		, "<fmt:message key="MIL01002A.payRequestDate"/>"
		, "<fmt:message key="MIL01002A.mileageStateCD"/>"
		, "<fmt:message key="MIL01002A.mileagePayTPCD"/>"
		//, "<fmt:message key="MIL01002A.transferDate"/>"
		, "<fmt:message key="MIL01002A.commt"/>"
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
	                        , str, num, num,num, num5, num5
	                        , num, num, num, num, num, num
	                        , num, str, str, str, str
	                        ]);
	    grid.setCellEditable(false);
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
		
		grid.onRowDoubleClicked = function(event, row){
			$("#selectMileageID").val(this.getCellText(_col.mileageID,row));
			$("#_detail")[0].contentWindow.Search();
			appletOpen();
		};
		
    }
	
</script>