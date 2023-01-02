<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp"%>
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
								<%@include file="../sys3/cms/calendar.jsp" %>
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD03001B" />
							</td>
						</tr>
		                <tr>
		                	<td height="1">             
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;"></table>
		                    			</td>
		                   			</tr>
								</table>
		                    </td>
		                </tr>
						<tr>
							<td>
								<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
									<tr>
										<td height="1" style="padding-top: 10px;">
											<table border="0" cellspacing="0" cellpadding="0" width="100%">
												<tr>
													<td style="text-align: right;">
														<script type="text/javascript">
							                   				var addRow = new AW.UI.Button;
								                      		
							                   				addRow.setControlText("<fmt:message key="button.AddRow" />");
								                      		addRow.setControlImage("addRow");
								                      		document.write(addRow);
								                      
								                      		addRow.onControlClicked = function(event) {		 
								                        		grid.addRow(maxRow++);
								                        		grid.setCellText("U",_col.activeFlg,maxRow-1);
								                        		grid.setCellText("Y",_col.activeYN,maxRow-1);
								                        		grid.setCellText("${params.clientDate}".substring(0,4), _col.yyyy, maxRow-1);
								                        		
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
							<tr>
								<td height="1">
									<input type="hidden" id="selectSeqCD" name="selectSeqCD" />
									<input type="hidden" id="showNo" name="showNo" />
									<input type="hidden" id="showComment" name="showComment" />
									<input type="hidden" id="showActiveYN" name="showActiveYN" />
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

	.aw-column-0 {width: 30px;	text-align: center;}
	.aw-column-1 {width: 150px;	text-align: center;}
	.aw-column-2 {width: 300px;	text-align: center;}
	.aw-column-3 {width: 100px;	text-align: center;}
	.aw-column-4 {width: 100px;	text-align: center;}
	.aw-column-5 {width: 100px;	text-align: center;}
	.aw-column-6 {width: 100px;	text-align: center;}
	.aw-column-7 {width: 50px;	text-align: center;}

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
	$(document).ready(function() {

		window.onload = function() {

			createGrid();
			grid.refresh();
			Search();
			
		};

		${initScript}
		
	});

	//행삭제
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
		checkbox : _i++
	  , rowNum : _i++
	  , commt : _i++
	  , yyyy : _i++
	  , activeYN : _i++
	  , regDate : _i++
	  , chgDate : _i++
	  , deleteBtn : _i++
	  ,	seq : _i++
	  , activeFlg : _i++
	};
   
	//조회
	function Search() {
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/AD0300101S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey",
        		"checkbox;rowNum;commt;yyyy;activeYN;"+
        		"regDate;chgDate;deleteBtn;seq;");
        table.setParameter("format",
        		"str;str;str;str;str;"+
        		"str;str;str;str;");
        table.setParameter("no_S", $("#no_S").val());
        table.setParameter("comment_S", $("#comment_S").val());
        table.setParameter("activeYN_S", $("#activeYN_S").val());
        table.request();
        
        createGrid();
        
        var rowCount = table.getCount();
        
        if (rowCount > 0) {
        	var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	
            	data[i] = [
            		""
	                , table.getData(_col.rowNum,i)              
	                , table.getData(_col.commt,i)              
	                , table.getData(_col.yyyy,i)              
	                , table.getData(_col.activeYN,i)              
	                , table.getData(_col.regDate,i)  
	                , table.getData(_col.chgDate,i)
	                , table.getData(_col.deleteBtn,i)
	                , table.getData(_col.seq,i)
	                , 'U'
					
            	];
            }
            
            
            grid.setCellData(data);
            //grid.setCellText("U",_col.activeFlg);
            grid.setRowCount(rowCount);
        }
        else {
        	message("<fmt:message key="info.nullData"/>");
        }
        
        grid.refresh();
        
      	maxRow = rowCount;
	}

	//사용처리
	function useProcess() {
		var index = grid.getRowIndices();
		if(index == "") {
			index = new Array();
			for(var i = 0; i < grid.getRowCount(); i++) {
				index[i] = i;
			}
		}
		
		var seqs = new Array();
		var commts = new Array();
		var count = 0;
		for(var i=0; i<index.length; i++) {
			if(grid.getCellValue(_col.checkbox, index[i])) {
				seqs[count] = grid.getCellText(_col.seq, index[i]);
				commts[count] = grid.getCellText(_col.commt, index[i]);
				count++;
			}
		}
		
		if(count == 0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if(grid.getCellValue(_col.checkbox, index[i])) {
				//사용여부가 이미 'Y'일 때 				
				if(grid.getCellText(_col.activeYN, index[i]) != "N") {
					alert("<fmt:message key="AD03001A.msg1"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="AD03001A.msg3"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ad03/requestUseProcess");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("seqs", seqs);
		table.setParameter("commts", commts);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}else {
			alert(table.getData(1,0));
		}	
		
	}
	
	//미사용처리
	function unUsedProcess() {
		var index = grid.getRowIndices();
		if(index == "") {
			index = new Array();
			for(var i = 0; i < grid.getRowCount(); i++) {
				index[i] = i;
			}
		}
		
		var seqs = new Array();
		var commts = new Array();
		var count = 0;
		for(var i=0; i<index.length; i++) {
			if(grid.getCellValue(_col.checkbox, index[i])) {
				seqs[count] = grid.getCellText(_col.seq, index[i]);
				commts[count] = grid.getCellText(_col.commt, index[i]);
				count++;
			}
		}
		
		if(count == 0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if(grid.getCellValue(_col.checkbox, index[i])) {
				//사용여부가 이미 'N'일 때
				if(grid.getCellText(_col.activeYN, index[i]) != "Y") {
					alert("<fmt:message key="AD03001A.msg2"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="AD03001A.msg4"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ad03/requestUnUsedProcess");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("seqs", seqs);
		table.setParameter("commts", commts);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}	
		
	}

	//저장
	function Save() {
		var seqs = new Array();
        var commts = new Array();
        var yyyys = new Array();
        var activeYNs = new Array();
        var activeFlgs = new Array();
        var j=0;
        
        
        for (var i=0; i < maxRow; i++) {
        	if(grid.getCellText(_col.activeFlg, i) !== "D") {
				if(grid.getCellText(_col.commt, i) === "") {
					alert("<fmt:message key="AD03001A.msg5" />"); 
					setCellFocus(grid, _col.activeYN, i); 
					return;
				}
				
				if(grid.getCellText(_col.yyyy, i) === "") {
					alert("<fmt:message key="AD03001A.msg6" />"); 
					setCellFocus(grid, _col.yyyy, i); 
					return;
				}
        	}
       		seqs[j] = grid.getCellText(_col.seq,i);
       		commts[j] = grid.getCellText(_col.commt,i);
       		yyyys[j] = grid.getCellText(_col.yyyy,i);
       		activeYNs[j] = grid.getCellText(_col.activeYN,i);
       		activeFlgs[j] = grid.getCellText(_col.activeFlg,i);
       		j++;
        }

		var table = new AW.XML.Table;     
        table.setURL("${contextPath}/service/ad03/saveAdList");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("seqs", seqs);
        table.setParameter("commts", commts);
        table.setParameter("yyyys", yyyys);
        table.setParameter("activeYNs", activeYNs);
        table.setParameter("activeFlgs", activeFlgs);
        table.setParameter("empID", "${params.empID}");
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
	*					Grid Setting
	*****************************************************/
    var grid = null;
    
	var columns = [
		""
      , "<fmt:message key="AD03001A.rowNumber"/>"
      , "<fmt:message key="AD03001A.comment"/>"  
      , "<fmt:message key="AD03001A.yyyy"/>"  
      , "<fmt:message key="AD03001A.activeYN"/>"
      , "<fmt:message key="AD03001A.regDate"/>"
      , "<fmt:message key="AD03001A.chgDate"/>"
      , "<fmt:message key="AD03001A.rowRemove"/>"
    ];
     //그리드 생성
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
	    
	    grid.setHeaderText(columns);
	    for (var i=0;i<columns.length;i++) {
	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([str,str,str,str,str,str,str,str]);
	    
	    // 컬럼 편집 활성화
	    grid.setCellEditable(true, _col.commt);
	    grid.setCellEditable(true, _col.yyyy);

	    //checkBox
	    grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellValue(false, _col.checkbox);
		grid.setHeaderTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		
	    grid.setCellTemplate(new AW.Templates.Combo, _col.yyyy);
		
	    //  BEGIN validating (Enter, Cell LoseFocus)
	    grid.onCellValidating = function(text, col, row) {
           	this.setCellText("U",_col.activeFlg,row);
	    };
	    grid.onCellValidated = function(text, col, row){
	    };
	    //  END validated Action (Enter, Cell LoseFocus)

	    grid.setPopupTemplate(function(col, row) {

	    	if (col == _col.yyyy) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","YEARCD");
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
			            grid.setCellText(value[i], _col.yyyy, row);
	            	}
	            	catch(e){}
	            };
			}
			
            return list;
        });
		
	    
	    
		//삭제 버튼	    
    	grid.setCellImage("deleteGrid",_col.deleteBtn);
	    var deleteFlag = new AW.Templates.Image;
	    var delImage = deleteFlag.getContent("box/image");
	    delImage.setTag("a");
	    delImage.setAttribute("href", function(){
	    	return "javascript:removeRow(grid.getCurrentRow())";
	    });
		grid.setCellTemplate(deleteFlag, _col.deleteBtn);
	    
	    //header 클릭
		grid.onHeaderClicked = function(event,col) {
			
			if (col == _col.checkbox && this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(true, _col.checkbox);
			}
			else if (col == _col.checkbox && !this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(false, _col.checkbox);
			}
			return false;
		};
		
		//그리드 row 클릭
	    grid.onRowDoubleClicked = function(event, row){
			$("#selectSeqCD").val(this.getCellText(_col.seq, row));
			$("#showNo").val(this.getCellText(_col.rowNum, row));
			$("#showComment").val(this.getCellText(_col.commt, row));
			$("#showActiveYN").val(this.getCellText(_col.activeYN, row));
			
			if($("#selectSeqCD").val() == "") {
				alert("<fmt:message key="AD03001A.msg7"/>");
				return;
			}
			
	    	
			$("#_detail")[0].contentWindow.$("#selectSeqCD").val(grid.getCellText(_col.seq,row));
			$("#_detail")[0].contentWindow.Search();
			appletOpen();
	    }
    }
    
</script>
