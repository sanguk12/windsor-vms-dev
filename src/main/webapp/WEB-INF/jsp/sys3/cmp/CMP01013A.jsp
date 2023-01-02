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
							        			<col style="width:80px;"></col>
							        			<col style="width:150px;"></col>
							        			<col style="width:80px;"></col>
							        			<col style="width:280px;"></col>
							        			<col style="width:80px;"></col>
							        			<col></col>
							        		</colgroup>
							        		<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="CMP01013A.searchWord" />
												</td>
												<td class="td-input">
													<input type="text" id="searchWord" name="searchWord" style="width:140px;">
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01013A.period" />
												</td>
												<td class="td-input">
													<nis:calendar id="dateFrom" readOnly="yes" value="${params.firstDate}" eventproc="" /> -
													<nis:calendar id="dateTo" readOnly="yes" value="${params.currentDate}" eventproc="" />
												</td>
												<td class="td-cond">
													<fmt:message key="CMP01013A.useYN" />
												</td>
												<td class="td-input">
													<nis:selectbox id="useYN_cond" category="USETYPE1CD" defaultText="all" style="width:100px"/>
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
            		<tr>
            			<td height="1" style="padding-top:20px;">
            				<table border="0" cellspacing="0" cellpadding="0" width="100%">
								<tr>
									<td class="group-title">
										<fmt:message key="CMP01013A.newsTicker" />
									</td>
								</tr>
								<tr>
									<td class="tb-border">
										<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
											<colgroup>
							        			<col style="width:80px;"></col>
							        			<col style="width:150px;"></col>
							        			<col style="width:80px;"></col>
							        			<col style="width:280px;"></col>
							        			<col style="width:80px;"></col>
							        			<col></col>
							        		</colgroup>
							        		<tbody>
                           					<tr>
                               					<td class="td-cond">
                               						<fmt:message key="CMP01013A.newsID" />
                               					</td>
                               					<td class="td-input">
                                   					<input type="text" id="newsID" class="input-readonly" style="width:100px" readonly="readonly">
                               					</td>
                               					<td class="td-cond-required">
                               						<fmt:message key="CMP01013A.period" />
                               					</td>
                               					<td class="td-input">
                                   					<nis:calendar id="newsStartDate" readOnly="yes" value="${params.currentDate}" eventproc="" /> -
													<nis:calendar id="newsEndDate" readOnly="yes" value="${params.currentDate}" eventproc="" /> 
                               					</td>
                               					<td class="td-cond">
                               						<fmt:message key="CMP01013A.useYN" />
                               					</td>
                               					<td class="td-input">
                                   					<nis:radio id="useYN" name="useYN" category="USETYPE1CD" value="Y"/> 
                               					</td>
                           					</tr>
                           					<tr>
                               					<td class="td-cond-required">
                               						<fmt:message key="CMP01013A.newsText" />
                               					</td>
                               					<td class="td-input" colspan="3">
                                   					<input type="text" id="newsText" style="width:460px" maxlength="100">
                               					</td>
                               					<td class="td-cond">
                               						<fmt:message key="CMP01013A.url" />
                               					</td>
                               					<td class="td-input">
                                    				<input type="text" id="URL" style="width:200px; ime-mode:disabled;">
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
			</div>
		</div>
  	</form>
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    .aw-column-0 {width: 100px; text-align: center;}
    .aw-column-1 {width: 300px;}
    .aw-column-2 {width: 100px; text-align: center;}
    .aw-column-3 {width: 100px; text-align: center;}
    .aw-column-4 {width: 150px; }
    .aw-column-5 {width: 80px; text-align:center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
    
//-->
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		window.onload = function() {
			
			createGrid();
			grid.refresh();
			
			$("#searchWord").focus();
		};
	
		${initScript}
		
		$("#searchWord").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
	});  
</script>
	
<script type="text/javascript">

	/****************************************
	* Button
	****************************************/
	
	function New() {
        
		$("#newsID").val("");
        $("#newsStartDate").val("${params.currentDate}");
        $("#newsEndDate").val("${params.currentDate}");
        setRadioValue(document.form.useYN,"Y");
        $("#newsText").val("");
        $("#URL").val("");
    }
    
    function Save() {
    	
        if ($("#newsText").val() == "") {
       		alert("<fmt:message key="CMP01013A.msg1" />");
       		$("#newsText").focus();
       		return;
        }
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/newsTicker/saveNewsTicker");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("newsID", $("#newsID").val());
        table.setParameter("newsText", $("#newsText").val());
        table.setParameter("newsStartDate", $("#newsStartDate").val());
        table.setParameter("newsEndDate", $("#newsEndDate").val());
        table.setParameter("URL", $("#URL").val());
        table.setParameter("useYN", getRadioValue("useYN"));
        table.request();
        
        if (table.getData(0,0) == 'S') {
            message(table.getData(1,0));
            $("#newsID").val(table.getData(3,0));
            Search();
        }
        else {
           alert(table.getData(1,0));
        }
    }
    
    function Delete() {
    	
    	if ($("#newsID").val() == "") {
        	alert("<fmt:message key="CMP01013A.msg2" />");
        	return;
        }
        if (confirm("<fmt:message key="confirm.delete"/>")) {
            
            var table = new AW.XML.Table;
            table.setURL("${contextPath}/service/newsTicker/removeNewsTicker");
            table.setAsync(false);
            table.setRequestMethod("POST");
            table.setParameter("newsID", $("#newsID").val());
            table.request();
            
            
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
    
	function Search() {
	
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0101302S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
        table.setParameter("outParamKey","newsID;newsText;newsStartDate;newsEndDate;URL;useYN;");
        table.setParameter("format","str;str;date;date;str;str;");
        table.setParameter("searchWord", $("#searchWord").val());
        table.setParameter("dateFrom", convertDate($("#dateFrom").val()));
        table.setParameter("dateTo", convertDate($("#dateTo").val()));
        table.setParameter("useYN", $("#useYN_cond").val());
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
      				table.getData(2,i),
      				table.getData(3,i),
      				table.getData(4,i),
      				table.getData(5,i)=="Y"?"<fmt:message key="CMP01013A.use" />":"<fmt:message key="CMP01013A.noUse" />"
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	else {
      		message("<fmt:message key="info.nullData"/>");          	
      	}
      	grid.refresh();
	}
	
	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var grid = null;

	var columns = [
		"<fmt:message key="CMP01013A.newsID" />",
		"<fmt:message key="CMP01013A.newsText" />",
		"<fmt:message key="CMP01013A.newsStartDate" />", 
		"<fmt:message key="CMP01013A.newsEndDate" />", 
		"<fmt:message key="CMP01013A.url" />", 
		"<fmt:message key="CMP01013A.useYN" />"
	];
	
	function createGrid() {
	
		grid = new AW.UI.Grid;
		grid.setId("grid");
		
		grid.setSelectorWidth(40);
		grid.getSelectorTemplate().setStyle("text-align", "right");
		grid.setSelectorVisible(true);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);
		grid.setHeaderText(columns);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setColumnCount(columns.length);
		grid.setCellFormat([str, str, str, str, str, str]);
		
		grid.onRowDoubleClicked = function(event, row){
            $("#newsID").val(this.getCellText(0,row));
            $("#newsText").val(this.getCellText(1,row));
            $("#newsStartDate").val(this.getCellText(2,row));
            $("#newsEndDate").val(this.getCellText(3,row));
            $("#URL").val(this.getCellText(4,row));
            setRadioValue("useYN", this.getCellText(5,row)=="<fmt:message key="CMP01013A.use" />"?"Y":"N");
	    }
	}	
</script>