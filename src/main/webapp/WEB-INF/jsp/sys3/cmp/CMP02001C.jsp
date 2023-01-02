<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>${params.viewName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="Pragma" content="no-cache">
    <%@include file="../scripts.jsp" %>
    <%@include file="../cms/calendar.jsp" %>
</head>
    
<body class="yui-skin-sam" ${bodyConfig}> 
    <form name="form" method="post">
    	<div id="wrapDiv">
    		<div id="formDiv">
    			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            		<tr>
                		<td height="1">
           					<%@include file="../cms/standardParam.jsp" %>
				           	<%@include file="../cms/functionbar.jsp" %>
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
							                    	<fmt:message key="CMP02001C.bulletinTermCD" />
							                    </td>
							                    <td class="td-input">${params.bulletinTermName}</td>
							                    <td class="td-cond">
							                    	<fmt:message key="CMP02001C.reading" />
							                    </td>
							                    <td class="td-input">${params.reading}</td>
							                </tr>
							                <tr>
							                    <td class="td-cond">
							                    	<fmt:message key="CMP02001C.writeUserName" />
							                    </td>
							                    <td class="td-input">${params.writeUserName}&nbsp;&nbsp;&nbsp;<span class="deptNmClass">- ${params.deptNm}</span></td>
							                    <td class="td-cond">
							                    	<fmt:message key="CMP02001C.writeDate" />
							                    </td>
							                    <td class="td-input">${params.writeDate}</td>
							                </tr>
							                <tr>
							                    <td class="td-cond">
							                    	<fmt:message key="CMP02001C.title" />
							                    </td>
							                    <td class="td-input" colspan="3">${params.articleTitle}</td>
							                </tr>
			                				<c:if test="${params.isPublic=='Y'}">
							                <tr>
							                    <td class="td-cond">
							                    	<fmt:message key="CMP02001C.articlePublicTarget" />
							                    </td>
							                    <td class="td-input" colspan="3">&nbsp;<c:out value="${params.publicName}" escapeXml="true"/></td>
							                </tr>               
							                </c:if>
			                				<tr>
			                    				<td class="td-input" colspan="4">
				                   					<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				                       					<tr>
				                           					<td height="20"></td>
				                       					</tr>
				                       					<tr>
						                   					<td>${params.articleContent}</td>
						               					</tr>
						               					<tr>
				                           					<td height="20"></td>
				                       					</tr>
				                    				</table>
				                				</td>
			                				</tr>
			                				<c:if test="${params.isAttachFile!='N'}">
			                				<tr>
							                    <td colspan="4">
								                   <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
								                       <tr>
								                           <td height="100">
								                               <span id="grid_fileAttatch"></span>
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
			                				<c:if test="${params.isReply!='N'}">
				            				<tr>
				                				<td colspan="4">
				                 				<!-- 댓글입력  -->
				                     				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				                         				<tr>
				                             				<td width="88%">
				                                 				<textarea id="content" name="content" class="board_box" Preset="none" ImeMode="active" ByteSize="2000" style="height:60px; width:100%;"></textarea>
				                             				</td>
				                             				<td width="12%" align="center" style="padding-left:4px">
				                             					<script  type="text/javascript">
				                                    				var btn_reply = new AW.UI.Button;
								                                    btn_reply.setControlText("<fmt:message key="CMP02001C.returnMessage" />");
								                                    document.write(btn_reply);
								                                     
								                                    btn_reply.onControlClicked = function(event){
								                                    	InsertReply();
								                                    }
							                                    </script>
				                                 				<!--  img src="${contextPath}/images/btn_reply.gif" alt="" border="0" onclick="InsertReply();" /-->
				                             				</td>
				                        				</tr>
				                        				<tr>
				                        					<td height="5">&nbsp;</td>
				                        				</tr>
				                     				</table>
				                     				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				                          				<c:forEach items="${articleReplyList}" var="reply" varStatus="status">
				                          				<tr height="27">
				                              				<td width="74%" class="td-input">${reply.content}</td>
				                              				<td width="26%" class="td-input">
				                                    			<font style="font: bold"><c:out value="${reply.writeUserName}"/> &nbsp;${reply.writeDate}</font>
				                                    			<c:if test="${params.userID==reply.writeUserID}">
				                                        			<img src="${contextPath}/images/ico/btn_reply_del.gif" style="cursor:pointer;" onClick="DeleteReply('${reply.replyID}');" />
				                                    			</c:if> 
				                              				</td>
				                          				</tr> 
				                          				</c:forEach>                   
				                     				</table>                      
				                  				</td>
				             				</tr>  
				             				</c:if> 
                       					</table>
                    				</td>
               					</tr>
           				</table>
				        <!--
				        <c:if test="${params.isAnswer!='N'}"><span id="grid"></span></c:if>                     
				        -->
				         <!-- Local Parameter - START -->
				           <input type="hidden" id="userID" name="userID" value="${params.userID}" />
				           <input type="hidden" id="boardID" name="boardID" value="${param.boardID}" />
				           <input type="hidden" id="articleID" name="articleID" value="${params.articleID}" />
				           <input type="hidden" id="writeUserID" name="writeUserID" value="${params.writeUserID}" />
				           <input type="hidden" id="ref" name="ref" value="${params.ref}" />
				           <input type="hidden" id="refStep" name="refStep" value="${params.refStep}" />
				           <input type="hidden" id="refNo" name="refNo" value="${params.refNo}" />
				           <input type="hidden" id="boardTypeCD" name="boardTypeCD" value="${params.boardTypeCD}" />
				               
				           <input type="hidden" id="superPage" name="superPage" value="${params.superPage}">
				           <input type="hidden" id="page" name="page" value="${params.page}">
				           <input type="hidden" id="writeAuth" name="writeAuth" value="${params.writeAuth}">
				           <input type="hidden" id="updateAuth" name="updateAuth" value="${params.updateAuth}">
				          <!-- Local Parameter - END -->
				                  
				           <!-- Action Parameter - START -->
				           <input type="hidden" id="initAction" name="initAction">
				           <!-- Action Parameter - END -->         
						</td>
					</tr>
				</table>
			</div>
		</div>		      
    </form>
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    #grid .aw-column-0 {width: 75px; text-align:right;}
    #grid .aw-column-1 {width: 300px;}
    #grid .aw-column-2 {width: 80px; text-align:center;}
    #grid .aw-column-3 {width: 80px; text-align:center;}
    #grid .aw-column-4 {width: 80px; text-align:center;}
    
    #grid_fileAttatch .aw-column-0 {width: 300px; }
    #grid_fileAttatch .aw-column-1 {width: 100px; text-align:right;}
    #grid_fileAttatch .aw-column-2 {width: 50px; text-align: center;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
//-->
</style> 

<script type="text/javascript">
	/****************************************
	 * Variable
	 ****************************************/
	
	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {
	
		window.onload = function() {
	
			<c:if test="${params.isAnswer!='N'}">
		        Search();
		    </c:if>
		    <c:if test="${params.isAnswer=='N'}">
		    	btnAnswer.setControlVisible(false);
		    </c:if>
		    
		    searchFileAttatch();

		    <c:if test="${!(params.authLevelCD == '10' || params.authLevelCD == '20') && params.writeUserID != params.userID}">
				btnUpdate.setControlVisible(false);
				btnDelete.setControlVisible(false);
			</c:if>
			
			
			<c:if test="${params.mainPopup == 'Y'}">
				btnList.setControlVisible(false);
			</c:if>
			<c:if test="${params.mainPopup == null}">
				btnClose.setControlVisible(false);
			</c:if>
			
			
		};
	
		${initScript}
	
	});

    function searchFileAttatch() {
    
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/SYS0004S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","docLinkID;fileName;fileURL;UUID;fileTypeCD;fileSize;");
        table.setParameter("linkDivCD", "SUBJECT");
        table.setParameter("linkID", $("#articleID").val());
        table.request();
        
        if (grid_fileAttatch != null) grid_fileAttatch.clear();
        createGrid_fileAttatch();
        
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
                    table.getData(5,i)
                ];
            }
            grid_fileAttatch.setCellData(data);
            grid_fileAttatch.setRowCount(rowCount);
        }        
        grid_fileAttatch.refresh();    
    }
    
    function fileDownload(docLinkID) {
        url = "${contextPath}/service/doclink/downloadFile/?docLinkID="+docLinkID;
        form.action = url;
        form.target = "downloadFrame";
        form.submit();
    }
    
    
    function Update() {
        /*
        if ('${params.writeAuth}' == 'Y' && '${params.updateAuth}' == 'Y')
        {
        */
            fnSubmitConfirm(document.form, "${contextPath}/service/board", "editArticle/?viewID=CMP02001B", "<fmt:message key="confirm.update" />");
        /*
        }
        else
        {
            message("<fmt:message key="CMP02001C.msg1" />");
        }
        */
    }
    
    function Delete() {
        /*
        if ('${params.writeAuth}' == 'Y' && '${params.updateAuth}' == 'Y')
        {
        */
            fnSubmitConfirm(document.form, "${contextPath}/service/board", "removeArticle/?viewID=CMP02001A", "<fmt:message key="confirm.delete" />");
        /*
        }
        else
        {
            message("<fmt:message key="CMP02001C.msg2" />");
        } 
        */          
    }
    
    function List() {
        fnSubmit(document.form, "${contextPath}/service/board", "findArticleList/?viewID=CMP02001A");
    }

    function Answer() {     
        fnSubmitConfirm(document.form, "${contextPath}/service/board", "newArticle/?viewID=CMP02001B", "<fmt:message key="confirm.answer" />");
    }
    
    function openForm(articleID) {
        $("#articleID").val(articleID);
        fnSubmit(document.form, "${contextPath}/service/board", "viewArticle");
    }
    
    function InsertReply() {
        fnSubmitConfirm(document.form, "${contextPath}/service/board", "addArticleReply", "<fmt:message key="confirm.insertReply" />");
    }
    
    function DeleteReply(replyID) {
        fnSubmitConfirm(document.form, "${contextPath}/service/board", "removeArticleReply/?replyID="+replyID, "<fmt:message key="confirm.deleteReply" />");
    }
        
    function Search() {
    	
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0200101S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey",
        		"articleID;title;ref;refStep;refNo;"+
        		"reading;writeUserID;writeDate;writeIP;bulletinTermCD;"+
        		"isNew;boardTypeCD;");
        table.setParameter("format",
        		"str;str;str;str;str;"+
        		"str;str;date;str;str;"+
        		"str;str;");
        table.setParameter("ref", $("#ref").val());
        table.request();
        
        if (grid != null) grid.clear();
      	createGrid();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            var data = new Array();
            for (var i=0; i < rowCount; i++) {
                var title = "";
                for(var cnt=0;cnt<table.getData(3,i);cnt++) {
                    title +="<img src=\"${contextPath}/images/ico/icoLevel.gif\" align=\"absmiddle\" />";
                }
                if(table.getData(3,i)>=1) {                 
                    title+="<img src=\"${contextPath}/images/ico/icoReply.gif\" align=\"absmiddle\" />";
            
                }
                title+=table.getData(1,i);
                if(table.getData(10,i)!="N") {
                    title+="<img src=\"${contextPath}/images/ico/icoNew02.gif\" align=\"absmiddle\" />";
                }
                data[i] = [
                    table.getData(0,i),
                    title,
                    table.getData(6,i),
                    table.getData(7,i),
                    table.getData(5,i)
                ];
            }
            grid.setCellData(data);
            grid.setRowCount(rowCount);
        }
        grid.refresh();
    }
    
    function Close() {
    	window.close();
    }
    
    
    /*****************************************************
    *   Grid Setting
    *****************************************************/
    var grid = null;
    var keyIndex = 0;

    var columns = [
        "<fmt:message key="CMP02001C.no"/>", 
        "<fmt:message key="CMP02001C.title"/>", 
        "<fmt:message key="CMP02001C.writeUserName"/>",
        "<fmt:message key="CMP02001C.writeDate"/>", 
        "<fmt:message key="CMP02001C.reading"/>"
    ];

    function createGrid() {

        grid = new AW.UI.Grid;
        grid.setId("grid");
        grid.setSelectorWidth(40);
        grid.getSelectorTemplate().setStyle("text-align", "right");
        grid.setSelectorVisible(true);
        grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
        grid.setSelectionMode("single-row");
        grid.setCellEditable(false);
        grid.setHeaderText(columns);
        for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
        grid.setStyle("width", "80%");
        grid.setStyle("height", "80px");
        grid.setCellFormat([str, html, str, str, str]);
        
        grid.onRowDoubleClicked = function(event, row){
            openForm(this.getCellText(0, row));
        }
        
        var keyEvent = grid.getEvent("onkeydown");
        grid.setEvent("onkeydown", function(e, rowIndex) {      
            if(event.keyCode==46){
                Delete(this.getCellText(0, grid.getSelectedRows()));
                event.returnValue = false;
            } else if(event.keyCode==13){
                openForm(this.getCellText(0, grid.getSelectedRows()));
            } else {
                
            }
        });     
    }
    
    var grid_fileAttatch = null;
    
    var columns_fileAttatch = [
        "<fmt:message key="CMP02001C.fileName"/>", 
        "<fmt:message key="CMP02001C.fileSize"/>"
    ];
    
    function createGrid_fileAttatch() {
    
        grid_fileAttatch = new AW.UI.Grid;
        grid_fileAttatch.setId("grid_fileAttatch");
        grid_fileAttatch.setSelectorVisible(true);
        grid_fileAttatch.setSelectionMode("single-row");
        grid_fileAttatch.setCellEditable(false);
        grid_fileAttatch.setHeaderText(columns_fileAttatch);
        for(var i=0;i<columns_fileAttatch.length;i++){grid_fileAttatch.getHeaderTemplate(i).setStyle("text-align", "center");}
        grid_fileAttatch.setColumnCount(columns_fileAttatch.length);
        grid_fileAttatch.setCellFormat([html,str]);
       
        grid_fileAttatch.onHeaderClicked=function(){
            return true;
        }
    }
    
</script>