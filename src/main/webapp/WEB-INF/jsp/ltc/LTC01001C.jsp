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
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            	<tr>
                    <td height="1">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
					</td>
				</tr>
				<tr>
					<td height="1">
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
						        			<col style="width:150px;"></col>
						        			<col style="width:150px;"></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond">
													<fmt:message key="LTC01001C.venue" />
												</td>
												<td class="td-cond">
													<fmt:message key="LTC01001C.minContractQty" />
												</td>
				                            </tr>
				                            <tr>
				                            	<td class="td-input-rborder">
													<b><span id="venueNm"></span></b></br>
												</td>
				                            	<td class="td-input-rborder">
													<b><span id="minContractQty"></span></b></br>
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
						<input type="hidden" id="venueCD" name="venueCD" />
						<input type="hidden" id="eventYM_1" name="eventYM_1" />
						<input type="hidden" id="eventYM_2" name="eventYM_2" />
						<input type="hidden" id="eventYM_3" name="eventYM_3" />
						<input type="hidden" id="state_1" name="state_1" />
						<input type="hidden" id="state_2" name="state_2" />
						<input type="hidden" id="state_3" name="state_3" />
					</td>
				</tr>
               <tr>
               		<td height="*" valign="top">
               			<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" >
               				<tr>
								<td width="22%">
								<b><span id="eventYMNm_1"></span></b></br>
									<span id="grid_1"></span>
								</td>
								<td width="22%">
								<b><span id="eventYMNm_2"></span></b></br>
									<span id="grid_2"></span>
								</td>
								<td width="22%">
								<b><span id="eventYMNm_3"></span></b></br>
									<span id="grid_3"></span>
								</td>
								<td width="17%">
								<b><fmt:message key="LTC01001C.tcontractQty" /></b></br>
									<span id="grid_total"></span>
								</td>
								<td width="17%">
								<b><fmt:message key="LTC01001C.progress" /></b></br>
									<span id="grid_progress"></span>
								</td>
							</tr>
						</table>
               		</td>
               </tr>
			</table>
			</div>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 100px; text-align:left;}
    .aw-column-1 {width: 60px; text-align:right;}
    .aw-column-2 {width: 60px; text-align:right;}

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
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			createGrid_total();
			createGrid_progress();
			grid_1.refresh();
			grid_2.refresh();
			grid_3.refresh();
			grid_total.refresh();
			grid_progress.refresh();
			
			Search();
		};

		${initScript}

	});
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function Search() {
		Search_dtl();
		Search_prd();
		Search_total();
		Search_progress();
	}
	
	var _i_dtl = 0;
	var _col_dtl = {
		 venueNm : _i_dtl++
		, minContractQty : _i_dtl++
		, eventYM : _i_dtl++
		, venueCD : _i_dtl++
		, state : _i_dtl++
    };
	function Search_dtl() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0100104S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"venueNm;minContractQty;eventYM;venueCD;apprStateCD;");
	  	table.setParameter("format",
	  			"str;num;str;str;str;");
	  	table.setParameter("supportID", "${param.supportID}");
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#venueNm").text(table.getData(_col_dtl.venueNm, 0));
      		$("#minContractQty").text(table.getData(_col_dtl.minContractQty, 0));
      		$("#venueCD").val(table.getData(_col_dtl.venueCD, 0));
      		var eventYM_1 = table.getData(_col_dtl.eventYM, 0);
      		var eventYM_2 = table.getData(_col_dtl.eventYM, 1);
      		var eventYM_3 = table.getData(_col_dtl.eventYM, 2);
      		$("#eventYMNm_1").text(eventYM_1.substring(0,4)+"년 "+eventYM_1.substring(4,6)+"월");
      		$("#eventYMNm_2").text(eventYM_2.substring(0,4)+"년 "+eventYM_2.substring(4,6)+"월");
      		$("#eventYMNm_3").text(eventYM_3.substring(0,4)+"년 "+eventYM_3.substring(4,6)+"월");
      		$("#eventYM_1").val(eventYM_1);
      		$("#eventYM_2").val(eventYM_2);
      		$("#eventYM_3").val(eventYM_3);
      		$("#state_1").val(table.getData(_col_dtl.state, 0));
      		$("#state_2").val(table.getData(_col_dtl.state, 1));
      		$("#state_3").val(table.getData(_col_dtl.state, 2));
      	}
	}
	
	var _i_prd = 0;
	var _col_prd = {
		 prdNm : _i_prd++
		, planQty : _i_prd++
		, resultQty  : _i_prd++
		, eventYM : _i_prd++
		, prdCD : _i_prd++
    };
	
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0100105S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"prdNm;planQty;resultQty;eventYM;prdCD;");
	  	table.setParameter("format",
	  			"str;num;num;str;str;");
	  	table.setParameter("supportID", "${param.supportID}");
	  	table.setParameter("venueCD", $("#venueCD").val());
	  	table.request();
      	
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data_1 = new Array();
      		var data_2 = new Array();
      		var data_3 = new Array();
      		var cnt_1 = 0;
      		var cnt_2 = 0;
      		var cnt_3 = 0;
      		for (var i=0; i<rowCount; i++) {
      			if($("#eventYM_1").val()==table.getData(_col_prd.eventYM,i)){
      				data_1[cnt_1] = [
						table.getData(_col_prd.prdNm,i),
						table.getData(_col_prd.planQty,i),
						table.getData(_col_prd.resultQty,i),
						table.getData(_col_prd.eventYM,i),
						table.getData(_col_prd.prdCD,i)
      				];
      				cnt_1++;
      			}else if($("#eventYM_2").val()==table.getData(_col_prd.eventYM,i)){
      				data_2[cnt_2] = [
      					table.getData(_col_prd.prdNm,i),
      					table.getData(_col_prd.planQty,i),
      					table.getData(_col_prd.resultQty,i),
      					table.getData(_col_prd.eventYM,i),
      					table.getData(_col_prd.prdCD,i)
      		    	];
      		    	cnt_2++;
      		    }else{
      				data_3[cnt_3] = [
      		    		table.getData(_col_prd.prdNm,i),
      		    		table.getData(_col_prd.planQty,i),
      		    		table.getData(_col_prd.resultQty,i),
      		    		table.getData(_col_prd.eventYM,i),
      		    		table.getData(_col_prd.prdCD,i)
      		       	];
      		       	cnt_3++;
      		    }
      		}
      		grid_1.setCellData(data_1);
      		grid_2.setCellData(data_2);
      		grid_3.setCellData(data_3);
      		grid_1.setRowCount(cnt_1);
      		grid_2.setRowCount(cnt_2);
      		grid_3.setRowCount(cnt_3);
      	}
      	grid_1.refresh();
      	grid_2.refresh();
      	grid_3.refresh();
      	if($("#state_1").val()!="10"&&$("#state_1").val()!="40"){
      		grid_1.setCellEditable(false, _col_prd.planQty);
      		grid_1.getCellTemplate(_col_prd.planQty).setStyle("background", "#ececec");
      	}
      	if($("#state_2").val()!="10"&&$("#state_2").val()!="40"){
      		grid_2.setCellEditable(false, _col_prd.planQty);
      		grid_2.getCellTemplate(_col_prd.planQty).setStyle("background", "#ececec");
      	}
      	if($("#state_3").val()!="10"&&$("#state_3").val()!="40"){
      		grid_3.setCellEditable(false, _col_prd.planQty);
      		grid_3.getCellTemplate(_col_prd.planQty).setStyle("background", "#ececec");
      	}
      		
	}
	
	function Search_total() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0100106S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"prdNm;planQty;eventYM;prdCD;");
	  	table.setParameter("format",
	  			"str;num;str;str;");
	  	table.setParameter("supportID", "${param.supportID}");
	  	table.setParameter("venueCD", $("#venueCD").val());
	  	table.request();
      	
      	createGrid_total();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      				data[i] = [
						table.getData(_col_prd.prdNm,i),
						table.getData(_col_prd.planQty,i)*3,
						,
						,
						table.getData(_col_prd.prdCD,i)
      				];
      		}
      		
      		grid_total.setCellData(data);
      		grid_total.setRowCount(rowCount);
      	}
      	grid_total.refresh();
	}
	
	function Search_progress() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/LTC0100111S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"prdNm;resultQty;eventYM;prdCD;");
	  	table.setParameter("format",
	  			"str;num;str;str;");
	  	table.setParameter("supportID", "${param.supportID}");
	  	table.setParameter("venueCD", $("#venueCD").val());
	  	table.request();
      	
      	createGrid_progress();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      				data[i] = [
						table.getData(_col_prd.prdNm,i),
						table.getData(_col_prd.planQty,i),
						,
						,
						table.getData(_col_prd.prdCD,i)
      				];
      		}
      		
      		grid_progress.setCellData(data);
      		grid_progress.setRowCount(rowCount);
      	}
      	grid_progress.refresh();
	}
	
	function Save() {
		var prdCDs = new Array();
		var planQtys = new Array();
		var planQtys_1 = new Array();
		var planQtys_2 = new Array();
		var planQtys_3 = new Array();
		var eventYMs = new Array();
		var planQtys_total = new Array();
		var count = grid_total.getRowCount();
		
		for(var i=0; i<count;i++){
			planQtys_1[i] = parseFloat(unformatNum(grid_1.getCellText(_col_prd.planQty, i)));
			planQtys_2[i] = parseFloat(unformatNum(grid_2.getCellText(_col_prd.planQty, i)));
			planQtys_3[i] = parseFloat(unformatNum(grid_3.getCellText(_col_prd.planQty, i)));
			
			planQtys_total[i] = 0;
			planQtys_total[i] += planQtys_1[i];
			planQtys_total[i] += planQtys_2[i];
			planQtys_total[i] += planQtys_3[i];
			if(grid_total.getCellText(_col_prd.planQty, i)>planQtys_total[i]){
				alert("<fmt:message key="LTC01001C.msg1" />");
				return;
			}
		}
		
		for(var j=0; j<count;j++){
			planQtys[j]=grid_1.getCellText(_col_prd.planQty, j);
			planQtys[j+count]=grid_2.getCellText(_col_prd.planQty, j);
			planQtys[j+(count*2)]=grid_3.getCellText(_col_prd.planQty, j);
			
			prdCDs[j]=grid_1.getCellText(_col_prd.prdCD, j);
			prdCDs[j+count]=grid_2.getCellText(_col_prd.prdCD, j);
			prdCDs[j+(count*2)]=grid_3.getCellText(_col_prd.prdCD, j);

			eventYMs[j]=grid_1.getCellText(_col_prd.eventYM, j);
			eventYMs[j+count]=grid_2.getCellText(_col_prd.eventYM, j);
			eventYMs[j+(count*2)]=grid_3.getCellText(_col_prd.eventYM, j);
		}
		if(!confirm("<fmt:message key="confirm.save"/>")){
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ltc01/updatePlanQty");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("supportID", "${param.supportID}");
	  	table.setParameter("venueCD", $("#venueCD").val());
	  	table.setParameter("planQtys", planQtys);
	  	table.setParameter("prdCDs", prdCDs);
	  	table.setParameter("eventYMs", eventYMs);
		table.request();
		
		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			Close();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Close() {
		window.close();
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns_total = [
		"<fmt:message key="LTC01001C.prdNm" />"
		, "<fmt:message key="LTC01001C.enterQty" />"
	];
	var columns_progress = [
	    "<fmt:message key="LTC01001C.prdNm" />"
	    , "<fmt:message key="LTC01001C.enterQty" />"
	];
	var columns = [
		"<fmt:message key="LTC01001C.prdNm" />"
		, "<fmt:message key="LTC01001C.planQty" />"
		, "<fmt:message key="LTC01001C.resultQty" />"
	];

	var grid_1 = null;
	var grid_2 = null;
	var grid_3 = null;
	var grid_total = null;
	var grid_progress = null;
	
	function createGrid() {
		grid_1 = new AW.UI.Grid;
	    grid_1.setId("grid_1");
	    grid_1.setRowCount(0);
	    grid_1.setStyle("width","100%");
	    grid_1.setStyle("height","95%");
	    grid_1.setSelectorVisible(false);
	    grid_1.setSelectionMode("single-cell");
	    grid_1.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid_1.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_1.setColumnCount(columns.length);
	    grid_1.setCellFormat([
	                        str, num
	                        ]);
	    grid_1.setCellEditable(true);
	    grid_1.setCellEditable(false,_col_prd.prdNm);
	    grid_1.setCellEditable(false,_col_prd.resultQty);
	    
		grid_2 = new AW.UI.Grid;
	    grid_2.setId("grid_2");
	    grid_2.setRowCount(0);
	    grid_2.setStyle("width","100%");
	    grid_2.setStyle("height","95%");
	    grid_2.setSelectorVisible(false);
	    grid_2.setSelectionMode("single-cell");
	    grid_2.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid_2.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_2.setColumnCount(columns.length);
	    grid_2.setCellFormat([
	                        str, num
	                        ]);
	    grid_2.setCellEditable(true);
	    grid_2.setCellEditable(false,_col_prd.prdNm);
	    grid_2.setCellEditable(false,_col_prd.resultQty);
	    
		grid_3 = new AW.UI.Grid;
	    grid_3.setId("grid_3");
	    grid_3.setRowCount(0);
	    grid_3.setStyle("width","100%");
	    grid_3.setStyle("height","95%");
	    grid_3.setSelectorVisible(false);
	    grid_3.setSelectionMode("single-cell");
	    grid_3.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid_3.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_3.setColumnCount(columns.length);
	    grid_3.setCellFormat([
	                        str, num
	                        ]);
	    grid_3.setCellEditable(true);
	    grid_3.setCellEditable(false,_col_prd.prdNm);
	    grid_3.setCellEditable(false,_col_prd.resultQty);
	    
		
    }
	
	function createGrid_total() {
		grid_total = new AW.UI.Grid;
	    grid_total.setId("grid_total");
	    grid_total.setRowCount(0);
	    grid_total.setStyle("width","100%");
	    grid_total.setStyle("height","95%");
	    grid_total.setSelectorVisible(false);
	    grid_total.setSelectionMode("single-row");
	    grid_total.setHeaderText(columns_total);
	    for(var i=0;i<columns_total.length;i++){grid_total.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_total.setColumnCount(columns_total.length);
	    grid_total.setCellFormat([
	                        str, num
	                        ]);
	    grid_total.setCellEditable(false);
		
    }
	
	function createGrid_progress() {
		grid_progress = new AW.UI.Grid;
	    grid_progress.setId("grid_progress");
	    grid_progress.setRowCount(0);
	    grid_progress.setStyle("width","100%");
	    grid_progress.setStyle("height","95%");
	    grid_progress.setSelectorVisible(false);
	    grid_progress.setSelectionMode("single-row");
	    grid_progress.setHeaderText(columns_progress);
	    for(var i=0;i<columns_progress.length;i++){grid_progress.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_progress.setColumnCount(columns_progress.length);
	    grid_progress.setCellFormat([
	                        str, num
	                        ]);
	    grid_progress.setCellEditable(false);
		
    }
	
</script>