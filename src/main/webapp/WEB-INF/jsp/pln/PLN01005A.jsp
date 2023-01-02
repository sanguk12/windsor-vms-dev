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
													<fmt:message key="PLN01005A.eventYM" />
												</td>
												<td class="td-input">
													<nis:selectbox id="yearCD_S" name="yearCD_S" defaultText="none" category="YEARCD" event="onchange" eventproc="getPlanWriteDate();" />
													<nis:selectbox id="monthCD_S" name="monthCD_S" defaultText="none" category="MONTHCD" event="onchange" eventproc="getPlanWriteDate();" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PLN01005A.activity" />
												</td>
												<td class="td-input">
													<nis:selectbox id="activityCD_S" name="activityCD_S" defaultText="all" category="ACTIVITYCD" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="PLN01005A.venueGradCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="venueGradCD_S" name="venueGradCD_S" defaultText="all" category="VENUEGRADCD" />
				                                </td>
				                                
				                            </tr>
											<tr>
												<td class="td-cond">
													<fmt:message key="PLN01005A.addrTpCD1" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD1_S" name="addrTpCD1_S" defaultText="all" category="ADDRTPCD1" event="onchange" eventproc="getAddrTpCD2(this.value);" />
				                                </td>
				                                <td class="td-cond">
													<fmt:message key="PLN01005A.addrTpCD2" />
												</td>
												<td class="td-input">
													<nis:selectbox id="addrTpCD2_S" name="addrTpCD2_S" defaultText="all" category="ADDRTPCD2" />
				                                </td>
												<td class="td-cond">
													<fmt:message key="PLN01005A.apprStateCD" />
												</td>
												<td class="td-input">
													<nis:selectbox id="apprStateCD_S" name="apprStateCD_S" defaultText="none" category="APPRSTATECD" event="onchange" eventproc="changeApprStateCD();"/>
				                                </td>
				                            </tr>
				                            <tr>
												<td class="td-cond">
													<fmt:message key="PLN01005A.venue" />
												</td>
												<td class="td-input" colspan="5">
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
                	<td height="1">
                		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                			<colgroup>
			        			<col style="width:110px;"></col>
			        			<col style="width:200px;"></col>
			        			<col></col>
			        		</colgroup>
			        		<tbody>
			        			<tr>
									<td class="tit_text01">
										<fmt:message key="PLN01005A.planWriteDate" />
									</td>
									<td class="tit_text01">
										<span id="planWriteDate_S" />
	                                </td>
	                                <td class="tit_text01" >
										<fmt:message key="PLN01005A.msg9" />
	                                </td>
	                                <td style="text-align:right;">
		                   				<script type="text/javascript">
			                   				var productCartPopup = new AW.UI.Button;
					                      	productCartPopup.setControlText("<fmt:message key="button.ProductCart" />");
					                      	productCartPopup.setControlImage("search");
					                      	document.write(productCartPopup);
					                      
					                      	productCartPopup.onControlClicked = function(event) {
					                      		if($("#selectVenueCD").val() == "") {
					                      			alert("업소를 선택하시기 바랍니다.");
					                      			return;
					                      		}
						                      	openProductCartPopup("closeProductCartPopup");
					                      	};
					                      	
// 					                      	var addRow = new AW.UI.Button;
// 					                      	addRow.setControlText("<fmt:message key="button.AddRow" />");
// 					                      	addRow.setControlImage("addRow");
// 					                      	document.write(addRow);
					                      
