<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../scripts.jsp" %>
	</head>

    <body class="yui-skin-sam" ${bodyConfig}>
        <form name="form" method="post" action="partner.do" enctype="multipart/form-data">
        	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1">
			            <!-- Standard Parameter - START -->
			            <input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
			            <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
			            <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
			            <input type="hidden" id="method" name="method">
			            <!-- Standard Information - END -->
			    
			            <!-- Function Bar - Title & Button -->
			            <%@include file="../cms/functionbar.jsp" %>
    				</td>
                </tr>
                <tr>
                    <td class="pd" height="1">
                    	<table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td class="tb-border">
						        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
										<tr>
											<td class="td-cond" width="80"><fmt:message key="companyCD" /></td>
											<td class="td-input" width="210">
												<input id="companyCD" name="companyCD" type="text" class="input-required" style="width:200px; ime-mode:disabled;">
											</td>
											<td class="td-cond" width="80"><fmt:message key="companyName" /></td>
											<td class="td-input" width="210">
												<input id="companyName" name="companyName" type="text" class="input-required" style="width:200px;">
											</td>
											<td class="td-cond" width="80"><fmt:message key="reprName" /></td>
											<td class="td-input" width="*">
												<input id="reprName" name="reprName" type="text" style="width:200px;">
											</td>
										</tr>
										<tr>
											<td class="td-cond"><fmt:message key="bizRegNo" /></td>
											<td class="td-input">
												<input id="bizRegNo" name="bizRegNo" type="text" class="input-required"  style="width:200px; ime-mode:disabled;" onfocus="this.value=unformat(this.value);this.select();" onblur="this.value=formatBizRegNo(this.value);">
											</td>
											<td class="td-cond"><fmt:message key="sangho" /></td>
											<td class="td-input">
												<input id="sangho" name="sangho" type="text" style="width:200px;">
											</td>
											<td class="td-cond"><fmt:message key="bizCond" /></td>
											<td class="td-input">
												<input id="bizCond" name="bizCond" type="text" style="width:200px;">
											</td>
										</tr>
										<tr>
											<td class="td-cond"><fmt:message key="bizItem" /></td>
											<td class="td-input">
												<input id="bizItem" name="bizItem" type="text" style="width:200px;">
											</td>
											<td class="td-cond"><fmt:message key="closeYN" /></td>
											<td class="td-input">
												<nis:radio id="closeYN" name="closeYN" category="USETYPE3CD" value="N"/>
											</td>
											<td class="td-cond"><fmt:message key="homepageURL" /></td>
											<td class="td-input">
												<input id="homepageURL" name="homepageURL" type="text" style="width:200px;">
											</td>
										</tr>
										<tr>
											<td class="td-cond"><fmt:message key="address" /></td>
											<td class="td-input" colspan="5">
												<input id="zipCode" name="zipCode" type="text" class="input-readonly"  style="width:80px; text-align:center;" readnly="readonly"><img id="VKGRP_POPUP" src="${themeURL}/images/btn/search_popup.gif" hspace="3" style="vertical-align:middle; cursor:pointer" onclick="openAddressPopup('closeAddressPopup')">
			                                    <input id="addr1" name="addr1" type="text" class="input-readonly" style="width:250px" readonly="readonly">
			                                    <input id="addr2" name="addr2" type="text" style="width:200px">
											</td>
										</tr>
										<tr>
											<td class="td-cond"><fmt:message key="telNo" />1</td>
											<td class="td-input">
												<input id="telNo1" name="telNo1" type="text" class="input-required"  style="width:120px; ime-mode:disabled;">
											</td>
											<td class="td-cond"><fmt:message key="telNo" />2</td>
											<td class="td-input">
												<input id="telNo2" name="telNo2" type="text" style="width:120px; ime-mode:disabled;">
											</td>
											<td class="td-cond"><fmt:message key="faxNo" /></td>
											<td class="td-input">
												<input id="faxNo" name="faxNo" type="text" style="width:120px; ime-mode:disabled;">
											</td>
										</tr>
										<tr>
											<td class="td-cond"><fmt:message key="remark" /></td>
											<td class="td-input" colspan="5">
												<textarea id="remark" name="remark" style="width:600px; height:100px;"></textarea>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="*">
				        <input type="hidden" id="companyID" name="companyID" value="${params.companyID}">
			            <input type="hidden" id="searchWord" name="searchWord" value="${params.searchWord}">
			            <input type="hidden" id="initAction" name="initAction">
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
    
    function openAddressPopup(finalAction) {
        var url = "simpleCommand.do?mnuGrpID="+document.getElementById("mnuGrpID").value+"&pgmID="+document.getElementById("pgmID").value+"&viewID=AddressPopup&finalAction="+finalAction;
        newWindow(url, "addresspopup",550,400,"yes");
        //newWindow(url, "orgpopup",550,400,"yes");
        
    };
    
    function closeAddressPopup(data) {
		$("#zipCode").val(data.zipCode);
		$("#addr1").val(data.address);
		$("#addr2").focus();
    }
    
    /****************************************
    * Button Action
    ****************************************/

    function Delete(){
        if (confirm("<fmt:message key="confirm.delete"/>")) {
            showLoading();
        
	        var table = new AW.XML.Table;
	        table.setURL("company.do");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("method","removeCompany");
	        table.setParameter("companyID", document.getElementById("companyID").value);
	        
	        table.request();
	        
	        hideLoading();
	        
	        message(table.getData(1,0));
	        
	        if (table.getData(0,0) == 'S') {
	            List();
	        }
        }
    }
        
    function List(){
        document.form.action = "simpleCommand.do";
        $("#viewID").val("CMP01005A");
        $("#initAction").val("Search");
        document.form.submit();
    }
    
    
    function Search(){

        var table = new AW.XML.Table;     
        table.setURL("simpleAction.do");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("actionKey","search");   // search, save (add, remove, modify, update)
        table.setParameter("resultType","XML"); // List, Map, XML
        table.setParameter("resultURL","");     // ModelAndView
        table.setParameter("queryKey","commonservice.auth.company.select");
        table.setParameter("companyID", document.getElementById("companyID").value);
        table.request();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            //Search
            var i = 0;
            document.getElementById("companyID").value = table.getData(i++,0);
            document.getElementById("companyCD").value = table.getData(i++,0);
            document.getElementById("companyName").value = table.getData(i++,0);
            document.getElementById("reprName").value = table.getData(i++,0);
            document.getElementById("bizRegNo").value = formatBizRegNo(table.getData(i++,0));
            document.getElementById("sangho").value = table.getData(i++,0);
            document.getElementById("bizCond").value = table.getData(i++,0);
            document.getElementById("bizItem").value = table.getData(i++,0);
            document.getElementById("zipCode").value = formatZipCode(table.getData(i++,0));
            document.getElementById("addr1").value = table.getData(i++,0);
            document.getElementById("addr2").value = table.getData(i++,0);
            document.getElementById("telNo1").value = table.getData(i++,0);
            document.getElementById("telNo2").value = table.getData(i++,0);
            document.getElementById("faxNo").value = table.getData(i++,0);
            document.getElementById("homepageURL").value = table.getData(i++,0);
            setRadioValue(document.form.closeYN, table.getData(i++,0));
            document.getElementById("remark").value = table.getData(i++,0);
        } else {
            // Init
            message("<fmt:message key="info.nullData"/>");
        }
    }
    
    function Save(){
        
        if (confirm("<fmt:message key="confirm.save"/>")) {
	        showLoading();
	        
	        var table = new AW.XML.Table;
	        table.setURL("company.do");
	        table.setAsync(false);
	        table.setRequestMethod("POST");
	        table.setParameter("method","saveCompany");
	        table.setParameter("companyID", document.getElementById("companyID").value);
	        table.setParameter("companyCD", document.getElementById("companyCD").value);
	        table.setParameter("companyName", document.getElementById("companyName").value);
	        table.setParameter("reprName", document.getElementById("reprName").value);
	        table.setParameter("bizRegNo", unformat(document.getElementById("bizRegNo").value));
	        table.setParameter("sangho", document.getElementById("sangho").value);
	        table.setParameter("bizCond", document.getElementById("bizCond").value);
	        table.setParameter("bizItem", document.getElementById("bizItem").value);
	        table.setParameter("zipCode", unformat(document.getElementById("zipCode").value));
	        table.setParameter("addr1", document.getElementById("addr1").value);
	        table.setParameter("addr2", document.getElementById("addr2").value);
	        table.setParameter("telNo1", document.getElementById("telNo1").value);
	        table.setParameter("telNo2", document.getElementById("telNo2").value);
	        table.setParameter("faxNo", document.getElementById("faxNo").value);
	        table.setParameter("homepageURL", document.getElementById("homepageURL").value);
	        table.setParameter("closeYN", getRadioValue(document.form.closeYN));
	        table.setParameter("remark", document.getElementById("remark").value);
	        
	        table.request();
	        
	        hideLoading();
	        
	        if (table.getData(0,0) == 'S') {
	            message(table.getData(1,0));
	            document.getElementById("companyID").value = table.getData(3,0);
	            Search();
	        }
	        else
	        {
	           alert(table.getData(1,0));
	        }
        }
    }
    


</script>

<script type="text/javascript">
<!--
    <c:if test="${!empty params.initAction}">
        ${params.initAction}();
    </c:if>
//-->
</script>