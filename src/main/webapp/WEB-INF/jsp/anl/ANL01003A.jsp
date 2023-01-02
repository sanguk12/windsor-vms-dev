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
													<fmt:message key="ANL01003A.programCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="programCD_S" name="programCD_S" defaultText="all" category="PROGRAMCD" />
				                                </td>
												<td class="td-cond-required">
													<fmt:message key="ANL01003A.eventYM" />
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="startYearCD_S" name="startYearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="startMonthCD_S" name="startMonthCD_S" defaultText="none" category="MONTHCD" /> ~
													<nis:selectbox id="endYearCD_S" name="endYearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="endMonthCD_S" name="endMonthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="ANL01003A.dkmdTpCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="dkmdTpCD_S" name="dkmdTpCD_S" defaultText="all" category="DKMDTPCD" />
				                                </td>
				                            	<td class="td-cond">
													<fmt:message key="ANL01003A.activityCD" />
												</td>
												<td class="td-input" colspan="3">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
													<!-- <nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" /> -->
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="ANL01003A.rageSphereCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="rageSphereCD_S" name="rageSphereCD_S" defaultText="all" category="RAGESPHERECD" event="onchange" eventproc="getOfficeCD(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL01003A.officeCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="officeCD_S" name="officeCD_S" defaultText="all" category="OFFICECD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="ANL01003A.kindTpCD5" />
												</td>
												<td class="td-input">
													<nis:selectbox id="kindTpCD5_S" name="kindTpCD5_S" defaultText="all" category="KINDTPCD5" />
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

	.aw-column-0 {width: 100px; text-align:center;}
	.aw-column-1 {width: 100px; text-align:center;}
    .aw-column-2 {width: 100px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:left;}
    .aw-column-4 {width: 100px; text-align:left;}
    .aw-column-5 {width: 70px; text-align:right;}
    .aw-column-6 {width: 120px; text-align:right;}
    .aw-column-7 {width: 80px; text-align:right;}
    .aw-column-8 {width: 120px; text-align:right;}

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
			
			$("#startYearCD_S").val("${params.clientDate}".substring(0,4));
			$("#startMonthCD_S").val("${params.clientDate}".substring(4,6));
			$("#endYearCD_S").val("${params.clientDate}".substring(0,4));
			$("#endMonthCD_S").val("${params.clientDate}".substring(4,6));
			
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
		rageSphereCDName : _i++
		, officeCDName : _i++
		, incntTpCDName : _i++
		, kindTpCD5Name : _i++
		, kindTpCD2Name : _i++
		, venueCount : _i++
		, payAmt : _i++
		, planQty_eu : _i++
		, euRate : _i++
		, gp : _i++
    };
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/ANL0100301S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"rageSphereCDName;officeCDName;incntTpCDName;kindTpCD5Name;kindTpCD2Name;"+
	  			"venueCount;payAmt;planQty_eu;euRate;gp;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"num;num;num;num;str;");
	  	table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	table.setParameter("programCD", $("#programCD_S").val());
	  	table.setParameter("startEventYM", $("#startYearCD_S").val()+$("#startMonthCD_S").val());
	  	table.setParameter("endEventYM", $("#endYearCD_S").val()+$("#endMonthCD_S").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("kindTpCD5", $("#kindTpCD5_S").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
		var rowCount = table.getCount();
		if (rowCount > 0) {
			var data = new Array();
			for (var i=0; i<rowCount; i++) {
				data[i] = [
					table.getData(_col.rageSphereCDName,i)
					, table.getData(_col.officeCDName,i)
					, table.getData(_col.incntTpCDName,i)
					, table.getData(_col.kindTpCD5Name,i)
					, table.getData(_col.kindTpCD2Name,i)
					, table.getData(_col.venueCount,i)
					, table.getData(_col.payAmt,i)
					, table.getData(_col.planQty_eu,i)
					, table.getData(_col.euRate,i)
					, table.getData(_col.gp,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount-1);
      		
      		grid.setFooterText(table.getData(_col.rageSphereCDName,rowCount-1), _col.rageSphereCDName);
      		grid.setFooterText(table.getData(_col.venueCount,rowCount-1), _col.venueCount);
      		grid.setFooterText(table.getData(_col.payAmt,rowCount-1), _col.payAmt);
      		grid.setFooterText(table.getData(_col.planQty_eu,rowCount-1), _col.planQty_eu);
      		grid.setFooterText(table.getData(_col.euRate,rowCount-1), _col.euRate);
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
		table.setParameter("queryKey", "ANL0100301S");
		table.setParameter("rageSphereCD_S", "${params.rageSphereCD}");
	  	table.setParameter("officeCD_S", "${params.officeCD}");
	  	table.setParameter("teamCD_S", "${params.teamCD}");
	  	table.setParameter("territoryCD", "${params.territoryCD}");
	  	table.setParameter("programCD", $("#programCD_S").val());
	  	table.setParameter("startEventYM", $("#startYearCD_S").val()+$("#startMonthCD_S").val());
	  	table.setParameter("endEventYM", $("#endYearCD_S").val()+$("#endMonthCD_S").val());
	  	table.setParameter("dkmdTpCD", $("#dkmdTpCD_S").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("rageSphereCD", $("#rageSphereCD_S").val());
	  	table.setParameter("officeCD", $("#officeCD_S").val());
	  	table.setParameter("kindTpCD5", $("#kindTpCD5_S").val());
		
		var headerText = [
			"<fmt:message key="ANL01003A.rageSphereCD"/>"
			, "<fmt:message key="ANL01003A.officeCD"/>"
			, "<fmt:message key="ANL01003A.incntTpCDName"/>"
			, "<fmt:message key="ANL01003A.kindTpCD5Name"/>"
			, "<fmt:message key="ANL01003A.kindTpCD2Name"/>"
			, "<fmt:message key="ANL01003A.venueCount"/>"
			, "<fmt:message key="ANL01003A.payAmt"/>"
			, "<fmt:message key="ANL01003A.planQty_eu"/>"
			, "<fmt:message key="ANL01003A.euRate"/>"
		];
		
		table.setParameter("templateFile", "ANL01003A");
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
		"<fmt:message key="ANL01003A.rageSphereCD"/>"
		, "<fmt:message key="ANL01003A.officeCD"/>"
		, "<fmt:message key="ANL01003A.incntTpCDName"/>"
		, "<fmt:message key="ANL01003A.kindTpCD5Name"/>"
		, "<fmt:message key="ANL01003A.kindTpCD2Name"/>"
		, "<fmt:message key="ANL01003A.venueCount"/>"
		, "<fmt:message key="ANL01003A.payAmt"/>"
		, "<fmt:message key="ANL01003A.planQty_eu"/>"
		, "<fmt:message key="ANL01003A.euRate"/>"
	];

	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
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
	                        , num, num, num, num
	                        ]);
	    grid.setCellEditable(false);
		//footer
		grid.setFooterVisible(true);
		grid.getFooterTemplate().setStyle("border-right", "1px solid threedlightshadow");
		grid.getFooterTemplate().setStyle("font-weight", "bold");
    }
	
</script>