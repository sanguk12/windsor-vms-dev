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
                    <td height="1" valign="top">
			            <%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
					</td>
				</tr>
				<tr>
					<td height="*" valign="top">
                        <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
                    		<tr>
                    			<td class="tb-border" valign="top">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
			                            <colgroup>
						        			<col style="width:120px;"></col>
						        			<col></col>
						        		</colgroup>
						        		<tbody>
				                            <tr>
				                            	<td class="td-cond-required">
				                            		<fmt:message key="MDM04003A.ifDateExecute" />
												</td>
												<td class="td-input">
													<nis:calendar id="startDate" cssClass="input-readonly" readOnly="yes" value="" eventproc="" /> - 
													<nis:calendar id="endDate" cssClass="input-readonly" readOnly="yes" value="" eventproc="" />
				                                </td>
				                            </tr>
			                            </tbody>
			                        </table>
                    			</td>
                   			</tr>
						</table>
                    </td>
                </tr>
			</table>
		</form>
	</body>
</html>

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
			
			$("#startDate").val("${params.firstDate}");
			$("#endDate").val("${params.currentDate}");
		};

		${initScript}
		
	});
	
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	//rfid 배치
	function Execute() {
		var startDate = unformat($("#startDate").val());
		var endDate = unformat($("#endDate").val());
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/COM03011S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
		table.setParameter("startDate", unformat($("#startDate").val()));
	  	table.setParameter("endDate", unformat($("#endDate").val()));
	  	table.request();
	  	
	  	var diff = 0;
	  	diff = table.getData(0,0);
	  	if(diff >30) {
	  		alert("<fmt:message key="MDM04003A.msg1" />");
	  		return false;
	  	}
	  	if(unformat($("#startDate").val()) > unformat($("#endDate").val())){
			alert("<fmt:message key="MDM04003A.msg2" />");
			$("#endDate").val($("#startDate").val());
			return false;
		}
	  	
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleBatch/request_salesInfo_action");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("startDate", unformat($("#startDate").val()));
	  	table.setParameter("endDate", unformat($("#endDate").val()));
		table.request();

		alert(table.getData(1,0));
	}
	
	function Close() {
		window.close();
	}
	
</script>