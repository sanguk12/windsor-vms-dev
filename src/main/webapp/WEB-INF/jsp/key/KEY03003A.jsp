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
								<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=KEY03003B" />
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
								        			<col style="width:300px;"></col>
								        			<col style="width:100px;"></col>
								        			<col style="width:150px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond">
															<fmt:message key="KEY03003A.venueGradCD" />
														</td>
														<td class="td-input">
															<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03003A.addrTpCD1" />
														</td>
														<td class="td-input">
															<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03003A.addrTpCD2" />
														</td>
														<td class="td-input">
															<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond">
															<fmt:message key="KEY03003A.venue" />
														</td>
														<td class="td-input">
															<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
						                                	<!-- <script type="text/javascript">
																var addRow = new AW.UI.Button;
										                      	addRow.setControlText("<fmt:message key="button.Init" />");
										                      	addRow.setControlImage("initialGrid");
										                      	document.write(addRow);
										                      
										                      	addRow.onControlClicked = function(event) {		 
										                      		if($("#venue_S").val() != "") {
										                      			initVeneuCD();
										                      		}
										                      	};
															</script> -->
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03003A.empNm" />
														</td>
														<td class="td-input">
															<input type="text" id="empNm_S" name="empNm_S" style="width:100px;" />
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03003A.keymanNm" />
														</td>
														<td class="td-input">
															<input type="text" id="keyManNm_S" name="keyManNm_S" style="width:100px;" />
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond-required">
															<fmt:message key="KEY03003A.applyDate" />
														</td>
														<td class="td-input">
															<nis:calendar id="lApplyDateFrom_S"  eventproc="clear()" callback="clear" /> - 
															<nis:calendar id="lApplyDateTo_S" eventproc="clear()" callback="clear" />
														</td>
						                            	<td class="td-cond">
															<fmt:message key="KEY03003A.docuConfirmS" />
														</td>
														<td class="td-input">
															<input type="checkbox" id="docuConfirmChk" name="docuConfirmChk" class="checkbox" />
														</td>
														<td class="td-cond">
															<fmt:message key="KEY03003A.docuCompleteValue" />
														</td>
														<td class="td-input">
															<nis:selectbox id="dCompValue" name="dCompValue" defaultText="all" category="DOCFINSHFL" />
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
								<span id="grid"></span>
							</td>
						</tr>
						<tr>
		                    <td class="td-paging">
		                        <nis:paging id="grid" titleDisable="no" callback="PagingSearch()"/>
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

	.aw-column-0 {width: 60px; text-align:center;}
	.aw-column-1 {width: 90px; text-align:center;}
    .aw-column-2 {width: 120px; }
    .aw-column-3 {width: 80px; text-align:center;}
    .aw-column-4 {width: 60px; text-align:center;}
    .aw-column-5 {width: 85px; text-align:center;}
    .aw-column-6 {width: 100px; text-align:center;}
    .aw-column-7 {width: 100px; text-align:center;}
    .aw-column-8 {width: 90px; text-align:center;}
    .aw-column-9 {width: 110px; text-align:center;}
    .aw-column-10 {width: 90px; text-align:center;}
    .aw-column-11 {width: 90px; text-align:center;}
    .aw-column-12 {width: 120px; text-align:center;}
    .aw-column-13 {width: 80px; text-align:center;}
    .aw-column-14 {width: 80px; text-align:center;}
    .aw-column-15 {width: 150px; text-align:left;}
    .aw-column-16 {width: 80px; text-align:center;}
    .aw-column-17 {width: 80px; text-align:center;}
    .aw-column-18 {width: 120px; text-align:center;}
    .aw-column-19 {width: 100px; text-align:center;}
    .aw-column-20 {width: 80px; text-align:center;}
    .aw-column-21 {width: 80px; text-align:center;}
    .aw-column-22 {width: 100px; text-align:center;}
    .aw-column-23 {width: 100px; text-align:center;}
    .aw-column-24 {width: 80px; text-align:center;}
    .aw-column-25 {width: 80px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
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
			
			$("#grid_displayNum").val("200");
			createGrid();
			grid.refresh();
			
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
    		
    		setDefaultDate();
			
		};
		
		${initScript}
		
		
		$("#venue_S_popup").click(function(){
			openVenuePopup("closeVenuePopup");
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
	
	function closeVenuePopup(data) {
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
		
		//$("#lApplyDateFrom_S").val(toCalStr(dateFrom));
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
	
	function initVeneuCD() {
		$("#venue_S").val("");
		$("#venueCD_S").val("");
		$("#venueNm_S").val("");
		grid.clear();
		createGrid();
		grid.refresh();
	}
	
	function clear() {
		grid.clear();
		createGrid();
		grid.refresh();
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
		, keymanTypeCDName : _i++
		, keymanDocCompleteFl : _i++
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
		, docNeedYn : _i++
    };
	
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0300301S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"empNm;venueCD;venueNm;keymanID;keymanNm;"+
	  			"doc_100_prgs_NM;doc_200_prgs_NM;doc_300_prgs_NM;doc_400_prgs_NM;docFinshFlNm;"+
	  			"keymanTypeCDName;docMngFl;birthDate;dutyCDName;addr;"+
	  			"phoneNo;bankCD;bankCDName;accountNo;holderNm;"+
	  			"PkeymanYN;activeYNName;oldKeymanID;note;lApplyDate;"+
	  			"keymanTypeCD;activeYN;rowNum;docNeedYn;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;str;"+
	  			"str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("empNm", $("#empNm_S").val());
	  	table.setParameter("keyManNm", $("#keyManNm_S").val());
	  	table.setParameter("lApplyDateFrom", convertDate($("#lApplyDateFrom_S").val()));
	  	table.setParameter("lApplyDateTo", convertDate($("#lApplyDateTo_S").val()));
	  	if ($("input:checked[id='docuConfirmChk']").is(":checked")) {
	  		table.setParameter("docuConfirmChk", "Y");
       }
	  	table.setParameter("dCompValue", $("#dCompValue").val());
		//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		/* alert(table.getData(_col.regIDNo,0).length); */
      		for (var i=0; i<rowCount; i++) {
      		
      			data[i] = [
					table.getData(_col.empNm,i)
					, table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
      			    , table.getData(_col.keymanID,i)
					, table.getData(_col.keymanNm,i)
					, table.getData(_col.docNeedYn,i)
					, table.getData(_col.doc_100_prgs_NM,i)
					, table.getData(_col.doc_200_prgs_NM,i)
					, table.getData(_col.doc_300_prgs_NM,i)
					, table.getData(_col.doc_400_prgs_NM,i)
					, table.getData(_col.keymanTypeCDName,i)
					, table.getData(_col.docMngFlNm,i)
					, table.getData(_col.keymanDocCompleteFl,i)
					, formatDate(table.getData(_col.birthDate,i))
					, table.getData(_col.dutyCDName,i)
					, table.getData(_col.addr,i)
					, table.getData(_col.phoneNo,i)
					, table.getData(_col.bankCD,i)
					, table.getData(_col.bankCDName,i)
					, table.getData(_col.accountNo,i)
					, table.getData(_col.holderNm,i)
					, table.getData(_col.PkeymanYN,i)
					, table.getData(_col.activeYNName,i)
					, table.getData(_col.oldKeymanID,i)
					, table.getData(_col.note,i)
					, formatDate(table.getData(_col.lApplyDate,i))
					, table.getData(_col.keymanTypeCD,i)
					, table.getData(_col.activeYN,i)
      			];
      			
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/KEY0300302S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("outParamKey","totalCount;");
			table.setParameter("format","str;");
			table.request();
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo('grid', beginRowNum, endRowNum, table.getData(0,0));
      	}
      	else {
			message("<fmt:message key="info.nullData"/>");	//조회건수 없을때 메시지
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
      	}
      	grid.refresh();
    }
	
	function Excel() {
		
		if ($("input:checked[id='docuConfirmChk']").is(":checked")) {
			alert("체크");
       }
		
		showLoading();
		if(!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "KEY0300301S");
		table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("empNm", $("#empNm_S").val());
	  	table.setParameter("keyManNm", $("#keyManNm_S").val());
	  	table.setParameter("lApplyDateFrom", convertDate($("#lApplyDateFrom_S").val()));
	  	table.setParameter("lApplyDateTo", convertDate($("#lApplyDateTo_S").val()));
	  	if ($("input:checked[id='docuConfirmChk']").is(":checked")) {
	  		table.setParameter("docuConfirmChk", "Y");
       }
	  	
		var headerText = [
					"<fmt:message key="KEY03003A.empNm"/>"
					, "<fmt:message key="KEY03003A.venueCD"/>"
					, "<fmt:message key="KEY03003A.venueNm"/>"
					, "<fmt:message key="KEY03003A.keymanID"/>"
					, "<fmt:message key="KEY03003A.keymanNm"/>"
					, "<fmt:message key="KEY03003A.docuNeedYn"/>"
					, "<fmt:message key="KEY03003A.programAgreeDoc"/>"
					, "<fmt:message key="KEY03003A.personInfoAgreeDoc"/>"
					, "<fmt:message key="KEY03003A.saleRegistDoc"/>"
					, "<fmt:message key="KEY03003A.entrustDoc"/>"
					, "<fmt:message key="KEY03003A.docCompleteYn"/>"
					, "<fmt:message key="KEY03003A.keymanTpCD"/>"
					, "<fmt:message key="KEY03003A.regIDNo"/>"
					, "<fmt:message key="KEY03003A.birthDate"/>"
					, "<fmt:message key="KEY03003A.dutyCD"/>"
					, "<fmt:message key="KEY03003A.addr"/>"
					, "<fmt:message key="KEY03003A.phoneNo"/>"
					, "<fmt:message key="KEY03003A.bankCD"/>"
					, "<fmt:message key="KEY03003A.bankCDName"/>"
					, "<fmt:message key="KEY03003A.accountNo"/>"
					, "<fmt:message key="KEY03003A.holderNm"/>"
					, "<fmt:message key="KEY03003A.PKeymanYN"/>"
					, "<fmt:message key="KEY03003A.activeYN"/>"
					, "<fmt:message key="KEY03003A.oldKeymanID"/>"
					, "<fmt:message key="KEY03003A.note"/>"
					, "<fmt:message key="KEY03003A.lApplyDate"/>"
		];
		
		table.setParameter("templateFile", "KEY03003A");
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
	
	
	
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		"<fmt:message key="KEY03003A.empNm"/>"
		, "<fmt:message key="KEY03003A.venueCD"/>"
		, "<fmt:message key="KEY03003A.venueNm"/>"
		, "<fmt:message key="KEY03003A.keymanID"/>"
		, "<fmt:message key="KEY03003A.keymanNm"/>"
		, "<fmt:message key="KEY03003A.docuNeedYn"/>"
		, "<fmt:message key="KEY03003A.personInfoAgreeDoc"/>"
		, "<fmt:message key="KEY03003A.programAgreeDoc"/>"
		, "<fmt:message key="KEY03003A.saleRegistDoc"/>"
		, "<fmt:message key="KEY03003A.entrustDoc"/>"
		, "<fmt:message key="KEY03003A.docCompleteYn"/>"
		, "<fmt:message key="KEY03003A.docMngFlNm"/>"
		, "<fmt:message key="KEY03003A.keymanTpCD"/>"
		, "<fmt:message key="KEY03003A.birthDate"/>"
		, "<fmt:message key="KEY03003A.dutyCD"/>"
		, "<fmt:message key="KEY03003A.addr"/>"
		, "<fmt:message key="KEY03003A.phoneNo"/>"
		, "<fmt:message key="KEY03003A.bankCD"/>"
		, "<fmt:message key="KEY03003A.bankCDName"/>"
		, "<fmt:message key="KEY03003A.accountNo"/>"
		, "<fmt:message key="KEY03003A.holderNm"/>"
		, "<fmt:message key="KEY03003A.PKeymanYN"/>"
		, "<fmt:message key="KEY03003A.activeYN"/>"
		, "<fmt:message key="KEY03003A.oldKeymanID"/>"
		, "<fmt:message key="KEY03003A.note"/>"
		, "<fmt:message key="KEY03003A.lApplyDate"/>"
	];

	var grid = null;
	
	function createGrid() {
		grid = new AW.UI.Grid;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false); //그리드 순번표기 on/off기능
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);	//그리드 컬럼 적용 
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}	//그리드 컬럼의 속성 적용
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                        str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        ]);
	    
	    grid.onRowDoubleClicked = function(event, row) {
	    	appletOpen();
	    	
	    	$("#_detail")[0].contentWindow.$("#keyMan").val(grid.getCellValue(3,row));
	    	$("#_detail")[0].contentWindow.Search();
	    	
	    };
    }
</script>