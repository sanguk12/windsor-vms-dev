package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class SearchArea extends WebControl {
	protected final Log logger = LogFactory.getLog(getClass());
	
	private String searchType = null;

	public String getSitleType() {
		return searchType;
	}


	public void setSitleType(String searchType) {
		this.searchType = searchType;
	}


	public int doStartTag() {
		try {
			JspWriter out = pageContext.getOut();
			if("normal".equals(this.getSitleType())) {
				out.print("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"tblCaptionOut\" style=\"margin-bottom:3px;\" >");
				out.print("	<tr height=\"28\">");
				out.print("		<td class=\"tblCaptionTd\" style=\"padding-left:10px;padding:4px 4px 4px 4px;\">");
				out.print("			<input type=\"text\" name=\"searchValue\" value=\"\" class=\"txtNormal\" />");
				out.print("			<input type=\"button\" name=\"btnSearch\" class=\"btnBlue01\" onclick=\"fnSearch();\" onfocus=\"this.blur();\" value=\"<fmt:message key=\"button.Search\" />\" />");
				out.print("		</td>");
				out.print("	</tr>");
				out.print("</table>");
			}
		} catch (IOException e) {
			if(logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
			}
		}
		return SKIP_BODY;
	}
}
