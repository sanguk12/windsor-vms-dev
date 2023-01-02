package kr.co.nis.waf.system.cms.service;

import java.util.List;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.cms.model.View;
import kr.co.nis.waf.system.cms.model.ViewFunction;

import org.springframework.stereotype.Service;

@Service("viewService")
public class ViewServiceImpl implements ViewService {

	@Resource
	private SimpleDao simpleDao;

	public void addView(View view) throws Exception {
		simpleDao.insert("CMP0100207I", view);
		
		List viewFunctionList = view.getViewFunction();
		for (int i=0; i < viewFunctionList.size(); i++) {
			simpleDao.insert("CMP0100208I", (ViewFunction)viewFunctionList.get(i));
		}
	}

	public void modifyView(View view) throws Exception {
		simpleDao.update("CMP0100209U", view);
		simpleDao.delete("CMP0100210D", view);
		
		List viewFunctionList = view.getViewFunction();
		for (int i=0; i < viewFunctionList.size(); i++) {
			simpleDao.insert("CMP0100208I", (ViewFunction)viewFunctionList.get(i));
		}
	}

	public void removeView(View view) throws Exception {
		simpleDao.delete("CMP0100210D", view);
		simpleDao.update("CMP0100211D", view);
	}
}