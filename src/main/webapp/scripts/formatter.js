// Bizer Regist Number
function formatBizRegNo(val)
{
	if (val == null) return null;
    
	if (val == '' || trim(removeChar(val, '-')).length != 10){
		return val;
	}

	val = trim(removeChar(val, '-'));

	var fore = val.substring(0, 3);
	var middle = val.substring(3, 5);
	var rear = val.substring(5, 10);

	return fore+'-'+middle+'-'+rear;	
}

// Month - YYYY.MM
function formatMonth(val) {
    
    if (val == null) return null;

    if (val == '' || trim(removeChar(val, '.')).length != 6){
        return val;
    }
    
    val = trim(removeChar(val, '.'));
    
    var yyyy = val.substring(0, 4);
    var mm = val.substring(4, 6);
    
    return yyyy + '.' + mm;
}

//Birth - YY.MM.DD
function formatBirth(val) {
    
    if (val == null) return null;

    if (val == '' || trim(removeChar(val, '.')).length != 6){
        return val;
    }
    
    val = trim(removeChar(val, '.'));
    
    var yy = val.substring(0, 2);
    var mm = val.substring(2, 4);
    var dd = val.substring(4, 6);
    
    return yy + '.' + mm + '.' + dd;
}



function formatTime(val) {
	if (val == null) return null;
	
	val = trim(removeChar(val, '.'));
    val = trim(removeChar(val, ':'));
    val = trim(removeChar(val, ' '));
    
    if (val == '' || (val.length != 4 && val.length != 6)){
        return val;
    }
    
    var hour = val.substring(0, 2);
    var min = val.substring(2, 4);
    var sec = "";
    try {
    	sec = val.substring(4, 6);
    }catch(e){}
    
    if (val.length == 4) {
    	return hour + ":" + min;
    }
    else if (val.length == 6) {
    	return hour + ":" + min + ":" + sec;
    }
}

// ID Number
function formatIDNo(val, hidden)
{
	if (val == null) return null;

	if (val == '' || trim(removeChar(val, '-')).length != 13){
		return val;
	}
	
	val = trim(removeChar(val, '-'));
	
	var fore = val.substring(0, 6);
	var rear = val.substring(6, 13);
	
	if (hidden == '*') {
		//var fore = val.substring(0, 6);
		//return fore+'-*******';
		return val.substring(0, 6) + '-' + val.substring(6, 7) + '******';
	} else {
		return fore+'-'+rear;
	}
}

// Post Number
function formatZipCode(val)
{
	if (val == null) return null;

	if (val == '' || trim(removeChar(val, '-')).length != 6){
		return val;
	}
	
	val = trim(removeChar(val, '-'));
	
	var fore = val.substring(0, 3);
	var rear = val.substring(3, 6);
	
	return fore+'-'+rear;
}


//Tel Number
function formatTelNo(val)
{
	if (val == null) return null;

	if (val == '' || trim(removeChar(val, '-')).length > 11){
		return val;
	}
	
	val = trim(removeChar(val, '-'));
	
	if (val.length == 11) {
		
		var fore = val.substring(0, 3);
		var mid = val.substring(3, 7);
		var rear = val.substring(7, 11);
	
		return fore+'-'+mid+'-'+rear;
	}
	else if (val.length == 10) {
		if (val.substring(0,2) == "02") {
			var fore = val.substring(0, 2);
			var mid = val.substring(2, 6);
			var rear = val.substring(6, 10);
		}
		else {
			var fore = val.substring(0, 3);
			var mid = val.substring(3, 6);
			var rear = val.substring(6, 10);
		}	
	
		return fore+'-'+mid+'-'+rear;
	}
	else if (val.length == 9) {
		if (val.substring(0,2) == "02") {
			var fore = val.substring(0,2);
			var mid = val.substring(2,5);
			var rear = val.substring(5,9);
		}
		else {
			var fore = val.substring(0,3);
			var mid = val.substring(3,5);
			var rear = val.substring(5,9);
		}	
	
		return fore+'-'+mid+'-'+rear;
	}
	else {
		return val;
	}
}

//Card Number
function formatCardNo(val)
{
	if (val == null) return null;

	val = trim(removeChar(val, '-'));
	
	if (val.length >= 10) {
		
		var fore = val.substring(0, 4);
		var mid = "";
		mid = val.substring(4, 6);
		for (var i=6; i < 8; i++){
			mid = mid + "*";
		}
		var mid2 = "";
		for (var i=8; i < val.length-4; i++){
			mid2 = mid2 + "*";
		}
		var rear = val.substring(val.length-4, val.length);
	
		return fore+"-"+mid+"-"+mid2+"-"+rear;
	}
	else if (val.length < 10) {
		var mid = "";
		for (var i=0; i < val.length-4; i++){
			mid = mid + "*";
		}
		var rear = val.substring(val.length-4, val.length);
	
		return mid+rear;
	}
}

