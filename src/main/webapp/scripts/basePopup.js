/*
 * 우편번호/주소 선택 팝업 열기
 */
function openZipCodePopup(finalAction) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM01001A"+
    "&finalAction="+finalAction;

    newWindow(url, "COM01001A",600,450,"yes");
}

/*
 * 신주소 선택 팝업 열기
 */
function openNewZipCodePopup(finalAction) {
	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM01001C"+
    "&finalAction="+finalAction;

    newWindow(url, "COM01001C",800,500,"no");
}

/*
 * 사원찾기 팝업 열기
 */
function openEmpPopup(finalAction) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001A"+
    "&finalAction="+finalAction;

    newWindow(url,"COM02001A",600,450,"yes");
}

/*
 * 사원명 찾기
 */
function getEmpName(emp, empID, empNm) {

	if ($("#"+emp).val() == "") {
		$("#"+emp).val("");
		$("#"+empID).val("");
        $("#"+empNm).val("");
  		return;
	}
	var table = new AW.XML.Table;
  	table.setURL(_contextPath+"/service/simpleAction/COM02001A01S");
  	table.setAsync(false);
  	table.setRequestMethod("POST");
    table.setParameter("empID", $("#"+emp).val());
  	table.request();
  	
	var rowCount = table.getCount();
  	if (rowCount == 1) {
  		$("#"+emp).val(table.getData(0,0));
  		$("#"+empID).val(table.getData(0,0));
        $("#"+empNm).val(table.getData(1,0));
  	}
  	else {
  		$("#"+emp).val("");
  		$("#"+empID).val("");
        $("#"+empNm).val("");
  	}
}

/*
 * territory찾기 팝업 열기
 */
function openTerritoryPopup(finalAction) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001F"+
    "&finalAction="+finalAction;

    newWindow(url,"COM02001F",600,450,"yes");
}

/*
 * territory찾기 그리드 팝업 열기
 */
function openTerritoryPopup_grid(finalAction, gridRow) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001F"+
    "&finalAction="+finalAction+
    "&gridRow="+gridRow;

    newWindow(url,"COM02001F",600,450,"yes");
}

/*
 * territory찾기
 */
function getTerritoryName(territory, territoryCD, territoryCDName) {

	if ($("#"+territory).val() == "") {
		$("#"+territory).val("");
		$("#"+territoryCD).val("");
        $("#"+territoryCDName).val("");
  		return;
	}
	var table = new AW.XML.Table;
  	table.setURL(_contextPath+"/service/simpleAction/COM02001F02S");
  	table.setAsync(false);
  	table.setRequestMethod("POST");
    table.setParameter("code", $("#"+territory).val());
  	table.request();
  	
	var rowCount = table.getCount();
  	if (rowCount == 1) {
  		$("#"+territory).val(table.getData(0,0));
  		$("#"+territoryCD).val(table.getData(0,0));
        $("#"+territoryCDName).val(table.getData(1,0));
  	}
  	else {
  		$("#"+territory).val("");
  		$("#"+territoryCD).val("");
        $("#"+territoryCDName).val("");
  	}
}

/*
 * 읍면동찾기 팝업 열기
 */
function openAddrPopup(finalAction, addrTpCD1, addrTpCD2) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001G"+
    "&finalAction="+finalAction+
    "&addrTpCD1="+$("#"+addrTpCD1).val()+
    "&addrTpCD2="+$("#"+addrTpCD2).val();

    newWindow(url,"COM02001G",600,450,"yes");
}

/*
 * 읍면동찾기 그리드 팝업 열기
 */
function openAddrPopup_grid(finalAction, addrTpCD1, addrTpCD2, addrTpCD3, gridRow) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001G"+
    "&finalAction="+finalAction+
    "&addrTpCD1="+addrTpCD1+
    "&addrTpCD2="+addrTpCD2+
    "&addrTpCD3="+addrTpCD3+
    "&gridRow="+gridRow;

    newWindow(url,"COM02001G",600,450,"yes");
}

/*
 * WS-SAP찾기 팝업 열기
 */
