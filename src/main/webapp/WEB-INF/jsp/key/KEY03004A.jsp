<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
						        			<col style="width:300px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:100px;"></col>
						        			<col style="width:100px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
						        			<tr>
						        				<td class="td-cond">
						        					<fmt:message key="KEY03004A.requestDate" />
						        				</td>
						        				<td class="td-input">
													<nis:calendar id="requestDateFrom_S" cssClass="input-readonly" readOnly="yes" /> -
													<nis:calendar id="requestDateTo_S" cssClass="input-readonly" readOnly="yes" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="KEY03004A.requestStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="requestStateCD_S" name="requestStateCD_S" defaultText="all" category="REQUESTSTATECD"/>
												</td>
				                                <td class="td-cond">
													<fmt:message key="KEY03004A.keymanNm" />
												</td>
												<td class="td-input">
													<input type="text" id="keymanNm_S" style="width:100px;">
				                                </td>
						        			</tr>
						        			<tr>
						        				<td class="td-cond">
													<fmt:message key="KEY03004A.venue" />
												</td>
												<td class="td-input">
													<nis:popup id="venue_S" nameID="venueNm_S" keyID="venueCD_S" style="width:100px;" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="KEY03004A.appYN" />
												</td>
												<td class="td-input">
													<nis:selectbox id="appYN_S" name="appYN_S" defaultText="all" category="APPYN" />
												</td>
												<td class="td-cond">
													<fmt:message key="KEY03004A.contractYN" />
												</td>
												<td class="td-input">
													<nis:selectbox id="contractYN_S" name="contractYN_S" defaultText="all" category="CONTRACTYN"/>
												</td>
						        			</tr>
						        			<tr>
						        				<td class="td-cond" >
													<fmt:message key="KEY03004A.phoneNo" />
												</td>
												<td class="td-input" colspan="5">
													<input type="text" id="phoneNo_S" style="width:100px;">
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
				        <nis:paging id="grid" titleDisable="no" callback="PagingSearch()" />
				    </td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 30px; text-align:center;}
	.aw-column-1 {width: 80px; text-align:center;}
    .aw-column-2 {width: 90px; text-align:center;}
    .aw-column-3 {width: 80px; text-align:center;}
    .aw-column-4 {width: 100px; text-align:center;}
    .aw-column-5 {width: 100px; text-align:center;}
    .aw-column-6 {width: 150px; text-align:left;}
    .aw-column-7 {width: 90px; text-align:center;}
    .aw-column-8 {width: 90px; text-align:center;}
    .aw-column-9 {width: 90px; text-align:center;}
    .aw-column-10 {width: 100px; text-align:center;}
    .aw-column-11 {width: 120px; text-align:center;}
    .aw-column-12 {width: 70px; text-align:center;}
    .aw-column-13 {width: 60px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script type="text/javascript">
	/****************************************
	 * Variable
 	 ****************************************/
 
	/****************************************
	 * Function
	 ****************************************/
	$(document).ready(function() {

		window.onload = function() {
			$("#grid_displayNum").val("100");
		
			createGrid();
			grid.refresh();
		
			$("#requestDateFrom_S").val("${params.firstDate}");
			$("#requestDateTo_S").val("${params.currentDate}");
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
	var _i = 0;
	var _col = {
		checkBox : _i++
		, requestDate : _i++
		, requestStateCDNm : _i++
		, keymanNm : _i++
		, appID : _i++
		, phoneNo : _i++
		, venueNm : _i++
		, appYN : _i++
		, personInfoAgreeYN : _i++
		, infoGatherAgreeYN : _i++
		, promotionEventAgreeYN : _i++
		, consignmentAgreeYN : _i++
		, ownerKeymanAgreeYN : _i++
		, contractYN : _i++
		, count : _i++
	};
	
	function Search() {
		$("#grid_pageNum").val("1");
		PagingSearch();
		
	}
	
	function PagingSearch() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/KEY0300401S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;requestDate;requestStateCDNm;keymanNm;appID;"+
	  			"phoneNo;venueNm;appYN;personInfoAgreeYN;infoGatherAgreeYN;"+
	  			"promotionEventAgreeYN;consignmentAgreeYN;ownerKeymanAgreeYN;contractYN;count;"+
	  			"rowNum;totalCount;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;");
	  	table.setParameter("requestDateFrom", convertDate($("#requestDateFrom_S").val()));
	  	table.setParameter("requestDateTo", convertDate($("#requestDateTo_S").val()));
	  	table.setParameter("requestStateCD", $("#requestStateCD_S").val());
	  	table.setParameter("keymanNm", $("#keymanNm_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
	  	table.setParameter("appYN", $("#appYN_S").val());
	  	table.setParameter("contractYN", $("#contractYN_S").val());
	  	table.setParameter("phoneNo", $("#phoneNo_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	//Paging Parameter - START
		table.setParameter("pageNum", $("#grid_pageNum").val());
        table.setParameter("displayNum", $("#grid_displayNum").val());
        //Paging Parameter - END
	  	table.request();
      	
	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
      			      ""     
					, formatDate(table.getData(_col.requestDate,i))
					, table.getData(_col.requestStateCDNm,i)
					, table.getData(_col.keymanNm,i)
      			    , table.getData(_col.appID,i)
					, table.getData(_col.phoneNo,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.appYN,i)
					, table.getData(_col.personInfoAgreeYN,i)
					, table.getData(_col.infoGatherAgreeYN,i)
					, table.getData(_col.promotionEventAgreeYN,i)
					, table.getData(_col.consignmentAgreeYN,i)
					, table.getData(_col.ownerKeymanAgreeYN,i)
					, table.getData(_col.contractYN,i)
					, table.getData(_col.count,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      		
      	//Paging Function: setPageInfo(Grid Name, beginRowNum, endRowNum, totalCount);
            setPageInfo('grid', table.getData(15, 0), table.getData(15, rowCount - 1), table.getData(16, 0));
      	} else {
      		message("<fmt:message key="info.nullData"/>");
      	}
      	grid.refresh();
	}
	
	function SmsReSend(){
		var appIDs = new Array();
		var phoneNos = new Array();
		var counts = new Array();
		var chkCnt = 0;
		var table = new AW.XML.Table;
		
		for (var i = 0; i < grid.getRowCount(); i++) {
			if (grid.getCellValue(_col.checkBox, i)) {
					appIDs.push(grid.getCellValue(_col.appID, i));
					phoneNos.push(grid.getCellValue(_col.phoneNo, i));
					counts.push(grid.getCellValue(_col.count, i));
					chkCnt++;
			}
		}
		
		if(chkCnt!=0){
			showLoading();
			table.setURL("${contextPath}/service/key03/smsSend");
			table.setAsync(false);
			table.setRequestMethod("POST");

			table.setParameter("appIDs", appIDs);
			table.setParameter("phoneNos", phoneNos);
			table.setParameter("counts", counts);
			
			if(confirm("선택한 고객에게 SMS를 재전송하시겠습니까?")){
			table.request();
			}else{
				return false;
				hideLoading();
			}
		}else{
			alert("<fmt:message key='KEY03004A.msg1' />");
			return false;
		}
		
		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
		hideLoading();
	}
	
	var columns = [
		""
	    , "<fmt:message key="KEY03004A.requestDate"/>"
	    , "<fmt:message key="KEY03004A.requestStateCD"/>"
	    , "<fmt:message key="KEY03004A.keymanNm"/>"
	    , "<fmt:message key="KEY03004A.appID"/>"
	    , "<fmt:message key="KEY03004A.phoneNo"/>"
	    , "<fmt:message key="KEY03004A.venueNm"/>"
	    , "<fmt:message key="KEY03004A.appYN"/>"
	    , "<fmt:message key="KEY03004A.personInfoAgreeYN"/>"
	    , "<fmt:message key="KEY03004A.infoGatherAgreeYN"/>"
	    , "<fmt:message key="KEY03004A.promotionEventAgreeYN"/>"
	    , "<fmt:message key="KEY03004A.consignmentAgreeYN"/>"
	    , "<fmt:message key="KEY03004A.ownerKeymanAgreeYN"/>"
	    , "<fmt:message key="KEY03004A.contractYN"/>"
	    ];

	var grid = null;
	function createGrid() {
		grid = new AW.Grid.Extended;
		grid.setId("grid");
		grid.setRowCount(0);
	     	    
		grid.setStyle("width", "100%");
		grid.setStyle("height", "100%");
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-row");
		grid.setHeaderText(columns);
		for (var i = 0; i < columns.length; i++) {
			grid.getHeaderTemplate(i).setStyle("text-align", "center");
		}
		grid.setColumnCount(columns.length);
		grid.setCellEditable(false);
		grid.setHeaderTemplate(new AW.Templates.CheckBox, 0);
		grid.setCellTemplate(new AW.Templates.CheckBox, 0);
		
		grid.setHeaderHeight(36);
		grid.getHeadersTemplate().setClass("text", "wrap");

		grid.onHeaderClicked = function(event, col) {
			if (col == 0 && this.getHeaderValue(0, 0)) {
				for (var i = 0; i < this.getRowCount(); i++) {
					this.setCellValue(true, 0, i);
				}
			} else if (col == 0 && !this.getHeaderValue(0, 0)) {
				for (var i = 0; i < this.getRowCount(); i++) {
					this.setCellValue(false, 0, i);
				}
			}
			return false;
		};

	}
</script>