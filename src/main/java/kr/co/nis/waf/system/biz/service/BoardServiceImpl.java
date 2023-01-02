package kr.co.nis.waf.system.biz.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.biz.model.Article;
import kr.co.nis.waf.system.biz.model.ArticleAuthority;
import kr.co.nis.waf.system.biz.model.ArticleReadLog;
import kr.co.nis.waf.system.biz.model.Board;
import kr.co.nis.waf.system.biz.model.BoardAuthority;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Resource
	private SimpleDao simpleDao;
	
    public void addArticle(Article article) throws Exception {
		
    	//F_Article
		simpleDao.insert("CMP0200112I", article);
		//F_ArticleAuthority
		simpleDao.insert("CMP0200113D", article);
		
		if( article.getPublicID()!=null&&!( article.getPublicID().equals(""))) {
			 String[] arrPublicId 	 = article.getPublicID().split(";");
	         String[] arrPublicClassCd = article.getPublicClassCD().split(";");
	         String[] arrPublicName  = article.getPublicName().split(";");
	         	         
				
	         for(int i = 0; i<arrPublicId.length;i++) {
	        	 ArticleAuthority articleAuthority = new ArticleAuthority();
	        	 
	        	 articleAuthority.setCompanyID(article.getCompanyID());
	        	 articleAuthority.setBoardID(article.getBoardID());
	        	 articleAuthority.setArticleID(article.getArticleID());
	        	 articleAuthority.setPublicID(arrPublicId[i]); 
	        	 articleAuthority.setPublicClassCD(arrPublicClassCd[i]); 
	        	 articleAuthority.setPublicName(arrPublicName[i]); 

	        	 //F_ArticleAuthority
	        	 simpleDao.insert("CMP0200114I", articleAuthority);
	         }
		}
	}
    
	public void addBoard(Board board) throws Exception {
		
		//F_Board
		simpleDao.insert("CMP0101105I", board);
		
		List boardAuthorityList = board.getBoardAuthority();
		for (int i = 0; i < boardAuthorityList.size(); i++) {
			BoardAuthority boardAuthority = (BoardAuthority) boardAuthorityList.get(i);
			//F_BoardAuthority
			simpleDao.insert("CMP0101106I", boardAuthority);
		}
	}

	public List findArticle(Map command) throws Exception {
		int page = 0;
		int superPage = 0; 
		
		int recordCount = 0;
		int recordPerPage = 15;
		
		int pageCount = 0;
		int listCount = 0;
		
		int superPageCount = 0;
		int pagePerSuperPage = 10;
		int startRecordNum = 0;
	
		
		if (command.get("keyWord") != null && !command.get("keyWord").equals("")) {
			command.put("keyWord",(String)command.get("keyWord"));
		}
		else {
			command.put("keyWord","");
		}
		
		//F_Article
		recordCount = simpleDao.queryForInt("CMP0200108S", command);

		if (command.get("page") != null) {
			page = Integer.parseInt(command.get("page").toString());
		}
		
		pageCount =(int)Math.ceil((double)recordCount / recordPerPage);
		
		startRecordNum = page * recordPerPage;

		if (command.get("superPage") != null) {
			superPage = Integer.parseInt(command.get("superPage").toString());
		}
		superPageCount =(int)Math.ceil((double)pageCount / pagePerSuperPage);
		
		listCount = recordCount - ((page-1)*recordPerPage)-recordPerPage;
		
		if(page > 0 && listCount == 0) {
			page = page-1;
		}
			
		// parameter setting
		command.put("page", new Integer(page));
		command.put("superPage", new Integer(superPage));
		command.put("recordCount", new Integer(recordCount));
		command.put("recordPerPage", new Integer(recordPerPage));
		command.put("pageCount", new Integer(pageCount));
		command.put("listCount", new Integer(listCount));
		command.put("superPageCount", new Integer(superPageCount));
		command.put("pagePerSuperPage", new Integer(pagePerSuperPage));
		command.put("startRecordNum", new Integer(startRecordNum));
		command.put("s_seq", new Integer(recordPerPage));
		command.put("e_seq", new Integer(listCount));
		command.put("continue_loop", new Boolean(true));
		command.put("breakValue", "N");
		
		//F_Article
		return simpleDao.queryForList("CMP0200115S", command);
	}

	public List findArticleView(Map command) throws Exception {
		
		int page = 0;
		int superPage = 0; 
		
		int recordCount = 0;
		int recordPerPage = 3;
		
		int pageCount = 0;
		int listCount = 0;
		
		int superPageCount = 0;
		int pagePerSuperPage = 10;
		int startRecordNum = 0;
	
		
		if (command.get("keyWord") != null && !command.get("keyWord").equals("")) {
			command.put("keyWord",(String)command.get("keyWord"));
		}
		else {
			command.put("keyWord","");
		}
		
		//F_Article
		recordCount = simpleDao.queryForInt("CMP0200108S", command);
		 
		if (command.get("page") != null) {
			page = Integer.parseInt(command.get("page").toString());
		}
		
		pageCount =(int)Math.ceil((double)recordCount / recordPerPage);
		
		startRecordNum = page * recordPerPage;

		if (command.get("superPage") != null) {
			superPage = Integer.parseInt(command.get("superPage").toString());
		}
		superPageCount =(int)Math.ceil((double)pageCount / pagePerSuperPage);
		
		listCount = recordCount - ((page-1)*recordPerPage)-recordPerPage;
			
		// parameter setting
		command.put("page", new Integer(page));
		command.put("superPage", new Integer(superPage));
		command.put("recordCount", new Integer(recordCount));
		command.put("recordPerPage", new Integer(recordPerPage));
		command.put("pageCount", new Integer(pageCount));
		command.put("listCount", new Integer(listCount));
		command.put("superPageCount", new Integer(superPageCount));
		command.put("pagePerSuperPage", new Integer(pagePerSuperPage));
		command.put("startRecordNum", new Integer(startRecordNum));
		command.put("s_seq", new Integer(recordPerPage));
		command.put("e_seq", new Integer(listCount));
		command.put("continue_loop", new Boolean(true));
		command.put("breakValue", "N");
		
		//F_Article
		return simpleDao.queryForList("CMP0200116S", command);
	}

	public void modifyArticle(Article article) throws Exception {
		//F_Article
		simpleDao.update("CMP0200117U", article);
		//F_ArticleAuthority
		simpleDao.insert("CMP0200113D", article);
		
		if( article.getPublicID()!=null&&!( article.getPublicID().equals(""))){
			 
			 String[] arrPublicId 	 = article.getPublicID().split(";");
	         String[] arrPublicClassCd = article.getPublicClassCD().split(";");
	         String[] arrPublicName  = article.getPublicName().split(";");
				
	         for(int i = 0; i < arrPublicId.length;i++) {
	        	 ArticleAuthority articleAuthority = new ArticleAuthority();
	        	 
	        	 articleAuthority.setCompanyID(article.getCompanyID());
	        	 articleAuthority.setBoardID(article.getBoardID());
	        	 articleAuthority.setArticleID(article.getArticleID());
	        	 articleAuthority.setPublicID(arrPublicId[i]); 
	        	 articleAuthority.setPublicClassCD(arrPublicClassCd[i]); 
	        	 articleAuthority.setPublicName(arrPublicName[i]); 

	        	 //F_ArticleAuthority
	             simpleDao.insert("CMP0200114I", articleAuthority);
	         }
		}
	}
	
	public void modifyArticleReadCount(Article article, ArticleReadLog articleReadLog) throws Exception {

		int cnt =0;
		//F_Article
		simpleDao.update("CMP0200118U", article);
		//F_ArticleReadLog
		cnt = simpleDao.queryForInt("CMP0200119S", article);	
		
		if( cnt > 0) {
			//F_ArticleReadLog
			simpleDao.update("CMP0200120U", articleReadLog);
		}
		else {
			//F_ArticleReadLog
			simpleDao.insert("CMP0200121I", articleReadLog);
		}
		
	}
	
	public void modifyBoard(Board board) throws Exception {
		//F_Board
		simpleDao.update("CMP0101108U", board);
		//F_BoardAuthority
		simpleDao.insert("CMP0101107D", board);
		
		List boardAuthorityList = board.getBoardAuthority();
		
		if (boardAuthorityList != null) {
            for(int i = 0; i < boardAuthorityList.size();i++) {
                BoardAuthority boardAuthority = (BoardAuthority)boardAuthorityList.get(i);
                //F_BoardAuthority
	        	simpleDao.insert("CMP0101106I", boardAuthority);
	        }
		}
	}
}
