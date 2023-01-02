<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<script type="text/javascript">
    DHTMLSuite.include("calendar");    
</script>

<script type="text/javascript">

    document.onmousedown = mousedown_event;
    
    function mousedown_event( myEvent ) {
		var browser;
		if($.browser.mozilla)
			browser = "Firefox";
		else if($.browser.msie)
			browser = "IE";
		else if($.browser.opera)
			browser = "Opera";
		else if($.browser.safari)
			browser = "Safari";
		else if($.browser.chrome)
			browser = "Chrome";
		else
			browser = "Unknown";
		
		if(browser=="Firefox") {
			vMouseY = myEvent.clientY;
	        vMouseX = myEvent.clientX;
		}
		else if(browser=="IE") {
			vMouseY = event.clientY + document.body.scrollTop;
	        vMouseX = event.clientX + document.body.scrollLeft;
		}
		else if(browser=="Chrome") {
			vMouseY = event.clientY;
	        vMouseX = event.clientX;
		}
		else {
			vMouseY = event.clientY;
	        vMouseX = event.clientX;
		}
    }
    
    var calendarModel = new DHTMLSuite.calendarModel();
    calendarModel.setWeekStartsOnMonday(false);
    
	if ("${params.languageCD}".toUpperCase() == "KR") {
    	calendarModel.setLanguageCode('kr');
    }
    else {
    	calendarModel.setLanguageCode('en');
    }
    var calendarObjForForm = new DHTMLSuite.calendar({minuteDropDownInterval:10,numberOfRowsInHourDropDown:5,callbackFunctionOnDayClick:'getDateFromCalendar',isDragable:true,displayTimeBar:false}); 
    calendarObjForForm.setCalendarModelReference(calendarModel);
    
	
    function monthChangeCallback(arg){
    	
    	var _ym = arg.year+""+arg.month;
    	var _curDt = new Date();
    	var _curYm = _curDt.getFullYear()+""+((_curDt.getMonth()+1<10?"0":"")+_curDt.getMonth()+1);
		
    	if(_ym>_curYm){
			calendarObjForForm.setDisplayedMonth(_curDt.getMonth());
			calendarObjForForm.setDisplayedYear(_curDt.getFullYear());
		}
    }

    function dayClickCallback(arg){
    	
    	var curDt = "${params.currentDate}";
    	var cprDt = ''+arg.year+arg.month+arg.day;
    	
    	var dtObj =   new Date(curDt.replace(/\./ig, '/'));
    	dtObj.setDate(dtObj.getDate()-1);
    	
    	var inputArray = {};
    	var bfDt = ''+dtObj.getFullYear()+lpad(dtObj.getMonth()+1,2,'0')+lpad(dtObj.getDate(),2,'0');
    	if(bfDt <= cprDt){
    		inputArray.year=dtObj.getFullYear();
    		inputArray.month=lpad(dtObj.getMonth()+1,2,'0');
    		inputArray.day=lpad(dtObj.getDate(),2,'0');
    	}else{
    		inputArray.year=arg.year;
    		inputArray.month=arg.month;
    		inputArray.day=arg.day;
    	}
    	
    	 var references = calendarObjForForm.getHtmlElementReferences(); // Get back reference to form field.
         
         var delimiter = "";
 		if ("${params.dateFormatCD}".substring(3,4) == "D") {
         	delimiter = ".";
         }
         else if ("${params.dateFormatCD}".substring(3,4) == "S") {
         	delimiter = "/";
         }
         else if ("${params.dateFormatCD}".substring(3,4) == "B") {
         	delimiter = "-";
         }
         else {
         	delimiter = ".";
         }
 		
 	    if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
 	    	references.myDate.value = inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day;
         }
         else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
         	references.myDate.value = inputArray.month + delimiter + inputArray.day + delimiter + inputArray.year;
         }
         else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
         	references.myDate.value = inputArray.day + delimiter + inputArray.month + delimiter + inputArray.year;
         }
         else {
         	references.myDate.value = inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day;
         }
 	    
         calendarObjForForm.hide();  
    }
    
    var calendarTimeObjForForm = new DHTMLSuite.calendar({minuteDropDownInterval:10,numberOfRowsInHourDropDown:5,callbackFunctionOnDayClick:'getDateFromCalendarTime',isDragable:true,displayTimeBar:true}); 
    calendarTimeObjForForm.setCalendarModelReference(calendarModel);
    
    var calendarObjForGrid = new DHTMLSuite.calendar({minuteDropDownInterval:10,numberOfRowsInHourDropDown:5,callbackFunctionOnDayClick:'getDateFromCalendarForGrid',isDragable:true,displayTimeBar:false}); 
    calendarObjForGrid.setCalendarModelReference(calendarModel);
    
    var col=0;
    var row=0;
    var calendar_grid_temp = null;
    
    function myOtherFunction(){}
    
	function dayClickCallbackForGrid(arg){
    	
    	var curDt = "${params.currentDate}";
    	var cprDt = ''+arg.year+arg.month+arg.day;
    	var dtObj =   new Date(curDt.replace(/\./ig, '/'));

    	
    	var inputArray = {};
    	var bfDt = ''+dtObj.getFullYear()+lpad(dtObj.getMonth()+1,2,'0')+lpad(dtObj.getDate(),2,'0');
    	if(bfDt <= cprDt){
    		inputArray.year=dtObj.getFullYear();
    		inputArray.month=lpad(dtObj.getMonth()+1,2,'0');
    		inputArray.day=lpad(dtObj.getDate(),2,'0');
    	}else{
    		inputArray.year=arg.year;
    		inputArray.month=arg.month;
    		inputArray.day=arg.day;
    	}
    	
    	 var references = calendarObjForGrid.getHtmlElementReferences(); // Get back reference to form field.
    	 
         var delimiter = "";
 		if ("${params.dateFormatCD}".substring(3,4) == "D") {
         	delimiter = ".";
         }
         else if ("${params.dateFormatCD}".substring(3,4) == "S") {
         	delimiter = "/";
         }
         else if ("${params.dateFormatCD}".substring(3,4) == "B") {
         	delimiter = "-";
         }
         else {
         	delimiter = ".";
         }
 		
 	    if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
 	    	references.myDate.setCellText(inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day,col,row);
         }
         else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
         	references.myDate.setCellText(inputArray.month + delimiter + inputArray.day + delimiter + inputArray.year,col,row);
         }
         else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
         	references.myDate.setCellText(inputArray.day + delimiter + inputArray.month + delimiter + inputArray.year,col,row);
         }
         else {
         	references.myDate.setCellText(inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day,col,row);
         }
 	  
 	   calendarObjForGrid.hide();  
 	 
    }
    
    function pickDate(buttonObj,inputObject,callbackFunction,selectBeforeYN) {
    	if(selectBeforeYN == "Y") {
    		calendarObjForForm.setCallbackFunctionOnDayClick("dayClickCallback");
    	}
    	
        var format = "";
        if ("${params.dateFormatCD}" == "YMDD") {
        	format = "yyyy.mm.dd";
        }
        else if ("${params.dateFormatCD}" == "YMDS") {
        	format = "yyyy/mm/dd";
        }
        else if ("${params.dateFormatCD}" == "YMDB") {
        	format = "yyyy-mm-dd";
        }
        else if ("${params.dateFormatCD}" == "MDYD") {
        	format = "mm.dd.yyyy";
        }
        else if ("${params.dateFormatCD}" == "MDYS") {
        	format = "mm/dd/yyyy";
        }
        else if ("${params.dateFormatCD}" == "MDYB") {
        	format = "mm-dd-yyyy";
        }
        else if ("${params.dateFormatCD}" == "DMYD") {
        	format = "dd.mm.yyyy";
        }
        else if ("${params.dateFormatCD}" == "DMYS") {
        	format = "dd/mm/yyyy";
        }
        else if ("${params.dateFormatCD}" == "DMYB") {
        	format = "dd-mm-yyyy";
        }
        
        if (unformat(inputObject.value) == "00000000") {
            inputObject.value = "";
        }
        
        if (inputObject.value.length == 8) {
        	if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
            	format = "yyyymmdd";
            }
            else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
            	format = "mmddyyyy";
            }
            else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
            	format = "ddmmyyyy";
            }
        }
        
        calendarObjForForm.setCallbackFunctionOnClose(callbackFunction);
        calendarObjForForm.setCalendarPositionByHTMLElement(inputObject,0,inputObject.offsetHeight+2);  // Position the calendar right below the form input
        calendarObjForForm.setInitialDateFromInput(inputObject,format); // Specify that the calendar should set it's initial date from the value of the input field.
        calendarObjForForm.addHtmlElementReference('myDate',inputObject);   // Adding a reference to this element so that I can pick it up in the getDateFromCalendar below(myInput is a unique key)
        if(calendarObjForForm.isVisible()){
            calendarObjForForm.hide();
        }else{
            calendarObjForForm.resetViewDisplayedMonth();   // This line resets the view back to the inital display, i.e. it displays the inital month and not the month it displayed the last time it was open.
            calendarObjForForm.display();
        }       
    }
    
    function pickDateForGrid(gridObject, pcol, prow, callbackFunction) {
        col = pcol;
        row = prow;
        calendar_grid_temp = gridObject;
        var currentDate = gridObject.getCellText(col,row);
		
        var format = "";
        if ("${params.dateFormatCD}" == "YMDD") {
        	format = "yyyy.mm.dd";
        }
        else if ("${params.dateFormatCD}" == "YMDS") {
        	format = "yyyy/mm/dd";
        }
        else if ("${params.dateFormatCD}" == "YMDB") {
        	format = "yyyy-mm-dd";
        }
        else if ("${params.dateFormatCD}" == "MDYD") {
        	format = "mm.dd.yyyy";
        }
        else if ("${params.dateFormatCD}" == "MDYS") {
        	format = "mm/dd/yyyy";
        }
        else if ("${params.dateFormatCD}" == "MDYB") {
        	format = "mm-dd-yyyy";
        }
        else if ("${params.dateFormatCD}" == "DMYD") {
        	format = "dd.mm.yyyy";
        }
        else if ("${params.dateFormatCD}" == "DMYS") {
        	format = "dd/mm/yyyy";
        }
        else if ("${params.dateFormatCD}" == "DMYB") {
        	format = "dd-mm-yyyy";
        }
        
        if (unformat(currentDate) == "00000000") {
        	currentDate = "";
        }
        if (currentDate.length == 8){
        	if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
            	format = "yyyymmdd";
            }
            else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
            	format = "mmddyyyy";
            }
            else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
            	format = "ddmmyyyy";
            }
        }
        else if (currentDate.length < 8){
            currentDate = '';
        }

        calendarObjForGrid.setCallbackFunctionOnClose(callbackFunction);
        calendarObjForGrid.setCalendarPositionByMouseEvent(vMouseX,vMouseY);  // Position the calendar right below the form input
        calendarObjForGrid.setInitialDateFromData(currentDate,format); // Specify that the calendar should set it's initial date from the value of the input field.
        if(calendarObjForGrid.isVisible()){
            calendarObjForGrid.hide();
        }else{
            calendarObjForGrid.resetViewDisplayedMonth();   // This line resets the view back to the inital display, i.e. it displays the inital month and not the month it displayed the last time it was open.
            calendarObjForGrid.displayByMouseEvent();
        }       
    }
    
    
    /* selection until today */
    function pickDateForGrid2(gridObject, pcol, prow, callbackFunction) {
        col = pcol;
        row = prow;
        calendar_grid_temp = gridObject;
        var currentDate = gridObject.getCellText(col,row);
		
        calendarObjForGrid.setCallbackFunctionOnDayClick("dayClickCallbackForGrid");
        
        var format = "";
        if ("${params.dateFormatCD}" == "YMDD") {
        	format = "yyyy.mm.dd";
        }
        else if ("${params.dateFormatCD}" == "YMDS") {
        	format = "yyyy/mm/dd";
        }
        else if ("${params.dateFormatCD}" == "YMDB") {
        	format = "yyyy-mm-dd";
        }
        else if ("${params.dateFormatCD}" == "MDYD") {
        	format = "mm.dd.yyyy";
        }
        else if ("${params.dateFormatCD}" == "MDYS") {
        	format = "mm/dd/yyyy";
        }
        else if ("${params.dateFormatCD}" == "MDYB") {
        	format = "mm-dd-yyyy";
        }
        else if ("${params.dateFormatCD}" == "DMYD") {
        	format = "dd.mm.yyyy";
        }
        else if ("${params.dateFormatCD}" == "DMYS") {
        	format = "dd/mm/yyyy";
        }
        else if ("${params.dateFormatCD}" == "DMYB") {
        	format = "dd-mm-yyyy";
        }
        
        if (unformat(currentDate) == "00000000") {
        	currentDate = "";
        }
        if (currentDate.length == 8){
        	if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
            	format = "yyyymmdd";
            }
            else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
            	format = "mmddyyyy";
            }
            else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
            	format = "ddmmyyyy";
            }
        }
        else if (currentDate.length < 8){
            currentDate = '';
        }

        calendarObjForGrid.setCallbackFunctionOnClose(callbackFunction);
        calendarObjForGrid.setCalendarPositionByMouseEvent(vMouseX,vMouseY);  // Position the calendar right below the form input
        calendarObjForGrid.setInitialDateFromData(currentDate,format); // Specify that the calendar should set it's initial date from the value of the input field.
        calendarObjForGrid.addHtmlElementReference('myDate',gridObject);
        if(calendarObjForGrid.isVisible()){
            calendarObjForGrid.hide();
        }else{
            calendarObjForGrid.resetViewDisplayedMonth();   // This line resets the view back to the inital display, i.e. it displays the inital month and not the month it displayed the last time it was open.
            calendarObjForGrid.displayByMouseEvent();
        }       
    }
    
    function pickDateTime(buttonObj,inputObject,callbackFunction) {
        var format = "";
        if ("${params.dateFormatCD}" == "YMDD") {
        	format = "yyyy.mm.dd hh:ii";
        }
        else if ("${params.dateFormatCD}" == "YMDS") {
        	format = "yyyy/mm/dd hh:ii";
        }
        else if ("${params.dateFormatCD}" == "YMDB") {
        	format = "yyyy-mm-dd hh:ii";
        }
        else if ("${params.dateFormatCD}" == "MDYD") {
        	format = "mm.dd.yyyy hh:ii";
        }
        else if ("${params.dateFormatCD}" == "MDYS") {
        	format = "mm/dd/yyyy hh:ii";
        }
        else if ("${params.dateFormatCD}" == "MDYB") {
        	format = "mm-dd-yyyy hh:ii";
        }
        else if ("${params.dateFormatCD}" == "DMYD") {
        	format = "dd.mm.yyyy hh:ii";
        }
        else if ("${params.dateFormatCD}" == "DMYS") {
        	format = "dd/mm/yyyy hh:ii";
        }
        else if ("${params.dateFormatCD}" == "DMYB") {
        	format = "dd-mm-yyyy hh:ii";
        }
        
        if (inputObject.value.length == 12) {
            if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
            	format = "yyyymmddhhii";
            }
            else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
            	format = "mmddyyyyhhii";
            }
            else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
            	format = "ddmmyyyyhhii";
            }
        }
        calendarTimeObjForForm.setCallbackFunctionOnClose(callbackFunction);
        calendarTimeObjForForm.setCalendarPositionByHTMLElement(inputObject,0,inputObject.offsetHeight+2);  // Position the calendar right below the form input
        calendarTimeObjForForm.setInitialDateFromInput(inputObject,format); // Specify that the calendar should set it's initial date from the value of the input field.
        calendarTimeObjForForm.addHtmlElementReference('myDateTime',inputObject);   // Adding a reference to this element so that I can pick it up in the getDateFromCalendar below(myInput is a unique key)
        if(calendarTimeObjForForm.isVisible()){
            calendarTimeObjForForm.hide();
        }else{
            calendarTimeObjForForm.resetViewDisplayedMonth();   // This line resets the view back to the inital display, i.e. it displays the inital month and not the month it displayed the last time it was open.
            calendarTimeObjForForm.display();
        }       
    } 

    /* inputArray is an associative array with the properties
    year
    month
    day
    hour
    minute
    calendarRef - Reference to the DHTMLSuite.calendar object.
    */
    function getDateFromCalendar(inputArray) {
        var references = calendarObjForForm.getHtmlElementReferences(); // Get back reference to form field.
        
        var delimiter = "";
		if ("${params.dateFormatCD}".substring(3,4) == "D") {
        	delimiter = ".";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "S") {
        	delimiter = "/";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "B") {
        	delimiter = "-";
        }
        else {
        	delimiter = ".";
        }
		
	    if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
	    	references.myDate.value = inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day;
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
        	references.myDate.value = inputArray.month + delimiter + inputArray.day + delimiter + inputArray.year;
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
        	references.myDate.value = inputArray.day + delimiter + inputArray.month + delimiter + inputArray.year;
        }
        else {
        	references.myDate.value = inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day;
        }
	    
        calendarObjForForm.hide();  
        
    }
    
    function getDateFromCalendarForGrid(inputArray)
    {
        var references = calendarObjForGrid.getHtmlElementReferences(); // Get back reference to form field.
        
        var delimiter = "";
		if ("${params.dateFormatCD}".substring(3,4) == "D") {
        	delimiter = ".";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "S") {
        	delimiter = "/";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "B") {
        	delimiter = "-";
        }
        else {
        	delimiter = ".";
        }
		
	    if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
	    	calendar_grid_temp.setCellText(inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day, col, row);
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
        	calendar_grid_temp.setCellText(inputArray.month + delimiter + inputArray.day + delimiter + inputArray.year, col, row);
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
        	calendar_grid_temp.setCellText(inputArray.day + delimiter + inputArray.month + delimiter + inputArray.year, col, row);
        }
        else {
        	calendar_grid_temp.setCellText(inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day, col, row);
        }
	    
        
        try {
        	//calendar_grid_temp.setCellText('U', _col.activeFlg, row);
        }catch(e){}
        calendarObjForGrid.hide();  
        
    }
    
    function getDateFromCalendarTime(inputArray)
    {
        var references = calendarTimeObjForForm.getHtmlElementReferences(); // Get back reference to form field.
        
        var delimiter = "";
		if ("${params.dateFormatCD}".substring(3,4) == "D") {
        	delimiter = ".";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "S") {
        	delimiter = "/";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "B") {
        	delimiter = "-";
        }
        else {
        	delimiter = ".";
        }
		
	    if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
	    	references.myDateTime.value = inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day + ' ' + inputArray.hour + ':' + inputArray.minute;;
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
        	references.myDateTime.value = inputArray.month + delimiter + inputArray.day + delimiter + inputArray.year + ' ' + inputArray.hour + ':' + inputArray.minute;;
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
        	references.myDateTime.value = inputArray.day + delimiter + inputArray.month + delimiter + inputArray.year + ' ' + inputArray.hour + ':' + inputArray.minute;;
        }
        else {
        	references.myDateTime.value = inputArray.year + delimiter + inputArray.month + delimiter + inputArray.day + ' ' + inputArray.hour + ':' + inputArray.minute;;
        }
	    
        calendarObjForForm.hide();  
        
        calendarTimeObjForForm.hide();  
        
    }

    function checkValidDate(calObj) {
        if (calObj.value != "") {
			if (!isDate(calObj.value)) {
				alert("<fmt:message key="error.dateFormat" />");
				calObj.value = unformat("${params.currentDate}");
				calObj.focus();
				return false;
			}
			else {
				return true;
			}
        }
        else {
            return true;
        }
    }
    
