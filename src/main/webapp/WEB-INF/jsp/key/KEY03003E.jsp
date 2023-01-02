<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 사업자 등록증 등록화면 -->
<html>
	<head>
        <title>${params.viewName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%@include file="../sys3/scripts.jsp" %>
	</head>
	<body class="yui-skin-sam" ${bodyConfig}>
		<form name="form" method="post">
			<div id="wrapDiv">
          		<div id="formDiv">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		            	<tr>
		                    <td height="1">
					            <%@include file="../sys3/cms/standardParam.jsp" %>
								<%@include file="../sys3/cms/calendar.jsp" %>
								<!-- PDF -->
								<input type="hidden" id="path" name="path" value = "C:/deploy/diageo" />
					            <input type="hidden" id="report" name="report">
					            <input type="hidden" id="format" name="format">
					            <input type="hidden" id="keymanID" name="keymanID">
					            <!-- hidden -->
					            <input type="hidden" id="docLinkID" name="docLinkID">
					            <input type="hidden" id="valexStatCd" name="valexStatCd">
							</td>
						</tr>
						<tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td class="tb-border">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col style="width:100px;"></col>
								        			<col style="width:250px;"></col>
								        			<col style="width:100px;"></col>
								        			<col style="width:250px;"></col>
								        			<col style="width:100px;"></col>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
								        			<tr>
						                            	<td class="td-cond">
						                            		<fmt:message key="KEY03003E.depDocuStat" />
														</td>
														<td class="td-input" colspan="5"> 
															<input type="text"  id="defaultPrgs" name="defaultPrgs" class="input-readonly" readonly="readonly" style="width:80px; text-align: center;"/>
						                                </td>
						                            </tr>
						                            <tr>
						                            	<td class="td-cond">
						                            		<fmt:message key="KEY03003E.docuStat" />
														</td>
														<td class="td-input"> 
															<nis:selectbox id="keymanPrgsCd" name="keymanPrgsCd" defaultText="select" category="KEYMANPRGSCD" />
						                                </td>
						                                <td class="td-cond">
						                                	<fmt:message key="KEY03003E.comment" />
														</td>
														<td class="td-input" colspan="3"> 
															<input type="text" id="Comment" name="Comment" style="width:450px;"/>
						                                </td>
						                            </tr>
					                            </tbody>
					                        </table>
		                    			</td>
		                   			</tr>
								</table>
		                    </td>
		                </tr>
		                <tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                    		<tr>
		                    			<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
					                            <colgroup>
								        			<col></col>
								        		</colgroup>
								        		<tbody>
							                		<tr height="100%" >
									                	<td>
														    <img src="" id='previewId' style="width: 99%; height: auto; margin-left: 10px; margin-top: 10px; margin-right: 10px; margin-bottom: 10px;"></img>
													    </td>
									                </tr>
									                <tr>
														<td height="*" valign="top">
														</td>
													</tr>
					                            </tbody>
					                        </table>
		                    			</td>
		                   			</tr>
								</table>
		                    </td>
		                </tr>
		                <tr>
							<td height="*" valign="top">
							</td>
						</tr>
					</table>
				</div>
				${appletDiv}
			</div>
					
		</form>
	</body>
</html>

<script language="javascript">

	/****************************************
	 * Variable
	 ****************************************/
	 
	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});
	
	
	$(document).ready(function() {

		window.onload = function() {
			
			$("select[name='keymanPrgsCd'] option[value='999']").remove();
			$("select[name='keymanPrgsCd'] option[value='100']").remove();
			$("select[name='keymanPrgsCd'] option[value='200']").remove();
			
			$("#keymanID").val(parent.$("#keyManCD_S").val());
			
			Search();
			
		};
		
		${initScript}

	});
	
	function ValidationCheck() {
		var isBoolean = true;
		
		var DocFinshFl = parent.$("#DocFinshFl").val();
		var valexStatCd = $("#valexStatCd").val();
		
		
		if(DocFinshFl == 'Y') {
			alert("<fmt:message key="KEY03003E.msg1"/>");
			return;
			//isBoolean = false;
		}
		if(valexStatCd == '999') {
			alert("<fmt:message key="KEY03003E.msg4"/>");
			return;
			//isBoolean = false;
		}
		if($("#keymanPrgsCd").val() == ''){
			alert("<fmt:message key="KEY03003E.msg5"/>");
			return false;
		}
		
		return isBoolean;
	}
