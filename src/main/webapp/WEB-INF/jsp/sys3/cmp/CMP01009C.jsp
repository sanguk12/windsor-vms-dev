<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
       <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
       <meta http-equiv="Pragma" content="no-cache">
       <%@include file="../scripts.jsp" %>
       
	<link href="${contextPath}/css/treeview/dtree.css" rel="StyleSheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/scripts/treeview/dtree.js"></script>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<form name="form" method="post">
		<div id="wrapDiv">
        	<div id="formDiv">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					<tr>
		               	<td height="1">
		               		<%@include file="../cms/standardParam.jsp" %>
		               		
							<input type="hidden" id="menuConstructID" name="menuConstructID" value="" />
							<input type="hidden" id="menuGroupID" name="menuGroupID" value="" />
							<input type="hidden" id="grpID" name="grpID" value="${params.grpID_con}" />
							<input type="hidden" id="userID" name="userID" value="${params.userID}" />
							<input type="hidden" id="programID" name="programID" />
							<input type="hidden" id="viewPageID" name="viewPageID" />
							
						
							<%@include file="../cms/functionbar.jsp" %>
						</td>
					</tr>
					<tr>
						<td height="*">
							<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
		                  		<tr>
		                  			<td class="tb-border">
										<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
											<tr>
												<td width="160">
													<table width="150" height="100%" cellspacing="0" cellpadding="0" align="center">
														<tr>
															<td height="100%" class="tree-border" valign="top">
																<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
													                <tr>
													                    <td class="left_treetd" valign="top">
																			<div class="dtree">
																				<script type="text/javascript">
																				<!--
																					//id, pid, name, url, title, target, icon, iconOPne, open,
																					d = new dTree('d');
																					d.config.folderLinks = true;
																					d.config.closeSameLevel = false;
																					d.config.useCookies = false;
																					d.add("ROOT", -1, "${params.viewName}", "", "${params.viewName}");
																					<c:forEach items="${menuConstructTreeView}" var="item" varStatus="status">
																						d.add("${item.code}", "${item.pcode}", "${item.name}", "javascript:setValue('${params.mnuConstructID}', '${item.mnuGrpID}');searchProgram();", "${item.name}");
																					</c:forEach>		
																					document.write(d);
																				//-->
																				</script>
																				<p><a href="javascript: d.openAll();">Expand all</a> | <a href="javascript: d.closeAll();">Collapse all</a></p>
																			</div>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</td>
												<td width="*">
													<table cellspacing="0" cellpadding="1" width="100%" height="100%">
														<colgroup>
															<col style="width:50%"></col>
															<col style="width:50%"></col>
														</colgroup>
														<tbody>
														<tr>
															<td colspan="2" height="200">
																<span id="gridProgram"></span>
															</td>
														</tr>
														<tr>
															<td height="*">
																<span id="gridView"></span>
															</td>
															<td>
																<span id="gridFunction"></span>
															</td>
														</tr>
														</tbody>
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
		</div>
	</form>
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    #gridView .aw-column-0 {width: 145px;}
    #gridView .aw-column-1 {width: 145px;}
    
    #gridFunction .aw-column-0 {width: 90px;}
    #gridFunction .aw-column-1 {width: 100px;}
    #gridFunction .aw-column-2 {width: 100px;}

    #gridProgram .aw-column-0 {width: 90px;}
    #gridProgram .aw-column-1 {width: 150px;}
    #gridProgram .aw-column-2 {width: 360px;}
    
    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
    
//-->
</style>


