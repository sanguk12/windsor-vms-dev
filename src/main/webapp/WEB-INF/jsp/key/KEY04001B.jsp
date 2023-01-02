<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 개인정보 동의서 등록화면 -->
<html>
	<head>
		<title>${params.viewName}</title>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
			<%@include file="../sys3/signScripts.jsp" %>
	</head>
	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post" >
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
								<input type="hidden" id="keymanID" name="keymanID" value="${params.kmID }">
								<input type="hidden" id="keymanDocTpCd" name="keymanDocTpCd" value="${params.wordType }">
							</td>
						</tr>
						<tr>
							<td height="1" valign="top" style="padding-bottom: 0;padding-top: 70px;">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                        	<tr>
		                        		<td class="tb-border">
		                        			<table style="width: 100%; height: 100%; border-collapse:collapse; border:#e1dcbe solid 1px; table-layout:fixed;">
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
															<fmt:message key="KEY04001B.venue" />
														</td>
														<td class="td-input">
															<input type="text" id="venueCD_S" name="venueCD_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly" />
															<input type="text" id="venueNm_S" name="venueNm_S" style="width:140px;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001B.keyMan" />
														</td>
														<td class="td-input">
															<input type="text" id="keyManCD_S" name="keyManCD_S" style="width:80px; text-align: center;" class="input-readonly" readonly="readonly"/>
															<input type="text" id="keyManNm_S" name="keyManNm_S" style="width:80px;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001B.birthDate" />
														</td>
														<td class="td-input">
															<input type="text" id="birthDate" name="birthDate" style="width:80px; text-align: center;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001B.docCompleteYn" />
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
						                            		<fmt:message key="KEY04001B.docuStat" />
														</td>
														<td class="td-input"> 
															<input type="hidden" id="keyManPrgsCd_S" name="keyManPrgsCd_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly" />
															<input type="text" id="KeyManPrgsNm_S" name="KeyManPrgsNm_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly" />
						                                </td>
						                                <td class="td-cond">
						                                	<fmt:message key="KEY04001B.comment" />
														</td>
														<td class="td-input" > 
															<input type="text" id="Comment" name="Comment" style="width:450px;" class="input-readonly" readonly="readonly" />
						                                </td>
						                            </tr>
					                            </tbody>
					                        </table>
		                    			</td>
		                   			</tr>
		                   			<tr height="7px;"></tr>
		                    		<tr>
		                    			<td>
											<table style="width: 100%; height: 100%; border-collapse:collapse; border:#e1dcbe solid 1px; table-layout:fixed;">
												<tbody>
													<tr>
														<div class="group-title">개인정보 수집 및 이용 동의</div>
														<td colspan="6">
															<div class="myInfo">
																<ul class="inputList">
																	<li class="agree">
																		<!-- 개인정보 수집 및 이용 동의  -->
																		<div class="group-text">개인정보 수집 및 이용 동의</div>
																		<div class="terms">
																			<ul class="innerWrap">
																				<li><span class="num">1.  수집하는 개인정보의 항목</span><p class="article">성명, 주소, 업소명, 업소 연락처, Customer 연락처(성명 포함), 거래계좌정보(금융기관명, 예금주, 계좌번호 등), 명함에 기재된 개인정보 등</p></li>
																				<li><span class="num">2.	수집•이용 목적</span><p class="article">   - 계약 당사자의 신원 확인, 계약 체결 여부의 결정, 상품의 공급 및 대금 수령 등 계약의 이행, 관련 분쟁에 대한 대응(내용증명 발송•가압류 신청•소 제기 등 포함)<br>
																																											  - 법인세•주세•부가가치세 등 각종 세금의 신고•납부, 영수증•세금계산서•주류판매계산서의 발급•교부 등 회사에 부과되는 법적•행정적 의무의 이행<br>
																																											  - 계약내용•거래현황•물품공급, 대금지급내역 등에 대한 전산관리 및 고객 관계 관리 등</p></li>
																				<li><span class="num">3.	보유 및 이용기간:</span><p class="article">관계법령에 따른 보존 의무가 인정되지 않는 한, 위 수집•이용 목적이 달성될 때까지</p></li>
																				<li><span class="num">4.	동의를 거부할 권리 및 거부에 따른 불이익</span><p class="article">귀하는 개인정보의 수집 및 이용에 동의하지 않을 수 있으나, 이 경우 상품의 공급을 포함한 계약의 체결•유지 및 이행이 불가능할 수 있습니다.</p></li>
																			</ul>
																		</div>
																		<div class="signCheck"><input class="signCheckbox" type="checkbox" id="docChkYn1" name="docChkYn1"  value="Y"><span style="background-color:#DCDCDC;">회사의 개인정보 수집 및 이용에 관한 설명을 이해하고, 이에 동의합니다.</span></div>
																		<!-- //개인정보 수집 및 이용 동의  -->
																	</li>
																</ul>
																
																<ul class="inputList">
																	<li class="agree">
																		<!-- 제품 홍보 및 이벤트 안내 관련 동의   -->
																		<div class="group-text">제품 홍보 및 이벤트 안내 관련 동의</div>
																		<div class="terms">
																			<ul class="innerWrap">
																				<li><span class="num">상기 개인정보는 우편(전자우편 포함) 발송, SMS 전송, 전화, 팩스 등을 통한 지속적인 제품의 홍보 및 판촉, 이벤트•할인•경품행사에 대한 안내 등에 이용될 수 있습니다. <br>이에 동의하지 않는 경우 신제품이나 이벤트•할인•경품행사 등에 대한 안내를 받지 못하실 수 있습니다. </span><p class="article"></p></li>
																			</ul>
																		</div>
																		<div class="signCheck"><input type="checkbox" class="signCheckbox" id="docChkYn2" name="docChkYn2" onclick="oneCheckbox(this)" value="Y"><span style="background-color:#DCDCDC;">마케팅 목적의 개인정보 이용에 동의합니다.</span><input type="checkbox" class="signCheckbox" id="docChkYn2" name="docChkYn2" onclick="oneCheckbox(this)" value="N"><span style="background-color:#DCDCDC;">동의하지 않습니다.</span></div>
																		<!-- //제품 홍보 및 이벤트 안내 관련 동의   -->
																	</li>
																</ul>
																
																<ul class="inputList">
																	<li class="agree">
																		<!-- 개인정보 처리업무의 위탁에 대한 안내  -->
																		<div class="group-text">개인정보 처리업무의 위탁에 대한 안내</div>
																		<div class="terms">
																			<ul class="innerWrap">
																				<li><span class="num">회사는 제품의 홍보 및 판촉 관련 업무를 아래와 같이 외부 전문업체에 위탁하고 있습니다. <br>
																											     수탁업체는 변경될 수 있으며, 변경시에는 서면, 이메일, 팩스, 전화, SMS 또는 이와 유사한 방법 중 1개 이상의 방법으로 알려드립니다.</span></li>
																				<li><span class="num">1.	수탁업체: 발렉스 코리아, 티비테크,덱스터스, 맨파워, T&L</span></li>
																				<li><span class="num">2.	위탁 업무내용: 제품의 홍보 및 판촉, 이벤트•할인•경품행사 실시</span></li>
																			</ul>
																		</div>
																		<div class="signCheck"><input type="checkbox" class="signCheckbox" id="docChkYn3" name="docChkYn3" value="Y"><span style="background-color:#DCDCDC;">회사의 개인정보 처리업무의 위탁에 관한 설명을 이해하였습니다.</span></div>
																		<!-- //개인정보 처리업무의 위탁에 대한 안내  -->
																	</li>
																</ul>
																
																<ul class="inputList">
																	<li class="agree">
																		<!-- 업주 키맨의 경우 추가 동의 -->
																		<div class="group-text">업주 고객의 경우 추가 동의</div>
																		<div class="terms">
																			<ul class="innerWrap">
																				<li><span class="num">귀하가 소속 Customer을 비롯한 제3자(이하 “Customer 등”)의 개인정보를 회사에 제공하는 경우, 귀하는 그에 앞서 Customer 등에게 그들의 정보를 회사에 제공한다는 점과 제공하는 개인정보의 항목, 제공 목적(회사가 이를 다시 제3자에게 제공하는 경우에는 그와 관련된 내용을 포함), 회사가 해당 개인정보를 보유 및 이용하는 기간을 충분히 설명하고 이에 대한 동의를 받아야 합니다. 귀하는 이 동의서에 서명하거나 전자적으로 동의함으로써 귀하가 Customer 등에게 그와 같은 설명을 제공하고 해당 Customer 등으로부터 적법한 동의를 받았음을 확인합니다.</span></li>
																			</ul>
																		</div>
																		<div class="signCheck"><input type="checkbox" class="signCheckbox" id="docChkYn4" name="docChkYn4"  value="Y"><span style="background-color:#DCDCDC;">이상의 내용에 대한 설명을 이해하고, 이에 동의합니다.</span></div>
																		<!-- //업주 키맨의 경우 추가 동의  -->
																	</li>
																</ul>
															</div>
														</td>
													</tr>
													<tr>
														<td colspan="6" align="center">
															<p>
																본인은 상기 내용을 상세히 읽어보았고, 이에 관하여 충분히 이해하였으며, 본인의 자유로운 의사에 의해 명확히 동의하므로 아래와 같이 서명합니다.
															</p>
														</td>
													</tr>
												</tbody>
					                        </table>
		                    			</td>
		                   			</tr>
                					<tr height="5px">
									</tr>
		                   			<tr>
		                   				<td>
		                   					<table style="border:0; border-collapse:collapse; width: 100%; height: 100%">
					                   			<tr>
					                   				<td>
					                   					<table style="width: 100%; height: 100%; border-collapse:collapse; border:#e1dcbe solid 1px; table-layout:fixed;">
															<colgroup>
																<col style="width:100px;"></col>
																<col style="width:130px;"></col>
																<col style="width:100px;"></col>
																<col style="width:130px;"></col>
																<col style="width:100px;"></col>
																<col></col>
															</colgroup>
															<tbody>
																<tr>
																	<td class="td-cond">
																		<fmt:message key="KEY04001B.docWorkDate" />
																	</td>
																	<td class="td-input">
																		<input type="text" id="regDate" style="width:100px;"class="input-readonly" readonly="readonly">
																	</td>
																	<td class="td-cond">
																		<fmt:message key="KEY04001B.name" />
																	</td>
																	<td class="td-input">
																		<input type="text" id="keyManNm" style="width:100px;">
																	</td>
																	<td class="td-cond">
																		<fmt:message key="KEY04001B.sign" />
																	</td>
																	<td class="td-input">
																		<div class="sigPad signed" > 
																			<ul class="sigNav">
																	    			<li class="clearButton"><a href="#clear">Clear</a></li>
																	  		</ul>
																			<div style="margin-top:1px; margin-bottom:2px;clear:both;height:100px; width:250px; wiborder:1px solid #ccc;"> 
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
	
	<script type="text/javascript">
		$(function() {
			$("#kmID").val("${params.kmID}");
			$("#wordType").val("${params.wordType}");
		});
	
		$(document).ready(function () {
			var sig = null;
			
	  		$('.sigPad').signaturePad({drawOnly:true}).regenerate(sig);
	  	
	  		//메뉴바 고정
	  		$("#btn").attr("style", "position: fixed; width: 100%;");
	  		window.onload = function() {
	  			Search();
	  		}
	  		
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
		/****************************************
		 * Variable
		 ****************************************/
		 
		/****************************************
		 * Function
		 ****************************************/
		 
		function Save() {
			if(!chkValidate(["docChkYN1","docChkYN2","docChkYN3","docChkYN4","regDate","keyManNm","output"]))return;
			
			if($("#DocFinshFl").val() == 'Y') { // 서류완료여부가 완료인 경우 수정불가
				alert("<fmt:message key="KEY04001B.msg1"/>");
				return false;
			}
			
			if(searchDocLink()) {
				if(!deleteDocLink()){
					return false;
				}
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
			}
			else if($("#keyManPrgsCd_S").val() == '400') {
				alert("<fmt:message key="KEY04001B.msg2"/>");
				return false;
			}
			
			var signCanvas = document.getElementById("signCanvas");
			
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/key04/saveSaleRegist");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("keymanID", $("#keymanID").val());
			table.setParameter("keymanDocTpCd", '100');
			table.setParameter("keymanPrgsCd", prgsCd); //todo
			table.setParameter("docWorkDate", unformat($("#regDate").val()));
			table.setParameter("docChkYn1", $("[name=docChkYn1]:checked").val());
			table.setParameter("docChkYn2", $("[name=docChkYn2]:checked").val());
			table.setParameter("docChkYn3", $("[name=docChkYn3]:checked").val());
			table.setParameter("docChkYn4", $("[name=docChkYn4]:checked").val());
			table.setParameter("keymanNm", $("#keyManNm").val());
			table.setParameter("signvector1", $("#output").val());
			table.setParameter("fileDocLink", $("#docLinkID").val());
			table.setParameter("data", signCanvas.toDataURL("image/png"));
			table.setParameter("linkDivCD", "SIGNIMAGE");
			
			table.request();
			
			if(table.getData(0,0) == "S") {
				alert(table.getData(1,0));
				opener.Search();
				window.close();
	   		}
			else {
				alert(table.getData(1,0));
			}
		}
		
		function Search() {
			kmSearch();
			signSearch();
		}
		
		function List() {
			opener.Search();
			window.close();
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
	        table.setURL("${contextPath}/service/simpleAction/KEY0400104S");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("outParamKey", "venueCD;venueNm;keymanID;keymanNm;birthDate;"
					+ "DocFinshFl;DocFinshFlNm;keyManPrgsCd;KeymanPrgsNm;docChkYn1;"
					+ "docChkYn2;docChkYn3;docChkYn4;keyManNm;docWorkDate;"
					+ "comment;docLinkID;");
			table.setParameter("format", "str;str;str;str;date;"
						+"str;str;str;str;str;"
						+"str;str;str;str;date;"
						+"str;str;");
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
	   			$("#KeyManPrgsNm_S").val(table.getData(8,0));
	   			$("input[name=docChkYn1][value="+table.getData(9,0)+"]").attr("checked", true);
	   			oneCheckbox($("input[name=docChkYn2][value="+table.getData(10,0)+"]").val());
	   			$("input[name=docChkYn2][value="+table.getData(10,0)+"]").attr("checked", true);
	   			$("input[name=docChkYn3][value="+table.getData(11,0)+"]").attr("checked", true);
	   			$("input[name=docChkYn4][value="+table.getData(12,0)+"]").attr("checked", true);
	   			$("#keyManNm").val(table.getData(13,0));
	   			
	   			
	   			if(table.getData(14,0) == null || table.getData(14,0) == "") {
	   				$("#regDate").val("${params.currentDate}");
	   			}
	   			else {
	   				$("#regDate").val(table.getData(14,0));
	   			}
	   			
	   			if(table.getData(5,0) == "Y" || table.getData(7,0) == "400"){		// 서류완료상태가 완료(Y)인 경우 파일첨부 기능 숨김
	   				$("#signButton").hide();
	   			}
	   			
	   			$("#Comment").val(table.getData(15,0)); //todo
	   			$("#docLinkID").val(table.getData(16,0)); //todo
	   			
	      	}else {
	      		message("<fmt:message key="info.nullData"/>");
	      	}
		}

		//라디오버튼 하나면 클릭
		function oneCheckbox(a){
	        var obj = $("[name=docChkYn2]");

	        for(var i=0; i<obj.length; i++){
	            if(obj[i] != a){
	                obj[i].checked = false;
	            }
	        }
	    }
		
		//----------- 필수값 체크 ------------
		function chkValidate(chkObjs){
			for (var i=0; i<chkObjs.length ; i++){
				switch(chkObjs[i]) {   
					case 'docChkYN1':
						if(!$("#docChkYn1").is(":checked")){
							alert("<fmt:message key="KEY04001B.msg3"/>");
							$("#docChkYn1").focus();
							return false;
						}
					break;   
					case 'docChkYN2':
						if(!$("[name=docChkYn2]").is(":checked")){
							alert("<fmt:message key="KEY04001B.msg3"/>");
							$("[name=docChkYn2][value=Y]").focus();
							return false;
						}
						else if($("[name=docChkYn2]:checked").val() == "N") {
							alert("<fmt:message key="KEY04001B.msg3"/>");
							$("[name=docChkYn2][value=Y]").focus();
							return false;
						}
					break;   
					case 'docChkYN3':
						if(!$("#docChkYn3").is(":checked")){
							alert("<fmt:message key="KEY04001B.msg3"/>");
							$("#docChkYn3").focus();
							return false;
						}
					break;   
					case 'docChkYN4':
						if(!$("#docChkYn4").is(":checked")){
							alert("<fmt:message key="KEY04001B.msg3"/>");
							$("#docChkYn4").focus();
							return false;
						}
					break;   
					case 'regDate':
						if($("#regDate").val() == null || $("#regDate").val() == ""){
							alert("<fmt:message key="KEY04001B.msg4"/>");
							return false;
						}
					break;  
					case 'keyManNm':
						if($("#keyManNm").val() == null || $("#keyManNm").val() == ""){
							alert("<fmt:message key="KEY04001B.msg5"/>");
							return false;
						}
					break;   
					case 'output':
						if(($("#output").val().length == 2 && $("#output").val() == '[]')||($("#output").val() == ''||$("#output").val() == null)){
							alert("<fmt:message key="KEY04001B.msg6"/>");
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
		
		win = "";
		function openSignCheck(finalAction){
			//var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
		   // "&viewID=KEY04001E"+
		   // "&finalAction="+finalAction;

		   // newWindow(url,"KEY04001E",300,270,"yes");
		   
		   if(!win.closed && win) {
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
</html>