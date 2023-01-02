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
		<form name="form" id="form" method="post" enctype="multipart/form-data">
		    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		    	<tr>
		        	<td height="1">
				    	<%@include file="../sys3/cms/standardParam.jsp" %>
				       	<%@include file="../sys3/cms/functionbar.jsp" %>
		            </td>
		       </tr>
		       <tr>
					<td height="1">             
		            	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
		               		<tr>
		               			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
									    <colgroup>
									    	<col style="width:130px"></col>
									    	<col></col>
									    </colgroup>
									    <tbody>
				    					<tr>
						                	<td class="td-cond">
						                		<fmt:message key="MDM01001B.fileUpload" />
						                	</td>
						                	<td class="td-input">
				                        		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				                           			<tr>
				                               			<td height="25" width="310">
				                                   			<div id="selectedFileDisplay">
					                                       		 <input type="text" id="progressReport" value="" style="width:300px;float: left; display: inline-block;" class="file_input_textbox" readonly="readonly" >
					                                   		</div>
				                               			</td>
				                               			<td width="75"> 
				                                   			<div id="uploaderContainer" class="file_input_div">
                                                             	<input type="button" class="file_input_button" />
                                                             	<input type="file" name="fileuploader" id="fileuploader" class="file_input_hidden">                                
					                                   		</div>
				                               			</td>
				                               			<td width="*">
				                                   			<div id="uploadFilesLink">
					                                   			<a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a>
					                                   		</div>
				                               			</td>
				                           			</tr>
				                       			</table>
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
		    </table>
	    </form>
	</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    .aw-row-selector {text-align: center}

    .aw-column-0 {width: 80px; }
    .aw-column-1 {width: 90px; }
    .aw-column-2 {width: 90px; }
    .aw-column-3 {width: 70px; }
    .aw-column-4 {width: 150px; }
    .aw-column-5 {width: 100px; }
    .aw-column-6 {width: 100px; }
    .aw-column-7 {width: 100px; }
    .aw-column-8 {width: 150px; }
    .aw-column-9 {width: 70px; }
    .aw-column-10 {width: 150px; }

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->    
</style>

<script type="text/javascript">
	/****************************************
	* Variable
	****************************************/
    
    /****************************************
    * Function
    ****************************************/
    $(function() { 
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			grid.refresh();
		};
		
		${initScript}  
	});
	
	function SetGridData(xmlData) {
		var data = new Array();
		var rowCount = 0;

// 		grid.clear();
		createGrid();

		$(xmlData).find("rows").each(function(i) {
			$(this).children().each(function(j) {
				data[j] = [
					$(this).find("dkmdTpCDName").text()
					, $(this).find("empID").text()
					, $(this).find("empNm").text()
					, $(this).find("empTpCDName").text()
					, $(this).find("rageSphereCDName").text()
					, $(this).find("officeCDName").text()
					, $(this).find("teamCDName").text()
					, $(this).find("territoryCDName").text()
					, $(this).find("emailAddr").text()
					, $(this).find("workStatCDName").text()
					, $(this).find("grpIDName").text()
					, $(this).find("dkmdTpCD").text()
					, $(this).find("empTpCD").text()
					, $(this).find("rageSphereCD").text()
					, $(this).find("officeCD").text()
					, $(this).find("teamCD").text()
					, $(this).find("territoryCD").text()
					, $(this).find("workStatCD").text()
					, $(this).find("grpID").text()
				];
				rowCount++;
			});
		});

		grid.setCellData(data);
		grid.setRowCount(rowCount);
		grid.refresh();
		
		//hideLoading();
	}
</script>   

