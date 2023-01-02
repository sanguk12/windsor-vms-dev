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
        	<table border="0" cellpadding="0" cellspacing="0" width="100%">
           		<tr>
                   	<td height="1">
		            	<%@include file="../sys3/cms/standardParam.jsp" %>
		            	<%@include file="../sys3/cms/functionbar.jsp" %>
		            	<input type="hidden" id="prdSAPYN_YN" name="prdSAPYN_YN"/>
                   	</td>
               	</tr>
           		<tr>
	               	<td height="1">
                  		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
			        		<colgroup>
						    	<col style="width:150px"></col>
								<col style="width:250px"></col>
								<col style="width:150px"></col>
								<col></col>
						    </colgroup>
						    <tbody>
	                      	<tr>
	                  			<td class="td-cond">
									<fmt:message key="MDM03001B.categoryCD1" />
								</td>
	                           	<td class="td-input">
	                                 <nis:selectbox id="categoryCD1" defaultText="select" category="CATEGORYCD1" />
	                            </td>
	                            <td class="td-cond">
									<fmt:message key="MDM03001B.categoryCD2" />
								</td>	
								<td class="td-input">
									<div id="categoryCD2_cond" style="float:left;">
										<select id="categoryCD2">
											<option value=""><fmt:message key="select" /></option>
										</select>
									</div>
                                </td>
							<tr>
								<td class="td-cond">
									<fmt:message key="MDM03001B.categoryCD3" />
								</td>	
								<td class="td-input">
									<div id="categoryCD3_cond" style="float:left;">
										<select id="categoryCD3">
											<option value=""><fmt:message key="select" /></option>
										</select>
									</div>
                                </td>
                                <td class="td-cond">
									<fmt:message key="MDM03001B.categoryCD4" />
								</td>
								<td class="td-input">
									<div id="categoryCD4_cond" style="float:left;">
										<select id="categoryCD4">
											<option value=""><fmt:message key="select" /></option>
										</select>
									</div>
                                </td>
		        			</tr>
                           	<tr>
								<td class="td-cond">
									<fmt:message key="MDM03001B.categoryCD5" />
								</td>
								<td class="td-input">
									<div id="categoryCD5_cond" style="float:left;">
										<select id="categoryCD5">
											<option value=""><fmt:message key="select" /></option>
										</select>
									</div>
                                </td>
                                <td class="td-cond-required">
	                           		<fmt:message key="MDM03001B.dkRivalTpCD" />
      							</td>
      		 					<td class="td-input">
      		 						<nis:selectbox id="dkRivalTpCD" defaultText="select" category="DKRIVALTPCD" event="onchange" eventProc="chgDkRivalTpCD(this.value)" />
	       						</td>
   							</tr>
     						<tr>	
   								<td class="td-cond-required">
	                           		<fmt:message key="MDM03001B.prdCD" />
                         		</td>
     							<td class="td-input">
          							<input type="text" id="prdCD" class="input-readonly" style="width:100px;" readonly="readonly">
      							</td>
      							<td id="prdSAPCD_td" class="td-cond">
									<fmt:message key="MDM03001B.prdSAPCD" />
								</td>
								<td class="td-input">
									<input type="text" id="prdSAPCD" name="prdSAPCD" style="width:100px; ime-mode:disabled;" maxlength="7" />
                               	</td>
                           	</tr>
                           	<tr>
                           		<td class="td-cond-required">
									<fmt:message key="MDM03001B.prdShCD" />
								</td>
								<td class="td-input">
									<nis:selectbox id="prdShCD" defaultText="select" category="PRDSHCD" />
                               	</td>
                               	<td class="td-cond-required">
									<fmt:message key="MDM03001B.prdNm" />
								</td>
								<td class="td-input">
									<input type="text" id="prdNm" name="prdNm" style="width:200px;" maxlength="25" />
                              	</td>
                           	</tr>
							<tr>
								<td class="td-cond-required">
									<fmt:message key="MDM03001B.factoryPrice" />
								</td>
      							<td class="td-input">
									<input type="text" id="factoryPrice" name="factoryPrice" style="width:150px; text-align:right;" maxlength="13">
                               </td>
								<td class="td-cond-required">
	                           		<fmt:message key="MDM03001B.ml" />
	                           	</td>	
      							<td class="td-input">
									<input type="text" id="ml" name="ml" style="width:100px; text-align:right;" maxlength="5">
      							</td>
      						</tr>
      						<tr>
      							<td class="td-cond-required">
									<fmt:message key="MDM03001B.unit" />
								</td>
								<td class="td-input">
									<input type="text" id="unit" name="unit" style="width:100px; text-align:right;" maxlength="3">
                              	</td>
      							<td class="td-cond-required">
									<fmt:message key="MDM03001B.eu" />
								</td>
								<td class="td-input">
									<input type="text" id="eu" name="eu" style="width:100px; text-align:right;" maxlength="7">
                              	</td>
                           	</tr>
                          	<tr>
	                           	<td class="td-cond-required">
	                           		<fmt:message key="MDM03001B.sdxYN" />
	                           	</td>
      							<td class="td-input">
          							<nis:selectbox id="sdxYN" defaultText="select" category="SDXYN" />
      							</td>
                           		<td id="qtyUnitCD_td" class="td-cond">
	                           		<fmt:message key="MDM03001B.qtyUnitCD" />
      							</td>
      		 					<td class="td-input">
      		 						<nis:selectbox id="qtyUnitCD" defaultText="select" category="QTYUNITCD" />
	       						</td>
     						</tr>
     						<tr>
     							<td class="td-cond">
	                           		<fmt:message key="MDM03001B.kindTpCD1" />
	                           	</td>
      		 					<td class="td-input">
      								<nis:selectbox id="kindTpCD1" defaultText="select" category="KINDTPCD1" />
      							</td>
      							<td class="td-cond">
	                           		<fmt:message key="MDM03001B.kindTpCD2" />
      							</td>
      							<td class="td-input">
									<nis:selectbox id="kindTpCD2" defaultText="select" category="KINDTPCD2" />
	                           	</td>
      						</tr>
      						<tr>
      							<td class="td-cond">
	                           		<fmt:message key="MDM03001B.kindTpCD3" />
      							</td>
      							<td class="td-input">
									<nis:selectbox id="kindTpCD3" defaultText="select" category="KINDTPCD3" />
	                           	</td>
                           		<td class="td-cond">
	                           		<fmt:message key="MDM03001B.kindTpCD4" />
	                           	</td>
      		 					<td class="td-input">
      		 						<nis:selectbox id="kindTpCD4" defaultText="select" category="KINDTPCD4" />
      							</td>
                       		</tr>
                           	<tr>
                           		<td class="td-cond">
	                           		<fmt:message key="MDM03001B.kindTpCD5" />
      							</td>
      							<td class="td-input" colspan="3">
      								<nis:selectbox id="kindTpCD5" defaultText="select" category="KINDTPCD5" />
	                           	</td>
							</tr>
							<tr>
                           		<td class="td-cond-required">
	                           		<fmt:message key="MDM03001B.incntTpCD" />
      							</td>
      							<td class="td-input">
      								<nis:selectbox id="incntTpCD" defaultText="select" category="INCNTTPCD" />
	                           	</td>
                           		<td class="td-cond-required">
	                           		<fmt:message key="MDM03001B.activeYN" />
      							</td>
      							<td class="td-input">
									<nis:selectbox id="activeYN" defaultText="select" category="ACTIVEYN" />
	                           	</td>
							</tr>
							<tr>
                           		<td class="td-cond">
	                           		<fmt:message key="MDM03001B.angelPrd16CD" />
	                           	</td>
      		 					<td class="td-input">
									<input type="text" id="angelPrd16CD" name="angelPrd16CD" style="width:120px; ime-mode:disabled;" maxlength="10" />
      							</td>
      							<td class="td-cond">
	                           		<fmt:message key="MDM03001B.angelPrdMlCD" />
      							</td>
      							<td class="td-input">
									<input type="text" id="angelPrdMlCD" name="angelPrdMlCD" style="width:120px; ime-mode:disabled;" maxlength="10" />
	                           	</td>
                       		</tr>
                       		<tr>
                       			<td class="td-cond">
                       				<fmt:message key="MDM03001B.gsv" />
                       			</td>
                       			<td class="td-input">
                       				<input type="text" id="gsv" name="gsv" style="width:120px; text-align:right;" maxlength="10" />
                       			</td>
                       			<td class="td-cond">
                       				<fmt:message key="MDM03001B.wsdc" />
                       			</td>
                       			<td class="td-input">
                       				<input type="text" id="wsdc" name="wsdc" style="width:120px; text-align:right;" maxlength="10" />
                       			</td>
                       		</tr>
                       		<tr>
                       			<td class="td-cond">
                       				<fmt:message key="MDM03001B.cogs" />
                       			</td>
                       			<td class="td-input">
                       				<input type="text" id="cogs" name="cogs" style="width:120px; text-align:right;" maxlength="10" />
                       			</td>
                       			<td class="td-cond">
                       				<fmt:message key="MDM03001B.duty" />
                       			</td>
                       			<td class="td-input">
                       				<input type="text" id="duty" name="duty" style="width:120px; text-align:right;" maxlength="9" /> 
                       			</td>
                       		</tr>
                      		</tbody>
	        			</table>
	        		</td>
       			</tr>
 			</table>
 		</form>
    </body>
