
package kr.co.nis.waf.system.ui.customtag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

import kr.co.nis.waf.system.ui.customtag.WebControl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class Space extends WebControl {
	protected final Log logger = LogFactory.getLog(getClass());
	
	private int length = 0;

	public int getLength() {
		return length;
	}

	public void setLength(int length) {
		this.length = length;
	}


	public int doStartTag() {
		try {
			JspWriter out = pageContext.getOut();
			String space = "";

			for (int i=0; i < this.length; i++) {
				space = space + "&nbsp;";
			}

			out.print(space);
		} catch (IOException e) {
			if(logger.isDebugEnabled()) {
				logger.debug("Error : " + e);
			}
		}
		return SKIP_BODY;
	}
}
