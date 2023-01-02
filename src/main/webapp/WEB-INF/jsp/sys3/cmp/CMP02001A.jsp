<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>${params.viewName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		                   	<div id="btn">
								<div id="tit">
									<table class="functionbar-title" width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td valign="top" class="tit_text" style="height:30px; width:300px; vertical-align:middle;">
												<img src="${contextPath}${params.themeURL}/images/common/tit_point.gif"> 
												<c:choose>
								                    <c:when test="${params.viewTitle == ''}">
								                        ${params.viewName}
								                    </c:when>
								                    <c:otherwise>
								                        ${params.viewTitle}
								                    </c:otherwise>
								                </c:choose>
							                </td>
											<td class="tit_text01" style="text-align:right; padding-right:30px;" id="messagebar">
											</td>
										</tr>
									</table>
								</div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td style="height:8px;"></td>
									</tr>
									<tr>
										<td align="right">
											<c:if test="${params.authYN == 'Y'}">
												<c:forEach items="${funcList}" var="function" varStatus="status">
													<script type="text/javascript">
												  	var ${function.funcCode} = new AW.UI.Button;
													${function.funcCode}.setId("${function.funcCode}");
													${function.funcCode}.setControlText("${function.funcName}");
													${function.funcCode}.setControlImage("${function.icon}");
													document.write(${function.funcCode});
													
													${function.funcCode}.onControlClicked = function(event){
														${function.funcCode}();
													}
													</script>
												</c:forEach>
											</c:if>
										</td>
									</tr>
									<tr>
										<td height="2"></td>
									</tr>
								</table>
							</div>
                   		</td>
               		</tr>
               		<tr>
						<td height="1">             
                       		<table border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout: fixed;"> 
                       			<tr>
                   					<td class="tb-border">
                   						<table border="0" cellpadding="0" cellspacing="0" width="100%">
                   							<tr>
                   								<td>
                   									<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<tr height="28">
						                            		<td align="left">
						                                		<img src="${contextPath}/images/ico/icon_doc.gif" alt="" /> <fmt:message key="CMP02001A.total" /> <font color="red" style="font-weight:bold;">${params.recordCount}</font> <fmt:message key="CMP02001A.msg1" />
						                            		</td>
						                            		<td align="right">
						                                  		<input name="keyWord" type="text" class="board_box" id="text"  style="width:200px" value="${params.keyWord}" onKeypress="if (event.keyCode==13){Search(); return false;}"/> 
						                                  		<img id="search_btn" src="${contextPath}/images/common/search_popup.gif" style="vertical-align:middle;cursor:pointer;margin-bottom: 1px;" />
						                            		</td>
						                        		</tr>
						                    		</table>
                   								</td>
                   							</tr>
                   							<c:if test="${params.boardTypeCD != '40'}">
					                		<tr>
					                    		<td height="325">
											        <script type="text/javascript">
											        
											            var columns = [
											                "<fmt:message key="CMP02001A.no"/>",
											                "<fmt:message key="CMP02001A.title"/>",
											                "<fmt:message key="CMP02001A.writeUserName"/>",
											                "<fmt:message key="CMP02001A.writeDate"/>",
											                "<fmt:message key="CMP02001A.reading"/>"
											            ];
											            
											            var grid = new AW.UI.Grid;
											            grid.setSelectorVisible(true);
											            grid.setSelectionMode("single-row");
											            for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
											            grid.setCellEditable(false);
											            grid.setHeaderText(columns);
											            grid.setColumnCount(columns.length);
											            grid.setCellFormat([html,html,str,str,str]);
											            
											            var data = new Array();
											        
										                <c:set var="listCount" value="${0}"/>     
										                <c:forEach items="${articleList}" var="list" varStatus="status">
										                    data[${listCount}] =
										                    <c:set var="listCount" value="${listCount+1}"/>
										                        [
										                           "<c:if test="${list.topYN =='Y'}"><img src='${contextPath}/images/ico/top_notice.gif' align='absmiddle'></c:if><c:if test="${list.topYN != 'Y'}"><c:out value='${list.articleID}'/></c:if>",
										                           //"<c:forEach var="i" begin="0" end="${list.refStep}" step="1"><img src='${contextPath}/images/ico/icoLevel.gif' align='absmiddle'></c:forEach><c:if test="${list.refStep >= 1}"><img src='${contextPath}/images/ico/icoReply.gif' align='absmiddle'></c:if><c:out value="${list.title}"/><c:if test="${list.isNew !='N'}"><c:if test="${list.imageFlag =='Y'}"><img src='${contextPath}/images/ico/icon_new.gif' align='absmiddle'></c:if></c:if><c:if test="${list.hotYN =='Y'}"><c:if test="${list.imageFlag =='Y'}"><img src='${contextPath}/images/ico/hot.gif' align='absmiddle'></c:if></c:if>",
										                           "<c:forEach var="i" begin="0" end="${list.refStep}" step="1"><img src='${contextPath}/images/ico/icoLevel.gif' align='absmiddle'></c:forEach><c:if test="${list.refStep >= 1}"><img src='${contextPath}/images/ico/icoReply.gif' align='absmiddle'></c:if><c:out value="${list.title}"/><c:if test="${list.isNew !='N'}"><c:if test="${list.imageFlag =='Y'}"><img src='${contextPath}/images/ico/icon_new.gif' align='absmiddle'></c:if></c:if><c:if test="${list.hotYN =='Y'}"><img src='${contextPath}/images/ico/hot.gif' align='absmiddle'></c:if>",
										                           "${list.writeUserID}",
										                           formatDate("${list.writeDate}"),
										                           "${list.reading}",
										                           "${list.articleID}"
										                        ];
										                </c:forEach>
											            
											            grid.setCellData(data);
											            grid.setRowCount(data.length);
											            
											            grid.onRowDoubleClicked = function(event, row){
												            openView(this.getCellText(5,row));
												        };
												        
											            grid.onHeaderClicked=function(){
											                return ture;
											            };
											            
											            document.write(grid);
								        			</script>
												</td>
											</tr>
								    		</c:if>
                   						</table>
                   						<!-- 사진첩 리스트 -->
							    		<c:if test="${params.boardTypeCD == '40'}">
							    
							        		<c:set var="tempArticle" value=""/>
							        		<c:set var="tempReply" value=""/>
							        		<c:forEach items="${articleViewList}" var="view" varStatus="status">
							            		<c:if test="${view.articleID!=tempArticle}">
							                		<c:set var="tempArticle" value="${view.articleID}"/>    
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
									                        	<fmt:message key="CMP02001A.title" />
									                        </td>
									                        <td colspan="3" class="td-input">${view.articleTitle}</td>
									                    </tr>
									                    <tr>
									                        <td class="td-cond">
									                        	<fmt:message key="CMP02001A.writeUserName" />
									                        </td>
									                        <td class="td-input">${view.writeUserName}&nbsp;&nbsp;&nbsp;<span class="deptNmClass">- ${view.deptNm}</span></td>
									                        <td class="td-cond">
									                        	<fmt:message key="CMP02001A.writeDate" />
									                        </td>
									                        <td class="td-input">${view.writeDate}</td>
									                    </tr>
								                    	<tr>
								                        	<td colspan="4" class="td-input">
								                            	${view.articleContent}
								                        	</td>
								                    	</tr>
								                    	<tr>
								                        	<td colspan="4">
								                            	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="f5f5f5">
								                                	<tr>
								                                    	<td height="40" style="padding-left:20px">
									                                        <c:if test="${view.isRecommend != 'N'}">
										                                        <img src="${contextPath}/images/ico/tx_reply.gif" alt="" /> (<span class="top_info_num">${view.replyCnt}</span>) &nbsp;
										                                        <img src="${contextPath}/images/ico/tx_good.gif" alt="" /> (<span class="top_info_num">${view.recommendCount}</span>) &nbsp;
										                                        <img src="${contextPath}/images/ico/btn_good.gif" alt="" border="0"  onclick="Recommend('${view.articleID}')"/>
									                                        </c:if>
								                                    	</td>
								                                    	<td align="right" style="padding-right:10px">
									                                        <c:if test="${params.writeUserID==view.writeUserID}">
										                                        <script  type="text/javascript">
												                                    var btn_update = new AW.UI.Button;
												                                    btn_update.setControlText("<fmt:message key="button.Update" />");
												                                    document.write(btn_update);
												                                     
												                                    btn_update.onControlClicked = function(event){
												                                    	Update('${view.articleID}');
												                                    }
											                                    </script>&nbsp;
											                                    <script  type="text/javascript">
												                                    var btn_delete = new AW.UI.Button;
												                                    btn_delete.setControlText("<fmt:message key="button.Delete" />");
												                                    document.write(btn_delete);
												                                     
												                                    btn_delete.onControlClicked = function(event){
												                                    	Delete('${view.articleID}');
												                                    }
											                                    </script>
									                                            <!-- img src="${contextPath}/images/btn_modify.gif" alt="" border="0"  onclick="Update('${view.articleID}');" /-->
									                                            <!--img src="${contextPath}/images/btn_del.gif" alt="" border="0" onclick="Delete('${view.articleID}');"/-->
									                                        </c:if> 
									                                    </td>
								                                	</tr>
								                            	</table>
								                        	</td>
								                    	</tr>
								                		</tbody>
							                		</table>
							                		
							                		<c:if test="${view.isReply!='N'}">
							                			<table border="0" cellpadding="0" cellspacing="0" width="100%" style="table-layout: fixed;">
							                    			<tr>
							                        			<td width="88%">
							                            			<textarea name="content${view.articleID}"  class="board_box" Preset="none" ImeMode="active" ByteSize="2000" style="height:60px; width:100%;behavior:url(/scripts/htc/BaseTextBox.htc);"></textarea>
							                        			</td>
							                        			<td width="12%" align="center" style="padding-left:4px">
							                        				<script  type="text/javascript">
						                                    			
								                        				var btn_reply = new AW.UI.Button;
									                                    btn_reply.setControlText("<fmt:message key="CMP02001A.returnMessage" />");
									                                    document.write(btn_reply);
									                                     
									                                    btn_reply.onControlClicked = function(event){
										                                    //alert('${(params.superPage + 1) * params.pagePerSuperPage}');
										                                    //return;
									                                    	InsertReply(document.form.content${view.articleID}.value,'${view.articleID}','${view.boardID}','${params.superPage - 1}', '${(params.superPage - 1)*params.pagePerSuperPage}');
									                                    }
								                                    </script>
										                            <!--img src="${contextPath}/images/ico/btn_reply.gif" alt="" border="0" onclick="InsertReply(document.form.content${view.articleID}.value,'${view.articleID}','${view.boardID}','${params.superPage - 1}', '${(params.superPage - 1)*params.pagePerSuperPage}');"/-->
										                        </td>
										                    </tr>
							        			        </table>
							        			            
							                			<table width="100%" border="0" cellspacing="0" cellpadding="0">
							                    			<c:forEach items="${articleViewList}" var="reply" varStatus="status"> 
							                        			<c:if test="${reply.articleID==view.articleID && reply.replyID !=null }">
							                            			<tr height="27">
							                                			<td width="74%" class="td-input">${reply.content}</td>
							                                			<td width="26%" class="td-input">
							                                				<font style="font: bold">${reply.writeReplyUserName}&nbsp;${reply.writeReplyDate}</font>
							                                    			<c:if test="${params.writeUserID==reply.writeReplyUserID}">
							                                        			<img src="${contextPath}/images/ico/btn_reply_del.gif" style="cursor:pointer;" onclick="DeleteReply('${reply.replyID}');" />
							                                    			</c:if>
							                                			</td>
							                            			</tr>
							                        			</c:if>
							                    			</c:forEach>
							                			</table>
							            			</c:if>
							            			<table width="100%" border="0" cellspacing="0" cellpadding="0">
							            				<tr>
                   											<td height="20"></td>
                   										</tr>
							            			</table> 
							        			</c:if>
							    			</c:forEach>
							    		</c:if>
                   						<!------------------------------ Paging Table START ------------------------->
							    		<table width="100%" height="36" border="0" cellpadding="0" cellspacing="0" align="center">
							        		<tr> 
							            		<td height="15"></td>
							        		</tr>
							        		<tr> 
							            		<td align="center">
							                		<c:if test="${params.superPage > 0}"> 
							                    		<a href="javascript:PageMove('${params.superPage - 1}', '${(params.superPage - 1)*params.pagePerSuperPage}');"> 
							                    		<img src="${contextPath}/images/ico/arr_first.gif" align="absmiddle" border="0"></a>
							                		</c:if>
							                		<c:if test="${params.superPage <= 0}"> 
							                    		<img src="${contextPath}/images/ico/arr_pre.gif" align="absmiddle" border="0"> 
							                		</c:if>
							                  		:: 
								                	<c:if test="${params.exist == 1}">
							                    		<c:forEach var="i" begin="0" end="${params.pagePerSuperPage - 1}" step="1">                 
							                        		<c:if test="${params.breakValue =='N'}">
							                            		<c:if test="${params.page != (params.superPage * params.pagePerSuperPage) + i}">
							                                		<a href="javascript:PageMove('${params.superPage}', '${(params.superPage) * params.pagePerSuperPage + i}')"> 
							                                		${((params.superPage*params.pagePerSuperPage) + i + 1)}</a>
							                            		</c:if>
							                            		<c:if test="${params.page == (params.superPage * params.pagePerSuperPage) + i}"> 
							                                		<strong>${(params.superPage*params.pagePerSuperPage) + i + 1}</strong>
							                            		</c:if>
							                                
							                            		<c:if test="${((params.superPage * params.pagePerSuperPage) + i + 1 != params.pageCount) && (i != (params.pagePerSuperPage - 1))}">
							                                		<img src="${contextPath}/images/ico/arr_line.gif" alt="" />
							                            		</c:if>
							                            		<c:if test="${(((params.superPage * params.pagePerSuperPage) + i + 1)) ==  params.pageCount}">                              
							                                 		<c:set target="${params}" property="breakValue" value="Y"/>                                
							                            		</c:if>                         
							                        		</c:if>
							                   			</c:forEach>
							                		</c:if>
							              			::
							              			<c:if test="${params.superPageCount > params.superPage + 1}"> 
							                  			<a href="javascript:PageMove('${params.superPage + 1}', '${(params.superPage + 1) * params.pagePerSuperPage}');">
							                  			<img src="${contextPath}/images/ico/arr_next.gif" align="absmiddle" border="0"></a> 
							              			</c:if>
							              			<c:if test="${params.superPageCount <= params.superPage + 1}">
							                  			<img src="${contextPath}/images/ico/arr_end.gif" align="absmiddle" border="0">
							              			</c:if> 
							            		</td>
							        		</tr>
							    		</table>
							    		<!------------------------------ Paging Table END ------------------------->
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
                   		<td height="*"></td>
                   	</tr>    
               		<tr>
                   		<td height="5">
				        	<!-- Local Parameter - START -->
				            <input type="hidden" id="userID" name="userID" value="${params.userID}" />
				            <input type="hidden" id="boardID" name="boardID" value="${params.boardID}" />
				            <input type="hidden" id="boardTypeCD" name="boardTypeCD" value="${params.boardTypeCD}" />
				            <input type="hidden" id="writeUserID" name="writeUserID" value="${params.writeUserID}" />       
				            
				            <input type="hidden" id="content" name="content" value="" />
				            <input type="hidden" id="articleID" name="articleID" value="" /> 
				            <input type="hidden" id="superPage" name="superPage" value="${params.superPage}">
				            <input type="hidden" id="page" name="page" value="${params.page}">
				            <input type="hidden" id="writeAuth" name="writeAuth" value="${params.writeAuth}">
				            <input type="hidden" id="breakValue" name="breakValue" value="${params.breakValue}">
				            <input type="hidden" id="isView" name="isView" value="${params.isView}">
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
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}

    .aw-column-0 {width: 80px; text-align:center;}
    .aw-column-1 {width: 400px; }
    .aw-column-2 {width: 100px; text-align: center;}
    .aw-column-3 {width: 100px; text-align: center;}
    .aw-column-4 {width: 80px; text-align: center;}

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
			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
			if ("${params.msg}" != "") {
				fnMessage('${params.msg}');
	        }

			<c:if test="${params.authYN != 'Y'}">
				//btnInsert.setControlVisible(false);
			</c:if>
		};

		${initScript}

		$("#search_btn").click(function(){
			Search();
		});	
	});
	 
    function Insert() {
        <c:choose>
            <c:when test="${params.writeAuth=='N'}">
                message("<fmt:message key="CMP02001A.msg2" />");
            </c:when>
            <c:otherwise>
                fnSubmit(document.form, "${contextPath}/service/board", "newArticle/?viewID=CMP02001B");
            </c:otherwise>
        </c:choose>
    }
    

    // PageMove --
    function PageMove(superPage, page) {	
        $("#superPage").val(superPage);
        $("#page").val(page);
        fnSubmit(document.form, "${contextPath}/service/board", "findArticleList/?viewID=CMP02001A");
    } 
    
    // Move Board Update Screen
    function Update(articleID) {
    	$("#articleID").val(articleID);
        fnSubmitConfirm(document.form, "${contextPath}/service/board", "editArticle/?viewID=CMP02001B", "<fmt:message key="confirm.update" />");
    }
    
    // Move Board Update Screen
    function Recommend(articleID) {
    	$("#articleID").val(articleID);
        fnSubmitConfirm(document.form, "${contextPath}/service/board", "modifyArticleRecommend/?viewID=CMP02001A", "<fmt:message key="CMP02001A.msg3" />");
    }
     
    // Board Delete
    function Delete(articleID) {
    	$("#articleID").val(articleID);
        fnSubmitConfirm(document.form, "${contextPath}/service/board", "removeArticle/?viewID=CMP02001A", "<fmt:message key="confirm.delete" />");
    }
    
    <c:if test="${params.isReply!='N'}">
	    function InsertReply(content, articleID, boardID, superPage, page) {
	    	$("#articleID").val(articleID);
	    	$("#content").val(content);
	    	$("#superPage").val(superPage);
	
	        fnSubmitConfirm(document.form, "${contextPath}/service/board", "addArticleViewReply/?viewID=CMP02001A", "<fmt:message key="confirm.insertReply" />");        
	    }
	    
	    function DeleteReply(replyID) {
	        fnSubmitConfirm(document.form, "${contextPath}/service/board", "removeArticleViewReply/?replyID="+replyID, "<fmt:message key="confirm.deleteReply" />");
	    }
    </c:if>
    
    function openView(articleID) {
    	$("#articleID").val(articleID);    
        fnSubmit(document.form, "${contextPath}/service/board", "viewArticle/?viewID=CMP02001C");
    }

    function Search()  {
   		fnSubmit(form, "${contextPath}/service/board", "findArticleList/?viewID=CMP02001A");        
    }
</script>