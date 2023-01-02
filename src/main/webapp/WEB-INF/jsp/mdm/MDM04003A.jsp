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
													<fmt:message key="MDM04003A.ifDate" />
												</td>
												<td class="td-input">
													<nis:calendar id="startDate" cssClass="input-readonly" readOnly="yes" value="" eventproc="" /> - 
													<nis:calendar id="endDate" cssClass="input-readonly" readOnly="yes" value="" eventproc="" />
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

	.aw-column-0 {width: 150px; text-align:center;}
	.aw-column-1 {width: 150px; text-align:center;}
    .aw-column-2 {width: 60px; text-align:center;}
    .aw-column-3 {width: 200px; text-align:left;}
    .aw-column-4 {width: 80px; text-align:center;}

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
			
			createGrid();
			grid.refresh();
			
			$("#startDate").val("${params.firstDate}");
			$("#endDate").val("${params.currentDate}");
		};

		${initScript}
		
	});
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	var _i = 0;
	var _col = {
        ifDate : _i++
		, ifNm : _i++
		, resultCD : _i++
		, resultMsg : _i++
		, ifResultCD : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MDM0400301S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"ifDate;ifNm;resultCD;resultMsg;ifResultCD;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;");
		table.setParameter("startDate", unformat($("#startDate").val()));
	  	table.setParameter("endDate", unformat($("#endDate").val()));
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					table.getData(_col.ifDate,i)
					, table.getData(_col.ifNm,i)
					, table.getData(_col.resultCD,i)
					, table.getData(_col.resultMsg,i)
					, table.getData(_col.ifResultCD,i)
      			];
      		}
			grid.setCellData(data);
			grid.setRowCount(rowCount);
		}
      	grid.refresh();
	}
	
	function Execute() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM04003B";
    	newWindow(url, "MDM04003B",400,300,"yes");
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="MDM04003A.ifDate" />"
		, "<fmt:message key="MDM04003A.ifNm" />"
		, "<fmt:message key="MDM04003A.resultCD" />"
		, "<fmt:message key="MDM04003A.resultMsg" />"
		, "<fmt:message key="MDM04003A.ifResultCD" />"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
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
	                        str, str, str, str, str
	                        ]);
	    grid.setCellEditable(false);
    }
	
</script>