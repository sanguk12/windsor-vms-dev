<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%-- <%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %> --%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>DiageoKIA</title>
<meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<link rel="stylesheet" href="${contextPath}/scripts/jquery.mobile-1.4.5/jquery.mobile-1.4.5.min.css" />
	 
	<script src="${contextPath}/scripts/jquery/jquery-1.11.1.js"></script>
	
	<script src="${contextPath}/scripts/jquery.mobile-1.4.5/jquery.mobile-1.4.5.min.js"></script>
	
	<script src="${contextPath}/scripts/aw/runtime/lib/aw.js"></script>
	
	<script type="text/javascript" src="${contextPath}/scripts/formatter.js"></script>

	<link rel="stylesheet" href="${contextPath}/scripts/jquery-ui-1.11.4/jquery-ui.css">
	
	<script src="${contextPath}/scripts/jquery/jquery-1.10.2.js"></script>
	
	<script src="${contextPath}/scripts/jquery-ui-1.11.4/jquery-ui.js"></script>
	<!-- ----------------------------------------------------------------------------------- -->
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/mobile/css/mobileOrder.css">
	
</head>
 
<body>
	<form id="form" name="form" method="post">

		<section id="page1" data-role="page" data-add-back-btn="true">
	        <header data-role="header" data-position="fixed">
				<h1>Application 설치</h1>
            </header>
	        <div class="content" data-role="content" style="padding-top:0; padding-bottom:0; border-bottom: 1px solid #eee">
				<ul data-role="listview" data-inset="true">
					<li data-role="fieldcontain">
						<div style="text-align: center"><img src="${contextPath}/images/common/title.gif" alt="DIAGEO Customer Incentive Management System" /></div>
						<table>
							<colgroup>
				      			<col style="width:50%"></col>
				      			<col style="width:50%"></col>
			    			</colgroup>
			      			<tbody>
								<tr style="font-size: 16px; padding: 0;">
								<td style="border-right:none; border-bottom: 0; border-top-left-radius:7px; border-bottom-left-radius:7px;">
								</td>
									<td style="border-right:none; border-bottom: 0; border-top-left-radius:0px; border-bottom-left-radius:0px;">
										삼성, LG, 기타
									</td>
									<td id="onOFF_Section"  style="border-right: 0; border-bottom: 0; border-top-right-radius:7px; border-bottom-right-radius:7px;">
						  				<div id="onBtn">
						  					<a href="https://play.google.com/store/apps/details?id=kr.co.diageo.kia" data-rel="dialog" data-transition="flip" style="font-size: 12px;"
											class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-mini" data-role="none">다운로드</a>
						  				</div>
						    		</td>
								</tr>
							</tbody>
						</table>
						<table>
							<colgroup>
				      			<col style="width:50%"></col>
				      			<col style="width:50%"></col>
			    			</colgroup>
			      			<tbody>
								<tr style="font-size: 16px; padding: 0;">
								<td style="border-right:none; border-bottom: 0; border-top-left-radius:7px; border-bottom-left-radius:7px;">
								</td>
									<td style="border-right:none; border-bottom: 0; border-top-left-radius:0px; border-bottom-left-radius:0px;">
										아이폰
									</td>
									<td id="onOFF_Section"  style="border-right: 0; border-bottom: 0; border-top-right-radius:7px; border-bottom-right-radius:7px;">
						  				<div id="onBtn">
						  					<a href="https://itunes.apple.com/kr/app/%ED%8C%8C%ED%8A%B8%EB%84%88%EC%8B%AD-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%A8/id1445515648?mt=8" data-rel="dialog" data-transition="flip" style="font-size: 12px;"
											class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-mini" data-role="none">다운로드</a>
						  				</div>
						    		</td>
								</tr>
							</tbody>
						</table>
						<table>
							<colgroup>
				      			<col style="width:50%"></col>
				      			<col style="width:50%"></col>
			    			</colgroup>
			      			<tbody>
								<tr style="font-size: 16px; padding: 0;">
								<td style="border-right:none; border-bottom: 0; border-top-left-radius:7px; border-bottom-left-radius:7px;">
								</td>
									<td style="border-right:none; border-bottom: 0; border-top-left-radius:0px; border-bottom-left-radius:0px;">
										사용 매뉴얼
									</td>
									<td id="onOFF_Section"  style="border-right: 0; border-bottom: 0; border-top-right-radius:7px; border-bottom-right-radius:7px;">
						  				<div id="onBtn">
						  					<a href="javascript:guideDownload();" data-rel="dialog" data-transition="flip" style="font-size: 12px;"
											class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-mini" data-role="none">다운로드</a>
						  				</div>
						    		</td>
								</tr>
							</tbody>
						</table>
						<!-- <table>
							<colgroup>
				      			<col style="width:50%"></col>
				      			<col style="width:50%"></col>
			    			</colgroup>
			      			<tbody>
								<tr style="font-size: 16px; padding: 0;">
								<td style="border-right:none; border-bottom: 0; border-top-left-radius:7px; border-bottom-left-radius:7px;">
								</td>
									<td style="border-right:none; border-bottom: 0; border-top-left-radius:0px; border-bottom-left-radius:0px;">
										Test APK 파일 다운로드
									</td>
									<td id="onOFF_Section"  style="border-right: 0; border-bottom: 0; border-top-right-radius:7px; border-bottom-right-radius:7px;">
						  				<div id="onBtn">
						  					<a href="javascript:testApkDownload();" data-rel="dialog" data-transition="flip" style="font-size: 12px;"
											class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-mini" data-role="none">다운로드</a>
						  				</div>
						    		</td>
								</tr>
							</tbody>
						</table>  -->
						<p></p>
					</li>
				</ul>
			</div>
	    </section>
	</form>
</body> 
</html>

<script type="text/javascript">

function guideDownload() {
    form.action = "${contextPath}/service/app/guideDownload";
    form.target = "_self";
    form.submit();
}
function testApkDownload() {
    form.action = "${contextPath}/service/app/testApkDownload";
    form.target = "_self";
    form.submit();
}
</script>