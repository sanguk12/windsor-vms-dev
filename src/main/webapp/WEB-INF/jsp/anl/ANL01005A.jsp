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
												<td class="td-cond-required">
													<fmt:message key="ANL01001A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL01001A.dkmdTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD_S" name="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL01001A.activityCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="ANL01001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL01001A.officeCD" />
												</td>
												<td class="td-input" colspan="3">
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
    .aw-column-2 {width: 80px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:left;}
    .aw-column-4 {width: 100px; text-align:left;}
    .aw-column-5 {width: 70px; text-align:center;}
    .aw-column-6 {width: 100px; text-align:center;}
    .aw-column-7 {width: 150px; text-align:left;}
    .aw-column-8 {width: 90px; text-align:center;}
    .aw-column-9 {width: 120px; text-align:left;}
    .aw-column-10 {width: 70px; text-align:center;}
    .aw-column-11 {width: 100px; text-align:left;}
    .aw-column-12 {width: 100px; text-align:left;}
    .aw-column-13 {width: 70px; text-align:center;}
    .aw-column-14 {width: 100px; text-align:center;}
    .aw-column-15 {width: 120px; text-align:center;}
    .aw-column-16 {width: 150px; text-align:center;}
    .aw-column-17 {width: 100px; text-align:left;}
    .aw-column-18 {width: 100px; text-align:left;}
    .aw-column-19 {width: 120px; text-align:left;}
    .aw-column-20 {width: 80px; text-align:right;}
    .aw-column-21 {width: 100px; text-align:right;}
    .aw-column-22 {width: 100px; text-align:right;}
    .aw-column-23 {width: 100px; text-align:right;}
    .aw-column-24 {width: 100px; text-align:right;}
    .aw-column-25 {width: 100px; text-align:right;}

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
		eventYM : _i++
		, activityCDName : _i++
		, dkmdTpCDName : _i++
		, rageSphereCDName : _i++
		, officeCDName : _i++
		, empNm : _i++
		, venueCD : _i++
		, venueNm : _i++
		, wsSapCD : _i++
		, wsSapCDName : _i++
		, venueGradCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, addrTpCD3Name : _i++
		, addrTpCD4Name : _i++
		, kindTpCD5Name : _i++
		, kindTpCD2Name : _i++
		, prdNm : _i++
		, planQty : _i++
		, planUnitAmt : _i++
		, guidAmt : _i++
		, payAmt : _i++
		, gsvRate : _i++
		, euPlanQty : _i++
		, rowNum : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/ANL0100501S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"eventYM;activityCDName;dkmdTpCDName;rageSphereCDName;officeCDName;"+
	  			"empNm;venueCD;venueNm;wsSapCD;wsSapCDName;"+
	  			"venueGradCDName;segmentCDName;subSegmentCDName;addrTpCD1Name;addrTpCD2Name;"+
	  			"addrTpCD3Name;addrTpCD4Name;kindTpCD5Name;kindTpCD2Name;prdNm;planQty;"+
	  			"planUnitAmt;guidAmt;payAmt;gsvRate;euPlanQty;"+
	  			"rowNum;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;num;"+
	  			"num;num;num;num;num5;"+
	  			"str;");
	  	table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
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
				data[i] = [
					formatMonth(table.getData(_col.eventYM,i))
					, table.getData(_col.activityCDName,i)
					, table.getData(_col.dkmdTpCDName,i)
					, table.getData(_col.rageSphereCDName,i)
					, table.getData(_col.officeCDName,i)
					, table.getData(_col.empNm,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.wsSapCD,i)
					, table.getData(_col.wsSapCDName,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.addrTpCD3Name,i)
					, table.getData(_col.addrTpCD4Name,i)
					, table.getData(_col.kindTpCD5Name,i)
					, table.getData(_col.kindTpCD2Name,i)
					, table.getData(_col.prdNm,i)
					, table.getData(_col.planQty,i)
					, table.getData(_col.planUnitAmt,i)
					, table.getData(_col.guidAmt,i)
					, table.getData(_col.payAmt,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.euPlanQty,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
			
			//totalCount
			var beginRowNum = table.getData(_col.rowNum,0);
			var endRowNum = table.getData(_col.rowNum,rowCount-1);
			table.setURL("${contextPath}/service/simpleAction/ANL0100502S");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("outParamKey","totalCount;");
			table.setParameter("format","str;");
			table.request();
			
			//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
			setPageInfo("grid", beginRowNum, endRowNum, table.getData(0,0));
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
		table.setParameter("queryKey", "ANL0100501S");
		table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
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
		
		var headerText = [
			"<fmt:message key="ANL01001A.eventYM"/>"
			, "<fmt:message key="ANL01001A.activityCD"/>"
			, "<fmt:message key="ANL01001A.dkmdTpCD"/>"
			, "<fmt:message key="ANL01001A.rageSphereCD"/>"
			, "<fmt:message key="ANL01001A.officeCD"/>"
			, "<fmt:message key="ANL01001A.empNm"/>"
			, "<fmt:message key="ANL01001A.venueCD"/>"
			, "<fmt:message key="ANL01001A.venueNm"/>"
			, "<fmt:message key="ANL01001A.wsSapCD"/>"
			, "<fmt:message key="ANL01001A.wsSapCDName"/>"
			, "<fmt:message key="ANL01001A.venueGradCD"/>"
			, "<fmt:message key="ANL01001A.segmentCD"/>"
			, "<fmt:message key="ANL01001A.subSegmentCD"/>"
			, "<fmt:message key="ANL01001A.addrTpCD1"/>"
			, "<fmt:message key="ANL01001A.addrTpCD2"/>"
			, "<fmt:message key="ANL01001A.addrTpCD3"/>"
			, "<fmt:message key="ANL01001A.addrTpCD4"/>"
			, "<fmt:message key="ANL01001A.kindTpCD5Name"/>"
			, "<fmt:message key="ANL01001A.kindTpCD2Name"/>"
			, "<fmt:message key="ANL01001A.prdNm"/>"
			, "<fmt:message key="ANL01001A.planQty"/>"
			, "<fmt:message key="ANL01001A.planUnitAmt"/>"
			, "<fmt:message key="ANL01001A.guidAmt"/>"
			, "<fmt:message key="ANL01001A.payAmt"/>"
			, "<fmt:message key="ANL01001A.gsvRate"/>"
			, "<fmt:message key="ANL01001A.euPlanQty"/>"
		];
		
		table.setParameter("templateFile", "ANL01005A");
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
		"<fmt:message key="ANL01001A.eventYM"/>"
		, "<fmt:message key="ANL01001A.activityCD"/>"
		, "<fmt:message key="ANL01001A.dkmdTpCD"/>"
		, "<fmt:message key="ANL01001A.rageSphereCD"/>"
		, "<fmt:message key="ANL01001A.officeCD"/>"
		, "<fmt:message key="ANL01001A.empNm"/>"
		, "<fmt:message key="ANL01001A.venueCD"/>"
		, "<fmt:message key="ANL01001A.venueNm"/>"
		, "<fmt:message key="ANL01001A.wsSapCD"/>"
		, "<fmt:message key="ANL01001A.wsSapCDName"/>"
		, "<fmt:message key="ANL01001A.venueGradCD"/>"
		, "<fmt:message key="ANL01001A.segmentCD"/>"
		, "<fmt:message key="ANL01001A.subSegmentCD"/>"
		, "<fmt:message key="ANL01001A.addrTpCD1"/>"
		, "<fmt:message key="ANL01001A.addrTpCD2"/>"
		, "<fmt:message key="ANL01001A.addrTpCD3"/>"
		, "<fmt:message key="ANL01001A.addrTpCD4"/>"
		, "<fmt:message key="ANL01001A.kindTpCD5Name"/>"
		, "<fmt:message key="ANL01001A.kindTpCD2Name"/>"
		, "<fmt:message key="ANL01001A.prdNm"/>"
		, "<fmt:message key="ANL01001A.planQty"/>"
		, "<fmt:message key="ANL01001A.planUnitAmt"/>"
		, "<fmt:message key="ANL01001A.guidAmt"/>"
		, "<fmt:message key="ANL01001A.payAmt"/>"
		, "<fmt:message key="ANL01001A.gsvRate"/>"
		, "<fmt:message key="ANL01001A.euPlanQty"/>"
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
	                        str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str,num
	                        , num, num, num, num, num5
	                        ]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(8);
	    
    }
	
</script>