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
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>				                            	
												<td class="td-cond-required">
													<fmt:message key="ANL01001A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                            	<td class="td-cond">
													<fmt:message key="ANL01001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL01001A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="CVR02001A.apprStateCD" />
												</td>
												<td class="td-input">													
													<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="all" category="APPRSTATECD" />
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
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 20px; text-align:left;}
	.aw-column-1 {width: 150px; text-align:left;}
    .aw-column-2 {width: 150px; text-align:left;}
    .aw-column-3 {width: 150px; text-align:center;}
    .aw-column-4 {width: 150px; text-align:right;}
    .aw-column-5 {width: 150px; text-align:right;}
    .aw-column-6 {width: 150px; text-align:left;}
    .aw-column-7 {width: 100px; text-align:center;}

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
			
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));	
			
    		$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
    		
    		$("#apprStateCD_S").val("20");
		};

		${initScript}

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

	/****************************************
	* Button Action
	****************************************/		
	var _i = 0;
	var _col = {
		  checkbox     : _i++
		, rageSphereNM : _i++
		, officeNM     : _i++
		, kindTpNM     : _i++
		, NGGSVN       : _i++
		, NGGSVC       : _i++
		, BJ           : _i++
		, apprStateNM  : _i++	
		, rageSphereCD : _i++
		, officeCD     : _i++
		, apprStateCD  : _i++
		, kindTpCD  : _i++
    };	
	
	function Search() {		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CVR0200102S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","checkbox;rageSphereNM;officeNM;kindTpNM;NGGSVN;NGGSVC;BJ;apprStateNM;rageSphereCD;officeCD;apprStateCD;kindTpCD;");
	  	table.setParameter("format","str;str;str;str;num2;num2;str;str;str;str;str;str;");
	  	table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S"    , "${params.officeCD}");
	  	table.setParameter("teamCD_S"      , "${params.teamCD}");
	  	table.setParameter("territoryCD"   , "${params.territoryCD}");	  	
	  	table.setParameter("eventYM"       , $("#yearCD_S").val()+$("#monthCD_S").val()); 
	  	table.setParameter("rageSphereCD"  , $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD"      , $("#officeCD_S").val());
	  	table.setParameter("apprStateCD_S"      , $("#apprStateCD_S").val());

	  	table.request();

      	createGrid();
      	
		var rowCount = table.getCount();
		if (rowCount > 0) {
			var data = new Array();
			for (var i=0; i<rowCount; i++) {
				data[i] = [
				           		""
								, formatMonth(  table.getData(_col.rageSphereNM,i))
								, table.getData(_col.officeNM,i)
								, table.getData(_col.kindTpNM,i)
								, table.getData(_col.NGGSVN,i)
								, table.getData(_col.NGGSVC,i)
								, table.getData(_col.BJ,i)
								, table.getData(_col.apprStateNM,i)   	
								, table.getData(_col.rageSphereCD,i)
								, table.getData(_col.officeCD,i)
								, table.getData(_col.apprStateCD,i)
								, table.getData(_col.kindTpCD,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);			
		}
		else {
			message("<fmt:message key="info.nullData"/>");	
      	}
      	grid.refresh();
      	
      	maxRow = rowCount;
	}
	
	//승인
	function Approval() {
		var rageSphereCDs = new Array();
		var officeCDs = new Array();
		var kindTpCDs = new Array();
		
		var count = 0;
		var chkCnt = 0;
		
		for (var i=0; i<maxRow; i++) {
			if(grid.getCellValue(_col.checkbox, i)) {
				chkCnt++;
			}
		}
		
		if (chkCnt == 0){
			alert("<fmt:message key="CVR02001A.msg02"/>");
			return;
		}
		
		if (!confirm("<fmt:message key="CVR02001A.msg06"/>")) return;
		
		for (var i=0; i<maxRow; i++) {
			if(grid.getCellValue(_col.checkbox, i)) {
				if(grid.getCellText(_col.apprStateCD, i) == "20"){
					rageSphereCDs[count] = grid.getCellText(_col.rageSphereCD, i);
					officeCDs[count] = grid.getCellText(_col.officeCD, i);
					kindTpCDs[count] = grid.getCellText(_col.kindTpCD, i);
					
					count++;
				}else{
					alert("<fmt:message key="CVR02001A.msg08"/>");
					return;
				}
			}
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/cvr02/saveApproval");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYm", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("rageSphereCDs", rageSphereCDs);
	  	table.setParameter("officeCDs", officeCDs);
	  	table.setParameter("kindTpCDs", kindTpCDs);
	  	table.setParameter("chgID", "${params.userID}");
	  	table.request();
     	
     	if(table.getCount() > 0) {
     		if(table.getData(0,0) == "S") {
    			message(table.getData(1,0));
    			Search();
       		}
    		else {
    			alert(table.getData(1,0));
    		}
     	}
	}
	
	//반려
	function Reject() {
		var rageSphereCDs = new Array();
		var officeCDs = new Array();
		var kindTpCDs = new Array();
		
		var count = 0;
		var chkCnt = 0;
		
		for (var i=0; i<maxRow; i++) {
			if(grid.getCellValue(_col.checkbox, i)) {
				chkCnt++;
			}
		}
		
		if (chkCnt == 0){
			alert("<fmt:message key="CVR02001A.msg02"/>");
			return;
		}
		
		if (!confirm("<fmt:message key="CVR02001A.msg07"/>")) return;
		
		for (var i=0; i<maxRow; i++) {
			if(grid.getCellValue(_col.checkbox, i)) {
				if(grid.getCellText(_col.apprStateCD, i) == "20"){
					rageSphereCDs[count] = grid.getCellText(_col.rageSphereCD, i);
					officeCDs[count] = grid.getCellText(_col.officeCD, i);
					kindTpCDs[count] = grid.getCellText(_col.kindTpCD, i);
					
					count++;
				}else{
					alert("<fmt:message key="CVR02001A.msg08"/>");
					return;
				}
			}
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/cvr02/saveApprReject");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYm", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("rageSphereCDs", rageSphereCDs);
	  	table.setParameter("officeCDs", officeCDs);
	  	table.setParameter("kindTpCDs", kindTpCDs);
	  	table.setParameter("chgID", "${params.userID}");
	  	table.request();
     	
     	if(table.getCount() > 0) {
     		if(table.getData(0,0) == "S") {
    			message(table.getData(1,0));
    			Search();
       		}
    		else {
    			alert(table.getData(1,0));
    		}
     	}
	}
	
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
	    ""
		, "<fmt:message key="CVR02001A.rageSphereCD"/>"
		, "<fmt:message key="CVR02001A.officeCD"/>"		
		, "<fmt:message key="CVR02001A.kindTpCD"/>"
		, "<fmt:message key="CVR02001A.NGGSVN"/>"
		, "<fmt:message key="CVR02001A.NGGSVC"/>"
		, "<fmt:message key="CVR02001A.BJ"/>"
		, "<fmt:message key="CVR02001A.apprStateCD"/>"		
	];
	
	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(true);
		grid.setSelectorWidth(40);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
	    grid.setSelectionMode("single-cell");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([str, str,str, str, num2,  num2, str , str, str , str, str , str, str ]);
	    grid.setCellEditable(false);	    
	    
	    grid.setHeaderTemplate(new AW.Templates.CheckBox, _col.checkbox);
	    grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
	    grid.setCellValue(false, _col.checkbox);
	    
	    grid.setFixedLeft(2);
	    
	 // Cell startEdit BEGIN
        grid.onCellSelectedChanged = function(selected, col, row) {
        };
        
		grid.onHeaderClicked=function(event,col){
			if (col != _col.checkbox) return true;
			
			if (col == _col.checkbox && this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(true, _col.checkbox);
			}
			else if (col == _col.checkbox && !this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(false, _col.checkbox);
			}
			return false;
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
		grid.onCellEditStarted = function(text, col, row){
			if ( col == _col.NGGSVC) {
				this.setCellText(unformatNum(text), col, row);
			}
		};
	    
		grid.onCellValidating = function(text, col, row) {
			if(col == _col.NGGSVC) {				
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
				if(unformat(text).length > 4) {
	    			alert("<fmt:message key="info.validate.numlength"><fmt:param value='4'/></fmt:message>");
	    			this.setCellText("0",col,row);
					return;
				}
			}
	    };
	
    }	
	
</script>