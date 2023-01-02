<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- jQuery - START -->

	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery-1.8.2.min.js"></script>
	
	<script type="text/javascript" src="${contextPath}/scripts/jquery/ui/js/jquery-ui-1.10.1.custom.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/scripts/jquery/ui/css/humanity/jquery-ui-1.10.1.custom.css" />
	
	<script type="text/javascript" src="${contextPath}/scripts/jquery/jquery.alphanumeric.js"></script>
	
    <script type="text/javascript" src="${contextPath}/scripts/jquery/lightbox/js/jquery.lightbox-0.5.js"></script>
    <link rel="stylesheet" type="text/css" href="${contextPath}/scripts/jquery/lightbox/css/jquery.lightbox-0.5.css" media="screen" />	
	
<!-- jQuery - END -->
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = request.getAttribute("niceId").toString();			// NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = request.getAttribute("nicePass").toString();		// NICE�κ��� �ο����� ����Ʈ �н�����
    String seq = request.getAttribute("seq").toString();		
    
    String sRequestNumber = seq;        	// ��û ��ȣ, �̴� ����/�����Ŀ� ���� ������ �ǵ����ְ� �ǹǷ� 
                                                    	// ��ü���� �����ϰ� �����Ͽ� ���ų�, �Ʒ��� ���� �����Ѵ�.
    //sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// ��ŷ���� ������ ���Ͽ� ������ ���ٸ�, ���ǿ� ��û��ȣ�� �ִ´�.
  	
   	String sAuthType = "";      	// ������ �⺻ ����ȭ��, M: �ڵ���, C: �ſ�ī��, X: ����������
   	
   	String popgubun 	= "Y";		//Y : ��ҹ�ư ���� / N : ��ҹ�ư ����
	String customize 	= "";		//������ �⺻ �������� / Mobile : �����������
	
	String sGender = ""; 			//������ �⺻ ���� ��, 0 : ����, 1 : ���� 
	
    // CheckPlus(��������) ó�� ��, ��� ����Ÿ�� ���� �ޱ����� ���������� ���� http���� �Է��մϴ�.
	//����url�� ���� �� ������������ ȣ���ϱ� �� url�� �����ؾ� �մϴ�. ex) ���� �� url : http://www.~ ���� url : http://www.~
	String uri = request.getRequestURI().toString();
	String url = request.getRequestURL().toString();
	String action = url.replace(uri,"");
	
	String sReturnUrl = action + "/service/api/niceChkSuccess";      // ������ �̵��� URL
    String sErrorUrl = action + "/service/api/niceChkFail";          // ���н� �̵��� URL

    // �Էµ� plain ����Ÿ�� �����.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize + 
						"6:GENDER" + sGender.getBytes().length + ":" + sGender;
    
    String sMessage = "";
    String sEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    if( iReturn == 0 )
    {
        sEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
        sMessage = "��ȣȭ �ý��� �����Դϴ�.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "��ȣȭ ó�������Դϴ�.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "��ȣȭ ������ �����Դϴ�.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "�Է� ������ �����Դϴ�.";
    }    
    else
    {
        sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
    }
%>

<html>
<head>
	<title>NICE������ - CheckPlus</title>
	
	<script language='javascript'>
	window.name ="Parent_window";
	
  	$(document).ready(function() {
		
		window.onload = function() {
 			fnPopup();
		};	
	});
	
	
	function fnPopup(){
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk.submit();
	}
	</script>
</head>
<body>
	<form name="form_chk" method="post">
		<input type="hidden" name="m" value="checkplusSerivce">						<!-- �ʼ� ����Ÿ��, �����Ͻø� �ȵ˴ϴ�. -->
		<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- ������ ��ü������ ��ȣȭ �� ����Ÿ�Դϴ�. -->
	</form>
</body>
</html>