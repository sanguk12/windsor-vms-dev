package com.kia.ad.web;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.apache.poi.ss.usermodel.DateUtil;
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

import com.kia.ad.model.GCHA01MT;
import com.kia.ad.service.Ad04Service;

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
@RequestMapping("/service/ad04")
public class Ad04Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;
	
	@Value("#{appenv['file.prdListUpload']}")
	private String prdListUpload;

	@Resource
	private Ad04Service ad04Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	

	@RequestMapping("/extractChainXls")
	public ModelAndView extractChainXls(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
						
						Map record = new LinkedHashMap<String, String>();
						
						for (int j = 0; j < numOfCells; j++) {
							String value = "";
							Cell cell = row.getCell(j);
							
							if (cell != null) {
								switch (cell.getCellType()) {
								case Cell.CELL_TYPE_FORMULA :
									value = cell.getCellFormula();
									break;
								case Cell.CELL_TYPE_NUMERIC :
									if (DateUtil.isCellDateFormatted(cell)) {
										SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
										value = formatter.format(cell.getDateCellValue());
									}
									else {
										value = String.valueOf((long) cell.getNumericCellValue());
									}
									break;
								case Cell.CELL_TYPE_STRING :
									value = cell.getStringCellValue();
									break;
								case Cell.CELL_TYPE_BLANK :
									//value = String.valueOf(cell.getBooleanCellValue());
									value = cell.getStringCellValue();
									break;
								case Cell.CELL_TYPE_ERROR :
									value = String.valueOf(cell.getErrorCellValue());
									break;
								}
							}
							
							record.put("col" + String.valueOf(j), value);
						}
						
						
						String chainCD = record.get("col0").toString();
						String chainNm = record.get("col1").toString();
						
						if(chainCD.length() > 0 && chainNm.length() > 0) {

							data.put("chainCD", chainCD);
							data.put("chainNm", chainNm);
							
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
	
	@RequestMapping("/extractChainVenueXls")
	public ModelAndView extractChainVenueXls(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
						
						Map record = new LinkedHashMap<String, String>();
						
						for (int j = 0; j < numOfCells; j++) {
							String value = "";
							Cell cell = row.getCell(j);
							
							if (cell != null) {
								switch (cell.getCellType()) {
								case Cell.CELL_TYPE_FORMULA :
									value = cell.getCellFormula();
									break;
								case Cell.CELL_TYPE_NUMERIC :
									if (DateUtil.isCellDateFormatted(cell)) {
										SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
										value = formatter.format(cell.getDateCellValue());
									}
									else {
										value = String.valueOf((long) cell.getNumericCellValue());
									}
									break;
								case Cell.CELL_TYPE_STRING :
									value = cell.getStringCellValue();
									break;
								case Cell.CELL_TYPE_BLANK :
									//value = String.valueOf(cell.getBooleanCellValue());
									value = cell.getStringCellValue();
									break;
								case Cell.CELL_TYPE_ERROR :
									value = String.valueOf(cell.getErrorCellValue());
									break;
								}
							}
							
							record.put("col" + String.valueOf(j), value);
						}
						
						String chainCD = record.get("col0").toString();
						String venueCD = record.get("col1").toString();
						
						
						if (chainCD.length() > 0 && venueCD.length() > 0) {
						
							data.put("chainCD", chainCD);   
							data.put("venueCD", venueCD);   
							
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
	

	@RequestMapping("/saveChain")
	public ModelAndView saveChain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GCHA01MT gcha01mt = new GCHA01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
	
		bind(request, gcha01mt);
		
		try {
			gcha01mt.clean();
			gcha01mt.validate(gcha01mt.ACTION_SAVE);
			
			ad04Service.saveChain(gcha01mt);
			
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
	
	
	@RequestMapping("/saveChainVenue")
	public ModelAndView saveChainVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GCHA01MT gcha01mt = new GCHA01MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);
	
		bind(request, gcha01mt);
		
		try {
			gcha01mt.clean();
			gcha01mt.validate(gcha01mt.ACTION_SAVE);
			
			ad04Service.saveChainVenue(gcha01mt);
			
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
	
	
	
	
}