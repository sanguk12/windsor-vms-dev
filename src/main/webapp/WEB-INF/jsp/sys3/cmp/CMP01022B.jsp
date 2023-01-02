<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@include file="../scripts.jsp" %>
		<style type="text/css">
			a:link,a:visited,a:active,a:hover {color:#666;text-decoration:none;}
		</style>
	</head>
	<body class="yui-skin-sam" ${bodyConfig} style="overflow-y:hidden">
		<form name="form" method="post">
		    <!-- Standard Parameter - START -->
		    <input type="hidden" id="mnuGrpID" name="mnuGrpID" value="${params.mnuGrpID}">
		    <input type="hidden" id="pgmID" name="pgmID" value="${params.pgmID}">
		    <input type="hidden" id="viewID" name="viewID" value="${params.viewID}">
		    <input type="hidden" id="method" name="method">
		    <input type="hidden" id="initAction" name="initAction">
		    <!-- Standard Information - END -->
		    
		    <!-- Function Bar - Button -->
		    <%@include file="../cms/functionbar.jsp" %>
		    
		    <table width="100%">
		    	<!-- 
		    	<tr>
		    	    <td class="td-cond" width="40" style="border:#e1dcbe solid 1px;">조직장</td>
                    <td class="td-input" width="*" style="border:#e1dcbe solid 1px;">
                         <input type="checkbox" id="select1" class="checkbox" value="8101"> 총괄본부장
                         <input type="checkbox" id="select2" class="checkbox" value="8102"> 본부장
                         <input type="checkbox" id="select3" class="checkbox" value="8105"> 사업국장<br>
                         <input type="checkbox" id="select4" class="checkbox" value="8002"> 총괄지사장
                         <input type="checkbox" id="select5" class="checkbox" value="8005"> 지사장
                    </td>
                </tr>
		    	 -->
                <tr>
                    <td align="center" colspan="2">
                         <iframe id="tree" name="tree" style="width:370px; height:390px;" frameborder="0" scrolling="auto" src="/cmp/CMP01022C.page"></iframe>
                    </td>
                </tr>
                <tr>
                    <td class="cond-td" align="center" colspan="2">
                         <p><a href='javascript: tree.d.openAll();'><img src="${contextPath}/images/menu/all_open.png"> 펼치기</a> | <a href='javascript: tree.d.closeAll();'><img src="${contextPath}/images/menu/all_close.png"> 접기</a></p>
                    </td>
                </tr>
            </table>
	   </form>
	</body>
</html>

<script type="text/javascript">

    /****************************************
    * Function
    ****************************************/
    // Only ModalDialog
    <c:if test="${params.modalDialog == 'Y'}"> 
        var opener = window.dialogArguments;
    </c:if>
    
    $(document).ready(function() {

		window.onload = function() {
			Search();
		};

		${initScript}	

		$("input").click(function(){
			//top.tree.selectLPTYP($("#"+this.id).val(), ($("#"+this.id).is(":checked"))?"checked":"");
		});
    });
    
    function Search() {
	    showLoading();
		window.setTimeout("top.tree.Search()", 500);
		window.setTimeout("hideLoading()", 500);
    }

    /****************************************
    * Button Action
    ****************************************/
    function Confirm() {
        var NAME = new Array();
        var HP = new Array();
        var j=0;

        //var checkYN = top.tree.document.forms[0].checkYN;
        var rowCount = top.tree.rowCount;
        //alert(top.tree.rowCount);
        //alert(top.tree.$("#checkYN"+0).attr("checked"));
        for (var i=0; i < rowCount; i++){
            
            if (top.tree.$("#checkYN"+i).attr("checked")) {
                var data = new Array();
                data = top.tree.$("#checkYN"+i).val().split(';');
                if(data[5]!=""){
	                NAME[j] = data[3];
	                HP[j] = data[5];
	                j++;
                }    
            }
        }
        
        var result = {
        	"NAME":NAME,
        	"HP":HP
        };
        //alert('${params.finalAction}');
        <c:if test="${!empty params.finalAction}"> 
            opener.${params.finalAction}(result);
        </c:if>
        window.close();
    }

    function Close() {
        window.close();
    }
</script>