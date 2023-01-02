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
		<form name="form" method="post" id="form" enctype="multipart/form-data">
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
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
											<col style="width:100px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond">
													<fmt:message key="uploadFile"/>
												</td>
												<td class="td-input">
													<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					                           			<tr>
					                               			<td height="25" width="310">
					                                   			<div id="selectedFileDisplay">
					                                       			<input type="text" id="progressReport" value="" style="width:300px;float: left; display: inline-block;" class="file_input_textbox" readonly="readonly" >
					                                   			</div>
					                               			</td>
					                               			<td width="75"> 
					                                   			<div id="uploaderContainer" class="file_input_div">
						                                       		<input type="button" class="file_input_button" />
                                                             		<input type="file" name="fileuploader" id="fileuploader" class="file_input_hidden">                                
					                                   			</div>
					                               			</td>
					                               			<td width="*">
					                                   			<div id="uploadFilesLink">
					                                   				<a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a>
					                                   			</div>
					                               			</td>
					                           			</tr>
					                       			</table>
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
    .aw-column-1 {width: 150px; text-align:center;} 
    .aw-column-2 {width: 100px; text-align:center;} 
    .aw-column-3 {width: 100px; text-align:center;} 
    .aw-column-4 {width: 150px; text-align:right;} 
    .aw-column-5 {width: 150px; text-align:right;} 
    .aw-column-6 {width: 150px; text-align:right;} 
    
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	$(document).ready(function() {
	
		window.onload = function() {
			
			createGrid();
			grid.refresh();
		};

		${initScript}

	});
	
	//엑셀 업로드 시 데이터 세팅
	function SetGridData(xmlData) {
		var data = new Array();
		var rowCount = 0;

		createGrid();

		$(xmlData).find("rows").each(function(i) { 
			
			$(this).children().each(function(j) {
				//소수점 둘째 자리부터 내림
				var efp =  parseFloat($(this).find("efp").text());
				var duty = parseFloat($(this).find("duty").text());
				var cogs = parseFloat($(this).find("cogs").text());
				var eu = parseFloat($(this).find("eu").text());
				
				efp = efp != "0" ? Math.floor(efp*10)/10 : $(this).find("efp").text();			
				duty = duty != "0" ? Math.floor(duty *10)/10 : $(this).find("duty").text();			
				cogs = cogs != "0" ? Math.floor(cogs*10)/10 : $(this).find("cogs").text();			
				
				data[j] = [
				
					  $(this).find("prdCD").text()
					, $(this).find("prdNM").text()
					, eu
					, $(this).find("sdxYN").text()
					, efp
					, duty
					, cogs
					, $(this).find("qtyUnitCD").text()
				];
				rowCount++;
			});
			
		});

		grid.setCellData(data);
		grid.setRowCount(rowCount);
		grid.refresh();
		
		hideLoading();
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
	  , qtyUnitCD : _i++
    };
	
	//저장
	function Save() {
		var index = grid.getRowIndices();
		
		if(grid.getRowCount()==0) {
			alert("<fmt:message key="msg.upload"/>");
			return;
		}

		if (index == '') {
			index = new Array();
			
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		for (var i=0; i < index.length; i++) {
			
			if (grid.getCellText(_col.prdCD, i) == "") {
				alert("<fmt:message key="AD03001B.msg1" />"); 
				setCellFocus(grid, _col.prdCD, i); 
				return;
			}
			
			if (grid.getCellText(_col.prdNM, i) == "") {
				alert("<fmt:message key="AD03001B.msg2" />"); 
				setCellFocus(grid, _col.prdNM, i); 
				return;
			}
//			qtyUnitCD(수량단위) 사용안함
// 			if (grid.getCellText(_col.qtyUnitCD, i) == "") {
// 				alert("<fmt:message key="AD03001B.msg3" />"); 
// 				setCellFocus(grid, _col.qtyUnitName, i); 
// 				return;
// 			}

			if (grid.getCellText(_col.eu, i) == "") {
				alert("<fmt:message key="AD03001B.msg8" />"); 
				setCellFocus(grid, _col.eu, i); 
				return;
			}
			
			if (grid.getCellText(_col.sdxYN, i) == "") {
				alert("<fmt:message key="AD03001B.msg4" />"); 
				setCellFocus(grid, _col.sdxYN, i); 
				return;
			}
			
			if (grid.getCellText(_col.efp, i) == "") {
				alert("<fmt:message key="AD03001B.msg5" />"); 
				setCellFocus(grid, _col.efp, i); 
				return;
			}
			
			if (grid.getCellText(_col.duty, i) == "") {
				alert("<fmt:message key="AD03001B.msg6" />"); 
				setCellFocus(grid, _col.duty, i); 
				return;
			}
			
			if (grid.getCellText(_col.cogs, i) == "") {
				alert("<fmt:message key="AD03001B.msg7" />");
				setCellFocus(grid, _col.cogs, i); 
				return;
			}
		}

		showLoading();
		
		var prdCDs = new Array();
		var prdNMs = new Array();
		//var qtyUnitCDs = new Array();
		var sdxYNs = new Array();
		var efps = new Array();
		var dutys = new Array();
		var cogss = new Array();
		var eus = new Array();
		var count = 0;
		for (var i = 0; i < index.length; i++) {
			prdCDs[count]      = grid.getCellText(_col.prdCD, index[i]);
			prdNMs[count]      = grid.getCellText(_col.prdNM, index[i]).replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">");
			//qtyUnitCDs[count]     = grid.getCellText(_col.qtyUnitCD, index[i]);
			sdxYNs[count]  = grid.getCellText(_col.sdxYN, index[i]);
			efps[count]  = grid.getCellText(_col.efp, index[i]);
			dutys[count]    = grid.getCellText(_col.duty, index[i]);
			cogss[count] = grid.getCellText(_col.cogs, index[i]);
			eus[count] = grid.getCellText(_col.eu, index[i]);
			count++;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ad03/savePrdGrid");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("seq", parent.$("#seqCD").val());
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("prdNMs", prdNMs);
		//table.setParameter("qtyUnitCDs", qtyUnitCDs);
		table.setParameter("sdxYNs", sdxYNs);
		table.setParameter("efps", efps);
		table.setParameter("dutys", dutys);
		table.setParameter("cogss", cogss);
		table.setParameter("eus", eus);
		table.request();
		
		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
   		}
		else {
			alert(table.getData(1,0));
		}
		
		hideLoading();
	}

	//목록
	function List() {
		parent.Search();
		parent.appletClose();
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="AD03001A.prdCD"/>"
       , "<fmt:message key="AD03001A.prdNM"/>"  
       , "<fmt:message key="AD03001B.eu"/>"
       , "<fmt:message key="AD03001A.sdxYN"/>"
       , "<fmt:message key="AD03001A.efpTp"/>"
	   , "<fmt:message key="AD03001A.butyTp"/>"
       , "<fmt:message key="AD03001A.COGSTp"/>"
    ];

	var grid = null;
	
	function createGrid() {
		grid = new AW.Grid.Extended;
		
	    grid.setId("grid");
	    grid.setSize(400, 200);
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-cell");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                          str, str, str, str, str
	                        , str, str]);
	    grid.setCellEditable(true);
	    
	    //grid.setCellTemplate(new AW.Templates.Combo, _col.qtyUnitName);
	    grid.setCellTemplate(new AW.Templates.Combo, _col.sdxYN);

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

		grid.onCellEditEnded = function(text, col, row) {
			this.setCellText(text, col, row);
			this.focus();
		};
		// Cell startEdit END
	    
		grid.setPopupTemplate(function(col, row) {
			
			if (col == _col.qtyUnitName) {
		       	var table = new AW.XML.Table;
		       	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		       	table.setAsync(false);
		       	table.setRequestMethod("POST");
		        table.setParameter("outParamKey","comCode;codeName;");
		        table.setParameter("codeDiv","QTYUNITCD");
		        table.request();
		        	
		        var rowCount = table.getCount();
		        var value    = new Array();
		        var text     = new Array();

		        if (rowCount > 0) {
		         	for (var i=0; i < rowCount; i++) {
		           		value[i] = table.getData(0,i);
		           		text[i] = table.getData(1,i);
		           	}
		        }
		              	
		        var list = new AW.UI.List;
		        list.setStyle("width","100px");
		        list.setStyle("height","90px");
		        list.setItemText(text);
		        list.setAttribute("value", value);
		        list.setItemCount(text.length);
		         
		        list.onItemMouseDown = function(event, i) {
		          	try {
		           		AW.$popup.hidePopup();
				        var text = this.getItemText(i);  
				        var value = this.getAttribute("value");
				        grid.setCellText(text, col, row);  
				        grid.setCellText(value[i], _col.qtyUnitCD, row);
		           	}
		           	catch(e){}
		        };
			}
			else if (col == _col.sdxYN) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","SDXYN");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","100px");
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid.setCellText(text, col, row);  
			            grid.setCellText(value[i], _col.sdxYN, row);
	            	}
	            	catch(e){}
	            };
			}
				
           return list;
        });
		    
		    
    }
	
