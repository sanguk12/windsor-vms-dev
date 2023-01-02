<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
	</head>

	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            	<tr>
                    <td height="1">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
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
/*     #grid_file .aw-column-2 {width: 50px; text-align:center;} */

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 var maxRow_file = 0;
	 
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
    	"<fmt:message key="CMP02001B.fileName"/>"
    	, "<fmt:message key="CMP02001B.fileSize"/>"
    	//, "<fmt:message key="button.Delete"/>"
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
	    grid_file.setCellFormat([html,str
	    						//	,str
	    						]);

	    //grid_file.setCellImage("deleteGrid",2);
	    //var deleteFlag = new AW.Templates.Image;
	    //var delImage = deleteFlag.getContent("box/image");
	    //delImage.setTag("a");
	    //delImage.setAttribute("href", function(){
	     //   return "javascript:removeRow_file(grid_file.getCurrentRow())";
	    //});
	    //grid_file.setCellTemplate(deleteFlag, 2);
	    
	    grid_file.onHeaderClicked=function(){
	        return true;
	    }
	}
	
    function fileDownload_file(docLinkID) {
        url = "${contextPath}/service/doclink/downloadFile/?docLinkID="+docLinkID;
        form.action = url;
        form.target = "downloadFrame_file";
        form.submit();
    }

</script>