function formatCardNoNonStar(val)
{
	if (val == null) return null;
	if (val.length != 16)	return null;
	
	val = trim(removeChar(val, '-'));
	
	var one = "";
	var two = "";
	var three = "";
	var four = "";
	one = val.substring(0,4);
	two = val.substring(4,8);
	three = val.substring(8,12);
	four = val.substring(12,16);

	return one+"-"+two+"-"+three+"-"+four;
}

//Password
function formatPassword(val)
{
	if (val == null) return null;

	val = trim(removeChar(val, '-'));
	
	var returnVal = "";
	for (var i=0; i < val.length; i++){
		returnVal = returnVal + "*";
	}
	return returnVal;
}

// Remove Char
function removeChar(str, _del) 
{
	str+=''; // Don't erase this line.

	var temp="";
	for(var i=0;i<str.length;++i) {
      		var c=str.charAt(i);
      		if(c!=_del) temp += c;
   	}
   	return temp;
}

// Remove Format
function unformat(val)
{
	if (val == null) return null;

	val = removeChar(val, '-');
	val = removeChar(val, '/');
	val = removeChar(val, '.');
	val = removeChar(val, ',');
	val = removeChar(val, ':');
	val = removeChar(val, ' ');
	
	return val;
}

function unformatNum(val)
{
	if (val == null) return null;

	val = removeChar(val, ',');
	
	return val;
}
function unformatDate(val,format) {
	if (val == null || val == '') return '';
	
	var date = unformat(val);
	var yyyy = "";
	var mm = "";
	var dd = "";
	
	if (format.substring(0,3) == "YMD") {
    	yyyy = date.substring(0,4);
    	mm = date.substring(4,6);
    	dd = date.substring(6,8);
    }
    else if (format.substring(0,3) == "MDY") {
    	yyyy = date.substring(4,8);
    	mm = date.substring(0,2);
    	dd = date.substring(2,4);
    }
    else if (format.substring(0,3) == "DMY") {
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

function numCheck()
{
  if ((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
}


function trim(str) {
    var temp="";
    for(var i=0;i<str.length;++i) {
            var c=str.charAt(i);
            if(c!=" ") temp += c;
    }
    return temp;
}

function isNumber(obj){
	var val;
	if (obj.tagName == "INPUT")
		val = trim(obj.value);
	else 
		val = trim(obj);
	
	if (val == '') return true;

	if (window.RegExp){
		var regex = /^([1-9-])?[0-9]+$/;
		flag = regex.test(val);
	}else{
		flag = !isNaN(val);
	}

	if (obj.tagName == "INPUT" && flag) 
		obj.value = parseInt(val, 10);

	return flag;
}


function isDecimal(objInput){
  var szBuff = "";
  var chBuff = '';
  var szTemp = "";
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
    
    if((chBuff < '0' || chBuff > '9') && chBuff != '.') {
    	if (!(i == 0 && chBuff == '-')) {
    		return false;
    	}
    }
  }
  return true;
}

function cs_isDecimal(objInput){
  var szBuff = "";
  var chBuff = '';
  var szTemp = "";
  var i = 0;
  var dotCount = 0;

  szBuff = objInput;
  for(i=1; i < szBuff.length; i++) {
    chBuff = szBuff.charAt(i);

    if(chBuff == ".") {
      dotCount = dotCount + 1;
      if(dotCount > 1) {
        dotCount = 0;
        return false;
      }
    }
    
    if((chBuff < '0' || chBuff > '9') && chBuff != '.') {
    	if (!(i == 0)) {
    		return false;
    	}
    }
  }
  return true;
}

function isNumberChar(objInput) {
  var szBuff = "";
  var chBuff = '';
  var szTemp = "";
  var i = 0;
  var dotCount = 0;

  szBuff = objInput.value;
  for(i=0; i < szBuff.length; i++) {
    chBuff = szBuff.charAt(i);

    if(chBuff == ".") {
      dotCount = dotCount + 1;
      if(dotCount > 1) {
        dotCount = 0;
        alert("Error!!!");

        for(var j=0; j<szBuff.length; j++) {
          chBuff = szBuff.charAt(j);
          if ((chBuff < '0' || chBuff > '9') && chBuff != '.') {
            continue;
          } else {
            if(chBuff == ".") {
              dotCount = dotCount + 1;
              if(dotCount > 1) {
                continue;
              } else {
                szTemp = szTemp + chBuff;
              }
            } else {
              szTemp = szTemp + chBuff;
            }
          }
        }
        
        objInput.value = szTemp;
        return;
      }
    }
    
    if((chBuff < '0' || chBuff > '9') && chBuff != '.') {
        alert("Error!!!");

      for(var j=0; j<szBuff.length; j++) {
        chBuff = szBuff.charAt(j);
        if ((chBuff < '0' || chBuff > '9') && chBuff != '.') {
          continue;
        } else {
          szTemp = szTemp + chBuff;
        }
      }

      objInput.value = szTemp;
      return;
    }
  }
}

function isAlphaNumeric(objInput) {
  var szBuff = "";
  var chBuff = '';
  var szTemp = "";
  var i = 0;

  szBuff = objInput.value;
  for(i=0; i<szBuff.length; i++) {
    chBuff = szBuff.charAt(i);
    if((chBuff < '0' || chBuff > '9') && (chBuff < "A" || chBuff > "Z") && (chBuff < "a" || chBuff > "z")) {
      alert("Error!!!");

      for(var j=0; j<szBuff.length; j++) {
        chBuff = szBuff.charAt(j);
        if((chBuff < '0' || chBuff > '9') && (chBuff < "A" || chBuff > "Z") && (chBuff < "a" || chBuff > "z")) {
          continue;
        } else {
          szTemp = szTemp + chBuff;
        }
      }
      objInput.value = szTemp;

      return;
    }
  }
}

function isSignNumber(objInput) {
  var szBuff = "";
  var chBuff = '';
  var szTemp = "";
  var i = 0;

  szBuff = objInput.value;
  for(i=0; i < szBuff.length; i++) {
	chBuff = szBuff.charAt(i);
	if (i > 0 && chBuff == '-') {
		alert("Error!!!");

		for(var j=0; j<szBuff.length; j++) {
		  chBuff = szBuff.charAt(j);
		  if (chBuff == '-') {
			continue;
		  } else {
			szTemp = szTemp + chBuff;
		  }
		}
  
		objInput.value = szTemp;
		return;
	}
	else if((chBuff < '0' || chBuff > '9') && chBuff != '-') {
	  alert("Error!!!");

	  for(var j=0; j<szBuff.length; j++) {
		chBuff = szBuff.charAt(j);
		if ((chBuff < '0' || chBuff > '9') && chBuff != '-') {
		  continue;
		} else {
		  szTemp = szTemp + chBuff;
		}
	  }

	  objInput.value = szTemp;
	  return;
	}
  }
}

function getStringLength(sel_object) {
  var strValue = sel_object.value;
  var retCode = 0;
  var count_char = 0;

  for (i=0; i<strValue.length; i++) {
    var retCode = strValue.charCodeAt(i);
    var retChar = strValue.substr(i,1).toUpperCase();
    retCode = parseInt(retCode);

    if ((retChar < "0" || retChar > "9") && (retChar < "A" || retChar > "Z") && ((retCode > 255) || (retCode < 0))) {
      count_char = count_char + 2;
    } else {
      count_char = count_char + 1;
    }
  }

  return (count_char);
}

function formatNum(str) {
    str = str + "";
    
    var spt = str.split(".");
    str = spt[0];
    var tail = "";
    if (spt.length > 1) {
    	tail = "."+spt[1];
    } 

    var tmp1,tmp2,tmp3;
    var statValue="",strValue="", modValue="";
    if(str.substring(0,1) == "-"){
	  statValue = str.substring(1,str.length);
	}
	else{
      statValue = str;
	}
       tmp1 = statValue.length;
       
       if(tmp1 > 3){
         tmp2 = Math.floor(tmp1/3);
         tmp3 = tmp1 % 3;
         if(tmp3>0){
            strValue += statValue.substring(0,tmp3) + ",";
            modValue = statValue.substring(tmp3);
         }
         else{
            modValue = statValue;
         }

         for ( var i=0; i < tmp2 ; i++ ){
            if(i==(tmp2-1)){
                strValue += modValue.substring(i*3,i*3+3);
            }
            else{
                strValue += modValue.substring(i*3,i*3+3) + ",";
            }
         }
       }
       else{
            strValue = statValue;
       }
		if(str.substring(0,1) == "-"){ strValue = "-"+strValue; }
		else{strValue = strValue;}
		return strValue + tail;
}

function formatAmt(str) {
	var val = parseFloat(str).toFixed(2).split(".");
	return formatNum(val[0]) + "." + val[1];
}

function isTime(objName) {
	
	var hour;
	var min;
	
	if (objName.length != 4) {
		return false;
	}
	
	hour = parseInt(objName.substring(0,2),10);
	min = parseInt(objName.substring(2,4),10);
	
	if (hour < 0 || hour > 23) {
		return false;
	} else if (min < 0 || min > 59) {
		return false;
	}
	
	return true;
}

function getNormalNum(strAmt) {
  var strResult = "";
  var strAry;
  
  strAry = strAmt.split(',');
  
  for(i=0; i < strAry.length; i++)
    strResult = strResult + strAry[i];
  
  if(strResult == "")
    return "0";
  else
    return strResult;
}

function numToStr(temp)
{
    str = "";
    start = (temp.length % 3);
    for(i = 0; i < start; i++)
    {
        str = str + (temp.charAt(i));
    }    
                       
    if((temp.length % 3) > 0)
	{
		for(j = start; j < temp.length; j++)
      	{
	        if(((temp.length - j) % 3) == 0)
            {
	            str = str + ",";
	        }
            str = str + (temp.charAt(j));
	    }
        return str;
	}
	else
	{
	  	str = str + temp.charAt(start);
	   	for(j = (start + 1); j < temp.length; j++)
       	{
		    if(((temp.length - j) % 3) == 0)
            {
	            str = str + ",";
	        }
            str = str + (temp.charAt(j));
	    }
        return str;
    }
}

function formatDecimal(str) {
	str = str + "";
   
    var reindex=0;
    reindex=str.indexOf(".");
    var restr="";
    if(reindex!=0&&reindex!=-1){
    	restr = str.substring(reindex,str.length);
    	str =str.substring(0,reindex);
    }
    
    var tmp1,tmp2,tmp3;
    var statValue="",strValue="", modValue="";
    if(str.substring(0,1) == "-"){
	  statValue = str.substring(1,str.length);
	}
	else{
      statValue = str;
	}
       tmp1 = statValue.length;
       
       if(tmp1 > 3){
         tmp2 = Math.floor(tmp1/3);
         tmp3 = tmp1 % 3;
         if(tmp3>0){
            strValue += statValue.substring(0,tmp3) + ",";
            modValue = statValue.substring(tmp3);
         }
         else{
            modValue = statValue;
         }

         for ( var i=0; i < tmp2 ; i++ ){
            if(i==(tmp2-1)){
                strValue += modValue.substring(i*3,i*3+3);
            }
            else{
                strValue += modValue.substring(i*3,i*3+3) + ",";
            }
         }
       }
       else{
            strValue = statValue;
       }
        if(str.substring(0,1) == "-"){ srtValue = "-"+strValue; }
        else{srtValue = strValue;}
		return srtValue+restr;
}


 function  checkIDNo() {
     var f = document.frmExecute;  		   
     var chk =0
     var yy = f.idNo1.value.substring(0,2);
     var mm = f.idNo1.value.substring(2,4);
     var dd = f.idNo2.value.substring(4,6);
     var sex = f.idNo2.value.substring(0,1);

     if ((f.idNo1.value.length!=6)||(yy <20||mm <1||mm>12||dd<1)){
         alert ("Error!!!");
         f.idNo1.value='';
         f.idNo2.value='';
         f.idNo1.focus();
         return;
     }

     if ((sex != 1 && sex !=2 )||(f.idNo2.value.length != 7 )){
         alert ("Error!!!");
         f.idNo1.value='';
         f.idNo2.value='';
         f.idNo1.focus();
         return;
     }   

     for (var i = 0; i <=5 ; i++){ 
         chk = chk + ((i%8+2) * parseInt(f.idNo1.value.substring(i,i+1)));
     }

     for (var i = 6; i <=11 ; i++){ 
         chk = chk + ((i%8+2) * parseInt(f.idNo2.value.substring(i-6,i-5)));
     }

     chk = 11 - (chk %11);
     chk = chk % 10;

     if (chk != f.idNo2.value.substring(6,7))
     {
         alert ("Error!!!");
         f.idNo1.value='';
         f.idNo2.value='';
         f.idNo1.focus();
         return;
     } 
}

function autoFocus(len, inObj, nextObj) {
	try{
		if( inObj.value.length == len) {
			nextObj.focus();
		}
	}catch(e){
		alert("Error!!!\r\n"+e.description);
	}
}

function isEmail(email){
	email = email.replace(" ", "");
	email = trim(email);
	if(email != "") {
		reg = new RegExp("^[\\w\\-]+(\\.[\\w\\-_]+)*@[\\w\\-]+(\\.[\\w\\-]+)*(\\.[a-zA-Z]{2,3})$", "gi");
	
		if (!reg.test(email)) {
			return false;
		}
	}
	return true;
}

function formatMaskingNo(no) {
	var rtn = "";
	if (no.length < 10) {
		for (var i=0; i<no.length-2; i++) {
			rtn += "*";
		}
		rtn += no.substring(no.length-2);
	} else {
		for (var i=0; i<no.length; i++) {
			if (i<4 || i>=no.length-2) {
				rtn += no.substring(i,i+1);
			} else {
				rtn += "*";
			}
		}
	}
	return rtn;
}