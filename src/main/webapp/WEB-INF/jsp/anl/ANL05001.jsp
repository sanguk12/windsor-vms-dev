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
						        			<col style="width:300px;"></col>						        			
<!-- 						        			<col style="width:400px;"></col> -->
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
				                           		 <td class="td-cond">
													<fmt:message key="ANL05001.venue" />
												</td>
				                            	<td class="td-input">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:80px;" />
												</td>
												<td class="td-cond">
													<fmt:message key="ANL05001.empOld" />
												</td>								
												<td class="td-input"" colspan = "2">
														<input type="text" id="empID_Old" name="empID_Old" value="" style="width:100px;">	
														<input type="text" id="empNm_Old" name="empNm_Old" value="" style="width:100px;">
					                            </td>					                            
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
				                            		<fmt:message key="ANL05001.empNew"/>
												</td>
												<td class="td-input" >
													<nis:popup id="emp" nameID="empNm" keyID="empID" />
													<!-- <input type="hidden" id="orgEmpID" name="orgEmpID" /> -->
												</td>              	
				                            	<td class="td-cond">
				                            		<fmt:message key="ANL05001.territoryCD"/>
												</td>
												<td class="td-input">
													<nis:popup id="territory" nameID="territoryCDName" keyID="territoryCD" />													
												</td>
												<td class="td-input">
													<input type="button" onclick="searchBtnClick()" value="조회" name="searchBtn" id="searchBtn" style="float: right; width:50;" >													
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

	.aw-column-0 {width: 100px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:center;}
    .aw-column-4 {width: 100px; text-align:left;}
    .aw-column-5 {width: 100px; text-align:left;}
    .aw-column-6 {width: 100px; text-align:left;}
    .aw-column-7 {width: 120px; text-align:left;}
    

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
		$(document).ready(function() {

		window.onload = function() {			
			
			$("#grid_displayNum").val("100");
			createGrid();
			grid.refresh();
			Search();
			
		};
		
		$("#empID_Old").attr("disabled", true);
		$("#empID_Old").addClass("input-readonly");
		
		$("#empNm_Old").attr("disabled", true);
		$("#empNm_Old").addClass("input-readonly");
		
		$("#territory").keypress(function(){
			if (event.keyCode==13){
				getTerritoryName("territory", "territoryCD", "territoryCDName");
			}
		});
		$("#territory_popup").click(function(){
			openTerritoryPopup("closeTerritoryPopup");
		});			
		
		$("#emp").keypress(function(){
			if (event.keyCode==13){
				getEmpName("emp", "empID", "empNm");
			}
		});		
		$("#emp_popup").click(function(){
			openEmpPopup("closeEmpPopup");
		});
		
		
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
	
	var _col_cd = {
		"code" : 0,
		"name" : 1
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
		chgDate : _i++
		, venueCD : _i++
		, venueNm : _i++
		, territoryCD : _i++		
		, territoryCDName : _i++		
		, regID : _i++
		, regNm : _i++
// 		, updateQuery : _i++		
		, rowNum : _i++
		, totalCount : _i++	
    };
	
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/ANL0500101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"chgDate;venueCD;venueNm;territoryCD;territoryCDName;"+
	  			"regID;regNm;rowNum;totalCount");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("territoryCD", $("#territoryCD").val());
	  	table.setParameter("territoryCDName", $("#territoryCDName").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("venueNm", $("#venueNm_S").val());
	  	table.setParameter("empID_Old", $("#empID_Old").val());
	  	table.setParameter("empNm_Old", $("#empNm_Old").val());
	  	table.setParameter("empID", $("#empID").val());
	  	table.setParameter("empNm", $("#empNM").val());	  	
	  	
	  	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
		
		// ---
	  	table.request();
      	
		//if (grid != null) grid.clear();
      	createGrid();
      	
		var rowCount = table.getCount();
		if (rowCount > 0) {
			
			var data = new Array();
			
			for (var i = 0; i<rowCount; i++) {
				
				data[i] = [
					 table.getData(_col.chgDate,i)
					,table.getData(_col.venueCD,i)
					,table.getData(_col.venueNm,i)					
					,table.getData(_col.territoryCD,i)
					,table.getData(_col.territoryCDName,i)
					,table.getData(_col.regID,i)
					,table.getData(_col.regNm,i)
// 					,table.getData(_col.updateQuery,i)				
					];
      		}
			
			
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
			
			/* //totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/ANL0500102S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("outParamKey","totalCount;");
			table.setParameter("format","str;");
			table.request(); */
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
      		setPageInfo('grid', table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
		}
		else {
			message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
      	}
      	grid.refresh();
	}
	
	function Transformation(){
		if (!confirm("변환하시겠습니까?")) {
            //Search();
        } else {
            Update();
        }
	}
	
	function Update(){
		//alert("변환확인클릭");		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/anl05/changeEmpID");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("territoryCD", $("#territory").val());
	  	table.setParameter("territoryCDName", $("#territoryCDName").val());
	  	table.setParameter("venueCD", $("#venue_S").val());
	  	table.setParameter("venueNm", $("#venueNm_S").val());
		table.setParameter("empID",$("#empID").val());
		table.setParameter("empNm",$("#empNm").val());
		table.request();
		
		/* if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			$("#adSupportID").val(table.getData(3,0));
			$("#adSeq").val(table.getData(4,0));
			Search(); 
   		}
		else {
			alert(table.getData(1,0));
		}
	 else{
		if(!checkContractDate()) {
			return;
		}	 */	
		New();
	 }
	 
	function New(){
		$("#empID_Old").val("");
		$("#empNm_Old").val("");
		$("#venue_S").val("");
		$("#venueNm_S").val("");		
		$("#territory").val("");
		$("#territoryCDName").val("");
		$("#emp").val("");
		$("#empNm").val("");
		Search();
	}
	function searchBtnClick(){		
		Search();	
	}
	
	//업소 팝업 close
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
	//Territory 팝업 close
	function closeTerritoryPopup(data) {
		$("#territory").val(data.territoryCD);
		$("#territoryCD").val(data.territoryCD);
        $("#territoryCDName").val(data.territoryCDName);
	}
	
	//사원 팝업 close
	function closeEmpPopup(data) {
		$("#emp").val(data.empID);
		$("#empID").val(data.empID);
        $("#empNm").val(data.empNm);
	}		
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="ANL05001.chgDate"/>"				
		,"<fmt:message key="ANL05001.venueCD"/>"
		,"<fmt:message key="ANL05001.venueNm"/>"
		,"<fmt:message key="ANL05001.territoryCD"/>"
		,"<fmt:message key="ANL05001.territoryNm"/>"
		,"<fmt:message key="ANL05001.empCD"/>"
		,"<fmt:message key="ANL05001.empNm"/>"
		,"<fmt:message key="ANL05001.updateQuery"/>"
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
	    for(var i=0;i<columns.length;i++){
	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                          str, str, str, str, str 
	                        , str, str, str
	                        ]);
	    grid.setCellEditable(false); 
	    
	    
	  //그리드 row 클릭
	    grid.onRowDoubleClicked = function(event, row){
	    	$("#empID_Old").val("");
			$("#empNm_Old").val("");						
			$("#empID_Old").val(this.getCellText(_col.regID, row));			
			$("#empNm_Old").val(this.getCellText(_col.regNm, row));
			$("#venueNm_S").val("");
			$("#venue_S").val(this.getCellText(_col.venueCD, row));			
			$("#venueNm_S").val(this.getCellText(_col.venueNm, row));
			$("#territory").val("");
			$("#territoryCDName").val("");
			$("#territory").val(this.getCellText(_col.territoryCD, row));			
			$("#territoryCDName").val(this.getCellText(_col.territoryCDName, row));
			
	    }	    
    }
	
</script>