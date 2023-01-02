<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		<%@include file="../sys3/scripts.jsp" %>
		<%@include file="../sys3/cms/calendar.jsp" %>
	</head>

    <body class="yui-skin-sam" ${bodyConfig}>
    	<form name="form" method="post">
    		<div id="wrapDiv" class="pd-l">
          		<div id="formDiv">
		            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            	<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/functionbar.jsp" %>
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MDM03001B" />
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
													<col style="width:200px"></col>
													<col style="width:100px"></col>
													<col style="width:200px"></col>
													<col style="width:100px"></col>
													<col></col>
												</colgroup>
												<tbody>
					                            <tr>
													<td class="td-cond">
														<fmt:message key="MDM03001A.categoryCD1" />
													</td>
													<td class="td-input">
														<nis:selectbox id="categoryCD1" defaultText="all" category="CATEGORYCD1" />
					                                </td>
													<td class="td-cond">
														<fmt:message key="MDM03001A.categoryCD2" />
													</td>	
													<td class="td-input">
														<div id="categoryCD2_cond" style="float:left;">
															<select id="categoryCD2" style="width:180px;">
																<option value=""><fmt:message key="all" /></option>
															</select>
														</div>
					                                </td>
													<td class="td-cond">
														<fmt:message key="MDM03001A.categoryCD3" />
													</td>	
													<td class="td-input">
														<div id="categoryCD3_cond" style="float:left;">
															<select id="categoryCD3" style="width:180px;">
																<option value=""><fmt:message key="all" /></option>
															</select>
														</div>
					                                </td>
					                            </tr>
					                            <tr>    
													<td class="td-cond">
														<fmt:message key="MDM03001A.categoryCD4" />
													</td>
													<td class="td-input">
														<div id="categoryCD4_cond" style="float:left;">
															<select id="categoryCD4" style="width:180px;">
																<option value=""><fmt:message key="all" /></option>
															</select>
														</div>
					                                </td>
													<td class="td-cond">
														<fmt:message key="MDM03001A.dkRivalTpCD" />
													</td>
													<td class="td-input">
														<nis:selectbox id="dkRivalTpCD" defaultText="all" category="DKRIVALTPCD" />
					                                </td>
													<td class="td-cond">
														<fmt:message key="MDM03001A.activeYN" />
													</td>
													<td class="td-input">
														<nis:selectbox id="activeYN" defaultText="all" category="ACTIVEYN" />
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
				${appletDiv}
			</div>
        </form>
    </body>
</html>

<!-- grid format -->
<style type="text/css">
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

    .aw-column-0 {width: 80px; } 
    .aw-column-1 {width: 150px; } 
    .aw-column-2 {width: 100px; } 
    .aw-column-3 {width: 150px; } 
    .aw-column-4 {width: 100px; } 
    .aw-column-5 {width: 90px; text-align:center;} 
    .aw-column-6 {width: 90px; text-align:center;} 
    .aw-column-7 {width: 150px; } 
    .aw-column-8 {width: 120px; } 
    .aw-column-9 {width: 90px; text-align:right;} 
    .aw-column-10 {width: 60px; text-align:right;} 
    .aw-column-11 {width: 60px; text-align:right;} 
    .aw-column-12 {width: 60px; text-align:center;} 
    .aw-column-13 {width: 60px; text-align:center;} 
    .aw-column-14 {width: 60px; text-align:center;} 
    .aw-column-15 {width: 90px; text-align:center;} 
    .aw-column-16 {width: 90px; }
    .aw-column-17 {width: 90px; }
    .aw-column-18 {width: 90px; } 
    .aw-column-19 {width: 90px; } 
    .aw-column-20 {width: 90px; } 
    .aw-column-21 {width: 80px; text-align:center;} 
    .aw-column-22 {width: 140px; text-align:center;} 
    .aw-column-23 {width: 60px; text-align:right;} 
    .aw-column-24 {width: 100px; text-align:right;}
    .aw-column-25 {width: 100px; text-align:right;}
    .aw-column-26 {width: 100px; text-align:right;}
    .aw-column-27 {width: 100px; text-align:right;}
        
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}

