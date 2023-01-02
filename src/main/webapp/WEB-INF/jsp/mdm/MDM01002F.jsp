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
											<col style="width:300px"></col>
											<col style="width:120px"></col>
											<col></col>
										</colgroup>
										<tbody>
											<tr>
												<td class="td-cond"><fmt:message key="MDM01002B.apprTpNm"/>
												</td>
												<td class="td-input">
													<span id="apprTpNm"></span>
												</td>
												<td class="td-cond"><fmt:message key="MDM01002F.papprGrpNm"/>
												</td>
												<td class="td-input">
													<span id="papprGrpNm"></span>
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM01002F.apprGrpID"/>
												</td>
												<td class="td-input">
													<input type="text" id="apprGrpID" name="apprGrpID" style="width:100px;" maxlength="10" />
													<div id="overLap"></div>
												</td>
												<td class="td-cond-required"><fmt:message key="MDM01002F.apprGrpNm"/>
												</td>
												<td class="td-input">
													<input type="text" id="apprGrpNm" name="apprGrpNm" style="width:150px;" maxlength="50" />
												</td>
											</tr>
											<tr>
												<td class="td-cond-required"><fmt:message key="MDM01002F.empNm"/>
												</td>
												<td class="td-input">
													<nis:popup id="emp" nameID="empNm" keyID="empID" />
													<input type="hidden" id="orgEmpID" name="orgEmpID" />
												</td>
												<td class="td-cond"><fmt:message key="MDM01002F.sortSeq"/>
												</td>
												<td class="td-input">
													<input type="text" id="sortSeq" name="sortSeq" style="width:50px; ime-mode:disabled; text-align:right;" maxlength="3" />
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td height="1">
						<input type="hidden" id="uniqueYN" name="uniqueYN" value="N" />
						<input type="hidden" id="activeFlg" name="activeFlg" />
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
		
		$("#apprGrpID").change(function(){
			$("#uniqueYN").val("N");
		});
		$("#emp").keypress(function(){
			if (event.keyCode==13){
				getEmpName("emp", "empID", "empNm");
			}
		});
		$("#emp_popup").click(function(){
			openEmpPopup("closeEmpPopup");
		});
	});
	
	function closeEmpPopup(data) {
		$("#emp").val(data.empID);
		$("#empID").val(data.empID);
        $("#empNm").val(data.empNm);
	}
	
	var overLap = new AW.UI.Button;
	overLap.setId("overLap");
	overLap.setControlText("<fmt:message key="button.Overlap"/>");
	overLap.refresh();

	overLap.onControlClicked = function(event) {
		if($("#apprGrpID").val()=="") {
			return;
		}
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/MDM0100205S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("apprTpID", parent.$("#apprTpID").val());
		table.setParameter("apprGrpID", $("#apprGrpID").val());
		table.request();
	
		var rowCount = table.getCount();
		if (rowCount > 0) {
			if (table.getData(0,0) != "0") {
				$("uniqueYN").val("N");
				alert("<fmt:message key="MDM01002F.msg1"/>");
				$("#apprGrpID").val("");
				$("#apprGrpID").focus();
			}
			else {
				$("#uniqueYN").val("Y");
				alert("<fmt:message key="MDM01002F.msg2"/>");
			}
		}
	}
	
</script>   

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	function New() {
		overLap.setControlVisible(true);
		$("#activeFlg").val("I");
		$("#apprTpNm").text(parent.$("#apprTpNm").val());
		$("#papprGrpNm").text(parent.$("#papprGrpNm").val());
		$("#apprGrpID").val("");
		$("#apprGrpID").attr("readonly",false);
  		$("#apprGrpID").removeClass("input-readonly");
		$("#apprGrpNm").val("");
		$("#emp").val("");
		$("#empNm").val("");
		$("#empID").val("");
		$("#sortSeq").val("0");
		$("uniqueYN").val("N");
	}
    
    var _i = 0;
    var _col = {
    	apprTpNm : _i++
    	, papprGrpNm : _i++
    	, apprGrpID : _i++
    	, apprGrpNm : _i++
    	, empID : _i++
    	, empNm : _i++
    	, sortSeq : _i++
    };
    function Search() {
    	var table = new AW.XML.Table;
    	table.setURL("${contextPath}/service/simpleAction/MDM0100206S");
    	table.setAsync(false);
    	table.setRequestMethod("POST");
    	table.setParameter("apprTpID", parent.$("#apprTpID").val());
    	table.setParameter("apprGrpID", $("#apprGrpID").val());
    	table.request();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			$("#activeFlg").val("U");
			$("#apprTpNm").text(table.getData(_col.apprTpNm,0));
			$("#papprGrpNm").text(table.getData(_col.papprGrpNm,0));
			$("#apprGrpID").val(table.getData(_col.apprGrpID,0));
			$("#apprGrpNm").val(table.getData(_col.apprGrpNm,0));
			$("#emp").val(table.getData(_col.empID,0));
			$("#empID").val(table.getData(_col.empID,0));
			$("#orgEmpID").val(table.getData(_col.empID,0));
			$("#empNm").val(table.getData(_col.empNm,0));
			$("#sortSeq").val(table.getData(_col.sortSeq,0));
			
	  		overLap.setControlVisible(false);
			$("#apprGrpID").attr("readonly",true);
	  		$("#apprGrpID").addClass("input-readonly");
		}
	}
    
	function Save() {
		if($("#activeFlg").val() == "I") {
			if($("#uniqueYN").val() == "N") {
				alert("<fmt:message key="MDM01002F.msg3"/>");
				return;
			}
		}
		if($("#apprGrpNm").val() == "") {
			alert("<fmt:message key="MDM01002F.msg4"/>");
   			$("#apprGrpNm").focus();
   			return;
   		}
		if($("#empID").val() == "") {
			alert("<fmt:message key="MDM01002F.msg6"/>");
   			$("#emp").focus();
   			return;
   		}
		var table = new AW.XML.Table;     
		table.setURL("${contextPath}/service/mdm01/saveApprGrp");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("apprGrpID", $("#apprGrpID").val());
		table.setParameter("apprTpID", parent.$("#apprTpID").val());
		table.setParameter("apprGrpNm", $("#apprGrpNm").val());
		table.setParameter("papprGrpID", parent.$("#papprGrpID").val());
		table.setParameter("empID", $("#empID").val());
		table.setParameter("orgEmpID", $("#orgEmpID").val());
		table.setParameter("sortSeq", $("#sortSeq").val());
		table.setParameter("activeFlg", $("#activeFlg").val());
		table.request();
		
		var rowCount = table.getCount();
		if (rowCount > 0) {
			if (table.getData(0,0) == "S") {
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