<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>${params.viewName}</title>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
			<%@include file="../sys3/signScripts.jsp" %>
	</head>
	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post" class="sigPad">
			<div id="wrapDiv">
          		<div id="formDiv">
					<table>
		            	<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/functionbar.jsp" %>
							</td>
						</tr>
						<tr>
							<td height="1">
		                        <table>
		                    		<tr>
		                    			<td class="tb-border">
											<table style="border:#e1dcbe solid 1px; width:260; height:180; table-layout:fixed;">
												<tr>
													<td>
														<ul class="sigNav">
												    			<li class="clearButton"><a href="#clear">Clear</a></li>
												  		</ul>
														<div class="sig"  style="margin-top:1px; margin-bottom:2px; clear:both;height:100px;border:1px solid #ccc;">
												    			<div class="typed"></div>
												    			<canvas class="pad" width="250" height="100" id="signCanvas"></canvas>
												    			<input type="hidden" name="output" class="output">
												    			<input type="hidden" name="data" id="data" />
												  		</div>
													</td>
												</tr>
					                        </table>
		                    			</td>
		                   			</tr>
								</table>
		                    </td>
		                </tr>
					</table>
				</div>
			</div>		
		</form>
	</body>
</html>

<script type="text/javascript">
		$(document).ready(function () {
				$('.sigPad').signaturePad({drawOnly:true});
		});
		
		function Save() {
			var output = $("input[name=output]").val();
			var data =  {
				"output":output
			};
			
			<c:if test="${!empty params.finalAction}"> 
				opener.${params.finalAction}(data);
				opener.upload();
			</c:if>
			window.close();
		}

		function Close() {
			window.close();
		}
	</script>
