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
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:90px;"></col>
											<col style="width:120px;"></col>
											<col style="width:90px;"></col>
											<col style="width:120px;"></col>
											<col style="width:90px;"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="COM02001B.dkmdTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" />
												</td>
												<td class="td-cond">
													<fmt:message key="COM02001B.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="COM02001B.subSegmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="subSegmentCD_S" name="subSegmentCD_S" defaultText="all" category="SUBSEGMENTCD" />
				                                </td>
			                                </tr>
			                                <tr>
			                                	<td class="td-cond"
			                                		><fmt:message key="COM02001B.activeYN"/>
												</td>
												<td class="td-input">
													<nis:selectbox id="activeYN_S" name="activeYN_S" defaultText="all" category="ACTIVEYN" />
												</td>
												<td class="td-cond">
													<fmt:message key="COM02001B.addrTpCD1" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="COM02001B.addrTpCD2" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
				                                </td>
				                            </tr>
				                            <tr>
												<td class="td-cond">
													<fmt:message key="COM02001B.venueCD" />
												</td>
												<td class="td-input">
													<input type="text" id="venueCD_S" name="venueCD_S" style="width:100px;">
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="COM02001B.venueNm" />
												</td>
												<td class="td-input" colspan="3">
													<input type="text" id="venueNm_S" name="venueNm_S" style="width:100px;">
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

<!-- grid format -->
<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    .aw-row-selector {text-align: center}

    .aw-column-0 {width: 80px; text-align: center;}
	.aw-column-1 {width: 100px; text-align: center;}
	.aw-column-2 {width: 120px; text-align: left;}
	.aw-column-3 {width: 60px; text-align: center;}
	.aw-column-4 {width: 120px; text-align: left;}
	.aw-column-5 {width: 80px; text-align: left;}
	.aw-column-6 {width: 120px; text-align: left;}
	.aw-column-7 {width: 80px; text-align: center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">

	// Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>

	/****************************************
	 * Variable
	 ****************************************/
	 var totalCount = 0;
	
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
			
			if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD_S").val("${params.dkmdTpCD}");
				$("#dkmdTpCD_S").attr("disabled", true);
				$("#dkmdTpCD_S").addClass("input-readonly");
			}
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
    		
    		$("#venueNm_S").focus();
		};

		${initScript}
		
		$("#venueCD_S").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		$("#venueNm_S").keypress(function(){
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
		if(code == "") {
			$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
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
	     	$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#addrTpCD2_S").attr("disabled",false);
    		$("#addrTpCD2_S").removeClass("input-readonly");
		}
     	else {
     		$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
     	}
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
		dkmdTpCDName : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, activeYNName : _i++
		, rowNum : _i++
	};
	function PagingSearch() {
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/MDM0200101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"dkmdTpCDName;venueCD;venueNm;venueGradCDName;subSegmentCDName;"
	  			+"addrTpCD1Name;addrTpCD2Name;activeYNName;rowNum;");
		table.setParameter("format",
				"str;str;str;str;str;"
				+"str;str;str;str;");
		table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("activeYN", $("#activeYN_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("venueNm", $("#venueNm_S").val());
		//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
        table.setParameter("displayNum", $("#grid_displayNum").val());
        //Paging Parameter - END
      	table.request();
      	
//       	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
				data[i] = [
					table.getData(_col.dkmdTpCDName,i)
					, table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.activeYNName,i)
				];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      		//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/MDM0200105S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("outParamKey","totalCount;");
			table.setParameter("format","str;");
			table.request();
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo('grid', beginRowNum, endRowNum, table.getData(0,0));
      	}
      	else {
      		////Paging Function: clearPageInfo(Grid Name);
            clearPageInfo('grid');
      		message("<fmt:message key="info.nullData"/>");
      	}
      	
      	grid.refresh();
	}
    
	function Choice() {
		
		var data = {
			"venueCD":grid.getCellText(_col.venueCD, grid.getCurrentRow())
			, "venueNm":grid.getCellText(_col.venueNm, grid.getCurrentRow())
		};
		
		if(!"${params.row}" == "") {
			data.row = "${params.row}";
		}
		
		<c:if test="${!empty params.finalAction}"> 
			opener.${params.finalAction}(data);
		</c:if>
		
		window.close();
	}
	
</script>   

<script type="text/javascript">


	/*****************************************************
	*	Grid Setting
	*****************************************************/
	
	var columns = [
		"<fmt:message key="COM02001B.dkmdTpCD"/>",
		"<fmt:message key="COM02001B.venueCD"/>", 
		"<fmt:message key="COM02001B.venueNm"/>", 
		"<fmt:message key="COM02001B.venueGradCD"/>",
		"<fmt:message key="COM02001B.subSegmentCD"/>",
		"<fmt:message key="COM02001B.addrTpCD1"/>", 
		"<fmt:message key="COM02001B.addrTpCD2"/>", 
		"<fmt:message key="COM02001B.activeYN"/>"
   	];
   	
   	var grid = null;
   	function createGrid() {
   		grid = new AW.Grid.Extended;
   		grid.setId("grid");
   		grid.setCellFormat([str, str, str, str, str, str, str, str]);
   		grid.setHeaderText(columns);
   		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
   		grid.setRowCount(0);
   		grid.setColumnCount(columns.length);
   		grid.setSelectorVisible(false);
   		grid.setSelectionMode("single-row");
   		grid.setCellEditable(false);
   		grid.setFixedLeft(3);
   		
   		grid.onRowDoubleClicked = function(event, row) {
	    	Choice();
	    };
   	}
    
</script>