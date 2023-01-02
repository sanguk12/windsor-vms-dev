// Screen Size Value
var screenWidth = screen.availWidth;
var screenHeight = screen.availHeight;


document.onactivate=function() {

    // Multi Form
    try {
        for(var j=0;j<document.forms.length;j++) {
            var obj = document.forms[j];
            for(var i=1; i<obj.elements.length; i++) {
                try {
                    initTextBox(obj.elements[i]);
                } catch(e) {
                }
            }
        }
    } catch(e) {
    }
};

document.onmouseover=function(e) {
    if(!e) e=window.event;
    var el=e.target?e.target:e.srcElement;
    while(el!=null && el.tagName!="A") el=el.parentNode;
    if(el==null) return;
    if(e.preventDefault) {
        e.preventDefault();
    } else {
        e.returnValue=true;
    }
};

function fnMessage(msg, actionType) {
    try {
        if(msg.length>0) {
            alert(msg);
            
            switch(actionType) {
                case "Close" :
                    fnClose();
                case "CloseReload" :
                    opener.Search();
                    fnClose();
                case "ParentClose" :
                    fnParentClose();
                case "ParentCloseReload" :
                    fnParentClose();
                default :
            }
        }
        
    } catch(e) {
        alert(e);
    }
}

/*
 * GridList Checkbox Check(Name)
 * */
function fnGridCheckName(objName) {
    var obj = document.getElementsByName(objName);
    var checkCount = 0;
    try {
        if(obj.length!=undefined) {
            if(obj.length>0) {
                for(i=0;i<obj.length;i++) {
                    if(obj[i].checked) {
                        checkCount++;
                    }
                }   
            }
            if(checkCount>0) {
                return true;
            } else {
                return false;
            }
            
        } else {
            if(obj.checked!=true) {
                return false;
            }
        }
    } catch(e) {
        return false;
    }
}

/*
 * GridList Checkbox Check(ID)
 * */
function fnGridCheckID(objID) {
    var obj = document.getElementById(objID);
    var checkCount = 0;
    try {
        if(obj.length!=undefined) {
            if(obj.length>0) {
                for(i=0;i<obj.length;i++) {
                    if(obj[i].checked) {
                        checkCount++;
                    }
                }   
            }
            if(checkCount>0) {
                return true;
            } else {
                return false;
            }
            
        } else {
            if(obj.checked!=true) {
                return false;
            }
        }
    } catch(e) {
        return false;
    }
}

function fnShiftClick() {
    if(event.keyCode=="17") { 
        shiftClick = true;
    }
}

function fnSubmit(form, ctrl, act) {
    form.action = ctrl + "/" + act; // + "/?";
    //form.method = "post";
    form.target = "_self";
    form.submit();
}

function fnSubmitConfirm(form, ctrl, act, msg) {
    if(msg!="") {
        if(confirm(msg)) {
            fnSubmit(form, ctrl, act)           
            return true;
        } else {
            return false;
        }
    } else {
        fnSubmit(form, ctrl, act)
    }
}


function fnParentClose() {
    parent.top.close();
}

function fnClose() {
    window.close();
}


function trimHTMLtag(string) {
    var objStrip = new RegExp();
    objStrip = /[<][^>]*[>]/gi;
    return string.replace(objStrip, "");
}


/*
 * New Window Open
 * @param sURL - New Window URL
 * @param winName - New Window Name
 * @param wid - New Window Width Size
 * @param hei - New Window Height Size
 * @param scroll - Window Scroll(yes/no)
 */
function newWindow(sURL, winName, wid, hei, scroll) {
    var iWidth = (screen.width - wid) / 2;
    var iHeight = (screen.height - hei) / 2;
    winprops = "height="+hei+",width="+wid+",top="+iHeight+",left="+iWidth+",scrollbars="+scroll+",dependent=yes ,resizable=yes"
    win = window.open(sURL, winName.replace(/./gi,""), winprops);
    if (parseInt(navigator.appVersion)>=4) { win.window.focus(); }
}

function popupWindow(sURL, winName, wid, hei, scroll, winTitle) {
    var iWidth = (screen.width - wid) / 2;
    var iHeight = (screen.height - hei) / 2;
    winprops = "height="+hei+",width="+wid+",top="+iHeight+",left="+iWidth+",scrollbars="+scroll+",resizable=yes"
    win = window.open(sURL, winName.replace(/./gi,""), winprops);
    if (parseInt(navigator.appVersion)>=4) { win.window.focus(); }
    top.addWindow(win, winTitle);
}

/*
 * New Windows Open Parameter Create
 * @param wid - New Window Width Size
 * @param hei - New Window Height Size
 * @param scroll - Window Scroll(yes/no)
 */
function getWindowOpenParam(wid, hei, scroll) {

    var iWidth = (screen.width - wid) / 2;
    var iHeight = (screen.height - hei) / 2;
    var winprops = "height=700,width=1000,top="+iHeight+",left="+iWidth+",scrollbars="+scroll+",resizable=yes";
    
    return winprops;
}

