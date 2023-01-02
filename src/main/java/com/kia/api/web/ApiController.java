package com.kia.api.web;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.spec.KeySpec;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.api.ResultData;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.auth.model.User;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.view.SimpleDoc;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Cell;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.api.model.GAPI01MT;
import com.kia.api.service.Api01Service;

@Controller
@RequestMapping("/service/api")
public class ApiController extends SimpleMultiActionController{
	
    protected final Log logger = LogFactory.getLog(getClass());
 
    @Value("#{system['docLink.realUploadSignPath']}")
	private String realUploadSignPath;
    
    @Value("#{appenv['app.api.token']}")
    private String token;
    
    @Value("#{appenv['nice.id']}")
    private String niceId;
    
    @Value("#{appenv['nice.pass']}")
    private String nicePass;
    
    @Value("#{appenv['bank.api.key']}")
    private String bankKey;

    //쿼리 서비스
    @Resource
    private SimpleService simpleService;

    //ID생성 서비스
    @Resource
    private CodeService codeService;
    
    @Resource
	private Api01Service api01Service;

	/**
	 * 앱컨텐츠 버전체크 및 다운로드 링크 제공
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/checkAppVersion")
	public ModelAndView checkAppVersion(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map parameter = new HashMap();
		ResultData rd = new ResultData();
		boolean checkCondition = true;
	
		bind(request, parameter);
		rd.setCode(rd.RESULT_ERROR);
		
		Map app = simpleService.queryForMap("MCOM00001", parameter);
		if(app == null){
			// 등록된 앱이 없을 경우
			rd.setParam("appCode","EA");
			rd.setParam("appMsg","등록되지 않은 앱입니다.");
			checkCondition = false;
		}
		else {
			if(app.get("useYN") == null || app.get("useYN").toString().equals("N")){
				// 사용 유무가 빈값 or N인 경우
				rd.setParam("appCode","SA");
				rd.setParam("appMsg","사용 중지 된 앱입니다.");
				checkCondition = false;
			}
		}
		
		if (checkCondition) {
			// 앱, 컨텐츠 파일 버전 확인
			Map appVersion = simpleService.queryForMap("MCOM00002", parameter);
			if (appVersion == null) {
				// 앱에 등록된 버전이 없는 경우
				rd.setParam("appCode","NV");
				rd.setParam("appMsg","앱에 등록된 버전 정보가 없습니다.");
				checkCondition = false;
			}
			else {
				// 앱에 등록된 버전인 경우
				logger.debug("appVersion null check " + appVersion);
				logger.debug("appVersion versionNo check " + (Double.parseDouble(appVersion.get("versionNo").toString()) > Double.parseDouble(parameter.get("appVersion").toString()))); 
				
				if (Double.parseDouble(appVersion.get("versionNo").toString()) > Double.parseDouble(parameter.get("appVersion").toString())){
					// 등록된 최상위 사용 버전과 사용 중인 앱 버전이 낮은 경우
					// 파일 경로 or 앱스토어 url
					rd.setParam("appCode","LV");
					rd.setParam("appMsg","현재 낮은 버전 사용 중입니다.");
					checkCondition = false;
				}
				else {
					Map contentsVersion = simpleService.queryForMap("MCOM00003", parameter);
					if (contentsVersion == null) {
						rd.setParam("appCode","NC");
						rd.setParam("appMsg","앱에 등록된 컨텐츠 파일이 없습니다.");
						checkCondition = false;
					}
					else {
						logger.debug("contentsVersion null check " + contentsVersion);
					
						if(contentsVersion != null && Double.parseDouble(contentsVersion.get("contentsVer").toString()) > Double.parseDouble(parameter.get("contentsVer").toString())){
							Map url = simpleService.queryForMap("MCOM00004", parameter);
	
							rd.setParam("url", "/contentsDown/" + url.get("packageNm").toString() + "_" + url.get("appOs").toString() + "_" + url.get("versionNo").toString() + ".zip");
							rd.setParam("ver", url.get("contentVer").toString());
							
							rd.setParam("appCode","LC");
							rd.setParam("appMsg","컨텐츠 파일 버전이 낮습니다.");
							checkCondition = false;	
						}
					}
				}
			}
		}
		
		if (checkCondition) {
			rd.setCode(rd.RESULT_SUCCESS);
			rd.setParam("appCode","S");
			rd.setParam("appMsg","변경된 버전 파일이 없습니다.");
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		return mv;
	}

	/**
	 * 로그인 인증
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map parameter = new HashMap();
		User user = new User();
		ResultData rd = new ResultData();
	
		bind(request, parameter);
		bind(request, user);
		
		user.setCompanyID("000001");
		
		try {
			if (simpleService.queryForInt("LOGIN01S",user) > 0) {
				List data = simpleService.queryForList("LOGIN02S",user);
				
				rd.setCode(rd.RESULT_SUCCESS);
				rd.setParam("token",token);
				rd.setData(data);
			}
			else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("아이디 및 비밀번호를 확인하십시오.");
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		
		return mv;
	}
	
	
	/**
	 * 본인인증 완료
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/completeAuth")	
	public ModelAndView completeAuth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map parameter = new HashMap();
		GAPI01MT gapi01mt = new GAPI01MT();
		ResultData rd = new ResultData();
		
		bind(request, parameter);
		
		
		try 
		{
			if (parameter.get("token") != null && parameter.get("token").toString().equals(this.token)) {
				gapi01mt.setUserID(parameter.get("userID").toString());
				gapi01mt.setKeymanID(parameter.get("keymanID").toString());

				GAPI01MT mt = new GAPI01MT();		
				mt.setKeymanID(parameter.get("keymanID").toString());

				HashMap birth = new HashMap();
				birth = (HashMap) simpleService.queryForMap("API0100130S",mt);
				String key = parameter.get("userID").toString() + birth.get("birthDate"); //ID + 생년월일
				
				String ciphertext = parameter.get("regIDNo").toString();
				String passPhrase = key;
		        String decrypted = decrypt(passPhrase, ciphertext, 100, 128);
				
				String regIDNo = decrypted;
				gapi01mt.setRegIDNo(regIDNo);
				
				api01Service.updateCompleteAuth(gapi01mt);	
				rd.setCode(rd.RESULT_SUCCESS);
				rd.setMessage("정상적으로 처리되었습니다.");
				rd.setParam("token",token);			
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}
		}catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);		
		
		return mv;
	}
	
	/**
	 * 계약현황 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getContractList")
	public ModelAndView getContractList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map parameter = new HashMap();
		User user = new User();
		ResultData rd = new ResultData();
		
		bind(request, parameter);
		bind(request, user);
		user.setCompanyID("000001");
		
		try {
			if (parameter.get("token") != null && parameter.get("token").toString().equals(this.token)) {
				List data = simpleService.queryForList("ContractList01S", parameter);
				
				if (data.size() > 0) {
					rd.setCode(rd.RESULT_SUCCESS);
					rd.setData(data);
				}
				else {
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage("계약현황이 없습니다.");
				}
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}	
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		
		return mv;
	}
	
	/**
	 * 계약현황 상세 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getContract")
	public ModelAndView getContract(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map parameter = new HashMap();
		User user = new User();
		ResultData rd = new ResultData();
		GAPI01MT gapi01mt = new GAPI01MT();
		
		bind(request, parameter);
		bind(request, user);
		
		user.setCompanyID("000001");
		
		try {
			if (parameter.get("token") != null && parameter.get("token").toString().equals(this.token)) {
				List data = new ArrayList();
				data = simpleService.queryForList("Contract01S", parameter);
				HashMap dataHM = new HashMap();
				dataHM = (HashMap) simpleService.queryForMap("Contract01S", parameter);
				
				if (dataHM.size() > 0) {
					GAPI01MT mt = new GAPI01MT();		
					mt.setKeymanID(dataHM.get("KEYMANID").toString());
					String ciphertext = "";
					if(dataHM.get("accountNo") != null){
						ciphertext = dataHM.get("accountNo").toString();
					}
					
					if(ciphertext != null && ciphertext != ""){
						HashMap birth = new HashMap();
						birth = (HashMap) simpleService.queryForMap("API0100130S",mt);
						String key = parameter.get("userID").toString() + birth.get("birthDate"); //ID + 생년월일
						String passPhrase = key;
						dataHM.put("accountNo",encrypt(passPhrase, ciphertext, 100, 128));
					}

					data.clear();
					data.add(0,dataHM);
					rd.setCode(rd.RESULT_SUCCESS);
					rd.setData(data);
				}
				else {
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage("계약현황이 없습니다.");
				}
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}	
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		return mv;
	}
	
	/**
	 * 계약 체결
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/signContract")
	public ModelAndView signContract(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map        pt     = new HashMap();
		GAPI01MT   mtC    = new GAPI01MT();
		GAPI01MT   mt     = new GAPI01MT();
		ResultData rd     = new ResultData();
		
		bind(request, pt);
		bind(request, mtC);
		
		mt.setKeymanID(pt.get("keymanID").toString());
		mt.setContractYN(pt.get("contractYN").toString());
		mt.setContract01(pt.get("contract01").toString());
		mt.setContract02(pt.get("contract02").toString());
		mt.setContract03(pt.get("contract03").toString());
		mt.setContract04(pt.get("contract04").toString());
		mt.setContract05(pt.get("contract05").toString());
		mt.setContract06(pt.get("contract06").toString());
		mt.setContract07(pt.get("contract07").toString());
		mt.setContract08(pt.get("contract08").toString());
		mt.setContract09(pt.get("contract09").toString());
		mt.setContract10(pt.get("contract10").toString());
		
		String fileBase64 = pt.get("contractSign").toString().split(";")[1].substring(7);
		String ext = pt.get("contractSign").toString().split("/")[1].split(";")[0];
		byte[] imgBytes = DatatypeConverter.parseBase64Binary(fileBase64);
		
		Calendar cal = Calendar.getInstance();
		String year = String.valueOf(cal.get(Calendar.YEAR));
		String month = (cal.get(Calendar.MONTH) + 1) < 10 ? "0" + String.valueOf((cal.get(Calendar.MONTH) + 1)) : String.valueOf((cal.get(Calendar.MONTH) + 1));  
		String day = cal.get(Calendar.DAY_OF_MONTH) < 10 ? "0" + String.valueOf(cal.get(Calendar.DAY_OF_MONTH)) : String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
		String hour = cal.get(Calendar.HOUR_OF_DAY) < 10 ? "0" + String.valueOf(cal.get(Calendar.HOUR_OF_DAY)) : String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
		String minute = cal.get(Calendar.MINUTE) < 10 ? "0" + String.valueOf(cal.get(Calendar.MINUTE)) : String.valueOf(cal.get(Calendar.MINUTE));
		String second = cal.get(Calendar.SECOND) < 10 ? "0" + String.valueOf(cal.get(Calendar.SECOND)) : String.valueOf(cal.get(Calendar.SECOND));
		String millisecond = cal.get(Calendar.MILLISECOND) < 10 ? "0" + String.valueOf(cal.get(Calendar.MILLISECOND)) : String.valueOf(cal.get(Calendar.MILLISECOND));
		
		String fileNm = "SIGN_"
					  + year + month + day + "_"
					  + hour + minute + second + "_" + millisecond; 
		
		BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imgBytes));
		
		String folderPath = "/upload/SIGNIMAGE/";
		String fullFolderPath = this.realUploadSignPath+folderPath;
		File folder = new File(fullFolderPath);
		
		if(!folder.exists()){
			folder.mkdirs();
		}
		String fullFilePath = fullFolderPath + fileNm + "." + ext;
		String filePath = folderPath + fileNm + "." + ext;
		ImageIO.write(bufImg, ext, new File(fullFilePath));
		
		mt.setContractIMG(filePath);
	
		try 
		{
			if (pt.get("token") != null && pt.get("token").toString().equals(this.token)) {
				
				if(simpleService.queryForInt("API0100120S",mtC) > 0) {
					
					api01Service.updateSignContract(mt);			
					
					rd.setCode(rd.RESULT_SUCCESS);
					rd.setMessage("체결 완료되었습니다.");
				}else{			
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage("계좌인증이 되어 있지 않습니다. 계좌버튼을 클릭 후 계좌인증을 진행해 주세요.");
				}
				
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}
				
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("체결 실패하였습니다.");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);		
		
		return mv;
	}

	/**
	 * 판매관리 리스트 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getSalesPromotionList")
	public ModelAndView getSalesPromotionList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map parameter = new HashMap();
		User user = new User();
		ResultData rd = new ResultData();
		HashMap dataHM = new HashMap();
		List resultData = new ArrayList();
		
		bind(request, parameter);
		bind(request, user);
		
		user.setCompanyID("000001");
		try {
			if (parameter.get("token") != null && parameter.get("token").toString().equals(this.token)) {
				List data = simpleService.queryForList("SalesPromotionList01S", parameter);
				if (data.size() > 0) {
					for(int i=0;i<data.size();i++){
						dataHM = (HashMap) data.get(i);
						
						GAPI01MT mt = new GAPI01MT();		
						mt.setKeymanID(dataHM.get("keymanID").toString());
						String ciphertext = "";
						if(dataHM.get("accountNo") != null){
							ciphertext = dataHM.get("accountNo").toString();
						}
						
						if(ciphertext != null && ciphertext != ""){
							HashMap birth = new HashMap();
							birth = (HashMap) simpleService.queryForMap("API0100130S",mt);
							String key = parameter.get("userID").toString() + birth.get("birthDate"); //ID + 생년월일
							String passPhrase = key;
							dataHM.put("accountNo",encrypt(passPhrase, ciphertext, 100, 128));
						}
					}
					
					rd.setCode(rd.RESULT_SUCCESS);
					rd.setData(data);
				}
				else {
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage("계약현황이 없습니다.");
				}
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}	
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		
		return mv;
	}
	
	/**
	 * 판매관리상세 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getSalesPromotion")
	public ModelAndView getSalesPromotion(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map parameter = new HashMap();
		User user = new User();
		ResultData rd = new ResultData();
		
		bind(request, parameter);
		bind(request, user);
		
		user.setCompanyID("000001");
		try {
			if (parameter.get("token") != null && parameter.get("token").toString().equals(this.token)) {
				List data = simpleService.queryForList("SalesPromotion01S", parameter);
				
				if (data.size() > 0) {
					rd.setCode(rd.RESULT_SUCCESS);
					rd.setData(data);
				}
				else {
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage("계약현황이 없습니다.");
				}
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}	
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		
		return mv;
	}
	
	/**
	 * 계좌변경은행조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getBankList")
	public ModelAndView getBankList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map parameter = new HashMap();
		User user = new User();
		ResultData rd = new ResultData();
		
		bind(request, parameter);
		bind(request, user);
		
		user.setCompanyID("000001");
		
		try {
			if (parameter.get("token") != null && parameter.get("token").toString().equals(this.token)) {
				List data = simpleService.queryForList("BankList01S", parameter);
				
				if (data.size() > 0) {
					rd.setCode(rd.RESULT_SUCCESS);					
					rd.setData(data);
				}
				else {
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage("계좌정보가 없습니다.");
				}
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		
		return mv;
	}
	
	/**
	 * 계좌번호변경 (마스터 및 계약정보)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/saveAccountNumber")
	public ModelAndView saveAccountNumber(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map        pt     = new HashMap();
		GAPI01MT   mt     = new GAPI01MT();
		ResultData rd     = new ResultData();
		Map       bankRtn = new HashMap();
		
		bind(request, pt);

		
		mt.setKeymanID(pt.get("keymanID").toString());
		
		HashMap birth = new HashMap();
		birth = (HashMap) simpleService.queryForMap("API0100130S",mt);
		String key = pt.get("userID").toString() + birth.get("birthDate"); //ID + 생년월일
		
		String ciphertext = pt.get("accountNumber").toString();
		String passPhrase = key;
		String decrypted = decrypt(passPhrase, ciphertext, 100, 128);
		
		String accountNumber = decrypted;
		
		
		
		mt.setKeymanID(pt.get("keymanID").toString());
		mt.setBankCD(pt.get("accountBankCode").toString());
		mt.setAccountNO(accountNumber);
		pt.put("accountNumber", accountNumber);
		mt.setHolderNM(pt.get("accountHolder").toString());
		mt.setEventYM(pt.get("eventYM").toString());
		String account_holder_info = pt.get("residentNumber").toString();
		if(account_holder_info.length()>6){
			account_holder_info = account_holder_info.substring(2, account_holder_info.length());
			pt.put("residentNumber", account_holder_info);
		}

		try 
		{
			
			if (pt.get("token") != null && pt.get("token").toString().equals(this.token)) {
				

				String gubun="";
				if(pt.get("gubun") != null){
					gubun=pt.get("gubun").toString();
				}

				bankRtn = chkBankAcc(pt,request);
				String msg = bankRtn.get("msg").toString();
				String rtCd = bankRtn.get("rtCd").toString();
				/*
				String msg = "";
				String rtCd = "S";
				*/
				if("S".equals(rtCd)){
			        api01Service.updateSaveAccountNumber1(mt);
					
			        if("B".equals(gubun)){
			        	//실적 계좌 브랜드단위
			        	api01Service.updateSaveAccountNumber2(mt);
			        }else{
			        	//실적 계좌 업소단위
			        	api01Service.updateSaveAccountNumber3(mt);
			        }
				
					rd.setCode(rd.RESULT_SUCCESS);
					rd.setMessage("저장이 완료되었습니다.");
				}else{
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage(msg);
				}
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}	
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("저장에 실패하였습니다.");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		return mv;
	}
	
	/**
	 * 판매관리승인
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/saveSalesPromotion")
	public ModelAndView saveSalesPromotion(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map        pt     = new HashMap();
		GAPI01MT   mt     = new GAPI01MT();
		ResultData rd     = new ResultData();
		
		bind(request, pt);

		try 
		{
			if (pt.get("token") != null && pt.get("token").toString().equals(this.token)) {
				mt.setEventYM(pt.get("eventYM").toString());
				mt.setVenueCD(pt.get("venueCD").toString());
				mt.setUserID(pt.get("userID").toString());
				mt.setSaleCD01(pt.get("saleCD01").toString());
				mt.setSaleCD02(pt.get("saleCD02").toString());
				mt.setSaleCD03(pt.get("saleCD03").toString());
				mt.setSaleCD04(pt.get("saleCD04").toString());
				mt.setSaleCD05(pt.get("saleCD05").toString());
				mt.setSaleCD06(pt.get("saleCD06").toString());
				mt.setSaleCD07(pt.get("saleCD07").toString());
				mt.setSaleCD08(pt.get("saleCD08").toString());
				mt.setSaleCD09(pt.get("saleCD09").toString());
				mt.setSaleCD10(pt.get("saleCD10").toString());
				
				mt.setKeymanID(pt.get("keymanID").toString());
				mt.setDiffNo(pt.get("diffNo").toString());
				
				if("B".equals(pt.get("gubun").toString())){
			        //JSON데이터를 넣어 JSON Object 로 만들어 준다.
					JSONParser jsonParser = new JSONParser();
			        JSONArray itemsArray = (JSONArray) jsonParser.parse(pt.get("prdCDs").toString());
			        if(itemsArray.size()>0){
				        for(int k=0; k < itemsArray.size(); k++){
				        	JSONObject itemObject = (JSONObject) itemsArray.get(k);
				        	String text = itemObject.get("prdCD").toString();
				        	mt.setPrdCD(text);
				        	//브랜드별 
				        	api01Service.updateSaveSalesPromotion2(mt);	
				        }
			        }
				}else{
		        	/* 업소별 */
		       		api01Service.updateSaveSalesPromotion1(mt);	
		        }	
		        
		        api01Service.updateSaveSalesPromotion3(mt);	
				
		        rd.setCode(rd.RESULT_SUCCESS);
				rd.setMessage("저장이 완료되었습니다.");
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}	
				
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("저장에 실패하였습니다.");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		return mv;
	}
	
	/**
	 * 비밀번호변경
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/changePassword")
	public ModelAndView changePassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean checkCondition = true;
		Map        pt     = new HashMap();
		GAPI01MT   mt     = new GAPI01MT();
		ResultData rd     = new ResultData();
		User user = new User();
		
		bind(request, pt);
		bind(request, user);
		user.setPasswd(pt.get("password").toString());
		mt.setUserID(pt.get("userID").toString());
		mt.setNewPassword(pt.get("newPassword").toString());
		mt.setPassword(pt.get("password").toString());		
		
		try 
		{
			if (pt.get("token") != null && pt.get("token").toString().equals(this.token)) {

				if(simpleService.queryForInt("LOGIN01S",user) < 1){				
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage("기존 비밀번호가 잘못되었습니다.");
					checkCondition = false;
				}
				
				if(checkCondition){
				    api01Service.updateChangePassword(mt);				
				}
				
				rd.setCode(rd.RESULT_SUCCESS);
				rd.setMessage("변경되었습니다.");
				
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}	
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("변경에 실패하였습니다.");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		return mv;
	}
	
	/**
	 * NiecID 인증
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/niceChk")
	public ModelAndView nice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map          pt = new HashMap();
		ResultData   rd = new ResultData();
		ModelAndView mv = new ModelAndView();
		GAPI01MT     mt = new GAPI01MT();
		
		bind(request, pt);
		if (pt.get("token") != null && pt.get("token").toString().equals(this.token)) {
		//if(true){	
			HashMap seqMap = new HashMap();
			seqMap = (HashMap) simpleService.queryForMap("API0100140S",pt);
			String niceSeq = seqMap.get("SEQ").toString();
			
			mt.setSeq(niceSeq);
			mt.setUserID(pt.get("userID").toString());
			api01Service.updateHistory(mt);
			
			mv = new ModelAndView("api/check");
			mv.addObject("niceId", niceId);
			mv.addObject("nicePass", nicePass);
			mv.addObject("userID", pt.get("userID"));
			mv.addObject("seq", niceSeq);
		}else {
			
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("인증정보가 일치하지 않습니다.");
			mv = new ModelAndView("resultDataView");
			mv.addObject("resultData", rd);
		}	
		
		return mv;
	}
	
	@RequestMapping("/niceChkFail")
	public ModelAndView niceF(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ResultData rd     = new ResultData();
		GAPI01MT     mt = new GAPI01MT();
		
		NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

	    String sSiteCode = niceId;				// NICE로부터 부여받은 사이트 코드
	    String sSitePassword = nicePass;		// NICE로부터 부여받은 사이트 패스워드

	    String sCipherTime = "";			// 복호화한 시간
	    String sRequestNumber = "";			// 요청 번호
	    String sErrorCode = "";				// 인증 결과코드
	    String sAuthType = "";				// 인증 수단
	    String sMessage = "인증에 실패했습니다.";
	    String sPlainData = "";
	    
	    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

	    if( iReturn == 0 )
	    {
	        sPlainData = niceCheck.getPlainData();
	        sCipherTime = niceCheck.getCipherDateTime();
	        
	        // 데이타를 추출합니다.
	        HashMap mapresult = niceCheck.fnParse(sPlainData);
	        
	        sRequestNumber 	= (String)mapresult.get("REQ_SEQ");
	        sErrorCode 		= (String)mapresult.get("ERR_CODE");
	        sAuthType 		= (String)mapresult.get("AUTH_TYPE");

	        mt.setSeq(sRequestNumber);
	        mt.setErrCode(sErrorCode);
	        mt.setAuthType(sAuthType);
			api01Service.updateHistory(mt);
	        
	        rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }
	    else if( iReturn == -1)
	    {
	        sMessage = "복호화 시스템 에러입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -4)
	    {
	        sMessage = "복호화 처리오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -5)
	    {
	        sMessage = "복호화 해쉬 오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -6)
	    {
	        sMessage = "복호화 데이터 오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -9)
	    {
	        sMessage = "입력 데이터 오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -12)
	    {
	        sMessage = "사이트 패스워드 오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else
	    {
	        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		return mv;
	}
	
	@RequestMapping("/niceChkSuccess")
	public ModelAndView niceS(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GAPI01MT     mt = new GAPI01MT();
		ResultData rd     = new ResultData();

		NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

	    String sSiteCode = niceId;				// NICE로부터 부여받은 사이트 코드
	    String sSitePassword = nicePass;		// NICE로부터 부여받은 사이트 패스워드

	    String sCipherTime = "";			// 복호화한 시간
	    String sRequestNumber = "";			// 요청 번호
	    String sResponseNumber = "";		// 인증 고유번호
	    String sAuthType = "";				// 인증 수단
	    String sName = "";					// 성명
	    String sDupInfo = "";				// 중복가입 확인값 (DI_64 byte)
	    String sConnInfo = "";				// 연계정보 확인값 (CI_88 byte)
	    String sBirthDate = "";				// 생년월일(YYYYMMDD)
	    String sGender = "";				// 성별
	    String sNationalInfo = "";			// 내/외국인정보 (개발가이드 참조)
		String sMobileNo = "";				// 휴대폰번호
		String sMobileCo = "";				// 통신사
	    String sMessage = "";
	    String sPlainData = "";
	    
	    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

	    if( iReturn == 0 )
	    {
	        sPlainData = niceCheck.getPlainData();
	        sCipherTime = niceCheck.getCipherDateTime();
	        
	        // 데이타를 추출합니다.
	        HashMap mapresult = niceCheck.fnParse(sPlainData);
	        
	        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
	        sResponseNumber = (String)mapresult.get("RES_SEQ");
	        sAuthType		= (String)mapresult.get("AUTH_TYPE");
	        sName			= (String)mapresult.get("NAME");
			//sName			= (String)mapresult.get("UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
	        sBirthDate		= (String)mapresult.get("BIRTHDATE");
	        sGender			= (String)mapresult.get("GENDER");
	        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
	        sDupInfo		= (String)mapresult.get("DI");
	        sConnInfo		= (String)mapresult.get("CI");
	        sMobileNo		= (String)mapresult.get("MOBILE_NO");
	        sMobileCo		= (String)mapresult.get("MOBILE_CO");
	        
	        mt.setSeq(sRequestNumber);
	        mt.setResSeq(sResponseNumber);
	        mt.setAuthType(sAuthType);
	        mt.setName(sName);
	        mt.setBirthDate(sBirthDate);
	        mt.setGender(sGender);
	        mt.setNationalinfo(sNationalInfo);
	        mt.setDI(sDupInfo);
	        mt.setCI(sConnInfo);
	        mt.setMobileNo(sMobileNo);
	        mt.setMobileCo(sMobileCo);
	        
			api01Service.updateHistory(mt);
	        
	        List data = new ArrayList();
	        Map dataMap = new HashMap();
	        dataMap.put("NAME",sName);
	        dataMap.put("BIRTHDATE",sBirthDate);
	        data.add(dataMap);
	        rd.setData(data);
	        
	        rd.setCode(rd.RESULT_SUCCESS);
			rd.setMessage("인증 되었습니다.");
	        
	        SessionManager session = new SessionManager(request, response);
	        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
	        if(!sRequestNumber.equals(session_sRequestNumber))
	        {
	            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
	            sResponseNumber = "";
	            sAuthType = "";
	            
	            rd.setCode(rd.RESULT_ERROR);
				rd.setMessage(sMessage);
	        }
	    }
	    else if( iReturn == -1)
	    {
	        sMessage = "복호화 시스템 에러입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -4)
	    {
	        sMessage = "복호화 처리오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -5)
	    {
	        sMessage = "복호화 해쉬 오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -6)
	    {
	        sMessage = "복호화 데이터 오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -9)
	    {
	        sMessage = "입력 데이터 오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else if( iReturn == -12)
	    {
	        sMessage = "사이트 패스워드 오류입니다.";
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }    
	    else
	    {
	        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
            
            rd.setCode(rd.RESULT_ERROR);
			rd.setMessage(sMessage + " " + iReturn);
	    }

	    
	    
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		return mv;
	}
	
	public String requestReplace (String paramValue, String gubun) {

        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
	

	/**
	 * 판매관리 반려
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/rejectSalesPromotion")
	public ModelAndView rejectPay(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map        pt     = new HashMap();
		GAPI01MT   mt     = new GAPI01MT();
		ResultData rd     = new ResultData();
		
		bind(request, pt);
		

		try 
		{
			if (pt.get("token") != null && pt.get("token").toString().equals(this.token)) {
				mt.setEventYM(pt.get("eventYM").toString());
				mt.setVenueCD(pt.get("venueCD").toString());
				mt.setCommt(pt.get("commt").toString());
				mt.setDiffNo(pt.get("diffNo").toString());
				mt.setKeymanID(pt.get("keymanID").toString());
				
				if("B".equals(pt.get("gubun").toString())){
			        //JSON데이터를 넣어 JSON Object 로 만들어 준다.
					JSONParser jsonParser = new JSONParser();
			        JSONArray itemsArray = (JSONArray) jsonParser.parse(pt.get("prdCDs").toString());
			        if(itemsArray.size()>0){
				        for(int k=0; k < itemsArray.size(); k++){
				        	JSONObject itemObject = (JSONObject) itemsArray.get(k);
				        	String text = itemObject.get("prdCD").toString();
				        	mt.setPrdCD(text);
				        	//브랜드별 
				        	api01Service.rejectSalesPromotion2(mt);	
				        }
			        }
		        }else{
		        	/* 업소별 */
		       		api01Service.rejectSalesPromotion1(mt);	
		        }	
		        
				
		        rd.setCode(rd.RESULT_SUCCESS);
				rd.setMessage("반려 처리 되었습니다.");
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}	
				
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("저장에 실패하였습니다.");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		return mv;
	}
	
	/**
	 * test 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getTest")
	public ModelAndView getTest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map parameter = new HashMap();
		User user = new User();
		ResultData rd = new ResultData();
		
		bind(request, parameter);
		bind(request, user);
		
		user.setCompanyID("000001");
		
		try {
			/*
	            String apiURL = "https://testapi.open-platform.or.kr/inquiry/real_name" ; //json
	            String appKey = "176d7ee9-c4e8-464f-a4cd-9aee37212007";
	            URL url = new URL(apiURL);
	            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
	            
	            conn.setDoInput(true);
	            conn.setDoOutput(true);
	            conn.setUseCaches(false);
	            conn.setReadTimeout(20000);
	            conn.setRequestMethod("POST");
	            conn.setRequestProperty("Content-Type", "application/json");
	            conn.setRequestProperty("Authorization","Bearer " + appKey);
	            
	            HashMap map = new HashMap();
	            
	            SimpleDateFormat sdfTime = new SimpleDateFormat("yyyyMMddHHmmss");
	            long currentTime = System.currentTimeMillis();
	            String timeString = sdfTime.format(new Date(currentTime));

	            JSONObject json = new JSONObject();
	            json.put("bank_code_std", "002");
	            json.put("account_num", "1234567890123456");
	            json.put("account_holder_info_type", " ");
	            json.put("account_holder_info", "880101");
	            json.put("tran_dtime", timeString);
	          
	            String jsonstr = "";
	            jsonstr = json.toString();
	            //실명조회
	            OutputStreamWriter os = new OutputStreamWriter(conn.getOutputStream());
	            os.write(jsonstr); // POST 바디에 Parameter 전송
	            os.flush();
	            os.close();

	            BufferedReader clsInput = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));

	            String inputLine;
	            StringBuffer responseApi = new StringBuffer();
	            while ((inputLine = clsInput.readLine()) != null)
	            {
	            	responseApi.append(inputLine);
	            }
	            clsInput.close();
	            
	          //실명조회
	            //"rsp_code": "A0000"
	            
	            JSONParser jsonParser = new JSONParser();
		        //JSON데이터를 넣어 JSON Object 로 만들어 준다.
	            JSONObject responseApiObject = (JSONObject) jsonParser.parse(responseApi.toString());
		        String resultCd = responseApiObject.get("rsp_code").toString();
	            if("A0000".equals(resultCd)){
	            	rd.setCode(rd.RESULT_SUCCESS);
	            	List data = new ArrayList();
	            	data.add("S");
	            	rd.setData(data);
	            }else{
	            	rd.setCode(rd.RESULT_ERROR);
					rd.setMessage("결과가 없습니다.");
	            }
				*/
	/*		
//암호화
String key ="9402235919850227"; //ID + 생년월일
Key secureKey = new SecretKeySpec(key.getBytes(), "AES");

Cipher cipher = Cipher.getInstance("AES");
cipher.init(Cipher.ENCRYPT_MODE, secureKey);

String text = "8502271076454";

byte[] encryptedData = cipher.doFinal(text.getBytes());

//byte to hex
StringBuilder sb = new StringBuilder(encryptedData.length * 2);
Formatter formatter = new Formatter(sb);
for (byte b : encryptedData) {
    formatter.format("%02x", b);
}
String enc = sb.toString();
System.out.println("-----------------     " + enc); 

//복호화
secureKey = new SecretKeySpec(key.getBytes(), "AES");
cipher.init(Cipher.DECRYPT_MODE, secureKey);
//hex to byte
byte[] encD = DatatypeConverter.parseHexBinary(enc);
encD = "U2FsdGVkX18kdlWhrHIXz54WSryc7ORWts3rhra18dA=".getBytes();

byte[] plainText = cipher.doFinal(encD);

String text2 = new String(plainText);
System.out.println("-----------------     " + text2);

GAPI01MT   mt     = new GAPI01MT();		
mt.setKeymanID("0000016134");
HashMap data = new HashMap();
data = (HashMap) simpleService.queryForMap("API0100130S",mt);


System.out.println("//////////  "+data.get("birthDate"));
*/
			
			String ciphertext = "AV9LoNwTcImX/PGDnz8dToiylwfm3SWtLJkQd3ykaf4="; 
			//String ciphertext = "9XZ2rQtzAtF3kjFsa7FqBA=="; 
	        String passPhrase = "9402235919850227";
	        
	        String decrypted = decrypt(passPhrase, ciphertext, 100, 128);
	        System.out.println("//////////         "+decrypted);
	        String encrypted = encrypt(passPhrase, decrypted, 100, 128);
	        System.out.println("//////////         "+encrypted);
			
			
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		
		return mv;
	}
	public static String decrypt(String passphrase, String ciphertext, int iterationCount, int keySize) throws Exception {
		String salt = "18b00b2fc5f0e0ee40447bba4dabc952"; 
        String iv = "4378110db6392f93e95d5159dabdee9b";
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
        KeySpec spec = new PBEKeySpec(passphrase.toCharArray(), Hex.decodeHex(salt.toCharArray()), iterationCount, keySize);
        SecretKey key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");        
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(Hex.decodeHex(iv.toCharArray())));        
        byte[] decrypted = cipher.doFinal(Base64.decodeBase64(ciphertext));        
        return new String(decrypted, "UTF-8");
    }
	public static String encrypt(String passphrase, String ciphertext, int iterationCount, int keySize) throws Exception {
		String salt = "18b00b2fc5f0e0ee40447bba4dabc952"; 
		String iv = "4378110db6392f93e95d5159dabdee9b";
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		KeySpec spec = new PBEKeySpec(passphrase.toCharArray(), Hex.decodeHex(salt.toCharArray()), iterationCount, keySize);
		SecretKey key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");        
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec(Hex.decodeHex(iv.toCharArray())));        
		byte[] encrypted = cipher.doFinal(ciphertext.getBytes("UTF-8"));
		 Base64.encodeBase64String(encrypted);

		return Base64.encodeBase64String(encrypted);
	}
	
	/**
	 * 키맨 확인 코드 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getKeyCodeList")
	public ModelAndView getKeyCodeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map parameter = new HashMap();
		User user = new User();
		ResultData rd = new ResultData();
		
		bind(request, parameter);
		bind(request, user);
		
		user.setCompanyID("000001");
		
		try {
			if (parameter.get("token") != null && parameter.get("token").toString().equals(this.token)) {
				List data = simpleService.queryForList("KeyCode01S", parameter);
				
				if (data.size() > 0) {
					rd.setCode(rd.RESULT_SUCCESS);					
					rd.setData(data);
				}
				else {
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage("코드정보가 없습니다.");
				}
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		
		return mv;
	}
	

	/**
	 * 계좌번호변경 (마스터)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/saveMstAccNumber")
	public ModelAndView saveMstAccNumber(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map        pt     = new HashMap();
		GAPI01MT   mt     = new GAPI01MT();
		ResultData rd     = new ResultData();
		Map       bankRtn = new HashMap();
		
		bind(request, pt);
		try 
		{
			
		mt.setKeymanID(pt.get("keymanID").toString());
		
		HashMap birth = new HashMap();
		birth = (HashMap) simpleService.queryForMap("API0100130S",mt);
		String key = pt.get("userID").toString() + birth.get("birthDate"); //ID + 생년월일
		
		String ciphertext = pt.get("accountNumber").toString();
		String passPhrase = key;
		String decrypted = decrypt(passPhrase, ciphertext, 100, 128);
		
		String accountNumber = decrypted;

		mt.setAccountNO(accountNumber);
		pt.put("accountNumber", accountNumber);
		mt.setKeymanID(pt.get("keymanID").toString());
		mt.setBankCD(pt.get("accountBankCode").toString());
		mt.setHolderNM(pt.get("accountHolder").toString());

		String account_holder_info = pt.get("residentNumber").toString();
		if(account_holder_info.length()>6){
			account_holder_info = account_holder_info.substring(2, account_holder_info.length());
			pt.put("residentNumber", account_holder_info);
		}
			if (pt.get("token") != null && pt.get("token").toString().equals(this.token)) {
				
				bankRtn = chkBankAcc(pt,request);
				String msg = bankRtn.get("msg").toString();
				String rtCd = bankRtn.get("rtCd").toString();
				if("S".equals(rtCd)){
			        api01Service.updateSaveAccountNumber1(mt);
				
					rd.setCode(rd.RESULT_SUCCESS);
					rd.setMessage("저장이 완료되었습니다.");
				}else{
					rd.setCode(rd.RESULT_ERROR);
					rd.setMessage(msg);
				}
				
			}else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("인증정보가 일치하지 않습니다.");
			}	
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("저장에 실패하였습니다.");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		return mv;
	}
	
	/**
	 * 계좌 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public Map chkBankAcc(Map pt, HttpServletRequest request) throws Exception {
		Map rtpt = new HashMap();
		String rtMsg = "";
		String rtCd = "";
		String account_holder_name = ""; 
		String bank_rsp_message = "";
		Map reqmap = new HashMap();
		GAPI01MT mt = new GAPI01MT();
		bind(request, reqmap);
		
		try {
			
	            String apiURL = "https://testapi.open-platform.or.kr/inquiry/real_name" ; //json
	            //String appKey = "176d7ee9-c4e8-464f-a4cd-9aee37212007";
	            String appKey = bankKey;
	            
	            String accountHolder = "";
	            String bank_code_std = "";
	            String account_num = "";
	            String account_holder_info = "";
	            if(pt.isEmpty()){
	            	System.out.println("------------------------");
	            	accountHolder = reqmap.get("accountHolder").toString();
	            	bank_code_std = reqmap.get("accountBankCode").toString();
	            	account_num = reqmap.get("accountNumber").toString();
	            	account_holder_info = reqmap.get("residentNumber").toString();
	            }else{
	            
		            accountHolder = pt.get("accountHolder").toString();
		            bank_code_std = pt.get("accountBankCode").toString();
		            account_num = pt.get("accountNumber").toString();
		             account_holder_info = pt.get("residentNumber").toString();
	            }
	            
	            URL url = new URL(apiURL);
	            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
	            
	            conn.setDoInput(true);
	            conn.setDoOutput(true);
	            conn.setUseCaches(false);
	            conn.setReadTimeout(20000);
	            conn.setRequestMethod("POST");
	            conn.setRequestProperty("Content-Type", "application/json");
	            conn.setRequestProperty("Authorization","Bearer " + appKey);
	            
	            HashMap map = new HashMap();
	            
	            SimpleDateFormat sdfTime = new SimpleDateFormat("yyyyMMddHHmmss");
	            long currentTime = System.currentTimeMillis();
	            String timeString = sdfTime.format(new Date(currentTime));

	            JSONObject json = new JSONObject();

	            json.put("bank_code_std", bank_code_std);
	            json.put("account_num", account_num);
	            json.put("account_holder_info", account_holder_info);
	            
	            json.put("account_holder_info_type", " ");// "" 생년월일 6자리 , "6" 사업자등록번호 
	            json.put("tran_dtime", timeString);
	          
	            String jsonstr = "";
	            jsonstr = json.toString();
	            //실명조회
	            OutputStreamWriter os = new OutputStreamWriter(conn.getOutputStream());
	            os.write(jsonstr); // POST 바디에 Parameter 전송
	            os.flush();
	            os.close();

	            BufferedReader clsInput = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));

	            String inputLine;
	            StringBuffer responseApi = new StringBuffer();
	            while ((inputLine = clsInput.readLine()) != null)
	            {
	            	responseApi.append(inputLine);
	            }
	            clsInput.close();
	            
	            //실명조회
	            JSONParser jsonParser = new JSONParser();
		        //JSON데이터를 넣어 JSON Object 로 만들어 준다.
	            JSONObject responseApiObject = (JSONObject) jsonParser.parse(responseApi.toString());
		        String rsp_code = responseApiObject.get("rsp_code").toString(); 
		        String rsp_message = responseApiObject.get("rsp_message").toString(); 
		        
		        //"rsp_code": "A0000" 성공
		        if("A0000".equals(rsp_code)){
	        		account_holder_name = responseApiObject.get("account_holder_name").toString(); 
	        		bank_rsp_message = responseApiObject.get("bank_rsp_message").toString();
	        		
		        	if(!accountHolder.equals(account_holder_name)){
		        		rtMsg = "계좌 소유주 정보가 일치하지 않습니다.";
		        		rtCd = "E";
		        		rtpt.put("msg", rtMsg);
		        		rtpt.put("rtCd", rtCd);
		        	}else{ 
		            	rtMsg = "유효한 계좌입니다.";
		            	rtCd = "S";
		            	rtpt.put("msg", rtMsg);
		            	rtpt.put("rtCd", rtCd);
	            	}
	            }else{
	            	rtMsg = "계좌 및 개인정보를 다시 확인해 주세요.";
	            	rtCd = "E";
	            	rtpt.put("msg", rtMsg);
	            	rtpt.put("rtCd", rtCd);
	            }
		        mt.setName(accountHolder);
		        mt.setBankCD(bank_code_std);
		        mt.setAccountNO(account_num);
		        mt.setBirthDate(account_holder_info);
		        mt.setHolderNM(account_holder_name);
		        mt.setRspCd(rsp_code);
		        mt.setCommt(bank_rsp_message);
		        api01Service.insertHistory(mt);
				
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rtMsg = "시스템 오류입니다. 잠시후 다시 시도해 주세요.";
			rtCd = "E";
			rtpt.put("msg", rtMsg);
			rtpt.put("rtCd", rtCd);
		}
		
		return rtpt;
	}
	
	/**
	 * 계좌 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/chkBankAcc")
	public ModelAndView chkBankAcc1(Map pt, HttpServletRequest request) throws Exception {
		ResultData rd = new ResultData();
		ResultMessage rm = new ResultMessage();
		GAPI01MT mt = new GAPI01MT();
		String rtMsg = "";
		String rtCd = "";
		Map reqmap = new HashMap();
		bind(request, reqmap);
		
		try {
			
			String apiURL = "https://testapi.open-platform.or.kr/inquiry/real_name" ; //json
			//String appKey = "176d7ee9-c4e8-464f-a4cd-9aee37212007";
			String appKey = bankKey;
			
			String accountHolder = "";
			String bank_code_std = "";
			String account_num = "";
			String account_holder_info = "";
			if(pt.isEmpty()){
				accountHolder = reqmap.get("accountHolder").toString();
				bank_code_std = reqmap.get("accountBankCode").toString();
				account_num = reqmap.get("accountNumber").toString();
				account_holder_info = reqmap.get("residentNumber").toString();
			}else{
				accountHolder = pt.get("accountHolder").toString();
				bank_code_std = pt.get("accountBankCode").toString();
				account_num = pt.get("accountNumber").toString();
				account_holder_info = pt.get("residentNumber").toString();
			}
          
			URL url = new URL(apiURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setUseCaches(false);
			conn.setReadTimeout(20000);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Authorization","Bearer " + appKey);
			
			HashMap map = new HashMap();
			
			SimpleDateFormat sdfTime = new SimpleDateFormat("yyyyMMddHHmmss");
			long currentTime = System.currentTimeMillis();
			String timeString = sdfTime.format(new Date(currentTime));
			
			JSONObject json = new JSONObject();
			
			json.put("bank_code_std", bank_code_std);
			json.put("account_num", account_num);
			json.put("account_holder_info", account_holder_info);
			
			json.put("account_holder_info_type", " ");// "" 생년월일 6자리 , "6" 사업자등록번호 
			json.put("tran_dtime", timeString);
			
			String jsonstr = "";
			jsonstr = json.toString();
			//실명조회
			OutputStreamWriter os = new OutputStreamWriter(conn.getOutputStream());
			os.write(jsonstr); // POST 바디에 Parameter 전송
			os.flush();
			os.close();
			
			BufferedReader clsInput = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
			
			String inputLine;
			StringBuffer responseApi = new StringBuffer();
			while ((inputLine = clsInput.readLine()) != null)
			{
				responseApi.append(inputLine);
			}
			clsInput.close();
			
			//실명조회
			JSONParser jsonParser = new JSONParser();
			//JSON데이터를 넣어 JSON Object 로 만들어 준다.
			JSONObject responseApiObject = (JSONObject) jsonParser.parse(responseApi.toString());
			String rsp_code = responseApiObject.get("rsp_code").toString(); 
			String rsp_message = responseApiObject.get("rsp_message").toString(); 
			String bank_rsp_message = responseApiObject.get("bank_rsp_message").toString(); 
			
			String account_holder_name = responseApiObject.get("account_holder_name").toString(); 
			
			//"rsp_code": "A0000" 성공
			if(!accountHolder.equals(account_holder_name)){
				rtMsg = "계좌 소유주 정보가 일치하지 않습니다.";
				rtCd = "E";
				rd.setParam("msg", rtMsg);
				rd.setParam("rtCd", rtCd);
			}else if("A0000".equals(rsp_code)){
				
				mt.setHolderNM(accountHolder);
				mt.setBankCD(bank_code_std);
				mt.setAccountNO(account_num);
				mt.setBirthDate(account_holder_info);
				mt.setUserID(reqmap.get("userID").toString());
				mt.setKeymanID(reqmap.get("userID").toString());
				
				api01Service.updateKeymanBank(mt);
				
				rtMsg = "저장되었습니다.";
				rtCd = "S";
				rd.setParam("msg", rtMsg);
				rd.setParam("rtCd", rtCd);
				
				
				
			}else{
				rtMsg = "계좌 및 개인정보를 다시 확인해 주세요.";
				rtCd = "E";
				rd.setParam("msg", rtMsg);
				rd.setParam("rtCd", rtCd);
			}
			
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rtMsg = "시스템 오류입니다. 잠시후 다시 시도해 주세요.";
			rtCd = "E";
			rd.setParam("msg", rtMsg);
			rd.setParam("rtCd", rtCd);
		}
		
		rm.setCode(rtCd);
		rm.setMessage(rtMsg);
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
		return mv;
	}


	/**
	 * 키맨 정보 수정(주소 등)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/updateKeyman")
	public ModelAndView updateKeyman(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map        pt     = new HashMap();
		GAPI01MT   mt     = new GAPI01MT();
		ResultMessage rm = new ResultMessage();
		
		bind(request, pt);

		mt.setKeymanID(pt.get("keymanID").toString());
		mt.setUserID(pt.get("keymanID").toString());
		mt.setCommt(pt.get("commt").toString());
		mt.setAddr(pt.get("addr").toString());
		mt.setPhoneNo(pt.get("phoneNo").toString());
		
		try 
		{
	        api01Service.updateKeyman(mt);
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage("저장이 완료되었습니다.");
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage("저장에 실패하였습니다.");
			rm.setSystemMessage(e.toString());
		}
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
		
		return mv;
	}
	/**
	 * 키맨 정보 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/selectKeyman")
	public ModelAndView selectKeyman(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		GAPI01MT   mt     = new GAPI01MT();
		Map data = new LinkedHashMap<String, String>();
		List<Map<String, Cell>> list = new ArrayList<Map<String, Cell>>();
		Map queryMap = null;
		
		mt.setEmpID(session.getUserID());
		
		try 
		{
			queryMap = new HashMap();
			queryMap = (HashMap) simpleService.queryForMap("ApiKeyman01S",mt);
			if(queryMap!=null) {
				String venueCD	 	= (queryMap.get("venueCD")!=null)?queryMap.get("venueCD").toString():""; 
				String venueNm	 	= (queryMap.get("venueNm")!=null)?queryMap.get("venueNm").toString():""; 
				String keymanID	 	= (queryMap.get("keymanID")!=null)?queryMap.get("keymanID").toString():""; 
				String keymanNm	 	= (queryMap.get("keymanNm")!=null)?queryMap.get("keymanNm").toString():""; 
				String keymanTypeCD	= (queryMap.get("keymanTypeCD")!=null)?queryMap.get("keymanTypeCD").toString():""; 
				String regIDNo	 	= (queryMap.get("regIDNo")!=null)?queryMap.get("regIDNo").toString():""; 
				String birthDate	= (queryMap.get("birthDate")!=null)?queryMap.get("birthDate").toString():""; 
				String dutyCD	 	= (queryMap.get("dutyCD")!=null)?queryMap.get("dutyCD").toString():""; 
				String addr	 		= (queryMap.get("addr")!=null)?queryMap.get("addr").toString():""; 
				String phoneNo	 	= (queryMap.get("phoneNo")!=null)?queryMap.get("phoneNo").toString():""; 
				String bankCD	 	= (queryMap.get("bankCD")!=null)?queryMap.get("bankCD").toString():""; 
				String bankNm	 	= (queryMap.get("bankNm")!=null)?queryMap.get("bankNm").toString():""; 
				String accountNo	= (queryMap.get("accountNo")!=null)?queryMap.get("accountNo").toString():""; 
				String holderNm	 	= (queryMap.get("holderNm")!=null)?queryMap.get("holderNm").toString():""; 
				String PkeymanYN	= (queryMap.get("PkeymanYN")!=null)?queryMap.get("PkeymanYN").toString():""; 
				String note	 		= (queryMap.get("note")!=null)?queryMap.get("note").toString():""; 

				data.put("venueCD", venueCD);
				data.put("venueNm", venueNm);
				data.put("keymanNm", keymanNm);
				data.put("addr", addr);
				data.put("phoneNo", phoneNo);
				data.put("holderNm", holderNm);
				data.put("bankCD", bankCD);
				data.put("accountNo", accountNo);
				data.put("birthDate", birthDate);
				data.put("note", note);
				data.put("bankNm", bankNm);
				
			}

			list.add(data);
			
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
		}
		ModelAndView mav = new ModelAndView("resultView");
		SimpleDoc simpleDoc = new SimpleDoc("XML", list);

		mav = simpleDoc.create();

		return mav;
	}
	
	/**
	 * 사용자 정보
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/userInfo")
	public ModelAndView userInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		User user = new User();
		ResultData rd = new ResultData();
	
		bind(request, user);
		
		user.setCompanyID("000001");
		
		try {
			if (simpleService.queryForInt("API0100160S",user) > 0) {
				List data = simpleService.queryForList("API0100161S",user);
				
				rd.setCode(rd.RESULT_SUCCESS);
				rd.setParam("token",token);
				rd.setData(data);
			}
			else {
				rd.setCode(rd.RESULT_ERROR);
				rd.setMessage("아이디를 확인하십시오.");
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("System Error!");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		
		return mv;
	}

	/**
	 * 비밀번호 초기화
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/resetUserPass")
	public ModelAndView resetUserPass(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean checkCondition = true;
		Map        pt     = new HashMap();
		GAPI01MT   mt     = new GAPI01MT();
		ResultData rd     = new ResultData();
		User user = new User();
		
		bind(request, pt);
		mt.setUserID(pt.get("userID").toString());
		
		try 
		{
		    api01Service.updateResetPassword(mt);				
				
			rd.setCode(rd.RESULT_SUCCESS);
			rd.setMessage("비밀번호 초기화 되었습니다.");
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			rd.setCode(rd.RESULT_ERROR);
			rd.setMessage("초기화 실패 하였습니다.");
			rd.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultDataView");
		mv.addObject("resultData", rd);
		
		return mv;
	}
	
}
