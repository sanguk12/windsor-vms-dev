<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		<%@include file="../scripts.jsp" %>
	</head>

	<body onload="Search();" class="yui-skin-sam" ${bodyConfig}>
    	<form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1">
			            <!-- Standard Parameter - START -->
			            <input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
			            <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
			            <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
			            <input type="hidden" id="method" name="method">
			            <!-- Standard Information - END -->
			    
			            <!-- Function Bar - Title & Button -->
			            <%@include file="../cms/functionbar.jsp" %>
			        </td>
			    </tr>
			    <tr>
                    <td class="pd" height="1">
                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
						        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
										<tr>
											<td class="td-cond" width="70">프로그램</td>
											<td class="td-input" width="150">
												<input type="text" id="searchWord" name="searchWord" style="width:140px;" onkeypress="if (event.keyCode==13){Search(); return false;}">
											</td>
											<td class="td-cond" width="130">즐겨찾기 등록 프로그램</td>
											<td class="td-input" width="*">
												 <input type="checkbox" id="favoriteYN" style="border:0px; width=25px;" onclick="Search()">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			    <tr>
                    <td class="pd" height="*">
						<span id="grid"></span>
					</td>
                </tr>
                <tr>
                    <td height="5">
			            <!-- Action Parameter - START -->
			            <input type="hidden" id="mnuConstructID" value="${params.mnuConstructID}">
			            <input type="hidden" id="userID" value="${params.userID}">
			            <!-- Action Parameter - END -->
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>

<!-- grid format -->
<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 50px; text-align: center;}
	.aw-column-1 {width: 200px; }
	.aw-column-2 {width: 200px; }
	.aw-column-3 {width: 60px; text-align: right;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">

    /****************************************
    * Variable
    ****************************************/
    //var opener = window.dialogArguments;
    
    _col = {
        favoriteYN:0,
        mnuGrpName:1,
        pgmName:2,
        seq:3,
        activeFlg:4,
        mnuGrpID:5,
        pgmID:6
    };

	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {
		
		window.onload = function() {
			$("#searchWord").focus();
		};
	
		${initScript}
	});  
	/****************************************
	* Button Action
	****************************************/
	function Close(){
	   window.close();
	}
	
	function Save(){
	
	    var favoriteYN = new Array();
	    var mnuGrpID = new Array();
	    var pgmID = new Array();
	    var seq = new Array();
	    var activeFlg = new Array();

	    var j=0;
	    for (var i=0; i < grid.getRowCount(); i++) {
	       if (grid.getCellText(_col.activeFlg,i) != ""){
		       favoriteYN[j] = grid.getCellValue(_col.favoriteYN,i)?'Y':'N';
		       mnuGrpID[j] = grid.getCellText(_col.mnuGrpID,i);
		       pgmID[j] = grid.getCellText(_col.pgmID,i);
		       seq[j] = grid.getCellText(_col.seq,i);
		       activeFlg[j] = grid.getCellText(_col.activeFlg,i);
		       j++;
	       }
	    }
	
		var table = new AW.XML.Table;	  
	  	table.setURL("favorite.do");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("method","saveFavorite");
	  	table.setParameter("mnuConstructID", $("#mnuConstructID").val());
	  	table.setParameter("mnuGrpID", mnuGrpID);
	  	table.setParameter("pgmID", pgmID);
	  	table.setParameter("seq", seq);
	  	table.setParameter("favoriteYN", favoriteYN);
	  	table.setParameter("activeFlg", activeFlg);
	  	table.request();
      	
      	if (table.getData(0,0) == "S") {
          	Search();
      		message(table.getData(1,0));
      	}
      	else
      	{
      	    alert(table.getData(1,0));
      	}
	}
	
	function Search(){
	
		var table = new AW.XML.Table;	  
	  	table.setURL("simpleAction.do");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("returnType","List");
        table.setParameter("resultType","XML");
        table.setParameter("RFC","ZCWCOMMC05_WCM_140");
        table.setParameter("inParamKey","SEARCHWORD;MNUCONSTRUCTID;USERID;FAVORITEYN;");
        table.setParameter("outParamKey","FAVORITEYN;MNUGRPNAME;PGMNAME;SEQ;MNUGRPID;PGMID;");

        table.setParameter("MNUCONSTRUCTID", $("#mnuConstructID").val());
	  	table.setParameter("USERID", $("#userID").val());
	  	if ($("#favoriteYN").is(':checked')) {
	  		table.setParameter("FAVORITEYN", "Y");
		}
	    else {
	    	table.setParameter("FAVORITEYN","N");
	    }
	  	table.setParameter("SEARCHWORD", $("#searchWord").val());
      	table.request();
      	
      	grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (i=0; i < rowCount; i++) {
      			data[i] = [
      						"",
      						table.getData(1,i),
      						table.getData(2,i),
      						table.getData(3,i),
      						"",
      						table.getData(4,i),
      						table.getData(5,i)
      					  ];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      		for (var i=0; i<rowCount; i++){
      			if ($("#favoriteYN").is(':checked')){
      				grid.setCellValue(true, _col.favoriteYN, i);
      			}
      			else {
	      		    if (table.getData(0,i) == 'Y') {
	      		        grid.setCellValue(true, _col.favoriteYN, i);
	      		    }
      			}
      		}
      		
      	}
      	
      	grid.refresh();
	}


	
	/*****************************************************
	*	define data formats define
	*****************************************************/
	var columns = [
		"선택", "메뉴그룹", "프로그램", "순서"
	];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str, str, num]);
		grid.setHeaderText(columns);
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setHeaderHeight(20);
		grid.setSelectionMode("single-cell");
		grid.setSize(380, 400);
		grid.setStyle("width", "100%");
		grid.setStyle("height", "100%");
		grid.setCellEditable(false);
		grid.setCellEditable(true,_col.seq);
		grid.setCellTemplate(new AW.Templates.CheckBox, _col.favoriteYN);
		
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
        // Cell startEdit END

        grid.onCellClicked=function(event, col, row){
            if (col == _col.favoriteYN){
	            if (this.getCellValue(col,row)){
		            this.setCellText("U",_col.activeFlg,row);
		        }
		        else {
		        	this.setCellText("D",_col.activeFlg,row);
		        }
		    }
        };
        
    	//  BEGIN validating (Enter, Cell LoseFocus)
        grid.onCellValidating = function(text, col, row){
             if (col == _col.seq) {
                 if (!isNumber(text)) {
                    this.setCellText(0,col,row);
                    alert("<fmt:message key="invalid.numberformat.msg"/>");
                 }
             }
        }

        grid.onCellValidated = function(text, col, row){
            if (col == _col.seq) {
                grid.setCellText("U",_col.activeFlg,row);
            }
        }
        //  END validated Action (Enter, Cell LoseFocus)
	}
	
	createGrid();
	grid.refresh();
</script>

<script type="text/javascript">
<!--
	<c:if test="${!empty params.initAction}">
		${params.initAction}();
	</c:if>
//-->
</script>	