<script type="text/javascript">

    /****************************************
    * Button Action
    ****************************************/
    function New() {
    	$("#progressReport").val("");
    	createGrid();
		grid.refresh();
    }
    
    var _i = 0;
	var _col = {
		dkmdTpCDName : _i++
		, empID : _i++
		, empNm : _i++
		, empTpCDName : _i++
		, rageSphereCDName : _i++
		, officeCDName : _i++
		, teamCDName : _i++
 		, territoryCDName : _i++
 		, emailAddr : _i++
		, workStatCDName : _i++
		, grpIDName : _i++
		
		, dkmdTpCD : _i++
		, empTpCD : _i++
		, rageSphereCD : _i++
		, officeCD : _i++
		, teamCD : _i++
 		, territoryCD : _i++
		, workStatCD : _i++
		, grpID : _i++
		, useYN : _i++
		, activeFlg : _i++
	};
	
	function Save() {
		if(grid.getRowCount()==0) {
			alert("<fmt:message key="msg.upload"/>");
			return;
		}
		
		var index = grid.getRowIndices();
		if (index == '') {
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellText(_col.dkmdTpCD, i) == "") {alert("<fmt:message key="MDM01001B.msg2" />"); setCellFocus(grid, _col.dkmdTpCDNm, i); return;}
			if (grid.getCellText(_col.empID, i) == "") {alert("<fmt:message key="MDM01001B.msg3" />"); setCellFocus(grid, _col.empID, i); return;}
			if (grid.getCellText(_col.empID, i).length < 5) {alert("<fmt:message key="MDM01001B.msg13" />"); setCellFocus(grid, _col.empID, i); return;}
			if (grid.getCellText(_col.empNm, i) == "") {alert("<fmt:message key="MDM01001B.msg4" />"); setCellFocus(grid, _col.empNm, i); return;}
			if (grid.getCellText(_col.empTpCD, i) == "") {alert("<fmt:message key="MDM01001B.msg5" />"); setCellFocus(grid, _col.empTpCDName, i); return;}
			
			if (grid.getCellText(_col.empTpCD, i) == "20") {//영업
				if (grid.getCellText(_col.rageSphereCD, i) == "") {alert("<fmt:message key="MDM01001B.msg6" />"); setCellFocus(grid, _col.rageSphereCDName, i); return;}
// 				if (grid.getCellText(_col.officeCD, i) == "") {alert("<fmt:message key="MDM01001B.msg7" />"); setCellFocus(grid, _col.officeCDName, i); return;}
// 				if (grid.getCellText(_col.teamCD, i) == "") {alert("<fmt:message key="MDM01001B.msg8" />"); setCellFocus(grid, _col.teamCDName, i); return;}
// 				if (grid.getCellText(_col.territoryCD, i) == "") {alert("<fmt:message key="MDM01001B.msg9" />"); setCellFocus(grid, _col.territoryCDName, i); return;}
			} else {
				if (grid.getCellText(_col.rageSphereCD, i) != "") {alert("<fmt:message key="MDM01001B.msg14" />"); grid.setCellText('', _col.rageSphereCDName, i); grid.setCellText('', _col.rageSphereCD, i);return;}
// 				if (grid.getCellText(_col.officeCD, i) != "") {alert("<fmt:message key="MDM01001B.msg15" />"); grid.setCellText('', _col.officeCDName, i); grid.setCellText('', _col.officeCD, i);return;}
// 				if (grid.getCellText(_col.teamCD, i) != "") {alert("<fmt:message key="MDM01001B.msg16" />"); grid.setCellText('', _col.teamCDName, i); grid.setCellText('', _col.teamCD, i);return;}
// 				if (grid.getCellText(_col.territoryCD, i) != "") {alert("<fmt:message key="MDM01001B.msg17" />"); grid.setCellText('', _col.territoryCDName, i); grid.setCellText('', _col.territoryCD, i);return;}
			}
			
			if (grid.getCellText(_col.emailAddr, i) == "") {alert("<fmt:message key="MDM01001B.msg10" />"); setCellFocus(grid, _col.emailAddr, i); return;}
			if (grid.getCellText(_col.workStatCD, i) == "") {alert("<fmt:message key="MDM01001B.msg11" />"); setCellFocus(grid, _col.workStatCDName, i); return;}
			if (grid.getCellText(_col.workStatCD, i) == "01"){
				grid.setCellText('Y',_col.useYN,i);
				grid.setCellText('U',_col.activeFlg,i);
			} else if (grid.getCellText(_col.workStatCD, i) == "02"){
				grid.setCellText('N',_col.useYN,i);
				grid.setCellText('D',_col.activeFlg,i);
			}
			if (grid.getCellText(_col.grpID, i) == "") {alert("<fmt:message key="MDM01001B.msg12" />"); setCellFocus(grid, _col.grpIDName, i); return;}
			
			grid.setCellText(grid.getCellText(_col.empID, i).toUpperCase(),_col.empID,i);
		}

		showLoading();
		
		var dkmdTpCD = new Array();
		var empID = new Array();
		var empNm = new Array();
		var empTpCD = new Array();
		var rageSphereCD = new Array();
		var officeCD = new Array();
		var teamCD = new Array();
		var territoryCD = new Array();
		var emailAddr = new Array();
		var workStatCD = new Array();
		var grpID = new Array();
		var useYN = new Array();
		var activeFlg = new Array();
		var count = 0;

		for (var i = 0; i < index.length; i++) {
			dkmdTpCD[count] = grid.getCellText(_col.dkmdTpCD, index[i]);
			empID[count] = grid.getCellText(_col.empID, index[i]);
			empNm[count] = grid.getCellText(_col.empNm, index[i]);
			empTpCD[count] = grid.getCellText(_col.empTpCD, index[i]);
			rageSphereCD[count] = grid.getCellText(_col.rageSphereCD, index[i]);
			officeCD[count] = grid.getCellText(_col.officeCD, index[i]);
			teamCD[count] = grid.getCellText(_col.teamCD, index[i]);
			territoryCD[count] = grid.getCellText(_col.territoryCD, index[i]);
			emailAddr[count] = grid.getCellText(_col.emailAddr, index[i]);
			workStatCD[count] = grid.getCellText(_col.workStatCD, index[i]);
			grpID[count] = grid.getCellText(_col.grpID, index[i]);
			useYN[count] = grid.getCellText(_col.useYN, index[i]);
			activeFlg[count] = grid.getCellText(_col.activeFlg, index[i]);
			count++;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mdm01/saveEmpGrid");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("dkmdTpCD", dkmdTpCD);
		table.setParameter("empIDs", empID);
		table.setParameter("empNms", empNm);
		table.setParameter("empTpCD", empTpCD);
		table.setParameter("rageSphereCD", rageSphereCD);
		table.setParameter("officeCD", officeCD);
		table.setParameter("teamCD", teamCD);
		table.setParameter("territoryCD", territoryCD);
		table.setParameter("emailAddr", emailAddr);
		table.setParameter("workStatCD", workStatCD);
		table.setParameter("grpID", grpID);
		table.setParameter("useYN", useYN);
		table.setParameter("activeFlg", activeFlg);
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
   		}
		else {
			alert(table.getData(1,0));
		}
		
		hideLoading();
	}


	function List() {
		parent.appletClose();
	}
	
