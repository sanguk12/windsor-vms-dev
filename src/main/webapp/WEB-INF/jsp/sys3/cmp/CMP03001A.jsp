<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../scripts.jsp" %>
		<script type="text/javascript">
			function keyCheck() {
			    if(event.keyCode == 120) { //F9
			        Execute();
			    }
			    else if (event.keyCode == 118) { //F7
			        if (h_i == -1) {
			            h_i = max_i;
			        }
			        
			        if (h_i == 0) {
			            h_i = max_i+1;
			        }
			        
			        document.getElementById("sql").value = query_h[--h_i];
			    }
			    else if (event.keyCode == 119) { //F8
			        if (h_i == -1) {
			            h_i = max_i - 1;
			        }
			    
			        if (h_i == max_i) {
			            h_i = -1;
			        }

			         document.getElementById("sql").value = query_h[++h_i];
                }
			}
		</script>
    </head>

    <body onkeydown="keyCheck()" class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1">
						<!-- Standard Parameter - START -->
						<input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
						<input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
						<input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
						<input type="hidden" id="method" name="method">
						<!-- Standard Information - END -->
						
						<!-- Function Bar - Title & Button -->
						<%@include file="../cms/functionbar.jsp" %>
					</td>
				</tr>
                <tr>
                    <td class="pd" height="1">
                    	<table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
						        	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
			                            <tr>
			                                <td class="td-cond" width="*">
			                                    <fmt:message key="sqlStatement" /> (F9 - Run Query, F7 - 이전 Query 불러오기, F8 - 이후 Query 불러오기))
			                                </td>
			                                <td class="td-cond" width="330">Columns</td>
			                            </tr>
			                            <tr>
			                                <td class="td-input">
			                                    <textarea id="sql" name="sql" style="width:100%; height:200px; font-family:courier;"></textarea>
			                                </td>
			                                <td class="td-input">
			                                    <span id="gridPK"></span>
			                                </td>
			                            </tr>
                        			</table>
                        		</td>
                        	</tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="pd" height="*">	
			 			<span id="grid"></span>
			 		</td>
			 	</tr>
			 	<tr>
			 		<td class="pd" height="1">
			 			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
			 				<tr>
				                <td class="td-cond" width="100">Upload Excel File</td>
				                <td class="td-input" width="*">
				                	<input type="file" id="inputFile" name="inputFile" size="40" onkeydown="event.returnValue=false;" class="form-input">
			 			        </td>
			 			    </tr>
			 			</table>
					</td>			 			    
 			    </tr>
 			    <tr>
                    <td height="5">
                    	<input type="hidden" id="dataType" name="dataType"> 
                    </td>
                </tr>
 			</table>
		</form>
	</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    #gridPK .aw-column-0 {width: 150px; }
    #gridPK .aw-column-1 {width: 50px; text-align: center;}
    #gridPK .aw-column-2 {width: 100px;}
    
    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}

//-->
</style>

<script type="text/javascript">

    var query_h = new Array();
    var max_i = -1;
    var h_i = -1;
