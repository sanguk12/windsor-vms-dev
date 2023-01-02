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
    <div id="wrapDiv">
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
											<col style="width:90px;"></col>
											<col style="width:120px;"></col>
											<col style="width:90px;"></col>
											<col style="width:120px;"></col>
											<col style="width:90px;"></col>
											<col></col>
										</colgroup>
										<tbody>
				                            <tr>
												<td class="td-cond">
													<fmt:message key="COM02001B.venueCD" />
												</td>
												<td class="td-input">
													<input type="text" id="venueCD_S" name="venueCD_S" style="width:100px;">
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="COM02001B.venueNm" />
												</td>
												<td class="td-input" colspan="3">
													<input type="text" id="venueNm_S" name="venueNm_S" style="width:100px;">
				                                </td>
				                            </tr>
				                            <tr>
												<td class="td-cond">
													<fmt:message key="MDM05001A.activeYN" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activeYN_S" name="ACTIVEYN" defaultText="all" category="ACTIVEYN" style="width:100px;"/>
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
                    <td height="*">
                        <span id="grid"></span>
                    </td>
                </tr>
                <tr>
                    <td class="td-paging">
<!--                         <nis:paging id="grid" titleDisable="no" callback="PagingSearch()"/> -->
                    </td>
                </tr>
                <tr>
                	<td height="1">
                	</td>
                </tr>
            </table>
        </form>
        </div>
    </body>
</html>

<!-- grid format -->
<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    .aw-row-selector {text-align: center}

    .aw-column-0 {width: 80px; text-align: center;}
	.aw-column-1 {width: 120px; text-align: left;}
	.aw-column-2 {width: 60px; text-align: center;}
	.aw-column-3 {width: 100px; text-align: center;}
	.aw-column-4 {width: 100px; text-align: left;}
	.aw-column-5 {width: 100px; text-align: left;}
	.aw-column-6 {width: 100px; text-align: left;}
	.aw-column-7 {width: 100px; text-align: left;}
	.aw-column-8 {width: 80px; text-align: center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">

	//Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>

	/****************************************
	 * Variable
	 ****************************************/
	 var totalCount = 0;
	
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
			Search();
			
		};

		${initScript}
		
		$("#venueCD_S").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		$("#venueNm_S").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		
	});
	
</script>    
	
<script type="text/javascript">


    /****************************************
	* Button Action
	****************************************/
   
	function Search() {
		$("#grid_pageNum").val("1");
		PagingSearch();
	}
    
	function Close() {
		window.close();
	}
	
	var _i = 0;
	var _col = {
		 venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, addrTpCD3Name : _i++
		, oldAddr2 : _i++
		, activeYNName : _i++
		, rowNum : _i++
	};
	function PagingSearch(){
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/MDM0600106S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"venueCD;venueNm;venueGradCDName;subSegmentCDName;addrTpCD1Name;"+
	  			"addrTpCD2Name;addrTpCD3Name;oldAddr2;activeYNName;rowNum;");
		table.setParameter("format",
				"str;str;str;str;str;"+
				"str;str;str;str;str;");
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("venueNm", $("#venueNm_S").val());
	  	table.setParameter("activeYN", $("#activeYN_S").val());
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	table.setParameter("empID", "${params.empID}");
      	table.request();
      	
//       	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
				data[i] = [
					  table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.addrTpCD3Name,i)
					, table.getData(_col.oldAddr2,i)
					, table.getData(_col.activeYNName,i)
				];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
//       		//totalCount
// 			var beginRowNum = table.getData(_col.rowNum,0);
// 			var endRowNum = table.getData(_col.rowNum,rowCount-1);
// 			table.setURL("${contextPath}/service/simpleAction/MDM0600108S");
// 			table.setAsync(false);
// 			table.setRequestMethod("POST");
// 			table.setParameter("outParamKey","totalCount;");
// 			table.setParameter("format","str;");
// 			table.request();
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			//setPageInfo('grid', beginRowNum, endRowNum, table.getData(0,0));
      	}
      	else {
      		////Paging Function: clearPageInfo(Grid Name);
            clearPageInfo('grid');
      		message("<fmt:message key="info.nullData"/>");
      	}
      	
      	grid.refresh();
	}
    
	function Choice() {
		
		var data = {
			"venueCD":grid.getCellText(_col.venueCD, grid.getSelectedRows())
		}
		
		<c:if test="${!empty params.finalAction}"> 
			opener.${params.finalAction}(data)
		</c:if>
		
		window.close();
	}
	
</script>   

<script type="text/javascript">


	/*****************************************************
	*	Grid Setting
	*****************************************************/
	
	var columns = [
		"<fmt:message key="COM02001B.venueCD"/>", 
		"<fmt:message key="COM02001B.venueNm"/>", 
		"<fmt:message key="COM02001B.venueGradCD"/>",
		"<fmt:message key="COM02001B.subSegmentCD"/>",
		"<fmt:message key="MDM05001A.addrTpCD1Name"/>", 
		"<fmt:message key="MDM05001A.addrTpCD2Name"/>", 
		"<fmt:message key="MDM05001A.addrTpCD3Name"/>", 
		"<fmt:message key="MDM05001A.addrTpCD4Name"/>", 
		"<fmt:message key="COM02001B.activeYN"/>"
   	];
   	
   	var grid = null;
   	function createGrid() {
   		
   		grid = new AW.UI.Grid;
   		grid.setId("grid");
   		grid.setCellFormat([str, str, str, str, str, str, str, str, str]);
   		grid.setHeaderText(columns);
   		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
   		grid.setRowCount(0);
   		grid.setColumnCount(columns.length);
   		grid.setSelectorVisible(false);
   		grid.setSelectionMode("single-row");
   		grid.setCellEditable(false);
   		grid.setFixedLeft(3);
   		
   		grid.onRowDoubleClicked = function(event, row) {
	    	Choice();
	    };
   	}
    
</script>