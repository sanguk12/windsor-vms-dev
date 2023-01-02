package kr.co.nis.waf.system.cms.model;

import kr.co.nis.waf.system.cms.model.ViewFunction;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.util.StringUtil;

public class ViewFunctionList extends CommonObject implements Model{
	
	public final int ACTION_DEFAULT = 0;
	public final int ACTION_REMOVE = 1;
	public final int ACTION_SAVE = 2;
	
	private String viewID = "";
	private String[] funcID = null;
	private String[] seq = null;
	private String[] pfuncCode = null;
	private String[] command = null;
	
	public void clean() {
		for (int i=0; i < getSize(); i++)
		{
			try{seq[i] = StringUtil.unFormatNum(seq[i]);}catch(Exception e){seq[i] = "0";}
			
			if (seq[i].equals(""))
			{
				seq[i] = "0";
			}
		}
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
		
		if (this.funcID != null)
		{
			 size = this.funcID.length;
		}
		
		return size;
	}
	
	public ViewFunction getObject(int index) {
		
		ViewFunction viewFunction = new ViewFunction();
		if (getSize() > index) {
			
			viewFunction.setCompanyID(this.getCompanyID());
			viewFunction.setUserID(this.getUserID());
			viewFunction.setViewID(this.viewID);
			try{viewFunction.setFuncID(this.funcID[index]);}catch(Exception e){};
			try{viewFunction.setSeq(this.seq[index]);}catch(Exception e){}
			try{viewFunction.setPfuncCode(this.pfuncCode[index]);}catch(Exception e){}
			try{viewFunction.setCommand(this.command[index]);}catch(Exception e){}
		}
		
		return viewFunction;
	}

	public String getViewID()
	{
		return viewID;
	}

	public void setViewID(String viewID)
	{
		this.viewID = viewID;
	}

	public String[] getFuncID()
	{
		return funcID;
	}

	public void setFuncID(String[] funcID)
	{
		this.funcID = funcID;
	}

	public String[] getSeq()
	{
		return seq;
	}

	public void setSeq(String[] seq)
	{
		this.seq = seq;
	}

	public String[] getPfuncCode()
	{
		return pfuncCode;
	}

	public void setPfuncCode(String[] pfuncCode)
	{
		this.pfuncCode = pfuncCode;
	}

	public String[] getCommand()
	{
		return command;
	}

	public void setCommand(String[] command)
	{
		this.command = command;
	}
}
