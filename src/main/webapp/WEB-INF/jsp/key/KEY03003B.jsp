<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title>${params.viewName}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="Pragma" content="no-cache">
        <%@include file="../sys3/scripts.jsp" %>
    </head>

	<body class="yui-skin-sam" ${bodyConfig}>
    	<form name="form" method="post"> 
			<div id="wrapDiv">
          		<div id="formDiv">
            		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                		<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/functionbar.jsp" %>
								<%@include file="../sys3/cms/calendar.jsp" %>
		                    	<input type="hidden" id="nextAction" name="nextAction" />
		                    	<input type="hidden" id="keyMan" name="keyMan" />
		                    </td>
		                </tr>
		                <tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:70px;"></col>
								        			<col style="width:260px;"></col>
								        			<col style="width:70px;"></col>
								        			<col style="width:260px;"></col>
								        			<col style="width:70px;"></col>
								        			<col style="width:120px;"></col>
								        			<col style="width:100px;"></col>
								        			<col style="width:120px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
						                            <tr>
														<td class="td-cond">
															<fmt:message key="KEY03003B.venue" />
														</td>
														<td class="td-input">
															<input type="text" id="venueCD_S" name="venueCD_S" style="width:120px; text-align: center;" class="input-readonly" readonly="readonly"/>
															<input type="text" id="venueNm_S" name="venueNm_S" style="width:120px;" class="input-readonly" readonly="readonly"/>
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03003B.keymanID" />
														</td>
														<td class="td-input">
															<input type="text" id="keyManCD_S" name="keyManCD_S" style="width:120px; text-align: center;" class="input-readonly" readonly="readonly"/>
															<input type="text" id="keyManNm_S" name="keyManNm_S" style="width:120px;" class="input-readonly" readonly="readonly"/>
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03003B.birthDate" />
														</td>
														<td class="td-input">
															<input type="text" id="birthDay_S" name="birthDay_S" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly"/>
						                                </td>
						                                <td class="td-cond">
															<fmt:message key="KEY03003B.docCompleteYn" />
														</td>
														<td class="td-input" colspan="2">
															<input type="hidden" id=DocFinshFl name="DocFinshFl" style="width:100px;" class="input-readonly" readonly="readonly"/>
															<input type="text" id="DocFinshFlNm" name="DocFinshFlNm" style="width:100px; text-align: center;" class="input-readonly" readonly="readonly"/>
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
		                    <td height="*">
		                    	<div id="tabs" class="yui-navset tb-border" style="width:100%;height:100%;">
					                <ul class="yui-nav">
					                    <li class="selected" id="li_tab1"><a href="#tab1" onclick="changeTab(1)" id="li_tab1_click"><em><fmt:message key="KEY03003B.personInfoAgreeDoc"/></em></a></li>
					                    <li id="li_tab2"><a href="#tab2" onclick="changeTab(2)" id="li_tab2_click"><em><fmt:message key="KEY03003B.programAgreeDoc"/></em></a></li>
					                    <li id="li_tab3"><a href="#tab3" onclick="changeTab(3)" id="li_tab3_click"><em><fmt:message key="KEY03003B.saleRegistDoc"/></em></a></li>
					                    <li id="li_tab4"><a href="#tab4" onclick="changeTab(4)" id="li_tab4_click"><em><fmt:message key="KEY03003B.entrustDoc"/></em></a></li>
					                </ul>            
					                <div class="yui-content" >
					                    <div id="tab1" style="padding-top:10px;">
					                    	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
					                            <tr>
					                                <td valign="top">
					                                    <iframe id="_tab1" name="_tab1" style="width:100%; height:400px;" frameborder="0" scrolling="yes"></iframe>   
					                                </td>
					                            </tr>                         
					                        </table>
					                    </div>                
					                    <div id="tab2" style="padding-top:10px;"> 
					                        <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
					                            <tr>
					                                <td valign="top">
					                                    <iframe id="_tab2" name="_tab2" style="width:100%; height:400px;" frameborder="0" scrolling="yes"></iframe>   
					                                </td>
					                            </tr>                         
					                        </table>
					                    </div>
					                    <div id="tab3" style="padding-top:10px;">
					                        <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
					                            <tr>
					                                <td valign="top">
					                                    <iframe id="_tab3" name="_tab3" style="width:100%; height:400px;" frameborder="0" scrolling="yes"></iframe>   
					                                </td>
					                            </tr>                        
					                        </table>
					                    </div>
					                    <div id="tab4" style="padding-top:10px;">
					                        <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
					                            <tr>
					                                <td valign="top">
					                                    <iframe id="_tab4" name="_tab4" style="width:100%; height:400px;" frameborder="0" scrolling="yes"></iframe>   
					                                </td>
					                            </tr>                        
					                        </table>
					                    </div>
					                </div>
					            </div>
					            <script type="text/javascript">
					                var tabView = new YAHOO.widget.TabView('tabs');
					            </script>
		                    </td>
                		</tr>
            		</table>
            	</div>
            	${appletDiv}
            </div>	
        </form>
    </body>
