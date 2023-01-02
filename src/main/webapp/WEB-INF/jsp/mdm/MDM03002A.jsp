<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		<%@include file="../sys3/scripts.jsp" %>
	</head>

    <body class="yui-skin-sam" ${bodyConfig}>
    	<form name="form" method="post">
    		<div id="wrapDiv" class="pd-l">
          		<div id="formDiv">
		            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            	<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/functionbar.jsp" %>
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
													<col style="width:80px"></col>
													<col style="width:130px"></col>
													<col style="width:120px"></col>
													<col></col>
												</colgroup>
												<tbody>
					                            <tr>
													<td class="td-cond">
														<fmt:message key="MDM03002A.prdNm" />
													</td>	
													<td class="td-input">
														<input type="text" id="prdNm_S" name="prdNm_S" style="width:150px;">
					                                </td>
													<td class="td-cond">
														<fmt:message key="MDM03002A.activeYN" />
													</td>
													<td class="td-input">
														<nis:selectbox id="activeYN" defaultText="all" category="ACTIVEYN" />
					                                </td>
													<td class="td-cond">
														<fmt:message key="MDM03002A.guidAmtYN" />
													</td>
													<td class="td-input">
														<nis:selectbox id="guidAmtYN" defaultText="all" category="GUIDAMTYN" />
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
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
		                    		<tr>
					                    <td width="600px" height="*">
					                        <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
										  		<tr>
								                    <td height="*">
								                        <span id="grid"></span>
								                    </td>
								                </tr>
									  		</table>
								        </td>
					                    <td valign="top" style="padding-left:5px;" height="*">
					                    	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					                    		<tr>
					                    			<td height="1">
					                    				<table border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px; table-layout:fixed;">
								                            <colgroup>
																<col style="width:120px"></col>
																<col></col>
															</colgroup>
															<tbody>
								                            <tr>
								                            	<td class="td-cond-required">
									                           		<fmt:message key="MDM03002A.prdCD" />
								                         		</td>
								     							<td class="td-input">
								          							<input type="text" id="prdCD" class="input-readonly" style="width:100px;" readonly="readonly">
								      							</td>
								                            </tr>
								                            <tr>    
																<td class="td-cond">
																	<fmt:message key="MDM03002A.prdNm" />
																</td>	
																<td class="td-input">
																	<input type="text" id="prdNm" class="input-readonly" style="width:200px;" readonly="readonly"/>
								                                </td>
								                            </tr>
								                            <tr>
								                            	<td class="td-cond">
									                           		<fmt:message key="MDM03002A.qtyUnitCD" />
								      							</td>
								      		 					<td class="td-input">
								      		 						<nis:selectbox id="qtyUnitCD" style="width:100px;" defaultText="select" category="QTYUNITCD" />
									       						</td>
								                          	</tr>
								                            </tbody>
								                        </table>
								                    </td>
								                </tr>            
					                            <tr>
										          	<td height="1" style="padding-top:10px;">
										        		<table border="0" cellspacing="0" cellpadding="0" width="100%">                  		
										            		<tr>
										               			<td style="text-align:right;">
										                   			<script type="text/javascript">
												                      	var addRow = new AW.UI.Button;
												                      	addRow.setControlText("<fmt:message key="button.AddRow" />");
												                      	addRow.setControlImage("addRow");
												                      	document.write(addRow);
												                      
												                      	addRow.onControlClicked = function(event) {		 
												                          	grid_detail.addRow(maxRow_detail++);
												                          	grid_detail.setCellText("U",_col_dt.activeFlg,maxRow_detail-1);		                              
												                          	setCellFocus(grid_detail, _col_dt.overQty, maxRow_detail-1);
												                      	};
												                   	</script>
										               			</td>
										              		</tr>
										             	</table>
										            </td>
										        </tr>
										        <tr>
										            <td height="*">
										            	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
										            		<tr>
										            			<td>
										                			<span id="grid_detail"></span>
										                		</td>
										                	</tr>
										                </table>			
										            </td>
										        </tr>
					                        </table>
					                    </td>
					                </tr>
					            </table>
					        </td>            
		                </tr>
		            </table>
				</div>
				${appletDiv}
			</div>
        </form>
    </body>
