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
						<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=SUP02001B" />
					</td>
				</tr>
				<tr>
					<td height="1">
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
                    		<tr>
                    			<td class="tb-border">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
						        			<col style="width:120px;"></col>
						        			<col style="width:300px;"></col>
						        			<col style="width:120px;"></col>
						        			<col style="width:250px;"></col>
						        			<col style="width:120px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
												<td class="td-cond-required">
													<fmt:message key="SUP03001A.contractDate" />
												</td>
												<td class="td-input">
													<nis:calendar id="contractDateFrom_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" /> - 
													<nis:calendar id="contractDateTo_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" />
												</td>
				                                <td class="td-cond">
				                                	<fmt:message key="SUP03005A.contractStatus" />
												</td>
												<td class="td-input" colspan="3">
													<select id="contractStatus">
														<option value=""><fmt:message key="all" /></option>
														<option value="Y"><fmt:message key="SUP03005A.progressIng" /></option>
														<option value="N"><fmt:message key="SUP03005A.progressComplete" /></option>
														<option value="X"><fmt:message key="SUP03005A.progressExpend" /></option>
													</select>
												</td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="SUP03001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="SUP03001A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="SUP03001A.venue" />
												</td>
												<td class="td-input">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
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

	.aw-column-0 {width: 90px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:center;}
	.aw-column-2 {width: 50px; text-align:center;}
	.aw-column-3 {width: 150px; text-align:center;}
    .aw-column-4 {width: 120px; text-align:center;}
    .aw-column-5 {width: 180px; text-align:center;}
    .aw-column-6 {width: 80px; text-align:center;}
    .aw-column-7 {width: 100px; text-align:center;}
    .aw-column-8 {width: 80px; text-align:center;}
    .aw-column-9 {width: 100px; text-align:center;}
    .aw-column-10 {width: 100px; text-align:center;}
    .aw-column-11 {width: 100px; text-align:center;}
    .aw-column-12 {width: 80px; text-align:center;}
    .aw-column-13 {width: 100px; text-align:center;}
    .aw-column-14 {width: 100px; text-align:center;}
    .aw-column-15 {width: 100px; text-align:center;}
    .aw-column-16 {width: 100px; text-align:right;}
    .aw-column-17 {width: 100px; text-align:right;}
    .aw-column-18 {width: 100px; text-align:right;}
    .aw-column-19 {width: 100px; text-align:right;}
    .aw-column-20 {width: 100px; text-align:right;}
    .aw-column-21 {width: 100px; text-align:right;}
    .aw-column-22 {width: 100px; text-align:right;}

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
			
			createGrid();
			grid.refresh();
			
			//1년전부터
			$("#contractDateFrom_S").val("${params.agoYearDate}");
			$("#contractDateTo_S").val("${params.currentDate}");
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
	
	function closeVenuePopup(data) {
		$("#venue_S").val(data.venueCD);
		$("#venueCD_S").val(data.venueCD);
        $("#venueNm_S").val(data.venueNm);
	}
	
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	var _i = 0;
	var _col = {
		supportID : _i++
		, kindType : _i++
		, fy : _i++
		, officeNm : _i++
		, venueCD : _i++
		, venueNm : _i++
		, progress : _i++
		, contractStatus : _i++
		, contractDateFrom : _i++
		, contractDateTo : _i++
		, contractMontCt : _i++
		, currentStd : _i++
		, expMonth : _i++
		, expMonth2 : _i++
		, addMonth : _i++
		, remainAmt : _i++
		, constractAmt : _i++
		, monthTgt : _i++
		, accumAmt : _i++
		, kiaAccumAmt : _i++
		, completeRtnAmt : _i++
		, diffAmt : _i++
		, targetRate : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/SUP0300105S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"supportID;kindType;fy;officeNm;venueCD;"+
	  			"venueNm;progress;contractStatus;contractDateFrom;contractDateTo;"+
	  			"contractMontCt;currentStd;expMonth;expMonth2;addMonth;"+
	  			"remainAmt;constractAmt;monthTgt;accumAmt;kiaAccumAmt;"+
	  			"completeRtnAmt;diffAmt;targetRate;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"num;num;num;num;num;"+
	  			"num;num;str;");
	  	table.setParameter("contractDateFrom", unformat($("#contractDateFrom_S").val()));
	  	table.setParameter("contractDateTo", unformat($("#contractDateTo_S").val()));
	  	table.setParameter("contractStatus", $("#contractStatus").val());
	  	table.setParameter("rageSphereCD", "${params.rageSphereCD}");
	  	table.setParameter("officeCD", "${params.officeCD}");
	  	table.setParameter("teamCD", "${params.teamCD}");
	  	table.setParameter("dkmdTpCD", "${params.dkmdTpCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("venue_S", $("#venue_S").val());
	  	/*장기단기 분리시 밑의 주석을 풀어줘야함, 기준이 3개월일경우 숫자 3을 입력하면됨*/
	  	//table.setParameter("periodLongTerm", 3);
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					table.getData(_col.supportID,i)
      			    , table.getData(_col.kindType,i)
      			    , table.getData(_col.fy,i)
      			    , table.getData(_col.officeNm,i)
      			    , table.getData(_col.venueCD,i)
      			    , table.getData(_col.venueNm,i)
      			    , table.getData(_col.progress,i)
      			    , table.getData(_col.contractStatus,i)
      			    , table.getData(_col.contractDateFrom,i)
      			    , table.getData(_col.contractDateTo,i)
      			    , table.getData(_col.contractMontCt,i)
      			    , table.getData(_col.currentStd,i)
      			    , table.getData(_col.expMonth,i)
      			    /* , table.getData(_col.expMonth2,i) */
      			    , table.getData(_col.addMonth,i)
      			    , table.getData(_col.remainAmt,i)
      			    , table.getData(_col.constractAmt,i)
      			    , table.getData(_col.monthTgt,i)
      			    , table.getData(_col.accumAmt,i)
      			    , table.getData(_col.kiaAccumAmt,i)
      			    , table.getData(_col.completeRtnAmt,i)
      			    , table.getData(_col.diffAmt,i)
      			    , table.getData(_col.targetRate,i)
      			];
			}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
	function Excel() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "SUP0300105S");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("contractDateFrom", unformat($("#contractDateFrom_S").val()));
	  	table.setParameter("contractDateTo", unformat($("#contractDateTo_S").val()));
	  	table.setParameter("contractStatus", $("#contractStatus").val());
	  	table.setParameter("rageSphereCD", "${params.rageSphereCD}");
	  	table.setParameter("officeCD", "${params.officeCD}");
	  	table.setParameter("teamCD", "${params.teamCD}");
	  	table.setParameter("dkmdTpCD", "${params.dkmdTpCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	/*장기단기 분리시 밑의 주석을 풀어줘야함, 기준이 3개월일경우 숫자 3을 입력하면됨*/
	  	//table.setParameter("periodLongTerm", 3);
	  	
	  	table.setParameter("rageSphereCD_S", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD_S", $("#officeCD_S").val());
	  	table.setParameter("venue_S", $("#venue_S").val());
	  	
		var headerText = [
			"<fmt:message key="SUP03005A.supportID"/>"
			, "<fmt:message key="SUP03005A.kindType"/>"
			, "<fmt:message key="SUP03005A.fy"/>"
			, "<fmt:message key="SUP03005A.officeNm"/>"
			, "<fmt:message key="SUP03005A.venueCD"/>"
			, "<fmt:message key="SUP03005A.venueNm"/>"
			, "<fmt:message key="SUP03005A.progress"/>"
			, "<fmt:message key="SUP03005A.contractStatus"/>"
			, "<fmt:message key="SUP03005A.contractDateFrom"/>"
			, "<fmt:message key="SUP03005A.contractDateTo"/>"
			, "<fmt:message key="SUP03005A.contractMontCt"/>"
			, "<fmt:message key="SUP03005A.currentStd"/>"
			, "<fmt:message key="SUP03005A.expMonth"/>"
			/* , "<fmt:message key="SUP03005A.expMonth2"/>" */
			, "<fmt:message key="SUP03005A.addMonth"/>"
			, "<fmt:message key="SUP03005A.remainAmt"/>"
			, "<fmt:message key="SUP03005A.constractAmt"/>"
			, "<fmt:message key="SUP03005A.monthTgt"/>"
			, "<fmt:message key="SUP03005A.accumAmt"/>"
			, "<fmt:message key="SUP03005A.kiaAccumAmt"/>"
			, "<fmt:message key="SUP03005A.completeRtnAmt"/>"
			, "<fmt:message key="SUP03005A.diffAmt"/>"
			, "<fmt:message key="SUP03005A.targetRate"/>"
		];
		
		table.setParameter("templateFile", "SUP03005A");
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
	}
	
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
	   			"<fmt:message key="SUP03005A.supportID"/>"
				, "<fmt:message key="SUP03005A.kindType"/>"
				, "<fmt:message key="SUP03005A.fy"/>"
				, "<fmt:message key="SUP03005A.officeNm"/>"
				, "<fmt:message key="SUP03005A.venueCD"/>"
				, "<fmt:message key="SUP03005A.venueNm"/>"
				, "<fmt:message key="SUP03005A.progress"/>"
				, "<fmt:message key="SUP03005A.contractStatus"/>"
				, "<fmt:message key="SUP03005A.contractDateFrom"/>"
				, "<fmt:message key="SUP03005A.contractDateTo"/>"
				, "<fmt:message key="SUP03005A.contractMontCt"/>"
				, "<fmt:message key="SUP03005A.currentStd"/>"
				, "<fmt:message key="SUP03005A.expMonth"/>"
				/* , "<fmt:message key="SUP03005A.expMonth2"/>" */
				, "<fmt:message key="SUP03005A.addMonth"/>"
				, "<fmt:message key="SUP03005A.remainAmt"/>"
				, "<fmt:message key="SUP03005A.constractAmt"/>"
				, "<fmt:message key="SUP03005A.monthTgt"/>"
				, "<fmt:message key="SUP03005A.accumAmt"/>"
				, "<fmt:message key="SUP03005A.kiaAccumAmt"/>"
				, "<fmt:message key="SUP03005A.completeRtnAmt"/>"
				, "<fmt:message key="SUP03005A.diffAmt"/>"
				, "<fmt:message key="SUP03005A.targetRate"/>"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
	    grid.setId("grid");
	    grid.setRowCount(0);
	    grid.setStyle("width","100%");
	    grid.setStyle("height","100%");
	    grid.setSelectorVisible(false);
	    grid.setSelectionMode("single-row");
	    grid.setHeaderText(columns);
	    for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid.setColumnCount(columns.length);
	    grid.setCellFormat([
	                        str, str, str, str, str
	                        , str, str, str, str, str
	                        , str, str, str, str, str
	                        , num, num, num, num, num
	                        , num, num, str
	                        ]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(3);
    }
	
</script>