/*
 * New ModalDialog Open
 * @param sURL - New Window URL
 * @param winName - New Window Name
 * @param wid - New Window Width Size
 * @param hei - New Window Height Size
 * @param scroll - Window Scroll(yes/no)
 */
function newModalDialog(sURL, winName, wid, hei, scroll) {
    var iWidth = (screen.width - wid) / 2;
    var iHeight = (screen.height - hei) / 2;
    winprops = "dialogHeight:"+hei+"px; dialogWidth:"+wid+"px; dialogTop:"+iHeight+"px; dialogLeft="+iWidth+"px;"
    modal = window.showModalDialog(sURL+"&modalDialog=Y", self, winprops);
    //if (parseInt(navigator.appVersion)>=4) { win.window.focus(); }
}

/*
 * New Window Open Always Full Screen
 * @param sURL - New Window URL
 * @param winName - New Window Name
 * @param wid - New Window Width Size
 * @param hei - New Window Height Size
 * @param scroll - Window Scroll(yes/no)
 */
function newWindowFull(sURL, winName, wid, hei, scroll) {
    var iWidth = 0;
    var iHeight = 0;
    winprops = "height="+screen.availHeight+",width="+screen.availWidth+",top="+iHeight+",left="+iWidth+",scrollbars="+scroll+",resizable=yes"
    win = window.open(sURL, winName, winprops)
    if (parseInt(navigator.appVersion) >= 4) { win.window.focus() }
}

/*
 * Input Text Size Byte Check
 * @param ctrlID - Input Control ID
 * @param ibyte - Input Text Byte Size
 */
function getByte(ctrlID, ibyte) {
    var sum = 0;
    var len = ctrlID.value.length;
    for (var i=0; i<len; i++) {
        var ch = ctrlID.value.substring(i, i + 1);
        var en = escape(ch);
        if (en.length <= 4) {
            sum++;
        } else {
            sum += 2;
        }
    }
    
    if(sum>ibyte) {
        alert("AoA¤CN ¹®AU¿­ ≫cAIAi¸| AE°uCI¿´½A´I´U.");        
        //return true;
        ctrlID.value = cutString(ibyte, ctrlID.value);
    } else {
        return false;
    }
}

/*
 * Input Text Size Byte Check with Label Control Message Print
 * @param ctrlID - Input Control ID
 * @param ibyte - Input Text Byte Size
 * @param lblID - Label Control ID
 */
function getByte2(ctrlID, ibyte, lblID) {
    var sum = 0;
    var len = ctrlID.value.length;
    for (var i=0; i<len; i++) {
        var ch = ctrlID.value.substring(i, i + 1);
        var en = escape(ch);
        if (en.length <= 4) {
            sum++;
        } else {
            sum += 2;
        }
    }
    
    if(sum>ibyte) {
        lblID.innerHTML="CoAc <B>"+sum+"</B> Byte["+ibyte+" Byte]";
        ctrlID.value = cutString(ibyte, ctrlID.value);
    } else {
        return false;
    }
}

/*
 * Cutting String
 * @param str - Input String
 * @param len - Cutting Length
 */
function cutString(str, len) {
    var l = 0;
    for (var i=0; i<str.length; i++) {
        l += (str.charCodeAt(i) > 128) ? 2 : 1;
        if (l > len) return str.substring(0,i);
    }
    return str;
}

function cutStr(str,limit){
	var tmpStr = str;
	var byte_count = 0;
	var len = str.length;
	var dot = "";

	for(i=0; i<len; i++){
	byte_count += chr_byte(str.charAt(i)); 
	if(byte_count == limit-1){
	if(chr_byte(str.charAt(i+1)) == 2){
	tmpStr = str.substring(0,i+1);
	dot = "...";
	}else {
	if(i+2 != len) dot = "...";
	tmpStr = str.substring(0,i+2);
	}
	break;
	}else if(byte_count == limit){
	if(i+1 != len) dot = "...";
	tmpStr = str.substring(0,i+1);
	break;
	}
	}
	
	return tmpStr+dot;
}

function chr_byte(chr){
	if(escape(chr).length > 4)
	return 2;
	else
	return 1;
}

function regExpCheck(str, pattern) {

    var pattern0 = "[^가-힣]";  //'한글만
    var pattern1 = "[^-0-9 ]";  //'숫자만
    var pattern2 = "[^-a-zA-Z]";  //'영어만
    var pattern3 = "[^-가-힣a-zA-Z0-9/ ]"; //'숫자와 영어 한글만 
    var pattern4 = "<[^>]*>";   //'태그만
    var pattern5 = "[^-a-zA-Z0-9/ ]";    //'영어 숫자만
    // 6 = '날짜만'
    var pattern7 = "[^-0-9-*]";  //'숫자와 '-'만
    var pattern8 = "[^-0-9]+(.[0-9]+)?";  //'소수만
    
    var rxSplit;

    switch (pattern) {
    case 0:
        rxSplit = new RegExp(pattern0);
        break;
    case 1:
        rxSplit = new RegExp(pattern1);
        break;
    case 2:
        rxSplit = new RegExp(pattern2);
        break;        
    case 3:
        rxSplit = new RegExp(pattern3);
        break;        
    case 4:
        rxSplit = new RegExp(pattern4);
        break;        
    case 5:
        rxSplit = new RegExp(pattern5);
        break;
    case 7:
        rxSplit = new RegExp(pattern7);
        break;
    case 8:
        rxSplit = new RegExp(pattern8);
        break;
    default:
        rxSplit = new RegExp(pattern5);
        break;
    }

    if (pattern == 6)
    {
        if (isDate(unformat(str))) {return true;} else {return false;}
    }
    else
    {    
        if (rxSplit.test(str)) {return false;} else {return true;}
    }
}


