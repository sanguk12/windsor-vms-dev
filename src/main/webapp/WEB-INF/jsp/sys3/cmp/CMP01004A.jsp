<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		<%@include file="../scripts.jsp" %>
		<style type="text/css">
			.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
			.aw-row-selector {text-align: center}
		
			.aw-column-0 {width: 80px; text-align: center;}
			.aw-column-1 {width: 120px; }
			.aw-column-2 {width: 60px; text-align: right;}
			.aw-column-3 {width: 150px;}
			.aw-column-4 {width: 100px;}
			.aw-column-5 {width: 150px;}
			.aw-column-6 {width: 150px;}
		
			.aw-grid-cell {border-right: 1px solid threedlightshadow;}
			.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
		</style>
	</head>

    <body class="yui-skin-sam" ${bodyConfig}>
        <form name="form" method="post">
        	<div id="wrapDiv">
          		<div id="formDiv" >
		            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		                <tr>
		                    <td height="1">
								<%@include file="../cms/standardParam.jsp" %>
								<input type="hidden" id="companyID" name="companyID" value="${params.companyID}">
								<%@include file="../cms/functionbar.jsp" %>
						    </td>
						</tr>
						<tr>
		                    <td height="*">
		                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
		                    		<tr>
					                    <td width="250" height="*" rowspan="2" class="tree-border">
							   				<iframe id="_tree" name="_tree" width='100%' height="100%" frameborder='0' scrolling='auto' 
							        				src="${contextPath}/service/organization/initOrgList/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01004B&companyID=${params.companyID}&handler=javascript:parent.Search"></iframe>
					        			</td>
					                    <td class="tb-border" height="30">
					                    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
												<tr>
													<td class="td-cond" width="80"><fmt:message key="pOrgCD" /></td>
													<td class="td-input" width="300">
														<input type="text" name="porgName" class="input-readonly"  style="width:150px;" readonly="readonly">&nbsp;
								                        <input type="text" name="porgCD" class="input-readonly"  style="width:100px;" readonly="readonly">
								                        <input type="hidden" id="porgID" name="porgID">
													</td>
													<td class="td-input" width="*" style="text-align:right;">
														<script type="text/javascript">
									                       var addRow = new AW.UI.Button;
								                           addRow.setControlText("행추가");
								                           document.write(addRow);
								                            
								                           addRow.onControlClicked = function(event) {
								                                if (requiredCheck() == false) return;
								        				        grid.addRow(maxRow++);
														        grid.setCellText('U', 11, maxRow-1);
								                           };
								                           
								                           var removeRow = new AW.UI.Button;
								                           removeRow.setControlText("행삭제");
								                           document.write(removeRow);
								                            
								                           removeRow.onControlClicked = function(event) {
								                                var row = grid.getCurrentRow();
								        				        grid.deleteRow(row);
														        grid.setCellText('D', 11, row);
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
					</table>
				</div>
				${appletDiv}
			</div>
		</form>
		
		<script type="text/javascript">

			/****************************************
			* Variable
			****************************************/
			var maxRow = 0;
			
			/****************************************
			* Function
			****************************************/
			$(document).ready(function() {
				
				${initScript}
				
				window.onload = function() {
					if ("${resultMsg.code}" != "") {
						message("${resultMsg.message}");
					}
					Search();
				};	
			});
			
			function requiredCheck() {
			
				if (document.getElementById("porgCD").value == "") {
					message("<fmt:message key="info.required.pOrgCD"/>");
					return false;
				}
				
				return true;
			}
			
			/****************************************
			* Button Action
			****************************************/
		
			function Save() {
				
				if (requiredCheck() == false) return;
		      	
		      	var orgCD = new Array();
			  	var orgName = new Array();
			  	var seq = new Array();
			  	var remark = new Array();
			  	var orgID = new Array();
			  	var orgClassCD = new Array();
			  	var porgID = new Array();
			  	var activeFlg = new Array();
			  	var partnerID = new Array();
			  	var companyID = new Array();
			  	
				for(var i=0; i < maxRow; i++) {
			  		orgCD[i] = grid.getCellText(0,i);
			  		orgName[i] = grid.getCellText(1,i);
			  		seq[i] = grid.getCellText(2,i);
			  		remark[i] = grid.getCellText(3,i);
			  		orgClassCD[i] = grid.getCellText(7,i);
			  		porgID[i] = grid.getCellText(8,i);
			  		orgID[i] = grid.getCellText(9,i);
			  		partnerID[i] = grid.getCellText(10,i);
			  		activeFlg[i] = grid.getCellText(11,i);
			  	    companyID[i] = grid.getCellText(12,i);
			  	}
		      	
		      	var req = new AW.XML.Table;		  
			  	req.setURL("${contextPath}/service/organization/saveOrganization");
			  	req.setAsync(false);
			  	req.setRequestMethod("POST");
		      	req.setParameter("orgCD", orgCD);
			  	req.setParameter("orgName", orgName);
			  	req.setParameter("seq", seq);
			  	req.setParameter("remark", remark);
			  	req.setParameter("orgID", orgID);
			  	req.setParameter("porgID", porgID);
			  	req.setParameter("orgClassCD", orgClassCD);
			  	req.setParameter("activeFlg", activeFlg);
			  	req.setParameter("partnerID", partnerID);
			  	req.setParameter("companyIDs", companyID);
			  	req.setParameter("porgID_con", document.getElementById("porgID").value);
		      	req.request();
		      	
		      	if (req.getData(0,0) == "S") {
		      		document._tree.location.href=
			      		"${contextPath}/service/organization/initOrgList/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01004B&companyID=${params.companyID}&handler=javascript:parent.Search";
		      		Search(document.getElementById("porgID").value, document.getElementById("porgCD").value, document.getElementById("porgName").value);
		      	}
		      	message(req.getData(1,0));
		
			}
			
			function Search(orgID, orgCD, orgName){
				
				if (orgID != '' && orgID != undefined) {
		            document.getElementById("porgID").value = orgID;
		            document.getElementById("porgCD").value = orgCD;
		            document.getElementById("porgName").value = orgName;
		        }
		        else
		        {
		            document.getElementById("porgID").value = 'ROOT';
		            document.getElementById("porgCD").value = 'ROOT';
		            document.getElementById("porgName").value = 'Organization';
		        }
		
				var table = new AW.XML.Table;	  
			  	table.setURL("${contextPath}/service/simpleAction/CMP0100401S");
			  	table.setAsync(false);
			  	table.setRequestMethod("POST");
			  	//table.setParameter("queryKey","CMP0100401S");
		        table.setParameter("companyID",$("#companyID").val());
			  	table.setParameter("porgID", document.getElementById("porgID").value);
		      	table.request();
		      	
		      	createGrid();
		      	grid.refresh();
		      	
		      	var rowCount = table.getCount();
		      	if (rowCount > 0) {
		      		var data = new Array();
		      		for (var i=0; i < rowCount; i++) {
		      			data[i] = [
		      			           table.getData(0,i), //orgCD
		      			           table.getData(1,i), //orgName
		      			           table.getData(2,i), //seq
		      			           table.getData(3,i), //remark
		      			           table.getData(9,i), //orgClassCDName
				      			   table.getData(7,i), //porgName
				      			   table.getData(11,i), //partnerName
				      			   table.getData(8,i), //orgClassCD
				      			   table.getData(5,i), //porgID
		                           table.getData(4,i), //orgID
		                           table.getData(10,i), //partnerID
				      			   table.getData(6,i), //activeFlg
				      			   table.getData(12,i) //companyID
				      			  ];
		      		}
		      		grid.setCellData(data);
		      		grid.setRowCount(rowCount);
		      		grid.refresh();
		      	} else {
		      		message("<fmt:message key="info.nullData"/>");
		      	}
		      	
		      	maxRow = grid.getRowCount();
			}
		
			
			/*****************************************************
			*	define data formats define
			*****************************************************/
			var str = new AW.Formats.String;
			var num = new AW.Formats.Number;
		  
			var columns = [
				"<fmt:message key="orgCD"/>",
				"<fmt:message key="orgName"/>",
				"<fmt:message key="seq"/>", 
				"<fmt:message key="remark"/>",
				"<fmt:message key="orgClass" />",
				"<fmt:message key="pOrgCD" />",
				"<fmt:message key="partner"/>"
			];
			
			var grid = null;
			
			function createGrid() {
				
				grid = new AW.UI.Grid;
				
				grid.setId("grid");
				grid.setCellFormat([str, str, num, str, str, str, str]);
				grid.setHeaderText(columns);
				for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
				grid.setSize(450, 400);
				grid.setRowCount(0);
				grid.setColumnCount(columns.length);
				grid.setSelectorVisible(true);
				grid.setSelectionMode("single-cell");
				grid.setStyle("width", "100%"); 
				grid.setStyle("height", "100%");
				grid.setCellEditable(true);
				grid.setCellEditable(false, 4);
				grid.setCellEditable(false, 5);
				grid.setCellEditable(false, 6);
		
		
				var orgClassCD_table = new AW.XML.Table;
		        orgClassCD_table.setURL("${contextPath}/service/simpleAction/CMP0100301S");
		        orgClassCD_table.setAsync(false);
		        orgClassCD_table.setRequestMethod("POST");
		        //orgClassCD_table.setParameter("queryKey","CMP0100301S");
		        orgClassCD_table.setParameter("codeDiv", "ORGCLASSCD");     
		        orgClassCD_table.request();
		
		        var orgClassCD_value = new Array();
		        var orgClassCD_text = new Array();
		        var orgClassCD_rowCount = orgClassCD_table.getCount();
		        if (orgClassCD_rowCount > 0) {
		            for (var i=0; i < orgClassCD_rowCount; i++) {
		                orgClassCD_text[i] = orgClassCD_table.getData(2,i);
		                orgClassCD_value[i] = orgClassCD_table.getData(1,i);
		            }
		        }
		        
				var porgCD_table = new AW.XML.Table;
				porgCD_table.setURL("${contextPath}/service/simpleAction/CMP0100401S");
				porgCD_table.setAsync(false);
				porgCD_table.setRequestMethod("POST");
				//porgCD_table.setParameter("queryKey","CMP0100401S");
				porgCD_table.setParameter("porgID", ""); //ROOT     
				porgCD_table.request();
		
		        var porgCD_value = new Array();
		        var porgCD_text = new Array();
		        var porgCD_rowCount = porgCD_table.getCount();
		        if (porgCD_rowCount > 0) {
		            for (var i=0; i < porgCD_rowCount; i++) {
		            	porgCD_text[i] = porgCD_table.getData(1,i);
		            	porgCD_value[i] = porgCD_table.getData(4,i);
		            }
		        }
		
		        var partnerID_table = new AW.XML.Table;
		        partnerID_table.setURL("${contextPath}/service/simpleAction/CMP0100402S");
		        partnerID_table.setAsync(false);
		        partnerID_table.setRequestMethod("POST");
		        //partnerID_table.setParameter("queryKey","CMP0100402S");
		        partnerID_table.setParameter("partnerDivCD","HQ");
		        partnerID_table.request();
		
		        var partnerID_value = new Array();
		        var partnerID_text = new Array();
		        var companyID_value = new Array();
		        var partnerID_rowCount = partnerID_table.getCount();
		        if (partnerID_rowCount > 0) {
		            for (var i=0; i < partnerID_rowCount; i++) {
		                partnerID_text[i] = partnerID_table.getData(1,i);
		                partnerID_value[i] = partnerID_table.getData(0,i);
		                companyID_value[i] = partnerID_table.getData(2,i);
		            }
		        }
		
		        
		        grid.setCellTemplate(new AW.Templates.Combo, 4); 
		        grid.setCellTemplate(new AW.Templates.Combo, 5);
		        grid.setCellTemplate(new AW.Templates.Combo, 6);
		        
		        grid.setPopupTemplate(function(col, row){  
		
		        	var orgClassCD_list = new AW.UI.List;  
		            var porgCD_list = new AW.UI.List;  
		            var partnerID_list = new AW.UI.List;
		
		            if (col == 4)
		            {
		                orgClassCD_list.setStyle("width","100px");
		                orgClassCD_list.setStyle("height","100px");
		                orgClassCD_list.setItemText(orgClassCD_text);
		                orgClassCD_list.setAttribute("value", orgClassCD_value);
		                orgClassCD_list.setItemCount(orgClassCD_text.length);
		                
		         
		                orgClassCD_list.onItemMouseDown = function(event, i)
		                {
		                    var text = this.getItemText(i);  
		                    var value = this.getAttribute("value");
		                    grid.setCellText(text, col, row);  
		                    grid.setCellValue(text, col, row);
		                    
		                    grid.setCellText(value[i], 7, row);
		                    grid.setCellValue(value[i], 7, row);
		
		                    grid.getCellTemplate(col, row).hidePopup();  
		                }
		                return orgClassCD_list;
		            }
		            else  if (col == 5)
		            {
		            	porgCD_list.setStyle("width","150px");
		            	porgCD_list.setStyle("height","200px");
		            	porgCD_list.setItemText(porgCD_text);
		            	porgCD_list.setAttribute("value", porgCD_value);
		            	porgCD_list.setItemCount(porgCD_text.length);
			            
			     
			            porgCD_list.onItemMouseDown = function(event, i)
			            {
			                var text = this.getItemText(i);  
			                var value = this.getAttribute("value");
			                grid.setCellText(text, col, row);  
			                grid.setCellValue(text, col, row);
			                
			                grid.setCellText(value[i], 8, row);
			                grid.setCellValue(value[i], 8, row);
			                
			                grid.getCellTemplate(col, row).hidePopup();  
			            }
			            return porgCD_list;
		            }
		            else  if (col == 6)
		            {
		                partnerID_list.setStyle("width","150px");
		                partnerID_list.setStyle("height","200px");
		                partnerID_list.setItemText(partnerID_text);
		                partnerID_list.setAttribute("value", partnerID_value);
		                partnerID_list.setAttribute("companyID_value", companyID_value);
		                partnerID_list.setItemCount(partnerID_text.length);
		                
		         
		                partnerID_list.onItemMouseDown = function(event, i)
		                {
		                    var text = this.getItemText(i);  
		                    var value = this.getAttribute("value");
		                    var companyID_value = this.getAttribute("companyID_value");
		                    grid.setCellText(text, col, row);  
		                    grid.setCellValue(text, col, row);
		                    
		                    grid.setCellText(value[i], 10, row);
		                    grid.setCellText(companyID_value[i], 12, row);
		                    
		                    grid.getCellTemplate(col, row).hidePopup();  
		                }
		                return partnerID_list;
		            }
		        });
		        
				
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
		        };
		        // Cell startEdit END
		
		        grid.onHeaderClicked=function(){
		  			return true;
		  		};
			}
			
			createGrid();
			grid.refresh();
			
		</script>
	</body>
</html>