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
        <div id="wrapDiv">
        	<div id="formDiv">
	            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
	                <tr>
	                    <td height="1"> 
							<%@include file="../cms/standardParam.jsp" %>
							<input type="hidden" id="currentPgmID" name="currentPgmID">
				            <input type="hidden" id="uniqueYN" name="uniqueYN" value="N"> 
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
													<fmt:message key="CMP01006A.searchWord" />
												</td>
												<td class="td-input">
													<input type="text" id="searchWord" name="searchWord" style="width:200px;" onkeypress="if (event.keyCode==13){Search(); return false;}">
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
	                    <td height="1">
				            <div id="tabs" class="yui-navset" style="margin-top: 5px;">
				                <ul class="yui-nav">
				                    <li class="selected"><a href="#tab1" onclick="changeTab(1)"><em><fmt:message key="CMP01006A.basic"/></em></a></li>
				                    <li><a href="#tab2" onclick="changeTab(2)"><em><fmt:message key="CMP01006A.view"/></em></a></li>
				                </ul>            
				                <div class="yui-content">
				                    <div id="tab1">
				                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
				                        	<colgroup>
				                        		<col style="width:90px"></col>
				                        		<col style="width:200px"></col>
												<col style="width:90px"></col>
												<col style="width:150px"></col>
												<col style="width:100px"></col>
												<col></col>
							        		</colgroup>
							        		<tbody>
				                            <tr>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01006A.pgmID" />
				                                </td>
				                                <td class="td-input">
				                                    <input type="text" id="pgmIDs" name="pgmIDs" style="width:100px;">
				                                    <div id="overLap"></div>
				                                </td>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01006A.pgmName" />
				                                </td>
				                                <td class="td-input">
				                                    <input type="text" id="pgmName" name="pgmName" style="width:140px" >
				                                </td>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01006A.pgmUrl" />
				                                </td>
				                                <td class="td-input">
				                                    <input type="text" id="pgmURL" name="pgmURL" style="width:180px; ime-mode: disabled;"> 
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01006A.remark" />
				                                </td>
				                                <td class="td-input" colspan="3">
				                                    <input type="text" id="remark" name="remark" style="width:400px" >
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01006A.openWindowYN" />
				                                </td>
				                                <td class="td-input">
				                                    <input type="checkbox" id="openWindowYN" name="openWindowYN" class="checkbox">
				                                </td>
				                            </tr>
				                            </tbody>
				                        </table>
				                    </div>
				                    <div id="tab2">
				                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
				                            <tr>
				                                <td class="td-cond" width="350"><fmt:message key="CMP01006A.disagreeView" /></td>
				                                <td class="td-input" width="25"></td>
				                                <td class="td-cond" width="*"><fmt:message key="CMP01006A.agreeView" /></td>
				                            </tr>
				                            <tr>
				                                <td class="td-input" height="190"><span id="grid_disagree"></span></td>
				                                <td class="td-input" align="center" valign="middle">
				                                	<img src="${contextPath}/images/ico/btn_arrow_right.gif" onclick="Add();" style="cursor:hand;" alt="<fmt:message key="button.Add" />"><br><br>
				                                    <img src="${contextPath}/images/ico/btn_arrow_left.gif" onclick="Remove();" style="cursor:hand;" alt="<fmt:message key="button.Remove" />">
				                                </td>
				                                <td class="td-input">
				                                    <span id="grid_agree"></span>
				                                </td>
				                            </tr>
				                        </table>
				                    </div>
				                </div>
				            </div>
				            <script type="text/javascript">
				                var tabView = new YAHOO.widget.TabView('tabs');
				            </script>
	                    </td>
	                </tr>
	            </table>
	        </div>
			${appletDiv}
		</div>
    </body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    #grid .aw-column-0 {width: 160px;}
    #grid .aw-column-1 {width: 210px;}
    #grid .aw-column-2 {width: 400px;}
    #grid .aw-column-3 {width: 130px;}
    
    #grid_disagree .aw-column-0 {width: 30px; text-align:center}
    #grid_disagree .aw-column-1 {width: 150px;}
    #grid_disagree .aw-column-2 {width: 150px;}
    
    #grid_agree .aw-column-0 {width: 30px; text-align:center}
    #grid_agree .aw-column-1 {width: 150px;}
    #grid_agree .aw-column-2 {width: 150px;}
    #grid_agree .aw-column-3 {width: 80px; text-align:center;}
    #grid_agree .aw-column-4 {width: 150px;}
    

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">

    /****************************************
    * Variable
    ****************************************/
    var maxRow_agree = 0;
    var maxRow_disagree = 0;
    var tab = 1;
    
    /****************************************
	* Function
	****************************************/
	$(function() {
		$("#pgmIDs").alphanumeric();
	});
    
	$(document).ready(function() {
		
		window.onload = function() {
			createGrid();
			grid.refresh();
			New();
		};
		
		${initScript}
		
		$("#pgmIDs").change(function() {
			// 프로그램ID 가 처음 입력한 것과 다른 경우 중복확인여부 초기화
	        if ($("#viewIDs").val() != $("#currentPgmID").val()) {
	            $("#uniqueYN").val('N');
	        }
		});
		
	});
    
    /****************************************
    * Button Action
    ****************************************/
    function changeTab(i) {
        tab = i;
        
        if (tab == 2) {
        	grid_disagree.refresh();
        	grid_agree.refresh();
        } 
    }

    
    //중복확인 버튼 생성
     var overLap = new AW.UI.Button;
     overLap.setId("overLap");
     overLap.setControlText("<fmt:message key="button.Overlap"/>");
     overLap.refresh();
      
     overLap.onControlClicked = function(event){
        
        if ($("#pgmIDs").val() == '') {
            alert('<fmt:message key="CMP01006A.msg1"/>');
            return;
        }
         
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0100601S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("pgmIDs", $("#pgmIDs").val());
        table.request();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            if (table.getData(0,0) != '0') {
                $("uniqueYN").val('N');
                alert('<fmt:message key="CMP01006A.msg2"/>');
                $("#pgmIDs").val('');
                $("#pgmIDs").focus();
            }
            else {
                $("#uniqueYN").val('Y');
                $("#currentPgmID").val($("#pgmIDs").val());
                alert('<fmt:message key="CMP01006A.msg3"/>');
                $("#pgmName").focus();
            }
        }
        else {
            $("#uniqueYN").val('N');
            alert('<fmt:message key="CMP01006A.msg4"/>');
        }
     }

    function Add() {
        var disagree_index = grid_disagree.getRowIndices();
        if (disagree_index == ''){ //Grid 의 데이터와 DataSource 의 데이터가 갯수 및 위치가 동일할 때
            disagree_index = new Array();
            for (var i = 0; i < grid_disagree.getRowCount(); i++){
                disagree_index[i] = i;
            }
        }
            
        for(var i=0; i < disagree_index.length; i++) {
            if (grid_disagree.getCellValue(0,disagree_index[i])) {   // CheckBox : true 일때
                grid_agree.addRow(maxRow_agree++);
                grid_agree.setCellValue(false, 0, maxRow_agree-1);
                grid_agree.setCellText(grid_disagree.getCellText(1, disagree_index[i]),1, maxRow_agree-1);
                grid_agree.setCellText(grid_disagree.getCellText(2, disagree_index[i]),2, maxRow_agree-1);
                grid_agree.setCellText(grid_disagree.getCellText(3, disagree_index[i]),3, maxRow_agree-1);
                grid_agree.setCellText("",4, maxRow_agree-1);
                grid_agree.setCellText("U",5, maxRow_agree-1);
            }
        }
        
        for(var i=disagree_index.length-1; i >= 0; i--) {
            if (grid_disagree.getCellValue(0,disagree_index[i])) {   // CheckBox : true 일때
                grid_disagree.deleteRow(disagree_index[i]);
            }
        }
    }
    
    function Remove() {
        
        var agree_index = grid_agree.getRowIndices();
        if (agree_index == ''){ //Grid 의 데이터와 DataSource 의 데이터가 갯수 및 위치가 동일할 때
            agree_index = new Array();
            for (var i = 0; i < grid_agree.getRowCount(); i++){
                agree_index[i] = i;
            }
        }
            
        for(var i=0; i < agree_index.length; i++) {
            if (grid_agree.getCellValue(0,agree_index[i])) { // CheckBox : true 일때
                grid_disagree.addRow(maxRow_disagree++);
                grid_disagree.setCellValue(false, 0, maxRow_disagree-1);
                grid_disagree.setCellText(grid_agree.getCellText(1, agree_index[i]),1, maxRow_disagree-1);
                grid_disagree.setCellText(grid_agree.getCellText(2, agree_index[i]),2, maxRow_disagree-1);
            }
        }
        
        for(var i=agree_index.length-1; i >= 0; i--) {
            if (grid_agree.getCellValue(0,agree_index[i])) { // CheckBox : true 일때
                grid_agree.deleteRow(agree_index[i]);
                grid_agree.setCellText("D",5,agree_index[i]);
            }
        }
    }    