function openWSPopup(finalAction, wsCD) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001H"+
    "&finalAction="+finalAction+
    "&wsCD="+$("#"+wsCD).val();

    newWindow(url,"COM02001H",600,450,"yes");
}

/*
 * WS-SAP찾기 그리드 팝업 열기
 */
function openWSPopup_grid(finalAction, wsCD, gridRow) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001H"+
    "&finalAction="+finalAction+
    "&wsCD="+wsCD+
    "&gridRow="+gridRow;

    newWindow(url,"COM02001H",600,450,"yes");
}

/*
 * 업소찾기 팝업 열기
 */
function openVenuePopup(finalAction, venueCD, venueNm) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001B"+
    "&finalAction="+finalAction+
    "&wsCD="+$("#"+venueCD).val()+
    "&venueNm="+$("#"+venueNm).val();

    newWindow(url,"COM02001B",650,450,"yes");
}

/*
 * 업소명 찾기
 */
function getVenueName(venue, venueCD, venueNm) {

	if ($("#"+venue).val() == "") {
		$("#"+venue).val("");
		$("#"+venueCD).val("");
        $("#"+venueNm).val("");
  		return;
	}
	var table = new AW.XML.Table;
  	table.setURL(_contextPath+"/service/simpleAction/COM02001B01S");
  	table.setAsync(false);
  	table.setRequestMethod("POST");
    table.setParameter("code", $("#"+venue).val());
  	table.request();
  	
	var rowCount = table.getCount();
  	if (rowCount == 1) {
  		$("#"+venue).val(table.getData(0,0));
  		$("#"+venueCD).val(table.getData(0,0));
        $("#"+venueNm).val(table.getData(1,0));
  	}
  	else {
  		$("#"+venue).val("");
  		$("#"+venueCD).val("");
        $("#"+venueNm).val("");
  	}
}

/*
 * 제품 선택 팝업 열기
 */
function openProductPopup(finalAction) {
    
	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
			  "&viewID=COM02001C"+
			  "&finalAction="+finalAction;
			  
	newWindow(url, "COM02001C",1100,500,"yes");
}

/*
 * 제품명 가져오기
 */
function getProductName(code, name) {
	
	if ($("#"+code).val() == "") {
		$("#"+code).val("");
        $("#"+name).val("");
  		return;
	}
	
	var table = new AW.XML.Table;
  	table.setURL(_contextPath+"/service/simpleAction/COM0200101S");
  	table.setAsync(false);
  	table.setRequestMethod("POST");
  	table.setParameter("outParamKey","prdCD;prdNm;");
    table.setParameter("prdCD", $("#"+code).val());
    table.setParameter("salOrgCD", salOrgCD_S);
    table.request();
	
	var rowCount = table.getCount();
  	if (rowCount == 1) {
  		$("#"+code).val(table.getData(0,0));
        $("#"+name).val(table.getData(1,0));
  	}
  	else {
  		$("#"+code).val("");
        $("#"+name).val("");
  	}
}

/*
 * 제품 멀티 선택 팝업 열기
 */
function openProductCartPopup(finalAction, venueCD) {   
    var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
              "&viewID=COM02001D"+
              "&venueCD_S="+venueCD+"&finalAction="+finalAction;
    
    newWindow(url, "COM02001D",1100,500,"yes");
}

/*
 * 제품 멀티 선택 팝업 열기(중기약정)
 */


function openProductCartPopupForLTC(finalAction, venueCD) {   
	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
	"&viewID=COM02001N"+
	"&venueCD="+venueCD+"&finalAction="+finalAction;
	
	newWindow(url, "COM02001N",1100,500,"yes");
}

/*
 * 제품 멀티 선택 팝업 열기(검색전용)
 */
function openProductMultiPopup(finalAction) {   
	
    var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
              "&viewID=COM02001L"+
              "&finalAction="+finalAction;
    
    newWindow(url, "COM02001L",1100,500,"yes");
}

/*
 * 나의업소찾기 팝업 열기
 */
function openMyVenuePopup(finalAction, venueCD, venueNm) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001I"+
    "&finalAction="+finalAction+
    "&wsCD="+$("#"+venueCD).val()+
    "&venueNm="+$("#"+venueNm).val();

    newWindow(url,"COM02001I",650,450,"yes");
}

