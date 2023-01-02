package kr.co.nis.waf.system.cms.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class ProgramView extends CommonObject implements Model {
	
	private String pgmID = "";
	private String viewID = "";
	private String introYN = "";
	private String viewTitle = "";
	
	public void clean() throws Exception {
	}
	
	public void validate(int action) throws Exception {
	}
	
	public String getPgmIDs()
	{
		return pgmID;
	}

	public void setPgmIDs(String pgmID)
	{
		this.pgmID = pgmID;
	}
	
	public String getViewID()
	{
		return viewID;
	}
	
	public void setViewID(String viewID)
	{
		this.viewID = viewID;
	}
	
	public String getIntroYN()
	{
		return introYN;
	}
	
	public void setIntroYN(String introYN)
	{
		this.introYN = introYN;
	}
	
	public String getViewTitle()
	{
		return viewTitle;
	}
	
	public void setViewTitle(String viewTitle)
	{
		this.viewTitle = viewTitle;
	}
}
