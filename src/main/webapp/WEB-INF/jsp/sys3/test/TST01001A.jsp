<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML>

<html>
    <head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../scripts.jsp" %>
		
		<link rel="stylesheet" href="${contextPath}/scripts/jqwidgets/styles/jqx.base.css" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/gettheme.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/jqwidgets/jqxcore.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/jqwidgets/jqxdata.js"></script> 
		<script type="text/javascript" src="${contextPath}/scripts/jqwidgets/jqxbuttons.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/jqwidgets/jqxscrollbar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/jqwidgets/jqxmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/jqwidgets/jqxgrid.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/jqwidgets/jqxgrid.selection.js"></script> 
		<script type="text/javascript" src="${contextPath}/scripts/jqwidgets/jqxgrid.columnsresize.js"></script> 
		<script type="text/javascript" src="${contextPath}/scripts/jqwidgets/jqxtabs.js"></script>
		
    </head>

    <body class="yui-skin-sam"  ${bodyConfig}>
        <form name="form" method="post">
        	<div id="wrapDiv">
          		<div id="formDiv" >
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
														<td class="td-cond"><fmt:message key="searchWord" /></td>
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
		                    	<div id="jqxgrid"></div>
							</td>
						</tr>
		                <tr>
		                    <td height="1">
		                    </td>
		                </tr>
		                <tr>
		                    <td height="1">
			                        <div id="jqxtabs">
						                <ul>
						                    <li>기본</li>
						                    <li>기능</li>
						                </ul>            
					                    <div>
					                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
					                        	<tr style="display:none;">
								        			<td width="140"></td>
								        			<td width="150"></td>
								        			<td width="140"></td>
								        			<td width="200"></td>
								        			<td width="80"></td>
								        			<td width="*"></td>
								        		</tr>
					                            <tr>
					                                <td class="td-cond"><fmt:message key="viewID" /></td>
					                                <td class="td-input">
					                                    <input type="text" id="viewIDs" name="viewIDs" class="input-required" style="width:100px; ime-mode:disabled;" onchange="changeAttribute('viewIDs',5)">
					                                    <input type="button" id="overLap" name="overLap" value="<fmt:message key='button.Overlap'/>" />
					                                </td>
					                                <td class="td-cond"><fmt:message key="viewName" /></td>
					                                <td class="td-input">
					                                    <input type="text" id="viewName" name="viewName" class="input-required" style="width:130px" > 
					                                </td>
					                                <td class="td-cond"><fmt:message key="viewUrl" /></td>
					                                <td class="td-input">
					                                    <input type="text" id="viewURL" name="viewURL" class="input-required" style="width:160px; ime-mode:disabled;" onchange="changeAttribute('viewURL',5)"> 
					                                </td>
					                            </tr>
					                            <tr>
					                            	<td class="td-cond"><fmt:message key="appPositionCD" /></td>
					                                <td class="td-input">
					                                    <nis:selectbox id="_appPositionCD" name="_appPositionCD" defaultText="select" category="APPPOSITIONCD" />
					                                </td>
					                                <td class="td-cond"><fmt:message key="appDisRate" /></td>
					                                <td class="td-input" >
					                                    <input type="text" id="_appDisRate" name="_appDisRate" style="width:60px; ime-mode:disabled; text-align:right;" onchange="changeAttribute('_appDisRate',1)">
					                                    <nis:selectbox id="_appDisUnitCD" defaultText="select" category="APPDISUNITCD" event="" eventproc="" />
					                                </td>
					                                <td class="td-cond"><fmt:message key="useYN" /></td>
					                                <td class="td-input">
					                                    <nis:radio id="useYN" name="useYN" category="USETYPE2CD" value="Y" />
					                                </td>
					                            </tr>
					                            <tr>
					                            	<td class="td-cond"><fmt:message key="remark" /></td>
				                            		<td class="td-input" colspan="5">
				                            			<input type="text" id="remark" name="remark" style="width:600px" >
			                            			</td>
					                            </tr>
					                        </table>
					                    </div>
					                    <div>
					                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
					                            <tr>
					                                <td class="td-cond" width="320"><fmt:message key="disagreeFunction" /></td>
					                                <td class="td-input" width="25"></td>
					                                <td class="td-cond" width="*"><fmt:message key="agreeFunction" /></td>
					                            </tr>
					                            <tr>
					                                <td class="td-input" height="190"><span id="jqxgrid2"></span></td>
					                                <td class="td-input" align="center" valign="middle">
					                                	<img src="${contextPath}/images/ico/btn_arrow_right.gif" onclick="Add();" style="cursor:hand;" alt="<fmt:message key="button.Add" />"><br><br>
					                                    <img src="${contextPath}/images/ico/btn_arrow_left.gif" onclick="Remove();" style="cursor:hand;" alt="<fmt:message key="button.Remove" />">
					                                </td>
					                                <td class="td-input">
					                                    <span id="jqxgrid3"></span>
					                                </td>
					                            </tr>
					                        </table>
					                    </div>
						            </div>
		                    </td>
		                </tr>
		                <tr>
		                    <td height="5">            
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
		    var maxRow_agree = 0;
		    var maxRow_disagree = 0;
		    var theme = getTheme();
		    
		    /****************************************
			* Function
			****************************************/
			$(document).ready(function() {
				
				${initScript}
				
				window.onload = function() {
					//function showLoading() {message("");};
					//function hideLoading() {message("");};
					
					$("#jqxtabs").jqxTabs({width:'96%', height:'auto', position:'top', theme:theme});
					$('#jqxtabs').bind('selected', function (event) {
						var item = event.args.item;
						var title = $('#jqxtabs').jqxTabs('getTitleAt', item);
						message(title);
					});
					
					renderGrid();
					renderGrid2();
					renderGrid3();
					
					//New();
					
					<c:if test="${!empty params.initAction}">
					   ${params.initAction}();
					</c:if>
				};	
			});
		    
			/****************************************
			* Button Action
			****************************************/
			
		    //중복확인 버튼 생성
		    $("#overLap").jqxButton({width:'70', height:'20', theme:theme});
		    $("#overLap").bind('click', function (event) {
		        if (document.getElementById("viewIDs").value == '')
		        {
		            alert('<fmt:message key="viewlist.msg1"/>');
		            return;
		        }
		        
		        var table = new AW.XML.Table;
		        table.setURL("${contextPath}/service/simpleAction/CMP0100201S");
		        table.setAsync(false);
		        table.setRequestMethod("POST");
		        table.setParameter("viewID", document.getElementById("viewIDs").value);
		        table.request();
		        
		        var rowCount = table.getCount();
		        if (rowCount > 0) {
		            if (table.getData(0,0) != '0')
		            {
		                document.getElementById("uniqueYN").value = 'N';
		                alert('<fmt:message key="viewlist.msg2"/>');
		                document.getElementById("viewIDs").value = '';
		                document.getElementById("viewIDs").focus();
		            }
		            else
		            {
		                document.getElementById("uniqueYN").value = 'Y';
		                document.getElementById("currentViewID").value = document.getElementById("viewIDs").value;
		                alert('<fmt:message key="viewlist.msg3"/>');
		                document.getElementById("viewName").focus();
		            }
		        }
		        else
		        {
		            document.getElementById("uniqueYN").value = 'N';
		            alert('<fmt:message key="viewlist.msg4"/>');
		        }
		    });
		    
		
		    //입력항목 변경 여부 확인
		    function changeAttribute(attribute, pattern)
		    {
		        var message = "";
		        
		        switch (attribute) {
		            case "viewIDs":
		                message = "<fmt:message key="viewlist.msg5"/>";
		                break;
		            case "viewURL":
		                message = "<fmt:message key="viewlist.msg6"/>";
		                break;
		        }
		            
		        /* 
		            사용자ID 영문자 및 숫자 입력 확인
		            0 = 한글만
		            1 = 숫자만
		            2 = 영어만
		            3 = 숫자와 영어 한글만 
		            4 = 태그만
		            5 = 영어 숫자만
		        */          
		        if (!regExpCheck(document.getElementById(attribute).value,pattern))
		        {
		            if (message != '')
		            {
		                alert(message);
		            }
		            document.getElementById(attribute).value = "";
		            document.getElementById(attribute).focus();
		            return;
		        }
		        
		        // 뷰ID 가 처음 입력한 것과 다른 경우 중복확인여부 초기화
		        if (attribute == 'viewIDs' && document.getElementById(attribute).value != document.getElementById("currentViewID").value)
		        {
		            document.getElementById("uniqueYN").value = 'N';
		        }
		    }
		    
		    // add function
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
		    
		    // remove function
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
		
		    // 신규버튼 Action
		    function New()
		    {
		        $("#overLap").jqxButton({disabled:false});
		        document.getElementById("viewIDs").className = 'form-input';
		        document.getElementById("viewIDs").readOnly = false;
		        document.getElementById("uniqueYN").value = "N";
		        
		        document.getElementById("viewIDs").value = "";
		        document.getElementById("viewName").value = "";
		        document.getElementById("viewURL").value = "";
		        setRadioValue("useYN","Y");
		        document.getElementById("remark").value = "";
		        
		        document.getElementById("_appPositionCD").value = "";
		        document.getElementById("_appDisRate").value = "0";
		        document.getElementById("_appDisUnitCD").value = "";
		        
		        var table = new AW.XML.Table;
		        table.setURL("${contextPath}/service/simpleAction/CMP0100202S");
		        table.setAsync(false);
		        table.setRequestMethod("POST");
		        table.request();
		        
		        createGrid_disagree();
		        grid_disagree.refresh();
		        
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
		            grid_disagree.refresh();
		            
		            maxRow_disagree = rowCount;
		        }
		
		        var table = new AW.XML.Table;
		        table.setURL("${contextPath}/service/simpleAction/CMP0100203S");
		        table.setAsync(false);
		        table.setRequestMethod("POST");
		        table.request();
		        
		        createGrid_agree();
		        grid_agree.refresh();
		        
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
		            grid_agree.refresh();
		            
		            maxRow_agree = rowCount;
		        }
		        
		    }
		    
		    function Save()
		    {
		        if (document.getElementById("uniqueYN").value == 'N')
		        {
		            alert('<fmt:message key="viewlist.msg7"/>');
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
		        table.setParameter("viewID", document.getElementById("viewIDs").value);
		        table.setParameter("viewName", document.getElementById("viewName").value);
		        table.setParameter("viewURL", document.getElementById("viewURL").value);
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
		            
		            $("#overLap").jqxButton({disabled:true});
		            document.getElementById("viewIDs").className = 'input-readonly';
		            document.getElementById("viewIDs").readOnly = true;
		            document.getElementById("uniqueYN").value = 'Y';
		
		            Search();
		        }
		        else
		        {
		           alert(table.getData(1,0));
		        }
		    }
		    
		    function Delete() 
		    {
		        if (confirm("<fmt:message key="confirm.delete"/>")) {
		            
		            var table = new AW.XML.Table;
		            table.setURL("${contextPath}/service/view/removeView");
		            table.setAsync(false);
		            table.setRequestMethod("POST");
		            table.setParameter("viewID", document.getElementById("viewIDs").value);
		            table.request();
		            
		            if (table.getData(0,0) == 'S') {
		                message(table.getData(1,0));
		                Search();
		                New();
		            }
		            else
		            {
		               alert(table.getData(1,0));
		            }
		        }
		    }
		    	
			function Search() {
				/*
				var table = new AW.XML.Table;
			  	table.setURL("${contextPath}/service/simpleAction/CMP0100204S");
			  	table.setAsync(false);
			  	table.setRequestMethod("POST");
			  	table.setParameter("searchWord", document.getElementById("searchWord").value);
		      	table.request();
		      	
		      	grid.clear();
		      	createGrid();
		      	
		      	var rowCount = table.getCount();
		      	if (rowCount > 0) {
		      		var data = new Array();
		      		for (i=0; i < rowCount; i++) {
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
		      	*/
		      	
		      	/*
		      	$.ajax({
		      		type: "POST",
		      		url: "${contextPath}/service/simpleAction/CMP0100204S",
		      		dataType: "xml",
		      		data: {
		      			searchWord : $("#searchWord").val()
		      		},
		      		success: function(xml) {
			            var source =
			            {
			                datatype: "xml",
			                datafields: [
			                    { name: 'viewID', map: 'viewID' },
			                    { name: 'viewName', map: 'viewName' },
			                    { name: 'viewURL', map: 'viewURL' },
			                    { name: 'useYN', map: 'useYN' }
			                ],
			                root: "rows",
			                record: "row",
			                id: 'viewID',
			                localdata: xml
			                //url: "${contextPath}/service/simpleAction/CMP0100204S"
			            };
				      	
				      	var dataAdapter = new $.jqx.dataAdapter(source);
				      	
			            $("#jqxgrid").jqxGrid({ source: dataAdapter });
		      			
		      		},
		      		error: function(e) {
		      			alert('서버와의 통신이 실패했습니다.');
		      		}
		      	});
		      	*/
		      	
		      	var source = {
	                datatype: "xml",
	                datafields: [
	                    { name: 'viewID', map: 'viewID' },
	                    { name: 'viewName', map: 'viewName' },
	                    { name: 'viewURL', map: 'viewURL' },
	                    { name: 'useYN', map: 'useYN' }
	                ],
	                root: "rows",
	                record: "row",
	                id: 'viewID',
	                data: {
		      			searchWord : $("#searchWord").val()
		      		},
	                url: "${contextPath}/service/simpleAction/CMP0100204S"
	            };
		      	
		      	var dataAdapter = new $.jqx.dataAdapter(source);
		      	
	            $("#jqxgrid").jqxGrid({ source: dataAdapter });
		      	
			}
			
		</script>
		
		<script type="text/javascript">
		 
			/*****************************************************
			*	define grid / data formats define
			*****************************************************/
		    
		    // agree_Grid
		    var grid_agree = null;
		    
		    var agreeColumns = [
		        "",
		        "<fmt:message key="funcCode"/>",
		        "<fmt:message key="funcName"/>",
		        "<fmt:message key="seq"/>",
		        "<fmt:message key="parentFunctionCode"/>",
		        "<fmt:message key="command"/>" 
		    ];
		    
		    function createGrid_agree() {
		    
			    grid_agree = new AW.UI.Grid; 
			    grid_agree.setId("grid_agree");
			    grid_agree.setVirtualMode(false);
			    grid_agree.setSelectionMode("single-cell");
			    grid_agree.setSize(400,400)
			    grid_agree.setStyle("width","100%");
			    grid_agree.setStyle("height","100%");
			    grid_agree.setCellValue(false, 0);
				grid_agree.setHeaderText(agreeColumns);
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
		    
		    function renderGrid() {

	            $("#jqxgrid").jqxGrid(
	            {
	                width: "100%",
	                height: "100%",
	                //source: source,
	                theme: theme,
	                columnsresize: true,
	                columns: [
	                  { text: '뷰ID', datafield: 'viewID', width: 160 },
	                  { text: '뷰이름', datafield: 'viewName', width: 200 },
	                  { text: '뷰URL', datafield: 'viewURL', width: 320 },
	                  { text: '사용유무', datafield: 'useYN', resizable: false, width: 'auto' }
	                ]
	            });
	            
	            $("#jqxgrid").bind('columnresized', function(event) {
	            	var column = event.args.columntext;
	            	var newwidth = event.args.newwidth;
	            	var oldwidth = event.args.oldwidth;
	            	message("Column: " + column + ", New Width: " + newwidth + ", Old Width: " + oldwidth);
	            });
	            
				$("#jqxgrid").bind('rowdoubleclicked', function(event) {
	            	
	            	$("#overLap").jqxButton({disabled:true});
		            document.getElementById("viewIDs").className = 'form-readonly';
		            document.getElementById("viewIDs").readOnly = true;
		            document.getElementById("uniqueYN").value = 'Y';
		            
		            document.getElementById("viewIDs").value = this.getCellText(0,row);
		            document.getElementById("viewName").value = this.getCellText(1,row);
		            document.getElementById("viewURL").value = this.getCellData(2,row);
		            setRadioValue("useYN", this.getCellText(4,row));
		            document.getElementById("remark").value = this.getCellText(5,row);
		            
		            document.getElementById("_appPositionCD").value = this.getCellText(6,row);
		            document.getElementById("_appDisRate").value = formatNum(this.getCellText(7,row));
		            document.getElementById("_appDisUnitCD").value = this.getCellText(8,row);
		
			        var source2 = {
			                datatype: "xml",
			                datafields: [
			                    { name: 'funcCode', map: 'funcCode' },
			                    { name: 'funcName', map: 'funcName' },
			                    { name: 'seq', map: 'seq' },
			                    { name: 'funcID', map: 'funcID' },
			                    { name: 'command', map: 'command' }
			                ],
			                root: "rows",
			                record: "row",
			                id: 'viewID',
			                data: {
				      			viewID : $("#jqxgrid").jqxGrid('getrenderedrowdate', event.args.rowindex).viewID
				      		},
			                url: "${contextPath}/service/simpleAction/CMP0100205S"
			            };
				      	
			      	var dataAdapter2 = new $.jqx.dataAdapter(source2);
			      	
		            $("#jqxgrid2").jqxGrid({ source: dataAdapter2 });
		
		            
		            
			        var source3 = {
			                datatype: "xml",
			                datafields: [
			                    { name: 'funcCode', map: 'funcCode' },
			                    { name: 'funcName', map: 'funcName' },
			                    { name: 'seq', map: 'seq' },
			                    { name: 'pfuncCode', map: 'pfuncCode' },
			                    { name: 'command', map: 'command' },
			                    { name: 'funcID', map: 'funcID' }
			                ],
			                root: "rows",
			                record: "row",
			                id: 'viewID',
			                data: {
				      			viewID : $("#jqxgrid").jqxGrid('getrenderedrowdate', event.args.rowindex).viewID
				      		},
			                url: "${contextPath}/service/simpleAction/CMP0100206S"
			            };
				      	
			      	var dataAdapter3 = new $.jqx.dataAdapter(source3);
			      	
		            $("#jqxgrid3").jqxGrid({ source: dataAdapter3 });
			        
	            });
		    }
		    
		    function renderGrid2() {

	            $("#jqxgrid2").jqxGrid(
	            {
	                width: "100%",
	                height: "100%",
	                //source: source,
	                theme: theme,
	                columnsresize: true,
	                columns: [
	                  { text: '', datafield: 'viewID', width: 30 },
	                  { text: '<fmt:message key="funcCode"/>', datafield: 'viewName', width: 100 },
	                  { text: '<fmt:message key="funcName"/>', datafield: 'viewURL', width: 100 },
	                  { text: '<fmt:message key="seq"/>', datafield: 'seq', width: 'auto' }
	                ]
	            });
	            
		    }
		    
		    function renderGrid3() {

	            $("#jqxgrid3").jqxGrid(
	            {
	                width: "100%",
	                height: "100%",
	                //source: source,
	                theme: theme,
	                columnsresize: true,
	                columns: [
	                  { text: '', datafield: 'viewID', width: 30 },
	                  { text: '<fmt:message key="funcCode"/>', datafield: 'viewName', width: 100 },
	                  { text: '<fmt:message key="funcName"/>', datafield: 'viewURL', width: 100 },
	                  { text: '<fmt:message key="parentFunctionCode"/>', datafield: 'parentFunctionCode', width: 100 },
	                  { text: '<fmt:message key="command"/>', datafield: 'command', width: 'auto' }
	                ]
	            });
		    }
		</script>
    </body>
</html>