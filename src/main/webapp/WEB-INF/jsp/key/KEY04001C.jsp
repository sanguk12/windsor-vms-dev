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
								<%@include file="../sys3/cms/functionbar.jsp" %>
								<%@include file="../sys3/cms/calendar.jsp" %>
								<!-- hidden -->
								<input type="hidden" id="docLinkID" name="docLinkID"/>
								<input type="hidden" id="kmID" name="kmID"/>
								<input type="hidden" id="wordType" name="wordType"/>
							</td>
						</tr>
						<tr>
							<td height="1" style="padding-top: 70px;">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:70px;"></col>
								        			<col style="width:270px;"></col>
								        			<col style="width:70px;"></col>
								        			<col style="width:185px;"></col>
								        			<col style="width:80px;"></col>
								        			<col style="width:100px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond">
															<fmt:message key="KEY04001C.venue" />
														</td>
														<td class="td-input">
															<input type="text" id="venueCD_S" name="venueCD_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly" />
															<input type="text" id="venueNm_S" name="venueNm_S" style="width:130px;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001C.keyMan" />
														</td>
														<td class="td-input">
															<input type="text" id="keyManCD_S" name="keyManCD_S" style="width:80px; text-align: center;" class="input-readonly" readonly="readonly"/>
															<input type="text" id="keyManNm_S" name="keyManNm_S" style="width:80px;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001C.birthDate" />
														</td>
														<td class="td-input">
															<input type="text" id="birthDate" name="birthDate" style="width:80px; text-align: center;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001C.docCompleteYn" />
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
		                   			<tr>
		                    			<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:100px;"></col>
								        			<col style="width:130px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
						                            	<td class="td-cond">
						                            		<fmt:message key="KEY04001C.docuStat" />
														</td>
														<td class="td-input"> 
															<input type="hidden" id="keyManPrgsCd_S" name="keyManPrgsCd_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly" />
															<input type="text" id="keyManPrgsNm_S" name="keyManPrgsNm_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
						                                	<fmt:message key="KEY04001C.comment" />
														</td>
														<td class="td-input" colspan="2"> 
															<input type="text" id="Comment" name="Comment" style="width:450px;" class="input-readonly" readonly="readonly" />
						                                </td>
						                            </tr>
					                            </tbody>
					                        </table>
		                    			</td>
		                   			</tr>
		                   			<tr height="20px"></tr>
		                   			<tr align="center">
										<td height="1">
					                        <table border="0" cellspacing="0" cellpadding="0" width="85%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                        	<tr height="20px"></tr>
					                   			<tr align="center">
					                    			<td>
														<table border="0" cellpadding="0" cellspacing="0" width="70%" style="table-layout:fixed;">
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
																	<td colspan="7">
																		<div class="myInfo">
																			<ul class="inputList">
																				<li class="agree">
																					<div class="group-text">
																						<span class="num" style="font-size: 15px; font-weight:bold;">본인은 아래 업소의 사업자 (또는사업자로부터 운영권을 위임 받은 자)로서디아지오코리아의
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
												                		<input type="text" id="storeNm" name="storeNm" style="width:300px; height:50px; text-align: left; border: #a3a3a3 solid 0px;" readonly="readonly"/>
												                	</td>
												                </tr>
												                <tr>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">본인성명</td>
												                	<td style="text-align:left; padding-left:5px;" colspan="3">
												                		<input type="text" id="reprsNm" name="reprsNm" style="width:100px; text-align: center;"/>
												                	</td>
												                </tr>
												                <tr>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">생년일자</td>
												                	<td style="text-align:left; padding-left:5px;" colspan="3">
												                		<!-- <nis:calendar id="requestDateFrom_S" readOnly="no" /> -->
												                		<input type="text" id="year" name="year" style="width:40px;" maxlength="4">년
												                		<input type="text" id="month" name="month" style="width:20px;" maxlength="2">월
												                		<input type="text" id="date" name="date" style="width:20px;" maxlength="2">일
												                	</td>
												                </tr>
												                <tr>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">작성일자</td>
												                	<td style="text-align:left; padding-left:5px;" colspan="3">
												                		<input type="text" id="regDate" name="regDate" style="width:300px; text-align: left; height:50px; border: #a3a3a3 solid 0px" readonly="readonly"/>
												                	</td>
												                </tr>
												                <tr>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;"></td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">서명</td>
												                	<td style="text-align:left; padding-left:5px;" colspan="3">
												                		<div class="sigPad signed" > 
													                		<ul class="sigNav">
																	    			<li class="clearButton"><a href="#clear">Clear</a></li>
																	  		</ul>
																			<div style="margin-top:1px; margin-bottom:2px; clear:both;height:100px;width:250px;border:1px solid #ccc;"> 
																				<div class="typed"></div>
																				<canvas id="signCanvas" class="pad" width="250" height="100" style="border:#c0d8e4 solid 1px;"></canvas>
																				<input type="hidden" id="output" name="output" class="output">
																			</div>
																		</div>
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
												                		<input type="text" id="keymanNm" name="keymanNm" style="width:80px; height:50px; text-align: center; border: #a3a3a3 solid 0px;" readonly="readonly"/>
												                	</td>
												                	<td style="text-align:left; padding-left:10px; height:50px; font-family:맑은 고딕,gulim,dotum,arial; font-size:13px; color:#70614e; font-weight:bold; background-repeat:no-repeat; background-position:top right;">고객 생년월일</td>
												                	<td style="text-align:left; padding-left:5px;">
												                		<input type="text" id="keymanBirthDate" name="keymanBirthDate" style="width:150px; height:50px; text-align: left; border: #a3a3a3 solid 0px" readonly="readonly"/>
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
		var sig = null;
		
		$('.sigPad').signaturePad({drawOnly:true}).regenerate(sig);
		
		//메뉴바 고정
		$("#btn").attr("style", "position: fixed; width: 100%;");
		
		window.onload = function() {
			$("#kmID").val("${params.kmID}");
			$("#wordType").val("${params.wordType}");
			
			Search();
		};
		
		${initScript}
		
	});

	function deleteDocLink() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/doclink/deleteFile");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("docLinkID", $("#docLinkID").val());
		
		table.request();
		
		if(table.getData(0,0) != "S") {
			alert(table.getData(1,0));
			return false;
   		}
		return true;
	}
	
	function searchDocLink() {
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/simpleAction/KEY0400108S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","searchCount;");
	  	table.setParameter("docLinkID", $("#docLinkID").val());
      	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
			if(table.getData(0,0) == "1") {
				return true;
			}
			else {
				table.getData(0,0);
				return false;
			}
      	}
      	else {
      		return;
      	}
	}
	
	function validationChk(){
		
		var isBoolean = true;
		var DocFinshFl = $("#DocFinshFl").val();
		var keyManPrgsCd_S = $("#keyManPrgsCd_S").val();
		
		
		if(DocFinshFl == 'Y') { // 서류완료여부가 완료인 경우 수정불가
			alert("<fmt:message key="KEY04001D.msg1"/>");
			isBoolean = false;
		}
		if(keyManPrgsCd_S == '400') {
			alert("<fmt:message key="KEY04001D.msg2"/>");
			isBoolean = false;
		}

		return isBoolean;
		
	}
	
	function chkValidate(chkObjs){
		for (var i=0; i<chkObjs.length ; i++){
			switch(chkObjs[i]) {   
				case 'reprsNm':
					if($("#reprsNm").val() == null || $("#reprsNm").val() == ""){
						alert("본인성명을 입력하세요.");
						$("#reprsNm").focus();
						return false;
					}
				break;   
				case 'year':
					if($("#year").val() == null || $("#year").val() == ""){
						alert("생년일자를 입력하세요.");
						$("#year").focus();
						return false;
					}
					if(isNaN($("#year").val())) {
						alert("유효하지 않은 글자가 입력 되었습니다.");
						$("#year").focus();
						return false;
					}
					if($("#year").val().length < 4) {
						alert("생년일자를 입력하세요.");
						$("#year").focus();
						return false;
					}
				break;   
				case 'month':
					var month = parseInt($("#month").val());
					if($("#month").val() == null || $("#month").val() == ""){
						alert("생년일자를 입력하세요.");
						$("#month").focus();
						return false;
					}
					if(isNaN(month)) {
						alert("유효하지 않은 글자가 입력 되었습니다.");
						$("#month").focus();
						return false;
					}
					if($("#month").val().length < 2) {
						if($("#month").val() == "0") {
							alert("생년일자를 입력하세요.");
							$("#month").focus();
							return false;
						}
						else {
							$("#month").val("0"+$("#month").val());
						}
					}
				break;
				case 'date':
					var date = parseInt($("#date").val());
					if($("#date").val() == null || $("#date").val() == ""){
						alert("생년일자를 입력하세요.");
						$("#date").focus();
						return false;
					}
					if(isNaN(date)) {
						alert("유효하지 않은 글자가 입력 되었습니다.");
						$("#date").focus();
						return false;
					}
					if($("#date").val().length < 2) {
						if($("#date").val() == "0") {
							alert("생년일자를 입력하세요.");
							$("#date").focus();
							return false;
						}
						else {
							$("#date").val("0"+$("#date").val());
						}
					}
				break;
				case 'regDate':
					if($("#regDate").val() == null || $("#regDate").val() == ""){
						alert("날짜");
						return false;
					}
				break;  
				case 'keymanNm':
					if($("#keymanNm").val() == null || $("#keymanNm").val() == ""){
						alert("고객이름");
						$("#keymanNm").focus();
						return false;
					}
				break;   
				case 'keymanBirthDate':
					if($("#keymanBirthDate").val() == null || $("#keymanBirthDate").val() == ""){
						alert("고객생일");
						$("#keymanBirthDate").focus();
						return false;
					}
				break;   
				case 'output':
					if(($("#output").val().length == 2 && $("#output").val() == '[]')||($("#output").val() == ''||$("#output").val() == null)){
						alert("서명");
						return false;
					}
				break;   
				default:
					alert("Error - chkValidate :  chkObjs[" + i + "] = [" + chkObjs[i] + "]");
				return false;
			}
		}
		return true;
	}
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	function Save() {

		if(!validationChk() || !chkValidate(["reprsNm", "year", "month", "date", "keymanNm", "keymanBirthDate", "regDate", "output"])){
			return;
		}
		
		if(searchDocLink()) {
			if(!deleteDocLink()){
				return false;
			}
		}
		
		var signCanvas = document.getElementById("signCanvas");
		var prgsCd = "";
		if($("#keyManPrgsCd_S").val() == '100') {
			prgsCd = "100";
		}else if($("#keyManPrgsCd_S").val() == '200') {
			prgsCd = "200";
		}else if($("#keyManPrgsCd_S").val() == '300') {
			prgsCd = "200";
		}
		else if($("#keyManPrgsCd_S").val() == '999') {
			prgsCd = "100";
		}
		else if($("#keyManPrgsCd_S").val() == '400') {
			alert("<fmt:message key="KEY04001B.msg2"/>");
			return false;
		}
		
		var reprsBirthDate = new String($("#year").val())+new String($("#month").val())+new String($("#date").val());
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key04/saveSaleRegist");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("keymanID", $("#keyManCD_S").val());
		table.setParameter("keymanDocTpCd", "200");
		table.setParameter("keymanPrgsCd", prgsCd);
		table.setParameter("docWorkDate", unformat($("#regDate").val()));
		table.setParameter("reprsNm", $("#reprsNm").val());
		table.setParameter("reprsBirthDate", reprsBirthDate);
		table.setParameter("keymanNm", $("#keymanNm").val());
		table.setParameter("keymanBirthDate", unformat($("#keymanBirthDate").val()));
		table.setParameter("signvector1", $("#output").val());
		table.setParameter("fileDocLink", $("#docLinkID").val());
		table.setParameter("data", signCanvas.toDataURL("image/png"));
		table.setParameter("linkDivCD", "SIGNIMAGE");
		
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			<c:if test="${!empty params.finalAction}"> 
				opener.${params.finalAction}();
			</c:if>
			window.close();
   		} else {
			alert(table.getData(1,0));
		}
		
	}
	
	function List() {
		opener.Search();
		window.close();
	}
	
	function Search() {
		kmSearch();
		signSearch();
	}
	
	//서명 조회
	function signSearch() {
		var table = new AW.XML.Table;	  
	  	table.setURL("${contextPath}/service/key04/signSearch");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","signvector1;");
	  	table.setParameter("format","str;");
	  	table.setParameter("kmID", "${params.kmID}");
        table.setParameter("wordType", "${params.wordType}");
      	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#output").val(table.getData(0,0));
	      	$('.sigPad').signaturePad({displayOnly:true}).regenerate($("#output").val());
      	}
      	
      	
	}
	
	//키맨정보 조회
	function kmSearch() {
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/KEY0400106S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey", "venueCD;venueNm;keymanID;keymanNm;birthDate;"
        											+ "DocFinshFl;DocFinshFlNm;keyManPrgsCd;KeymanPrgsNm;storeNm;"
        											+ "reprsNm;reprsBirthDate;docWorkDate;comment;docLinkID;");
        table.setParameter("format", "str;str;str;str;date;"
        									+"str;str;str;str;str;"
        									+"str;str;date;str;str;");
        table.setParameter("kmID", "${params.kmID}");
        table.setParameter("wordType", "${params.wordType}");
        table.request();
        
        var rowCount = table.getCount();
      	if (rowCount == 1) {
   			$("#venueCD_S").val(table.getData(0,0));
   			$("#venueNm_S").val(table.getData(1,0));
   			$("#keyManCD_S").val(table.getData(2,0));
   			$("#keyManNm_S").val(table.getData(3,0));
   			$("#birthDate").val(table.getData(4,0));
   			$("#DocFinshFl").val(table.getData(5,0));
   			$("#DocFinshFlNm").val(table.getData(6,0));
   			$("#keyManPrgsCd_S").val(table.getData(7,0));
   			$("#keyManPrgsNm_S").val(table.getData(8,0));
   			$("#storeNm").val(table.getData(1,0));
   			$("#reprsNm").val(table.getData(10,0));
   			var requestDateFrom = table.getData(11, 0);
   			$("#year").val(requestDateFrom.substring(0,4));
   			$("#month").val(requestDateFrom.substring(4,6));
   			$("#date").val(requestDateFrom.substring(6,8));
   			$("#requestDateFrom_S").val(table.getData(11,0));
   			$("#keymanNm").val(table.getData(3,0));
   			$("#keymanBirthDate").val(table.getData(4,0));
   			if(table.getData(12,0) == null || table.getData(12,0) == "") {
   				$("#regDate").val("${params.currentDate}");
   			}
   			else {
   				$("#regDate").val(table.getData(12,0));
   			}
   			
   			if(table.getData(5,0) == "Y" || table.getData(7,0) == "400"){		// 서류완료상태가 완료(Y)인 경우 파일첨부 기능 숨김
   				$("#signButton").hide();
   			}
   			
   			$("#Comment").val(table.getData(13,0));
   			$("#docLinkID").val(table.getData(14,0));
   			
      	}else {
      		message("<fmt:message key="info.nullData"/>");
      	}
	}
	
	//서명이미지 출력
	function upload() {
		var signCanvas = document.getElementById("signCanvas");
		
		var req = new AW.XML.Table;
        req.setURL("${contextPath}/service/key04/signImg");
        req.setAsync(false);
        req.setRequestMethod("POST");
        req.setParameter("keymanID", $("#keyManCD_S").val());
        req.setParameter("linkDivCD", "SIGNIMAGE");
        req.setParameter("data", signCanvas.toDataURL("image/png"));
        req.request();
        
		if(req.getData(0,0) == "S") {
        	$("#docLinkID").val(req.getData(3,0));
   		} else {
			alert(req.getData(1,0));
		}
    }
	
	function openSignCheck(finalAction){
		
		/* if(!win.closed && win) {
        	return false;
		} */
		
		var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
	    "&viewID=KEY04001E"+
	    "&finalAction="+finalAction;
    	win = pageNewWindow(url,"KEY04001E",300,270,"yes");
	    
	}
	
	win = "";
	function pageNewWindow() {
		if(!win.closed && win) {
			window._childwin.focus();
	    	return false;
		} 
		var winName = "KEY04001E";
		var sURL = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
	    "&viewID=KEY04001E"+
	    "&finalAction=closeSignPopup";
		
	    var iWidth = (screen.width - 300) / 2;
	    var iHeight = (screen.height - 270) / 2;
	    winprops = "height=270"+",width=300"+",top="+iHeight+",left="+iWidth+",scrollbars=yes"+",dependent=yes ,resizable=yes"
	    win = window.open(sURL, winName.replace(/./gi,""), winprops);
	    if (parseInt(navigator.appVersion)>=4) { win.window.focus(); }
	}
</script>