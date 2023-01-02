<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf8"%>
<%@include file="../taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <%@include file="../scripts.jsp" %>
        <%@include file="../cms/calendar.jsp" %>
	</head>

    <body style="margin:0;background-color:transparent">
    </body>
</html>

<script type="text/javascript">

	// 우에서 좌로 스크롤되며 마우스가 가면 멈춥니다.(연속버전)
	var sliderwidth="380px"  // 슬라이드 가로 크기
	var sliderheight="20px" // 슬라이드 세로 크기
	var slidespeed=1   // 속도 숫자가 클수록 빨라집니다.
	slidebgcolor=""  // 슬라이드 배경색

	
  	var leftrightslide;
	var finalslide='';
	
	searchNewsTicker();	
 
	/////// 아래는 수정할 내용이 없습니다. ///////////////////////
 
	var copyspeed=slidespeed;
	leftrightslide='<nobr>'+leftrightslide.join(" ")+'</nobr>';
	var iedom=document.all||document.getElementById;
	if (iedom)
		document.write('<span id="temp" style="visibility:hidden;position:absolute;top:-100px;left:-9000px">'+leftrightslide+'</span>');
	var actualwidth='';
	var cross_slide, ns_slide;

	function searchNewsTicker(){

		leftrightslide=new Array();
		
		var table = new AW.XML.Table;
	  	table.setURL("${contextPath}/service/simpleAction/CMP0101301S");
	  	table.setAsync(false);
	  	table.setRequestMethod("POST");
	    
	    table.setParameter("currentDate", convertDate("${params.currentDate}"));
	  	table.request();

	  	var rowCount = table.getCount();
	  	if (rowCount > 0) {
	  		for (var i=0; i < rowCount; i++) {
	  	  		j = i*2;
	  	  		if(table.getData(1,i) == "")
	  				leftrightslide[j] = table.getData(0,i);
	  	  		else
	  	  			leftrightslide[j] = '<a href='+table.getData(1,i)+' class="main_link" target="_blank">'+table.getData(0,i)+'</a>';
	  			leftrightslide[j+1] = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
	  		}
	  	}
	}

	function fillup(){
		if (iedom){
			cross_slide=document.getElementById? document.getElementById("test2") : document.all.test2;
			cross_slide2=document.getElementById? document.getElementById("test3") : document.all.test3;
			cross_slide.innerHTML=cross_slide2.innerHTML=leftrightslide;
			actualwidth=document.all? cross_slide.offsetWidth : document.getElementById("temp").offsetWidth;
			cross_slide2.style.left=actualwidth+200+"px";
		}
		else if (document.layers){
			ns_slide=document.ns_slidemenu.document.ns_slidemenu2;
			ns_slide2=document.ns_slidemenu.document.ns_slidemenu3;
			ns_slide.document.write(leftrightslide);
			ns_slide.document.close();
			actualwidth=ns_slide.document.width;
			ns_slide2.left=actualwidth+200;
			ns_slide2.document.write(leftrightslide);
			ns_slide2.document.close();
		}
		lefttime=setInterval("slideleft()",30);
	}
	window.onload=fillup;
 
	function slideleft(){
		if (iedom){
			if (parseInt(cross_slide.style.left)>(actualwidth*(-1)+8))
				cross_slide.style.left=parseInt(cross_slide.style.left)-copyspeed+"px";
			else
				cross_slide.style.left=parseInt(cross_slide2.style.left)+actualwidth+200+"px";
 
		if (parseInt(cross_slide2.style.left)>(actualwidth*(-1)+8))
			cross_slide2.style.left=parseInt(cross_slide2.style.left)-copyspeed+"px";
		else
			cross_slide2.style.left=parseInt(cross_slide.style.left)+actualwidth+200+"px";
		}
		else if (document.layers){
			if (ns_slide.left>(actualwidth*(-1)+8))
				ns_slide.left-=copyspeed;
			else
				ns_slide.left=ns_slide2.left+actualwidth+200;
 
			if (ns_slide2.left>(actualwidth*(-1)+8))
				ns_slide2.left-=copyspeed;
			else
				ns_slide2.left=ns_slide.left+actualwidth+200;
		}
	}


	if (iedom||document.layers){
		with (document){
			document.write('<table border="0" cellspacing="0" cellpadding="0"><td>');
			if (iedom){
				write('<div style="position:relative;width:'+sliderwidth+';height:'+sliderheight+';overflow:hidden">')
				write('<div style="position:absolute;width:'+sliderwidth+';height:'+sliderheight+';background-color:'+slidebgcolor+'" onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed">')
				write('<div id="test2" style="position:absolute;left:0px;top:0px"></div>')
				write('<div id="test3" style="position:absolute;left:-1000px;top:0px"></div>')
				write('</div></div>')
			}
			else if (document.layers){
				write('<ilayer width='+sliderwidth+' height='+sliderheight+' name="ns_slidemenu" bgColor='+slidebgcolor+'>')
				write('<layer name="ns_slidemenu2" left=0 top=0 onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed"></layer>')
				write('<layer name="ns_slidemenu3" left=0 top=0 onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed"></layer>')
				write('</ilayer>')
			}
			document.write('</td></table>')
		}
	}

	 
</script>

<script type="text/javascript">
	/**
	* NewsTicker Refresh
	*/
	/*
	var interval;
	var timerID = null;
	var timerRunning = false;
	var delay = 1000;
	
	function InitNewsTickerTimer(){
	    // Set the length of the timer, in seconds
	    interval = 600;
	    StopNewsTickerTimer();
	    StartNewsTickerTimer();
	}
	
	function StopNewsTickerTimer(){
	    if(timerRunning)
	        clearTimeout(timerID);
	    timerRunning = false;
	}
	
	function StartNewsTickerTimer(){
	    if (interval==0){
	        StopNewsTickerTimer();
	        document.location.href="simpleCommand.do?mnuGrpID=091&pgmID=COM04003&viewID=COM04003B";
	    }
	    else{
	    	interval = interval - 1;
	        timerRunning = true;
	        timerID = self.setTimeout("StartNewsTickerTimer()", delay);
	    }
	}
	
	InitNewsTickerTimer();
	*/
</script>
