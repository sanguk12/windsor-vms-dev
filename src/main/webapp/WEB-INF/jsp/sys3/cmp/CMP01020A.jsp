<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
  	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig} style="overflow-y:hidden">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
        <tr>
            <td height="1">
				<%@include file="../cms/standardParam.jsp" %>
   			</td>
        </tr>
        <tr>
            <td align="center">
                <table border="0" cellspacing="0" cellpadding="0" width="300">
            		<tr>
            			<td align="center" class="tb-border">
                   			<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
                   				<colgroup>
                   					<col style="width:100px;"></col>
                   					<col></col>
                   				</colgroup>
                   				<tbody>
                   				<tr>
                        			<td class="td-cond">
                        				<fmt:message key="CMP01020A.nowPassword" />
                        			</td>
                        			<td class="td-input">
                            			<input type="password" id="nowPasswd" style="width:150px; ime-mode:disabled;" maxlength="20">
                        			</td>
                    			</tr>
                    			<tr>
                        			<td class="td-cond">
                        				<fmt:message key="CMP01020A.newPassword" />
                        			</td>
                        			<td class="td-input">
                            			<input type="password" id="passwd" style="width:150px; ime-mode:disabled;" maxlength="20">
                        			</td>
                    			</tr>
                    			<tr>
                        			<td class="td-cond">
                        				<fmt:message key="CMP01020A.confPassword" />
                        			</td>
                        			<td class="td-input">
                            			<input type="password" id="passwdconfirm" style="width:150px; ime-mode:disabled;" maxlength="20">
                            		</td>
                        		</tr>
                        		<tr>
                        			<td class="td-cond">
                        				<fmt:message key="CMP01020A.dateFormat" />
                        			</td>
                        			<td class="td-input">
                            			<nis:selectbox id="dateFormatCD" defaultText="none" category="DATEFORMATCD" enable="false" />
                            		</td>
                        		</tr>
                        		<tr>
                        			<td class="td-cond">
                        				<fmt:message key="CMP01020A.language" />
                        			</td>
                        			<td class="td-input">
                            			<nis:selectbox id="languageCD" defaultText="none" category="LANGUAGECD" enable="false" />
                            		</td>
                        		</tr>
                        		<tr>
                        			<td class="td-cond">
                        				<fmt:message key="CMP01020A.timezone" />
                        			</td>
                        			<td class="td-input">
                            			<nis:selectbox id="timezoneCD" defaultText="none" category="TIMEZONECD" enable="false" />
                            		</td>
                        		</tr>
                        		</tbody>
                       		</table>
                		</td>
               		</tr>
               		<tr>
						<td height="20" style="text-align:right; text-valign:top;">
							<script type="text/javascript">
								var Confirm = new AW.UI.Button;
								Confirm.setControlImage("confirm");
								Confirm.setControlText("<fmt:message key="button.Confirm" />");
			          			document.write(Confirm);
			
			             		Confirm.onControlClicked = function() {
				              		Confirm();
				       	  		}
			             		
			             		var Close = new AW.UI.Button;
								Close.setControlImage("close");
								Close.setControlText("<fmt:message key="button.Close" />");
			          			document.write(Close);
			
			             		Close.onControlClicked = function() {
				              		Close();
				       	  		}
							</script>
						</td>
					</tr>
				</table>
    		</td>
		</tr>
		<tr>
            <td height="1">
				&nbsp;
   			</td>
        </tr>
        <tr>
        	<td height="1%">
				<input type="hidden" id="userID" value="${params.userID}">
            </td>
        </tr>
    </table>
</body>
</html>

