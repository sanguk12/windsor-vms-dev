var myObjectElement = document.createElement('<object id="'+flash_id+'" name="'+flash_id+'" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="'+flash_width+'" height="'+flash_height+'"></object>');
var myParamElement1 = document.createElement('<Param name=movie value="'+flash_url+'">');  
var myParamElement2 = document.createElement('<Param name=quality value=high>');
var myParamElement3 = document.createElement('<Param name=menu value=false>');
var myParamElement4 = document.createElement('<Param name=scale value=noscale>');
var myParamElement5 = document.createElement('<Param name=salign value=left>');
var myParamElement6 = document.createElement('<param name=allowScriptAccess value=always>');
var myParamElement7 = document.createElement('<Param name=wmode value=transparent>');

myObjectElement.appendChild(myParamElement1);
myObjectElement.appendChild(myParamElement2);
myObjectElement.appendChild(myParamElement3);
myObjectElement.appendChild(myParamElement4);
myObjectElement.appendChild(myParamElement5);
myObjectElement.appendChild(myParamElement6);
myObjectElement.appendChild(myParamElement7);

myObjectLocation = eval("embedControlLocation"+flash_location_id);
myObjectLocation.appendChild(myObjectElement);