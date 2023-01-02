//<![CDATA[

/*
 * Use Ajax when Data insert/update/delete/etc
 * @param url - url(ex: <c:out value="${contextPath}" />/bld.do)
 * @param docForm - Form
 * @param controllerMethodName - Controller's Method
 */
function fnUseAjax(url, docForm, controllerMethodName){
	var request = creatHttpRequest();
	settingHttpRequest(request, url, docForm, controllerMethodName)
}

/*
 * XMLHttpRequest Object Create
 * @param parameterName - Control's Name
 */
function creatHttpRequest(){
  if(window.ActiveXObject){
    try{
      //IE6
      return new ActiveXObject("Msxml2.XMLHTTP");
    } catch(e) {
      try{
        //IE5, IE4
        return new ActiveXObject("Microsoft.XMLHTTP")
      } catch(e) {
        return null;
      }
    }
  } else if(window.NMLHttpRequest){
    //Mozilla, FireFox, Opera, Safari, Konqueror3
    return new XMLHttpRequest();
  } else {
    return null;
  }
}

/*
 * XMLHttpRequest generate(use when insert/update/delete/etc.. data)
 * @param request - XMLHttpRequest Object
 * @param url - url
 * @param docForm - Form
 * @param controllerMethodName - Controller's Method
 */
function settingHttpRequest(request, url, docForm, controllerMethodName){
	var queryString = "method=" + controllerMethodName + "&";
	queryString += fnToQueryString(docForm);
	
	request.open("POST", url);
	request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
	request.send(queryString);
	
	if (window.opera) {
	    request.onload = function() { 
	    	callback(request);
	    }
	} else {
	    request.onreadystatechange = function(){
	        if (request.readyState == 4 && request.status == 200){
	            callback(request);
	        }
	    }
	}
}

/*
 * XMLHttpRequest generate(use when select/etc.. data)
 * @param request - XMLHttpRequest Object
 * @param url - url
 * @param queryString - queryString
 */
function setHttpRequest(request, url, queryString){
	request.open("POST", url);
	request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
	request.send(queryString);
	
	if (window.opera) {
	    request.onload = function() { 
	    	callback(request);
	    }
	} else {
	    request.onreadystatechange = function(){
	        if (request.readyState == 4 && request.status == 200){
	            callback(request);
	        }
	    }
	}
}

/*
 * QueryString's parameterName
 * @param parameterName - Control's Name
 */
function fnSetParameterName(parameterName){
	//alert(parameterName);
	var temp01 = parameterName.substring(3, 4).toLowerCase();
	var temp02 = parameterName.substring(4);
	//alert(temp01 + temp02);
	return temp01 + temp02;
}

/*
 * QueryString's parameterValue
 * @param paramValue - Control's Value
 */
function fnParamEscape(paramValue){
	return encodeURIComponent(paramValue);
}

/*
 * Setting QueryString use FormData
 * @param docForm - Form
 */
function fnToQueryString(docForm){
	var submitString = "";
	var formElement;
	var lastElementName = "";
	
	for(i=0;i < docForm.elements.length;i++){
		formElement = docForm.elements[i];
		
		switch(formElement.type){
			case "text":
			case "select-one":
			case "hidden":
			case "textarea":
				if(formElement.name.indexOf("Date") > 0){
					submitString += fnSetParameterName(formElement.name) + "=" + fnParamEscape(formElement.value.replace(/-/g, '')) + "&";
				} else {
					submitString += fnSetParameterName(formElement.name) + "=" + fnParamEscape(formElement.value) + "&";
				}
				break;
			case "radio":
				if(formElement.checked){
					submitString += fnSetParameterName(formElement.name) + "=" + fnParamEscape(formElement.value) + "&";
				}
				break;
			case "checkbox":
				if(formElement.checked){
					if(formElement.name == lastElementName){
						if(submitString.lastIndexOf('&') == submitString.length - 1){
							submitString = submitString.substring(0, submitString.length -1);
						}
						submitString += "," + fnParamEscape(formElement.value);
					} else {
						//alert(formElement.name);
						submitString += fnSetParameterName(formElement.name) + "=" + fnParamEscape(formElement.value);
					}
					submitString += "&";
					lastElementName = formElement.name;
				}
				break;
		}
	}
	
	submitString = submitString.substring(0, submitString.length -1);
	//alert(submitString);
	return submitString;
}

//]]>