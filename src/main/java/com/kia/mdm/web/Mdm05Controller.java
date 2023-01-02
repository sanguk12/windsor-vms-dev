package com.kia.mdm.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
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
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kia.mdm.model.GVEN03MT;
import com.kia.mdm.service.Mdm05Service;

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
@RequestMapping("/service/mdm05")
public class Mdm05Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;
	
//	@Value("#{system['jXls.templateFilePath']}")
//	private String templateFilePath;
	
	@Value("#{appenv['file.temporaryVenueUpload']}")
	private String venueUploadFile;
	
	@Value("#{appenv['juso.URL']}")
	private String jusoUrl;
	
	@Value("#{appenv['juso.confmKey']}")
	private String confmKey;
	
	@Resource
	private Mdm05Service mdm05Service;
	
	@Resource	
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/saveTmpVenue")
	public ModelAndView saveTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN03MT gven03mt = new GVEN03MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven03mt);
		
		try {
			gven03mt.clean();
			gven03mt.validate(gven03mt.ACTION_SAVE);
			
			if (gven03mt.getActiveFlg().equals("I")) {
				mdm05Service.insertVenue(gven03mt);
			}
			else {
				if(gven03mt.getSaveChk().equals("Y")) {
					mdm05Service.resetTmpVenue(gven03mt);
				}else {
					mdm05Service.updateVenue(gven03mt);
				}
			}
			
			rm.setParameters(gven03mt.getTmpVenueCD());
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
	
	@RequestMapping("/downloadFile")
	public ModelAndView downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		parameters.put("fileName", venueUploadFile);
		parameters.put("tempFileName", venueUploadFile);
		parameters.put("uploadDir", templateFilePath);

		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/extractTmpVenueXls")
	public ModelAndView extractTmpVenueXls(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		Map<?, ?> params = new HashMap<Object, Object>();
		List<Map<String, Cell>> list = new ArrayList<Map<String, Cell>>();
		String empID = request.getParameter("empID");
		
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
				for (int i = 2; i < numOfRows; i++) {
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
						
						String requestDate = "";
						String territoryCDName = "";
						String phoneNo = "";
						String fasciaCDName = "";
						String venueGradCDName = "";
						String addrTpCD1Name = "";
						String addrTpCD2Name = "";
						String addrTpCD3Name = "";
						String addrTpCD4Name = "";
						String siteCDName = "";
						String channelCDName = "";
						String subChannelCDName = "";
						String segmentCDName = "";
						String subSegmentCDName = "";
						String reserveSegmentCDName = "";
						String ageingCDName = "";
						String kegYNName = "";
						String locationCDName = "";
						String ws1SapCDName = "";
						String ws2SapCDName = "";
						String ws3SapCDName = "";
						String ws4SapCDName = "";
						
						//코드명으로 되어있는 excel 코드값 찾기
						Map param = null;
						Map queryMap = null;
						
						String venueCD = "";
						
						
						if (!record.get("col3").equals("TEST 1-1") && !"".equals(record.get("col2"))) {
							
							if(!"".equals(record.get("col0"))) {
								requestDate = record.get("col0").toString(); 
								SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd");
								Date requestDateFormat = new Date();
								
								try {
									requestDateFormat = date.parse(requestDate);
								} catch (ParseException e) {
									requestDate = "";
								} finally {
									if(requestDate.length() > 0) {
										requestDate = date.format(requestDateFormat);
									}
									
								}
								
							}
							
							String territoryCD = "";
							if(!"".equals(record.get("col3"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "TERRITORYCD");
								param.put("codeName", record.get("col3"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									territoryCD = queryMap.get("code").toString();
									territoryCDName = record.get("col3").toString();
								}
							}
							
							String regExp1 = "^\\d{2,3}-\\d{3,4}-\\d{4}$";
							String regExp2 = "^01(?:0|1|[0-9])$";
							if(!"".equals(record.get("col4"))) {
								phoneNo = record.get("col4").toString(); 
								
								if(phoneNo.matches(regExp1) && phoneNo.substring(0,3).matches(regExp2)) {
									phoneNo = "";
								}
							}
							
							String fasciaCD = "";
							if(!"".equals(record.get("col5"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "FASCIACD");
								param.put("codeName", record.get("col5"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									fasciaCD = queryMap.get("code").toString();
									fasciaCDName = record.get("col5").toString();
								}
							}
							String venueGradCD = "";
							if(!"".equals(record.get("col6"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "VENUEGRADCD");
								param.put("codeName", record.get("col6"));
								param.put("attrib01", "C");
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									venueGradCD = queryMap.get("code").toString();
									venueGradCDName = record.get("col6").toString();
								}
							}
							
							String addr1 = "";
							String addrTpCD1_tmp = "";
							String addrTpCD2_tmp = "";
							String addrTpCD3_tmp = "";
							String addrTpCD4_tmp = "";
							String addrTpCD1 = "";
							String addrTpCD2 = "";
							String addrTpCD3 = "";
							String addrTpCD4 = "";
							String newAddr1 = "";
							String oldAddr1 = "";
							String newAddr2 = "";
							String oldAddr2 = "";
							String detail_r = "";
							String detail_j = "";
							String detail_tmp = "";
								
							if(!"".equals(record.get("col7"))) {
								addr1 = record.get("col7").toString();
								addrTpCD1_tmp = record.get("col7").toString();
							}
							if(!"".equals(record.get("col8"))) {
								addr1 += " " + record.get("col8").toString();
								addrTpCD2_tmp = record.get("col8").toString();
							}
							if(!"".equals(record.get("col9"))) {
								addr1 += " " + record.get("col9").toString();
								addrTpCD3_tmp = record.get("col9").toString();
							}
							if(!"".equals(record.get("col10"))) {
								int idx = record.get("col10").toString().indexOf(" ");
								if(idx > 0) {
									addr1 += " " + record.get("col10").toString().substring(0, idx);
									detail_tmp = record.get("col10").toString().substring(idx, record.get("col10").toString().length());
								} else {
									addr1 += " " + record.get("col10").toString();
								}
							}
							
							JSONParser parser = new JSONParser();
							JSONObject obj = (JSONObject) parser.parse(getAddrApi(addr1));
		
							obj = (JSONObject) obj.get("results");
							
							JSONObject juso = new JSONObject();
							JSONArray jusoArr = new JSONArray();
							
							jusoArr = (JSONArray) obj.get("juso");
	
							if(!"".equals(jusoArr) && null != jusoArr) {
								if(jusoArr.size() > 0) {
									juso.put("juso", jusoArr.get(0));
									juso = (JSONObject) juso.get("juso");
									
									//전체주소
									newAddr1 = (String) juso.get("roadAddr");
									oldAddr1 = (String) juso.get("jibunAddr");
									//상세주소
									detail_r = (String) juso.get("buldSlno");
									detail_j = (String) juso.get("lnbrSlno");
									
									if(detail_r.length() > 0 && !detail_r.equals("0")) {
										detail_r = (String) juso.get("buldMnnm") + "-" + juso.get("buldSlno") + " " + detail_tmp;
									}else {
										detail_r = (String) juso.get("buldMnnm") + " " + detail_tmp;
									}
									
									if(detail_j.length() > 0 && !detail_j.equals("0")) {
										detail_j = (String) juso.get("lnbrMnnm") + "-" + juso.get("lnbrSlno") + " " + detail_tmp;
									}else {
										detail_j = (String) juso.get("lnbrMnnm") + " " + detail_tmp;
									}
									
									
									
									//addrTpCD3_tmp = (String) juso.get("emdNm");
									
									param = new HashMap();
									queryMap = new HashMap();
									param.put("codeDiv", "ADDRTPCD1");
									param.put("codeName", addrTpCD1_tmp.trim());
									queryMap = simpleService.queryForMap("MDM0500108S", param);
									if(queryMap!=null) {
										addrTpCD1 = queryMap.get("code").toString();
										addrTpCD1Name = addrTpCD1_tmp;
									}
									
									if(!"".equals(addrTpCD1)) {
										param = new HashMap();
										queryMap = new HashMap();
										param.put("codeDiv", "ADDRTPCD2");
										param.put("codeName", addrTpCD2_tmp.trim());
										param.put("attrib02", addrTpCD1);
										queryMap = simpleService.queryForMap("MDM0500108S", param);
										if(queryMap!=null) {
											addrTpCD2 = queryMap.get("code").toString();
											addrTpCD2Name = addrTpCD2_tmp;
										}
									}
									
									
									if(!"".equals(addrTpCD2)) {
										param = new HashMap();
										queryMap = new HashMap();
										param.put("codeDiv", "ADDRTPCD3");
										param.put("codeName", addrTpCD3_tmp.trim());
										param.put("attrib02", addrTpCD2);
										queryMap = simpleService.queryForMap("MDM0500108S", param);
										
										if(queryMap!=null) {
											addrTpCD3 = queryMap.get("code").toString();
											addrTpCD3Name = addrTpCD3_tmp;
										}
									}
									
									if(!"".equals(addrTpCD3)) {
										param = new HashMap();
										queryMap = new HashMap();
										param.put("codeDiv", "ADDRTPCD4");
										param.put("codeName", addrTpCD4_tmp);
										param.put("attrib02", addrTpCD3);
										queryMap = simpleService.queryForMap("MDM0500108S", param);
										if(queryMap!=null) {
											addrTpCD4 = queryMap.get("code").toString();
											addrTpCD4Name = addrTpCD4_tmp;
										}
									}
								}	
							}
							
							String siteCD = "";
							if(!"".equals(record.get("col12"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "SITECD");
								param.put("codeName", record.get("col12"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									siteCD = queryMap.get("code").toString();
									siteCDName = record.get("col12").toString();
								}
							}
							
							String channelCD = "";
							String subChannelCD= "";
							String segmentCD = "";
							String subSegmentCD = "";
							if(!"".equals(record.get("col32"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "SUBSEGMENTCD");
								param.put("codeName", record.get("col32"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									subSegmentCD = queryMap.get("code").toString();
									subSegmentCDName = record.get("col32").toString();
									segmentCD = queryMap.get("attrib02").toString();
								}
							}
						
							if(!"".equals(segmentCD)) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "SEGMENTCD");
								param.put("comCode", segmentCD);
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									segmentCDName = queryMap.get("codeName").toString();
									subChannelCD = queryMap.get("attrib02").toString();
								}
							}
							
							if(!"".equals(subChannelCD)) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "SUBCHANNELCD");
								param.put("comCode", subChannelCD);
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									subChannelCDName = queryMap.get("codeName").toString();
									channelCD = queryMap.get("attrib02").toString();
								}
							}
							
							if(!"".equals(channelCD)) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "CHANNELCD");
								param.put("comCode", channelCD);
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									channelCDName = queryMap.get("codeName").toString();
								}
							}
							
							String reserveSegmentCD = "";
							if(!"".equals(record.get("col33"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "RESERVESEGMENTCD");
								param.put("codeName", record.get("col33"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									reserveSegmentCD = queryMap.get("code").toString();
									reserveSegmentCDName = record.get("col33").toString();
								}
							}
							
							String ageingCD = "";
							if(!"".equals(record.get("col34"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "AGEINGCD");
								param.put("codeName", record.get("col34"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									ageingCD = queryMap.get("code").toString();
									ageingCDName = record.get("col34").toString();
								}
							}
							
							String kegYN = "";
							if(!"".equals(record.get("col35"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "ACTIVEYN");
								param.put("codeName", record.get("col35"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									kegYN = queryMap.get("code").toString();
									kegYNName = record.get("col35").toString();
								}
							}
							String locationCD = "";
							if(!"".equals(record.get("col37"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "LOCATIONCD");
								param.put("codeName", record.get("col37"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									locationCD = queryMap.get("code").toString();
									locationCDName = record.get("col37").toString();
								}
							}
							String ws1CD = "";
							String ws1SapCD = "";
							if(!"".equals(record.get("col38"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSSAPCD");
								param.put("comCode", record.get("col38"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									ws1SapCD = queryMap.get("code").toString();
									ws1SapCDName = queryMap.get("codeName").toString();
									ws1CD = queryMap.get("attrib02").toString();	
								}
							}
							String ws1CDName = "";
							if(!"".equals(ws1CD)) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSCD");
								param.put("comCode", ws1CD);
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									ws1CDName = queryMap.get("codeName").toString();
								}
							}
							
							String ws2CD = "";
							String ws2SapCD = "";
							if(!"".equals(record.get("col39"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSSAPCD");
								param.put("comCode", record.get("col39"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									ws2SapCD = queryMap.get("code").toString();
									ws2SapCDName = queryMap.get("codeName").toString();
									ws2CD = queryMap.get("attrib02").toString();	
								}
							}
							
							String ws2CDName = "";
							if(!"".equals(ws2CD)) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSCD");
								param.put("comCode", ws2CD);
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									ws2CDName = queryMap.get("codeName").toString();
								}
							}
							String ws3CD = "";
							String ws3SapCD = "";
							if(!"".equals(record.get("col40"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSSAPCD");
								param.put("comCode", record.get("col40"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									ws3SapCD = queryMap.get("code").toString();
									ws3SapCDName = queryMap.get("codeName").toString();
									ws3CD = queryMap.get("attrib02").toString();	
								}
							}
							String ws3CDName = "";
							if(!"".equals(ws3CD)) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSCD");
								param.put("comCode", ws3CD);
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									ws3CDName = queryMap.get("codeName").toString();
								}
							}
							String ws4CD = "";
							String ws4SapCD = "";
							if(!"".equals(record.get("col41"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSSAPCD");
								param.put("comCode", record.get("col41"));
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									ws4SapCD = queryMap.get("code").toString();
									ws4SapCDName = queryMap.get("codeName").toString();
									ws4CD = queryMap.get("attrib02").toString();	
								}
							}
							String ws4CDName = "";
							if(!"".equals(ws4CD)) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSCD");
								param.put("comCode", ws4CD);
								queryMap = simpleService.queryForMap("MDM0500104S", param);
								if(queryMap!=null) {
									ws4CDName = queryMap.get("codeName").toString();
								}
							}
							
							String legalCDName = "";
							String legalCD = "";
							if(!"".equals(empID)) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "LEGALCD");
								param.put("empID", empID);
								queryMap = simpleService.queryForMap("MDM0500114S", param);
								if(queryMap!=null) {
									legalCD = queryMap.get("code").toString();
									legalCDName = queryMap.get("codeName").toString();
								}
							}
							
							data.put("requestDate", requestDate);
							data.put("mdDupYN", record.get("col1"));
							data.put("venueNm", record.get("col2"));
							data.put("territoryCDName", territoryCDName);
							data.put("phoneNo", phoneNo);
							data.put("fasciaCDName", fasciaCDName);
							data.put("venueGradCDName", venueGradCDName);
							data.put("addrTpCD1Name", addrTpCD1Name);
							data.put("addrTpCD2Name", addrTpCD2Name);
							data.put("addrTpCD3Name", addrTpCD3Name);
							//data.put("addrTpCD4Name", addrTpCD4Name);
							data.put("newAddr2", detail_r);
							data.put("postCD", record.get("col11"));
							data.put("siteCDName", siteCDName);
							data.put("channelCDName", channelCDName);
							data.put("subChannelCDName", subChannelCDName);
							data.put("segmentCDName", segmentCDName);
							data.put("subSegmentCDName", subSegmentCDName);
							data.put("reserveSegmentCDName", reserveSegmentCDName);
							data.put("ageingCDName", ageingCDName);
							data.put("kegYNName", kegYNName);
							data.put("mdVenueCD", record.get("col36"));
							data.put("locationCDName", locationCDName);
							data.put("legalCDName", legalCDName);
							data.put("ws1SapCD", ws1SapCD);
							data.put("ws1SapCDName", ws1SapCDName);
							data.put("branch1", ws1CDName);
							data.put("ws2SapCD", ws2SapCD);
							data.put("ws2SapCDName", ws2SapCDName);
							data.put("branch2", ws2CDName);
							data.put("ws3SapCD", ws3SapCD);
							data.put("ws3SapCDName", ws3SapCDName);
							data.put("branch3", ws3CDName);
							data.put("ws4SapCD", ws4SapCD);
							data.put("ws4SapCDName", ws4SapCDName);
							data.put("branch4", ws4CDName);
							
							data.put("territoryCD", territoryCD);
							data.put("fasciaCD", fasciaCD);
							data.put("venueGradCD", venueGradCD);
							data.put("addrTpCD1", addrTpCD1);
							data.put("addrTpCD2", addrTpCD2);
							data.put("addrTpCD3", addrTpCD3);
							data.put("siteCD", siteCD);
							data.put("channelCD", channelCD);
							data.put("subChannelCD", subChannelCD);
							data.put("segmentCD", segmentCD);
							data.put("subSegmentCD", subSegmentCD);
							data.put("reserveSegmentCD", reserveSegmentCD);
							data.put("ageingCD", ageingCD);
							data.put("kegYN", kegYN);
							data.put("locationCD", locationCD);
							data.put("ws1CD", ws1CD);
							data.put("ws2CD", ws2CD);
							data.put("ws3CD", ws3CD);
							data.put("ws4CD", ws4CD);
							data.put("addrTpCD4", addrTpCD4);
							data.put("newAddr1", newAddr1);
							data.put("oldAddr1", oldAddr1);
							data.put("oldAddr2", detail_j);
							data.put("legalCD", legalCD);
							
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

	@RequestMapping("/saveTmpVenueGrid")
	public ModelAndView saveTmpVenueGrid(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		GVEN03MT gven03mt = new GVEN03MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven03mt);
		
		try {
			gven03mt.clean();
			gven03mt.validate(gven03mt.ACTION_SAVE);
			
			mdm05Service.saveTmpVenueGrid(gven03mt);
			
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
	
	@RequestMapping("/requestApprTmpVenue") //승인요청
	public ModelAndView requestApprTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN03MT gven03mt = new GVEN03MT();
		ResultMessage rm = new ResultMessage();
	
		bind(request, gven03mt);
		
		try {
			gven03mt.clean();
			gven03mt.validate(gven03mt.ACTION_SAVE);

			mdm05Service.requestApprTmpVenue(gven03mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.requestAppr"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.requestAppr"));
			rm.setSystemMessage(e.toString());
		}
	
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
	
		return mv;
	}
	
	@RequestMapping("/clearRequestApprTmpVenue") //승인요청취소
	public ModelAndView clearRequestApprTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN03MT gven03mt = new GVEN03MT();
		ResultMessage rm = new ResultMessage();
	
		bind(request, gven03mt);
		
		try {
			gven03mt.clean();
			gven03mt.validate(gven03mt.ACTION_SAVE);
			
			mdm05Service.clearRequestApprTmpVenue(gven03mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.clearRequestAppr"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.clearRequestAppr"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/approvalTmpVenue") //승인
	public ModelAndView approvalTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN03MT gven03mt = new GVEN03MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven03mt);
		
		try {
			gven03mt.clean();
			gven03mt.validate(gven03mt.ACTION_SAVE);
			
			GVEN03MT gven03mt_a = gven03mt.getObject_approval(0);
			
			//한건이라도 최종승인이면 최종담당자임을 제약으로 함
			if(gven03mt_a.getLastApprYN().equals("Y")) {
				mdm05Service.lastApprovalTmpVenue(gven03mt);
			}
			else {
				mdm05Service.approvalTmpVenue(gven03mt);
			}
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.approval"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.approval"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/rejectTmpVenue") //반려
	public ModelAndView rejectTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN03MT gven03mt = new GVEN03MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		bind(request, gven03mt);
		
		try {
			gven03mt.clean();
			gven03mt.validate(gven03mt.ACTION_SAVE);
			gven03mt.setEmpID(session.getEmpID());
			gven03mt.setEmpNm(session.getEmpNm());
			gven03mt.setEmailAddr(session.getEmailAddr());
			gven03mt.setClientDate(session.getClientDate());
			
			mdm05Service.rejectTmpVenue(gven03mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.reject"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.reject"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/printChk")
	public ModelAndView printChk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN03MT gven03mt = new GVEN03MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven03mt);
		
		try {
			gven03mt.clean();
			gven03mt.validate(gven03mt.ACTION_SAVE);
			
			mdm05Service.printChk(gven03mt);
			
			rm.setParameters(gven03mt.getVenueCD());
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
	
	public String getAddrApi(String kw) throws Exception {
		// 요청변수 설정
	  	String currentPage = "1";    //요청 변수 설정 (현재 페이지. currentPage : n > 0)
		String countPerPage = "1";  //요청 변수 설정 (페이지당 출력 개수. countPerPage 범위 : 0 < n <= 100)
		String resultType = "json";      //요청 변수 설정 (검색결과형식 설정, json)
		//String confmKEY = confmKey;          //요청 변수 설정 (승인키)
		String keyword = kw;           //요청 변수 설정 (키워드)
		//String jusoURL = jusoUrl;
		// OPEN API 호출 URL 정보 설정
		String apiUrl = jusoUrl+"/addrlink/addrLinkApi.do?currentPage="+currentPage+"&countPerPage="+countPerPage+"&keyword="+URLEncoder.encode(keyword,"UTF-8")+"&confmKey="+confmKey+"&resultType="+resultType;
		
		URL url = new URL(apiUrl);
		
		BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
		StringBuffer sb = new StringBuffer();
		String tempStr = null;

		while(true){
			tempStr = br.readLine();
			if(tempStr == null) break;
			sb.append(tempStr);								// 응답결과 JSON 저장
		}
		String result = sb.toString(); 
				
		return result;			// 응답결과 반환
	
	}
	
	@RequestMapping("/excelCount")
	public ModelAndView excelCount(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN03MT gven03mt = new GVEN03MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven03mt);
		
		try {
			gven03mt.clean();
			gven03mt.validate(gven03mt.ACTION_SAVE);
			
			mdm05Service.excelCount(gven03mt);
			
			rm.setParameters(gven03mt.getVenueCD());
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
	
	@RequestMapping("/excelSeq")
	public ModelAndView excelSeq(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN03MT gven03mt = new GVEN03MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven03mt);
		
		try {
			gven03mt.clean();
			gven03mt.validate(gven03mt.ACTION_SAVE);
			
			mdm05Service.excelSeq(gven03mt);
			
			rm.setParameters(gven03mt.getVenueCD());
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