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
					<td height="1" valign="top">
						<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
	                   		<tr>
	                   			<td height="1">
									<span id="grid"></span>
								</td>
							</tr>
							<tr>
								<td height="30" align="center">
									<img src="${contextPath}/images/ico/btn_add.gif" onclick="Add();" style="cursor:hand;" alt="<fmt:message key="button.Add" />">
									<img src="${contextPath}/images/ico/btn_remove.gif" onclick="Remove();" style="cursor:hand;" alt="<fmt:message key="button.Remove" />">
								</td>
							</tr>
							<tr>
								<td height="1">
									<span id="grid_reg"></span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="*">
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td>
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
						        			<col style="width:380px;"></col>
						        			<col style="width:180px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
				                            	<td></td>
												<td class="td-cond">
													<fmt:message key="MIL01001C.msg1" />
												</td>
												<td class="td-input" style="text-align:right; padding-right:5px;">
													<b><span id="payAmt_sum"></span></b>
													<input type="hidden" id="contractAmt" name="contractAmt" value="${params.contractAmt }" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td></td>
												<td class="td-cond">
													<fmt:message key="MIL01001C.msg2" />
												</td>
												<td class="td-input" style="text-align:right; padding-right:5px;">
													<b><span id="payAmt_diff"></span></b>
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
						<input type="hidden" id="payTpCD" name="payTpCD" value="ORG" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid .aw-column-0 {width: 35px; text-align:center;}
	#grid .aw-column-1 {width: 80px; text-align:center;}
    #grid .aw-column-2 {width: 100px; text-align:left;}
    #grid .aw-column-3 {width: 80px; text-align:center;}
    #grid .aw-column-4 {width: 100px; text-align:center;}
    #grid .aw-column-5 {width: 120px; text-align:center;}
    #grid .aw-column-6 {width: 90px; text-align:center;}
    
    #grid_reg .aw-column-0 {width: 35px; text-align:center;}
    #grid_reg .aw-column-1 {width: 80px; text-align:center;}
    #grid_reg .aw-column-2 {width: 100px; text-align:left;}
	#grid_reg .aw-column-3 {width: 80px; text-align:center;}
    #grid_reg .aw-column-4 {width: 100px; text-align:center;}
    #grid_reg .aw-column-5 {width: 120px; text-align:center;}
    #grid_reg .aw-column-6 {width: 120px; text-align:right;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	//Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>

	/****************************************
	 * Variable
	 ****************************************/
	var maxRow = 0;
	var maxRow_reg = 0;
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			grid.refresh();
			
			createGrid_reg();
			grid_reg.refresh();
			
			Search();
		};

		${initScript}
		
	});
	
	function calculatePayAmt_sum() {
		var payAmt = 0;
		for(var i=0; i<maxRow_reg; i++) {
			if(grid_reg.getCellText(_col_reg.activeFlg, i)!="D") {
				payAmt += parseFloat(unformat(grid_reg.getCellText(_col_reg.payAmt, i)));
			}
		}
		$("#payAmt_sum").text(formatNum(payAmt));
		
		var contractAmt = parseFloat(unformat($("#contractAmt").val()));
		var payAmt_sum = parseFloat(unformat($("#payAmt_sum").text()));
		var payAmt_diff = 0;
		payAmt_diff = contractAmt - payAmt_sum;
		$("#payAmt_diff").text(formatNum(payAmt_diff));
	}
	
</script>

<script type="text/javascript">
	
	//Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		checkbox : _i++
		, keymanID : _i++
		, keymanNm : _i++
		, birthDate : _i++
		, bankCDName : _i++
		, accountNo : _i++
		, pkeymanYN : _i++
		, holderNm : _i++
		, bankCD : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MIL0100104S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;keymanID;keymanNm;birthDate;bankCDName;"+
	  			"accountNo;pkeymanYN;holderNm;bankCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("mileageID", "${params.mileageID}");
	  	table.setParameter("venueCD", "${params.venueCD}");
	  	table.setParameter("payTpCD", $("#payTpCD").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
      			    , table.getData(_col.keymanID,i)
					, table.getData(_col.keymanNm,i)
					, formatDate(table.getData(_col.birthDate,i))
					, table.getData(_col.bankCDName,i)
					, table.getData(_col.accountNo,i)
					, table.getData(_col.pkeymanYN,i)
					, table.getData(_col.holderNm,i)
					, table.getData(_col.bankCD,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
      	
      	maxRow = rowCount;
		Search_reg();
	}
	
	var _i_reg = 0;
	var _col_reg = {
		checkbox : _i_reg++
		, keymanID : _i_reg++
		, keymanNm : _i_reg++
		, birthDate : _i_reg++
		, bankCDName : _i_reg++
		, accountNo : _i_reg++
		, payAmt : _i_reg++
		, pkeymanYN : _i_reg++
		, holderNm : _i_reg++
		, bankCD : _i_reg++
		, activeFlg : _i_reg++
    };
	function Search_reg() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MIL0100105S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;keymanID;keymanNm;birthDate;bankCDName;"+
	  			"accountNo;payAmt;pkeymanYN;holderNm;bankCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;num;str;str;str;");
	  	table.setParameter("mileageID", "${params.mileageID}");
	  	table.setParameter("venueCD", "${params.venueCD}");
	  	table.setParameter("payTpCD", $("#payTpCD").val());
	  	table.request();
      	
