<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<%@include file="../sys3/scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<div id="wrapDiv">
    	<div id="formDiv">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" style="padding-bottom:5px;">
                <tr>
                    <td height="1">
						<%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
                    </td>
                </tr>
                <tr>
					<td height="1">             
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:100px"></col>
											<col style="width:100px"></col>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
				   							<tr>
					   							<td class="td-cond">
	                           						<fmt:message key="MDM03001B.kindTpCD5" />
      											</td>
      											<td class="td-input">
      												<nis:selectbox id="kindTpCD5" defaultText="select" category="KINDTPCD5" />
	                           					</td>
				                               	<td class="td-cond">
													제품명
												</td>
												<td class="td-input" colspan="3">
													<input type="text" id="prdNm" name="prdNm" style="width:200px; ime-mode:disabled;">
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
                    </td>
                </tr>
                <tr>
					<td height="1">
						<!--  <input type="hidden" id="incntTpCD" name="incntTpCD" value=""/> -->
					</td>
				</tr>
		  </table>
       </div>
  	</div>
</body>
</html>

<style type="text/css">
<!--
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

    .aw-column-0 {width: 35px; text-align: center;}
    .aw-column-1 {width: 80px; text-align: center;}
    .aw-column-2 {width: 80px; text-align: center;}
    .aw-column-3 {width: 200px; }

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
	
	/****************************************
	* Function
	****************************************/
    $(function() {
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			$("#grid_displayNum").val("100");
			createGrid();
			grid.refresh();
			
		};
		
		${initScript}
		
		$("#prdNm").keypress(function(){
			if (event.keyCode==13){
				if($("#prdNm").val()!="") {
					Search();
				}
			}
		});
		
	});

	/****************************************
	* Button Action
	****************************************/
	
	function Choice() {
		var index = grid.getRowIndices();
		if (index == '') { //Grid 의 데이터와 DataSource 의 데이터가 갯수 및 위치가 동일할 때
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
        for(var i=0; i < index.length; i++) {
            if (grid.getCellValue(_col.checkbox, index[i])) {   // CheckBox : true 일때
            	
            	var data = {
           			 "prdCD":grid.getCellText(_col.prdCD, index[i])
           			, "kindTpCD5":grid.getCellText(_col.kindTpCD5, index[i])
					, "prdNm":grid.getCellText(_col.prdNm, index[i])
					, "EFP":grid.getCellText(_col.EFP, index[i])
					, "duty":grid.getCellText(_col.duty, index[i])
					, "COGS":grid.getCellText(_col.COGS, index[i])
					, "eu":grid.getCellText(_col.eu, index[i])
					, "sdxYN":grid.getCellText(_col.sdxYN, index[i])
					, "seq":grid.getCellText(_col.seq, index[i])
           		};
            	
            	<c:if test="${!empty params.finalAction}"> 
	    			opener.${params.finalAction}(data);
	    		</c:if>
            }
        }
        
        window.close();
	}
	
	var _i = 0;
	var _col = {
		checkbox : _i++	
		, prdCD : _i++
		, kindTpCD5 : _i++
		, prdNm : _i++
		, EFP : _i++
		, duty : _i++
		, COGS : _i++
		, eu : _i++
		, sdxYN : _i++
		, seq : _i++
	};

	function Search(){
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/AD0100103S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;prdCD;kindTpCD5;prdNm;EFP;" +
	  			"duty;COGS;eu;sdxYN;seq;");
	  	table.setParameter("format",
				"str;str;str;str;str;"+
				"str;str;str;str;str;");
		table.setParameter("prdNm",$("#prdNm").val());
		table.setParameter("kindTpCD5", $("#kindTpCD5").val());
        //Paging Parameter - END
      	table.request();
      	
//       	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
      			           ""
      				        , table.getData(_col.prdCD,i)
      				        , table.getData(_col.kindTpCD5,i)
      				        , table.getData(_col.prdNm,i)
      				        , table.getData(_col.EFP,i)
      				        , table.getData(_col.duty,i)
      				        , table.getData(_col.COGS,i)
      				        , table.getData(_col.eu,i)
      				        , table.getData(_col.sdxYN,i)
      				        , table.getData(_col.seq,i)
      				];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	}
      	grid.refresh();
	}
	
	function Close() {
		window.close();
	}
	
    /*****************************************************
	*	Grid
	*****************************************************/
    
	var columns = [
//         "<fmt:message key="COM02001D.barCode"/>",
//         "<fmt:message key="COM02001D.prdCD"/>",
//         "<fmt:message key="COM02001D.prdNm"/>",
//         "<fmt:message key="COM02001D.prdLTpCD"/>",
//         "<fmt:message key="COM02001D.custPrice"/>",
//         "<fmt:message key="COM02001D.supPrice"/>"
/*
		""
		, "제품코드"
		, "Material Code"	
		, "제품명"	
		, "제품약어"	
		, "출고가"	
		, "용량"	
		, "Unit"	
		, "1EU"	
		, "수량단위"	
		, "관리여부"*/
		
		""
		, "제품코드"
		, "분류"
		, "제품명"	
    ];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
        grid.setId("grid");
        grid.setCellFormat([str, str, str, str, str, str, str, str, str, str]);
        for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
        grid.setHeaderText(columns);
        grid.setRowCount(0);
        grid.setColumnCount(columns.length);
        grid.setSelectorVisible(false);
        grid.setSelectionMode("single-row");
        grid.setCellEditable(false);
        
        grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
        grid.setCellValue(false, _col.checkbox);
		
        grid.setHeaderTemplate(new AW.Templates.CheckBox, _col.checkbox);
        grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
        grid.onHeaderClicked=function(event,col){
			if (col == _col.checkbox && this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(true, _col.checkbox);
			}
			else if (col == _col.checkbox && !this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(false, _col.checkbox);
			}
			return false;
		};
		
		grid.onRowDoubleClicked = function(event, row) {
			var data = {
				 "prdCD":grid.getCellText(_col.prdCD, grid.getSelectedRows())
				, "kindTpCD5":grid.getCellText(_col.kindTpCD5, grid.getSelectedRows())
				, "prdNm":grid.getCellText(_col.prdNm, grid.getSelectedRows())
				, "EFP":grid.getCellText(_col.EFP, grid.getSelectedRows())
				, "duty":grid.getCellText(_col.duty, grid.getSelectedRows())
				, "COGS":grid.getCellText(_col.COGS, grid.getSelectedRows())
				, "eu":grid.getCellText(_col.eu, grid.getSelectedRows())
				, "sdxYN":grid.getCellText(_col.sdxYN, grid.getSelectedRows())
				, "seq":grid.getCellText(_col.seq, grid.getSelectedRows())
			};
           	
           	<c:if test="${!empty params.finalAction}"> 
    			opener.${params.finalAction}(data);
    		</c:if>
	        
	        window.close();
			
		};
	}
	
</script>