</script>


<script type="text/javascript">
    
    /*****************************************************
    *   Grid Setting
    *****************************************************/
	var columns = [
		"<fmt:message key="MDM01001B.dkmdTpCD" />",
		"<fmt:message key="MDM01001B.empID" />",
		"<fmt:message key="MDM01001B.empNm" />", 
		"<fmt:message key="MDM01001B.empTpCD" />",
		"<fmt:message key="MDM01001B.rageSphereCD" />",
		"<fmt:message key="MDM01001B.officeCD" />",
		"<fmt:message key="MDM01001B.teamCD" />",
		"<fmt:message key="MDM01001B.territory" />",
		"<fmt:message key="MDM01001B.emailAddr" />",
		"<fmt:message key="MDM01001B.workStatCD" />",
		"<fmt:message key="MDM01001B.grpID" />"
	];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str, str, str, str, str, str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setHeaderText(columns);
	    grid.setRowCount(0);
	    grid.setColumnCount(columns.length);
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-cell");
		grid.setCellEditable(false);
		grid.setCellEditable(true, _col.empID);
		grid.setCellEditable(true, _col.empNm);
		grid.setCellEditable(true, _col.emailAddr);
		
		//콤보박스
		grid.setCellTemplate(new AW.Templates.Combo, _col.dkmdTpCDName);
		grid.setCellTemplate(new AW.Templates.Combo, _col.empTpCDName);
		grid.setCellTemplate(new AW.Templates.Combo, _col.rageSphereCDName);
		grid.setCellTemplate(new AW.Templates.Combo, _col.officeCDName);
		grid.setCellTemplate(new AW.Templates.Combo, _col.teamCDName);
		grid.setCellTemplate(new AW.Templates.Combo, _col.territoryCDName);
		grid.setCellTemplate(new AW.Templates.Combo, _col.workStatCDName);
		grid.setCellTemplate(new AW.Templates.Combo, _col.grpIDName);
		
		grid.setPopupTemplate(function(col, row) {
			
			if (col == _col.dkmdTpCDName) {
				grid.setCellText("", _col.grpIDName, row);
				grid.setCellText("", _col.grpID, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","DKMDTPCD");
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
	            list.setStyle("width","80px");
	            list.setStyle("height","90px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.dkmdTpCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.empTpCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","EMPTPCD");
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
	            list.setStyle("width","70px");
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
			            grid.setCellText(value[i], _col.empTpCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.rageSphereCDName) {
				grid.setCellText("", _col.officeCDName, row);
				grid.setCellText("", _col.officeCD, row);
				grid.setCellText("", _col.teamCDName, row);
				grid.setCellText("", _col.teamCD, row);
				grid.setCellText("", _col.territoryCDName, row);
				grid.setCellText("", _col.territoryCD, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","RAGESPHERECD");
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
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.rageSphereCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.officeCDName) {
				grid.setCellText("", _col.teamCDName, row);
				grid.setCellText("", _col.teamCD, row);
				grid.setCellText("", _col.territoryCDName, row);
				grid.setCellText("", _col.territoryCD, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","OFFICECD");
	            table.setParameter("attrib02", grid.getCellText(_col.rageSphereCD, row));
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	            
	            if(grid.getCellText(_col.rageSphereCD, row)=="") {
	            	value[0] = "";
              		text[0] = "";
	            }
	            else {
	            	if (rowCount > 0) {
		            	for (var i=0; i < rowCount; i++) {
		              		value[i] = table.getData(0,i);
		              		text[i] = table.getData(1,i);
		              	}
		            }
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.officeCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.teamCDName) {
				grid.setCellText("", _col.territoryCDName, row);
				grid.setCellText("", _col.territoryCD, row);
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","TEAMCD");
	            table.setParameter("attrib02", grid.getCellText(_col.officeCD, row));
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	            
	            if(grid.getCellText(_col.officeCD, row)=="") {
	            	value[0] = "";
              		text[0] = "";
	            }
	            else {
		            if (rowCount > 0) {
		            	for (var i=0; i < rowCount; i++) {
		              		value[i] = table.getData(0,i);
		              		text[i] = table.getData(1,i);
		              	}
		            }
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.teamCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.territoryCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","TERRITORYCD");
	            table.setParameter("attrib02", grid.getCellText(_col.teamCD, row));
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	            
	            if(grid.getCellText(_col.teamCD, row)=="") {
	            	value[0] = "";
              		text[0] = "";
	            }
	            else {
		            if (rowCount > 0) {
		            	for (var i=0; i < rowCount; i++) {
		              		value[i] = table.getData(0,i);
		              		text[i] = table.getData(1,i);
		              	}
		            }
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.territoryCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.workStatCDName) {
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","WORKSTATCD");
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
	            list.setStyle("width","70px");
	            list.setStyle("height","100px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.workStatCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col.grpIDName) {
				
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/CMP04001A05S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","grpID;grpName;");
	            table.setParameter("dkmdTpCD", grid.getCellText(_col.dkmdTpCD, row));
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
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.grpID, row);
	            	}
	            	catch(e){}
	            };
			}
            return list;
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
	    
	    grid.onCellEditStarted = function(text, col, row){
	    };
	      
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

<script type="text/javascript">

	/**********************************************
	* fileupload setting
	**********************************************/
	
	$("#fileuploader").change(function(e) {
		var name = $("#fileuploader")[0].value;
		$("#progressReport").val(name.substring(name.lastIndexOf('\\')+1));
	});
	
	function upload() {
		if ($("#fileuploader").val() == "") {
			alert("파일을 선택해 주세요.");
		}
		else {
	        
			var linkIDVal = $("#articleID").val();
			$("#linkID").val(linkIDVal);
			
	        $("#form").ajaxForm({
	            url : "${contextPath}/service/mdm01/extractEmpXls",
	            enctype : "multipart/form-data",
	            data : 
					{},
	            error : function(){
			        this.progressReport = document.getElementById("progressReport");
			        this.progressReport.value = "Upload error.";        	
			    	alert("Upload error..");
	            },
				xhr: function() {
					var xhr = $.ajaxSettings.xhr();
					xhr.upload.onprogress = function(e) {
						var percent = Math.round(e.loaded * 100 / e.total) + "%";
						if (percent == "100%") percent = "Complete!!";
						$("#progressReport").val(percent);
					}
					return xhr;
				},            
	            success : function(data){
 					$("#fileuploader").val("");

 					SetGridData(data);
				
			  		this.progressReport = document.getElementById("progressReport");
			        this.progressReport.value = "Complete!!";
			  		
	            }
	        });
	 
	        $("#form").submit() ;
	     	
		}
	}
	
</script>
