package kr.co.nis.waf.system.cms.model;

import kr.co.nis.waf.system.cms.model.ProgramView;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class ProgramViewList extends CommonObject implements Model {
	
	public final int ACTION_DEFAULT = 0;
	public final int ACTION_REMOVE = 1;
	public final int ACTION_SAVE = 2;
	
	private String pgmID = "";
	private String[] viewID = null;
	private String[] introYN = null;
	private String[] viewTitle = null;
	
	public void clean() {

	}

	public void validate(int action) throws Exception {
		
		switch (action)
		{
			default:
				
				break;
		}
	}

	public int getSize() {
		int size = 0 ;
		
		if (this.viewID != null)
		{
			 size = this.viewID.length;
		}
		
		return size;
	}
	
	public ProgramView getObject(int index) {
		
		ProgramView programView = new ProgramView();
		if (getSize() > index) {
			
			programView.setCompanyID(this.getCompanyID());
			programView.setUserID(this.getUserID());
			programView.setPgmIDs(this.pgmID);
			try{programView.setViewID(this.viewID[index]);}catch(Exception e){};
			try{programView.setIntroYN(this.introYN[index]);}catch(Exception e){}
			try{programView.setViewTitle(this.viewTitle[index]);}catch(Exception e){}
		}
		
		return programView;
	}

	public String getPgmIDs()
	{
		return pgmID;
	}

	public void setPgmIDs(String pgmID)
	{
		this.pgmID = pgmID;
	}

	public String[] getViewID()
	{
		return viewID;
	}

	public void setViewID(String[] viewID)
	{
		this.viewID = viewID;
	}

	public String[] getIntroYN()
	{
		return introYN;
	}

	public void setIntroYN(String[] introYN)
	{
		this.introYN = introYN;
	}

	public String[] getViewTitle()
	{
		return viewTitle;
	}

	public void setViewTitle(String[] viewTitle)
	{
		this.viewTitle = viewTitle;
	}

}
