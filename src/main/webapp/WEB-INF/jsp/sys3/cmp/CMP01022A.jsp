<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>문자메세지 서비스</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="Pragma" content="no-cache">
        <%@include file="../scripts.jsp" %>
		
		<script type="text/javascript">
			var c=false;
			function ch () {
				if ( c ) return;
				document.getElementById("sms_msg").style.backgroundImage="";
				document.getElementById("sms_msg").value="";
				c=true;
	
			}
			
			function add(str) {
				ch();
				document.getElementById("sms_msg").focus();
				document.getElementById("sms_msg").value+=str; 
				ChkLen();
				return;
			}
			
			function ChkLen() {

				   var msgtext, msglen;
					
					msgtext = document.getElementById("sms_msg").value;
					msglen = document.getElementById("sms_msg_cnt").value;
					
					var i=0,l=0;
					var temp,lastl;
					
					//길이를 구한다.
					while(i < msgtext.length)
					{
						temp = msgtext.charAt(i);
						
						if (escape(temp).length > 4)
							l+=2;
						else if (temp!='\r')
							l++;
						// OverFlow
						if(l>80)
						{
							alert("메시지란에 허용 길이 이상의 글을 쓰셨습니다.\n메시지란에는 한글 40자, 영문80자까지만 쓰실 수 있습니다.");
							temp = document.getElementById("sms_msg").value.substr(0,i);
							document.getElementById("sms_msg").value = temp;
							l = lastl;
							break;
						}
						lastl = l;
						i++;
					}
					document.getElementById("sms_msg_cnt").value=l;


				}
				/*
			    function openPopupPublicSelector() {
	
			        var url = "simpleCommand.do"+
			                  "?mnuGrpID="+document.getElementById("mnuGrpID").value+
			                  "&pgmID="+document.getElementById("pgmID").value+
			                  "&viewID=CMP01022B"+
			                  "&boardID="+$("#boardID").val()+
			                  "&articleID="+$("#articleID").val()+
			                  "&finalAction=closePublicSelector";
			                                            
			        newWindow(url, "publicSelector", 400, 500, "no");
			        //newWindow(url, "publicSelector", 400, 500, "yes");
			    }
			    */
			    
		</script>

		<style>
			td{font-size:12px;}
			a.m:link {  font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color: white ; text-decoration: none }
			a.m:visited { font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color: white ; text-decoration: none }
			a.m:active { font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color: #FF7800 ;  text-decoration: underline }
			a.m:hover { font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color:#FF7800; text-decoration: underline }
		</style>
	</head>
	
	<!--  body topmargin="10" leftmargin="10"-->
	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr>
					<td height="1">
						<!-- Standard Parameter - START -->
					    <input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
					    <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
					    <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
					    <input type="hidden" id="method" name="method">
					    <!-- Standard Information - END -->
					    
					    <!-- Function Bar - Title & Button -->
		    		    <%@include file="../cms/functionbar.jsp" %>
		    		    <%@include file="../cms/calendar.jsp" %>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="pd" height="*"> 		 
						<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
							<tr>
								<td align="left" valign="top" width="30%">
									<!-- 메세지창&이모티콘 -->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center" valign="top"> 
												<table width="161" border="0" cellspacing="0" cellpadding="0" height="453" background="/images/sms/index_smsbg.gif">
													<tr>
														<td height="190" align="center" valign="top"> 
															<!-- 메세지창전체 -->
															<table width="148" border="0" cellspacing="0" cellpadding="0" height="102" class=td1>
																<tr>
																	<td height="45"></td>
																</tr> 
																<tr>
																	<td width="148" height="78" valign="middle" align="center">
																		<!-- 액상화면 -->
																		<table width="100" border="0" cellspacing="0" cellpadding="0" class="td1">
																			<tr>
																				<td align="center">
																					<textarea id="sms_msg" name="sms_msg" id="mobile" onChange="ChkLen()" onKeyUp="ChkLen()" onkeydown="return ch();" onmousedown="return ch();"
																						style="border-color:#000000; border:solid 0; height:138px; background-color: transparent; width: 102px; font-size: 9pt; overflow:hidden" style='background-image:url(/images/sms/msg_box.jpg);background-repeat:no-repeat;background-position:center;' rows=5 cols=16 ></textarea>
																				</td>
																			</tr>
																		</table>
																		<!-- 액상화면 -->
																	</td>
																</tr>
																<tr><td height="5"></td></tr>
																<tr>
																	<td align="center" valign="top"> 
																		<input type="text" id="sms_msg_cnt" name="sms_msg_cnt" 
																			style="background-color:transparent; border:solid 0 #000000; height: 17px; width: 24px; font-size: 9pt; font-family:Verdana; text-align:right;" maxlength="3" value="80" readonly="readonly" >/80 byte
																	</td>
																</tr>
															</table>
															<!-- 메세지창전체 -->
														</td>
													</tr>
													<tr><td height="30" align="center" valign=top></td></tr>
													<tr>
														<td height="200" align="center" valign=top>
															<!-- 특수문자 -->
															<table width="82" border="0" cellspacing="0" cellpadding="0">
															<tr><td width="18"><a href="javascript:add('■')"><img src="/images/sms/c.gif" width="19" height="19" border=0></a></td>
																<td width="18"><a href="javascript:add('□')"><img src="/images/sms/c1.gif" width="18" height="19" border="0"></a></td>
																<td width="18"><a href="javascript:add('▣')"><img src="/images/sms/c2.gif" width="18" height="19" border="0"></a></td>
																<td width="18"><a href="javascript:add('◈')"><img src="/images/sms/c3.gif" width="18" height="19" border="0"></a></td>
																<td width="18"><a href="javascript:add('◆')"><img src="/images/sms/c4.gif" width="18" height="19" border="0"></a></td>
																<td width="18"><a href="javascript:add('◇')"><img src="/images/sms/c5.gif" width="18" height="19" border="0"></a></td>
																<td width="18"><a href="javascript:add('♥')"><img src="/images/sms/c6.gif" width="18" height="19" border="0"></a></td>
																<td width="18"><a href="javascript:add('♡')"><img src="/images/sms/c7.gif" width="19" height="19" border="0"></a></td>
															</tr>
															<tr><td width="18"><a href="javascript:add('●')"><img src="/images/sms/c8.gif" width="19" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('○')"><img src="/images/sms/c9.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('▲')"><img src="/images/sms/c10.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('▼')"><img src="/images/sms/c11.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('▶')"><img src="/images/sms/c12.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('▷')"><img src="/images/sms/c13.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('◀')"><img src="/images/sms/c14.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('◁')"><img src="/images/sms/c15.gif" width="19" height="17" border="0"></a></td>
															</tr>
															<tr><td width="18"><a href="javascript:add('☎')"><img src="/images/sms/c16.gif" width="19" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('☏')"><img src="/images/sms/c17.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('♠')"><img src="/images/sms/c18.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('♤')"><img src="/images/sms/c19.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('♣')"><img src="/images/sms/c20.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('♧')"><img src="/images/sms/c21.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('★')"><img src="/images/sms/c22.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('☆')"><img src="/images/sms/c23.gif" width="19" height="17" border="0"></a></td>
															</tr>
															 <tr><td width="18"><a href="javascript:add('☞')"><img src="/images/sms/c24.gif" width="19" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('☜')"><img src="/images/sms/c25.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('▒')"><img src="/images/sms/c26.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('⊙')"><img src="/images/sms/c27.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('㈜')"><img src="/images/sms/c28.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('№')"><img src="/images/sms/c29.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('㉿')"><img src="/images/sms/c30.gif" width="18" height="17" border="0"></a></td>
																<td width="18"><a href="javascript:add('♨')"><img src="/images/sms/c31.gif" width="19" height="17" border="0"></a></td>
															</tr>
															<tr><td width="18"><a href="javascript:add('™')"><img src="/images/sms/c32.gif" width="19" height="18" border="0"></a></td>
																<td width="18"><a href="javascript:add('℡')"><img src="/images/sms/c33.gif" width="18" height="18" border="0"></a></td>
																<td width="18"><a href="javascript:add('∑')"><img src="/images/sms/c34.gif" width="18" height="18" border="0"></a></td>
																<td width="18"><a href="javascript:add('∏')"><img src="/images/sms/c35.gif" width="18" height="18" border="0"></a></td>
																<td width="18"><a href="javascript:add('♬')"><img src="/images/sms/c36.gif" width="18" height="18" border="0"></a></td>
																<td width="18"><a href="javascript:add('♪')"><img src="/images/sms/c37.gif" width="18" height="18" border="0"></a></td>
																<td width="18"><a href="javascript:add('♩')"><img src="/images/sms/c38.gif" width="18" height="18" border="0"></a></td>
																<td width="18"><a href="javascript:add('♭')"><img src="/images/sms/c39.gif" width="19" height="18" border="0"></a></td>
															</tr>
															</table>
															<!-- 특수문자 -->
															<!-- 특수문자2 -->
															<table border="0" cellspacing="0" cellpadding="0">
															<tr><td colspan=2 height="0"></td></tr>
															<tr><td width="37"><a href="javascript:add('*^^*')"><img src="/images/sms/i1.gif" width="37" height="18" border="0"></a></td>
																<td width="36"><a href="javascript:add('♡.♡')"><img src="/images/sms/i2.gif" width="36" height="18" border="0"></a></td>
																<td width="36"><a href="javascript:add('@_@')"><img src="/images/sms/i3.gif" width="36" height="18" border="0"></a></td>
																<td width="37"><a href="javascript:add('☞_☜')"><img src="/images/sms/i4.gif" width="37" height="18" border="0"></a></td>
															</tr>
															<tr><td><a href="javascript:add('ㅠ.ㅠ')"><img src="/images/sms/i5.gif" width="37" height="17" border="0"></a></td>
																<td><a href="javascript:add('Θ_Θ')"><img src="/images/sms/i6.gif" width="36" height="17" border="0"></a></td>
																<td><a href="javascript:add('~o~')"><img src="/images/sms/i7.gif" width="36" height="17" border="0"></a></td>
																<td><a href="javascript:add('^_~♥')"><img src="/images/sms/i8.gif" width="37" height="17" border="0"></a></td>
															</tr>
															<tr><td><a href="javascript:add('★.★')"><img src="/images/sms/i9.gif" width="37" height="17" border="0"></a></td>
																<td><a href="javascript:add('(!_!)')"><img src="/images/sms/i10.gif" width="36" height="17" border="0"></a></td>
																<td><a href="javascript:add('q.p')"><img src="/images/sms/i11.gif" width="36" height="17" border="0"></a></td>
																<td><a href="javascript:add('⊙.⊙')"><img src="/images/sms/i12.gif" width="37" height="17" border="0"></a></td>
															</tr>
															<tr>
															<td colspan="2"><a href="javascript:add('┏( ` `)┛')"><img src="/images/sms/i13.gif" width="73" height="17" border="0"></a></td>
															<td colspan="2"><a href="javascript:add('@)-)--')"><img src="/images/sms/i14.gif" width="73" height="17" border="0"></a></td>
															</tr>
															<tr>
															<td colspan="2"><a href="javascript:add('↖(^-^)↗')"><img src="/images/sms/i15.gif" width="73" height="18" border="0"></a></td>
															<td colspan="2"><a href="javascript:add('(*^ㅡ^*)')"><img src="/images/sms/i16.gif" width="73" height="18" border="0"></a></td>
															</tr>
															</table>
															<!-- 특수문자2 -->
															<!-- 메세지창&이모티콘창 -->
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
								<!-- 우측 정보 및 그리드 -->
								<td width="70%" height="100%" valign="top" class="tb-border">
									<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                    					<tr>
                    						<td height="1">
												<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
													<colgroup>
														<col style="width:80px;"></col>
														<col style="width:150px;"></col>
														<col style="width:80px;"></col>
														<col></col>
													</colgroup>
													<tbody>
													    <tr>
															<td class="td-cond">발송대상</td>
															<td class="td-input" colspan="3">
																총 <input type="text" id="smsSendCnt" name="smsSendCnt" style="width:30px; text-align: right;" class="input-readonly" readonly="readonly"/>명&nbsp;&nbsp;
																<!-- 
																<input type="checkbox" id="testYN" name="testYN" class="checkbox" value="Y">
																자신에게 테스트 발송
																 -->
															</td>
														</tr>
														<tr>
															<td class="td-cond">발신번호</td>
															<td class="td-input">
																<input type="text" id="callback" style="width:120px; ime-mode:disabled;" maxlength="11" onfocus="this.value=unformat(this.value); this.select();">
															</td>
															<td class="td-cond">전송방식</td>
															<td class="td-input">
																<select id="schedule_type">
																	<option value="0">즉시발송</option>
																	<option value="1">예약발송</option>
																</select>
															</td>
														</tr>
														<tr>
															<td class="td-cond">예약일시</td>
															<td class="td-input" colspan="3">
																<nis:calendar id="send_date"/>
																<select id="send_hourCD">
																	<option value="">(선택)</option>
																	<option value="00">오전12시</option>
																	<option value="01">오전1시</option>
																	<option value="02">오전2시</option>
																	<option value="03">오전3시</option>
																	<option value="04">오전4시</option>
																	<option value="05">오전5시</option>
																	<option value="06">오전6시</option>
																	<option value="07">오전7시</option>
																	<option value="08">오전8시</option>
																	<option value="09">오전9시</option>
																	<option value="10">오전10시</option>
																	<option value="11">오전11시</option>
																	<option value="12">오후12시</option>
																	<option value="13">오후1시</option>
																	<option value="14">오후2시</option>
																	<option value="15">오후3시</option>
																	<option value="16">오후4시</option>
																	<option value="17">오후5시</option>
																	<option value="18">오후6시</option>
																	<option value="19">오후7시</option>
																	<option value="20">오후8시</option>
																	<option value="21">오후9시</option>
																	<option value="22">오후10시</option>
																	<option value="23">오후11시</option>
																</select>
																<nis:selectbox id="send_minuteCD" style="width:70px;" defaultText="select"  category="MINUTECD" />
															</td>
														</tr>
													</tbody>
												 </table>	
											 </td>
									    </tr>
										<tr>
											<td height="30">
											<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
												<tr>
													<td class="group-title" height="1">수신대상 추가</td>
													<td>
													<div align="right">
														<script type="text/javascript">
						                                    var AddRow = new AW.UI.Button;
						                                    //AddRow.setControlImage("AddRow");
						                                    AddRow.setControlText("추가");
						                                    document.write(AddRow);
						                                     
						                                    AddRow.onControlClicked = function(event){
						                                    	openSmsSelector();
						                                    }
						                                    
						                                    var RemoveAll = new AW.UI.Button;
						                                    RemoveAll.setControlText("전체삭제");
						                                    document.write(RemoveAll);
						                                     
						                                    RemoveAll.onControlClicked = function(event){
						                                    	removeAll();
						                                    }
						                                </script>
						                             </div>
						                             </td>
					                        	</tr>     
					                        </table>        
											</td>
										</tr>
										<tr>
						                    <td height="*" class="tb-border">
												<span id="grid"></span>
											</td>
						                </tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
                    <td height="5">
                   		<input type="hidden" id="initAction" name="initAction">
						<input type="hidden" id="currentDate" name="currentDate" value="${params.currentDate}">
						<input type="hidden" id="smsLimitCount" name="smsLimitCount">
						<input type="hidden" id="sendCnt" name="sendCnt">
						<input type="hidden" id="smsAvailCnt" name="smsAvailCnt">
						<input type="hidden" id="userName" name="userName">
					</td>
				</tr>		
			</table>
		</form>			
	</body>
</html>

<!-- grid format -->
<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 180px; text-align:center;}
	.aw-column-1 {width: 130px; text-align:center;}
	.aw-column-2 {width: 50px; text-align:center;}
	
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">
	var maxRow = 0;
	// Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	/****************************************
	* Function
	****************************************/
	
	$(function() {
		$("#callback").numeric();
	});
	
	$(document).ready(function() {

		window.onload = function() {
			chgScheduleType();
			$("#smsSendCnt").val("0");
			getUserNameInfo();
		};
		
		${initScript}

		//엔터시 포커스 이동 및 포맷팅
		$("#callback").keypress(function(){
			if (event.keyCode==13){
				$("#schedule_type").focus();
				return false;
			}
		});
		$("#schedule_type").keypress(function(){
			if (event.keyCode==13){
				$("#send_date").focus();
				return false;
			}
		});
		$("#send_date").keypress(function(){
			if (event.keyCode==13){
				$("#send_hourCD").focus();
				return false;
			}
		});
		$("#send_hourCD").keypress(function(){
			if (event.keyCode==13){
				$("#send_minuteCD").focus();
				return false;
			}
		});

		//이벤트처리
		$("#callback").blur(function(){
			$("#callback").val(formatTelNo($("#callback").val()));
		});
		$("#schedule_type").change(function(){
			chgScheduleType();
		});
		
	});
    //발신자 이름 가져오기
	function getUserNameInfo() {
		/*
		var table = new AW.XML.Table;
      	table.setURL("simpleAction.do");
      	table.setAsync(false);
      	table.setRequestMethod("POST");
      	table.setParameter("queryKey","z.smsSendUserName.select"); 
        table.setParameter("outParamKey","userName;");
      	table.request();

      	if (table.getCount() == 1){ 
      		$("#userName").val(table.getData(0,0));
      	} 
      	*/
    }
    
    //전송방식 변경시
    function chgScheduleType(){
    	if($("#schedule_type").val() =='1'){
			//예약일시 활성화
			$("#send_date").removeClass("input-readonly");
		    $("#send_date").attr("readonly","");
		    $("#send_date_POPUP").show();
		    $("#send_hourCD").removeClass("input-readonly");
		    $("#send_minuteCD").removeClass("input-readonly");
		    $("#send_hourCD").attr("disabled",false);
		    $("#send_minuteCD").attr("disabled",false);
		}else{	
			$("#send_date").val("");
			$("#send_hourCD").val("");
			$("#send_minuteCD").val("");
			//예약일시 비활성화
			$("#send_date").addClass("input-readonly");
		    $("#send_date").attr("readonly","readonly");
		    $("#send_date_POPUP").hide();
		    $("#send_hourCD").addClass("input-readonly");
		    $("#send_minuteCD").addClass("input-readonly");
		    $("#send_hourCD").attr("disabled",true);
		    $("#send_minuteCD").attr("disabled",true);
		}	
    }    
    //수신대상추가
	function openSmsSelector() {
		var url = "simpleCommand.do?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
	    	"&viewID=CMP01022B"+
	    	"&finalAction=closeSmsSelector";
		
		newWindow(url, "CMP01022B", 405, 545, "no");
		//newWindow(url, "CMP01022B", 405, 545, "no");
	}
	function closeSmsSelector(rtnData){
		
		var data = new Array();
		var j = 0;
		for (var i=0; i < rtnData.NAME.length; i++) {
			
				data[j] = [
					rtnData.NAME[i],
					formatTelNo(rtnData.HP[i]),
					"",
					"U"
	        	];
	        	j++;
		}
		// 중복 수신대상자 제거
		var adjustData = new Array();
		j = 0;
		for (var i=0; i < data.length; i++) {
			var insFlag = true;
			for (var k=0; k < adjustData.length; k++) {
				if (adjustData[k][_col.hpNo] == data[i][_col.hpNo]) {
					insFlag = false;
					break;
				}
			}
			
			if (insFlag) {
				adjustData[j] = data[i];
				j++;
			}
		}
		
		grid.clear();
		createGrid();
		maxRow = 0;
		grid.setCellData(adjustData);
		grid.setRowCount(j);
		maxRow = j;
		$("#smsSendCnt").val(maxRow);
		
		grid.refresh();
    }
	
	
	/*SMS발송대상 조회창에서 arr를 가져와 보여준다.
	function Search(){
		
		if($("#acCD").val()==""){
			$("#acCD").val(opener.$("#acCD").val());
		}	
		$("#testYN").focus();
		//매장팝업 비활성화
		$("#acCD").addClass("input-readonly");
	    $("#acCD").attr("readonly","readonly");
	    $("#acCD_popup").hide();
		//예약일시 비활성화
		$("#send_date").addClass("input-readonly");
	    $("#send_date").attr("readonly","readonly");
	    $("#send_date_POPUP").hide();
	    $("#send_hourCD").addClass("input-readonly");
	    $("#send_minuteCD").addClass("input-readonly");
	    $("#send_hourCD").attr("disabled",true);
	    $("#send_minuteCD").attr("disabled",true);
	    
		var grd = opener.grid;
		var j = 0;
		var data = new Array();
		for (var i=0; i < grd.getRowCount(); i++) {
			if(grd.getCellValue(0,i) == true){
				data[j] = [
		   		      		grd.getCellText(2, i), //custName
		   		      	 	grd.getCellText(5, i), //birthDate
		   		      		grd.getCellText(7, i), //hpNo
		   		      		"",
		   		      		"U"
		   			   ];
	   			   j++;
			}
		}
		
		grid.clear();
		createGrid();
		maxRow = 0;
		//grid.setCellData(adjustData);
		//grid.setRowCount(j);
		//maxRow = j;
		grid.setCellData(data);
		maxRow = data.length;
		grid.setRowCount(maxRow);
		$("#smsSendCnt").val(maxRow);
		grid.refresh();
    }
    */
	
	function removeRow(row) {
		grid.deleteRow(row);
	    grid.setCellText('D', _col.activeFlg, row);
	    $("#smsSendCnt").val(parseInt($("#smsSendCnt").val())-1);
	}
	
	function removeAll(row) {
		grid.clear();
		createGrid();
		grid.refresh();
		maxRow = 0;
	}
	
</script>	
<script type="text/javascript">

    /****************************************
    * Button Action
    ****************************************/
	function Send(){
    	
    	//TODO: 풀비타 서비스 준비중
    	/*
    	if ("${params.companyID}" == "000002") {
    		alert("서비스 준비중입니다.");
    		return;
    	}
    	*/
		
		if ($("#sms_msg").val() == "") {
			alert("전송할 메세지를 먼저 입력하십시오.");
			//$("#sms_msg").focus();
			return;
		}
		else if ($("#callback").val() == "") {
			alert("발신번호를 먼저 입력하십시오.");
			$("#callback").focus();
			return;
		}
		else if ($("#schedule_type").val() == "2") {
			if($("#send_date").val() == ""){
				alert("예약일시(일자)를 먼저 입력하십시오.");
				$("#send_date").focus();
				return;
			}
			if($("#send_hourCD").val() == ""){
				alert("예약일시(시간)를 먼저 입력하십시오.");
				$("#send_hourCD").focus();
				return;
			}
			if($("#send_minuteCD").val() == ""){
				alert("예약일시(분)를 먼저 입력하십시오.");
				$("#send_minuteCD").focus();
				return;
			}
		}
		/*현재 발송할 매장의 sms발송건수 계산 (테스트시 건수 하나 추가)
		var smsSendCnt = 0;
		if($("#testYN").attr("checked") == true){
			
			smsSendCnt = parseInt($("#smsSendCnt").val())+1;
		
		}else{
			smsSendCnt = parseInt($("#smsSendCnt").val());
		}	
		
		if(parseInt($("#smsAvailCnt").val())-smsSendCnt < 0){
			alert("발송가능 문자건수를 초과했습니다.");
			return;
		}	
		
		//히스토리에 남길 현재까지  매장의 sms발송건수 계산 (
		var sendCnt = 0;
		sendCnt = parseInt($("#sendCnt").val())+smsSendCnt;
		*/
		
		showLoading();
		window.setTimeout("hideLoading()", 500);
		try{parent.InitSessionTimer();}catch(e){}

		var table = new AW.XML.Table;
        table.setURL("sms.do");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("method","saveSmsSend");
        //table.setParameter("tran_etc1",$("#acID").val()); //매장코드
        table.setParameter("callback",unformat($("#callback").val()));//송신자번호
        table.setParameter("sms_msg",$("#sms_msg").val());//메세지내용
        //table.setParameter("sendCnt",sendCnt); //히스토리에 남길 메세지 발송갯수
        table.setParameter("schedule_type",$("#schedule_type").val()); //메세지 전송유형 (즉시 or 예약)
        table.setParameter("send_date",unformat($("#send_date").val())+$("#send_hourCD").val()+$("#send_minuteCD").val()+"00"); //발송 희망시간(예약일시) YYYYMMDDHH24MISS
        table.setParameter("currentMonth", unformat($("#currentDate").val()).substring(0,6));
                
        var custHpNoArr = new Array();
       
        var j=0;
        for (var i=0; i < maxRow; i++){
            if ((grid.getCellText(_col.hpNo,i) != ""  && grid.getCellText(_col.activeFlg,i) == "U")) {
            	//custHpNoArr[j] = grid.getCellText(_col.custName,i)+"^"+unformat(grid.getCellText(_col.hpNo,i));
            	custHpNoArr[j] = unformat(grid.getCellText(_col.hpNo,i));
            	//alert(grid.getCellText(_col.hpNo,i));
				j++;
            }
        }
        
        if (j == 0) {
        	alert("메세지 수신대상이 없습니다.");
        	return;
        }
        if(j > 0 && $("#testYN").attr("checked") == true){
            if($("#callback").val() != ''){
        		custHpNoArr[j] = $("#userName").val()+"^"+unformat($("#callback").val());
            }
        }    
        table.setParameter("custHpNoArr", custHpNoArr);
        table.request();
        
        if (table.getData(0,0) == 'S') {
            alert("문자메세지 발송 또는 예약이 완료되었습니다.");
            $("#sms_msg").val("");
            ChkLen();
            //getAgencySmsInfo();
            document.getElementById("sms_msg").style.backgroundImage="url(/images/sms/msg_box.jpg)";
            c = false;
        }
        else {
            alert("문자메세지  발송 또는 예약에 실패하였습니다.");
        }
    }
    	
    function Close() {
		window.close();
	}
</script>    
<script type="text/javascript">

	/*****************************************************
	*	define data formats define
	*****************************************************/
	
	var _col = {
		"custName":0,
		"hpNo":1,
		"deleteBtn":2,
		"activeFlg":3
	};
	
	var columns = [
		"이름","휴대폰번호","삭제"
	];
	
	var grid = null;
	
	function createGrid() {
		
		grid = new AW.UI.Grid;
		
		grid.setId("grid");
		grid.setCellFormat([str, str, str, str]);
		grid.setHeaderText(columns);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setRowCount(0);
		grid.setColumnCount(columns.length);
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setSize(380, 400);
		grid.setStyle("width", "100%");
		grid.setStyle("height", "100%");
		grid.setCellEditable(false);
		
		//삭제버튼
		grid.setCellImage("deleteGrid", _col.deleteBtn);
		var deleteFlag = new AW.Templates.Image;
        var delImage = deleteFlag.getContent("box/image");
        delImage.setTag("a");
        delImage.setAttribute("href", function(){
            return "javascript:removeRow(grid.getCurrentRow())";
        });
        grid.setCellTemplate(deleteFlag, _col.deleteBtn);
		/*
		// Cell startEdit BEGIN
        grid.onCellSelectedChanged = function(selected, col, row) { 
            if (selected) { 
                this.setTimeout(function(){ 
                   this.raiseEvent("editCurrentCell", {}, col, row); 
                }); 
            } 
        };
        
        grid.onCellClicked = function(event, col, row) { 
            if (this.getCellSelected(col, row)) { 
                this.setTimeout(function(){ 
                   this.raiseEvent("editCurrentCell", {}, col, row); 
               }); 
            }
        };
        
        grid.onCellEditStarted = function(text, col, row){
            if (col == 0) {
				this.setCellText(unformat(text), col, row);
            }
        };
        // Cell startEdit END
        
    	//  BEGIN validating (Enter, Cell LoseFocus)
        grid.onCellValidating = function(text, col, row){
             if (col == 0) {
                 if (!isNumber(unformat(text))) {
                    this.setCellText("",col,row);
                    alert("전화번호 형식이 유효하지 않습니다.");
                 }
             }
        }

        grid.onCellValidated = function(text, col, row){
        	if (col == 0) {
        		this.setCellText(formatTelNo(text), col, row);
            }
        }
        //  END validated Action (Enter, Cell LoseFocus)
        */
	}
	
	createGrid();
	grid.refresh();
</script>