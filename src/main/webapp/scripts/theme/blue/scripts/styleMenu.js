fixMozillaZIndex=true; //Fixes Z-Index problem  with Mozilla browsers but causes odd scrolling problem, toggle to see if it helps
_menuCloseDelay=500;
_menuOpenDelay=150;
_subOffsetTop=2;
_subOffsetLeft=-2;
_menuTop=50;
_menuLeft=180;


/// Menu Header Style Definitions ///
with(menuStyle=new mm_style()){
bordercolor="#999999";
borderstyle="solid";
borderwidth=0;
fontfamily="arial, tahoma";
fontsize="8pt";
fontstyle="normal";
headerbgcolor="#AFD1B5";
headerborder=1;
headercolor="#000099";
offbgcolor="#f6f6f6";
menubgimage="/scripts/theme/VISTA/images/menu/bg_gray.png";
bgimage="/scripts/theme/VISTA/images/menu/bg_gray.png";
offcolor="#000000";
onbgcolor="#FEFAD2";
onborder="1px solid #cfcfcf";
oncolor="#000000";
onsubimage="/scripts/theme/VISTA/images/menu/on_downboxed.gif";
overbgimage="/scripts/theme/VISTA/images/menu/backon_beige.gif";
padding=3;
pagebgcolor="#CFE2D1";
pagecolor="#000066";
pageimage="/scripts/theme/VISTA/images/menu/db_red.gif";
separatoralign="right";
separatorcolor="#999999";
separatorwidth="85%";
subimage="/scripts/theme/VISTA/images/menu/downboxed.gif";
}

/// Menu Body Style Definitions ///
//offbgcolor=#5871B3, onbgcolor=#DC9B5B, pagebgcolor=#82B6D7
with(submenuStyle=new mm_style()){
styleid=1;
bordercolor="#cfcfcf";
borderstyle="solid";
borderwidth=1;
fontfamily="arial, tahoma";
fontsize="8pt";
fontstyle="normal";
headerbgcolor="#AFD1B5";
headerborder=1;
headercolor="#000099";
image="/scripts/theme/VISTA/images/menu/18_blank.gif";
imagepadding=3;
menubgimage="/scripts/theme/VISTA/images/menu/backoff_gray.gif";
offbgcolor="transparent";
offcolor="#000000";
onbgcolor="#FEFAD2";
onborder="1px solid #999999";
oncolor="#000000";
onsubimage="/scripts/theme/VISTA/images/menu/on_13x13_greyboxed.gif";
outfilter="randomdissolve(duration=0.2)";
overfilter="Fade(duration=0.1);Alpha(opacity=95);Shadow(color=#777777', Direction=135, Strength=3)";
padding=3;
pagebgcolor="#CFE2D1";
pagecolor="#000066";
pageimage="/scripts/theme/VISTA/images/menu/db_red.gif";
separatoralign="right";
separatorcolor="#999999";
separatorpadding=1;
separatorwidth="85%";
subimage="/scripts/theme/VISTA/images/menu/black_13x13_greyboxed.gif";
menubgcolor="#F5F5F5";
closeonclick=1
}
