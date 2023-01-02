package com.kia.mdm.web;

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

import com.kia.mdm.model.GVEN01MT;
import com.kia.mdm.service.Mdm02Service;

@Controller
@RequestMapping("/service/mdm02")
public class Mdm02Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;
	
//	@Value("#{system['jXls.templateFilePath']}")
//	private String templateFilePath;
	
	@Value("#{appenv['file.venueUpload']}")
	private String venueUploadFile;

	@Resource
	private Mdm02Service mdm02Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("/saveVenue")
	public ModelAndView saveVenue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GVEN01MT gven01mt = new GVEN01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven01mt);
		
		try {
			gven01mt.clean();
			gven01mt.validate(gven01mt.ACTION_SAVE);
			
			if (gven01mt.getActiveFlg().equals("I")) {
				mdm02Service.insertVenue(gven01mt);
			}
			else {
				mdm02Service.updateVenue(gven01mt);
			}
			
			rm.setParameters(gven01mt.getVenueCD());
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
						
						Cell c_venueCD = row.getCell(0);
						Cell c_venueNm = row.getCell(1);
						Cell c_dkmdTpCDName = row.getCell(2);
						Cell c_territoryCDName = row.getCell(3);
						Cell c_venueGradCDName = row.getCell(4);
						Cell c_channelCDName = row.getCell(5);
						Cell c_subChannelCDName = row.getCell(6);
						Cell c_segmentCDName = row.getCell(7);
						Cell c_subSegmentCDName = row.getCell(8);
						Cell c_addrTpCD1Name = row.getCell(9);
						Cell c_addrTpCD2Name = row.getCell(10);
						Cell c_addrTpCD3Name = row.getCell(11);
						Cell c_addrTpCD4Name = row.getCell(12);
						Cell c_wsCDName = row.getCell(13);
						Cell c_wsSapCDName = row.getCell(14);
						Cell c_note1 = row.getCell(15);
						Cell c_note2 = row.getCell(16);
						Cell c_note3 = row.getCell(17);
						Cell c_note4 = row.getCell(18);
						Cell c_incntTpCDName = row.getCell(19);
						Cell c_venueDivCDName = row.getCell(20);
						Cell c_activeYNName = row.getCell(21);
						
						String dkmdTpCDName = "";
						String territoryCDName = "";
						String venueGradCDName = "";
						String channelCDName = "";
						String subChannelCDName = "";
						String segmentCDName = "";
						String subSegmentCDName = "";
						String addrTpCD1Name = "";
						String addrTpCD2Name = "";
						String addrTpCD3Name = "";
						String addrTpCD4Name = "";
						String wsCDName = "";
						String wsSapCDName = "";
						String incntTpCDName = "";
						String venueDivCDName = "";
						String activeYNName = "";
						
						//코드명으로 되어있는 excel 코드값 찾기
						Map param = null;
						Map queryMap = null;
						
						String venueCD = "";
						venueCD = c_venueCD.getStringCellValue();
						
						String dkmdTpCD = "";
						if(c_dkmdTpCDName!=null) {							
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "DKMDTPCD");
							param.put("codeName", c_dkmdTpCDName.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								dkmdTpCD = queryMap.get("code").toString();
								dkmdTpCDName = c_dkmdTpCDName.getStringCellValue();
							}
						}
						String territoryCD = "";
						if(c_territoryCDName!=null) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "TERRITORYCD");
							param.put("codeName", c_territoryCDName.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								territoryCD = queryMap.get("code").toString();
								territoryCDName = c_territoryCDName.getStringCellValue();
							}
						}
						String venueGradCD = "";
						if(c_venueGradCDName!=null) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "VENUEGRADCD");
							param.put("codeName", c_venueGradCDName.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								venueGradCD = queryMap.get("code").toString();
								venueGradCDName = c_venueGradCDName.getStringCellValue();
							}
						}
						String channelCD = "";
						if(c_channelCDName!=null) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "CHANNELCD");
							param.put("codeName", c_channelCDName.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								channelCD = queryMap.get("code").toString();
								channelCDName = c_channelCDName.getStringCellValue();
							}
						}
						String subChannelCD = "";
						if(!channelCD.equals("")) {
							if(c_subChannelCDName!=null) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "SUBCHANNELCD");
								param.put("codeName", c_subChannelCDName.getStringCellValue());
								param.put("attrib02", channelCD);
								queryMap = simpleService.queryForMap("MDM0200104S", param);
								if(queryMap!=null) {
									subChannelCD = queryMap.get("code").toString();
									subChannelCDName = c_subChannelCDName.getStringCellValue();
								}
							}
						}
						String segmentCD = "";
						if(c_segmentCDName!=null) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "SEGMENTCD");
							param.put("codeName", c_segmentCDName.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								segmentCD = queryMap.get("code").toString();
								segmentCDName = c_segmentCDName.getStringCellValue();
							}
						}
						String subSegmentCD = "";
						if(!segmentCD.equals("")) {
							if(c_subSegmentCDName!=null) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "SUBSEGMENTCD");
								param.put("codeName", c_subSegmentCDName.getStringCellValue());
								param.put("attrib02", segmentCD);
								queryMap = simpleService.queryForMap("MDM0200104S", param);
								if(queryMap!=null) {
									subSegmentCD = queryMap.get("code").toString();
									subSegmentCDName = c_subSegmentCDName.getStringCellValue();
								}
							}
						}
						String addrTpCD1 = "";
						if(c_addrTpCD1Name!=null) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "ADDRTPCD1");
							param.put("codeName", c_addrTpCD1Name.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								addrTpCD1 = queryMap.get("code").toString();
								addrTpCD1Name = c_addrTpCD1Name.getStringCellValue();
							}
						}
						String addrTpCD2 = "";
						if(!addrTpCD1.equals("")) {
							if(c_addrTpCD2Name!=null) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "ADDRTPCD2");
								param.put("codeName", c_addrTpCD2Name.getStringCellValue());
								param.put("attrib02", addrTpCD1);
								queryMap = simpleService.queryForMap("MDM0200104S", param);
								if(queryMap!=null) {
									addrTpCD2 = queryMap.get("code").toString();
									addrTpCD2Name = c_addrTpCD2Name.getStringCellValue();
								}
							}
						}
						String addrTpCD3 = "";
						if(!addrTpCD2.equals("")) {
							if(c_addrTpCD3Name!=null) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "ADDRTPCD3");
								param.put("codeName", c_addrTpCD3Name.getStringCellValue());
								param.put("attrib02", addrTpCD2);
								queryMap = simpleService.queryForMap("MDM0200104S", param);
								if(queryMap!=null) {
									addrTpCD3 = queryMap.get("code").toString();
									addrTpCD3Name = c_addrTpCD3Name.getStringCellValue();
								}
							}
						}
						String addrTpCD4 = "";
						if(!addrTpCD3.equals("")) {
							if(c_addrTpCD4Name!=null) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "ADDRTPCD4");
								param.put("codeName", c_addrTpCD4Name.getStringCellValue());
								param.put("attrib02", addrTpCD3);
								queryMap = simpleService.queryForMap("MDM0200104S", param);
								if(queryMap!=null) {
									addrTpCD4 = queryMap.get("code").toString();
									addrTpCD4Name = c_addrTpCD4Name.getStringCellValue();
								}
							}
						}
						String wsCD = "";
						if(c_wsCDName!=null) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "WSCD");
							param.put("codeName", c_wsCDName.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								wsCD = queryMap.get("code").toString();
								wsCDName = c_wsCDName.getStringCellValue();
							}
						}
						String wsSapCD = "";
						if(!wsCD.equals("")) {
							if(c_wsSapCDName!=null) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WSSAPCD");
								param.put("codeName", c_wsSapCDName.getStringCellValue());
								param.put("attrib02", wsCD);
								queryMap = simpleService.queryForMap("MDM0200104S", param);
								if(queryMap!=null) {
									wsSapCD = queryMap.get("code").toString();
									wsSapCDName = c_wsSapCDName.getStringCellValue();
								}
							}
						}
						String incntTpCD = "";
						if(c_incntTpCDName!=null) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "INCNTTPCD");
							param.put("codeName", c_incntTpCDName.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								incntTpCD = queryMap.get("code").toString();
								incntTpCDName = c_incntTpCDName.getStringCellValue();
							}
						}
						String venueDivCD = "";
						if(venueDivCDName!=null) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "VENUEDIVCD");
							param.put("codeName", c_venueDivCDName.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								venueDivCD = queryMap.get("code").toString();
								venueDivCDName = c_venueDivCDName.getStringCellValue();
							}
						}
						String activeYN = "";
						if(c_activeYNName!=null) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "ACTIVEYN");
							param.put("codeName", c_activeYNName.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0200104S", param);
							if(queryMap!=null) {
								activeYN = queryMap.get("code").toString();
								activeYNName = c_activeYNName.getStringCellValue();
							}
						}
						
						data.put("venueCD", venueCD);
						data.put("venueNm", c_venueNm);
						data.put("dkmdTpCDName", dkmdTpCDName);
						data.put("territoryCDName", territoryCDName);
						data.put("venueGradCDName", venueGradCDName);
						data.put("channelCDName", channelCDName);
						data.put("subChannelCDName", subChannelCDName);
						data.put("segmentCDName", segmentCDName);
						data.put("subSegmentCDName", subSegmentCDName);
						data.put("addrTpCD1Name", addrTpCD1Name);
						data.put("addrTpCD2Name", addrTpCD2Name);
						data.put("addrTpCD3Name", addrTpCD3Name);
						data.put("addrTpCD4Name", addrTpCD4Name);
						data.put("wsCDName", wsCDName);
						data.put("wsSapCDName", wsSapCDName);
						data.put("note1", c_note1);
						data.put("note2", c_note2);
						data.put("note3", c_note3);
						data.put("note4", c_note4);
						data.put("incntTpCDName", incntTpCDName);
						data.put("venueDivCDName", venueDivCDName);
						data.put("activeYNName", activeYNName);
						data.put("dkmdTpCD", dkmdTpCD);
						data.put("territoryCD", territoryCD);
						data.put("venueGradCD", venueGradCD);
						data.put("channelCD", channelCD);
						data.put("subChannelCD", subChannelCD);
						data.put("segmentCD", segmentCD);
						data.put("subSegmentCD", subSegmentCD);
						data.put("addrTpCD1", addrTpCD1);
						data.put("addrTpCD2", addrTpCD2);
						data.put("addrTpCD3", addrTpCD3);
						data.put("addrTpCD4", addrTpCD4);
						data.put("wsCD", wsCD);
						data.put("wsSapCD", wsSapCD);
						data.put("incntTpCD", incntTpCD);
						data.put("venueDivCD", venueDivCD);
						data.put("activeYN", activeYN);

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
	
