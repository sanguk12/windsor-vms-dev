<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>

<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 155px; }
	.aw-column-1 {width: 50px; text-align: center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">

    YAHOO.example.container.panel = new YAHOO.widget.Panel("windowselector", { width:"250px", autofillheight:"body", visible:false, draggable:false, close:true, zIndex:1000, x:687, y:40 } );

	var windowStack = new Array();
	var windowName = new Array();
	var windowStatus = new Array();
	var grid = null;
	
	function addWindow(win, winName){
		windowStack[windowStack.length] = win;
		windowName[windowName.length] = winName;
		windowStatus[windowStatus.length] = "U";
	}

	function closeWindow(row){
		windowStack[parseFloat(grid.getCellText(2,row))].close();
		windowStatus[parseFloat(grid.getCellText(2,row))] = "D";
		grid.deleteRow(row);
	}
	
    function searchWindowStack() {

    	var columns = [
  	       		"<fmt:message key="menubar.windowName"/>",
  	       		"<fmt:message key="menubar.close"/>"
  	       	];

    	if (grid != null) grid.clear();
    	
  		grid = new AW.UI.Grid;
   		
   		grid.setId("grid");
   		grid.setCellFormat([str, str]);
   		grid.setHeaderText(columns);
   		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
   		grid.setSize(225, 200);
   		grid.setRowCount(0);
   		grid.setColumnCount(columns.length);
   		grid.setSelectorVisible(false);
   		grid.setSelectionMode("single-row");
   		grid.setCellEditable(false);

   		grid.setCellImage("close", 1);
		var closeFlag = new AW.Templates.Image;
        var closeImage = closeFlag.getContent("box/image");
        closeImage.setTag("a");
        closeImage.setAttribute("href", function(){
            return "javascript:closeWindow(grid.getCurrentRow())";
        });
        grid.setCellTemplate(closeFlag, 1);
        
   		grid.onRowClicked = function(event, row) {
   	   		windowStack[parseFloat(grid.getCellText(2,row))].focus();
   			YAHOO.example.container.panel.hide();
   		};
   		
   		// event : enter key
   		var keyEvent = grid.getEvent("onkeypress");
   	    grid.setEvent("onkeypress", function(e, rowIndex) {    	
   			if(event.keyCode==13){
   				YAHOO.example.container.panel.hide();
   			} else {
   				keyEvent.call(this, event);
   				event.returnValue = false;
   			}
   	    });
   	    
   	 	grid.onHeaderClicked=function(){
			return true;
		}

   	 	var data = new Array();
   	 	var j=0;
   	    for (var i=0; i < windowStack.length; i++){
   	   	    if (windowStatus[i] == "U"){
   	   	   	    try {
	   	   	   	    if (windowStack[i].status == null) {
	   	   	   			windowStatus[i] = "D";
	   	   	   	    }
	   	   	   	    else {
			    		data[j++] = [
			  				windowName[i],
			  				"",
			  				i
			  			];
	   	   	   	    }
   	   	   	    }
   	   	   	    catch(e){
   	   	   			windowStatus[i] = "D";
   	   	   	    }
   	   	    }
  	    }
  		grid.setCellData(data);
  		grid.setRowCount(j);
  		
   	    YAHOO.example.container.panel.setHeader("Window Selector");
	    YAHOO.example.container.panel.setBody(grid);
	    YAHOO.example.container.panel.setFooter("<fmt:message key="application.title" />");
	    YAHOO.example.container.panel.render(document.body);
		
		YAHOO.example.container.panel.show();
		
		grid.focus();
	}
</script>

<script type="text/javascript">
	
	function goHome() {
		if("${params.displayMnuTp}" == "200"){
			_workspace.location.href = "${contextPath}/sys3/cms/workspace2frame.page?mnuGrpID=MOB";
	    }else if("${params.displayMnuTp}" == "300"){
			_workspace.location.href = "${contextPath}/sys3/cms/workspace2frame.page?mnuGrpID=ESLT";
	    }else{
			_workspace.location.href = "${contextPath}/service/widget/viewUserWidget";	
	    }
	}

	function goMenu(url) {
		_workspace.location.href = "${contextPath}/"+url;	
	}
	
	/*
	* 대메뉴 선택시 선택 탭 스타일 고정
	* menutree.jsp 에서 호출됨
	*/
	function menuBarTabStyleChange(mnuGrpID) {
		$(".menutab").removeClass('off');
		
		if (mnuGrpID != null) {
			$("#"+mnuGrpID).addClass('off');
			$("#"+mnuGrpID).removeClass('on');
		}
	}

	function logout() {
		if (confirm("<fmt:message key="confirm.logout" />")) {
			document.menubar.action = "${contextPath}/service/auth/logout";
			document.menubar.submit();
		}
	}

	function notice_getCookie(name) {
	        var nameOfCookie = name + "=";
	        var x = 0;
	        while ( x <= document.cookie.length )
	        {
	                var y = (x+nameOfCookie.length);
	                if ( document.cookie.substring( x, y ) == nameOfCookie ) {
	                        if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
	                                endOfCookie = document.cookie.length;
	                        return unescape( document.cookie.substring( y, endOfCookie ) );
	                }
	                x = document.cookie.indexOf( " ", x ) + 1;
	                if ( x == 0 )
	                        break;
	        }
	        return "";
	}	
	
	function openNotice() {
		
		var table = new AW.XML.Table;
	  	table.setURL("simpleAction.do");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("returnType","List");
        table.setParameter("resultType","XML");
        table.setParameter("RFC","ZCWCOMMC05_WCM_157");
        table.setParameter("inParamKey","CURRENTDATE;USERID;AUTHLEVELCD;");
        table.setParameter("outParamKey","DOCLINKID;NOTICETITLE;FILENAME;WIDTH;HEIGHT;X;Y;");
        
        table.setParameter("CURRENTDATE", unformat("${params.currentDate}"));
        table.setParameter("USERID", "${params.userID}");
        table.setParameter("AUTHLEVELCD", "${params.authLevelCD}");
		table.request();
		
	  	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		for (var i=0; i < rowCount; i++) {
      			if ( notice_getCookie("Notice"+table.getData(0,i)) != "done" ) {
      				var url = "simpleCommand.do?mnuGrpID=ETC&pgmID=COM04009"+
      		        "&viewID=COM04009B"+
      		        "&NOTICEID="+"Notice"+table.getData(0,i)+
      		        "&DOCLINKID="+table.getData(0,i)+
      		        "&NOTICETITLE="+encodeURIComponent(table.getData(1,i))+
      		        "&FILENAME="+encodeURIComponent(table.getData(2,i))+
      		        "&WIDTH="+table.getData(3,i)+
      		        "&HEIGHT="+table.getData(4,i);

      				//600, 630
      				newWindow(url, "Notice"+table.getData(0,i),parseFloat(table.getData(3,i)),parseFloat(table.getData(4,i))+30,"no");
      			}
      		}
      	}
	}

	function changeTheme(theme, displayMnuTp) {
		
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/user/saveTheme");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("userID", $("#userID").val());
        table.setParameter("themeCD", theme);
        table.request();

        if (table.getData(0,0) == 'S') {
        	//window.location.reload(true);
        	$("#deviceValue").val(displayMnuTp);
        	document.menubar.action = "${contextPath}/service/auth/login";
        	document.menubar.submit();
        }
        else {
			alert("<fmt:message key="menubar.msg1"/>");
        }
	}

	function checkPasswordInit() {
		//if ("${params.passwd}" == "${params.encryptUserID}") {
		if ("${params.passwd}" == "${params.encryptINIT}") {
			var url = "${contextPath}/service/simpleCommand/?mnuGrpID=ETC&pgmID=CMP01020&viewID=CMP01020A";
			newWindow(url, "CMP01020A",450,220,"no");
		}
	}
	
	function openPassword() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=ETC&pgmID=CMP01020&viewID=CMP01020A";
		newWindow(url, "CMP01020A",400,220,"no");
	}
	
	function expiredSessionLogout() {
		document.menubar.action = "${contextPath}/service/auth/logout"; 
        document.menubar.submit();
    }

	function openSMS() {

		<c:if test="${params.partnerDivCD_S == 'AC'}">
			alert("<fmt:message key="menubar.msg2"/>");
			return;
		</c:if>
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=ETC&pgmID=CMP01022&viewID=CMP01022A";

		newWindow(url, "CMP01022A",720,530,"no");
	}

	function openFavorite() {

		alert("<fmt:message key="menubar.msg3"/>");
		return;
		
	   	var url = "${contextPath}/service/simpleCommand/?mnuGrpID=ETC&pgmID=COM04004&viewID=COM04004A&initAction=Search";
        newWindow(url, "COM04004A",550,450,"no");
	}

	
	function changeUserWidget() {
		
	   	var url = "${contextPath}/service/simpleCommand/?mnuGrpID=ETC&pgmID=CMP01015&viewID=CMP01015A";

        newWindow(url, "CMP01015A",655,310,"no");
	}

	function openHelpContents() {
		var url = "${contextPath}/service/simpleCommand/?mnuGrpID=ETC&pgmID=COM03002&viewID=COM03002A";
        newWindow(url, "helpcontentsviewer",1010,600,"no");
	}	

	function openSite(url) {
		newWindow(url, "sitepopup",970,620,"yes");
	}
	
	function openAppStatePopup() {		
		if($("#appCount").val() > 0){

		    var url = "${contextPath}/service/simpleCommand/?mnuGrpID=ETC&pgmID=COM03001&viewID=COM03001A";

	        newWindow(url,"COM03001A",650,450,"no");
		}
	}
	
	/**
	* Session Timeout Process
	*/
	var maxInactiveInterval;
	var sessionTimerID = null;
	var sessionTimerRunning = false;
	var sessionDelay = 1000;

	function InitSessionTimer(){
	    // Set the length of the timer, in seconds
	    maxInactiveInterval = ${params.maxInactiveInterval} - 5;
	    StopTheSessionTimer();
	    StartTheSessionTimer();
	}

	function StopTheSessionTimer(){
	    if(sessionTimerRunning)
	        clearTimeout(sessionTimerID);
	    sessionTimerRunning = false;
	}

	function StartTheSessionTimer(){
	    if (maxInactiveInterval==0){
	        StopTheSessionTimer();
	        expiredSessionLogout();
	    }
	    else{
	    	maxInactiveInterval = maxInactiveInterval - 1;
	        sessionTimerRunning = true;
	        sessionTimerID = self.setTimeout("StartTheSessionTimer()", sessionDelay);
	    }
	}

	//TODO:자동세션타임아웃 시작
	InitSessionTimer();
	