</html>

<!-- grid format -->
<style type="text/css">
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

   	#grid .aw-column-0 {width: 100px; text-align:center;}
    #grid .aw-column-1 {width: 100px; text-align:center;}
    #grid .aw-column-2 {width: 150px; }
    #grid .aw-column-3 {width: 100px; text-align:center;}
    #grid .aw-column-4 {width: 100px; text-align:center;}
    
   	#grid_detail .aw-column-0 {width: 100px; text-align:right;}
    #grid_detail .aw-column-1 {width: 100px; text-align:right;}
    #grid_detail .aw-column-2 {width: 150px; text-align:right;}
    #grid_detail .aw-column-3 {width: 50px; text-align:center;}
    
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}

</style>

<script type="text/javascript">
	/****************************************
	* Variable
	****************************************/
	var maxRow_detail = 0;
	var currentOverQty = 0;
	var currentUnderQty = 0;
	var beforeOverQty = 0;
	var beforeUnderQty = 0;
	
	/****************************************
	* Function
	****************************************/
    $(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			try{$("#qtyUnitCD").addClass("input-readonly")}catch(e){}
			try{$("#qtyUnitCD").attr("disabled",true)}catch(e){}
			
			createGrid();
			grid.refresh();
			
			createGrid_detail();
			grid_detail.refresh();
			
		};

		${initScript}
		
	});
	
	//수량(이상)체크
	function getOverQtyCheck(row) {
		if(grid_detail.getCellText(_col_dt.activeFlg,row) != "D") {
			if(grid_detail.getCellText(_col_dt.overQty,row) == ""){
				currentOverQty = 0;
			} else {
				currentOverQty = grid_detail.getCellText(_col_dt.overQty,row);
			}
			
			if(grid_detail.getCellText(_col_dt.activeFlg,row-1) != "D") {
				
				if(grid_detail.getCellText(_col_dt.overQty,row-1) == ""){
					beforeOverQty = 0;
				} else {
					beforeOverQty = grid_detail.getCellText(_col_dt.overQty,row-1);
				}
				
				if(grid_detail.getCellText(_col_dt.underQty,row-1) == ""){
					beforeUnderQty = 0;
				} else {
					beforeUnderQty = grid_detail.getCellText(_col_dt.underQty,row-1);
				}
			}
			
			if(row != 0) {
				if(parseFloat(unformatNum(currentOverQty)) <= parseFloat(unformatNum(beforeOverQty)) || 
						parseFloat(unformatNum(currentOverQty)) < parseFloat(unformatNum(beforeUnderQty))){
					alert("<fmt:message key="MDM03002A.msg2"/>");
					grid_detail.setCellText('',_col_dt.overQty,row);
					return false;
				} 
			}
		}
	}
	
	//수량(미만)체크
	function getUnderQtyCheck(row) {
		if(grid_detail.getCellText(_col_dt.underQty,row) == ""){
			currentUnderQty = 0;
		} else {
			currentUnderQty = grid_detail.getCellText(_col_dt.underQty,row);
		}
		
		if(grid_detail.getCellText(_col_dt.overQty,row) == ""){
			currentOverQty = 0;
		} else {
			currentOverQty = grid_detail.getCellText(_col_dt.overQty,row);
		}
		
		if(grid_detail.getCellText(_col_dt.overQty,row-1) == ""){
			beforeOverQty = 0;
		} else {
			beforeOverQty = grid_detail.getCellText(_col_dt.overQty,row-1);
		}
		
		if(grid_detail.getCellText(_col_dt.underQty,row-1) == ""){
			beforeUnderQty = 0;
		} else {
			beforeUnderQty = grid_detail.getCellText(_col_dt.underQty,row-1);
		}
		if(parseFloat(unformatNum(currentUnderQty)) <= parseFloat(unformatNum(currentOverQty))){
			alert("<fmt:message key="MDM03002A.msg2"/>");
			grid_detail.setCellText('',_col_dt.underQty,row);
			return false;
		} 
	}
	
	function removeRow(row) {
		grid_detail.deleteRow(row);
        grid_detail.setCellText("D",_col_dt.activeFlg,row);
    }
	
	var _i_dt = 0;
	var _col_dt = {
		overQty : _i_dt++
		, underQty : _i_dt++
 		, guidAmt : _i_dt++
 		, deleteBtn : _i_dt++
 		, activeFlg : _i_dt++
	};
	
	function Detail(prdCD,prdNm,qtyUnitCD) {
		$("#prdCD").val(prdCD);
		$("#prdNm").val(prdNm);
		$("#qtyUnitCD").val(qtyUnitCD);
		
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/MDM0300202S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","overQty;underQty;guidAmt;deleteBtn;");
		table.setParameter("format","num;num;num;str;");								
        table.setParameter("prdCD",prdCD);
        table.request();
        
//         if (grid_detail != null) grid_detail.clear();
      	createGrid_detail();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
					table.getData(_col_dt.overQty,i),
					table.getData(_col_dt.underQty,i),
					table.getData(_col_dt.guidAmt,i),
					table.getData(_col_dt.deleteBtn,i),
					'U'
			  	];
      		}
      		grid_detail.setCellData(data);
      		grid_detail.setRowCount(rowCount);
      		
      	}
      	grid_detail.refresh();
      	
      	maxRow_detail = rowCount;
	}
	
