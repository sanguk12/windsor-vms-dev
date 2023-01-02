<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf8"%>
<%@include file="../sys3/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>${params.viewName}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<%@include file="../sys3/scripts.jsp"%>
<%@include file="../sys3/cms/calendar.jsp"%>
</head>

<body class="yui-skin-sam" ${bodyConfig}>
	<form name="form" method="post">
		<div id="wrapDiv" class="pd-l">
			<div id="formDiv">
				<table border="0" cellpadding="0" cellspacing="0" width="100%"
					height="100%">
					<tr>
						<td height="1"><%@include
								file="../sys3/cms/standardParam.jsp"%>
							<%@include file="../sys3/cms/functionbar.jsp"%>
						</td>
					</tr>
					<tr>
						<td height="1">
							<table border="0" cellspacing="0" cellpadding="0" width="100%">
								<tr>
									<td class="tb-border">
										<table border="0" cellpadding="0" cellspacing="0" width="100%"
											style="border: #e1dcbe solid 1px; table-layout: fixed;">
											<colgroup>
												<col style="width: 100px"></col>
												<col style="width: 150px"></col>
												<col style="width: 120px"></col>
												<col></col>
											</colgroup>

										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table border="0" cellpadding="0" cellspacing="0" width="100%"
								height="100%">
								<tr>
									<td height="1" style="padding-top: 10px;">
										<table border="0" cellspacing="0" cellpadding="0" width="100%">
											<tr>
												<td style="text-align: right;"><script
														type="text/javascript">
													var addRow = new AW.UI.Button;
													addRow.setControlText("<fmt:message key="button.AddRow" />");
													addRow.setControlImage("addRow");
													document.write(addRow);

													addRow.onControlClicked = function(event) {
														grid.addRow(maxRow++);
														grid.setCellText("U", _col.activeFlg, maxRow - 1);
														grid.refresh();
													};
												</script></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height="*">
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
											height="100%">
											<tr>
												<td><span id="grid"></span></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			${appletDiv}
		</div>
	</form>
</body>
</html>

