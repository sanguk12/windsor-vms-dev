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
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            	<tr>
                    <td height="1">
			            <%@include file="../cms/standardParam.jsp" %>
						<%@include file="../cms/functionbar.jsp" %>
						<%@include file="../cms/calendar.jsp" %>
					</td>
				</tr>
                <tr>
                    <td height="40%">
                        <span id="grid"></span>
                    </td>
                </tr>
                <tr>
                	<td height="1" style="text-align:right;">
                		<script type="text/javascript">
							var btn_addRow = new AW.UI.Button;
							btn_addRow.setControlText("<fmt:message key="button.Add" />");
							document.write(btn_addRow);
							
							btn_addRow.onClick = function(){
								if($("#notify_code").val()=="") {
									alert("<fmt:message key="CMP04001A.msg1" />");
									return;
								}
								grid_auth.addRow(maxRow_auth++);
								grid_auth.setCellText("I", _col_auth.activeFlg, maxRow_auth-1);
							}
							
							var btn_save = new AW.UI.Button;
							btn_save.setControlText("<fmt:message key="button.Save" />");
							document.write(btn_save);
							
							btn_save.onClick = function(){
								if($("#notify_code").val()=="") {
									alert("<fmt:message key="CMP04001A.msg1" />");
									return;
								}
								Save();
							}
						</script>
                	</td>
                </tr>
                <tr>
                	<td height="1">             
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
											<col style="width:80px"></col>
											<col style="width:200px"></col>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond-required"><fmt:message key="CMP04001A.notify_name" />
												</td>
												<td class="td-input">
													<input type="text" id="notify_name" name="notify_name" style="width:150px;">
												</td>
												<td class="td-cond-required"><fmt:message key="CMP04001A.post_period" />
												</td>
												<td class="td-input">
													<input type="text" id="post_period" name="post_period" style="width:100px;"><fmt:message key="CMP04001A.day" />
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
                        <span id="grid_auth"></span>
                    </td>
                </tr>
                <tr>
                	<td height="1">
                		<input type="hidden" id="notify_code" name="notify_code" />
                	</td>
                </tr>
            </table>
        </form>
    </body>
</html>

<!-- grid format -->
<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

    #grid .aw-column-0 {width: 150px; text-align:center;}
    #grid .aw-column-1 {width: 400px; }
    #grid .aw-column-2 {width: 100px; text-align:right;}
    
    #grid_auth .aw-column-0 {width: 150px; }
    #grid_auth .aw-column-1 {width: 150px; }
    #grid_auth .aw-column-2 {width: 50px; text-align:center;}
        
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script type="text/javascript">

	/****************************************
	 * Variable
	 ****************************************/
	var maxRow_auth = 0;
	
	/****************************************
	* Function
	****************************************/
	
    $(function() {
    	$("#post_period").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			createGrid();
			grid.refresh();
			
			createGrid_auth();
			grid_auth.refresh();
		};

		${initScript}
		
		$("#post_period").blur(function(){
			if(parseInt($("#post_period").val())>8) {
				alert("<fmt:message key="CMP04001A.msg2" />");
				$("#post_period").val("7");
			}
		});
	});
	
	function removeRow(row) {
        grid_auth.deleteRow(row);
        grid_auth.setCellText("D",_col_auth.activeFlg,row);
    }

</script>    

<script type="text/javascript">


    /****************************************
	* Button Action
	****************************************/
   
	function Search() {
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP04001A01S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey",
        		"notify_name;receipt_name;post_period;notify_code;");
        table.setParameter("format",
        		"str;str;str;str;");
        table.request();
        
//         if (grid != null) grid.clear();
        createGrid();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	data[i] = [
                	table.getData(0,i)
                   	, table.getData(1,i)
                   	, table.getData(2,i)
                   	, table.getData(3,i)
            	];
            }
            grid.setCellData(data);
            grid.setRowCount(rowCount);
        }
        grid.refresh();
        
	}
    
    var _i=0;
    var _col_auth = {
    	"receipt_division_name" : _i++
    	, "receipt_name" : _i++
    	, "del" : _i++
    	, "receipt_division" : _i++
    	, "receipt" : _i++
    	, "org_receipt_division" : _i++
    	, "org_receipt" : _i++
    	, "activeFlg" : _i++
    };
	function DetailSearch() {
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP04001A02S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey",
        		"receipt_division_name;receipt_name;receipt_division;receipt;org_receipt_division;org_receipt;");
        table.setParameter("format",
        		"str;str;str;str;str;str;");
	  	table.setParameter("notify_code", $("#notify_code").val());
        table.request();
        