</script>

<script type="text/javascript">

	function Search() {

		var table = new AW.XML.Table;
	    table.setURL("${contextPath}/service/simpleAction/CMP0100602S");
	    table.setAsync(false);
	    table.setRequestMethod("POST");
	    table.setParameter("outParamKey", "pgmID;pgmName;pgmURL;remark;openWindowYN;");
	    table.setParameter("searchWord", $("#searchWord").val());
	    table.request();
	    
	    if (grid != null) grid.clear();
	    createGrid();
	    
	    var rowCount = table.getCount();
	    if (rowCount > 0) {
	        var data = new Array();
	        for (var i=0; i < rowCount; i++) {
	            data[i] = [
	                table.getData(0,i), //pgmID
	                table.getData(1,i), //pgmName
	                table.getData(2,i), //pgmURL
	                table.getData(3,i),  //remark
	                table.getData(4,i)	//openWindowYN
	            ];
	        }
	        
	        grid.setCellData(data);
	        grid.setRowCount(rowCount);
	    }
	    grid.refresh();
	}


    function New(){
        
        overLap.setStyle("visibility","visible");
        document.getElementById("pgmIDs").className = '';
        document.getElementById("pgmIDs").readOnly = false;
        $("#uniqueYN").val("N");
        
        $("#pgmIDs").val("");
        $("#pgmName").val("");
        $("#pgmURL").val("");
        $("#remark").val("");
        $("#openWindowYN").attr("checked",false);
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0100603S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","viewID;viewName;");
        table.setParameter("pgmIDs", $("#pgmIDs").val());
        table.request();
        
        if (grid_disagree != null) grid_disagree.clear();
        createGrid_disagree();
        
        maxRow_disagree = 0;
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
                data[i] = [
                    "",
                    table.getData(0,i),  //viewID
                    table.getData(1,i)   //viewName
                ];
            }

            grid_disagree.setCellData(data);
            grid_disagree.setRowCount(rowCount);
            
            maxRow_disagree = rowCount;
        }

        if (grid_agree != null) grid_agree.clear();
        createGrid_agree();
        maxRow_agree = 0;
        
        if (tab == 2) {
        	grid_disagree.refresh();
        	grid_agree.refresh();
        }
    }
    
    function Save() {
    	
        if ($("#uniqueYN").val() == 'N'){
            alert('<fmt:message key="CMP01006A.msg5"/>');
            return;
        }

        var openWindowYN = "N";
        if ($("#openWindowYN").is(":checked")) {
            openWindowYN = "Y";
        }

        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/program/saveProgram");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("pgmIDs", $("#pgmIDs").val());
        table.setParameter("pgmName", $("#pgmName").val());
        table.setParameter("pgmURL", $("#pgmURL").val());
        table.setParameter("remark", $("#remark").val());
        table.setParameter("useYN", "Y");
        table.setParameter("openWindowYN", openWindowYN);
        
        var viewID = new Array();
        var introYN = new Array();
        var viewTitle = new Array();
        
        var j=0;
        for (var i=0; i < maxRow_agree; i++) {
            if (grid_agree.getCellText(5,i) != 'D') {
                viewID[j] = grid_agree.getCellText(1,i);
                introYN[j] = grid_agree.getCellValue(3,i)?"Y":"N";
                viewTitle[j] = grid_agree.getCellText(4,i);
                j++;
            }        
        }
        
        table.setParameter("viewID", viewID);
        table.setParameter("introYN", introYN);
        table.setParameter("viewTitle", viewTitle);
        table.request();
        
        if (table.getData(0,0) == 'S') {
            message(table.getData(1,0));
            
            overLap.setStyle("visibility","hidden");
            document.getElementById("pgmIDs").className = 'input-readonly';
            document.getElementById("pgmIDs").readOnly = true;
            $("#uniqueYN").val('Y');

            Search();
        }
        else {
           alert(table.getData(1,0));
        }
    }
    
    function Delete() {
    	
        if (confirm("<fmt:message key="confirm.delete"/>")) {
            
            var table = new AW.XML.Table;
            table.setURL("${contextPath}/service/program/removeProgram");
            table.setAsync(false);
            table.setRequestMethod("POST");
            table.setParameter("pgmIDs", $("#pgmIDs").val());
            table.request();
            
            if (table.getData(0,0) == 'S') {
                message(table.getData(1,0));
                Search();
                New();
            }
            else {
               alert(table.getData(1,0));
            }
        }
    }
        
    