</html>

<script type="text/javascript">

	/****************************************
	* Variable
	****************************************/

	/****************************************
	* Function
	****************************************/
	
 	$(function() {
	 	try{$("#factoryPrice").numeric();}catch(e){}
	 	try{$("#ml").numeric();}catch(e){}
	 	try{$("#unit").numeric();}catch(e){}
	 	try{$("#eu").decimal();}catch(e){}
	 	try{$("#angelPrdMlCD").numeric();}catch(e){}
	 	try{$("#gsv").decimal();}catch(e){}
	 	try{$("#wsdc").decimal();}catch(e){}
	 	try{$("#cogs").decimal();}catch(e){}
	 	try{$("#duty").decimal();}catch(e){}
	});
	
	$(document).ready(function() {

		window.onload = function() {
			Search();
		};
		
		${initScript}

		$("#factoryPrice").blur(function(){
			$("#factoryPrice").val(formatNum($("#factoryPrice").val()));
		});	
		
		$("#factoryPrice").focus(function(){
			$("#factoryPrice").val(unformat($("#factoryPrice").val()));
// 			$("#factoryPrice").select();
		});
		
		$("#ml").blur(function(){
			$("#ml").val(formatNum($("#ml").val()));
		});	
		
		$("#ml").focus(function(){
			$("#ml").val(unformat($("#ml").val()));
		});
		
		$("#unit").blur(function(){
			$("#unit").val(formatNum($("#unit").val()));
		});	
		
		$("#unit").focus(function(){
			$("#unit").val(unformat($("#unit").val()));
		});
		
		$("#eu").blur(function(){
			
			if (gatherIntFloat($("#eu").val(),6,5)) {
				
             	$("#eu").val(formatDecimal($("#eu").val()));
             	
			} else {
				n = $("#eu").val().split(".");
				
				if(n[0].length > 1) {
					
					$("#eu").val($("#eu").val().substring(0,1));
					this.focus(); 
					
				} else if(n[0].length == 1) {
					
					$("#eu").val(formatDecimal(roundXL(parseFloat($("#eu").val())),2));
					this.focus(); 
					
				} else if(n[0].length < 1) {
					
					$("#eu").val("");
					this.focus(); 
				}
			}
		});
		
		// 3자리수 마다 , 찍기
		$("#angelPrdMlCD").blur(function(){
			$("#angelPrdMlCD").val(formatNum($("#angelPrdMlCD").val()));
		});	
		
		// 3자리수 마다 ,찍기 없애기
		$("#angelPrdMlCD").focus(function(){
			$("#angelPrdMlCD").val(unformat($("#angelPrdMlCD").val()));
		});
		
	
		// 소수점 2자리수 까지 출력하기, 전체자리수 7자리 이하로 출력
		$("#gsv").blur(function(){
			if (gatherIntFloat($("#gsv").val(), 9, 2)) {
				
             	$("#gsv").val(formatDecimal($("#gsv").val()));
			
			} else {
				n = $("#gsv").val().split(".");
				
				if(n[0].length > 7) {
					
					$("#gsv").val($("#gsv").val().substring(0,7));
					this.focus(); 
			
				} else if(n[0].length == 7) {
					
					$("#gsv").val(formatDecimal(roundXL(parseFloat($("#gsv").val())),2));
					this.focus(); 
					
				} else if(n[0].length < 7) {
					
					$("#gsv").val("");
					this.focus(); 
				}
			}
		});
		
		$("#gsv").focus(function(){
			$("#gsv").val(unformatNum($("#gsv").val()));
		});
	
		$("#wsdc").blur(function(){
		
			if (gatherIntFloat($("#wsdc").val(), 9, 2)) {
				
             	$("#wsdc").val(formatDecimal($("#wsdc").val()));
			
			} else {
				n = $("#wsdc").val().split(".");
				
				if(n[0].length > 7) {
					
					$("#wsdc").val($("#wsdc").val().substring(0,7));
					this.focus(); 
			
				} else if(n[0].length == 7) {
					
					$("#wsdc").val(formatDecimal(roundXL(parseFloat($("#wsdc").val())),2));
					this.focus(); 
					
				} else if(n[0].length < 7) {
					
					$("#wsdc").val("");
					this.focus(); 
				}
			}
		});
		
		$("#wsdc").focus(function(){
			$("#wsdc").val(unformatNum($("#wsdc").val()));
		});
	
		$("#cogs").blur(function(){
		
			if (gatherIntFloat($("#cogs").val(), 9, 2)) {
				
             	$("#cogs").val(formatDecimal($("#cogs").val()));
			
			} else {
				n = $("#cogs").val().split(".");
				
				if(n[0].length > 7) {
					
					$("#cogs").val($("#cogs").val().substring(0,7));
					this.focus(); 
			
				} else if(n[0].length == 7) {
					
					$("#cogs").val(formatDecimal(roundXL(parseFloat($("#cogs").val())),2));
					this.focus(); 
					
				} else if(n[0].length < 7) {
					
					$("#cogs").val("");
					this.focus(); 
				}
			}
		});
		
		$("#cogs").focus(function(){
			$("#cogs").val(unformatNum($("#cogs").val()));
		});
	
		$("#duty").blur(function() {
		
			if (gatherIntFloat($("#duty").val(), 9, 2)) {
				
             	$("#duty").val(formatDecimal($("#duty").val()));
			
			} else {
				n = $("#duty").val().split(".");
				
				if(n[0].length > 7) {
					
					$("#duty").val($("#duty").val().substring(0,7));
					this.focus(); 
			
				} else if(n[0].length == 7) {
					
					$("#duty").val(formatDecimal(roundXL(parseFloat($("#duty").val())),2));
					this.focus(); 
					
				} else if(n[0].length < 7) {
					
					$("#duty").val("");
					this.focus(); 
				}
			}

		});
		
		$("#duty").focus(function(){
			$("#duty").val(unformatNum($("#duty").val()));
		});
		
		
	});// documetReady 종료
	
	$("#categoryCD1").change(function() {
		refresh_categoryCD2();
	});
	
	function refresh_categoryCD2() {
		if($("#categoryCD1").val()=="") {
			$("#categoryCD2").val("");
			$("#categoryCD2").attr("disabled",true);
    		$("#categoryCD2").addClass("input-readonly");
    		$("#categoryCD3").val("");
			$("#categoryCD3").attr("disabled",true);
    		$("#categoryCD3").addClass("input-readonly");
    		$("#categoryCD4").val("");
			$("#categoryCD4").attr("disabled",true);
    		$("#categoryCD4").addClass("input-readonly");
    		$("#categoryCD5").val("");
			$("#categoryCD5").attr("disabled",true);
    		$("#categoryCD5").addClass("input-readonly");
			return;
		}
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "CATEGORYCD2");
        table.setParameter("attrib02", $("#categoryCD1").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='categoryCD2' style='width:180px;' onchange='refresh_categoryCD3()'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            $("#categoryCD2").attr("disabled",false);
    		$("#categoryCD2").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#categoryCD2_cond").html(s);
        
     	$("#categoryCD3").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#categoryCD3").attr("disabled",true);
   		$("#categoryCD3").addClass("input-readonly");
   		$("#categoryCD4").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#categoryCD4").attr("disabled",true);
   		$("#categoryCD4").addClass("input-readonly");
   		$("#categoryCD5").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#categoryCD5").attr("disabled",true);
   		$("#categoryCD5").addClass("input-readonly");
	}
	
	function refresh_categoryCD3() {
		if($("#categoryCD2").val()=="") {
    		$("#categoryCD3").val("");
			$("#categoryCD3").attr("disabled",true);
    		$("#categoryCD3").addClass("input-readonly");
    		$("#categoryCD4").val("");
			$("#categoryCD4").attr("disabled",true);
    		$("#categoryCD4").addClass("input-readonly");
    		$("#categoryCD5").val("");
			$("#categoryCD5").attr("disabled",true);
    		$("#categoryCD5").addClass("input-readonly");
			return;
		}
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "CATEGORYCD3");
        table.setParameter("attrib02", $("#categoryCD2").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='categoryCD3' style='width:180px;' onchange='refresh_categoryCD4()'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            $("#categoryCD3").attr("disabled",false);
    		$("#categoryCD3").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#categoryCD3_cond").html(s);
        
        $("#categoryCD4").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#categoryCD4").attr("disabled",true);
   		$("#categoryCD4").addClass("input-readonly");
   		$("#categoryCD5").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#categoryCD5").attr("disabled",true);
   		$("#categoryCD5").addClass("input-readonly");
	}
	
	function refresh_categoryCD4() {
		if($("#categoryCD3").val()=="") {
    		$("#categoryCD4").val("");
			$("#categoryCD4").attr("disabled",true);
    		$("#categoryCD4").addClass("input-readonly");
    		$("#categoryCD5").val("");
			$("#categoryCD5").attr("disabled",true);
    		$("#categoryCD5").addClass("input-readonly");
			return;
		}
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "CATEGORYCD4");
        table.setParameter("attrib02", $("#categoryCD3").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='categoryCD4' style='width:180px;' onchange='refresh_categoryCD5()'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            $("#categoryCD4").attr("disabled",false);
    		$("#categoryCD4").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#categoryCD4_cond").html(s);
        
        $("#categoryCD5").find("option").remove().end().append('<option value=""><fmt:message key="select"/></option>');
    	$("#categoryCD5").attr("disabled",true);
   		$("#categoryCD5").addClass("input-readonly");
        
	}
	
	function refresh_categoryCD5() {
		if($("#categoryCD4").val()=="") {
    		$("#categoryCD5").val("");
			$("#categoryCD5").attr("disabled",true);
    		$("#categoryCD5").addClass("input-readonly");
			return;
		}
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/SYS0001S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","comCode;codeName;");
        table.setParameter("codeDiv", "CATEGORYCD5");
        table.setParameter("attrib02", $("#categoryCD4").val());
        table.request();
        
        var rowCount = table.getCount();
        var s = "<select id='categoryCD5'><option value=''><fmt:message key="select"/></option>";
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++) {
                s = s + '<option value=' + table.getData(0,i) + '>'+table.getData(1,i)+'</option>';
            }
            $("#categoryCD5").attr("disabled",false);
    		$("#categoryCD5").removeClass("input-readonly");
        }
        s = s + '</select>';
        
        $("#categoryCD5_cond").html(s);
	}
	
	function chgDkRivalTpCD(val) {
		if(val == "DK") {
			try{$("#prdSAPCD_td").addClass("td-cond-required")}catch(e){}
			try{$("#qtyUnitCD_td").addClass("td-cond-required")}catch(e){}
		}
		else {
			try{$("#prdSAPCD_td").removeClass("td-cond-required")}catch(e){}
			try{$("#qtyUnitCD_td").removeClass("td-cond-required")}catch(e){}
		}
	}
  	
