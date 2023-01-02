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
<!-- 													<fmt:message key="COM02001D.categoryCD1" /> -->
													카테고리1
												</td>
					                           	<td class="td-input">
					                                 <nis:selectbox id="categoryCD1" defaultText="all" category="CATEGORYCD1" />
					                            </td>
					                            <td class="td-cond">
<!-- 													<fmt:message key="COM02001D.categoryCD2" /> -->
													카테고리2
												</td>	
												<td class="td-input">
													<div id="categoryCD2_cond" style="float:left;">
														<select id="categoryCD2">
															<option value=""><fmt:message key="all" /></option>
														</select>
													</div>
				                                </td>
												<td class="td-cond">
<!-- 													<fmt:message key="COM02001D.categoryCD3" /> -->
													카테고리3
												</td>	
												<td class="td-input">
													<div id="categoryCD3_cond" style="float:left;">
														<select id="categoryCD3">
															<option value=""><fmt:message key="all" /></option>
														</select>
													</div>
				                                </td>
						        			</tr>
				                           	<tr>
				                               	<td class="td-cond">
<!-- 													<fmt:message key="COM02001D.categoryCD4" /> -->
													카테고리4
												</td>
												<td class="td-input">
													<div id="categoryCD4_cond" style="float:left;">
														<select id="categoryCD4">
															<option value=""><fmt:message key="all" /></option>
														</select>
													</div>
				                                </td>
												<td class="td-cond">
<!-- 													<fmt:message key="COM02001D.categoryCD5" /> -->
													카테고리5
												</td>
												<td class="td-input">
													<div id="categoryCD5_cond" style="float:left;">
														<select id="categoryCD5">
															<option value=""><fmt:message key="all" /></option>
														</select>
													</div>
				                                </td>
				                                <td class="td-cond">
<!-- 					                           		<fmt:message key="COM02001D.activeYN" /> -->
													관리여부
				      							</td>
				      							<td class="td-input">
													<nis:selectbox id="activeYN" defaultText="all" category="ACTIVEYN" value="Y" />
					                           	</td>
				   							</tr>
				   							<tr>    
				                               	<td class="td-cond">
