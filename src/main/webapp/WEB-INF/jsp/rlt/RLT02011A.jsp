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
			<input type="hidden" id="apprLv" name="apprLv" value="" />
			<input type="hidden" id="diffNo" name="diffNo" value="9" /><!-- G1 -->
			<input type="hidden" id="apprLvCHK" name="apprLvCHK" value="" />
			<input type="hidden" id="apprTpID" name="apprTpID" value="000000" /><!-- Plan/Result승인라인 -->
			<input type="hidden" id="apprTpID_Normal" name="apprTpID_Normal" value="000004" /><!-- Result Normal 승인라인 -->
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
            	<tr>
                    <td height="1">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
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
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:200px;"></col>
						        			<col style="width:100px;"></col>						        			
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>				                            	
												<td class="td-cond-required">
													<fmt:message key="ANL01001A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                            	<td class="td-cond">
													<fmt:message key="ANL01001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<c:choose>
													<c:when test="${params.rageSphereCD eq '' }">
														<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
													</c:when>
													<c:otherwise>
														<select id="rageSphereCD_S" name="rageSphereCD_S">
															<option value="${params.rageSphereCD}">${params.rageSphereCDName}</option>
														</select>
													</c:otherwise>
													</c:choose>
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL01001A.officeCD" />
												</td>
												<td class="td-input">
													<c:choose>
														<c:when test="${params.officeCD eq '' }">
															<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" query="COM03017S" paramkey="rageSphereCD;x;" paramvalue="${params.rageSphereCD};x;" />
														</c:when>
														<c:otherwise>
															<select id="officeCD_S" name="officeCD_S">
																<option value="${params.officeCD}">${params.officeCDName}</option>
															</select>
														</c:otherwise>
													</c:choose>
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
					<td height="205" valign="top">
						<span id="grid1"></span>
					</td>
				</tr>
				<tr>
					<td height="*" valign="top">
						<span id="grid2"></span>
					</td>
				</tr>
				<tr>
					<td height="1">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid1-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid1 .aw-column-0 {width: 185px; text-align:center;}
	#grid1 .aw-column-1 {width: 100px; text-align:center;}
    #grid1 .aw-column-2 {width: 200px; text-align:right;}
    #grid1 .aw-column-3 {width: 150px; text-align:right;}
    #grid1 .aw-column-4 {width: 150px; text-align:right;}
    #grid1 .aw-column-5 {width: 150px; text-align:right;}
    #grid1 .aw-column-6 {width: 0px; text-align:center;}
    
    #grid2 .aw-column-0 {width: 35px; text-align:center;}
    #grid2 .aw-column-1 {width: 150px; text-align:center;}
	#grid2 .aw-column-2 {width: 100px; text-align:center;}
    #grid2 .aw-column-3 {width: 200px; text-align:right;}
    #grid2 .aw-column-4 {width: 150px; text-align:right;}
    #grid2 .aw-column-5 {width: 150px; text-align:right;}
    #grid2 .aw-column-6 {width: 150px; text-align:right;}
    #grid2 .aw-column-7 {width: 150px; text-align:center;}
    #grid2 .aw-column-8 {width: 150px; text-align:center;}

	.aw-grid1-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid1-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

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
						
			checkApprLevel();
			createGrid();
			grid1.refresh();
			grid2.refresh();
			
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));	
			
			if ($("#apprLv").val() == "20"){
	    		$("#officeCD_S").attr("disabled",true);
	    		$("#officeCD_S").addClass("input-readonly");
	    		$("#rageSphereCD_S").attr("disabled",true);
	    		$("#rageSphereCD_S").addClass("input-readonly");
			}else if ($("#apprLv").val() == "30"){
				$("#rageSphereCD_S").attr("disabled",true);
	    		$("#rageSphereCD_S").addClass("input-readonly");
			}else if ($("#apprLv").val() == "40"){
				$("#officeCD_S").attr("disabled",true);
	    		$("#officeCD_S").addClass("input-readonly");
			}
    		
		};

		${initScript}
		
		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
			Search();
		});

	});
	
	var _col_cd = {
		  "code" : 0
		, "name" : 1
	}
	
	function getOfficeCD(code) {
		if(code=="") {
			$("#officeCD_S").val("");
			$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
			return;
		}
		
		if ($("#apprLv").val() == "40") return;
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "OFFICECD");
	  	table.setParameter("attrib02", code);
	  	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#officeCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#officeCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#officeCD_S").attr("disabled",false);
    		$("#officeCD_S").removeClass("input-readonly");
     	}
	}

	/****************************************
	* Button Action
	****************************************/		
	var _i = 0;
	var _col = {
		  summary : _i++
		, summaryN : _i++
		, volume : _i++
		, incentive : _i++
		, GSV : _i++
		, NGGSV : _i++	
		, apprStateCDName : _i++
		, apprStateCD : _i++
    };
	
	_i = 0;
	
	var _col2 = {
			checkbox : _i++
			 , summary : _i++
			, summaryN : _i++
			, volume : _i++
			, incentive : _i++
			, GSV : _i++
			, NGGSV : _i++	
			, apprStateCDName : _i++
			, apprStateCD : _i++
			, empID : _i++
	    };
	
	function Search() {		
		
		checkAppr();
		
     	var table1 = new AW.XML.Table;
		table1.setURL("${contextPath}/service/simpleAction/RLT0201100S");
		table1.setAsync(false);
		table1.setRequestMethod("POST");
		table1.setParameter("outParamKey","summary;summaryN;volume;incentive;GSV;NGGSV;apprStateCDName;apprStateCD;"	);
		table1.setParameter("format","str;str;num;num;num;num2;str;str;");
		
	  	table1.setParameter("eventYM"         , $("#yearCD_S").val()+$("#monthCD_S").val()); 
	  	table1.setParameter("rageSphereCD_S"  , $("#rageSphereCD_S").val());
	  	table1.setParameter("officeCD_S"      , $("#officeCD_S").val()); 
	  	
	  	table1.setParameter("empID"           , "${params.userID}");	 	  
	  	
	  	table1.setParameter("apprLv"          , $("#apprLv").val());
	  	

	  	table1.request();

      	createGrid();      	
      	
		var rowCount = table1.getCount();
		
		if (rowCount > 0) {
		
			var data = new Array();
			
			for (var i=0; i<rowCount; i++) {
				
                var apprStateCDName = "";
				
      			if(table1.getData(_col.apprStateCD,i) == "0") {
      				apprStateCDName = "";
          		}
          		else {
          			apprStateCDName = table1.getData(_col.apprStateCDName,i);
          		}
      			
				data[i] = [
								formatMonth(  table1.getData(_col.summary,i))
								, table1.getData(_col.summaryN,i)
								, table1.getData(_col.volume,i)
								, table1.getData(_col.incentive,i)
								, table1.getData(_col.GSV,i)
								, table1.getData(_col.NGGSV,i)  
								, apprStateCDName
					            , table1.getData(_col.apprStateCD,i)
      			];
				
				if(i != 2 && table1.getData(_col.summaryN,i) == "RESULT" ){
      				grid1.getCellTemplate(_col.summary,i).setStyle("font-weight", "bold");
      				grid1.getCellTemplate(_col.summaryN,i).setStyle("font-weight", "bold");
      				grid1.getCellTemplate(_col.volume,i).setStyle("font-weight", "bold");
      				grid1.getCellTemplate(_col.incentive,i).setStyle("font-weight", "bold");
      				grid1.getCellTemplate(_col.GSV,i).setStyle("font-weight", "bold");
      				grid1.getCellTemplate(_col.NGGSV,i).setStyle("font-weight", "bold");
      				grid1.getCellTemplate(_col.apprStateCDName,i).setStyle("font-weight", "bold");  
      				grid1.getCellTemplate(_col.NGGSV, i).setStyle("font-weight", "bold");				
      				grid1.getCellTemplate(_col.NGGSV, i).setStyle("background", "#7fff00");
      			}
      		}
      		grid1.setCellData(data);
      		grid1.setRowCount(rowCount);			
		}
		else {
			message("<fmt:message key="info.nullData"/>");	
      	}
      	grid1.refresh();
      	
      	var paramQuery = "RLT0201102S"		//지점장
      	if ($("#apprLv").val() == "30")  paramQuery = "RLT0201103S";	//권역장
      	if ($("#apprLv").val() == "40")  paramQuery = "RLT0201104S";	//CM
      	
      	var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/"+paramQuery);
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","checkbox;summary;summaryN;volume;incentive;GSV;NGGSV;apprStateCDName;apprStateCD;empID;"	);
	  	table.setParameter("format","str;str;str;num;num;num;num2;str;str;str;");
	  	
	  	
	  	table.setParameter("eventYM"       , $("#yearCD_S").val()+$("#monthCD_S").val()); 
	  	table.setParameter("rageSphereCD_S"  , $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S"      , $("#officeCD_S").val()); 
	  	
	  	table.setParameter("empID"         , "${params.userID}");	 	  
	  	
	  	table.request();     	  	
      	
		var rowCount = table.getCount();
		
		if (rowCount > 0) {
			var data = new Array();
			var chk  = 0;
			var chkRow  = 2;
			for (var i=0; i<rowCount; i++) {
				
                var apprStateCDName = "";
				
      			if(table.getData(_col2.apprStateCD,i) == "0") {
      				apprStateCDName = "";
          		}
          		else {
          			
                    if(i==chkRow){          				
          				
          				apprStateCDName = table.getData(_col2.apprStateCDName,i);
          				
          				if($("#apprLvCHK").val() != '50'){ 
          					
    	          			if (apprStateCDName == '승인') apprStateCDName = '승인요청';
          				}
	          			
	          			//chkRow = chkRow+9;
          		    }
                    
          		}
      			
				data[i] = [
								""
								, formatMonth(  table.getData(_col2.summary,i))
								, table.getData(_col2.summaryN,i)
								, table.getData(_col2.volume,i)
								, table.getData(_col2.incentive,i)
								, table.getData(_col2.GSV,i)
								, table.getData(_col2.NGGSV,i)  
								, apprStateCDName 
					            , table.getData(_col2.apprStateCD,i)
					            , table.getData(_col2.empID,i)
      			];
      			
				if( i == chk){
					
					if($("#apprLv").val() == "20" || $("#apprLv").val() == "30"){
						grid2.setCellTemplate(new AW.Templates.Checkbox, _col2.checkbox, i); 
					}
					
					grid2.getCellTemplate(_col2.summary, i).setStyle("background", "#2600ff");
					grid2.getCellTemplate(_col2.summary, i).setStyle("color", "#ffffff");
					grid2.getCellTemplate(_col2.summary, i).setStyle("font-weight", "bold");
					chk = chk+9;
				}
				
				if(table.getData(_col2.summary,i) != "Total" && table.getData(_col2.summaryN,i) == "RESULT" ){					
					
      				grid2.getCellTemplate(_col2.summary,i).setStyle("font-weight", "bold");
      				grid2.getCellTemplate(_col2.summaryN,i).setStyle("font-weight", "bold");
      				grid2.getCellTemplate(_col2.volume,i).setStyle("font-weight", "bold");
      				grid2.getCellTemplate(_col2.incentive,i).setStyle("font-weight", "bold");
      				grid2.getCellTemplate(_col2.GSV,i).setStyle("font-weight", "bold");
      				grid2.getCellTemplate(_col2.NGGSV,i).setStyle("font-weight", "bold");
      				grid2.getCellTemplate(_col2.apprStateCDName,i).setStyle("font-weight", "bold"); 
      				
      				if( grid1.getCellText(_col.NGGSV, 1) < table.getData(_col2.NGGSV,i)){      					
      					grid2.getCellTemplate(_col2.NGGSV, i).setStyle("background", "#ff4c00");
    					grid2.getCellTemplate(_col2.NGGSV, i).setStyle("color", "#ffffff");
      				}else{
   						grid2.getCellTemplate(_col2.NGGSV, i).setStyle("background", "#7fff00");		
   						grid2.getCellTemplate(_col2.NGGSV, i).setStyle("background", "#7fff00");		
      				}
      			}
				
				if(i==chkRow){          				
      				chkRow = chkRow+9;
      		    }
      		}
      		grid2.setCellData(data);
      		grid2.setRowCount(rowCount);			
		}
		else {
			message("<fmt:message key="info.nullData"/>");	
      	}
      	grid2.refresh();
	}
	
	//승인
	function Approval() {
		
		
		if($("#apprLv").val() == ""){
			alert("<fmt:message key="PLN02001A.msg6"/>");
			return;
		}
		
		if($("#apprLvCHK").val() == "X"){
			alert("<fmt:message key="PLN02001A.msg15"/>");
			return;
		}
		
		if($("#apprLvCHK").val() == "50"){
			alert("<fmt:message key="PLN02001A.msg14"/>");
			return;
		}		
		
		if ($("#apprLv").val() == "20"){
		
			//하위 레벨 영업사원의 승인요청 및 지점별 GSV 확인
			var table2 = new AW.XML.Table;
			table2.setURL("${contextPath}/service/simpleAction/PLN0201106S");
			table2.setAsync(false);
			table2.setRequestMethod("POST");
			table2.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
			table2.setParameter("empID", "${params.empID}");
			
			table2.request();		 
	
			if ($("#apprLv").val() == "20"){
				if (table2.getData(0,0) == ''){
					alert("<fmt:message key="PLN02001A.msg10"/>");
					return;
				}
			}
			
			var ngsvLocal = table2.getData(0,0);		//지점별 NGSV (local)
			var ngsvInter = table2.getData(0,1);		//지점별 NGSV (international)
			
			//if (grid1.getCellValue(_col.NGGSV ,5) > ngsvLocal * 1.05 ){
			if (grid1.getCellValue(_col.NGGSV ,5) > ngsvLocal ){
				alert("<fmt:message key="PLN02001A.msg11"/>");
				return;
			}
		
			//if (grid1.getCellValue(_col.NGGSV ,8) > ngsvInter * 1.05 ){
			if (grid1.getCellValue(_col.NGGSV ,8) > ngsvInter ){
				alert("<fmt:message key="PLN02001A.msg11"/>");
				return;
			}	
			
		}
		
//test시 주석
		for (var i=0; i<grid2.getRowCount(); i++){
			//하위 레벨 직원의 승인요청 확인
			if (grid2.getCellValue(_col2.summary ,i) == "Total" && grid2.getCellValue(_col2.summaryN ,i) == "RESULT"){
				if (grid2.getCellValue(_col2.apprStateCD ,i) != "50"){
					alert("<fmt:message key="PLN02001A.msg7"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="PLN02005A.msg1"/>")) {
	   		return;
	   	}
	
		//승인 처리
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt02/approvalReslut");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("userID" , "${params.userID}");
		
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD"    , $("#officeCD_S").val());
	  	
	  	if ($("#apprLv").val() == "40"){
			table.setParameter("lastApprYN", "Y");
		}else{
			table.setParameter("lastApprYN", "N");			
		}
		
		table.setParameter("levelNo"        , $("#apprLv").val() != '' ? $("#apprLv").val() / 10 : '0');
		table.setParameter("apprLv"         , $("#apprLv").val());
		table.setParameter("diffNo"         , $("#diffNo").val());
		table.setParameter("apprTpID"       , $("#apprTpID").val());
		table.setParameter("apprTpID_Normal", $("#apprTpID_Normal").val());
		table.request();		 

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function Reject() {
		//영업사원 단위로 반려 가능.
		
		if ( $("#apprLv").val() == "40"){
			alert("<fmt:message key="PLN02001A.msg13"/>");
			return;
		}
		
		if(!confirm("<fmt:message key="PLN02001A.msg5"/>")) {
       		return;
       	}
		
		var empIDs     = new Array();
		
		if(grid2.getRowCount() == 0) {
			alert("<fmt:message key="info.validate.gridSelect"/>");
			return;
		}
		
		var empIDCnt = 0;
		
		for(var i=0; i<grid2.getRowCount(); i++) {
			if (grid2.getCellValue(_col2.checkbox, i)) {
				//개별승인상태가 승인요청(승인)일 경우만 가능
				if(grid2.getCellText(_col2.apprStateCD, i+2) == "50") {
					empIDs[empIDCnt]     = grid2.getCellText(_col2.empID, i+2);
					empIDCnt++;
				}else{
					alert("<fmt:message key="PLN02001A.msg3"/>");
					return;
				}
			}
		}
		if(empIDCnt == 0){
			alert("선택된 항목이 없습니다.");
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt02/rejectResult");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM"        , $("#yearCD_S").val()+$("#monthCD_S").val());
		
		table.setParameter("empIDs"         , empIDs);
		
		table.setParameter("userID"         , "${params.userID}");
		table.setParameter("diffNo"         , $("#diffNo").val());
		table.setParameter("apprTpID"       , $("#apprTpID").val());
		table.setParameter("apprTpID_Normal", $("#apprTpID_Normal").val());
		table.request();

		if(table.getData(0,0) == "S") {			
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}	
		
	}
	
	function Excel() {
		showLoading();
		if(!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		
      	var paramQuery = "RLT0201102S"		//지점장
        
      	if ($("#apprLv").val() == "30")  paramQuery = "RLT0201103S";	//권역장
        if ($("#apprLv").val() == "40")  paramQuery = "RLT0201104S";	//CM
          	
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", paramQuery );
		table.setParameter("eventYM"       , $("#yearCD_S").val()+$("#monthCD_S").val()); 
	  	table.setParameter("rageSphereCD_S"  , $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S"      , $("#officeCD_S").val()); 
	  	
	  	table.setParameter("empID"         , "${params.userID}");	 	
		
		var headerText = [
			  "<fmt:message key="PLN01011A.summary"/>"
			, "<fmt:message key="PLN01011A.summaryN"/>"
			, "<fmt:message key="PLN01011A.volume"/>"
			, "<fmt:message key="PLN01011A.incentive"/>"
			, "<fmt:message key="PLN01011A.GSV"/>"
			, "<fmt:message key="PLN01011A.NGGSV"/>"
		];
		
		table.setParameter("templateFile", "RLT02011A");
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
	
	//로그인 사용자 승인 레벨 확인
	function checkApprLevel(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/PLN0201102S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.request();		 

		if(table.getData(0,0) != "") {
			$("#apprLv").val(table.getData(0,0));
		}
		
	}
	
	//로그인 사용자 승인 확인
	function checkAppr(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/RLT0201108S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM" , $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.userID}");
		table.setParameter("levelNo", $("#apprLv").val() != '' ? $("#apprLv").val() / 10 : '0');
		table.request();		 

		if(table.getData(0,0) != "") {
			$("#apprLvCHK").val(table.getData(0,0));
		}
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		 "<fmt:message key="PLN01011A.summary"/>"
		, "<fmt:message key="PLN01011A.summaryN"/>"
		, "<fmt:message key="PLN01011A.volume"/>"
		, "<fmt:message key="PLN01011A.incentive"/>"
		, "<fmt:message key="PLN01011A.GSV"/>"
		, "<fmt:message key="PLN01011A.NGGSV"/>"
	];
	
	var columns2 = [
	       		""	               
	       		, "<fmt:message key="PLN01011A.summary"/>"
	       		, "<fmt:message key="PLN01011A.summaryN"/>"
	       		, "<fmt:message key="PLN01011A.volume"/>"
	       		, "<fmt:message key="PLN01011A.incentive"/>"
	       		, "<fmt:message key="PLN01011A.GSV"/>"
	       		, "<fmt:message key="PLN01011A.NGGSV"/>"
	       		, "<fmt:message key="PLN01003A.apprStateCD"/>"
	       	];
	
	var grid1 = null;
	var grid2 = null;
	function createGrid() {
		grid1 = new AW.Grid.Extended;
	    grid1.setId("grid1");
	    grid1.setRowCount(0);
	    grid1.setStyle("width","100%");
	    grid1.setStyle("height","100%");
	    grid1.setSelectorVisible(true);
		grid1.setSelectorWidth(40);
		grid1.setSelectorText(function(i){return this.getRowPosition(i)+1});
	    grid1.setSelectionMode("single-row");
	    grid1.setHeaderText(columns);
	    //grid1.setsortable
	    for(var i=0;i<columns.length;i++){grid1.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid1.setColumnCount(columns.length);
	    grid1.setCellFormat([
                              str, str,  num, num , num, num2, str
	                        ]);
	    grid1.setCellEditable(false);
	    grid1.setFixedLeft(2);
	    
	    grid1.onHeaderClicked=function(event,col){	
			return true;
		};
		
		grid2 = new AW.Grid.Extended;
	    grid2.setId("grid2");
	    grid2.setRowCount(0);
	    grid2.setStyle("width","100%");
	    grid2.setStyle("height","100%");
	    grid2.setSelectorVisible(true);
		grid2.setSelectorWidth(40);
		grid2.setSelectorText(function(i){return this.getRowPosition(i)+1});
	    grid2.setSelectionMode("single-row");
	    grid2.setHeaderText(columns2);
	    //grid2.setsortable
	    for(var i=0;i<columns2.length;i++){grid2.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid2.setColumnCount(columns2.length);
	    grid2.setCellFormat([
                              str, str, str,  num, num , num, num2, str,str,str
	                        ]);
	    grid2.setCellEditable(false);
	    grid2.setFixedLeft(2);
	    
	    if ($("#apprLv").val() == "20"){		  
		    grid2.setCellValue(false, _col2.checkbox);
		    grid2.setHeaderTemplate(new AW.Templates.CheckBox, _col2.checkbox);
	    }
	    
	    grid2.onHeaderClicked=function(event,col){
	    	if (col != _col2.checkbox) return true;
	    	
			if (col == _col2.checkbox && this.getHeaderValue(_col2.checkbox,0)) {
				this.setCellValue(true, _col2.checkbox);
			}
			else if (col == _col2.checkbox && !this.getHeaderValue(_col2.checkbox,0)) {
				this.setCellValue(false, _col2.checkbox);
			}
			return false;
		};
    }
	
</script>