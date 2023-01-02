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
				                            	<td class="td-cond">
													<fmt:message key="ANL04001A.programCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="programCD_S" name="programCD_S" defaultText="all" category="PROGRAMCD" />
				                                </td>
												<td class="td-cond-required">
													<fmt:message key="ANL04001A.transferDate" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                
				                                <td class="td-cond">
													<fmt:message key="ANL04001A.dkmdTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD_S" name="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="ANL04001A.activityCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
				                            	<td class="td-cond">
													<fmt:message key="ANL04001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL04001A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
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
				<tr>
					<td height="1">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 70px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:left;}
    .aw-column-2 {width: 150px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:right;}
    .aw-column-4 {width: 100px; text-align:right;}
    .aw-column-5 {width: 100px; text-align:right;}
    .aw-column-6 {width: 100px; text-align:right;}
    .aw-column-7 {width: 100px; text-align:right;}
    .aw-column-8 {width: 150px; text-align:right;}
   

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
			
			$("#grid_displayNum").val("100");
			createGrid();
			grid.refresh();
			
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			
			if("${params.dkmdTpCD}" != "DK") {
				$("#dkmdTpCD_S").val("${params.dkmdTpCD}");
				$("#dkmdTpCD_S").attr("disabled", true);
				$("#dkmdTpCD_S").addClass("input-readonly");
			}
			
    		$("#officeCD_S").attr("disabled",true);
    		$("#officeCD_S").addClass("input-readonly");
		};

		${initScript}

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
		  transferDate : _i++
		, keymanNm : _i++
		, regIDNo : _i++
		, totalAmt : _i++
		, incomeTax : _i++
		, residentTax : _i++
		, withholdingTax : _i++
		, payAmt : _i++
		, rowNum : _i++
		, totalCount : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/ANL0400101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"transferDate;keymanNm;regIDNo;totalAmt;incomeTax;"+
	  			"residentTax;withholdingTax;payAmt;rowNum;totalCount");
	  	table.setParameter("format",
	  			"str;str;str;num;num;"+
	  			"num;num;num;num;str;");
	  	table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("programCD", $("#programCD_S").val());
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
		table.setParameter("displayNum", $("#grid_displayNum").val());
		//Paging Parameter - END
		// --- 그룹 권한에 따라 empId가 'MK'로 시작하는 담당자 이름은 보이지 않도록 수정 2016.04.20
		if(		   '${params.grpID}' == '000004' || '${params.grpID}' == '000003' || '${params.grpID}' == '000002' 
				|| '${params.grpID}' == '000026' || '${params.grpID}' == '000005'
				|| '${params.grpID}' == '000013' || '${params.grpID}' == '000016' || '${params.grpID}' == '000018'
				|| '${params.grpID}' == '000017' || '${params.grpID}' == '000023' || '${params.grpID}' == '000024'){
			table.setParameter("grpID", "Y");
		}else{
			table.setParameter("grpID", "");
		}
		// ---
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
		var rowCount = table.getCount();
		if (rowCount > 0) {
			var data = new Array();
			for (var i=0; i<rowCount; i++) {
				var regNo = "";
      			if(table.getData(_col.regIDNo,i).length == 13){					//주민번호 포맷
      				regNo = formatIDNo(table.getData(_col.regIDNo,i), "");
      			}else if(table.getData(_col.regIDNo,i).length == 10){			//사업자번호 포맷
      				regNo = formatBizRegNo(table.getData(_col.regIDNo,i), "");	
      			}else{
      				regNo = table.getData(_col.regIDNo,i);
      			}
				data[i] = [
					formatMonth(table.getData(_col.transferDate,i))
					, table.getData(_col.keymanNm,i)
					, regNo
					, table.getData(_col.totalAmt,i)
					, table.getData(_col.incomeTax,i)
					, table.getData(_col.residentTax,i)
					, table.getData(_col.withholdingTax,i)
      			    , table.getData(_col.payAmt,i)
					
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
      		setPageInfo("grid", table.getData(_col.rowNum,0), table.getData(_col.rowNum,rowCount-1), table.getData(_col.totalCount,0));
		}
		else {
			message("<fmt:message key="info.nullData"/>");
			////Paging Function: clearPageInfo(Grid Name);
			clearPageInfo("grid");
      	}
      	grid.refresh();
	}
	
	function Excel() {
		showLoading();
		if(!confirm("<fmt:message key="confirm.excelDown"/>")) {
			hideLoading();
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "ANL0400101S");
		table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	table.setParameter("programCD", $("#programCD_S").val());
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
		
		var headerText = [
			"<fmt:message key="ANL04001A.transferDate"/>"
			, "<fmt:message key="ANL04001A.keymanNm"/>"
			, "<fmt:message key="ANL04001A.regIDNo"/>"
			, "<fmt:message key="ANL04001A.totalAmt"/>"
			, "<fmt:message key="ANL04001A.incomeTax"/>"
			, "<fmt:message key="ANL04001A.residentTax"/>"
			, "<fmt:message key="ANL04001A.withholdingTax"/>"
			, "<fmt:message key="ANL04001A.payAmt"/>"
		];
		
		table.setParameter("templateFile", "ANL04001A");
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
	   			"<fmt:message key="ANL04001A.transferDate"/>"
				, "<fmt:message key="ANL04001A.keymanNm"/>"
				, "<fmt:message key="ANL04001A.regIDNo"/>"
				, "<fmt:message key="ANL04001A.totalAmt"/>"
				, "<fmt:message key="ANL04001A.incomeTax"/>"
				, "<fmt:message key="ANL04001A.residentTax"/>"
				, "<fmt:message key="ANL04001A.withholdingTax"/>"
				, "<fmt:message key="ANL04001A.payAmt"/>"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(true);
		grid.setSelectorWidth(40);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                          str, str, str, num, num 
	                        , num, num, num, num
	                        ]);
	    grid.setCellEditable(false);
	    
    }
	
</script>