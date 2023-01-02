<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
        <%@include file="../scripts.jsp" %>
    </head>

    <body onload="init()" class="yui-skin-sam" ${bodyConfig}>
        <form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1">	
						<!-- Standard Parameter - START -->
					    <input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
					    <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
					    <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
						<input type="hidden" name="method">
						
						<input type="hidden" name="classCD" value="${params.classCD }">
						<!-- Standard Information - END -->
				
						<!-- Function Set - Button -->
						<%@include file="../cms/functionbar.jsp" %>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                    		<tr>
			                    <td width="250" height="*" rowspan="2" class="tree-border">
									<iframe id="_tree" name="_tree" width="100%" height="100%" frameborder='0' scrolling='auto' 
									        src="${contextPath}/service/class/initClassList/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01012B&classCD=${params.classCD }&pclassID=&handler=javascript:parent.Search"></iframe>
								</td>
			                    <td class="tb-border" height="30">
			                    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
										<tr>
											<td class="td-cond" width="80"><fmt:message key="CMP01012A.pClassCD" /></td>
											<td class="td-input" width="300">
												<input type="text" id="pclassName" name="pclassName" class="input-readonly"  style="width:150px;" readonly="readonly">&nbsp;
						                        <input type="text" id="pclassCD" name="pclassCD" class="input-readonly"  style="width:100px;" readonly="readonly">&nbsp;
						                        <input type="hidden" id="pclassID" name="pclassID">
											</td>
											<td class="td-input" width="*" style="text-align:right;">
												<script type="text/javascript">
						                           var addRow = new AW.UI.Button;
						                           addRow.setControlText("<fmt:message key="button.AddRow" />");
						                           document.write(addRow);
						                            
						                           addRow.onControlClicked = function(event) {
						                                if (requiredCheck() == false) return;
						                                grid.addRow(maxRow++);
						                                grid.setCellText("${params.classCD}", 0, maxRow-1);
						                                grid.setCellText('U', 6, maxRow-1);
						                           };
						                           
						                           var removeRow = new AW.UI.Button;
						                           removeRow.setControlText("<fmt:message key="button.RemoveRow" />");
						                           document.write(removeRow);
						                            
						                           removeRow.onControlClicked = function(event) {
												        var row = grid.getCurrentRow();
												        grid.deleteRow(row);
												        grid.setCellText('D', 6, row);
						                           };
						                       </script>
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
			        </td>
				</tr>
                <tr>
                    <td height="5">
                    </td>
                </tr>
			</table>
		</form>
	</body>
</html>

