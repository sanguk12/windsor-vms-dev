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
													<fmt:message key="PLN01001A.eventYM" />
												</td>
												<td class="td-input" colspan="5">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" event="onchange" eventproc="getPlanWriteDate();" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" event="onchange" eventproc="getPlanWriteDate();" />
				                                </td>
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="PLN01001A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="PLN01001A.segmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="segmentCD_S" name="segmentCD_S" defaultText="all" category="SEGMENTCD" event="onchange" eventproc="getSubSegment(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PLN01001A.subSegmentCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="subSegmentCD_S" name="subSegmentCD_S" defaultText="all" category="SUBSEGMENTCD" />
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
										<fmt:message key="PLN01001A.planWriteDate" />
									</td>
									<td class="tit_text01">
										<span id="planWriteDate_S" />
	                                </td>
	                            </tr>
			        		</tbody>
		        		</table>
                	</td>
                </tr>
                <tr>
					<td height="*" valign="top">
						<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
	                   		<tr>
	                   			<td width="40%">
									<span id="grid"></span>
								</td>
								<td width="4%" align="center">
									<img src="${contextPath}/images/ico/btn_arrow_right.gif" onclick="Add();" style="cursor:hand;" alt="<fmt:message key="button.Add" />"><br><br>
									<img src="${contextPath}/images/ico/btn_arrow_left.gif" onclick="Remove();" style="cursor:hand;" alt="<fmt:message key="button.Remove" />">
								</td>
								<td width="*">
									<span id="grid_pln"></span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1">
						<input type="hidden" id="incntTpCD" name="incntTpCD" value="VEN" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid .aw-column-0 {width: 35px; text-align:center;}
	#grid .aw-column-1 {width: 80px; text-align:center;}
    #grid .aw-column-2 {width: 100px; text-align:left;}
    #grid .aw-column-3 {width: 60px; text-align:center;}
    #grid .aw-column-4 {width: 100px; text-align:center;}
    #grid .aw-column-5 {width: 100px; text-align:center;}
    
    #grid_pln .aw-column-0 {width: 35px; text-align:center;}
    #grid_pln .aw-column-1 {width: 80px; text-align:left;}
    #grid_pln .aw-column-2 {width: 120px; text-align:left;}
	#grid_pln .aw-column-3 {width: 80px; text-align:center;}
    #grid_pln .aw-column-4 {width: 100px; text-align:left;}
    #grid_pln .aw-column-5 {width: 60px; text-align:center;}
    #grid_pln .aw-column-6 {width: 100px; text-align:center;}
    #grid_pln .aw-column-7 {width: 100px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	var maxRow = 0;
	var maxRow_pln = 0;
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid();
			grid.refresh();
			
			createGrid_pln();
			grid_pln.refresh();
			
			btnSave.setControlDisabled(true);
			btnCopyLastMonPlanBusi.setControlDisabled(true);
			$("#yearCD_S").val("${params.clientDate}".substring(0,4));
			$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			$("#subSegmentCD_S").attr("disabled",true);
    		$("#subSegmentCD_S").addClass("input-readonly");
			getPlanWriteYN();
			getPlanWriteDate();
		};

		${initScript}
		
		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
			Search();
		});

	});
	
	function getPlanWriteYN() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "01"); //01:plan_업소단위,02:result_업소단위,03:plan_브랜드단위,04:result_브랜드단위
		table.request();
		
		if(table.getCount() > 0) {
			if(table.getData(0,0) == "Y") {
				btnSave.setControlDisabled(false);
				btnCopyLastMonPlanBusi.setControlDisabled(false);
			}
			else {
				btnSave.setControlDisabled(true);
				btnCopyLastMonPlanBusi.setControlDisabled(true);
			}
		}
	}
	
	function getPlanWriteDate() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03002S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "01");	//01:plan_업소단위,02:result_업소단위,03:plan_브랜드단위,04:result_브랜드단위
		table.request();
		
		var s = "";
	  	if (table.getCount() > 0) {
	  		s = "<select id='planWriteDate_S' name='planWriteDate_S'>";
		  	for (var i=0; i < table.getCount(); i++) {
		  		s += "<option>"+table.getData(0,i)+"</option>";
		  	}
	  	}
	  	else {
	  		 s = "<select id='planWriteDate_S' name='planWriteDate_S'><option value=''><fmt:message key="nothing"/></option>";
	  	}
	  	s += "</select>";
	  	$("#planWriteDate_S").html(s);
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
		, venueCD : _i++
		, venueNm : _i++
		, venueGradCDName : _i++
		, subSegmentCDName : _i++
		, addrTpCD2Name : _i++
    };
	function Search() {
		getPlanWriteYN();
		getPlanWriteDate();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/COM03003S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;venueCD;venueNm;venueGradCDName;subSegmentCDName;"+
	  			"addrTpCD2Name;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("incntTpCD", $("#incntTpCD").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
	  	table.request();
      	
// 	  	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
      			    , table.getData(_col.venueCD,i)
					, table.getData(_col.venueNm,i)
					, table.getData(_col.venueGradCDName,i)
					, table.getData(_col.subSegmentCDName,i)
					, table.getData(_col.addrTpCD2Name,i)
      			];
      		}
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
      	
      	maxRow = rowCount;
      	Search_pln();
	}
	
	var _i_pln = 0;
	var _col_pln = {
		checkbox : _i_pln++
		, programCDName : _i_pln++
		, activityCDName : _i_pln++
		, venueCD : _i_pln++
		, venueNm : _i_pln++
		, venueGradCDName : _i_pln++
		, subSegmentCDName : _i_pln++
		, addrTpCD2Name : _i_pln++
		, programCD : _i_pln++
		, activityCD : _i_pln++
		, apprStateCD : _i_pln++
		, apprStateCDName : _i_pln++
		, activeFlg : _i_pln++
    };
	function Search_pln() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0100101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;programCDName;activityCDName;venueCD;venueNm;"+
	  			"venueGradCDName;subSegmentCDName;addrTpCD2Name;programCD;activityCD;"+
	  			"apprStateCD;apprStateCDName;activeFlg;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.request();
      	