<!-- grid format -->
<style type="text/css">
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-grid-header {text-align: center; border-right: 1px solid #aca899 !important}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 100px;text-align: center;}
	.aw-column-1 {width: 120px;text-align: center;}
	.aw-column-2 {width: 150px;text-align: center;}
	.aw-column-3 {width: 150px;text-align: center;}

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
	
</style>

<script type="text/javascript">
	/****************************************
	 * Variable
	 ****************************************/
	var maxRow = 0;


	/****************************************
	 * Function
	 ****************************************/
	$(function() {
	});

	$(document).ready(function() {

		window.onload = function() {

			//try{$("#rate").attr("disabled",true)}catch(e){}
			//try {$("#rate").addClass("input-readonly")} catch (e) {}
				createGrid();
				grid.refresh();
				Search();
			};
	
		${initScript}
	});

	/*	function getRegDateCheck() {
 	 var row = grid.getCurrentRow(); 
	 if(grid.getCellText(_col.fromRate,row)=="" || grid.getCellText(_col.toRate,row)=="") {
		 return;
	 }
	
	 if(grid.getCellText(_col.fromRate,row) > grid.getCellText(_col.toRate,row)){
	 	alert("<fmt:message key="MDM04001A.msg1" />");
	 	grid.setCellText(grid.getCellText(_col.fromRate, row), _col.toRate, row);
	 	setCellFocus(grid, _col.toRate, row);
	 	return false;
	 }
	 } 	 */

	 //수량(이상)체크
	function getOverQtyCheck(row) {
		if (grid.getCellText(_col.activeFlg, row) != "D") {
			if (grid.getCellText(_col.fromRate, row) == "") {
			
			} else {
			//	currentOverQty = grid.getCellText(_col.fromRate, row);
			}

			if (grid.getCellText(_col.activeFlg, row - 1) != "D") {

				if (grid.getCellText(_col.fromRate, row - 1) == "") {
				//	beforeOverQty = 0;
				} else {
					//beforeOverQty = grid.getCellText(_col.fromRate, row - 1);
				}

				if (grid.getCellText(_col.toRate, row - 1) == "") {
					//beforeUnderQty = 0;
				} else {
					//beforeUnderQty = grid.getCellText(_col.toRate, row - 1);
				}
			}
		}
	}

	//수량(미만)체크
	function getUnderQtyCheck(row) {
		if (grid.getCellText(_col.fromRate, row) == "") {
			//currentUnderQty = 0;
		} else {
		//	currentUnderQty = grid.getCellText(_col.fromRate, row);
		}

		if (grid.getCellText(_col.toRate, row) == "") {
		//	currentOverQty = 0;
		} else {
		//	currentOverQty = grid.getCellText(_col.toRate, row);
		}

		if (grid.getCellText(_col.fromRate, row - 1) == "") {
		//	beforeOverQty = 0;
		} else {
			//beforeOverQty = grid.getCellText(_col.fromRate, row - 1);
		}

		if (grid.getCellText(_col.toRate, row - 1) == "") {
			//beforeUnderQty = 0;
		} else {
		//	beforeUnderQty = grid.getCellText(_col.toRate, row - 1);
		}
	}

	function removeRow(row) {
		grid.deleteRow(row);
		grid.setCellText("D", _col.activeFlg, row);
		grid.refresh();
	}
</script>

<script type="text/javascript">
	/****************************************
	 * Button Action
	 ****************************************/

	var _i = 0;
	var _col = {
		fromRate : _i++,
		toRate : _i++,
		rate : _i++,
		deleteBtn : _i++,
		activeFlg : _i++
	};

	function Search() {
		var table = new AW.XML.Table;
		table.setURL("${contextPath}/service/simpleAction/CVR0100101S");
		table.setAsync(false);
		table.setRequestMethod("POST");
		table.setParameter("outParamKey", "fromRate;toRate;rate;deleteBtn;");
		table.setParameter("format", "str;str;str;str;");
		table.request();

		//         if (grid != null) grid.clear();
		createGrid();

		var rowCount = table.getCount();
		if (rowCount > 0) {
			var data = new Array();
			for (var i = 0; i < rowCount; i++) {
				data[i] = [ 
					table.getData(_col.fromRate, i),
					table.getData(_col.toRate, i),
					table.getData(_col.rate, i),
					table.getData(_col.deleteBtn, i),
					'U'
				];
			}
			grid.setCellData(data);
			grid.setRowCount(rowCount);

		} else {
			message("<fmt:message key="info.nullData"/>");
		}
		grid.refresh();

		maxRow = rowCount;
	}

	function Save() {
		var regxp = /^\d+(?:[.]?[\d]?[\d])?$/;
			  
		var fromRate = new Array();
		var toRate = new Array();
		var rate = new Array();
		var activeFlg = new Array();
		var j = 0;
		for (var i = 0; i < maxRow; i++) {
				if (grid.getCellText(_col.activeFlg, i) != "D") {
					if(!regxp.test(grid.getCellText(_col.fromRate, i))){
						alert("<fmt:message key="CVR01001A.msg5" />");
						setCellFocus(grid, _col.fromRate, i);
						return;
					}
					if(!regxp.test(grid.getCellText(_col.toRate, i))){
						alert("<fmt:message key="CVR01001A.msg5" />");
						setCellFocus(grid, _col.toRate, i);
						return;
					}
					if(!regxp.test(grid.getCellText(_col.rate, i))){
						alert("<fmt:message key="CVR01001A.msg5" />");
						setCellFocus(grid, _col.rate, i);
						return;
					}
					if (grid.getCellText(_col.fromRate, i) == "") {
						alert("<fmt:message key="CVR01001A.msg2" />");
						setCellFocus(grid, _col.fromRate, i);
						return;
					}
					if (grid.getCellText(_col.toRate, i) == "") {
						alert("<fmt:message key="CVR01001A.msg3" />");
						setCellFocus(grid, _col.toRate, i);
						return;
					}
					if (grid.getCellText(_col.rate, i) == "") {
						alert("<fmt:message key="CVR01001A.msg4" />");
						setCellFocus(grid, _col.rate, i);
						return;
					}
					fromRate[j] = grid.getCellText(_col.fromRate, i);
					toRate[j] = grid.getCellText(_col.toRate, i);
					rate[j] = grid.getCellText(_col.rate, i);
					j++;
				}
				
		}
			var table = new AW.XML.Table;
			table.setURL("${contextPath}/service/cvr01/savePrdGuidAmt");
			table.setAsync(false);
			table.setRequestMethod("POST");
			table.setParameter("fromRate", fromRate);
			table.setParameter("toRate", toRate);
			table.setParameter("rate", rate);
			table.setParameter("activeFlg", activeFlg);
			table.request();

			var rowCount = table.getCount();
			if (rowCount > 0) {
				if (table.getData(0, 0) == 'S') {
					message(table.getData(1, 0));
					Search();
				} else {
					alert(table.getData(1, 0));
				}
			}
	}
</script>

<script type="text/javascript">



	/*****************************************************
	 *	Grid Setting
	 *****************************************************/
	var grid = null;

//	var columns = [ "<fmt:message key="CVR01001A.targetRate"/>", "", "", "" ];

	var columns_header = [ 
			"<fmt:message key="CVR01001A.from"/>",
			"<fmt:message key="CVR01001A.to"/>",
			"<fmt:message key="CVR01001A.rewarRate"/>",
			"<fmt:message key="CVR01001A.deleteBtn"/>" ];

/* 	AW.Grid.Header2 = AW.Grid.Header.subclass();
	AW.Grid.Header2.create = function() {

		var obj = this.prototype;
		obj.element = AW.System.HTML.prototype.element;

		function display() {
			var span = this.getHeaderProperty("span");
			return span == 0 ? "none" : null;
		}

		function width() {
			var span = this.getHeaderProperty("span");
			if (span == 1) {
				return null;
			}
			var pos = this.getColumnProperty("position");
			var a = this.getColumnProperty("indices");
			var i, col, w = 0;
			for (i = 0; i < span; i++) {
				col = a ? a[pos + i] : pos + i; // column index 
				w += this.getColumnProperty("width", col);
			}
			return w;
		}

		obj.setStyle("display", display);
		obj.setStyle("width", width);
	}; */

	function createGrid() {
		grid = new AW.Grid.Extended;

		grid.setId("grid");
		grid.setSize(400, 290);
		grid.setRowCount(0);
		grid.setHeaderHeight(20);
		grid.setStyle("width", "100%");
		grid.setStyle("height", "100%");
		grid.setSelectorVisible(false);
		grid.setSelectionMode("single-cell");
		grid.setCellEditable(false);
		grid.setCellEditable(true, _col.fromRate);
		grid.setCellEditable(true, _col.toRate);
		grid.setCellEditable(true, _col.rate);
		/* 
		grid.setHeaderText(columns);
		for (var i = 0; i < columns.length; i++) {
			grid.getHeaderTemplate(i).setStyle("text-align", "center");
		}
		 */
		grid.setColumnCount(columns_header.length);
		grid.setCellFormat([str, str, str, str]);
		grid.defineHeaderProperty("span", 1);
		//grid.setHeaderTemplate(new AW.Grid.Header2);
	//	grid.setHeaderCount(2);

		grid.refresh();

		grid.onColumnWidthChanged = function() {
			this.getHeadersTemplate(1, "center").refresh();
		};
	//	grid.setHeaderText(columns, 1);
		grid.setHeaderText(columns_header);
	//	grid.setHeaderIndices([ 1, 0 ]);

		/* grid.setHeaderSpan(2, 0, 1);
		grid.setHeaderSpan(0, 1, 1);
		grid.setHeaderSpan(1, 2, 1);
		grid.setHeaderSpan(1, 3, 1);  */
 
		grid.getHeadersTemplate().setClass("text", "wrap");

		grid.setFixedLeft(4);
		grid.setVirtualMode(false);
		grid.setSize(400, $(document).height());
		grid.setStyle("width", "100%");

		grid.setCellImage("deleteGrid", _col.deleteBtn);
		var deleteFlag = new AW.Templates.Image;
		var delImage = deleteFlag.getContent("box/image");
		delImage.setTag("a");
		delImage.setAttribute("href", function() {
			return "javascript:removeRow(grid.getCurrentRow())";
		});
		grid.setCellTemplate(deleteFlag, _col.deleteBtn);

		// Cell startEdit BEGIN
		grid.onCellSelectedChanged = function(selected, col, row) {
			if (selected) {
				this.setTimeout(function() {
					this.raiseEvent("editCurrentCell", {}, col, row);
				});
			}
		};

		grid.onCellClicked = function(event, col, row) {
			if (this.getCellSelected(col, row)) {
				this.setTimeout(function() {
					this.raiseEvent("editCurrentCell", {}, col, row);
				});
			}
		};

		grid.onCellEditStarted = function(text, col, row) {
			if (col == _col.fromRate) {
				this.setCellText(text, col, row);
			}
			if (col == _col.toRate) {
				this.setCellText(text, col, row);
			}
			if (col == _col.rate) {
				this.setCellText(text, col, row);
			}
		};

		grid.onCellEditEnded = function(text, col, row) {
			this.setCellText(text, col, row);
		};
		// Cell startEdit END

		//  BEGIN validating (Enter, Cell LoseFocus)
		grid.onCellValidating = function(text, col, row) {
			if (col == _col.fromRate) {
				if (text> 95.0) {
					alert('<fmt:message key="MDM03002A.msg5" />');
					this.setCellText("", col, row);
				}
				if (parseFloat(text) < 0) {
					alert('<fmt:message key="MDM03002A.msg4" />');
					this.setCellText("", col, row);
				}
				getOverQtyCheck(row);
			}
			if (col == _col.toRate) {
				if (text == "" || text == null) {
					this.setCellFocus(grid, col, row);
					return;
				}
				if (text.length > 5) {
					alert('<fmt:message key="MDM03002A.msg5" />');
					this.setCellText("", col, row);
				} else if (parseFloat(text) < 0) {
					alert('<fmt:message key="MDM03002A.msg4" />');
					this.setCellText("", col, row);
				}
				getUnderQtyCheck(row);
			}
			if (col == _col.rate) {
				if (text.length > 5) {
					alert('<fmt:message key="MDM03002A.msg6" />');
					this.setCellText("", col, row);
				} else if (text < 0) {
					alert('<fmt:message key="error.noMinusNum" />');
					this.setCellText("", col, row);
				}
			}
			this.setCellText("U", _col.activeFlg, row);
		};

		grid.onCellValidated = function(text, col, row) {
			if (col == _col.fromRate) {
				this.setCellText(text, col, row);
			}
			if (col == _col.toRate) {
				this.setCellText(text, col, row);
			}
			if (col == _col.rate) {
				this.setCellText(text, col, row);
			}
		};
		//  END validated Action (Enter, Cell LoseFocus)

		grid.onHeaderClicked = function() {
			return true;
		};
	}
</script>