</script>

<script type="text/javascript">
	
	function convertDate(s) {
		
		if (s == null || s == '') return '';
		
		var date = unformat(s);
		var yyyy = "";
		var mm = "";
		var dd = "";
		
		if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
        	yyyy = date.substring(0,4);
        	mm = date.substring(4,6);
        	dd = date.substring(6,8);
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
        	yyyy = date.substring(4,8);
        	mm = date.substring(0,2);
        	dd = date.substring(2,4);
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
        	yyyy = date.substring(4,8);
        	mm = date.substring(2,4);
        	dd = date.substring(0,2);
        }
        else {
        	yyyy = date.substring(0,4);
        	mm = date.substring(4,6);
        	dd = date.substring(6,8);
        }
		
		return yyyy+mm+dd;
	}
	
	function isDate(objName) {
		
		var objDate;
	  	var nOldYear;
	  	var nOldMonth;
	  	var nOldDay;
	  	var nNewYear;
	  	var nNewMonth;
	  	var nNewDay;

	  	if(objName.length < 8) {
	    	return false;
	 	}

	  	if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
	  		nOldYear = parseInt(objName.substring(0, 4), 10);
		  	nOldMonth = parseInt(objName.substring(4, 6), 10) - 1;
		  	nOldDay = parseInt(objName.substring(6, 8), 10);
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
        	nOldYear = parseInt(objName.substring(4, 8), 10);
    	  	nOldMonth = parseInt(objName.substring(0, 2), 10) - 1;
    	  	nOldDay = parseInt(objName.substring(2, 4), 10);
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
        	nOldYear = parseInt(objName.substring(4, 8), 10);
    	  	nOldMonth = parseInt(objName.substring(2, 4), 10) - 1;
    	  	nOldDay = parseInt(objName.substring(0, 2), 10);
        }
        else {
        	nOldYear = parseInt(objName.substring(0, 4), 10);
    	  	nOldMonth = parseInt(objName.substring(4, 6), 10) - 1;
    	  	nOldDay = parseInt(objName.substring(6, 8), 10);
        }
	  				
	  	objDate = new Date(nOldYear, nOldMonth, nOldDay);
					
	  	nNewYear = objDate.getFullYear();
	  	nNewMonth = objDate.getMonth();
	  	nNewDay = objDate.getDate();
					
	  	if(nOldYear == nNewYear && nOldMonth == nNewMonth && nOldDay == nNewDay) {
	    	return true;
	  	}
	  	else {
	    	return false;
	  	}
	}
	
	// Date - YYYY.MM.DD
	function formatDate(val) {
		
		if (val == null) return null;

		if (val == '' || trim(removeChar(val, '.')).length != 8){
			return trim(val);
		}
		
		val = trim(removeChar(val, '.'));
		val = trim(removeChar(val, '-'));
	    val = trim(removeChar(val, '/'));
		
	    var yyyy = "";
	    var mm = "";
	    var dd = "";
	    var date = "";
		var delimiter = "";
		
		if ("${params.dateFormatCD}".substring(3,4) == "D") {
        	delimiter = ".";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "S") {
        	delimiter = "/";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "B") {
        	delimiter = "-";
        }
        else {
        	delimiter = ".";
        }
		
	    if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
        	yyyy = val.substring(0,4);
        	mm = val.substring(4,6);
        	dd = val.substring(6,8);
        	date = yyyy+delimiter+mm+delimiter+dd;
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
        	yyyy = val.substring(4,8);
        	mm = val.substring(0,2);
        	dd = val.substring(2,4);
        	date = mm+delimiter+dd+delimiter+yyyy;
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
        	yyyy = val.substring(4,8);
        	mm = val.substring(2,4);
        	dd = val.substring(0,2);
        	date = dd+delimiter+mm+delimiter+yyyy;
        }
        else {
        	yyyy = val.substring(0,4);
        	mm = val.substring(4,6);
        	dd = val.substring(6,8);
        	date = yyyy+delimiter+mm+delimiter+dd;
        }
	    
	    return date;
	}
	
	// Date - YYYY.MM.DD hh:ii
	function formatDateTime(val) {
	    
	    if (val == null) return null;

	    val = trim(removeChar(val, '.'));
	    val = trim(removeChar(val, '-'));
	    val = trim(removeChar(val, '/'));
	    
	    if (val == '' || val.length < 12){
	        return val;
	    }
	    
	    var yyyy = "";
	    var mm = "";
	    var dd = "";
	    var hh = val.substring(8, 10);
	    var ii = val.substring(10, 12);
	    var date = "";
		var delimiter = "";
		
		if ("${params.dateFormatCD}".substring(3,4) == "D") {
        	delimiter = ".";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "S") {
        	delimiter = "/";
        }
        else if ("${params.dateFormatCD}".substring(3,4) == "B") {
        	delimiter = "-";
        }
        else {
        	delimiter = ".";
        }
		
	    if ("${params.dateFormatCD}".substring(0,3) == "YMD") {
        	yyyy = val.substring(0,4);
        	mm = val.substring(4,6);
        	dd = val.substring(6,8);
        	date = yyyy+delimiter+mm+delimiter+dd+' '+hh+':'+ii;
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "MDY") {
        	yyyy = val.substring(4,8);
        	mm = val.substring(0,2);
        	dd = val.substring(2,4);
        	date = mm+delimiter+dd+delimiter+yyyy+' '+hh+':'+ii;
        }
        else if ("${params.dateFormatCD}".substring(0,3) == "DMY") {
        	yyyy = val.substring(4,8);
        	mm = val.substring(2,4);
        	dd = val.substring(0,2);
        	date = dd+delimiter+mm+delimiter+yyyy+' '+hh+':'+ii;
        }
        else {
        	yyyy = val.substring(0,4);
        	mm = val.substring(4,6);
        	dd = val.substring(6,8);
        	date = yyyy+delimiter+mm+delimiter+dd+' '+hh+':'+ii;
        }
	    
	    return date;
	}
	
</script>
