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
				 		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
                						<colgroup>
					        				<col style="width:15%;"></col>
					        				<col style="width:90%;"></col>
					        				<col></col>
			        					</colgroup>
					        			<tbody>
								      		<tr>
						                 		<td class="td-cond">
						                 			<fmt:message key="AD01001B.inputFile"/>
						                 		</td>
						                 		<td class="td-input" >
						                 			<table border="0" cellpadding="0" cellspacing="0" width="100%">
						                 				<tr>
						                  					<td height="25" width="310">
						                       					<div id="selectedFileDisplay_file">
						                           					<input type="text" cols="100" id="progressReport_file" value="" style="width:300px;"class="file_input_textbox"  readonly="readonly" >
						                       					</div>
						                   					</td>
						                   					<td width="75"> 
						                 	  					<div id="uploaderContainer_file" class="file_input_div">
                                                             		<input type="button" class="file_input_button" /><input type="file" name="fileuploader" id="fileuploader" class="file_input_hidden">                                
						                       					</div>
						                   					</td>
						                            		<td width="*">
						                            			<div id="uploadFilesLink"><a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a></div>
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
					<span id="grid_file"></span>
				 	<iframe src="" id="downloadFrame_file" name="downloadFrame_file" style="width:0px;height:0px;"></iframe>
				 </td>
			   </tr>
			   <tr>
				  <td height="1">
					<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
					<input type="hidden" id="selectAdSupportID" name="selectAdSupportID" />
				  </td>
			   </tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid_file .aw-column-0 {width: 300px;}
	#grid_file .aw-column-1 {width: 100px; text-align:right;}
    #grid_file .aw-column-2 {width: 50px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 var maxRow_file = 0;
	 var maxRow = 0;
	 
	/****************************************
	 * Function
	 ****************************************/
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid_file();
			grid_file.refresh();
			fileSearch();
			
		};

		${initScript}
	});
	

	//조회
	function fileSearch() {
	    var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/SYS0004S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","docLinkID;fileName;fileURL;UUID;fileTypeCD;fileSize;");
        table.setParameter("linkDivCD", "${param.fileDivCD}");
        table.setParameter("linkID", "${param.adSupportID}");
        table.request();
        
        if (grid_file != null) {
        	grid_file.clear();
        }
        
        createGrid_file();
        
        maxRow_file = 0;
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
                var fileUrl = 
		            "<a href=\"javascript:fileDownload_file('"+table.getData(0,i)+"');\">"+
		            "<img src=\"${contextPath}/images/filetype/"+table.getData(4,i)+".gif\" onerror=\"this.src='${contextPath}/images/filetype/unknown.gif'\" align=\"absmiddle\" /> "+table.getData(1,i)+
		            "</a>";
		            
                data[i] = [
                    fileUrl,
                    table.getData(5,i),
                    "",
                    table.getData(0,i),
                    "U"
                ];
            }
            grid_file.setCellData(data);
            grid_file.setRowCount(rowCount);
            maxRow_file = rowCount;
        }        
        grid_file.refresh();
		
		
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/

	//닫기
	function Close() {
		window.close();
	}
	
	
	//행삭제
	function removeRow_file(row) {
	    var req = new AW.XML.Table;
        req.setURL("${contextPath}/service/doclink/deleteFile");
        req.setAsync(false);
        req.setRequestMethod("POST");
        req.setParameter("docLinkID",grid_file.getCellText(3,row));
        req.request();
        
        var rowCount = req.getCount();
        if (rowCount > 0) {
            if (req.getData(0,0) == 'S') {
                grid_file.deleteRow(row);
                grid_file.setCellText('D',4,row);
            }
            else {
                alert('<fmt:message key="CMP02001B.msg2"/>');
            }
        }
        else {
            alert('<fmt:message key="CMP02001B.msg2"/>');
        }
    }
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var grid_file = null;
    
	var columns_file = [
    	"<fmt:message key="CMP02001B.fileName"/>",
    	"<fmt:message key="CMP02001B.fileSize"/>",
    	"<fmt:message key="button.Delete"/>"
	];

	function createGrid_file() {

	    grid_file = new AW.UI.Grid;
	    grid_file.setId("grid_file");
	    grid_file.setSelectorVisible(true);
	    grid_file.setSelectionMode("single-row");
	    grid_file.setCellEditable(false);
	    grid_file.setHeaderText(columns_file);
	    grid_file.setColumnCount(columns_file.length);
	    grid_file.setRowCount(0);
	    grid_file.setCellFormat([html,str,str]);
	    
	    grid_file.setCellImage("deleteGrid",2);
	    var deleteFlag = new AW.Templates.Image;
	    var delImage = deleteFlag.getContent("box/image");
	    delImage.setTag("a");
	    delImage.setAttribute("href", function(){
	        return "javascript:removeRow_file(grid_file.getCurrentRow())";
	    });
	    grid_file.setCellTemplate(deleteFlag, 2);
	    
	    grid_file.onHeaderClicked=function(){
	        return true;
	    }
	}
	
	$("#fileuploader").change(function(e) {
		var name = $("#fileuploader")[0].value;
		$("#progressReport_file").val(name.substring(name.lastIndexOf('\\')+1));
	});
	
	//업로드
	function upload() {
		if ($("#fileuploader").val() == "") {
			alert("파일을 선택해 주세요.");
		}
		else {
	        
			var linkIDVal = $("#articleID").val();
			$("#linkID").val(linkIDVal);
			
	        $("#form").ajaxForm({
	            url : "${contextPath}/service/doclink/insertFileForYUI",
	            enctype : "multipart/form-data",
	            data : 
 	            	{linkDivCD:"${param.fileDivCD}",
	            	linkID:"${param.adSupportID}",
 	                companyID:"${params.companyID}"},
	            error : function(){
			        this.progressReport = document.getElementById("progressReport_file");
			        this.progressReport.value = "Upload error.";        	
			    	alert("Upload error..");
	            },
				xhr: function() {
					var xhr = $.ajaxSettings.xhr();
					xhr.upload.onprogress = function(e) {
						var percent = Math.round(e.loaded * 100 / e.total) + "%";
						if (percent == "100%") percent = "Complete!!";
						$("#progressReport_file").val(percent);
					}
					return xhr;
				},            
	            success : function(data){
 					$("#fileuploader").val("");
					
					var fileID = "";
//		        	
 			       var fileData = data.split(';');
  		        	if (fileData[0] == 'S') {
  		        		grid_file.addRow(maxRow++);
 			            var fileUrl = 
 			            "<a href=\"javascript:fileDownload_file('"+fileData[4]+"');\">"+
 			            "<img src=\"${contextPath}/images/filetype/"+fileData[1]+".gif\" onerror=\"this.src='${contextPath}/images/filetype/unknown.gif'\" align=\"absmiddle\" /> "+fileData[2]+
 			            "</a>";
 			           grid_file.setCellText(fileUrl,0,maxRow-1);
 			           grid_file.setCellText(formatNum(Math.round(parseFloat(fileData[3])/1024)+"")+"k",1,maxRow-1);
 			           grid_file.setCellText(fileData[4],3,maxRow-1);
 			           grid_file.setCellText('U',4,maxRow-1);
			            
			  		   this.progressReport = document.getElementById("progressReport_file");
 				       this.progressReport.value = "Complete!!";
			            
			        }
			        else if (fileData[0] == 'E') {
				  		this.progressReport = document.getElementById("progressReport_file");
			        	this.progressReport.value = "Upload error.";
			            alert('File Upload Error.');
			        }else if (fileData[0] == 'Reject') {
				  		this.progressReport = document.getElementById("progressReport_file");
			        	this.progressReport.value = fileData[1]+" Files are not allowd.";
			        	alert(fileData[1]+" Files are not allowd.");
			        }	
			  		
	            }
	        });
	        $("#form").submit() ;
	     	
		}
	}
	
	//파일 다운로드
   	function fileDownload_file(docLinkID) {
		url = "${contextPath}/service/doclink/downloadFile/?docLinkID="+docLinkID;
		form.action = url;
		form.target = "downloadFrame";
		form.submit();
	}

</script>