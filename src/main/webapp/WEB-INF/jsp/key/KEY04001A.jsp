<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
	</head>

	<body id="mobBody" class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
		<table height="100%" border="0" cellspacing="0" cellpadding="0"><tr><td id="contents_width"  width="975" valign="top"> <!-- JSPARK -->
			<div id="wrapDiv">
          		<div id="formDiv">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            	<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/functionbar.jsp" %>
								<%@include file="../sys3/cms/calendar.jsp" %>
								
								<!-- hidden -->
								<input type="hidden" id="popupChk" name="popupChk" width="50px"/>
							</td>
						</tr>
						<tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:100px;"></col>
								        			<col style="width:400px;"></col>
								        			<col style="width:130px;"></col>
								        			<col style="width:110px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
						                            	<td class="td-cond">
															<fmt:message key="KEY04001A.venue" />
														</td>
														<td class="td-input">
															<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
															<script type="text/javascript">
																var addRow = new AW.UI.Button;
										                      	addRow.setControlText("<fmt:message key="button.Init" />");
										                      	addRow.setControlImage("initialGrid");
										                      	document.write(addRow);
										                      
										                      	addRow.onControlClicked = function(event) {		
										                      		if($("#venue_S").val() != "") {
											                      		initVeneuCD();
										                      		}
										                      	};
															</script>
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY04001A.keymanNm" />
														</td>
														<td class="td-input" colspan="3">
															<input type="text" id="keyManNm_S" name="keyManNm_S" style="width:100px;" />
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond-required">
															<fmt:message key="KEY04001A.applyDate" />
														</td>
														<td class="td-input">
															<nis:calendar id="lApplyDateFrom_S" eventproc="clear()" callback="clear" /> - 
															<nis:calendar id="lApplyDateTo_S" eventproc="clear()" callback="clear" />
														</td>
						                            	<td class="td-cond">
						                            		<fmt:message key="KEY04001A.reRegistDocuS" />
														</td>
														<td class="td-input">
															<input type="checkbox" id="docuConfirmChk" name="docuConfirmChk" class="checkbox" />
														</td>
														<td class="td-cond">
															<fmt:message key="KEY04001A.docuCompleteValue" />
														</td>
														<td class="td-input">
															<nis:selectbox id="dCompValue" name="dCompValue" defaultText="all" category="DOCFINSHFL" />
						                                </td>
						                            </tr>
					                            </tbody>
					                        </table>
		                    			</td>
		                   			</tr>
		                   			<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style='width:60px'></col>
													<col style='width:160px'></col>
													<col style='width:60px'></col>
													<!--<col style='width:85px'></col>-->
													<col style='width:95px'></col>
													<col style='width:95px'></col>
													<col style='width:85px'></col>
													<col style='width:75px'></col>
													<col style='width:85px'></col>
													<col style='width:85px'></col>
													<col style='width:90px'></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
											            <td class='td-cond' style="height:30px;">
											            	<fmt:message key='KEY04001A.empNm' />
											            </td>
											            <td class='td-cond' style="text-align: center">
											            	<fmt:message key='KEY04001A.venueNm' />
											            </td>
											            <td class='td-cond' style='text-align: center'>
											            	<fmt:message key='KEY04001A.keymanNm' />
											            </td>
											           <!-- <td class='td-cond'>
											            	<fmt:message key='KEY04001A.docuNeedYn' />
											            </td> -->
											            <td class='td-cond'>
											            	<fmt:message key='KEY04001A.personInfoAgreeDoc' />
											            </td>
											            <td class='td-cond'>
											            	<fmt:message key='KEY04001A.programAgreeDoc' />
											            </td>
											            <td class='td-cond'>
											            	<fmt:message key='KEY04001A.saleRegistDoc' />
											            </td>
											            <td class='td-cond'>
											            	<fmt:message key='KEY04001A.entrustDoc' />
											            </td>
											            <td class='td-cond'>
											            	<fmt:message key='KEY04001A.docCompleteYn' />
											            </td>
											            <td class='td-cond'>
											            	<fmt:message key='KEY04001A.docMngFlNm' />
											            </td>
											            <td class='td-cond'>
											            	<fmt:message key='KEY04001A.applyDate' />
											            </td>
										            </tr>
										            <tr>
											           	<td valign="top" colspan="11">
											               	<div id="psite_cond" style="overflow-x:hidden;overflow-y:scroll;width:100%;height:300px;">
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
						<tr>
		                    <td class="td-paging" valign="top">
		                        <nis:paging id="grid" titleDisable="no" callback="PagingSearch()"/>
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
			</td><td></td></tr></table>
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
	$(function() {
	});
	
	
	$(document).ready(function() {

		window.onload = function() {
			
			$("#grid_displayNum").val("100");
			
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
    		
    		setDefaultDate();
    		
		};
		
		${initScript}
		
		
		$("#venue_S_popup").click(function(){
			
			var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
		    "&viewID=COM02001K&finalAction=closeRealMyVenuePopup";
			
			newWindow(url, "COM02001K", 650, 450,"yes");
			
		});
		
		$("#venue_S").keypress(function(){
			if (event.keyCode==13){
				getVenueName("venue_S", "venueCD_S", "venueNm_S");
				if($("#venueCD_S").val()!="") {
					Search();
				}
			}
		});
	});
	
	function initVeneuCD() {
		$("#venue_S").val("");
		$("#venueCD_S").val("");
		$("#venueNm_S").val("");
	}
	
	function clear() {
		
	}
	
	function closeRealMyVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}

	var _col_cd = {
			"code" : 0
			, "name" : 1
		}
	function getAddrTpCD2(code) {
		if(code == "") {
			$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "ADDRTPCD2");
	  	table.setParameter("attrib02", code);
     	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#addrTpCD2_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#addrTpCD2_S").attr("disabled",false);
    		$("#addrTpCD2_S").removeClass("input-readonly");
		}
     	else {
     		$("#addrTpCD2_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
     	}
	}
	
	function setDefaultDate() {
		var today = toDate("${params.clientDate}");
	    var dateFrom = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 14);

		$("#lApplyDateFrom_S").val('2014.01.01');
		$("#lApplyDateTo_S").val(toCalStr(today));
	}
	
	function toDate(str) {
        return new Date(str.substr(0, 4), str.substr(4, 2) - 1, str.substr(6, 2));
    }

	function toCalStr(date) {
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		var d = date.getDate();
		return '' + y + '.' + (m < 10 ? '0' + m : m) + '.' + (d < 10 ? '0' + d : d);
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	function Search() {
		$("#grid_pageNum").val("1");
		PagingSearch();
	}
	
	var _i = 0;
	var _col = {
		empNm : _i++
		, venueCD : _i++
		, venueNm : _i++
		, keymanID : _i++
		, keymanNm : _i++
		, doc_100_prgs_NM : _i++
		, doc_200_prgs_NM : _i++
		, doc_300_prgs_NM : _i++
		, doc_400_prgs_NM : _i++
		, keymanDocCompleteFl : _i++
		, keymanTypeCDName : _i++
		, docMngFlNm : _i++
		, birthDate : _i++
		, dutyCDName : _i++
		, addr : _i++
		, phoneNo : _i++
		, bankCD : _i++
		, bankCDName : _i++
		, accountNo : _i++
		, holderNm : _i++
		, PkeymanYN : _i++
		, activeYNName : _i++
		, oldKeymanID : _i++
		, note : _i++
		, lApplyDate : _i++
		, keymanTypeCD : _i++
		, activeYN : _i++
		, rowNum : _i++
		, doc_100_prgs : _i++
		, doc_200_prgs : _i++
		, doc_300_prgs : _i++
		, doc_400_prgs : _i++
		, docFinshFlNm : _i++
		, docNeedYn : _i++
    };
	
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0400101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"empNm;venueCD;venueNm;keymanID;keymanNm;"+
	  			"doc_100_prgs_NM;doc_200_prgs_NM;doc_300_prgs_NM;doc_400_prgs_NM;docFinishFl;"+
	  			"keymanTypeCDName;docMngFlNm;birthDate;dutyCDName;addr;"+
	  			"phoneNo;bankCD;bankCDName;accountNo;holderNm;"+
	  			"PkeymanYN;activeYNName;oldKeymanID;note;lApplyDate;"+
	  			"keymanTypeCD;activeYN;rowNum;"+
	  			"doc_100_prgs;doc_200_prgs;doc_300_prgs;doc_400_prgs;docFinshFlNm;"+
	  			"docNeedYn;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;");
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("empID", "${params.userID}");
	  	table.setParameter("keyManNm", $("#keyManNm_S").val());
	  	if ($("input:checked[id='docuConfirmChk']").is(":checked")) {
	  		table.setParameter("docuConfirmChk", "Y");
       	}else{       		
		  	table.setParameter("lApplyDateFrom", convertDate($("#lApplyDateFrom_S").val()));
		  	table.setParameter("lApplyDateTo", convertDate($("#lApplyDateTo_S").val()));
       	}
	  	table.setParameter("DocFinshFl", $("#dCompValue").val());
		//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
	  	table.request();
      	
      	var rowCount = table.getCount();
      	var s = "<table border='0' cellspacing='0' cellpadding='0' width='100%'>"
	   			+"<tr>"
				+"<td>"
				+"<table border='0' cellpadding='0' cellspacing='0' width='100%' style='border:#e1dcbe solid 1px; table-layout:fixed;'>"
				+"<colgroup>"
				+"<col style='width:59px'></col>"
				+"<col style='width:160px'></col>"
				+"<col style='width:60px'></col>"
				<!--+"<col style='width:85px'></col>" -->
				+"<col style='width:95px'></col>"
				+"<col style='width:95px'></col>"
				+"<col style='width:85px'></col>"
				+"<col style='width:75px'></col>"
				+"<col style='width:85px'></col>"
				+"<col style='width:85px'></col>"
				+"<col style='width:88px'></col>"
				+"<col></col>"
				+"</colgroup>"
				+"<tbody>";
				
      	
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
				var docCheckYn = "<input type='text' style='width:50px; border:#e1dcbe solid 0px; text-align:center; font-size:13px'>";	// 서류가 없을경우 공백처리를 위해 input박스 생성
      			var personInfoDocHtml = "<a href='#' onclick=\"documentPopup(\'"+ 100 +"\',\'"+ table.getData(_col.keymanID,i) +"\',\'"+ "KEY04001B"+"\');return false;\">"+ table.getData(_col.doc_100_prgs_NM,i) + "</a>";
      			var incenProgDocHtml = "<a href='#' onclick=\"documentPopup(\'"+ 200 +"\',\'"+ table.getData(_col.keymanID,i) +"\',\'"+ "KEY04001C"+"\');return false;\">"+ table.getData(_col.doc_200_prgs_NM,i) + "</a>";
      			var entrustDocHtml = "<a href='#' onclick=\"documentPopup(\'"+ 300 +"\',\'"+ table.getData(_col.keymanID,i) +"\',\'"+ "KEY04001D"+"\');return false;\">"+ table.getData(_col.doc_300_prgs_NM,i) + "</a>";
      			var saleRegistDocHtml = "<a href='#' onclick=\"documentPopup(\'"+ 400 +"\',\'"+ table.getData(_col.keymanID,i) +"\',\'"+ "KEY04001F"+"\');return false;\">"+ table.getData(_col.doc_400_prgs_NM,i) + "</a>";
      			
      			s=s+"<tr>"
	            +"<td style='height:50px; text-align:center;  font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            +table.getData(_col.empNm,i)
	            +"</td>"
	            +"<td style='text-align:left; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            +table.getData(_col.venueNm,i)
	            +"</td>"
	            +"<td style='text-align:center; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            +table.getData(_col.keymanNm,i)
	            +"</td>"
	            <!--+"<td style='text-align:center; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"-->
	            <!--+table.getData(_col.docNeedYn,i) -->
	            <!--+"</td>"-->
	            +"<td style='text-align:center; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            +personInfoDocHtml
	            +"</td>"
	            +"<td style='text-align:center; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            +incenProgDocHtml
	            +"</td>"
	            +"<td style='text-align:center; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            +entrustDocHtml
	            +"</td>"
	            +"<td style='text-align:center; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            +saleRegistDocHtml
	            +"</td>"
	            +"<td style='text-align:center; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            +table.getData(_col.docFinshFlNm,i)
	            +"</td>"
	            +"<td style='text-align:center; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            +table.getData(_col.docMngFlNm,i)
	            +"</td>"
	            +"<td style='text-align:left; padding-left:5px; height:25px; font-size:13px; border-right:#e1dcbe solid 1px; border-bottom:#e1dcbe solid 1px;'>"
	            + formatDate(table.getData(_col.lApplyDate,i));
	            +"</td>"
	            +"</tr>";
      			
      		}
      		
      		s = s +  "</tbody>"
    		+"</table>"
    		+"</td>"
    		+"</tr>"
    		+"</table>";
      		
			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/KEY0400102S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("outParamKey","totalCount;");
			table.setParameter("format","str;");
			table.setParameter("venueCD", $("#venueCD_S").val());
		  	table.setParameter("empID", "${params.empID}");
		  	table.setParameter("keyManNm", $("#keyManNm_S").val());
		  	if ($("input:checked[id='docuConfirmChk']").is(":checked")) {
		  		table.setParameter("docuConfirmChk", "Y");
	       	}else{       		
			  	table.setParameter("lApplyDateFrom", convertDate($("#lApplyDateFrom_S").val()));
			  	table.setParameter("lApplyDateTo", convertDate($("#lApplyDateTo_S").val()));
	       	}
		  	table.setParameter("DocFinshFl", $("#dCompValue").val());
			table.request();
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo('grid', beginRowNum, endRowNum, table.getData(0,0));
      	}
      	else {
			message("<fmt:message key="info.nullData"/>");	//조회건수 없을때 메시지
			////Paging Function: clearPageInfo(Grid Name);
      	}
      	$("#psite_cond").html(s);
    }
	
	function Excel() {
		
		if ($("input:checked[id='docuConfirmChk']").is(":checked")) {
			alert("체크");
       }
		
		return;
		
		showLoading();
		if(!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "KEY0300201S");
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("empNm", $("#empNm_S").val());
	  	table.setParameter("activeYN", $("#activeYN_S").val());
	  	table.setParameter("lApplyDateFrom", convertDate($("#lApplyDateFrom_S").val()));
	  	table.setParameter("lApplyDateTo", convertDate($("#lApplyDateTo_S").val()));
	  	
		var headerText = [
			"<fmt:message key="KEY04001A.empNm"/>"
			, "<fmt:message key="KEY04001A.venueCD"/>"
			, "<fmt:message key="KEY04001A.venueNm"/>"
			, "<fmt:message key="KEY04001A.keymanID"/>"
			, "<fmt:message key="KEY04001A.keymanNm"/>"
			, "<fmt:message key="KEY04001A.docMngFlNm"/>"
			, "<fmt:message key="KEY04001A.keymanTpCD"/>"
			, "<fmt:message key="KEY04001A.birthDate"/>"
			, "<fmt:message key="KEY04001A.dutyCD"/>"
			, "<fmt:message key="KEY04001A.addr"/>"
			, "<fmt:message key="KEY04001A.phoneNo"/>"
			, "<fmt:message key="KEY04001A.bankCD"/>"
			, "<fmt:message key="KEY04001A.bankCDName"/>"
			, "<fmt:message key="KEY04001A.accountNo"/>"
			, "<fmt:message key="KEY04001A.holderNm"/>"
			, "<fmt:message key="KEY04001A.PKeymanYN"/>"
			, "<fmt:message key="KEY04001A.activeYN"/>"
			, "<fmt:message key="KEY04001A.oldKeymanID"/>"
			, "<fmt:message key="KEY04001A.note"/>"
			, "<fmt:message key="KEY04001A.lApplyDate"/>"
		];
		
		table.setParameter("templateFile", "KEY04001A");
		table.setParameter("headerText", headerText);
		table.request();

		if (table.getCount() > 0) {
			if (table.getData(0,0) == "S") {	
			    form.action = "${contextPath}/service/simpleExport/download/?"+
			    		"tempFile="+table.getData(3,0)+
			    		"&downloadFile=${params.viewName}";
			    form.target = "_self";
			    form.submit();
			}
		}
		hideLoading();
	}

	function documentPopup(wordType, kmID, viewID) {
		
		var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
		"&viewID="+viewID+"&finalAction=Search"+"&wordType="+wordType+"&kmID="+kmID;
		
		newWindow(url, viewID, 1000,800,"yes");
		
	}
	
</script>