</html>

<script type="text/javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 var tab = 1;
	 var totalCount = 0;
    /****************************************
    * Function
    ****************************************/
     
    $(function() {
    	
	});
	
	$(document).ready(function() {

		window.onload = function() {
			
			changeTab(1);

		};

		${initScript}
		
	});
    
	function changeTab(i) {
        tab = i;
		var src = _contextPath+"/service/simpleCommand/?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&eventID="+$("#eventID").val();
        
		if($("#nextAction").val() == "update"){
			src += "&initAction=Search";			
		} 	
		
        if (i == 1) {
	        $("#_tab1").attr("src",src+"&viewID=KEY03003C");
        }
        else if (i == 2) {
			$("#_tab2").attr("src",src+"&viewID=KEY03003D");
        
       	}
        else if (i == 3) {
	        $("#_tab3").attr("src",src+"&viewID=KEY03003E");
        }
        else if (i == 4) {
        	$("#_tab4").attr("src",src+"&viewID=KEY03003F");
    	}
    }

</script>   

<script type="text/javascript">

    /****************************************
    * Button Action
    ****************************************/
	function Save(){
		if (tab == 1) {
    		document.getElementById("_tab1").contentWindow.Save();
		}else if(tab == 2){
			document.getElementById("_tab2").contentWindow.Save();
		}else if(tab == 3){
			document.getElementById("_tab3").contentWindow.Save();
		}else if(tab == 4){
			document.getElementById("_tab4").contentWindow.Save();
		}
	}
	
	function Pdf(){
		if (tab == 1) {
    		document.getElementById("_tab1").contentWindow.Pdf();
		}else if(tab == 2){
			document.getElementById("_tab2").contentWindow.Pdf();
		}else if(tab == 3){
			document.getElementById("_tab3").contentWindow.Pdf();
		}else if(tab == 4){
			document.getElementById("_tab4").contentWindow.Pdf();
		}
		
	}
	
	function KeymDocConf(){
		if (tab == 1) {
    		document.getElementById("_tab1").contentWindow.KeymDocConf();
		}else if(tab == 2){
			document.getElementById("_tab2").contentWindow.KeymDocConf();
		}else if(tab == 3){
			document.getElementById("_tab3").contentWindow.KeymDocConf();
		}else if(tab == 4){
			document.getElementById("_tab4").contentWindow.KeymDocConf();
		}
	}
	
	function KeymDocConfCancel(){
		if (tab == 1) {
    		document.getElementById("_tab1").contentWindow.KeymDocConfCancel();
		}else if(tab == 2){
			document.getElementById("_tab2").contentWindow.KeymDocConfCancel();
		}else if(tab == 3){
			document.getElementById("_tab3").contentWindow.KeymDocConfCancel();
		}else if(tab == 4){
			document.getElementById("_tab4").contentWindow.KeymDocConfCancel();
		}
	}
	
    function Search(){
		if (tab == 1) {
    		document.getElementById("_tab1").contentWindow.Search();
		}
	}
    
    function KeymDocMngFl(){
    	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
        "&viewID=KEY03003G"+
        "&keymanCd="+$("#keyManCD_S").val()+
        "&keymanNm="+$("#keyManNm_S").val();

        newWindow(url, "KEY03003G",300,200,"no");
	}

	function List() {
		tab = 1;
		tabView.set("activeIndex", 0);
		$("#nextAction").val("");
		
		$("#_tab2").attr("src","");
		$("#_tab3").attr("src","");
		$("#_tab4").attr("src","");;
		
		$("#venueCD_S").val('');
		$("#venueNm_S").val('');
		$("#keyManCD_S").val('');
		$("#keyManNm_S").val('');
		$("#birthDay_S").val('');		
		$("#DocFinshFl").val('');
		$("#DocFinshFlNm").val('');
		
		parent.appletClose();
    	parent.Search();
	}
	
</script>