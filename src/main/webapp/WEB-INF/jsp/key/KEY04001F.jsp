<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 대표권위임확인서 등록화면 -->
<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
	</head>

	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
			<div id="wrapDiv">
          		<div id="formDiv">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            	<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/functionbar.jsp" %>
								<%@include file="../sys3/cms/calendar.jsp" %>
								<input type="hidden" id="docLinkID" name="docLinkID"/>
								<input type="hidden" id="kmID" name="kmID"/>
								<input type="hidden" id="wordType" name="wordType"/>
							</td>
						</tr>
						<tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:80px;"></col>
								        			<col style="width:250px;"></col>
								        			<col style="width:60px;"></col>
								        			<col style="width:200px;"></col>
								        			<col style="width:80px;"></col>
								        			<col style="width:100px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond">
															<fmt:message key="KEY04001D.venue" />
														</td>
														<td class="td-input">
															<input type="text" id="venueCD_S" name="venueCD_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly" />
															<input type="text" id="venueNm_S" name="venueNm_S" style="width:130px;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001D.keyMan" />
														</td>
														<td class="td-input">
															<input type="text" id="keyManCD_S" name="keyManCD_S" style="width:80px; text-align: center;" class="input-readonly" readonly="readonly"/>
															<input type="text" id="keyManNm_S" name="keyManNm_S" style="width:100px;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001D.birthDate" />
														</td>
														<td class="td-input">
															<input type="text" id="birthDate" name="birthDate" style="width:80px; text-align: center;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001D.docCompleteYn" />
														</td>
														<td class="td-input">
															<input type="text" id="DocFinshFlNm" name="DocFinshFlNm" style="width:80px; text-align: center;" class="input-readonly" readonly="readonly" />
															<input type="hidden" id="DocFinshFl" name="DocFinshFl" style="width:80px; text-align: center;" class="input-readonly" readonly="readonly" />
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
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:80px;"></col>
								        			<col style="width:130px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
						                            	<td class="td-cond">
						                            		<fmt:message key="KEY04001D.docuStat" />
														</td>
														<td class="td-input"> 
															<input type="hidden" id="keyManPrgsCd_S" name="keyManPrgsCd_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly" />
															<input type="text" id="keyManPrgsNm_S" name="keyManPrgsNm_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
						                                	<fmt:message key="KEY04001D.comment" />
														</td>
														<td class="td-input"> 
															<input type="text" id="Comment" name="Comment" style="width:600px;" class="input-readonly" readonly="readonly" />
						                                </td>
						                            </tr>
					                            </tbody>
					                        </table>
		                    			</td>
		                   			</tr>
								</table>
		                    </td>
		                </tr>
		                <tr id="trFileArea">
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:80px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
							                    		<td class="td-cond">
							                    			<fmt:message key="CMP02001B.fileAttatch"/>
							                    		</td>
							                    		<td class="td-input">
							                        		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
							                           			<tr>
							                               			<td height="25" width="650px">
							                               				<!-- 모바일 파일업로드 -->
							                               				<input type="file" id="fileName" name="fileName" cols="100" value="" style="width:300px;" >
						                                       			<script type="text/javascript">
																			var uploadBtn = new AW.UI.Button;
																			uploadBtn.setControlText("<fmt:message key="button.Upload" />");
																			uploadBtn.setControlImage("fileupload");
													                      	document.write(uploadBtn);
													                      
													                      	uploadBtn.onControlClicked = function(event) {		 
													                      		fmAttach();
													                      	};
																		</script>
																		<!-- 사진 회전 이벤트 -->
																		<script type="text/javascript">
																			var left = new AW.UI.Button;
																			left.setControlText("<fmt:message key="KEY04001D.left" />");
																			left.setControlImage("prev");
													                      	document.write(left);
													                      
													                      	left.onControlClicked = function(event) {		 
													                      		removeImg('L');
													                      	};
																		</script>
																		<script type="text/javascript">
																			var right = new AW.UI.Button;
																			right.setControlText("<fmt:message key="KEY04001D.right" />");
																			right.setControlImage("next");
													                      	document.write(right);
													                      
													                      	right.onControlClicked = function(event) {		 
													                      		removeImg('R');
													                      	};
																		</script>
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
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
							                		<tr height="100%">
									                	<td>
														    <img src="" id='previewId' style="width: 99%; height: auto; padding-left: 5px; padding-top: 5px; padding-right: 5px; padding-bottom: 5px;"></img>
													    </td>
									                </tr>
									                <tr>
														<td height="*" valign="top">
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
							<td height="*" valign="top">
							</td>
						</tr>
					</table>
				</div>
				${appletDiv}
			</div>
					
		</form>
	</body>
</html>

