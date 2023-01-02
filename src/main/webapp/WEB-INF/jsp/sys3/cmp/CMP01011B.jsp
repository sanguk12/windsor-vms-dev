<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>${params.viewName}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
   	<form name="form" method="post">
   		<div id="wrapDiv">
	    	<div id="formDiv">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		        	<tr>
		            	<td height="1">
				            <%@include file="../cms/standardParam.jsp" %>
				            <input type="hidden" id="publicID" name="publicID">
							<input type="hidden" id="publicClassCD" name="publicClassCD">
							<input type="hidden" id="initAction" name="initAction">
							<input type="hidden" id="boardName_con" name="boardName_con" />
							
						    <%@include file="../cms/functionbar.jsp" %>
		                </td>
		            </tr>
		            <tr>
		               	<td height="*" valign="top">
		               		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		               			<tr>
		               				<td class="tb-border">
				                		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout: fixed;">
				                        	<colgroup>
										    	<col style="width:130px"></col>
										    	<col style="width:200px"></col>
										    	<col style="width:130px"></col>
										    	<col></col>
										    </colgroup>
										    <tbody>
						                    <tr>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.boardID" />
						                        </td>
						                        <td class="td-input">
						                            <input type="text" id="boardID" name="boardID" class="input-readonly" style="width:150px" value="${params.boardID}" readonly="readonly">
						                        </td>
						                        <td class="td-cond-required">
						                        	<fmt:message key="CMP01011B.boardName" />
						                        </td>
						                        <td class="td-input">
						                            <input type="text" id="boardName" name="boardName" style="width:200px">
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="td-cond-required">
						                        	<fmt:message key="CMP01011B.boardTitle" />
						                        </td>
						                        <td class="td-input" colspan="3">
						                            <input type="text" id="boardTitle" name="boardTitle" style="width:300px">
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.remark" />
						                        </td>
						                        <td class="td-input" style="padding-right:5px; height:75px;" colspan="3">
						                            <textarea id="remark" name="remark" rows="4" style="width:100%"></textarea>
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.boardTypeCD" />
						                        </td>
						                        <td class="td-input">
						                            <nis:selectbox id="boardTypeCD" name="boardTypeCD" category="BOARDTYPECD" defaultText="select"/>
						                        </td>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.mgtUserID" />
						                        </td>
						                        <td class="td-input">
						                            <input type="hidden" id="mgtUserID" name="mgtUserID">
						                            <input type="text" id="mgtUserName" name="mgtUserName" class="input-readonly" style="width:100px;" readonly="readonly">
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.useYN" />
						                        </td>
						                        <td class="td-input">
						                            <nis:radio id="useYN" name="useYN" category="USETYPE1CD" value="Y" />
						                        </td>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.isBulletinTerm" />
						                        </td>
						                        <td class="td-input">
						                            <nis:radio id="isBulletinTerm" name="isBulletinTerm" category="USETYPE1CD" value="Y" />
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.isAttachFile" />
						                        </td>
						                        <td class="td-input">
						                            <nis:radio id="isAttachFile" name="isAttachFile" category="USETYPE1CD" value="Y" />
						                        </td>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.isAnswer" /></td>
						                        <td class="td-input">
						                            <nis:radio id="isAnswer" name="isAnswer" category="USETYPE1CD" value="Y" />
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.isReply" />
						                        </td>                        
						                        <td class="td-input">
						                            <nis:radio id="isReply" name="isReply" category="USETYPE1CD" value="Y" />
						                        </td>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.isView" />
						                        </td>
						                        <td class="td-input">
						                            <nis:radio id="isView" name="isView" category="USETYPE1CD" value="Y" />
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.isTop" />
						                        </td>
						                        <td class="td-input">
						                            <nis:radio id="isTop" name="isTop" category="USETYPE1CD" value="Y" />
						                        </td>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.isHot" />
						                        </td>
						                        <td class="td-input">
						                            <nis:radio id="isHot" name="isHot" category="USETYPE1CD" value="Y" />
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.isRecommend" />
						                        </td>                        
						                        <td class="td-input">
						                            <nis:radio id="isRecommend" name="isRecommend" category="USETYPE1CD" value="Y" />
						                        </td>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.isPublic" />
						                        </td>
						                        <td class="td-input">
						                            <nis:radio id="isPublic" name="isPublic" category="USETYPE1CD" value="Y" />
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="td-cond">
						                        	<fmt:message key="CMP01011B.boardWriteAuthorityOwner" />
						                        </td>
						                        <td class="td-input" colspan="3">
						                            <input type="text" id="publicName" name="publicName" class="input-readonly" style="width:400px;" readonly="readonly"><img id="public_popup" src="${themeURL}/images/btn/search_popup.gif" hspace="3" style="vertical-align:middle; cursor:pointer">
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
			</div>
		</div>
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
	$(document).ready(function() {

		window.onload = function() {
			//목록으로 화면전환시 필요한 파라미터 받기
            $("#boardName_con").val("${params.boardName_con}");

            $("#mgtUserID").val("ADMIN");
            $("#mgtUserName").val("<fmt:message key="CMP01011B.admin" />");
			<c:if test="${!empty params.initAction}">
				${params.initAction}();
			</c:if>
			
		};

		${initScript}

		$("#boardTypeCD").change(function(){
			changeBoardTypeCD();
		});
		
		//게시판쓰기권한자 팝업
		$("#public_popup").click(function(){
			openPopupPublicSelector();
		});
		

	});
	
	function changeBoardTypeCD() {

        if ($("#boardTypeCD").val() == "40") {   //사진첩
            setRadioValue('isHot', 'N');
            $("input:radio[name=isHot]").attr("disabled", true);
        }
        else {    //일반-게시판, 자료실
        	 setRadioValue('isHot', 'Y');
        	 $("input:radio[name=isHot]").attr("disabled", false);
        	 //document.getElementById("isHot").disabled = false;
        }
    }
    
    function closePublicSelector(rtnPublicID, rtnPublicClassCD, rtnPublicName) {
    	
        var publicID = "";
        var publicClassCD = "";
        var publicName = "";
        for(var i=0; i < rtnPublicID.length; i++){
            if (i < rtnPublicID.length-1) {
	            publicID = publicID + rtnPublicID[i]+';';
	            publicClassCD = publicClassCD + rtnPublicClassCD[i]+';';
	            publicName = publicName + rtnPublicName[i]+';';
	        }
	        else {
	            publicID = publicID + rtnPublicID[i];
                publicClassCD = publicClassCD + rtnPublicClassCD[i];
                publicName = publicName + rtnPublicName[i];
            }
        }
        $("#publicName").val(publicName);
        $("#publicID").val(publicID);
        $("#publicClassCD").val(publicClassCD);
    }
    
    function openPopupPublicSelector() {

        var url = "${contextPath}/service/simpleCommand/"+
                  "?mnuGrpID="+$("#mnuGrpID").val()+
                  "&pgmID="+$("#pgmID").val()+
                  "&viewID=COM01002A"+
                  "&finalAction=closePublicSelector";
                                            
        newWindow(url, "publicSelector", 470, 570, "no");
    }
    
    function Search() {
    
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0101102S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey",
        		"boardID;boardName;boardTitle;boardTypeCD;remark;"+
        		"useYN;mgtUserID;mgtUserName;isBulletinTerm;isAttachFile;"+
        		"isAnswer;isReply;isView;isTop;isHot;"+
        		"isRecommend;isPublic;");
        table.setParameter("boardID", $("#boardID").val());
        table.request();

        var rowCount = table.getCount();
        if (rowCount > 0) {
            $("#boardID").val(table.getData(0,0));
            $("#boardName").val(table.getData(1,0));
            $("#boardTitle").val(table.getData(2,0));
            $("#boardTypeCD").val(table.getData(3,0));
            $("#remark").val(table.getData(4,0));
            setRadioValue("useYN", table.getData(5,0));
            $("#mgtUserID").val(table.getData(6,0));
            $("#mgtUserName").val(table.getData(7,0));
            setRadioValue("isBulletinTerm", table.getData(8,0));
            setRadioValue("isAttachFile", table.getData(9,0));
            setRadioValue("isAnswer", table.getData(10,0));
            setRadioValue("isReply", table.getData(11,0));
            setRadioValue("isView", table.getData(12,0));
            setRadioValue("isTop", table.getData(13,0));
            setRadioValue("isHot", table.getData(14,0));
            setRadioValue("isRecommend", table.getData(15,0));
            setRadioValue("isPublic", table.getData(16,0));
        }
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0101103S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","publicID;publicClassCD;publicName;");
        table.setParameter("boardID", $("#boardID").val());
        table.request();

        var publicID = "";
        var publicClassCD = "";
        var publicName = "";
        var rowCount = table.getCount();
        if (rowCount > 0) {
            for (var i=0; i < rowCount; i++){
	            if (i < rowCount-1) {
	                publicID = publicID + table.getData(0,i)+';';
	                publicClassCD = publicClassCD + table.getData(1,i)+';';
	                publicName = publicName + table.getData(2,i)+';';
	            }
	            else {
	                publicID = publicID + table.getData(0,i);
                    publicClassCD = publicClassCD + table.getData(1,i);
                    publicName = publicName + table.getData(2,i);
	            }
            }
        }
        $("#publicID").val(publicID);
        $("#publicClassCD").val(publicClassCD);
        $("#publicName").val(publicName);
        
        //최초 로딩시 게시판형태가 '사진첩'일 경우 중요도표시여부 사용 막기
        changeBoardTypeCD();
    }
    
