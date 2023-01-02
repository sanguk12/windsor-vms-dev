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
								<!--엑셀업로드 화면 경로 -->
								<input type="hidden" id="appSrc_cha" name="appSrc_cha" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD04001B" />
								<input type="hidden" id="appSrc_ven" name="appSrc_ven" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD04001C" />
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
						                            	<td class="td-cond">
															<fmt:message key="AD04001A.chain" />
														</td>
														<td class="td-input">
															<input type="text" id="chain" name="chain" style="width: 150px;">
														</td>
						                            	<td class="td-cond">
															<fmt:message key="AD04001A.venue" />
														</td>
														<td class="td-input">
															<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
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
								<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
			                   		<tr>
			                   			<td width=35%">
											<span id="grid_cha"></span>
										</td>
										<td width="*">
			                            	<span id="grid_ven"></span>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height="1">
								<input type="hidden" id="selectChainCD" name="selectChainCD" />
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

	#grid_cha .aw-column-0 {width: 150px; text-align:center;}
	#grid_cha .aw-column-1 {width: 300px; text-align:left;}
    
    #grid_ven .aw-column-0 {width: 150px; text-align:center;}
    #grid_ven .aw-column-1 {width: 300px; text-align:left;}

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

		window.onload = function() {
			
			
			createGrid_cha();
			grid_cha.refresh();
			
			createGrid_ven();
			grid_ven.refresh();
			
			Search();
			
			
		};

		${initScript}
		
		$("#venue_S_popup").click(function(){
			openVenuePopup("closeVenuePopup");
		});
		
		$("#venue_S").keypress(function(){
			
			if (event.keyCode == 13){
				getVenueName("venue_S", "venueCD_S", "venueNm_S");
				
				if ($("#venueCD_S").val() != "") {
					Search_cha();
					Search_ven();
				}
			} 
		});
	});
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}

