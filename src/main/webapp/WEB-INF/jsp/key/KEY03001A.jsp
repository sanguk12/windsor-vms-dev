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
						        			<col style="width:350px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="KEY03001A.dateGb" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dateGb" name="dateGb" defaultText="none" category="DATEGB" />
													<nis:calendar id="requestDateFrom_S" cssClass="input-readonly" readOnly="yes" /> - 
													<nis:calendar id="requestDateTo_S" cssClass="input-readonly" readOnly="yes" />
												</td>
				                                <td class="td-cond">
													<fmt:message key="KEY03001A.requestStateCD" />
												</td>
												<td class="td-input">
													<select id="requestStateCD_S" name="requestStateCD_S" ></select>
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
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 35px; text-align:center;}
	.aw-column-1 {width: 80px; text-align:center;}
	.aw-column-2 {width: 80px; text-align:center;}
    .aw-column-3 {width: 60px; text-align:center;}
    .aw-column-4 {width: 100px; text-align:center;}
    .aw-column-5 {width: 100px; text-align:center;}
    .aw-column-6 {width: 120px; text-align:left;}
    .aw-column-7 {width: 80px; text-align:center;}
    .aw-column-8 {width: 100px; text-align:center;}
    .aw-column-9 {width: 60px; text-align:center;}
    .aw-column-10 {width: 120px; text-align:center;}
    .aw-column-11 {width: 80px; text-align:center;}
    .aw-column-12 {width: 80px; text-align:center;}
    .aw-column-13 {width: 120px; }
    .aw-column-14 {width: 120px; text-align:center;}
    .aw-column-15 {width: 60px; text-align:center;}
    .aw-column-16 {width: 60px; text-align:center;}
    .aw-column-17 {width: 120px; text-align:center;}
    .aw-column-18 {width: 100px; text-align:center;}
    .aw-column-19 {width: 80px; text-align:center;}
    .aw-column-20 {width: 120px; }
    .aw-column-21 {width: 120px; }
    .aw-column-22 {width: 80px; text-align:center;}

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
			
			$("#requestDateFrom_S").val("${params.agoWeekDate}");
			$("#requestDateTo_S").val("${params.currentDate}");
			
    		getRequestStateCD();
    		$("#requestStateCD_S").val("40");
		};

		${initScript}
	});
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	
	function getRequestStateCD() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "REQUESTSTATECD");
	  	table.setParameter("attrib03", "VELEX");
     	table.request();
		
     	if(table.getCount() > 0) {
	     	$("#requestStateCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	     		$("#requestStateCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
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
		, apprDate : _i++
		, requestDate : _i++
		, requestTpCDName : _i++
		, empNm : _i++
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
		, note : _i++
		, accreErrCommt : _i++
		, requestStateCDName : _i++
		, requestStateCD : _i++
		, requestTpCD : _i++
		, keymanTypeCD : _i++
		, requestSeq : _i++
		, dutyCD : _i++
		, emailAddr : _i++
    };
	
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0300101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;apprDate;requestDate;requestTpCDName;empNm;"+
	  			"venueCD;venueNm;keymanID;keymanNm;keymanTypeCDName;"+
	  			"regIDNo;birthDate;dutyCDName;addr;phoneNo;" +
	  			"bankCD;bankCDName;accountNo;holderNm;PkeymanYN;"+
	  			"note;accreErrCommt;requestStateCDName;requestStateCD;requestTpCD;" + 
	  			"keymanTypeCD;requestSeq;dutyCD;emailAddr;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("requestDateFrom", convertDate($("#requestDateFrom_S").val()));
	  	table.setParameter("requestDateTo", convertDate($("#requestDateTo_S").val()));
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("requestStateCD", $("#requestStateCD_S").val());
	  	table.setParameter("dateGb", $("#dateGb").val());
	  	
		 // -- 그룹 권한에 따라 주민/사업자번호 가 보이지 않도록 수정 2016.10.11
		if('${params.grpID}' == '000006' || '${params.grpID}' == '000009' || '${params.grpID}' == '000010' ){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
		// --
		
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			data[i] = [
					""
					, formatDate(table.getData(_col.apprDate,i))
					, formatDate(table.getData(_col.requestDate,i))
					, table.getData(_col.requestTpCDName,i)
					, table.getData(_col.empNm,i)
					, table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.keymanID,i)
      			    , table.getData(_col.keymanNm,i)
					, table.getData(_col.keymanTypeCDName,i)
					, formatIDNo(table.getData(_col.regIDNo,i))
					, formatDate(table.getData(_col.birthDate,i))
					, table.getData(_col.dutyCDName,i)
					, table.getData(_col.addr,i)
					, table.getData(_col.phoneNo,i)
					, table.getData(_col.bankCD,i)
					, table.getData(_col.bankCDName,i)
					, table.getData(_col.accountNo,i)
					, table.getData(_col.holderNm,i)
					, table.getData(_col.PkeymanYN,i)
					, table.getData(_col.note,i)
					, table.getData(_col.accreErrCommt,i)
					, table.getData(_col.requestStateCDName,i)
					, table.getData(_col.requestStateCD,i)
					, table.getData(_col.requestTpCD,i)
					, table.getData(_col.keymanTypeCD,i)
					, table.getData(_col.requestSeq,i)
					, table.getData(_col.dutyCD,i)
					, table.getData(_col.emailAddr,i)
      			];
      			
      			var keymanTypeCD = table.getData(_col.keymanTypeCD,i);
      			var regIDNo = table.getData(_col.regIDNo,i);
      			if(keymanTypeCD == "10") {
      				grid.setCellText(formatIDNo(regIDNo), _col.regIDNo, i);
      			} else {
      				grid.setCellText(formatBizRegNo(regIDNo), _col.regIDNo, i);
      			}
      			
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	
      	}
      	
      	grid.refresh();
    }
	
	function CompleteAccre() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var keymanIDs = new Array();
		var venueCDs = new Array();
		var keymanNms = new Array();
		var keymanTypeCDs = new Array();
		var regIDNos = new Array();
		var birthDates = new Array();
		var addrs = new Array();
		var phoneNos = new Array();
		var bankCDs = new Array();
		var accountNos = new Array();
		var holderNms = new Array();
		var dutyCDs = new Array();
		var emailAddrs= new Array();
		var notes = new Array();
		var PkeymanYNs = new Array();
		var requestTpCDs = new Array();
		var requestDates = new Array();
		var requestSeqs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				keymanIDs[count] = grid.getCellText(_col.keymanID, index[i]);
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				keymanNms[count] = grid.getCellText(_col.keymanNm, index[i]);
				keymanTypeCDs[count] = grid.getCellText(_col.keymanTypeCD, index[i]);
				regIDNos[count] = unformat(grid.getCellText(_col.regIDNo, index[i]));
				birthDates[count] = unformat(grid.getCellText(_col.birthDate, index[i]));
				addrs[count] = grid.getCellText(_col.addr, index[i]);
				phoneNos[count] = grid.getCellText(_col.phoneNo, index[i]);
				bankCDs[count] = grid.getCellText(_col.bankCD, index[i]);
				accountNos[count] = grid.getCellText(_col.accountNo, index[i]);
				holderNms[count] = grid.getCellText(_col.holderNm, index[i]);
				dutyCDs[count] = grid.getCellText(_col.dutyCD, index[i]);
				emailAddrs[count] = grid.getCellText(_col.emailAddr, index[i]);
				notes[count] = grid.getCellText(_col.note, index[i]);
				PkeymanYNs[count] = grid.getCellText(_col.PkeymanYN, index[i]);
				requestTpCDs[count] = grid.getCellText(_col.requestTpCD, index[i]);
				requestDates[count] = unformat(grid.getCellText(_col.requestDate, index[i]));
				requestSeqs[count] = grid.getCellText(_col.requestSeq, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//신청상태가 승인일 경우만 가능
				if(grid.getCellText(_col.requestStateCD, index[i]) != "40") {
					alert("<fmt:message key="KEY03001A.msg1"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="KEY03001A.msg2"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key03/completeAccreKeymanID");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("keymanIDs", keymanIDs);
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("keymanNms", keymanNms);
		table.setParameter("keymanTypeCDs", keymanTypeCDs);
		table.setParameter("regIDNos", regIDNos);
		table.setParameter("birthDates", birthDates);
		table.setParameter("addrs", addrs);
		table.setParameter("phoneNos", phoneNos);
		table.setParameter("bankCDs", bankCDs);
		table.setParameter("accountNos", accountNos);
		table.setParameter("holderNms", holderNms);
		table.setParameter("dutyCDs", dutyCDs);
		table.setParameter("emailAddrs", emailAddrs);
		table.setParameter("notes", notes);
		table.setParameter("PkeymanYNs", PkeymanYNs);
		table.setParameter("requestTpCDs", requestTpCDs);
		table.setParameter("requestDates", requestDates);
		table.setParameter("requestSeqs", requestSeqs);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function ErrorAccre() {
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
		var accreErrCommts = new Array();
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
				accreErrCommts[count] = grid.getCellText(_col.accreErrCommt, index[i]);
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
				//신청상태가 승인일 경우만 가능
				if(grid.getCellText(_col.requestStateCD, index[i]) != "40") {
					alert("<fmt:message key="KEY03001A.msg3"/>");
					return;
				}
				if(grid.getCellText(_col.accreErrCommt, index[i]) == "") {
					alert("<fmt:message key="KEY03001A.msg4"/>");
					setCellFocus(grid, _col.accreErrCommt, index[i]);
					return;
				}
			}
			
		}
		
		if(!confirm("<fmt:message key="KEY03001A.msg5"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key03/errorAccreKeymanID");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("keymanIDs", keymanIDs);
		table.setParameter("requestDates", requestDates);
		table.setParameter("requestSeqs", requestSeqs);
		table.setParameter("accreErrCommts", accreErrCommts);
		table.setParameter("requestTpCDNames", requestTpCDNames);
		table.setParameter("venueNms", venueNms);
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("keymanNms", keymanNms);
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
		table.setParameter("queryKey", "KEY0300101S");
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("requestDateFrom", convertDate($("#requestDateFrom_S").val()));
	  	table.setParameter("requestDateTo", convertDate($("#requestDateTo_S").val()));
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("requestStateCD", $("#requestStateCD_S").val());
	  	table.setParameter("dateGb", $("#dateGb").val());
	  	
		var headerText = [
				"<fmt:message key="KEY03001A.apprDate"/>"
				, "<fmt:message key="KEY03001A.requestDate"/>"
				, "<fmt:message key="KEY03001A.requestTpCD"/>"
				, "<fmt:message key="KEY03001A.empNm"/>"
				, "<fmt:message key="KEY03001A.venueCD"/>"
				, "<fmt:message key="KEY03001A.venueNm"/>"
				, "<fmt:message key="KEY03001A.keymanID"/>"
				, "<fmt:message key="KEY03001A.keymanNm"/>"
				, "<fmt:message key="KEY03001A.keymanTpCD"/>"
				, "<fmt:message key="KEY03001A.regIDNo"/>"
				, "<fmt:message key="KEY03001A.birthDate"/>"
				, "<fmt:message key="KEY03001A.dutyCD"/>"
				, "<fmt:message key="KEY03001A.addr"/>"
				, "<fmt:message key="KEY03001A.phoneNo"/>"
				, "<fmt:message key="KEY03001A.bankCD"/>"
				, "<fmt:message key="KEY03001A.bankCDName"/>"
				, "<fmt:message key="KEY03001A.accountNo"/>"
				, "<fmt:message key="KEY03001A.holderNm"/>"
				, "<fmt:message key="KEY03001A.PKeymanYN"/>"
				, "<fmt:message key="KEY03001A.note"/>"
				, "<fmt:message key="KEY03001A.accreErrCommt"/>"
				, "<fmt:message key="KEY03001A.requestStateCD"/>"
		];
		
		table.setParameter("templateFile", "KEY03001A");
		table.setParameter("headerText", headerText);
		
		// -- 그룹 권한에 따라 주민/사업자번호 가 보이지 않도록 수정 2016.10.11
		if('${params.grpID}' == '000006' || '${params.grpID}' == '000009' || '${params.grpID}' == '000010' ){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
		// --
		
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
		, "<fmt:message key="KEY03001A.apprDate"/>"
		, "<fmt:message key="KEY03001A.requestDate"/>"
		, "<fmt:message key="KEY03001A.requestTpCD"/>"
		, "<fmt:message key="KEY03001A.empNm"/>"
		, "<fmt:message key="KEY03001A.venueCD"/>"
		, "<fmt:message key="KEY03001A.venueNm"/>"
		, "<fmt:message key="KEY03001A.keymanID"/>"
		, "<fmt:message key="KEY03001A.keymanNm"/>"
		, "<fmt:message key="KEY03001A.keymanTpCD"/>"
		, "<fmt:message key="KEY03001A.regIDNo"/>"
		, "<fmt:message key="KEY03001A.birthDate"/>"
		, "<fmt:message key="KEY03001A.dutyCD"/>"
		, "<fmt:message key="KEY03001A.addr"/>"
		, "<fmt:message key="KEY03001A.phoneNo"/>"
		, "<fmt:message key="KEY03001A.bankCD"/>"
		, "<fmt:message key="KEY03001A.bankCDName"/>"
		, "<fmt:message key="KEY03001A.accountNo"/>"
		, "<fmt:message key="KEY03001A.holderNm"/>"
		, "<fmt:message key="KEY03001A.PKeymanYN"/>"
		, "<fmt:message key="KEY03001A.note"/>"
		, "<fmt:message key="KEY03001A.accreErrCommt"/>"
		, "<fmt:message key="KEY03001A.requestStateCD"/>"
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
	                        str, str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str
	                        , str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setCellEditable(true, _col.accreErrCommt);
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