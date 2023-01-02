package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.mvc.Model;

public class GroupUser extends CommonObject implements Model{

	public final int ACTION_DEFAULT = 0;
	public final int ACTION_ADD = 1;
	public final int ACTION_MODIFY = 2;
	public final int ACTION_REMOVE = 3;
	public final int ACTION_SAVE = 4;
	
	private String grpID = "";
	private String userID = "";
	
	public void clean() throws Exception {
		this.userID = this.userID.toUpperCase();
	}

	public void validate(int action) throws Exception {
		
		switch (action)
		{
			default:
				
				if (this.userID.equals(""))
				{
					throw new InputRequiredException("CMP01008A.userID");
				}
				else if (this.grpID.equals(""))
				{
					throw new InputRequiredException("CMP01008A.grpName");
				}

				break;
				
		}
	}
	
	public String getGrpID()
	{
		return grpID;
	}

	public void setGrpID(String grpID)
	{
		this.grpID = grpID;
	}

	public String getUserID()
	{
		return userID;
	}
	
	public void setUserID(String userID)
	{
		this.userID = userID;
	}
}
