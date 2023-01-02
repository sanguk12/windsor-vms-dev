<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
		<%@include file="../sys3/cms/calendar.jsp" %>
    </head>

    <body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1"> 		
						<%@include file="../sys3/cms/standardParam.jsp" %>
						
						<input type="hidden" id="refund_no" name="refund_no">
						<input type="hidden" id="buy_serial_no" name="buy_serial_no" value="${params.buy_serial_no}">
						<input type="hidden" id="user_name" name="user_name">
						<input type="hidden" id="register" name="register">
						<input type="hidden" id="refund_type_code" name="refund_type_code">
						<input type="hidden" id="beforeAction" name="beforeAction" value="${params.beforeAction}"/>
						<input type="hidden" id="remit_type_code" name="remit_type_code" />
						<input type="hidden" id=popUpYN name="popUpYN" value="${params.popUpYN}"/>
						
						<%@include file="../sys3/cms/functionbar.jsp" %>
                    </td>
                </tr>
		        <tr>
		           	<td height="*" valign="top">
		           		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			           		<tr id="gridTopDiv">
							    <td height="1"  style="border-bottom:#d9b79b solid 2px;">
							        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
							            <colgroup>
							                <col style="width:90%;"></col> 
							            </colgroup>
							            <tbody>
							                <tr>
							                	<td><div id="listTopDiv"></td>
							                </tr>
							            </tbody>
							        </table>
							    </td>
							</tr>
		           			<tr>
					            <td height="1" style="padding:10px 0 0 0;">
					                <table border="0" cellspacing="0" cellpadding="0" width="100%" >
					                    <colgroup>
					                        <col style="width:100%;"></col>
					                    </colgroup>
					                    <tbody>
					                        <tr>
					                            <td class="group-title"><fmt:message key="COM01001L.custBasicInfo"/></td>
					                        </tr>
					                    </tbody>    
					                </table>
					            </td>
					        </tr>
		           			<tr>
		           				<td class="tb-border">
				              		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
				                      	<colgroup>
									    	<col style="width:100px"></col>
									    	<col style="width:180px"></col>
									    	<col style="width:100px"></col>
									    	<col style="width:180px"></col>
									    	<col style="width:100px"></col>
									    	<col></col>
									    </colgroup>
									    <tbody>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.name"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="name"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.nationality_code"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="nationality_code"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.passport_no"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="passport_no"></span>&nbsp
					                        </td>
					                    </tr>
					                    <tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.passport_expirydate"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="passport_expirydate"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.birthday"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="birthday"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.gender_code"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="gender_code"></span>&nbsp
					                        </td>
					                    </tr>
					                    <tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.input_way_code"/>
					                        </td>
					                        <td class="td-input" colspan="5">
					                            <span id="input_way_code"></span>&nbsp
					                        </td>
					                    </tr>
					            		</tbody>        
					                </table>  
		           				</td>
	            			</tr>
	            			<tr>
					            <td height="1" >
					                <table border="0" cellspacing="0" cellpadding="0" width="100%" >
					                    <colgroup>
					                        <col style="width:100%;"></col> 
					                    </colgroup>
					                    <tbody>
					                        <tr>
					                            <td class="group-title"><fmt:message key="COM01001L.shopBasicInfo"/></td>
					                        </tr>
					                    </tbody>    
					                </table>
					            </td>           
					        </tr>
		           			<tr>
		           				<td class="tb-border">
				              		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
				                      	<colgroup>
									    	<col style="width:100px"></col>
									    	<col style="width:180px"></col>
									    	<col style="width:100px"></col>
									    	<col style="width:180px"></col>
									    	<col style="width:100px"></col>
									    	<col></col>
									    </colgroup>
									    <tbody>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.shop_name"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="shop_name"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.biz_permit_no"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="biz_permit_no"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.company_name"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="company_name"></span>&nbsp
					                        </td>
					                    </tr>
					                    <tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.sell_date"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="sell_date"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.sell_time"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="sell_time"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.tel_no"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="tel_no"></span>&nbsp
					                        </td>
					                    </tr>
					            		</tbody>        
					                </table>  
		           				</td>
	            			</tr>
	            			<tr>
					            <td height="1" >
					                <table border="0" cellspacing="0" cellpadding="0" width="100%" >
					                    <colgroup>
					                        <col style="width:100%;"></col> 
					                    </colgroup>
					                    <tbody>
					                        <tr>
					                            <td class="group-title"><fmt:message key="COM01001L.out_info"/></td>
					                        </tr>
					                    </tbody>    
					                </table>
					            </td>           
					        </tr>
	            			<tr>
		           				<td class="tb-border">
				              		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
				                      	<colgroup>
									    	<col style="width:100px"></col>
									    	<col style="width:180px"></col>
									    	<col style="width:100px"></col>
									    	<col style="width:180px"></col>
									    	<col style="width:100px"></col>
									    	<col></col>
									    </colgroup>
									    <tbody>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.out_customs_name"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="out_customs_name"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.out_date"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="out_date"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.customs_out_no"/>
					                        </td>
					                        <td class="td-input">
					                            <span id="customs_out_no"></span>&nbsp
					                        </td>
					                    </tr>
					                    <tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.out_division_name"/>
					                        </td>
					                        <td class="td-input" colspan="5">
					                            <span id="out_division_name"></span>&nbsp
					                        </td>
					                    </tr>
					            		</tbody>        
					                </table>  
		           				</td>
	            			</tr>
	            			<tr id="refundWayInfoTr">
					            <td height="1" >
					                <table border="0" cellspacing="0" cellpadding="0" width="100%" >
					                    <colgroup>
					                        <col style="width:100%;"></col> 
					                    </colgroup>
					                    <tbody>
					                        <tr>
					                            <td class="group-title"><fmt:message key="COM01001L.refundWayInfo"/></td>
					                        </tr>
					                    </tbody>    
					                </table>
					            </td>           
					        </tr>
					        <!-- 현금 -->
		           			<tr id="cashTr">
		           				<td class="tb-border">
				              		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
				                      	<colgroup>
									    	<col style="width:100px"></col>
									    	<col style="width:180px"></col>
									    	<col style="width:100px"></col>
									    	<col style="width:180px"></col>
									    	<col style="width:100px"></col>
									    	<col></col>
									    </colgroup>
									    <tbody>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.refund_way_name"/>
					                        </td>
					                        <td class="td-input" colspan="5">
					                           	<fmt:message key="COM01001L.cash"/>
					                        </td>
					                    </tr>
					            		</tbody>        
					                </table>  
		           				</td>
	            			</tr>
					        <!-- 카드 -->   			
	            			<tr id="cardTr">
		           				<td class="tb-border">
				              		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
				                      	<colgroup>
									    	<col style="width:100px"></col>
									    	<col style="width:250px"></col>
									    	<col style="width:100px"></col>
									    	<col></col>
									    </colgroup>
									    <tbody>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.refund_way_name"/>
					                        </td>
					                        <td class="td-input" colspan="3">
												 <fmt:message key="COM01001L.card"/>
					                        </td>
					                    </tr>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.card_no"/>
					                        </td>
					                        <td class="td-input">
												<span id="card_no"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.validperiod_yr"/>
					                        </td>
					                        <td class="td-input">
												<span id="validperiod_yr"></span>&nbsp
					                        </td>					                        
					                    </tr>			
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.card_company_name"/>
					                        </td>
					                        <td class="td-input">
												<span id="card_company_name"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.csc"/>
					                        </td>
					                        <td class="td-input">
												<span id="csc"></span>&nbsp
					                        </td>					                        
					                    </tr>		
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.owner_name"/>
					                        </td>
					                        <td class="td-input" colspan="3">
												<span id="owner_name"></span>&nbsp
					                        </td>
					                    </tr>	              
					            		</tbody>        
					                </table>  
		           				</td>
	            			</tr>
					        <!-- 계좌 -->   			
	            			<tr id="accountTr">
		           				<td class="tb-border">
				              		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
				                      	<colgroup>
									    	<col style="width:100px"></col>
									    	<col style="width:250px"></col>
									    	<col style="width:100px"></col>
									    	<col></col>
									    </colgroup>
									    <tbody>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.refund_way_name"/>
					                        </td>
					                        <td class="td-input" colspan="3">
												 <fmt:message key="COM01001L.acount"/>
					                        </td>
					                    </tr>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.bank_name"/>
					                        </td>
					                        <td class="td-input">
												<span id="bank_name"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.country_code"/>
					                        </td>
					                        <td class="td-input">
												<span id="country_code"></span>&nbsp
					                        </td>					                        
					                    </tr>			
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.account_no"/>
					                        </td>
					                        <td class="td-input">
												<span id="account_no"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.swift_code"/>
					                        </td>
					                        <td class="td-input">
												<span id="swift_code"></span>&nbsp
					                        </td>					                        
					                    </tr>		
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.acc_holder_name"/>
					                        </td>
					                        <td class="td-input" colspan="3">
												<span id="acc_holder_name"></span>&nbsp
					                        </td>
					                    </tr>	              
					            		</tbody>        
					                </table>  
		           				</td>
	            			</tr>
					        <!-- 우편 -->   			
	            			<tr id="postTr">
		           				<td class="tb-border">
				              		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
				                      	<colgroup>
									    	<col style="width:100px"></col>
									    	<col style="width:250px"></col>
									    	<col style="width:100px"></col>
									    	<col></col>
									    </colgroup>
									    <tbody>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.refund_way_name"/>
					                        </td>
					                        <td class="td-input" colspan="3">
												 <fmt:message key="COM01001L.post"/>
					                        </td>
					                    </tr>
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.tel_no"/>
					                        </td>
					                        <td class="td-input">
												<span id="post_tel_no"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.country"/>
					                        </td>
					                        <td class="td-input">
												<span id="country"></span>&nbsp
					                        </td>					                        
					                    </tr>			
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.addr"/>
					                        </td>
					                        <td class="td-input" colspan="3">
												<span id="addr"></span>&nbsp
					                        </td>
					                    </tr>		
			                         	<tr>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.remittee_name"/>
					                        </td>
					                        <td class="td-input">
												<span id="remittee_name"></span>&nbsp
					                        </td>
					                        <td class="td-cond">
					                        	<fmt:message key="COM01001L.reg_no"/>
					                        </td>
					                        <td class="td-input">
												<span id="reg_no"></span>&nbsp
					                        </td>
					                    </tr>	              
					            		</tbody>        
					                </table>  
		           				</td>
	            			</tr>
	            			<tr>
					            <td height="1" >
					                <table border="0" cellspacing="0" cellpadding="0" width="100%" >
					                    <colgroup>
					                        <col style="width:100%;"></col> 
					                    </colgroup>
					                    <tbody>
					                        <tr>
					                            <td class="group-title"><fmt:message key="COM01001L.buy_detail"/></td>
					                        </tr>
					                    </tbody>    
					                </table>
					            </td>           
					        </tr>
				            <tr>
								<td height="*" style="vertical-align:text-top;">
									<div id="gridDiv"></div>
								</td>
				            </tr>
	         			</table>
		           	</td>
		        </tr>
            </table>
        </form>
    </body>
