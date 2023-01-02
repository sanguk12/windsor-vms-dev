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
				
				data[j] = [
					  $(this).find("chainCD").text()
					, $(this).find("venueCD").text()
				];
				rowCount++;
			});
			
		});

		grid.setCellData(data);
		grid.setRowCount(rowCount);
		grid.refresh();
		
// 		hideLoading();
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		chainCD : _i++
	  , venueCD : _i++
    };
	
	//저장
	function Save() {
		var index = grid.getRowIndices();
		var count = 0;
		var countTmp = 0;
		var chainCDs = new Array();
		var venueCDs = new Array();
		var venueTmpCDs = new Array();
		var venueTmp = "";
		var currElem = "";
		var rowNum = 0;
		var ovarLap = false;
		
		
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

			if (grid.getCellText(_col.chainCD, i) == "") {
				alert("<fmt:message key="AD04001A.msg2" />"); 
				setCellFocus(grid, _col.chainCD, i); 
				return;
			}
			
			if (grid.getCellText(_col.venueCD, i) == "") {
				alert("<fmt:message key="AD04001A.msg4" />"); 
				setCellFocus(grid, _col.venueCD, i); 
				return;
			}
			
			venueTmpCDs[i] = grid.getCellText(_col.venueCD, index[i]);
		}
		
		for (var i = 0; i < venueTmpCDs.length; i++) {
			var currElem = venueTmpCDs[i];
			
			for (var j = i + 1; j < venueTmpCDs.length; j++) {
 				if (currElem == venueTmpCDs[j]) {
 					venueTmp = currElem;
 					rowNum = i;
 					ovarLap = true;
				}
			}
		}
		
		if (ovarLap) {
			alert(venueTmp + " 업소는 중복됩니다.");
			setCellFocus(grid, _col.venueCD, rowNum); 
			return;
		} 
		
		for (var i = 0; i < index.length; i++) {
			chainCDs[count]      = grid.getCellText(_col.chainCD, index[i]);
			venueCDs[count]      = grid.getCellText(_col.venueCD, index[i]);
			count++;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/ad04/saveChainVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("chainCDs", chainCDs);
		table.setParameter("venueCDs", venueCDs);
		table.request();
		
		if (table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			List();
   		}
		else {
			alert(table.getData(1,0));
		}
		
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
		"<fmt:message key="AD04001A.chainCD"/>"
	  , "<fmt:message key="AD04001A.venueCD"/>"  
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
	    for (var i = 0; i < columns.length; i++) {
	    	grid.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([str, str]);
	    grid.setCellEditable(true);
	    grid.setCellEditable(false, _col.venueCD);
	    
	    grid.setCellImage("searchGrid", _col.venueCD);
		var search_venueCD = new AW.Templates.ImageText;
		var search_venueCD_Image = search_venueCD.getContent("box/image");
		search_venueCD_Image.setTag("a");
		search_venueCD_Image.setAttribute("href",function() {
			return "javascript:openVenuePopup_grid('closeVenuePopup_grid', grid.getCurrentRow())";
		});
		grid.setCellTemplate(search_venueCD, _col.venueCD);
		    
    }
	
	function openVenuePopup_grid(finalAction, row) {
		window.name='mainwin';
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}"
				+ "&viewID=COM02001B"
				+ "&finalAction=" + finalAction
				+ "&row=" + row;
		
		newWindow(url, "COM02001B", 600, 350,"yes");
	}
	
	function closeVenuePopup_grid(data) {
		grid.setCellText(data.venueCD, _col.venueCD, data.row);
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
	            url : "${contextPath}/service/ad04/extractChainVenueXls",
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