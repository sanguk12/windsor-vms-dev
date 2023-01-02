<script type="text/javascript">
    
    /**************************************
    * 본사 조직인 경우는 본사 조직명 표시
    * 대리점 조직인 경우는 대리점 명 표시
    **************************************/
    var name='';
    if ('${params.partnerDivCD}' == 'HQ'){
        name='${params.orgName}';
    }
    else if ('${params.partnerDivCD}' == 'AC'){
        name='${params.partnerName}';
    }
    else {
        name='Organization';
    }
    
    
    
    var obj = new AW.UI.Input;
    obj.setControlText(name);
    obj.setControlImage("search");
    obj.setStyle("width","300px");
    obj.setStyle("height","21px");
    document.write(obj);
    
    obj.onControlValidated = function(text) {
        searchOrganization(text);
    }
    
    obj.onControlActivated = function(event) {
        if (obj.getControlText() == 'Organization')
        {
            obj.setControlText('');
        }
    }
    
    
    
    function callSearchOrganization()
    {
        searchOrganization(obj.getControlText());
    }
    
    function setOrganization(companyID, partnerID, orgCD, orgName)
    {
        YAHOO.example.container.panel.hide();

        // Session에 CompanyID, orgID, rpartnerID, partnerID  설정
        var table = new AW.XML.Table;     
        table.setURL("organization.do");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("method","modifySessionOrganization");
        table.setParameter("companyID",companyID);
        table.setParameter("partnerID",partnerID);
        table.request();
        
        var rowCount = table.getCount();
        if (rowCount > 0)
        {
            if (table.getData(0,0) == 'S')
            {
                _workspace.location.reload();
            }
            else
            {
                // 변경 조직정보 세션반영 실패
                alert('<fmt:message key="orgselector.msg1"/>');
                return;
            }
        }
        else
        {
        	// 변경 조직정보 세션반영 실패
        	alert('<fmt:message key="orgselector.msg1"/>');
            return;
        }
                    
        obj.setControlText(orgName);
    }

</script>&nbsp;
<img id="orgsearch" src="${contextPath}/images/btn_search.gif" align="absmiddle" onClick="javascript:callSearchOrganization()"/>

<script type="text/javascript">

    YAHOO.example.container.panel = new YAHOO.widget.Panel("orgselector", { width:"300px", autofillheight:"body", visible:false, draggable:false, close:true, zIndex:1000, x:316, y:28 } );
    
    function searchOrganization(text) {
    
        if (text == 'Organization') text = '';
        
        // 검색어가 없을 경우 검색어 입력 요구 메세지 표시
        /*
        if (trim(removeChar(text, '%')) == '') {
            alert('<fmt:message key="orgselector.msg2"/>');
            return;
        }
        */
        
        var body =
            "<table width='260'>"+
            "    <tr>"+
            "        <td align='center'>"+
            "            <iframe id='tree' name='tree' style='width:273px; height:304px; background-color:#f2f2f2;' frameborder='0' scrolling='auto' "+
            "                    src='/cms/orgtree.page?companyID="+"${params.companyID}"+"&partnerID="+"${params.partnerID}"+"&orgID="+"${params.orgID}"+"&orgName="+encodeURIComponent(text)+"'></iframe>"+
            "       </td>"+
            "   </tr>"+
            "   <tr>"+
            "       <td class='cond-td' align='center'>"+
            "            <p><a href='javascript: tree.d.openAll();'>open all</a> | <a href='javascript: tree.d.closeAll();'>close all</a></p>"+
            "       </td>"+
            "   </tr>"+
            "</table>";
            
	    YAHOO.example.container.panel.setHeader("Organization Selector");
	    YAHOO.example.container.panel.setBody(body);
	    YAHOO.example.container.panel.setFooter("anyWorks/PRM 3");
	    YAHOO.example.container.panel.render(document.body);
		
		YAHOO.example.container.panel.show();
		
	}
</script>

<script type="text/javascript">
    
    /************************************
    *  권한레벨에 의한 조직변경 기능 제한
    *  10:  System Administrator
    *  20:  Company Adminstrator
    *  30:  Company Power User
    *  40:  Company User
    *  50:  Agency User
    ************************************/
    if (parseFloat('${params.authLevelCD}') > 30){
        obj.setControlDisabled(true);
        document.getElementById("orgsearch").style.visibility = 'hidden';
    }

</script>