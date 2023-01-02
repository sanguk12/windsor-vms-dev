package com.kia.anl.web;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kia.anl.model.ESLT_AREA_MT;
import com.kia.anl.model.ESLT_BRANCH_MT;
import com.kia.anl.model.ESLT_CD_ACT;
import com.kia.anl.model.ESLT_CD_FC;
import com.kia.anl.model.ESLT_CD_TG;
import com.kia.anl.model.ESLT_CUSTOMER_MT;
import com.kia.anl.model.ESLT_DC_ACT;
import com.kia.anl.model.ESLT_DC_FC;
import com.kia.anl.model.ESLT_DC_FCACT;
import com.kia.anl.model.ESLT_DC_TG;
import com.kia.anl.model.ESLT_NOTEG_ACT;
import com.kia.anl.model.ESLT_NOTEG_FC;
import com.kia.anl.model.ESLT_NOTEG_TG;
import com.kia.anl.model.ESLT_NTS_ACT;
import com.kia.anl.model.ESLT_NTS_FC;
import com.kia.anl.model.ESLT_NTS_TG;
import com.kia.anl.model.ESLT_PRODUCT_MT;
import com.kia.anl.model.ESLT_PRODUCT_SEQ;
import com.kia.anl.model.ESLT_SH_ACT;
import com.kia.anl.model.ESLT_SH_FC;
import com.kia.anl.model.ESLT_SH_TG;
import com.kia.anl.model.ESLT_TEAM_MT;
import com.kia.anl.service.Anl02Service;


@Controller
@RequestMapping("/service/anl02")
public class Anl02Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Anl02Service anl02Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;

	@Value("#{system['docLink.realDownloadPath']}")
	private String realDownloadPath;

//	@Value("#{system['jXls.templateFilePath']}")
//	private String templateFilePath;
	
