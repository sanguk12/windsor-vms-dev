<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>문자메세지 서비스</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
        <c:choose>
			<c:when test="${params.themeURL == 'nullnull'}">
				<c:set var="themeURL" value="/scripts/theme/BLUE"/>
			</c:when>
			<c:otherwise>
				<c:set var="themeURL" value="${params.themeURL}"/>
			</c:otherwise>
		</c:choose>
		
		<!-- ActiveWidgets Module - START -->
		<link rel="stylesheet" type="text/css" href="${themeURL}/styles/aw.css" ></link>
		<script type="text/javascript" src="${contextPath}/scripts/aw/runtime/lib/aw.js" ></script>
		<script type="text/javascript" src="${contextPath}/scripts/aw/awConfig.js" ></script>
		<!-- ActiveWidgets Module - END -->
		
		<!-- Common Service - START -->
		<script type="text/javascript" src="${contextPath}/scripts/baseScript.js"></script>
		<!-- Common Service - END -->

		<!-- jQuery - START -->
		<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.6.1.min.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery.alphanumeric.js"></script>
		<!-- jQuery - END -->
		
		<!-- Program Common Module - START -->
		<link rel="stylesheet" type="text/css" href="${themeURL}/theme.css" ></link>
		<script type="text/javascript" src="${contextPath}/scripts/formatter.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/basePopup.js"></script>
		<!-- Program Common Module - END -->
		
		<script type="text/javascript">
			var c=false;
			function ch () {
				if ( c ) return;
				document.getElementById("MSG_TXT").style.backgroundImage="";
				document.getElementById("MSG_TXT").value="";
				c=true;
	
			}
			
			function add(str) {
				document.getElementById("MSG_TXT").focus();
				document.getElementById("MSG_TXT").value+=str; 
				ChkLen();
				return;
			}
			
			function ChkLen() {

				   var msgtext, msglen;
					
					msgtext = document.getElementById("MSG_TXT").value;
					msglen = document.getElementById("MSG_TXT_CNT").value;
					
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
							temp = document.getElementById("MSG_TXT").value.substr(0,i);
							document.getElementById("MSG_TXT").value = temp;
							l = lastl;
							break;
						}
						lastl = l;
						i++;
					}
					document.getElementById("MSG_TXT_CNT").value=l;


				}
			
			    function openPopupPublicSelector() {
	
			        var url = "simpleCommand.do"+
			                  "?mnuGrpID="+document.getElementById("mnuGrpID").value+
			                  "&pgmID="+document.getElementById("pgmID").value+
			                  "&viewID=COM04002D"+
			                  "&boardID="+$("#boardID").val()+
			                  "&articleID="+$("#articleID").val()+
			                  "&finalAction=closePublicSelector";
			                                            
			        newWindow(url, "publicSelector", 400, 500, "no");
			        //newWindow(url, "publicSelector", 400, 500, "yes");
			    }
		</script>

		<style>
			td{font-size:12px;}
			a.m:link {  font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color: white ; text-decoration: none }
			a.m:visited { font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color: white ; text-decoration: none }
			a.m:active { font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color: #FF7800 ;  text-decoration: underline }
			a.m:hover { font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color:#FF7800; text-decoration: underline }
		</style>
	</head>
	
	<body topmargin="10" leftmargin="10">
	
		<!-- Standard Parameter - START -->
	    <input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
	    <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
	    <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
	    <input type="hidden" id="method" name="method">
	    <input type="hidden" id="initAction" name="initAction">
	    <!-- Standard Information - END -->
	    
		<div id="tit" style="width:560px; text-align:left; background:url(${params.themeURL}/images/common/tit_bg.gif) repeat-x;">
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="tit_text" style="height:30px; width:370px; vertical-align:middle;">
						<img src="${params.themeURL}/images/common/tit_point.gif"> 문자메세지 서비스
	                </td>
				</tr>
			</table>
		</div>
		<div style="height:10px"></div>
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center" valign="top" width="180" rowspan="2">
					<!-- 메세지창&이모티콘 -->
					<table width="185" border="0" cellspacing="0" cellpadding="0">
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
																	<textarea id="MSG_TXT" name="MSG_TXT" id="mobile" onChange="ChkLen()" onKeyUp="ChkLen()" onkeydown="return ch();" onmousedown="return ch();"
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
														<input type="text" id="MSG_TXT_CNT" name="MSG_TXT_CNT" 
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
				<td width="525" height="350" colspan="3">
					<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
						<tr>
							<td class="group-title" height="1">수신대상 추가</td>
							<td style="text-align:right;">
								<script type="text/javascript">
                                    var AddRow = new AW.UI.Button;
                                    AddRow.setControlImage("AddRow");
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
							</td>
						</tr>
						<tr>
		                    <td class="tb-border" height="*" colspan="2">
								<span id="grid"></span>
							</td>
		                </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100">보내는사람 번호</td>
				<td width="130">
					<input type="text" id="SENDPHONE" style="width:120px; ime-mode:disabled;" maxlength="11" onfocus="this.value=unformat(this.value); this.select();">
				</td>
				<td width="295" height="30" align="right">
					<img src="/images/sms/bt_send.gif" width="146" height="23" border="0" style="cursor:pointer;" onclick="sendSMS();">
				</td>
			</tr>
		</table>
	</body>
</html>

<!-- grid format -->
<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 140px; }
	.aw-column-1 {width: 80px; }
	.aw-column-2 {width: 100px; }
	.aw-column-3 {width: 120px; }
	.aw-column-4 {width: 50px; text-align:center;}
	
	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">

	$(function() {
		$("#SENDPHONE").numeric();
	});

	var maxRow = 0;
	
	$(document).ready(function() {
		$("#SENDPHONE").blur(function(){
			$("#SENDPHONE").val(formatTelNo($("#SENDPHONE").val()));
		});
	});
	
	function openSmsSelector() {
		var url = "simpleCommand.do?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
	    	"&viewID=COM04008B"+
	    	"&finalAction=closeSmsSelector";
		
		newWindow(url, "smsSelector", 405, 545, "no");
	}
	
	function closeSmsSelector(rtnData){
		
		var data = new Array();
		var j = 0;
		
		for (var i=0; i < rtnData.OTYPE.length; i++) {
			
			/*
			if (rtnData.OTYPE[i] == "O") { // 조직
				
				var table = new AW.XML.Table;     
		        table.setURL("simpleAction.do");
		        table.setAsync(false);
		        table.setRequestMethod("POST");
		        table.setParameter("returnType","List");
		        table.setParameter("resultType","XML");
		        table.setParameter("RFC","ZCWCMC01_0008");
		        table.setParameter("inParamKey","ACT_OBJID;ACT_PERNR;ACT_BEGDA;");
		        table.setParameter("outParamKey","OTYPE;OBJID;NAME;LPTYP;LPTYP_T;HP;ORGEH;ORGEH_T;");
		        table.setParameter("ACT_OBJID",rtnData.OBJID[i]);
		        table.setParameter("ACT_PERNR","");
		        table.setParameter("ACT_BEGDA",unformat("${params.currentDate}"));
		        table.request();
		        
		        var rowCount = table.getCount();
		        if (rowCount > 0) {
		        	for (var k=0; k < rowCount; k++) {
		        		if (table.getData(0,k) == "P") {
				        	data[j] = [
				        		table.getData(7,k),
				        		table.getData(2,k),
				        		table.getData(4,k),
				        		formatTelNo(unformat(table.getData(5,k))),
				        		"",
				        		"U",
				        		table.getData(0,k),
				        		table.getData(1,k),
				        		table.getData(3,k),
				        		table.getData(6,k)
				        	];
				        	j++;
		        		}
		        	}
		        }
			}
			else 
			*/
			if (rtnData.OTYPE[i] == "P") { // 사용자
				data[j] = [
					rtnData.ORGEH_T[i],
					rtnData.NAME[i],
					rtnData.LPTYP_T[i],
					formatTelNo(rtnData.HP[i]),
					"",
					"U",
					rtnData.OTYPE[i],
	        		rtnData.OBJID[i],
	        		rtnData.LPTYP[i],
	        		rtnData.ORGEH[i]
	        	];
	        	j++;
			}
		}
		
		// 중복 수신대상자 제거
		var adjustData = new Array();
		j = 0;
		for (var i=0; i < data.length; i++) {
			var insFlag = true;
			for (var k=0; k < adjustData.length; k++) {
				if (adjustData[k][_col.OBJID] == data[i][_col.OBJID]) {
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
		
		grid.refresh();
    }
	
	function removeRow(row) {
		grid.deleteRow(row);
	    grid.setCellText('D', _col.ACTIVEFLG, row);
	}
	
	function removeAll(row) {
		grid.clear();
		createGrid();
		grid.refresh();
		maxRow = 0;
	}
	
	function sendSMS() {
		
		if ($("#MSG_TXT").val() == "") {
			alert("전송할 메세지를 먼저 입력하십시오.");
			return;
		}
		else if ($("#SENDPHONE").val() == "") {
			alert("보내는사람 번호를 먼저 입력하십시오.");
			$("#SENDPHONE").focus();
			return;
		}
        
		var table = new AW.XML.Table;
        table.setURL("sms.do");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("method","ZCWCMC01_0009");
        
        table.setParameter("SENDPHONE",$("#SENDPHONE").val());
        table.setParameter("MESSAGE",$("#MSG_TXT").val());
                
        var OTYPE = new Array();
        var OBJID = new Array();
        var NAME = new Array();
        var LPTYP = new Array();
        var LPTYP_T = new Array();
        var HP = new Array();
        var ORGEH = new Array();
        var ORGEH_T = new Array();
        var j=0;
        for (var i=0; i < maxRow; i++){
            if ((grid.getCellText(_col.HP,i) != ""  && grid.getCellText(_col.ACTIVEFLG,i) == "U")) {
            	OTYPE[j] = grid.getCellText(_col.OTYPE,i);
            	OBJID[j] = grid.getCellText(_col.OBJID,i);
            	NAME[j] = grid.getCellText(_col.NAME,i);
            	LPTYP[j] = grid.getCellText(_col.LPTYP,i);
            	LPTYP_T[j] = grid.getCellText(_col.LPTYP_T,i);
            	HP[j] = grid.getCellText(_col.HP,i);
            	ORGEH[j] = grid.getCellText(_col.ORGEH,i);
            	ORGEH_T[j] = grid.getCellText(_col.ORGEH_T,i);
				j++;
            }
        }
        table.setParameter("OTYPE", OTYPE);
        table.setParameter("OBJID", OBJID);
        table.setParameter("NAME", NAME);
        table.setParameter("LPTYP", LPTYP);
        table.setParameter("LPTYP_T", LPTYP_T);
        table.setParameter("HP", HP);
        table.setParameter("ORGEH", ORGEH);
        table.setParameter("ORGEH_T", ORGEH_T);
        
        if (j == 0) {
        	alert("메세지 수신대상이 없습니다.");
        	return;
        }

        table.request();
        
        if (table.getData(0,0) == 'S') {
            alert("문자메세지 전송이 완료되었습니다.");
            $("#MSG_TXT").val("");
        }
        else {
            alert("문자메세지 전송에 실패하였습니다.");
        }
	}

	/*****************************************************
	*	define data formats define
	*****************************************************/
	var _col = {
		"ORGEH_T":0,
		"NAME":1,
		"LPTYP_T":2,
		"HP":3,
		"DELETE_BTN":4,
		"ACTIVEFLG":5,
		"OTYPE":6,
		"OBJID":7,
		"LPTYP":8,
		"ORGEH":9
	};
	
	var columns = [
		"조직명","BP명","직책","휴대폰번호","삭제"
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
		grid.setCellImage("deleteGrid", _col.DELETE_BTN);
		var deleteFlag = new AW.Templates.Image;
        var delImage = deleteFlag.getContent("box/image");
        delImage.setTag("a");
        delImage.setAttribute("href", function(){
            return "javascript:removeRow(grid.getCurrentRow())";
        });
        grid.setCellTemplate(deleteFlag, _col.DELETE_BTN);
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