<!--
    function Execute(){
        showLoading();
        var table = new AW.XML.Table;
        table.setURL("datamanager.do");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("method","runQuery");
        table.setParameter("sql", document.getElementById("sql").value);
        table.request();
        
        createGridPK();
        
        var rowCount = table.getCount();
        if (rowCount > 1) {
        
            // 성공한 Query History 에 저정
            query_h[++max_i] = document.getElementById("sql").value;
        
            var status = table.getData(0,0).split(";"); //0:결과코드, 1:결과메세지, 2:컬럼갯수
            
            if (status[0] == 'S') {
            
	            var columns = new Array();
	            var PKData = new Array();
	
	            for (var i=0; i < parseFloat(status[2]); i++){
	                columns[i] = table.getData(i,1);
	                PKData[i] = [
	                                table.getData(i,1),
	                                "",
	                                "String"
	                            ];
	            }
	            
	            createGrid(columns);
	            
	            gridPK.setCellData(PKData);
	            gridPK.setRowCount(PKData.length);
	            gridPK.refresh();
	            
	            var j=0;
	            var data = new Array();
	            for (var i=2; i < rowCount; i++){
	                var columnData = new Array();
		            for (var k=0; k < parseFloat(status[2]); k++){
		                columnData[k] = table.getData(k,i);
		            }
	                data[j] = columnData;
	                j++;
	            }
	            
	            grid.setCellData(data);
	            grid.setRowCount(data.length);
	            grid.refresh();
	            message(status[1]);
	            hideLoading();
	        }
	        else {
		        createGrid(header);
	            grid.refresh();
	            gridPK.refresh();
	            hideLoading();
	            alert(status[1]);
	        }
        }
        else if (rowCount == 1 && table.getData(0,0) == 'E') {
            createGrid(header);
            grid.refresh();
            gridPK.refresh();
            hideLoading();
            alert(table.getData(1,0));
        }
        else {
            createGrid(header);
            grid.refresh();
            gridPK.refresh();
            hideLoading();
            message('<fmt:message key="info.nullData"/>');
        }       
    }
    
    function Excel() {
        if (grid.getRowCount() == 0) {
            alert("파일 출력할 데이터가 없습니다.");
            return;
        }
        document.form.action = "datamanager.do";
        document.form.target = "_self";
        document.getElementById("method").value = "downloadExcel";
        var dataType = "";
        for(var i=0; i < gridPK.getRowCount(); i++){
            if (gridPK.getCellText(2,i) == 'String'){
                dataType = dataType + 's;';
            }
            else if (gridPK.getCellText(2,i) == 'Number') {
                dataType = dataType + 'n;';
            }
        }
        document.getElementById("dataType").value = dataType;
        document.form.submit();
    }
    
    function ExcelUpload(){
        document.form.action = "datamanager.do";
        document.form.target = "_self";
        document.getElementById("method").value = "uploadExcel";
        document.form.submit();
    }
        
    function Save(){alert("개발중이니까 기다리삼...");}
//-->
</script>

<script type="text/javascript">

    /*****************************************************
    *   define grid / data formats define
    *****************************************************/
    var grid = null;
    var header = [
        "","","","","","","","","","","","","","","","","","","",""
    ];
    
    function createGrid(columns) {
    
        grid = new AW.UI.Grid;
        grid.setId("grid");
        grid.setRowHeight(20);
        grid.setSelectorVisible(true);
        grid.setSelectionMode("single-cell");
        grid.setCellEditable(true);
        grid.setHeaderHeight(20);
        grid.setHeaderText(columns);
        grid.setColumnCount(columns.length);
        grid.setStyle("width", "100%");
        grid.setStyle("height", "100%");
    }
    
    createGrid(header);
    grid.refresh();
    
    var gridPK = null;
    var columnsPK = [
        "Column","PK","Type"
    ];
    
    function createGridPK() {
    
        gridPK = new AW.UI.Grid;
        
        gridPK.setId("gridPK");
        gridPK.setSelectorVisible(true);
        gridPK.setSelectionMode("single-cell");
        gridPK.setCellEditable(false);
        gridPK.setHeaderHeight(20);
        gridPK.setHeaderText(columnsPK);
        gridPK.setColumnCount(columnsPK.length);
        gridPK.setSize(200,200);
        gridPK.setStyle("width", "100%");
        gridPK.setStyle("height", "100%");
        
        gridPK.setCellTemplate(new AW.Templates.CheckBox,1);
        gridPK.setCellTemplate(new AW.Templates.Combo,2);
        
        var text = new Array();
        text[0] = "String";
        text[1] = "Number";
                
        gridPK.setPopupTemplate(function(col, row){
            var list = new AW.UI.List;
            if (col == 2)
            {
                list.setStyle("width","100px");
                list.setStyle("height","40px");
                list.setItemText(text);
                list.setItemCount(text.length);
                
                list.onItemMouseDown = function(event, i)
                {
                    var text = this.getItemText(i);  
                    gridPK.setCellText(text, col, row);  
                    gridPK.setCellValue(text, col, row);
                    gridPK.getCellTemplate(col, row).hidePopup();  
                }
                return list;
            }
         });
    }
    
    createGridPK();
    gridPK.refresh();
    
</script>
<script type="text/javascript">
<!--
    <c:if test="${!empty params.initAction}">
        ${params.initAction}();
    </c:if>
//-->
</script>