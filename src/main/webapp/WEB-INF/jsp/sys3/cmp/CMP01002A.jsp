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
		          								            
							<input type="hidden" id="currentViewID" name="currentViewID">
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
													<fmt:message key="CMP01002A.searchWord" />
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
				                    <li class="selected"><a href="#tab1" onclick="changeTab(1)"><em><fmt:message key="CMP01002A.basic"/></em></a></li>
				                    <li><a href="#tab2" onclick="changeTab(2)"><em><fmt:message key="CMP01002A.function"/></em></a></li>
				                </ul>            
				                <div class="yui-content">
				                    <div id="tab1">
				                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
				                        	<colgroup>
				                        		<col style="width:80px"></col>
				                        		<col style="width:200px"></col>
												<col style="width:110px"></col>
												<col style="width:180px"></col>
												<col style="width:80px"></col>
												<col></col>
							        		</colgroup>
							        		<tbody>
				                            <tr>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01002A.viewID" />
				                                </td>
				                                <td class="td-input">
				                                    <input type="text" id="viewIDs" name="viewIDs" style="width:100px;">
				                                    <div id="overLap"></div>
				                                </td>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01002A.viewName" />
				                                </td>
				                                <td class="td-input">
				                                    <input type="text" id="viewName" name="viewName" style="width:130px" > 
				                                </td>
				                                <td class="td-cond-required">
				                                	<fmt:message key="CMP01002A.viewUrl" />
				                                </td>
				                                <td class="td-input">
				                                    <input type="text" id="viewURL" name="viewURL" style="width:160px; ime-mode: disabled;"> 
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
				                            		<fmt:message key="CMP01002A.appPositionCD" />
				                            	</td>
				                                <td class="td-input">
				                                    <nis:selectbox id="_appPositionCD" name="_appPositionCD" defaultText="select" category="APPPOSITIONCD" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01002A.appDisRate" />
				                                </td>
				                                <td class="td-input" >
				                                    <input type="text" id="_appDisRate" name="_appDisRate" style="width:60px; text-align:right;">
				                                    <nis:selectbox id="_appDisUnitCD" defaultText="select" category="APPDISUNITCD" event="" eventproc="" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="CMP01002A.useYN" />
				                                </td>
				                                <td class="td-input">
				                                    <nis:radio id="useYN" name="useYN" category="USETYPE2CD" value="Y" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
				                            		<fmt:message key="CMP01002A.remark" />
				                            	</td>
			                            		<td class="td-input" colspan="5">
			                            			<input type="text" id="remark" name="remark" style="width:600px" >
			                           			</td>
				                            </tr>
				                            </tbody>
				                        </table>
				                    </div>
				                    <div id="tab2">
				                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
				                            <tr>
				                                <td class="td-cond" width="320"><fmt:message key="CMP01002A.disagreeFunction" /></td>
				                                <td class="td-input" width="25"></td>
				                                <td class="td-cond" width="*"><fmt:message key="CMP01002A.agreeFunction" /></td>
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
    #grid .aw-column-1 {width: 200px;}
    #grid .aw-column-2 {width: 320px;}
    #grid .aw-column-3 {width: 80px; text-align:center;}
    
    #grid_disagree .aw-column-0 {width: 30px; text-align:center}
    #grid_disagree .aw-column-1 {width: 100px;}
    #grid_disagree .aw-column-2 {width: 100px;}
    #grid_disagree .aw-column-3 {width: 70px; text-align:right}
    
    #grid_agree .aw-column-0 {width: 30px; text-align:center}
    #grid_agree .aw-column-1 {width: 100px;}
    #grid_agree .aw-column-2 {width: 100px;}
    #grid_agree .aw-column-3 {width: 70px; text-align:right;}
    #grid_agree .aw-column-4 {width: 100px;}
    #grid_agree .aw-column-5 {width: 120px;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
