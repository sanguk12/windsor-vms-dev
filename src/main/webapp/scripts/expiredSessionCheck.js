var expiredSessionCheckObj = new expiredSessionCheck()

function expiredSessionCheck(){
	this.checkSession = function(){
		try {
			top.InitSessionTimer();
		} 
		catch(e){}		
	}
	
	this.setDocCapture = function() {
		if (document.layers)
   			document.captureEvents(Event.CLICK);
		document.onclick = this.checkSession;
	}
	this.releaseDocCapture = function () {
		if (document.layers)
	   		document.releaseEvents(Event.CLICK);
	   	document.onclick = function() {};
	}
}

expiredSessionCheckObj.setDocCapture();