package kr.co.nis.waf.system.biz.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Article;
import kr.co.nis.waf.system.biz.model.ArticleReadLog;
import kr.co.nis.waf.system.biz.model.ArticleReply;
import kr.co.nis.waf.system.biz.model.Board;
import kr.co.nis.waf.system.biz.model.BoardAuthorityList;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.BoardService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/board")
public class BoardController extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Value("#{system['board.pageSize']}")
	private int pageSize = 0;

	@Resource
	private BoardService boardService;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;

	
	@RequestMapping("/addArticle")
	public ModelAndView addArticle(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView mv = null;
		
		Article article = new Article();
		Board board = new Board();
		Map content = new HashMap();
		Map params = new HashMap();
		
		SessionManager session = new SessionManager(request, response);

		bind(request, content);
		bind(request, board);
		bind(request, article);
		
		//F_Board
		params = simpleService.queryForMap("CMP0101104S", content);

		params.put("writeUserID", session.getUserID());
		params.put("writeAuth", params.get("writeAuth"));
		params.put("isView", StringUtil.nullToBlank(params.get("isView"), ""));
		params.put("breakValue", "N");
		params.put("pagePerSuperPage", "10");
		params.put("boardTypeCD", params.get("boardTypeCD").toString());
		params.put("authYN", params.get("authYN").toString());
		
		content.putAll(params);		

		article.setBulletinTermCD(StringUtil.nullToBlank(article.getBulletinTermCD(), "9999"));
		article.setWriteIP(request.getRemoteAddr());
		article.setViewYN(StringUtil.nullToBlank(article.getViewYN(), "Y"));
		article.setTopYN(StringUtil.nullToBlank(article.getTopYN(), "N"));
		article.setHotYN(StringUtil.nullToBlank(article.getHotYN(), "N"));
		article.setActiveFlg("U");

		content.put("userID", session.getUserID());

		if (!content.containsKey("keyWord")) {
			content.put("keyWord", "");
		}

		int exist = 0;

		try {
			//F_Article
			simpleService.update("CMP0200102U", article);
			boardService.addArticle(article);
			content.put("writeUserID", session.getUserID());
			content.put("msg", getMessageSourceAccessor().getMessage("success.save"));

			if (!"40".equals(board.getBoardTypeCD())) {
				mv = new ModelAndView(super.getViewUrl(request));

				article.setRef(content.get("ref").toString());
				article.setBoardID(content.get("boardID").toString());
				List list = boardService.findArticle(content);

				if (list.isEmpty() || list == null) {
					exist = 0;
				}
				else {
					exist = 1;
				}
				content.put("exist", new Integer(exist));
				mv.addObject("articleList", list);
			}
			else {
				
				mv = new ModelAndView(super.getViewUrl(request));
				article.setRef("");
				content.put("writeUserID", session.getUserID());
				List list = boardService.findArticleView(content);
				if (list.isEmpty() || list == null) {
					exist = 0;
				}
				else {
					exist = 1;
				}
				content.put("exist", new Integer(exist));
				mv.addObject("articleViewList", list);
			}

		}
		catch (Exception e) {
			if (logger.isDebugEnabled())
			{
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mv = new ModelAndView("defaulterrormessage");
		}

		setObjectAll(mv, request, response, content);
		return mv;
	}
	
	@RequestMapping("/addArticleReply")
	public ModelAndView addArticleReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = null;
		Article article = new Article();
		ArticleReply articleReply = new ArticleReply();
		Map content = new HashMap();
		SessionManager session = new SessionManager(request, response);
		Code seqID = new Code();

		bind(request, article);
		bind(request, articleReply);
		bind(request, seqID);

		seqID.setSeqDiv("REPLYID");
		articleReply.setReplyID(codeService.getSeqID(seqID).get("seqID").toString());
		articleReply.setWriteUserID(session.getUserID());
		articleReply.setWriteIP(request.getRemoteAddr());
		articleReply.setActiveFlg("U");

		try {
			mv = new ModelAndView(super.getViewUrl(request));
			//F_ArticleReply
			simpleService.insert("CMP0200103I", articleReply);
			//F_Article
			content = simpleService.queryForMap("CMP0200104S", article);
			content.put("writeUserID", session.getUserID());

			article.setRef(content.get("ref").toString());
			mv.addObject("article", content);
			
			if ("Y".equals(content.get("isReply").toString())) {
				//F_ArticleReply
				mv.addObject("articleReplyList", simpleService.queryForList("CMP0200105S", article));
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			mv = new ModelAndView("defaulterrormessage");
		}

		bind(request, content);
		content.put("initAction", "Search");

		setObjectAll(mv, request, response, content);
		return mv;
	}

	@RequestMapping("/addArticleViewReply")
	public ModelAndView addArticleViewReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = null;
		Article article = new Article();
		ArticleReply articleReply = new ArticleReply();
		Map content = new HashMap();
		SessionManager session = new SessionManager(request, response);
		Code seqID = new Code();

		bind(request, article);
		bind(request, articleReply);
		bind(request, content);
		bind(request, seqID);

		seqID.setSeqDiv("REPLYID");
		articleReply.setReplyID(codeService.getSeqID(seqID).get("seqID").toString());
		articleReply.setWriteUserID(session.getUserID());
		articleReply.setWriteIP(request.getRemoteAddr());
		articleReply.setActiveFlg("U");

		try {
			mv = new ModelAndView(super.getViewUrl(request));
			//F_ArticleReply
			simpleService.insert("CMP0200103I", articleReply);
			mv.addObject("articleViewList", boardService.findArticleView(content));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			mv = new ModelAndView("defaulterrormessage");
		}
		setObjectAll(mv, request, response, content);
		return mv;
	}

	@RequestMapping("/editArticle")
	public ModelAndView editArticle(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView(super.getViewUrl(request));
		SessionManager session = new SessionManager(request, response);
		Article article = new Article();
		Map params = new HashMap();
		
		bind(request, article);
		bind(request, params);

		String strPublicId = "";
		String strPublicClassCd = "";
		String strPublicName = "";

		//F_ArticleAuthority
		List list = simpleService.queryForList("CMP0200106S", article);

		if (!list.isEmpty()) {
			for (int i = 0; i < list.size(); i++) {
				Map map = (Map) list.get(i);
				strPublicId = strPublicId + map.get("publicID") + ";";
				strPublicClassCd = strPublicClassCd + map.get("publicClassCD") + ";";
				strPublicName = strPublicName + map.get("publicName") + ";";
			}
		}
		
		params.put("userID", session.getUserID());
		//F_Board
		Map boardConfig = simpleService.queryForMap("CMP0101104S", params);
		params.putAll(boardConfig);

		//F_Article
		Map articleContent = simpleService.queryForMap("CMP0200104S", article);
		params.putAll(articleContent);
		
		params.put("publicID", strPublicId);
		params.put("publicClassCD", strPublicClassCd);
		params.put("publicName", strPublicName);
		params.put("saveType", "update");

		setObjectAll(mv, request, response, params);
		
		return mv;
	}

	@RequestMapping("/findArticleList")
	public ModelAndView findArticleList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView(super.getViewUrl(request));
		SessionManager session = new SessionManager(request, response);
		HashMap params = new HashMap();
		Article article = new Article();
		Board board = new Board();
		int exist = 0;

		bind(request, params);
		bind(request, article);
		bind(request, board);

		Map content = new HashMap();
		content = simpleService.queryForMap("CMP0101104S", params);

		params.put("writeUserID", session.getUserID());
		params.put("writeAuth", content.get("writeAuth"));
		params.put("isView", StringUtil.nullToBlank(content.get("isView"), ""));
		params.put("isPublic", StringUtil.nullToBlank(content.get("isPublic"), ""));
		params.put("breakValue", "N");
		params.put("pagePerSuperPage", "10");
		params.put("boardTypeCD", content.get("boardTypeCD").toString());
		params.put("authYN", content.get("authYN").toString());
		
		board.setBoardTypeCD(content.get("boardTypeCD").toString());

		if (!params.containsKey("keyWord")) {
			params.put("keyWord", "");
		}

		if (!"40".equals(board.getBoardTypeCD())) {
			List list = boardService.findArticle(params);

			if (list.isEmpty() || list == null) {
				exist = 0;
			}
			else {
				exist = 1;
			}
			params.put("exist", new Integer(exist));
			mv.addObject("articleList", list);
		}
		else {
			List list = boardService.findArticleView(params);
			if (list.isEmpty() || list == null) {
				exist = 0;
			}
			else {
				exist = 1;
			}
			params.put("exist", new Integer(exist));
			mv.addObject("articleViewList", list);
		}

		setObjectAll(mv, request, response, params);
		return mv;
	}

	@RequestMapping("/findMainPageBoard")
	public ModelAndView findMainPageBoard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		HashMap params = new HashMap();
		bind(request, params);
		Article article = new Article();
		int listCount = 12;

		bind(request, article);

		params.put("writeUserID", session.getUserID());
		params.put("userNm", session.getUserName());

		params.put("e_seq", new Integer(listCount));
		params.put("boardID", "000001");

		//F_Article
		List listNotice = simpleService.queryForList("CMP0200107S", params);
		ModelAndView mv = new ModelAndView("main");
		int exist = 0;

		params.put("exist", new Integer(exist));
		mv.addObject("listNotice", listNotice);

		setObjectAll(mv, request, response, params);
		return mv;
	}

	@RequestMapping("/getArticleCount")
	public ModelAndView getArticleCount(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView(super.getViewUrl(request));
		Map content = new HashMap();

		bind(request, content);

		//F_Article
		int listCount = simpleService.queryForInt("CMP0200108S", content);

		mv.addObject("recordCount", new Integer(listCount));

		return mv;
	}

	@RequestMapping("/modifyArticle")
	public ModelAndView modifyArticle(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView(this.getViewUrl(request));
		Article article = new Article();
		Board board = new Board();
		Map params = new HashMap();
		Map content = new HashMap();
		SessionManager session = new SessionManager(request, response);

		int exist = 0;

		bind(request, params);
		bind(request, article);
		bind(request, board);

		params.put("userID", session.getUserID());
		
		//F_Board
		content = simpleService.queryForMap("CMP0101104S", params);
		content.put("writeUserID", session.getUserID());
		content.put("writeAuth", content.get("writeAuth"));
		content.put("isView", StringUtil.nullToBlank(content.get("isView"), ""));
		content.put("breakValue", "N");
		content.put("pagePerSuperPage", "10");
		content.put("boardTypeCD", content.get("boardTypeCD").toString());
		content.put("authYN", content.get("authYN").toString());
		params.putAll(content);
		
		article.setBulletinTermCD(StringUtil.nullToBlank(article.getBulletinTermCD(), "9999"));
		article.setWriteIP(request.getRemoteAddr());
		article.setViewYN(StringUtil.nullToBlank(article.getViewYN(), "Y"));
		article.setTopYN(StringUtil.nullToBlank(article.getTopYN(), "N"));
		article.setHotYN(StringUtil.nullToBlank(article.getHotYN(), "N"));

		try {

			if ((session.getUserID()).equals(params.get("writeUserID").toString())) {
				boardService.modifyArticle(article);
			}
			else{
			}
			
			if (!"40".equals(board.getBoardTypeCD()))
			{
				params.put("boardID", article.getBoardID());
				params.put("msg", getMessageSourceAccessor().getMessage("success.update"));
				params.put("isView", board.getIsView());
				
				List list = boardService.findArticle(params);

				if (list.isEmpty() || list == null) {
					exist = 0;
				}
				else {
					exist = 1;
				}
				params.put("exist", new Integer(exist));
				mv.addObject("articleList", list);
			}
			else {
				params.put("writeUserID", session.getUserID());
				List list = boardService.findArticleView(params);
				if (list.isEmpty() || list == null) {
					exist = 0;
				}
				else {
					exist = 1;
				}
				params.put("exist", new Integer(exist));
				mv.addObject("articleViewList", list);
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			params.put("msg", getMessageSourceAccessor().getMessage("failure.save"));
			mv = new ModelAndView("defaulterrormessage");
		}

		setObjectAll(mv, request, response, params);
		return mv;
	}

	@RequestMapping("/modifyArticleRecommend")
	public ModelAndView modifyArticleRecommend(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = null;
		Article article = new Article();
		Map content = new HashMap();
		SessionManager session = new SessionManager(request, response);

		bind(request, article);
		bind(request, content);

		try {
			mv = new ModelAndView(super.getViewUrl(request));
			//F_Article
			simpleService.update("CMP0200109U", article);
			mv.addObject("articleViewList", boardService.findArticleView(content));

		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			mv = new ModelAndView("defaulterrormessage");
		}
		setObjectAll(mv, request, response, content);
		return mv;
	}

	@RequestMapping("/newArticle")
	public ModelAndView newArticle(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView(super.getViewUrl(request));
		Map content = new HashMap();
		Article article = new Article();
		Map params = new HashMap();
		Code seqID = new Code();
		
		SessionManager session = new SessionManager(request, response);
		
		bind(request, params);
		bind(request, article);

		article.setUserID(session.getUserID());
		params.put("userID", session.getUserID());
		
		//F_Board
		content = simpleService.queryForMap("CMP0101104S", params);
		bind(request, content);
		
		bind(request, seqID);
		
		seqID.setSeqDiv("ARTICLEID");
		String articleID = (String) codeService.getSeqID(seqID).get("seqID");
		content.put("articleID", articleID);
		content.put("boardID", article.getBoardID());
		content.put("writeUserID", session.getUserID());
		content.put("saveType", "insert");
		content.put("writeUserName", session.getUserName());
		content.put("writeDate", StringUtil.nowDate("yyyy-MM-dd"));
		
		if (request.getParameter("ref") != null) {
			content.put("ref", request.getParameter("ref"));
			content.put("refStep", new Integer(Integer.parseInt(request.getParameter("refStep")) + 1));
			content.put("refNo", new Integer(Integer.parseInt(request.getParameter("refNo")) + 1));
		}
		else {
			content.put("ref", articleID);
			content.put("refStep", "0");
			content.put("refNo", "0");
		}

		setObjectAll(mv, request, response, content);
		return mv;
	}

	@RequestMapping("/removeArticle")
	public ModelAndView removeArticle(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView(this.getViewUrl(request));
		Article article = new Article();
		Board board = new Board();
		Map params = new HashMap();
		Map content = new HashMap();
		
		SessionManager session = new SessionManager(request, response);

		bind(request, article);
		bind(request, board);
		bind(request, params);

		//F_Board
		content = simpleService.queryForMap("CMP0101104S", params);
		content.put("writeUserID", session.getUserID());
		content.put("writeAuth", content.get("writeAuth"));
		content.put("isView", StringUtil.nullToBlank(content.get("isView"), ""));
		content.put("breakValue", "N");
		content.put("pagePerSuperPage", "10");
		content.put("boardTypeCD", content.get("boardTypeCD").toString());
		content.put("authYN", content.get("authYN").toString());
		params.putAll(content);
		

		int exist = 0;
		try {
			if ((session.getUserID()).equals(request.getParameter("writeUserID"))) {
				//F_Article
				simpleService.update("CMP0200110U", article);
			}
			else {
				params.put("msg", getMessageSourceAccessor().getMessage("failure.auth"));
			}
			
			if (!"40".equals(board.getBoardTypeCD())) {
				
				List list = boardService.findArticle(params);

				if (list.isEmpty() || list == null) {
					exist = 0;
				}
				else {
					exist = 1;
				}
				params.put("exist", new Integer(exist));
				mv.addObject("articleList", list);
			}
			else {
				
				List list = boardService.findArticleView(params);
				if (list.isEmpty() || list == null) {
					exist = 0;
				}
				else {
					exist = 1;
				}
				params.put("exist", new Integer(exist));
				mv.addObject("articleViewList", list);
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			params.put("msg", getMessageSourceAccessor().getMessage("failure.delete"));
			mv = new ModelAndView("defaulterrormessage");
		}

		setObjectAll(mv, request, response, params);
		return mv;
	}

	@RequestMapping("/removeArticleReply")
	public ModelAndView removeArticleReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = null;
		Article article = new Article();
		ArticleReply articleReply = new ArticleReply();
		Map content = new HashMap();

		bind(request, article);
		bind(request, articleReply);

		try {
			articleReply.setActiveFlg("D");

			mv = new ModelAndView(super.getViewUrl(request));
			//F_ArticleReply
			simpleService.delete("CMP0200111U", articleReply);
			//F_Article
			content = simpleService.queryForMap("CMP0200104S", article);

			article.setRef(content.get("ref").toString());
			mv.addObject("article", content);
			
			if ("Y".equals(content.get("isReply").toString())) {
				//F_ArticleReply
				mv.addObject("articleReplyList", simpleService.queryForList("CMP0200105S", article));
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			mv = new ModelAndView("defaulterrormessage");
		}

		bind(request, content);

		setObjectAll(mv, request, response, content);
		return mv;
	}

	@RequestMapping("/removeArticleViewReply")
	public ModelAndView removeArticleViewReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = null;
		Article article = new Article();
		ArticleReply articleReply = new ArticleReply();
		Map content = new HashMap();

		bind(request, article);
		bind(request, articleReply);
		bind(request, content);

		try {
			articleReply.setActiveFlg("D");

			mv = new ModelAndView(super.getViewUrl(request));
			//F_ArticleReply
			simpleService.delete("CMP0200111U", articleReply);
			mv.addObject("articleViewList", boardService.findArticleView(content));

		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			mv = new ModelAndView("defaulterrormessage");
		}

		setObjectAll(mv, request, response, content);
		return mv;
	}

	@RequestMapping("/saveBoard")
	public ModelAndView saveBoard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Board board = new Board();
		BoardAuthorityList boardAuthorityList = new BoardAuthorityList();
		Code seqID = new Code();

		SessionManager sessionManager = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		
		bind(request, board);
		bind(request, boardAuthorityList);
		bind(request, seqID);

		try {
			board.validate();

			if (board.getBoardID() == null || board.getBoardID().equals("")) {
				seqID.setSeqDiv("BOARDID");
				String boardID = (codeService.getSeqID(seqID)).get("seqID").toString();
				board.setBoardID(boardID);
				boardAuthorityList.setBoardID(boardID);
				board.load(boardAuthorityList);
				boardService.addBoard(board);
			}
			else {
				board.load(boardAuthorityList);
				boardService.modifyBoard(board);
			}

			rm.setParameters(board.getBoardID());
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));

		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage() + getMessageSourceAccessor().getMessage(e.getErrorCode()));
		}
		catch (Exception e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/viewArticle")
	public ModelAndView viewArticle(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView(super.getViewUrl(request));
		Map content = new HashMap();
		Map params = new HashMap();
		Article article = new Article();
		ArticleReadLog articleReadLog = new ArticleReadLog();
		SessionManager session = new SessionManager(request, response);

		String strPublicId = "";
		String strPublicClassCd = "";
		String strPublicName = "";

		bind(request, article);
		bind(request, articleReadLog);
		bind(request, params);

		article.setWriteUserID(session.getUserID());
		//F_Board
		content = simpleService.queryForMap("CMP0101104S", params);
		params.putAll(content);
		boardService.modifyArticleReadCount(article, articleReadLog);
		//F_Article
		content = simpleService.queryForMap("CMP0200104S", article);
		//F_ArticleAuthority
		List list = simpleService.queryForList("CMP0200106S", article);

		if (!list.isEmpty()) {
			for (int i = 0; i < list.size(); i++) {
				Map map = (Map) list.get(i);
				strPublicId = strPublicId + map.get("publicID") + ";";
				strPublicClassCd = strPublicClassCd + map.get("publicClassCD") + ";";
				strPublicName = strPublicName + map.get("publicName") + ";";
			}
		}

		//content.put("writeUserID", session.getUserID());

		article.setRef(content.get("ref").toString());
		content.put("userID", session.getUserID());
		content.put("superPage", new Integer(article.getSuperPage()));
		content.put("page", new Integer(article.getPage()));

		content.put("publicID", strPublicId);
		content.put("publicClassCD", strPublicClassCd);
		content.put("publicName", strPublicName);

		if ("Y".equals(content.get("isReply").toString())) {
			//F_ArticleReply
			mv.addObject("articleReplyList", simpleService.queryForList("CMP0200105S", article));
		}

		params.putAll(content);

		setObjectAll(mv, request, response, params);

		return mv;
	}
}