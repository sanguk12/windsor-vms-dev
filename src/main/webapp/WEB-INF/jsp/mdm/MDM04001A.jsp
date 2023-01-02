<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		<%@include file="../sys3/scripts.jsp" %>
		<%@include file="../sys3/cms/calendar.jsp" %>
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
													<col style="width:100px"></col>
													<col style="width:150px"></col>
													<col style="width:120px"></col>
													<col></col>
												</colgroup>
												<tbody>
					                            <tr>
													<td class="td-cond-required">
														<fmt:message key="MDM04001A.yearCD" />
													</td>
													<td class="td-input">
														<nis:selectbox id="yearCD_S" defaultText="none" category="YEARCD" style="width:100px;" />
					                                </td>
													<td class="td-cond">
														<fmt:message key="MDM04001A.planResultTpCD" />
													</td>
													<td class="td-input">
														<nis:selectbox id="planResultTpCD_S" defaultText="all" category="PLANRESULTTPCD" />
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
		                	<td>
		                    	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
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
									                          	grid.addRow(maxRow++);
									                          	grid.setCellText("U",_col.activeFlg,maxRow-1);		                              
									                          	grid.setCellText($("#yearCD_S").val(),_col.eventYear,maxRow-1);		                              
									                          	grid.setCellText($("#yearCD_S").val(),_col.yearCD,maxRow-1);		
									                          	
									                          	var table = new AW.XML.Table;
									            	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
									            	        	table.setAsync(false);
									            	        	table.setRequestMethod("POST");
									            	            table.setParameter("outParamKey","comCode;codeName;");
									            	            table.setParameter("codeDiv","MONTHCD");
									            	            table.setParameter("comCode","${params.clientDate}".substring(4,6));
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
									            	            grid.setCellText(value[0], _col.monthCD, maxRow-1); 
									            	            grid.setCellText(text[0], _col.eventMonth, maxRow-1); 
									                          	setCellFocus(grid, _col.planResultTpCD, maxRow-1);
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
							                			<span id="grid"></span>
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

   	.aw-column-0 {width: 100px; text-align:center;}
    .aw-column-1 {width: 120px; }
    .aw-column-2 {width: 150px; }
    .aw-column-3 {width: 150px; }
    .aw-column-4 {width: 150px; }
    .aw-column-5 {width: 50px; text-align:center;}
    
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}

</style>

<script type="text/javascript">
	/****************************************
	* Variable
	****************************************/
	var maxRow = 0;
	
	/****************************************
	* Function
	****************************************/
    $(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			createGrid();
			grid.refresh();
			
		};

		${initScript}
		
	});
	
	function getRegDateCheck() {
		var row = grid.getCurrentRow(); 
		if(grid.getCellText(_col.regDateFrom,row)=="" || grid.getCellText(_col.regDateTo,row)=="") {
			return;
		}
		
		if(unformat(grid.getCellText(_col.regDateFrom,row)) > unformat(grid.getCellText(_col.regDateTo,row))){
			alert("<fmt:message key="MDM04001A.msg1" />");
			grid.setCellText(grid.getCellText(_col.regDateFrom, row), _col.regDateTo, row);
			setCellFocus(grid, _col.regDateTo, row);
			return false;
		}
	}
	
	function removeRow(row) {
		grid.deleteRow(row);
        grid.setCellText("D",_col.activeFlg,row);
    }
	
</script>    
	
<script type="text/javascript">


    /****************************************
	* Button Action
	****************************************/
	
	var _i = 0;
	var _col = {
		eventYear : _i++
		, eventMonth : _i++
		, planResultTpCDName : _i++	
 		, regDateFrom : _i++
 		, regDateTo : _i++
 		, deleteBtn : _i++
		, yearCD : _i++
		, monthCD : _i++
		, planResultTpCD : _i++
		, eventSeq : _i++
		, activeFlg : _i++
	};
   
	function Search() {
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/MDM0400101S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","eventYear;eventMonth;planResultTpCDName;regDateFrom;regDateTo;"+
        								"deleteBtn;yearCD;monthCD;planResultTpCD;eventSeq;");
		table.setParameter("format","str;str;str;date;date;"+
									"str;str;str;str;num;");								
        table.setParameter("yearCD", $("#yearCD_S").val());
        table.setParameter("planResultTpCD", $("#planResultTpCD_S").val());
        table.request();
        