<script type="text/javascript">
	
	/****************************************
	* Variable
	****************************************/
	// Only ModalDialog
	<c:if test="${params.modalDialog == 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>

		
	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {

		window.onload = function() {
			$("#dateFormatCD").val("${params.dateFormatCD}");
			$("#languageCD").val("${params.languageCD}");
			$("#timezoneCD").val("${params.timezoneCD}");
			$("#nowPasswd").focus();
		};

		${initScript}

		$("#nowPasswd").keypress(function(){
			if (event.keyCode==13){
				$("#passwd").focus();
				return false;
			}
		});
		
		$("#passwd").keypress(function(){
			if (event.keyCode==13){
				$("#passwdconfirm").focus();
				return false;
			}
		});
	});

	/****************************************
	* Button Action
	****************************************/
	
	function Confirm() {

		if("${params.workspaceOpen}"=="Y") {
			
			if ($("#passwd").val() == "") {
				alert("<fmt:message key="CMP01020A.msg1" />");
				$("#passwd").focus();
				return;
			}
		}
		
		if(!checkPasswordValid()) {
			return;
		}

		if(!checkNowPassWD()) {
			return;
		}
		
		if($("#passwd").val() != $("#passwdconfirm").val()) {
			alert("<fmt:message key="CMP01020A.msg2" />");
			$("#passwdconfirm").focus();
			return;
		}
		
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/user/savePassword");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("userID", $("#userID").val());
        table.setParameter("passwd", $("#passwd").val());
        table.setParameter("dateFormatCD_info", $("#dateFormatCD").val());
        table.setParameter("languageCD_info", $("#languageCD").val());
        table.setParameter("timezoneCD_info", $("#timezoneCD").val());
        table.request();

        if (table.getData(0,0) == 'S') {
        	alert("<fmt:message key="CMP01020A.msg3" />");
        	//비밀번호 강제변경시
        	if("${params.workspaceOpen}"=="Y") {
        		parent.YAHOO.example.container.panel.hide();
        	}
        	else {
       			Close();
        	}
        }
        else {
			alert(table.getData(1,0));
			$("#passwd").val("");
			$("#passwdconfirm").val("");
			$("#passwd").focus();
        }
      	
	}
	
	function checkPasswordValid() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0015S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.request();

		var passwdMinNumbers = 0;
		var passwd_len = $("#passwd").val().length;
		if (table.getCount() > 0) {
			passwdMinNumbers = table.getData(0,0);
			
			if(passwdMinNumbers > passwd_len) {
				alert("<fmt:message key="CMP01020A.msg5"><fmt:param value='"+passwdMinNumbers+"' /></fmt:message>");
				$("#passwd").focus();
				return false;
			}
		}

		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0016S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("passwd", $("#passwd").val());
		table.request();
		
		if (table.getCount() > 0) {
			if(table.getData(0,0) == "N") {
				alert("<fmt:message key="CMP01020A.msg6" />");
				$("#passwd").focus();
				return false;
			}
		}
		
		//영문, 숫자 혼합사용
		var chk_num = $("#passwd").val().search(/[0-9]/g); 
	    var chk_eng_lower = $("#passwd").val().search(/[a-z]/g);
	    var chk_eng_upper = $("#passwd").val().search(/[A-Z]/g);
	    var chk_special = $("#passwd").val().search(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi);
	    if(chk_num < 0 || chk_eng_lower < 0 || chk_eng_upper < 0 || chk_special < 0){ 
	    	alert("<fmt:message key="CMP01020A.msg7" />");
	        return false;
	    }
	    else {
	    	return true;
	    }
		
	}
	
	function checkNowPassWD() {
		
		if ($("#nowPasswd").val() == "") {
			alert("<fmt:message key="CMP01020A.msg8" />");
			$("#nowPasswd").focus();
			return false;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/SYS0018S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("userID", $("#userID").val());
		table.setParameter("nowPasswd", $("#nowPasswd").val());
		table.request();
		
		if (table.getCount() > 0) {
			if(table.getData(0,0) == "N") {
				alert("<fmt:message key="CMP01020A.msg9" />");
				$("#nowPasswd").focus();
				return false;
			}else {
				return true;
			}
		}
	}
	
	
	function Close() {
		if("${params.workspaceOpen}"=="Y") {
			parent.YAHOO.example.container.panel.hide();
			parent.document.menubar.action = "${contextPath}/service/auth/logout"; 
			parent.document.menubar.submit();
		}
		else {
			window.close();
		}
	}
	
</script>