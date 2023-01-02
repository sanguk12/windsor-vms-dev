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
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:100px"></col>
											<col style="width:250px"></col>
											<col style="width:150px"></col>
											<col style="width:200px"></col>
											<col style="width:150px"></col>
											<col></col>
										</colgroup>
										<tbody>
				                            <tr>
					                  			<td class="td-cond">
													<fmt:message key="COM02001C.categoryCD1" />
												</td>
					                           	<td class="td-input">
					                                 <nis:selectbox id="categoryCD1" defaultText="select" category="CATEGORYCD1" />
					                            </td>
					                            <td class="td-cond">
													<fmt:message key="COM02001C.categoryCD2" />
												</td>	
												<td class="td-input">
													<div id="categoryCD2_cond" style="float:left;">
														<select id="categoryCD2">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
				                                </td>
												<td class="td-cond">
													<fmt:message key="COM02001C.categoryCD3" />
												</td>	
												<td class="td-input">
													<div id="categoryCD3_cond" style="float:left;">
														<select id="categoryCD3">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
				                                </td>
						        			</tr>
				                           	<tr>
				                               	<td class="td-cond">
													<fmt:message key="COM02001C.categoryCD4" />
												</td>
												<td class="td-input">
													<div id="categoryCD4_cond" style="float:left;">
														<select id="categoryCD4">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
				                                </td>
												<td class="td-cond">
													<fmt:message key="COM02001C.categoryCD5" />
												</td>
												<td class="td-input">
													<div id="categoryCD5_cond" style="float:left;">
														<select id="categoryCD5">
															<option value=""><fmt:message key="select" /></option>
														</select>
													</div>
				                                </td>
				                                <td class="td-cond">
					                           		<fmt:message key="COM02001C.activeYN" />
				      							</td>
				      							<td class="td-input">
													<nis:selectbox id="activeYN" defaultText="select" category="ACTIVEYN" />
					                           	</td>
				   							</tr>
				   							<tr>    
				                               	<td class="td-cond">
													<fmt:message key="COM02001C.prdNm" />
												</td>
												<td class="td-input" colspan="5">
													<input type="text" id="prdNm" name="prdNm" style="width:300px; ime-mode:disabled;">
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
		  </table>
       </div>
  	</div>
</body>
</html>

