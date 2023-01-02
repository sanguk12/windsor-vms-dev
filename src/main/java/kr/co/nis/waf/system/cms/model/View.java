package kr.co.nis.waf.system.cms.model;

import java.util.ArrayList;
import java.util.List;

import kr.co.nis.waf.system.cms.model.ViewFunctionList;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.mvc.Model;

public class View extends CommonObject implements Model{

	public final int ACTION_DEFAULT = 0;
	public final int ACTION_REMOVE = 1;
	public final int ACTION_SAVE = 2;

	
	private String viewID = "";
	private String viewName = "";
	private String viewURL = "";
	private String useYN = "";
	private String remark = "";
	private String appPositionCD = "";
	private String appDisRate = "0";
	private String appDisUnitCD = "";
	
	private List viewFunction = null;

	public void load(ViewFunctionList viewFunctionList) {
		viewFunction = new ArrayList();
		for (int i=0; i < viewFunctionList.getSize(); i++)
		{
			viewFunction.add(viewFunctionList.getObject(i));
		}
	}

	public void clean() {
		
	}

	public void validate(int action) throws Exception {
		
		switch (action)
		{
			case ACTION_SAVE:				
				
				if (this.viewID.equals(""))
				{
					throw new InputRequiredException("viewID");
				}
				else if (this.viewName.equals(""))
				{
					throw new InputRequiredException("viewName");
				}
				else if (this.viewURL.equals(""))
				{
					throw new InputRequiredException("viewURL");
				}
				
				break;
				
			case ACTION_REMOVE:				
				
				if (this.viewID.equals(""))
				{
					throw new InputRequiredException("viewID");
				}
				
				break;				
				
			default:
				
				break;
		}
	}

	
	public String getAppDisUnitCD() {
		return appDisUnitCD;
	}

	public void setAppDisUnitCD(String appDisUnitCD) {
		this.appDisUnitCD = appDisUnitCD;
	}

	public String getAppPositionCD() {
		return appPositionCD;
	}

	public void setAppPositionCD(String appPositionCD) {
		this.appPositionCD = appPositionCD;
	}

	public String getAppDisRate() {
		return appDisRate;
	}

	public void setAppDisRate(String appDisRate) {
		this.appDisRate = appDisRate;
	}

	public int getACTION_DEFAULT() {
		return ACTION_DEFAULT;
	}

	public int getACTION_REMOVE() {
		return ACTION_REMOVE;
	}

	public int getACTION_SAVE() {
		return ACTION_SAVE;
	}

	public String getViewID()
	{
		return viewID;
	}

	public void setViewID(String viewID)
	{
		this.viewID = viewID;
	}

	public String getViewName()
	{
		return viewName;
	}

	public void setViewName(String viewName)
	{
		this.viewName = viewName;
	}

	public String getViewURL()
	{
		return viewURL;
	}

	public void setViewURL(String viewURL)
	{
		this.viewURL = viewURL;
	}

	public String getUseYN()
	{
		return useYN;
	}

	public void setUseYN(String useYN)
	{
		this.useYN = useYN;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public List getViewFunction()
	{
		return viewFunction;
	}

	public void setViewFunction(List viewFunction)
	{
		this.viewFunction = viewFunction;
	}
}
