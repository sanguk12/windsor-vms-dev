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
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            	<tr>
                    <td height="1">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
					</td>
				</tr>				
                <tr>
                    <td height="*">
                        <span id="grid"></span>
                    </td>
                </tr>                
            </table>
       
    </body>
</html>

<!-- grid format -->
<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    .aw-row-selector {text-align: center}

    .aw-column-0 {width: 50px; text-align: center;}
	.aw-column-1 {width: 150px; text-align: center;}
	.aw-column-2 {width: 100px; text-align: center;}
	.aw-column-3 {width: 100px; text-align: center;}
	.aw-column-4 {width: 100px; text-align: center;}
	.aw-column-5 {width: 120px; text-align: right;}
	
    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style>

<script type="text/javascript">
	
	/****************************************
	* Function
	****************************************/
	var grid = null;
	
    $(function() {    	
    	
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			grid.refresh();
			Search();
		};

		${initScript}

		
	});


    /****************************************
	* Button Action
	****************************************/
   
	function Search() {
		
		var table = new AW.XML.Table;
		
	  	table.setURL("${contextPath}/service/simpleAction/COM03001A_Search");
	  	
	  	table.setAsync(false);
	  	
	  	table.setRequestMethod("POST");
	  	
		//조회조건 입력	
	  	table.setParameter("empID", "${params.userID}");
	  	
	  	table.request();
	  	
	  	createGrid();
	  	
	  	var redRows = [];
	  	var sum1 	= 0;	
	  	
	  	var rowCount = table.getCount();
	  	if (rowCount > 0) {
	  		var data = new Array();
	  		for (var i=0; i < rowCount; i++) {
	  			data[i] = [
	  			      i+1,     //순서
	  				table.getData(0,i), //inNm1  업무명
	  				table.getData(1,i), //inNm2 인센티브구분
	  				table.getData(2,i), //eventym  행사년월
	  				table.getData(3,i), //apprStateCDName 승인구분
	  				table.getData(4,i), //cnt    
	  				table.getData(5,i), //mnuGrpID  	
	  				table.getData(6,i)  //pgmID  	
	  			];	 
	  			sum1 += parseInt(unformatNum(table.getData( 4,i))); 
	  		}		  		
	  		
	  		grid.setCellData(data);
	  		grid.setRowCount(rowCount);
	  	}else {      		
      		message("<fmt:message key="info.nullData"/>");
      	}
	  	
	  	grid.setFooterText("합&nbsp;&nbsp;&nbsp;계", 1);
  		grid.setFooterText(formatNum(sum1),  5);
  		
	  	grid.refresh();
	}
    
	function Close() {
		window.close();
	}	
    
	function Choice() {		
		
		if( opener._workspace.$("#subMenuTitle") ){
			//메인외 화면			
		}else{
			//메인일때		
		}	
		
		var seq      = grid.getCellText(0, grid.getSelectedRows()); //순서
		var inNm1    = grid.getCellText(1, grid.getSelectedRows()); //업무명
		var inNm2    = grid.getCellText(2, grid.getSelectedRows()); //인센티브구분
		var eventym  = grid.getCellText(3, grid.getSelectedRows()); //행사년월
		var appNm    = grid.getCellText(4, grid.getSelectedRows()); //승인구분
		var mnuGrpID = grid.getCellText(6, grid.getSelectedRows()); //mnuGrpID
		var pgmID    = grid.getCellText(7, grid.getSelectedRows()); //pgmID
		
		if(pgmID == ""){
			alert("<fmt:message key="COM03001A.msg1"/>");
			return;
		}
		
	    var tmpURL = encodeURIComponent("${contextPath}/service/simpleCommand/?mnuGrpID="+mnuGrpID+"&pgmID="+pgmID+"&eventym="+eventym);
		opener.goMenu('sys3/cms/workspace2frame.page?mnuGrpID='+mnuGrpID.substring(0,3)+'&openProgram='+tmpURL);
		
		window.close();
		
	}


	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var columns = [
		"<fmt:message key="COM03001A.seq"/>",
		"<fmt:message key="COM03001A.inNm1"/>", 
		"<fmt:message key="COM03001A.inNm2"/>", 
		"<fmt:message key="COM03001A.eventym"/>",
		"<fmt:message key="COM03001A.apprStateCDName"/>",
		"<fmt:message key="COM03001A.cnt"/>"
   	];	
   	
   	
   	
   	function createGrid() {
   		
   		grid = new AW.Grid.Extended;
   		
   		grid.setId("grid");
   		grid.setCellFormat([str, str, str, str, str, str]);
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
	    
	    grid.setFooterVisible(true);	//HEE
		grid.setFooterCount(1);			//HEE
   	}
    
</script>