<!-- grid format -->
<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 100px; text-align: center;}
	.aw-column-1 {width: 150px; }
	.aw-column-2 {width: 80px; text-align: right;}
	.aw-column-3 {width: 80px; text-align: center;}
	.aw-column-4 {width: 300px;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		window.onload = function() {
	
		};
	
		${initScript}
	});

	var maxRow = 0;
	
	/****************************************
	* Function
	****************************************/
	function init(){
		if ("${resultMsg.code}" != "") {
			message("${resultMsg.message}");
		} 
	}
	
	function requiredCheck() {
	
		if ($("#pclassCD").val() == "") {
			message("<fmt:message key="info.required.pClassCD"/>");
			return false;
		}
		
		return true;
	}
	
	/****************************************
	* Button Action
	****************************************/
	function Save() {
		
		if (requiredCheck() == false) return;
		
		if (confirm("<fmt:message key="confirm.save"/>")) {
	      	
			var classCD = new Array();
		  	var className = new Array();
		  	var seq = new Array();
		  	var useYN = new Array();
		  	var remark = new Array();
		  	var classID = new Array();
		  	var pclassID = new Array();
		  	var activeFlg = new Array();
		  	
		  	var count = 0;
	  	    for(var i=0; i < maxRow; i++)
	  	    {
	  	    	if(grid.getCellText(6, i)!="D") {
	  	    		
	  	    		
		  	    	if (grid.getCellText(1, i) == "") {alert("<fmt:message key="CMP01012A.msg1"/>"); setCellFocus(grid, 1, i); return;}
		  	    	if (grid.getCellText(2, i) == "") {alert("<fmt:message key="CMP01012A.msg2"/>"); grid.setCellText("0", 2, i); return;}
	  	    	}
	  	    	
                classCD[count] = grid.getCellText(0,i);
                className[count] = grid.getCellText(1,i);
                seq[count] = grid.getCellText(2,i);
                if (grid.getCellValue(3,i))
                {
                    useYN[count] = 'Y';
                }
                else
                {
                    useYN[count] = 'N';
                }
                remark[count] = grid.getCellText(4,i);
                classID[count] = grid.getCellText(5,i);
                pclassID[count] = document.getElementById("pclassID").value;
                activeFlg[count] = grid.getCellText(6,i);
                count++;
            }
	  	    
	  	  	if(count == 0) {
	  	    	alert("<fmt:message key="info.nullData.save"/>");
	  	    	return;
	  	    }
	  	    
	      	var req = new AW.XML.Table;
	      	req.setURL("${contextPath}/service/class/saveClass");
	      	req.setAsync(false);
	      	req.setRequestMethod("POST");
	      	req.setParameter("classCD", classCD);
		  	req.setParameter("className", className);
		  	req.setParameter("seq", seq);
		  	req.setParameter("useYN", useYN);
		  	req.setParameter("remark", remark);
		  	req.setParameter("classID", classID);
		  	req.setParameter("pclassID", pclassID);
		  	req.setParameter("activeFlg", activeFlg);
		  	req.setParameter("pclassID_con", $("#pclassID").val());
	      	req.request();
	      	
	      	if (req.getData(0,0) == "S") {
	      		document._tree.location.href=
		      		"${contextPath}/service/class/initClassList/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01012B&classCD=${params.classCD }&handler=javascript:parent.Search";
	      		Search($("#pclassID").val(), $("#pclassCD").val(), $("#pclassName").val());
	      	}
	      	message(req.getData(1,0));
	    }
	}
	
	function Search(classID, classCD, className){
	
		if (classID != '' && classID != undefined) {
			$("#pclassID").val(classID);
			$("#pclassCD").val(classCD);
			$("#pclassName").val(className);
        }
        else {
        	$("#pclassID").val("ROOT");
			$("#pclassCD").val("ROOT");
			$("#pclassName").val("<fmt:message key="CMP01012A.class"/>");
        }
        		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/CMP0101201S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("pclassID", $("#pclassID").val());
	  	table.setParameter("classCD", $("#pclassCD").val());
	  	
      	table.request();
      	
      	createGrid();
      	grid.refresh();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
      						table.getData(5,i), //classCD
      						table.getData(1,i), //className
      						table.getData(2,i), //seq
      						'', //useYN
		      			   	table.getData(3,i), //remark
		      			   	table.getData(0,i), //classID
		      			   	table.getData(7,i) //activeFlg
		      			  ];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		for (var i=0; i <rowCount; i++)
            {
                if (table.getData(6,i) == 'Y')
                {
                    grid.setCellValue(true,3,i);
                }
            } 
      		grid.refresh();
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	}
      	
      	maxRow = grid.getRowCount();
	}

	
	/*****************************************************
	*	define data formats define
	*****************************************************/
 
	var columns = [
		"<fmt:message key="CMP01012A.classCD"/>",
		"<fmt:message key="CMP01012A.className"/>",
		"<fmt:message key="CMP01012A.seq"/>", 
		"<fmt:message key="CMP01012A.useYN"/>",
		"<fmt:message key="CMP01012A.remark"/>",
		"<fmt:message key="CMP01012A.classID"/>"
	];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str, num0, str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setHeaderText(columns);
		grid.setSize(450, 400);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(true);
		grid.setSelectionMode("single-cell");
		grid.setStyle("width", "100%");
		grid.setStyle("height", "100%");
		grid.setCellEditable(true);
		grid.setCellEditable(false, 0);
		grid.setCellEditable(false, 3);
		grid.setCellEditable(false, 5);
		
		grid.setCellTemplate(new AW.Templates.CheckBox, 3);
        grid.setCellValue(false, 3);
		
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

        grid.onCellEditEnded = function(text, col, row){
	        this.setCellText(text, col, row);
	        this.focus();
	    };
	    
        grid.onKeyEnter = function(event){
			var col = this.getCurrentColumn();
			var row = this.getCurrentRow();
			
			if (col == 0){
				setCellFocus(this, 1, row);
			}
			else if (col == 1){
				setCellFocus(this, 2, row);
			}
			else if (col == 2){
				setCellFocus(this, 4, row);
			}
		};
        // Cell startEdit END
        
		//  BEGIN validating (Enter, Cell LoseFocus)
		grid.onCellEditStarted = function(text, col, row){
			if (col == 2) {
				this.setCellText(unformatNum(text), col, row);
			}
		};

		grid.onCellValidating = function(text, col, row) {
			if(col == 1) {
				if(text.length > 50){
					alert("<fmt:message key="CMP01012A.msg3"/>");
					this.setCellText("",col,row);
					setCellFocus(this, col, row);
					return;
				}
			}
			if (col == 2) {
				if (!isDecimal(text)) {
					alert("<fmt:message key="error.noNum"/>");
					this.setCellText("0",col,row);
					return;
				}
				else if (parseFloat(text) < 0) {
					alert("<fmt:message key="error.noMinusNum"/>");
					this.setCellText("0",col,row);
					return;
				}
			}
		};

		grid.onCellValidated = function(text, col, row){
			if (col == 2) {
				this.setCellText(formatNum(text), col, row);
			}
		};
		//  END validated Action (Enter, Cell LoseFocus)
        
	}
	
	createGrid();
	grid.refresh();
</script>

<script type="text/javascript">
<!--
	<c:if test="${!empty params.initAction}">
		${params.initAction}();
	</c:if>
//-->
</script>	