</script>

<script type="text/javascript">

    /*****************************************************
    *   Grid Setting
    *****************************************************/
    var grid = null;
    
    var columns = [
        "<fmt:message key="CMP01006A.pgmID"/>",
        "<fmt:message key="CMP01006A.pgmName"/>",
        "<fmt:message key="CMP01006A.pgmUrl"/>",
        "<fmt:message key="CMP01006A.remark"/>"
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
        grid.setCellFormat([str, str, str, str]);
        
        grid.onRowDoubleClicked = function(event, row){

            overLap.setStyle("visibility","hidden");
            document.getElementById("pgmIDs").className = 'input-readonly';
            document.getElementById("pgmIDs").readOnly = true;
            $("#uniqueYN").val('Y');
            
            $("#pgmIDs").val(this.getCellText(0,row));
            $("#pgmName").val(this.getCellText(1,row));
            $("#pgmURL").val(this.getCellData(2,row));
            $("#remark").val(this.getCellText(3,row));
            if (this.getCellText(4,row) == "Y") {
                $("#openWindowYN").attr("checked",true);
            }
            else {
            	$("#openWindowYN").attr("checked",false);
            }

            var table = new AW.XML.Table;
            table.setURL("${contextPath}/service/simpleAction/CMP0100603S");
            table.setAsync(false);
            table.setRequestMethod("POST");
            table.setParameter("outParamKey","viewID;viewName;");
            table.setParameter("pgmIDs", this.getCellText(0,row));
            table.request();
            
            if (grid_disagree != null) grid_disagree.clear();
	        createGrid_disagree();
            
            maxRow_disagree = 0;
            var rowCount = table.getCount();
            if (rowCount > 0) {
                var data = new Array();
                for (var i=0; i < rowCount; i++) {
                    data[i] = [
                        "",
                        table.getData(0,i),  //viewID
                        table.getData(1,i)   //viewName
                    ];
                }
                
                grid_disagree.setCellData(data);
                grid_disagree.setRowCount(rowCount);
                
                maxRow_disagree = rowCount;
            }
    
            var table = new AW.XML.Table;
            table.setURL("${contextPath}/service/simpleAction/CMP0100604S");
            table.setAsync(false);
            table.setRequestMethod("POST");
            table.setParameter("outParamKey","viewID;viewName;introYN;viewTitle;");
            table.setParameter("pgmIDs",this.getCellText(0,row));
            table.request();
            
            if (grid_agree != null) grid_agree.clear();
	        createGrid_agree();
            
            maxRow_agree = 0;
            var rowCount = table.getCount();
            if (rowCount > 0) {
                var data = new Array();
                for (var i=0; i < rowCount; i++) {
                    data[i] = [
                        "",
                        table.getData(0,i),  //viewID
                        table.getData(1,i),  //viewName
                        "",  //introYN
                        table.getData(3,i),  //viewTitle
                        "U"
                    ];
                }
                
                grid_agree.setCellData(data);
                grid_agree.setRowCount(rowCount);
                
                for (var i=0; i < data.length; i++) {
                    if (table.getData(2,i) == 'Y') {
                        grid_agree.setCellValue(true,3,i);
                    }
                    else {
                        grid_agree.setCellValue(false,3,i);
                    }
                }
                
                maxRow_agree = rowCount;
            }
            
            if (tab == 2) {
	        	grid_disagree.refresh();
	        	grid_agree.refresh();
			}
        };
    }
    
    
    // disagree_Grid
    var grid_disagree = null;
    
    var disagreeColumns = [
        "",
        "<fmt:message key="CMP01006A.viewID"/>",
        "<fmt:message key="CMP01006A.viewName"/>"
    ];
    
    function createGrid_disagree(){
    
        grid_disagree = new AW.UI.Grid; 
        grid_disagree.setId("grid_disagree");
        grid_disagree.setVirtualMode(false);
        grid_disagree.setSelectionMode("single-row");
        grid_disagree.setCellValue(false, 0);
        for(var i=0;i<disagreeColumns.length;i++){grid_disagree.getHeaderTemplate(i).setStyle("text-align", "center");}
        grid_disagree.setHeaderText(disagreeColumns);
        grid_disagree.setColumnCount(disagreeColumns.length);
        grid_disagree.setCellFormat([str, str, str]);
        grid_disagree.setCellEditable(false);
        
        grid_disagree.setCellTemplate(new AW.Templates.CheckBox, 0);
        grid_disagree.setCellValue(false,0);
    }
    
    
    // agree_Grid
    var grid_agree = null;
    
    var agreeColumns = [
        "",
        "<fmt:message key="CMP01006A.viewID"/>",
        "<fmt:message key="CMP01006A.viewName"/>", 
        "<fmt:message key="CMP01006A.introYN"/>", 
        "<fmt:message key="CMP01006A.viewTitle"/>"  
    ];
    
    function createGrid_agree() {
    
        grid_agree = new AW.UI.Grid; 
        grid_agree.setId("grid_agree");
        grid_agree.setVirtualMode(false);
        grid_agree.setSelectionMode("single-cell");
        grid_agree.setCellValue(false, 0);
        for(var i=0;i<agreeColumns.length;i++){grid_agree.getHeaderTemplate(i).setStyle("text-align", "center");}
        grid_agree.setHeaderText(agreeColumns);
        grid_agree.setColumnCount(agreeColumns.length);
        grid_agree.setCellFormat([str, str, str, str, str]);
        grid_agree.setCellEditable(false);
        grid_agree.setCellEditable(true,4);
                
        grid_agree.setCellTemplate(new AW.Templates.CheckBox, 0);
        grid_agree.setCellTemplate(new AW.Templates.CheckBox, 3);
        
        grid_agree.onCellValueChanged = function (value, col, row) {
            if (col == 3 && value)
            {
                for (var i=0; i < maxRow_agree; i++)
                {
                    if (i != row) {
                        grid_agree.setCellValue(false, 3, i);
                    }
                }
            }  
        };
        
        // Cell startEdit BEGIN
        grid_agree.onCellSelectedChanged = function(selected, col, row) { 
            if (selected) { 
                this.setTimeout(function(){ 
                   this.raiseEvent("editCurrentCell", {}, col, row); 
                }); 
            } 
        };
        
        grid_agree.onCellClicked = function(event, col, row) { 
            if (this.getCellSelected(col, row)) { 
                this.setTimeout(function(){ 
                   this.raiseEvent("editCurrentCell", {}, col, row); 
               }); 
            }
        }; 
        
        grid_agree.onCellEditEnded = function(text, col, row){
	    	this.setCellText(text, col, row);
	    };
        // Cell startEdit END
        
    }     
</script>