//	@RequestMapping("/saveVenueGrid")
//	public ModelAndView saveVenueGrid(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		GVEN01MT gven01mt = new GVEN01MT();
//		ResultMessage rm = new ResultMessage();
//
//		bind(request, gven01mt);
//		
//		try {
//			gven01mt.clean();
//			gven01mt.validate(gven01mt.ACTION_SAVE);
//			
//			mdm02Service.saveVenueGrid(gven01mt);
//			
//			rm.setCode(rm.RESULT_SUCCESS);
//			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
//		}
//		catch (InputRequiredException e) {
//			rm.setCode(rm.RESULT_ERROR);
//			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
//		}
//		catch (SelectRequiredException e) {
//			rm.setCode(rm.RESULT_ERROR);
//			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
//		}
//		catch (Exception e) {
//			if (logger.isDebugEnabled()) {
//				logger.debug(e.toString());
//				e.printStackTrace();
//			}
//
//			rm.setCode(rm.RESULT_ERROR);
//			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
//			rm.setSystemMessage(e.toString());
//		}
//
//		ModelAndView mv = new ModelAndView("resultView");
//		mv.addObject("resultMsg", rm);
//
//		return mv;
//	}
	
	@RequestMapping("/saveVenueGrid")
	public ModelAndView saveVenueGrid(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		GVEN01MT gven01mt = new GVEN01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gven01mt);
		
		try {
			gven01mt.clean();
			gven01mt.validate(gven01mt.ACTION_SAVE);
			for(int i=0;i<gven01mt.getActiveYNs().length;i++)
				System.out.print(gven01mt.getActiveYNs()[i]+", ");
			mdm02Service.saveVenueGrid(gven01mt);
			
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