</style>

<script type="text/javascript">
	
	/****************************************
	* Function
	****************************************/
    $(function() {
		//$("#EXAMPLE").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			grid.refresh();
			//alert(222);
			$("#categoryCD2").attr("disabled",true);
    		$("#categoryCD2").addClass("input-readonly");
    		$("#categoryCD3").attr("disabled",true);
    		$("#categoryCD3").addClass("input-readonly");
    		$("#categoryCD4").attr("disabled",true);
    		$("#categoryCD4").addClass("input-readonly");
		};

		${initScript}
		
	});
	//jj
	$("#categoryCD1").change(function() {
		//alert($("#categoryCD1").val());
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
        var s = "<select id='categoryCD2' style='width:180px;' onchange='refresh_categoryCD3()'><option value=''><fmt:message key="all"/></option>";
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
	});
	
	function refresh_categoryCD3() {
		if($("#categoryCD2").val()=="") {
    		$("#categoryCD3").val("");
			$("#categoryCD3").attr("disabled",true);
    		$("#categoryCD3").addClass("input-readonly");
    		$("#categoryCD4").val("");
			$("#categoryCD4").attr("disabled",true);
    		$("#categoryCD4").addClass("input-readonly");
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
        var s = "<select id='categoryCD3' style='width:180px;' onchange='refresh_categoryCD4()'><option value=''><fmt:message key="all"/></option>";
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
	}
	
	function refresh_categoryCD4() {
		if($("#categoryCD3").val()=="") {
    		$("#categoryCD4").val("");
			$("#categoryCD4").attr("disabled",true);
    		$("#categoryCD4").addClass("input-readonly");
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
        var s = "<select id='categoryCD4' style='width:180px;'><option value=''><fmt:message key="all"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            $("#categoryCD4").attr("disabled",false);
    		$("#categoryCD4").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#categoryCD4_cond").html(s);
        
	}

</script>
	
<script type="text/javascript">


    /****************************************
	* Button Action
	****************************************/
	
	var _i = 0;
	var _col = {
		categoryCD1Name : _i++
		, categoryCD2Name : _i++
		, categoryCD3Name : _i++
		, categoryCD4Name : _i++
		, categoryCD5Name : _i++
 		, prdCD : _i++
		, prdSAPCD : _i++
		, prdNm : _i++
		, prdShCDName : _i++
		, factoryPrice : _i++
 		, ml : _i++
 		, unit : _i++
		, eu : _i++
		, sdxYNName : _i++
		, qtyUnitCDName : _i++
		, dkRivalTpCDName : _i++
		, kindTpCD1Name : _i++
		, kindTpCD2Name : _i++
		, kindTpCD3Name : _i++
		, kindTpCD4Name : _i++
		, kindTpCD5Name : _i++
		, activeYNName : _i++
		, angelPrd16CD : _i++
		, angelPrdMlCD : _i++
		, gsv : _i++
		, wsdc : _i++
		, cogs : _i++
		, duty : _i++
	};
   
	function Search() {
    	
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/MDM0300101S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey",
        		"categoryCD1Name;categoryCD2Name;categoryCD3Name;categoryCD4Name;categoryCD5Name;"+
        		"prdCD;prdSAPCD;prdNm;prdShCDName;factoryPrice;"+
        		"ml;unit;eu;sdxYNName;qtyUnitCDName;"+
        		"dkRivalTpCDName;kindTpCD1Name;kindTpCD2Name;kindTpCD3Name;kindTpCD4Name;"+
        		"kindTpCD5Name;activeYNName;angelPrd16CD;angelPrdMlCD;"+
        		"gsv;wsdc;cogs;duty;");
        table.setParameter("format",
        		"str;str;str;str;str;"+
        		"str;str;str;str;num;"+
        		"num;num;num5;str;str;"+
        		"str;str;str;str;str;"+
        		"str;str;str;num;"+
        		"num2;num2;num2;num2;");
        table.setParameter("categoryCD1", $("#categoryCD1").val());
        table.setParameter("categoryCD2", $("#categoryCD2").val());
        table.setParameter("categoryCD3", $("#categoryCD3").val());
        table.setParameter("categoryCD4", $("#categoryCD4").val());
        table.setParameter("dkRivalTpCD", $("#dkRivalTpCD").val());
        table.setParameter("activeYN", $("#activeYN").val());
        table.request();
        
        createGrid();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	data[i] = [
                	table.getData(_col.categoryCD1Name,i),              
                   	table.getData(_col.categoryCD2Name,i),              
                   	table.getData(_col.categoryCD3Name,i),                
                    table.getData(_col.categoryCD4Name,i),  
                   	table.getData(_col.categoryCD5Name,i),
                   	table.getData(_col.prdCD,i),               
                   	table.getData(_col.prdSAPCD,i),                
                   	table.getData(_col.prdNm,i),                
                   	table.getData(_col.prdShCDName,i),                
                   	table.getData(_col.factoryPrice,i),                
                   	table.getData(_col.ml,i),                
                   	table.getData(_col.unit,i),                
                   	table.getData(_col.eu,i),                
                   	table.getData(_col.sdxYNName,i),                
                   	table.getData(_col.qtyUnitCDName,i),                
                   	table.getData(_col.dkRivalTpCDName,i),                
                   	table.getData(_col.kindTpCD1Name,i),                
                   	table.getData(_col.kindTpCD2Name,i),                
                   	table.getData(_col.kindTpCD3Name,i),                
                   	table.getData(_col.kindTpCD4Name,i),                
                   	table.getData(_col.kindTpCD5Name,i),                
                   	table.getData(_col.activeYNName,i),                
                   	table.getData(_col.angelPrd16CD,i),                
                   	table.getData(_col.angelPrdMlCD,i),
                   	table.getData(_col.gsv,i),
                   	table.getData(_col.wsdc,i),
                   	table.getData(_col.cogs,i),
                   	table.getData(_col.duty,i)
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
	
	function New() {
		$("#_detail")[0].contentWindow.New();
		appletOpen();
	}	
	
	function Excel() {	
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "MDM0300101S");
		table.setParameter("categoryCD1", $("#categoryCD1").val());
        table.setParameter("categoryCD2", $("#categoryCD2").val());
        table.setParameter("categoryCD3", $("#categoryCD3").val());
        table.setParameter("categoryCD4", $("#categoryCD4").val());
        table.setParameter("dkRivalTpCD", $("#dkRivalTpCD").val());
        table.setParameter("activeYN", $("#activeYN").val());
		 
		var headerText = [
			"<fmt:message key="MDM03001A.categoryCD1"/>", 
			"<fmt:message key="MDM03001A.categoryCD2"/>", 
			"<fmt:message key="MDM03001A.categoryCD3"/>", 
			"<fmt:message key="MDM03001A.categoryCD4"/>", 
			"<fmt:message key="MDM03001A.categoryCD5"/>", 
			"<fmt:message key="MDM03001A.prdCD"/>",       
			"<fmt:message key="MDM03001A.prdSAPCD"/>",    
			"<fmt:message key="MDM03001A.prdNm"/>",       
			"<fmt:message key="MDM03001A.prdShCD"/>",     
			"<fmt:message key="MDM03001A.factoryPrice"/>",
			"<fmt:message key="MDM03001A.ml"/>",          
			"<fmt:message key="MDM03001A.unit"/>",        
			"<fmt:message key="MDM03001A.eu"/>",          
			"<fmt:message key="MDM03001A.sdxYN"/>",       
			"<fmt:message key="MDM03001A.qtyUnitCD"/>",   
			"<fmt:message key="MDM03001A.dkRivalTpCD"/>", 
			"<fmt:message key="MDM03001A.kindTpCD1"/>",   
			"<fmt:message key="MDM03001A.kindTpCD2"/>",   
			"<fmt:message key="MDM03001A.kindTpCD3"/>",   
			"<fmt:message key="MDM03001A.kindTpCD4"/>",   
			"<fmt:message key="MDM03001A.kindTpCD5"/>",
			"<fmt:message key="MDM03001A.activeYN"/>",
			"<fmt:message key="MDM03001A.angelPrd16CD"/>",
			"<fmt:message key="MDM03001A.angelPrdMlCD"/>",
			"<fmt:message key="MDM03001A.gsv"/>",
			"<fmt:message key="MDM03001A.wsdc"/>",
			"<fmt:message key="MDM03001A.cogs"/>",
			"<fmt:message key="MDM03001A.duty"/>"
		];
		
		table.setParameter("templateFile", "MDM03001A");
		table.setParameter("headerText", headerText);
		table.request();
		
		if (table.getCount() > 0) {
			if (table.getData(0,0) == "S") {
			    form.action = "${contextPath}/service/simpleExport/download/?"+
			    		"tempFile="+table.getData(3,0)+
			    		"&downloadFile=${params.viewName}";
			    form.target = "_self";
			    form.submit();
			}
		}
	}	
</script>   

<script type="text/javascript">

	/*****************************************************
	*					Grid Setting
	*****************************************************/
    var grid = null;
    
	var columns = [
        "<fmt:message key="MDM03001A.categoryCD1"/>",
        "<fmt:message key="MDM03001A.categoryCD2"/>",  
        "<fmt:message key="MDM03001A.categoryCD3"/>",
        "<fmt:message key="MDM03001A.categoryCD4"/>",
        "<fmt:message key="MDM03001A.categoryCD5"/>",
		"<fmt:message key="MDM03001A.prdCD"/>",
        "<fmt:message key="MDM03001A.prdSAPCD"/>",
        "<fmt:message key="MDM03001A.prdNm"/>",
        "<fmt:message key="MDM03001A.prdShCD"/>",
        "<fmt:message key="MDM03001A.factoryPrice"/>",
        "<fmt:message key="MDM03001A.ml"/>",
        "<fmt:message key="MDM03001A.unit"/>",
        "<fmt:message key="MDM03001A.eu"/>",
        "<fmt:message key="MDM03001A.sdxYN"/>",
        "<fmt:message key="MDM03001A.qtyUnitCD"/>",
        "<fmt:message key="MDM03001A.dkRivalTpCD"/>",
        "<fmt:message key="MDM03001A.kindTpCD1"/>",
        "<fmt:message key="MDM03001A.kindTpCD2"/>",
        "<fmt:message key="MDM03001A.kindTpCD3"/>",
        "<fmt:message key="MDM03001A.kindTpCD4"/>",
        "<fmt:message key="MDM03001A.kindTpCD5"/>",
        "<fmt:message key="MDM03001A.activeYN"/>",
        "<fmt:message key="MDM03001A.angelPrd16CD"/>",
        "<fmt:message key="MDM03001A.angelPrdMlCD"/>",
		"<fmt:message key="MDM03001A.gsv"/>",
		"<fmt:message key="MDM03001A.wsdc"/>",
		"<fmt:message key="MDM03001A.cogs"/>",
		"<fmt:message key="MDM03001A.duty"/>"
    ];
     
    function createGrid() {
    
	    grid = new AW.UI.Grid;
	    grid.setId("grid");
	    grid.setSize(400, 290);
	    grid.setRowCount(0);
	    grid.setHeaderHeight(20);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-row");
	    grid.setCellEditable(false);
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([str,str,str,str,str, str,str,str,str,num, num,num,num5,str,str, str,str,str,str,str, str,str,str,num, num2,num2,num2,num2]);
	    
	    grid.onRowDoubleClicked = function(event, row){
			appletOpen();
			$("#_detail")[0].contentWindow.$("#prdCD").val(grid.getCellText(_col.prdCD,row));
			$("#_detail")[0].contentWindow.Search();
	    }
    }
    
</script>   