<!-- 													<fmt:message key="COM02001D.prdNm" /> -->
													제품명
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
                <tr>
					<td height="1">
						<input type="hidden" id="incntTpCD" name="incntTpCD" value=""/>
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
    .aw-column-4 {width: 100px; }
    .aw-column-5 {width: 80px; text-align: right;}
    .aw-column-6 {width: 80px; text-align: right;}
    .aw-column-7 {width: 80px; text-align: right;}
    .aw-column-8 {width: 80px; text-align: right;}
    .aw-column-9 {width: 80px; text-align: center;}
    .aw-column-10 {width: 80px; text-align: center;}

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
			
			$("#categoryCD2").attr("disabled",true);
			$("#categoryCD2").addClass("input-readonly");
			$("#categoryCD3").attr("disabled",true);
			$("#categoryCD3").addClass("input-readonly");
			$("#categoryCD4").attr("disabled",true);
			$("#categoryCD4").addClass("input-readonly");
			$("#categoryCD5").attr("disabled",true);
			$("#categoryCD5").addClass("input-readonly");

			if("${params.venueCD_S}" != ""){
				setIncntTpCD("${params.venueCD_S}");
			}
		};
		
		${initScript}
		
		$("#categoryCD1").change(function() {
			refresh_categoryCD2();
		});
	});

	function setIncntTpCD(venueCD_S){
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/COM02001D01S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"incntTpCD;");
	  	table.setParameter("format",
	  			"str;");
	  	table.setParameter("venueCD_S", venueCD_S);
	  	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#incntTpCD").val(table.getData(0, 0));
      	}
	}

	function refresh_categoryCD2() {
		if($("#categoryCD1").val()=="") {
			$("#categoryCD2").val("");
			$("#categoryCD2").attr("disabled",true);
    		$("#categoryCD2").addClass("input-readonly");
    		$("#categoryCD3").val("");
			$("#categoryCD3").attr("disabled",true);
    		$("#categoryCD3").addClass("input-readonly");
    		$("#categoryCD4").val("");
			$("#categoryCD4").attr("disabled",true);
    		$("#categoryCD4").addClass("input-readonly");
    		$("#categoryCD5").val("");
			$("#categoryCD5").attr("disabled",true);
    		$("#categoryCD5").addClass("input-readonly");
			return;
		}
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
            $("#categoryCD2").attr("disabled",false);
    		$("#categoryCD2").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#categoryCD2_cond").html(s);
        
        $("#categoryCD3").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
    	$("#categoryCD3").attr("disabled",true);
   		$("#categoryCD3").addClass("input-readonly");
   		$("#categoryCD4").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
    	$("#categoryCD4").attr("disabled",true);
   		$("#categoryCD4").addClass("input-readonly");
   		$("#categoryCD5").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
    	$("#categoryCD5").attr("disabled",true);
   		$("#categoryCD5").addClass("input-readonly");
	}
	
	function refresh_categoryCD3() {
		if($("#categoryCD2").val()=="") {
    		$("#categoryCD3").val("");
			$("#categoryCD3").attr("disabled",true);
    		$("#categoryCD3").addClass("input-readonly");
    		$("#categoryCD4").val("");
			$("#categoryCD4").attr("disabled",true);
    		$("#categoryCD4").addClass("input-readonly");
    		$("#categoryCD5").val("");
			$("#categoryCD5").attr("disabled",true);
    		$("#categoryCD5").addClass("input-readonly");
			return;
		}
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
            $("#categoryCD3").attr("disabled",false);
    		$("#categoryCD3").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#categoryCD3_cond").html(s);
        
        $("#categoryCD4").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
    	$("#categoryCD4").attr("disabled",true);
   		$("#categoryCD4").addClass("input-readonly");
   		$("#categoryCD5").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
    	$("#categoryCD5").attr("disabled",true);
   		$("#categoryCD5").addClass("input-readonly");
	}
	
	function refresh_categoryCD4() {
		if($("#categoryCD3").val()=="") {
    		$("#categoryCD4").val("");
			$("#categoryCD4").attr("disabled",true);
    		$("#categoryCD4").addClass("input-readonly");
    		$("#categoryCD5").val("");
			$("#categoryCD5").attr("disabled",true);
    		$("#categoryCD5").addClass("input-readonly");
			return;
		}
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
            $("#categoryCD4").attr("disabled",false);
    		$("#categoryCD4").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#categoryCD4_cond").html(s);
        
        $("#categoryCD5").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
    	$("#categoryCD5").attr("disabled",true);
   		$("#categoryCD5").addClass("input-readonly");
	}
	
	function refresh_categoryCD5() {
		if($("#categoryCD4").val()=="") {
    		$("#categoryCD5").val("");
			$("#categoryCD5").attr("disabled",true);
    		$("#categoryCD5").addClass("input-readonly");
			return;
		}
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
            $("#categoryCD5").attr("disabled",false);
    		$("#categoryCD5").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#categoryCD5_cond").html(s);
        
	}
	

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
            		"kindTpCD5Name":grid.getCellText(_col.kindTpCD5Name, index[i])
           			, "kindTpCD5":grid.getCellText(_col.kindTpCD5, index[i])
           			, "prdCD":grid.getCellText(_col.prdCD, index[i])
           			, "prdNm":grid.getCellText(_col.prdNm, index[i])
           			, "factoryPrice":grid.getCellText(_col.factoryPrice, index[i])
           			, "qtyUnitCDName":grid.getCellText(_col.qtyUnitCDName, index[i])
           			, "qtyUnitCD":grid.getCellText(_col.qtyUnitCD, index[i])
           			, "eu":grid.getCellText(_col.eu, index[i])
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
	  			"checkbox;prdCD;prdSAPCD;prdNm;prdShCD;factoryPrice;"+
	  			"ml;unit;eu;qtyUnitCDName;activeYNName;"+
	  			"kindTpCD5Name;qtyUnitCD;activeYN;kindTpCD5;"+
	  			"rowNum;totalCount;");
	  	table.setParameter("format",
				"str;str;str;str;str;num;"+
				"num;num;num5;str;str;"+
				"str;str;str;str;"+
				"num;num;");
	  	table.setParameter("categoryCD1",$("#categoryCD1").val());
       	table.setParameter("categoryCD2",$("#categoryCD2").val());
       	table.setParameter("categoryCD3",$("#categoryCD3").val());
       	table.setParameter("categoryCD4",$("#categoryCD4").val());
       	table.setParameter("categoryCD5",$("#categoryCD5").val());
       	table.setParameter("incntTpCD",$("#incntTpCD").val());
      	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
        table.setParameter("displayNum", $("#grid_displayNum").val());
        
        table.setParameter("mnuID", "${params.mnuGrpID}");
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
//         "<fmt:message key="COM02001D.barCode"/>",
//         "<fmt:message key="COM02001D.prdCD"/>",
//         "<fmt:message key="COM02001D.prdNm"/>",
//         "<fmt:message key="COM02001D.prdLTpCD"/>",
//         "<fmt:message key="COM02001D.custPrice"/>",
//         "<fmt:message key="COM02001D.supPrice"/>"

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
		, "관리여부"	
    ];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
        grid.setId("grid");
        grid.setCellFormat([str, str, str, str, str, num, num, num, num5, str, str]);
        for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
        grid.setHeaderText(columns);
        grid.setRowCount(0);
        grid.setColumnCount(columns.length);
        grid.setSelectorVisible(false);
        grid.setSelectionMode("single-cell");
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
				"kindTpCD5Name":grid.getCellText(_col.kindTpCD5Name, grid.getSelectedRows())
				, "kindTpCD5":grid.getCellText(_col.kindTpCD5, grid.getSelectedRows())
				, "prdCD":grid.getCellText(_col.prdCD, grid.getSelectedRows())
				, "prdNm":grid.getCellText(_col.prdNm, grid.getSelectedRows())
				, "factoryPrice":grid.getCellText(_col.factoryPrice, grid.getSelectedRows())
				, "qtyUnitCDName":grid.getCellText(_col.qtyUnitCDName, grid.getSelectedRows())
				, "qtyUnitCD":grid.getCellText(_col.qtyUnitCD, grid.getSelectedRows())
				, "eu":grid.getCellText(_col.eu, grid.getSelectedRows())
			};
           	
           	<c:if test="${!empty params.finalAction}"> 
    			opener.${params.finalAction}(data);
    		</c:if>
	        
	        window.close();
			
		};
	}
	
</script>