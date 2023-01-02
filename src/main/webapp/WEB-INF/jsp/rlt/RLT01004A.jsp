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
													<fmt:message key="RLT01004A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" />
				                                </td>
				                                 <td class="td-cond">
													<fmt:message key="RLT01004A.activity" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="RLT01004A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
				                                </td>
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="RLT01004A.subSegmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="segmentCD_S" name="segmentCD_S" defaultText="all" category="SEGMENTCD" event="onchange" eventproc="getSubSegment(this.value);" />
				                                </td>
				                                <td class="td-cond-required">
													<fmt:message key="RLT01004A.subSegmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="subSegmentCD_S" name="subSegmentCD_S" defaultText="all" category="SUBSEGMENTCD" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT01004A.overGuidAmt" />
												</td>
												<td class="td-input">
				                                	<select id="overGuidAmt_S" name="overGuidAmt_S">
				                                     	<option value=""><fmt:message key="all"/></option>
				                                     	<option value="Y">Y</option>
													</select>
				                                </td>
				                            </tr>
				                            <tr>
				                            	<td class="td-cond">
													<fmt:message key="RLT01004A.addrTpCD1" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT01004A.addrTpCD2" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="RLT01004A.kindTpCD5" />
												</td>
												<td class="td-input">
													<nis:selectbox id="kindTpCD5_S" name="kindTpCD5_S" defaultText="all" category="KINDTPCD5" />
				                                </td>
				                            </tr>
				                            <tr>    
												<td class="td-cond">
													<fmt:message key="RLT01004A.apprStateCD" />
												</td>
												<td class="td-input" colspan="5">
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
			        			<col style="width:60px;"></col>
			        			<col></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="RLT01004A.myAppr" />
									</td>
									<td class="tit_text01">
										<span id="myAppr" />
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
						<input type="hidden" id="selectPrdCD" name="selectPrdCD" />
						<input type="hidden" id="apprTpID" name="apprTpID" value="000000" /><!-- Plan/Result승인라인 -->
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 35px; }
    .aw-column-1 {width: 70px; text-align:center; }
	.aw-column-2 {width: 70px; text-align:center; }
    .aw-column-3 {width: 120px; text-align:left; }
    .aw-column-4 {width: 70px; text-align:center; }
    .aw-column-5 {width: 100px; text-align:left; }
    .aw-column-6 {width: 100px; text-align:left; }
    .aw-column-7 {width: 70px; text-align:center; }
    .aw-column-8 {width: 70px; text-align:center; }
    .aw-column-9 {width: 120px; text-align:center; }
    .aw-column-10 {width: 120px; text-align:left; }
    .aw-column-11 {width: 60px; text-align:right;}
    .aw-column-12 {width: 70px; text-align:right;}
    .aw-column-13 {width: 60px; text-align:center;}
    .aw-column-14 {width: 70px; text-align:right;}
    .aw-column-15 {width: 70px; text-align:right;}
    .aw-column-16 {width: 70px; text-align:right;}
    .aw-column-17 {width: 80px; text-align:left;}
    .aw-column-18 {width: 80px; text-align:right;}
    .aw-column-19 {width: 80px; text-align:right;}
    .aw-column-20 {width: 80px; text-align:right;}
    .aw-column-21 {width: 80px; text-align:right;}
    .aw-column-22 {width: 80px; text-align:right;}
	.aw-column-23 {width: 70px; text-align:center;}
    .aw-column-24 {width: 70px; text-align:right;}
    .aw-column-25 {width: 70px; text-align:right;}
    .aw-column-26 {width: 70px; text-align:center;}
    .aw-column-27 {width: 120px; text-align:left;}
    .aw-column-28 {width: 70px; text-align:center;}

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
		table.setParameter("planResultTpCD", "02");		//01:plan,02:result
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
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i = 0;
	var _col = {
		checkbox : _i++
		, activityCDName : _i++
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, segmentCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD1Name : _i++
		, addrTpCD2Name : _i++
		, kindTpCD5Name : _i++
		, prdNm : _i++
		, eu : _i++
		, factoryPrice : _i++
		, qtyUnitCDName : _i++
		, planQty : _i++
		, planUnitAmt : _i++
		, rfidQty : _i++
		, resultTpCDName : _i++
		, resultQty : _i++
		, resultUnitAmt : _i++
		, guidAmt : _i++
		, payAmt : _i++
		, targetQty : _i++
		, sdxTpCDName : _i++
		, targetRate : _i++
		, gsvRate : _i++
		, keymanName : _i++
		, commt : _i++
		, apprStateCDName : _i++
		, prdCD : _i++
		, resultTpCD : _i++
		, sdxTpCD : _i++
		, apprStateCD : _i++
		, chgID : _i++
    };
	function Search() {
		getResultWriteYN();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/RLT0100401S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;activityCDName;venueCD;venueNm;venueGradCDName;segmentCDName;"+
	  			"subSegmentCDName;addrTpCD1Name;addrTpCD2Name;kindTpCD5Name;prdNm;"+
	  			"eu;factoryPrice;qtyUnitCDName;planQty;planUnitAmt;"+
	  			"rfidQty;resultTpCDName;resultQty;resultUnitAmt;guidAmt;"+
	  			"payAmt;targetQty;sdxTpCDName;targetRate;gsvRate;"+
	  			"keymanName;commt;apprStateCDName;prdCD;"+
	  			"resultTpCD;sdxTpCD;apprStateCD;chgID;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"num5;num;str;num;num;"+
	  			"num;str;num;num;num;"+
	  			"num;num5;str;num;num;"+
	  			"str;str;str;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("overGuidAmt", $("#overGuidAmt_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("kindTpCD5", $("#kindTpCD5_S").val());
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
          			apprStateCDName = "<a href=\"javascript:openApprState('"+i+"');\">"+table.getData(_col.apprStateCDName,i)+"</a>";
          		}
      			
      			data[i] = [
					table.getData(_col.checkbox,i)
					, table.getData(_col.activityCDName,i)
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.segmentCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD1Name,i)
					, table.getData(_col.addrTpCD2Name,i)
					, table.getData(_col.kindTpCD5Name,i)
					, table.getData(_col.prdNm,i)
					, table.getData(_col.eu,i)
					, table.getData(_col.factoryPrice,i)
					, table.getData(_col.qtyUnitCDName,i)
					, table.getData(_col.planQty,i)
					, table.getData(_col.planUnitAmt,i)
					, table.getData(_col.rfidQty,i)
					, table.getData(_col.resultTpCDName,i)
					, table.getData(_col.resultQty,i)
					, table.getData(_col.resultUnitAmt,i)
					, table.getData(_col.guidAmt,i)
					, table.getData(_col.payAmt,i)
					, table.getData(_col.targetQty,i)
					, table.getData(_col.sdxTpCDName,i)
					, table.getData(_col.targetRate,i)
					, table.getData(_col.gsvRate,i)
					, table.getData(_col.keymanName,i)
					, table.getData(_col.commt,i)
					, apprStateCDName
					, table.getData(_col.prdCD,i)
					, table.getData(_col.resultTpCD,i)
					, table.getData(_col.sdxTpCD,i)
					, table.getData(_col.apprStateCD,i)
					, table.getData(_col.chgID,i)
      			];
				
      			var resultUnitAmt = parseInt(unformat(table.getData(_col.resultUnitAmt,i)));
      			var guidAmt = parseInt(unformat(table.getData(_col.guidAmt,i)));
      			if(resultUnitAmt > guidAmt) {
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("background", "");
      				grid.getCellTemplate(_col.resultUnitAmt, i).setStyle("color", "");
      			}

      			var sdxTpCD = table.getData(_col.sdxTpCD,i);
      			if(sdxTpCD == "3LT") {
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("background", "");
      				grid.getCellTemplate(_col.sdxTpCDName, i).setStyle("color", "");
      			}
      			
      			var targetRate = parseInt(unformat(table.getData(_col.targetRate,i)));
      			if(targetRate < 70 || targetRate > 150) {
      				grid.getCellTemplate(_col.targetRate, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.targetRate, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.targetRate, i).setStyle("background", "");
      				grid.getCellTemplate(_col.targetRate, i).setStyle("color", "");
      			}
      			
      			var gsvRate = parseInt(unformat(table.getData(_col.gsvRate,i)));
      			if(gsvRate > 30) {
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "#ff0000");
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "#ffffff");
      			} else {
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("background", "");
      				grid.getCellTemplate(_col.gsvRate, i).setStyle("color", "");
      			}
      			if(table.getData(_col.chgID,i) != ""){
      				grid.getCellTemplate(_col.activityCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.venueCD,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.venueNm,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.venueGradCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.addrTpCD1Name,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.addrTpCD2Name,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.segmentCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.subSegmentCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.kindTpCD5Name,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.prdNm,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.eu,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.factoryPrice,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.qtyUnitCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.planQty,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.planUnitAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.rfidQty,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.resultTpCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.resultQty,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.resultUnitAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.guidAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.payAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.commt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.targetQty,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.sdxTpCDName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.targetRate,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.payAmt,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.keymanName,i).setStyle("font-weight", "bold");
      				grid.getCellTemplate(_col.commt,i).setStyle("font-weight", "bold");
          		}
			}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
	
	function openApprState(i) {
		$("#selectVenueCD").val(grid.getCellText(_col.venueCD,i));
      	$("#selectPrdCD").val(grid.getCellText(_col.prdCD,i));
      	
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=RLT01003B"
				+"&eventYM="+$("#yearCD_S").val()+$("#monthCD_S").val()
				+"&venueCD="+$("#selectVenueCD").val()
				+"&prdCD="+$("#selectPrdCD").val()
				+"&apprTpID="+$("#apprTpID").val();
		
		newWindow(url, "RLT01003B",600,350,"yes");
	}
	
	function RequestApp() {
		if($("#myAppr").text() == "") {
			alert("<fmt:message key="RLT01004A.msg1"/>");
			return;
		}
	
		var index = grid.getRowIndices();
		if (index == ""){
			index = new Array();
			for (var i = 0; i < grid.getRowCount(); i++){
				index[i] = i;
			}
		}
		
		var venueCDs = new Array();
		var prdCDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				prdCDs[count] = grid.getCellText(_col.prdCD, index[i]);
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
					alert("<fmt:message key="RLT01004A.msg2"/>");
					return;
				}
				if (grid.getCellText(_col.keymanName, index[i]) == "") {alert("<fmt:message key="RLT01004A.msg6" />"); setCellFocus(grid, _col.keymanName, index[i]); return;}
			}
		}
		
		if(!confirm("<fmt:message key="RLT01004A.msg3"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt01/requestAppResultBrand");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("apprStateCD", "20");
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("apprTpID", $("#apprTpID").val());
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
		
		var venueCDs = new Array();
		var prdCDs = new Array();
		var count = 0;
		for (var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				venueCDs[count] = grid.getCellText(_col.venueCD, index[i]);
				prdCDs[count] = grid.getCellText(_col.prdCD, index[i]);
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
					alert("<fmt:message key="RLT01004A.msg4"/>");
					return;
				}
			}
		}
		
		if(!confirm("<fmt:message key="RLT01004A.msg5"/>")) {
       		return;
       	}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/rlt01/clearRequestAppResultBrand");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("apprStateCD", "10");
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("prdCDs", prdCDs);
		table.setParameter("apprTpID", $("#apprTpID").val());
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
		table.setParameter("queryKey", "RLT0100401S");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.setParameter("overGuidAmt", $("#overGuidAmt_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("kindTpCD5", $("#kindTpCD5_S").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
		
		var headerText = [
			"<fmt:message key="RLT01004A.activity"/>"
			, "<fmt:message key="RLT01004A.venueCD"/>"
			, "<fmt:message key="RLT01004A.venueNm"/>"
			, "<fmt:message key="RLT01004A.venueGradCD"/>"
			, "<fmt:message key="RLT01004A.segmentCD"/>"
			, "<fmt:message key="RLT01004A.subSegmentCD"/>"
			, "<fmt:message key="RLT01004A.addrTpCD1"/>"
			, "<fmt:message key="RLT01004A.addrTpCD2"/>"
			, "<fmt:message key="RLT01004A.kindTpCD5"/>"
			, "<fmt:message key="RLT01004A.prdNm"/>"
			, "<fmt:message key="RLT01004A.eu"/>"
			, "<fmt:message key="RLT01004A.factoryPrice"/>"
			, "<fmt:message key="RLT01004A.qtyUnitCD"/>"
			, "<fmt:message key="RLT01004A.planQty"/>"
			, "<fmt:message key="RLT01004A.planUnitAmt"/>"
			, "<fmt:message key="RLT01004A.rfidQty"/>"
			, "<fmt:message key="RLT01004A.resultTpCD"/>"
			, "<fmt:message key="RLT01004A.resultQty"/>"
			, "<fmt:message key="RLT01004A.resultUnitAmt"/>"
			, "<fmt:message key="RLT01004A.guidAmt"/>"
			, "<fmt:message key="RLT01004A.payAmt"/>"
			, "<fmt:message key="RLT01004A.targetQty"/>"
			, "<fmt:message key="RLT01004A.sdxTpCD"/>"
			, "<fmt:message key="RLT01004A.targetRate"/>"
			, "<fmt:message key="RLT01004A.gsvRate"/>"
			, "<fmt:message key="RLT01004A.keymanID"/>"
			, "<fmt:message key="RLT01004A.commt"/>"
			, "<fmt:message key="RLT01004A.apprStateCD"/>"
		];
		
		table.setParameter("templateFile", "RLT01004A");
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
		, "<fmt:message key="RLT01004A.activity"/>"
       	, "<fmt:message key="RLT01004A.venueCD"/>"
		, "<fmt:message key="RLT01004A.venueNm"/>"
		, "<fmt:message key="RLT01004A.venueGradCD"/>"
		, "<fmt:message key="RLT01004A.segmentCD"/>"
		, "<fmt:message key="RLT01004A.subSegmentCD"/>"
		, "<fmt:message key="RLT01004A.addrTpCD1"/>"
		, "<fmt:message key="RLT01004A.addrTpCD2"/>"
		, "<fmt:message key="RLT01004A.kindTpCD5"/>"
		, "<fmt:message key="RLT01004A.prdNm"/>"
		, "<fmt:message key="RLT01004A.eu"/>"
		, "<fmt:message key="RLT01004A.factoryPrice"/>"
		, "<fmt:message key="RLT01004A.qtyUnitCD"/>"
		, "<fmt:message key="RLT01004A.planQty"/>"
		, "<fmt:message key="RLT01004A.planUnitAmt"/>"
		, "<fmt:message key="RLT01004A.rfidQty"/>"
		, "<fmt:message key="RLT01004A.resultTpCD"/>"
		, "<fmt:message key="RLT01004A.resultQty"/>"
		, "<fmt:message key="RLT01004A.resultUnitAmt"/>"
		, "<fmt:message key="RLT01004A.guidAmt"/>"
		, "<fmt:message key="RLT01004A.payAmt"/>"
		, "<fmt:message key="RLT01004A.targetQty"/>"
		, "<fmt:message key="RLT01004A.sdxTpCD"/>"
		, "<fmt:message key="RLT01004A.targetRate"/>"
		, "<fmt:message key="RLT01004A.gsvRate"/>"
		, "<fmt:message key="RLT01004A.keymanID"/>"
		, "<fmt:message key="RLT01004A.commt"/>"
		, "<fmt:message key="RLT01004A.apprStateCD"/>"
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
						str, str, str, str, str, str, str, str, str, str
						, str, str, str, str, str, str, str, str, str, str
						, str, str, str, str, str, str, str, str, html]);
	    grid.setCellEditable(false);
	    grid.setFixedLeft(5);
	    
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
		};
		
    }
	
</script>