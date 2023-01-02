<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>${params.viewName}</title>
    <base target="_self">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="Pragma" content="no-cache">
    <%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
   <form name="form" id="form" method="post" enctype="multipart/form-data"> 
    	<div id="wrapDiv">
    		<div id="formDiv">
		         <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            <tr>
						<td height="1">
		           			<%@include file="../cms/standardParam.jsp" %>
		
		           			<%@include file="../cms/functionbar.jsp" %>
		     				<%@include file="../cms/calendar.jsp" %>
		                </td>
		            </tr>
		       		<tr>
		            	<td height="*" valign="top">
		            		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		                   		<tr>
		               				<td class="tb-border">
		                       			<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
		       								<colgroup>
										    	<col style="width:15%"></col>
										    	<col style="width:35%"></col>
										    	<col style="width:15%"></col>
										    	<col style="width:35%"></col>
										    </colgroup>
		       								<tbody>
					                            <tr>
					                            	<td class="td-cond">
					                            		<fmt:message key="CMP02001B.title" />
					                            	</td>
					                            	<td class="td-input"  colspan="3">
					                            		<input type="text" id="title" name="title" class="board_box" value="${params.articleTitle}" style="width:98%" />
					                            	</td>
					                            </tr>
					                            <tr>
								                    <td class="td-cond">
								                    	<fmt:message key="CMP02001B.writeUserName" />
								                    </td>
								                    <td class="td-input">${params.writeUserName}&nbsp;&nbsp;&nbsp;<span class="deptNmClass">- ${params.deptNm}</span></td>
								                    <td class="td-cond">
								                    	<fmt:message key="CMP02001B.writeDate" />
								                    </td>
								                    <td class="td-input">${params.writeDate}</td>
								                </tr> 
					                			<tr>
						                			<c:set var="viewCount" value="${0}"/>         
						                			<c:if test="${params.isView == 'Y'}">
						                     			<c:set var="viewCount" value="${viewCount+1}"/>
							                    		<td class="td-cond">
							                    			<fmt:message key="CMP02001B.viewYN" />
							                    		</td>
									                    <td class="td-input">
									                        <input type="radio" id="viewYN" name="viewYN" class="radio" value="Y" <c:if test="${params.viewYN != 'N'}">checked</c:if>> <fmt:message key="CMP02001B.yes" />                      
									                        <input type="radio" id="viewYN" name="viewYN" class="radio" value="N" <c:if test="${params.viewYN == 'N'}">checked</c:if>> <fmt:message key="CMP02001B.no" />
									                    </td>   
									                </c:if>
						                			<c:if test="${params.isTop=='Y'}">
								                		<c:set var="viewCount" value="${viewCount+1}"/>
									                    <td class="td-cond">
									                    	<fmt:message key="CMP02001B.topYN" />
									                    </td>
									                    <td class="td-input">                    
									                         <input type="radio" id="topYN" name="topYN" class="radio" value="Y" <c:if test="${params.topYN == 'Y'}">checked</c:if>> <fmt:message key="CMP02001B.yes" />                      
									                         <input type="radio" id="topYN" name="topYN" class="radio" value="N" <c:if test="${params.topYN != 'Y'}">checked</c:if>> <fmt:message key="CMP02001B.no" />                    
									                    </td>                   
									                </c:if> 
									            	<c:if test="${viewCount == 2 }">
							                    		<c:set var="viewCount" value="${0}"/> 
								                    	</tr>
								                    <tr> 
							                	</c:if>
				                				<c:if test="${params.isHot == 'Y'}">
					                				<c:set var="viewCount" value="${viewCount+1}"/>
					                    			<td class="td-cond">
					                    				<fmt:message key="CMP02001B.hotYN" />
					                    			</td>
					                    			<td class="td-input" <c:if test="${viewCount == 1 }">colspan="3"<c:set var="viewCount" value="${viewCount+1}"/></c:if>>
					                        			<input type="checkbox" id="hotYN" name="hotYN" class="checkbox" value="Y" <c:if test="${params.hotYN=='Y'}">checked</c:if>>
					                        			(*<fmt:message key="CMP02001B.msg1" />)
					                    			</td>
					                			</c:if>
					                			<c:if test="${viewCount == 2 }">
					                    			<c:set var="viewCount" value="${0}"/> 
					                    			</tr>
					                			</c:if>
					                			<c:if test="${params.isPublic == 'Y'}">
						                		<tr>
						                    	<c:set var="viewCount" value="${viewCount+1}"/>
						                    		<td class="td-cond">
						                    			<fmt:message key="CMP02001B.articlePublicTarget" />
						                    		</td>
						                    		<td class="td-input" colspan="3">
						                        		<input type="text" id="publicName" name="publicName"  class="board_box" style="background-color:#ECECEC; width:80%;"  value="${params.publicName}" readOnly> 
						                        		<a href="#" onClick="openPopupPublicSelector()"><img src="${contextPath}/images/common/search_popup.gif" align="absmiddle" border=0></a>
						                    		</td>
						                 		</tr>   
					                			</c:if>
					                			<c:if test="${params.isPublic != 'Y'}">
					                    			<input type="hidden" name="publicName" value="${params.publicName}">   
					                			</c:if>
					                			<c:if test="${params.isBulletinTerm!='N'}">
						                		<tr>
						                    		<td class="td-cond">
						                    			<fmt:message key="CMP02001B.bulletinTermCD" />
						                    		</td>
						                    		<td class="td-input" colspan="3">
						                        		<nis:radio id="bulletinTermCD" name="bulletinTermCD" category="BULLETINTERMCD"/>
						                        		<script type="text/javascript">
						                            		setRadioValue('bulletinTermCD','${params.bulletinTermCD}');
						                        		</script>
						                    		</td>
						                		</tr>
					                			</c:if>
					                			<c:if test="${params.isAttachFile!='N'}">
						                		<tr height="140">
						                    		<td class="td-cond">
						                    			<fmt:message key="CMP02001B.fileAttatch"/>
						                    		</td>
						                    		<td class="td-input" colspan="3">
						                        		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
						                           			<tr>
						                               			<td height="25" width="310">
						                                   			<div id="selectedFileDisplay">
						                                       			<input type="text" cols="100" id="progressReport" class="file_input_textbox" value="" style="width:300px;" readonly="readonly" >
						                                   			</div>
						                               			</td>
						                               			<td width="75"> 
						                                   			<div id="uploaderContainer" class="file_input_div">
							                                        	<input type="button" class="file_input_button" />
							                                        	<input type="file" name="fileuploader" id="fileuploader" class="file_input_hidden">	
						                                   			</div>
						                               			</td>
						                               			<td width="*">
						                               				<!-- <div id="uploadFilesLink"><a id="uploadLink" onClick="upload(); return false;" href="#">Upload File</a></div> -->
						                                   			<div id="uploadFilesLink">
						                                   				<a id="uploadLink" onclick="upload(); return false;" href="#"><img src="${themeURL}/images/btn/upload.png"></a>
						                                   			</div>
						                               			</td>
						                           			</tr>
						                           			<tr>
								                       			<td colspan="3" height="100">
								                           			<span id="grid"></span>
								                           			<iframe src="" id="downloadFrame" name="downloadFrame" style="width:0px;height:0px;"></iframe>
								                       			</td>
								                   			</tr>
						                       			</table>
						                   			</td>
						                		</tr>
						            			</c:if>
						            			</tbody>   
						       				</table>
						        			<table border="0" cellpadding="0" cellspacing="0" width="100%" style="table-layout: fixed;">
						                		<tr>
						                    		<td colspan="4" height="2"></td>
						                		</tr>
						                		<tr>
						                    		<td width="100%" height="400" valign="top" colspan="4">
												  	<c:choose>
												    <c:when test="${configure.webEditor == 'fck'}">
									                	<FCK:editor id="content" basePath="${contextPath}/scripts/fck/"
									                    	height="400"
									                        toolbarSet="MyToolbarSet"
								                            imageBrowserURL="${contextPath}/scripts/fck/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
								                            linkBrowserURL="${contextPath}/scripts/fck/editor/filemanager/browser/default/browser.html?Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
								                            flashBrowserURL="${contextPath}/scripts/fck/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
								                            imageUploadURL="${contextPath}/scripts/fck/editor/filemanager/upload/simpleuploader?Type=Image"
								                            linkUploadURL="${contextPath}/scripts/fck/editor/filemanager/upload/simpleuploader?Type=File"
								                            flashUploadURL="${contextPath}/scripts/fck/editor/filemanager/upload/simpleuploader?Type=Flash">
								                            ${params.articleContent}
									                    </FCK:editor>
									               	</c:when>
									                <c:otherwise>
									                	<input type="hidden" id="content" name="content">
								                        <textarea id="editor" name="editor" rows="20" cols="75">${params.articleContent}</textarea>
														<script type="text/javascript">
															/*
															(function() {
															    var Dom = YAHOO.util.Dom,
															        Event = YAHOO.util.Event;
															    
															    var myConfig = {
															        height: '400px',
															        width: '800px',
															        dompath: true,
															        focusAtStart: false
															    };
															
															    var myEditor = new YAHOO.widget.Editor('editor', myConfig);
															    myEditor._defaultToolbar.buttonType = 'basic';
															    myEditor.render();
															
															})();
															*/
														</script>
						                            </c:otherwise>
						                            </c:choose>
						                    		</td>
						                		</tr> 
						                		<tr>
						                     		<td colspan="4" height="20">
						                     			<!-- Local Parameter - START -->
											            <input type="hidden" id="boardID" name="boardID" value="${params.boardID}" />
											            <input type="hidden" id="articleID" name="articleID" value="${params.articleID}" />
											            <input type="hidden" id="writeUserID" name="writeUserID" value="${params.writeUserID}" />
											            <input type="hidden" id="ref" name="ref" value="${params.ref}" />
											            <input type="hidden" id="refStep" name="refStep" value="${params.refStep}" />
											            <input type="hidden" id="refNo" name="refNo" value="${params.refNo}" />
											            <input type="hidden" id="boardTypeCD" name="boardTypeCD" value="${params.boardTypeCD}" />
											                
											            <input type="hidden" id="superPage" name="superPage" value="${params.superPage}">
											            <input type="hidden" id="page" name="page" value="${params.page}">
											            <input type="hidden" id="email" name="email" value="" />
											            <input type="hidden" id="homepage" name="homepage" value="" />
											            <input type="hidden" id="writeAuth" name="writeAuth" value="${params.writeAuth}">
											            <input type="hidden" id="updateAuth" name="updateAuth" value="${params.updateAuth}">
											            <input type="hidden" id="isView" name="isView" value="${params.isView}">
											        
											            <input type="hidden" id="publicCD" name="publicCD" value="<c:out value="${params.publicCD}"/>">
											            <input type="hidden" id="publicDivCD" name="publicDivCD" value="<c:out value="${params.publicDivCD}"/>">
											            <!-- Local Parameter - END -->
											            
											            <input type="hidden" id="publicID" name="publicID" value="${params.publicID}">
											            <input type="hidden" id="publicClassCD" name="publicClassCD" value="${params.publicClassCD}">         
									                </td>
									            </tr>
									        </table>
									   	</td>
								  	</tr>   
		               			</table>
		              		</td>
		          		</tr> 
		       		</table>
		    	</div>
			</div>
   	</form>
