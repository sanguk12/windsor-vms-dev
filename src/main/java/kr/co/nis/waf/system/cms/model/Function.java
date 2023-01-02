package kr.co.nis.waf.system.cms.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.SelectRequiredException;

public class Function extends CommonObject implements Model {

	public final int ACTION_DEFAULT = 0;
	public final int ACTION_ADD = 1;
	public final int ACTION_MODIFY = 2;
	public final int ACTION_REMOVE = 3;
	public final int ACTION_SAVE = 4;

	
	private String funcID = "";
	private String funcCode= "";
	private String funcName = "";
	private String seq = "0";
	private String icon = "";
	private String standardYN = "";
	private String command = "";
	private String remark = "";
	
	
	public void clean()
	{
		if (this.seq.equals("")) this.seq = "0";
	}
	
	public void validate(int action) throws Exception {
		
		switch (action)
		{
			case ACTION_SAVE:
				if (this.funcCode.equals(""))
				{
					throw new InputRequiredException("CMP01001A.funcCode");
				}
				else if (this.funcName.equals(""))
				{
					throw new InputRequiredException("CMP01001A.funcName");
				}
				break;
				
			case ACTION_REMOVE:
				if (this.funcID.equals(""))
				{
					throw new SelectRequiredException("CMP01001A.funcCode");
				}

				break;
				
			default:
				
				break;
				
		}
	}

	public String getFuncID()
	{
		return funcID;
	}

	public void setFuncID(String funcID)
	{
		this.funcID = funcID;
	}

	public String getFuncCode()
	{
		return funcCode;
	}

	public void setFuncCode(String funcCode)
	{
		this.funcCode = funcCode;
	}

	public String getFuncName()
	{
		return funcName;
	}

	public void setFuncName(String funcName)
	{
		this.funcName = funcName;
	}

	public String getSeq()
	{
		return seq;
	}

	public void setSeq(String seq)
	{
		this.seq = seq;
	}

	public String getIcon()
	{
		return icon;
	}

	public void setIcon(String icon)
	{
		this.icon = icon;
	}

	public String getStandardYN()
	{
		return standardYN;
	}

	public void setStandardYN(String standardYN)
	{
		this.standardYN = standardYN;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public String getCommand()
	{
		return command;
	}

	public void setCommand(String command)
	{
		this.command = command;
	}
}