</script>    
	
<script type="text/javascript">

    /****************************************
    * Button Action
    ****************************************/
   
    function New() {
//     	$("#overLap").show();
    	$("#categoryCD1").val("");
    	$("#categoryCD2").val("");
    	$("#categoryCD3").val("");
    	$("#categoryCD4").val("");
    	$("#categoryCD5").val("");
    	$("#prdCD").val("");
    	$("#prdSAPCD").val("");
    	$("#prdShCD").val("");
    	$("#prdNm").val("");
    	$("#factoryPrice").val("");
    	$("#ml").val("");
    	$("#unit").val("");
    	$("#eu").val("");
    	$("#sdxYN").val("");
    	$("#qtyUnitCD").val("");
    	$("#dkRivalTpCD").val("");
    	chgDkRivalTpCD($("#dkRivalTpCD").val());
    	$("#kindTpCD1").val("");
    	$("#kindTpCD2").val("");
    	$("#kindTpCD3").val("");
    	$("#kindTpCD4").val("");
    	$("#kindTpCD5").val("");
    	$("#incntTpCD").val("");
    	$("#activeYN").val("");
    	$("#angelPrd16CD").val("");
    	$("#angelPrdMlCD").val("");
    	$("#gsv").val("");
    	$("#wsdc").val("");
    	$("#cogs").val("");
    	$("#duty").val("");
    	
    	
    	$("#categoryCD2").attr("disabled",true);
		$("#categoryCD2").addClass("input-readonly");
		$("#categoryCD3").attr("disabled",true);
		$("#categoryCD3").addClass("input-readonly");
		$("#categoryCD4").attr("disabled",true);
		$("#categoryCD4").addClass("input-readonly");
		$("#categoryCD5").attr("disabled",true);
		$("#categoryCD5").addClass("input-readonly");
    }
    
    var _i = 0;
	var _col = {
		categoryCD1 : _i++
		, categoryCD2 : _i++
		, categoryCD3 : _i++
		, categoryCD4 : _i++
		, categoryCD5 : _i++
 		, prdCD : _i++
		, prdSAPCD : _i++
		, prdShCD : _i++
		, prdNm : _i++
		, factoryPrice : _i++
 		, ml : _i++
 		, unit : _i++
		, eu : _i++
		, sdxYN : _i++
		, qtyUnitCD : _i++
		, dkRivalTpCD : _i++
		, kindTpCD1 : _i++
		, kindTpCD2 : _i++
		, kindTpCD3 : _i++
		, kindTpCD4 : _i++
		, kindTpCD5 : _i++
		, incntTpCD : _i++
		, activeYN : _i++
		, angelPrd16CD : _i++
		, angelPrdMlCD : _i++
		, gsv : _i++
		, wsdc : _i++
		, cogs : _i++
		, duty : _i++
	};
	
    function Search() {
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/MDM0300101S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","categoryCD1;categoryCD2;categoryCD3;categoryCD4;categoryCD5;"+
				"prdCD;prdSAPCD;prdShCD;prdNm;factoryPrice;"+
				"ml;unit;eu;sdxYN;qtyUnitCD;"+
				"dkRivalTpCD;kindTpCD1;kindTpCD2;kindTpCD3;kindTpCD4;"+
				"kindTpCD5;incntTpCD;activeYN;angelPrd16CD;angelPrdMlCD;gsv;wsdc;cogs;duty;");
		table.setParameter("format","str;str;str;str;str;"+
				"str;str;str;str;num;"+
				"num;num;num5;str;str;"+
				"str;str;str;str;str;"+
				"str;str;str;str;num;"+
				"num2;num2;num2;num2;");
        table.setParameter("prdCD", $("#prdCD").val());
        table.request();
            
        var rowCount = table.getCount();
      	if (rowCount == 1) {

   			$("#categoryCD1").val(table.getData(_col.categoryCD1,0));
   			refresh_categoryCD2();
    		$("#categoryCD2").val(table.getData(_col.categoryCD2,0));
   			refresh_categoryCD3();
    		$("#categoryCD3").val(table.getData(_col.categoryCD3,0));
   			refresh_categoryCD4();
    		$("#categoryCD4").val(table.getData(_col.categoryCD4,0));
   			refresh_categoryCD5();
    		$("#categoryCD5").val(table.getData(_col.categoryCD5,0));
    		$("#prdCD").val(table.getData(_col.prdCD,0));
    		$("#prdSAPCD").val(table.getData(_col.prdSAPCD,0));
    		$("#prdShCD").val(table.getData(_col.prdShCD,0));   
    		$("#prdNm").val(table.getData(_col.prdNm,0));
    		$("#factoryPrice").val(table.getData(_col.factoryPrice,0));
    		$("#ml").val(table.getData(_col.ml,0));
    		$("#unit").val(table.getData(_col.unit,0));
    		$("#eu").val(table.getData(_col.eu,0));
    		$("#sdxYN").val(table.getData(_col.sdxYN,0));
    		$("#qtyUnitCD").val(table.getData(_col.qtyUnitCD,0));
    		$("#dkRivalTpCD").val(table.getData(_col.dkRivalTpCD,0));
    		
    		if($("#dkRivalTpCD").val() == "DK") {
    			try{$("#prdSAPCD_td").addClass("td-cond-required")}catch(e){}
    			try{$("#qtyUnitCD_td").addClass("td-cond-required")}catch(e){}
    		}
    		else {
    			try{$("#prdSAPCD_td").removeClass("td-cond-required")}catch(e){}
    			try{$("#qtyUnitCD_td").removeClass("td-cond-required")}catch(e){}
    		}
    		
    		$("#kindTpCD1").val(table.getData(_col.kindTpCD1,0));
    		$("#kindTpCD2").val(table.getData(_col.kindTpCD2,0));
    		$("#kindTpCD3").val(table.getData(_col.kindTpCD3,0));
    		$("#kindTpCD4").val(table.getData(_col.kindTpCD4,0));
    		$("#kindTpCD5").val(table.getData(_col.kindTpCD5,0));
    		$("#incntTpCD").val(table.getData(_col.incntTpCD,0));
    		$("#activeYN").val(table.getData(_col.activeYN,0));
    		$("#angelPrd16CD").val(table.getData(_col.angelPrd16CD,0));
    		$("#angelPrdMlCD").val(table.getData(_col.angelPrdMlCD,0));
    		$("#gsv").val(table.getData(_col.gsv,0));
    		$("#wsdc").val(table.getData(_col.wsdc,0));
    		$("#cogs").val(table.getData(_col.cogs,0));
    		$("#duty").val(table.getData(_col.duty,0));
     	}
	}
    
    function Save(){
		if ($("#prdShCD").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg1" />");
	   		$("#prdShCD").focus();
			return;
	   	}
	   	if ($("#prdNm").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg2" />");
	   		$("#prdNm").focus();
			return;
	   	}
	   	if ($("#factoryPrice").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg3" />");
	   		$("#factoryPrice").focus();
			return;
	   	}
	   	if ($("#ml").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg4" />");
	   		$("#ml").focus();
			return;
	   	}
	   	if ($("#unit").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg5" />");
	   		$("#unit").focus();
			return;
	   	}
	   	if ($("#eu").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg6" />");
	   		$("#eu").focus();
			return;
	   	}
	   	if ($("#sdxYN").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg7" />");
	   		$("#sdxYN").focus();
			return;
	   	}
	   	if ($("#qtyUnitCD").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg8" />");
	   		$("#qtyUnitCD").focus();
			return;
	   	}
	   	if ($("#dkRivalTpCD").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg9" />");
	   		$("#dkRivalTpCD").focus();
			return;
	   	}
	   	if($("#dkRivalTpCD").val() == "DK") {
	   		if ($("#prdSAPCD").val() == ""){
    	   		alert("<fmt:message key="MDM03001B.msg17" />");
    	   		$("#prdSAPCD").focus();
    			return;
    	   	}
	   		if ($("#qtyUnitCD").val() == ""){
    	   		alert("<fmt:message key="MDM03001B.msg19" />");
    	   		$("#qtyUnitCD").focus();
    			return;
    	   	}
		}
	   	if ($("#incntTpCD").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg18" />");
	   		$("#incntTpCD").focus();
			return;
	   	}
	   	if ($("#activeYN").val() == ""){
	   		alert("<fmt:message key="MDM03001B.msg10" />");
	   		$("#activeYN").focus();
			return;
	   	}

	   	
       	var table = new AW.XML.Table;     
       	table.setURL("${contextPath}/service/mdm03/savePrdinfo");
       	table.setAsync(false);
       	table.setRequestMethod("POST");
       	table.setParameter("categoryCD1",$("#categoryCD1").val());
       	table.setParameter("categoryCD2",$("#categoryCD2").val());
       	table.setParameter("categoryCD3",$("#categoryCD3").val());
       	table.setParameter("categoryCD4",$("#categoryCD4").val());
       	table.setParameter("categoryCD5",$("#categoryCD5").val());
       	table.setParameter("prdCD",$("#prdCD").val());
   		table.setParameter("prdSAPCD",$("#prdSAPCD").val());
       	table.setParameter("prdShCD",$("#prdShCD").val());
       	table.setParameter("prdNm",$("#prdNm").val());
       	table.setParameter("factoryPrice", unformat($("#factoryPrice").val()));
       	table.setParameter("ml", unformat($("#ml").val()));
       	table.setParameter("unit", unformat($("#unit").val()));
       	table.setParameter("eu", $("#eu").val());
       	table.setParameter("sdxYN",$("#sdxYN").val());
       	table.setParameter("qtyUnitCD",$("#qtyUnitCD").val());
       	table.setParameter("dkRivalTpCD",$("#dkRivalTpCD").val());
       	table.setParameter("kindTpCD1",$("#kindTpCD1").val());
       	table.setParameter("kindTpCD2",$("#kindTpCD2").val());
       	table.setParameter("kindTpCD3",$("#kindTpCD3").val());
       	table.setParameter("kindTpCD4",$("#kindTpCD4").val());
       	table.setParameter("kindTpCD5",$("#kindTpCD5").val());
       	table.setParameter("incntTpCD",$("#incntTpCD").val());
       	table.setParameter("activeYN",$("#activeYN").val());
       	table.setParameter("angelPrd16CD",$("#angelPrd16CD").val());
       	table.setParameter("angelPrdMlCD", unformat($("#angelPrdMlCD").val()));
       	table.setParameter("gsv", $("#gsv").val());
       	table.setParameter("wsdc", $("#wsdc").val());
       	table.setParameter("cogs", $("#cogs").val());
       	table.setParameter("duty", $("#duty").val());
       	
       	table.request();
       
       	var rowCount = table.getCount();
       	if (rowCount > 0) {
          	if (table.getData(0,0) == 'S') {
			$("#prdCD").val(table.getData(3,0));
          	message(table.getData(1,0));
            Search();
           	} else {
           		alert(table.getData(1,0));
          	}
      	}
	}
    
    function List() {
    	parent.appletClose();
    	parent.Search();
	}
    
</script>    