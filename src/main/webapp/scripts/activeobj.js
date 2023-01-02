function WriteObjElement(element_id)
{
	if(navigator.userAgent.indexOf("MSIE 3") != -1 ||
		navigator.userAgent.indexOf("MSIE 4") != -1 ||
		navigator.userAgent.indexOf("MSIE 5") != -1 ||
		navigator.userAgent.indexOf("MSIE 6") != -1 ||
		navigator.userAgent.indexOf("MSIE 7") != -1 )

		document.write(element_id.innerHTML);
}