</script>

<script type="text/javascript">

	/****************************************
	* Button Action
	****************************************/
	
	function Save() {
		if(!ValidationCheck()){
			return;
		}
		
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key04/updateGKEY05MT");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("docComment", $("#Comment").val());
		table.setParameter("keymanPrgsCd", $("#keymanPrgsCd").val());
		table.setParameter("keymanID", parent.$("#keyManCD_S").val());
		table.setParameter("keymanDocTpCd", "300");
		
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
   		} else {
			alert(table.getData(1,0));
		}
		
	}
	
	function Pdf() {
		if($("#docLinkID").val() == ""){
			alert("<fmt:message key="KEY03003E.msg3"/>");
			return;
		}
		
		var winprops = getWindowOpenParam(1000,700,"yes");
	    var win = window.open("", "reportviewer", winprops);
	            
	    document.form.action = "${contextPath}/service/simpleReport";
        document.form.target = "reportviewer";
        document.getElementById("report").value = "KEY03003E";
        document.getElementById("format").value = "pdf";
        document.getElementById("path").value;
        //document.getElementById("keymanID").value = parent.$("#keyManCD_S").val();
        document.getElementById("keymanID").value = parent.$("#keyMan").val();
        document.form.submit();
	}
	
	function KeymDocConf(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key03/updateKeymanDocComp");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("keymanID", parent.$("#keyManCD_S").val());
		table.setParameter("keymanDocTpCd", "300");
		table.setParameter("docFinshFl", "Y");
		
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			parent.$("#DocFinshFl").val('Y');
			parent.$("#DocFinshFlNm").val('완료');
   		} else {
			alert(table.getData(1,0));
		}
	}
	
	function KeymDocConfCancel(){
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/key03/updateKeymanDocComp");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("keymanID", parent.$("#keyManCD_S").val());
		table.setParameter("keymanDocTpCd", "300");
		table.setParameter("docFinshFl", "N");
		table.request();

		if(table.getData(0,0) == "S") {
			alert(table.getData(1,0));
			parent.$("#DocFinshFl").val('N');
			parent.$("#DocFinshFlNm").val('미완료');
   		} else {
			alert(table.getData(1,0));
		}
	}
	
	function Search() {
		var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/KEY0400103S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey", "venueCD;venueNm;keymanID;keymanNm;birthDate;"
        											+ "DocFinshFl;DocFinshFlNm;DocComment;FileDocLink;fileUrl;"
        											+ "uuid;keyManPrgsCd;KeymanPrgsNm;");
        table.setParameter("format", "str;str;str;str;str;"
        									+"str;str;str;str;str;"
        									+"str;str;str;");
        table.setParameter("kmID", parent.$("#keyMan").val());
        table.setParameter("wordType", "300");
        table.request();
        
        var rowCount = table.getCount();
      	if (rowCount == 1) {
   			parent.$("#venueCD_S").val(table.getData(0,0));
   			parent.$("#venueNm_S").val(table.getData(1,0));
   			parent.$("#keyManCD_S").val(table.getData(2,0));
   			parent.$("#keyManNm_S").val(table.getData(3,0));
   			parent.$("#birthDay_S").val(formatDate(table.getData(4,0)));
   			parent.$("#DocFinshFl").val(table.getData(5,0));
   			parent.$("#DocFinshFlNm").val(table.getData(6,0));
   			$("#Comment").val(table.getData(7,0));
   			$("#docLinkID").val(table.getData(8,0));
   			
   			$("#keymanPrgsCd").val(table.getData(11,0));
   			$("#valexStatCd").val(table.getData(11,0));
   			$("#defaultPrgs").val(table.getData(12,0));
   			
   			var filePath = table.getData(9,0)+table.getData(10,0);
   			
   			if(table.getData(8,0) != ""){
   				$("#previewId").attr("src","/upload/"+filePath);
   				parent.$("#_tab4").attr("height","100%");
   			}
   			
      	}else {
      		message("<fmt:message key="info.nullData"/>");
      	}
		
	}
	
</script>