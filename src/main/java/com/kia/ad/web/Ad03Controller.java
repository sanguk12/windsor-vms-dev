package com.kia.ad.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kia.ad.model.GME01DT;
import com.kia.ad.model.GME01MT;
import com.kia.ad.service.Ad03Service;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.common.FileInfo;
import kr.co.nis.waf.common.FileUploadUtil;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.view.SimpleDoc;

@Controller
@RequestMapping("/service/ad03")
public class Ad03Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;
	
//	@Value("#{system['jXls.templateFilePath']}")
//	private String templateFilePath;
	
	@Value("#{appenv['file.prdListUpload']}")
	private String prdListUpload;

	@Resource
	private Ad03Service ad03Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	

	@RequestMapping("/requestUseProcess")
	public ModelAndView requestUseProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GME01MT gme01mt = new GME01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
	
		bind(request, gme01mt);
		
		try {
			gme01mt.clean();
			gme01mt.validate(gme01mt.ACTION_SAVE);
			
			ad03Service.requestUseProcess(gme01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.useProcess"));
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
				e.printStackTrace();
			}
	
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.useProcess"));
			rm.setSystemMessage(e.toString());
		}
	
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
	
		return mv;
	}
	
	@RequestMapping("/requestUnUsedProcess")
	public ModelAndView requestUnUsedProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GME01MT gme01mt = new GME01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
	
		bind(request, gme01mt);
		
		try {
			gme01mt.clean();
			gme01mt.validate(gme01mt.ACTION_SAVE);
			
			ad03Service.requestUnUsedProcess(gme01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.unUseProcess"));
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
				e.printStackTrace();
			}
	
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.unUseProcess"));
			rm.setSystemMessage(e.toString());
		}
	
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
	
		return mv;
	}
	
	@RequestMapping("/downloadFile")
	public ModelAndView downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		parameters.put("fileName", prdListUpload);
		parameters.put("tempFileName", prdListUpload);
		parameters.put("uploadDir", templateFilePath);

		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/extractPrdXls")
	public ModelAndView extractVenueXls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> list = new ArrayList<Map<String, Cell>>();

		bind(request, params);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileNameIterator = mpRequest.getFileNames();

		while (fileNameIterator.hasNext()) {
			MultipartFile multiFile = mpRequest.getFile((String) fileNameIterator.next());

			if (multiFile.getSize() > 0) {
				FileInfo fileInfo = FileUploadUtil.uploadFormFile(multiFile, realUploadPath);
				logger.debug("[Upload File Info] ----------> " + realUploadPath + fileInfo.getTempFileName());
				String originalFileName = multiFile.getOriginalFilename();
				String extension = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				
				logger.debug("excel extension: "+extension.toLowerCase());
				Workbook workbook = null;
				Sheet sheet = null; 
				if(extension.toLowerCase().equals("xls")) {
					POIFSFileSystem fs = new POIFSFileSystem(multiFile.getInputStream());
					workbook = new HSSFWorkbook(fs);
					sheet = workbook.getSheetAt(0);
					
				}
				else if(extension.toLowerCase().equals("xlsx")) {
					workbook = new XSSFWorkbook(OPCPackage.open(multiFile.getInputStream()));
					sheet = workbook.getSheetAt(0);
					
				}
				
				int numOfRows = 999;
				int numOfCells = 99;
				try {numOfRows = sheet.getPhysicalNumberOfRows();} catch (Exception e) {}
				for (int i = 0; i < numOfRows; i++) {
					Row row = sheet.getRow(i);
					if (row != null) {
						int tmp = 0;
						try {tmp = row.getPhysicalNumberOfCells();} catch (Exception e) {}
						numOfCells = (tmp > numOfCells) ? tmp : numOfCells;
					}
				}
				if (logger.isDebugEnabled()) {
					logger.debug("numOfRows : " + numOfRows);
					logger.debug("numOfCells : " + numOfCells);
				}
				
				//i=1; except header
				for (int i = 1; i < numOfRows; i++) {
					Map data = new LinkedHashMap<String, String>();
					Row row = sheet.getRow(i);
					
					if (row != null) {
						
						Cell c_prdCD = row.getCell(0);
						Cell c_prdNM = row.getCell(1);
						Cell c_eu = row.getCell(2);
						Cell c_sdxYN = row.getCell(3);
						Cell c_efp = row.getCell(4);
						Cell c_duty = row.getCell(5);
						Cell c_cogs = row.getCell(6);
						//Cell c_qtyUnitCD = row.getCell(7);
						
						String qtyUnitName = "";
						
						//코드명으로 되어있는 excel 코드값 찾기
						Map param = null;
						Map queryMap = null;
						
						if(c_prdCD!=null && c_prdNM!=null) {
							
//							String qtyUnitCD = "";
//							if(c_qtyUnitName!=null) {
//								if(!"".equals(c_qtyUnitName.getStringCellValue())) {
//									param = new HashMap();
//									queryMap = new HashMap();
//									param.put("codeDiv", "QTYUNITCD");
//									param.put("codeName", c_qtyUnitName.getStringCellValue());
//									queryMap = simpleService.queryForMap("AD0300106S", param);
//									if(queryMap != null) {
//										qtyUnitName = c_qtyUnitName.getStringCellValue();
//										qtyUnitCD = queryMap.get("comCode").toString();	
//									}
//									else {
//										qtyUnitName = "";
//										qtyUnitCD = "";
//									}
//								}
							//}
							
							data.put("prdCD", c_prdCD);
							data.put("prdNM", c_prdNM);
							data.put("eu", c_eu);
							data.put("sdxYN", c_sdxYN);
							data.put("efp", c_efp);
							data.put("duty", c_duty);
							data.put("cogs", c_cogs);
							
							//data.put("qtyUnitCD", qtyUnitCD);
						
	
							list.add(data);
						}
					}
				}
				
				// temp file delete
				try {
					File f = new File(realUploadPath + fileInfo.getTempFileName());
					f.delete();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		ModelAndView mav = new ModelAndView("resultView");
		SimpleDoc simpleDoc = new SimpleDoc("XML", list);

		mav = simpleDoc.create();

		return mav;
	}
	
	@RequestMapping("/savePrdGrid")
	public ModelAndView savePrdGrid(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		GME01DT gme01dt = new GME01DT();
		ResultMessage rm = new ResultMessage();

		bind(request, gme01dt);
		
		try {
			gme01dt.clean();
			gme01dt.validate(gme01dt.ACTION_SAVE);
			
			ad03Service.savePrdGrid(gme01dt);
			
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
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/saveAdList")
	public ModelAndView saveAdList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		GME01MT gme01mt = new GME01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gme01mt);
		
		try {
			gme01mt.clean();
			gme01mt.validate(gme01mt.ACTION_ADD);
			
			ad03Service.saveAdList(gme01mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
			rm.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
		
		return mv;
	}
	
}