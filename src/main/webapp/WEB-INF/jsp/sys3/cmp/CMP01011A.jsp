<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@include file="../scripts.jsp" %>	
</head>

<body class="yui-skin-sam" ${bodyConfig}>
   	<form name="form" method="post">
   		<div id="wrapDiv">
	    	<div id="formDiv">
   		    	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
               		<tr>
                   		<td height="1">
                   			<%@include file="../cms/standardParam.jsp" %>
                   			<input type="hidden" id="boardID" name="boardID" />
			        		<input type="hidden" id="boardName_con" name="boardName_con" />
			        		<input type="hidden" id="initAction" name="initAction" />
							
							<%@include file="../cms/functionbar.jsp" %>
	                    </td>
	                </tr>
               		<tr>
						<td height="1">             
                       		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                   				<tr>
                   					<td class="tb-border">
										<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
		                             		<colgroup>
								    			<col style="width:80px"></col>
								    			<col></col>
								    		</colgroup>
								    		<tbody>
			                            	<tr>
												<td class="td-cond">
													<fmt:message key="CMP01011A.searchWord" />
												</td>
												<td class="td-input">
													<input type="text" id="boardName" name="boardName" style="width:200px;">
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
           	</div>
		</div>
	</form>
</body>
</html>

    
<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}

    .aw-column-0 {width: 80px; text-align:center;}
    .aw-column-1 {width: 140px;}
    .aw-column-2 {width: 80px; text-align:center;}
    .aw-column-3 {width: 60px; text-align:center;}
    .aw-column-4 {width: 120px; text-align:center;}
    .aw-column-5 {width: 120px; text-align:center;}
    .aw-column-6 {width: 120px; text-align:center;}
    .aw-column-7 {width: 120px; text-align:center;}
    .aw-column-8 {width: 80px; text-align:center;}
    .aw-column-9 {width: 120px; text-align:center;}
    .aw-column-10 {width: 120px; text-align:center;}
    .aw-column-11 {width: 120px; text-align:center;}
    .aw-column-12 {width: 120px; text-align:center;}
    .aw-column-13 {width: 120px; text-align:center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
    
//-->
</style>

<script type="text/javascript">

    /****************************************
    * Function
    ****************************************/
    $(function() {
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {
		if ("${params.boardName_con}" != "") $("#boardName").val("${params.boardName_con}");
		
		window.onload = function() {
			Search();
		};

		${initScript}

		$("#boardName").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
	});
	
    /****************************************
    * Button Action
    ****************************************/
    
	function New() {
		
    	document.form.action = "${contextPath}/service/simpleCommand";
		document.form.target = "_self";
		$("#viewID").val("CMP01011B");
		$("#initAction").val("");
		$("#boardName_con").val($("#boardName").val());
        document.form.submit();
	}
	
	function Search() {
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0101101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"boardID;boardName;regDate;useYN;isBulletinTerm;"+
	  			"isAttachFile;isAnswer;isReply;boardTypeCD;isView;"+
	  			"isTop;isHot;isRecommend;isPublic;");
	    table.setParameter("format",
	    		"str;str;date;str;str;"+
	    		"str;str;str;str;str;"+
	    		"str;str;str;str;");
	  	table.setParameter("boardName", $("#boardName").val());
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
      				table.getData(5,i),
      				table.getData(6,i),
      				table.getData(7,i),
      				table.getData(8,i),
      				table.getData(9,i),
      				table.getData(10,i),
      				table.getData(11,i),
      				table.getData(12,i),
      				table.getData(13,i)
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
	var columns = [
		"<fmt:message key="CMP01011A.boardID"/>",
		"<fmt:message key="CMP01011A.boardName"/>", 
		"<fmt:message key="CMP01011A.makeDate"/>",
		"<fmt:message key="CMP01011A.isUsed"/>", 
		"<fmt:message key="CMP01011A.isBulletinTerm"/>", 
		"<fmt:message key="CMP01011A.isAttachFile"/>",
		"<fmt:message key="CMP01011A.isAnswer"/>", 
		"<fmt:message key="CMP01011A.isReply"/>", 
		"<fmt:message key="CMP01011A.boardTypeCD"/>",
		"<fmt:message key="CMP01011A.isView"/>", 
		"<fmt:message key="CMP01011A.isTop"/>", 
		"<fmt:message key="CMP01011A.isHot"/>",
		"<fmt:message key="CMP01011A.isRecommend"/>", 
		"<fmt:message key="CMP01011A.isPublic"/>"
	];

	var grid = null;

	function createGrid() {
	
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setCellFormat([str, str, str]);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setHeaderText(columns);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setCellEditable(false);
		
		grid.onRowDoubleClicked = function(event, row) {
			document.form.action = "${contextPath}/service/simpleCommand";
			document.form.target = "_self";
			$("#viewID").val("CMP01011B");
			$("#initAction").val("Search");
            $("#boardID").val(this.getCellText(0,row));

            $("#boardName_con").val($("#boardName").val());
			document.form.submit();
        };
		
	}
</script>
