package kr.co.nis.waf.system.biz.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.model.NewsTicker;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/newsTicker")
public class NewsTickerController extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleService simpleService;
	
	@Resource
	private CodeService codeService;


	@RequestMapping("/saveNewsTicker")
	public ModelAndView saveNewsTicker(HttpServletRequest request, HttpServletResponse response) throws Exception {

		NewsTicker newsTicker = new NewsTicker();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();

		bind(request, newsTicker);
		bind(request, seqID);
		
		try {

			newsTicker.clean();
			newsTicker.validate(newsTicker.ACTION_SAVE);
			
			if (newsTicker.getNewsID() == null || newsTicker.getNewsID().equals("")) {
				seqID.setSeqDiv("NEWSID");
				String newsID = (codeService.getSeqID(seqID)).get("seqID").toString();

				newsTicker.setNewsID(newsID);
				//F_NewsTicker
				simpleService.insert("CMP0101303I", newsTicker);
			}
			else {
				//F_NewsTicker
				simpleService.update("CMP0101304U", newsTicker);
			}
			rm.setParameters(newsTicker.getNewsID());
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/removeNewsTicker")
	public ModelAndView removeNewsTicker(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		NewsTicker newsTicker = new NewsTicker();
		ResultMessage rm = new ResultMessage();

		bind(request, newsTicker);

		try {

			newsTicker.clean();
			newsTicker.validate(newsTicker.ACTION_SAVE);
			//F_NewsTicker
			simpleService.delete("CMP0101305U",newsTicker);

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.delete"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.delete"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	

}
