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
						<%@include file="../sys3/cms/functionbar.jsp" %>
                    </td>
                </tr>
                <tr>
					<td height="*" valign="top">
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    		<tr>
                    			<td>
									<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 0px; table-layout:fixed;">
										<colgroup>
						        			<col style="width:80px"></col>
											<col></col>
										</colgroup>
										<tbody>
				                            <tr>
												<td class="td-cond"><fmt:message key="COM02001E.biz_permit_no"/>
												</td>
												<td class="td-input">
													<input type="text" id="biz_permit_no" style="width:150px;" maxlength="10" />
													<input type="hidden" id="biz_division_code" name="biz_division_code" />
													<script type="text/javascript">
				                                        var btnUsing = new AW.UI.Button;
				                                        btnUsing.setControlText("<fmt:message key="COM02001E.btnUsing"/>");
				                                        document.write(btnUsing);
	
				                                        btnUsing.onClick = function(){
				                                        	Using();
				                                        }
			                                        </script>
				                                </td>
				                            </tr>
				                            <tr>
												<td class="td-input" colspan="2">
													<span id="comment" style="font-weight:bold;" />
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
                    <td height="5">
						<!-- Action Parameter - START -->
						<input type="hidden" name="initAction" />
						<!-- Action Parameter - END -->
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>

<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 90px; text-align:center;}
	.aw-column-1 {width: 150px; }
	.aw-column-2 {width: 170px; }

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">
	
	$("#biz_permit_no").numeric();
	
	// Only ModalDialog
	<c:if test="${params.modalDialog eq 'Y'}"> 
		var opener = window.dialogArguments;
	</c:if>
	
	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {

		window.onload = function() {
			$("#biz_permit_no").val("${params.biz_permit_no}");
			btnUsing.setControlDisabled(true);
			
			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
			
		};

		${initScript}

		$("#biz_permit_no").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		
		$("#biz_permit_no").focus(function(){
			$("#biz_permit_no").val(unformat($("#biz_permit_no").val()));
			btnUsing.setControlDisabled(true);
		});
		$("#biz_permit_no").blur(function(){
			/*
			if(!checkBizNo($("#biz_permit_no").val())) {
				alert("사업자 번호가 유효하지 않습니다.");
			}
			*/
			checkBizNo();
			
			$("#biz_permit_no").val(formatBizRegNo($("#biz_permit_no").val()));
		});
		
	});
	
	function checkBizNo() {
		if(checkBizNoPerson($("#biz_permit_no").val())) {
			$("#comment").html("<fmt:message key="COM02001E.msg4"/>");
			$("#biz_division_code").val("02");
		}
		else {
			$("#comment").html("<fmt:message key="COM02001E.msg5"/>");
			$("#biz_division_code").val("01");
		}
	}
	
	/****************************************
	* Button Action
	****************************************/
	
	function Search() {
		if($("#biz_permit_no").val()==""){
			return;
		}
		
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/COM02001E01S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","count;");
        table.setParameter("biz_permit_no", unformat($("#biz_permit_no").val()));
        checkBizNo();
        table.request();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
        	
            if (table.getData(0,0) != "0") {
            	opener.$("#uniqueYN_biz").val("N");
                btnUsing.setControlDisabled(true);
                $("#comment").html("<fmt:message key="COM02001E.msg1"/>");
                $("#biz_permit_no").val("");
                $("#biz_permit_no").focus();
            }
            else {
            	opener.$("#uniqueYN_biz").val("Y");
            	btnUsing.setControlDisabled(false);
                $("#comment").html("<fmt:message key="COM02001E.msg2"/>");
            }
        }
        else {
        	$("#biz_division_code").val("");
        	opener.$("#uniqueYN_biz").val("N");
        	btnUsing.setControlDisabled(true);
            $("#comment").html("<fmt:message key="COM02001E.msg3"/>");
        }
	}
	
	function Using() {

		var data = {
		  "biz_permit_no":$("#biz_permit_no").val()
		  , "biz_division_code":$("#biz_division_code").val()
		};
		
		<c:if test="${!empty params.finalAction}"> 
			opener.${params.finalAction}(data);
		</c:if>
		
		window.close();
	}

	function Close() {
		window.close();
	}
	
</script>