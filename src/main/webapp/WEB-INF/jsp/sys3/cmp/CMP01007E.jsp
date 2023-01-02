<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title><fmt:message key="application.title" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <%@include file="../scripts.jsp" %>
</head>

<body onload="fnMessage('${params.msg}');" class="yui-skin-sam" ${bodyConfig}>
<form name="form" method="post">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
    	<tr>
        	<td height="1">
				<!-- Standard Parameter - START -->
				<input type="hidden" id="mnuConstructID" name="mnuConstructID" value="${params.mnuConstructID}" />
				<input type="hidden" id="mnuConstructName" name="mnuConstructName" value="${params.mnuConstructName}" />
				<input type="hidden" id="pmnuGrpID" name="pmnuGrpID" value="${params.pmnuGrpID}" />
				<input type="hidden" id="pmnuGrpName" name="pmnuGrpName" value="${params.pmnuGrpName}" />
				<input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}" />
				<input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}" />
				<input type="hidden" id="viewID" name="viewID" value="${params.viewID}" />
				<!-- Standard Information - END -->
			</td>
		</tr>
		<tr>
			<td height="240">
				<span id="grid"></span>
			</td>
		</tr>
		<tr>
			<td height="*">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="border:#e1dcbe solid 1px;">
                    <tr>
                        <td class="td-cond" width="260" height="1"><fmt:message key="CMP01007E.disagreeProgram" /></td>
                        <td class="td-input" width="25"></td>
                        <td class="td-cond" width="*"><fmt:message key="CMP01007E.agreeProgram" /></td>
                    </tr>
                    <tr>
                        <td class="td-input" height="*">
                        	<span id="disagreeList">
                        </td>
                        <td class="td-input" align="center" valign="middle">
                        	<img src="${contextPath}/images/ico/btn_arrow_right.gif" onclick="Add();" style="cursor:hand;" alt="<fmt:message key="button.Add" />"><br><br>
							<img src="${contextPath}/images/ico/btn_arrow_left.gif" onclick="Remove();" style="cursor:hand;" alt="<fmt:message key="button.Remove" />">
                        </td>
                        <td class="td-input">
                        	<span id="agreeList"></span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
	</table>
	<div id="tmp"></div>
