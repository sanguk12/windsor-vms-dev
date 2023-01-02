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
		<form name="form" id="form" method="post" enctype="multipart/form-data">
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
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
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

    #grid .aw-column-0 {width: 120px; text-align:center;}

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
	
	function SetGridData(xmlData) {
		var data = new Array();
		var rowCount = 0;

		createGrid();
		$(xmlData).find("rows").each(function(i) {
			$(this).children().each(function(j) {
				data[j] = [
						$(this).find("venueCD").text()
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
			  venueCD   : _i++
    };
	
	function Save() {
		var index = grid.getRowIndices();
		var venueCDs = new Array();
		var count = 0;
		
		if (grid.getRowCount() == 0) {
			alert("<fmt:message key="msg.upload"/>");
			return;
		}
		
		if (index == '') {
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}

		for (var i = 0; i < index.length; i++) {
			venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
			count++;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/mdm08/saveTmpVenueGrid_Del");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("venueCDs", venueCDs);
		table.request();
		
		if (table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			grid.clear();
			createGrid();
			grid.refresh();
			this.progressReport = document.getElementById("progressReport");
	        this.progressReport.value = "";
   		}
		else {
			alert(table.getData(1,0));
		}
		
		//hideLoading();
	}


	function List() {
		parent.Search();
		parent.appletClose();
	}
	
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var grid = null;
	var columns = [
		 "<fmt:message key="MDM08001A.venueCD"/>"
	];
	
 	function createGrid() {
		grid = new AW.Grid.Extended;
	//	grid = new AW.UI.Grid;
	    grid.setId("grid"); 
	    grid.setRowCount(0);
	    grid.setColumnCount(columns.length);
	    grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setHeaderText(columns);
		for (var i=0;i<columns.length;i++) {
	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    grid.setCellFormat([  str  ]); 
		grid.setCellEditable(true);
		
    	
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
		
		//  BEGIN validating (Enter, Cell LoseFocus)
		grid.onCellValidating = function(text, col, row) {
			if(col == _col.venueCD) {
				if(text.length>10) {
					this.setCellText(text.substring(0,10),col,row);
				}
			}
	    };
	
	    grid.onCellValidated = function(text, col, row) {
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
	    
    }
 	
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
	            url : "${contextPath}/service/mdm08/extractVenueXlsDel",
	            enctype : "multipart/form-data",
	            data : 
					{
	            	userID:"${params.empID}"
	            	},
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