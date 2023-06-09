if(!window.DHTMLSuite)var DHTMLSuite=new Object();if(!String.trim)String.prototype.trim=function(){return this.replace(/^\s+|\s+$/,'')};var DHTMLSuite_funcs=new Object();if(!window.DHTML_SUITE_THEME)var DHTML_SUITE_THEME='blue';if(!window.DHTML_SUITE_THEME_FOLDER)var DHTML_SUITE_THEME_FOLDER='/scripts/dhtml/themes/';if(!window.DHTML_SUITE_JS_FOLDER)var DHTML_SUITE_JS_FOLDER='/scripts/dhtml/js/separateFiles/';var DHTMLSuite=new Object();var standardObjectsCreated=false;DHTMLSuite.eventEls=new Array();var widgetDep=new Object();widgetDep['formValidator']=['dhtmlSuite-formUtil.js'];widgetDep['paneSplitter']=['dhtmlSuite-paneSplitter.js','dhtmlSuite-paneSplitterModel.js','dhtmlSuite-dynamicContent.js','ajax.js'];widgetDep['menuBar']=['dhtmlSuite-menuBar.js','dhtmlSuite-menuItem.js','dhtmlSuite-menuModel.js'];widgetDep['windowWidget']=['dhtmlSuite-windowWidget.js','dhtmlSuite-resize.js','dhtmlSuite-dragDropSimple.js','ajax.js','dhtmlSuite-dynamicContent.js'];widgetDep['colorWidget']=['dhtmlSuite-colorWidgets.js','dhtmlSuite-colorUtil.js'];widgetDep['colorSlider']=['dhtmlSuite-colorWidgets.js','dhtmlSuite-colorUtil.js','dhtmlSuite-slider.js'];widgetDep['colorPalette']=['dhtmlSuite-colorWidgets.js','dhtmlSuite-colorUtil.js'];widgetDep['calendar']=['dhtmlSuite-calendar.js','dhtmlSuite-dragDropSimple.js'];widgetDep['dragDropTree']=['dhtmlSuite-dragDropTree.js'];widgetDep['slider']=['dhtmlSuite-slider.js'];widgetDep['dragDrop']=['dhtmlSuite-dragDrop.js'];widgetDep['imageEnlarger']=['dhtmlSuite-imageEnlarger.js','dhtmlSuite-dragDropSimple.js'];widgetDep['imageSelection']=['dhtmlSuite-imageSelection.js'];widgetDep['floatingGallery']=['dhtmlSuite-floatingGallery.js','dhtmlSuite-mediaModel.js'];widgetDep['contextMenu']=['dhtmlSuite-contextMenu.js','dhtmlSuite-menuBar.js','dhtmlSuite-menuItem.js','dhtmlSuite-menuModel.js'];widgetDep['dynamicContent']=['dhtmlSuite-dynamicContent.js','ajax.js'];widgetDep['textEdit']=['dhtmlSuite-textEdit.js','dhtmlSuite-textEditModel.js','dhtmlSuite-listModel.js'];widgetDep['listModel']=['dhtmlSuite-listModel.js'];widgetDep['resize']=['dhtmlSuite-resize.js'];widgetDep['dragDropSimple']=['dhtmlSuite-dragDropSimple.js'];widgetDep['dynamicTooltip']=['dhtmlSuite-dynamicTooltip.js','dhtmlSuite-dynamicContent.js','ajax.js'];widgetDep['modalMessage']=['dhtmlSuite-modalMessage.js','dhtmlSuite-dynamicContent.js','ajax.js'];widgetDep['tableWidget']=['dhtmlSuite-tableWidget.js','ajax.js'];widgetDep['progressBar']=['dhtmlSuite-progressBar.js'];widgetDep['tabView']=['dhtmlSuite-tabView.js','dhtmlSuite-dynamicContent.js','ajax.js'];widgetDep['infoPanel']=['dhtmlSuite-infoPanel.js','dhtmlSuite-dynamicContent.js','ajax.js'];widgetDep['form']=['dhtmlSuite-formUtil.js','dhtmlSuite-dynamicContent.js','ajax.js'];widgetDep['autoComplete']=['dhtmlSuite-autoComplete.js','ajax.js'];widgetDep['chainedSelect']=['dhtmlSuite-chainedSelect.js','ajax.js'];var depCache=new Object();DHTMLSuite.include=function(widget){if(!widgetDep[widget]){alert('Cannot find the files for widget '+widget+'. Please verify that the name is correct');return}
var files=widgetDep[widget];for(var no=0;no<files.length;no++){if(!depCache[files[no]]){document.write('<'+'script');document.write(' language="javascript"');document.write(' type="text/javascript"');document.write(' src="'+DHTML_SUITE_JS_FOLDER+files[no]+'">');document.write('</'+'script'+'>');depCache[files[no]]=true}}}
DHTMLSuite.discardElement=function(element){element=DHTMLSuite.commonObj.getEl(element);var gBin=document.getElementById('IELeakGBin');if(!gBin){gBin=document.createElement('DIV');gBin.id='IELeakGBin';gBin.style.display='none';document.body.appendChild(gBin)}
gBin.appendChild(element);gBin.innerHTML=''}
DHTMLSuite.createStandardObjects=function(){DHTMLSuite.clientInfoObj=new DHTMLSuite.clientInfo();DHTMLSuite.clientInfoObj.init();if(!DHTMLSuite.configObj){DHTMLSuite.configObj=new DHTMLSuite.config();DHTMLSuite.configObj.init()}
DHTMLSuite.commonObj=new DHTMLSuite.common();DHTMLSuite.variableStorage=new DHTMLSuite.globalVariableStorage();;DHTMLSuite.commonObj.init();DHTMLSuite.domQueryObj=new DHTMLSuite.domQuery();DHTMLSuite.commonObj.addEvent(window,'unload',function(){DHTMLSuite.commonObj.__clearMemoryGarbage()});standardObjectsCreated=true}
DHTMLSuite.config=function(){var imagePath;var cssPath;var defaultCssPath;var defaultImagePath}
DHTMLSuite.config.prototype={init:function(){this.imagePath=DHTML_SUITE_THEME_FOLDER+DHTML_SUITE_THEME+'/images/';this.cssPath=DHTML_SUITE_THEME_FOLDER+DHTML_SUITE_THEME+'/css/';this.defaultCssPath=this.cssPath;this.defaultImagePath=this.imagePath},setCssPath:function(newCssPath){this.cssPath=newCssPath},resetCssPath:function(){this.cssPath=this.defaultCssPath},resetImagePath:function(){this.imagePath=this.defaultImagePath},setImagePath:function(newImagePath){this.imagePath=newImagePath}}
DHTMLSuite.globalVariableStorage=function(){var menuBar_highlightedItems;this.menuBar_highlightedItems=new Array();var arrayDSObjects;var arrayOfDhtmlSuiteObjects;this.arrayDSObjects=new Array();this.arrayOfDhtmlSuiteObjects=this.arrayDSObjects;var ajaxObjects;this.ajaxObjects=new Array()}
DHTMLSuite.globalVariableStorage.prototype={}
DHTMLSuite.common=function(){var loadedCSSFiles;var cssCacheStatus;var eventEls;var isOkToSelect;this.okToSelect=true;this.cssCacheStatus=true;this.eventEls=new Array()}
DHTMLSuite.common.prototype={init:function(){this.loadedCSSFiles=new Array()},loadCSS:function(cssFile,prefixConfigPath){if(!prefixConfigPath&&prefixConfigPath!==false)prefixConfigPath=true;if(!this.loadedCSSFiles[cssFile]){this.loadedCSSFiles[cssFile]=true;var lt=document.createElement('LINK');if(!this.cssCacheStatus){if(cssFile.indexOf('?')>=0)cssFile=cssFile+'&';else cssFile=cssFile+'?';cssFile=cssFile+'rand='+Math.random()}
if(prefixConfigPath){lt.href=DHTMLSuite.configObj.cssPath+cssFile}else{lt.href=cssFile}
lt.rel='stylesheet';lt.media='screen';lt.type='text/css';document.getElementsByTagName('HEAD')[0].appendChild(lt)}},__setTextSelOk:function(okToSelect){this.okToSelect=okToSelect},__isTextSelOk:function(){return this.okToSelect},setCssCacheStatus:function(cssCacheStatus){this.cssCacheStatus=cssCacheStatus},getEl:function(elRef){if(typeof elRef=='string'){if(document.getElementById(elRef))return document.getElementById(elRef);if(document.forms[elRef])return document.forms[elRef];if(document[elRef])return document[elRef];if(window[elRef])return window[elRef]}
return elRef},isArray:function(el){if(el.constructor.toString().indexOf("Array")!=-1)return true;return false},getStyle:function(el,property){el=this.getEl(el);if(document.defaultView&&document.defaultView.getComputedStyle){var retVal=null;var comp=document.defaultView.getComputedStyle(el,'');if(comp){retVal=comp[property]}
return el.style[property]||retVal}
if(document.documentElement.currentStyle&&DHTMLSuite.clientInfoObj.isMSIE){var retVal=null;if(el.currentStyle)value=el.currentStyle[property];return(el.style[property]||retVal)}
return el.style[property]},getLeftPos:function(el){if(document.getBoxObjectFor){if(el.tagName!='INPUT'&&el.tagName!='SELECT'&&el.tagName!='TEXTAREA')return document.getBoxObjectFor(el).x
}
var returnValue=el.offsetLeft;while((el=el.offsetParent)!=null){if(el.tagName!='HTML'){returnValue+= el.offsetLeft;if(document.all)returnValue+=el.clientLeft}}
return returnValue},getTopPos:function(el){if(document.getBoxObjectFor){if(el.tagName!='INPUT'&&el.tagName!='SELECT'&&el.tagName!='TEXTAREA')return document.getBoxObjectFor(el).y
}
var returnValue=el.offsetTop;while((el=el.offsetParent)!=null){if(el.tagName!='HTML'){returnValue+=(el.offsetTop-el.scrollTop);if(document.all)returnValue+=el.clientTop}}
return returnValue},getCookie:function(name){var start=document.cookie.indexOf(name+"=");var len=start+name.length+1;if((!start)&&(name!=document.cookie.substring(0,name.length)))return null;if(start==-1)return null;var end=document.cookie.indexOf(";",len);if(end==-1)end=document.cookie.length;return unescape(document.cookie.substring(len,end))},setCookie:function(name,value,expires,path,domain,secure){expires=expires*60*60*24*1000;var today=new Date();var expires_date=new Date(today.getTime()+(expires));var cookieString=name+"="+escape(value)+
((expires)?";expires="+expires_date.toGMTString():"")+
((path)?";path="+path:"")+
((domain)?";domain="+domain:"")+
((secure)?";secure":"");document.cookie=cookieString},deleteCookie:function(name,path,domain){if(this.getCookie(name))document.cookie=name+"="+
((path)?";path="+path:"")+
((domain)?";domain="+domain:"")+
";expires=Thu,01-Jan-1970 00:00:01 GMT"},cancelEvent:function(){return false},addEvent:function(obj,type,fn,suffix){if(!suffix)suffix='';if(obj.attachEvent){if(typeof DHTMLSuite_funcs[type+fn+suffix]!='function'){DHTMLSuite_funcs[type+fn+suffix]=function(){fn.apply(window.event.srcElement)};obj.attachEvent('on'+type,DHTMLSuite_funcs[type+fn+suffix])}
obj=null} else {obj.addEventListener(type,fn,false)}
this.__addEventEl(obj)},removeEvent:function(obj,type,fn,suffix){if(obj.detachEvent){obj.detachEvent('on'+type,DHTMLSuite_funcs[type+fn+suffix]);DHTMLSuite_funcs[type+fn+suffix]=null;obj=null} else {obj.removeEventListener(type,fn,false)}},__clearMemoryGarbage:function(){if(!DHTMLSuite.clientInfoObj.isMSIE)return;for(var no=0;no<DHTMLSuite.eventEls.length;no++){try{var el=DHTMLSuite.eventEls[no];el.onclick=null;el.onmousedown=null;el.onmousemove=null;el.onmouseout=null;el.onmouseover=null;el.onmouseup=null;el.onfocus=null;el.onblur=null;el.onkeydown=null;el.onkeypress=null;el.onkeyup=null;el.onselectstart=null;el.ondragstart=null;el.oncontextmenu=null;el.onscroll=null;el=null}catch(e){}}
for(var no in DHTMLSuite.variableStorage.arrayDSObjects){DHTMLSuite.variableStorage.arrayDSObjects[no]=null}
window.onbeforeunload=null;window.onunload=null;DHTMLSuite=null},__addEventEl:function(el){DHTMLSuite.eventEls[DHTMLSuite.eventEls.length]=el},getSrcElement:function(e){var el;if(e.target)el=e.target;else if(e.srcElement)el=e.srcElement;if(el.nodeType==3)
el=el.parentNode;return el},getKeyFromEvent:function(e){var code=this.getKeyCode(e);return String.fromCharCode(code)},getKeyCode:function(e){if(e.keyCode)code=e.keyCode;else if(e.which)code=e.which;return code},isObjectClicked:function(obj,e){var src=this.getSrcElement(e);var string=src.tagName+'('+src.className+')';if(src==obj)return true;while(src.parentNode&&src.tagName.toLowerCase()!='html'){src=src.parentNode;string=string+','+src.tagName+'('+src.className+')';if(src==obj)return true}
return false},getObjectByClassName:function(e,className){var src=this.getSrcElement(e);if(src.className==className)return src;while(src&&src.tagName.toLowerCase()!='html'){src=src.parentNode;if(src.className==className)return src}
return false},getObjectByAttribute:function(e,attribute){var src=this.getSrcElement(e);var att=src.getAttribute(attribute);if(!att)att=src[attribute];if(att)return src;while(src&&src.tagName.toLowerCase()!='html'){src=src.parentNode;var att=src.getAttribute('attribute');if(!att)att=src[attribute];if(att)return src}
return false},getUniqueId:function(){var no=Math.random()+'';no=no.replace('.','');var no2=Math.random()+'';no2=no2.replace('.','');return no+no2},getAssociativeArrayFromString:function(propertyString){if(!propertyString)return;var retArray=new Array();var items=propertyString.split(/,/g);for(var no=0;no<items.length;no++){var tokens=items[no].split(/:/);retArray[tokens[0]]=tokens[1]}
return retArray},correctPng:function(el){el=DHTMLSuite.commonObj.getEl(el);var img=el;var width=img.width;var height=img.height;var html='<span style="display:inline-block;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\''+img.src+'\',sizingMethod=\'scale\');width:'+width+';height:'+height+'"></span>';img.outerHTML=html},__evaluateJs:function(obj){obj=this.getEl(obj);var scriptTags=obj.getElementsByTagName('SCRIPT');var string='';var jsCode='';for(var no=0;no<scriptTags.length;no++){if(scriptTags[no].src){var head=document.getElementsByTagName("head")[0];var scriptObj=document.createElement("script");scriptObj.setAttribute("type","text/javascript");scriptObj.setAttribute("src",scriptTags[no].src)}else{if(DHTMLSuite.clientInfoObj.isOpera){jsCode=jsCode+scriptTags[no].text+'\n'}
else
jsCode=jsCode+scriptTags[no].innerHTML}}
if(jsCode)this.__installScript(jsCode)},__installScript:function(script){try{if(!script)
return;if(window.execScript){window.execScript(script)
}else if(window.jQuery&&jQuery.browser.safari){window.setTimeout(script,0)}else{window.setTimeout(script,0)}}catch(e){}},__evaluateCss:function(obj){obj=this.getEl(obj);var cssTags=obj.getElementsByTagName('STYLE');var head=document.getElementsByTagName('HEAD')[0];for(var no=0;no<cssTags.length;no++){head.appendChild(cssTags[no])}}}
DHTMLSuite.clientInfo=function(){var browser;var isOpera;var isMSIE;var isOldMSIE;var isFirefox;var navigatorVersion;var isOldMSIE}
DHTMLSuite.clientInfo.prototype={init:function(){this.browser=navigator.userAgent;this.isOpera=(this.browser.toLowerCase().indexOf('opera')>=0)?true:false;this.isFirefox=(this.browser.toLowerCase().indexOf('firefox')>=0)?true:false;this.isMSIE=(this.browser.toLowerCase().indexOf('msie')>=0)?true:false;this.isOldMSIE=(this.browser.toLowerCase().match(/msie\s[0-6]/gi))?true:false;this.isSafari=(this.browser.toLowerCase().indexOf('safari')>=0)?true:false;this.navigatorVersion=navigator.appVersion.replace(/.*?MSIE\s(\d\.\d).*/g,'$1')/1;this.isOldMSIE=(this.isMSIE&&this.navigatorVersion<7)?true:false},getBrowserWidth:function(){if(self.innerWidth)return self.innerWidth;return document.documentElement.offsetWidth},getBrowserHeight:function(){if(self.innerHeight)return self.innerHeight;return document.documentElement.offsetHeight}}
DHTMLSuite.domQuery=function(){document.getElementsByClassName=this.getElementsByClassName;document.getElementsByAttribute=this.getElementsByAttribute}
DHTMLSuite.domQuery.prototype={}