</script>

<form name="menubar" method="post" target="_top" onSubmit="return false;">
	<!-- Standard Parameter - START -->
	<input type="hidden" id="companyID" name="companyID" value="${params.companyID}">
    <input type="hidden" id="userID"    name="userID"    value="${params.userID}">
    <input type="hidden" id="passwd"    name="passwd"    value="${params.passwd}">
    <input type="hidden" id="appCount"  name="appCount"  value="${params.appCount}">
    <input type="hidden" id="method"    name="method">
    <input type="hidden" id="deviceValue" name="deviceValue">
    <!-- Standard Information - END -->
    
	<div id="header">
		<div style="width:162px; height:113px; float:left; background:url(${themeURL}/images/common/topmenu_bg_new.gif) repeat-x;">
			<c:choose>
				<c:when test="${params.displayMnuTp == '100'}" >
					<p style="margin-left:35px; margin-top:20px;"><a href="javascript:goHome();"><img src="${contextPath}/images/common/logo_kia_<c:choose><c:when test="${params.languageCD == 'KR'}">KR</c:when><c:otherwise>EN</c:otherwise></c:choose>.png"></a></p>
				</c:when>
				<c:when test="${params.displayMnuTp == '200'}" >
					<p style="margin-left:35px; margin-top:20px;"><a href="javascript:goHome();"><img src="${contextPath}/images/common/logo_kia_<c:choose><c:when test="${params.languageCD == 'KR'}">KR</c:when><c:otherwise>EN</c:otherwise></c:choose>.png"></a></p>
				</c:when>
				<c:when test="${params.displayMnuTp == '300' }">
					<p style="margin-left:35px; margin-top:20px;"><a href="javascript:goHome();"><img src="${contextPath}/images/login_eslt/logo.png"></a></p>
				</c:when>
			</c:choose>
			<p style="margin-top:25px; margin-left:11px; font-size:11px;"><img src="${themeURL}/images/common/login_icon.gif" width="17" height="19">
			<span style="font-weight:bold; color:#465580;">${params.userName}</span>
			<c:choose><c:when test="${params.languageCD == 'kr'}">님</c:when></c:choose>
			<fmt:message key="COM03001A.appCount" /> [ <a href="javascript:openAppStatePopup();"><span id='AppStateCount' style='color:#e46d19'>${params.appCount}</span></a> ]건
			</p>
		</div>
		<div style="float:right; margin-top:-10px;">
			<div style="margin-top:26px; margin-left:0px; width:850px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	                    <td style="text-align:left; width:62px;"><img src="${themeURL}/images/common/tit_news.gif" width="50" height="20"></td>
						<td width="400" valign="middle">
	                    	<iframe id="newsTicker" src="${contextPath}/service/simpleCommand.do?mnuGrpID=ETC&pgmID=CMP01013&viewID=CMP01013B" style="width:400px;" class="newsTicker" allowtransparency="false" align="absmiddle" border="0" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
	                    </td>
						<td width="*">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<c:choose>
										<c:when test="${params.displayMnuTp == '200' }">
											<td style="text-align:right;height:24px; padding-right:50px; ">
												<a here="" class="glo_menu" href="javascript:logout();"><fmt:message key="menubar.logout"/></a>
												&nbsp;
												<a href="#" onclick="searchWindowStack()"><img src="${themeURL}/images/btn/download.gif"></a>
												&nbsp;
												<img src="${contextPath}/images/menu/color.png"> <a href="#" onclick="changeTheme('violet','200')"><img src="${contextPath}/images/menu/violet.png"></a> <a href="#" onclick="changeTheme('gold','200')"><img src="${contextPath}/images/menu/gold.png"></a> <a href="#" onclick="changeTheme('blue','200')"><img src="${contextPath}/images/menu/blue.png"></a> <a href="#" onclick="changeTheme('brown','200')"><img src="${contextPath}/images/menu/brown.png"></a> <a href="#" onclick="changeTheme('green','200')"><img src="${contextPath}/images/menu/green.png"></a>
											</td>
										</c:when>
										<c:when test="${params.displayMnuTp == '300' }">
											<td style="text-align:right;height:24px; padding-right:50px; ">
												<a here="" class="glo_menu" href="javascript:logout();"><fmt:message key="menubar.logout"/></a>
												&nbsp;
												<a href="#" onclick="searchWindowStack()"><img src="${themeURL}/images/btn/download.gif"></a>
												&nbsp;
												<img src="${contextPath}/images/menu/color.png"> <a href="#" onclick="changeTheme('violet','200')"><img src="${contextPath}/images/menu/violet.png"></a> <a href="#" onclick="changeTheme('gold','200')"><img src="${contextPath}/images/menu/gold.png"></a> <a href="#" onclick="changeTheme('blue','200')"><img src="${contextPath}/images/menu/blue.png"></a> <a href="#" onclick="changeTheme('brown','200')"><img src="${contextPath}/images/menu/brown.png"></a> <a href="#" onclick="changeTheme('green','200')"><img src="${contextPath}/images/menu/green.png"></a>
											</td>
										</c:when>
										<c:otherwise>
											<td style="text-align:right;height:24px;">
												<a here="" class="glo_menu" href="javascript:goMenu('sys3/cms/workspace2frame.page?mnuGrpID=CMT');"><fmt:message key="menubar.board"/></a>
												<img src="${contextPath}/images/common/global_mid_line.gif">
												<a here="" class="glo_menu" href="javascript:openPassword();"><fmt:message key="menubar.changeUserInfo"/></a>
												<img src="${contextPath}/images/common/global_mid_line.gif">
												<a here="" class="glo_menu" href="javascript:logout();"><fmt:message key="menubar.logout"/></a>
												&nbsp;
												<a href="#" onclick="searchWindowStack()"><img src="${themeURL}/images/btn/download.gif"></a>
												&nbsp;
												<img src="${contextPath}/images/menu/color.png"> <a href="#" onclick="changeTheme('violet','100')"><img src="${contextPath}/images/menu/violet.png"></a> <a href="#" onclick="changeTheme('gold','100')"><img src="${contextPath}/images/menu/gold.png"></a> <a href="#" onclick="changeTheme('blue','100')"><img src="${contextPath}/images/menu/blue.png"></a> <a href="#" onclick="changeTheme('brown','100')"><img src="${contextPath}/images/menu/brown.png"></a> <a href="#" onclick="changeTheme('green','100')"><img src="${contextPath}/images/menu/green.png"></a>
											</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="float:left; margin-top:-3px;">
			<div id="app_menubar" style="height:35px; margin-top:10px; width:850px">
				<table border="0" cellspacing="0" cellpadding="0" class="topmenu_tit" id="topnav"><!-- width="646"  -->
					<tr>
						<td width="10"><img src="${themeURL}/images/common/top_bg02.gif"></td>
						<c:forEach items="${mnuGrpIDList}" var="mnuGrpID" varStatus="status">
							<c:set var="mnuMapList" value="${mnuMap[status.count-1]}"/>
							<c:forEach items="${mnuMapList}" var="mnuItem" varStatus="statusMap">
				                <c:if test="${statusMap.count==1}">
				                	<td id="${mnuItem.code}" width="90" class="on menutab"><a here="" href="javascript:goMenu('${mnuItem.URL}')">${mnuItem.name}</a></td>
				                </c:if>
				                <c:if test="${statusMap.count!=1}">
				                	<td width="1"><img src="${themeURL}/images/common/topmenu_mid_line.gif"></td>
				                	<td id="${mnuItem.code}" width="90" class="on menutab"><a here="" href="javascript:goMenu('${mnuItem.URL}')">${mnuItem.name}</a></td>
				                </c:if>
							</c:forEach>
						</c:forEach>
						<td width="*">
							<input type="hidden" id="dkmdTpCD" name="dkmdTpCD" value="${params.dkmdTpCD }" />
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</form>

