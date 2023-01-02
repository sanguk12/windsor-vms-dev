package kr.co.nis.waf.system.biz.service;

import java.util.List;
import java.util.Map;

import kr.co.nis.waf.system.biz.model.Article;
import kr.co.nis.waf.system.biz.model.ArticleReadLog;
import kr.co.nis.waf.system.biz.model.ArticleReply;
import kr.co.nis.waf.system.biz.model.Board;

public interface BoardService {

	public void addArticle(Article article) throws Exception;
	
	public void addBoard(Board board) throws Exception;

	public List findArticle(Map command) throws Exception;

	public List findArticleView(Map command) throws Exception;

	public void modifyArticle(Article article) throws Exception;

	public void modifyArticleReadCount(Article article, ArticleReadLog articleReadLog) throws Exception;

	public void modifyBoard(Board board) throws Exception;
	
}