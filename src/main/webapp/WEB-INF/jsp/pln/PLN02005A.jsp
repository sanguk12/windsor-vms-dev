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
						        			<col style="width:80px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:80px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:80px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:80px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="PLN02005A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                 <td class="td-cond">
													<fmt:message key="PLN02005A.activityCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
				                            	<td class="td-cond">
													<fmt:message key="PLN02005A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PLN02005A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
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
					<td height="45%">
						<span id="grid_all"></span>
					</td>
				</tr>
                <tr>
					<td height="*">
						<span id="grid_exception"></span>
					</td>
				</tr>
				<tr>
					<td height="1">
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="diffNo" name="diffNo" value="9" /><!-- G1 -->
						<input type="hidden" id="apprTpID" name="apprTpID" value="000000" /><!-- Plan/Result 승인라인 -->
						<input type="hidden" id="apprTpID_Normal" name="apprTpID_Normal" value="000004" /><!-- Result Normal 승인라인 -->
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 200px; text-align:center;}
	.aw-column-1 {width: 70px; text-align:center;}
	.aw-column-2 {width: 70px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:right;}
    .aw-column-4 {width: 120px; text-align:right;}
    .aw-column-5 {width: 100px; text-align:right;}
    .aw-column-6 {width: 100px; text-align:right;}
    .aw-column-7 {width: 150px; text-align:right;}
    .aw-column-8 {width: 140px; text-align:right;}
    .aw-column-9 {width: 120px; text-align:right;}
    .aw-column-10 {width: 120px; text-align:right;}
    .aw-column-11 {width: 80px; text-align:right;}

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
			
			createGrid_all();
			grid_all.refresh();
			createGrid_exception();
			grid_exception.refresh();
			
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));
    		$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
		};

		${initScript}

		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
			Search();
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
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i_all = 0;
	var _col_all = {
	    gubun : _i_all++
		, eventYM : _i_all++
		, typeName : _i_all++
		, venueCount : _i_all++
		, planQty : _i_all++
		, eu : _i_all++
		, payAmt : _i_all++
		, avgUnitAmt : _i_all++
		, avgEuUnitAmt : _i_all++
		, nsv : _i_all++
		, gp : _i_all++
		, gpRate : _i_all++
		, seq : _i_all++
		, levelNo : _i_all++
		, lastApprYN : _i_all++
    };
	function Search() {
		/** 조회월의 4개월전부터 1개월전 구하기*/
		var fromDate = new Date($("#yearCD_S").val(), $("#monthCD_S").val()-4, '01');
		var toDate = new Date($("#yearCD_S").val(), $("#monthCD_S").val()-2, '01');
		
		var fYear = fromDate.getYear();
		var fMonth = fromDate.getMonth()+1;
		var tYear = toDate.getYear();
		var tMonth = toDate.getMonth()+1;
		
		if(fMonth < 10) fMonth = '0'+fMonth;		
		if(tMonth < 10) tMonth = '0'+tMonth;		
		
		var fromMonth;
		var toMonth;
		
		fromMonth = fYear +''+ fMonth;
		toMonth = tYear +''+ tMonth;
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0200501S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"gubun;eventYM;typeName;venueCount;planQty;"+
	  			"eu;payAmt;avgUnitAmt;avgEuUnitAmt;nsv;"+
	  			"gp;gpRate;seq;levelNo;lastApprYN;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;");
	  	table.setParameter("fromMonth", fromMonth);
	  	table.setParameter("toMonth", toMonth);
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("apprTpID_Normal", $("#apprTpID_Normal").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	 	// --- 그룹 권한에 따라 empId가 'MK'로 시작하는 담당자 이름은 보이지 않도록 수정 2016.04.20
		if(		   '${params.grpID}' == '000004' || '${params.grpID}' == '000003' || '${params.grpID}' == '000002' 
				|| '${params.grpID}' == '000026' || '${params.grpID}' == '000005'
				|| '${params.grpID}' == '000013' || '${params.grpID}' == '000016' || '${params.grpID}' == '000018'
				|| '${params.grpID}' == '000017' || '${params.grpID}' == '000023' || '${params.grpID}' == '000024'){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
		// ---
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid_all();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			var gubun = "";
      			var eventYM = "";
      			var typeName = "";
      			var venueCount = "";
      			var planQty = "";
      			var eu = "";
      			var payAmt = "";
      			var avgUnitAmt = "";
      			var avgEuUnitAmt = "";
      			var nsv = "";
      			var gp = "";
      			var gpRate = "";
      			var seq = "";
      			var levelNo = "";
      			var lastApprYN = "";
      			
      			if(table.getData(_col_all.seq,i) == "2") {
      				gubun = table.getData(_col_all.gubun,i);
      				eventYM = formatMonth(table.getData(_col_all.eventYM,i));
      				typeName = table.getData(_col_all.typeName,i);
      				venueCount = formatNum(table.getData(_col_all.venueCount,i))+' '+'%';
      				planQty = formatNum(table.getData(_col_all.planQty,i))+' '+'%';
      				eu = formatNum(table.getData(_col_all.eu,i))+' '+'%';
      				payAmt = formatNum(table.getData(_col_all.payAmt,i))+' '+'%';
      				avgUnitAmt = formatNum(table.getData(_col_all.avgUnitAmt,i))+' '+'%';
      				avgEuUnitAmt = formatNum(table.getData(_col_all.avgEuUnitAmt,i))+' '+'%';
      				nsv = formatNum(table.getData(_col_all.nsv,i))+' '+'%';
      				gp = formatNum(table.getData(_col_all.gp,i))+' '+'%';
      				gpRate = formatNum(table.getData(_col_all.gpRate,i))+' '+'%';
      				seq = table.getData(_col_all.seq,i);
      				levelNo = table.getData(_col_all.levelNo,i);
      				lastApprYN = table.getData(_col_all.lastApprYN,i);
      			} else {
      				gubun = table.getData(_col_all.gubun,i);
      				eventYM = formatMonth(table.getData(_col_all.eventYM,i));
      				typeName = table.getData(_col_all.typeName,i);
      				venueCount = formatNum(table.getData(_col_all.venueCount,i));
      				planQty = formatNum(table.getData(_col_all.planQty,i));
      				eu = formatNum(table.getData(_col_all.eu,i));
      				payAmt = formatNum(table.getData(_col_all.payAmt,i));
      				avgUnitAmt = formatNum(table.getData(_col_all.avgUnitAmt,i));
      				avgEuUnitAmt = formatNum(table.getData(_col_all.avgEuUnitAmt,i));
      				nsv = formatNum(table.getData(_col_all.nsv,i));
      				gp = formatNum(table.getData(_col_all.gp,i));
      				gpRate = formatNum(table.getData(_col_all.gpRate,i))+' '+'%';
      				seq = table.getData(_col_all.seq,i);
      				levelNo = table.getData(_col_all.levelNo,i);
      				lastApprYN = table.getData(_col_all.lastApprYN,i);
      			}
      			
      			data[i] = [
					gubun,
					eventYM,
					typeName,
					venueCount,
					planQty,
					eu,
					payAmt,
					avgUnitAmt,
					avgEuUnitAmt,
					nsv,
					gp,
					gpRate,
					seq,
					levelNo,
					lastApprYN
      			];
      			
      			if(table.getData(_col_all.typeName,i) == "Plan"){
      				grid_all.getCellTemplate(_col_all.gubun,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.eventYM,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.typeName,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.venueCount,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.planQty,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.eu,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.payAmt,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.avgUnitAmt,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.avgEuUnitAmt,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.nsv,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.gp,i).setStyle("font-weight", "bold");
      				grid_all.getCellTemplate(_col_all.gpRate,i).setStyle("font-weight", "bold");
      			}
      			
      		}
      		grid_all.setCellData(data);
      		grid_all.setRowCount(rowCount);
      	}
      	else {
			message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid_all");
      	}
      	grid_all.refresh();
      	
      	Search_exception(fromMonth,toMonth);
	}
	
	var _i_exception = 0;
	var _col_exception = {
	    gubun : _i_exception++
		, eventYM : _i_exception++
		, typeName : _i_exception++
		, venueCount : _i_exception++
		, planQty : _i_exception++
		, eu : _i_exception++
		, payAmt : _i_exception++
		, avgUnitAmt : _i_exception++
		, avgEuUnitAmt : _i_exception++
		, nsv : _i_exception++
		, gp : _i_exception++
		, gpRate : _i_exception++
		, seq : _i_exception++
    };
	function Search_exception(fromMonth,toMonth) {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0200502S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"gubun;eventYM;typeName;venueCount;planQty;"+
	  			"eu;payAmt;avgUnitAmt;avgEuUnitAmt;nsv;"+
	  			"gp;gpRate;seq;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;");
	  	table.setParameter("fromMonth", fromMonth);
	  	table.setParameter("toMonth", toMonth);
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("apprTpID_Normal", $("#apprTpID_Normal").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	 	// --- 그룹 권한에 따라 empId가 'MK'로 시작하는 담당자 이름은 보이지 않도록 수정 2016.04.20
		if(		   '${params.grpID}' == '000004' || '${params.grpID}' == '000003' || '${params.grpID}' == '000002' 
				|| '${params.grpID}' == '000026' || '${params.grpID}' == '000005'
				|| '${params.grpID}' == '000013' || '${params.grpID}' == '000016' || '${params.grpID}' == '000018'
				|| '${params.grpID}' == '000017' || '${params.grpID}' == '000023' || '${params.grpID}' == '000024'){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
		// ---
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid_exception();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			var gubun = "";
      			var eventYM = "";
      			var typeName = "";
      			var venueCount = "";
      			var planQty = "";
      			var eu = "";
      			var payAmt = "";
      			var avgUnitAmt = "";
      			var avgEuUnitAmt = "";
      			var nsv = "";
      			var gp = "";
      			var gpRate = "";
      			
      			if(table.getData(_col_exception.seq,i) == "2") {
      				gubun = table.getData(_col_exception.gubun,i);
      				eventYM = formatMonth(table.getData(_col_exception.eventYM,i));
      				typeName = table.getData(_col_exception.typeName,i);
      				venueCount = formatNum(table.getData(_col_exception.venueCount,i))+' '+'%';
      				planQty = formatNum(table.getData(_col_exception.planQty,i))+' '+'%';
      				eu = formatNum(table.getData(_col_exception.eu,i))+' '+'%';
      				payAmt = formatNum(table.getData(_col_exception.payAmt,i))+' '+'%';
      				avgUnitAmt = formatNum(table.getData(_col_exception.avgUnitAmt,i))+' '+'%';
      				avgEuUnitAmt = formatNum(table.getData(_col_exception.avgEuUnitAmt,i))+' '+'%';
      				nsv = formatNum(table.getData(_col_exception.nsv,i))+' '+'%';
      				gp = formatNum(table.getData(_col_exception.gp,i))+' '+'%';
      				gpRate = formatNum(table.getData(_col_exception.gpRate,i))+' '+'%';
      			} else {
      				gubun = table.getData(_col_exception.gubun,i);
      				eventYM = formatMonth(table.getData(_col_exception.eventYM,i));
      				typeName = table.getData(_col_exception.typeName,i);
      				venueCount = formatNum(table.getData(_col_exception.venueCount,i));
      				planQty = formatNum(table.getData(_col_exception.planQty,i));
      				eu = formatNum(table.getData(_col_exception.eu,i));
      				payAmt = formatNum(table.getData(_col_exception.payAmt,i));
      				avgUnitAmt = formatNum(table.getData(_col_exception.avgUnitAmt,i));
      				avgEuUnitAmt = formatNum(table.getData(_col_exception.avgEuUnitAmt,i));
      				nsv = formatNum(table.getData(_col_exception.nsv,i));
      				gp = formatNum(table.getData(_col_exception.gp,i));
      				gpRate = formatNum(table.getData(_col_exception.gpRate,i))+' '+'%';
      			}
      			
      			data[i] = [
					gubun,
					eventYM,
					typeName,
					venueCount,
					planQty,
					eu,
					payAmt,
					avgUnitAmt,
					avgEuUnitAmt,
					nsv,
					gp,
					gpRate
      			];
      			if(table.getData(_col_exception.typeName,i) == "Plan"){
      				grid_exception.getCellTemplate(_col_exception.gubun,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.eventYM,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.typeName,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.venueCount,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.planQty,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.eu,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.payAmt,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.avgUnitAmt,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.avgEuUnitAmt,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.nsv,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.gp,i).setStyle("font-weight", "bold");
      				grid_exception.getCellTemplate(_col_exception.gpRate,i).setStyle("font-weight", "bold");
      			}
      		}
      		grid_exception.setCellData(data);
      		grid_exception.setRowCount(rowCount);
      	}
      	else {
			message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid_exception");
      	}
      	grid_exception.refresh();
	}
	
	function Approval() {
		var index = grid_all.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid_all.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var levelNos = new Array();
		var lastApprYNs = new Array();
		var count = 0;

		for (var i=0; i<index.length; i++) {
			if (grid_all.getCellValue(_col_all.typeName, index[i]) == "Plan") {
				levelNos[count] = grid_all.getCellText(_col_all.levelNo, index[i]);
				lastApprYNs[count] = grid_all.getCellText(_col_all.lastApprYN, index[i]);
				count++;
			}
		}
		
		if(!confirm("<fmt:message key="PLN02005A.msg1"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln02/approvalPlanVenue_new");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
		table.setParameter("lastApprYNs", lastApprYNs);
		table.setParameter("levelNos", levelNos);
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Reject() {
		if(!confirm("<fmt:message key="PLN02005A.msg2"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln02/rejectPlanVenue_new");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Excel() {
		/** 조회월의 4개월전부터 1개월전 구하기*/
		var fromDate = new Date($("#yearCD_S").val(), $("#monthCD_S").val()-4, '01');
		var toDate = new Date($("#yearCD_S").val(), $("#monthCD_S").val()-2, '01');
		
		var fYear = fromDate.getYear();
		var fMonth = fromDate.getMonth()+1;
		var tYear = toDate.getYear();
		var tMonth = toDate.getMonth()+1;
		
		if(fMonth < 10) fMonth = '0'+fMonth;		
		if(tMonth < 10) tMonth = '0'+tMonth;		
		
		var fromMonth;
		var toMonth;
		
		fromMonth = fYear +''+ fMonth;
		toMonth = tYear +''+ tMonth;
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "PLN0200501S");
		table.setParameter("fromMonth", fromMonth);
	  	table.setParameter("toMonth", toMonth);
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("apprTpID_Normal", $("#apprTpID_Normal").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	 	// --- 그룹 권한에 따라 empId가 'MK'로 시작하는 담당자 이름은 보이지 않도록 수정 2016.04.20
		if(		   '${params.grpID}' == '000004' || '${params.grpID}' == '000003' || '${params.grpID}' == '000002' 
				|| '${params.grpID}' == '000026' || '${params.grpID}' == '000005'
				|| '${params.grpID}' == '000013' || '${params.grpID}' == '000016' || '${params.grpID}' == '000018'
				|| '${params.grpID}' == '000017' || '${params.grpID}' == '000023' || '${params.grpID}' == '000024'){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
		// ---
		
		var headerText = [
			"",
			"<fmt:message key="PLN02005A.Period"/>"
			, "<fmt:message key="PLN02005A.Type"/>"
			, "<fmt:message key="PLN02005A.VenueNumber"/>"
			, "<fmt:message key="PLN02005A.Volume(ActualCase)"/>"
			, "<fmt:message key="PLN02005A.Volume(EU)"/>"
			, "<fmt:message key="PLN02005A.Incentive(KKRW)"/>"
			, "<fmt:message key="PLN02005A.CaserateperA/C(KKRW)"/>"
			, "<fmt:message key="PLN02005A.CaserateperEU(KKRW)"/>"
			, "<fmt:message key="PLN02005A.NSV(KKRW)"/>"
			, "<fmt:message key="PLN02005A.GP(KKRW)"/>"
			, "<fmt:message key="PLN02005A.GPrate(%)"/>"
		];
		
		table.setParameter("templateFile", "PLN02005A");
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
	var columns_all = [
        "",
		"<fmt:message key="PLN02005A.Period"/>"
		, "<fmt:message key="PLN02005A.Type"/>"
		, "<fmt:message key="PLN02005A.VenueNumber"/>"
		, "<fmt:message key="PLN02005A.Volume(ActualCase)"/>"
		, "<fmt:message key="PLN02005A.Volume(EU)"/>"
		, "<fmt:message key="PLN02005A.Incentive(KKRW)"/>"
		, "<fmt:message key="PLN02005A.CaserateperA/C(KKRW)"/>"
		, "<fmt:message key="PLN02005A.CaserateperEU(KKRW)"/>"
		, "<fmt:message key="PLN02005A.NSV(KKRW)"/>"
		, "<fmt:message key="PLN02005A.GP(KKRW)"/>"
		, "<fmt:message key="PLN02005A.GPrate(%)"/>"
	];

	var grid_all = null;
	function createGrid_all() {
		grid_all = new AW.UI.Grid;
		grid_all.setId("grid_all");
		grid_all.setRowCount(0);
		grid_all.setStyle("width","100%");
	    grid_all.setStyle("height","100%");
	    grid_all.setSelectorVisible(false);
	    grid_all.setSelectionMode("single-row");
	    grid_all.setHeaderText(columns_all);
	    for(var i=0;i<columns_all.length;i++){grid_all.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_all.setColumnCount(columns_all.length);
	    grid_all.setCellFormat([
	                        str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str
	                        ]);
	    grid_all.setCellEditable(false);
	    
    }
	
	var columns_exception = [
		"",
		"<fmt:message key="PLN02005A.Period"/>"
		, "<fmt:message key="PLN02005A.Type"/>"
		, "<fmt:message key="PLN02005A.VenueNumber"/>"
		, "<fmt:message key="PLN02005A.Volume(ActualCase)"/>"
		, "<fmt:message key="PLN02005A.Volume(EU)"/>"
		, "<fmt:message key="PLN02005A.Incentive(KKRW)"/>"
		, "<fmt:message key="PLN02005A.CaserateperA/C(KKRW)"/>"
		, "<fmt:message key="PLN02005A.CaserateperEU(KKRW)"/>"
		, "<fmt:message key="PLN02005A.NSV(KKRW)"/>"
		, "<fmt:message key="PLN02005A.GP(KKRW)"/>"
		, "<fmt:message key="PLN02005A.GPrate(%)"/>"
	];

	var grid_exception = null;
	function createGrid_exception() {
		grid_exception = new AW.UI.Grid;
		grid_exception.setId("grid_exception");
		grid_exception.setRowCount(0);
		grid_exception.setStyle("width","100%");
	    grid_exception.setStyle("height","100%");
	    grid_exception.setSelectorVisible(false);
	    grid_exception.setSelectionMode("single-row");
	    grid_exception.setHeaderText(columns_exception);
	    for(var i=0;i<columns_exception.length;i++){grid_exception.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_exception.setColumnCount(columns_exception.length);
	    grid_exception.setCellFormat([
	                        str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str
	                        ]);
	    grid_exception.setCellEditable(false);
	    
    }
	
</script>