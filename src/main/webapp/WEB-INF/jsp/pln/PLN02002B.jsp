<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<%@include file="../sys3/scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<form name="form" method="post">
	<div id="wrapDiv">
    	<div id="formDiv">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="padding-bottom:5px;">
                <tr>
                    <td height="1">
						<%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
                    </td>
                </tr>
                <tr>
                	<td class="tit_text01" td height="1">
						<fmt:message key="PLN02001B.thisMonth" />
					</td>
                </tr>
                <tr>
                    <td height="60%">
                        <span id="grid"></span>
                    </td>
                </tr>
                <tr>
                	<td class="tit_text01" td height="1">
						<fmt:message key="PLN02001B.nextMonth" />
					</td>
                </tr>
                <tr>
                    <td height="*">
                        <span id="gridBefore"></span>
                    </td>
                </tr>
                <tr>
					<td height="1">
						<input type="hidden" id="eventYMBefore" name="eventYMBefore"/>
						<input type="hidden" id="apprTpID" name="apprTpID" value="000000"/>
					</td>
				</tr>
		  </table>
       </div>
  	</div>
  	</form>
</body>
</html>

<style type="text/css">
<!--
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 100px; text-align:left;}
    .aw-column-1 {width: 100px; text-align:left;}
	.aw-column-2 {width: 300px; text-align:left;}
    .aw-column-3 {width: 80px; text-align:center;}
    .aw-column-4 {width: 150px; text-align:right;}
    .aw-column-5 {width: 100px; text-align:right;}
    .aw-column-6 {width: 100px; text-align:right;}
    .aw-column-7 {width: 100px; text-align:right;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">

	// Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	 * Variable
	 ****************************************/
	
	/****************************************
	* Function
	****************************************/
    $(function() {
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			//$("#grid_displayNum").val("100");
			createGrid();
			createGridBefore();
			grid.refresh();
			gridBefore.refresh();
			setMonthBefore();
			Search();
		};
		
		${initScript}
		
		$("#categoryCD1").change(function() {
			refresh_categoryCD2();
		});
	});

	/****************************************
	* Button Action
	****************************************/

	function setMonthBefore() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03002A02S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey",
	  			"lastMonthYear;lastMonthMon");
	  	table.setParameter("format",
	  			"str;str");
	  	table.setParameter("yearMonthTemp", "${params.eventYM}");
     	table.request();
		
     	if(table.getCount() > 0) {
     		var yearTemp = table.getData(0,0);
     		var monthTemp = table.getData(1,0);

     		$("#eventYMBefore").val(yearTemp+monthTemp);
		}
	}

	var _i = 0;
	var _col = {
		rageSphereCDName : _i++
		, officeCDName : _i++
		, type : _i++
		, apprStateCDName : _i++
		, tpayAmt : _i++
		, planTQty : _i++
		, avgUnitAmt : _i++
		, gsvRate : _i++
		, apprStateCD : _i++
		, monthSeq : _i++
    };
	
	function Search(){
		var table = new AW.XML.Table;
		if("${params.rltYN}" == "Y"){
			table.setURL("${contextPath}/service/simpleAction/RLT0200207S");
		}
		else{
	  		table.setURL("${contextPath}/service/simpleAction/PLN0200207S");
		}
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"rageSphereCDName;officeCDName;type;apprStateCDName;tpayAmt;planTQty;avgUnitAmt;gsvRate;apprStateCD;monthSeq;");
	  	table.setParameter("format",
	  			"str;str;str;str;num;num;num;num;str;str;");
	  	table.setParameter("eventYM","${params.eventYM}");
	  	table.setParameter("eventYMBefore", $("#eventYMBefore").val());
	  	table.setParameter("apprTpID", $("#apprTpID").val());
	  	table.setParameter("empID", "${params.empID}");
	 	// --- 그룹 권한에 따라 empId가 'MK'로 시작하는 담당자 이름은 보이지 않도록 수정 2016.04.20
		if(		   '${params.grpID}' == '000004' || '${params.grpID}' == '000003' || '${params.grpID}' == '000002' 
				|| '${params.grpID}' == '000026' || '${params.grpID}' == '000005'
				|| '${params.grpID}' == '000013' || '${params.grpID}' == '000016' || '${params.grpID}' == '000018'
				|| '${params.grpID}' == '000017' || '${params.grpID}' == '000023' || '${params.grpID}' == '000024'){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
      	//Paging Parameter - START
		//table.setParameter("pageNum", $("#grid_pageNum").val());
        //table.setParameter("displayNum", $("#grid_displayNum").val());
        //Paging Parameter - END
      	table.request();
      	
//       	if (grid != null) grid.clear();
      	createGrid();
      	createGridBefore();
      	var rowCount = table.getCount();
      	var rowCount2 = 0;
       	if (rowCount > 0) {
       		var data = new Array();
       		var data2 = new Array();
       		for (var i=0; i < rowCount; i++) {
       			if(table.getData(_col.monthSeq,i)=="1"){
	       			data[i] = [
						table.getData(_col.rageSphereCDName,i)
						, table.getData(_col.officeCDName,i)
	   					, table.getData(_col.type,i)
						, table.getData(_col.apprStateCDName,i)
						, table.getData(_col.tpayAmt,i)
						, table.getData(_col.planTQty,i)
						, table.getData(_col.avgUnitAmt,i)
	      			    , table.getData(_col.gsvRate,i)
						, table.getData(_col.apprStateCD,i)
	   	      			];
       			}
       			else{
       				data2[rowCount2] = [
  						table.getData(_col.rageSphereCDName,i)
  						, table.getData(_col.officeCDName,i)
  	   					, table.getData(_col.type,i)
  						, table.getData(_col.apprStateCDName,i)
  						, table.getData(_col.tpayAmt,i)
  						, table.getData(_col.planTQty,i)
  						, table.getData(_col.avgUnitAmt,i)
  	      			    , table.getData(_col.gsvRate,i)
  						, table.getData(_col.apprStateCD,i)
  	   	      			];
       				rowCount2++;
       			}
    		}
    		grid.setCellData(data);
    		grid.setRowCount(rowCount-rowCount2);
    		gridBefore.setCellData(data2);
    		gridBefore.setRowCount(rowCount2);
      		//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
      		//setPageInfo('grid', table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
      	} else {
      		////Paging Function: clearPageInfo(Grid Name);
            //clearPageInfo('grid');
      		message("<fmt:message key="info.nullData"/>");
      	
      	}
      	
      	grid.refresh();
      	gridBefore.refresh();
	}
	
	function Close() {
		window.close();
	}
	
    /*****************************************************
	*	Grid
	*****************************************************/
    
	var columns = [
				"<fmt:message key="PLN02001B.rageSphereCDName"/>"
				, "<fmt:message key="PLN02001B.officeCDName"/>"
	       		, "<fmt:message key="PLN02001B.type"/>"
	       		, "<fmt:message key="PLN02001B.apprStateCDName"/>"
	       		, "<fmt:message key="PLN02001B.tpayAmt"/>"
	       		, "<fmt:message key="PLN02001B.planTQty"/>"
	       		, "<fmt:message key="PLN02001B.avgUnitAmt"/>"
	       		, "<fmt:message key="PLN02001B.gsvRate"/>"
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
	                          str, str, str, str, num, num, num, num
	                        ]);
	    grid.setCellEditable(false);
	    //grid.setCellEditable(true, _col.payCommt);
	    grid.setFixedLeft(6);
	    grid.getCellTemplate(_col.tpayAmt).setStyle("color", "#ff0000");
	    grid.getCellTemplate(_col.periodPayAmt).setStyle("color", "#0000ff");
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
		
	    grid.onRowDoubleClicked = function(event, row){
		};
		//footer
    }

	var columnsBefore = [
  	       		 "<fmt:message key="PLN02001B.rageSphereCDName"/>"
  	       		, "<fmt:message key="PLN02001B.officeCDName"/>"
  	       		, "<fmt:message key="PLN02001B.type"/>"
  	       		, "<fmt:message key="PLN02001B.apprStateCDName"/>"
  	       		, "<fmt:message key="PLN02001B.tpayAmt"/>"
  	       		, "<fmt:message key="PLN02001B.planTQty"/>"
  	       		, "<fmt:message key="PLN02001B.avgUnitAmt"/>"
  	       		, "<fmt:message key="PLN02001B.gsvRate"/>"
  	];

  	var gridBefore = null;
  	function createGridBefore() {
  		gridBefore = new AW.Grid.Extended;
  		gridBefore.setId("gridBefore");
  		gridBefore.setRowCount(0);
  		gridBefore.setStyle("width","100%");
  		gridBefore.setStyle("height","100%");
  		gridBefore.setSelectorVisible(false);
  		gridBefore.setSelectionMode("single-cell");
  		gridBefore.setHeaderText(columnsBefore);
  	    for(var i=0;i<columnsBefore.length;i++){gridBefore.getHeaderTemplate(i).setStyle("text-align", "center");}
  	    gridBefore.setColumnCount(columnsBefore.length);
  	    gridBefore.setCellFormat([
  	                          str, str, str, str, num, num, num, num
  	                        ]);
  	    gridBefore.setCellEditable(false);
  	    //gridBefore.setCellEditable(true, _col.payCommt);
  	    gridBefore.setFixedLeft(6);
  	    gridBefore.getCellTemplate(_col.tpayAmt).setStyle("color", "#ff0000");
  	    gridBefore.getCellTemplate(_col.periodPayAmt).setStyle("color", "#0000ff");
          gridBefore.onCellSelectedChanged = function(selected, col, row) {
              if (selected) {
                  this.setTimeout(function(){
                     this.raiseEvent("editCurrentCell", {}, col, row);
                  });
              }
          };

          gridBefore.onCellClicked = function(event, col, row) {
              if (this.getCellSelected(col, row)) {
                  this.setTimeout(function(){
                     this.raiseEvent("editCurrentCell", {}, col, row);
                 });
              }
          };

  		gridBefore.onCellEditEnded = function(text, col, row) {
  			this.setCellText(text, col, row);
  			this.focus();
  		};
  		// Cell startEdit END
  		
  	    gridBefore.onRowDoubleClicked = function(event, row){
  		};
  		//footer
      }
	
</script>