var btnCheck = true;
/*
 * List Header CheckBox
 * @param obj - CheckBox Control ID
 */
function checkControl(obj) {
    if(obj != null) {
        if(btnCheck == true) {
            checkAll(obj);  
            btnCheck = false;
        } else {
            unCheckAll(obj);
            btnCheck = true;
        }
    } else {
        alert("None CheckBox.");
    }
}

function checkAll(obj) {
    if(obj.length == null) {
        obj.checked = true;
    } else {
        for(i=0; i<obj.length; i++) {
            if(obj[i].disabled==false) {
                obj[i].checked = true;
            }
        }
    }
}

function unCheckAll(obj) {
    if(obj.length == null) {
        obj.checked = false;
    } else {
        for(i=0; i<obj.length; i++) {
            obj[i].checked = false;
        }
    }   
}

function getChecked(obj){
    var check_cnt= 0;

    if(obj!=null) {
        if (obj.length ==null) {
            if (obj.checked)   check_cnt++;
        } else {
            for (var j = 0; j < obj.length; j++) {
                if (obj[j].checked)  check_cnt++;
            }
        }
    }
    return  check_cnt;
}

/*
 * Month Is LastDay
 * @param calyear - Year
 * @param calmonth - Month
 */
function lastday(calyear, calmonth) {
     var monthDays = new Array(31, 28, 31, 30, 31, 30, 31, 31,30, 31, 30, 31);
     if (((calyear % 4 == 0) && (calyear % 100 != 0)) || (calyear % 400 == 0))
          monthDays[1] = 29;
     var nDays = monthDays[calmonth - 1];
     return nDays;
}

/*
 * Now Date Add Days
 * @param val - Add Day numbers
 */
function AddDays(val) {
    var now=new Date();
    var newdate=new Date();
    var newtimems=newdate.getTime()+(val*24*60*60*1000);
    newdate.setTime(newtimems);
    
    var year = newdate.getYear();
    var month = (parseInt(newdate.getMonth()+1)<=9)?"0"+(newdate.getMonth()+1):newdate.getMonth()+1;
    var day = (parseInt(newdate.getDate())<=9)?"0"+newdate.getDate():newdate.getDate();
    return year + "-" + month + "-" + day;
}

function roundXL(n, digits) {
  if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림

  digits = Math.pow(10, digits); // 정수부 반올림
  var t = Math.round(n * digits) / digits;

  return parseFloat(t.toFixed(0));
}


/*
 * Number To Comma
 * @param str - Number String
 */
function toComma(str) {
    var pointValue = "";
    var rmPoint=str.indexOf(".");
    str = str + "";
    str = str.replace(/(\,)/g,"");
    if(rmPoint>=0) {
        pointValue = str.substring(rmPoint, str.length);
        str = str.substring(0, rmPoint);
    }
    
    var tmp1, tmp2, tmp3;
    var statValue="", strValue="", modValue="";
    if(str.substring(0,1) == "-"){
        statValue = str.substring(1,str.length);
    } else {
        statValue = str;
    }
    tmp1 = statValue.length;

    if(tmp1 > 3){
        tmp2 = Math.floor(tmp1/3);
        tmp3 = tmp1 % 3;

        if(tmp3>0){
            strValue += statValue.substring(0,tmp3) + ",";
            modValue = statValue.substring(tmp3);
        } else {
            modValue = statValue;
        }

        for ( var i=0; i < tmp2 ; i++ ){
            if(i==(tmp2-1)){
                strValue += modValue.substring(i*3,i*3+3);
            } else {
                strValue += modValue.substring(i*3,i*3+3) + ",";
            }
        }
    } else {
        strValue = statValue;
    }
    
    if(str.substring(0,1) == "-"){ srtValue = "-"+strValue; }
    else{srtValue = strValue;}
    
    element.value=srtValue+pointValue;
}

// Getter Radio Input
function getRadioValue(x) {
  /*
  for(var i=0; i<x.length; i++)
    if (x[i].checked==true) return x[i].value;
  return "";
  */
	if($("input:radio[name='"+x+"']:checked").val() != undefined){
		return $("input:radio[name='"+x+"']:checked").val();
	}
	 return "";
}
// Setter Radio Input
function setRadioValue(x, set_value) {
  /*
  for(var i=0; i<x.length; i++)
    if (x[i].value==set_value) x[i].checked=true;
  */
  
  $("input:radio[name='"+x+"'][value='"+set_value+"']").attr("checked",true);
}

