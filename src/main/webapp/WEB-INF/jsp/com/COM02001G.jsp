<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
	</head>

    <body class="yui-skin-sam" ${bodyConfig}>
    	<form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            	<tr>
                    <td height="1">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
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
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="COM02001G.addrTpCD1Name" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1" name="addrTpCD1" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" style="width:120px;" />
				                                </td>
				                                <td class="td-cond">
				                                	<fmt:message key="COM02001G.addrTpCD2Name" />
												</td>
												<td class="td-input">
												    <div id="addrTpCD2_cond" style="float:left;">
														<select id="addrTpCD2" style="width:120px;" onChange="javascript:getAddrTpCD3(this.value)">
															<option value=""><fmt:message key="all" /></option>
														</select>
													</div>		
										        </td>
											</tr>
											<tr>
				                                <td class="td-cond">
				                                	<fmt:message key="COM02001G.addrTpCD3Name" />
				                                </td>
				                                <td class="td-input" colspan="3">
				                                   	<select id="addrTpCD3" style="width:120px;">
															<option value=""><fmt:message key="all" /></option>
													</select>
													<input type="text" id="addrTpCD4" name="addrTpCD4" style="width:150px;">
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
                    <td class="td-paging">
                        <nis:paging id="grid" titleDisable="no" callback="PagingSearch()"/>
                    </td>
                </tr>
                <tr>
                	<td height="1">
                	</td>
                </tr>
            </table>
        </form>
    </body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}
	
    .aw-column-0 {width: 100px;  text-align:left;}
    .aw-column-1 {width: 120px; text-align:left;}
    .aw-column-2 {width: 130px; text-align:left;}
    .aw-column-3 {width: 190px; text-align:left;}
        
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}

</style>

<script type="text/javascript">

	//Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	* Function
	****************************************/
	
    $(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			$("#grid_displayNum").val("20");
			
			createGrid();
			grid.refresh();
			
			if("${params.addrTpCD1}"!="") {
				$("#addrTpCD1").val("${params.addrTpCD1}");
	    		getAddrTpCD2("${params.addrTpCD1}");
	    		$("#addrTpCD3").attr("disabled",true);
	    		$("#addrTpCD3").addClass("input-readonly");
			}else {
				$("#addrTpCD2").attr("disabled",true);
	    		$("#addrTpCD2").addClass("input-readonly");
	    		$("#addrTpCD3").attr("disabled",true);
	    		$("#addrTpCD3").addClass("input-readonly");
			}
			
			if("${params.addrTpCD2}"!="") {
				$("#addrTpCD2").val("${params.addrTpCD2}");
				getAddrTpCD3("${params.addrTpCD2}");
	    		$("#addrTpCD3").attr("disabled",true);
	    		$("#addrTpCD3").addClass("input-readonly");
			}else {
				$("#addrTpCD3").attr("disabled",true);
	    		$("#addrTpCD3").addClass("input-readonly");
			}
			
			if("${params.addrTpCD3}"!="") {
				$("#addrTpCD3").val("${params.addrTpCD3}");	
				$("#addrTpCD3").attr("disabled",false);
				$("#addrTpCD3").removeClass("input-readonly");
			}
			
			if("${params.addrTpCD4}"!="") {
				$("#addrTpCD4").val("${params.addrTpCD4}");					
			}			
			
			if("${params.addrTpCD1}"!="" || "${params.addrTpCD2}"!="" || "${params.addrTpCD3}"!="" || "${params.addrTpCD4}"!="") {
				Search();
			}
		};

		${initScript}
		
		$("#addrTpCD4").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});		
		
	});
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getAddrTpCD2(code) {
		
		$("#addrTpCD2").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
		$("#addrTpCD3").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
		$("#addrTpCD4").val("");
		$("#addrTpCD3").attr("disabled",true);
		$("#addrTpCD3").addClass("input-readonly");
				
		if(code == "") {
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "ADDRTPCD2");
	  	table.setParameter("attrib02", code);
     	table.request();
		
     	if(table.getCount() > 0) {
	     	
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#addrTpCD2").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#addrTpCD2").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#addrTpCD2").attr("disabled",false);
    		$("#addrTpCD2").removeClass("input-readonly");
		}
	}
	
	function getAddrTpCD3(code) {
		
		$("#addrTpCD3").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
		$("#addrTpCD4").val("");
		
		if(code == "") {
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "ADDRTPCD3");
	  	table.setParameter("attrib02", code);
     	table.request();
		
     	if(table.getCount() > 0) {
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#addrTpCD3").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#addrTpCD3").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#addrTpCD3").attr("disabled",false);
    		$("#addrTpCD3").removeClass("input-readonly");
		}
	}
	
	function getAddrTpCD4(code) {		
		$("#addrTpCD4").val("");
	}
	
