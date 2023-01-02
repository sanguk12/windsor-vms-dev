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
								<%@include file="../sys3/cms/calendar.jsp" %>
								<input type="hidden" id="appSrc_upload" name="appSrc_upload" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD03001C" />
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
													<col style="width:150px"></col>
													<col style="width:100px"></col>
													<col style="width:200px"></col>
													<col style="width:100px"></col>
													<col></col>
												</colgroup>
												<tbody>
					                            <tr>
					                            	<td class="td-cond-required">
														<fmt:message key="AD03001A.rowNumber" />
													</td>
													<td class="td-input">
														<input type="text" id="no_S" name="no_S" style="width:100px; ime-mode:disabled; text-align:right;" maxlength="13"/>
					                                </td>
													<td class="td-cond">
														<fmt:message key="AD03001A.comment" />
													</td>
													<td class="td-input">
														<input type="text" id="comment_S" name="comment_S" style="width:180px; ime-mode:disabled; text-align:right;" maxlength="13"/>
					                                </td>
													<td class="td-cond">
														<fmt:message key="AD03001A.activeYN" />
													</td>	
													<td class="td-input" colspan="3">
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
		                <tr>
		                	<td height="1">
		                		<input type="hidden" id="seqCD" name="seqCD" />
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

    .aw-column-0 {width: 150px; text-align:center;} 
    .aw-column-1 {width: 150px; text-align:center;} 
    .aw-column-2 {width: 100px; text-align:center;} 
    .aw-column-3 {width: 100px; text-align:center;} 
    .aw-column-4 {width: 150px; text-align:right;} 
    .aw-column-5 {width: 150px; text-align:right;} 
    .aw-column-6 {width: 150px; text-align:right;} 
        
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}

</style>

<script type="text/javascript">
	
	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {

		window.onload = function() {
			
			
			createGrid();
			grid.refresh();
			
		};

		${initScript}
		
	});
	
	//클릭한 RawData 정보
	function ShowSearch() {
		
		$("#no_S").val(parent.$("#showNo").val());
		$("#no_S").attr("disabled",true);
		$("#no_S").addClass("input-readonly");
		
		$("#comment_S").val(parent.$("#showComment").val());
		$("#comment_S").attr("disabled",true);
		$("#comment_S").addClass("input-readonly");

		$("#activeYN").val(parent.$("#showActiveYN").val());
		$("#activeYN").attr("disabled",true);
		$("#activeYN").addClass("input-readonly");
	}
	

</script>
	
<script type="text/javascript">

    /****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
	   prdCD : _i++
	  , prdNM : _i++
	  , eu : _i++
	  , sdxYN : _i++
	  , efp : _i++
 	  , duty : _i++
	  , cogs : _i++
	};
   
	//조회
	function Search() {
        ShowSearch();

        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/AD0300102S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey",
        		"prdCD;prdNM;eu;sdxYN;"+
        		"efp;duty;cogs;");
        table.setParameter("format",
        		"str;str;str;str;"+
        		"str;str;str;");
        table.setParameter("seq", parent.$("#selectSeqCD").val());
        table.request();
        
        createGrid();
        
        var rowCount = table.getCount();
        
        if (rowCount > 0) {
        	var data = new Array();
            for (var i=0; i < rowCount; i++) {
            	data[i] = [
            		  table.getData(_col.prdCD,i)              
                	, table.getData(_col.prdNM,i)              
                	, table.getData(_col.eu,i)                
               		, table.getData(_col.sdxYN,i)
                	, table.getData(_col.efp,i)
                	, table.getData(_col.duty,i)               
                	, table.getData(_col.cogs,i)
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

	//엑셀 입력용 파일 다운로드
	function DownloadToInput() {
     	var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleExport/jxls");
 		table.setAsync(false); 
 		table.setRequestMethod("POST");
 		table.setParameter("queryKey", "AD0300103S");
		 
		var headerText = [
		     "<fmt:message key="AD03001A.prdCD"/>",
		     "<fmt:message key="AD03001A.prdNM"/>",  
		     "<fmt:message key="AD03001B.eu"/>",
		     "<fmt:message key="AD03001A.sdxYN"/>",
		     "<fmt:message key="AD03001A.efpTp"/>",
			 "<fmt:message key="AD03001A.butyTp"/>",
		     "<fmt:message key="AD03001A.COGSTp"/>"
		];
		
		table.setParameter("templateFile", "RAWDATA_M_E_Sample");
		table.setParameter("headerText", headerText);
		table.request();
		
		if (table.getCount() > 0) {
			
			if (table.getData(0,0) == "S") {
				
			    form.action = "${contextPath}/service/simpleExport/download/?"+
			    		"tempFile="+table.getData(3,0)+
			    		"&downloadFile=RAWDATA_M_E_Sample";
			    form.target = "downloadFrame";
			    form.submit();
			}
		}
    }
	
	//엑셀 업로드
	function ExcelUpload() {
		$("#seqCD").val(parent.$("#selectSeqCD").val());
		
		appletDiv_set({"src":$("#appSrc_upload").val(), "appPositionCD":"${params.appPositionCD}", "appDisRate":"${params.appDisRate}", "appDisUnitCD":"${params.appDisUnitCD}"});
		appletOpen();
	}
	
	//엑셀
	function Excel() {	
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "AD0300102S");
		 table.setParameter("seq", parent.$("#selectSeqCD").val());
		 
		var headerText = [
		     "<fmt:message key="AD03001A.prdCD"/>",
		     "<fmt:message key="AD03001A.prdNM"/>",  
		     "<fmt:message key="AD03001B.eu"/>",
		     "<fmt:message key="AD03001A.sdxYN"/>",
		     "<fmt:message key="AD03001A.efpTp"/>",
			 "<fmt:message key="AD03001A.butyTp"/>",
		     "<fmt:message key="AD03001A.COGSTp"/>"
		];
		
		table.setParameter("templateFile", "AD03001B");
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
	
	function List() {
		parent.Search();
		parent.appletClose();
	}
	
</script>   

<script type="text/javascript">

	/*****************************************************
	*					Grid Setting
	*****************************************************/
    var grid = null;
    
	var columns = [
        "<fmt:message key="AD03001A.prdCD"/>"
       , "<fmt:message key="AD03001A.prdNM"/>"  
       , "<fmt:message key="AD03001B.eu"/>"
       , "<fmt:message key="AD03001A.sdxYN"/>"
       , "<fmt:message key="AD03001A.efpTp"/>"
	   , "<fmt:message key="AD03001A.butyTp"/>"
       , "<fmt:message key="AD03001A.COGSTp"/>"
    ];
     //그리드 생성
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
	    for (var i=0;i<columns.length;i++) {
	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([str,str,str,str,
	    					str,str,str]);
	    
    }
    
</script>   