</form>
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    #grid .aw-column-0 {width: 160px;}
    #grid .aw-column-1 {width: 160px;}
    #grid .aw-column-2 {width: 100px; text-align:center;}
    #grid .aw-column-3 {width: 100px; text-align:center;}
    #grid .aw-column-4 {width: 100px; text-align:center;}
    
    #disagreeList .aw-column-0 {width: 30px; text-align:center}
    #disagreeList .aw-column-1 {width: 120px;}
    #disagreeList .aw-column-2 {width: 145px;}
    
    #agreeList .aw-column-0 {width: 30px; text-align:center}
    #agreeList .aw-column-1 {width: 120px;}
    #agreeList .aw-column-2 {width: 135px;}
    #agreeList .aw-column-3 {width: 80px;}
    #agreeList .aw-column-4 {width: 80px;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">

    /****************************************
    * Variable
    ****************************************/
    var maxRow_agreeGrid = 0;
    var maxRow_disagreeGrid = 0;
    
	var WIDTH=600;
	var HEIGHT=300;
	var servlet = "${contextPath}/service/menuConstruct";
	
	/****************************************
	* Function
	****************************************/
	$(function() {
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {
		
		window.onload = function() {
			Search();
		};
	
	});
	
	// add function
	function Add() {
		var disagree_index = disagreeList.getRowIndices();
        if (disagree_index == ''){ //Grid 의 데이터와 DataSource 의 데이터가 갯수 및 위치가 동일할 때
            disagree_index = new Array();
            for (var i = 0; i < disagreeList.getRowCount(); i++){
                disagree_index[i] = i;
            }
        }
		
        for(var i=0; i < disagree_index.length; i++) {
            if (disagreeList.getCellValue(0,disagree_index[i])) {   // CheckBox : true 일때
				agreeList.addRow(maxRow_agreeGrid++);
				agreeList.setCellValue(false, 0, maxRow_agreeGrid-1);
				agreeList.setCellText(disagreeList.getCellText(1, disagree_index[i]),1, maxRow_agreeGrid-1);
				agreeList.setCellText(disagreeList.getCellText(2, disagree_index[i]),2, maxRow_agreeGrid-1);
				agreeList.setCellText("<input type='text' name='seqs' maxlength='5' style='border:#d6d6d6 1px solid; BACKGROUND-COLOR:#ffffff; height:18px; width:100%;font-size:12px;text-align:right;' onfocus='this.select()' value='0'>",3, maxRow_agreeGrid-1);
				agreeList.setCellText("<nis:selectbox id="useYNs" preset="aw" name="useYNs" category="USETYPE1CD" value="Y" />",4, maxRow_agreeGrid-1);
			}
		}
		
		for(var i=disagree_index.length-1; i >= 0; i--) {
            if (disagreeList.getCellValue(0,disagree_index[i])) {   // CheckBox : true 일때
                disagreeList.deleteRow(disagree_index[i]);
            }
        }
	}
	
	// remove function
	function Remove() {
	
		var agree_index = agreeList.getRowIndices();
        if (agree_index == ''){ //Grid 의 데이터와 DataSource 의 데이터가 갯수 및 위치가 동일할 때
            agree_index = new Array();
            for (var i = 0; i < agreeList.getRowCount(); i++){
                agree_index[i] = i;
            }
        }
        
        for(var i=0; i < agree_index.length; i++) {
            if (agreeList.getCellValue(0,agree_index[i])) { // CheckBox : true 일때
                disagreeList.addRow(maxRow_disagreeGrid++);
                disagreeList.setCellValue(false, 0, maxRow_disagreeGrid-1);
                disagreeList.setCellText(agreeList.getCellText(1, agree_index[i]),1, maxRow_disagreeGrid-1);
                disagreeList.setCellText(agreeList.getCellText(2, agree_index[i]),2, maxRow_disagreeGrid-1);
            }
        }
        
		for(var i=agree_index.length-1; i >= 0; i--) {
            if (agreeList.getCellValue(0,agree_index[i])) { // CheckBox : true 일때
                agreeList.deleteRow(agree_index[i]);
            }
        }
	}
	
	function Save() {
		document.all.tmp.innerHTML="";
		var agreeListIndices = agreeList.getRowIndices();
		
        if (agreeListIndices == '') {
            for(var i=0; i < agreeList.getRowCount(); i++) {
                if(agreeList.getCellText(1, i)!="") {
                    document.all.tmp.innerHTML+="<input type=\"hidden\" name=\"pgmIDs\" value=\""+agreeList.getCellText(1, i)+"\"/>";
                }
            }
        }
        else {
            for(var i=0; i < agreeListIndices.length; i++) {
                if(agreeList.getCellText(1, agreeListIndices[i])!="") {
                    document.all.tmp.innerHTML+="<input type=\"hidden\" name=\"pgmIDs\" value=\""+agreeList.getCellText(1, agreeListIndices[i])+"\"/>";
                }
            }
        }
            
		fnSubmitConfirm(form, servlet, "saveMenuConstructGroupProgram", "<fmt:message key="confirm.save" />");
	}
	
	// Menu Group Insert
	function Insert() {
		var param = "";
		param += "mnuGrpID=${params.mnuGrpID}";
		param += "&pgmID=${params.pgmID}";
		param += "&viewID=CMP01007F";
		param += "&mnuConstructID=${params.mnuConstructID}";
		param += "&mnuConstructName=${params.mnuConstructName}";
		param += "&pmnuGrpID=${params.pmnuGrpID}";
		param += "&pmnuGrpName=${params.pmnuGrpName}";
		newWindow(servlet+"/detailMenuConstructGroup/?"+param, "InsertMenuConstructGroup", WIDTH, HEIGHT, "no");
	}
	
	// Menu Group Delete
	function Delete() {
		if(grid.getSelectedRows().length>0) {
			document.all.tmp.innerHTML="";
			for(var i=0;i<grid.getSelectedRows().length;i++) {
				document.all.tmp.innerHTML+="<input type=\"hidden\" name=\"mnuGrpIDs\" value=\""+grid.getCellText(0, grid.getSelectedRows()[i])+"\"/>";
			}
			fnSubmitConfirm(form, servlet, "deleteListMenuConstructGroup", "<fmt:message key="confirm.delete" />");
		} else {
			alert("<fmt:message key="infos.selected" />");
		}
	}
	
	// Menu Group Detail Page Open
	function Detail(mnuGrpID) {
		var param = "";
		param += "mnuConstructID=${params.mnuConstructID}";
		param += "&mnuGrpID=${params.mnuGrpID}";
		param += "&pgmID=${params.pgmID}";
		param += "&viewID=CMP01007F";
		param += "&mnuGrpID2="+mnuGrpID;
		var queryString = "/detailMenuConstructGroup/?"+param;
		newWindow(servlet+queryString, mnuGrpID, WIDTH, HEIGHT, "no");
	}
	
	function Search() {
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0100702S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","mnuGrpID;mnuGrpName;seq;pmnuGrpID;URL;useYN;displayYN;");
	  	table.setParameter("mnuConstructID",document.form.mnuConstructID.value);
	  	table.setParameter("pmnuGrpID",document.form.pmnuGrpID.value);
	  	table.request();
      	
      	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (i=0; i < rowCount; i++) {
      			data[i] = [
      				table.getData(0,i),
      				table.getData(1,i),
      				table.getData(2,i),
      				table.getData(5,i),
      				table.getData(6,i)
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	}
      	
      	grid.refresh();
	}
	
	/*****************************************************
	*	Grid Setting
	*****************************************************/

	var columns = [
		"<fmt:message key="CMP01007E.mnuGrpID"/>",
		"<fmt:message key="CMP01007E.mnuGrpName"/>",
		"<fmt:message key="CMP01007E.seq"/>", 
		"<fmt:message key="CMP01007E.useYN"/>",
		"<fmt:message key="CMP01007E.displayYN"/>"
	];
	
	var grid = null;
    
	function createGrid() {

		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setSelectorVisible(true);
		grid.setSelectorWidth(40);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setSelectionMode("multi-row-marker");
		grid.setCellEditable(false);
		grid.setVirtualMode(false);
		grid.setHeaderText(columns);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setColumnCount(columns.length);
		grid.setCellFormat([str, str, str, str]);

		grid.onRowDoubleClicked = function(event, rowIndex){
			Detail(this.getCellText(0, rowIndex));
	    }
	    
		grid.onSelectedRowsChanged = function(){return true;}
	}
	
	// disagree_Grid
	var disagreeList = new AW.UI.Grid; 
	disagreeList.setId("disagreeList");
	disagreeList.setSelectionMode("single-row");
	disagreeList.setCellEditable(false);
	disagreeList.setVirtualMode(false);
	disagreeList.setCellTemplate(new AW.Templates.CheckBox, 0);
    disagreeList.setCellValue(false, 0);
    
    var disagreeColumns = [
        "",
        "<fmt:message key="CMP01007E.pgmID"/>",
        "<fmt:message key="CMP01007E.pgmName"/>"
    ];
    disagreeList.setHeaderText(disagreeColumns);
    for(var i=0;i<disagreeColumns.length;i++){disagreeList.getHeaderTemplate(i).setStyle("text-align", "center");}
    disagreeList.setColumnCount(disagreeColumns.length);
    
    var disagreeData = [
    <c:forEach items="${disagreeProgramList}" var="disagree" varStatus="status">
        [
            "",
            "${disagree.pgmID}",
            "${disagree.pgmName}"
        <c:choose>
        <c:when test="${status.last}">
            ]
        </c:when>
        <c:otherwise>
            ],
        </c:otherwise>
      </c:choose>
    </c:forEach>
    ];
    
    maxRow_disagreeGrid = disagreeData.length;
    
    disagreeList.setCellData(disagreeData);
    disagreeList.setRowCount(disagreeData.length);
    disagreeList.setCellFormat([str, str, str]);
    disagreeList.refresh();
    
	// agree_Grid
	var agreeList = new AW.UI.Grid; 
	agreeList.setId("agreeList");
	agreeList.setSelectionMode("single-row"); 
	agreeList.setSize(300,225);
	agreeList.setStyle("width", "100%");
	agreeList.setStyle("height", "100%");
	agreeList.setCellEditable(false);
	agreeList.setVirtualMode(false);
    agreeList.setCellTemplate(new AW.Templates.CheckBox, 0);
    agreeList.setCellValue(false, 0);
	
	var agreeListColumns = [
		"",
		"<fmt:message key="CMP01007E.pgmID"/>",
		"<fmt:message key="CMP01007E.pgmName"/>",
		"<fmt:message key="CMP01007E.seq"/>",
		"<fmt:message key="CMP01007E.useYN"/>"
	];
	agreeList.setHeaderText(agreeListColumns);
	for(var i=0;i<agreeListColumns.length;i++){agreeList.getHeaderTemplate(i).setStyle("text-align", "center");}
	agreeList.setColumnCount(agreeListColumns.length);

	var agreeData = [
	<c:forEach items="${agreeProgramList}" var="agree" varStatus="status">
		[
		    "",
			"${agree.pgmID}",
			"${agree.pgmName}",
			"<input type='text' name='seqs' maxlength='5' style='border:#d6d6d6 1px solid; BACKGROUND-COLOR:#ffffff; height:18px; width:100%;font-size:12px;text-align:right;' onfocus='this.select()' value='${agree.seq}'>",
			"<nis:selectbox id="useYNs" preset="aw" name="useYNs" category="USETYPE1CD" value="${agree.useYN}" />"
		<c:choose>
		<c:when test="${status.last}">
			]
		</c:when>
		<c:otherwise>
			],
		</c:otherwise>
	  </c:choose>
	</c:forEach>
	];
	
	maxRow_agreeGrid = agreeData.length;
	
	agreeList.setCellData(agreeData);
	agreeList.setRowCount(agreeData.length);
	agreeList.setCellFormat([str, str, str, html, html]);
	agreeList.refresh();

</script>