<script type="text/javascript">
	
	$(document).ready(function() {
		/*
	    $("#topnav td").hover(function () {
	    	if ($(this).attr("class") == 'on') {
	        	$(this).addClass("off");
	    	}
	    }, function() {
		    $(this).removeClass("off");
	    });
		*/
		
	    // 초기 비밀번호 변경
	    checkPasswordInit();

	    // 팝업공지 오픈
	    //openNotice();
	    
	    // 모바일 프로그램 자동이동
	    
	    if("${params.displayMnuTp}" == "200"){
	    	goMenu('sys3/cms/workspace2frame.page?mnuGrpID=MOB');
			return;
	    }else if("${params.displayMnuTp}" == "300"){
	    	goMenu('sys3/cms/workspace2frame.page?mnuGrpID=ESLT');
			return;
	    }
	    
	    // 프로그램 자동이동
	    <c:if test="${!empty params.openProgram}">
			goMenu('sys3/cms/workspace2frame.page?mnuGrpID=CMT&openProgram='+encodeURIComponent('${params.openProgram}'));
			return;
		</c:if>
	    // 프로그램 자동이동(게시판)
	    <c:if test="${!empty params.articleID}">
	    	var tmpURL = encodeURIComponent("${contextPath}/service/board/viewArticle/?boardID=${params.boardID}&mnuGrpID=CMT&pgmID=CMP02001&viewID=CMP02001C&articleID=${params.articleID}&superPage=0&page=0");
			goMenu('sys3/cms/workspace2frame.page?mnuGrpID=CMT&openProgram='+tmpURL);
			return;
		</c:if>
	    <c:if test="${!empty params.boardID}">
	    	var tmpURL = encodeURIComponent("${contextPath}/service/board/viewArticle/?boardID=${params.boardID}&mnuGrpID=CMT&pgmID=CMP02001&viewID=CMP02005C");
			goMenu('sys3/cms/workspace2frame.page?mnuGrpID=CMT&openProgram='+tmpURL);
			return;
		</c:if>
	});
	
	 /**
     * Timer Process
     */
     var maxWorkInactiveInterval;
     var workTimerID = null;
     var workTimerRunning = false;
     var workDelay = 1000;
     
     // 타이머 함수
    function InitWorkTimer(){
         // Set the length of the timer, in seconds
         maxWorkInactiveInterval = 300; //300초 마다
         StopTheWorkTimer();
         StartTheWorkTimer();
     }

    function StopTheWorkTimer(){
         if(workTimerRunning)
             clearTimeout(workTimerID);
         workTimerRunning = false;
     }

    function StartTheWorkTimer(){
         if (maxWorkInactiveInterval==0){
             StopTheWorkTimer();
             execWork();
         }
         else{
             maxWorkInactiveInterval = maxWorkInactiveInterval - 1;
             workTimerRunning = true;
             workTimerID = self.setTimeout("StartTheWorkTimer()", workDelay);
         }
     }
     

    // 타이머 종료 시 실행될 함수, 함수 로직 실행 후 타이머 다시 초기화
    function execWork() {         
        //TODO - 실행로직       
	 	appCountFun();       
         
        // 로직 실행 후 타이머 초기화, 1회만 실행할 경우 제거
        InitWorkTimer();
     }
    
    function appCountFun() {   
    	var table = new AW.XML.Table;
 		table.setURL("${contextPath}/service/simpleAction/COM03001A_Search_All");	  	
 	  	table.setAsync(false);	  	
 	  	table.setRequestMethod("POST");	  	
 		//조회조건 입력	
 	  	table.setParameter("userID", "${params.userID}");	  	
 	  	table.request();
 	  	$("#appCount").val(table.getData(0,0));	 	 
 	  	
 	  	document.getElementById("AppStateCount").innerHTML = table.getData(0,0);
    }
    
    window.setTimeout('InitWorkTimer()',1000);
</script>