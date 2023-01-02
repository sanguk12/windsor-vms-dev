<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		<title>알림</title>
		<%@include file="../scripts.jsp" %>
	</head>

    <body ${bodyConfig}>
        <form name="form" method="post">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr>
                    <td height="1">
						<input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
						<input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
						<input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
						<input type="hidden" id="method" name="method">
                    </td>
                </tr>
                <tr>
					<td class="alert_tit" style="background:url(${themeURL}/images/common/alert_top.png) no-repeat;" height="1">
						알림
					</td>
				</tr>
				<tr>
					<td class="alert_mid" height="*">
						<table width="622" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td style="font-size:13px; text-align:center; min-height:100px;">
									${alertMessage}
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" style="text-align:center; padding-bottom:20px; padding-top:10px;">
						<script type="text/javascript">
                       		var confirm = new AW.UI.Button;
                      		confirm.setControlText("확인");
                      		confirm.setControlImage("Confirm");
                       		document.write(confirm);
                               
                  			confirm.onControlClicked = function(event){
                       			window.close();
                       		}
                   		</script>
					</td>
				</tr>
				<tr>
					<td height="1"><img src="${themeURL}/images/common/alert_bottom.png"></td>
				</tr>
			</table>
		</form>
    </body>
</html>