</script>

<script type="text/javascript">

	/**********************************************
	* fileupload setting
	**********************************************/
	
	$("#fileuploader").change(function(e) {
		var name = $("#fileuploader")[0].value;
		$("#progressReport").val(name.substring(name.lastIndexOf('\\')+1));
	});
	
	function upload() {
		if ($("#fileuploader").val() == "") {
			alert("파일을 선택해 주세요.");
		}
		else {
	        
			var linkIDVal = $("#articleID").val();
			$("#linkID").val(linkIDVal);
			
	        $("#form").ajaxForm({
	            url : "${contextPath}/service/ad03/extractPrdXls",
	            enctype : "multipart/form-data",
	            data : 
					{},
	            error : function(){
			        this.progressReport = document.getElementById("progressReport");
			        this.progressReport.value = "Upload error.";        	
			    	alert("Upload error..");
	            },
				xhr: function() {
					var xhr = $.ajaxSettings.xhr();
					xhr.upload.onprogress = function(e) {
						var percent = Math.round(e.loaded * 100 / e.total) + "%";
						if (percent == "100%") percent = "Complete!!";
						$("#progressReport").val(percent);
					}
					return xhr;
				},            
	            success : function(data){
 					$("#fileuploader").val("");

 					SetGridData(data);
				
			  		this.progressReport = document.getElementById("progressReport");
			        this.progressReport.value = "Complete!!";
			  		
	            }
	        });
	 
	        $("#form").submit() ;
	     	
		}
	}
	
</script>