package kr.co.nis.waf.system.biz.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.BoardService;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/widgetContents")
public class WidgetContentsController extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Value("#{appenv['app.system.version']}")
	private String systemVersion;
	
	@Resource
	private BoardService boardService;
	
	@Resource
	private SimpleService simpleService;

	@RequestMapping("/notice")
	public ModelAndView notice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		HashMap params = new HashMap();

		bind(request, params);
		
		params.put("displayNum", "10");
		if(params.get("selectPageNum")==null) {
			params.put("selectPageNum", "1");
		}
		if(params.get("startGroupPage")==null) {
			params.put("startGroupPage", "1");
		}
		if(params.get("endGroupPage")==null) {
			params.put("endGroupPage", "10");
		}
		params.put("boardID", "000001");
		
		List list = null;
		list = simpleService.queryForList("CMP04002A01S", params);
		
		List pageList = null;
		pageList = simpleService.queryForList("CMP04002A02S", params);
		
     	StringBuffer html = new StringBuffer();
     	html.append("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'> \n");
     	html.append("<html> \n");
     	html.append("<head> \n");
     	html.append("<title></title> \n");
     	html.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'> \n");
     	html.append("<script type='text/javascript' src='"+request.getContextPath()+"/scripts/jquery/jquery-1.8.2.min.js'></script> \n");
     	html.append("<link rel='stylesheet' href='"+request.getContextPath()+session.getThemeURL()+"/theme.css' type='text/css'> \n");
     	html.append("<script type='text/javascript' src='"+request.getContextPath()+"/scripts/aw/runtime/lib/aw.js' ></script> \n");
     	html.append("<script type='text/javascript' src='"+request.getContextPath()+"/scripts/baseScript.js' ></script> \n");
     	html.append("<style type='text/css'> \n");
     	html.append("<!-- \n");
     	html.append("body { \n");
     	html.append("	margin-left: 3px; \n");
     	html.append("	margin-top: 3px; \n");
     	html.append("	margin-right: 0px; \n");
     	html.append("	margin-bottom: 0px; \n");
     	html.append("} \n");
     	html.append(" td { font-family:\"맑은 고딕\",gulim,dotum,arial; font-size:12px; color:#555; } \n");
     	html.append(" a {text-decoration:none; color:#666;} \n");
		html.append(" a:hover, a:active, a:focus {color:#999999; text-decoration:none;} \n");
		html.append(" a:focus, input:focus, button:focus, textarea:focus {outline:1px dotted #dddddd;} \n");
     	html.append("--> \n");
     	html.append("</style> \n");
     	html.append("</head> \n");
     	html.append("<body> \n");
     	html.append("<form name='form' method='post'> \n");
     	html.append(" <div id='news' style='width:100%; height:100%;'> \n");
     	html.append("   <table border='0' cellspacing='0' cellpadding='0' width='100%' height='100%' > \n");
	    html.append("     <tr><td height='*' valign='top'> \n");
	    html.append("        <table width='100%' border='0' cellspacing='0' cellpadding='0' style='table-layout:fixed;'> \n");
	    html.append(" 	        <colgroup> \n");
	    html.append(" 	            <col style='width:60px'></col> \n");
	    html.append(" 	            <col></col> \n");
	    html.append(" 	            <col style='width:80px'></col> \n");
	    html.append(" 	            <col style='width:90px'></col> \n");
	    html.append(" 	        </colgroup> \n");
	    html.append(" 	        <tbody> \n");
	    html.append(" 	        <tr> \n");
	    html.append(" 		      <td colspan='3' style='border-top:#d8d8e4 solid 1px;'></td> \n");
	    html.append(" 	        </tr> \n");
	     
	    int count = 0;
	    count = list.size();
	    if(count>0) {
	    	for (int i=0; i < count; i++) {
	    		Map map = (Map)list.get(i);
	    		html.append(" 			<tr> \n");
	    		html.append(" 			  <td class='main_news' style='overflow:hidden; white-space:nowrap; text-overflow:ellipsis;'> \n");
	    		html.append("              		<img src='"+request.getContextPath()+session.getThemeURL()+"/images/main/board_point.gif' hspace='3' style='vertical-align:middle;'> \n");
	    		html.append("                   	"+map.get("noName").toString()+" \n");
	    		html.append("			   </td> \n");
	    		html.append(" 			  <td class='main_news'> \n");
	    		html.append("              		<a class='main_link' href=\"javascript:popupNotice('"+map.get("articleID").toString()+"');\" title='"+map.get("title").toString()+"'> \n");
	    		html.append("              		<script type=\"text/javascript\">document.write(cutStr('"+map.get("title").toString()+"', 25));</script></a> \n");
	    		if (map.get("chk_new").toString().equals("NEW")) {
					html.append("<img src='"+request.getContextPath()+session.getThemeURL()+"/images/main/icon_new.gif' width='22' height='11' hspace='5'>");
				}
				if (map.get("hotYN").toString().equals("Y")) {
					html.append("<img src='"+request.getContextPath()+session.getThemeURL()+"/images/main/hot.gif' width='22' height='11' hspace='5'>");
				}
				html.append(" 			  </td> \n");
				html.append(" 			  <td class='main_news'>"+map.get("writerName").toString()+"</td> \n");
	    		html.append(" 			  <td class='main_news' style='text-align:center;'>"+map.get("regDate").toString()+"</td> \n");
	    		html.append(" 			</tr> \n");
	    	}
	    }
	    else {
	    	html.append(" 			<tr> \n");
	    	html.append(" 			  <td colspan='4' class='main_news' style='overflow:hidden; white-space:nowrap; text-overflow:ellipsis;'> \n");
	    	html.append(" 			    	<img src='"+request.getContextPath()+session.getThemeURL()+"/images/main/board_point.gif' hspace='3' style='vertical-align:middle;'>데이터가 없습니다 \n");
	    	html.append(" 			  </td> \n");
	    	html.append(" 			</tr> \n");
	    }
	    html.append(" 	    </tbody> \n");
	    html.append(" 		</table></td> \n");
	    html.append(" 	  </tr> \n");
	    if(pageList.size()>0) {
	    	html.append(" 	  <tr><td colspan='3' style='text-align:center;'> \n");
	    	for (int i=0; i < pageList.size(); i++) {
	    		Map map = (Map)pageList.get(i);
	    		if(i==0) {
	    			 html.append(" <a href=\"javascript:page_left('"+map.get("pageNum").toString()+"');\" >&lt;</a> \n");
	    		}
	    		if(map.get("pageNum").toString().equals(params.get("selectPageNum"))) {
	    			html.append(" <strong>"+map.get("pageNum").toString()+"</strong> \n");
	    		}
	    		else {
	    			html.append(" <a href=\"javascript:page_move('"+map.get("pageNum").toString()+"');\">"+map.get("pageNum").toString()+"</a> \n");
	    		}
	    		if(i==pageList.size()-1) {
	    			html.append(" <a href=\"javascript:page_right('"+map.get("pageNum").toString()+"');\" >&gt;</a> \n");
	    		}
	    	}
	    	html.append(" 	  </td></tr> \n");
	    }
	    html.append(" 	</table> \n");
	    html.append(" </div> \n");
	    
		html.append(" <div> \n");
		html.append(" <input type=\"hidden\" id=\"displayNum\" name=\"displayNum\" value=\""+params.get("displayNum")+"\"/> \n");
		html.append(" <input type=\"hidden\" id=\"startGroupPage\" name=\"startGroupPage\" value=\""+params.get("startGroupPage")+"\"/> \n");
		html.append(" <input type=\"hidden\" id=\"endGroupPage\" name=\"endGroupPage\"value=\""+params.get("endGroupPage")+"\" /> \n");
		html.append(" <input type=\"hidden\" id=\"selectPageNum\" name=\"selectPageNum\"value=\""+params.get("selectPageNum")+"\" /> \n");
		html.append(" </div> \n");
		
	    html.append(" </form></body></html> \n");
	    html.append(" <script type='text/javascript'> \n");
	    html.append(" 	function popupNotice(articleID) { \n");
	    html.append(" 		winprops = 'height=500,width=1000,scrollbars=yes,resizable=yes'; \n");
	    html.append(" 		win = window.open('"+request.getContextPath()+"/service/board/viewArticle/?mnuGrpID=ETC&pgmID=CMP02001&viewID=CMP02001C&mainPopup=Y&boardID=000001&articleID='+articleID, 'popupNotice', winprops); \n");
	    html.append(" 	} \n");
	    html.append("	function page_left(pageNum) { \n");
	    html.append("		if(pageNum!=1) { \n");
	    html.append("			$(\"#startGroupPage\").val(parseInt($(\"#startGroupPage\").val())-10); \n");
	    html.append("			$(\"#endGroupPage\").val(parseInt($(\"#endGroupPage\").val())-10); \n");
	    html.append("			$(\"#selectPageNum\").val($(\"#startGroupPage\").val()); \n");
	    html.append("			Search(); \n");
	    html.append("		} \n");
	    html.append("	} \n");
	    html.append("	 \n");
	    html.append("	function page_right(pageNum) { \n");
	    html.append("		if(parseInt(pageNum)%10==0) { \n");
	    html.append("			$(\"#startGroupPage\").val(parseInt($(\"#startGroupPage\").val())+10); \n");
	    html.append("			$(\"#endGroupPage\").val(parseInt($(\"#endGroupPage\").val())+10); \n");
	    html.append("			$(\"#selectPageNum\").val($(\"#startGroupPage\").val()); \n");
	    html.append("			Search(); \n");
	    html.append("		} \n");
	    html.append("	} \n");
	    html.append("	 \n");
	    html.append("	function page_move(pageNum) { \n");
	    html.append("		$(\"#selectPageNum\").val(pageNum); \n");
	    html.append("		Search(); \n");
	    html.append("	} \n");
	    html.append("	function Search() { \n");
	    html.append("		form.action = \""+request.getContextPath()+"/service/widgetContents/notice\"; \n");
	    html.append("		form.target = \"_self\"; \n");
	    html.append("		form.submit(); \n");
	    html.append("	} \n");
	    html.append(" </script> \n");
	    
		ModelAndView mv = new ModelAndView("simpleHtmlView");
		mv.addObject("html", html.toString());
		return mv;
	}
	
	@RequestMapping("/reference")
	public ModelAndView reference(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		HashMap params = new HashMap();

		bind(request, params);
		
		params.put("displayNum", "10");
		if(params.get("selectPageNum")==null) {
			params.put("selectPageNum", "1");
		}
		if(params.get("startGroupPage")==null) {
			params.put("startGroupPage", "1");
		}
		if(params.get("endGroupPage")==null) {
			params.put("endGroupPage", "10");
		}
		params.put("boardID", "000005");
		
		List list = null;
		list = simpleService.queryForList("CMP04002A01S", params);
		
		List pageList = null;
		pageList = simpleService.queryForList("CMP04002A02S", params);
		
     	StringBuffer html = new StringBuffer();
     	html.append("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'> \n");
     	html.append("<html> \n");
     	html.append("<head> \n");
     	html.append("<title></title> \n");
     	html.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'> \n");
     	html.append("<script type='text/javascript' src='"+request.getContextPath()+"/scripts/jquery/jquery-1.8.2.min.js'></script> \n");
     	html.append("<link rel='stylesheet' href='"+request.getContextPath()+session.getThemeURL()+"/theme.css' type='text/css'> \n");
     	html.append("<script type='text/javascript' src='"+request.getContextPath()+"/scripts/aw/runtime/lib/aw.js' ></script> \n");
     	html.append("<script type='text/javascript' src='"+request.getContextPath()+"/scripts/baseScript.js' ></script> \n");
     	html.append("<style type='text/css'> \n");
     	html.append("<!-- \n");
     	html.append("body { \n");
     	html.append("	margin-left: 3px; \n");
     	html.append("	margin-top: 3px; \n");
     	html.append("	margin-right: 0px; \n");
     	html.append("	margin-bottom: 0px; \n");
     	html.append("} \n");
     	html.append(" td { font-family:\"맑은 고딕\",gulim,dotum,arial; font-size:12px; color:#555; } \n");
     	html.append(" a {text-decoration:none; color:#666;} \n");
		html.append(" a:hover, a:active, a:focus {color:#999999; text-decoration:none;} \n");
		html.append(" a:focus, input:focus, button:focus, textarea:focus {outline:1px dotted #dddddd;} \n");
     	html.append("--> \n");
     	html.append("</style> \n");
     	html.append("</head> \n");
     	html.append("<body> \n");
     	html.append("<form name='form' method='post'> \n");
     	html.append(" <div id='news' style='width:100%; height:100%;'> \n");
     	html.append("   <table border='0' cellspacing='0' cellpadding='0' width='100%' height='100%' > \n");
	    html.append("     <tr><td height='*' valign='top'> \n");
	    html.append("        <table width='100%' border='0' cellspacing='0' cellpadding='0' style='table-layout:fixed;'> \n");
	    html.append(" 	        <colgroup> \n");
	    html.append(" 	            <col style='width:60px'></col> \n");
	    html.append(" 	            <col></col> \n");
	    html.append(" 	            <col style='width:80px'></col> \n");
	    html.append(" 	            <col style='width:90px'></col> \n");
	    html.append(" 	        </colgroup> \n");
	    html.append(" 	        <tbody> \n");
	    html.append(" 	        <tr> \n");
	    html.append(" 		      <td colspan='3' style='border-top:#d8d8e4 solid 1px;'></td> \n");
	    html.append(" 	        </tr> \n");
	     
	    int count = 0;
	    count = list.size();
	    if(count>0) {
	    	for (int i=0; i < count; i++) {
	    		Map map = (Map)list.get(i);
	    		html.append(" 			<tr> \n");
	    		html.append(" 			  <td class='main_news' style='overflow:hidden; white-space:nowrap; text-overflow:ellipsis;'> \n");
	    		html.append("              		<img src='"+request.getContextPath()+session.getThemeURL()+"/images/main/board_point.gif' hspace='3' style='vertical-align:middle;'> \n");
	    		html.append("                   	"+map.get("noName").toString()+" \n");
	    		html.append("			   </td> \n");
	    		html.append(" 			  <td class='main_news'> \n");
	    		html.append("              		<a class='main_link' href=\"javascript:popupNotice('"+map.get("articleID").toString()+"');\" title='"+map.get("title").toString()+"'> \n");
	    		html.append("              		<script type=\"text/javascript\">document.write(cutStr('"+map.get("title").toString()+"', 25));</script></a> \n");
	    		if (map.get("chk_new").toString().equals("NEW")) {
					html.append("<img src='"+request.getContextPath()+session.getThemeURL()+"/images/main/icon_new.gif' width='22' height='11' hspace='5'>");
				}
				if (map.get("hotYN").toString().equals("Y")) {
					html.append("<img src='"+request.getContextPath()+session.getThemeURL()+"/images/main/hot.gif' width='22' height='11' hspace='5'>");
				}
				html.append(" 			  </td> \n");
				html.append(" 			  <td class='main_news'>"+map.get("writerName").toString()+"</td> \n");
	    		html.append(" 			  <td class='main_news' style='text-align:center;'>"+map.get("regDate").toString()+"</td> \n");
	    		html.append(" 			</tr> \n");
	    	}
	    }
	    else {
	    	html.append(" 			<tr> \n");
	    	html.append(" 			  <td colspan='4' class='main_news' style='overflow:hidden; white-space:nowrap; text-overflow:ellipsis;'> \n");
	    	html.append(" 			    	<img src='"+request.getContextPath()+session.getThemeURL()+"/images/main/board_point.gif' hspace='3' style='vertical-align:middle;'>데이터가 없습니다 \n");
	    	html.append(" 			  </td> \n");
	    	html.append(" 			</tr> \n");
	    }
	    html.append(" 	    </tbody> \n");
	    html.append(" 		</table></td> \n");
	    html.append(" 	  </tr> \n");
	    if(pageList.size()>0) {
	    	html.append(" 	  <tr><td colspan='3' style='text-align:center;'> \n");
	    	for (int i=0; i < pageList.size(); i++) {
	    		Map map = (Map)pageList.get(i);
	    		if(i==0) {
	    			 html.append(" <a href=\"javascript:page_left('"+map.get("pageNum").toString()+"');\" >&lt;</a> \n");
	    		}
	    		if(map.get("pageNum").toString().equals(params.get("selectPageNum"))) {
	    			html.append(" <strong>"+map.get("pageNum").toString()+"</strong> \n");
	    		}
	    		else {
	    			html.append(" <a href=\"javascript:page_move('"+map.get("pageNum").toString()+"');\">"+map.get("pageNum").toString()+"</a> \n");
	    		}
	    		if(i==pageList.size()-1) {
	    			html.append(" <a href=\"javascript:page_right('"+map.get("pageNum").toString()+"');\" >&gt;</a> \n");
	    		}
	    	}
	    	html.append(" 	  </td></tr> \n");
	    }
	    html.append(" 	</table> \n");
	    html.append(" </div> \n");
	    
		html.append(" <div> \n");
		html.append(" <input type=\"hidden\" id=\"displayNum\" name=\"displayNum\" value=\""+params.get("displayNum")+"\"/> \n");
		html.append(" <input type=\"hidden\" id=\"startGroupPage\" name=\"startGroupPage\" value=\""+params.get("startGroupPage")+"\"/> \n");
		html.append(" <input type=\"hidden\" id=\"endGroupPage\" name=\"endGroupPage\"value=\""+params.get("endGroupPage")+"\" /> \n");
		html.append(" <input type=\"hidden\" id=\"selectPageNum\" name=\"selectPageNum\"value=\""+params.get("selectPageNum")+"\" /> \n");
		html.append(" </div> \n");
		
	    html.append(" </form></body></html> \n");
	    html.append(" <script type='text/javascript'> \n");
	    html.append(" 	function popupNotice(articleID) { \n");
	    html.append(" 		winprops = 'height=500,width=1000,scrollbars=yes,resizable=yes'; \n");
	    html.append(" 		win = window.open('"+request.getContextPath()+"/service/board/viewArticle/?mnuGrpID=ETC&pgmID=CMP02001&viewID=CMP02001C&mainPopup=Y&boardID=000005&articleID='+articleID, 'popupNotice', winprops); \n");
	    html.append(" 	} \n");
	    html.append("	function page_left(pageNum) { \n");
	    html.append("		if(pageNum!=1) { \n");
	    html.append("			$(\"#startGroupPage\").val(parseInt($(\"#startGroupPage\").val())-10); \n");
	    html.append("			$(\"#endGroupPage\").val(parseInt($(\"#endGroupPage\").val())-10); \n");
	    html.append("			$(\"#selectPageNum\").val($(\"#startGroupPage\").val()); \n");
	    html.append("			Search(); \n");
	    html.append("		} \n");
	    html.append("	} \n");
	    html.append("	 \n");
	    html.append("	function page_right(pageNum) { \n");
	    html.append("		if(parseInt(pageNum)%10==0) { \n");
	    html.append("			$(\"#startGroupPage\").val(parseInt($(\"#startGroupPage\").val())+10); \n");
	    html.append("			$(\"#endGroupPage\").val(parseInt($(\"#endGroupPage\").val())+10); \n");
	    html.append("			$(\"#selectPageNum\").val($(\"#startGroupPage\").val()); \n");
	    html.append("			Search(); \n");
	    html.append("		} \n");
	    html.append("	} \n");
	    html.append("	 \n");
	    html.append("	function page_move(pageNum) { \n");
	    html.append("		$(\"#selectPageNum\").val(pageNum); \n");
	    html.append("		Search(); \n");
	    html.append("	} \n");
	    html.append("	function Search() { \n");
	    html.append("		form.action = \""+request.getContextPath()+"/service/widgetContents/notice\"; \n");
	    html.append("		form.target = \"_self\"; \n");
	    html.append("		form.submit(); \n");
	    html.append("	} \n");
	    html.append(" </script> \n");
	    
		ModelAndView mv = new ModelAndView("simpleHtmlView");
		mv.addObject("html", html.toString());
		return mv;
	}
	
}