</script>

<script type="text/javascript">

   	/****************************************
   	* Button Action
   	****************************************/
	function Save() {
   		
		if(trim($("#boardName").val())=="") {
			alert("<fmt:message key="CMP01011B.msg1" />");
			return;
		}
		else if(trim($("#boardTitle").val())=="") {
			alert("<fmt:message key="CMP01011B.msg2" />");
			return;
		}
		
	    var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/board/saveBoard");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("boardID", $("#boardID").val());
        table.setParameter("boardName", $("#boardName").val());
        table.setParameter("boardTitle", $("#boardTitle").val());
        table.setParameter("boardTypeCD", $("#boardTypeCD").val());
        table.setParameter("remark", $("#remark").val());
        table.setParameter("useYN", getRadioValue("useYN"));
        table.setParameter("mgtUserID", $("#mgtUserID").val());
        table.setParameter("isBulletinTerm", getRadioValue("isBulletinTerm"));
        table.setParameter("isAttachFile", getRadioValue("isAttachFile"));
        table.setParameter("isAnswer", getRadioValue("isAnswer"));
        table.setParameter("isReply", getRadioValue("isReply"));
        table.setParameter("isView", getRadioValue("isView"));
        table.setParameter("isTop", getRadioValue("isTop"));
        table.setParameter("isHot", getRadioValue("isHot"));
        table.setParameter("isRecommend", getRadioValue("isRecommend"));
        table.setParameter("isPublic", getRadioValue("isPublic"));
        
        var publicID = new Array();
        var publicClassCD = new Array();
        var publicName = new Array();
        
        publicID = $("#publicID").val().split(';');
        publicClassCD = $("#publicClassCD").val().split(';');
        publicName = $("#publicName").val().split(';');

        if (publicID.length > 0 && publicID[0] != "") {
	        table.setParameter("publicID", publicID);
	        table.setParameter("publicClassCD", publicClassCD);
	        table.setParameter("publicName", publicName);
        }
        
        table.request();
        
        if (table.getData(0,0) == 'S') {
            message(table.getData(1,0));
            $("#boardID").val(table.getData(3,0));
            Search();
        }
        else {
            alert(table.getData(1,0));
        }
	}
	
	function List() {
		$("#viewID").val("CMP01011A");
		$("#initAction").val("Search");
		document.form.action = "${contextPath}/service/simpleCommand";
		document.form.submit();
	}
</script>
