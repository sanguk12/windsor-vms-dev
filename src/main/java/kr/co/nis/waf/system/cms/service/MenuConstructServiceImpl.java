package kr.co.nis.waf.system.cms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.cms.model.MenuConstruct;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("menuConstructService")
public class MenuConstructServiceImpl implements MenuConstructService {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;

	public void copyMenuConstruct(MenuConstruct menuConstruct) throws Exception {
		//F_MenuConstruct
		simpleDao.insert("CMP0100713I", menuConstruct);
		//F_MenuConstructGroup
		simpleDao.insert("CMP0100714I", menuConstruct);
		//F_MenuConstructDetail
		simpleDao.insert("CMP0100715I", menuConstruct);
	}

	public void deleteMenuConstruct(MenuConstruct menuConstruct) throws Exception {
		if (menuConstruct.getMnuConstructIDs() != null) {
			for (int i = 0; i < menuConstruct.getMnuConstructIDs().length; i++) {
				menuConstruct.setMnuConstructID(menuConstruct.getMnuConstructIDs()[i]);
				//F_MenuConstructDetail
				simpleDao.delete("CMP0100716D", menuConstruct);
				//F_MenuConstructGroup
				simpleDao.delete("CMP0100717D", menuConstruct);
				//F_MenuConstruct
				simpleDao.delete("CMP0100718D", menuConstruct);
			}
		}
		else {
			//F_MenuConstructDetail
			simpleDao.delete("CMP0100716D", menuConstruct);
			//F_MenuConstructGroup
			simpleDao.delete("CMP0100717D", menuConstruct);
			//F_MenuConstruct
			simpleDao.delete("CMP0100718D", menuConstruct);
		}
	}

	public void deleteMenuConstructGroup(MenuConstruct menuConstruct) throws Exception {
		if (menuConstruct.getMnuGrpIDs() != null) {
			for (int i = 0; i < menuConstruct.getMnuGrpIDs().length; i++) {
				menuConstruct.setMnuGrpID(menuConstruct.getMnuGrpIDs()[i]);
				//F_MenuConstructGroup
				simpleDao.delete("CMP0100719D", menuConstruct);
			}
		}
		else {
			//F_MenuConstructGroup
			simpleDao.delete("CMP0100719D", menuConstruct);
		}
	}

	public Map getMenuMap(Map command) throws Exception {

		List mnuGrpID = new ArrayList();
		List mnuMap = new ArrayList();
		List mnuItem = null;
		Map item = null;
		Map mnuInfo = new HashMap();

		if (command.containsKey("mnuGrpID") == false || command.get("mnuGrpID").toString() == null) {
			command.put("mnuGrpID", "ROOT");
		}

		// Header Menu Creation
		mnuItem = simpleDao.queryForList("SYS0009S", command);
		mnuGrpID.add(command.get("mnuGrpID").toString());
		mnuMap.add(mnuItem);

		for (int i = 0; i < mnuItem.size(); i++) {
			item = (Map) mnuItem.get(i);
			if (item.get("kind").equals("G")) {
				mnuGrpID.add(item.get("code").toString());
			}
		}
		
//		gtf. 20130314. taejoon.jang, cs페이지
//		if (command.get("menuStyle").toString().equals("WATERFALL")) {
		if(command.get("companyID").toString().equals("000002")) {
			// Sub Menu Creation
			for (int j = 1; j < mnuGrpID.size(); j++) {
				command.put("mnuGrpID", mnuGrpID.get(j).toString());
				mnuItem = simpleDao.queryForList("SYS0009S", command);
				mnuMap.add(mnuItem);
				for (int k = 0; k < mnuItem.size(); k++) {
					item = (Map) mnuItem.get(k);
					if (item.get("kind").equals("G")) {
						mnuGrpID.add(item.get("code").toString());
					}
				}
			}
		}

		for (int i = 0; i < mnuMap.size(); i++) {
			transferHnwURL((List) mnuMap.get(i));
		}

		mnuInfo.put("mnuGrpID", mnuGrpID);
		mnuInfo.put("mnuMap", mnuMap);

		return mnuInfo;
	}
	