//         if (grid != null) grid.clear();
        createGrid();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	data[i] = [
                	table.getData(_col.eventYear,i),      
                   	table.getData(_col.eventMonth,i),         
                   	table.getData(_col.planResultTpCDName,i),       
                   	table.getData(_col.regDateFrom,i),       
                   	table.getData(_col.regDateTo,i),       
                   	table.getData(_col.deleteBtn,i),    
                	table.getData(_col.yearCD,i),     
                   	table.getData(_col.monthCD,i),         
                   	table.getData(_col.planResultTpCD,i),  
                   	table.getData(_col.eventSeq,i),  
                   	'U'      
            	];
            }
            grid.setCellData(data);
            grid.setRowCount(rowCount);
            
        } else {
      		message("<fmt:message key="info.nullData"/>");
      	}
        grid.refresh();
        
        maxRow = rowCount;
	}
    
    function Save() {
    	var table = new AW.XML.Table;     
        table.setURL("${contextPath}/service/mdm04/saveEventRegDate");
        table.setAsync(false);
        table.setRequestMethod("POST");
        var yearCD = new Array();
        var eventYM = new Array();
        var planResultTpCD = new Array();
        var regDateFrom = new Array();
        var regDateTo = new Array();
        var eventSeq = new Array();
        var activeFlg = new Array();
        var j=0;
        for (var i=0; i < maxRow; i++) {
        	if(grid.getCellText(_col.activeFlg, i)!="D") {
				if (grid.getCellText(_col.yearCD, i) == "") {alert("<fmt:message key="MDM04001A.msg2" />"); setCellFocus(grid, _col.yearCD, i); return;}
				if (grid.getCellText(_col.monthCD, i) == "") {alert("<fmt:message key="MDM04001A.msg3" />"); setCellFocus(grid, _col.monthCD, i); return;}
				if (grid.getCellText(_col.planResultTpCD, i) == "") {alert("<fmt:message key="MDM04001A.msg4" />"); setCellFocus(grid, _col.planResultTpCDName, i); return;}
				if (grid.getCellText(_col.regDateFrom, i) == "") {alert("<fmt:message key="MDM04001A.msg5" />"); setCellFocus(grid, _col.regDateFrom, i); return;}
				if (grid.getCellText(_col.regDateTo, i) == "") {alert("<fmt:message key="MDM04001A.msg6" />"); setCellFocus(grid, _col.regDateTo, i); return;}
			}
       		yearCD[j] = grid.getCellText(_col.yearCD,i);
       		eventYM[j] = grid.getCellText(_col.yearCD,i)+grid.getCellText(_col.monthCD,i);
       		planResultTpCD[j] = grid.getCellText(_col.planResultTpCD,i);
       		regDateFrom[j] = unformat(grid.getCellText(_col.regDateFrom,i));
       		regDateTo[j] = unformat(grid.getCellText(_col.regDateTo,i));
       		eventSeq[j] = unformat(grid.getCellText(_col.eventSeq,i));
       		activeFlg[j] = grid.getCellText(_col.activeFlg,i);
       		j++;
        }
        table.setParameter("yearCD", yearCD);
        table.setParameter("eventYM", eventYM);
        table.setParameter("planResultTpCD", planResultTpCD);
        table.setParameter("regDateFrom", regDateFrom);
        table.setParameter("regDateTo", regDateTo);
        table.setParameter("eventSeq", eventSeq);
        table.setParameter("activeFlg", activeFlg);
		table.request();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            if (table.getData(0,0) == 'S') {
                message(table.getData(1,0));
				Search();
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
		"<fmt:message key="MDM04001A.yearCD"/>",
		"<fmt:message key="MDM04001A.monthCD"/>",
        "<fmt:message key="MDM04001A.planResultTpCD"/>",
        "<fmt:message key="MDM04001A.regDateFrom"/>",
        "<fmt:message key="MDM04001A.regDateTo"/>",
        "<fmt:message key="MDM04001A.deleteBtn"/>"
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
	    grid.setSelectionMode("single-cell");
	    grid.setCellEditable(false);
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([str, str, str, str, str, str]);
	    
	    grid.setCellTemplate(new AW.Templates.Combo, _col.eventMonth);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.planResultTpCDName);
	    
		grid.setPopupTemplate(function(col, row) {
			
			if (col == _col.eventMonth) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","MONTHCD");
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
	            list.setStyle("width","120px");
	            list.setStyle("height","200px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.monthCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.planResultTpCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","PLANRESULTTPCD");
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
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.planResultTpCD, row);
	            	}
	            	catch(e){}
	            };
			}
			
            return list;
        });
		
		//등록시작일자 달력
        grid.setCellImage("calendarGrid",_col.regDateFrom);
    	var calendar = new AW.Templates.ImageText;
        var calImage = calendar.getContent("box/image");
        calImage.setTag("a");
        calImage.setAttribute("href", function(){
            return "javascript:pickDateForGrid(grid, _col.regDateFrom,grid.getCurrentRow(), 'getRegDateCheck')";
        });
    	grid.setCellTemplate(calendar, _col.regDateFrom);
    	
    	//등록종료일자 달력
        grid.setCellImage("calendarGrid",_col.regDateTo);
    	var calendar = new AW.Templates.ImageText;
        var calImage = calendar.getContent("box/image");
        calImage.setTag("a");
        calImage.setAttribute("href", function(){
            return "javascript:pickDateForGrid(grid, _col.regDateTo,grid.getCurrentRow(), 'getRegDateCheck')";
        });
    	grid.setCellTemplate(calendar, _col.regDateTo);
    	
    	grid.setCellImage("deleteGrid",_col.deleteBtn);
	    var deleteFlag = new AW.Templates.Image;
	    var delImage = deleteFlag.getContent("box/image");
	    delImage.setTag("a");
	    delImage.setAttribute("href", function(){
	    	return "javascript:removeRow(grid.getCurrentRow())";
	    });
		grid.setCellTemplate(deleteFlag, _col.deleteBtn);
		
		
	 	// Cell startEdit BEGIN
	    grid.onCellSelectedChanged = function(selected, col, row) { 
	        if (selected) { 
	            this.setTimeout(function(){ 
	               this.raiseEvent("editCurrentCell", {}, col, row); 
	            }); 
	        } 
	    };
	      
	    grid.onCellClicked = function(event, col, row) { 
	        if (this.getCellSelected(col, row)) { 
	            this.setTimeout(function(){
	               this.raiseEvent("editCurrentCell", {}, col, row); 
	           }); 
	        }
	    }; 
	    
	    grid.onCellEditStarted = function(text, col, row){
	    };
	    
	    grid.onCellEditEnded = function(text, col, row){
	    	this.setCellText(text, col, row);
	    };
	 	// Cell startEdit END
	      
	    //  BEGIN validating (Enter, Cell LoseFocus)
	    grid.onCellValidating = function(text, col, row) {
           	this.setCellText("U",_col.activeFlg,row);
	    };
	
	
	    grid.onCellValidated = function(text, col, row){
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
	    
	    grid.onHeaderClicked = function(){
  			return true;
  		};
    }
    
</script>   
