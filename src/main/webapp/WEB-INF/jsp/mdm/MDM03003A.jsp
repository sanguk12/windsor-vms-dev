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
							</td>
						</tr>
		                <tr>
		                	<td height="1">             
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
													<col style="width:80px"></col>
													<col style="width:200px"></col>
													<col style="width:80px"></col>
													<col></col>
												</colgroup>
												<tbody>
					                            <tr>
													<td class="td-cond">
														<fmt:message key="MDM03003A.prdNm" />
													</td>	
													<td class="td-input">
														<input type="text" id="prdNm" name="prdNm" style="width:150px;">
					                                </td>
													<td class="td-cond">
														<fmt:message key="MDM03003A.activeYN" />
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

    .aw-column-0 {width: 100px; text-align:center;} 
    .aw-column-1 {width: 100px; text-align:center;} 
    .aw-column-2 {width: 200px; } 
    .aw-column-3 {width: 100px; text-align:center;} 
    .aw-column-4 {width: 100px; text-align:right;} 
    .aw-column-5 {width: 100px; text-align:right;} 
    .aw-column-6 {width: 100px; text-align:right;} 
        
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
		};

		${initScript}
		
		$("#prdNm").keypress(function(){
			if (event.keyCode==13){
				$("#activeYN").focus();
				return false;
			}
		});
		
	});
	
</script>
	
<script type="text/javascript">


    /****************************************
	* Button Action
	****************************************/
	
	var _i = 0;
	var _col = {
		prdCD : _i++
		, prdSAPCD : _i++
		, prdNm : _i++
		, qtyUnitCDName : _i++
		, overQty : _i++
		, underQty : _i++
 		, guidAmt : _i++
	};
   
	function Search() {
    	
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/MDM0300301S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","prdCD;prdSAPCD;prdNm;qtyUnitCDName;"+
        								"overQty;underQty;guidAmt;");
        table.setParameter("format","str;str;str;str;"+
        							"num;num;num;");
        table.setParameter("prdNm", $("#prdNm").val());
        table.setParameter("activeYN", $("#activeYN").val());
        table.request();
        
//         if (grid != null) grid.clear();
        createGrid();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	data[i] = [
                	table.getData(_col.prdCD,i),              
                   	table.getData(_col.prdSAPCD,i),                
                   	table.getData(_col.prdNm,i),                
                   	table.getData(_col.qtyUnitCDName,i),                
                   	table.getData(_col.overQty,i),                
                   	table.getData(_col.underQty,i),                
                   	table.getData(_col.guidAmt,i)                
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
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "MDM0300301S");
		table.setParameter("prdNm", $("#prdNm").val());
        table.setParameter("activeYN", $("#activeYN").val());
		
		var headerText = [
			"<fmt:message key="MDM03003A.prdCD"/>",
			"<fmt:message key="MDM03003A.prdSAPCD"/>",
			"<fmt:message key="MDM03003A.prdNm"/>",
			"<fmt:message key="MDM03003A.qtyUnitCD"/>",
			"<fmt:message key="MDM03002A.overQty"/>",
			"<fmt:message key="MDM03002A.underQty"/>",
			"<fmt:message key="MDM03002A.guidAmt"/>"
		];
		
		table.setParameter("templateFile", "MDM03003A");
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
	*	Grid Setting
	*****************************************************/
    var grid = null;
    
	var columns = [
		"<fmt:message key="MDM03003A.prdCD"/>",
        "<fmt:message key="MDM03003A.prdSAPCD"/>",
        "<fmt:message key="MDM03003A.prdNm"/>",
        "<fmt:message key="MDM03003A.qtyUnitCD"/>",
        "<fmt:message key="MDM03002A.overQty"/>",
        "<fmt:message key="MDM03002A.underQty"/>",
        "<fmt:message key="MDM03002A.guidAmt"/>"
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
	    grid.setCellFormat([str,str,str,str,num,num,num]);
	    
    }
    
</script>   
