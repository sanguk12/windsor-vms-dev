<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 인센티브 프로그램 참여 동의서 등록화면 -->
<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/signScripts.jsp" %>
	</head>

	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
			<div id="wrapDiv">
          		<div id="formDiv">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            	<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/calendar.jsp" %>
								<!-- Pdf -->
								<input type="hidden" id="path" name="path" value = "C:/deploy/diageo" />
					            <input type="hidden" id="report" name="report">
					            <input type="hidden" id="format" name="format">
					            <input type="hidden" id="keymanID" name="keymanID">
					            <!-- hidden -->
					            <input type="hidden" id="docLinkID" name="docLinkID">
					            <input type="hidden" id="valexStatCd" name="valexStatCd">
							</td>
						</tr>
						<tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                   			<tr>
		                    			<td>
											<table border="0" cellpadding="0" cellspacing="0" width="70%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:100px;"></col>
								        			<col style="width:130px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
								        			<tr>
						                            	<td class="td-cond">
						                            		<fmt:message key="KEY03003D.depDocuStat" />
														</td>
														<td class="td-input" colspan="3"> 
															<input type="text"  id="defaultPrgs" name="defaultPrgs" class="input-readonly" readonly="readonly" style="width:80px; text-align: center;"/>
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond">
						                            		<fmt:message key="KEY03003D.docuStat" />
														</td>
														<td class="td-input"> 
															<nis:selectbox id="keymanPrgsCd" name="keymanPrgsCd" defaultText="select" category="KEYMANPRGSCD" />
						                                </td>
						                                <td class="td-cond">
						                                	<fmt:message key="KEY03003D.comment" />
														</td>
														<td class="td-input"> 
															<input type="text" id="Comment" name="Comment" style="width:450px;"/>
						                                </td>
						                            </tr>
					                            </tbody>
					                        </table>
		                    			</td>
		                   			</tr>
		                   			<tr height="20px"></tr>
		                   			<tr align="left">
										<td height="1">
					                        <table border="0" cellspacing="0" cellpadding="0" width="70%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                        	<tr height="20px"></tr>
					                   			<tr align="left">
					                    			<td>
														<table border="0" cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed;">
								                            <colgroup>
								                            	<col style="width:115px;"></col>
											        			<col style="width:220px;"></col>
											        			<col style="width:100px;"></col>
											        			<col></col>
											        		</colgroup>
											        		<tbody>
									                            <div style="font-family:맑은 고딕,gulim,dotum,arial; font-size:30px; color:#666; font-weight:bold; padding-left:15px; padding-bottom:2px; text-align:center; background-repeat:no-repeat; background-position:left;">인센티브 프로그램 참여 동의서</div>
								                            </tbody>
								                        </table>
					                    			</td>
					                   			</tr>
					                   			<tr height="20px"></tr>
					                    		<tr align="center">
					                    			<td>
														<table style="width: 80%; height: 100%; border-collapse:collapse; border:#e1dcbe solid 0px; table-layout:fixed;">
															<tbody>
																<tr>
																	<td>
																		<div class="myInfo">
																			<ul class="inputList">
																				<li class="agree">
																					<div class="group-text">
																						<span class="num" style="font-size: 16px; font-weight:bold;">본인은 아래 업소의 사업자 (또는사업자로부터 운영권을 위임 받은 자)로서디아지오코리아의
													                					트레이드 고객 인센티브 프로그램에 대해 설명을 듣고 이해 했으며 본 업소에 종사하고 있는
													                					아래의 인원들이 프로그램에 참여하는 것에 동의 합니다. </span>
																					</div>
																				</li>
																			</ul>
																		</div>
																	</td>
																</tr>
															</tbody>
								                        </table>
					                    			</td>
					                   			</tr>
					                   			<tr height="30px"></tr>
					                   			<tr align="center">
					                    			<td>
														<table border="0" cellpadding="0" cellspacing="0" width="70%" style="border:#e1dcbe solid 0px; table-layout:fixed;">
								                            <colgroup>
								                            	<col style="width:80px;"></col>
								                            	<col style="width:115px;"></col>
											        			<col style="width:220px;"></col>
											        			<col style="width:100px;"></col>
											        			<col></col>
											        		</colgroup>
											        		<tbody>
												                <tr>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">업소명</td>
												                	<td style="text-align:left; padding-left:5px;" colspan="3">
												                		<input type="text" id="storeNm" name="storeNm" style="width:300px; text-align: left; border: #a3a3a3 solid 0px;" readonly="readonly"/>
												                	</td>
												                </tr>
												                <tr>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">본인성명</td>
												                	<td style="text-align:left; padding-left:5px;" colspan="3">
												                		<input type="text" id="reprsNm" name="reprsNm" style="width:300px; text-align: left; border: #a3a3a3 solid 0px;" readonly="readonly"/>
												                	</td>
												                </tr>
												                <tr>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">생년일자</td>
												                	<td style="text-align:left; padding-left:5px;" colspan="3">
												                		<input type="text" id="reprsBirthDate" name="reprsBirthDate" style="width:300px; text-align: left; border: #a3a3a3 solid 0px;" readonly="readonly"/>
												                	</td>
												                </tr>
												                <tr>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">작성일자</td>
												                	<td style="text-align:left; padding-left:5px;" colspan="3">
												                		<input type="text" id="regDate" name="regDate" style="width:300px; text-align: left; border: #a3a3a3 solid 0px" readonly="readonly"/>
												                	</td>
												                </tr>
												                <tr height="100%">
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">
												                		<fmt:message key="KEY03003D.sign" />
												                	</td>
												                	<td style="text-align:left; padding-left:5px;" colspan="3">
												                		<img src="" id='previewId' style="width: auto; height: auto; border: 1px solid black; margin-left: 10px; margin-top: 7px; margin-right: 10px; margin-bottom: 10px;" ></img>
												                	</td>
												                </tr>
								                            </tbody>
								                        </table>
					                    			</td>
					                   			</tr>
					                   			<tr height="50px"></tr>
					                   			<tr align="center">
					                    			<td>
														<table border="0" cellpadding="0" cellspacing="0" width="70%" style="border:#e1dcbe solid 0px; table-layout:fixed;">
								                            <colgroup>
								                            	<col style="width:80px;"></col>
								                            	<col style="width:120px;"></col>
											        			<col style="width:150px;"></col>
											        			<col style="width:100px;"></col>
											        			<col></col>
											        		</colgroup>
											        		<tbody>
												                <tr>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">트레이드 고객이름</td>
												                	<td style="text-align:left; padding-left:5px;">
												                		<input type="text" id="keymanNm" name="keymanNm" style="width:80px; text-align: center; border: #a3a3a3 solid 0px;" readonly="readonly"/>
												                	</td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">고객 생년월일</td>
												                	<td style="text-align:left; padding-left:5px;">
												                		<input type="text" id="keymanBirthDate" name="keymanBirthDate" style="width:150px; text-align: left; border: #a3a3a3 solid 0px" readonly="readonly"/>
												                	</td>
												                </tr>
								                            </tbody>
								                        </table>
					                    			</td>
					                   			</tr>
											</table>
										</td>
									</tr>
								</table>
		                    </td>
		                </tr>
		                <tr>
							<td height="*" valign="top"></td>
						</tr>
					</table>
				</div>
				${appletDiv}
			</div>
		</form>
	</body>
