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
						        			<col style="width:300px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="KEY02001A.requestDate" />
												</td>
												<td class="td-input">
													<nis:calendar id="requestDateFrom_S" cssClass="input-readonly" readOnly="yes" /> - 
													<nis:calendar id="requestDateTo_S" cssClass="input-readonly" readOnly="yes" />
												</td>
				                                <td class="td-cond">
													<fmt:message key="KEY02001A.apprStateCD" />
												</td>
												<td class="td-input">
													<select id="apprStateCD_S" name="apprStateCD_S" ></select>
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
						<input type="hidden" id="selectKeymanID" name="selectKeymanID" />
						<input type="hidden" id="selectRequestDate" name="selectRequestDate" />
						<input type="hidden" id="selectRequestSeq" name="selectRequestSeq" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0  {width: 35px;  text-align:center;}
	.aw-column-1  {width: 80px;  text-align:center;}
    .aw-column-2  {width: 60px;  text-align:center;}
    .aw-column-3  {width: 120px; }
    .aw-column-4  {width: 90px;  text-align:center;}
    .aw-column-5  {width: 100px; text-align:left;}
    .aw-column-6  {width: 80px;  text-align:center;}
    .aw-column-7  {width: 120px; text-align:center;}
    .aw-column-8  {width: 80px;  text-align:center;}
    .aw-column-9  {width: 100px; text-align:center;}
    .aw-column-10 {width: 150px; }
    .aw-column-11 {width: 100px; text-align:center;}
    .aw-column-12 {width: 80px;  text-align:center;}
    .aw-column-13 {width: 120px; text-align:center;}
    .aw-column-14 {width: 80px;  text-align:center;}
    .aw-column-15 {width: 80px;  text-align:center;}
    .aw-column-16 {width: 120px; }
    .aw-column-17 {width: 80px;  text-align:center;}
    .aw-column-18 {width: 80px;  text-align:center;}
    .aw-column-19 {width: 120px; }
    .aw-column-20 {width: 80px;  text-align:center;}
    .aw-column-21 {width: 100px; text-align:center;}
    .aw-column-22 {width: 80px;  text-align:center;}

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
			if("${params.eventym}"==""){
			    $("#requestDateFrom_S").val("${params.agoWeekDate}");
			}else{
				$("#requestDateFrom_S").val("${params.eventym}");
			}
			$("#requestDateTo_S").val("${params.currentDate}");
			
    		getApprStateCD();
    		$("#apprStateCD_S").val("20");
    		
    		if("${params.eventym}"!=""){
    			Search();
    		}
		};

		${initScript}
	});
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	
	function getApprStateCD() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "APPRSTATECD");
	  	table.setParameter("attrib02", "MNG");
     	table.request();
		
     	if(table.getCount() > 0) {
	     	$("#apprStateCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	     		$("#apprStateCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   		}
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
		, requestDate : _i++
		, requestTpCDName : _i++
		, venueNm : _i++
		, keymanID : _i++
		, keymanNm : _i++
		, keymanTypeCDName : _i++
		, regIDNo : _i++
		, birthDate : _i++
		, dutyCDName : _i++
		, addr : _i++
		, phoneNo : _i++
		, bankCDName : _i++
		, accountNo : _i++
		, holderNm : _i++
		, PkeymanYN : _i++
		, note : _i++
		, empId : _i++
		, empNm : _i++
		, apprCommt : _i++
		, apprStateCDName : _i++
		, licenceChkYn : _i++
		, requestStateCDName : _i++
		, apprStateCD : _i++
		, requestStateCD : _i++
		, lapprLevelNo : _i++
		, levelNo : _i++
		, lastApprYN : _i++
		, requestSeq : _i++		
		, venueCD : _i++
    };
	
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0200101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;requestDate;requestTpCDName;venueNm;keymanID;"+
	  			"keymanNm;keymanTypeCDName;regIDNo;birthDate;dutyCDName;"+
	  			"addr;phoneNo;bankCDName;accountNo;holderNm;"+
	  			"PkeymanYN;note;empId;empNm;apprCommt;"+
	  			"apprStateCDName;licenceChkYn;requestStateCDName;apprStateCD;requestStateCD;lapprLevelNo;"+
	  			"levelNo;lastApprYN;requestSeq;venueCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;");
	  	table.setParameter("requestDateFrom", convertDate($("#requestDateFrom_S").val()));
	  	table.setParameter("requestDateTo", convertDate($("#requestDateTo_S").val()));
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	
	  	// -- 그룹 권한에 따라 주민/사업자번호 가 보이지 않도록 수정 2016.10.11
	  	if('${params.grpID}' == '000006' || '${params.grpID}' == '000009' || '${params.grpID}' == '000010' ){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
	  	//--
	  	
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			var requestStateCDName = "";
//       			if(table.getData(_col.requestStateCD,i) == "10") {
//       				requestStateCDName = table.getData(_col.requestStateCDName,i);
//           		}
//           		else {
          			requestStateCDName = "<a href=\"javascript:openRequestState('"+i+"');\">"+table.getData(_col.requestStateCDName,i)+"</a>";
//           		}
      			
      			data[i] = [
					""
					, formatDate(table.getData(_col.requestDate,i))
					, table.getData(_col.requestTpCDName,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.keymanID,i)
      			    , table.getData(_col.keymanNm,i)
					, table.getData(_col.keymanTypeCDName,i)
					, formatIDNo(table.getData(_col.regIDNo,i), "")
					, formatDate(table.getData(_col.birthDate,i))
					, table.getData(_col.dutyCDName,i)
					, table.getData(_col.addr,i)
					, table.getData(_col.phoneNo,i)
					, table.getData(_col.bankCDName,i)
					, table.getData(_col.accountNo,i)
					, table.getData(_col.holderNm,i)
					, table.getData(_col.PkeymanYN,i)
					, table.getData(_col.note,i)
					, table.getData(_col.empId,i)
					, table.getData(_col.empNm,i)
					, table.getData(_col.apprCommt,i)
					, table.getData(_col.apprStateCDName,i)
					, table.getData(_col.licenceChkYn,i)
					, requestStateCDName
					, table.getData(_col.apprStateCD,i)
					, table.getData(_col.requestStateCD,i)
					, table.getData(_col.lapprLevelNo,i)
					, table.getData(_col.levelNo,i)
					, table.getData(_col.lastApprYN,i)
					, table.getData(_col.requestSeq,i)					
					, table.getData(_col.venueCD,i)					
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	
      	}
      	
      	grid.refresh();
	}
	
	function openRequestState(i) {
		var keymanID = grid.getCellText(_col.keymanID,i);
		var requestSeq = grid.getCellText(_col.requestSeq,i);
		var requestDate = grid.getCellText(_col.requestDate,i);
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=KEY01001D"
				+"&keymanID="+keymanID
				+"&requestSeq="+requestSeq
				+"&requestDate="+unformat(requestDate);
		newWindow(url, "KEY01001D",600,350,"yes");
	}
	
	function Approval() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var keymanIDs = new Array();
		var requestDates = new Array();
		var requestSeqs = new Array();
		var lastApprYNs = new Array();
		var levelNos = new Array();
		var apprCommts = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				keymanIDs[count] = grid.getCellText(_col.keymanID, index[i]);
				requestDates[count] = unformat(grid.getCellText(_col.requestDate, index[i]));
				requestSeqs[count] = grid.getCellText(_col.requestSeq, index[i]);
				lastApprYNs[count] = grid.getCellText(_col.lastApprYN, index[i]);
				levelNos[count] = grid.getCellText(_col.levelNo, index[i]);
				apprCommts[count] = grid.getCellText(_col.apprCommt, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//개별승인상태가 승인요청일 경우만 가능
				if(grid.getCellText(_col.apprStateCD, index[i]) != "20") {
					alert("<fmt:message key="KEY02001A.msg2"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="KEY02001A.msg3"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key02/approvalKeymanID");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("keymanIDs", keymanIDs);
		table.setParameter("requestDates", requestDates);
		table.setParameter("requestSeqs", requestSeqs);
		table.setParameter("lastApprYNs", lastApprYNs);
		table.setParameter("levelNos", levelNos);
		table.setParameter("apprCommts", apprCommts);
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
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var keymanIDs = new Array();
		var requestDates = new Array();
		var requestSeqs = new Array();
		var apprCommts = new Array();
		var requestTpCDNames = new Array();
		var venueNms = new Array();
		var venueCDs = new Array();
		var keymanNms = new Array();
		
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				keymanIDs[count] = grid.getCellText(_col.keymanID, index[i]);
				requestDates[count] = unformat(grid.getCellText(_col.requestDate, index[i]));
				requestSeqs[count] = grid.getCellText(_col.requestSeq, index[i]);
				apprCommts[count] = grid.getCellText(_col.apprCommt, index[i]);
				requestTpCDNames[count] = grid.getCellText(_col.requestTpCDName, index[i]);
				venueNms[count] = grid.getCellText(_col.venueNm, index[i]);
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				keymanNms[count] = grid.getCellText(_col.keymanNm, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//개별승인상태가 승인요청일 경우만 가능
				if(grid.getCellText(_col.apprStateCD, index[i]) != "20") {
					alert("<fmt:message key="KEY02001A.msg4"/>");
					return;
				}
				if(grid.getCellText(_col.apprCommt, index[i]) == "") {
					alert("<fmt:message key="KEY02001A.msg5"/>");
					setCellFocus(grid, _col.apprCommt, index[i]);
					return;
				}
			}
			
		}
		
		if(!confirm("<fmt:message key="KEY02001A.msg6"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key02/rejectKeymanID");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("keymanIDs", keymanIDs);
		table.setParameter("requestDates", requestDates);
		table.setParameter("requestSeqs", requestSeqs);
		table.setParameter("apprCommts", apprCommts);
		table.setParameter("requestTpCDNames", requestTpCDNames);
		table.setParameter("venueNms", venueNms);
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("keymanNms", keymanNms);
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
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
	    ""
		, "<fmt:message key="KEY02001A.requestDate"/>"
		, "<fmt:message key="KEY02001A.requestTpCD"/>"
		, "<fmt:message key="KEY02001A.venueNm"/>"
		, "<fmt:message key="KEY02001A.keymanID"/>"
		, "<fmt:message key="KEY02001A.keymanNm"/>"
		, "<fmt:message key="KEY02001A.keymanTpCD"/>"
		, "<fmt:message key="KEY02001A.regIDNo"/>"
		, "<fmt:message key="KEY02001A.birthDate"/>"
		, "<fmt:message key="KEY02001A.dutyCD"/>"
		, "<fmt:message key="KEY02001A.addr"/>"
		, "<fmt:message key="KEY02001A.phoneNo"/>"
		, "<fmt:message key="KEY02001A.bankCD"/>"
		, "<fmt:message key="KEY02001A.accountNo"/>"
		, "<fmt:message key="KEY02001A.holderNm"/>"
		, "<fmt:message key="KEY02001A.PKeymanYN"/>"
		, "<fmt:message key="KEY02001A.note"/>"
		, "<fmt:message key="KEY02001A.empId"/>"
		, "<fmt:message key="KEY02001A.empNm"/>"
		, "<fmt:message key="KEY02001A.apprCommt"/>"
		, "<fmt:message key="KEY02001A.apprStateCD"/>"
		, "<fmt:message key="KEY01002A.licenceChkYn"/>"
		, "<fmt:message key="KEY02001A.requestStateCD"/>"
		
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
	                          str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, html
	                        ]);
	    grid.setCellEditable(false);
	    grid.setCellEditable(true, _col.apprCommt);
// 	    grid.setFixedLeft(5);
	    
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
	    };
	
	    grid.onCellValidated = function(text, col, row) {
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
		
    }
	
</script>