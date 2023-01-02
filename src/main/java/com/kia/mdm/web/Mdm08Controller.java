package com.kia.mdm.web;

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

import com.kia.mdm.model.GVEN02MT;
import com.kia.mdm.service.Mdm08Service;

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
@RequestMapping("/service/mdm08")
public class Mdm08Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;
	
//	@Value("#{system['jXls.templateFilePath']}")
//	private String templateFilePath;
	
	@Value("#{appenv['file.venueUpload_admin_merge']}")
	private String venueUpload_admin_merge;
	
	@Value("#{appenv['file.venueUpload_admin_delete']}")
	private String venueUpload_admin_delete;

	@Resource
	private Mdm08Service mdm08Service;
	
	@Resource	
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/saveTmpVenue")
	public ModelAndView saveTmpVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			
			if (gven02mt.getActiveFlg().equals("I")) {
				mdm08Service.insertVenue(gven02mt);
			}
			else {
				mdm08Service.updateVenue(gven02mt);
			}
			
			rm.setParameters(gven02mt.getVenueCD());
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
	
	@RequestMapping("/downloadFile_merge")
	public ModelAndView downloadFile_merge(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		parameters.put("fileName", venueUpload_admin_merge);
		parameters.put("tempFileName", venueUpload_admin_merge);
		parameters.put("uploadDir", templateFilePath);

		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/downloadFile_delete")
	public ModelAndView downloadFile_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		Map<?, ?> params = new HashMap<Object, Object>();
		
		bind(request, params);
		
		Map parameters = new HashMap();
		parameters.put("fileName", venueUpload_admin_delete);
		parameters.put("tempFileName", venueUpload_admin_delete);
		parameters.put("uploadDir", templateFilePath);

		return new ModelAndView("downloadView", parameters);
	}
	
	@RequestMapping("/extractVenueXls")
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
						
						Cell c_sellingAreaID                 = row.getCell(0);
						Cell c_customerID                    = row.getCell(1);
						Cell c_refNo                         = row.getCell(2);
						Cell c_venueCD                       = row.getCell(3);
						Cell c_country                       = row.getCell(4);
						Cell c_territoryCDName               = row.getCell(5);
						Cell c_rageSphereCDName              = row.getCell(6);
						Cell c_teamCDName                    = row.getCell(7);
						Cell c_repNm                         = row.getCell(8);
						Cell c_repNm_KR                      = row.getCell(9);
						Cell c_customerNm                    = row.getCell(10);
						Cell c_sellingAreaNm                 = row.getCell(11);
						Cell c_legalCDName                	 = row.getCell(12);
						Cell c_channelCDName                 = row.getCell(13);
						Cell c_subChannelCDName              = row.getCell(14);
						Cell c_segmentCDName                 = row.getCell(15);
						Cell c_subSegmentCDName              = row.getCell(16);
						Cell c_reserveSegmentCDName          = row.getCell(17);
						Cell c_kegYNName                     = row.getCell(18);
						Cell c_ageingCDName                  = row.getCell(19);
						Cell c_siteCDName                    = row.getCell(20);
						Cell c_venueGradCDName               = row.getCell(21);
						Cell c_addrTpCD1Name                 = row.getCell(22);
						Cell c_addrTpCD2Name                 = row.getCell(23);
						Cell c_addrTpCD3Name                 = row.getCell(24);
						Cell c_oldAddr2                 	 = row.getCell(25);
						Cell c_newAddr1  		             = row.getCell(26);
						Cell c_postCD                      	 = row.getCell(27);
						Cell c_phoneNo                       = row.getCell(28);
						Cell c_fasciaCDName                  = row.getCell(29);
						Cell c_legacyFrontOfficeAccountNo    = row.getCell(30);
						Cell c_legacyBackOfficeAccountNo     = row.getCell(31);
						Cell c_ws1SapCDName                  = row.getCell(32);
						Cell c_ws2SapCDName                  = row.getCell(33);
						Cell c_ws3SapCDName                  = row.getCell(34);
						Cell c_ws4SapCDName                  = row.getCell(35);
						Cell c_license                       = row.getCell(36);
						Cell c_activeYNName                  = row.getCell(37);
						Cell c_createDate                    = row.getCell(38);
						Cell c_sellingAreaCreatedDate        = row.getCell(39);
						Cell c_lastModifiedDate              = row.getCell(40);
						Cell c_sellingAreaLastModifiedDate   = row.getCell(41);
						Cell c_lastModifiedBy				 = row.getCell(42);
						Cell c_venueDivCDName				 = row.getCell(43);
						
						String territoryCDName 				= "";
						String teamCDName 					= "";
						String rageSphereCDName 			= "";
						String fasciaCDName 				= "";
						String venueGradCDName 				= "";
						String addrTpCD1Name 				= "";
						String addrTpCD2Name 				= "";
						String addrTpCD3Name 				= "";
						String siteCDName 					= "";
						String segmentCDName 				= "";
						String subSegmentCDName 			= "";
						String channelCDName 				= "";
						String subChannelCDName 			= "";
						String reserveSegmentCDName 		= "";
						String ageingCDName 				= "";
						String kegYNName 					= "";
						String locationCDName 				= "";
						String legalCDName 				= "";
						String activeYNName 				= "";
						String ws1SapCDName 				= "";
						String ws2SapCDName                 = "";
						String ws3SapCDName                 = "";
						String ws4SapCDName                 = "";
						String oldAddr2                 = "";
						String newAddr2                 = "";
						String venueDivCD                 = "";
						//코드명으로 되어있는 excel 코드값 찾기
						Map param = null;
						Map queryMap = null;
						
						String venueCD = "";
						
						if (!record.get("col5").equals("TEST 1-1") && !"".equals(record.get("col3"))) {
							
							String territoryCD = "";
							if(!record.get("col5").toString().equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "TERRITORYCD");
								param.put("codeName", record.get("col5").toString());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								
								if (queryMap!=null) {
									territoryCD = queryMap.get("code").toString();
									territoryCDName = record.get("col5").toString();
								}
							}

							String teamCD = "";
							String officeCD = "";
							String rageSphereCD = "";
							if(!record.get("col7").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "TEAMCD");
								param.put("codeName", record.get("col7"));
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								
								if (queryMap!=null) {
									teamCD = queryMap.get("code").toString();
									teamCDName = record.get("col7").toString();
									officeCD = queryMap.get("attrib02").toString();
								}
							}
							
							
							if(!teamCD.equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "OFFICECD");
								param.put("comCode", officeCD);
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									officeCD = queryMap.get("code").toString();
									rageSphereCD = queryMap.get("attrib02").toString();
								}
							}
							
							if(!officeCD.equals("") ) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "RAGESPHERECD");
								param.put("codeName", rageSphereCD);
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									if(queryMap.get("codeName").toString().equals(record.get("col6").toString())) {
										rageSphereCD = queryMap.get("code").toString() ;
										rageSphereCDName = record.get("col6").toString();
									} else {
										rageSphereCD = "";
										rageSphereCDName = "";
									}
								} 
								
							}
							
							String legalCD = "";
							if(!record.get("col12").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "LEGALCD");
								param.put("codeName", record.get("col12"));
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									legalCD = queryMap.get("code").toString();
									legalCDName = queryMap.get("codeName").toString();
								}
							}
							
							String channelCD = "";
							if(!record.get("col13").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "CHANNELCD");
								param.put("codeName", record.get("col13").toString().replace("[KR]","").trim());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									channelCD = queryMap.get("code").toString();
									channelCDName = record.get("col13").toString().replace("[KR]","").trim();
								}
							}
							
							String subChannelCD = "";
							if(!channelCD.equals("")) {
								if(!record.get("col14").equals("")) {
									param = new HashMap();
									queryMap = new HashMap();
									param.put("codeDiv", "SUBCHANNELCD");
									param.put("codeName", record.get("col14").toString().replace("[KR]","").trim());
									param.put("attrib02", channelCD);
									queryMap = simpleService.queryForMap("MDM0800104S", param);
									if(queryMap!=null) {
										subChannelCD = queryMap.get("code").toString();
										subChannelCDName = record.get("col14").toString().replace("[KR]","").trim();
									}
								}
							}
							
							String segmentCD = "";
							if(!record.get("col15").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "SEGMENTCD");
								param.put("codeName", record.get("col15").toString().replace("[KR]","").trim());
								param.put("attrib02", subChannelCD);
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									segmentCD = queryMap.get("code").toString();
									segmentCDName = record.get("col15").toString().replace("[KR]","").trim();
								}
							}
							
							String subSegmentCD = "";
							if(!segmentCD.equals("")) {
								if(!record.get("col16").equals("")) {
									param = new HashMap();
									queryMap = new HashMap();
									param.put("codeDiv", "SUBSEGMENTCD");
									param.put("codeName", record.get("col16").toString().replace("[KR]","").trim());
									param.put("attrib02", segmentCD);
									queryMap = simpleService.queryForMap("MDM0800104S", param);
									if(queryMap!=null) {
										subSegmentCD = queryMap.get("code").toString();
										subSegmentCDName = record.get("col16").toString().replace("[KR]","").trim();
									}
								}
							}
							
							String reserveSegmentCD = "";
							if(!record.get("col17").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "RESERVESEGMENTCD");
								param.put("codeName", record.get("col17").toString().replace("[KR]","").trim());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									reserveSegmentCD = queryMap.get("code").toString();
									reserveSegmentCDName = record.get("col17").toString().replace("[KR]","").trim();
								}
							}
							
							String kegYN = "";
							if(!record.get("col18").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "ACTIVEYN");
								param.put("codeName", record.get("col18"));
								queryMap = simpleService.queryForMap("MDM0800108S", param);
								if(queryMap!=null) {
									kegYN = queryMap.get("code").toString();
									kegYNName = queryMap.get("codeName").toString();
								}
							}else {
								kegYN = "N";
								kegYNName = "N";
							}
							
							String ageingCD = "";
							if(!record.get("col19").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "AGEINGCD");
								param.put("codeName", record.get("col19").toString().replace("[KR]","").trim());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									ageingCD = queryMap.get("code").toString();
									ageingCDName = record.get("col19").toString().replace("[KR]","").trim();
								}
							}
							
							String siteCD = "";
							if(!record.get("col20").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "SITECD");
								param.put("codeName", record.get("col20").toString().replace("[KR]","").trim());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									siteCD = queryMap.get("code").toString();
									siteCDName = record.get("col20").toString().replace("[KR]","").trim();
								}
							}
				
							String venueGradCD = "";
							if(!record.get("col21").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "VENUEGRADCD");
								param.put("codeName", record.get("col21"));
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									venueGradCD = queryMap.get("code").toString();
									venueGradCDName = record.get("col21").toString();
								}
							}
	//						
							String addrTpCD1 = "";
							if(!record.get("col22").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "ADDRTPCD1");
								param.put("codeName", record.get("col22"));
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									addrTpCD1 = queryMap.get("code").toString();
									addrTpCD1Name = record.get("col22").toString();
								}
							}
							
							String addrTpCD2 = "";
							if(!addrTpCD1.equals("")) {
								if(!record.get("col23").equals("")) {
									param = new HashMap();
									queryMap = new HashMap();
									param.put("codeDiv", "ADDRTPCD2");
									param.put("codeName", record.get("col23"));
									param.put("attrib02", addrTpCD1);
									queryMap = simpleService.queryForMap("MDM0800104S", param);
									if(queryMap!=null) {
										addrTpCD2 = queryMap.get("code").toString();
										addrTpCD2Name = record.get("col23").toString();
									}
								}
							}
							
							String addrTpCD3 = "";
							if(!addrTpCD2.equals("")) {
								if(record.get("col24")!=null) {
									param = new HashMap();
									queryMap = new HashMap();
									param.put("codeDiv", "ADDRTPCD3");
									param.put("codeName", record.get("col24"));
									param.put("attrib02", addrTpCD2);
									queryMap = simpleService.queryForMap("MDM0800104S", param);
									if(queryMap!=null) {
										addrTpCD3 = queryMap.get("code").toString();
										addrTpCD3Name = record.get("col24").toString();
									}
								}
							}
							
							
							String fasciaCD = "";
							if(!record.get("col29").equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "FASCIACD");
								param.put("codeName", record.get("col29").toString().replace("[KR]","").trim());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									fasciaCD = queryMap.get("code").toString();
									fasciaCDName = record.get("col29").toString().replace("[KR]","").trim();
								}
							}
							
							String ws1CD = "";
							String ws1SapCD = "";
							if(!"".equals(record.get("col32"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSSAPCD");
								param.put("codeName", record.get("col32").toString().replace("[KR]","").trim());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
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
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									ws1CDName = queryMap.get("codeName").toString();
								}
							}
							
							String ws2CD = "";
							String ws2SapCD = "";
							if(!"".equals(record.get("col33"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSSAPCD");
								param.put("codeName", record.get("col33").toString().replace("[KR]","").trim());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
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
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									ws2CDName = queryMap.get("codeName").toString();
								}
							}
							String ws3CD = "";
							String ws3SapCD = "";
							if(!"".equals(record.get("col34"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSSAPCD");
								param.put("codeName", record.get("col34").toString().replace("[KR]","").trim());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
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
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									ws3CDName = queryMap.get("codeName").toString();
								}
							}
							String ws4CD = "";
							String ws4SapCD = "";
							if(!"".equals(record.get("col35"))) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSSAPCD");
								param.put("codeName", record.get("col35").toString().replace("[KR]","").trim());
								queryMap = simpleService.queryForMap("MDM0800104S", param);
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
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									ws4CDName = queryMap.get("codeName").toString();
								}
							}
	
							String activeYN = "";
							if(!record.get("col37").equals("")) {
								param = new HashMap();
								queryMap = new HashMap(); 
								param.put("codeDiv", "ACTIVEYN");
								param.put("codeName", record.get("col37"));
								queryMap = simpleService.queryForMap("MDM0800108S", param);
								if(queryMap!=null) {
									activeYN = queryMap.get("code").toString();
									activeYNName = queryMap.get("codeName").toString();
								}else {
									activeYN = "N";
									activeYNName = "N";
								}
							}
							
							
							
							String createDate = ""; 
							if(!"".equals(record.get("col38"))) {
								createDate = record.get("col38").toString(); 
								SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd");
								Date createDateFormat = new Date();
								
								try {
									createDateFormat = date.parse(createDate);
								} catch (ParseException e) {
									createDate = "";
								} finally {
									if(createDate.length() > 0) {
										createDate = date.format(createDateFormat);
									}
									
								}
								
							}
							
							String sellingAreaCreatedDate = ""; 
							if(!"".equals(record.get("col39"))) {
								sellingAreaCreatedDate = record.get("col39").toString(); 
								SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd");
								Date sellingAreaCreatedDateFormat = new Date();
								
								try {
									sellingAreaCreatedDateFormat = date.parse(sellingAreaCreatedDate);
								} catch (ParseException e) {
									sellingAreaCreatedDate = "";
								} finally {
									if(sellingAreaCreatedDate.length() > 0) {
										sellingAreaCreatedDate = date.format(sellingAreaCreatedDateFormat);
									}
									
								}
								
							}
							
							String lastModifiedDate = ""; 
							if(!"".equals(record.get("col40"))) {
								lastModifiedDate = record.get("col40").toString(); 
								SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd");
								Date lastModifiedDateFormat = new Date();
								
								try {
									lastModifiedDateFormat = date.parse(lastModifiedDate);
								} catch (ParseException e) {
									lastModifiedDate = "";
								} finally {
									if(lastModifiedDate.length() > 0) {
										lastModifiedDate = date.format(lastModifiedDateFormat);
									}
									
								}
								
							}
							
							String sellingAreaLastModifiedDate = ""; 
							if(!"".equals(record.get("col41"))) {
								sellingAreaLastModifiedDate = record.get("col41").toString(); 
								SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd");
								Date sellingAreaLastModifiedDateFormat = new Date();
								
								try {
									sellingAreaLastModifiedDateFormat = date.parse(sellingAreaLastModifiedDate);
								} catch (ParseException e) {
									sellingAreaLastModifiedDate = "";
								} finally {
									if(sellingAreaLastModifiedDate.length() > 0) {
										sellingAreaLastModifiedDate = date.format(sellingAreaLastModifiedDateFormat);
									}
									
								}
								
							}
							
							String venueDivCDName = ""; 
							if(!record.get("col43").equals("")) {
								param = new HashMap();
								queryMap = new HashMap(); 
								param.put("codeDiv", "VENUEDIVCD");
								param.put("codeName", record.get("col43"));
								queryMap = simpleService.queryForMap("MDM0800104S", param);
								if(queryMap!=null) {
									venueDivCD = queryMap.get("code").toString();
									venueDivCDName = queryMap.get("codeName").toString();
								}
							}
							
							data.put("sellingAreaID", record.get("col0"));
							data.put("customerID", record.get("col1"));
							data.put("refNo", record.get("col2"));
							data.put("venueCD", record.get("col3"));
							data.put("country", record.get("col4"));
							data.put("territoryCDName", territoryCDName);
							data.put("rageSphereCDName", rageSphereCDName);
							data.put("rageSphereCDName", rageSphereCDName);
							data.put("teamCDName", teamCDName);
							data.put("repNm", record.get("col8"));
							data.put("repNm_KR", record.get("col9"));
							
							data.put("customerNm", record.get("col10"));
							data.put("sellingAreaNm", record.get("col11"));
							data.put("legalCDName", legalCDName);
							data.put("channelCDName", channelCDName);
							data.put("subChannelCDName", subChannelCDName);
							data.put("segmentCDName", segmentCDName);
							data.put("subSegmentCDName", subSegmentCDName);
							data.put("reserveSegmentCDName", reserveSegmentCDName);
							data.put("kegYNName", kegYNName);
							data.put("ageingCDName", ageingCDName);
							
							data.put("siteCDName", siteCDName);
							data.put("venueGradCDName", venueGradCDName);
							data.put("addrTpCD1Name", addrTpCD1Name);
							data.put("addrTpCD2Name", addrTpCD2Name);
							data.put("addrTpCD3Name", addrTpCD3Name);
							data.put("oldAddr2", record.get("col25"));
							data.put("newAddr1", record.get("col26"));
							data.put("postCD", record.get("col27"));
							data.put("phoneNo", record.get("col28"));
							data.put("fasciaCDName", fasciaCDName);
							
							data.put("legacyFrontOfficeAccountNo", record.get("col30"));
							data.put("legacyBackOfficeAccountNo", record.get("col31"));
							data.put("ws1SapCDName", ws1SapCDName);
							data.put("ws2SapCDName", ws2SapCDName);
							data.put("ws3SapCDName", ws3SapCDName);
							data.put("ws4SapCDName", ws4SapCDName);
							data.put("license", record.get("col36"));
							data.put("activeYNName", activeYNName);
							data.put("createDate", createDate);
							data.put("sellingAreaCreatedDate", sellingAreaCreatedDate);
							data.put("lastModifiedDate", lastModifiedDate);
							data.put("sellingAreaLastModifiedDate", sellingAreaLastModifiedDate);
							
							data.put("lastModifiedBy", record.get("col42"));
							data.put("venueDivCDName", venueDivCDName);
							data.put("territoryCD", territoryCD);
							data.put("rageSphereCD", rageSphereCD);
							data.put("teamCD", teamCD);
							data.put("legalCD", legalCD);
							data.put("channelCD", channelCD);
							data.put("subChannelCD", subChannelCD);
							data.put("segmentCD", segmentCD);
							
							data.put("subSegmentCD", subSegmentCD);
							data.put("reserveSegmentCD", reserveSegmentCD);
							data.put("kegYN", kegYN);
							data.put("ageingCD", ageingCD);
							data.put("siteCD", siteCD);
							data.put("venueGradCD", venueGradCD);
							data.put("addrTpCD1", addrTpCD1);
							data.put("addrTpCD2", addrTpCD2);
							data.put("addrTpCD3", addrTpCD3);
	
							data.put("fasciaCD", fasciaCD);
							data.put("ws1SapCD", ws1SapCD);					
							data.put("ws2SapCD", ws2SapCD);					
							data.put("ws3SapCD", ws3SapCD);					
							data.put("ws4SapCD", ws4SapCD);					
							data.put("activeYN", activeYN);
	//						data.put("oldAddr2", oldAddr2);
							data.put("newAddr2", newAddr2);
							data.put("ws1CD", ws1CD);					
							data.put("ws2CD", ws2CD);					
							data.put("ws3CD", ws3CD);					
							data.put("ws4CD", ws4CD);	
							data.put("venueDivCD", venueDivCD);	
							
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
		
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			
			mdm08Service.saveTmpVenueGrid(gven02mt);
			
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
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();
	
		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);

			mdm08Service.requestApprTmpVenue(gven02mt);
			
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
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();
	
		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			
			mdm08Service.clearRequestApprTmpVenue(gven02mt);
			
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
	
	@RequestMapping("/venueSynchronize") //승인요청취소
	public ModelAndView venueSynchronize(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			
			mdm08Service.venueSynchronize(gven02mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.venueSynchronize"));
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
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.venueSynchronize"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}

	@RequestMapping("/saveTmpVenueGrid_Del")
	public ModelAndView saveTmpVenueGrid_Del(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		GVEN02MT gven02mt = new GVEN02MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven02mt);
		
		try {
			gven02mt.clean();
			gven02mt.validate(gven02mt.ACTION_SAVE);
			
			mdm08Service.saveTmpVenueGrid_Del(gven02mt);
			
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
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.delete"));
			rm.setSystemMessage(e.toString());
		}

		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}
	
	@RequestMapping("/extractVenueXlsDel")
	public ModelAndView extractVenueXlsDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
					
						data.put("venueCD", record.get("col0"));
						
						list.add(data);
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
}