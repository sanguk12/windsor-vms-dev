package kr.co.nis.waf.system.biz.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.ResultView;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.ClasseList;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.ClassService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/class")
public class ClassController extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private ClassService classService;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;

	/*
	public void setClassService(ClassService classService) {
		this.classService = classService;
	}

	public void setCodeService(CodeService codeService) {
		this.codeService = codeService;
	}
	
	public void setSimpleService(SimpleService simpleService) {
		this.simpleService = simpleService;
	}
	*/

	@RequestMapping("/initClassList")
	public ModelAndView initClassList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map params = new HashMap();

		bind(request, params);

		List list = simpleService.queryForList("commonservice.biz.classChart.select", params);

		params.put("initAction", "Search");

		ModelAndView mv = new ModelAndView(getViewUrl(request));
		setObjectAll(mv, request, response, params);
		mv.addObject("classChart", list);

		return mv;
	}

	@RequestMapping("/saveClass")
	public ModelAndView saveClass(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ClasseList classList = new ClasseList();
		Code seqID = new Code();
		Map params = new HashMap();
		ResultMessage resultMsg = new ResultMessage();

		bind(request, classList);
		bind(request, params);
		
		try {
			String[] classID = classList.getClassID();
			seqID.setCompanyID(classList.getCompanyID());
			seqID.setSeqDiv("CLASSID");
			seqID.setUserID(classList.getUserID());
			for (int i = 0; i < classID.length; i++)
			{
				if (classID[i].equals(""))
				{
					classID[i] = (codeService.getSeqID(seqID)).get("seqID").toString();
				}
			}
			classList.setClassID(classID);

			classService.saveClass(params, classList);

			resultMsg.setCode(resultMsg.RESULT_SUCCESS);
			resultMsg.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (Exception e)
		{
			if (logger.isDebugEnabled())
			{
				logger.debug(e.toString());
				e.printStackTrace();
			}

			resultMsg.setCode(resultMsg.RESULT_ERROR);
			resultMsg.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			resultMsg.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView(new ResultView());
		mv.addObject("resultMsg", resultMsg);

		return mv;
	}


}
