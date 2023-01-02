<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<%@include file="../scripts.jsp" %>
	<%@include file="../cms/calendar.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<form name="form" method="post">
		<div id="wrapDiv">
    		<div id="formDiv">
        		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            		<tr>
                		<td height="1">
           					<%@include file="../cms/standardParam.jsp" %>
           					<input type="hidden" id="partnerID" value="${params.rpartnerID}">
           					
           					<%@include file="../cms/functionbar.jsp" %>
       					</td>
   					</tr>
   					<tr>
                		<td height="1">
                			<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                				<tr>
                					<td class="tb-border">
		        						<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px; table-layout:fixed;">
		        							<colgroup>
		        								<col style="width:80px"></col>
		        								<col></col>
		        							</colgroup>
		        							<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01014A.searchWord" />
												</td>
												<td class="td-input">
													<input type="text" id="searchWord" style="width:200px;">
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
							<table width="100%" height="100%" border="0" cellspacing="1" cellpadding="0" style="table-layout:fixed;">
								<colgroup>
									<col style="width:310px"></col>
									<col></col>
								</colgroup>
								<tbody>
								<tr>
								  	<td height="*">
								  		<span id="grid"></span>
								  	</td>
									<td valign="top">
				                        <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
				                        	<colgroup>
							        			<col style="width:110px"></col>
							        			<col style="width:130px"></col>
							        			<col style="width:110px"></col>
							        			<col style="width:130px"></col>
							        			<col style="width:100px"></col>
							        			<col></col>
							        		</colgroup>
							        		<tbody>
					                            <tr>
					                                <td class="td-cond" height="1">
					                                    <fmt:message key="CMP01014A.widgetID" />
					                                </td>
					                                <td class="td-input">                            
					                                    <input id="widgetID" type="text" class="input-readonly" style="width:80px;" readonly="readonly">
					                                </td>
					                                <td class="td-cond">
					                                    <fmt:message key="CMP01014A.widgetName" />
					                                </td>
					                                <td class="td-input" colspan="3">
					                                    <input id="widgetName" type="text" style="width:200px;">
					                                </td>
					                            </tr>
					                            <tr>
					                                <td class="td-cond" height="1">
					                                    <fmt:message key="CMP01014A.width" />
					                                </td>
					                                <td class="td-input">                            
					                                    <input id="width" type="text" style="width:50px; ime-mode:disabled; text-align:right;">
					                                </td>
					                                <td class="td-cond">
					                                    <fmt:message key="CMP01014A.height" />
					                                </td>
					                                <td class="td-input">                            
				                                    	<input id="height" type="text" style="width:50px; ime-mode:disabled; text-align:right;">
				                                    </td>
				                                    <td class="td-cond">
				                                    	<fmt:message key="CMP01014A.x" />
				                                    </td>
				                                    <td class="td-input">                            
				                                    	<input id="x" type="text" style="width:50px; ime-mode:disabled; text-align:right;">
				                                    </td>
					                            </tr>
				                                <tr>
				                                	<td class="td-cond" height="1">
				                                    	<fmt:message key="CMP01014A.y" />
		                                          	</td>
		                                          	<td class="td-input">
		                                            	<input id="y" type="text" style="width:50px; ime-mode:disabled; text-align:right;">
		                                          	</td>
				                                    <td class="td-cond">
				                                    	<fmt:message key="CMP01014A.refreshYN" />
				                                    </td>
				                                    <td class="td-input">
					                                	<nis:radio id="refreshYN" category="USETYPE3CD" />
					                                </td>
				                                    <td class="td-cond">
				                                    	<fmt:message key="CMP01014A.interval" />
				                                    </td>
				                                    <td class="td-input">                            
				                                    	<input id="interval" type="text" style="width:50px; ime-mode:disabled; text-align:right;">
				                                        <fmt:message key="CMP01014A.sec" />
				                                    </td>
				                                </tr>
				                                <tr>    
				                                	<td class="td-cond" height="1">
				                                    	<fmt:message key="CMP01014A.useYN" />
				                                    </td>
				                                    <td class="td-input">                            
				                                    	<nis:radio id="useYN" category="USETYPE3CD" />
				                                    </td>
				                                    <td class="td-cond">
				                                    	<fmt:message key="CMP01014A.loadMethod" />
				                                    </td>
			                                        <td class="td-input" colspan="3">
			                                        	<nis:selectbox id="loadMethod" style="width:100px;" defaultText="none" category="LOADMETHODCD" />
			                                        </td>
				                                </tr>
					                            <tr>
					                            	<td class="td-cond" height="1">
					                                    <fmt:message key="CMP01014A.remark" />
					                                </td>
					                                <td class="td-input" colspan="5">
					                                    <input id="remark" type="text" style="width:400px">
					                                </td>
					                            </tr>
					                            <tr>
				                                	<td class="td-cond" height="50">
				                                    	<fmt:message key="CMP01014A.titleScript" />
				                                    </td>
				                                    <td class="td-input" colspan="5">                            
				                                    	<textarea id="titleScript" style="width:100%; height:50px; font-family:courier;"></textarea>
				                                    </td>
				                                </tr>
					                            <tr>
					                                <td class="td-cond"  height="*">
					                                    <fmt:message key="CMP01014A.bodyScript" />
					                                </td>
					                                <td class="td-input" colspan="5">
					                                    <textarea id="bodyScript" style="width:100%; height:330px; font-family:courier;"></textarea>
					                                </td>
					                            </tr>
					                        	</tbody>
				                            </table>
				                        </td>
				                    </tr>
				                    </tbody>
                    			</table>
                			</td>
            			</tr>
        			</table>
        		</div>
        	</div>
    </form>