</html>

<script type="text/javascript">
	
	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {
		window.onload = function() {
			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
			
		};

		${initScript}
		
		$("#cashTr").hide();
		$("#cardTr").hide();
		$("#accountTr").hide();
		$("#postTr").hide();
		
		if($("#popUpYN").val() == 'Y'){
			btnList.setControlVisible(false);
		}
		else{
			//btnClose.setControlVisible(false);
		}
		
	});
	
	
	/****************************************
	* Button Action
	****************************************/
    function List(){
    	clear();
    	parent.appletClose();
    	parent.PagingSearch();
    }
	
    function clear(){
    	$("#cashTr").hide();
		$("#cardTr").hide();
		$("#accountTr").hide();
		$("#postTr").hide();
		$("#refundWayInfoTr").show();
    }
    
    function display(){
		
		if($("#refund_type_code").val().trim() == "01"){
			$("#cashTr").show();
		}
		else if($("#refund_type_code").val().trim() == "02"){
			
			if($("#remit_type_code").val().trim() == "02"){
				$("#cardTr").show();
			}
			else if($("#remit_type_code").val().trim() == "03"){
				$("#accountTr").show();
			}
			else if($("#remit_type_code").val().trim() == "04"){
				$("#postTr").show();
			}
			
		}
		else{
			$("#refundWayTitleTr").hide();
		}
    }
	
	function Search() {
		if($("#beforeAction").val() == "TRC01001A" || $("#beforeAction").val() == "TRC04001A"){
			SearchProcessA();
		}
		else if($("#beforeAction").val() == "TRC01003A"){
			SearchProcessB();
		}
	}
	
	//환급조회 상세화면 조회
	function SearchProcessA() {
		
   		//고객기본정보, 매장기본저보, 환급방법정보 조회	
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/COM01001L01S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"NAME;NATIONALITY_NAME;PASSPORT_NO;PASSPORT_EXPIRYDATE;BIRTHDAY;"+
				"GENDER_NAME;INPUT_WAY_NAME;SHOP_NAME;BIZ_PERMIT_NO;COMPANY_NAME;"+
				"SELL_DATE;SELL_TIME;TEL_NO;REFUND_NO;"+
				"REFUND_TYPE_CODE;USER_NAME;OUT_CUSTOMS_NAME;OUT_DATE;"+
				"CUSTOMS_OUT_NO;OUT_DIVISION_NAME;");
	    table.setParameter("format",
	    		"str;str;str;str;str;"+
				"str;str;str;str;str;"+
				"str;str;str;str;"+
				"str;str;str;str;"+
				"str;str;");
	    table.setParameter("buy_serial_no", $("#buy_serial_no").val());
      	table.request();
      	
        var rowCount = table.getCount();
        if (rowCount > 0) {
            $("#name").text(table.getData(0,0));
            $("#nationality_code").text(table.getData(1,0));
            $("#passport_no").text(table.getData(2,0));
            $("#passport_expirydate").text(formatDate(table.getData(3,0)));
            $("#birthday").text(formatDate(table.getData(4,0)));
            $("#gender_code").text(table.getData(5,0));
            $("#input_way_code").text(table.getData(6,0));
            $("#shop_name").text(table.getData(7,0));
            $("#biz_permit_no").text(formatBizRegNo(table.getData(8,0)));
            $("#company_name").text(table.getData(9,0));
            $("#sell_date").text(formatDate(table.getData(10,0)));
            $("#sell_time").text(formatTime(table.getData(11,0)));
            $("#tel_no").text(formatTelNo(table.getData(12,0)));
            $("#refund_no").val(table.getData(13,0));
            $("#refund_type_code").val(table.getData(14,0));
            $("#user_name").val(table.getData(15,0));
			$("#out_customs_name").text(table.getData(16,0));
			$("#out_date").text(formatDate(table.getData(17,0)));
			$("#customs_out_no").text(table.getData(18,0));
			$("#out_division_name").text(table.getData(19,0));
        }
      	
   		//구매내역 조회	
		var table2 = new AW.XML.Table;
	  	table2.setURL("${contextPath}/service/simpleAction/COM01001L02S");
	  	table2.setAsync(false);
	  	table2.setRequestMethod("POST");
	  	table2.setParameter("outParamKey",
	  			"ROWNUM;GOODS_NAME;UNIT_PRICE;QTY;SELL_COST;"+
	  			"TAX1_AMT;TAX2_AMT;TAX3_AMT;TOTAL_BUY_AMT;TOTAL_TAX_AMT;"+
	  			"RCT_NO;ETC_INFO;");
	    table2.setParameter("format",
	    		"str;str;str;str;str;"+
	    		"str;str;str;str;str;"+
	    		"str;str;");
	    table2.setParameter("buy_serial_no", $("#buy_serial_no").val());
      	table2.request();
        
		var rowCount = table2.getCount();
		var grid = "";
		if (rowCount > 0) {
			grid += "<table border='0' cellpadding='2' cellspacing='0' width='100%' style='table-layout:fixed;'>";
			grid += "<colgroup>";
			grid += "	<col width='10%' />";
			grid += "	<col width='30%' />";
			grid += "	<col width='11%' />";
			grid += "	<col width='7%' />";
			grid += "	<col width='11%' />";
			grid += "	<col width='18%' />";
			grid += "	<col width='13%' />";
			grid += "</colgroup>";
			grid += "<thead>";
			grid += "	<tr>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.rownum"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.goods_name"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.unit_price"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.qty"/>";
			grid += "		</tdh>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.sell_cost"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.rct_no"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.etc_info"/>";
			grid += "		</th>";
			grid += "	</tr>";
			grid += "</thead>";

			var listTop = "<b>"+"<fmt:message key="COM01001L.refund_no"/>"+" : " + table.getData(14, 0).trim() +" / "+"<fmt:message key="COM01001L.buy_serial_no"/>"+" : " + $("#buy_serial_no").val() +" / "+"<fmt:message key="COM01001L.user_name"/>"+" : " + $("#user_name").val()+"</b>";
			for (i = 0; i < rowCount; i++) {
				var rownum = table2.getData(0,i);
				var goods_name = table2.getData(1,i);
				var unit_price = formatNum(table2.getData(2,i));
				var qty = table2.getData(3,i);
				var sell_cost = formatNum(table2.getData(4,i));
				var tax1_amt = formatNum(table2.getData(5,i));
				var tax2_amt = formatNum(table2.getData(6,i));
				var tax3_amt = formatNum(table2.getData(7,i));
				var total_buy_amt = formatNum(table2.getData(8,i));
				var total_tax_amount = formatNum(table2.getData(9,i));
				
				grid += "	<tr>";
				grid += "		<td style='text-align:center;' class='td-report'>";
				grid += rownum;
				grid += "		</td>";
				grid += "		<td style='text-align:left;' class='td-report'>";
				grid += goods_name;
				grid += "		</td>";		
				grid += "		<td style='text-align:right;' class='td-report'>";
				grid += unit_price;
				grid += "		</td>";
				grid += "		<td style='text-align:center;' class='td-report'>";
				grid += qty;
				grid += "		</td>";
				grid += "		<td style='text-align:right;' class='td-report'>";
				grid += sell_cost;
				grid += "		</td>";
				grid += "		<td style='text-align:center;' class='td-report'>";
				grid += table2.getData(10,i);
				grid += "		</td>";
				grid += "		<td style='text-align:left;' class='td-report'>";
				grid += table2.getData(11,i);
				grid += "		</td>";
				grid += "	</tr>";
			}
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "<fmt:message key="COM01001L.total_buy_amt"/>";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += total_buy_amt+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "<fmt:message key="COM01001L.tax1_amt"/>";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += tax1_amt+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "<fmt:message key="COM01001L.tax2_amt"/>";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += tax2_amt+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "<fmt:message key="COM01001L.tax3_amt"/>";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += tax3_amt+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "<fmt:message key="COM01001L.total_tax_amount"/>";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += total_tax_amount+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "</table>";
		}
		$("#gridDiv").html(grid);
		$("#listTopDiv").html(listTop);
		
		display();
	}
	
	//송금조회 상세화면 조회
	function SearchProcessB() {

   		//고객기본정보, 매장기본저보, 환급방법정보 조회	
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/COM01001L04S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey",
	  			"NAME;NATIONALITY_NAME;PASSPORT_NO;PASSPORT_EXPIRYDATE;BIRTHDAY;"
	  		   +"GENDER_NAME;INPUT_WAY_NAME;SHOP_NAME;BIZ_PERMIT_NO;COMPANY_NAME;"
	  		   +"SELL_DATE;SELL_TIME;TEL_NO;REMIT_TYPE_CODE;REFUND_NO;"
	  		   +"REFUND_TYPE_CODE;REGISTER;REFUND_WAY_NAME;OUT_CUSTOMS_NAME;OUT_DATE;"+
	  		   "CUSTOMS_OUT_NO;OUT_DIVISION_NAME;");
	    table.setParameter("format",
	    		"str;str;str;str;str;"
				+"str;str;str;str;str;"
				+"str;str;str;str;str;"
				+"str;str;str;str;str"+
				"str;str;");
	    table.setParameter("buy_serial_no", $("#buy_serial_no").val());
      	table.request();
      	
        var rowCount = table.getCount();
        if (rowCount > 0) {
            $("#name").text(table.getData(0,0));
            $("#nationality_code").text(table.getData(1,0));
            $("#passport_no").text(table.getData(2,0));
            $("#passport_expirydate").text(formatDate(table.getData(3,0)));
            $("#birthday").text(formatDate(table.getData(4,0)));
            $("#gender_code").text(table.getData(5,0));
            $("#input_way_code").text(table.getData(6,0));
            $("#shop_name").text(table.getData(7,0));
            $("#biz_permit_no").text(formatBizRegNo(table.getData(8,0)));
            $("#company_name").text(table.getData(9,0));
            $("#sell_date").text(formatDate(table.getData(10,0)));
            $("#sell_time").text(formatTime(table.getData(11,0)));
            $("#tel_no").text(formatTelNo(table.getData(12,0)));
            $("#remit_type_code").val(table.getData(13,0));
            $("#refund_no").val(table.getData(14,0));
            $("#refund_type_code").val(table.getData(15,0));
            $("#register").val(table.getData(16,0));
            $("#out_customs_name").text(table.getData(17,0));
			$("#out_date").text(formatDate(table.getData(18,0)));
			$("#customs_out_no").text(table.getData(19,0));
			$("#out_division_name").text(table.getData(20,0));
        }
      	
		//구매내역 조회
		var table2 = new AW.XML.Table;
	  	table2.setURL("${contextPath}/service/simpleAction/COM01001L02S");
	  	table2.setAsync(false);
	  	table2.setRequestMethod("POST");
	  	table2.setParameter("outParamKey",
	  			"ROWNUM;GOODS_NAME;UNIT_PRICE;QTY;SELL_COST;TAX1_AMT;TAX2_AMT;TAX3_AMT;TOTAL_BUY_AMT;TOTAL_TAX_AMT");
	    table2.setParameter("format", "str;str;str;str;str;str;str;str;str;str;");
	    table2.setParameter("buy_serial_no", $("#buy_serial_no").val());
      	table2.request();
        
		var rowCount = table2.getCount();
		var grid = "";
		if (rowCount > 0) {
			grid += "<table border='0' cellpadding='2' cellspacing='0' width='100%' style='table-layout:fixed;'>";
			grid += "<colgroup>";
			grid += "	<col width='8%' />";
			grid += "	<col width='42%' />";
			grid += "	<col width='10%' />";
			grid += "	<col width='10%' />";
			grid += "	<col width='10%' />";
			grid += "	<col width='10%' />";
			grid += "	<col width='10%' />";
			grid += "</colgroup>";
			grid += "<thead>";
			grid += "	<tr>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.rownum"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.goods_name"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.unit_price"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.qty"/>";
			grid += "		</tdh>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.sell_cost"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.rct_no"/>";
			grid += "		</th>";
			grid += "		<th style='text-align:center;' class='td-cond'>";
			grid += "			"+"<fmt:message key="COM01001L.etc_info"/>";
			grid += "		</th>";
			grid += "	</tr>";
			grid += "</thead>";
			
			var listTop = "<b>"+"<fmt:message key="COM01001L.refund_no"/>"+" : " + table.getData(14, 0).trim() +" / "+"<fmt:message key="COM01001L.buy_serial_no"/>"+" : "  + $("#buy_serial_no").val() +" / "+"<fmt:message key="COM01001L.user_name"/>"+" : " + $("#register").val()+"</b>";
			for (i = 0; i < rowCount; i++) {
				var rownum = table2.getData(0,i);
				var goods_name = table2.getData(1,i);
				var unit_price = formatNum(table2.getData(2,i));
				var qty = table2.getData(3,i);
				var sell_cost = formatNum(table2.getData(4,i));
				var tax1_amt = formatNum(table2.getData(5,i));
				var tax2_amt = formatNum(table2.getData(6,i));
				var tax3_amt = formatNum(table2.getData(7,i));
				var total_buy_amt = formatNum(table2.getData(8,i));
				var total_tax_amount = formatNum(table2.getData(9,i));
				grid += "	<tr>";
				grid += "		<td style='text-align:left;' class='td-report'>";
				grid += rownum;
				grid += "		</td>";
				grid += "		<td style='text-align:left;' class='td-report'>";
				grid += goods_name;
				grid += "		</td>";		
				grid += "		<td style='text-align:right;' class='td-report'>";
				grid += unit_price;
				grid += "		</td>";
				grid += "		<td style='text-align:left;' class='td-report'>";
				grid += qty;
				grid += "		</td>";
				grid += "		<td style='text-align:right;' class='td-report'>";
				grid += sell_cost;
				grid += "		</td>";
				grid += "		<td style='text-align:center;' class='td-report'>";
				grid += table2.getData(10,i);
				grid += "		</td>";
				grid += "		<td style='text-align:left;' class='td-report'>";
				grid += table2.getData(11,i);
				grid += "		</td>";
				grid += "	</tr>";
			}
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "총판매액";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += total_buy_amt+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "부가세";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += tax1_amt+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "개별소비세";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += tax2_amt+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "교육세";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += tax3_amt+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "	<tr>";
			grid += "		<td style='text-align:left;' class='td-report'>";
			grid += "총세액";
			grid += "		</td>";
			grid += "		<td colspan='6' style='text-align:center;' class='td-report'>";
			grid += total_tax_amount+"<fmt:message key="COM01001L.won"/>";
			grid += "		</td>";
			grid += "	</tr>";
			grid += "</table>";
		
		}
		$("#gridDiv").html(grid);
		$("#listTopDiv").html(listTop);
		
		//환급방법 송금시 처리
		var table3 = new AW.XML.Table;
	  	table3.setURL("${contextPath}/service/simpleAction/COM01001L03S");
	  	table3.setAsync(false);
	  	table3.setRequestMethod("POST");
	  	table3.setParameter("outParamKey",
	  			"CARD_NO;VALIDPERIOD_YR;CARD_COMPANY_NAME;CSC;OWNER_NAME;"
	  		   +"BANK_NAME;COUNTRY_CODE;ACCOUNT_NO;SWIFT_CODE;ACC_HOLDER_NAME;"
	  		   +"TEL_NO;COUNTRY;ADDR;REMITTEE_NAME;REG_NO;");
	    table3.setParameter("format", "str;str;str;str;str;"
	    							+"str;str;str;str;str;"
	    							+"str;str;str;str;str;");
	    table3.setParameter("refund_no", $("#refund_no").val());
      	table3.request();
      	
        var rowCount = table3.getCount();
        if (rowCount > 0) {
        	if("${params.cardNoUser}"=="Y") {
        		$("#card_no").text(formatCardNoNonStar(table3.getData(0,0)));	
        	}
        	else {
        		$("#card_no").text(formatCardNo(table3.getData(0,0)));
        	}
            $("#validperiod_yr").text(table3.getData(1,0));
            $("#card_company_name").text(table3.getData(2,0));
            $("#csc").text(table3.getData(3,0));
            $("#owner_name").text(table3.getData(4,0));
            $("#bank_name").text(table3.getData(5,0));
            $("#country_code").text(table3.getData(6,0));
            $("#account_no").text(table3.getData(7,0));
            $("#swift_code").text(table3.getData(8,0));
            $("#acc_holder_name").text(table3.getData(9,0));
            $("#post_tel_no").text(formatTelNo(table3.getData(10,0)));
            $("#country").text(table3.getData(11,0));
            $("#addr").text(table3.getData(12,0));
            $("#remittee_name").text(table3.getData(13,0));
            $("#reg_no").text(table3.getData(14,0));
        }
	        
		display();
	}
	
</script>