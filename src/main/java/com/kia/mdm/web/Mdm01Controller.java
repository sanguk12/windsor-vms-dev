package com.kia.mdm.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kia.mdm.model.GAPP01MT;
import com.kia.mdm.model.GEMP01MT;
import com.kia.mdm.model.GEMP01MTs;
import com.kia.mdm.service.Mdm01Service;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.common.FileInfo;
import kr.co.nis.waf.common.FileUploadUtil;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.util.StringUtil;
import kr.co.nis.waf.view.SimpleDoc;

@Controller
@RequestMapping("/service/mdm01")
public class Mdm01Controller extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;

	@Resource
	private Mdm01Service mdm01Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@RequestMapping("listTree")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map param = new HashMap();
		SessionManager session = new SessionManager(request, response);
		
		bind(request, param);

		GAPP01MT gapp01mt = new GAPP01MT();
		gapp01mt.setCompanyID(session.getCompanyID());
		gapp01mt.setApprTpID(StringUtil.nullToBlank(request.getParameter("apprTpID"), ""));
		
		mav.addObject("apprTreeView", simpleService.queryForList("MDM0100201S", gapp01mt));
		setObjectAll(mav, request, response, param);
		return mav;
	}
	
	@RequestMapping("/saveAppr")
	public ModelAndView saveAppr(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAPP01MT gapp01mt = new GAPP01MT();
		Code seqID = new Code();
		ResultMessage rm = new ResultMessage();

		bind(request, gapp01mt);
		bind(request, seqID);
		
		try {
			gapp01mt.clean();
			gapp01mt.validate(gapp01mt.ACTION_SAVE);
			
			if (gapp01mt.getApprTpID().equals("")) {
				seqID.setSeqDiv("APPRTPID");
				String apprTpID = codeService.getSeqIDNoComp(seqID).get("seqID").toString();
				gapp01mt.setApprTpID(apprTpID);
				mdm01Service.insertAppr(gapp01mt);
			}
			else {
				mdm01Service.updateAppr(gapp01mt);
			}
			
			rm.setParameters(gapp01mt.getApprTpID());
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
	
	@RequestMapping("/deleteAppr")
	public ModelAndView deleteAppr(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAPP01MT gapp01mt = new GAPP01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gapp01mt);
		
		Map<String, Object> params = new HashMap<String, Object>();
		bind(request, params);
		
		try {
			gapp01mt.clean();
			gapp01mt.validate(gapp01mt.ACTION_REMOVE);
			
			mdm01Service.deleteAppr(gapp01mt);
			
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
	
	@RequestMapping("/saveApprGrp")
	public ModelAndView saveApprGrp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAPP01MT gapp01mt = new GAPP01MT();
		ResultMessage rm = new ResultMessage();
		Map params = new HashMap();
		
		bind(request, gapp01mt);
		bind(request, params);
		
		try {
			gapp01mt.clean();
			gapp01mt.validate(gapp01mt.ACTION_SAVE);
			
			//승인라인 담당자 중복체크
			int overlapCount = 0;
			overlapCount = simpleService.queryForInt("MDM0100207S", gapp01mt);
			if (params.get("activeFlg").equals("I")) {
				if(overlapCount > 0) {
					rm.setCode(rm.RESULT_ERROR);
					rm.setMessage(getMessageSourceAccessor().getMessage("MDM01002F.msg5"));
				}
				else {
					mdm01Service.insertApprGrp(gapp01mt);
					rm.setCode(rm.RESULT_SUCCESS);
					rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
				}
			}
			else {
				//수정시 담당자가 변경이 안되었을때
				if(gapp01mt.getEmpID().equals(gapp01mt.getOrgEmpID())) {
					if(overlapCount > 1) {
						rm.setCode(rm.RESULT_ERROR);
						rm.setMessage(getMessageSourceAccessor().getMessage("MDM01002F.msg5"));
					}
					else {
						mdm01Service.updateApprGrp(gapp01mt);
						rm.setCode(rm.RESULT_SUCCESS);
						rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
					}
				}
				else {
					if(overlapCount > 0) {
						rm.setCode(rm.RESULT_ERROR);
						rm.setMessage(getMessageSourceAccessor().getMessage("MDM01002F.msg5"));
					}
					else {
						mdm01Service.updateApprGrp(gapp01mt);
						rm.setCode(rm.RESULT_SUCCESS);
						rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
					}
				}
			}
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
	
	@RequestMapping("/deleteApprGrp")
	public ModelAndView deleteApprGrp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAPP01MT gapp01mt = new GAPP01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, gapp01mt);
		
		Map<String, Object> params = new HashMap<String, Object>();
		bind(request, params);
		
		try {
			gapp01mt.clean();
			gapp01mt.validate(gapp01mt.ACTION_REMOVE);
			
			mdm01Service.deleteApprGrp(gapp01mt);
			
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

	@RequestMapping("/saveEmployee")
	public ModelAndView saveEmployee(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SessionManager session = new SessionManager(request, response);
		GEMP01MT gemp01mt = new GEMP01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gemp01mt);

		try {
			gemp01mt.clean();
			int cnt = simpleService.queryForInt("MDM0100104S", gemp01mt);
			
			if(cnt > 0){
				gemp01mt.validate(gemp01mt.ACTION_MODIFY);
				
				String territoryCD = gemp01mt.getTerritoryCD();
				if(!territoryCD.equals("") || !territoryCD.equals(null)) {
					int chgTerritoryCnt = simpleService.queryForInt("MDM0100108S", gemp01mt);
					
					if(chgTerritoryCnt > 0){
						throw new DataIntegrityViolationException("다른 사용자에 의해 사용되고 있는 territory입니다.");
					}
				}
				mdm01Service.modifyEmployee(gemp01mt);
			} else {
				gemp01mt.validate(gemp01mt.ACTION_ADD);
				
				String territoryCD = gemp01mt.getTerritoryCD();
				if(!territoryCD.equals("") || !territoryCD.equals(null)) {
					int newTerritoryCnt = simpleService.queryForInt("MDM0100107S", gemp01mt);
					
					if(newTerritoryCnt > 0){
						throw new DataIntegrityViolationException("다른 사용자에 의해 사용되고 있는 territory입니다.");
					}
				}
				
				mdm01Service.addEmployee(gemp01mt);
			}

			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (DataIntegrityViolationException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(e.getMessage());
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
	
	//엑셀업로드
	@RequestMapping("/extractEmpXls")
	public ModelAndView extractEmpXls(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
						
						Cell c_dkmdTpCD = row.getCell(0);
						Cell c_empID = row.getCell(1);
						Cell c_empNm = row.getCell(2);
						Cell c_empTpCD = row.getCell(3);
						Cell c_empTpCDName = row.getCell(4);
						Cell c_rageSphereCD = row.getCell(5);
						Cell c_rageSphereCDName = row.getCell(6);
						Cell c_officeCD = row.getCell(7);
						Cell c_officeCDName = row.getCell(8);
						Cell c_teamCD = row.getCell(9);
						Cell c_teamCDName = row.getCell(10);
						Cell c_territoryCD = row.getCell(11);
						Cell c_territoryCDName = row.getCell(12);
						Cell c_emailAddr = row.getCell(13);
						Cell c_workStatCD = row.getCell(14);
						Cell c_workStatCDName = row.getCell(15);
						Cell c_grpID = row.getCell(16);
						Cell c_grpIDName = row.getCell(17);
						
						String dkmdTpCDName = "";
						String empTpCDName = "";
						String rageSphereCDName = "";
						String officeCDName = "";
						String teamCDName = "";
						String territoryCDName = "";
						String workStatCDName = "";
						String grpIDName = "";
						
						//코드가 맞는지 체크
						Map param = null;
						Map queryMap = null;
						
						String empID = "";
						empID = c_empID.getStringCellValue();
						logger.debug("######empID : "+empID);
						String dkmdTpCD = "";
						if(!c_dkmdTpCD.getStringCellValue().equals("")) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "DKMDTPCD");
							param.put("comCode", c_dkmdTpCD.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0100105S", param);
							if(queryMap!=null) {
								dkmdTpCDName = queryMap.get("codeName").toString();
								dkmdTpCD = c_dkmdTpCD.getStringCellValue();
							}
							else {
								dkmdTpCDName = "";
								dkmdTpCD = "";
							}
						}
						String empTpCD = "";
						if(!c_empTpCD.getStringCellValue().equals("")) {
							param = new HashMap();
							queryMap = new HashMap();
							param.put("codeDiv", "EMPTPCD");
							param.put("comCode", c_empTpCD.getStringCellValue());
							queryMap = simpleService.queryForMap("MDM0100105S", param);
							if(queryMap!=null) {
								empTpCDName = queryMap.get("codeName").toString();
								empTpCD = c_empTpCD.getStringCellValue();
							}
							else {
								empTpCDName = "";
								empTpCD = "";
							}
						}
						String rageSphereCD = "";
						if(c_rageSphereCD!=null) {
							if(!c_rageSphereCD.getStringCellValue().equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "RAGESPHERECD");
								param.put("comCode", c_rageSphereCD.getStringCellValue());
								queryMap = simpleService.queryForMap("MDM0100105S", param);
								if(queryMap!=null) {
									rageSphereCDName = queryMap.get("codeName").toString();
									rageSphereCD = c_rageSphereCD.getStringCellValue();
								}
								else {
									rageSphereCDName = "";
									rageSphereCD = "";
								}
							}
						}
						String officeCD = "";
						if(!rageSphereCD.equals("")) {
							if(c_officeCD!=null) {
								if(!c_officeCD.getStringCellValue().equals("")) {
									param = new HashMap();
									queryMap = new HashMap();
									param.put("codeDiv", "OFFICECD");
									param.put("comCode", c_officeCD.getStringCellValue());
									param.put("attrib02", rageSphereCD);
									queryMap = simpleService.queryForMap("MDM0100105S", param);
									if(queryMap!=null) {
										officeCDName = queryMap.get("codeName").toString();
										officeCD = c_officeCD.getStringCellValue();
									}
									else {
										officeCDName = "";
										officeCD = "";
									}
								}
							}
						}
						String teamCD = "";
						if(!officeCD.equals("")) {
							if(c_teamCD!=null) {
								if(!c_teamCD.getStringCellValue().equals("")) {
									param = new HashMap();
									queryMap = new HashMap();
									param.put("codeDiv", "TEAMCD");
									param.put("comCode", c_teamCD.getStringCellValue());
									param.put("attrib02", officeCD);
									queryMap = simpleService.queryForMap("MDM0100105S", param);
									if(queryMap!=null) {
										teamCDName = queryMap.get("codeName").toString();
										teamCD = c_teamCD.getStringCellValue();
									}
									else {
										teamCDName = "";
										teamCD = "";
									}
								}
							}
						}
						String territoryCD = "";
						if(!teamCD.equals("")) {
							if(c_territoryCD!=null) {
								if(!c_territoryCD.getStringCellValue().equals("")) {
									param = new HashMap();
									queryMap = new HashMap();
									param.put("codeDiv", "TERRITORYCD");
									param.put("comCode", c_territoryCD.getStringCellValue());
									param.put("attrib02", teamCD);
									queryMap = simpleService.queryForMap("MDM0100105S", param);
									if(queryMap!=null) {
										territoryCDName = queryMap.get("codeName").toString();
										territoryCD = c_territoryCD.getStringCellValue();
									}
									else {
										territoryCDName = "";
										territoryCD = "";
									}
								}
							}
						}
						String workStatCD = "";
						if(c_workStatCD!=null) {
							if(!c_workStatCD.getStringCellValue().equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("codeDiv", "WORKSTATCD");
								param.put("comCode", c_workStatCD.getStringCellValue());
								queryMap = simpleService.queryForMap("MDM0100105S", param);
								if(queryMap!=null) {
									workStatCDName = queryMap.get("codeName").toString();
									workStatCD = c_workStatCD.getStringCellValue();
								}
								else {
									workStatCDName = "";
									workStatCD = "";
								}
							}
						}
						String grpID = "";
						if(c_grpID!=null) {
							if(!c_grpID.getStringCellValue().equals("")) {
								param = new HashMap();
								queryMap = new HashMap();
								param.put("grpID", c_grpID.getStringCellValue());
								queryMap = simpleService.queryForMap("MDM0100106S", param);
								if(queryMap!=null) {
									grpIDName = queryMap.get("grpName").toString();
									grpID = c_grpID.getStringCellValue();
								}
							}
						}
						data.put("dkmdTpCDName", dkmdTpCDName);
						data.put("empID", c_empID);
						data.put("empNm", c_empNm);
						data.put("empTpCDName", empTpCDName);
						data.put("rageSphereCDName", rageSphereCDName);
						data.put("officeCDName", officeCDName);
						data.put("teamCDName", teamCDName);
						data.put("territoryCDName", territoryCDName);
						data.put("emailAddr", c_emailAddr);
						data.put("workStatCDName", workStatCDName);
						data.put("grpIDName", grpIDName);
						data.put("dkmdTpCD", dkmdTpCD);
						data.put("empTpCD", empTpCD);
						data.put("rageSphereCD", rageSphereCD);
						data.put("officeCD", officeCD);
						data.put("teamCD", teamCD);
						data.put("territoryCD", territoryCD);
						data.put("workStatCD", workStatCD);
						data.put("grpID", grpID);

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
	
	@RequestMapping("/saveEmpGrid")
	public ModelAndView saveEmpGrid(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		GEMP01MTs gemp01mts = new GEMP01MTs();
		ResultMessage rm = new ResultMessage();
		
		SessionManager session = new SessionManager(request, response);

		bind(request, gemp01mts);
		
		try {
			gemp01mts.clean();
			gemp01mts.validate(gemp01mts.ACTION_SAVE);
			
			for (int i = 0; i < gemp01mts.getSize(); i++) {
				GEMP01MT gemp01mt = gemp01mts.getGEMP01MT(i);
				
				gemp01mt.setCompanyID(session.getCompanyID());
				
				int cnt = simpleService.queryForInt("MDM0100104S", gemp01mt);
				
				if(cnt > 0){
					mdm01Service.modifyEmployee(gemp01mt);
				} else {
					mdm01Service.addEmployee(gemp01mt);
				}
				
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
	
	
	
	@RequestMapping("/test")
	public ModelAndView test(HttpServletRequest request, HttpServletResponse response, String[] array) throws Exception {

		SessionManager session = new SessionManager(request, response);
		GEMP01MT gemp01mt = new GEMP01MT();
		ResultMessage rm = new ResultMessage();

		bind(request, gemp01mt);

		try {
	         int numArr[] = new int[6];
	         int sum =0;
	         
	         
	         for(int i =0; i< 5; i++) {
	            for(int j= 0; j< i; j++) {
	            	double randoms = Math.random();
		        	 int z = (int)(randoms * 45) + 1;
		        	 numArr[j] = z;
		        	 if(numArr[i] == numArr[j]){   
		        		 i = i--;       
	        		    break;       
		        	}
	            
	            }
	            Arrays.sort(numArr);
	            
	            for(int z = 0; z< numArr.length; z++) {
	            	System.out.print(numArr[z] +"\t");
	            }System.out.println();
	            
	            
	         }
	            
	            /*
	            for(int k=0; k<5; k++) {
	               for (int l= k+1; l<6;l++) {
	                  if(numArr[k]>numArr[l]) {
	                     int temp = numArr[k];
	                     numArr[k] = numArr[l];
	                     numArr[l] = temp;
	                  }
	               }
	            }
	            */
	         
		}
	          
		

			
			
			/*String aa = test1(gemp01mt);
			System.out.println("aa : "+aa);
			
			String bb = test2(gemp01mt);
			System.out.println("bb : "+bb);
			*/
		
		
			
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

	private void sort() {
		// TODO Auto-generated method stub
		
	}

	/*public String test1(GEMP01MT gemp01mt) throws Exception {
	      String aa="";
	      
	      try {
	         Pattern p = Pattern.compile("(^[0-9]*$)");
	         
	         aa = gemp01mt.getEmpID();
	         Matcher m = p.matcher(aa);
	         
	         if(m.find()){
	        	 System.out.println("숫자는 못 넣습니다.");
	         }else{
	        	 System.out.println(aa);
	         } 
	      } catch (Exception e) {
	         System.out.println(e.toString());
	      }
	      return aa;
	   }
	
	public String test2(GEMP01MT gemp01mt) throws Exception {
		String bb = "";
		  
	      try {
	         Pattern p = Pattern.compile("^[a-zA-Z]*$");
	         
	         bb = gemp01mt.getEmpID();
	         Matcher m = p.matcher(bb);
	         
	         if(m.find()){
	            System.out.println("영어는 못 넣습니다.");
	         }else{
	        	 System.out.println(bb);
	         } 
	      } catch (Exception e) {
	         System.out.println(e.toString());
	      }
	      return bb;
	   }*/
	
}