-->
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
		$("#viewIDs").alphanumeric();
		$("#_appDisRate").numeric();
	});
    
	$(document).ready(function() {
		
		window.onload = function() {
			createGrid();
			grid.refresh();
			New();
		};
		
		${initScript}
		
		$("#viewIDs").change(function() {
			// 뷰ID 가 처음 입력한 것과 다른 경우 중복확인여부 초기화
	        if ($("#viewIDs").val() != $("#currentViewID").val()) {
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
        
        if ($("#viewIDs").val() == '') {
            alert('<fmt:message key="CMP01002A.msg1"/>');
            return;
        }
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0100201S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("viewID", $("#viewIDs").val());
        table.request();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            if (table.getData(0,0) != '0') {
                $("#uniqueYN").val('N');
                alert('<fmt:message key="CMP01002A.msg2"/>');
                $("#viewIDs").val('');
                $("#viewIDs").focus();
            }
            else {
                $("#uniqueYN").val('Y');
                $("#currentViewID").val($("#viewIDs").val());
                alert('<fmt:message key="CMP01002A.msg3"/>');
                $("#viewName").focus();
            }
        }
        else {
            $("#uniqueYN").val('N');
            alert('<fmt:message key="CMP01002A.msg4"/>');
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
                grid_agree.setCellText(grid_disagree.getCellText(5, disagree_index[i]),5, maxRow_agree-1);
                grid_agree.setCellText(grid_disagree.getCellText(4, disagree_index[i]),6, maxRow_agree-1);
                grid_agree.setCellText("U",7, maxRow_agree-1);
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
                grid_disagree.setCellText(grid_agree.getCellText(3, agree_index[i]),3, maxRow_disagree-1);
                grid_disagree.setCellText(grid_agree.getCellText(6, agree_index[i]),4, maxRow_disagree-1);
                grid_disagree.setCellText(grid_agree.getCellText(5, agree_index[i]),5, maxRow_disagree-1);
            }
        }
        
        for(var i=agree_index.length-1; i >= 0; i--) {
            if (grid_agree.getCellValue(0,agree_index[i])) { // CheckBox : true 일때
                grid_agree.deleteRow(agree_index[i]);
                grid_agree.setCellText("D",7,agree_index[i]);
            }
        }
    }    
</script>

<script type="text/javascript">

    function New() {
    	
        overLap.setStyle("visibility","visible");
        document.getElementById("viewIDs").className = '';
        document.getElementById("viewIDs").readOnly = false;
        $("#uniqueYN").val("N");
        
        $("#viewIDs").val("");
        $("#viewName").val("");
        $("#viewURL").val("");
        setRadioValue("useYN","Y");
        $("#remark").val("");
        
        $("#_appPositionCD").val("");
        $("#_appDisRate").val("0");
        $("#_appDisUnitCD").val("");
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0100202S");
        table.setAsync(false);
        table.setRequestMethod("POST");
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
                    table.getData(1,i),  //funcCode
                    table.getData(2,i),  //funcName
                    table.getData(3,i),  //seq
                    table.getData(0,i),  //funcID
                    table.getData(4,i)   //command
                ];
            }
            
            grid_disagree.setCellData(data);
            grid_disagree.setRowCount(rowCount);
            
            maxRow_disagree = rowCount;
        }

        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0100203S");
        table.setAsync(false);
        table.setRequestMethod("POST");
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
                    table.getData(1,i),  //funcCode
                    table.getData(2,i),  //funcName
                    table.getData(3,i),  //seq
                    table.getData(4,i),  //pfuncCode
                    table.getData(5,i),  //command
                    table.getData(0,i),   //funcID
                    "U"
                ];
            }
            
            grid_agree.setCellData(data);
            grid_agree.setRowCount(rowCount);
            
            maxRow_agree = rowCount;
        }
        
        if (tab == 2) {
        	grid_disagree.refresh();
        	grid_agree.refresh();
        }        
    }
    
    function Save() {
    	
        if ($("#uniqueYN").val() == 'N') {
            alert('<fmt:message key="CMP01002A.msg5"/>');
            return;
        }
        
        var funcID = new Array();
        var seq = new Array();
        var pfuncCode = new Array();
        var command = new Array();
        
        var j=0;
        for (var i=0; i < maxRow_agree; i++)
        {
            if (grid_agree.getCellText(7,i) != 'D')
            {
	            funcID[j] = grid_agree.getCellText(6,i);
	            seq[j] = grid_agree.getCellText(3,i);
	            pfuncCode[j] = grid_agree.getCellText(4,i);
	            command[j] = grid_agree.getCellText(5,i);
	            j++;
            }        
        }
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/view/saveView");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("viewID", $("#viewIDs").val());
        table.setParameter("viewName", $("#viewName").val());
        table.setParameter("viewURL", $("#viewURL").val());
        table.setParameter("useYN", getRadioValue("useYN"));
        table.setParameter("remark", document.getElementById("remark").value);
        table.setParameter("appPositionCD", $("#_appPositionCD").val());
        table.setParameter("appDisRate", unformatNum($("#_appDisRate").val()));
        table.setParameter("appDisUnitCD", $("#_appDisUnitCD").val());
        table.setParameter("funcID", funcID);
        table.setParameter("seq", seq);
        table.setParameter("pfuncCode", pfuncCode);
        table.setParameter("command", command);
        table.request();
        
        if (table.getData(0,0) == 'S') {
            message(table.getData(1,0));
            
            overLap.setStyle("visibility","hidden");
            document.getElementById("viewIDs").className = 'input-readonly';
            document.getElementById("viewIDs").readOnly = true;
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
            table.setURL("${contextPath}/service/view/removeView");
            table.setAsync(false);
            table.setRequestMethod("POST");
            table.setParameter("viewID", $("#viewIDs").val());
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
    	
	function Search() {
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0100204S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("searchWord", $("#searchWord").val());
      	table.request();
      	
      	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
      				table.getData(0,i), //viewID
      				table.getData(1,i), //viewName
      				table.getData(2,i), //viewURL
      				table.getData(4,i), //useYNDesc
      				table.getData(5,i), //useYN
      				table.getData(3,i),  //remark
      				table.getData(6,i),  //appPositionCD
      				table.getData(7,i),  //appDisRate
      				table.getData(8,i)  //appDisUnitCD
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
</script>

<script type="text/javascript">
 
	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var grid = null;
	
	var columns = [
		"<fmt:message key="CMP01002A.viewID"/>",
		"<fmt:message key="CMP01002A.viewName"/>",
		"<fmt:message key="CMP01002A.viewUrl"/>",
		"<fmt:message key="CMP01002A.useYN"/>"
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
            document.getElementById("viewIDs").className = 'input-readonly';
            document.getElementById("viewIDs").readOnly = true;
            $("#uniqueYN").val('Y');
            
            $("#viewIDs").val(this.getCellText(0,row));
            $("#viewName").val(this.getCellText(1,row));
            $("#viewURL").val(this.getCellData(2,row));
            setRadioValue("useYN", this.getCellText(4,row));
            $("#remark").val(this.getCellText(5,row));
            
            $("#_appPositionCD").val(this.getCellText(6,row));
            $("#_appDisRate").val(formatNum(this.getCellText(7,row)));
            $("#_appDisUnitCD").val(this.getCellText(8,row));

	        var table = new AW.XML.Table;
	        table.setURL("${contextPath}/service/simpleAction/CMP0100205S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("viewID",this.getCellText(0,row));
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
	                    table.getData(1,i),  //funcCode
	                    table.getData(2,i),  //funcName
	                    table.getData(3,i),  //seq
	                    table.getData(0,i),  //funcID
	                    table.getData(4,i)   //command
	                ];
	            }
	            
	            grid_disagree.setCellData(data);
	            grid_disagree.setRowCount(rowCount);
	            
	            maxRow_disagree = rowCount;
	        }
	
	        var table = new AW.XML.Table;
	        table.setURL("${contextPath}/service/simpleAction/CMP0100206S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("viewID",this.getCellText(0,row));
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
	                    table.getData(1,i),  //funcCode
	                    table.getData(2,i),  //funcName
	                    table.getData(3,i),  //seq
	                    table.getData(4,i),  //pfuncCode
	                    table.getData(5,i),  //command
	                    table.getData(0,i),  //funcID
	                    "U"
	                ];
	            }
	            
	            grid_agree.setCellData(data);
	            grid_agree.setRowCount(rowCount);
	            
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
        "<fmt:message key="CMP01002A.funcCode"/>",
        "<fmt:message key="CMP01002A.funcName"/>",
        "<fmt:message key="CMP01002A.seq"/>"
    ];
    
    function createGrid_disagree(){
    
        grid_disagree = new AW.UI.Grid; 
	    grid_disagree.setId("grid_disagree");
	    grid_disagree.setVirtualMode(false);
	    grid_disagree.setSelectionMode("single-row");
	    grid_disagree.setCellValue(false, 0);
	    grid_disagree.setHeaderText(disagreeColumns);
	    for(var i=0;i<disagreeColumns.length;i++){grid_disagree.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_disagree.setColumnCount(disagreeColumns.length);
	    grid_disagree.setCellFormat([str, str, str, str]);
	    grid_disagree.setCellEditable(false);
	    
	    grid_disagree.setCellTemplate(new AW.Templates.CheckBox, 0);
        grid_disagree.setCellValue(false,0);
    }


    
    // agree_Grid
    var grid_agree = null;
    
    var agreeColumns = [
        "",
        "<fmt:message key="CMP01002A.funcCode"/>",
        "<fmt:message key="CMP01002A.funcName"/>",
        "<fmt:message key="CMP01002A.seq"/>",
        "<fmt:message key="CMP01002A.parentFunctionCode"/>",
        "<fmt:message key="CMP01002A.command"/>" 
    ];
    
    function createGrid_agree() {
    
	    grid_agree = new AW.UI.Grid; 
	    grid_agree.setId("grid_agree");
	    grid_agree.setVirtualMode(false);
	    grid_agree.setSelectionMode("single-cell");
	    grid_agree.setCellValue(false, 0);
		grid_agree.setHeaderText(agreeColumns);
		for(var i=0;i<agreeColumns.length;i++){grid_agree.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_agree.setColumnCount(agreeColumns.length);
        grid_agree.setCellFormat([str, str, str, str, str, str]);
    	grid_agree.setCellEditable(false);
    	grid_agree.setCellEditable(true,3);
    	grid_agree.setCellEditable(true,4);
    	grid_agree.setCellEditable(true,5);
    	        
        grid_agree.setCellTemplate(new AW.Templates.CheckBox, 0);
        
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