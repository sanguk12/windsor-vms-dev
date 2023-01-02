<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

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
						<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=AD02004B" />
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
						        			<col style="width:250px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:180px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="RLT02001A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearFromCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthFromCD_S" name="monthFromCD_S" defaultText="none" category="MONTHCD" /> -
													<nis:selectbox id="yearToCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthToCD_S" name="monthToCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT02001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT02001A.officeCD" />
												</td>
												<td class="td-input" colspan="5">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" style="width:100px;"  />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="RLT02001A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" style="width:80px;" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="RLT01001A.venue" />
												</td>
												<td class="td-input" colspan="7">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:80px;" />
												</td>				                            
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="AD01001A.payStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="payStateCD_S" name="payStateCD_S" defaultText="all" category="ADPAYSTATECD" style="width:80px;"  />
				                                </td>
												<td class="td-cond">
													<fmt:message key="AD01001A.apprStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="all" category="APPRSTATECD" style="width:80px;"  />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="AD01001A.contractStateCD" />
												</td>
												<td class="td-input" colspan="5">
													<nis:selectbox id="contractStateCD_S" name="contractStateCD_S" defaultText="all" category="CONTRACTSTATECD" style="width:80px;"  />
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
                		<table border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed;">
                			<colgroup>
			        			<col style="width:8%;"></col>
			        			<col style="width:17%;"></col>
			        			<col style="width:7%;"></col>
			        			<col style="width:25%;"></col>
			        			<col style="width:5%;"></col>
			        			<col></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="AD01001A.msg3" />
									</td>
									<td class="tit_text01">
										<span id="myAppr" style="background-color:#FFFFFF;"/>
	                                </td>
	                                <td class="tit_text01">
										<fmt:message key="AD01001A.msg4" />
									</td>
									<td class="tit_text01">
										<span id="myADApprEx2"  style="background-color:#BCF5A9;"  />
	                                </td>
	                            </tr>
			        		</tbody>
		        		</table>
                	</td>
                </tr>
               <tr>                                       
					<td height="*" valign="top">           
						<span id="grid_srch"></span>     
					</td>
				</tr>
				<tr>
                	<td height="5">
                		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                			<colgroup>
			        			<col style="width:100px;"></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="AD02004A.msg1" />
									</td>
	                            </tr>
			        		</tbody>
		        		</table>
                	</td>
                </tr>
               <tr>                                       
					<td height="200" valign="top">           
						<span id="grid_dtl"></span>     
					</td>
				</tr>
				<tr>
					<td height="1">
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="selectAdSupportID" name="selectAdSupportID" />
						<input type="hidden" id="selectAdSeq" name="selectAdSeq" />
						<input type="hidden" id="selectPayStateCD" name="selectPayStateCD" />
						<input type="hidden" id="selectContractStateCD" name="selectContractStateCD" />
						<input type="hidden" id="selectApprStateCD" name="selectApprStateCD" />
					</td>
				</tr>
			</table>
			</div>
				${appletDiv}
			</div>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid_srch .aw-column-0 {width: 70px; text-align:center;}
    #grid_srch .aw-column-1 {width: 100px; text-align:center;}
    #grid_srch .aw-column-2 {width: 140px; text-align:left;}
    #grid_srch .aw-column-3 {width: 75px; text-align:center;}
    #grid_srch .aw-column-4 {width: 75px; text-align:center;}
    #grid_srch .aw-column-5 {width: 75px; text-align:right;}
    #grid_srch .aw-column-6 {width: 90px; text-align:right;}
    #grid_srch .aw-column-7 {width: 90px; text-align:right;}
    #grid_srch .aw-column-8 {width: 90px; text-align:right;} 
    #grid_srch .aw-column-9 {width: 90px; text-align:right;} 
    #grid_srch .aw-column-10 {width: 90px; text-align:right;} 
    #grid_srch .aw-column-11 {width: 90px; text-align:right;} 
    #grid_srch .aw-column-12 {width: 200px; text-align:left;}
    #grid_srch .aw-column-13 {width: 70px; text-align:center;}
    #grid_srch .aw-column-14 {width: 70px; text-align:center;}
    #grid_srch .aw-column-15 {width: 60px; text-align:center;} 
    #grid_srch .aw-column-16 {width: 100px; text-align:center;} 
    #grid_srch .aw-column-17 {width: 60px; text-align:center;}
    #grid_srch .aw-column-18 {width: 100px; text-align:center;}
    #grid_srch .aw-column-19 {width: 60px; text-align:center;} 
    #grid_srch .aw-column-20 {width: 100px; text-align:left;}
    #grid_srch .aw-column-21 {width: 60px; text-align:center;}
    #grid_srch .aw-column-22 {width: 70px; text-align:center;}
    #grid_srch .aw-column-23 {width: 120px; text-align:left;}
    #grid_srch .aw-column-24 {width: 80px; text-align:center;} 
    #grid_srch .aw-column-25 {width: 80px; text-align:center;} 
    #grid_srch .aw-column-26 {width: 80px; text-align:center;} 
    
    
	#grid_dtl .aw-column-0 {width: 70px; text-align:center;}
    #grid_dtl .aw-column-1 {width: 100px; text-align:center;}
    #grid_dtl .aw-column-2 {width: 140px; text-align:left;}
    #grid_dtl .aw-column-3 {width: 75px; text-align:center;}
    #grid_dtl .aw-column-4 {width: 75px; text-align:center;}
    #grid_dtl .aw-column-5 {width: 75px; text-align:right;}
    #grid_dtl .aw-column-6 {width: 90px; text-align:right;}
    #grid_dtl .aw-column-7 {width: 90px; text-align:right;}
    #grid_dtl .aw-column-8 {width: 90px; text-align:right;} 
    #grid_dtl .aw-column-9 {width: 90px; text-align:right;}
    #grid_dtl .aw-column-10 {width: 90px; text-align:right;}
    #grid_dtl .aw-column-11 {width: 90px; text-align:right;} 
    #grid_dtl .aw-column-12 {width: 200px; text-align:left;}
    #grid_dtl .aw-column-13 {width: 70px; text-align:center;}
    #grid_dtl .aw-column-14 {width: 70px; text-align:center;}
    #grid_dtl .aw-column-15 {width: 60px; text-align:center;}
    #grid_dtl .aw-column-16 {width: 100px; text-align:center;}
    #grid_dtl .aw-column-17 {width: 60px; text-align:center;} 
    #grid_dtl .aw-column-18 {width: 100px; text-align:center;}
    #grid_dtl .aw-column-19 {width: 60px; text-align:center;}
    #grid_dtl .aw-column-20 {width: 100px; text-align:left;} 
    #grid_dtl .aw-column-21 {width: 60px; text-align:center;}
    #grid_dtl .aw-column-22 {width: 70px; text-align:center;}
    #grid_dtl .aw-column-23 {width: 120px; text-align:left;}
    #grid_dtl .aw-column-24 {width: 80px; text-align:center;}
    #grid_dtl .aw-column-25 {width: 80px; text-align:center;}
    #grid_dtl .aw-column-26 {width: 80px; text-align:center;}
    #grid_dtl .aw-column-27 {width: 80px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 var grid_displayNum = "100"; 
	 var myApprID = "000004";   //AD 승인라인
	 var myADApprExID = "000006"; // AD Exception2
	 var grpID = "000028"; //권한ID 3rd Party
	 
	/****************************************
	 * Function
	 ****************************************/
	$(document).ready(function() {

		window.onload = function() {

			firstInit();
			Search();
			
		};

		${initScript}

		$("#yearFromCD_S").change(function(){
			Search();
		});
		
		$("#yearToCD_S").change(function(){
			Search();
		});
		 
		$("#monthFromCD_S").change(function(){
			Search();
		});
		
		$("#monthToCD_S").change(function(){
			Search();
		});
		
		$("#venue_S_popup").click(function(){
			openMyVenuePopup("closeMyVenuePopup");
		});
		
		
		$("#venue_S").keypress(function(){
			if (event.keyCode == 13) {
				getVenueName("venue_S", "venueCD_S", "venueNm_S");
				if ($("#venueCD_S").val() != "") {
					Search();
				}
			}
		});
	});
	
	var _col_cd = {
		"code" : 0
	  , "name" : 1
	}
	
	//권역에 따른 지점
	function getOfficeCD(code) {
		
		if (code == "") {
			officeCDSetting();
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "OFFICECD");
	  	table.setParameter("attrib02", code);
	  	table.request();
     	
     	if (table.getCount() > 0) {
     		
     		$("#officeCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
     		
	     	for (var i = 0; i < table.getCount(); i++) {
	     		
	   			if (table.getData(_col_cd.code, i) == code) {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#officeCD_S").attr("disabled",false);
	     	$("#officeCD_S").removeClass("input-readonly");
     	}
	}
	
	//승인라인
	function getMyADAppr(apprTpID) {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03006S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprTpID", apprTpID);
		table.request();
		
		if(table.getCount() > 0) {
	 		if(apprTpID == myADApprExID) {
				$("#myADApprEx2").text(table.getData(0,0));
			}else {
				$("#myAppr").text(table.getData(0,0));
			}
		}
	}
	

	//날짜 유효성 check
	function validateDate(){
		var startDate = $("#yearFromCD_S").val() + $("#monthFromCD_S").val(); 
		var endDate = $("#yearToCD_S").val() + $("#monthToCD_S").val(); 
		var clientDate = "${params.clientDate}";
		var flag = true;
		
		if (startDate > endDate) {
			alert("<fmt:message key="AD01001B.msg1"/>");
			dateSetting();
			flag = false;
		}
		return flag;
	}
	
	//행사년월 setting
	function dateSetting() {
		$("#yearFromCD_S").val("${params.clientDate}".substring(0,4));
		$("#monthFromCD_S").val(1);
		$("#yearToCD_S").val("${params.clientDate}".substring(0,4));
		$("#monthToCD_S").val("${params.clientDate}".substring(4,6));		
	}
	
	//지점 setting
	function officeCDSetting() {
		$("#officeCD_S").val("");
		$("#officeCD_S").attr("disabled",true);
		$("#officeCD_S").addClass("input-readonly");
	}

	//초기 setting
	function firstInit() {
		$("#grid_displayNum").val(grid_displayNum);
		$("#apprStateCD_S option:eq(5)").prop("selected", true); //승인
		$("#contractStateCD option:eq(2)").prop("selected", true); //Exception1

		createGrid_srch();
		createGrid_dtl();
		grid_srch.refresh();
		grid_dtl.refresh();
		
		getMyADAppr(myApprID);
		getMyADAppr(myADApprExID);

		//지점 disable
		officeCDSetting();
		//행사년월 setting
		dateSetting();
	}
	
	//등록된 계약 건 존재 여부 check
	function checkContractTmpList() {
		var flag = true;
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0200441S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("adSupportID", $("#selectAdSupportID").val());
		table.setParameter("adContractDivCD", "30"); //계약구분 : 해지
		table.request();
		
		if(table.getCount() > 0) {
	 		if(table.getData(0,0) > 0) {
	 			alert("<fmt:message key="AD02004A.msg8"/>");
	 			flag = false;
	 		}
		}
		
		return flag;
	}
	
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	//조회
	function Search() {
		Search_srch();
      	grid_dtl.clear();
      	createGrid_dtl();
      	grid_dtl.refresh();
	}
	
	var _i_srch = 0;
	
	var _col_srch = {
		 contractDivCD : _i_srch++
		, venueCD : _i_srch++
		, venueNM : _i_srch++
		, startDT : _i_srch++
		, endDT : _i_srch++
		, contractMonth : _i_srch++
		, apAmt : _i_srch++
		, adCostPerGSV : _i_srch++
		, totalGSV : _i_srch++  
		, monthGSV : _i_srch++ 
		, volume : _i_srch++ 
		, monthVolume : _i_srch++
		, commt : _i_srch++
		, contractStateName : _i_srch++
		, payStateName : _i_srch++
		, buCDName : _i_srch++ 
		, requiredADCD1Name : _i_srch++
		, amt1 : _i_srch++
		, requiredADCD2Name : _i_srch++
		, amt2 : _i_srch++
		, requiredADCD3Name : _i_srch++
		, amt3 : _i_srch++
		, apprStateName : _i_srch++
		, expccommt : _i_srch++
		, file1 : _i_srch++
		, file2 : _i_srch++
		, file3 : _i_srch++
		, apprStateCD : _i_srch++
		, contractStateCD : _i_srch++
		, payStateCD : _i_srch++
		, adSupportID : _i_srch++
		, apprExpc : _i_srch++
		, file1Cnt : _i_srch++
		, file2Cnt : _i_srch++
		, file3Cnt : _i_srch++
		, rowNum : _i_srch++
    };
	
	//AD계약 목록 조회
	function Search_srch() {
	
		if (!validateDate()) return;
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0200401S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"contractDivCD;venueCD;venueNM;startDT;endDT;"+
	  			"contractMonth;apAmt;adCostPerGSV;totalGSV;monthGSV;"+
	  			"totalVolume;monthVolume;commt;contractStateName;payStateName;"+
	  			"buCDName;requiredADCD1Name;amt1;requiredADCD2Name;amt2;"+
	  			"requiredADCD3Name;amt3;payStateName;apprStateName;expccommt;"+
	  			"file1;file2;file3;apprStateCD;contractStateCD;"+
	  			"payStateCD;adSupportID;apprExpc;file1Cnt;file2Cnt;"+
	  			"file3Cnt;rowNum;"
	  			);
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;"
	  			);
		table.setParameter("startDT", $("#yearFromCD_S").val() + $("#monthFromCD_S").val());
		table.setParameter("endDT", $("#yearToCD_S").val() + $("#monthToCD_S").val());
		table.setParameter("empID", "${params.empID}");
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("payStateCD", $("#payStateCD_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.setParameter("contractStateCD", $("#contractStateCD_S").val());
	  	table.request();
	  	
      	createGrid_srch();
      	
    	var rowCount = table.getCount();
   		var data = new Array();
		var file1 = "", 
			file2 = "",
			file3 = "",
			apprStateName  = "",
			adHistory = "";
      	
      	if (rowCount > 0) {
      		for (var i = 0; i < rowCount; i++) {
      			
      			apprStateName = "<a href=\"javascript:openApprState('"+i+"','srch');\">"+table.getData(_col_srch.apprStateName,i)+"</a>";
      		    file1 = "<a href=\"javascript:openFilePopUp('"+i+"','ADINPUT','srch');\">"+table.getData(_col_srch.file1,i)+"</a>";
      		    file2 = "<a href=\"javascript:openFilePopUp('"+i+"','ADEVIDENCE','srch');\">"+table.getData(_col_srch.file2,i)+"</a>";
      		    file3 = "<a href=\"javascript:openFilePopUp('"+i+"','ADCONFIRM','srch');\">"+table.getData(_col_srch.file3,i)+"</a>";
      			 
      			data[i] = [
 					  table.getData(_col_srch.contractDivCD, i)
					, table.getData(_col_srch.venueCD, i)
					, table.getData(_col_srch.venueNM, i)
					, formatMonth(table.getData(_col_srch.startDT, i))
					, formatMonth(table.getData(_col_srch.endDT, i))
      			    , table.getData(_col_srch.contractMonth, i)
					, table.getData(_col_srch.apAmt, i)
					, table.getData(_col_srch.adCostPerGSV, i) + "%"
					, table.getData(_col_srch.totalGSV,i)
					, table.getData(_col_srch.monthGSV,i)
					, table.getData(_col_srch.volume,i)
					, table.getData(_col_srch.monthVolume,i)
					, table.getData(_col_srch.commt, i)
					, table.getData(_col_srch.contractStateName, i)
					, table.getData(_col_srch.payStateName, i)
					, table.getData(_col_srch.buCDName,i)
					, table.getData(_col_srch.requiredADCD1Name,i)
					, table.getData(_col_srch.amt1,i)
					, table.getData(_col_srch.requiredADCD2Name,i)
					, table.getData(_col_srch.amt2,i)
					, table.getData(_col_srch.requiredADCD3Name,i)
					, table.getData(_col_srch.amt3,i)
					, apprStateName
					, table.getData(_col_srch.expccommt, i)
					, file1
					, file2
					, file3
					, table.getData(_col_srch.apprStateCD, i)
					, table.getData(_col_srch.contractStateCD, i)
					, table.getData(_col_srch.payStateCD, i)
					, table.getData(_col_srch.adSupportID, i)
					, table.getData(_col_srch.apprExpc, i)
      			];

				//승인라인 Exception(_col_srch.apprExpc)에 따라 컬럼 색 적용
      			var apprExpc = table.getData(_col_srch.apprExpc, i);
				
      			if (apprExpc == 2) { // Exception 2
					grid_srch.getCellTemplate(_col_srch.apprStateName, i).setStyle("background", "#BCF5A9");
				}
      			
      			if (table.getData(_col_srch.file1Cnt, i) > 0) {
      				grid_srch.getCellTemplate(_col_srch.file1, i).setStyle("background", "#B2CCFF");
      			}
      			
      			if (table.getData(_col_srch.file2Cnt, i) > 0) {
      				grid_srch.getCellTemplate(_col_srch.file2, i).setStyle("background", "#B2CCFF");
      			}
      			
      			if (table.getData(_col_srch.file3Cnt, i) > 0) {
      				grid_srch.getCellTemplate(_col_srch.file3, i).setStyle("background", "#B2CCFF");
      			}
      		}
      		grid_srch.setCellData(data);
      		grid_srch.setRowCount(rowCount);
		}
      	grid_srch.refresh();
	}
	
	
	var _i_dtl = 0;
	
	var _col_dtl = {
		 contractDivCD : _i_dtl++
		, venueCD : _i_dtl++
		, venueNM : _i_dtl++
		, startDT : _i_dtl++
		, endDT : _i_dtl++
		, contractMonth : _i_dtl++
		, apAmt : _i_dtl++
		, adCostPerGSV : _i_dtl++
		, totalGSV : _i_dtl++  
		, monthGSV : _i_dtl++ 
		, volume : _i_dtl++ 
		, monthVolume : _i_dtl++
		, commt : _i_dtl++
		, contractStateName : _i_dtl++
		, payStateName : _i_dtl++
		, buCDName : _i_dtl++ 
		, requiredADCD1Name : _i_dtl++
		, amt1 : _i_dtl++
		, requiredADCD2Name : _i_dtl++
		, amt2 : _i_dtl++
		, requiredADCD3Name : _i_dtl++
		, amt3 : _i_dtl++
		, apprStateName : _i_dtl++
		, expccommt : _i_dtl++
		, adContractDivCD : _i_dtl++
		, file1 : _i_dtl++
		, file2 : _i_dtl++
		, file3 : _i_dtl++
		, apprStateCD : _i_dtl++
		, contractStateCD : _i_dtl++
		, payStateCD : _i_dtl++
		, adSupportID : _i_dtl++
		, apprExpc : _i_dtl++
		, adSeq : _i_dtl++
		, file1Cnt : _i_dtl++
		, file2Cnt : _i_dtl++
		, file3Cnt : _i_dtl++
		, rowNum : _i_dtl++
    };
	
	//AD계약 수정 목록 조회
	function Search_dtl() {
	
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/AD0200418S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"contractDivCD;venueCD;venueNM;startDT;endDT;"+
	  			"contractMonth;apAmt;adCostPerGSV;totalGSV;monthGSV;"+
				"totalVolume;monthVolume;commt;contractStateName;payStateName;"+
				"buCDName;requiredADCD1Name;amt1;requiredADCD2Name;amt2;"+
				"requiredADCD3Name;amt3;apprStateName;expccommt;adContractDivCD;"+
	  			"file1;file2;file3;apprStateCD;contractStateCD;"+
	  			"payStateCD;adSupportID;apprExpc;adSeq;file1Cnt;"+
	  			"file2Cnt;file3Cnt;rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;");
		table.setParameter("adSupportID", $("#selectAdSupportID").val());
	  	table.request();
	  	
      	createGrid_dtl();
      	
    	var rowCount = table.getCount();
      	var data = new Array();
		var file1 = "",
			file2 = "",
			file3 = "",
			apprStateName  = "";
      	
      	if (rowCount > 0) {
      		for (var i = 0; i < rowCount; i++) {
   				apprStateName = "<a href=\"javascript:openApprState('"+i+"', 'dtl');\">"+table.getData(_col_dtl.apprStateName,i)+"</a>";
   		    	file1 = "<a href=\"javascript:openFilePopUp('"+i+"','ADINPUT','dtl');\">"+table.getData(_col_dtl.file1,i)+"</a>";
   		    	file2 = "<a href=\"javascript:openFilePopUp('"+i+"','ADEVIDENCE','dtl');\">"+table.getData(_col_dtl.file2,i)+"</a>";
   		    	file3 = "<a href=\"javascript:openFilePopUp('"+i+"','ADCONFIRM','dtl');\">"+table.getData(_col_dtl.file3,i)+"</a>";
      			
      			data[i] = [
 					  table.getData(_col_dtl.contractDivCD, i)
					, table.getData(_col_dtl.venueCD, i)
					, table.getData(_col_dtl.venueNM, i)
					, formatMonth(table.getData(_col_dtl.startDT, i))
					, formatMonth(table.getData(_col_dtl.endDT, i))
      			    , table.getData(_col_dtl.contractMonth, i)
					, table.getData(_col_dtl.apAmt, i)
					, table.getData(_col_dtl.adCostPerGSV, i) + "%"
					, table.getData(_col_dtl.totalGSV,i)
					, table.getData(_col_dtl.monthGSV,i)
					, table.getData(_col_dtl.volume,i)
					, table.getData(_col_dtl.monthVolume,i)
					, table.getData(_col_dtl.commt, i)
					, table.getData(_col_dtl.contractStateName, i)
					, table.getData(_col_dtl.payStateName, i)
					, table.getData(_col_dtl.buCDName,i)
					, table.getData(_col_dtl.requiredADCD1Name,i)
					, table.getData(_col_dtl.amt1,i)
					, table.getData(_col_dtl.requiredADCD2Name,i)
					, table.getData(_col_dtl.amt2,i)
					, table.getData(_col_dtl.requiredADCD3Name,i)
					, table.getData(_col_dtl.amt3,i)
					, apprStateName
					, table.getData(_col_dtl.expccommt, i)
					, table.getData(_col_dtl.adContractDivCD, i)
					, file1
					, file2
					, file3
					, table.getData(_col_dtl.apprStateCD, i)
					, table.getData(_col_dtl.contractStateCD, i)
					, table.getData(_col_dtl.payStateCD, i)
					, table.getData(_col_dtl.adSupportID, i)
					, table.getData(_col_dtl.apprExpc, i)
					, table.getData(_col_dtl.adSeq, i)
      			];

				//승인라인 Exception(_col.apprExpc)에 따라 컬럼 색 적용
      			var apprExpc = table.getData(_col_dtl.apprExpc, i);
				
      			if (apprExpc == 2) { // Exception 2
					grid_dtl.getCellTemplate(_col_dtl.apprStateName, i).setStyle("background", "#BCF5A9");
				}
      			
      			if (table.getData(_col_dtl.file1Cnt, i) > 0) {
      				grid_dtl.getCellTemplate(_col_dtl.file1, i).setStyle("background", "#B2CCFF");
      			}
      			
      			if (table.getData(_col_dtl.file2Cnt, i) > 0) {
      				grid_dtl.getCellTemplate(_col_dtl.file2, i).setStyle("background", "#B2CCFF");
      			}
      			
      			if (table.getData(_col_dtl.file3Cnt, i) > 0) {
      				grid_dtl.getCellTemplate(_col_dtl.file3, i).setStyle("background", "#B2CCFF");
      			}
      		}
      		grid_dtl.setCellData(data);
      		grid_dtl.setRowCount(rowCount);
		}
      	grid_dtl.refresh();
	}
	
	//수정
	function Update() {
		//row를 클릭할 때만 수정 가능
		if ($("#selectAdSupportID").val() == "") {
			alert("<fmt:message key="AD02004A.msg2"/>");
			return;
		}
		//승인상태가 승인일 때만 수정 가능
		if ($("#selectApprStateCD").val() == "") {
			alert("<fmt:message key="AD02004A.msg5"/>");
			return;
		}
		//계약 상태가 계약일 때만 수정 가능
		if ($("#selectContractStateCD").val() == "") {
			alert("<fmt:message key="AD02004A.msg3"/>");
			return;
		}
		//지급 상태가 지급일 때만 수정 가능
		//if($("#selectPayStateCD").val() == "") {
		//	alert("<fmt:message key="AD02004A.msg4"/>");
		//	return;
		//}
		//등록된 계약 건 존재 여부 check
		if(!checkContractTmpList()) {
			return;
		}
		
		$("#selectAdSeq").val("");
		
		appletOpen();
		
		$("#_detail")[0].contentWindow.$("#adSupportID").val($("#selectAdSupportID").val());
		$("#_detail")[0].contentWindow.pageInit();
	}
	
	//업소 팝업 close
	function closeMyVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
	//승인상태 팝업	
	function openApprState(i, grdDivCD) {
		var venueCD = "";
      	var adSupportID = "";
      	var apprExpc = "";
      	var apprTpIDEx = "";
      	var adSeq = "";
      	var viewID = "";
      	
        //AD계약해지 목록 Grid
		if (grdDivCD == "srch") { 
			venueCD = grid_srch.getCellText(_col_srch.venueCD,i);
      		adSupportID = grid_srch.getCellText(_col_srch.adSupportID,i);
      		apprExpc = grid_srch.getCellText(_col_srch.apprExpc,i);
      		viewID = "AD01002B";
      	//AD계약해지 수정 목록 Grid
		} else {
			venueCD = grid_dtl.getCellText(_col_dtl.venueCD,i);
      		adSupportID = grid_dtl.getCellText(_col_dtl.adSupportID,i);
      		apprExpc = grid_dtl.getCellText(_col_dtl.apprExpc,i);
      		adSeq = grid_dtl.getCellText(_col_dtl.adSeq,i);
      		viewID = "AD02004C";
		}
		
		apprTpIDEx = (apprExpc == "2") ? myADApprExID : myApprID;
		
  		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID="+viewID 
			+"&adSupportID="+adSupportID
			+"&venueCD="+venueCD
			+"&adSeq="+adSeq
			+"&apprTpID="+apprTpIDEx 
	
		newWindow(url, viewID ,600,350,"yes");
		
	}
	
	//첨부 파일 팝업 
	function openFilePopUp(i, fileDivCD, grdDivCD) {
		var venueCD = "";
      	var adSupportID = "";
      	var viewID = (fileDivCD !== "ADEVIDENCE") ? "AD01001C" : "AD01001E"; //AD01001C : 첨부파일 업로드 화면, AD01001E : 첨부파일 보기 화면
      	
        //AD계약해지 목록 Grid
    	if (grdDivCD == "srch") {
			venueCD = grid_srch.getCellText(_col_srch.venueCD, i);
      		adSupportID = grid_srch.getCellText(_col_srch.adSupportID,i);
      	//AD계약해지 수정 목록 Grid
		} else {
			venueCD = grid_dtl.getCellText(_col_dtl.venueCD,i);
      		adSupportID = grid_dtl.getCellText(_col_dtl.adSupportID,i);
		}
      	
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}"
				+"&viewID="+viewID
				+"&adSupportID="+adSupportID
				+"&venueCD="+venueCD
				+"&fileDivCD="+fileDivCD
		
		newWindow(url, viewID,600,350,"yes");
	}
	
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns_srch = [
		 "<fmt:message key="AD01001A.contractDivCD"/>"
		, "<fmt:message key="AD01001A.venueCD"/>"
		, "<fmt:message key="AD01001A.venueNm"/>"
		, "<fmt:message key="AD01001A.startDT"/>"
		, "<fmt:message key="AD01001A.endDT"/>"
		, "<fmt:message key="AD01001A.contractCnt"/>"
		, "<fmt:message key="AD01001B.APContract"/>"
		, "<fmt:message key="AD01001B.adCostPerGSV"/>"
		, "<fmt:message key="AD02002A.totalGSV"/>"
		, "<fmt:message key="AD02002A.monthGSV"/>"
		, "<fmt:message key="AD02002A.totalVolume"/>"
		, "<fmt:message key="AD02002A.monthVolume"/>"
		, "<fmt:message key="AD01001A.comment"/>"
		, "<fmt:message key="AD01001A.contractStateCD"/>"
		, "<fmt:message key="AD01001A.payStateCD"/>"
		, "<fmt:message key="AD01001A.buCDName"/>"
		, "<fmt:message key="AD01001A.requiredADCD1Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.requiredADCD2Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.requiredADCD3Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.apprStateCD"/>"
		, "<fmt:message key="AD01001A.exceptionCommt"/>"
		, "<fmt:message key="AD01001A.file1"/>"
		, "<fmt:message key="AD01001A.file2"/>"
		, "<fmt:message key="AD01001A.file3"/>"
	];

	var grid_srch = null;
	
	//그리드 생성
	function createGrid_srch() {
		grid_srch = new AW.Grid.Extended;
		grid_srch.setId("grid_srch");
	    grid_srch.setRowCount(0);
	    grid_srch.setStyle("width","100%");
	    grid_srch.setStyle("height","100%");
	    grid_srch.setSelectorVisible(false);
	    grid_srch.setSelectionMode("single-cell");
	    grid_srch.setHeaderText(columns_srch);
	    
	    for (var i = 0; i < columns_srch.length; i++) {
	    	grid_srch.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    
	    grid_srch.setColumnCount(columns_srch.length);
 	    grid_srch.setCellFormat([
 	                          str, str, str, str, str
 	                        , str, num, str, num, num
 	                        , num, num, str, str, str
 	                        , str, str, str, str, str
 	                      	, str, str, html, str, html
 	                        , html, html
 	                        ]);
	    
	    grid_srch.setCellEditable(false); 
	    
	  //그리드 row 클릭
	    grid_srch.onRowClicked = function(event, row){
			$("#selectAdSupportID").val(this.getCellText(_col_srch.adSupportID, row));
			$("#selectPayStateCD").val(this.getCellText(_col_srch.payStateCD, row));
			$("#selectContractStateCD").val(this.getCellText(_col_srch.contractStateCD, row));
			$("#selectApprStateCD").val(this.getCellText(_col_srch.apprStateCD, row));
			Search_dtl();
	    }
		
    }
	
	var columns_dtl = [
		 "<fmt:message key="AD01001A.contractDivCD"/>"
		, "<fmt:message key="AD01001A.venueCD"/>"
		, "<fmt:message key="AD01001A.venueNm"/>"
		, "<fmt:message key="AD01001A.startDT"/>"
		, "<fmt:message key="AD01001A.endDT"/>"
		, "<fmt:message key="AD01001A.contractCnt"/>"
		, "<fmt:message key="AD01001B.APContract"/>"
		, "<fmt:message key="AD01001B.adCostPerGSV"/>"
		, "<fmt:message key="AD02002A.totalGSV"/>"
		, "<fmt:message key="AD02002A.monthGSV"/>"
		, "<fmt:message key="AD02002A.totalVolume"/>"
		, "<fmt:message key="AD02002A.monthVolume"/>"
		, "<fmt:message key="AD01001A.comment"/>"
		, "<fmt:message key="AD01001A.contractStateCD"/>"
		, "<fmt:message key="AD01001A.payStateCD"/>"
		, "<fmt:message key="AD01001A.buCDName"/>"
		, "<fmt:message key="AD01001A.requiredADCD1Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.requiredADCD2Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.requiredADCD3Name"/>"
		, "<fmt:message key="AD01001A.amt"/>"
		, "<fmt:message key="AD01001A.apprStateCD"/>"
		, "<fmt:message key="AD01001A.exceptionCommt"/>"
		, "<fmt:message key="AD02004A.adContractDivCD"/>"
		, "<fmt:message key="AD01001A.file1"/>"
		, "<fmt:message key="AD01001A.file2"/>"
		, "<fmt:message key="AD01001A.file3"/>"
	];

	var grid_dtl = null;
	
	//그리드 생성
	function createGrid_dtl() {
		grid_dtl = new AW.Grid.Extended;
	    grid_dtl.setId("grid_dtl");
	    grid_dtl.setRowCount(0);
	    grid_dtl.setStyle("width","100%");
	    grid_dtl.setStyle("height","100%");
	    grid_dtl.setSelectorVisible(false);
	    grid_dtl.setSelectionMode("single-cell");
	    grid_dtl.setHeaderText(columns_dtl);
	    
	    for (var i = 0; i < columns_dtl.length; i++) {
	    	grid_dtl.getHeaderTemplate(i).setStyle("text-align", "center");
	    }
	    
	    grid_dtl.setColumnCount(columns_dtl.length);
	    grid_dtl.setCellFormat([
	                          str, str, str, str, str
	                        , str, num, str, num, num
	                        , num, num, str, str, str
	                        , str, str, str, str, str
	                        , str, str, html, str, str
	                        , html, html, html
	                        ]);
	    
	    grid_dtl.setCellEditable(false); 
	    
		//그리드 row 클릭
	    grid_dtl.onRowClicked = function(event, row){
			$("#selectAdSeq").val(this.getCellText(_col_dtl.adSeq, row));
			
			appletOpen();
			$("#_detail")[0].contentWindow.$("#adSupportID").val($("#selectAdSupportID").val());
			$("#_detail")[0].contentWindow.pageInit();
	    }
		
   }
	
</script>