//add Option in Select
function addOption(selId, txt, val) {
	var x = $("#"+selId).get(0);
	var length = x.length;
	
	for (var i=0; i<length; i++) {
		if (x.options[i].value == val) return;
	}
	
	for (var i=0; i<length; i++) {
		if (x.options[i].value > val) {
			for (var j=length; j>i; j--) {
				x.options[j] = new Option(x.options[j-1].text,x.options[j-1].value);
			}
			x.options[i] = new Option(txt,val);
			return;
		}
	}
	x.options[length] = new Option(txt,val);
}

//remove Option in Select
function removeOption(selId, val) {
	var x = $("#"+selId).get(0);
	
	for (var i=0; i<x.length; i++) {
		if (x.options[i].value == val) {
			for (var j=i; j<x.length-1; j++) {
				x.options[j] = new Option(x.options[j+1].text,x.options[j+1].value);
			}
			x.options[x.length-1] = null;
			return;
		}
	}
}
function removeOptionAll(selId) {
	$("#"+selId).get(0).options.length = 0;
}

//-->


/*
TODO:
Date: 2008.10.21
Description: Timre Action
*/
/* START ********************************************/
var secs;
var timerID = null;
var timerRunning = false;
var delay = 1000;

function InitializeTimer()
{
    // Set the length of the timer, in seconds
    secs = 7;
    StopTheClock();
    StartTheTimer();
}

function StopTheClock()
{
    if(timerRunning)
        clearTimeout(timerID);
    timerRunning = false;
}

function StartTheTimer()
{
    if (secs==0)
    {
        StopTheClock();
        // Here's where you put something useful that's
        // supposed to happen after the allotted time.
        // For example, you could display a message:
        //alert("You have just wasted 10 seconds of your life.")
        //refreshChart();
        document.getElementById("messagebar").style.visibility = "hidden";
        //InitializeTimer();
        StopTheClock();
    }
    else
    {
        //self.status = secs;
        secs = secs - 1;
        timerRunning = true;
        timerID = self.setTimeout("StartTheTimer()", delay);
    }
}

/*
TODO:
Date: 2008.10.07
Description: MessageBox Action
*/
/* START ********************************************/
function message(message, timeoff) {
    document.getElementById("messagebar").innerHTML = message;
    document.getElementById("messagebar").style.visibility = "visible";
    
    if (timeoff != "Y") {
    	InitializeTimer();
    }
    //alert(message);
}
/* END **********************************************/


/*
 * 경고 메세지 창
 */
function alertMessage(message) {
	var url = "/cms/messagebox.page?alertMessage="+encodeURIComponent(message);

    newModalDialog(url, "alertmessagebox",622,200,"no");
}

/*
* Grid Cell Focus 이동
*/
function setCellFocus(grid, col, row) {
	
	grid.setTimeout(function(){
		this.setSelectedColumns([col]);
		this.setSelectedRows([row]);
		this.setCurrentColumn(col);
		this.setCurrentRow(row);
		this.focus();
		this.raiseEvent("editCurrentCell", {}, col, row);
	});
}

//FM common siteID getter
function getSearchSiteIDs(){
	var siteIDs = new Array();
	if($("#searchSiteID").val() == ""){
		for (i = 0; i < $("select[name='searchSiteID']")[0].length; i++) {
			siteIDs[i] = $("#searchSiteID option:eq("+i+")").val();
		}
		
	} else {
		siteIDs[0] = "";
		siteIDs[1] = $("#searchSiteID").val();
	}
	
	return siteIDs;
}

//Left 빈자리 만큼 padStr 을 붙인다.
function lpad(src, len, padStr){
	var retStr = "";
	var padCnt = Number(len) - String(src).length;
	for(var i=0;i<padCnt;i++) retStr += String(padStr);
	return retStr+src;
}

// Right 빈자리 만큼 padStr 을 붙인다.
function rpad(src, len, padStr){
	var retStr = "";
	var padCnt = Number(len) - String(src).length;
	for(var i=0;i<padCnt;i++) retStr += String(padStr);
	return src+retStr;
}

//서버시간 가져오기(yyyyMMddhhmmss)
function getSysdate(fmt) {
	if (fmt == null || fmt == "") {
		fmt = "yyyyMMddhhmmss";
	}
	
	var table = new AW.XML.Table;	  
	table.setURL("simpleAction.do");
	table.setAsync(false);
	table.setRequestMethod("POST");
	table.setParameter("queryKey","common.sysdate.select");
	table.setParameter("format",fmt)
	table.request();
	
	var rowCount = table.getCount();
	if (rowCount > 0) {
		return table.getData(0,0);
	}
	return "";
}

/**
 * since 2007-08-22
 * author MyungKeun.Lee(keiangel78@gmail.com)
 * use : <input type="text" name="controlName" value="" ondocumentready="init(this);" onfocus="valueReplace(this);" onfocusout="valueCheck(this);" />
 */
var obj = null;
var Preset = "none";
var ImeMode = "active";
var LowerLimit = 0;
var UpperLimit = 0;
var LimitOverColor = "red";
var ByteSize = 0;
var TextAlign = "left";
var Read = "false";
var PreInit = "false";

