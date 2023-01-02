
package kr.co.nis.waf.system.common.web;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import kr.co.nis.waf.system.biz.service.CodeService;

/** 
 * XSSRequestWrapper 클래스 
 * @date: 2014.1.10
 * @version: 1.0
 * @author: NuriInfos Lab (admin@nis.co.kr)
 */

public class XSSRequestWrapper extends HttpServletRequestWrapper {

	private String uri;
	
	private static Pattern[] patterns = new Pattern[]{
        // Script fragments
        Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE),
        
        /* LG생건 게시판 이미지 삽입을 위해 img 태그 내 src 항목 필터 해제, 2014-09-11, 요청자: 임석진, 작업자: 고승효
        // src='...'
        Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        */
        
        // lonely script tags
        Pattern.compile("</script>", Pattern.CASE_INSENSITIVE),
        Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // eval(...)
        Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // expression(...)
        Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // javascript:...
        Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE),
        // vbscript:...
        Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE),
        // onload(...)=...
        Pattern.compile("onload(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // <iframe>
        Pattern.compile("</iframe>", Pattern.CASE_INSENSITIVE),
        Pattern.compile("<iframe.*?>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // onmouseover(...)=...
        Pattern.compile("onmouseover(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // onclick(...)=...
        Pattern.compile("onclick(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // onblur(...)=...
        Pattern.compile("onblur(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // onfocus(...)=...
        Pattern.compile("onfocus(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // onselect(...)=...
        Pattern.compile("onselect(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // onsubmit(...)=...
        Pattern.compile("onclick(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        
        Pattern.compile("onError(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),

        Pattern.compile("onKeyDown(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        
        Pattern.compile("on.*?=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
    };
	
	public XSSRequestWrapper(HttpServletRequest servletRequest) {
		super(servletRequest);     
		uri = servletRequest.getRequestURI().toString().trim();
	}     
	
	public String[] getParameterValues(String parameter) {       
		String[] values = super.getParameterValues(parameter);       
		  
		if (values==null)  {                  
			return null;
		}      
		
		int count = values.length;      
		  
		String[] encodedValues = new String[count];
		
		for (int i = 0; i < count; i++) {
			if(uri.indexOf("/service/simpleExportNew/") > -1 
					|| uri.indexOf("/service/act01/excelDown/") > -1 || uri.indexOf("/service/widget/") > -1         
					|| uri.indexOf("/service/simpleAction/SQL_DEV_TEST") > -1
					|| uri.indexOf("service/sys01/SQL_DEV_TEST2") > -1   
				){
					encodedValues[i] = values[i];
			}else if(uri.indexOf("service/board/addArticleReply") > -1   
		      || uri.indexOf("service/group/updateGroup") > -1
		      || uri.indexOf("service/menuConstruct") > -1 
		      /*|| uri.indexOf("/service/simpleCommand/") > -1  */
			  || uri.indexOf("/sys/cms/workspace2frame") > -1 
			){
				if("data2_master".equals(parameter)|| "data3_detail".equals(parameter)){ //오즈파라메터 에외처리
					encodedValues[i] = values[i];
				}else if("mnuGrpID".equals(parameter) || "openProgram".equals(parameter) ||"menuCloseYN".equals(parameter)||"finalAction".equals(parameter)){ 
					
					encodedValues[i] =  stripXSS(values[i]);
					encodedValues[i] =  cleanXSS4(encodedValues[i]);
				}else{
					encodedValues[i] =  cleanXSS4(values[i]);
				}
			}else if(uri.indexOf("/service/simpleCommand/") > -1){
				encodedValues[i] =  cleanXSS5(values[i]);
			}else if(/*uri.indexOf("/service/board/viewArticle") > -1 
				|| uri.indexOf("/service/board/addArticle") > -1
				|| */uri.indexOf("/service/board") > -1
				/*|| uri.indexOf("/service/board/modifyArticle") > -1*/
				|| uri.indexOf("/service/helpContents/saveHelpContents") > -1
			){ 
				if("content".equals(parameter)|| "articleContent".equals(parameter)){
					encodedValues[i] =  cleanXSS2(values[i]);
				/*}else if("keyWord".equals(parameter)){*/ 
					/*encodedValues[i] =  stripXSS(cleanXSS4(values[i]));*/
				}else{
					encodedValues[i] =  stripXSS(values[i]);
					encodedValues[i] =  cleanXSS5(encodedValues[i]);
					/*encodedValues[i] =  cleanXSS4(values[i]);*/
				} 
				//encodedValues[i] =  cleanXSS2(values[i]);
			}else if(uri.indexOf("/service/simpleAction/") > -1){ 
				encodedValues[i] =  cleanXSS3(values[i]);
			}else if(uri.indexOf("/service/api/") > -1){ 
				encodedValues[i] =  values[i];
			}else{
				encodedValues[i] = cleanXSS(values[i]);
			}
		}

		return encodedValues;
	}
		  
	public String getParameter(String parameter) {

		String value = super.getParameter(parameter);
		if (value == null) return null;
		
		return cleanXSS(value);
	}
	 
	public String getHeader(String name) {
		 
		String value = super.getHeader(name);
		if (value == null) return null;
		
		return cleanXSS(value);
	}     
		 
	private String cleanXSS(String value) {
		//You'll need to remove the spaces from the html entities below
		  
		value = value.replaceAll("<", "＜").replaceAll(">", "＞");
		//value = value.replaceAll("\\(", "（").replaceAll("\\)", "）");
		value = value.replaceAll("'", "’");
		value = value.replaceAll("eval\\((.*)\\)", "");
		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		value = value.replaceAll("script", "");
		value = value.replaceAll("SCRIPT", "");
		//value = value.replaceAll("&", "＆");
		value = value.replaceAll("#", "＃");
		value = value.replaceAll("\"", "￦");
		
		return value;
		
	}
	 

	private String cleanXSS2(String value) {
		//You'll need to remove the spaces from the html entities below

		value = value.replaceAll("eval\\((.*)\\)", "");
		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		value = value.replaceAll("script", "");
		value = value.replaceAll("SCRIPT", "");
		value = value.replaceAll("iframe", "");
		value = value.replaceAll("IFRAME", "");
		value = value.replaceAll("alert", "");
		value = value.replaceAll("ALERT", "");
		value = value.replaceAll("object", "");
		value = value.replaceAll("OBJECT", "");
		return value; 
	}

	private String cleanXSS3(String value) {
		//You'll need to remove the spaces from the html entities below
		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		value = value.replaceAll("script", "");
		value = value.replaceAll("SCRIPT", "");		
		value = value.replaceAll("\"", "");
		value = value.replaceAll("\'", "");
		return value; 
	}

	private String cleanXSS4(String value) { 
        value = value.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
        value = value.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
        value = value.replaceAll("'", "& #39;");
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        value = value.replaceAll("script", "");
		value = value.replaceAll("SCRIPT", "");		
		//value = value.replaceAll("\"", "");
		value = value.replaceAll("\'", "");
		
		value = value.replaceAll("<", "＜");
		value = value.replaceAll(">", "＞"); 
		value = value.replaceAll("'", "‘"); 
		return value; 
	}

	private String cleanXSS5(String value) { 
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        value = value.replaceAll("script", "");
		value = value.replaceAll("SCRIPT", "");		
		//value = value.replaceAll("\"", "");
		value = value.replaceAll("\'", "");
		
		value = value.replaceAll("<", "＜");
		value = value.replaceAll(">", "＞"); 
		value = value.replaceAll("'", "‘"); 
		return value; 
	}
	
	private String stripXSS(String value) {
        if (value != null) {
            // NOTE: It's highly recommended to use the ESAPI library and uncomment the following line to
            // avoid encoded attacks.
            // value = ESAPI.encoder().canonicalize(value);
 
            // Avoid null characters
            value = value.replaceAll("\0", "");
            
            if(!"".equals(value))
            // Remove all sections that match a pattern
            for (Pattern scriptPattern : patterns){
            	
        		/*System.out.println("### scriptPattern : " + scriptPattern.matcher(value).toMatchResult().toString() + " /  value : " + value);*/
            	
                value = scriptPattern.matcher(value).replaceAll("");
            }

    		value = value.replaceAll("(?i)alert", "");
    		value = value.replaceAll("(?i)confirm", "");
    		//value = value.replaceAll("\\\"", "\\\\\"");
        }
        return value;
    }

}