</script>    
	
<script type="text/javascript">


    /****************************************
	* Button Action
	****************************************/
   
	function Search() {
		$("#grid_pageNum").val("1");
		PagingSearch();
	}
    
	function Close() {
		window.close();
	}
	
	var _i = 0;
    var _col = {
    	  addrTpCD1Name : _i++
   		, addrTpCD2Name : _i++
   		, addrTpCD3Name : _i++
   		, addrTpCD4Name : _i++
   		, addrTpCD1 : _i++
   		, addrTpCD2 : _i++
   		, addrTpCD3 : _i++
   		, addrTpCD4 : _i++
   		, rowNum : _i++
   		, totalCount : _i++
    };
	function PagingSearch() {
		if($("#addrTpCD1").val()=="" && $("#addrTpCD2").val()=="" && $("#addrTpCD3").val()=="" && $("#addrTpCD4").val()=="" ) {
			alert("<fmt:message key="COM02001G.msg1"/>");
			return;
		}
		
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/COM02001G01S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","addrTpCD1Name;addrTpCD2Name;addrTpCD3Name;addrTpCD4Name;addrTpCD1;addrTpCD2;addrTpCD3;addrTpCD4;rowNum;totalCount;");
		table.setParameter("format","str;str;str;str;str;str;str;str;str;str;");
	  	table.setParameter("addrTpCD1", $("#addrTpCD1").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2").val());
	  	table.setParameter("addrTpCD3", $("#addrTpCD3").val());
	  	table.setParameter("addrTpCD4", $("#addrTpCD4").val());
		
	  	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
        table.request();

        createGrid();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	data[i] = [
                	  table.getData(_col.addrTpCD1Name,i)
                   	, table.getData(_col.addrTpCD2Name,i)
                   	, table.getData(_col.addrTpCD3Name,i)
                   	, table.getData(_col.addrTpCD4Name,i)
                   	, table.getData(_col.addrTpCD1,i)
                   	, table.getData(_col.addrTpCD2,i)
                   	, table.getData(_col.addrTpCD3,i)
                   	, table.getData(_col.addrTpCD4,i)
            	];
            }
            grid.setCellData(data);
            grid.setRowCount(rowCount);
            
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
            setPageInfo("grid", table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
        }
        else {
        	message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
		}
        grid.refresh();
	}
	
	function Choice() {
		
		var data = {
			  "addrTpCD1":grid.getCellText(_col.addrTpCD1, grid.getSelectedRows())
			, "addrTpCD2":grid.getCellText(_col.addrTpCD2, grid.getSelectedRows())
			, "addrTpCD3":grid.getCellText(_col.addrTpCD3, grid.getSelectedRows())
			, "addrTpCD4":grid.getCellText(_col.addrTpCD4, grid.getSelectedRows())
			, "addrTpCD1Name":grid.getCellText(_col.addrTpCD1Name, grid.getSelectedRows())
			, "addrTpCD2Name":grid.getCellText(_col.addrTpCD2Name, grid.getSelectedRows())
			, "addrTpCD3Name":grid.getCellText(_col.addrTpCD3Name, grid.getSelectedRows())
			, "addrTpCD4Name":grid.getCellText(_col.addrTpCD4Name, grid.getSelectedRows())
		}
		
		if("${params.gridRow}"=="") {
			<c:if test="${!empty params.finalAction}"> 
				opener.${params.finalAction}(data);
			</c:if>
		}
		else {
			<c:if test="${!empty params.finalAction}"> 
				opener.${params.finalAction}(data, "${params.gridRow}");
			</c:if>
		}
		
		window.close();
	}
	
</script>   

<script type="text/javascript">


	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var grid = null;
	
	var columns = [
		  "<fmt:message key="COM02001G.addrTpCD1Name"/>"
		, "<fmt:message key="COM02001G.addrTpCD2Name"/>"
		, "<fmt:message key="COM02001G.addrTpCD3Name"/>"
		, "<fmt:message key="COM02001G.addrTpCD4Name"/>"
	];
    
	function createGrid() {
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str]);
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setHeaderHeight(20);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setSelectionMode("single-row");
		grid.setStyle("width","100%");
		grid.setStyle("height","100%");
		grid.setCellEditable(false);
	    
	    grid.onRowDoubleClicked = function(event, row) {
	    	Choice();
	    };
    }
    
</script>