/**
 * OnDocumentReady Event Method
 */
function initTextBox(ctrl) {
	try {
		Preset = ctrl.Preset.toLowerCase();
		switch(ctrl.Preset.toLowerCase()){
			case "none" :
				if(ctrl.TextAlign==null) {
					ctrl.style.textAlign="left";
				}
				if(ctrl.value=="null" || ctrl.value.length==0) {
					ctrl.value = "";
				}
				//ctrl.style.imeMode="active";
				break;
			case "money" :
				if(ctrl.TextAlign==null) {
					ctrl.style.textAlign="right";
				}
				
				if(ctrl.value=="null" || ctrl.value.length==0) {
					ctrl.value = "0";
				}
				break;
			case "number" :
				if(ctrl.TextAlign==null) {
					ctrl.style.textAlign="right";
				}
				
				if(ctrl.value=="null" || ctrl.value.length==0) {
					ctrl.value = "0";
				}
				break;
			case "telno" :
				if(ctrl.TextAlign==null) {
					ctrl.style.textAlign="center";
				}
				
				if(ctrl.value=="null" || ctrl.value.length==0) {
					ctrl.value = "";
				} else {
					var telNum = ctrl.value;
					var tmpTelNum = "";
					if(telNum.length()>=9) {
						if (telNum.substring(0, 2) == "02") {
							if (telNum.length == 9) {
								tmpTelNum = telNum.substring(0, 2) + "-" + telNum.substring(2, 5) + "-" + telNum.substring(5, 9);
							} else  {
								tmpTelNum =  telNum.substring(0, 2) + "-" + telNum.substring(2, 6) + "-" + telNum.substring(6, 10);
							}
						} else {
							if (telNum.length == 10) {
								tmpTelNum =  telNum.substring(0, 3) + "-" + telNum.substring(3, 6) + "-" + telNum.substring(6, 10);
							} else {
								tmpTelNum =  telNum.substring(0, 3) + "-" + telNum.substring(3, 7) + "-" + telNum.substring(7, 11);
							}
						}
					}
					ctrl.value = tmpTelNum;
				}
				ctrl.maxLength=13;
				break;
			case "dateymd" :
				if(ctrl.TextAlign==null) {
					ctrl.style.textAlign="center";
				}
				if(ctrl.PreInit==null || ctrl.PreInit=="true") {
					if(ctrl.value==null || ctrl.value.length==0) {
						var toDate = new Date();
						var year = toDate.getYear();
						var month = (parseInt(toDate.getMonth())+1<=9)?"0"+(parseInt(toDate.getMonth())+1):parseInt(toDate.getMonth())+1;
						var day = (parseInt(toDate.getDate())<=9)?"0"+(toDate.getDate()):toDate.getDate();
						ctrl.value = year + "-" + month + "-" + day;
					}
				}
				ctrl.maxLength=8;
				break;
			case "dateym" :
				if(ctrl.TextAlign==null) {
					ctrl.style.textAlign="center";
				}
				if(ctrl.PreInit==null || ctrl.PreInit=="true") {
					if(ctrl.value==null || ctrl.value.length==0) {
						var toDate = new Date();
						var year = toDate.getYear();
						var month = (parseInt(toDate.getMonth())+1<=9)?"0"+(parseInt(toDate.getMonth())+1):parseInt(toDate.getMonth())+1;
						ctrl.value = year + "-" + month;
					}
				}
				ctrl.maxLength=6;
				break;
			case "hhmm" :
				if(ctrl.TextAlign==null) {
					ctrl.style.textAlign="center";
				}
				if(ctrl.PreInit==null || ctrl.PreInit=="true") {
					if(ctrl.value==null || ctrl.value.length==0) {
		  				var toDate = new Date();
		  				var hour = toDate.getHours();
		  				var minutes = toDate.getMinutes();
		  				if(TimeTerm!=null) {
		  					hour = hour+(parseInt(TimeTerm)/60);
		  					minutes = minutes + (parseInt(TimeTerm)%60);
		  				}
		  				if(parseInt(minutes)<10) {
		  				  minutes = "0" + minutes;
		  				}
		  				ctrl.value = hour + ":" + minutes;
		  			}
		  		}
				ctrl.maxLength=4;
				break;
		}
		if(ctrl.ImeMode!=null) ctrl.style.imeMode = ctrl.ImeMode;
		if(ctrl.TextAlign!=null) ctrl.style.textAlign=ctrl.TextAlign;
		
		if(ctrl.Read=="true") {
			ctrl.style.backgroundColor="#EEEEEE";
			ctrl.readOnly = true;
		}
		valueCheck(ctrl);
	} catch(e) {
	}
}

/**
 * OnFocusOut Event Method
 */