</body>
</html>

<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center;}

	.aw-column-0 {width: 80px; text-align: center;}
	.aw-column-1 {width: 150px; }
	.aw-column-2 {width: 60px; text-align: center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">

    /****************************************
    * Variable
    ****************************************/
    $(function() {
		$("#width").numeric();
		$("#height").numeric();
		$("#x").numeric();
		$("#y").numeric();
		$("#interval").numeric();
	});
    
	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {

		window.onload = function() {
			Search();
		};

		${initScript}
		
		$("#searchWord").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		
		$("#widgetName").keypress(function(){
			if (event.keyCode==13){
				$("#width").focus();
				return false;
			}
		});
		
		$("#width").keypress(function(){
			if (event.keyCode==13){
				$("#height").focus();
				return false;
			}
		});
		
		$("#height").keypress(function(){
			if (event.keyCode==13){
				$("#x").focus();
				return false;
			}
		});
		
		$("#x").keypress(function(){
			if (event.keyCode==13){
				$("#y").focus();
				return false;
			}
		});
		
		$("#y").keypress(function(){
			if (event.keyCode==13){
				$("#interval").focus();
				return false;
			}
		});
		
		$("#interval").keypress(function(){
			if (event.keyCode==13){
				$("#loadMethod").focus();
				return false;
			}
		});
		
		$("#loadMethod").keypress(function(){
			if (event.keyCode==13){
				$("#remark").focus();
				return false;
			}
		});
		
		$("#remark").keypress(function(){
			if (event.keyCode==13){
				$("#titleScript").focus();
				return false;
			}
		});
		
		$("#titleScript").keypress(function(){
			if (event.keyCode==13){
				$("#bodyScript").focus();
				return false;
			}
		});
	});
	

	function rowSearch(row) {
	
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/CMP0101401S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","widgetID;widgetName;titleScript;bodyScript;width;height;x;y;refreshYN;interval;useYN;remark;loadMethod;");
	  	table.setParameter("partnerID", $("#partnerID").val());
	  	table.setParameter("widgetID", grid.getCellText(_col.widgetID, row));
	  	table.setParameter("userID", "");
      	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#widgetID").val(table.getData(0,0));
      		$("#widgetName").val(table.getData(1,0));
      		$("#titleScript").val(table.getData(2,0));
      		$("#bodyScript").val(table.getData(3,0));
      		$("#width").val(table.getData(4,0));
      		$("#height").val(table.getData(5,0));
      		$("#x").val(table.getData(6,0));
      		$("#y").val(table.getData(7,0));
      		setRadioValue("refreshYN", table.getData(8,0));
      		$("#interval").val(table.getData(9,0));
      		setRadioValue("useYN", table.getData(10,0));
      		$("#remark").val(table.getData(11,0));
      		$("#loadMethod").val(table.getData(12,0));
      	}
	}
	
	/****************************************
	* Button Action
	****************************************/
	function Preview(){
	
	   if ($("#widgetID").val() == "") {
	       alert('<fmt:message key="CMP01014A.msg1"/>');
	       return;
	   }
    
       var url = "${contextPath}/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
                    "&viewID=CMP01014B"+
                    "&widgetID="+$("#widgetID").val()+
                    "&titleScript="+$("#titleScript").val()+
                    "&loadMethod="+$("#loadMethod").val()+
                    "&width="+$("#width").val()+
                    "&height="+$("#height").val()+
                    "&x="+$("#x").val()+
                    "&y="+$("#y").val();

        newWindow(url, "CMP01014B",1000,600,"yes");
    }
    
	function Delete(){
	
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/widget/removeWidget");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("widgetID", $("#widgetID").val());
      	table.request();
      	
      	if (table.getData(0,0) == "S") {
      		Search();
      		New();
      		message(table.getData(1,0));
      	}
      	else {
      	    alert(table.getData(1,0));
      	}
	}
	
	function New() {
		
		$("#widgetID").val("");
        $("#widgetName").val("");
        $("#titleScript").val("");
        $("#bodyScript").val("");
        $("#width").val("");
        $("#height").val("");
        $("#x").val("");
        $("#y").val("");
        setRadioValue("refreshYN", "N");
        $("#interval").val("");
        setRadioValue("useYN", "Y");
        $("#remark").val("");
        $("#loadMethod").val("");
	}
	
	function Save() {
	
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/widget/saveWidget");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("partnerID", $("#partnerID").val());
	  	table.setParameter("widgetID", $("#widgetID").val());
	  	table.setParameter("widgetName", $("#widgetName").val());
	  	table.setParameter("titleScript", $("#titleScript").val());
	  	table.setParameter("bodyScript", $("#bodyScript").val());
	  	table.setParameter("width", $("#width").val());
	  	table.setParameter("height", $("#height").val());
	  	table.setParameter("x", $("#x").val());
	  	table.setParameter("y", $("#y").val());
	  	table.setParameter("refreshYN", getRadioValue("refreshYN"));
	  	table.setParameter("interval", $("#interval").val());
	  	table.setParameter("useYN", getRadioValue("useYN"));
	  	table.setParameter("remark", $("#remark").val());
	  	table.setParameter("loadMethod", $("#loadMethod").val());
      	table.request();
      	
      	if (table.getData(0,0) == "S") {
      		$("#widgetID").val(table.getData(3,0));
      		Search();
      		message(table.getData(1,0));
      	}
      	else {
      	    alert(table.getData(1,0));
      	}
	}
	
	function Search(){
	
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/CMP0101401S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","widgetID;widgetName;useYN;");
	  	table.setParameter("partnerID", $("#partnerID").val());
	  	table.setParameter("userID", '');
	  	table.setParameter("searchWord", $("#searchWord").val());
      	table.request();
      	
      	if (grid != null) grid.clear();
      	createGrid();
      	
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
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	}
      	grid.refresh();
	}


	
	/*****************************************************
	*	Grid Setting
	*****************************************************/
    var _col = {
        "widgetID":0,
        "widgetName":1,
        "useYN":2
    };
	  
	var columns = [
		"<fmt:message key="CMP01014A.widgetID"/>",
		"<fmt:message key="CMP01014A.widgetName"/>", 
		"<fmt:message key="CMP01014A.useYN"/>"
	];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);
		
		grid.onRowDoubleClicked = function(event, index){
			rowSearch(index);
		};
	}
	
</script>