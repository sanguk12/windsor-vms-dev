
YAHOO.namespace("example.container");

function showLoading() {

    if (!YAHOO.example.container.wait) {

        YAHOO.example.container.wait = 
                new YAHOO.widget.Panel("wait",  
                                                { width: "240px", 
                                                  fixedcenter: true, 
                                                  close: false, 
                                                  draggable: false, 
                                                  zindex:4,
                                                  modal: true,
                                                  visible: false
                                                } 
                                            );

        YAHOO.example.container.wait.setHeader("Loading, please wait...");
        YAHOO.example.container.wait.setBody("<img src=\""+_contextPath+"/images/common/rel_interstitial_loading.gif\"/>");
        YAHOO.example.container.wait.render(document.body);
        

    }

    YAHOO.example.container.wait.show();
}

function hideLoading() {
    YAHOO.example.container.wait.hide();
}