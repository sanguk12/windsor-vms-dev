<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
        <title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		<%@include file="../scripts.jsp" %>
	</head>

	<body class="yui-skin-sam" ${bodyConfig}>
    	<form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="0">
			            <!-- Standard Parameter - START -->
			            <input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
			            <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
			            <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
			            <input type="hidden" id="method" name="method">
			            <!-- Standard Information - END -->
			        </td>
			    </tr>
			    <tr>
			    	<td height="*">
				    	<div id="tabs" class="yui-navset" style="height:100%;">
							<ul class="yui-nav">
								<li><a href="#tab1"><em><fmt:message key="configuration"/></em></a></li>
								<li class="selected"><a href="#tab2"><em><fmt:message key="helpContents"/></em></a></li>
							</ul>            
							<div class="yui-content">
								<div id="tab1" style="padding-top:10px;">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px;">
			                            <tr>
			                                <td class="td-cond" width="100"><fmt:message key="phelpContentsID" /></td>
			                                <td class="td-input" width="*">
			                                    <input id="phelpContentsID" name="phelpContentsID" type="text" class="input-readonly" style="width:80px;" readonly="readonly">
						                        <input id="phelpContentsName" name="phelpContentsName" type="text" class="input-readonly" style="width:200px;" readonly="readonly">
						                        <a href="#" onclick="changePHelpContents()"><fmt:message key="change"/></a>
			                                </td>
			                            </tr>
			                            <tr>
			                                <td class="td-cond"><fmt:message key="helpContentsID" /></td>
			                                <td class="td-input">
			                                    <input id="helpContentsID" name="helpContentsID" type="text" class="input-readonly" style="width:80px;" readonly="readonly">
			                                </td>
			                            </tr>
			                            <tr>
			                                <td class="td-cond"><fmt:message key="helpContentsCD" /></td>
			                                <td class="td-input">
			                                    <input id="helpContentsCD" name="helpContentsCD" type="text" class="input-required" style="width:80px; ime-mode:disabled;">
			                                </td>
			                            </tr>
			                            <tr>
			                                <td class="td-cond"><fmt:message key="seq" /></td>
			                                <td class="td-input">
			                                    <input id="seq" name="seq" type="text" style="width:80px; ime-mode:disabled; text-align:right;" value="0" onfocus="this.select()">
			                                </td>
			                            </tr>
			                            <tr>
			                                <td class="td-cond"><fmt:message key="helpContentsName" /></td>
			                                <td class="td-input">
			                                    <input id="helpContentsName" name="helpContentsName" type="text" style="width:400px;">
			                                </td>
			                            </tr>
										<tr>
			                                <td class="td-cond"><fmt:message key="useYN" /></td>
			                                <td class="td-input">
			                                    <nis:radio id="useYN" name="useYN" category="USETYPE3CD" value="Y"/>
			                                </td>
			                            </tr>
										<tr>
			                                <td class="td-cond"><fmt:message key="remark" /></td>
			                                <td class="td-input">
			                                    <textarea name="remark" id="remark" rows="5" cols="60"></textarea>
			                                </td>
			                            </tr>
			                        </table>
								</div>
								<div id="tab2" style="padding-top:10px;">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <tr>
			                                <td class="td-cond" width="100"><fmt:message key="template"/></td>
			                                <td class="td-input" width="*">
			                                    <nis:selectbox id="template" cssClass="ddlNormal" style="width:180px;" defaultText="select" category="HELPTEMPLATECD" />
			                                </td>
			                            </tr>
			                        </table>
			                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed;">    
			                            <tr>
			                            	<td height="5px">
			                            </td>	
			                            <tr>
			                            	<td>
			                            		<c:choose>
											      <c:when test="${configure.webEditor == 'fck'}">
											      		<FCK:editor id="content" basePath="${contextPath}/scripts/fck/"
									                            height="470"
									                            toolbarSet="AllowedAttachFile"
									                            imageBrowserURL="${contextPath}/scripts/fck/editor/filemanager/browser/default/browser.html?Type=Image&Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
									                            linkBrowserURL="${contextPath}/scripts/fck/editor/filemanager/browser/default/browser.html?Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
									                            flashBrowserURL="${contextPath}/scripts/fck/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=/editor/filemanager/browser/default/connectors/jsp/connector"
									                            imageUploadURL="${contextPath}/scripts/fck/editor/filemanager/upload/simpleuploader?Type=Image"
									                            linkUploadURL="${contextPath}/scripts/fck/editor/filemanager/upload/simpleuploader?Type=File"
									                            flashUploadURL="${contextPath}/scripts/fck/editor/filemanager/upload/simpleuploader?Type=Flash">
									                      </FCK:editor>
								                      <!--  FCK:editor instanceName="contentBody" basePath="/scripts/fck" height="470"/FCK:editor-->
								                  </c:when>
								                  <c:otherwise>
								                      <input type="hidden" id="content" name="content"/>
							                          <textarea id="editor" name="editor" rows="20" cols="75">
							                          </textarea>
													  <script type="text/javascript">
													
														//(function() {
														    var Dom = YAHOO.util.Dom,
														        Event = YAHOO.util.Event;
														    
														    var myConfig = {
														        height: '420px',
														        width: '800px',
														        dompath: true,
														        focusAtStart: false
														    };
														
														    var myEditor = new YAHOO.widget.Editor('editor', myConfig);
														    myEditor._defaultToolbar.buttonType = 'basic';
														    myEditor.render();
														
														//})();
													  </script>
					                                </c:otherwise>
					                            </c:choose>
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
                <tr>
                    <td height="5">
			            <!-- Action Parameter - START -->
			            <!-- Action Parameter - END -->
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
	$(function() {
		try{$("#seq").numeric();}catch(e){}
	});
	
	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {
		
		window.onload = function() {
			$("#helpContentsID").val("000001");
			//document.getElementById("helpContentsID").value = "000000001";

			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
		};
	
		${initScript}
	});
    
    /*
    	Help Contents 작성을 위한 Template을 에디터에 입력한다.
    */
    $("#template").change(function(){
    //document.getElementById("template").onchange = function() {

	    var table = new AW.XML.Table;
	    table.setURL("simpleAction.do");
	    table.setAsync(false);
	    table.setRequestMethod("POST");
	    table.setParameter("actionKey","search");   // search, save (add, remove, modify, update)
	    table.setParameter("resultType","XML");     // List, Map, XML
	    table.setParameter("resultURL","");         // ModelAndView
	    table.setParameter("queryKey","commonservice.biz.codeForMap.select");
	    table.setParameter("codeDiv", "HELPTEMPLATECD");
	    table.setParameter("comCode", $("#template").val());
	    table.request();
	        
	    var rowCount = table.getCount();
	    var oEditor = FCKeditorAPI.GetInstance('content');
	    if (rowCount > 0) {
	    	oEditor.SetHTML(table.getData(6,0));
	    }
	    else {
			oEditor.SetHTML('');
	    }

    });
    
    YAHOO.example.container.panel = new YAHOO.widget.Panel("phelpContentsChange", { width:"300px", autofillheight:"body", visible:false, draggable:true, close:true, zIndex:1000, x:250, y:65 } );
    
    function changePHelpContents() {
    
        var body =
            "<table width='260'>"+
            "    <tr>"+
            "        <td align='center'>"+
            "            <iframe id='tree' name='tree' style='width:273px; height:304px; background-color:#f2f2f2;' frameborder='0' scrolling='auto' "+
            "                    src='simpleCommand.do?mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01016D'></iframe>"+
            "       </td>"+
            "   </tr>"+
            "   <tr>"+
            "       <td class='cond-td' align='center'>"+
            "            <p><a href='javascript: tree.d.openAll();'>open all</a> | <a href='javascript: tree.d.closeAll();'>close all</a></p>"+
            "       </td>"+
            "   </tr>"+
            "</table>";
            
	    YAHOO.example.container.panel.setHeader("Help Contents Selector");
	    YAHOO.example.container.panel.setBody(body);
	    YAHOO.example.container.panel.setFooter("AnyWorks/PRM 4");
	    YAHOO.example.container.panel.render(document.body);
		
		YAHOO.example.container.panel.show();
		
	}
	
	function setPHelpContents(helpContentsID, helpContentsName) {
		YAHOO.example.container.panel.hide();
		$("#phelpContentsID").val(helpContentsID);
		$("#phelpContentsName").val(helpContentsName);
		/*
		document.getElementById("phelpContentsID").value = helpContentsID;
		document.getElementById("phelpContentsName").value = helpContentsName;
		*/
	}
	
	/****************************************
	* Button Action
	****************************************/
	function Preview(){
	
	   if (document.getElementById("widgetID").value == '') {
	       alert('<fmt:message key="widgetform.msg1"/>');
	       return;
	   }
    
       var url = "simpleCommand.do?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
                    "&viewID=CMP01014B"+
                    "&widgetID="+$("#widgetID").val()+
                    "&titleScript="+$("#titleScript").val()+
                    "&loadMethod="+$("#loadMethod").val()+
                    "&width="+$("#width").val()+
                    "&height="+$("#height").val()+
                    "&x="+$("#x").val()+
                    "&y="+$("#y").val()
                    ;

        newWindow(url, "widgetpreview",1000,600,"yes");
    }
    
	function Delete(){

		if (confirm("<fmt:message key="confirm.delete"/>")) {
			var table = new AW.XML.Table;	  
		  	table.setURL("helpcontents.do");
		  	table.setAsync(false);
		  	table.setRequestMethod("POST");
		  	table.setParameter("method","removeHelpContents");
		  	table.setParameter("helpContentsID", $("#helpContentsID").val());
	      	table.request();
	      	
	      	if (table.getData(0,0) == "S") {
	      		$("#helpContentsID").val("000001"); 
	      		$("#helpContentsName").val("Help"); 
	      		New();
	      		parent.message(table.getData(1,0));
	      		parent.document._tree.location.href=
		      		"helpcontents.do?method=initHelpContentsList&mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01016C&phelpContentsID=&handler=javascript:parent.Search";
	      	}
	      	else
	      	{
	      	    alert(table.getData(1,0));
	      	}
		} 	
	}
	
	function New() {
	
		if ($("#helpContentsID").val() == '') {
			alert("<fmt:message key="helpcontentsform.msg1"/>");
			return;
		}
		$("#phelpContentsID").val($("#helpContentsID").val());
		$("#phelpContentsName").val($("#helpContentsName").val());
		$("#helpContentsID").val("");
		$("#helpContentsCD").val("");
		$("#seq").val("0");
		$("#helpContentsName").val("");
		setRadioValue("useYN", "Y");
		$("#remark").val("");
		var oEditor = FCKeditorAPI.GetInstance('content');
		oEditor.SetHTML('');
		$("#template").val("");
		
		/*
		document.getElementById("phelpContentsID").value = document.getElementById("helpContentsID").value;
		document.getElementById("phelpContentsName").value = document.getElementById("helpContentsName").value;
        document.getElementById("helpContentsID").value = "";
        document.getElementById("helpContentsCD").value = "";
        document.getElementById("seq").value = "0";
        document.getElementById("helpContentsName").value = "";
        setRadioValue(document.form.useYN, "Y");
        document.getElementById("remark").value = "";
        var oEditor = FCKeditorAPI.GetInstance('content');
		oEditor.SetHTML('');
		document.getElementById("template").value = '';        
        */
	}
	
	function Save(){
	
		var req = new AW.XML.Table;	  
	  	req.setURL("helpcontents.do");
	  	req.setAsync(false);
	  	req.setRequestMethod("POST");
	  	req.setParameter("method","saveHelpContents");
	  	//req.setParameter("companyID", document.getElementById("companyID").value);
	  	req.setParameter("phelpContentsID", $("#phelpContentsID").val());
	  	req.setParameter("helpContentsID", $("#helpContentsID").val());
	  	req.setParameter("helpContentsCD", $("#helpContentsCD").val());
	  	req.setParameter("seq", $("#seq").val());
	  	req.setParameter("helpContentsName", $("#helpContentsName").val());
	  	req.setParameter("useYN", getRadioValue("useYN"));
	  	req.setParameter("remark", $("#remark").val());
	  	req.setParameter("content", FCKeditorAPI.GetInstance ('content').GetXHTML(true));
      	req.request();
      	
      	if (req.getData(0,0) == "S") {
      		$("#helpContentsID").val(req.getData(3,0));
      		//document.getElementById("helpContentsID").value = req.getData(3,0);
      		parent.message(req.getData(1,0));
			
			parent.document._tree.location.href=
		      		"helpcontents.do?method=initHelpContentsList&mnuGrpID=${params.mnuGrpID}&pgmID=${params.pgmID}&viewID=CMP01016C&phelpContentsID=&handler=javascript:parent.Search";
      	}
      	else {
      	    alert(req.getData(1,0));
      	}
	}
	
	function Search(){
	
		var table = new AW.XML.Table;	  
	  	table.setURL("simpleAction.do");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("actionKey","search");	// search, save (add, remove, modify, update)
	  	table.setParameter("resultType","XML");		// List, Map, XML
	  	table.setParameter("queryKey","system.helpContentsList.select");
	  	table.setParameter("helpContentsID", $("#helpContentsID").val());
      	table.request();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		$("#phelpContentsID").val(table.getData(4,0));
      		$("#phelpContentsName").val(table.getData(10,0));
      		$("#helpContentsID").val(table.getData(0,0));
      		$("#helpContentsCD").val(table.getData(5,0));
      		$("#seq").val(table.getData(2,0));
      		$("#helpContentsName").val(table.getData(1,0));
      		setRadioValue("useYN", table.getData(7,0));
      		$("#remark").val(table.getData(3,0));
      		var oEditor = FCKeditorAPI.GetInstance('content');  
			oEditor.SetHTML(table.getData(6,0));
			//alert(table.getData(6,0));
      		
          	/*
      		document.getElementById("phelpContentsID").value = table.getData(4,0);
      		document.getElementById("phelpContentsName").value = table.getData(10,0);
      		document.getElementById("helpContentsID").value = table.getData(0,0);
      		document.getElementById("helpContentsCD").value = table.getData(5,0);
      		document.getElementById("seq").value = table.getData(2,0);
      		document.getElementById("helpContentsName").value = table.getData(1,0);
      		setRadioValue(document.form.useYN, table.getData(7,0));
      		document.getElementById("remark").value = table.getData(3,0);
      		var oEditor = FCKeditorAPI.GetInstance('content');  
			oEditor.SetHTML(table.getData(6,0));
			*/
      	}
	}

</script>
