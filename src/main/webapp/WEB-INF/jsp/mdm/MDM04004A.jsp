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
						        			<col style="width:100px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:150px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:150px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="ANL01003A.eventYM" />
												</td>
												<td class="td-input" colspan="2">
													<nis:selectbox id="startYearCD_S" name="startYearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="startMonthCD_S" name="startMonthCD_S" defaultText="none" category="MONTHCD" /> ~
													<nis:selectbox id="endYearCD_S" name="endYearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="endMonthCD_S" name="endMonthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="MDM04001A.planResultTpCD" />
												</td>
				                                <td class="td-input" colspan="2">
				                                	<nis:selectbox id="planResultTpCD" name="planResultTpCD" defaultText="all" category="PLANRESULTTPCD" />
												</td>
												<td class="td-cond">
													<fmt:message key="MDM04004A.ACTIVEFLG" />
												</td>
				                                <td class="td-input" colspan="2">
				                                	<nis:selectbox id="USETYPE3CD" name="USETYPE3CD" defaultText="all" category="USETYPE3CD" />
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
					<td height="*" valign="top">
						<span id="grid"></span>
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

	.aw-column-0 {width: 150px; text-align:center;}
    .aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:center;}
    .aw-column-4 {width: 100px; text-align:center;}
    .aw-column-5 {width: 120px; text-align:center;}
    .aw-column-6 {width: 80px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

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
			
			$("#grid_displayNum").val("100");
			createGrid();
			grid.refresh();
			
			$("#startYearCD_S").val("${params.clientDate}".substring(0,4));
			$("#startMonthCD_S").val("${params.clientDate}".substring(4,6));
			$("#endYearCD_S").val("${params.clientDate}".substring(0,4));
			$("#endMonthCD_S").val("${params.clientDate}".substring(4,6));
		};

		${initScript}

	});
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getOfficeCD(code) {
		if(code=="") {
			$("#officeCD_S").val("");
			$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "OFFICECD");
	  	table.setParameter("attrib02", code);
	  	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#officeCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#officeCD_S").attr("disabled",false);
    		$("#officeCD_S").removeClass("input-readonly");
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
	
	var _i = 0;
	var _col = {
			
    };
	
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MDM0400207S");
	  	//table.setURL("${contextPath}/service/simpleAction/MDM0400209S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"FILENAME;PLANRESULTCD;STARTDATE;ENDDATE;REGEMPID;REGDATE;ACTIVEFLG;GDATID;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;str;str;str;");
	  	table.setParameter("startDate",$("#startYearCD_S").val()+$("#startMonthCD_S").val());
		table.setParameter("endDate",$("#endYearCD_S").val()+$("#endMonthCD_S").val());
		table.setParameter("planResultTpCD",$("#planResultTpCD").val());
		table.setParameter("USETYPE3CD",$("#USETYPE3CD").val());

	  	table.request();
		
		if (grid != null) grid.clear();
      	createGrid();
        maxRow = 0;
        
      	var data = new Array();
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			
      			var url=""; 
      			if(table.getData(6,i)=="Y"){
      				//url="<a href=>"+table.getData(0,i)+"</a>";
      				url = "<a href=\"javascript:fileDownload('"+table.getData(7,i)+"');\">"+
				          table.getData(0,i)+
				          "</a>";
      			}else{
      				url=table.getData(0,i);
      			}
      					
      			data[i] = [ 
						url,
   						table.getData(1,i),
   						table.getData(2,i),
   						table.getData(3,i),
   						table.getData(4,i),
   						table.getData(5,i),
	      			   	table.getData(6,i)
      			   ];
      			
      		}
      		      		
      	 	maxRow = rowCount;      		
      		//grid.setCellData(data);
      		grid.setCellText(data);
      		grid.setRowCount(rowCount);     	
      		 
      	} else {
      		message("<fmt:message key="MDM04004A.msg"/>");
      	}
      	grid.refresh();
	}
	
	function Save(){
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MDM0400207S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"GDATID;PLANRESULTCD;STARTDATE;ENDDATE;REGEMPID;REGDATE;ACTIVEFLG;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;str;str;");
	  	table.setParameter("startDate",$("#startYearCD_S").val()+$("#startMonthCD_S").val());
		table.setParameter("endDate",$("#endYearCD_S").val()+$("#endMonthCD_S").val());
		table.setParameter("planResultTpCD",$("#planResultTpCD").val());
	  	table.request();
	  	var data = new Array();
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		alert("해당스케쥴을 이미 등록되어 있습니다.");
      	}else{
      		scheduleSave();
      	} 
	}
	
	function scheduleSave(){
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mdm04/saveBatFileList");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("startDate",$("#startYearCD_S").val()+$("#startMonthCD_S").val());
		table.setParameter("endDate",$("#endYearCD_S").val()+$("#endMonthCD_S").val());
		table.setParameter("planResultTpCD",$("#planResultTpCD").val());
		
		table.request();
		
		var rowCount = table.getCount();
		if(rowCount > 0) {
			if(table.getData(0,0) == 'S') {
				message(table.getData(1, 0));
				$('#docID').val(table.getData(3, 0)); // parameter from controller
				Search();
			} else {
				alert(table.getData(1, 0));
			}
		}
		

	}
	
	 function fileDownload(GDATID) {
		 	//alert(FILENAME);
	        url = "${contextPath}/service/mdm04/downloadFile/?GDATID="+GDATID;
	        form.action = url;
	        //form.target = "downloadFrame";
	        form.submit();
	    }
	    
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	/* var _col =[
	           mvbox:0,
	           GDATID:1,
	           PLANRESULTCD:2,
	           STARTDATE:3,
	           ENDDATE:4,
	           REGEMPID:5,
	           REGDATE:6,
	           ACTIVEFLG:7
	           ] */
		
	var columns = [
		"<fmt:message key="MDM04004A.FileID"/>"/*파일ID  */
	    ,"<fmt:message key="MDM04004A.PLANRESULTCD"/>"/*구분  */
	    ,"<fmt:message key="MDM04004A.STARTDATE"/>"/*시작월  */
	    ,"<fmt:message key="MDM04004A.ENDDATE"/>"/*마감월  */
	    ,"<fmt:message key="MDM04004A.REGEMPID"/>"/*신청자  */
	    ,"<fmt:message key="MDM04004A.REGDATE"/>"/*등록일  */
	    ,"<fmt:message key="MDM04004A.ACTIVEFLG"/>"/*플래그  */
	];

	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
		
		grid.setId("grid")
		grid.setCellFormat([str, str, str, str, str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);
		
	}
	
</script>