</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/

	function Search() {
		Search_cha();
	}
	
	var _i_cha = 0;
	var _col_cha = {
		chainCD : _i_cha++
		, chainNm : _i_cha++
    };
	
	function Search_cha() {
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/AD0400101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey", "chainCD;chainNm;");
	  	table.setParameter("format", "str;str;");
	  	table.setParameter("chain", $("#chain").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.request();
      	
      	createGrid_cha();
      	
      	var rowCount = table.getCount();
  		var data = new Array();
      		
      	if (rowCount > 0) {
      		for (var i = 0; i < rowCount; i++) {
      			
      			data[i] = [
					table.getData(_col_cha.chainCD,i)
					, table.getData(_col_cha.chainNm,i)
      			];
      			
      		}
      		grid_cha.setCellData(data);
      		grid_cha.setRowCount(rowCount);
      	}
      	grid_cha.refresh();
      	if($("#venue_S").val() !== "") {
	      	$("#selectChainCD").val(table.getData(_col_cha.chainCD,0));
      		Search_ven(table.getData(_col_cha.chainCD,0));
      	}
      	
	}
	
	var _i_ven = 0;
	var _col_ven = {
		venueCD : _i_ven++
	  , venueNm : _i_ven++
    };
	
	function Search_ven() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/AD0400102S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey", "venueCD;venueNm");
	  	table.setParameter("format", "str;str;");
	  	table.setParameter("chain", $("#chain").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("selectChainCD", $("#selectChainCD").val());
	  	table.request();
      	
      	createGrid_ven();
      	
      	var rowCount = table.getCount();
   		var data = new Array();
   		
      	if (rowCount > 0) {
      		
      		for (var i = 0; i < rowCount; i++) {
      			
      			data[i] = [
					table.getData(_col_ven.venueCD,i)
					, table.getData(_col_ven.venueNm,i)
      			];
      			
      		}
      		grid_ven.setCellData(data);
      		grid_ven.setRowCount(rowCount);
      	}
      	grid_ven.refresh();
      	
	}
	
	//체인업로드
	function ChainExcelUpload() {
		appletDiv_set({"src":$("#appSrc_cha").val(), "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
		appletOpen();
	}
	
	//체인다운로드
	function ChainExcelDownload() {
		
		if (!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "AD0400101S");
		table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("chainCD", $("#chain").val());
	  	
		var headerText = [
							"<fmt:message key="AD04001A.chainCD"/>"
						  , "<fmt:message key="AD04001A.chainNm"/>"
						 ];
		
		table.setParameter("templateFile", "AD04001B");
		table.setParameter("headerText", headerText);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0,0) == "S") {
			    form.action = "${contextPath}/service/simpleExport/download/?"+
			    		"tempFile="+table.getData(3,0)+
			    		"&downloadFile="+encodeURIComponent("${params.viewName}");
			    form.target = "_self";
			    form.submit();
			}
		}
	}
	
	
	//엑셀업로드
	function ExcelUpload() {
		appletDiv_set({"src":$("#appSrc_ven").val(), "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
		appletOpen();
	}
	
	//엑셀다운로드
	function Excel() {
		
		if (!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "AD0400103S");
		table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("chainCD", $("#chain").val());
	  	
		var headerText = [
							 "<fmt:message key="AD04001A.chainCD"/>"
					       , "<fmt:message key="AD04001A.venueCD"/>"
						 ];
		
		table.setParameter("templateFile", "AD04001C");
		table.setParameter("headerText", headerText);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0,0) == "S") {
			    form.action = "${contextPath}/service/simpleExport/download/?"+
			    		"tempFile="+table.getData(3,0)+
			    		"&downloadFile="+encodeURIComponent("체인업소관리");
			    form.target = "_self";
			    form.submit();
			}
		}
	}
	
	

	
	/*****************************************************
	*	define grid_cha/ data formats define
	*****************************************************/
	var columns_cha = [
		"<fmt:message key="AD04001A.chainCD"/>"
		, "<fmt:message key="AD04001A.chainNm"/>"
	];

	var grid_cha = null;
	
	function createGrid_cha() {
		grid_cha = new AW.UI.Grid;
	    grid_cha.setId("grid_cha");
	    grid_cha.setRowCount(0);
	    grid_cha.setStyle("width","100%");
	    grid_cha.setStyle("height","100%");
	    grid_cha.setSelectorVisible(false);
	    grid_cha.setSelectionMode("single-row");
	    grid_cha.setHeaderText(columns_cha);
	    for (var i = 0; i < columns_cha.length; i++) {
	    	grid_cha.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    grid_cha.setColumnCount(columns_cha.length);
	    grid_cha.setCellFormat([str, str]);
	    grid_cha.setCellEditable(false);
	    
	    grid_cha.onRowClicked = function(event, row){
	    	$("#selectChainCD").val(this.getCellText(_col_cha.chainCD,row));
	    	Search_ven();
		};
    }

	/*****************************************************
	*	define grid_ven/ data formats define
	*****************************************************/
	var columns_ven = [
		"<fmt:message key="AD04001A.venueCD"/>"
		, "<fmt:message key="AD04001A.venueNm"/>"
	];
	
	var grid_ven = null;
	
	function createGrid_ven() {
		grid_ven = new AW.Grid.Extended;
	    grid_ven.setId("grid_ven");
	    grid_ven.setRowCount(0);
	    grid_ven.setStyle("width","100%");
	    grid_ven.setStyle("height","100%");
	    grid_ven.setSelectorVisible(false);
	    grid_ven.setSelectionMode("single-cell");
	    grid_ven.setHeaderText(columns_ven);
	    for (var i = 0; i < columns_ven.length; i++) {
	    	grid_ven.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    grid_ven.setColumnCount(columns_ven.length);
	    grid_ven.setCellFormat([str, str]);
	    grid_ven.setCellEditable(false);

    }
	
</script>