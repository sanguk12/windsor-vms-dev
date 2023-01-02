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
	                    <td valign="top">
	                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
	                    		<tr>
				                    <td width="200" height="*" rowspan="2" class="tree-border">
				                        <iframe id="_tree" name="_tree" width="100%" height="100%" frameborder='0' scrolling='auto'></iframe>
	                    			</td>
				                    <td class="tb-border" height="30" width="*">
				                    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
				                    		<colgroup>
				                    			<col style="width:120px"></col>
				                    			<col style="width:300px"></col>
				                    			<col style="width:80px"></col>
				                    			<col></col>
				                    		</colgroup>
				                    		<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01003A.codeDiv" />
												</td>
												<td class="td-input">
													<input type="text" id="codeDivName" name="codeDivName" class="input-readonly"  style="width:150px;" value="ROOT" readonly="readonly">
				                        			<input type="text" id="codeDiv" name="codeDiv" class="input-readonly"  style="width:100px;" value="ROOT" readonly="readonly">
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01003A.searchWord" />
												</td>
												<td class="td-input">
													<input type="text" id="codeName" name="codeName" />
<!-- 													<input type="checkbox" class="checkbox" id="codeAll" name="codeAll" /> -->
												</td>
											</tr>
											</tbody>
										</table>
				                    </td>
				                </tr>
				                <tr>
				                    <td height="*">
				                        <span id="grid"></span>
				                    </td>
				                </tr>
				            </table>
				        </td>
					</tr>
				</table>
				<div id="tmp"></div>
			</div>
			${appletDiv}
		</div>
	</form>
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    .aw-column-0 {width: 150px;}
    .aw-column-1 {width: 150px;}
    .aw-column-2 {width: 250px;}
    .aw-column-3 {width: 80px; text-align:right;}
    .aw-column-4 {width: 70px; text-align:center;}
    
    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">
	var servlet = "${contextPath}/service/code";
	var WIDTH=650;
	var HEIGHT=465;

	$(document).ready(function() {
		
		window.onload = function() {
			
			fnMessage('${params.MSG}');
			$("#codeName").focus();
			
			Search();
		};
	
		${initScript}
		
		$("#codeName").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
	});
		
	// Insert
	function Insert() {
		var queryString = "/detailCode/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01003B&codeDiv="+$("#codeDiv").val();
		newWindow(servlet+queryString, "InsertCode", WIDTH, HEIGHT, "no");
	}
	
	// Delete
	function Delete() {
		if(grid.getSelectedRows().length>0) {
			document.all.tmp.innerHTML="";
			for(var i=0;i<grid.getSelectedRows().length;i++) {
				document.all.tmp.innerHTML+="<input type=\"hidden\" name=\"comCodes\" value=\""+grid.getCellText(0, grid.getSelectedRows()[i])+"\"/>";
			}
			fnSubmitConfirm(form, servlet, "deleteListCode", "<fmt:message key="confirm.delete" />");
		} else {
			message("<fmt:message key="infos.selected" />");
		}
	}
	
	// Detail Open
	function Detail(comCode) {
		var queryString = "/detailCode/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01003B&codeDiv="+$("#codeDiv").val()+"&comCode="+comCode;
		newWindow(servlet+queryString, comCode, WIDTH, HEIGHT, "no");
	}
	
	function SetValue(codeDiv, codeDivName) {
		$("#codeDiv").val(codeDiv);
		$("#codeDivName").val(codeDivName);
	}
	
	function Search() {
	
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0100301S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"codeDiv;comCode;codeName;codeDesc;seq;remark;useYN;"+
	  			"attrib01;attrib02;attrib03;attrib04;attrib05;attrib06;"+
	  			"attrib07;attrib08;attrib09;attrib10;attrib11;attrib12;");
	  	table.setParameter("useYN", "ALL");
	  	table.setParameter("codeName", $("#codeName").val());
	  	if(arguments.length <= 0) {
			table.setParameter("codeDiv", $("#codeDiv").val());
		}
	  	else {
			table.setParameter("codeDiv", arguments[0]);
		}
	  	
// 	  	var codeAll = $("input:checkbox[name=codeAll]").attr("checked")=="checked"?"Y":'N';
// 	  	table.setParameter("codeAll", codeAll);
	  	
      	table.request();
      	
      	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
      				table.getData(1,i),
      				table.getData(2,i),
      				table.getData(3,i),
      				table.getData(4,i),
      				table.getData(6,i)
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	else {
      		message("<fmt:message key="info.nullData"/>");
      	}
      	
      	if ($("#codeDiv").val() == 'ROOT') {
	      		$("#_tree").attr("src", "${contextPath}/service/code/initCodeList/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01003C&codeDiv=ROOT");
	      	//document._tree.location.href=
	        	//"${contextPath}/service/code/initCodeList/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01003C&codeDiv=ROOT";
	    }
                    
      	grid.refresh();
	}
	
	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var grid = null;

	var columns = [
		"<fmt:message key="CMP01003A.comCode"/>",
		"<fmt:message key="CMP01003A.codeName"/>",
		"<fmt:message key="CMP01003A.codeDesc"/>",
		"<fmt:message key="CMP01003A.seq"/>",
		"<fmt:message key="CMP01003A.useYN"/>"
	];
	
	function createGrid() {
	
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setSelectorWidth(40);
		grid.getSelectorTemplate().setStyle("text-align", "right");
		grid.setSelectorVisible(true);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setSelectionMode("multi-row-marker");
		grid.setCellEditable(false);
		grid.setHeaderText(columns);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setColumnCount(columns.length);
		grid.setCellFormat([str, str, str, num, str]);
		
		grid.onRowDoubleClicked = function(event, rowIndex){
			Detail(this.getCellText(0, rowIndex));
	    }
	}
</script>