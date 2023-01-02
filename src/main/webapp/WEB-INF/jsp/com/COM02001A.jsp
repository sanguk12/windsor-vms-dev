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
						        			<col style="width:150px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
			                            <tr>
											<td class="td-cond">
												<fmt:message key="MDM01001A.dkmdTpCD" />
											</td>
											<td class="td-input">
												<nis:selectbox id="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" />
			                                </td>
			                                <td class="td-cond">
												<fmt:message key="MDM01001A.rageSphereCD" />
											</td>
											<td class="td-input">
												<nis:selectbox id="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" />
			                                </td>
			                            </tr>
			                            <tr>
											<td class="td-cond">
												<fmt:message key="MDM01001A.empID" />
											</td>
											<td class="td-input">
												<input type="text" id="empID_S" style="width:100px;">
			                                </td>
			                                <td class="td-cond">
												<fmt:message key="MDM01001A.empNm" />
											</td>
											<td class="td-input">
												<input type="text" id="empNm_S" style="width:100px;">
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

<!-- grid format -->
<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    .aw-row-selector {text-align: center}

    .aw-column-0 {width: 80px; text-align: center;}
	.aw-column-1 {width: 100px; text-align: center;}
	.aw-column-2 {width: 100px; text-align: center;}
	.aw-column-3 {width: 120px; text-align: left;}
	.aw-column-4 {width: 120px; text-align: left;}
	.aw-column-5 {width: 120px; text-align: left;}
	.aw-column-6 {width: 140px; text-align: left;}

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
	
	/****************************************
	* Function
	****************************************/
	
    $(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			$("#grid_displayNum").val("20");
			
			createGrid();
			grid.refresh();
			
			if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD_S").val("${params.dkmdTpCD}");
				$("#dkmdTpCD_S").attr("disabled", true);
				$("#dkmdTpCD_S").addClass("input-readonly");
			}
			$("#empNm_S").focus();
		};

		${initScript}
		
		$("#empNm_S").keypress(function(){
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
		dkmdTpCDName : _i++
		, empID : _i++
		, empNm : _i++
		, empTpCDName : _i++
		, rageSphereCDName : _i++
		, officeCDName : _i++
 		, teamCDName : _i++
		, territoryCDName : _i++
		, rowNum : _i++
		, totalCount : _i++
	};
    
	function PagingSearch(){
    	
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/MDM0100101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"dkmdTpCDName;empID;empNm;empTpCDName;rageSphereCDName;"
	  			+"officeCDName;teamCDName;territoryCDName;rowNum;totalCount;");
		table.setParameter("format",
				"str;str;str;str;str;"
				+"str;str;str;str;str;");
		table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("empID", $("#empID_S").val());
	  	table.setParameter("empNm", $("#empNm_S").val());
		//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
        table.setParameter("displayNum", $("#grid_displayNum").val());
        //Paging Parameter - END
      	table.request();
      	
//       	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
				data[i] = [
					table.getData(_col.dkmdTpCDName,i),
					table.getData(_col.empID,i),
					table.getData(_col.empNm,i),
					table.getData(_col.empTpCDName,i),
					table.getData(_col.rageSphereCDName,i),
					table.getData(_col.officeCDName,i),
					table.getData(_col.teamCDName,i),
					table.getData(_col.territoryCDName,i)
				];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      		//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
      		setPageInfo('grid', table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
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
			"empID":grid.getCellText(_col.empID, grid.getSelectedRows())
			, "empNm":grid.getCellText(_col.empNm, grid.getSelectedRows())
		}
		
		<c:if test="${!empty params.finalAction}"> 
			opener.${params.finalAction}(data);
		</c:if>
		
		window.close();
	}
	
</script>   

<script type="text/javascript">


	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var columns = [
		"<fmt:message key="MDM01001A.dkmdTpCD"/>",
		"<fmt:message key="MDM01001A.empID"/>", 
		"<fmt:message key="MDM01001A.empNm"/>", 
		"<fmt:message key="MDM01001A.empTpCD"/>",
		"<fmt:message key="MDM01001A.rageSphereCD"/>",
		"<fmt:message key="MDM01001A.officeCD"/>", 
		"<fmt:message key="MDM01001A.teamCD"/>", 
		"<fmt:message key="MDM01001A.territory"/>"
   	];
   	
   	var grid = null;
   	
   	function createGrid() {
   		
   		grid = new AW.Grid.Extended;
   		
   		grid.setId("grid");
   		grid.setCellFormat([str, str, str, str, str, str, str, str]);
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