</body>
</html>

<style type="text/css">
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}

    .aw-column-0 {width: 300px; }
    .aw-column-1 {width: 100px; text-align:right;}
    .aw-column-2 {width: 50px; text-align: center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}

</style>

<script type="text/javascript">

	/****************************************
	* Variable
	****************************************/
    var saveType = "${params.saveType}";
    var maxRow = 0;

    /****************************************
    * Function
    ****************************************/
	$(document).ready(function() {
		searchFileAttatch();
		window.onload = function() {
			searchFileAttatch();
		};
	
		${initScript}
	});
    
    function closePublicSelector(rtnPublicID, rtnPublicClassCD, rtnPublicName){
        var publicID = "";
        var publicClassCD = "";
        var publicName = "";
        for(var i=0; i < rtnPublicID.length; i++){
            if (i < rtnPublicID.length-1) {
                publicID = publicID + rtnPublicID[i]+';';
                publicClassCD = publicClassCD + rtnPublicClassCD[i]+';';
                publicName = publicName + rtnPublicName[i]+';';
            }
            else {
                publicID = publicID + rtnPublicID[i];
                publicClassCD = publicClassCD + rtnPublicClassCD[i];
                publicName = publicName + rtnPublicName[i];
            }
        }
        $("#publicName").val(publicName);
        $("#publicID").val(publicID);
        $("#publicClassCD").val(publicClassCD);
    }
    
    function openPopupPublicSelector() {

        var url = "${contextPath}/service/simpleCommand/"+
                  "?mnuGrpID="+$("#mnuGrpID").val()+
                  "&pgmID="+$("#pgmID").val()+
                  "&viewID=COM01002A"+
                  "&finalAction=closePublicSelector";
                                            
        newWindow(url, "publicSelector", 500, 560, "no");
    }
    
    function removeRow(row) {
	    var req = new AW.XML.Table;
        req.setURL("${contextPath}/service/doclink/deleteFile");
        req.setAsync(false);
        req.setRequestMethod("POST");
        req.setParameter("docLinkID",grid.getCellText(3,row));
        req.request();
        
        var rowCount = req.getCount();
        if (rowCount > 0) {
            if (req.getData(0,0) == 'S') {
                grid.deleteRow(row);
                grid.setCellText('D',4,row);
            }
            else {
                alert('<fmt:message key="CMP02001B.msg2"/>');
            }
        }
        else {
            alert('<fmt:message key="CMP02001B.msg2"/>');
        }
    }
    
    
    function searchFileAttatch() {

	    var table = new AW.XML.Table;
	    table.setURL("${contextPath}/service/simpleAction/SYS0004S");
	    table.setAsync(false);
	    table.setRequestMethod("POST");
	    table.setParameter("outParamKey","docLinkID;fileName;fileURL;UUID;fileTypeCD;fileSize;");
	    table.setParameter("linkDivCD", "SUBJECT");
	    table.setParameter("linkID", $("#articleID").val());
	    table.request();
	    
	    if (grid != null) grid.clear();
	    createGrid();
	    
	    maxRow = 0;
	    var rowCount = table.getCount();
	    if (rowCount > 0) {
	        var data = new Array();
	        for (var i=0; i < rowCount; i++) {
	            var fileUrl = 
		            "<a href=\"javascript:fileDownload('"+table.getData(0,i)+"');\">"+
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
	        grid.setCellData(data);
	        grid.setRowCount(rowCount);
	        maxRow = rowCount;
	    }        
	        
        grid.refresh();
        
	    if (saveType == "") {
	    	grid.clear();
    	}
    }
    
    function Save() {
    	
        if ($("#title").val() == '') {
            alert("<fmt:message key="CMP02001B.msg3"/>");
            $("#title").focus();
            return;
        }
        <c:if test="${params.isPublic == 'Y'}">
	        if($("#publicName").val() == '') {
	            alert("<fmt:message key="CMP02001B.msg4"/>");
	            $("#publicName").focus();
	            return;
	        }
        </c:if>
        <c:if test="${configure.webEditor == 'yui'}">
	        //YUI Editor 에서 HTML 불러오기
        	$("#content").val() = myEditor.getEditorHTML();
        </c:if>
        
        if(saveType == 'insert') {
            fnSubmitConfirm(document.form, '${contextPath}/service/board', 'addArticle/?viewID=CMP02001A', '<fmt:message key="confirm.save" />');                        
        } 
        else {
            fnSubmitConfirm(document.form, '${contextPath}/service/board', 'modifyArticle/?viewID=CMP02001A', '<fmt:message key="confirm.save" />');
        } 
    }
    
    function Delete() {
        fnSubmitConfirm(document.form, '${contextPath}/service/board', 'removeArticle/?viewID=CMP02001A', '<fmt:message key="confirm.delete" />');
    }
    
    function List() {
        fnSubmit(document.form, '${contextPath}/service/board', 'findArticleList/?viewID=CMP02001A');
    }


</script>

<script type="text/javascript">

    /*****************************************************
    *   Grid Setting
    *****************************************************/
    var grid = null;
    
    var columns = [
        "<fmt:message key="CMP02001B.fileName"/>",
        "<fmt:message key="CMP02001B.fileSize"/>",
        "<fmt:message key="button.Delete"/>"
    ];
    
    function createGrid() {
    
        grid = new AW.UI.Grid;
        grid.setId("grid");
        grid.setSelectorVisible(true);
        grid.setSelectionMode("single-row");
        grid.setCellEditable(false);
        grid.setHeaderText(columns);
        grid.setColumnCount(columns.length);
        grid.setRowCount(0);
        grid.setCellFormat([html,str,str]);
        
        grid.setCellImage("deleteGrid",2);
        var deleteFlag = new AW.Templates.Image;
        var delImage = deleteFlag.getContent("box/image");
        delImage.setTag("a");
        delImage.setAttribute("href", function(){
            return "javascript:removeRow(grid.getCurrentRow())";
        });
        grid.setCellTemplate(deleteFlag, 2);
        
        grid.onHeaderClicked=function(){
            return true;
        }
    }

</script>

<script type="text/javascript">
    
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
	            url : "${contextPath}/service/doclink/insertFileForYUI", 
	            enctype : "multipart/form-data",
	            data : 
					{
	            	linkDivCD:"SUBJECT",
                    linkID:$("#articleID").val(),
                    companyID:"${params.companyID}"
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

 					var fileID = "";
//		        	
 			       var fileData = data.split(';');
  		        	if (fileData[0] == 'S') {
  		        		grid.addRow(maxRow++);
 			            var fileUrl = 
 			            "<a href=\"javascript:fileDownload('"+fileData[4]+"');\">"+
 			            "<img src=\"${contextPath}/images/filetype/"+fileData[1]+".gif\" onerror=\"this.src='${contextPath}/images/filetype/unknown.gif'\" align=\"absmiddle\" /> "+fileData[2]+
 			            "</a>";
 			           grid.setCellText(fileUrl,0,maxRow-1);
 			           grid.setCellText(formatNum(Math.round(parseFloat(fileData[3])/1024)+"")+"k",1,maxRow-1);
 			           grid.setCellText(fileData[4],3,maxRow-1);
 			           grid.setCellText('U',4,maxRow-1);
			            
			  		   this.progressReport = document.getElementById("progressReport");
 				       this.progressReport.value = "Complete!!";
			            
			        }
			        else if (fileData[0] == 'E') {
				  		this.progressReport = document.getElementById("progressReport");
			        	this.progressReport.value = "Upload error.";
			            alert('File Upload Error.');
			        }else if (fileData[0] == 'Reject') {
				  		this.progressReport = document.getElementById("progressReport");
			        	this.progressReport.value = fileData[1]+" Files are not allowd.";
			        	alert(fileData[1]+" Files are not allowd.");
			        }	
	            }
	        });
	 
	        $("#form").submit() ;
	     	
		}
	}
    
    function fileDownload(docLinkID) {
        url = "${contextPath}/service/doclink/downloadFile/?docLinkID="+docLinkID;
        form.action = url;
        form.target = "downloadFrame";
        form.submit();
    }
 
    
</script>

<script type="text/javascript">
<!--
    <c:if test="${!empty params.initAction}">
        <c:out value="${params.initAction}"/>();
    </c:if>
    
//-->
</script>
