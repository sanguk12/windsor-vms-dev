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
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
											<col style="width:100px"></col>
											<col style="width:180px"></col>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="MDM01001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD" name="rageSphereCD" defaultText="all" category="RAGESPHERECD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="MDM01001A.officeCD" />
												</td>
												<td class="td-input">
													<div id="officeCD_cond" style="float:left;">
														<select id="officeCD" style="width:100px;">
															<option value=""><fmt:message key="all" /></option>
														</select>
													</div>
				                                </td>
											</tr>
											<tr>
				                                <td class="td-cond">
				                                    <fmt:message key="MDM01001A.teamCD" />
				                                </td>
				                                <td class="td-input">
				                                    <div id="teamCD_cond" style="float:left;">
														<select id="teamCD" style="width:100px;">
															<option value=""><fmt:message key="all" /></option>
														</select>
													</div>
				                                </td>
				                                <td class="td-cond">
				                                    <fmt:message key="MDM01001A.territory" />
				                                </td>
				                                <td class="td-input">
				                                	<input type="text" id="territoryCD" name="territoryCD" style="width:150px;">
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

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}
	
    .aw-column-0 {width: 120px; text-align:center;}
    .aw-column-1 {width: 120px; text-align:center;}
    .aw-column-2 {width: 120px; text-align:center;}
    .aw-column-3 {width: 120px; text-align:center;}
        
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}

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
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			$("#grid_displayNum").val("20");
			
			createGrid();
			grid.refresh();
		};

		${initScript}
		
		$("#territoryCD").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		
	});
	
	$("#rageSphereCD").change(function() {
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "OFFICECD");
        table.setParameter("attrib02", $("#rageSphereCD").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='officeCD' style='width:100px;' onchange='refresh_teamCD()'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#officeCD_cond").html(s);
        
        var init_teamCD = "<select id='teamCD' style='width:100px;'><option value=''><fmt:message key="all"/></option></select>";
        $("#teamCD_cond").html(init_teamCD);
	});
	
	function refresh_teamCD() {
		
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "TEAMCD");
        table.setParameter("attrib02", $("#officeCD").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='teamCD' style='width:100px;'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#teamCD_cond").html(s);
        
        var init_territoryCD = "<select id='territoryCD' style='width:100px;'><option value=''><fmt:message key="all"/></option></select>";
        $("#territoryCD_cond").html(init_territoryCD);
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
    
	function Close() {
		window.close();
	}
	
	var _i = 0;
    var _col = {
    	rageSphereCDName : _i++
   		, officeCDName : _i++
   		, teamCDName : _i++
   		, territoryCDName : _i++
   		, rageSphereCD : _i++
   		, officeCD : _i++
   		, teamCD : _i++
   		, territoryCD : _i++
   		, rowNum : _i++
   		, totalCount : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/COM02001F01S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey",
				"rageSphereCDName;officeCDName;teamCDName;territoryCDName;rageSphereCD;"
				+"officeCD;teamCD;territoryCD;rowNum;totalCount;");
		table.setParameter("format",
				"str;str;str;str;str;"
				+"str;str;str;str;str;");
	  	table.setParameter("rageSphereCD", $("#rageSphereCD").val());
	  	table.setParameter("officeCD", $("#officeCD").val());
	  	table.setParameter("teamCD", $("#teamCD").val());
	  	table.setParameter("territoryCD", $("#territoryCD").val());
		//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
        table.request();
        
//         if (grid != null) grid.clear();
        createGrid();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	data[i] = [
                	table.getData(_col.rageSphereCDName,i)
                   	, table.getData(_col.officeCDName,i)
                   	, table.getData(_col.teamCDName,i)
                   	, table.getData(_col.territoryCDName,i)
                   	, table.getData(_col.rageSphereCD,i)
                   	, table.getData(_col.officeCD,i)
                   	, table.getData(_col.teamCD,i)
                   	, table.getData(_col.territoryCD,i)
            	];
            }
            grid.setCellData(data);
            grid.setRowCount(rowCount);
            
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
            setPageInfo("grid", table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
        }
        else {
        	message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
		}
        grid.refresh();
	}
	
	function Choice() {
		
		var data = {
			"territoryCD":grid.getCellText(_col.territoryCD, grid.getSelectedRows())
			, "territoryCDName":grid.getCellText(_col.territoryCDName, grid.getSelectedRows())
		}
		
		if("${params.gridRow}"=="") {
			<c:if test="${!empty params.finalAction}"> 
				opener.${params.finalAction}(data);
			</c:if>
		}
		else {
			<c:if test="${!empty params.finalAction}"> 
				opener.${params.finalAction}(data, "${params.gridRow}");
			</c:if>
		}
		
		window.close();
	}
	
</script>   

<script type="text/javascript">


	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var grid = null;
	
	var columns = [
		"<fmt:message key="MDM01001A.rageSphereCD"/>"
		, "<fmt:message key="MDM01001A.officeCD"/>"
		, "<fmt:message key="MDM01001A.teamCD"/>"
		, "<fmt:message key="MDM01001A.territory"/>"
	];
    
	function createGrid() {
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str]);
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setHeaderHeight(20);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setSelectionMode("single-row");
		grid.setStyle("width","100%");
		grid.setStyle("height","100%");
		grid.setCellEditable(false);
	    
	    grid.onRowDoubleClicked = function(event, row) {
	    	Choice();
	    };
    }
    
</script>