//         if (grid_auth != null) grid_auth.clear();
        createGrid_auth();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	data[i] = [
                	table.getData(0,i)
                   	, table.getData(1,i)
                   	, ""
                   	, table.getData(2,i)
                   	, table.getData(3,i)
                   	, table.getData(4,i)
                   	, table.getData(5,i)
                   	, "U"
            	];
            }
            grid_auth.setCellData(data);
            grid_auth.setRowCount(rowCount);
        }
        grid_auth.refresh();
        
        maxRow_auth = rowCount;
	}
    
	function Save() {
		if($("#notify_name").val() == "") {
   			alert("<fmt:message key="CMP04001A.msg5" />");
   			$("#notify_name").focus();
   			return;
   		}
		if($("#post_period").val() == "") {
   			alert("<fmt:message key="CMP04001A.msg6" />");
   			$("#post_period").focus();
   			return;
   		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/notify/saveNotify_Master");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("notify_code", $("#notify_code").val());
	  	table.setParameter("notify_name", $("#notify_name").val());
	  	table.setParameter("post_period", $("#post_period").val());
	  	
		var receipt_divisions = new Array();
		var receipts = new Array();
		var org_receipt_divisions = new Array();
		var org_receipts = new Array();
		var activeFlgs = new Array();
		var j=0;
		for(var i=0; i<maxRow_auth; i++) {
			if(grid_auth.getCellText(_col_auth.activeFlg, i)!="D") {
				if (grid_auth.getCellText(_col_auth.receipt_division, i) == "") {alert("<fmt:message key="CMP04001A.msg3" />"); setCellFocus(grid_auth, _col.receipt_division, i); return;}
				if (grid_auth.getCellText(_col_auth.receipt, i) == "") {alert("<fmt:message key="CMP04001A.msg4" />"); setCellFocus(grid_auth, _col.receipt, i); return;}
			}
			receipt_divisions[j] = grid_auth.getCellText(_col_auth.receipt_division, i);
			receipts[j] = grid_auth.getCellText(_col_auth.receipt, i);
			org_receipt_divisions[j] = grid_auth.getCellText(_col_auth.org_receipt_division, i);
			org_receipts[j] = grid_auth.getCellText(_col_auth.org_receipt, i);
			activeFlgs[j] = grid_auth.getCellText(_col_auth.activeFlg, i);
			j++;
		}
        table.setParameter("receipt_divisions", receipt_divisions);
        table.setParameter("receipts", receipts);
        table.setParameter("org_receipt_divisions", org_receipt_divisions);
        table.setParameter("org_receipts", org_receipts);
        table.setParameter("activeFlgs", activeFlgs);
        table.request();
        
		var rowCount = table.getCount();
		if (rowCount > 0) {
			if (table.getData(0,0) == "S") {
				message(table.getData(1,0));
				Search();
				DetailSearch();
			}
			else {
				alert(table.getData(1,0));
			}
		}
	}
</script>   

<script type="text/javascript">


	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var grid = null;
	var columns = [
		"<fmt:message key="CMP04001A.div" />"
		, "<fmt:message key="CMP04001A.setup" />"
		, "<fmt:message key="CMP04001A.post_period" />"
	];
	function createGrid() {
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setCellFormat([str, str, str]);
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setHeaderHeight(20);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setSelectionMode("single-cell");
		grid.setStyle("width","100%");
		grid.setStyle("height","100%");
		grid.setCellEditable(false);
	    
	    grid.onRowDoubleClicked = function(event, row) {
	    	$("#notify_name").val(this.getCellText(0, row));
	    	$("#post_period").val(this.getCellText(2, row));
	    	$("#notify_code").val(this.getCellText(3, row));
	    	
	    	DetailSearch();
	    };
    }
	
	var grid_auth = null;
	var columns_auth = [
		"<fmt:message key="CMP04001A.receipt_division_name" />"
		, "<fmt:message key="CMP04001A.receipt_name" />"
		, "<fmt:message key="CMP04001A.del" />"
	];
	function createGrid_auth() {
		grid_auth = new AW.UI.Grid;
		grid_auth.setId("grid_auth");
		grid_auth.setCellFormat([str, str, str]);
		grid_auth.setHeaderText(columns_auth);
		grid_auth.setRowCount(0);
		grid_auth.setColumnCount(columns_auth.length);
		grid_auth.setHeaderHeight(20);
		for(var i=0;i<columns_auth.length;i++){grid_auth.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid_auth.setSelectionMode("single-cell");
		grid_auth.setStyle("width","100%");
		grid_auth.setStyle("height","100%");
		grid_auth.setCellEditable(false);
		
		grid_auth.setCellImage("deleteGrid",_col_auth.del);
	    var deleteFlag = new AW.Templates.Image;
	    var delImage = deleteFlag.getContent("box/image");
	    delImage.setTag("a");
	    delImage.setAttribute("href", function(){
	    	return "javascript:removeRow(grid_auth.getCurrentRow())";
	    });
	    grid_auth.setCellTemplate(deleteFlag, _col_auth.del);
	    
		grid_auth.setCellTemplate(new AW.Templates.Combo, _col_auth.receipt_division_name);
		grid_auth.setCellTemplate(new AW.Templates.Combo, _col_auth.receipt_name);
	    
		grid_auth.setPopupTemplate(function(col, row) {
			
			if (col == _col_auth.receipt_division_name) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","RECEIPT_DIVISION");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","150px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         	
	            list.onItemMouseDown = function(event, i) {
	            	try {
		            	AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid_auth.setCellText(text, col, row);  
			            grid_auth.setCellText(value[i], _col_auth.receipt_division, row);
			            grid_auth.setCellText("", _col_auth.receipt_name, row);
						grid_auth.setCellText("", _col_auth.receipt, row);
	            	}
	            	catch(e){}
	            };
	             
			}
			else if (col == _col_auth.receipt_name) {
	        	var table = new AW.XML.Table;
	        	if(grid_auth.getCellText(_col_auth.receipt_division, row) == "01") {
	        		table.setURL("${contextPath}/service/simpleAction/CMP04001A03S");
		        	table.setAsync(false);
		        	table.setRequestMethod("POST");
		            table.setParameter("outParamKey","user_no;userName;");
	        	}
	        	else if(grid_auth.getCellText(_col_auth.receipt_division, row) == "02") {
	        		table.setURL("${contextPath}/service/simpleAction/CMP04001A04S");
		        	table.setAsync(false);
		        	table.setRequestMethod("POST");
		            table.setParameter("outParamKey","classID;className;");
	        	}
	        	else if(grid_auth.getCellText(_col_auth.receipt_division, row) == "03") {
	        		table.setURL("${contextPath}/service/simpleAction/CMP04001A05S");
		        	table.setAsync(false);
		        	table.setRequestMethod("POST");
		            table.setParameter("outParamKey","grpID;grpName;");
	        	}
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","150px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid_auth.setCellText(text, col, row);  
			            grid_auth.setCellText(value[i], _col_auth.receipt, row);
			            
	            		//전체리스트가 두개 이상인경우 인원을 중복 선택 못하게 한다.
	    				if(maxRow_auth > 1){
	    					for(var j=0; j<maxRow_auth; j++){
	    						if(grid_auth.getCellText(_col_auth.activeFlg, j)!="D"){
	    							//자신의 row를 뺀 나머지
	    							if(j!=row){
	    								if(
	    										(grid_auth.getCellText(_col_auth.receipt_division, row) == grid_auth.getCellText(_col_auth.receipt_division, j)) &&
	    										(grid_auth.getCellText(_col_auth.receipt, row) == grid_auth.getCellText(_col_auth.receipt, j))
	    								){
	    									grid_auth.setCellText("", _col_auth.receipt_name, row);
	    									grid_auth.setCellText("", _col_auth.receipt, row);
											AW.$popup.hidePopup();
											return;
	   									}
	    							}
	    						}
	    					}
	    				}
	            		
	            	}
	            	catch(e){}
	            };
			} 
            return list;
        });
    }
    
</script>