<script language="javascript">
	
	//Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	 * Variable
	 ****************************************/
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});
	
	
	$(document).ready(function() {

		window.onload = function() {
			$("#kmID").val("${params.kmID}");
			$("#wordType").val("${params.wordType}");
			
			if("${params.docLinkID}" != "") {
				$("#docLinkID").val("${params.docLinkID}");
				$("#previewId").attr("src","${contextPath}/upload/"+"${params.fileUrl}"+"${params.UUID}"); 
			}
			
			Search();
		};
		
		${initScript}
		
	});
	
	function validationChk(){
		
		var isBoolean = true;
		var DocFinshFl = $("#DocFinshFl").val();
		var keyManPrgsCd_S = $("#keyManPrgsCd_S").val();
		var docLinkID = $("#docLinkID").val();
		
		var keymanPrgsCd = $("#keymanPrgsCd").val();
		
		
		if(DocFinshFl == 'Y') {
			alert("<fmt:message key="KEY04001F.msg1"/>");
			isBoolean = false;
		}
		if(keyManPrgsCd_S == '400') {
			alert("<fmt:message key="KEY04001F.msg2"/>");
			isBoolean = false;
		}
		if(docLinkID == '') {
			alert("<fmt:message key="KEY04001F.msg3"/>");
			isBoolean = false;
		}
		
		return isBoolean;
		
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	function Save() {
		$("[name=form]").attr("enctype","application/x-www-form-urlencoded");
		
		if(!validationChk()){
			return;
		}
		
		var prgsCd = "";
		if($("#keyManPrgsCd_S").val() == '100') {
			prgsCd = "100";
		}else if($("#keyManPrgsCd_S").val() == '200') {
			prgsCd = "200";
		}else if($("#keyManPrgsCd_S").val() == '300') {
			prgsCd = "200";
		}else if($("#keyManPrgsCd_S").val() == '999') {
			prgsCd = "100";
		}else if($("#keyManPrgsCd_S").val() == '400') {
			alert("<fmt:message key="KEY04001B.msg2"/>");
			return false;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key04/saveSaleRegist");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("keymanID", $("#keyManCD_S").val());
		table.setParameter("keymanDocTpCd", "400");
		table.setParameter("keymanPrgsCd", prgsCd);
		table.setParameter("docWorkDate", convertDate("${params.currentDate}"));
		table.setParameter("fileDocLink", $("#docLinkID").val());
		
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			opener.Search();
			window.close();
   		} else {
			alert(table.getData(1,0));
		}
		
	}
	
	function List() {
		<c:if test="${!empty params.finalAction}"> 
			opener.${params.finalAction}();
		</c:if>
		
		window.close();
	}
	
	function Search() {
		$("[name=form]").attr("enctype","application/x-www-form-urlencoded");
		
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/KEY0400103S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey", "venueCD;venueNm;keymanID;keymanNm;birthDate;"
														+ "DocFinshFl;DocFinshFlNm;DocComment;FileDocLink;fileUrl;"
														+ "uuid;keyManPrgsCd;KeymanPrgsNm;");
        table.setParameter("format", "str;str;str;str;str;"
														+"str;str;str;str;str;"
														+"str;str;str;");
        table.setParameter("kmID", "${params.kmID}");
        table.setParameter("wordType", "${params.wordType}");
        table.request();
        
        var rowCount = table.getCount();
      	if (rowCount == 1) {
      		$("#venueCD_S").val(table.getData(0,0));
   			$("#venueNm_S").val(table.getData(1,0));
   			$("#keyManCD_S").val(table.getData(2,0));
   			$("#keyManNm_S").val(table.getData(3,0));
   			$("#birthDate").val(formatDate(table.getData(4,0)));
   			$("#DocFinshFl").val(table.getData(5,0));
   			$("#DocFinshFlNm").val(table.getData(6,0));
   			$("#Comment").val(table.getData(7,0));
   			if("${params.docLinkID}" == "") {
   				$("#docLinkID").val(table.getData(8,0));
   			}
   			$("#keyManPrgsCd_S").val(table.getData(11,0));
   			$("#keyManPrgsNm_S").val(table.getData(12,0));
   			
   			if(table.getData(8,0) != "" && "${params.docLinkID}" == ""){
   				$("#previewId").attr("src","${contextPath}/upload/"+table.getData(9,0)+table.getData(10,0));
   			}
   			
   			if(table.getData(5,0) == "Y" || table.getData(11,0) == "400"){		// 서류완료상태가 완료(Y)인 경우 파일첨부 기능 숨김
   				$("#trFileArea").hide();
   			}
   			
      	}else {
      		message("<fmt:message key="info.nullData"/>");
      	}
		
      	
	}
	
</script>

<script type="text/javascript">

	//파일업로드 모바일
	function fmAttach() {
		if($("#fileName").val() == "") {
			alert("파일을 선택 하세요.");
			return false;
		}
		
		document.form.action = "${contextPath}/service/doclink/insertFileForMobile?companyID=${params.companyID}&linkDivCD=SIGN&viewName="+"${params.viewName}";
	    $("[name=form]").attr("enctype","multipart/form-data");
	    document.form.submit();
	    
	    showLoading();
	}

	//사진 회전 이벤트
	function removeImg(removeYn) {
		if($("#fileName").val() == "" && $("#docLinkID").val() == "") {
			alert("파일을 선택 하세요.");
			return false;
		}
		
		if($("#fileName").val() != "" && $("#docLinkID").val() == "") {
			alert("파일을 업로드 하세요.");
			return false;
		}
		
		document.form.action = "${contextPath}/service/doclink/removeImg?companyID=${params.companyID}&linkDivCD=SIGN&viewName="+"${params.viewName}&removeCD="+removeYn;
		
	    $("[name=form]").attr("enctype","multipart/form-data");
	    document.form.submit();
	    
	    showLoading();
	} 
</script>