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
					    <input type="hidden" id="planWriteYN" name="planWriteYN" />
					    <input type="hidden" id="apprTpID" name="apprTpID" value="000000" /><!-- Plan/Result 승인라인 -->
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 150px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 200px; text-align:right;}
    .aw-column-3 {width: 150px; text-align:right;}
    .aw-column-4 {width: 150px; text-align:right;}
    .aw-column-5 {width: 150px; text-align:right;}
    .aw-column-6 {width: 150px; text-align:center;}

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
			
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));  
    		
    		getPlanWriteYN();
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
	
	
	//Plan작성기간 유무판단
	function getPlanWriteYN() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "01");	//01:plan_업소단위,02:result_업소단위,03:plan_브랜드단위,04:result_브랜드단위
		table.request();
		
		if(table.getCount() > 0) {
			
			$("#planWriteYN").val(table.getData(0,0));
			if(table.getData(0,0) == "Y") {
				btnRequestApp.setControlDisabled(false);
				btnClearRequestApp.setControlDisabled(false);
			} else {
				btnRequestApp.setControlDisabled(true);
				btnClearRequestApp.setControlDisabled(true);
			}
		}
	}
	
	var _col_cd = {
		  "code" : 0
		, "name" : 1
	}
		
	/****************************************
	* Button Action
	****************************************/		
	var _i = 0;
	var _col = {
		  summary : _i++
		, summaryN : _i++
		, volume : _i++
		, incentive : _i++
		, GSV : _i++
		, NGGSV : _i++	
		, apprStateCDName : _i++
		, apprStateCD : _i++
    };
	
	function Search() {		
		getPlanWriteYN();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0101101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","summary;summaryN;volume;incentive;GSV;NGGSV;apprStateCDName;apprStateCD;"	);
	  	table.setParameter("format","str;str;num;num;num;num2;str;str;");
	  	
	  	table.setParameter("empID"      , "${params.userID}");	 
	  	table.setParameter("eventYM"    , $("#yearCD_S").val()+$("#monthCD_S").val()); 	  

	  	table.request();

      	createGrid();
      	
		var rowCount = table.getCount();
		if (rowCount > 0) {
			var data = new Array();
			for (var i=0; i<rowCount; i++) {
      			
				var apprStateCDName = "";
				
      			if(table.getData(_col.apprStateCD,i) == "0") {
      				apprStateCDName = "";
          		}
          		else {
          			if(i==1){
              		    apprStateCDName = table.getData(_col.apprStateCDName,i);
              		}
          		}
      			
				data[i] = [
					formatMonth(  table.getData(_col.summary,i))
								, table.getData(_col.summaryN,i)
								, table.getData(_col.volume,i)
								, table.getData(_col.incentive,i)
								, table.getData(_col.GSV,i)
								, table.getData(_col.NGGSV,i)   	
								, apprStateCDName
					            , table.getData(_col.apprStateCD,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);			
		}
		else {
			message("<fmt:message key="info.nullData"/>");	
      	}
      	grid.refresh();
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
	
	//승인요청
	function RequestApp() {
		
		if($("#myAppr").text() == "") {
			alert("<fmt:message key="PLN01003A.msg1"/>");
			return;
		}
		
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}		
		
		//승인상태가 등록일 경우만 가능
		if(grid.getCellText(_col.apprStateCD, index[1]) != "10") {
			alert("<fmt:message key="PLN01003A.msg2"/>");
			return;
		}
		
		if(!confirm("<fmt:message key="PLN01003A.msg4"/>")) {
       		return;
       	}
		
		//업소별 저장상태 체크
		var table2 = new AW.XML.Table;
		table2.setURL("${contextPath}/service/simpleAction/PLN0101102S");
		table2.setAsync(false);
		table2.setRequestMethod("POST");
		table2.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table2.setParameter("empID", "${params.empID}");
		
		table2.request();

		if(table2.getData(0,0) != "0") {
			alert("<fmt:message key="PLN01003A.msg7"/>");
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln01/requestAppPlan");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprStateCD", "20");
		table.setParameter("apprTpID", $("#apprTpID").val());
		
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));			
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	//승인취소
	function ClearRequestApp() {
		
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		if(grid.getCellText(_col.apprStateCD, index[1]) != "20") {
			alert("<fmt:message key="PLN01003A.msg5"/>");
			return;
		}
		
		if(!confirm("<fmt:message key="PLN01003A.msg6"/>")) {
       		return;
       	}
				
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln01/clearRequestAppPlan");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("apprStateCD", "10");
		table.setParameter("apprTpID", $("#apprTpID").val());		
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
		table.setParameter("queryKey", "PLN0101101S");		  	
	  	table.setParameter("eventYM"    , $("#yearCD_S").val()+$("#monthCD_S").val());  
	  	table.setParameter("empID"      , "${params.userID}");	 	  	  
	  	
		
		var headerText = [
			  "<fmt:message key="PLN01011A.summary"/>"
			, "<fmt:message key="PLN01011A.summaryN"/>"
			, "<fmt:message key="PLN01011A.volume"/>"
			, "<fmt:message key="PLN01011A.incentive"/>"
			, "<fmt:message key="PLN01011A.GSV"/>"
			, "<fmt:message key="PLN01011A.NGGSV"/>"
		];
		
		table.setParameter("templateFile", "PLN01011A");
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
		  "<fmt:message key="PLN01011A.summary"/>"
		, "<fmt:message key="PLN01011A.summaryN"/>"
		, "<fmt:message key="PLN01011A.volume"/>"
		, "<fmt:message key="PLN01011A.incentive"/>"
		, "<fmt:message key="PLN01011A.GSV"/>"
		, "<fmt:message key="PLN01011A.NGGSV"/>"
		, "<fmt:message key="PLN01003A.apprStateCD"/>"
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
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                          str, str,  num, num , num, num2, str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(2);
	    
	    grid.onHeaderClicked=function(event,col){	
			return true;
		};
	    
    }
	
</script>