function valueCheck(ctrl) {
	switch(ctrl.Preset.toLowerCase()) {
		case "none" :
			getByteSize(ctrl, ByteSize);
			break;
		case "money" :
			isNumber(ctrl);
			toComma(ctrl);
			getByteSize(ctrl, ByteSize);
			break;
		case "number" :
			isNumber(ctrl);
			toComma(ctrl);
			getByteSize(ctrl, ByteSize);
			break;
		case "telno" :
			isNumber(ctrl);
			ctrl.value = ctrl.value.replace(/(\-)/g,"");
			getByteSize(ctrl, 11);
			toDash(ctrl);
			break;
		case "dateymd" :
			toDate(ctrl);
			break;
		case "dateym" :
			toDate(ctrl);
			break;
		case "hhmm" :
			toTime(ctrl);
			break;
	}
}

/**
 * OnFocus Event Method
 */
function valueReplace(ctrl) {
	var oldValue = ctrl.value;
	var newValue = "";
	switch(ctrl.Preset.toLowerCase()) {
		case "none" :
			newValue = oldValue;
			break;
		case "money" :
			newValue = oldValue.replace(/(\,)/g,"");
			break;
		case "number" :
			newValue = oldValue.replace(/(\,)/g,"");
			break;
		case "telno" :
			newValue = oldValue.replace(/(\-)/g,"");
			break;
		case "dateymd" :
			newValue = oldValue.replace(/(\-)/g,"");;
			break;
		case "dateym" :
			newValue = oldValue.replace(/(\-)/g,"");;
			break;
		case "hhmm" :
			newValue = oldValue.replace(/(\:)/g,"");;
			break;
	}
	ctrl.value = newValue;
	ctrl.select();
}

function toDate(ctrl) {
	var oldValue = ctrl.value.replace(/-/gi,"");
	if(oldValue.length>=6) {
		if(parseInt(oldValue.substring(4,6))<=12 && (parseInt(oldValue.substring(6,8))<=31 || isNaN(parseInt(oldValue.substring(6,8))))) {
			switch(ctrl.Preset.toLowerCase()) {
				case "dateymd" :
					if(oldValue.length==8) {
						ctrl.value = oldValue.substring(0,4) + "-" + oldValue.substring(4,6) + "-" + oldValue.substring(6,8);
					}
					break;
				case "dateym" :
					if(oldValue.length==6) {
						ctrl.value = oldValue.substring(0,4) + "-" + oldValue.substring(4,6);
					}
					break;
			}
		} else {
			ctrl.value="";
		}
	}
}

function toTime(ctrl) {
	var oldValue = ctrl.value.replace(/:/gi,"");
	if(oldValue.length>=4) {
		if(parseInt(oldValue.substring(0,2))<=24 && parseInt(oldValue.substring(2,4))<=59) {
			switch(ctrl.Preset) {
				case "hhmmss" :
					if(oldValue.length==6) {
						ctrl.value = oldValue.substring(0,2) + ":" + oldValue.substring(2,4) + ":" + oldValue.substring(4,6);
					}
					break;
				case "hhmm" :
					if(oldValue.length==4) {
						ctrl.value = oldValue.substring(0,2) + ":" + oldValue.substring(2,4);
					}
					break;
			}
		} else {
			ctrl.value = "";
		}
	}
}

function isNumber(ctrl) {
	var str = ctrl.value;
	for(var i=0; i<str.length; i++) {
		if((str.charCodeAt(i) >= 48 && str.charCodeAt(i) <=57) || str.charCodeAt(i)==44 || str.charCodeAt(i)==45 || str.charCodeAt(i)==46) {
		} else {
			alert("inputs is not the numbers.");
			ctrl.value=0;
			ctrl.focus();
			return false;
		}
	}
	return true;
}

function getByteSize(ctrl, size) {
	var str = ctrl.value;
	if("number" == ctrl.Preset || "money" == ctrl.Preset) {
		str = str.replace(/(\,)/g,"");
	}
	
	if(size>0) {
		var sum = 0;
		var len = str.length;
		for (var i=0; i<len; i++) {
			var ch = str.substring(i, i + 1);
			var en = escape(ch);
			if( en.length <= 4 ) {
				sum++;
			} else {
				sum += 2;
			}
		}
		
		if(sum>size) {
			alert("It exceeded the number of byte where the string which it inputs is designated.");		
			//str = cutString(size, str);
			ctrl.value = str;
			ctrl.focus();
			return false;
		} else {
			return true;
		}
	}
}

function cutString(len, str) {
	var l = 0;
	for (var i=0; i<str.length; i++) {
		l += (str.charCodeAt(i) > 128) ? 2 : 1;
		if (l > len) return str.substring(0,i);
	}
	return str;
}

function toComma(ctrl) {
	var str = ctrl.value;
	var pointValue = "";
	var rmPoint=str.indexOf(".");
	if(rmPoint>=0) {
		pointValue = str.substring(rmPoint, str.length);
		str = str.substring(0, rmPoint);
	}
	str = str + "";
	str = str.replace(/(\,)/g,"");
	
	var tmp1, tmp2, tmp3;
	var statValue="", strValue="", modValue="";
	if(str.substring(0,1) == "-"){
		statValue = str.substring(1,str.length);
	} else {
		statValue = str;
	}
	tmp1 = statValue.length;

	if(tmp1 > 3){
		tmp2 = Math.floor(tmp1/3);
		tmp3 = tmp1 % 3;

		if(tmp3>0){
			strValue += statValue.substring(0,tmp3) + ",";
			modValue = statValue.substring(tmp3);
		} else {
			modValue = statValue;
		}

		for ( var i=0; i < tmp2 ; i++ ){
			if(i==(tmp2-1)){
				strValue += modValue.substring(i*3,i*3+3);
			} else {
				strValue += modValue.substring(i*3,i*3+3) + ",";
			}
		}
	} else {
		strValue = statValue;
	}
	
	if(str.substring(0,1) == "-"){ srtValue = "-"+strValue; }
	else{srtValue = strValue;}
	
	ctrl.value=srtValue+pointValue;
}

