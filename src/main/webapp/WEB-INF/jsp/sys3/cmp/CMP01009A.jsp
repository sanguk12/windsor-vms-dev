<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<form name="form" method="post">
		<div id="wrapDiv">
	    	<div id="formDiv">
	        	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
	                <tr>
	                    <td height="1">
							<%@include file="../cms/standardParam.jsp" %>
							<%@include file="../cms/functionbar.jsp" %>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="1">
	                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
	                    		<tr>
	                    			<td class="tb-border">
							        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
							        		<colgroup>
							        			<col style="width:80px;"></col>
							        			<col></col>
							        		</colgroup>
							        		<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01009A.searchWord" />
												</td>
												<td class="td-input">
													<input type="text" id="grpName" name="grpName" style="width:200px;">
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
	            </table>
	        </div>
		</div>
	</form>
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    .aw-column-0 {width: 80px; text-align: center;}
    .aw-column-1 {width: 130px;}
    .aw-column-2 {width: 130px;}
    .aw-column-3 {width: 150px;}
    .aw-column-4 {width: 130px; text-align:center;}
    .aw-column-5 {width: 80px; text-align:center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
    
//-->
</style>


<script type="text/javascript">

	$(document).ready(function() {
		
		window.onload = function() {
			Search();
			$("#grpName").focus();
		};
	
		${initScript}
		
		$("#grpName").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
	});
	
	var servlet = "${contextPath}/service/group";
	var WIDTH=600;
	var HEIGHT=310;

	function Insert() {
		var queryString = "/detailGroup/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01009B";
		newWindow(servlet+queryString, "InsertGroup", WIDTH, HEIGHT, "no");
	}
	
	function Detail(grpID) {
		var queryString = "/detailGroup/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01009B&grpID="+grpID;
		newWindow(servlet+queryString, grpID, WIDTH, HEIGHT, "no");
	}
	
	function MenuAuth(grpID, mnuConstructID) {
		if(mnuConstructID!="") {
			var param = "/initAuthMenuConstruct/?";
			param += "grpID_con="+grpID;
			param += "&mnuConstructID="+mnuConstructID;
			param += "&mnuGrpID=${params.mnuGrpID}";
			param += "&pgmID=${params.pgmID}";
			param += "&viewID=CMP01009C";
			//gtf. 20130139. taejoon.jang
// 			param += "&gtfcompanyID="+companyID;
			
			newWindow("${contextPath}/service/auth"+param, "AuthMenuConstruct", "890", "557", "no");
		} else {
			alert("<fmt:message key="infos.selected" />");
		}
	}
	
	function Search() {
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0100901S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","grpID;grpName;mnuConstructName;remark;mnuConstructID;dkmdTpCDName;");
// 	  	table.setParameter("companyID", "${params.companyID}");
	  	table.setParameter("grpName", $("#grpName").val());
      	table.request();
      	
      	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
      				table.getData(0,i),
      				table.getData(1,i),
      				table.getData(2,i),
      				table.getData(3,i),
      				((table.getData(4,i)!='')?"<fmt:message key="button.MenuAuthSetting"/>":""),
      				table.getData(5,i)
      			];
      			
      			if (table.getData(4,i) != '') {
                    grid.setCellLink("javascript:MenuAuth('"+table.getData(0,i)+"', '"+table.getData(4,i)+"');", 4, i);
                }
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	} else {
      		alert("<fmt:message key="info.nullData"/>");
      	}
      	grid.refresh();
	}
	
	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var grid = null;
	
	var columns = [
		"<fmt:message key="CMP01009A.grpID"/>",
		"<fmt:message key="CMP01009A.grpName"/>",
		"<fmt:message key="CMP01009A.mnuConstructName"/>",
		"<fmt:message key="CMP01009A.remark"/>",
		"<fmt:message key="CMP01009A.MenuAuthSetting" />",
		"<fmt:message key="CMP01009A.dkmdTpCD" />"
	];
	
	function createGrid() {

		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setSelectorWidth(40);
		grid.getSelectorTemplate().setStyle("text-align", "right");
		grid.setSelectorVisible(true);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);
		grid.setHeaderText(columns);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setColumnCount(columns.length);
		grid.setCellFormat([str, str, str, str, str, str]);
		
		grid.setCellTemplate(new AW.Templates.Link, 4);
		
		grid.onRowDoubleClicked = function(event, rowIndex){
			Detail(this.getCellText(0, rowIndex));
	    }
	}
</script>