// 					                      	addRow.onControlClicked = function(event) {
// 					                      		if($("#selectVenueCD").val() == "") {
// 					                      			alert("업소를 선택하시기 바랍니다.");
// 					                      			return;
// 					                      		}
// 					                      		grid_prd.addRow(maxRow_prd++);
// 					                      		grid_prd.setCellText("I",_col_prd.activeFlg,maxRow_prd-1);		                              
// 					                      		grid_prd.setCellText("10",_col_prd.apprStateCD,maxRow_prd-1);		                              
// 				                          		setCellFocus(grid_prd, _col_prd.planResultTpCD, maxRow_prd-1);
// 				                      		};
				                      	
				                   		</script>
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
									<span id="grid_pln"></span>
								</td>
								<td width="*">
									<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" >
			                    		<tr>
			                    			<td height="1" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
						                            <colgroup>
									        			<col style="width:100px;"></col>
									        			<col style="width:150px;"></col>
									        			<col style="width:100px;"></col>
									        			<col></col>
									        		</colgroup>
							        				<tbody>
						                            	<tr>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.venueCD" />
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="venueCD"></span>
															</td>
															<td class="td-cond-report">
																<fmt:message key="PLN01002A.venueNm" />
															</td>
															<td class="td-report-rborder">
																&nbsp;<span id="venueNm"></span>
															</td>
			                            				</tr>
		                            				</tbody>
		                            			</table>
		                            		</td>
	                            		</tr>
	                            		<tr>
				                            <td height="*">
				                            	<span id="grid_prd"></span>
				                            </td>
			                            </tr>
		                            </table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1">
						<input type="hidden" id="incntTpCD" name="incntTpCD" value="PRD" />
						<input type="hidden" id="selectVenueCD" name="selectVenueCD" />
						<input type="hidden" id="selectActivityCD" name="selectActivityCD" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<style type="text/css">

	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	#grid_pln .aw-column-0 {width: 35px; text-align:center;}
    #grid_pln .aw-column-1 {width: 120px; text-align:left;}
	#grid_pln .aw-column-2 {width: 80px; text-align:center;}
    #grid_pln .aw-column-3 {width: 100px; text-align:left;}
    #grid_pln .aw-column-4 {width: 60px; text-align:center;}
    #grid_pln .aw-column-5 {width: 100px; text-align:center;}
    
    #grid_prd .aw-column-0 {width: 80px; }
    #grid_prd .aw-column-1 {width: 100px; }
	#grid_prd .aw-column-2 {width: 60px; text-align:right;}
    #grid_prd .aw-column-3 {width: 60px; text-align:center;}
    #grid_prd .aw-column-4 {width: 70px; text-align:right;}
    #grid_prd .aw-column-5 {width: 70px; text-align:right;}
    #grid_prd .aw-column-6 {width: 90px; text-align:right;}
    #grid_prd .aw-column-7 {width: 80px; text-align:right;}
    #grid_prd .aw-column-8 {width: 80px; text-align:right;}
    #grid_prd .aw-column-9 {width: 200px; }
    #grid_prd .aw-column-10 {width: 80px; text-align:center;}
    #grid_prd .aw-column-11 {width: 35px; text-align:center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	var maxRow_pln = 0;
	var maxRow_prd = 0;
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			createGrid_pln();
			grid_pln.refresh();
			
			createGrid_prd();
			grid_prd.refresh();
			
			if("${params.eventym}"==""){
				$("#yearCD_S").val("${params.clientDate}".substring(0,4));
				$("#monthCD_S").val("${params.clientDate}".substring(4,6));
			}else{
				$("#yearCD_S").val("${params.eventym}".substring(0,4));
				$("#monthCD_S").val("${params.eventym}".substring(4,6));
			}
			$("#addrTpCD2_S").attr("disabled",true);
    		$("#addrTpCD2_S").addClass("input-readonly");
    		$("#apprStateCD_S").val("10");
    		$("#venueCD").text("");
    		$("#selectActivityCD").val("");
    		$("#venueNm").text("");
    		getPlanWriteYN();
			getPlanWriteDate();
			
			if("${params.eventym}"!=""){
				$("#apprStateCD_S").val("40");
    			Search();
    		}
		};

		${initScript}
		
		$("#yearCD_S").change(function(){
			Search();
		});
		$("#monthCD_S").change(function(){
			Search();
		});
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
	
	function getPlanWriteYN() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03001S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "01");		//01:plan,02:result
		table.request();
		
		if(table.getCount() > 0) {
			$("#planWriteYN").val(table.getData(0,0));
			if(table.getData(0,0) == "Y") {
				btnSave.setControlDisabled(false);
				btnCopyLastMonPlan.setControlDisabled(false);
			}
			else {
				btnSave.setControlDisabled(true);
				btnCopyLastMonPlan.setControlDisabled(true);
			}
		}
	}
	
	function getPlanWriteDate() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/COM03002S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("planResultTpCD", "01");		//01:plan,02:result
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
	
	function closeProductPopup(data) {
        var row = grid_prd.getCurrentRow();
        
    	for (var k=0; k<maxRow_prd; k++) {
			if (grid_prd.getCellText(_col_prd.prdCD,k) == data.prdCD &&
					grid_prd.getCellText(_col_prd.activeFlg,k) != "D" &&
       				k != row) {
				grid_prd.setCellText("",_col_prd.kindTpCD5Name,row);
				grid_prd.setCellText("",_col_prd.prdNm,row);
				grid_prd.setCellText("0",_col_prd.factoryPrice,row);
				grid_prd.setCellText("",_col_prd.qtyUnitCDName,row);
				grid_prd.setCellText("",_col_prd.kindTpCD5,row);
				grid_prd.setCellText("",_col_prd.prdCD,row);
				grid_prd.setCellText("",_col_prd.qtyUnitCD,row);
				grid_prd.setCellText("",_col_prd.activeFlg,row);
				grid_prd.setCellText("0",_col_prd.planQty,row);
				grid_prd.setCellText("0",_col_prd.planUnitAmt,row);
				grid_prd.setCellText("0",_col_prd.guidAmt,row);
				grid_prd.setCellText("0",_col_prd.payAmt,row);
				grid_prd.setCellText("0",_col_prd.gsvRate,row);
	            setCellFocus(grid_prd,_col_prd.prdCD,row);
				alert("<fmt:message key="PLN01005A.msg1"/>");
				return;
	            
			} else {
				
		        grid_prd.setCellText(data.kindTpCD5Name, _col_prd.kindTpCD5Name, row);       
		        grid_prd.setCellText(data.prdNm, _col_prd.prdNm, row); 
		        grid_prd.setCellText(formatNum(data.factoryPrice), _col_prd.factoryPrice, row);       
		        grid_prd.setCellText(data.qtyUnitCDName, _col_prd.qtyUnitCDName, row);       
		        grid_prd.setCellText(data.kindTpCD5, _col_prd.kindTpCD5, row);       
		        grid_prd.setCellText(data.prdCD, _col_prd.prdCD, row);       
		        grid_prd.setCellText(data.qtyUnitCD, _col_prd.qtyUnitCD, row); 
		        grid_prd.setCellText("0",_col_prd.planQty,row);
				grid_prd.setCellText("0",_col_prd.planUnitAmt,row);
				grid_prd.setCellText("0",_col_prd.guidAmt,row);
				grid_prd.setCellText("0",_col_prd.payAmt,row);
				grid_prd.setCellText("0",_col_prd.gsvRate,row);
		        setCellFocus(grid_prd,_col_prd.planQty,row);
			}
        }
    }
	
	function closeProductCartPopup(data) {
		//중복되는 것 체크
    	var count=0;
    	for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg,i)!="D") {
				if(grid_prd.getCellText(_col_prd.prdCD, i) == data.prdCD) {
					count++;
				}
       		}
    	}
    	if(count==0) {
			grid_prd.addRow(maxRow_prd++);
			grid_prd.setCellText(data.kindTpCD5Name, _col_prd.kindTpCD5Name, maxRow_prd-1);       
			grid_prd.setCellText(data.prdNm, _col_prd.prdNm, maxRow_prd-1); 
			grid_prd.setCellText(data.factoryPrice, _col_prd.factoryPrice, maxRow_prd-1);       
			grid_prd.setCellText(data.qtyUnitCDName, _col_prd.qtyUnitCDName, maxRow_prd-1);       
			grid_prd.setCellText(data.kindTpCD5, _col_prd.kindTpCD5, maxRow_prd-1);       
			grid_prd.setCellText(data.prdCD, _col_prd.prdCD, maxRow_prd-1);       
			grid_prd.setCellText(data.qtyUnitCD, _col_prd.qtyUnitCD, maxRow_prd-1);       
			grid_prd.setCellText("I", _col_prd.activeFlg, maxRow_prd-1);  
			grid_prd.setCellText("0",_col_prd.planQty,maxRow_prd-1);
			grid_prd.setCellText("0",_col_prd.planUnitAmt,maxRow_prd-1);
			grid_prd.setCellText("0",_col_prd.guidAmt,maxRow_prd-1);
			grid_prd.setCellText("0",_col_prd.payAmt,maxRow_prd-1);
			grid_prd.setCellText("0",_col_prd.gsvRate,maxRow_prd-1);
			
			//선지원일경우 선지원상세정보 단가 가져오기
			if($("#selectActivityCD").val() == "20") {
	    		var table = new AW.XML.Table;
	            table.setURL("${contextPath}/service/simpleAction/COM02001C02S");
	            table.setAsync(false);
	            table.setRequestMethod("POST");
	            table.setParameter("venueCD", $("#selectVenueCD").val());
	            table.setParameter("prdCD", data.prdCD);
	            table.request();
	            var rowCount = table.getCount();
	          	if (rowCount > 0) {
	          		grid_prd.setCellText(formatNum(table.getData(0,0)), _col_prd.planUnitAmt, maxRow_prd-1);
	          	}
	          	else {
	          		grid_prd.setCellText("0", _col_prd.planUnitAmt, maxRow_prd-1);
	          	}
    		}
			
			grid_prd.refresh();
       	}
    }
	
	//plan 가이드금액 계산
	function calculateGuidAmt(row) {
		var planQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.planQty, row)));
		var prdCD = grid_prd.getCellText(_col_prd.prdCD, row);
		
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/PLN0100503S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","guidAmt;");
		table.setParameter("format","num;");								
        table.setParameter("prdCD",prdCD);
        table.setParameter("planQty",planQty);
        table.request();
        
        var rowCount = table.getCount();
      	if (rowCount == 1) {
	        grid_prd.setCellText(table.getData(0,0), _col_prd.guidAmt, row);
	        setCellFocus(grid_prd,_col_prd.planUnitAmt,row);
      	}
      	else {
      		grid_prd.setCellText("0", _col_prd.guidAmt, row);
      	}
	}
	
	//plan 지급금액 계산
	function calculatePayAmt(row) {
		var planQty = parseFloat(unformat(grid_prd.getCellText(_col_prd.planQty, row)));
		var planUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.planUnitAmt, row)));
		var payAmt = 0;
		
		payAmt = planQty * planUnitAmt; 
        grid_prd.setCellText(formatNum(payAmt), _col_prd.payAmt, row);  
        
		var guidAmt = parseInt(unformat(grid_prd.getCellText(_col_prd.guidAmt, row)));
		if(planUnitAmt > guidAmt) {
			grid_prd.getCellTemplate(_col_prd.planUnitAmt, row).setStyle("background", "#ff0000");
			grid_prd.getCellTemplate(_col_prd.planUnitAmt, row).setStyle("color", "#ffffff");
			
		} else {
			grid_prd.getCellTemplate(_col_prd.planUnitAmt, row).setStyle("background", "");
			grid_prd.getCellTemplate(_col_prd.planUnitAmt, row).setStyle("color", "");
		}
        
        calculateGsvRate(row);
	}
	
	//vs GSV 계산
	function calculateGsvRate(row) {
		//gsv
		var gsv = 0;
		//제품별 plan단가
		var planUnitAmt = 0;
		//제품별 출고가
		var factoryPrice = 0;
		
		planUnitAmt = parseFloat(unformat(grid_prd.getCellText(_col_prd.planUnitAmt, row)));
		factoryPrice = parseFloat(unformat(grid_prd.getCellText(_col_prd.factoryPrice, row)));
		
		gsv = ((planUnitAmt*(1+0.0352)) / factoryPrice) *100;
        grid_prd.setCellText(Math.round(gsv), _col_prd.gsvRate, row);  
        
        if(Math.round(gsv) > "30") {
        	grid_prd.getCellTemplate(_col_prd.gsvRate, row).setStyle("background", "#ff0000");
        	grid_prd.getCellTemplate(_col_prd.gsvRate, row).setStyle("color", "#ffffff");
		} else {
			grid_prd.getCellTemplate(_col_prd.gsvRate, row).setStyle("background", "");
			grid_prd.getCellTemplate(_col_prd.gsvRate, row).setStyle("color", "");
		}
		
	}
	
	function removeRow(row) {
		grid_prd.deleteRow(row);
		grid_prd.setCellText("D",_col_prd.activeFlg,row);
    }
	
	function changeApprStateCD() {
		$("#selectVenueCD").val(grid_pln.getCellText(_col_pln.venueCD,grid_pln.getSelectedRows()));
	  	$("#selectActivityCD").val(grid_pln.getCellText(_col_pln.activityCD,grid_pln.getSelectedRows()));
	  	$("#venueCD").text(grid_pln.getCellText(_col_pln.venueCD,grid_pln.getSelectedRows()));
	  	$("#venueNm").text(grid_pln.getCellText(_col_pln.venueNm,grid_pln.getSelectedRows()));
	  	Search_prd();
	}
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	var _i_pln = 0;
	var _col_pln = {
		checkbox : _i_pln++
		, activityCDName : _i_pln++
		, venueCD : _i_pln++
		, venueNm : _i_pln++
		, venueGradCDName : _i_pln++
		, addrTpCD2Name : _i_pln++
		, activityCD : _i_pln++
		, apprStateCD : _i_pln++
		, chgID : _i_pln++
    };
	function Search() {
		getPlanWriteYN();
		getPlanWriteDate();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0100501S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"checkbox;activityCDName;venueCD;venueNm;venueGradCDName;"+
	  			"addrTpCD2Name;activityCD;apprStateCD;chgID;");
	  	table.setParameter("format",
	  			"str;str;str;str;str;"+
	  			"str;str;str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("empID", "${params.empID}");
	  	table.setParameter("activityCD", $("#activityCD_S").val());
	  	table.setParameter("venueGradCD", $("#venueGradCD_S").val());
	  	table.setParameter("addrTpCD1", $("#addrTpCD1_S").val());
	  	table.setParameter("addrTpCD2", $("#addrTpCD2_S").val());
	  	table.setParameter("venueCD", $("#venueCD_S").val());
// 	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.request();
      	
// 	  	if (grid_pln != null) grid_pln.clear();
      	createGrid_pln();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			data[i] = [
					""
      			    , table.getData(_col_pln.activityCDName,i)
      			    , table.getData(_col_pln.venueCD,i)
					, table.getData(_col_pln.venueNm,i)
					, table.getData(_col_pln.venueGradCDName,i)
					, table.getData(_col_pln.addrTpCD2Name,i)
					, table.getData(_col_pln.activityCD,i)
					, table.getData(_col_pln.apprStateCD,i)
      			];
      			if(table.getData(_col_pln.chgID,i) != ""){
      				grid_pln.getCellTemplate(_col_pln.activityCDName,i).setStyle("font-weight", "bold");
      				grid_pln.getCellTemplate(_col_pln.venueCD,i).setStyle("font-weight", "bold");
      			 	grid_pln.getCellTemplate(_col_pln.venueNm,i).setStyle("font-weight", "bold");
					grid_pln.getCellTemplate(_col_pln.venueGradCDName,i).setStyle("font-weight", "bold");
					grid_pln.getCellTemplate(_col_pln.addrTpCD2Name,i).setStyle("font-weight", "bold");
					grid_pln.getCellTemplate(_col_pln.activityCD,i).setStyle("font-weight", "bold");
					grid_pln.getCellTemplate(_col_pln.apprStateCD,i).setStyle("font-weight", "bold");
      			}
      		}
      		grid_pln.setCellData(data);
      		grid_pln.setRowCount(rowCount);
      	}
      	grid_pln.refresh();
      	
      	maxRow_pln = rowCount;
      	
      	$("#selectVenueCD").val("");
      	$("#selectActivityCD").val("");
      	$("#venueCD").text("");
		$("#venueNm").text("");
      	createGrid_prd();
		grid_prd.refresh();
		
	}
	
	var _i_prd = 0;
	var _col_prd = {
		kindTpCD5Name : _i_prd++
		, prdNm : _i_prd++
		, factoryPrice : _i_prd++
		, qtyUnitCDName : _i_prd++
		, planQty : _i_prd++
		, planUnitAmt : _i_prd++
		, guidAmt : _i_prd++
		, payAmt : _i_prd++
		, gsvRate : _i_prd++
		, commt : _i_prd++
		, apprStateCDName : _i_prd++
		, deleteBtn : _i_prd++
		, kindTpCD5 : _i_prd++
		, prdCD : _i_prd++
		, qtyUnitCD : _i_prd++
		, apprStateCD : _i_prd++
		, venueCD : _i_prd++
		, activeFlg : _i_prd++
    };
	function Search_prd() {
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/PLN0100502S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"kindTpCD5Name;prdNm;factoryPrice;qtyUnitCDName;planQty;"+
	  			"planUnitAmt;guidAmt;payAmt;gsvRate;commt;"+
	  			"apprStateCDName;deleteBtn;kindTpCD5;prdCD;qtyUnitCD;"+
	  			"apprStateCD;venueCD;");
	  	table.setParameter("format",
	  			"str;str;num;str;num;"+
	  			"num;num;num;num;str;"+
	  			"str;str;str;str;str;"+
	  			"str;str;");
	  	table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
	  	table.setParameter("venueCD", $("#selectVenueCD").val());
	  	table.setParameter("apprStateCD", $("#apprStateCD_S").val());
	  	table.request();
      	
