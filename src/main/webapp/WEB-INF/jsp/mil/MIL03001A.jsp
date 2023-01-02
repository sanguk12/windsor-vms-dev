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
						<input type="hidden" id="appSrc" name="appSrc" value="${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=MIL02001B" />
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
													<fmt:message key="MIL03001A.contractDate" />
												</td>
												<td class="td-input">
													<nis:calendar id="contractDateFrom_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" /> - 
													<nis:calendar id="contractDateTo_S" cssClass="input-readonly" readOnly="yes" value="" eventproc="" />
												</td>
				                                <td class="td-cond">
				                                	<fmt:message key="MIL03001A.contractOverYN" />
												</td>
												<td class="td-input" colspan="3">
													<select id="contractOverYN">
														<option value=""><fmt:message key="all" /></option>
														<option value="Y"><fmt:message key="MIL03001A.progressIng" /></option>
														<option value="N"><fmt:message key="MIL03001A.progressComplete" /></option>
													</select>
												</td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="MIL03001A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="MIL03001A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="MIL03001A.venue" />
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
	.aw-column-2 {width: 150px; text-align:left;}
	.aw-column-3 {width: 180px; text-align:center;}
    .aw-column-4 {width: 80px; text-align:right;}
    .aw-column-5 {width: 100px; text-align:right;}
    .aw-column-6 {width: 100px; text-align:right;}
    .aw-column-7 {width: 100px; text-align:right;}
    .aw-column-8 {width: 80px; text-align:right;}
    .aw-column-9 {width: 100px; text-align:right;}
    .aw-column-10 {width: 100px; text-align:right;}
    .aw-column-11 {width: 100px; text-align:right;}
    .aw-column-12 {width: 80px; text-align:right;}
    .aw-column-13 {width: 100px; text-align:right;}

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
		mileageID : _i++
		, venueCD : _i++
		, venueNm : _i++
		, contractDate : _i++
		, contractMonthCt : _i++
		, msTargetRate : _i++
		, tcontractQty : _i++
		, gsvAmt : _i++
		, gsvRate : _i++
		, stipulationAmt : _i++
		, contractAmt : _i++
		, subtractAmt : _i++
		, targetRate : _i++
		, addAmt : _i++
    };
	function Search() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/MIL0300101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"mileageID;venueCD;venueNm;contractDate;contractMonthCt;"+
	  			"msTargetRate;tcontractQty;gsvAmt;gsvRate;stipulationAmt;"+
	  			"contractAmt;subtractAmt;targetRate;addAmt;");
	  	table.setParameter("format",
	  			"str;str;str;str;num;"+
	  			"num;num5;num;num;num;"+
	  			"num;num;num;num;");
	  	table.setParameter("contractDateFrom", unformat($("#contractDateFrom_S").val()));
	  	table.setParameter("contractDateTo", unformat($("#contractDateTo_S").val()));
	  	table.setParameter("contractOverYN", $("#contractOverYN").val());
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
					table.getData(_col.mileageID,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.contractDate,i)
					, table.getData(_col.contractMonthCt,i)
					, table.getData(_col.msTargetRate,i)
					, table.getData(_col.tcontractQty,i)
					, table.getData(_col.gsvAmt,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.stipulationAmt,i)
					, table.getData(_col.contractAmt,i)
					, table.getData(_col.subtractAmt,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.addAmt,i)
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
		table.setParameter("queryKey", "MIL0300102S");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("contractDateFrom", unformat($("#contractDateFrom_S").val()));
	  	table.setParameter("contractDateTo", unformat($("#contractDateTo_S").val()));
	  	table.setParameter("contractOverYN", $("#contractOverYN").val());
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
			"<fmt:message key="MIL03001A.mileageID"/>"
			, "<fmt:message key="MIL03001A.venueCD"/>"
			, "<fmt:message key="MIL03001A.venueNm"/>"
			, "<fmt:message key="MIL03001A.contractDate"/>"
			, "<fmt:message key="MIL03001A.contractMonthCt"/>"
			, "<fmt:message key="MIL03001A.msTargetRate"/>"
			, "<fmt:message key="MIL03001A.tcontractQty"/>"
			, "<fmt:message key="MIL03001A.gsvAmt"/>"
			, "<fmt:message key="MIL03001A.gsvRate"/>"
			, "<fmt:message key="MIL03001A.stipulationAmt"/>"
			, "<fmt:message key="MIL03001A.contractAmt"/>"
			, "<fmt:message key="MIL03001A.subtractAmt"/>"
			, "<fmt:message key="MIL03001A.targetRate"/>"
			, "<fmt:message key="MIL03001A.addAmt"/>"
			, "<fmt:message key="MIL03001A.payTpCD"/>"
			, "<fmt:message key="MIL03001A.keymanID"/>"
			, "<fmt:message key="MIL03001A.keymanNm"/>"
			, "<fmt:message key="MIL03001A.birthDate"/>"
			, "<fmt:message key="MIL03001A.bankCDName"/>"
			, "<fmt:message key="MIL03001A.accountNo"/>"
			, "<fmt:message key="MIL03001A.payAmt"/>"
		];
		
		table.setParameter("templateFile", "MIL03001A");
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
		"<fmt:message key="MIL03001A.mileageID"/>"
		, "<fmt:message key="MIL03001A.venueCD"/>"
		, "<fmt:message key="MIL03001A.venueNm"/>"
		, "<fmt:message key="MIL03001A.contractDate"/>"
		, "<fmt:message key="MIL03001A.contractMonthCt"/>"
		, "<fmt:message key="MIL03001A.msTargetRate"/>"
		, "<fmt:message key="MIL03001A.tcontractQty"/>"
		, "<fmt:message key="MIL03001A.gsvAmt"/>"
		, "<fmt:message key="MIL03001A.gsvRate"/>"
		, "<fmt:message key="MIL03001A.stipulationAmt"/>"
		, "<fmt:message key="MIL03001A.contractAmt"/>"
		, "<fmt:message key="MIL03001A.subtractAmt"/>"
		, "<fmt:message key="MIL03001A.targetRate"/>"
		, "<fmt:message key="MIL03001A.addAmt"/>"
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
	                        str, str, str, str, num
	                        , num, num5, num, num, num
	                        , num, num, num, num
	                        ]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(3);
    }
	
</script>