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
					<td height="1"valign="top">
						<%@include file="../sys3/cms/standardParam.jsp" %>
						<%@include file="../sys3/cms/functionbar.jsp" %>
						<%@include file="../sys3/cms/calendar.jsp" %>
					</td>
				</tr>
				<tr>
					<td height="*" valign="top">
						<table border="0" cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td class="tb-border" height="1" valign="top">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
										<colgroup>
											<col style="width:120px"></col>
											<col style="width:200px"></col>
											<col style="width:120px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond"><fmt:message key="MDM01002B.apprTpID"/>
												</td>
												<td class="td-input">
													<input type="text" id="apprTpID" name="apprTpID" class="input-readonly" style="width:100px;" readonly="true" />
												</td>
												<td class="td-cond-required"><fmt:message key="MDM01002B.apprTpNm"/>
												</td>
												<td class="td-input">
													<input type="text" id="apprTpNm" name="apprTpNm" style="width:150px;" maxlength="50" />
												</td>
											</tr>
											<tr>
				                                <td class="td-cond" style="height:100%"><fmt:message key="MDM01002B.remark" />
				                                </td>
				                                <td class="td-input" style="padding-right:5px" colspan="3">
				                                    <textarea id="remark" name="remark" style="width:100%; height:35px;"></textarea>
				                                </td>
				                            </tr>
										</tbody>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td height="1">
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
	});
	
	$(document).ready(function() {

		window.onload = function() {
			Search();
		};

		${initScript}
		
	});
	
</script>   

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function New() {
		$("#apprTpID").val("");
		$("#apprTpNm").val("");
		$("#remark").val("");
	}
    
    var _i = 0;
    var _col = {
    	apprTpID : _i++
    	, apprTpNm : _i++
    	, remark : _i++
    };
    function Search() {
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/MDM0100204S");
    	table.setAsync(false);
    	table.setRequestMethod("POST");
    	table.setParameter("apprTpID", parent.$("#selectApprTpID").val());
    	table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#apprTpID").val(table.getData(_col.apprTpID,0));
			$("#apprTpNm").val(table.getData(_col.apprTpNm,0));
			$("#remark").val(table.getData(_col.remark,0));
		}
	}
    
	function Save() {
		if($("#apprTrNm").val() == "") {
   			alert("<fmt:message key="EMP01002B.msg18"/>");
   			$("#apprTrNm").focus();
   			return;
   		}
		var table = new AW.XML.Table;     
		table.setURL("${contextPath}/service/mdm01/saveAppr");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("apprTpID", $("#apprTpID").val());
		table.setParameter("apprTpNm", $("#apprTpNm").val());
		table.setParameter("remark", $("#remark").val());
		table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			if (table.getData(0,0) == "S") {
				parent.$("#selectApprTpID").val(table.getData(3,0));
				parent.parent.message(table.getData(1,0));
				parent.appletClose();
				parent.Search();
				parent.parent.document._tree.location.reload();
			}
			else {
				alert(table.getData(1,0));
			}
		}
	}
	
	function Close() {
		parent.appletClose();
	}
	
</script>