// 	  	if (grid_prd != null) grid_prd.clear();
      	createGrid_prd();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i<rowCount; i++) {
      			var apprStateCDName = "";
      			if(table.getData(_col_prd.apprStateCD,i) == "10") {
      				apprStateCDName = table.getData(_col_prd.apprStateCDName,i);
          		}
          		else {
          			apprStateCDName = "<a href=\"javascript:openApprState('"+i+"');\">"+table.getData(_col_prd.apprStateCDName,i)+"</a>";
          		}
      			
      			data[i] = [
					table.getData(_col_prd.kindTpCD5Name,i)
      			    , table.getData(_col_prd.prdNm,i)
					, formatNum(table.getData(_col_prd.factoryPrice,i))
					, table.getData(_col_prd.qtyUnitCDName,i)
					, formatNum(table.getData(_col_prd.planQty,i))
					, formatNum(table.getData(_col_prd.planUnitAmt,i))
					, formatNum(table.getData(_col_prd.guidAmt,i))
					, formatNum(table.getData(_col_prd.payAmt,i))
					, formatNum(table.getData(_col_prd.gsvRate,i))
					, table.getData(_col_prd.commt,i)
					, apprStateCDName
					, table.getData(_col_prd.deleteBtn,i)
					, table.getData(_col_prd.kindTpCD5,i)
					, table.getData(_col_prd.prdCD,i)
					, table.getData(_col_prd.qtyUnitCD,i)
					, table.getData(_col_prd.apprStateCD,i)
					, table.getData(_col_prd.venueCD,i)
					, "U"
      			];
				grid_prd.setCellTemplate(new AW.Templates.Text, _col_prd.prdNm, i);
      			grid_prd.getCellTemplate(_col_prd.prdNm, i).setStyle("background", "#ececec");
      			
      			var gsvRate = parseInt(unformat(table.getData(_col_prd.gsvRate,i)));
      			if(gsvRate > 30) {
      				grid_prd.getCellTemplate(_col_prd.gsvRate, i).setStyle("background", "#ff0000");
      				grid_prd.getCellTemplate(_col_prd.gsvRate, i).setStyle("color", "#ffffff");
      			} else {
      				grid_prd.getCellTemplate(_col_prd.gsvRate, i).setStyle("background", "");
      				grid_prd.getCellTemplate(_col_prd.gsvRate, i).setStyle("color", "");
      			}
      			var planUnitAmt = parseInt(unformat(table.getData(_col_prd.planUnitAmt,i)));
      			var guidAmt = parseInt(unformat(table.getData(_col_prd.guidAmt,i)));
      			if(planUnitAmt > guidAmt) {
      				grid_prd.getCellTemplate(_col_prd.planUnitAmt, i).setStyle("background", "#ff0000");
      				grid_prd.getCellTemplate(_col_prd.planUnitAmt, i).setStyle("color", "#ffffff");
      			}
      			else {
      				grid_prd.getCellTemplate(_col_prd.planUnitAmt, i).setStyle("background", "");
      				grid_prd.getCellTemplate(_col_prd.planUnitAmt, i).setStyle("color", "");
      			}
      			
      		}
      		grid_prd.setCellData(data);
      		grid_prd.setRowCount(rowCount);
      	}
      	grid_prd.refresh();
      	
      	maxRow_prd = rowCount;
	}
	
	function openApprState(i) {
      	var venueCD = grid_prd.getCellText(_col_prd.venueCD,i);
      	var prdCD = grid_prd.getCellText(_col_prd.prdCD,i);
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PLN01005B"
				+"&eventYM="+$("#yearCD_S").val()+$("#monthCD_S").val()
				+"&venueCD="+venueCD
				+"&prdCD="+prdCD
		newWindow(url, "PLN01005B",600,350,"yes");
	}
	
	function Save() {
		if(maxRow_prd == 0) {
			alert("<fmt:message key="info.nullData.save"/>");
			return;
		}
		
		for(var i=0; i<maxRow_prd; i++) {
			if(grid_prd.getCellText(_col_prd.activeFlg, i)!="D") {
				//등록, 반려인 경우에만 저장
				var apprStateCD = grid_prd.getCellText(_col_prd.apprStateCD, i);
				if (apprStateCD != "" && apprStateCD != "10" && apprStateCD != "40") {
					alert("<fmt:message key="PLN01005A.msg2"/>");
					return;
				}
				if (grid_prd.getCellText(_col_prd.planQty, i) == "") {alert("<fmt:message key="PLN01005A.msg3" />"); setCellFocus(grid_prd, _col_prd.planQty, i); return;}
				if (grid_prd.getCellText(_col_prd.planUnitAmt, i) == "") {alert("<fmt:message key="PLN01005A.msg4" />"); setCellFocus(grid_prd, _col_prd.planUnitAmt, i); return;}
				
				var planUnitAmt = parseInt(unformat(grid_prd.getCellText(_col_prd.planUnitAmt, i)));
				var guidAmt = parseInt(unformat(grid_prd.getCellText(_col_prd.guidAmt, i)));
				
				if(planUnitAmt > guidAmt) {
					if(grid_prd.getCellText(_col_prd.commt, i) == "") {
						alert("<fmt:message key="PLN01005A.msg6" />");
						setCellFocus(grid_prd, _col_prd.commt, i);
						return;
					}
				}
			}
		}
		
		
		
		var kindTpCD5 = new Array();
		var prdCD = new Array();
		var factoryPrice = new Array();
		var qtyUnitCD = new Array();
		var planQty = new Array();
		var planUnitAmt = new Array();
		var guidAmt = new Array();
		var payAmt = new Array();
		var gsvRate = new Array();
		var commt = new Array();
		var activeFlg = new Array();
		var apprStateCD = new Array();
		var count = 0;
		for (var i=0; i<maxRow_prd; i++) {
			kindTpCD5[count] = grid_prd.getCellText(_col_prd.kindTpCD5, i);
			prdCD[count] = grid_prd.getCellText(_col_prd.prdCD, i);
			factoryPrice[count] = unformat(grid_prd.getCellText(_col_prd.factoryPrice, i));
			qtyUnitCD[count] = grid_prd.getCellText(_col_prd.qtyUnitCD, i);
			planQty[count] = unformat(grid_prd.getCellText(_col_prd.planQty, i));
			planUnitAmt[count] = unformat(grid_prd.getCellText(_col_prd.planUnitAmt, i));
			guidAmt[count] = unformat(grid_prd.getCellText(_col_prd.guidAmt, i));
			payAmt[count] = unformat(grid_prd.getCellText(_col_prd.payAmt, i));
			gsvRate[count] = grid_prd.getCellText(_col_prd.gsvRate, i);
			commt[count] = grid_prd.getCellText(_col_prd.commt, i);
			activeFlg[count] = grid_prd.getCellText(_col_prd.activeFlg, i);
			apprStateCD[count] = grid_prd.getCellText(_col_prd.apprStateCD, i);
			count++;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln01/savePlanBrandWrite");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
		table.setParameter("venueCD", $("#selectVenueCD").val());
		table.setParameter("incntTpCD", $("#incntTpCD").val());
		table.setParameter("kindTpCD5", kindTpCD5);
		table.setParameter("prdCD", prdCD);
		table.setParameter("factoryPrice", factoryPrice);
		table.setParameter("qtyUnitCD", qtyUnitCD);
		table.setParameter("planQty", planQty);
		table.setParameter("planUnitAmt", planUnitAmt);
		table.setParameter("guidAmt", guidAmt);
		table.setParameter("payAmt", payAmt);
		table.setParameter("gsvRate", gsvRate);
		table.setParameter("commt", commt);
		table.setParameter("activeFlg", activeFlg);
		table.setParameter("apprStateCD", apprStateCD);
		table.request();

		if(table.getData(0,0) == "S") {
			top.appCountFun();
			message(table.getData(1,0));
			Search_prd();
   		}
		else {
			alert(table.getData(1,0));
		}
	}
	
	function CopyLastMonPlan() {
		var index_pln = grid_pln.getRowIndices();
		if (index_pln == ""){
			index_pln = new Array();
			for (var i = 0; i < grid_pln.getRowCount(); i++){
				index_pln[i] = i;
			}
		}
		
		var venueCDs = new Array();
		var count = 0;
		for(var i=0; i < index_pln.length; i++) {
			if (grid_pln.getCellValue(_col_pln.checkbox, index_pln[i])) {
				
				/*	plan승인처리가 등록, 반려가 아닌경우에는 전월플랜복사 불가
  					(20, 30, 50이 하나라도 있는 경우 50으로 처리 50인경우, 빼지못함)
  				*/
				var venueCD = grid_pln.getCellText(_col_pln.venueCD, index_pln[i]);
				var apprStateCD = grid_pln.getCellText(_col_pln.apprStateCD, index_pln[i]);
				if(apprStateCD=="50") {
					alert("<fmt:message key="PLN01005A.msg8"><fmt:param value='"+venueCD+"' /></fmt:message>");
					return;
				}
				
				venueCDs[count] = grid_pln.getCellText(_col_pln.venueCD, i);
				count++;
			}
		}
		
		
		if(count==0) {
			alert("<fmt:message key="info.noSelect"/>");
			return;
		}
		if(!confirm("<fmt:message key="PLN01005A.msg5"/>")) {
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/pln01/copyBefMonPlanBrandWrite");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("eventYM", $("#yearCD_S").val()+$("#monthCD_S").val());
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

	function PayHistory() {
		if(grid_prd.getCellText(_col_prd.prdCD, grid_prd.getSelectedRows()) == ""){
			alert("상품을 선택하여 주십시오.");
			return;
		}
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var venueCD = $("#venueCD").text();
		var venueNm = $("#venueNm").text();
		var prdCD = grid_prd.getCellText(_col_prd.prdCD, grid_prd.getSelectedRows());
		var prdNm = grid_prd.getCellText(_col_prd.prdNm, grid_prd.getSelectedRows());

		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=ANL01010A"
			+"&diffNo="+diffNo+"&eventYM="+eventYM+"&venueCD="+venueCD+"&venueNm="+venueNm+"&prdCD="+prdCD+"&prdNm="+prdNm;
		
		newWindow(url, "ANL01010A",1080,750,"yes");
	}

	function ApprovalHistory(){
		var eventYM = $("#yearCD_S").val()+$("#monthCD_S").val();
		var diffNo = $("#diffNo").val();
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=PLN02002B"
			+"&diffNo="+diffNo+"&eventYM="+eventYM;
		
		newWindow(url, "PLN02002B",1080,520,"yes");
	}
	/*****************************************************
	*	define grid / data formats define
	*****************************************************/
	var columns_pln = [
		""     
	    , "*<fmt:message key="PLN01005A.activity"/>"      
       	, "<fmt:message key="PLN01005A.venueCD"/>"
		, "<fmt:message key="PLN01005A.venueNm"/>"
		, "<fmt:message key="PLN01005A.venueGradCD"/>"
		, "<fmt:message key="PLN01005A.addrTpCD2"/>"
	];

	var grid_pln = null;
	function createGrid_pln() {
		grid_pln = new AW.UI.Grid;
	    grid_pln.setId("grid_pln");
	    grid_pln.setRowCount(0);
	    grid_pln.setStyle("width","100%");
	    grid_pln.setStyle("height","100%");
	    grid_pln.setSelectorVisible(false);
	    grid_pln.setSelectionMode("single-row");
	    grid_pln.setHeaderText(columns_pln);
	    for(var i=0;i<columns_pln.length;i++){grid_pln.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_pln.setColumnCount(columns_pln.length);
	    grid_pln.setCellFormat([
	                        str, str, str, str, str
	                        ]);
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
		
		grid_pln.onRowDoubleClicked = function(event, row){
		  	$("#selectVenueCD").val(this.getCellText(_col_pln.venueCD,row));
		  	$("#selectActivityCD").val(this.getCellText(_col_pln.activityCD,row));
		  	$("#venueCD").text(this.getCellText(_col_pln.venueCD,row));
		  	$("#venueNm").text(this.getCellText(_col_pln.venueNm,row));
		  	Search_prd();
		};
		
    }
	
	var columns_prd = [
	    "<fmt:message key="PLN01005A.kindTpCD5"/>"
       	, "<fmt:message key="PLN01005A.prdNm"/>"
		, "<fmt:message key="PLN01005A.factoryPrice"/>"
		, "<fmt:message key="PLN01005A.qtyUnitCD"/>"
		, "*<fmt:message key="PLN01005A.planQty"/>"
		, "*<fmt:message key="PLN01005A.planUnitAmt"/>"
		, "<fmt:message key="PLN01005A.guidAmt"/>"
		, "<fmt:message key="PLN01005A.payAmt"/>"
		, "<fmt:message key="PLN01005A.gsvRate"/>"
		, "<fmt:message key="PLN01005A.commt"/>"
		, "<fmt:message key="PLN01005A.apprStateCD"/>"
		, "<fmt:message key="PLN01005A.deleteBtn"/>"
		
	];
	var grid_prd = null;
	function createGrid_prd() {
		grid_prd = new AW.UI.Grid;
	    grid_prd.setId("grid_prd");
	    grid_prd.setRowCount(0);
	    grid_prd.setStyle("width","100%");
	    grid_prd.setStyle("height","100%");
	    grid_prd.setSelectorVisible(false);
	    grid_prd.setSelectionMode("single-cell");
	    grid_prd.setHeaderText(columns_prd);
	    for(var i=0;i<columns_prd.length;i++){grid_prd.getHeaderTemplate(i).setStyle("text-align", "center");}
	    grid_prd.setColumnCount(columns_prd.length);
	    grid_prd.setCellFormat([
	                        str, str, num, str, num, num, num, num, num, str, html, str]);
	    grid_prd.setCellEditable(false);
	    grid_prd.setCellEditable(true, _col_prd.planQty);
	    grid_prd.setCellEditable(true, _col_prd.planUnitAmt);
	    grid_prd.setCellEditable(true, _col_prd.commt);
	    
	    grid_prd.setCellImage("searchGrid", _col_prd.prdNm);
		var productSearch = new AW.Templates.ImageText;
		var searchImage = productSearch.getContent("box/image");
		searchImage.setTag("a");
		searchImage.setAttribute("href", function() {
			return "javascript:openProductPopup('closeProductPopup')";
		});
		grid_prd.setCellTemplate(productSearch, _col_prd.prdNm);
	    
		grid_prd.setCellImage("deleteGrid",_col_prd.deleteBtn);
	    var deleteFlag = new AW.Templates.Image;
	    var delImage = deleteFlag.getContent("box/image");
	    delImage.setTag("a");
	    delImage.setAttribute("href", function(){
	    	return "javascript:removeRow(grid_prd.getCurrentRow())";
	    });
	    grid_prd.setCellTemplate(deleteFlag, _col_prd.deleteBtn);
		
     	// Cell startEdit BEGIN
        grid_prd.onCellSelectedChanged = function(selected, col, row) {
            if (selected) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
                });
            }
        };

        grid_prd.onCellClicked = function(event, col, row) {
            if (this.getCellSelected(col, row)) {
                this.setTimeout(function(){
                   this.raiseEvent("editCurrentCell", {}, col, row);
               });
            }
        };
        
        grid_prd.onCellEditStarted = function(text, col, row){
	        if (col == _col_prd.planQty) {
	            this.setCellText(unformatNum(text), col, row);
	        }
	        if (col == _col_prd.planUnitAmt) {
	            this.setCellText(unformatNum(text), col, row);
	        }
	    };

		grid_prd.onCellEditEnded = function(text, col, row) {
			this.setCellText(text, col, row);
			this.focus();
		};
		// Cell startEdit END
		
		//  BEGIN validating (Enter, Cell LoseFocus)
		grid_prd.onCellValidating = function(text, col, row) {
			if(col == _col_prd.planQty) {
				if(text.length > 5) {
					this.setCellText(text.substring(0,5),col,row);
				}
				if (!isNumber(text)) {
				    alert('<fmt:message key="error.format" />');
				    this.setCellText("",col,row);
				}
	           	else if (parseFloat(text) < 0) {
					alert('<fmt:message key="error.noMinusNum" />');
					this.setCellText("",col,row);
				}
			}
			if(col == _col_prd.planUnitAmt) {
				if(text.length > 13) {
					this.setCellText(text.substring(0,13),col,row);
				}
				if (!isNumber(text)) {
				    alert('<fmt:message key="error.format" />');
				    this.setCellText("",col,row);
				}
	           	else if (parseFloat(text) < 0) {
					alert('<fmt:message key="error.noMinusNum" />');
					this.setCellText("",col,row);
				}
			}
	    };
	
	    grid_prd.onCellValidated = function(text, col, row) {
	    	if (col == _col_prd.planQty) {
	            this.setCellText(formatNum(text), col, row);
	            calculateGuidAmt(row);
	        }
	    	if (col == _col_prd.planUnitAmt) {
	            this.setCellText(formatNum(text), col, row);
	            calculatePayAmt(row);
	        }
	    };
	    //  END validated Action (Enter, Cell LoseFocus)
	    
	    grid_prd.onRowDoubleClicked = function(event, row){
		};
    }

</script>