<style type="text/css">
<!--
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

    .aw-column-0 {width: 80px; text-align: center;}
    .aw-column-1 {width: 80px; text-align: center;}
    .aw-column-2 {width: 200px; }
    .aw-column-3 {width: 100px; }
    .aw-column-4 {width: 80px; text-align: right;}
    .aw-column-5 {width: 80px; text-align: right;}
    .aw-column-6 {width: 80px; text-align: right;}
    .aw-column-7 {width: 80px; text-align: right;}
    .aw-column-8 {width: 80px; text-align: center;}
    .aw-column-9 {width: 80px; text-align: center;}

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
		
		$("#categoryCD1").change(function() {
			refresh_categoryCD2();
		});
	});
	
	
	function refresh_categoryCD2() {
		
		var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "CATEGORYCD2");
        table.setParameter("attrib02", $("#categoryCD1").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='categoryCD2' onchange='refresh_categoryCD3()'><option value=''><fmt:message key="all"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#categoryCD2_cond").html(s);
        
        var init_categoryCD3 = "<select id='categoryCD3' style='width:100px;' onchange='refresh_categoryCD4()'><option value=''><fmt:message key="all"/></option></select>";
        $("#categoryCD3_cond").html(init_categoryCD3);
	}
	
	function refresh_categoryCD3() {
		
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "CATEGORYCD3");
        table.setParameter("attrib02", $("#categoryCD2").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='categoryCD3' onchange='refresh_categoryCD4()'><option value=''><fmt:message key="all"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#categoryCD3_cond").html(s);
        
        var init_categoryCD4 = "<select id='categoryCD4' style='width:100px;'><option value=''><fmt:message key="all"/></option></select>";
        $("#categoryCD4_cond").html(init_categoryCD4);
	}
	
	function refresh_categoryCD4() {
		
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "CATEGORYCD4");
        table.setParameter("attrib02", $("#categoryCD3").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='categoryCD4' onchange='refresh_categoryCD5()'><option value=''><fmt:message key="all"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#categoryCD4_cond").html(s);
        
        var init_categoryCD5 = "<select id='categoryCD5' style='width:100px;'><option value=''><fmt:message key="all"/></option></select>";
        $("#categoryCD5_cond").html(init_categoryCD5);
        
	}
	
	function refresh_categoryCD5() {
		
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "CATEGORYCD5");
        table.setParameter("attrib02", $("#categoryCD4").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='categoryCD5'><option value=''><fmt:message key="all"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
        }
        s = s + '</select>';
        
        $("#categoryCD5_cond").html(s);
        
	}
	

	/****************************************
	* Button Action
	****************************************/
	
	function Choice() {
		var data = {
		  "kindTpCD5Name":grid.getCellText(_col.kindTpCD5Name, grid.getCurrentRow()),
		  "kindTpCD5":grid.getCellText(_col.kindTpCD5, grid.getCurrentRow()),
		  "prdCD":grid.getCellText(_col.prdCD, grid.getCurrentRow()),
		  "prdNm":grid.getCellText(_col.prdNm, grid.getCurrentRow()),
		  "factoryPrice":unformatNum(grid.getCellText(_col.factoryPrice, grid.getCurrentRow())),
		  "qtyUnitCDName":grid.getCellText(_col.qtyUnitCDName, grid.getCurrentRow()),
		  "qtyUnitCD":grid.getCellText(_col.qtyUnitCD, grid.getCurrentRow())
		};
		
		<c:if test="${!empty params.finalAction}"> 
			opener.${params.finalAction}(data);
		</c:if>
		window.close();
	}
	
	var _i = 0;
	var _col = {
		prdCD : _i++
		, prdSAPCD : _i++
		, prdNm : _i++
		, prdShCD : _i++
		, factoryPrice : _i++
 		, ml : _i++
 		, unit : _i++
		, eu : _i++
		, qtyUnitCDName : _i++
		, activeYNName : _i++
		, kindTpCD5Name : _i++
		, qtyUnitCD : _i++
		, activeYN : _i++
		, kindTpCD5 : _i++
		, rowNum : _i++
		, totalCount : _i++
	};

	function Search() {
		
		$("#grid_pageNum").val("1");
		PagingSearch();
	}
	
	function PagingSearch(){
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/COM02001C01S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"prdCD;prdSAPCD;prdNm;prdShCD;factoryPrice;"+
	  			"ml;unit;eu;qtyUnitCDName;activeYNName;"+
	  			"kindTpCD5Name;qtyUnitCD;activeYN;kindTpCD5;"+
	  			"rowNum;totalCount;");
	  	table.setParameter("format",
				"str;str;str;str;num;"+
				"num;num;num5;str;str;"+
				"str;str;str;str;"+
				"num;num;");
	  	table.setParameter("categoryCD1",$("#categoryCD1").val());
       	table.setParameter("categoryCD2",$("#categoryCD2").val());
       	table.setParameter("categoryCD3",$("#categoryCD3").val());
       	table.setParameter("categoryCD4",$("#categoryCD4").val());
       	table.setParameter("categoryCD5",$("#categoryCD5").val());
       	table.setParameter("activeYN",$("#activeYN").val());
       	table.setParameter("prdNm",$("#prdNm").val());
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
      				        table.getData(_col.prdCD,i)
      				        , table.getData(_col.prdSAPCD,i)
      				        , table.getData(_col.prdNm,i)
      				        , table.getData(_col.prdShCD,i)
      				        , table.getData(_col.factoryPrice,i)
      				        , table.getData(_col.ml,i)
      				        , table.getData(_col.unit,i)
      				        , table.getData(_col.eu,i)
      				        , table.getData(_col.qtyUnitCDName,i)
      				        , table.getData(_col.activeYNName,i)
      				        , table.getData(_col.kindTpCD5Name,i)
      				        , table.getData(_col.qtyUnitCD,i)
      				        , table.getData(_col.activeYN,i)
      				        , table.getData(_col.kindTpCD5,i)
      				];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      		//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
      		setPageInfo('grid', table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
      	} else {
      		////Paging Function: clearPageInfo(Grid Name);
            clearPageInfo('grid');
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
        "<fmt:message key="COM02001C.prdCD"/>"
        , "<fmt:message key="COM02001C.prdSAPCD"/>"
        , "<fmt:message key="COM02001C.prdNm"/>"
        , "<fmt:message key="COM02001C.prdShCD"/>"
        , "<fmt:message key="COM02001C.factoryPrice"/>"
        , "<fmt:message key="COM02001C.ml"/>"
        , "<fmt:message key="COM02001C.unit"/>"
        , "<fmt:message key="COM02001C.eu"/>"
        , "<fmt:message key="COM02001C.qtyUnitCD"/>"
        , "<fmt:message key="COM02001C.activeYN"/>"
    ];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
        grid.setId("grid");
        grid.setCellFormat([str, str, str, str, num, num, num, num5, str, str]);
        for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
        grid.setHeaderText(columns);
        grid.setRowCount(0);
        grid.setColumnCount(columns.length);
        grid.setSelectorVisible(false);
        grid.setSelectionMode("single-cell");
        grid.setCellEditable(false);
		
		grid.onRowDoubleClicked = function(event, row) {
			Choice();
		};
		
		// event : enter key
		var keyEvent = grid.getEvent("onkeypress");
	    grid.setEvent("onkeypress", function(e, rowIndex) {    	
			if(event.keyCode==13){
				Choice();
			} else {
				keyEvent.call(this, event);
				event.returnValue = false;
			}
	    });
	}
	
</script>