function toDash(ctrl){
	var str = ctrl.value;
	var firstNo = "";
	var secondNo = "";
	var thirdNo = "";
	var telNo = "";
	
	if(11 == str.length) {
		firstNo = str.substring(0, 3);
		secondNo = str.substring(3, 7);
		thirdNo = str.substring(7);
		
		telNo = firstNo + "-" + secondNo + "-" + thirdNo;
		
	} else if(10 == str.length) {
		firstNo = str.substring(0, 2);
		
		if("02" == firstNo){
			secondNo = str.substring(2, 6);
			thirdNo = str.substring(6);
		} else {
			firstNo = str.substring(0, 3);
			secondNo = str.substring(3, 6);
			thirdNo = str.substring(6);
		}
		
		telNo = firstNo + "-" + secondNo + "-" + thirdNo;
		
	} else if(9 == str.length) {
		firstNo = str.substring(0, 2);
		
		if("02" == firstNo){
			secondNo = str.substring(2, 5);
			thirdNo = str.substring(5);
		} else {
			firstNo = str.substring(0, 3);
			secondNo = str.substring(3, 6);
			thirdNo = str.substring(6);
		}
		
		telNo = firstNo + "-" + secondNo + "-" + thirdNo;
		
	} else {
		//alert("Directory number accurately, it was not input.");
		telNo = "";
	}
	
	
	ctrl.value=telNo;
	
}

//bizNo validation
function checkBizNo(bizNo) {
	var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
	var i, sum=0, c2, remainder;
	
	bizNo = bizNo.replace(/-/gi, '');
	
	for(i=0; i<=7; i++) {
		sum += checkID[i] * bizNo.charAt(i);
	}
	
	c2 = "0" + (checkID[8] * bizNo.charAt(8));
	c2 = c2.substring(c2.length - 2, c2.length);
	
	sum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(i));
	remainder = (10 - (sum%10)) % 10; 
	
	if(bizNo.length != 10) {
		return false;
	}
	else if(Math.floor(bizNo.charAt(9))!=remainder) {
		return false;
	}
	else {
		return true;
	}
}

//bizNo, division personal(true), corporate(fasle)
function checkBizNoPerson(bizNo) {
	bizNo = bizNo.replace(/-/gi, '');
	var c;
	c = bizNo.substring(3, 5);
	//personal : 01~80, 89~99, corporate : 81~86
	if(parseInt(c)>=81 && parseInt(c)<=86) return false;
	else
		return true;
}

/*
 * TextArea에서 입력한 줄바꿈 포함 텍스트에 대해
 * 일반영역에 표현할 경우...
 * (\r\n -> <br>로 변환)
 * */
function convertEnterText2Input(str) {
	var convertText = "";
	convertText = str.replace(/\n/g,"&lt;br&gt;")
	.replace(/\</g,"&#60;")
	.replace(/\>/g,"&#62;");
	
	return convertText;
}

/*
 * HTML태그로 변경한 줄바꿈을 TextArea에 표현할 경우
 * (<br> -> \r\n 로 변환)
 * */
function converEnterInput2Text(str) {
	var convertText = "";
	convertText = str.replace(/&lt;br&gt;/g, "\n")
	.replace(/&#60;/g, "<")
	.replace(/&#62;/g, ">");
	
	return convertText;
}

/*
 * DB에 저장된 &lt;br&gt;을 HTML태그 <br>로 변경
 * (&lt;br&gt; -> <br>로 변환)
 * */
function converEnterInput2PlainText(str) {
	var convertText = "";
	convertText = str.replace(/&lt;br&gt;/g, "<br>");
	
	return convertText;
}

function fnCheckID(str) {
    if(!/^[a-zA-Z]+[a-zA-Z0-9]{5,15}$/.test(str)) {
        return false;
    }
    /*혼합*/
    var chk_num = str.search(/[0-9]/g);
    var chk_eng = str.search(/[a-z]/g);
    if(chk_num<0 || chk_eng<0) {
    	return false;
    }
   
    return true;
}

function fnCheckHangul(str) {
    var chk_han = str.search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힝]/);
    if(chk_han != -1){
    	return false;
    }
   
    return true;
}

