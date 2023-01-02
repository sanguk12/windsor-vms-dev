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
								        			<col style="width:300px;"></col>
								        			<col style="width:100px;"></col>
								        			<col style="width:150px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond">
															<fmt:message key="KEY03002A.venueGradCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03002A.addrTpCD1" />
														</td>
														<td class="td-input">
															<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03002A.addrTpCD2" />
														</td>
														<td class="td-input">
															<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond">
															<fmt:message key="KEY03002A.venue" />
														</td>
														<td class="td-input">
															<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03002A.empNm" />
														</td>
														<td class="td-input">
															<input type="text" id="empNm_S" name="empNm_S" style="width:100px;" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03002A.activeYN" />
														</td>
														<td class="td-input">
															<nis:selectbox id="activeYN_S" name="activeYN_S" defaultText="all" category="ACTIVEYN" />
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond-required">
															<fmt:message key="KEY03002A.applyDate" />
														</td>
														<td class="td-input" colspan="5">
															<nis:calendar id="lApplyDateFrom_S" cssClass="input-readonly" readOnly="yes" /> - 
															<nis:calendar id="lApplyDateTo_S" cssClass="input-readonly" readOnly="yes" />
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

	.aw-column-0 {width: 80px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 120px; }
    .aw-column-3 {width: 80px; text-align:center;}
    .aw-column-4 {width: 100px; }
    .aw-column-5 {width: 80px; text-align:center;}
    .aw-column-6 {width: 120px; text-align:center;}
    .aw-column-7 {width: 80px; text-align:center;}
    .aw-column-8 {width: 80px; text-align:center;}
    .aw-column-9 {width: 120px; }
    .aw-column-10 {width: 100px; text-align:center;}
    .aw-column-11 {width: 80px; text-align:center;}
    .aw-column-12 {width: 80px; text-align:center;}
    .aw-column-13 {width: 120px; text-align:center;}
    .aw-column-14 {width: 100px; text-align:center;}
    .aw-column-15 {width: 80px; text-align:center;}
    .aw-column-16 {width: 80px; text-align:center;}
    .aw-column-17 {width: 100px; text-align:center;}
    .aw-column-18 {width: 120px; }
    .aw-column-19 {width: 80px; text-align:center;}

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
			
			$("#grid_displayNum").val("100");
			createGrid();
			grid.refresh();
			
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
    		
			$("#lApplyDateFrom_S").val("${params.firstDate}");
			$("#lApplyDateTo_S").val("${params.currentDate}");
			
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
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
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
	
	
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	function Search() {
		$("#grid_pageNum").val("1");
		PagingSearch();
	}
	
	var _i = 0;
	var _col = {
		empNm : _i++
		, venueCD : _i++
		, venueNm : _i++
		, keymanID : _i++
		, keymanNm : _i++
		, keymanTypeCDName : _i++
		, regIDNo : _i++
		, birthDate : _i++
		, dutyCDName : _i++
		, addr : _i++
		, phoneNo : _i++
		, bankCD : _i++
		, bankCDName : _i++
		, accountNo : _i++
		, holderNm : _i++
		, PkeymanYN : _i++
		, activeYNName : _i++
		, oldKeymanID : _i++
		, note : _i++
		, lApplyDate : _i++
		, keymanTypeCD : _i++
		, activeYN : _i++
		, rowNum : _i++
    };
	
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0300201S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"empNm;venueCD;venueNm;keymanID;keymanNm;"+
	  			"keymanTypeCDName;regIDNo;birthDate;dutyCDName;addr;"+
	  			"phoneNo;bankCD;bankCDName;accountNo;holderNm;"+
	  			"PkeymanYN;activeYNName;oldKeymanID;note;lApplyDate;"+
	  			"keymanTypeCD;activeYN;rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;");
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("empNm", $("#empNm_S").val());
	  	table.setParameter("activeYN", $("#activeYN_S").val());
	  	table.setParameter("lApplyDateFrom", convertDate($("#lApplyDateFrom_S").val()));
	  	table.setParameter("lApplyDateTo", convertDate($("#lApplyDateTo_S").val()));
		//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
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
		
		// -- 그룹 권한에 따라 주민/사업자번호 가 보이지 않도록 수정 2016.10.11
		if('${params.grpID}' == '000006' || '${params.grpID}' == '000009' || '${params.grpID}' == '000010' || '${params.grpID}' == '000001' ){
			table.setParameter("grpID2", "Y");
		}else{
			table.setParameter("grpID2", "");
		}
	  	
		// --
		
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		/* alert(table.getData(_col.regIDNo,0).length); */
      		for (var i=0; i<rowCount; i++) {
      			var regNo = "";
      			if(table.getData(_col.regIDNo,i).length > 12){					//주민번호 포맷
      				regNo = formatIDNo(table.getData(_col.regIDNo,i), "");
      			}else if(table.getData(_col.regIDNo,i).length == 10){			//사업자번호 포맷
      				regNo = formatBizRegNo(table.getData(_col.regIDNo,i), "")	
      			}
      		
      			data[i] = [
					table.getData(_col.empNm,i)
					, table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
      			    , table.getData(_col.keymanID,i)
					, table.getData(_col.keymanNm,i)
					, table.getData(_col.keymanTypeCDName,i)
					, regNo
					, formatDate(table.getData(_col.birthDate,i))
					, table.getData(_col.dutyCDName,i)
					, table.getData(_col.addr,i)
					, table.getData(_col.phoneNo,i)
					, table.getData(_col.bankCD,i)
					, table.getData(_col.bankCDName,i)
					, table.getData(_col.accountNo,i)
					, table.getData(_col.holderNm,i)
					, table.getData(_col.PkeymanYN,i)
					, table.getData(_col.activeYNName,i)
					, table.getData(_col.oldKeymanID,i)
					, table.getData(_col.note,i)
					, formatDate(table.getData(_col.lApplyDate,i))
					, table.getData(_col.keymanTypeCD,i)
					, table.getData(_col.activeYN,i)
      			];
      			
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/KEY0300202S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("outParamKey","totalCount;");
			table.setParameter("format","str;");
			table.request();
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo('grid', beginRowNum, endRowNum, table.getData(0,0));
      	}
      	else {
			message("<fmt:message key="info.nullData"/>");	//조회건수 없을때 메시지
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
      	}
      	grid.refresh();
    }
	
	function Save() {

		if(grid.getRowCount() == 0) {
			alert("<fmt:message key="info.validate.gridSelect"/>");
			return;
		}
		
		var keymanIDs = new Array();
		var activeYNs = new Array();
		var regIDNos = new Array();
		var birthDates = new Array();
		
		
		var count = 0;
		for (var i=0; i<grid.getRowCount(); i++) {
			
			keymanIDs[count] = grid.getCellText(_col.keymanID, i);
			activeYNs[count] = grid.getCellText(_col.activeYN, i);
			regIDNos[count] = unformat(grid.getCellText(_col.regIDNo, i));
			birthDates[count] = unformat(grid.getCellText(_col.birthDate, i));
			
			count++;
		}
		

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key03/saveKeymanActiveYN");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("keymanIDs", keymanIDs);
		table.setParameter("activeYNs", activeYNs);
		table.setParameter("regIDNos", regIDNos);
		table.setParameter("birthDates", birthDates);
		
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
		showLoading();
		if(!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "KEY0300201S");
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("empNm", $("#empNm_S").val());
	  	table.setParameter("activeYN", $("#activeYN_S").val());
	  	table.setParameter("lApplyDateFrom", convertDate($("#lApplyDateFrom_S").val()));
	  	table.setParameter("lApplyDateTo", convertDate($("#lApplyDateTo_S").val()));
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
		
		// -- 그룹 권한에 따라 주민/사업자번호 가 보이지 않도록 수정 2016.10.11
		if('${params.grpID}' == '000006' || '${params.grpID}' == '000009' || '${params.grpID}' == '000010'  || '${params.grpID}' == '000001' ){
			table.setParameter("grpID2", "Y");
		}else{
			table.setParameter("grpID2", "");
		}
		// --
		
		var headerText = [
			"<fmt:message key="KEY03002A.empNm"/>"
			, "<fmt:message key="KEY03002A.venueCD"/>"
			, "<fmt:message key="KEY03002A.venueNm"/>"
			, "<fmt:message key="KEY03002A.keymanID"/>"
			, "<fmt:message key="KEY03002A.keymanNm"/>"
			, "<fmt:message key="KEY03002A.keymanTpCD"/>"
			, "<fmt:message key="KEY03002A.regIDNo"/>"
			, "<fmt:message key="KEY03002A.birthDate"/>"
			, "<fmt:message key="KEY03002A.dutyCD"/>"
			, "<fmt:message key="KEY03002A.addr"/>"
			, "<fmt:message key="KEY03002A.phoneNo"/>"
			, "<fmt:message key="KEY03002A.bankCD"/>"
			, "<fmt:message key="KEY03002A.bankCDName"/>"
			, "<fmt:message key="KEY03002A.accountNo"/>"
			, "<fmt:message key="KEY03002A.holderNm"/>"
			, "<fmt:message key="KEY03002A.PKeymanYN"/>"
			, "<fmt:message key="KEY03002A.activeYN"/>"
			, "<fmt:message key="KEY03002A.oldKeymanID"/>"
			, "<fmt:message key="KEY03002A.note"/>"
			, "<fmt:message key="KEY03002A.lApplyDate"/>"
		];
		
		table.setParameter("templateFile", "KEY03002A");
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
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="KEY03002A.empNm"/>"
		, "<fmt:message key="KEY03002A.venueCD"/>"
		, "<fmt:message key="KEY03002A.venueNm"/>"
		, "<fmt:message key="KEY03002A.keymanID"/>"
		, "<fmt:message key="KEY03002A.keymanNm"/>"
		, "<fmt:message key="KEY03002A.keymanTpCD"/>"
		, "<fmt:message key="KEY03002A.regIDNo"/>"
		, "<fmt:message key="KEY03002A.birthDate"/>"
		, "<fmt:message key="KEY03002A.dutyCD"/>"
		, "<fmt:message key="KEY03002A.addr"/>"
		, "<fmt:message key="KEY03002A.phoneNo"/>"
		, "<fmt:message key="KEY03002A.bankCD"/>"
		, "<fmt:message key="KEY03002A.bankCDName"/>"
		, "<fmt:message key="KEY03002A.accountNo"/>"
		, "<fmt:message key="KEY03002A.holderNm"/>"
		, "<fmt:message key="KEY03002A.PKeymanYN"/>"
		, "<fmt:message key="KEY03002A.activeYN"/>"
		, "<fmt:message key="KEY03002A.oldKeymanID"/>"
		, "<fmt:message key="KEY03002A.note"/>"
		, "<fmt:message key="KEY03002A.lApplyDate"/>"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false); //그리드 순번표기 on/off기능
	    grid.setSelectionMode("single-cell");
	    grid.setHeaderText(columns);	//그리드 컬럼 적용 
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}	//그리드 컬럼의 속성 적용
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                        str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        ]);
	    grid.setCellEditable(false);  	//true 이면 그리드에서 더블클릭 수정 가능 
	    grid.setCellEditable(true, 6);	//수정할 그리드 컬럼의 순서번호를 입력하면 등록한 컬럼이 수정 가능
	    
	    var tempRegId = "";
	    
	   	grid.onCellEditStarted = function(event, col, row) {	//최대자릿수 지정
		   if(col == 6){
			   if(grid.getCellText(_col.keymanTypeCD, row) == "10"){	// 주민번호, 사업자번호일때 자릿수 조건
				   $("#grid-cell-"+_col.regIDNo+"-"+row+"-box-edit").attr("maxlength", 13);	// 주민번호 최대 입력자리
				   $("#grid-cell-"+_col.regIDNo+"-"+row+"-box-edit").numeric();
			   } else if(grid.getCellText(_col.keymanTypeCD, row) == "20"){
				   $("#grid-cell-"+_col.regIDNo+"-"+row+"-box-edit").attr("maxlength", 10);	// 사업자번호  최대 입력자리
				   $("#grid-cell-"+_col.regIDNo+"-"+row+"-box-edit").numeric();
			   }
			   grid.setCellText(unformat($("#grid-cell-"+_col.regIDNo+"-"+row+"-box-edit").val()), _col.regIDNo, row);	// 하이픈(-) 선택시 사라지고 비선택시 생성
		   }
	    }; 
	    
	    var newText = "";
	    var regText = "";
	    var yearFront = "";
	    
	    grid.onCellValidating = function(text, col, row){	// 그리드에  주민번호를 입력할 때 생년월일을 같이 변경
		    var nineteenOrTwenty = unformat($("#grid-cell-"+_col.regIDNo+"-"+row+"-box-edit").val()).substring(6,7);
		    var birthDate = unformat($("#grid-cell-"+_col.regIDNo+"-"+row+"-box-edit").val()).substring(0,6);
		    
	        if(col == 6){
	        	var textLength = text.length;
	        	
	        	if(grid.getCellText(_col.keymanTypeCD, row) == "10"){
        			if(textLength == 10){
           				alert("주민번호/사업자등록번호를 확인하세요");
           				return true;
        			}
        		}
	        	if(textLength != 10 && textLength != 13){
	           		alert("주민번호/사업자등록번호를 확인하세요");
			   		//grid.setCellFocus(col,row);
	            	return true; 
	           	} else {
	     	    	if(text.length == 13){
	     	    		if(nineteenOrTwenty=="1" || nineteenOrTwenty=="2" 
	     					|| nineteenOrTwenty=="5" || nineteenOrTwenty=="6") { //외국인 경우 추가 2014.10.02
	     					yearFront = "19";
	     				}
	     				else if(nineteenOrTwenty=="3" || nineteenOrTwenty=="4"
	     					|| nineteenOrTwenty=="7" || nineteenOrTwenty=="8") { //외국인 경우 추가 2014.10.02
	     					yearFront = "20"; 
	     				}
	     				else if(nineteenOrTwenty=="0"){
	     					yearFront = "";
	     				}
	     				else if(nineteenOrTwenty=="9"){
	     					yearFront = "";
	     				}
	     	    		birthDate = yearFront+unformat($("#grid-cell-"+_col.regIDNo+"-"+row+"-box-edit").val()).substring(0,6);
	     	    		
	     	    		//만나이 구하기
		     	   		var bday=parseInt(birthDate.substring(6,8)); 
		     	   		var bmo=(parseInt(birthDate.substring(4,6))-1); 
		     	   		var byr=parseInt(birthDate.substring(0,4)); 
		     	   		var byr;
		     	   		var age;
		     	   		var now = new Date();
		     	   		tday=now.getDate();
		     	   		tmo=(now.getMonth());
		     	   		tyr=(now.getFullYear());
		     	   		
		     	   		if((tmo > bmo)||(tmo==bmo & tday>=bday)) { 
		     	   			age=byr;
		     	   		}
		     	   		else {
		     	   			age=byr+1;
		     	   		}
		     	   		
		     	   		var manAge = 0;
		     	   		manAge = tyr-age;
		     	   		
	     	    		if(grid.getCellText(_col.keymanTypeCD, row) == "10") {
		     	   			if(manAge < 20) {
		     	   				alert("[경고] 만 20세 미만의 미성년자 입니다.\n만 20세 미만의 고객은 등록이 불가능 합니다.");
		     	   				return true;
		     	   			} 
    	   				}    
	     	    		  
						newText =  formatIDNo(text);
						grid.setCellText(formatDate(yearFront+newText.substring(0,6)),_col.birthDate, row);
						
					} else if (text.length == 10){
						newText =  formatBizRegNo(text);
					}
				  	grid.setCellText(newText, col, row);
	            }
	        }
	    }
	    
		grid.setCellTemplate(new AW.Templates.Combo, _col.activeYNName);
		grid.setPopupTemplate(function(col, row) {	
			if (col == _col.activeYNName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","ACTIVEYN");
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
			            grid.setCellText(value[i], _col.activeYN, row);
	            	}
	            	catch(e){}
	            };
			}
			
            return list;
        });
    }
	
</script>