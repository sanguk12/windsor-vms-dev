<script type="text/javascript" src="${contextPath}/scripts/menu/milonic_src.js"></script>
<script type="text/javascript">
if(ns4)_d.write("<scr"+"ipt type=text/javascript src=${contextPath}/scripts/menu/mmenuns4.js><\/scr"+"ipt>");
  else _d.write("<scr"+"ipt type=text/javascript src=${contextPath}/scripts/menu/mmenudom.js><\/scr"+"ipt>");
</script>
<script type="text/javascript" src="${params.themeURL}/scripts/styleMenu.js"></script>

<script type="text/javascript">

		    <!-- WaterFall Menu Style Item START-------------------------------------->
			<c:forEach items="${mnuGrpIDList}" var="mnuGrpID" varStatus="status">
				<c:choose>
					<c:when test="${status.count==1}">
						// Title Menu
						with(milonic=new menuname("${mnuGrpID}")){
						    menuwidth="100%";
							alwaysvisible=1;
							menuwidth="100%";
							left=0;
							orientation="horizontal";
							style=menuStyle;
							top=_menuTop;
					</c:when>
					<c:otherwise>
						/// Submenu Definitions ///
						with(milonic=new menuname("${mnuGrpID}")){
						margin=3;
						style=submenuStyle;	
					</c:otherwise>
				</c:choose>			
			
				<c:set var="mnuMapList" value="${mnuMap[status.count-1]}"/>
				
				<c:forEach items="${mnuMapList}" var="mnuItem" varStatus="statusMap">
					<c:choose>
						<c:when test="${status.count==1}">
							aI("text=${mnuItem.name}<nis:space length="5"/>;"+
							     "<c:if test="${!empty mnuItem.URL}">url=${mnuItem.URL};clickfunction=parent.urlfunction_workspace('${mnuItem.URL}');</c:if>"+
							     "<c:if test="${mnuItem.kind=='G'}">showmenu=${mnuItem.code};</c:if>");
						</c:when>
						<c:otherwise>
							aI("text=${mnuItem.name};<c:if test="${!empty mnuItem.URL}">url=${mnuItem.URL}</c:if>"+
								"<c:if test="${!empty mnuItem.code}">mnuGrpID=${mnuGrpID}&pgmID=${mnuItem.code};clickfunction=parent.urlfunction_workspace('${mnuItem.URL}mnuGrpID=${mnuGrpID}&pgmID=${mnuItem.code}');target=_workspace;</c:if><c:if test="${mnuItem.kind=='G'}">showmenu=${mnuItem.code};</c:if>");
						</c:otherwise>
					</c:choose>
				</c:forEach>
				}
			</c:forEach>	
			
	drawMenus();
	
</script>