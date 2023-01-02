package kr.co.nis.waf.system.common.web;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.mvc.WafMultiActionController;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public class SimpleMultiActionController extends WafMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	protected void setObjectAll(ModelAndView mv, HttpServletRequest request, HttpServletResponse response, Map params) {
		SessionManager session = new SessionManager(request, response);
		
		params.putAll(session.getAttributeAll(request, params));

		super.setObjectAll(mv, request, params);
		
		if (logger.isDebugEnabled()) {
			logger.debug("*************************** Controller Parameter Value List - START ***************************");
			logger.debug(params);
			logger.debug("*************************** Controller Parameter Value List - END ***************************");
		}
	}
	
	protected void bindExcel(HttpServletRequest request, List data) throws Exception {
		
		//data = new ArrayList();
		
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator fileNameIterator = mpRequest.getFileNames();
		
		while (fileNameIterator.hasNext()) {
			MultipartFile multiFile = mpRequest.getFile((String) fileNameIterator.next());
			if (multiFile.getSize() > 0) {
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
				for (int i = 0; i < numOfRows; i++) {
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
						data.add(record);
					}
				}
			}
		}
		
		if (logger.isInfoEnabled()) {
			logger.info("*************************** Excel Upload Data - START ***************************");
			for (int i = 0; i < data.size(); i++) {
				Map record = (LinkedHashMap) data.get(i);
				String str = ""; 
				for (int j = 0; j < record.size(); j++) {
					if (j != 0) str += ", ";
					str += record.get("col" + String.valueOf(j));
				}
				logger.info(str);
			}
			logger.info("*************************** Excel Upload Data - END ***************************");
		}
		
	}
	
	protected void bindExcel(HttpServletRequest request, Model model, String[] header) throws Exception {
		super.bind(request, model);
		
		List data = new ArrayList();
		
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator fileNameIterator = mpRequest.getFileNames();
		
		
		while (fileNameIterator.hasNext()) {
			MultipartFile multiFile = mpRequest.getFile((String) fileNameIterator.next());
			if (multiFile.getSize() > 0) {
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
				
				List headerName = new ArrayList();
				List colDatas = new ArrayList();
				
				for (int i = 0; i < numOfRows; i++) {
					Row row = sheet.getRow(i);
					if (row != null) {
						
						if (i == 0) {
							if (header != null) {
								for (int j = 0; j < header.length; j++) {
									headerName.add(header[j]);
									colDatas.add(new ArrayList());
								}
							}
							else {
								for (int j = 0; j < numOfCells; j++) {
									Cell cell = row.getCell(j);
									if (cell == null) break;
									
									headerName.add(cell.getStringCellValue());
									colDatas.add(new ArrayList());
								}
							}
							continue;
						}
						
						for (int j = 0; j < headerName.size(); j++) {
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
							((ArrayList)colDatas.get(j)).add(i-1, value);
						}
					}
				} // end
				
				for (int i = 0; i < headerName.size(); i++) {
					List colData = (ArrayList)colDatas.get(i);
					String[] arrData = (String[])colData.toArray(new String[colData.size()]);
					
					Class oClass = model.getClass();
					String propName = headerName.get(i).toString();
					propName = propName.substring(0, 1).toUpperCase() + propName.substring(1); 
					try {
						Method method = oClass.getDeclaredMethod("set" + propName, new Class[]{String[].class});
						method.invoke(model, new Object[]{arrData});
					}
					catch (Exception e) {
						try {
							Method method = oClass.getDeclaredMethod("set" + propName, new Class[]{String.class});
							method.invoke(model, new Object[]{arrData[0]});
						}
						catch (Exception e1) {
							e1.printStackTrace();
						}
					}
				}
			}
		}
		
		logger.debug(model);
	}
}