/*비밀번호 체크 START*/
function rtn_engnum_mix_chk(str) {
	var chk1 = /^[a-zA-Z0-9`~!@#$%^&*|\\\'\";:\/?]{6,}$/;
	
	 if(!chk1.test(str)) {
        return false;
    }
	return true;
}

function rtn_engnum_first_chk(str) {
	if('a' <= str.charAt(0) && str.charAt(0) <= 'z'){}
	else {
		return false;
	}
	return true;
}
/*비밀번호 체크 END*/

/*
 * Paging Funtion - START
 */

function pagingGrid(gridId, action, callback) {
	
	var pageNum = $("#"+gridId+"_pageNum").val();
	var totalCount = $("#"+gridId+"_totalCount").val();
	var displayNum = $("#"+gridId+"_displayNum").val();
	
	if (pageNum == "") pageNum = "0";
	if (totalCount == "") totalCount = "0";
	
	if (action == "GOTO" || action == "PAGE") {
		if ($("#"+gridId+"_pageNum").val() == "" || $("#"+gridId+"_pageNum").val() == "0" || $("#"+gridId+"_pageNum").val() == "1") {
			$("#"+gridId+"_pageNum").val("1");
		}
		
		var maxPageNum = Math.ceil(totalCount / parseFloat(displayNum));
		
		if (parseFloat(pageNum) > maxPageNum) {
			$("#"+gridId+"_pageNum").val(maxPageNum);
		}
	}
	/*
	else if (action == "PAGE") {
		
	}
	*/
	else if (action == "BEGIN") {
		$("#"+gridId+"_pageNum").val("1");
	}
	else if (action == "PREV") {
		if ($("#"+gridId+"_pageNum").val() == "" || $("#"+gridId+"_pageNum").val() == "0" || $("#"+gridId+"_pageNum").val() == "1") {
			$("#"+gridId+"_pageNum").val("1");
		}
		else {
			$("#"+gridId+"_pageNum").val(parseFloat(pageNum)-1);
		}
	}
	else if (action == "NEXT") {
		
		var maxPageNum = Math.ceil(totalCount / parseFloat(displayNum));
		
		if (parseFloat(pageNum) >= maxPageNum) {
			$("#"+gridId+"_pageNum").val(maxPageNum);
		}
		else {
			$("#"+gridId+"_pageNum").val(parseFloat(pageNum)+1);
		}
	}
	else if (action == "END") {
		var maxPageNum = Math.ceil(totalCount / parseFloat(displayNum));
		
		$("#"+gridId+"_pageNum").val(maxPageNum);
	}
	
	window.setTimeout(callback, 500);
}

function setPageInfo(gridId, beginRowNum, endRowNum, totalCount) {
	var pageInfoStr = "";
	if (parseFloat(beginRowNum) < parseFloat(endRowNum)) {
		pageInfoStr = beginRowNum+' - '+endRowNum+' of '+totalCount;
	}
	else {
		pageInfoStr = endRowNum+' - '+beginRowNum+' of '+totalCount;
	}
	$("#"+gridId+"_pageInfo").html(pageInfoStr);
	$("#"+gridId+"_totalCount").val(totalCount);
}

function clearPageInfo(gridId) {
	$("#"+gridId+"_pageInfo").html("");
	$("#"+gridId+"_totalCount").val("0");
}

function showAndHideLoading(func, param) {
	param = param==null ? "" : param;
	showLoading();
	setTimeout(func+"("+param+")",100);
	setTimeout("hideLoading()",100);
}

/*
 * Paging Funtion - END
 */


//byte check	
function getByteLength(data){
	var len = 0;
	var str = data.substring(0);
	
	if(str == null){
		return 0;
	}
	
	for(var i=0; i<str.length; i++){
		var ch = escape(str.charAt(i));
		if(ch.length == 1){
			len++;
		}else if(ch.indexOf("%u") != -1){
			len += 2;	//DB 한글인식 3byte 2->3
		}else if(ch.indexOf("%") != -1){
			len += ch.length/3;
		}
	}
	
	return len;
}

//-->

//전체(소수점자리제외) 및 소수점자리체크
function gatherIntFloat(objInput,i1,f1) {
  var szBuff = "";
  var chBuff = '';
  var szTemp = "";
  var intChar = 0;
  var floatChar = 0;
  var i = 0;
  var dotCount = 0;

  szBuff = objInput;
  for(i=0; i < szBuff.length; i++) {
    chBuff = szBuff.charAt(i);

    if(chBuff == ".") {
      dotCount = dotCount + 1;
      if(dotCount > 1) {
        dotCount = 0;
        return false;
      }
    }
    else if (dotCount==0){
    	intChar = intChar + 1;	
    }
    else if(dotCount==1){
    	floatChar = floatChar + 1;
    }
    
    if((chBuff < '0' || chBuff > '9') && chBuff != '.') {
    	if (!(i == 0 && chBuff == '-')) {
    		return false;
    	}
    }
  }
  
  if (intChar >(i1-f1)){
	  alert("전체 "+String(i1-f1)+"자리를 초과할 수 없습니다.(소수점자리 제외)");
	  return false; 
  }
//  else if ((f1==0)&&(dotCount>0)){
//	  alert("정수를 입력해야 합니다. ");
//	  return false;
//  }
  else if (floatChar>f1){
	  alert("소수점 "+String(f1)+"자리를 초과할 수 없습니다. ");
	  return false;
  }
  return true;
}