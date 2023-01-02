<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>${params.viewName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="Pragma" content="no-cache">
    <%@include file="../scripts.jsp" %>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
   	<div id="wrapDiv">
    	<div id="formDiv">
	      	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
	        	<tr>
	            	<td height="1">
		            	<%@include file="../cms/standardParam.jsp" %>
		            
		            	<input type="hidden" id="funcID" name="funcID">
		            	<input type="hidden" id="currentFuncCode" name="currentFuncCode">
		            	<input type="hidden" id="uniqueYN" name="uniqueYN" value="N">
		
						<%@include file="../cms/functionbar.jsp" %>
					</td>
				</tr>
				<tr>
               		<td height="1">
                 		<table border="0" cellspacing="0" cellpadding="0" width="100%" >
                 			<tr>
                 				<td class="tb-border">
					        	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:#e1dcbe solid 1px;">
					        		<colgroup>
					        			<col style="width:80px;"></col>
					        			<col></col>
					        		</colgroup>
					        		<tbody>
									<tr>
										<td class="td-cond">
											<fmt:message key="CMP01001A.searchWord" />
										</td>
										<td class="td-input">
											<input type="text" id="searchWord" name="searchWord" style="width:200px;">
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
               	<td height="*">
                   	<span id="grid"></span>
                 	</td>
             	</tr>
             	<tr>
             		<td height="1" style="padding-top:10px;">
             			<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr>
							<td class="group-title">
								<fmt:message key="CMP01001A.basicInfo" />
							</td>
						</tr>
						<tr>
							<td class="tb-border">
								<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
									<colgroup>
										<col style="width:100px"></col>
										<col style="width:200px"></col>
										<col style="width:80px"></col>
										<col style="width:150px"></col>
										<col style="width:80px"></col>
										<col style="width:110px"></col>
										<col style="width:80px"></col>
										<col></col>
									</colgroup>
									<tbody>
		                            <tr>
		                                <td class="td-cond-required">
		                                	<fmt:message key="CMP01001A.funcCode" />
		                                </td>
		                                <td class="td-input">
		                                    <input type="text" id="funcCode" name="funcCode" style="width:100px;">
		                                    <div id="overLap"></div>
		                                </td>
		                                <td class="td-cond-required">
		                                	<fmt:message key="CMP01001A.funcName" />
		                                </td>
		                                <td class="td-input">
		                                    <input type="text" id="funcName" name="funcName" style="width:140px" > 
		                                </td>
		                                <td class="td-cond-required">
		                                	<fmt:message key="CMP01001A.seq" />
		                                </td>
		                                <td class="td-input">
		                                    <input type="text" id="seq" name="seq" style="width:100px; text-align:right;"> 
		                                </td>
		                                <td class="td-cond">
		                                	<fmt:message key="CMP01001A.icon" />
		                                </td>
		                                <td class="td-input">
		                                	<nis:selectbox id="icon" defaultText="select" category="ICONCD" event="onchange" eventProc="iconImage(this.value);" />
		                                	<span id="iconImage"></span>
		                                </td>
		                            </tr>
		                            <tr>
		                                <td class="td-cond">
		                                	<fmt:message key="CMP01001A.standardYN" />
		                                </td>
		                                <td class="td-input">
		                                    <nis:radio id="standardYN" name="standardYN" category="USETYPE2CD" value="N" />
		                                </td>
		                                <td class="td-cond-required">
		                                	<fmt:message key="CMP01001A.command" />
		                                </td>
		                                <td class="td-input">
		                                    <input type="text" id="command" name="command" style="width:140px;">
		                                </td>
		                                <td class="td-cond">
		                                	<fmt:message key="CMP01001A.remark" />
		                                </td>
		                                <td class="td-input" colspan="3">
		                                    <input type="text" id="remark" name="remark" style="width:250px" > 
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
</body>
</html>

<style type="text/css">
<!--
    .aw-grid-control {height: 100%; width: 100%; margin: 0px;}
    
    .aw-column-0 {width: 150px;}
    .aw-column-1 {width: 150px;}
    .aw-column-2 {width: 70px; text-align: right;}
    .aw-column-3 {width: 150px; }
    .aw-column-4 {width: 100px; text-align: center;}
    .aw-column-5 {width: 300px;}

    .aw-grid-cell {border-right: 1px solid threedlightshadow;}
    .aw-grid-row {border-bottom: 1px solid threedlightshadow;}
    
//-->
</style>

<script type="text/javascript">

	/****************************************
	* Function
	****************************************/
	$(function() {
		$("#funcCode").alphanumeric();
		$("#seq").numeric();
		$("#command").alphanumeric();
	});
	
	$(document).ready(function() {
		
		window.onload = function() {
			Search();
		};
	
		${initScript}
		
		$("#searchWord").keypress(function(){
			if (event.keyCode==13){
				Search();
				return false;
			}
		});
		
		$("#funcCode").change(function() {
			// 뷰ID 가 처음 입력한 것과 다른 경우 중복확인여부 초기화
	        if ($("#funcCode").val() != $("#currentFuncCode").val()) {
	            $("#uniqueYN").val('N');
	        }
		});
	
	});
	
    //중복확인 버튼 생성
     var overLap = new AW.UI.Button;
     overLap.setId("overLap");
     overLap.setControlText("<fmt:message key="button.Overlap"/>");
     overLap.refresh();
      
     overLap.onControlClicked = function(event){
        
        if ($("#funcCode").val() == '')
        {
            alert('<fmt:message key="CMP01001A.msg1"/>');
            return;
        }
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/simpleAction/CMP0100102S");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("outParamKey","count;");
        table.setParameter("funcCode", $("#funcCode").val());
        table.request();
        
        var rowCount = table.getCount();
        if (rowCount > 0) {
            if (table.getData(0,0) != '0') {
                $("#uniqueYN").val('N');
                alert('<fmt:message key="CMP01001A.msg2"/>');
                $("#funcCode").val('');
                $("#funcCode").focus();
            }
            else {
                $("#uniqueYN").val('Y');
                $("#currentFuncCode").val($("#funcCode").val());
                alert('<fmt:message key="CMP01001A.msg3"/>');
                $("#funcName").focus();
            }
        }
        else {
            $("#uniqueYN").val('N');
            alert('<fmt:message key="CMP01001A.msg4"/>');
        }
     }    
     
     function iconImage(iconCode) {
    	 var buttonCode = iconCode.toLowerCase();
    	 var str = "";
    	 str = "<img id='pwd_init' src='${themeURL}/styles/"+buttonCode+".png' hspace='3' style='vertical-align:middle;'>";
    	 $("#iconImage").html(str);
     }
     
</script>
    
<script type="text/javascript">

	function Search() {
    	
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0100101S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	  	table.setParameter("outParamKey","funcID;funcCode;funcName;seq;icon;standardYNDesc;remark;standardYN;command;");
	  	table.setParameter("searchWord", $("#searchWord").val());
      	table.request();
      	
      	if (grid != null) grid.clear();
      	createGrid();
      	
      	var rowCount = table.getCount();
      	if (rowCount > 0) {
      		var data = new Array();
      		for (var i=0; i < rowCount; i++) {
      			data[i] = [
      				table.getData(1,i), //funcCode
      				table.getData(2,i), //funcName
      				table.getData(3,i), //seq
      				table.getData(4,i), //icon
      				table.getData(5,i), //standardYNDesc
      				table.getData(6,i), //reamrk
      				table.getData(7,i), //standardYN
      				table.getData(0,i),  //funcID
      				table.getData(8,i)   //command
      			];
      		}
      		
      		grid.setCellData(data);
      		grid.setRowCount(rowCount);
      	}
      	grid.refresh();
	}
    
    function New() {
        overLap.setStyle("visibility","visible");
        document.getElementById("funcCode").className = '';
        document.getElementById("funcCode").readOnly = false;
        $("#uniqueYN").val("N");
        
        $("#funcID").val("");
        $("#funcCode").val("");
        $("#funcName").val("");
        $("#seq").val("");
        $("#icon").val("");
        setRadioValue("standardYN","N");
        $("#command").val("");
        $("#remark").val("");
        
        $("#iconImage").html("");
    }
    
    function Save() {
    	
        if ($("#uniqueYN").val() == 'N') {
            alert('<fmt:message key="CMP01001A.msg5"/>');
            return;
        }
        
        var table = new AW.XML.Table;
        table.setURL("${contextPath}/service/function/saveFunction");
        table.setAsync(false);
        table.setRequestMethod("POST");
        table.setParameter("funcID", $("#funcID").val());
        table.setParameter("funcCode", $("#funcCode").val());
        table.setParameter("funcName", $("#funcName").val());
        table.setParameter("seq", $("#seq").val());
        table.setParameter("icon", $("#icon").val());
        table.setParameter("standardYN", getRadioValue("standardYN"));
        table.setParameter("command", $("#command").val());
        table.setParameter("remark", $("#remark").val());
        table.request();
        
        if (table.getData(0,0) == 'S') {
            message(table.getData(1,0));
            
            overLap.setStyle("visibility","hidden");
            document.getElementById("funcCode").className = 'input-readonly';
            document.getElementById("funcCode").readOnly = true;
            $("#uniqueYN").val('Y');
            
            $("#funcID").val(table.getData(3,0));
            Search();
        }
        else {
           alert(table.getData(1,0));
        }
    }
    
    function Delete() {
    	
        if (confirm("<fmt:message key="confirm.delete"/>")) {
            
            var table = new AW.XML.Table;
            table.setURL("${contextPath}/service/function/removeFunction");
            table.setAsync(false);
            table.setRequestMethod("POST");
            table.setParameter("funcID", $("#funcID").val());
            table.request();
            
            if (table.getData(0,0) == 'S') {
                message(table.getData(1,0));
                Search();
                New();
            }
            else {
               alert(table.getData(1,0));
            }
        }
    }
    
	
	
	/*****************************************************
	*	Grid Setting
	*****************************************************/
	var grid = null;

	var columns = [
		"<fmt:message key="CMP01001A.funcCode"/>",
		"<fmt:message key="CMP01001A.funcName"/>",
		"<fmt:message key="CMP01001A.seq"/>",
		"<fmt:message key="CMP01001A.icon"/>",
		"<fmt:message key="CMP01001A.standardYN"/>",
		"<fmt:message key="CMP01001A.remark"/>"
	];
	
	function createGrid() {
	
		grid = new AW.UI.Grid;
		grid.setId("grid");
		grid.setSelectorWidth(35);
		grid.getSelectorTemplate().setStyle("text-align", "right");
		grid.setSelectorVisible(true);
		grid.setSelectorText(function(i){return this.getRowPosition(i)+1});
		grid.setSelectionMode("single-row");
		grid.setCellEditable(false);
		grid.setHeaderText(columns);
		for(var i=0;i<columns.length;i++){grid.getHeaderTemplate(i).setStyle("text-align", "center");}
		grid.setColumnCount(columns.length);
		grid.setCellFormat([str, str, str, str, str, str]);
		
		grid.onRowDoubleClicked = function(event, row) {
            overLap.setStyle("visibility","hidden");
            document.getElementById("funcCode").className = 'input-readonly';
            document.getElementById("funcCode").readOnly = true;
            $("#uniqueYN").val('Y');
            
            $("#funcID").val(this.getCellText(7,row));
            $("#funcCode").val(this.getCellText(0,row));
            iconImage(this.getCellText(0,row));
            $("#funcName").val(this.getCellText(1,row));
            $("#seq").val(this.getCellText(2,row));
            $("#icon").val(this.getCellText(3,row));
            setRadioValue("standardYN", this.getCellText(6,row));
            $("#command").val(this.getCellText(8,row));
            $("#remark").val(this.getCellText(5,row));
	    }
	}
</script>