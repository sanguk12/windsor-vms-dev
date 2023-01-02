package kr.co.nis.waf.system.cms.model;

import java.util.ArrayList;
import java.util.List;

import kr.co.nis.waf.system.cms.model.ProgramViewList;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.mvc.Model;

public class Program extends CommonObject implements Model {

	public final int ACTION_DEFAULT = 0;
	public final int ACTION_REMOVE = 1;
	public final int ACTION_SAVE = 2;
	
	private String pgmID = "";
	private String pgmName = "";
	private String pgmURL = "";
	private String useYN = "";
	private String openWindowYN = "";
	private String remark = "";
	
	private List programView = null;
	
	public void load(ProgramViewList programViewList) {
		programView = new ArrayList();
		for (int i=0; i < programViewList.getSize(); i++)
		{
			programView.add(programViewList.getObject(i));
		}
	}

	public void clean() {
		
	}

	public void validate(int action) throws Exception {
		
		switch (action)
		{
			case ACTION_SAVE:				
				
				if (this.pgmID.equals(""))
				{
					throw new InputRequiredException("pgmID");
				}
				else if (this.pgmName.equals(""))
				{
					throw new InputRequiredException("pgmName");
				}
				else if (this.pgmURL.equals(""))
				{
					throw new InputRequiredException("pgmURL");
				}
				
				break;
				
			case ACTION_REMOVE:				
				
				if (this.pgmID.equals(""))
				{
					throw new InputRequiredException("pgmID");
				}
				
				break;				
				
			default:
				
				break;
		}
	}

	public String getPgmIDs()
	{
		return pgmID;
	}

	public void setPgmIDs(String pgmID)
	{
		this.pgmID = pgmID;
	}

	public String getPgmName()
	{
		return pgmName;
	}

	public void setPgmName(String pgmName)
	{
		this.pgmName = pgmName;
	}

	public String getPgmURL()
	{
		return pgmURL;
	}

	public void setPgmURL(String pgmURL)
	{
		this.pgmURL = pgmURL;
	}

	public String getUseYN()
	{
		return useYN;
	}

	public void setUseYN(String useYN)
	{
		this.useYN = useYN;
	}
	
	public String getOpenWindowYN() {
		return openWindowYN;
	}

	public void setOpenWindowYN(String openWindowYN) {
		this.openWindowYN = openWindowYN;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public List getProgramView()
	{
		return programView;
	}

	public void setProgramView(List programView)
	{
		this.programView = programView;
	}
	

}