/*
 * 나의업소명 찾기
 */
function getMyVenueName(venue, venueCD, venueNm, territoryCD) {

	if ($("#"+venue).val() == "") {
		$("#"+venue).val("");
		$("#"+venueCD).val("");
        $("#"+venueNm).val("");
  		return;
	}
	var table = new AW.XML.Table;
  	table.setURL(_contextPath+"/service/simpleAction/COM02001B01S");
  	table.setAsync(false);
  	table.setRequestMethod("POST");
    table.setParameter("code", $("#"+venue).val());
    table.setParameter("territoryCD", territoryCD);
  	table.request();
  	
	var rowCount = table.getCount();
  	if (rowCount == 1) {
  		$("#"+venue).val(table.getData(0,0));
  		$("#"+venueCD).val(table.getData(0,0));
        $("#"+venueNm).val(table.getData(1,0));
  	}
  	else {
  		$("#"+venue).val("");
  		$("#"+venueCD).val("");
        $("#"+venueNm).val("");
  	}
}

/*
 * 서명하기
 */
function openSignCheck(finalAction) {
	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=KEY04001E"+
    "&finalAction="+finalAction;

    newWindow(url,"KEY04001E",228,200,"yes");
}

/*
 * 나의진짜업소찾기 팝업 열기
 */
function openRealMyVenuePopup(finalAction, venueCD, venueNm) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001J"+
    "&finalAction="+finalAction+
    "&wsCD="+$("#"+venueCD).val()+
    "&venueNm="+$("#"+venueNm).val();

    newWindow(url,"COM02001J",650,450,"yes");
}

/*
 * 나의진짜업소명 찾기
 */
function getRealMyVenueName(venue, venueCD, venueNm, territoryCD) {

	if ($("#"+venue).val() == "") {
		$("#"+venue).val("");
		$("#"+venueCD).val("");
        $("#"+venueNm).val("");
  		return;
	}
	var table = new AW.XML.Table;
  	table.setURL(_contextPath+"/service/simpleAction/COM02001B01S");
  	table.setAsync(false);
  	table.setRequestMethod("POST");
    table.setParameter("code", $("#"+venue).val());
    table.setParameter("territoryCD", territoryCD);
  	table.request();
  	
	var rowCount = table.getCount();
  	if (rowCount == 1) {
  		$("#"+venue).val(table.getData(0,0));
  		$("#"+venueCD).val(table.getData(0,0));
        $("#"+venueNm).val(table.getData(1,0));
  	}
  	else {
  		$("#"+venue).val("");
  		$("#"+venueCD).val("");
        $("#"+venueNm).val("");
  	}
}

/*
 * 키맨찾기 팝업 열기
 */
function openKeymanPopup(finalAction, venueCD, venueNm) {

	var url = _contextPath+"/service/simpleCommand/?mnuGrpID="+$("#mnuGrpID").val()+"&pgmID="+$("#pgmID").val()+
    "&viewID=COM02001M"+
    "&finalAction="+finalAction+
    "&wsCD="+$("#"+venueCD).val()+
    "&venueNm="+$("#"+venueNm).val();

    newWindow(url,"COM02001M",900,450,"yes");
}

/*
 * 업소명 찾기
 */
function getKeymanName(keyman, keymanID, keymanNm) {

	if ($("#"+keyman).val() == "") {
		$("#"+keyman).val("");
		$("#"+keymanID).val("");
        $("#"+keymanNm).val("");
  		return;
	}
	var table = new AW.XML.Table;
  	table.setURL(_contextPath+"/service/simpleAction/COM02001M03S");
  	table.setAsync(false);
  	table.setRequestMethod("POST");
    table.setParameter("code", $("#"+keyman).val());
  	table.request();
  	
	var rowCount = table.getCount();
  	if (rowCount == 1) {
  		$("#"+keyman).val(table.getData(0,0));
  		$("#"+keymanID).val(table.getData(0,0));
        $("#"+keymanNm).val(table.getData(1,0));
  	}
  	else {
  		$("#"+keyman).val("");
  		$("#"+keymanID).val("");
        $("#"+keymanNm).val("");
  	}
}