//	@Value("#{system['jXls.createTempFilePath']}")
//	private String createTempFilePath;
	
	// Shipment Master업로드
	@Value("#{appenv['file.esltBranchMtUpload']}")
	private String esltBranchMtFile;
	@Value("#{appenv['file.esltCustomerMtUpload']}")
	private String esltCustomerMtFile;
	@Value("#{appenv['file.esltProductMtUpload']}")
	private String esltProductMtFile;
	@Value("#{appenv['file.esltProductSeqUpload']}")
	private String esltProductSeqFile;
	
	// Depletion Master업로드
	@Value("#{appenv['file.esltTeamMtUpload']}")
	private String esltTeamMtFile;
	@Value("#{appenv['file.esltAreaMtUpload']}")
	private String esltAreaMtFile;
	
	// 실적자료 업로드
	@Value("#{appenv['file.esltShActUpload']}")
	private String esltShActFile;
	@Value("#{appenv['file.esltDcActUpload']}")
	private String esltDcActFile;
	@Value("#{appenv['file.esltDcFactUpload']}")
	private String esltDCFactFile;
	@Value("#{appenv['file.esltCdActUpload']}")
	private String esltCdActFile;
	@Value("#{appenv['file.esltNtsActUpload']}")
	private String esltNtsActFile;
	@Value("#{appenv['file.esltNotegActUpload']}")
	private String esltNotegActFile;
	
	// 목표자료 업로드
	@Value("#{appenv['file.esltShTgUpload']}")
	private String esltShTgFile;
	@Value("#{appenv['file.esltDcTgUpload']}")
	private String esltDcTgFile;
	@Value("#{appenv['file.esltCdTgUpload']}")
	private String esltCdTgFile;
	@Value("#{appenv['file.esltNtsTgUpload']}")
	private String esltNtsTgFile;
	@Value("#{appenv['file.esltNotegTgUpload']}")
	private String esltNotegTgFile;
	
	// Shipment Forecast 업로드
	@Value("#{appenv['file.esltShFcUpload']}")
	private String esltShFcFile;
	@Value("#{appenv['file.esltDcFcUpload']}")
	private String esltDcFcFile;
	@Value("#{appenv['file.esltCdFcUpload']}")
	private String esltCdFcFile;
	
	// Shipment Outlook 업로드
	@Value("#{appenv['file.esltShOlUpload']}")
	private String esltShOlFile;
	@Value("#{appenv['file.esltDcOlUpload']}")
	private String esltDcOlFile;
	@Value("#{appenv['file.esltCdOlUpload']}")
	private String esltCdOlFile;
	
	// Depletion Forecast 업로드
	@Value("#{appenv['file.esltNtsFcUpload']}")
	private String esltNtsFcFile;
	@Value("#{appenv['file.esltNotegFcUpload']}")
	private String esltNotegFcFile;
	
	// Depletion Outlook 업로드
	@Value("#{appenv['file.esltNtsOlUpload']}")
	private String esltNtsOlFile;
	@Value("#{appenv['file.esltNotegOlUpload']}")
	private String esltNotegOlFile;
		
	@RequestMapping("/downloadFile_ANL02001A")
	public ModelAndView downloadFile_ANL02001A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		
		logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
		
		if(request.getParameter("esltTbInfo").equals("1")){
			parameters.put("fileName", esltBranchMtFile);
			parameters.put("tempFileName", esltBranchMtFile);
		}else if(request.getParameter("esltTbInfo").equals("2")){
			parameters.put("fileName", esltCustomerMtFile);
			parameters.put("tempFileName", esltCustomerMtFile);
		}else if(request.getParameter("esltTbInfo").equals("3")){
			parameters.put("fileName", esltProductMtFile);
			parameters.put("tempFileName", esltProductMtFile);
		}else{
			parameters.put("fileName", esltProductSeqFile);
			parameters.put("tempFileName", esltProductSeqFile);
		}
		
		parameters.put("uploadDir", templateFilePath);
		
		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/downloadFile_ANL02002A")
	public ModelAndView downloadFile_ANL02002A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		
		logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
		
		if(request.getParameter("esltTbInfo").equals("5")){
			parameters.put("fileName", esltTeamMtFile);
			parameters.put("tempFileName", esltTeamMtFile);
		}else{
			parameters.put("fileName", esltAreaMtFile);
			parameters.put("tempFileName", esltAreaMtFile);
		}
		
		parameters.put("uploadDir", templateFilePath);
		
		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/downloadFile_ANL02003A")
	public ModelAndView downloadFile_ANL02003A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		
		logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
		
		if(request.getParameter("esltTbInfo").equals("7")){
			parameters.put("fileName", esltShActFile);
			parameters.put("tempFileName", esltShActFile);
		}else if(request.getParameter("esltTbInfo").equals("8")){
			parameters.put("fileName", esltDcActFile);
			parameters.put("tempFileName", esltDcActFile);
		}else if(request.getParameter("esltTbInfo").equals("9")){
			parameters.put("fileName", esltDCFactFile);
			parameters.put("tempFileName", esltDCFactFile);
		}else if(request.getParameter("esltTbInfo").equals("10")){
			parameters.put("fileName", esltCdActFile);
			parameters.put("tempFileName", esltCdActFile);
		}else if(request.getParameter("esltTbInfo").equals("11")){
			parameters.put("fileName", esltNtsActFile);
			parameters.put("tempFileName", esltNtsActFile);
		}else{
			parameters.put("fileName", esltNotegActFile);
			parameters.put("tempFileName", esltNotegActFile);
		}
		
		parameters.put("uploadDir", templateFilePath);
		
		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/downloadFile_ANL02004A")
	public ModelAndView downloadFile_ANL02004A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		
		logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
		
		if(request.getParameter("esltTbInfo").equals("13")){
			parameters.put("fileName", esltShTgFile);
			parameters.put("tempFileName", esltShTgFile);
		}else if(request.getParameter("esltTbInfo").equals("14")){
			parameters.put("fileName", esltDcTgFile);
			parameters.put("tempFileName", esltDcTgFile);
		}else if(request.getParameter("esltTbInfo").equals("15")){
			parameters.put("fileName", esltCdTgFile);
			parameters.put("tempFileName", esltCdTgFile);
		}else if(request.getParameter("esltTbInfo").equals("16")){
			parameters.put("fileName", esltNtsTgFile);
			parameters.put("tempFileName", esltNtsTgFile);
		}else{
			parameters.put("fileName", esltNotegTgFile);
			parameters.put("tempFileName", esltNotegTgFile);
		}
		
		parameters.put("uploadDir", templateFilePath);
		
		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/downloadFile_ANL02005A")
	public ModelAndView downloadFile_ANL02005A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		
		logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
		
		if(request.getParameter("esltTbInfo").equals("18")){
			parameters.put("fileName", esltShFcFile);
			parameters.put("tempFileName", esltShFcFile);
		}else if(request.getParameter("esltTbInfo").equals("19")){
			parameters.put("fileName", esltDcFcFile);
			parameters.put("tempFileName", esltDcFcFile);
		}else{
			parameters.put("fileName", esltCdFcFile);
			parameters.put("tempFileName", esltCdFcFile);
		}
		
		parameters.put("uploadDir", templateFilePath);
		
		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/downloadFile_ANL02006A")
	public ModelAndView downloadFile_ANL02006A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		
		logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
		
		if(request.getParameter("esltTbInfo").equals("23")){
			parameters.put("fileName", esltShOlFile);
			parameters.put("tempFileName", esltShOlFile);
		}else if(request.getParameter("esltTbInfo").equals("24")){
			parameters.put("fileName", esltDcOlFile);
			parameters.put("tempFileName", esltDcOlFile);
		}else{
			parameters.put("fileName", esltCdOlFile);
			parameters.put("tempFileName", esltCdOlFile);
		}
		
		parameters.put("uploadDir", templateFilePath);
		
		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/downloadFile_ANL02007A")
	public ModelAndView downloadFile_ANL02007A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		
		logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
		
		if(request.getParameter("esltTbInfo").equals("21")){
			parameters.put("fileName", esltNtsFcFile);
			parameters.put("tempFileName", esltNtsFcFile);
		}else{
			parameters.put("fileName", esltNotegFcFile);
			parameters.put("tempFileName", esltNotegFcFile);
		}
		
		parameters.put("uploadDir", templateFilePath);
		
		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/downloadFile_ANL02008A")
	public ModelAndView downloadFile_ANL02008A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		
		logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
		
		if(request.getParameter("esltTbInfo").equals("26")){
			parameters.put("fileName", esltNtsOlFile);
			parameters.put("tempFileName", esltNtsOlFile);
		}else{
			parameters.put("fileName", esltNotegOlFile);
			parameters.put("tempFileName", esltNotegOlFile);
		}
		
		parameters.put("uploadDir", templateFilePath);
		
		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/extract_ANL02001A_Xls")
	public ModelAndView extract_ANL02001A_Xls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> insertList = new ArrayList<Map<String, Cell>>();
		List<Map<String, Cell>> updateList = new ArrayList<Map<String, Cell>>();
		List<Map<?, ?>> resultList = new ArrayList<Map<?,?>>();
		int errorCount = 0;
		
		bind(request, params);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileNameIterator = mpRequest.getFileNames();

		try{
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
					
					int numOfRows = 20000;
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
					
					logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
					
					//i=1; except header
					for (int i = 1; i < numOfRows; i++) {
						Map data = new LinkedHashMap<String, String>();
						Row row = sheet.getRow(i);
						
						if (row != null) {
							
							if(request.getParameter("esltTbInfo").equals("1")){
								
								Cell c_branch = row.getCell(0);
								Cell c_region = row.getCell(1);
								Cell c_channel = row.getCell(2);
								Cell c_dispseq = row.getCell(3);
								Cell c_empid = row.getCell(4);
								Cell c_empid1 = row.getCell(5);
								Cell c_useyn = row.getCell(6);
								
								data.put("branch", c_branch);
								data.put("region", c_region);
								data.put("channel", c_channel);
								data.put("dispseq", c_dispseq);
								data.put("empid", c_empid);
								data.put("empid1", c_empid1);
								data.put("useyn", c_useyn);
								
							}else if(request.getParameter("esltTbInfo").equals("2")){
								
								Cell c_customerCd = row.getCell(0);
								Cell c_branch = row.getCell(1);
								
								String customerCD_Str = null;
								String customerCD = null;
								
								customerCD_Str = c_customerCd.toString();
								customerCD = customerCD_Str.replace(".0", "");
								
								data.put("customerCd", customerCD);
								data.put("branch", c_branch);
								
							}else if(request.getParameter("esltTbInfo").equals("3")){
								
								Cell c_productL7 = row.getCell(0);
								Cell c_productL2 = row.getCell(1);
								Cell c_productL3 = row.getCell(2);
								Cell c_productL6 = row.getCell(3);
								Cell c_esltProduct = row.getCell(4);
								Cell c_esltProduct2 = row.getCell(5);
								
								String productL7 = null;
								
								if(c_productL7 != null){
									productL7 = c_productL7.getStringCellValue().replace("'", "`").toString();
								}
								
								String productL3 = null;
								
								if(c_productL3 != null){
									productL3 = c_productL3.getStringCellValue().replace("'", "`").toString();
								}
								
								data.put("productL7", productL7);
								data.put("productL2", c_productL2);
								data.put("productL3", productL3);
								data.put("productL6", c_productL6);
								data.put("esltProduct", c_esltProduct);
								data.put("esltProduct2", c_esltProduct2);
								
							}else{
								
								String dispSeq_Str = null;
								String dispSeq = null;
								
								Cell c_dataLv2 = row.getCell(0);
								Cell c_esltProduct = row.getCell(1);
								Cell c_dispSeq = row.getCell(2);
								
								dispSeq_Str = c_dispSeq.toString();
								dispSeq = dispSeq_Str.replace(".0", "");
								
								data.put("dataLv2", c_dataLv2);
								data.put("esltProduct", c_esltProduct);
								data.put("dispSeq", dispSeq);
								
							}
							
							data.put("errorCode", "S");
							resultList.add(data);
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
		}
		catch (Exception e) {
			Map data = new HashMap();
			data.put("errorCode", "E");
			data.put("errorMessage", "입력정보를 확인 하십시오.");
			resultList.add(data);
			e.printStackTrace();
		}

		SimpleDoc simpleDoc = new SimpleDoc("JSON", resultList);

		return simpleDoc.create();
	}
	
	@RequestMapping("/extract_ANL02002A_Xls")
	public ModelAndView extract_ANL02002A_Xls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> insertList = new ArrayList<Map<String, Cell>>();
		List<Map<String, Cell>> updateList = new ArrayList<Map<String, Cell>>();
		List<Map<?, ?>> resultList = new ArrayList<Map<?,?>>();
		int errorCount = 0;
		
		bind(request, params);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileNameIterator = mpRequest.getFileNames();

		try{
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
					
					int numOfRows = 20000;
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
					
					logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
					
					//i=1; except header
					for (int i = 1; i < numOfRows; i++) {
						Map data = new LinkedHashMap<String, String>();
						Row row = sheet.getRow(i);
						
						if (row != null) {
							
							if(request.getParameter("esltTbInfo").equals("5")){
							
								Cell c_team = row.getCell(0);
								Cell c_region = row.getCell(1);
								Cell c_channel = row.getCell(2);
								Cell c_dispseq = row.getCell(3);
								Cell c_empid = row.getCell(4);
								Cell c_empid1 = row.getCell(5);
								Cell c_useyn = row.getCell(6);
								
								data.put("team", c_team);
								data.put("region", c_region);
								data.put("channel", c_channel);
								data.put("dispseq", c_dispseq);
								data.put("empid", c_empid);
								data.put("empid1", c_empid1);
								data.put("useyn", c_useyn);
								
							}else{
								
								Cell c_city = row.getCell(0);
								Cell c_subCity1 = row.getCell(1);
								Cell c_subCity2 = row.getCell(2);
								Cell c_lpbTeam = row.getCell(3);
								Cell c_gpbTeam = row.getCell(4);
								
								data.put("city", c_city);
								data.put("subCity1", c_subCity1);
								data.put("subCity2", c_subCity2);
								data.put("lpbTeam", c_lpbTeam);
								data.put("gpbTeam", c_gpbTeam);
								
							}
							
							data.put("errorCode", "S");
							resultList.add(data);
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
		}
		catch (Exception e) {
			Map data = new HashMap();
			data.put("errorCode", "E");
			data.put("errorMessage", "입력정보를 확인 하십시오.");
			resultList.add(data);
			e.printStackTrace();
		}

		SimpleDoc simpleDoc = new SimpleDoc("JSON", resultList);

		return simpleDoc.create();
	}

	@RequestMapping("/extract_ANL02003A_Xls")
	public ModelAndView extract_ANL02003A_Xls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> insertList = new ArrayList<Map<String, Cell>>();
		List<Map<String, Cell>> updateList = new ArrayList<Map<String, Cell>>();
		List<Map<?, ?>> resultList = new ArrayList<Map<?,?>>();
		int errorCount = 0;
		
		bind(request, params);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileNameIterator = mpRequest.getFileNames();

		try{
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
					
					int numOfRows = 300000;
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
					
					logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
					
					//i=1; except header
					for (int i = 1; i < numOfRows; i++) {
						Map data = new LinkedHashMap<String, String>();
						Row row = sheet.getRow(i);
						
						if (row != null) {
							
							if(request.getParameter("esltTbInfo").equals("7")){
								
							
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_customercd = row.getCell(2);
								Cell c_productL7 = row.getCell(3);
								Cell c_productL8 = row.getCell(4);
								double c_volume = getTypeCastingDouble(row.getCell(5));
								int c_amount = getTypeCasting(row.getCell(6));
								
								String productL7 = null;
								String customerCd_Str = null;
								String customerCd_Chg = null;
								
								if(c_productL7 != null){
									productL7 = c_productL7.getStringCellValue().replace("'", "`").toString();
								}
								
								customerCd_Str = c_customercd.toString();
								
								customerCd_Chg = customerCd_Str.replace(".0", "");
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("customercd", customerCd_Chg);
								data.put("productL7", productL7);
								data.put("productL8", c_productL8);
								data.put("volume", c_volume);
								data.put("amount", c_amount);
								
							}else if(request.getParameter("esltTbInfo").equals("8")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_customercd = row.getCell(2);
								Cell c_productL2 = row.getCell(3);
								Cell c_productL7 = row.getCell(4);
								double c_volume = getTypeCastingDouble(row.getCell(5));
								
								String productL7 = null;
								String customerCd_Str = null;
								String customerCd_Chg = null;
								
								if(c_productL7 != null){
									productL7 = c_productL7.getStringCellValue().replace("'", "`").toString();
								}
								
								customerCd_Str = c_customercd.toString();
								
								customerCd_Chg = customerCd_Str.replace(".0", "");
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("customercd", customerCd_Chg);
								data.put("productL2", c_productL2);
								data.put("productL7", productL7);
								data.put("volume", c_volume);
								
							}else if(request.getParameter("esltTbInfo").equals("9")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_branch = row.getCell(2);
								Cell c_datatype = row.getCell(3);
								Cell c_productL2 = row.getCell(4);
								double c_volume = getTypeCastingDouble(row.getCell(5));
								 
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("branch", c_branch);
								data.put("datatype", c_datatype);
								data.put("productL2", c_productL2);
								data.put("volume", c_volume);
								
							}else if(request.getParameter("esltTbInfo").equals("10")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_customercd = row.getCell(2);
								Cell c_datatype = row.getCell(3);
								double c_volume = getTypeCastingDouble(row.getCell(4));
								 
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("customercd", c_customercd);
								data.put("datatype", c_datatype);
								data.put("volume", c_volume);
								
							}else if(request.getParameter("esltTbInfo").equals("11")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_city = row.getCell(2);
								Cell c_subcity1 = row.getCell(3);
								Cell c_subcity2 = row.getCell(4);
								Cell c_market = row.getCell(5);
								Cell c_segment = row.getCell(6);
								Cell c_channel = row.getCell(7);
								Cell c_company = row.getCell(8);
								double c_volume = getTypeCastingDouble(row.getCell(9));
								
								String market = null;
								
								if(c_market != null){
									market = c_market.getStringCellValue().replace("'", "`").toString();
								}
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("city", c_city);
								data.put("subcity1", c_subcity1);
								data.put("subcity2", c_subcity2);
								data.put("market", market);
								data.put("segment", c_segment);
								data.put("channel", c_channel);
								data.put("company", c_company);
								data.put("volume", c_volume);
								
							}else{
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_venueID = row.getCell(2);
								Cell c_city = row.getCell(3);
								Cell c_subcity1 = row.getCell(4);
								Cell c_subcity2 = row.getCell(5);
								Cell c_market = row.getCell(6);
								Cell c_productL7 = row.getCell(7);
								double c_volume = getTypeCastingDouble(row.getCell(8));
								int c_amount = getTypeCasting(row.getCell(9));
								
								String market = null;
								
								if(c_market != null){
									market = c_market.getStringCellValue().replace("'", "`").toString();
								}
								
								String productL7 = null;
								
								if(c_productL7 != null){
									productL7 = c_productL7.getStringCellValue().replace("'", "`").toString();
								}
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("venueID", c_venueID);
								data.put("city", c_city);
								data.put("subCity1", c_subcity1);
								data.put("subCity2", c_subcity2);
								data.put("market", market);
								data.put("productL7", productL7);
								data.put("volume", c_volume);
								data.put("amount", c_amount);
								
							}
							
							data.put("errorCode", "S");
							resultList.add(data);
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
		}
		catch (Exception e) {
			Map data = new HashMap();
			data.put("errorCode", "E");
			data.put("errorMessage", "입력정보를 확인 하십시오.");
			resultList.add(data);
			e.printStackTrace();
		}

		SimpleDoc simpleDoc = new SimpleDoc("JSON", resultList);

		return simpleDoc.create();
	}
	
	@RequestMapping("/extract_ANL02004A_Xls")
	public ModelAndView extract_ANL02004A_Xls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> insertList = new ArrayList<Map<String, Cell>>();
		List<Map<String, Cell>> updateList = new ArrayList<Map<String, Cell>>();
		List<Map<?, ?>> resultList = new ArrayList<Map<?,?>>();
		int errorCount = 0;
		
		bind(request, params);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileNameIterator = mpRequest.getFileNames();

		try{
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
					
					int numOfRows = 20000;
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
					
					logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
					
					//i=1; except header
					for (int i = 1; i < numOfRows; i++) {
						Map data = new LinkedHashMap<String, String>();
						Row row = sheet.getRow(i);
						
						if (row != null) {
							
							if(request.getParameter("esltTbInfo").equals("13")){
							
								Cell c_fy =  row.getCell(0);
								Cell c_period =  row.getCell(1);
								Cell c_branch =  row.getCell(2);
								Cell c_productL7 =  row.getCell(3);
								double c_volume =  getTypeCastingDouble(row.getCell(4));
								
								String productL7 = null;
								
								if(c_productL7 != null){
									productL7 = c_productL7.getStringCellValue().replace("'", "`").toString();
								}
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("branch", c_branch);
								data.put("productL7", productL7);
								data.put("volume", c_volume);
								
							}else if(request.getParameter("esltTbInfo").equals("14")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_branch = row.getCell(2);
								Cell c_dataType = row.getCell(3);
								Cell c_productL2 = row.getCell(4);
								double c_volume = getTypeCastingDouble(row.getCell(5));
								 
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("branch", c_branch);
								data.put("dataType", c_dataType);
								data.put("productL2", c_productL2);
								data.put("volume", c_volume);
								
							}else if(request.getParameter("esltTbInfo").equals("15")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_branch = row.getCell(2);
								Cell c_periodType = row.getCell(3);
								Cell c_branchType = row.getCell(4);
								Cell c_ratio = row.getCell(5);
								 
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("branch", c_branch);
								data.put("periodType", c_periodType);
								data.put("branchType", c_branchType);
								data.put("ratio", c_ratio);
								
							}else if(request.getParameter("esltTbInfo").equals("16")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_team = row.getCell(2);
								Cell c_market = row.getCell(3);
								Cell c_segment = row.getCell(4);
								Cell c_channel = row.getCell(5);
								Cell c_company = row.getCell(6);
								double c_volume = getTypeCastingDouble(row.getCell(7));
								
								String market = null;
								
								if(c_market != null){
									market = c_market.getStringCellValue().replace("'", "`").toString();
								}
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("team", c_team);
								data.put("market", market);
								data.put("segment", c_segment);
								data.put("channel", c_channel);
								data.put("company", c_company);
								data.put("volume", c_volume);
								
							}else{
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_team = row.getCell(2);
								Cell c_market = row.getCell(3);
								double c_volume = getTypeCastingDouble(row.getCell(4));
								double c_amount = getTypeCastingDouble(row.getCell(5));
								
								String market = null;
								
								if(c_market != null){
									market = c_market.getStringCellValue().replace("'", "`").toString();
								}
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("team", c_team);
								data.put("market", market);
								data.put("volume", c_volume);
								data.put("amount", c_amount);
								
							}
							
							data.put("errorCode", "S");
							resultList.add(data);
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
		}
		catch (Exception e) {
			Map data = new HashMap();
			data.put("errorCode", "E");
			data.put("errorMessage", "입력정보를 확인 하십시오.");
			resultList.add(data);
			e.printStackTrace();
		}

		SimpleDoc simpleDoc = new SimpleDoc("JSON", resultList);

		return simpleDoc.create();
	}
	
	@RequestMapping("/extract_ANL02005A_Xls")
	public ModelAndView extract_ANL02005A_Xls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> insertList = new ArrayList<Map<String, Cell>>();
		List<Map<String, Cell>> updateList = new ArrayList<Map<String, Cell>>();
		List<Map<?, ?>> resultList = new ArrayList<Map<?,?>>();
		int errorCount = 0;
		
		bind(request, params);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileNameIterator = mpRequest.getFileNames();

		try{
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
					
					int numOfRows = 20000;
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
					
					logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
					logger.debug("quarter1UseYn_h: "+request.getParameter("quarter1UseYn_h"));
					logger.debug("quarter2UseYn_h: "+request.getParameter("quarter2UseYn_h"));
					logger.debug("quarter3UseYn_h: "+request.getParameter("quarter3UseYn_h"));
					logger.debug("quarter4UseYn_h: "+request.getParameter("quarter4UseYn_h"));
					
					//i=1; except header
					for (int i = 1; i < numOfRows; i++) {
						Map data = new LinkedHashMap<String, String>();
						Row row = sheet.getRow(i);
						
						if (row != null) {
							
							if(request.getParameter("esltTbInfo").equals("18")){
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_esltProduct = row.getCell(2);
								Cell c_productL2 = row.getCell(3);
								Cell c_productL3 = row.getCell(4);
								double c_forVolume = getTypeCastingDouble(row.getCell(5));
								double c_outVolume = getTypeCastingDouble(row.getCell(5));
								
								String productL3 = null;
								
								if(c_productL3 != null){
									productL3 = c_productL3.getStringCellValue().replace("'", "`").toString();
								}
								
								if(c_period.getStringCellValue().equals("P01") || c_period.getStringCellValue().equals("P02") || c_period.getStringCellValue().equals("P03")){
									if(request.getParameter("quarter1UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("esltProduct", c_esltProduct);
										data.put("productL2", c_productL2);
										data.put("productL3", productL3);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P04") || c_period.getStringCellValue().equals("P05") || c_period.getStringCellValue().equals("P06")){
									if(request.getParameter("quarter2UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("esltProduct", c_esltProduct);
										data.put("productL2", c_productL2);
										data.put("productL3", productL3);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P07") || c_period.getStringCellValue().equals("P08") || c_period.getStringCellValue().equals("P09")){
									if(request.getParameter("quarter3UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("esltProduct", c_esltProduct);
										data.put("productL2", c_productL2);
										data.put("productL3", productL3);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P10") || c_period.getStringCellValue().equals("P11") || c_period.getStringCellValue().equals("P12")){
									if(request.getParameter("quarter4UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("esltProduct", c_esltProduct);
										data.put("productL2", c_productL2);
										data.put("productL3", productL3);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}
								
							}else if(request.getParameter("esltTbInfo").equals("19")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_dataType = row.getCell(2);
								Cell c_productL2 = row.getCell(3);
								double c_forVolume = getTypeCastingDouble(row.getCell(4));
								double c_outVolume = getTypeCastingDouble(row.getCell(4));
								
								if(c_period.getStringCellValue().equals("P01") || c_period.getStringCellValue().equals("P02") || c_period.getStringCellValue().equals("P03")){
									if(request.getParameter("quarter1UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("dataType", c_dataType);
										data.put("productL2", c_productL2);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_forVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P04") || c_period.getStringCellValue().equals("P05") || c_period.getStringCellValue().equals("P06")){
									if(request.getParameter("quarter2UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("dataType", c_dataType);
										data.put("productL2", c_productL2);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_forVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P07") || c_period.getStringCellValue().equals("P08") || c_period.getStringCellValue().equals("P09")){
									if(request.getParameter("quarter3UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("dataType", c_dataType);
										data.put("productL2", c_productL2);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_forVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P10") || c_period.getStringCellValue().equals("P11") || c_period.getStringCellValue().equals("P12")){
									if(request.getParameter("quarter4UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("dataType", c_dataType);
										data.put("productL2", c_productL2);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_forVolume);
									}else{
										continue;
									}
								}
								
							}else{
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_dataType = row.getCell(2);
								double c_forVolume = getTypeCastingDouble(row.getCell(3));
								double c_outVolume = getTypeCastingDouble(row.getCell(3));
								
								if(c_period.getStringCellValue().equals("P01") || c_period.getStringCellValue().equals("P02") || c_period.getStringCellValue().equals("P03")){
									if(request.getParameter("quarter1UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("dataType", c_dataType);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P04") || c_period.getStringCellValue().equals("P05") || c_period.getStringCellValue().equals("P06")){
									if(request.getParameter("quarter2UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("dataType", c_dataType);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P07") || c_period.getStringCellValue().equals("P08") || c_period.getStringCellValue().equals("P09")){
									if(request.getParameter("quarter3UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("dataType", c_dataType);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P10") || c_period.getStringCellValue().equals("P11") || c_period.getStringCellValue().equals("P12")){
									if(request.getParameter("quarter4UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("dataType", c_dataType);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}
							}
							
							data.put("errorCode", "S");
							resultList.add(data);
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
		}
		catch (Exception e) {
			Map data = new HashMap();
			data.put("errorCode", "E");
			data.put("errorMessage", "입력정보를 확인 하십시오.");
			resultList.add(data);
			e.printStackTrace();
		}

		SimpleDoc simpleDoc = new SimpleDoc("JSON", resultList);

		return simpleDoc.create();
	}
	
	@RequestMapping("/extract_ANL02006A_Xls")
	public ModelAndView extract_ANL02006A_Xls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> insertList = new ArrayList<Map<String, Cell>>();
		List<Map<String, Cell>> updateList = new ArrayList<Map<String, Cell>>();
		List<Map<?, ?>> resultList = new ArrayList<Map<?,?>>();
		int errorCount = 0;
		
		bind(request, params);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileNameIterator = mpRequest.getFileNames();

		try{
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
					
					int numOfRows = 20000;
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
					
					logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
					
					//i=1; except header
					for (int i = 1; i < numOfRows; i++) {
						Map data = new LinkedHashMap<String, String>();
						Row row = sheet.getRow(i);
						
						if (row != null) {
							
							if(request.getParameter("esltTbInfo").equals("23")){
							
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_esltProduct = row.getCell(2);
								Cell c_productL2 = row.getCell(3);
								Cell c_productL3 = row.getCell(4);
								double c_outVolume = getTypeCastingDouble(row.getCell(5));
								
								String productL3 = null;
								
								if(c_productL3 != null){
									productL3 = c_productL3.getStringCellValue().replace("'", "`").toString();
								}
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("esltProduct", c_esltProduct);
								data.put("productL2", c_productL2);
								data.put("productL3", productL3);
								data.put("outVolume", c_outVolume);
								
							}else if(request.getParameter("esltTbInfo").equals("24")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_dataType = row.getCell(2);
								Cell c_productL2 = row.getCell(3);
								double c_outVolume = getTypeCastingDouble(row.getCell(4));
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("dataType", c_dataType);
								data.put("productL2", c_productL2);
								data.put("outVolume", c_outVolume);
								
							}else{
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_dataType = row.getCell(2);
								double c_outVolume = getTypeCastingDouble(row.getCell(3));
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("dataType", c_dataType);
								data.put("outVolume", c_outVolume);
								
							}
							
							data.put("errorCode", "S");
							resultList.add(data);
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
		}
		catch (Exception e) {
			Map data = new HashMap();
			data.put("errorCode", "E");
			data.put("errorMessage", "입력정보를 확인 하십시오.");
			resultList.add(data);
			e.printStackTrace();
		}

		SimpleDoc simpleDoc = new SimpleDoc("JSON", resultList);

		return simpleDoc.create();
	}
	
	@RequestMapping("/extract_ANL02007A_Xls")
	public ModelAndView extract_ANL02007A_Xls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> insertList = new ArrayList<Map<String, Cell>>();
		List<Map<String, Cell>> updateList = new ArrayList<Map<String, Cell>>();
		List<Map<?, ?>> resultList = new ArrayList<Map<?,?>>();
		int errorCount = 0;
		
		bind(request, params);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileNameIterator = mpRequest.getFileNames();

		try{
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
					
					int numOfRows = 20000;
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
					
					logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
					
					//i=1; except header
					for (int i = 1; i < numOfRows; i++) {
						Map data = new LinkedHashMap<String, String>();
						Row row = sheet.getRow(i);
						
						if (row != null) {
							
							if(request.getParameter("esltTbInfo").equals("21")){
							
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_market = row.getCell(2);
								Cell c_segment = row.getCell(3);
								Cell c_channel = row.getCell(4);
								Cell c_company = row.getCell(5);
								double c_forVolume = getTypeCastingDouble(row.getCell(6));
								double c_outVolume = getTypeCastingDouble(row.getCell(6));
								
								String market = null;
								
								if(c_market != null){
									market = c_market.getStringCellValue().replace("'", "`").toString();
								}
								
								if(c_period.getStringCellValue().equals("P01") || c_period.getStringCellValue().equals("P02") || c_period.getStringCellValue().equals("P03")){
									if(request.getParameter("quarter1UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("market", market);
										data.put("segment", c_segment);
										data.put("channel", c_channel);
										data.put("company", c_company);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P04") || c_period.getStringCellValue().equals("P05") || c_period.getStringCellValue().equals("P06")){
									if(request.getParameter("quarter2UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("market", market);
										data.put("segment", c_segment);
										data.put("channel", c_channel);
										data.put("company", c_company);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P07") || c_period.getStringCellValue().equals("P08") || c_period.getStringCellValue().equals("P09")){
									if(request.getParameter("quarter3UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("market", market);
										data.put("segment", c_segment);
										data.put("channel", c_channel);
										data.put("company", c_company);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P10") || c_period.getStringCellValue().equals("P11") || c_period.getStringCellValue().equals("P12")){
									if(request.getParameter("quarter4UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("market", market);
										data.put("segment", c_segment);
										data.put("channel", c_channel);
										data.put("company", c_company);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
									}else{
										continue;
									}
								}
								
							}else{
								
								Cell c_fy = row.getCell(0);
								
								Cell c_period = row.getCell(1);
								Cell c_market = row.getCell(2);
								double c_forVolume = getTypeCastingDouble(row.getCell(3));
								double c_outVolume = getTypeCastingDouble(row.getCell(3));
								int c_forAmount = getTypeCasting(row.getCell(4));
								int c_outAmount = getTypeCasting(row.getCell(4));
								
								String market = null;
								
								if(c_market != null){
									market = c_market.getStringCellValue().replace("'", "`").toString();
								}
								
								if(c_period.getStringCellValue().equals("P01") || c_period.getStringCellValue().equals("P02") || c_period.getStringCellValue().equals("P03")){
									if(request.getParameter("quarter1UseYn_h").equals("Y")){
										
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("market", market);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
										data.put("forAmount", c_forAmount);
										data.put("outAmount", c_outAmount);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P04") || c_period.getStringCellValue().equals("P05") || c_period.getStringCellValue().equals("P06")){
									if(request.getParameter("quarter2UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("market", market);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
										data.put("forAmount", c_forAmount);
										data.put("outAmount", c_outAmount);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P07") || c_period.getStringCellValue().equals("P08") || c_period.getStringCellValue().equals("P09")){
									if(request.getParameter("quarter3UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("market", market);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
										data.put("forAmount", c_forAmount);
										data.put("outAmount", c_outAmount);
									}else{
										continue;
									}
								}else if(c_period.getStringCellValue().equals("P10") || c_period.getStringCellValue().equals("P11") || c_period.getStringCellValue().equals("P12")){
									if(request.getParameter("quarter4UseYn_h").equals("Y")){
										data.put("fy", c_fy);
										data.put("period", c_period);
										data.put("market", market);
										data.put("forVolume", c_forVolume);
										data.put("outVolume", c_outVolume);
										data.put("forAmount", c_forAmount);
										data.put("outAmount", c_outAmount);
									}else{
										continue;
									}
								}
							}
							
							data.put("errorCode", "S");
							resultList.add(data);
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
		}
		catch (Exception e) {
			Map data = new HashMap();
			data.put("errorCode", "E");
			data.put("errorMessage", "입력정보를 확인 하십시오.");
			resultList.add(data);
			e.printStackTrace();
		}

		SimpleDoc simpleDoc = new SimpleDoc("JSON", resultList);

		return simpleDoc.create();
	}
	
	@RequestMapping("/extract_ANL02008A_Xls")
	public ModelAndView extract_ANL02008A_Xls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> insertList = new ArrayList<Map<String, Cell>>();
		List<Map<String, Cell>> updateList = new ArrayList<Map<String, Cell>>();
		List<Map<?, ?>> resultList = new ArrayList<Map<?,?>>();
		int errorCount = 0;
		
		bind(request, params);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileNameIterator = mpRequest.getFileNames();

		try{
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
					
					int numOfRows = 20000;
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
					
					logger.debug("esltTbInfo: "+request.getParameter("esltTbInfo"));
					
					//i=1; except header
					for (int i = 1; i < numOfRows; i++) {
						Map data = new LinkedHashMap<String, String>();
						Row row = sheet.getRow(i);
						
						if (row != null) {
							
							if(request.getParameter("esltTbInfo").equals("26")){
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_market = row.getCell(2);
								Cell c_segment = row.getCell(3);
								Cell c_channel = row.getCell(4);
								Cell c_company = row.getCell(5);
								double c_outVolume = getTypeCastingDouble(row.getCell(6));
								
								String market = null;
								
								if(c_market != null){
									market = c_market.getStringCellValue().replace("'", "`").toString();
								}
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("market", market);
								data.put("segment", c_segment);
								data.put("channel", c_channel);
								data.put("company", c_company);
								data.put("outVolume", c_outVolume);
								
							}else{
								
								Cell c_fy = row.getCell(0);
								Cell c_period = row.getCell(1);
								Cell c_market = row.getCell(2);
								double c_outVolume = getTypeCastingDouble(row.getCell(3));
								int c_outAmount = getTypeCasting(row.getCell(4));
								
								String market = null;
								
								if(c_market != null){
									market = c_market.getStringCellValue().replace("'", "`").toString();
								}
								
								data.put("fy", c_fy);
								data.put("period", c_period);
								data.put("market", market);
								data.put("outVolume", c_outVolume);
								data.put("outAmount", c_outAmount);
								
							}
							
							data.put("errorCode", "S");
							resultList.add(data);
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
		}
		catch (Exception e) {
			Map data = new HashMap();
			data.put("errorCode", "E");
			data.put("errorMessage", "입력정보를 확인 하십시오.");
			resultList.add(data);
			e.printStackTrace();
		}

		SimpleDoc simpleDoc = new SimpleDoc("JSON", resultList);

		return simpleDoc.create();
	}
	
	@RequestMapping("/save_ANL02001A")
	public ModelAndView save_ANL02001A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		
		ESLT_BRANCH_MT eslt_branch_mt = new ESLT_BRANCH_MT();
		ESLT_CUSTOMER_MT eslt_customer_mt = new ESLT_CUSTOMER_MT();
		ESLT_PRODUCT_MT eslt_product_mt = new ESLT_PRODUCT_MT();
		ESLT_PRODUCT_SEQ eslt_product_seq = new ESLT_PRODUCT_SEQ();

		bind(request, eslt_branch_mt);
		bind(request, eslt_customer_mt);
		bind(request, eslt_product_mt);
		bind(request, eslt_product_seq);
		
		try {
			
			if(request.getParameter("esltTbInfo").equals("1")){
				
				eslt_branch_mt.clean();
				eslt_branch_mt.validate(eslt_branch_mt.ACTION_SAVE);
				
				anl02Service.save_ESLT_BRANCH_MT(eslt_branch_mt);
				
			}else if(request.getParameter("esltTbInfo").equals("2")){
				
				eslt_customer_mt.clean();
				eslt_customer_mt.validate(eslt_customer_mt.ACTION_SAVE);
				
				anl02Service.save_ESLT_CUSTOMER_MT(eslt_customer_mt);
				
			}else if(request.getParameter("esltTbInfo").equals("3")){
				
				eslt_product_mt.clean();
				eslt_product_mt.validate(eslt_product_mt.ACTION_SAVE);
				
				anl02Service.save_ESLT_PRODUCT_MT(eslt_product_mt);
				
			}else{
				
				eslt_product_seq.clean();
				eslt_product_seq.validate(eslt_product_seq.ACTION_SAVE);
				
				anl02Service.save_ESLT_PRODUCT_SEQ(eslt_product_seq);
				
			}
			
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
	
	@RequestMapping("/save_ANL02002A")
	public ModelAndView save_ANL02002A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		
		ESLT_TEAM_MT eslt_team_mt = new ESLT_TEAM_MT();
		ESLT_AREA_MT eslt_area_mt = new ESLT_AREA_MT();
		
		bind(request, eslt_team_mt);
		bind(request, eslt_area_mt);
		
		try {
			
			if(request.getParameter("esltTbInfo").equals("5")){
				
				eslt_team_mt.clean();
				eslt_team_mt.validate(eslt_team_mt.ACTION_SAVE);
				
				anl02Service.save_ESLT_TEAM_MT(eslt_team_mt);
				
			}else{
				
				eslt_area_mt.clean();
				eslt_area_mt.validate(eslt_area_mt.ACTION_SAVE);
				
				anl02Service.save_ESLT_AREA_MT(eslt_area_mt);
				
			}
			
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
	
	@RequestMapping("/save_ANL02003A")
	public ModelAndView save_ANL02003A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		
		ESLT_SH_ACT eslt_sh_act = new ESLT_SH_ACT();
		ESLT_DC_ACT eslt_dc_act = new ESLT_DC_ACT();
		ESLT_DC_FCACT eslt_dc_fcact = new ESLT_DC_FCACT();
		ESLT_CD_ACT eslt_cd_act = new ESLT_CD_ACT();
		ESLT_NTS_ACT eslt_nts_act = new ESLT_NTS_ACT();
		ESLT_NOTEG_ACT eslt_noteg_act = new ESLT_NOTEG_ACT();

		bind(request, eslt_sh_act);
		bind(request, eslt_dc_act);
		bind(request, eslt_dc_fcact);
		bind(request, eslt_cd_act);
		bind(request, eslt_nts_act);
		bind(request, eslt_noteg_act);
		
		try {
			System.out.println("//////////////esltTbInfo:"+request.getParameter("esltTbInfo"));
			if(request.getParameter("esltTbInfo").equals("7")){
				
				eslt_sh_act.clean();
				eslt_sh_act.validate(eslt_sh_act.ACTION_SAVE);
				
				anl02Service.save_ESLT_SH_ACT(eslt_sh_act);
				
			}else if(request.getParameter("esltTbInfo").equals("8")){
				
				eslt_dc_act.clean();
				eslt_dc_act.validate(eslt_dc_act.ACTION_SAVE);
				
				anl02Service.save_ESLT_DC_ACT(eslt_dc_act);
				
			}else if(request.getParameter("esltTbInfo").equals("9")){
				
				eslt_dc_fcact.clean();
				eslt_dc_fcact.validate(eslt_dc_fcact.ACTION_SAVE);
				
				anl02Service.save_ESLT_DC_FCACT(eslt_dc_fcact);
			
			}else if(request.getParameter("esltTbInfo").equals("10")){
			
				eslt_cd_act.clean();
				eslt_cd_act.validate(eslt_cd_act.ACTION_SAVE);
				
				anl02Service.save_ESLT_CD_ACT(eslt_cd_act);
				
			}else if(request.getParameter("esltTbInfo").equals("11")){
				
				eslt_nts_act.clean();
				eslt_nts_act.validate(eslt_nts_act.ACTION_SAVE);
				
				anl02Service.save_ESLT_NTS_ACT(eslt_nts_act);
				
			}else{
				
				eslt_noteg_act.clean();
				eslt_noteg_act.validate(eslt_noteg_act.ACTION_SAVE);
				
				anl02Service.save_ESLT_NOTEG_ACT(eslt_noteg_act);
				
			}
			
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
	
	@RequestMapping("/save_ANL02004A")
	public ModelAndView save_ANL02004A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		
		ESLT_SH_TG eslt_sh_tg = new ESLT_SH_TG();
		ESLT_DC_TG eslt_dc_tg = new ESLT_DC_TG();
		ESLT_CD_TG eslt_cd_tg = new ESLT_CD_TG();
		ESLT_NTS_TG eslt_nts_tg = new ESLT_NTS_TG();
		ESLT_NOTEG_TG eslt_noteg_tg = new ESLT_NOTEG_TG();

		bind(request, eslt_sh_tg);
		bind(request, eslt_dc_tg);
		bind(request, eslt_cd_tg);
		bind(request, eslt_nts_tg);
		bind(request, eslt_noteg_tg);
		
		System.out.println("//////////////esltTbInfo:"+request.getParameter("esltTbInfo"));
		
		try {
			
			if(request.getParameter("esltTbInfo").equals("13")){
				
				eslt_sh_tg.clean();
				eslt_sh_tg.validate(eslt_sh_tg.ACTION_SAVE);
				
				anl02Service.save_ESLT_SH_TG_TEMP(eslt_sh_tg);
				
			}else if(request.getParameter("esltTbInfo").equals("14")){
				
				eslt_dc_tg.clean();
				eslt_dc_tg.validate(eslt_dc_tg.ACTION_SAVE);
				
				anl02Service.save_ESLT_DC_TG_TEMP(eslt_dc_tg);
				
			}else if(request.getParameter("esltTbInfo").equals("15")){
				
				eslt_cd_tg.clean();
				eslt_cd_tg.validate(eslt_cd_tg.ACTION_SAVE);
				
				anl02Service.save_ESLT_CD_TG_TEMP(eslt_cd_tg);
			
			}else if(request.getParameter("esltTbInfo").equals("16")){
			
				eslt_nts_tg.clean();
				eslt_nts_tg.validate(eslt_nts_tg.ACTION_SAVE);
				
				anl02Service.save_ESLT_NTS_TG_TEMP(eslt_nts_tg);
				
			}else{
				
				eslt_noteg_tg.clean();
				eslt_noteg_tg.validate(eslt_noteg_tg.ACTION_SAVE);
				
				anl02Service.save_ESLT_NOTEG_TG_TEMP(eslt_noteg_tg);
				
			}
			
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
	
	@RequestMapping("/save_ANL02005A")
	public ModelAndView save_ANL02005A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		
		ESLT_SH_FC eslt_sh_fc = new ESLT_SH_FC();
		ESLT_DC_FC eslt_dc_fc = new ESLT_DC_FC();
		ESLT_CD_FC eslt_cd_fc = new ESLT_CD_FC();

		bind(request, eslt_sh_fc);
		bind(request, eslt_dc_fc);
		bind(request, eslt_cd_fc);
		
		try {
			
			if(request.getParameter("esltTbInfo").equals("18")){
				
				eslt_sh_fc.clean();
				eslt_sh_fc.validate(eslt_sh_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_SH_FC(eslt_sh_fc);
				
			}else if(request.getParameter("esltTbInfo").equals("19")){
				
				eslt_dc_fc.clean();
				eslt_dc_fc.validate(eslt_dc_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_DC_FC(eslt_dc_fc);
				
			}else{
				
				eslt_cd_fc.clean();
				eslt_cd_fc.validate(eslt_cd_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_CD_FC(eslt_cd_fc);
				
			}
			
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
	
	@RequestMapping("/save_ANL02006A")
	public ModelAndView save_ANL02006A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		
		ESLT_SH_FC eslt_sh_fc = new ESLT_SH_FC();
		ESLT_DC_FC eslt_dc_fc = new ESLT_DC_FC();
		ESLT_CD_FC eslt_cd_fc = new ESLT_CD_FC();

		bind(request, eslt_sh_fc);
		bind(request, eslt_dc_fc);
		bind(request, eslt_cd_fc);
		
		try {
			
			if(request.getParameter("esltTbInfo").equals("23")){
				
				eslt_sh_fc.clean();
				eslt_sh_fc.validate(eslt_sh_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_SH_OL(eslt_sh_fc);
				
			}else if(request.getParameter("esltTbInfo").equals("24")){
				
				eslt_dc_fc.clean();
				eslt_dc_fc.validate(eslt_dc_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_DC_OL(eslt_dc_fc);
				
			}else{
				
				eslt_cd_fc.clean();
				eslt_cd_fc.validate(eslt_cd_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_CD_OL(eslt_cd_fc);
				
			}
			
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
	
	@RequestMapping("/save_ANL02007A")
	public ModelAndView save_ANL02007A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		
		ESLT_NTS_FC eslt_nts_fc = new ESLT_NTS_FC();
		ESLT_NOTEG_FC eslt_noteg_fc = new ESLT_NOTEG_FC();

		bind(request, eslt_nts_fc);
		bind(request, eslt_noteg_fc);
		
		try {
			
			if(request.getParameter("esltTbInfo").equals("21")){
				
				eslt_nts_fc.clean();
				eslt_nts_fc.validate(eslt_nts_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_NTS_FC(eslt_nts_fc);
				
			}else{
				
				eslt_noteg_fc.clean();
				eslt_noteg_fc.validate(eslt_noteg_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_NOTEG_FC(eslt_noteg_fc);
				
			}
			
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
	
	@RequestMapping("/save_ANL02008A")
	public ModelAndView save_ANL02008A(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		
		ESLT_NTS_FC eslt_nts_fc = new ESLT_NTS_FC();
		ESLT_NOTEG_FC eslt_noteg_fc = new ESLT_NOTEG_FC();

		bind(request, eslt_nts_fc);
		bind(request, eslt_noteg_fc);
		
		try {
			
			if(request.getParameter("esltTbInfo").equals("26")){
				
				eslt_nts_fc.clean();
				eslt_nts_fc.validate(eslt_nts_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_NTS_OL(eslt_nts_fc);
				
			}else{
				
				eslt_noteg_fc.clean();
				eslt_noteg_fc.validate(eslt_noteg_fc.ACTION_SAVE);
				
				anl02Service.save_ESLT_NOTEG_OL(eslt_noteg_fc);
				
			}
			
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
	
	//shipment 엑셀 다운로드
	@RequestMapping("/downloadFileShipment")
	public ModelAndView downloadFileShipment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map parameters = new HashMap();
		
		String fileName = request.getParameter("fileName");
		
		parameters.put("fileName", fileName);
		parameters.put("tempFileName", fileName);
		parameters.put("uploadDir", createTempFilePath);
		
		return new ModelAndView("downloadView", parameters);
	}
	
	//수식으로 입력시 숫자로 리턴
	public int getTypeCasting(Cell cell) {
		int value = 0;
		
		if(cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
			value = Integer.parseInt(String.valueOf(Math.round(cell.getNumericCellValue())));
		}
		else if(cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
			value = Integer.parseInt(String.valueOf(Math.round(cell.getNumericCellValue())));
		}
		else if(cell.getCellType() == Cell.CELL_TYPE_STRING) {
			value = Integer.parseInt(String.valueOf(Math.round(cell.getNumericCellValue())));
		}
		
		return value;
	}
	
	//수식으로 입력시 숫자로 리턴
		public double getTypeCastingDouble(Cell cell) {
			double value = 0;
			
			if(cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
				value = Double.parseDouble(String.valueOf(cell.getNumericCellValue()));
			}
			else if(cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
				value = Double.parseDouble(String.valueOf(cell.getNumericCellValue()));
			}
			else if(cell.getCellType() == Cell.CELL_TYPE_STRING) {
				value = Double.parseDouble(String.valueOf(cell.getNumericCellValue()));
			}
			
			return value;
		}
}