<script type="text/javascript">

    var programID = "";
    var viewPageID = "";
    var keyIndex = 0;
    
	$(document).ready(function() {
			
		window.onload = function() {
			createGrid_program();
			createGrid_view();
			createGrid_function();
			
			gridProgram.refresh();
			gridView.refresh();
			gridFunction.refresh();
		};
	
		${initScript}
			
	});

    function Close() {
        window.close();
    }


	function Apply() {

		var rowCount = gridFunction.getRowCount();
		var useYN = new Array();
		var funcID = new Array();
		
		for(i=0; i < rowCount; i++) {
			useYN[i] = gridFunction.getCellText(4,i);
			funcID[i] = gridFunction.getCellText(3,i);
		}
		
		var table = new AW.XML.Table;
		<c:choose>
			<c:when test="${!empty params.grpID}">
				table.setURL("${contextPath}/service/auth/applyFunctionGroupAuth");
			</c:when>
			<c:otherwise>
				table.setURL("${contextPath}/service/auth/applyFunctionUserAuth");
			</c:otherwise>
		</c:choose>
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("dataActiveYN", useYN);
	  	table.setParameter("dataFuncID", funcID);
	  	table.setParameter("menuConstructID", $("#menuConstructID").val());
	  	table.setParameter("menuGroupID", $("#menuGroupID").val());
	  	table.setParameter("grpID", $("#grpID").val());
	  	table.setParameter("userID", $("#userID").val());
	  	table.setParameter("programID", $("#programID").val());
	  	table.setParameter("viewPageID", $("#viewPageID").val());
      	table.request();
      	
      	if (table.getData(0,0) == 'S') {
            message(table.getData(1,0));
        }
        else {
           alert(table.getData(1,0));
        }
	}
	
	function setValue(menuConstructID, menuGroupID) {
		
		$("#menuConstructID").val(menuConstructID);
		$("#menuGroupID").val(menuGroupID);
        
        if (gridView != null) gridView.clear();
        createGrid_view();
        if (gridFunction != null) gridFunction.clear();
        createGrid_function();
        
        gridView.refresh();
        gridFunction.refresh();
    }
    
    function searchProgram() {
    	
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0100902S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","pgmID;pgmName;pgmURL;");
        table.setParameter("mnuConstructID", $("#menuConstructID").val());
        table.setParameter("mnuGrpID", $("#menuGroupID").val());
        table.request();
        
        if (gridProgram != null) gridProgram.clear();
        createGrid_program();

        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
                data[i] = [
                    table.getData(0,i),
                    table.getData(1,i),
                    table.getData(2,i)
                ];
            }
            gridProgram.setCellData(data);
            gridProgram.setRowCount(rowCount);
        }
		else {
            message("<fmt:message key="info.nullData"/>");
        }
        gridProgram.refresh();
    }    

	var gridProgram = null;
	
    var programColumns = [
        "<fmt:message key="CMP01009C.pgmID"/>",
        "<fmt:message key="CMP01009C.pgmName"/>",
        "<fmt:message key="CMP01009C.pgmURL"/>"
    ];
    
    function createGrid_program() {
        
        gridProgram = new AW.UI.Grid;
        gridProgram.setId("gridProgram");
        gridProgram.setSelectorVisible(false);
        gridProgram.setSelectionMode("single-row");
        gridProgram.setCellEditable(false);
        gridProgram.setHeaderText(programColumns);
        for(var i=0;i<programColumns.length;i++){gridProgram.getHeaderTemplate(i).setStyle("text-align", "center");}
        gridProgram.setColumnCount(programColumns.length);
        gridProgram.setSize(300,235);
        gridProgram.setStyle("width", "100%");
        gridProgram.setCellFormat([str, str, str]);
        
        gridProgram.onRowDoubleClicked = function(event, rowIndex){
            
        	var table = new AW.XML.Table;  
            table.setURL("${contextPath}/service/simpleAction/CMP0100605S");
            table.setAsync(false);
            table.setRequestMethod("POST");
            table.setParameter("outParamKey","viewID;viewName;introYN;viewTitle;");
            table.setParameter("pgmIDs", this.getCellText(0,rowIndex));
            
            programID = this.getCellText(0,rowIndex);
            $("#programID").val(programID);
            table.request();
            
            if (gridView != null) gridView.clear();
            createGrid_view();
            
            var rowCount = table.getCount();
            if (rowCount > 0) {
                var data = new Array();
                for (var i=0; i < rowCount; i++) {
                    data[i] = [
                        table.getData(0,i),
                        table.getData(1,i)
                    ];
                }
                gridView.setCellData(data);
                gridView.setRowCount(rowCount);
            }
            gridView.refresh();
        }
    }

    var viewColumns = [
        "<fmt:message key="CMP01009C.viewID"/>",
		"<fmt:message key="CMP01009C.viewName"/>"
    ];
    
    var gridView = null;
    
    function createGrid_view() {
    
		gridView = new AW.UI.Grid; 
		gridView.setId("gridView");
		gridView.setSelectionMode("single-row"); 
	    gridView.setCellEditable(false);
	    gridView.setHeaderText(viewColumns);
	    for(var i=0;i<viewColumns.length;i++){gridView.getHeaderTemplate(i).setStyle("text-align", "center");}
	    gridView.setColumnCount(viewColumns.length);
	    gridView.setCellFormat([str, str]);
	    
	    gridView.onRowDoubleClicked = function(event, rowIndex){
	    	
	        var table = new AW.XML.Table;
	        table.setURL("${contextPath}/service/simpleAction/CMP0100903S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("outParamKey","funcID;funcCode;funcName;useYN;useYNDesc;");
	        <c:choose>
	            <c:when test="${!empty params.grpID}">
	                table.setParameter("authType", "GROUP");
	            </c:when>
	            <c:otherwise>
	                table.setParameter("authType", "USER");
	            </c:otherwise>
	        </c:choose>
	        table.setParameter("userID", "${params.userID}");
	        table.setParameter("mnuConstructID", "${params.mnuConstructID}");
	        table.setParameter("mnuGrpID", "${params.mnuGrpID}");
	        table.setParameter("pgmID", "${params.pgmID}");
	        table.setParameter("viewID", "${params.viewID}");
	        table.setParameter("menuConstructID", $("#menuConstructID").val());
	        table.setParameter("menuGroupID", $("#menuGroupID").val());
	        table.setParameter("programID", programID);
	        table.setParameter("viewPageID", this.getCellText(0, rowIndex));
	        table.setParameter("grpID", $("#grpID").val());
	        table.request();
	        
	        viewPageID = this.getCellText(0, rowIndex);
	        $("#viewPageID").val(viewPageID);
	        
	        if (gridFunction != null) gridFunction.clear();
	        createGrid_function();
	        
	        var rowCount = table.getCount();
	        if (rowCount > 0) {
	            var data = new Array();
	            for (var i=0; i < rowCount; i++) {
                    data[i] = [
                        table.getData(1,i),
                        table.getData(2,i),
                        table.getData(4,i),
                        table.getData(0,i),
                        table.getData(3,i)
                    ];
	            }
	            gridFunction.setCellData(data);
	            gridFunction.setRowCount(rowCount);
	        }
	        gridFunction.refresh();
	    }
    }
    

    var functionColumns = [
        "<fmt:message key="CMP01009C.funcCode"/>",
        "<fmt:message key="CMP01009C.funcName"/>",
        "<fmt:message key="CMP01009C.useYN"/>"
    ];

	var gridFunction = null; 
	
	function createGrid_function() {
		
		gridFunction = new AW.UI.Grid;
		gridFunction.setId("gridFunction");
		gridFunction.setSelectionMode("single-row"); 
	    gridFunction.setStyle("width", "100%");
	    gridFunction.setCellEditable(false);
		gridFunction.setHeaderText(functionColumns);
		for(var i=0;i<functionColumns.length;i++){gridFunction.getHeaderTemplate(i).setStyle("text-align", "center");}
		gridFunction.setColumnCount(functionColumns.length);
		gridFunction.setCellFormat([str, str, str]);
		
		gridFunction.setCellTemplate(new AW.Templates.Combo, 2);
		
		gridFunction.setPopupTemplate(function(col, row){  
            
            var list = new AW.UI.List;
            var table = new AW.XML.Table;
            var value = new Array();
            var text = new Array();
                 
            if (col == 2) {
                table.setURL("${contextPath}/service/simpleAction/SYS0001S");
                table.setAsync(false);
                table.setRequestMethod("POST");
                table.setParameter("outParamKey","comCode;codeName;");
                table.setParameter("codeDiv", "USETYPE1CD");
                table.request();
    
                var rowCount = table.getCount();
                if (rowCount > 0) {
                    for (i=0; i < rowCount; i++) {
                    	value[i] = table.getData(0,i);
                        text[i] = table.getData(1,i);
                    }
                }
                list.setStyle("width","100px");
                list.setStyle("height","50px");
                list.setItemText(text);
                list.setAttribute("value", value);
                list.setItemCount(text.length);            
            }
     
            list.onItemMouseDown = function(event, i) {  
                var text = this.getItemText(i);  
                var value = this.getAttribute("value");
                gridFunction.setCellText(text, col, row);  
                
                if (col == 2){ 
                	gridFunction.setCellText(value[i], 4, row);
                }
                gridFunction.getCellTemplate(col, row).hidePopup();  
            }  
            return list;
        }); 
	}
	
</script>