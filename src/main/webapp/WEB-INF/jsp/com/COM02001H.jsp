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
											<col style="width:150px"></col>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													WS-도매지점
<!-- 													<fmt:message key="COM02001G.addrTpCD1Name" /> -->
												</td>
												<td class="td-input">
													<nis:selectbox id="wsCD" name="wsCD" defaultText="all" category="WSCD" />
				                                </td>
				                                <td class="td-cond">
				                                	WS-SAP
<!-- 				                                	<fmt:message key="COM02001G.addrTpCD2Name" /> -->
												</td>
												<td class="td-input">
													<input type="text" id="wsSapCD" name="wsSapCD" style="width:200px;">
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
    .aw-column-1 {width: 150px; text-align:left;}
    .aw-column-2 {width: 100px; text-align:center;}
    .aw-column-3 {width: 150px; text-align:left;}
        
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
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			$("#grid_displayNum").val("20");
			
			createGrid();
			grid.refresh();
			
			if("${params.wsCD}"!="") {
				$("#wsCD").val("${params.wsCD}");
			}
		};

		${initScript}
		
		$("#wsSapCD").keypress(function(){
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
   		wsCD : _i++
    	, wsCDName : _i++
   		, wsSapCD : _i++
   		, wsSapCDName : _i++
   		, rowNum : _i++
   		, totalCount : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/COM02001H01S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey",
				"wsCD;wsCDName;wsSapCD;wsSapCDName;rowNum;"
				+"totalCount;");
		table.setParameter("format",
				"str;str;str;str;str;"
				+"str;");
	  	table.setParameter("wsCD", $("#wsCD").val());
	  	table.setParameter("wsSapCD", $("#wsSapCD").val());
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
                   	table.getData(_col.wsCD,i)
                	, table.getData(_col.wsCDName,i)
                   	, table.getData(_col.wsSapCD,i)
                   	, table.getData(_col.wsSapCDName,i)
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
			"wsCDName":grid.getCellText(_col.wsCDName, grid.getSelectedRows())
			, "wsSapCDName":grid.getCellText(_col.wsSapCDName, grid.getSelectedRows())
			, "wsCD":grid.getCellText(_col.wsCD, grid.getSelectedRows())
			, "wsSapCD":grid.getCellText(_col.wsSapCD, grid.getSelectedRows())
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
		"<fmt:message key="COM02001H.wsCD"/>"
		, "<fmt:message key="COM02001H.wsCDName"/>"
		, "<fmt:message key="COM02001H.wsSapCD"/>"
		, "<fmt:message key="COM02001H.wsSapCDName"/>"
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