package kr.co.nis.waf.system.cms.service;

import java.util.Map;

import kr.co.nis.waf.system.cms.model.MenuConstruct;

public interface MenuConstructService {

	public void deleteMenuConstruct(MenuConstruct menuConstruct) throws Exception;
	
	public void deleteMenuConstructGroup(MenuConstruct menuConstruct) throws Exception;
	
	public Map getMenuMap(Map command) throws Exception;
	
	public Map getMenu(Map command) throws Exception;
	
	public void copyMenuConstruct(MenuConstruct menuConstruct) throws Exception;
	
	public void saveMenuConstructProgram(MenuConstruct menuConstruct) throws Exception;
	
	public Map searchMenuTree(Map command) throws Exception;
	
}