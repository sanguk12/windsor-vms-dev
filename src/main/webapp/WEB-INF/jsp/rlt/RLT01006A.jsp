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
													<fmt:message key="RLT01006A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PLN01008A.apprType" />
												</td>
												<td class="td-input">
													<nis:selectbox id="apprType_S" name="apprType_S" defaultText="all" query="SYS0001S" paramkey="codeDiv;attrib02;" paramvalue="APPRTYPE;result;" style="height:17px;" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT01006A.activityCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="RLT01006A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="RLT01006A.segmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="segmentCD_S" name="segmentCD_S" defaultText="all" category="SEGMENTCD" event="onchange" eventproc="getSubSegment(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT01006A.subSegmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="subSegmentCD_S" name="subSegmentCD_S" defaultText="all" category="SUBSEGMENTCD" />
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="RLT01006A.addrTpCD1" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT01006A.addrTpCD2" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="RLT01006A.apprStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="all" category="APPRSTATECD" />
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
                		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                			<colgroup>
			        			<col style="width:100px;"></col>
			        			<col></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="RLT01006A.myAppr" />
									</td>
									<td class="tit_text01">
										<span id="myAppr" /></span>
										&nbsp&nbsp&nbsp
										<fmt:message key="RLT01006A.myAppr_Normal" />
										<span id="myAppr_Normal" /></span>
	                                </td>
	                            </tr>
			        		</tbody>
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
						<input type="hidden" id="resultWriteYN" name="resultWriteYN" />
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="diffNo" name="diffNo" value="9" /><!-- G1 -->
						<input type="hidden" id="apprTpID" name="apprTpID" value="000000" /><!-- Plan/Result 승인라인 -->
						<input type="hidden" id="apprTpID_Normal" name="apprTpID_Normal" value="000004" /><!-- Result Normal 승인라인 -->
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 35px; text-align:center;}
	.aw-column-1 {width: 85px; text-align:center;}
	.aw-column-2 {width: 70px; text-align:center;}
    .aw-column-3 {width: 100px; text-align:left;}
    .aw-column-4 {width: 100px; text-align:center;}
    .aw-column-5 {width: 150px; text-align:left;}
    .aw-column-6 {width: 70px; text-align:center;}
    .aw-column-7 {width: 100px; text-align:left;}
    .aw-column-8 {width: 100px; text-align:left;}
    .aw-column-9 {width: 70px; text-align:center;}
    .aw-column-10 {width: 100px; text-align:center;}
    .aw-column-11 {width: 100px; text-align:right;}
    .aw-column-12 {width: 100px; text-align:right;}
    .aw-column-13 {width: 100px; text-align:right;}
    .aw-column-14 {width: 80px; text-align:center;}
    .aw-column-15 {width: 80px; text-align:right;}
    .aw-column-16 {width: 80px; text-align:right;}
    .aw-column-17 {width: 100px; text-align:center;}
    .aw-column-18 {width: 80px; text-align:right;}
    .aw-column-19 {width: 90px; text-align:right;}
    .aw-column-20 {width: 90px; text-align:right;}
    .aw-column-21 {width: 60px; text-align:right;}
    .aw-column-22 {width: 150px; text-align:left;}
    .aw-column-23 {width: 100px; text-align:right;}
    .aw-column-24 {width: 80px; text-align:center;}
    
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
			
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			$("#subSegmentCD_S").attr("disabled",true);
    		$("#subSegmentCD_S").addClass("input-readonly");
    		$("#apprStateCD_S").val("10");
    		getResultWriteYN();
			getMyAppr();
		};

		${initScript}

		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
			Search();
		});
	});
	
	//Result작성기간 유무판단
	function getResultWriteYN() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "02");	//01:plan_업소단위,02:result_업소단위,03:plan_브랜드단위,04:result_브랜드단위
		table.request();
		
		if(table.getCount() > 0) {
			$("#resultWriteYN").val(table.getData(0,0));
			if(table.getData(0,0) == "Y") {
				btnRequestApp.setControlDisabled(false);
				btnClearRequestApp.setControlDisabled(false);
			}
			else {
				btnRequestApp.setControlDisabled(true);
				btnClearRequestApp.setControlDisabled(true);
			}
		}
	}
	
	//나의 승인라인가져오기
	function getMyAppr() {
		/* Special 승인라인*/
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03006S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.request();
		
		if(table.getCount() > 0) {
			$("#myAppr").text(table.getData(0,0));
		}
		
		/* Normal 승인라인*/
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03006S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprTpID", $("#apprTpID_Normal").val());
		table.request();
		
		if(table.getCount() > 0) {
			$("#myAppr_Normal").text(table.getData(0,0));
		}
	}
	
	var _col_cd = {
		"code" : 0
		, "name" : 1
	}
	function getSubSegment(code) {
		if(code=="") {
			$("#subSegmentCD_S").val("");
			$("#subSegmentCD_S").attr("disabled",true);
    		$("#subSegmentCD_S").addClass("input-readonly");
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
	  	table.setParameter("languageCD", "${params.languageCD}");
	  	table.setParameter("codeDiv", "SUBSEGMENTCD");
	  	table.setParameter("attrib02", code);
	  	table.request();
     	
     	if(table.getCount() > 0) {
	     	$("#subSegmentCD_S").find("option").remove().end().append('<option value=""><fmt:message key="all"/></option>');
	     	for(var i=0; i<table.getCount(); i++){
	   			if(table.getData(_col_cd.code,i)==code){
	   				$("#subSegmentCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'" checked="true">'+table.getData(_col_cd.name,i)+'</option>');
	   			} else {
	   				$("#subSegmentCD_S").append('<option value="'+table.getData(_col_cd.code,i)+'">'+table.getData(_col_cd.name,i)+'</option>');
	   			}
	   		}
	     	
	     	$("#subSegmentCD_S").attr("disabled",false);
    		$("#subSegmentCD_S").removeClass("input-readonly");
     	}
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		checkbox : _i++
		, apprTypeName : _i++
		, programCDName : _i++
		, activityCDName : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, tpayAmt : _i++
		, resultTQty : _i++
		, avgUnitAmt : _i++
		, resultTpCDName : _i++
		, targetRate : _i++
		, payRate : _i++
		, excPayTpCDName : _i++
		, gsvRate : _i++
		, nsv : _i++
		, gp : _i++
		, gpRate : _i++
		, commt : _i++
		, payAmt_keyman : _i++
		, apprStateCDName : _i++
		, apprStateCD : _i++
		, resultTpCD : _i++
		, guidPayRate : _i++
		, excPayTpCD : _i++
		, activityCD : _i++
		, chgID : _i++
		, apprType : _i++
    };
	function Search() {
		getResultWriteYN();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0100601S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;apprTypeName;programCDName;activityCDName;venueCD;venueNm;"+
	  			"venueGradCDName;segmentCDName;subSegmentCDName;addrTpCD1Name;addrTpCD2Name;"+
	  			"tpayAmt;resultTQty;avgUnitAmt;resultTpCDName;targetRate;"+
	  			"payRate;excPayTpCDName;gsvRate;nsv;gp;gpRate;"+
	  			"commt;payAmt_keyman;apprStateCDName;apprStateCD;resultTpCD;"+
	  			"guidPayRate;excPayTpCD;activityCD;chgID;apprType;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"num;num;num;str;num;"+
	  			"num;str;num;num1;num1;num1;"+
	  			"str;num;str;str;str;"+
	  			"num;str;str;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("apprType", $("#apprType_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			
      			var apprStateCDName = "";
      			if(table.getData(_col.apprStateCD,i) == "10") {
      				apprStateCDName = table.getData(_col.apprStateCDName,i);
          		}
          		else {
          			apprStateCDName = "<a href=\"javascript:openApprState('"+table.getData(_col.venueCD,i)+"','"+table.getData(_col.apprType,i)+"');\">"+table.getData(_col.apprStateCDName,i)+"</a>";
          		}
      			
      			data[i] = [
					""
					, table.getData(_col.apprTypeName,i)
					, table.getData(_col.programCDName,i)
					, table.getData(_col.activityCDName,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.tpayAmt,i)
					, table.getData(_col.resultTQty,i)
					, table.getData(_col.avgUnitAmt,i)
					, table.getData(_col.resultTpCDName,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.payRate,i)
					, table.getData(_col.excPayTpCDName,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.nsv,i)
					, table.getData(_col.gp,i)
					, table.getData(_col.gpRate,i)
					, table.getData(_col.commt,i)
					, table.getData(_col.payAmt_keyman,i)
					, apprStateCDName
					, table.getData(_col.apprStateCD,i)
					, table.getData(_col.resultTpCD,i)
					, table.getData(_col.guidPayRate,i)
					, table.getData(_col.excPayTpCD,i)
					, table.getData(_col.activityCD,i)
					, table.getData(_col.chgID,i)
					, table.getData(_col.apprType,i)
      			];
				
				var gsvRate = Number(table.getData(_col.gsvRate,i));
				var excPayTpCD = table.getData(_col.excPayTpCD,i);
				var guidPayRate = Number(table.getData(_col.guidPayRate,i));
				var payRate = Number(table.getData(_col.payRate,i));
				if(gsvRate > 10) {
					grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "#ffffff");
				}
				if(excPayTpCD == "YPAY") {
					grid.getCellTemplate(_col.excPayTpCDName, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.excPayTpCDName, i).setStyle("color", "#ffffff");
				}
		     	if(payRate > guidPayRate) {
		     		grid.getCellTemplate(_col.payRate, i).setStyle("background", "#ff0000");
					grid.getCellTemplate(_col.payRate, i).setStyle("color", "#ffffff");
		     	}
		     	else if(payRate < guidPayRate) {
		     		grid.getCellTemplate(_col.payRate, i).setStyle("background", "#00ff00");
					grid.getCellTemplate(_col.payRate, i).setStyle("color", "#00000");
		     	}
		     	if(table.getData(_col.chgID,i) != ""){
      				grid.getCellTemplate(_col.apprTypeName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.programCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.activityCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.venueCD,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.venueNm,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.venueGradCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.addrTpCD1Name,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.addrTpCD2Name,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.segmentCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.subSegmentCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.tpayAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.resultTQty,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.avgUnitAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.resultTpCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.targetRate,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.payRate,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.excPayTpCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.gsvRate,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.nsv,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.gp,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.gpRate,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.commt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.payAmt_keyman,i).setStyle("font-weight", "bold");
          		}
			}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
	function openApprState(venueCD,apprType) {
		var apprTpID = null;
		if(apprType == '10') {
			apprTpID = $("#apprTpID_Normal").val();
		} else if (apprType == '30'){
			apprTpID = $("#apprTpID").val();
		}
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01001B"
				+"&eventYM="+$("#yearCD_S").val()+$("#monthCD_S").val()
				+"&venueCD="+venueCD
				+"&diffNo="+$("#diffNo").val()
				+"&apprTpID="+apprTpID
		
		newWindow(url, "RLT01001B",600,350,"yes");
	}
	
	function RequestApp() {
		if($("#myAppr").text() == "" || $("#myAppr_Normal").text() == "") {
			alert("<fmt:message key="RLT01006A.msg1"/>");
			return;
		}
	
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var apprTypes = new Array();
		var venueCDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				apprTypes[count] = grid.getCellText(_col.apprType, index[i]);
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//승인상태가 등록일 경우만 가능
				if(grid.getCellText(_col.apprStateCD, index[i]) != "10") {
					alert("<fmt:message key="RLT01006A.msg2"/>");
					return;
				}
				//선지원(20)이 아닌경우
				if(grid.getCellText(_col.activityCD, index[i]) != "20") {
					var payAmt_keyman = parseFloat(unformat(grid.getCellText(_col.payAmt_keyman, index[i])));
					var tpayAmt = parseFloat(unformat(grid.getCellText(_col.tpayAmt, index[i])));
					if(payAmt_keyman != tpayAmt) {
						setCellFocus(grid, _col.payAmt_keyman, index[i]);
						alert("<fmt:message key="RLT01006A.msg3"/>");
						return;
					}
				}
				//지급율이 가이드금액보다 크거나, 120%초과가 초과분지급이거나, GSV 항목이 붉은색 조건에 해당하는 경우는 Comment항목이 필수
				var payRate = parseFloat(unformat(grid.getCellText(_col.payRate, index[i])));
				var guidPayRate = parseFloat(unformat(grid.getCellText(_col.guidPayRate, index[i])));
				var gsvRate = parseFloat(unformat(grid.getCellText(_col.gsvRate, index[i])));
				if(payRate > guidPayRate || $("#excPayTpCD").val()=="YPAY" || gsvRate > 10) {
					if(grid.getCellText(_col.commt, index[i]) == "") {
						setCellFocus(grid, _col.commt, index[i]);
						alert("<fmt:message key="RLT01006A.msg7"/>");
						return;
					}
				}
			}
		}
		
		if(!confirm("<fmt:message key="RLT01006A.msg4"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt01/requestAppResultVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("apprTpID_Normal", $("#apprTpID_Normal").val());
		table.setParameter("apprStateCD", "20");
		table.setParameter("apprTypes", apprTypes);
		table.setParameter("venueCDs", venueCDs);
		table.request();

		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function ClearRequestApp() {
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var apprTypes = new Array();
		var venueCDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				apprTypes[count] = grid.getCellText(_col.apprType, index[i]);
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				count++;
			}
		}
		
		if(count==0) {
        	alert("<fmt:message key="info.validate.gridSelect"/>");
        	return;
        }
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				//승인상태가 승인요청인 경우만 취소가능
				if(grid.getCellText(_col.apprStateCD, index[i]) != "20") {
					alert("<fmt:message key="RLT01006A.msg5"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="RLT01006A.msg6"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt01/clearRequestAppResultVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("diffNo", $("#diffNo").val());
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("apprTpID_Normal", $("#apprTpID_Normal").val());
		table.setParameter("apprStateCD", "10");
		table.setParameter("apprTypes", apprTypes);
		table.setParameter("venueCDs", venueCDs);
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
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleExport/jxls");
		table.setAsync(false); 
		table.setRequestMethod("POST");
		table.setParameter("queryKey", "RLT0100603S");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("diffNo", $("#diffNo").val());
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	
		var headerText = [
			"<fmt:message key="RLT01006A.programCD"/>"
	   		, "<fmt:message key="RLT01006A.activityCD"/>"
	   		, "<fmt:message key="RLT01006A.venueCD"/>"
	   		, "<fmt:message key="RLT01006A.venueNm"/>"
	   		, "<fmt:message key="RLT01006A.venueGradCD"/>"
	   		, "<fmt:message key="RLT01006A.segmentCD"/>"
	   		, "<fmt:message key="RLT01006A.subSegmentCD"/>"
	   		, "<fmt:message key="RLT01006A.addrTpCD1"/>"
	   		, "<fmt:message key="RLT01006A.addrTpCD2"/>"
	   		, "<fmt:message key="RLT01006A.tpayAmt"/>"
	   		, "<fmt:message key="RLT01006A.resultTQty"/>"
	   		, "<fmt:message key="RLT01006A.avgUnitAmt"/>"
	   		, "<fmt:message key="RLT01006A.resultTpCDName"/>"
	   		, "<fmt:message key="RLT01006A.targetRate"/>"
	   		, "<fmt:message key="RLT01006A.payRate"/>"
	   		, "<fmt:message key="RLT01006A.excPayTpCDName"/>"
	   		, "<fmt:message key="RLT01006A.gsvRate"/>"
	   		, "<fmt:message key="RLT01006A.commt"/>"
	   		, "<fmt:message key="RLT01006A.payAmt_keyman"/>"
	   		, "<fmt:message key="RLT01006A.apprStateCD"/>"
       		, "<fmt:message key="RLT01006A.kindTpCD5"/>"
       		, "<fmt:message key="RLT01006A.prdNm"/>"
       		, "<fmt:message key="RLT01006A.factoryPrice"/>"
       		, "<fmt:message key="RLT01006A.qtyUnitCD"/>"
       		, "<fmt:message key="RLT01006A.planQty"/>"
       		, "<fmt:message key="RLT01006A.resultQty"/>"
       		, "<fmt:message key="RLT01006A.resultUnitAmt"/>"
       		, "<fmt:message key="RLT01006A.payAmt"/>"
       		, "<fmt:message key="PLN01008A.NSV"/>"
    		, "<fmt:message key="PLN01008A.GP"/>"
    		, "<fmt:message key="PLN01008A.GPRate"/>"
		];
		
		table.setParameter("templateFile", "RLT01006A");
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
		""
		, "<fmt:message key="PLN01008A.apprType"/>"
		, "<fmt:message key="RLT01006A.programCD"/>"
		, "<fmt:message key="RLT01006A.activityCD"/>"
   		, "<fmt:message key="RLT01006A.venueCD"/>"
   		, "<fmt:message key="RLT01006A.venueNm"/>"
   		, "<fmt:message key="RLT01006A.venueGradCD"/>"
   		, "<fmt:message key="RLT01006A.segmentCD"/>"
   		, "<fmt:message key="RLT01006A.subSegmentCD"/>"
   		, "<fmt:message key="RLT01006A.addrTpCD1"/>"
   		, "<fmt:message key="RLT01006A.addrTpCD2"/>"
   		, "<fmt:message key="RLT01006A.tpayAmt"/>"
   		, "<fmt:message key="RLT01006A.resultTQty"/>"
   		, "<fmt:message key="RLT01006A.avgUnitAmt"/>"
   		, "<fmt:message key="RLT01006A.resultTpCDName"/>"
   		, "<fmt:message key="RLT01006A.targetRate"/>"
   		, "<fmt:message key="RLT01006A.payRate"/>"
   		, "<fmt:message key="RLT01006A.excPayTpCDName"/>"
   		, "<fmt:message key="RLT01006A.gsvRate"/>"
   		, "<fmt:message key="PLN01008A.NSV"/>"
   		, "<fmt:message key="PLN01008A.GP"/>"
		, "<fmt:message key="PLN01008A.GPRate"/>"
   		, "<fmt:message key="RLT01006A.commt"/>"
   		, "<fmt:message key="RLT01006A.payAmt_keyman"/>"
   		, "<fmt:message key="RLT01006A.apprStateCD"/>"
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
	                        str, str, str, str, str, str
	                        , str, str, str, str, str
	                        , num, num, num, str, num
	                        , num, str, num, num1, num1
	                        , num1, str, num, html
	                        ]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(6);
	    
	    grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellValue(false, _col.checkbox);
		
		grid.setHeaderTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.setCellTemplate(new AW.Templates.CheckBox, _col.checkbox);
		grid.onHeaderClicked=function(event,col){
			if (col == _col.checkbox && this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(true, _col.checkbox);
			}
			else if (col == _col.checkbox && !this.getHeaderValue(_col.checkbox,0)) {
				this.setCellValue(false, _col.checkbox);
			}
			return false;
		};
		
		grid.onRowDoubleClicked = function(event, row){
			$("#selectVenueCD").val(this.getCellText(_col.venueCD,row));
			
	    	var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01006B";
	    	newWindow(url, "RLT01006B",1000,340,"yes");
	    	
		};
		
    }
	
</script>