	/**
	 * For jqWidgets
	 */
	public Map getMenu(Map command) throws Exception {

		List mnuGrpID = new ArrayList();
		List mnuMap = new ArrayList();
		List mnuItem = null;
		Map mnuInfo = new HashMap();

		if (command.containsKey("mnuGrpID") == false || command.get("mnuGrpID").toString() == null) {
			command.put("mnuGrpID", "ROOT");
		}

		// Header Menu Creation
		List mnuItem0 = simpleDao.queryForList("SYS0009S", command);
		//mnuGrpID.add(command.get("mnuGrpID").toString());
		//mnuMap.add(mnuItem);

		getMenuGroupInfo(mnuMap, mnuItem0, command);
		
		/*
		for (int i0=0; i0 < mnuItem0.size(); i0++) {
			Map item0 = (Map) mnuItem0.get(i0);
			if (item0.get("kind").equals("G")) {
				item0.put("kind", "GO");
				mnuMap.add(item0);
				command.put("mnuGrpID", item0.get("code").toString());
				List mnuItem1 = simpleDao.queryForList("SYS0009S", command);
				for (int i1=0; i1 < mnuItem1.size(); i1++) {
					
				}
				item0.put("kind", "GC");
				mnuMap.add(item0);
			}
			else {
				mnuMap.add(item0);
			}
		}
		*/

		/*
		for (int i = 0; i < mnuMap.size(); i++) {
			transferHnwURL((List) mnuMap.get(i));
		}
		*/

		mnuInfo.put("mnuMap", mnuMap);

		return mnuInfo;
	}
	
	public void getMenuGroupInfo(List mnuMap, List mnuItem, Map command) {
		
		for (int i=0; i < mnuItem.size(); i++) {
			Map item = (Map)mnuItem.get(i);
			Map item_open = new HashMap();
			Map item_close = new HashMap();
			item_open.putAll(item);
			item_close.putAll(item);
			if (item.get("kind").equals("G")) {
				item_open.put("kind", "GO");
				mnuMap.add(item_open);
				command.put("mnuGrpID", item.get("code").toString());
				List mnuItem_sub = simpleDao.queryForList("SYS0009S", command);
				getMenuGroupInfo(mnuMap, mnuItem_sub, command);
				item_close.put("kind", "GC");
				mnuMap.add(item_close);
			}
			else {
				mnuMap.add(item);
			}
		}
	}

	public void saveMenuConstructProgram(MenuConstruct menuConstruct) throws Exception {

		//F_MenuConstructDetail
		simpleDao.delete("CMP0100720D", menuConstruct);

		if (menuConstruct.getPgmIDs() != null) {
			for (int i = 0; i < menuConstruct.getPgmIDs().length; i++) {
				menuConstruct.setPgmID(menuConstruct.getPgmIDs()[i]);
				menuConstruct.setSeq(menuConstruct.getSeqs()[i]);
				menuConstruct.setUseYN(menuConstruct.getUseYNs()[i]);
				//F_MenuConstructDetail
				simpleDao.insert("CMP0100721I", menuConstruct);
			}
		}
	}

	public Map searchMenuTree(Map command) throws Exception {

		List tree = new ArrayList();
		List treeItem = null;
		Map item = null;
		String index = "";
		int i = 0;
		int x = 0;

		treeItem = simpleDao.queryForList("CMP0100722S", command);

		for (int j = 0; j < treeItem.size(); j++) {
			item = (Map) treeItem.get(j);
			item.put("pcode", new Integer(-1));
			tree.add(i++, item);
		}

		for (int k = 0; k < tree.size(); k++) {
			if (((Map) tree.get(k)).get("kind").equals("G")) {
				command.put("mnuGrpID", ((Map) tree.get(k)).get("code"));
				treeItem = simpleDao.queryForList("CMP0100723S", command);
				for (int j = 0; j < treeItem.size(); j++) {
					item = (Map) treeItem.get(j);
					item.put("pcode", ((Map) tree.get(k)).get("code"));
					tree.add(i++, item);
				}
			}
		}

		transferHnwURL(tree);

		Map treeInfo = new HashMap();
		treeInfo.put("tree", tree);

		return treeInfo;
	}

	/**
	 * For EZGen
	 */
	private void transferHnwURL(List menuMap) {
		String url = null;
		for (int i = 0; i < menuMap.size(); i++) {
			url = (String) ((Map) menuMap.get(i)).get("URL");
			if (url != null && url.length() > 0) {
				url = url.replaceAll("&", "");
				if (url.substring(url.length() - 3, url.length()).equals("hnw")) {
					((Map) menuMap.get(i)).put("URL", "hnwhtml?hnwsrc=/" + url + "&");
				}
			}
		}
	}
}
