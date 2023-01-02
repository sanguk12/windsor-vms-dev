package kr.co.nis.waf.system.biz.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.system.biz.model.LangDescription;
import kr.co.nis.waf.system.biz.model.LangDescriptions;
import kr.co.nis.waf.system.biz.model.SystemLangDescription;
import kr.co.nis.waf.system.biz.service.LanguageService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/language")
public class LanguageController extends SimpleMultiActionController {
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private LanguageService languageService;
	
	@RequestMapping("/createLangDescription")
	public ModelAndView createLangDescription(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SystemLangDescription systemLangDescription = new SystemLangDescription();
		ResultMessage rm = new ResultMessage();

		bind(request, systemLangDescription);

		try {

			languageService.createLangDescription(systemLangDescription);

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
			
		}
		catch (Exception e) {
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage());
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/saveLangDescription")
	public ModelAndView saveLangDescription(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		LangDescriptions langDescriptions = new LangDescriptions();
		ResultMessage rm = new ResultMessage();

		bind(request, langDescriptions);

		try {

			langDescriptions.clean();
			langDescriptions.validate(langDescriptions.ACTION_SAVE);
			languageService.saveLangDescription(langDescriptions);

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
			e.printStackTrace();

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage());
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/uploadLangDescription")
	public ModelAndView uploadLangDescription(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		Map param = new HashMap();
		
		List langDescriptions = new ArrayList();
		bind(request, param);
		
		try {
			if (logger.isDebugEnabled()) {
				logger.debug("Excel LangDescription Upload Start...");
			}

			MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
			Iterator fileNameIterator = mpRequest.getFileNames();
	
			while (fileNameIterator.hasNext()) {
				MultipartFile multiFile = mpRequest.getFile((String) fileNameIterator.next());
	
				if (multiFile.getSize() > 0) {
					POIFSFileSystem fs = new POIFSFileSystem(multiFile.getInputStream());
	
					HSSFWorkbook workbook = new HSSFWorkbook(fs);
					
					HSSFSheet sheet = workbook.getSheetAt(0);
					
					int startRow = 1;
					int endRow = 20000;
					
					if (logger.isDebugEnabled()) {
						logger.debug("Start Row Num : " + startRow);
						logger.debug("End Row Num : " + endRow);
					}
					
//					String companyID = param.get("companyID").toString();
					String uploadUserID = param.get("uploadUserID").toString();
					
					
					for (int r = startRow; r <= endRow; r++) {
						HSSFRow row = sheet.getRow(r);
						if (row != null) {
							if (logger.isDebugEnabled()) {
								logger.debug("working on row("+r+")...");
							}
							
							LangDescription ld = new LangDescription();
							
							ld.setLanguageCD_info(getCellValue(row.getCell(2)));
							ld.setPkDesc(getCellValue(row.getCell(3)));
							ld.setTableID(getCellValue(row.getCell(4)));
							ld.setPkID1(getCellValue(row.getCell(5)));
							ld.setPkID2(getCellValue(row.getCell(6)));
							ld.setPkID3(getCellValue(row.getCell(7)));
							ld.setCompanyID(getCellValue(row.getCell(8)));
							ld.setUserID(uploadUserID);
							
							if (ld.getLanguageCD_info().equals("") || ld.getPkDesc().equals("") ||
									ld.getTableID().equals("") || ld.getPkID1().equals("") ||
									ld.getPkID2().equals("") || ld.getPkID3().equals("")) {
							}
							else {
								langDescriptions.add(ld);
							}
							
						}
					}
					
					if (langDescriptions.size() > 0) {
						languageService.saveLangDescription(langDescriptions);
					}

				}	
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Excel RequestPackage Upload End...");
			}
			mav = new ModelAndView("simpleHtmlView");
			mav.addObject("html","S;");
		}
		catch (IOException e) {
			e.printStackTrace();
			
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			mav = new ModelAndView("simpleHtmlView");
			mav.addObject("html", "E;"+e.getMessage()+";");
		}
		catch (Exception e) {
			e.printStackTrace();
			
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			mav = new ModelAndView("simpleHtmlView");
			mav.addObject("html", "E;"+e.getMessage()+";");
		}
		
		return mav;
	}
	
	public String getCellValue(HSSFCell cell) {
		String value = "";
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		value = cell.getRichStringCellValue().getString().trim();
		return value;
	}
}
