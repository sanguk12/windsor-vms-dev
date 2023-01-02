package kr.co.nis.waf.system.cms.service;

import java.util.List;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.cms.model.Program;
import kr.co.nis.waf.system.cms.model.ProgramView;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("ProgramService")
public class ProgramServiceImpl implements ProgramService {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	

	public void addProgram(Program program) throws Exception {
		
		// F_Program
		simpleDao.insert("CMP0100605I", program);
		
		List programViewList = program.getProgramView();
		for (int i = 0; i < programViewList.size(); i++) {
			
			// F_ProgramView
			simpleDao.insert("CMP0100606I",(ProgramView)programViewList.get(i));
		}
	}

	public void modifyProgram(Program program) throws Exception {
		
		// F_Program
		simpleDao.update("CMP0100607U", program);
		
		// F_ProgramView
		simpleDao.delete("CMP0100608D", program);

		List programViewList = program.getProgramView();

		for (int i = 0; i < programViewList.size(); i++) {
			
			// F_ProgramView
			simpleDao.insert("CMP0100606I",(ProgramView)programViewList.get(i));
		}
	}

	public void removeProgram(Program program) throws Exception {
		
		// F_ProgramView
		simpleDao.delete("CMP0100608D", program);
		
		// F_Program
		simpleDao.delete("CMP0100609D", program);
	}
}