</script>    
	
<script type="text/javascript">
	
	function New() {
		$("#prdCD").val("");
		$("#prdNm").val("");
		$("#qtyUnitCD").val("");
		
		createGrid_detail();
		grid_detail.refresh();
	}

    /****************************************
	* Button Action
	****************************************/
	
	var _i = 0;
	var _col = {
		prdCD : _i++
		, prdSAPCD : _i++
 		, prdNm : _i++
		, activeYNName : _i++
		, guidSeqNm : _i++
		, qtyUnitCD : _i++
	};
   
	function Search() {
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/MDM0300201S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","prdCD;prdSAPCD;prdNm;activeYNName;guidSeqNm;qtyUnitCD;");
		table.setParameter("format","str;str;str;str;str;str;num;");								
        table.setParameter("prdNm_S", $("#prdNm_S").val());
        table.setParameter("activeYN", $("#activeYN").val());
        table.setParameter("guidAmtYN", $("#guidAmtYN").val());
        table.request();
        
//         if (grid != null) grid.clear();
        createGrid();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	data[i] = [
                	table.getData(_col.prdCD,i),      
                   	table.getData(_col.prdSAPCD,i),            
                   	table.getData(_col.prdNm,i),            
                   	table.getData(_col.activeYNName,i),            
                   	table.getData(_col.guidSeqNm,i),         
                   	table.getData(_col.qtyUnitCD,i)       
            	];
            }
            grid.setCellData(data);
            grid.setRowCount(rowCount);
            
        }
        else {
      		message("<fmt:message key="info.nullData"/>");
      	}
        grid.refresh();
        
        New();
	}
    
    function Save() {
    	if ($("#prdCD").val() == ""){
	   		alert("<fmt:message key="MDM03002A.msg1" />");
	   		return false;
	   	}
    	
    	var overQty = new Array();
        var underQty = new Array();
        var guidAmt = new Array();
        var j=0;
        for (var i=0; i < maxRow_detail; i++) {
        	if(grid_detail.getCellText(_col_dt.activeFlg, i) != "D") {
				if (grid_detail.getCellText(_col_dt.overQty, i) == "") {alert("<fmt:message key="MDM03002A.msg7" />"); setCellFocus(grid_detail, _col_dt.overQty, i); return;}
				if (grid_detail.getCellText(_col_dt.underQty, i) == "") {alert("<fmt:message key="MDM03002A.msg8" />"); setCellFocus(grid_detail, _col_dt.underQty, i); return;}
				if (grid_detail.getCellText(_col_dt.guidAmt, i) == "") {alert("<fmt:message key="MDM03002A.msg9" />"); setCellFocus(grid_detail, _col_dt.guidAmt, i); return;}
			}
        	
        	if (grid_detail.getCellText(_col_dt.activeFlg,i) == "U") {
        		overQty[j] = unformat(grid_detail.getCellText(_col_dt.overQty,i));
        		underQty[j] = unformat(grid_detail.getCellText(_col_dt.underQty,i));
        		guidAmt[j] = unformat(grid_detail.getCellText(_col_dt.guidAmt,i));
           		j++;
           	}
        }
    	
    	var table = new AW.XML.Table;     
        table.setURL("${contextPath}/service/mdm03/savePrdGuidAmt");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("prdCD", $("#prdCD").val());
        table.setParameter("overQty", overQty);
        table.setParameter("underQty", underQty);
        table.setParameter("guidAmt", guidAmt);
		table.request();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
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
	*	Grid Setting
	*****************************************************/
    var grid = null;
    
	var columns = [
		"<fmt:message key="MDM03002A.prdCD"/>",
        "<fmt:message key="MDM03002A.prdSAPCD"/>",
        "<fmt:message key="MDM03002A.prdNm"/>",
        "<fmt:message key="MDM03002A.activeYN"/>",
        "<fmt:message key="MDM03002A.guidAmtYN"/>"
    ];
    
    function createGrid() {
    
	    grid = new AW.UI.Grid;
	    grid.setId("grid");
	    grid.setSize(400, 290);
	    grid.setRowCount(0);
	    grid.setHeaderHeight(20);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-row");
	    grid.setCellEditable(false);
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([str, str, str]);
	    
	    grid.onRowDoubleClicked = function(event, row) {
	    	Detail(this.getCellText(_col.prdCD,row),this.getCellText(_col.prdNm,row),this.getCellText(_col.qtyUnitCD,row));
	    };
    }
    
	var grid_detail = null;
    
	var columns_detail = [
		"<fmt:message key="MDM03002A.overQty"/>",
        "<fmt:message key="MDM03002A.underQty"/>",
        "<fmt:message key="MDM03002A.guidAmt"/>",
        "<fmt:message key="MDM03002A.deleteBtn"/>"
    ];
    
    function createGrid_detail() {
    
	    grid_detail = new AW.UI.Grid;
	    grid_detail.setId("grid_detail");
	    grid_detail.setSize(400, 290);
	    grid_detail.setRowCount(0);
	    grid_detail.setHeaderHeight(20);
	    grid_detail.setStyle("width","100%");
	    grid_detail.setStyle("height","100%");
	    grid_detail.setSelectorVisible(false);
	    grid_detail.setSelectionMode("single-cell");
	    grid_detail.setCellEditable(false);
	    grid_detail.setCellEditable(true, _col_dt.overQty);
	    grid_detail.setCellEditable(true, _col_dt.underQty);
	    grid_detail.setCellEditable(true, _col_dt.guidAmt);
	    grid_detail.setHeaderText(columns_detail);
	    for(var i=0;i<columns_detail.length;i++){grid_detail.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_detail.setColumnCount(columns_detail.length);
	    grid_detail.setCellFormat([str, str, str]);
		
		grid_detail.setCellImage("deleteGrid",_col_dt.deleteBtn);
	    var deleteFlag = new AW.Templates.Image;
	    var delImage = deleteFlag.getContent("box/image");
	    delImage.setTag("a");
	    delImage.setAttribute("href", function(){
	    	return "javascript:removeRow(grid_detail.getCurrentRow())";
	    });
		grid_detail.setCellTemplate(deleteFlag, _col_dt.deleteBtn);
		
	 	// Cell startEdit BEGIN
	    grid_detail.onCellSelectedChanged = function(selected, col, row) { 
	        if (selected) { 
	            this.setTimeout(function(){ 
	               this.raiseEvent("editCurrentCell", {}, col, row); 
	            }); 
	        } 
	    };
	      
	    grid_detail.onCellClicked = function(event, col, row) { 
	        if (this.getCellSelected(col, row)) { 
	            this.setTimeout(function(){
	               this.raiseEvent("editCurrentCell", {}, col, row); 
	           }); 
	        }
	    }; 
	    
	    grid_detail.onCellEditStarted = function(text, col, row){
	        if (col == _col_dt.overQty) {
	            this.setCellText(unformatNum(text), col, row);
	        }
	        if (col == _col_dt.underQty) {
	            this.setCellText(unformatNum(text), col, row);
	        }
	        if (col == _col_dt.guidAmt) {
	            this.setCellText(unformatNum(text), col, row);
	        }
	    };
	    
	    grid_detail.onCellEditEnded = function(text, col, row){
	    	this.setCellText(text, col, row);
	    };
	 	// Cell startEdit END
	      
	    //  BEGIN validating (Enter, Cell LoseFocus)
	 	
	    
	    grid_detail.onCellValidating = function(text, col, row) {
	    	if (col == _col_dt.overQty) {
	    		if(unformat(text).length > 5) {
	    			alert('<fmt:message key="MDM03002A.msg5" />');
					this.setCellText(text.substring(0,5),col,row);
				}
	    		if (!isNumber(text)) {
				    alert('<fmt:message key="error.format" />');
				    this.setCellText("",col,row);
				}
	           	else if (parseFloat(text) < 0) {
					alert('<fmt:message key="MDM03002A.msg4" />');
					this.setCellText("",col,row);
				}
	    		getOverQtyCheck(row);
	        }
	    	if (col == _col_dt.underQty) { 
	    		if(text == "" || text == null) {
	    			this.setCellFocus(grid_detail, col, row);
	    			return;
	    		}
	    		if(unformat(text).length > 5) {
	    			alert('<fmt:message key="MDM03002A.msg5" />');
					this.setCellText(text.substring(0,5),col,row);
				}
	    		if (!isNumber(text)) {
				    alert('<fmt:message key="error.format" />');
				    this.setCellText("",col,row);
				}
	           	else if (parseFloat(text) < 0) {
					alert('<fmt:message key="MDM03002A.msg4" />');
					this.setCellText("",col,row);
				}
	    		getUnderQtyCheck(row);
	        }
	    	if (col == _col_dt.guidAmt) { 
	    		if(unformat(text).length > 13) {
	    			alert('<fmt:message key="MDM03002A.msg6" />');
					this.setCellText(text.substring(0,13),col,row);
				}
	    		if (!isNumber(text)) {
				    alert('<fmt:message key="error.format" />');
				    this.setCellText("",col,row);
				}
	           	else if (parseFloat(text) < 0) {
					alert('<fmt:message key="error.noMinusNum" />');
					this.setCellText("",col,row);
				}
	        }
           	this.setCellText("U",_col_dt.activeFlg,row);
	    };
	
	
	    grid_detail.onCellValidated = function(text, col, row){
	    	if (col == _col_dt.overQty) {
	            this.setCellText(formatNum(text), col, row);
	        }
	    	if (col == _col_dt.underQty) {
	            this.setCellText(formatNum(text), col, row);
	        }
	    	if (col == _col_dt.guidAmt) {
	            this.setCellText(formatNum(text), col, row);
	        }
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
	    
	    grid_detail.onHeaderClicked = function(){
  			return true;
  		};
    }
    
</script>   