// 	  	if (grid_pln != null) grid_pln.clear();
      	createGrid_pln();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
					, table.getData(_col_pln.programCDName,i)
					, table.getData(_col_pln.activityCDName,i)
      			    , table.getData(_col_pln.venueCD,i)
					, table.getData(_col_pln.venueNm,i)
					, table.getData(_col_pln.venueGradCDName,i)
					, table.getData(_col_pln.subSegmentCDName,i)
					, table.getData(_col_pln.addrTpCD2Name,i)
					, table.getData(_col_pln.programCD,i)
					, table.getData(_col_pln.activityCD,i)
					, table.getData(_col_pln.apprStateCD,i)
					, table.getData(_col_pln.apprStateCDName,i)
					, "U"
      			];
      			
      			//선지원일경우
      			if(table.getData(_col_pln.activityCD,i) == "20") {
      				grid_pln.setPopupTemplate(new AW.Templates.Text, _col_pln.programCDName, i);
					grid_pln.setPopupTemplate(new AW.Templates.Text, _col_pln.activityCDName, i);
					grid_pln.getCellTemplate(_col_pln.programCDName, i).setStyle("background", "#ececec");
					grid_pln.getCellTemplate(_col_pln.activityCDName, i).setStyle("background", "#ececec");
      			}
      			//중기약정일경우
      			if(table.getData(_col_pln.activityCD,i) == "50") {
      				grid_pln.setPopupTemplate(new AW.Templates.Text, _col_pln.programCDName, i);
					grid_pln.setPopupTemplate(new AW.Templates.Text, _col_pln.activityCDName, i);
					grid_pln.getCellTemplate(_col_pln.programCDName, i).setStyle("background", "#ececec");
					grid_pln.getCellTemplate(_col_pln.activityCDName, i).setStyle("background", "#ececec");
      			}
      			/*	plan승인처리가 등록, 반려가 아닌경우에는 수정 불가
      				(10:등록, 40:반려)
      			*/
      			var apprStateCD = table.getData(_col_pln.apprStateCD,i);
				if(apprStateCD!="10" && apprStateCD!="40") {
					grid_pln.setPopupTemplate(new AW.Templates.Text, _col_pln.programCDName, i);
					grid_pln.setPopupTemplate(new AW.Templates.Text, _col_pln.activityCDName, i);
					grid_pln.getCellTemplate(_col_pln.programCDName, i).setStyle("background", "#ececec");
					grid_pln.getCellTemplate(_col_pln.activityCDName, i).setStyle("background", "#ececec");
				}
      		}
      		grid_pln.setCellData(data);
      		grid_pln.setRowCount(rowCount);
      	}
      	grid_pln.refresh();
      	
      	maxRow_pln = rowCount;
	}
	
	function Add() {
		message("<fmt:message key="PLN01001A.msg5" />");
		
		showLoading();
		window.setTimeout(function() {
			ActionAdd();
			hideLoading();
		}, 700);
	}
	
	function ActionAdd() {
		var index = grid.getRowIndices();
		if (index == "") {
			index = new Array();
			for (var i = 0; i < maxRow; i++) {
				index[i] = i;
			}
		}
		
		for(var i=0; i<index.length; i++) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				grid_pln.addRow(maxRow_pln++);
				grid_pln.setCellText(grid.getCellText(_col.venueCD, index[i]), _col_pln.venueCD, maxRow_pln-1);
				grid_pln.setCellText(grid.getCellText(_col.venueNm, index[i]), _col_pln.venueNm, maxRow_pln-1);
				
				//선지원이 해당되는지 체크
				var table = new AW.XML.Table;
			  	table.setURL("${contextPath}/service/simpleAction/COM03004S");
			  	table.setAsync(false);
			  	table.setRequestMethod("POST");
			  	table.setParameter("venueCD", grid.getCellText(_col.venueCD, index[i]));
			  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
			  	table.request();
				if(table.getData(0,0) == "Y") {
					grid_pln.setCellText("G1", _col_pln.programCDName, maxRow_pln-1);
					grid_pln.setCellText("G1", _col_pln.programCD, maxRow_pln-1);
					grid_pln.setPopupTemplate(new AW.Templates.Text, _col_pln.programCDName, maxRow_pln-1);
					grid_pln.getCellTemplate(_col_pln.programCDName, maxRow_pln-1).setStyle("background", "#ececec");
					
					grid_pln.setCellText("<fmt:message key="PLN01001A.activityCD_20" />", _col_pln.activityCDName, maxRow_pln-1);
					grid_pln.setCellText("20", _col_pln.activityCD, maxRow_pln-1);
					grid_pln.setPopupTemplate(new AW.Templates.Text, _col_pln.activityCDName, maxRow_pln-1);
					grid_pln.getCellTemplate(_col_pln.activityCDName, maxRow_pln-1).setStyle("background", "#ececec");
				}
				else {
					//default activityCD(10:Account Plan)
					grid_pln.setCellText("G1", _col_pln.programCDName, maxRow_pln-1);
					grid_pln.setCellText("G1", _col_pln.programCD, maxRow_pln-1);
					
					grid_pln.setCellText("<fmt:message key="PLN01001A.activityCD_10" />", _col_pln.activityCDName, maxRow_pln-1);
					grid_pln.setCellText("10", _col_pln.activityCD, maxRow_pln-1);
				}
				
				grid_pln.setCellText(grid.getCellText(_col.venueGradCDName, index[i]), _col_pln.venueGradCDName, maxRow_pln-1);
				grid_pln.setCellText(grid.getCellText(_col.subSegmentCDName, index[i]), _col_pln.subSegmentCDName, maxRow_pln-1);
				grid_pln.setCellText(grid.getCellText(_col.addrTpCD2Name, index[i]), _col_pln.addrTpCD2Name, maxRow_pln-1);
				grid_pln.setCellText("I", _col_pln.activeFlg, maxRow_pln-1);
			}
		}
		
		for(var i=index.length-1; i >= 0; i--) {
			if (grid.getCellValue(_col.checkbox, index[i])) {
				grid.deleteRow(index[i]);
			}
		}
	}

	function Remove(){
		message("<fmt:message key="PLN01001A.msg6" />");
		
		var index_pln = grid_pln.getRowIndices();
		if (index_pln == ""){
			index_pln = new Array();
			for (var i = 0; i < maxRow_pln; i++){
				index_pln[i] = i;
			}
		}
		
		for(var i=0; i<index_pln.length; i++) {
			if (grid_pln.getCellValue(_col_pln.checkbox, index_pln[i])) {
				
				/*	plan승인처리가 미등록, 등록, 반려가 아닌경우에는 삭제 불가
  					(10:등록, 40:반려)
  				*/
				var venueCD = grid_pln.getCellText(_col_pln.venueCD, index_pln[i]);
				var apprStateCD = grid_pln.getCellText(_col_pln.apprStateCD, index_pln[i]);
				var apprStateCDName = grid_pln.getCellText(_col_pln.apprStateCDName, index_pln[i]);
				var activityCD = grid_pln.getCellText(_col_pln.activityCD, index_pln[i]);
				if(apprStateCD!="" && apprStateCD!="10" && apprStateCD!="40") {
					alert("<fmt:message key="PLN01001A.msg1"><fmt:param value='"+venueCD+"' /><fmt:param value='"+apprStateCDName+"' /></fmt:message>");
					return;
				}
				if(activityCD=="50") {
					alert("<fmt:message key="PLN01001A.msg7" />");
					return;
				}
				
			}
		}
		
		for(var i=0; i<index_pln.length; i++) {
			if (grid_pln.getCellValue(_col_pln.checkbox, index_pln[i])) {
				grid.addRow(maxRow++);
				grid.setCellText(grid_pln.getCellText(_col_pln.venueCD, index_pln[i]), _col.venueCD, maxRow-1);
				grid.setCellText(grid_pln.getCellText(_col_pln.venueNm, index_pln[i]), _col.venueNm, maxRow-1);
				grid.setCellText(grid_pln.getCellText(_col_pln.venueGradCDName, index_pln[i]), _col.venueGradCDName, maxRow-1);
				grid.setCellText(grid_pln.getCellText(_col_pln.subSegmentCDName, index_pln[i]), _col.subSegmentCDName, maxRow-1);
				grid.setCellText(grid_pln.getCellText(_col_pln.addrTpCD2Name, index_pln[i]), _col.addrTpCD2Name, maxRow-1);
			}
		}
		
		for(var i=index_pln.length-1; i >= 0; i--) {
			if (grid_pln.getCellValue(_col_pln.checkbox, index_pln[i])) {
				grid_pln.setCellText("D", _col_pln.activeFlg, index_pln[i]);
				grid_pln.deleteRow(index_pln[i]);
			}
		}
	}

	
	function Save() {
		if(maxRow_pln == 0) {
			alert("<fmt:message key="info.validate.gridSelect"/>");
			return;
		}
		
		var venueCDs = new Array();
		var programCDs = new Array();
		var activityCDs = new Array();
		var activeFlgs = new Array();
		var count = 0;
		for (var i=0; i<maxRow_pln; i++) {
			if(grid_pln.getCellText(_col_pln.activeFlg, i)!="D") {
				if (grid_pln.getCellText(_col_pln.programCD, i) == "") {alert("<fmt:message key="PLN01001A.msg2" />"); setCellFocus(grid_pln, _col_pln.programCDName, i); return;}
				if (grid_pln.getCellText(_col_pln.activityCD, i) == "") {alert("<fmt:message key="PLN01001A.msg3" />"); setCellFocus(grid_pln, _col_pln.activityCDName, i); return;}
			}
			venueCDs[count] = grid_pln.getCellText(_col_pln.venueCD, i);
			programCDs[count] = grid_pln.getCellText(_col_pln.programCD, i);
			activityCDs[count] = grid_pln.getCellText(_col_pln.activityCD, i);
			activeFlgs[count] = grid_pln.getCellText(_col_pln.activeFlg, i);
			count++;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln01/savePlanVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("incntTpCD", $("#incntTpCD").val());
		table.setParameter("venueCDs", venueCDs);
		table.setParameter("programCDs", programCDs);
		table.setParameter("activityCDs", activityCDs);
		table.setParameter("activeFlgs", activeFlgs);
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
		table.setParameter("queryKey", "PLN0100101S");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("segmentCD", $("#segmentCD_S").val());
	  	table.setParameter("subSegmentCD", $("#subSegmentCD_S").val());
		
		var headerText = [
			"<fmt:message key="PLN01001A.programCDName"/>"
			, "<fmt:message key="PLN01001A.activityCDName"/>"
			, "<fmt:message key="PLN01001A.venueCD"/>"
			, "<fmt:message key="PLN01001A.venueNm"/>"
			, "<fmt:message key="PLN01001A.venueGradCDName"/>"
			, "<fmt:message key="PLN01001A.subSegmentCDName"/>"
			, "<fmt:message key="PLN01001A.addrTpCD2Name"/>"
		];
		
		table.setParameter("templateFile", "PLN01001A");
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
	
	function CopyLastMonPlanBusi() {
		if(!confirm("<fmt:message key="PLN01001A.msg4"/>")) {
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln01/copyBefMonPlanVenue");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("empID", "${params.empID}");
		table.setParameter("incntTpCD", $("#incntTpCD").val());
		table.request();
		
		if(table.getData(0,0) == "S") {
			message(table.getData(1,0));
			Search();
   		}
		else {
			alert(table.getData(1,0));
		}
	}


	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns = [
		""
		, "<fmt:message key="PLN01001A.venueCD"/>"
		, "<fmt:message key="PLN01001A.venueNm"/>"
		, "<fmt:message key="PLN01001A.venueGradCDName"/>"
		, "<fmt:message key="PLN01001A.subSegmentCDName"/>"
		, "<fmt:message key="PLN01001A.addrTpCD2Name"/>"
	];
	var grid = null;
	function createGrid() {
		grid = new AW.UI.Grid;
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
	                        ]);
	    grid.setCellEditable(false);
	    
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
		
    }
	
	var columns_pln = [
		""
		, "<fmt:message key="PLN01001A.programCDName"/>"
		, "<fmt:message key="PLN01001A.activityCDName"/>"
		, "<fmt:message key="PLN01001A.venueCD"/>"
		, "<fmt:message key="PLN01001A.venueNm"/>"
		, "<fmt:message key="PLN01001A.venueGradCDName"/>"
		, "<fmt:message key="PLN01001A.subSegmentCDName"/>"
		, "<fmt:message key="PLN01001A.addrTpCD2Name"/>"
	];
	var grid_pln = null;
	function createGrid_pln() {
		grid_pln = new AW.UI.Grid;
	    grid_pln.setId("grid_pln");
	    grid_pln.setRowCount(0);
	    grid_pln.setStyle("width","100%");
	    grid_pln.setStyle("height","100%");
	    grid_pln.setSelectorVisible(false);
	    grid_pln.setSelectionMode("single-cell");
	    grid_pln.setHeaderText(columns_pln);
	    for(var i=0;i<columns_pln.length;i++){grid_pln.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_pln.setColumnCount(columns_pln.length);
	    grid_pln.setCellFormat([
	                        str, str, str, str, str
	                        , str, str]);
	    grid_pln.setCellEditable(false);
	    
	    grid_pln.setCellTemplate(new AW.Templates.CheckBox, _col_pln.checkbox);
		grid_pln.setCellValue(false, _col_pln.checkbox);
		
		grid_pln.setHeaderTemplate(new AW.Templates.CheckBox, _col_pln.checkbox);
		grid_pln.setCellTemplate(new AW.Templates.CheckBox, _col_pln.checkbox);
		grid_pln.onHeaderClicked=function(event,col){
			if (col == _col_pln.checkbox && this.getHeaderValue(_col_pln.checkbox,0)) {
				this.setCellValue(true, _col_pln.checkbox);
			}
			else if (col == _col_pln.checkbox && !this.getHeaderValue(_col_pln.checkbox,0)) {
				this.setCellValue(false, _col_pln.checkbox);
			}
			return false;
		};
		
		grid_pln.setCellTemplate(new AW.Templates.Combo, _col_pln.programCDName);
	    grid_pln.setCellTemplate(new AW.Templates.Combo, _col_pln.activityCDName);
	    
		grid_pln.setPopupTemplate(function(col, row) {
			
			if (col == _col_pln.programCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","PROGRAMCD");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","80px");
	            list.setStyle("height","50px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid_pln.setCellText(text, col, row);  
			            grid_pln.setCellText(value[i], _col_pln.programCD, row);
	            	}
	            	catch(e){}
	            };
			}
			else if (col == _col_pln.activityCDName) {
	        	var table = new AW.XML.Table;
	        	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
	        	table.setAsync(false);
	        	table.setRequestMethod("POST");
	            table.setParameter("outParamKey","comCode;codeName;");
	            table.setParameter("codeDiv","ACTIVITYCD");
	            table.setParameter("notInCodes1","20");
	            table.setParameter("notInCodes2","50");
	            table.request();
	        	
	            var rowCount = table.getCount();
	            var value = new Array();
	            var text = new Array();
	                
	            if (rowCount > 0) {
	            	for (var i=0; i < rowCount; i++) {
	              		value[i] = table.getData(0,i);
	              		text[i] = table.getData(1,i);
	              	}
	            }
	              	
	            var list = new AW.UI.List;
	            list.setStyle("width","120px");
	            list.setStyle("height","60px");
	            list.setItemText(text);
	            list.setAttribute("value", value);
	            list.setItemCount(text.length);
	         
	            list.onItemMouseDown = function(event, i) {
	            	try {
	            		AW.$popup.hidePopup();
			            var text = this.getItemText(i);  
			            var value = this.getAttribute("value");
			            grid_pln.setCellText(text, col, row);  
			            grid_pln.setCellText(value[i], _col_pln.activityCD, row);
	            	}
	            	catch(e){}
	            };
			}
			
            return list;
        });
        
     	// Cell startEdit BEGIN
        grid_pln.onCellSelectedChanged = function(selected, col, row) {
            if (selected) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
                });
            }
        };

        grid_pln.onCellClicked = function(event, col, row) {
            if (this.getCellSelected(col, row)) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
               });
            }
        };

		grid_pln.onCellEditEnded = function(text, col, row) {
			this.setCellText(text, col, row);
			this.focus();
		};
		// Cell startEdit END
		
		//  BEGIN validating (Enter, Cell LoseFocus)
		grid_pln.onCellValidating = function(text, col, row) {
			if(col == _col_pln.venueCD) {
				if(text.length>10) {
					this.setCellText(text.substring(0,10),col,row);
				}
			}
			if(col == _col_pln.venueNm) {
				if(text.length>50) {
					this.setCellText(text.substring(0,50),col,row);
				}
			}
	    };
	
	    grid_pln.onCellValidated = function(text, col, row) {
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
    }

</script>