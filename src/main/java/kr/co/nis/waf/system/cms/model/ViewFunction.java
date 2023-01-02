package kr.co.nis.waf.system.cms.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class ViewFunction extends CommonObject implements Model {
	
	private String viewID = "";
	private String funcID = "";
	private String seq = "0";
	private String pfuncCode = "";
	private String command = "";
	
	public void clean() throws Exception {
	}
	
	public void validate(int action) throws Exception {
	}
	
	public String getViewID()
	{
		return viewID;
	}

	public void setViewID(String viewID)
	{
		this.viewID = viewID;
	}

	public String getFuncID()
	{
		return funcID;
	}

	public void setFuncID(String funcID)
	{
		this.funcID = funcID;
	}

	public String getSeq()
	{
		return seq;
	}

	public void setSeq(String seq)
	{
		this.seq = seq;
	}

	public String getPfuncCode()
	{
		return pfuncCode;
	}

	public void setPfuncCode(String pfuncCode)
	{
		this.pfuncCode = pfuncCode;
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