// 	  	if (grid_reg != null) grid_reg.clear();
      	createGrid_reg();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
      			    , table.getData(_col_reg.keymanID,i)
					, table.getData(_col_reg.keymanNm,i)
					, formatDate(table.getData(_col_reg.birthDate,i))
					, table.getData(_col_reg.bankCDName,i)
					, table.getData(_col_reg.accountNo,i)
					, table.getData(_col_reg.payAmt,i)
					, table.getData(_col_reg.pkeymanYN,i)
					, table.getData(_col_reg.holderNm,i)
					, table.getData(_col_reg.bankCD,i)
					, "U"
      			];
      		}
      		grid_reg.setCellData(data);
      		grid_reg.setRowCount(rowCount);
      	}
      	grid_reg.refresh();
      	
      	maxRow_reg = rowCount;
      	calculatePayAmt_sum();
	}
	
	function Add() {
		if(opener.$("#resultWriteYN").val() == "N") {
			alert("<fmt:message key="MIL01001C.msg3" />");
			return;
		}
		
		var index = grid.getRowIndices();
		if (index == "") {
			index = new Array();
			for (var i = 0; i < maxRow; i++) {
				index[i] = i;
			}
		}
		
		//마일리지정보의 상태가 등록, 지급반려, 보류가 아닌경우에는 추가 불가(10:등록, 40:지급반려, 50:지급보류)
		var mileageStateCD = opener.$("#mileageStateCD").val();
		if(mileageStateCD!="10" && mileageStateCD!="40" && mileageStateCD!="50") {
			alert("<fmt:message key="MIL01001C.msg4" />");
			return;
		}
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				grid_reg.addRow(maxRow_reg++);
				grid_reg.setCellText(grid.getCellText(_col.keymanID, index[i]), _col_reg.keymanID, maxRow_reg-1);
				grid_reg.setCellText(grid.getCellText(_col.keymanNm, index[i]), _col_reg.keymanNm, maxRow_reg-1);
				grid_reg.setCellText(grid.getCellText(_col.birthDate, index[i]), _col_reg.birthDate, maxRow_reg-1);
				grid_reg.setCellText(grid.getCellText(_col.bankCDName, index[i]), _col_reg.bankCDName, maxRow_reg-1);
				grid_reg.setCellText(grid.getCellText(_col.accountNo, index[i]), _col_reg.accountNo, maxRow_reg-1);
				grid_reg.setCellText(grid.getCellText(_col.pkeymanYN, index[i]), _col_reg.pkeymanYN, maxRow_reg-1);
				grid_reg.setCellText(grid.getCellText(_col.holderNm, index[i]), _col_reg.holderNm, maxRow_reg-1);
				grid_reg.setCellText(grid.getCellText(_col.bankCD, index[i]), _col_reg.bankCD, maxRow_reg-1);
				grid_reg.setCellText("0", _col_reg.payAmt, maxRow_reg-1);
				grid_reg.setCellText("I", _col_reg.activeFlg, maxRow_reg-1);
			}
		}
		
		for(var i=index.length-1; i >= 0; i--) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				grid.deleteRow(index[i]);
			}
		}
	}

	function Remove() {
		if(opener.$("#resultWriteYN").val() == "N") {
			alert("<fmt:message key="MIL01001C.msg3" />");
			return;
		}
		
		var index_reg = grid_reg.getRowIndices();
		if (index_reg == ""){
			index_reg = new Array();
			for (var i = 0; i < maxRow_reg; i++){
				index_reg[i] = i;
			}
		}
		
		//마일리지정보의 상태가 등록, 지급반려, 보류가 아닌경우에는 삭제 불가(10:등록, 40:지급반려, 50:지급보류)
		var mileageStateCD = opener.$("#mileageStateCD").val();
		if(mileageStateCD!="10" && mileageStateCD!="40" && mileageStateCD!="50") {
			alert("<fmt:message key="MIL01001C.msg4" />");
			return;
		}
		
		for(var i=0; i<index_reg.length; i++) {
			if (grid_reg.getCellValue(_col_reg.checkbox, index_reg[i])) {
				
				//remove시 키맨정보 다시 조회
				var table = new AW.XML.Table;
			  	table.setURL("${contextPath}/service/simpleAction/COM03012S");
			  	table.setAsync(false);
			  	table.setRequestMethod("POST");
			  	table.setParameter("outParamKey",
			  			"bankCDName;accountNo;pkeymanYN;holderNm;bankCD;");
			  	table.setParameter("format",
			  			"str;str;str;str;str;");
			  	table.setParameter("keymanID", grid_reg.getCellText(_col_reg.keymanID, index_reg[i]));
			  	table.request();
				
				grid.addRow(maxRow++);
				grid.setCellText(grid_reg.getCellText(_col_reg.keymanID, index_reg[i]), _col.keymanID, maxRow-1);
				grid.setCellText(grid_reg.getCellText(_col_reg.keymanNm, index_reg[i]), _col.keymanNm, maxRow-1);
				grid.setCellText(grid_reg.getCellText(_col_reg.birthDate, index_reg[i]), _col.birthDate, maxRow-1);
				
				if(table.getCount() > 0) {
					grid.setCellText(table.getData(0,0), _col.bankCDName, maxRow-1);
					grid.setCellText(table.getData(1,0), _col.accountNo, maxRow-1);
					grid.setCellText(table.getData(2,0), _col.pkeymanYN, maxRow-1);
					grid.setCellText(table.getData(3,0), _col.holderNm, maxRow-1);
					grid.setCellText(table.getData(4,0), _col.bankCD, maxRow-1);
				}
				else {
					grid.setCellText(grid_reg.getCellText(_col_reg.bankCDName, index_reg[i]), _col.bankCDName, maxRow-1);
					grid.setCellText(grid_reg.getCellText(_col_reg.accountNo, index_reg[i]), _col.accountNo, maxRow-1);
					grid.setCellText(grid_reg.getCellText(_col_reg.pkeymanYN, index_reg[i]), _col.pkeymanYN, maxRow-1);
					grid.setCellText(grid_reg.getCellText(_col_reg.holderNm, index_reg[i]), _col.holderNm, maxRow-1);
					grid.setCellText(grid_reg.getCellText(_col_reg.bankCD, index_reg[i]), _col.bankCD, maxRow-1);
				}
			}
		}
		
		for(var i=index_reg.length-1; i >= 0; i--) {
			if (grid_reg.getCellValue(_col_reg.checkbox, index_reg[i])) {
				grid_reg.setCellText("D", _col_reg.activeFlg, index_reg[i]);
				grid_reg.deleteRow(index_reg[i]);
			}
		}
		
		calculatePayAmt_sum();
	}

	
	function Save() {
		//마일리지정보의 상태가 등록, 지급반려, 보류가 아닌경우에는 저장 불가(10:등록, 40:지급반려, 50:지급보류)
		var mileageStateCD = opener.$("#mileageStateCD").val();
		if(mileageStateCD!="10" && mileageStateCD!="40" && mileageStateCD!="50") {
			alert("<fmt:message key="MIL01001C.msg4" />");
			return;
		}
		if(maxRow_reg == 0) {
			alert("<fmt:message key="info.validate.gridSelect"/>");
			return;
		}
		
		var keymanIDs = new Array();
		var bankCDs = new Array();
		var accountNos = new Array();
		var payAmts = new Array();
		var holderNms = new Array();
		var activeFlgs = new Array();
		var count = 0;
		for (var i=0; i<maxRow_reg; i++) {
			keymanIDs[count] = grid_reg.getCellText(_col_reg.keymanID, i);
			bankCDs[count] = grid_reg.getCellText(_col_reg.bankCD, i);
			accountNos[count] = grid_reg.getCellText(_col_reg.accountNo, i);
			payAmts[count] = grid_reg.getCellText(_col_reg.payAmt, i);
			holderNms[count] = grid_reg.getCellText(_col_reg.holderNm, i);
			activeFlgs[count] = grid_reg.getCellText(_col_reg.activeFlg, i);
			count++;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mil01/saveMileageKeyman");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("mileageID", "${params.mileageID}");
		table.setParameter("payTpCD", $("#payTpCD").val());
		table.setParameter("keymanIDs", keymanIDs);
		table.setParameter("bankCDs", bankCDs);
		table.setParameter("accountNos", accountNos);
		table.setParameter("payAmts", payAmts);
		table.setParameter("holderNms", holderNms);
		table.setParameter("activeFlgs", activeFlgs);
		table.request();

		if(table.getData(0,0) == "S") {
			//top.appCountFun();
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Close() {
		opener.CloseKeymanPopup();
		window.close();
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		""
		, "<fmt:message key="MIL01001C.keymanID"/>"
		, "<fmt:message key="MIL01001C.keymanNm"/>"
		, "<fmt:message key="MIL01001C.birthDate"/>"
		, "<fmt:message key="MIL01001C.bankCDName"/>"
		, "<fmt:message key="MIL01001C.accountNo"/>"
		, "<fmt:message key="MIL01001C.pkeymanYN"/>"
	];
	
	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","180");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                        str, str, str, str, str
	                        , str, str]);
	    grid.setCellEditable(false);
	    
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
		
    }
	
	var columns_reg = [
		""
		, "<fmt:message key="MIL01001C.keymanID"/>"
		, "<fmt:message key="MIL01001C.keymanNm"/>"
		, "<fmt:message key="MIL01001C.birthDate"/>"
		, "<fmt:message key="MIL01001C.bankCDName"/>"
		, "<fmt:message key="MIL01001C.accountNo"/>"
		, "<fmt:message key="MIL01001C.payAmt"/>"
	];
	var grid_reg = null;
	function createGrid_reg() {
		grid_reg = new AW.UI.Grid;
	    grid_reg.setId("grid_reg");
	    grid_reg.setRowCount(0);
	    grid_reg.setStyle("width","100%");
	    grid_reg.setStyle("height","180");
	    grid_reg.setSelectorVisible(false);
	    grid_reg.setSelectionMode("single-cell");
	    grid_reg.setHeaderText(columns_reg);
	    for(var i=0;i<columns_reg.length;i++){grid_reg.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_reg.setColumnCount(columns_reg.length);
	    grid_reg.setCellFormat([
	                        str, str, str, str, str
	                        , str, num]);
	    grid_reg.setCellEditable(false);
	    grid_reg.setCellEditable(true, _col_reg.payAmt);
	    
	    grid_reg.setCellTemplate(new AW.Templates.CheckBox, _col_reg.checkbox);
		grid_reg.setCellValue(false, _col_reg.checkbox);
		
		grid_reg.setHeaderTemplate(new AW.Templates.CheckBox, _col_reg.checkbox);
		grid_reg.setCellTemplate(new AW.Templates.CheckBox, _col_reg.checkbox);
		grid_reg.onHeaderClicked=function(event,col){
			if (col == _col_reg.checkbox && this.getHeaderValue(_col_reg.checkbox,0)) {
				this.setCellValue(true, _col_reg.checkbox);
			}
			else if (col == _col_reg.checkbox && !this.getHeaderValue(_col_reg.checkbox,0)) {
				this.setCellValue(false, _col_reg.checkbox);
			}
			return false;
		};
		
     	// Cell startEdit BEGIN
        grid_reg.onCellSelectedChanged = function(selected, col, row) {
            if (selected) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
                });
            }
        };

        grid_reg.onCellClicked = function(event, col, row) {
            if (this.getCellSelected(col, row)) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
               });
            }
        };

		grid_reg.onCellEditEnded = function(text, col, row) {
			this.setCellText(text, col, row);
			this.focus();
		};
		// Cell startEdit END
		
		//  BEGIN validating (Enter, Cell LoseFocus)
		grid_reg.onCellEditStarted = function(text, col, row){
			if (col == _col_reg.payAmt) {
				this.setCellText(unformatNum(text), col, row);
			}
		};
		
		grid_reg.onCellValidating = function(text, col, row) {
			if (col == _col_reg.payAmt) {
				if(unformat(text).length > 13) {
	    			alert("<fmt:message key="info.validate.numlength"><fmt:param value='13'/></fmt:message>");
					this.setCellText(unformat(text).substring(0,13),col,row);
					return;
				}
				if (!isDecimal(unformat(text))) {
				    alert("<fmt:message key="error.noNum" />");
				    this.setCellText("0",col,row);
				    return;
				}
	    		else if (parseFloat(unformat(text)) < 0) {
					alert("<fmt:message key="error.noMinusNum" />");
					this.setCellText("0",col,row);
					return;
				}
			}
	    };
	
	    grid_reg.onCellValidated = function(text, col, row) {
	    	if (col == _col_reg.payAmt) {
	    		this.setCellText(formatNum(unformat(text)), col, row);
	    		calculatePayAmt_sum();
	    	}
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
    }

</script>