</html>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 
	/****************************************
	 * Function
	 ****************************************/

	$(document).ready(function() {
		
		$("select[name='keymanPrgsCd'] option[value='999']").remove();
		$("select[name='keymanPrgsCd'] option[value='100']").remove();
		$("select[name='keymanPrgsCd'] option[value='200']").remove();
		
		window.onload = function() {

			Search();
			
		};
		
		${initScript}
		
	});
	
	function validationChk(){
		
		var isBoolean = true;
		var DocFinshFl = $("#DocFinshFl").val();
		var valexStatCd = $("#valexStatCd").val();
		
		
		if(DocFinshFl == 'Y') { // 서류완료여부가 완료인 경우 수정불가
			alert("<fmt:message key="KEY04001D.msg1"/>");
			isBoolean = false;
		}
		if(valexStatCd == '400') {
			alert("<fmt:message key="KEY04001D.msg2"/>");
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
		if(parent.$("#DocFinshFl").val() == 'Y') { // 서류완료여부가 완료인 경우 수정불가
			alert("<fmt:message key="KEY03003D.msg1"/>");
			return false;
		}
		
		if($("#valexStatCd").val() == '999'){
			alert("<fmt:message key="KEY03003D.msg4"/>");
			return false;
		}
		
		if($("#keymanPrgsCd").val() == ''){
			alert("<fmt:message key="KEY03003C.msg5"/>");
			$("#keymanPrgsCd").focus();
			return false;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key04/updateGKEY05MT");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("docComment", $("#Comment").val());
		table.setParameter("keymanPrgsCd", $("#keymanPrgsCd").val());
		table.setParameter("keymanID", parent.$("#keyManCD_S").val());
		table.setParameter("keymanDocTpCd", "200");
		
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
   		} else {
			alert(table.getData(1,0));
		}
	}
	
	function List() {
		opener.Search();
		window.close();
	}
	
	function Search() {
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/KEY0400106S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey", "venueCD;venueNm;keymanID;keymanNm;birthDate;"
        											+ "DocFinshFl;DocFinshFlNm;keyManPrgsCd;KeymanPrgsNm;storeNm;"
        											+ "reprsNm;reprsBirthDate;docWorkDate;"
        											+ "fileUrl;uuid;comment;docLinkID;");
        table.setParameter("format", "str;str;str;str;date;"
        									+"str;str;str;str;str;"
        									+"str;date;date;"
        									+"str;str;str;str;");
        table.setParameter("kmID", parent.$("#keyMan").val());
        table.setParameter("wordType", "200");
        table.request();
        
        var rowCount = table.getCount();
      	if (rowCount == 1) {
      		parent.$("#venueCD_S").val(table.getData(0,0));
      		parent.$("#venueNm_S").val(table.getData(1,0));
      		parent.$("#keyManCD_S").val(table.getData(2,0));
      		parent.$("#keyManNm_S").val(table.getData(3,0));
      		parent.$("#birthDate").val(table.getData(4,0));
      		parent.$("#DocFinshFl").val(table.getData(5,0));
      		parent.$("#DocFinshFlNm").val(table.getData(6,0));
      		
      		$("#keymanPrgsCd").val(table.getData(7,0));
      		$("#valexStatCd").val(table.getData(7,0));
      		$("#defaultPrgs").val(table.getData(8,0));
   			$("#KeyManPrgsNm_S").val(table.getData(8,0));
   			$("#storeNm").val(table.getData(1,0));
   			$("#reprsNm").val(table.getData(10,0));
   			$("#reprsBirthDate").val(table.getData(11,0));
   			$("#keymanNm").val(table.getData(3,0));
   			$("#keymanBirthDate").val(table.getData(4,0));
   			
   			if(table.getData(12,0) == null || table.getData(12,0) == "") {
   				$("#regDate").val("${params.currentDate}");
   			}
   			else {
   				$("#regDate").val(table.getData(12,0));
   			}
   			
   			var filePath = table.getData(13,0)+table.getData(14,0);
   			if(table.getData(13,0) != ""){
   				$("#previewId").attr("src","/upload/"+filePath);
   			}
   			
   			$("#Comment").val(table.getData(15,0));
   			$("#docLinkID").val(table.getData(16,0));
   			
      	}else {
      		//message("<fmt:message key="info.nullData"/>");
      	}
	}
	
	function KeymDocConf(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key03/updateKeymanDocComp");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("keymanID", parent.$("#keyManCD_S").val());
		table.setParameter("keymanDocTpCd", "200");
		table.setParameter("docFinshFl", "Y");
		
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			parent.$("#DocFinshFl").val('Y');
			parent.$("#DocFinshFlNm").val('완료');
   		} else {
			alert(table.getData(1,0));
		}
	}
	
	function KeymDocConfCancel(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key03/updateKeymanDocComp");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("keymanID", parent.$("#keyManCD_S").val());
		table.setParameter("keymanDocTpCd", "200");
		table.setParameter("docFinshFl", "N");
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			parent.$("#DocFinshFl").val('N');
			parent.$("#DocFinshFlNm").val('미완료');
   		} else {
			alert(table.getData(1,0));
		}
	}
	
	function Pdf() {
		if($("#docLinkID").val() == ""){
			alert("<fmt:message key="KEY03003D.msg3"/>");
			return;
		}
		
		var winprops = getWindowOpenParam(1000,700,"yes");
	    var win = window.open("", "reportviewer", winprops);
	            
	    document.form.action = "${contextPath}/service/simpleReport";
        document.form.target = "reportviewer";
        document.getElementById("report").value = "KEY03003D";
        document.getElementById("format").value = "pdf";
        document.getElementById("path").value;
        document.getElementById("keymanID").value = parent.$("#keyMan").val();
        document.form.submit();
	}
	
</script>