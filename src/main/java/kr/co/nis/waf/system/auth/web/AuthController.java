package kr.co.nis.waf.system.auth.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.net.util.Base64;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.ResultView;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.auth.model.Auth;
import kr.co.nis.waf.system.auth.model.Group;
import kr.co.nis.waf.system.auth.model.SystemUseLog;
import kr.co.nis.waf.system.auth.model.User;
import kr.co.nis.waf.system.auth.service.AuthService;
import kr.co.nis.waf.system.auth.service.GroupService;
import kr.co.nis.waf.system.auth.service.UserService;
import kr.co.nis.waf.system.cms.model.MenuConstruct;
import kr.co.nis.waf.system.cms.service.MenuConstructService;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;

@Controller
@RequestMapping("/service/auth")
public class AuthController extends SimpleMultiActionController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private AuthService authService;
	
	@Resource
	private GroupService groupService;
	
	@Resource
	private MenuConstructService menuConstructService;
	
	@Resource
	private SimpleService simpleService;
	
	@Resource
	private UserService userService;
	
	@Value("#{appenv['google.recaptcha.key.secret']}")
	private String secretKey;
	
	@Value("#{appenv['app.system.version']}")
	private String systemVersion;
	
	@Value("#{appenv['okta.token.url']}")
	private String tokenUrl;
	
	@Value("#{appenv['okta.userinfo.url']}")
	private String userinfoUrl;
	
	@Value("#{appenv['okta.client.id']}")
	private String clientId;
	
	@Value("#{appenv['okta.client.secret']}")
	private String clientSecret;
	
	@RequestMapping("/applyFunctionGroupAuth")
	public ModelAndView applyFunctionGroupAuth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Auth auth = new Auth();
		ResultMessage resultMsg = new ResultMessage();
		bind(request, auth);
		
		try {
			authService.applyFunctionGroupAuth(auth);
			resultMsg.setCode("success");
			resultMsg.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			resultMsg.setCode("failure");
			resultMsg.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
		}

		ModelAndView mav = new ModelAndView(new ResultView());
		mav.addObject("resultMsg", resultMsg);
		return mav;
	}

	@RequestMapping("/applyFunctionUserAuth")
	public ModelAndView applyFunctionUserAuth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Auth auth = new Auth();
		ResultMessage resultMsg = new ResultMessage();
		bind(request, auth);

		try {
			authService.applyFunctionUserAuth(auth);
			resultMsg.setCode("success");
			resultMsg.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			resultMsg.setCode("failure");
			resultMsg.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
		}

		ModelAndView mav = new ModelAndView(new ResultView());
		mav.addObject("resultMsg", resultMsg);
		return mav;

	}

	/**
	 * 그룹권한 사용자 적용
	 */
	@RequestMapping("/applyGroupUser")
	public ModelAndView applyGroupUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Group group = new Group();
		ResultMessage rm = new ResultMessage();
		bind(request, group);
		
		try {
			//simpleService.delete("commonservice.auth.groupUserAll.delete", group);
			groupService.addGroupUser(group);
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (Exception e) {
			e.printStackTrace();
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.save"));
		}

		ModelAndView mav = new ModelAndView(new ResultView());
		mav.addObject("resultMsg", rm);
		return mav;
	}

	/**
	 * 그룹/사용자 메뉴별 권한관리 페이지
	 */
	@RequestMapping("/initAuthMenuConstruct")
	public ModelAndView initAuthMenuConstruct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		Map param = new HashMap();
		MenuConstruct menuConstruct = new MenuConstruct();
		bind(request, param);
		bind(request, menuConstruct);
		if (logger.isDebugEnabled()) {
			logger.debug(menuConstruct);
		}
		//F_MenuConstruct
		mav.addObject("menuConstructTreeView", simpleService.queryForList("CMP0100708S", menuConstruct));
		setObjectAll(mav, request, response, param);
		return mav;
	}

	/**
	 * 그룹권한 사용자 목록
	 */
	@RequestMapping("/listAuthGroupUserSetting")
	public ModelAndView listAuthGroupUserSetting(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(super.getViewUrl(request));
		SessionManager session = new SessionManager(request, response);
		Group group = new Group();
		Map param = new HashMap();

		bind(request, param);
		group.setCompanyID(session.getCompanyID());
		
		mav.addObject("groupTreeView", simpleService.queryForList("commonservice.auth.groupTreeView.select", group));
		setObjectAll(mav, request, response, param);
		return mav;
	}

	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView mv = null;
		SessionManager session = new SessionManager(request, response);
		User user = new User();
		Map params = new HashMap();
		Map companyInfo = new HashMap();
		
		bind(request, user);
		bind(request, params);
		
		// Clear Session
		session.killSession();

		String openProgram = "";
		String boardID = "";
		String articleID = "";
		String logIp = "";
		
		if (params.get("openProgram") != null) openProgram = params.get("openProgram").toString();
		if (params.get("boardID") != null) boardID = params.get("boardID").toString();
		if (params.get("articleID") != null) articleID = params.get("articleID").toString();
		
		user.setUserID(user.getUserID().toUpperCase());
		user.setPasswd(user.getPasswd());
		try {
			
			String companyID = params.get("companyID")!=null?params.get("companyID").toString():"000001";
			user.setCompanyID(companyID);
			//DK, MD구분자
			user.setDkmdTpCD(params.get("dkmdTpCD").toString());
			
			if("DK".equals(params.get("dkmdTpCD").toString())){
				logIp = request.getRemoteAddr();
				user.setCurrentClientIp(logIp);
				
				if(!"".equals(request.getParameter("g-recaptcha-response"))){
					if(chkReCaptcha(request.getParameter("g-recaptcha-response"))){
						//ip 로그 카운트 초기화
						simpleService.update("API0100150U", user);
					}
				}

				int loginIpCnt = 0;
				Map loginIpMap = simpleService.queryForMap("API0100150S",user);
				if(loginIpMap!=null) {
					loginIpCnt = Integer.parseInt(loginIpMap.get("cnt").toString());
				}
				
				if (loginIpCnt >= 5) {
					mv = new ModelAndView("redirect:/index_dk.page");
					mv.addObject("chk", "Y");
					//return mv;
				}
			}
			
			//PasswordPolicy, 로그인실패시 계정잠금
			Map loginFailMap = simpleService.queryForMap("SYS0003S01S",user);
			int loginFailCnt = 0;
			if(loginFailMap!=null) {
				loginFailCnt = Integer.parseInt(loginFailMap.get("passwdErrCnt").toString());
				String accountBlockRuleYN = "";
				int accountBlockCnt = 0;
				Map accountMap = new HashMap();
				accountMap = simpleService.queryForMap("SYS0003S02S",user);
				accountBlockRuleYN = accountMap.get("accountBlockRuleYN").toString();
				accountBlockCnt = Integer.parseInt(accountMap.get("accountBlockCnt").toString());
				
				if(accountBlockRuleYN.equals("Y")) {
					if (loginFailCnt >= accountBlockCnt) {
						mv = new ModelAndView(configure.getLoginViewUrl());
						mv.addObject("message", getMessageSourceAccessor().getMessage("auth.failure.policy.block.login", new Object[] {String.valueOf(accountBlockCnt)}));
						setObjectAll(mv, request, response, params);
						return mv;
					}
				}
			}
			
			// 사용자 등록여부 확인
			if (simpleService.queryForInt("SYS0003S",user) > 0) {

				// 사용자 정보 가져오기
				params = simpleService.queryForMap("SYS0002S",user);
				params.put("passwd",user.getPasswd());
				params.put("encryptUserID", configure.encryptSHA256(user.getUserID().toUpperCase()));
				params.put("encryptINIT", configure.encryptSHA256("init"));
				
				if(request.getParameter("deviceValue") != null){
					if(user.getDisplayMnuTp().equals("100") || request.getParameter("deviceValue").equals("100")){
						params.put("displayMnuTp", "100");
						session.setDisplayMnuTp("100");
					}else if(user.getDisplayMnuTp().equals("200") || request.getParameter("deviceValue").equals("200")){
						params.put("displayMnuTp", "200");
						session.setDisplayMnuTp("200");
					}else if(user.getDisplayMnuTp().equals("300") || request.getParameter("deviceValue").equals("300")){
						params.put("displayMnuTp", "300");
						session.setDisplayMnuTp("300");
					}
				}else{
					if(user.getDisplayMnuTp().equals("100")){
						params.put("displayMnuTp", "100");
						session.setDisplayMnuTp("100");
					}else if(user.getDisplayMnuTp().equals("200")){
						params.put("displayMnuTp", "200");
						session.setDisplayMnuTp("200");
					}else if(user.getDisplayMnuTp().equals("300")){
						params.put("displayMnuTp", "300");
						session.setDisplayMnuTp("300");
					}
				}
				/*
				 * SaaS 서비스 접속 통제 체크
				 */
				if (params.get("blockYN") != null && params.get("blockYN").toString().equals("Y"))
					throw new Exception(getMessageSourceAccessor().getMessage("auth.info.loginBlock"));

				session.setUserID(params.get("userID").toString());
				session.setUserName(params.get("userName").toString());
				session.setAuthType(params.get("authType").toString());
				session.setGrpID(params.get("grpID").toString());
				session.setMnuConstructID(params.get("mnuConstructID").toString());
				/** Package Attribute - START **************************/

				// 회사ID
				if (!(params.get("companyID") == null || params.get("companyID").toString().equals(""))) {
					session.setCompanyID(params.get("companyID").toString());
				}
				
				// DIAGEO Extend Field (ADD: 2014.05.26)
				// DK/MD구분
				if (!(params.get("dkmdTpCD") == null || params.get("dkmdTpCD").toString().equals(""))) {
					session.setDkmdTpCD(params.get("dkmdTpCD").toString());
				}
				else {
					session.setDkmdTpCD("");
				}
				// 비밀번호 초기화
				if (!(params.get("initPasswdYN") == null || params.get("initPasswdYN").toString().equals(""))) {
					session.setInitPasswdYN(params.get("initPasswdYN").toString());
				}
				else {
					session.setInitPasswdYN("");
				}
				// 사번
				if (!(params.get("empID") == null || params.get("empID").toString().equals(""))) {
					session.setEmpID(params.get("empID").toString());
				}
				else {
					session.setEmpID("");
				}
				// 사원명
				if (!(params.get("empNm") == null || params.get("empNm").toString().equals(""))) {
					session.setEmpNm(params.get("empNm").toString());
				}
				else {
					session.setEmpNm("");
				}
				// 사원구분
				if (!(params.get("empTpCD") == null || params.get("empTpCD").toString().equals(""))) {
					session.setEmpTpCD(params.get("empTpCD").toString());
				}
				else {
					session.setEmpTpCD("");
				}
				// 권역
				if (!(params.get("rageSphereCD") == null || params.get("rageSphereCD").toString().equals(""))) {
					session.setRageSphereCD(params.get("rageSphereCD").toString());
				}
				else {
					session.setRageSphereCD("");
				}
				// 지점
				if (!(params.get("officeCD") == null || params.get("officeCD").toString().equals(""))) {
					session.setOfficeCD(params.get("officeCD").toString());
				}
				else {
					session.setOfficeCD("");
				}
				// 팀
				if (!(params.get("teamCD") == null || params.get("teamCD").toString().equals(""))) {
					session.setTeamCD(params.get("teamCD").toString());
				}
				else {
					session.setTeamCD("");
				}
				// Territory
				if (!(params.get("territoryCD") == null || params.get("territoryCD").toString().equals(""))) {
					session.setTerritoryCD(params.get("territoryCD").toString());
				}
				else {
					session.setTerritoryCD("");
				}
				// emailAddr
				if (!(params.get("emailAddr") == null || params.get("emailAddr").toString().equals(""))) {
					session.setEmailAddr(params.get("emailAddr").toString());
				}
				else {
					session.setEmailAddr("");
				}
				// 권역명
				if (!(params.get("rageSphereCDName") == null || params.get("rageSphereCDName").toString().equals(""))) {
					session.setRageSphereCDName(params.get("rageSphereCDName").toString());
				}
				else {
					session.setRageSphereCDName("");
				}
				// 지점명
				if (!(params.get("officeCDName") == null || params.get("officeCDName").toString().equals(""))) {
					session.setOfficeCDName(params.get("officeCDName").toString());
				}
				else {
					session.setOfficeCDName("");
				}
				// 팀명
				if (!(params.get("teamCDName") == null || params.get("teamCDName").toString().equals(""))) {
					session.setTeamCDName(params.get("teamCDName").toString());
				}
				else {
					session.setTeamCDName("");
				}
				// Territory명
				if (!(params.get("territoryCDName") == null || params.get("territoryCDName").toString().equals(""))) {
					session.setTerritoryCDName(params.get("territoryCDName").toString());
				}
				else {
					session.setTerritoryCDName("");
				}
				/** Package Attribute - END **************************/

				/** Menu Style , Theme - START **************************/

				if (params.get("menuStyle") == null || params.get("menuStyle").toString().equals("")) {
					session.setMenuStyle(configure.getMenuStyle());
					params.put("menuStyle",configure.getMenuStyle());
				}
				else {
					session.setMenuStyle(params.get("menuStyle").toString());
				}

				session.setThemeDefaultPath(configure.getThemeDefaultPath());

				if (params.get("themeCD") == null || params.get("themeCD").toString().equals("")) {
					session.setTheme(configure.getTheme());
				}
				else {
					session.setTheme(params.get("themeCD").toString());
				}

				session.setThemeDefaultPath(configure.getThemeDefaultPath());
				
				/*
				 * SaaS 서비스 사용자 여부
				 */
				if (!(params.get("saasYN") == null || params.get("saasYN").toString().equals(""))) {
					session.setSaaSYN(params.get("saasYN").toString());
				}
				else {
					session.setSaaSYN("N");
				}
				
				/** Menu Style , Theme - END **************************/

				/** Globalization - START *******************************/
				if (params.get("localeCD") == null || params.get("localeCD").toString().equals("")) {
					session.setLocale(configure.getLocale());
				}
				else {
					session.setLocale(params.get("localeCD").toString());
				}
				
				if (params.get("languageCD") == null || params.get("languageCD").toString().equals("")) {
					session.setLanguage(configure.getLanguage());
				}
				else {
					session.setLanguage(params.get("languageCD").toString());
				}
				session.setSystemLanguage(configure.getLanguage());
				
				if (params.get("currencyCD") == null || params.get("currencyCD").toString().equals("")) {
					session.setCurrency(configure.getCurrency());
				}
				else {
					session.setCurrency(params.get("currencyCD").toString());
				}
				session.setSystemTimezone(configure.getSystemTimezone());
				session.setSystemTimezoneDesc(configure.getSystemTimezoneDesc());
				if (params.get("timezoneCD") == null || params.get("timezoneCD").toString().equals("")) {
					session.setTimezone(configure.getTimezone());
					session.setTimezoneDesc(configure.getTimezoneDesc());
				}
				else {
					session.setTimezone(params.get("timezoneCD").toString());
					session.setTimezoneDesc(params.get("timezoneDesc").toString());
				}
				if (params.get("dateFormatCD") == null || params.get("dateFormatCD").toString().equals("")) {
					session.setDateFormat(configure.getDateFormat());
				}
				else {
					session.setDateFormat(params.get("dateFormatCD").toString());
				}
				if (params.get("amtFormatCD") == null || params.get("amtFormatCD").toString().equals("")) {
					session.setAmtFormat(configure.getAmtFormat());
				}
				else {
					session.setAmtFormat(params.get("amtFormatCD").toString());
				}
				session.setClientDate(session.getClientDate());
				
				session.setAppCount(params.get("APPCOUNT").toString());
				
				/** Globalization - END *******************************/

				/*
				 * 세션 유지시간 설정
				 */ 
				session.setMaxInactiveInterval(configure.getSessionMaxInActiveInterval());

				/*
				 * 접속시간 로그 저장
				 */
				SystemUseLog systemUseLog = new SystemUseLog();
				systemUseLog.setCompanyID(session.getCompanyID());
				systemUseLog.setUserID(session.getUserID());
				systemUseLog.setLoginOutCD("IN");
				systemUseLog.setIp(request.getRemoteAddr());
				simpleService.insert("commonservice.auth.systemUseLog.insert", systemUseLog);
				
				/*
				 * 접속자 클라이언트 IP 저장
				 */
				user.setCurrentClientIp(request.getRemoteAddr());
				simpleService.update("commonservice.auth.userCurrentClientIp.update", user);
				
				mv = new ModelAndView(configure.getMainViewUrl());
				System.out.println("★★★★★★ : " + configure.getMainViewUrl());
				/*
				 * Menu Construct Setting
				 */
				Map mnuInfo = null;
				if (systemVersion.equals("sys3")) { //for tree menu
					System.out.println("▶▶ DisplayMnuTp ◀◀ : " + user.getDisplayMnuTp());
					mnuInfo = menuConstructService.getMenuMap(params);
					mv.addObject("mnuGrpIDList", mnuInfo.get("mnuGrpID"));
					mv.addObject("mnuMap", mnuInfo.get("mnuMap"));
				}
				else if (systemVersion.equals("sys4")) { //for jqWidgets
					mnuInfo = menuConstructService.getMenu(params);
					mv.addObject("mnuMap", mnuInfo.get("mnuMap"));
				}
				
				/*
				 * User Widget Setting
				 */
				List widgetList = simpleService.queryForList("CMP0101504S", user);
				mv.addObject("widgetList", widgetList);
				
				/*
				 * 로그인 성공시 비밀번호오류횟수 초기화 update
				 */
				simpleService.update("SYS0003S02U", user);
				
				//ip 로그 카운트 초기화
				simpleService.update("API0100150U", user);
				
				//PasswordPolicy, 비밀번호변경 주기체크
				int passwdChgDate = simpleService.queryForInt("SYS0003S03S",user);
				String passwdChgRuleYN = "";
				int passwdChgCnt = 0;
				Map passwdChgMap = new HashMap();
				passwdChgMap = simpleService.queryForMap("SYS0003S04S",user);
				passwdChgRuleYN = passwdChgMap.get("passwdChgRuleYN").toString();
				passwdChgCnt = Integer.parseInt(passwdChgMap.get("passwdChgCnt").toString());
				
				if(passwdChgRuleYN.equals("Y")) {
					if (passwdChgDate >= passwdChgCnt) {
						session.setInitPasswdYN("Y");
						mv.addObject("message", getMessageSourceAccessor().getMessage("auth.failure.ploicy.pwchg.login", new Object[] {String.valueOf(passwdChgCnt)}));
						setObjectAll(mv, request, response, params);
						return mv;
					}
				}
			}
			else {
				/*
				 * 로그인 실패시 비밀번호오류횟수 update
				 */
				simpleService.update("SYS0003S01U", user);
				
				//ip 로그 카운트 증가
				simpleService.update("API0100150I", user);
				
				String loginViewUrl = "";
				
				if(user.getDisplayMnuTp().equals("200")){
					loginViewUrl = "redirect:/mobile/index.page";
				}else if(user.getDisplayMnuTp().equals("300")){
					loginViewUrl = "redirect:/eslt/index.page";
				}else{
					loginViewUrl = configure.getLoginViewUrl();
				}
				
				mv = new ModelAndView(loginViewUrl);

				
				mv.addObject("message", getMessageSourceAccessor().getMessage("auth.failure.login"));
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				e.printStackTrace();
			}
			
			String loginViewUrl = "";
			
			if(user.getDisplayMnuTp().equals("200")){
				loginViewUrl = "redirect:/mobile/index.page";
			}else if(user.getDisplayMnuTp().equals("300")){
				loginViewUrl = "redirect:/eslt/index.page";
			}else{
				loginViewUrl = configure.getLoginViewUrl();
			}
			
			mv = new ModelAndView(loginViewUrl);
			if (e.getMessage().equals(""))
				mv.addObject("message", getMessageSourceAccessor().getMessage("auth.failure.login"));
			else
				mv.addObject("message", e.getMessage());
		}

		params.put("openProgram", openProgram);
		params.put("boardID", boardID);
		params.put("articleID", articleID);
		setObjectAll(mv, request, response, params);

		return mv;
	}
	
	public boolean chkReCaptcha(String token) throws Exception{
		boolean flag = false;
		BufferedReader bufferedReader = null;
		String verifyUri = "https://www.google.com/recaptcha/api/siteverify?secret="+secretKey+"&response=" + token;
		
		URL url = new URL(verifyUri);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		
		conn.setDoInput(true);
        conn.setDoOutput(true);
        conn.setUseCaches(false);
        conn.setReadTimeout(20000);
        conn.setRequestMethod("POST");
		
        String param = "";
        //실명조회
        OutputStreamWriter os = new OutputStreamWriter(conn.getOutputStream());
        os.flush();
        os.close();
        
        bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
		
        String inputLine;
        StringBuffer responseApi = new StringBuffer();
        while ((inputLine = bufferedReader.readLine()) != null)
        {
        	responseApi.append(inputLine);
        }
        bufferedReader.close();
        
        JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(responseApi.toString());
        JSONObject responseApiObject =  (JSONObject)obj;
        flag = (Boolean) responseApiObject.get("success");

		return flag;
	}

	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		SessionManager session = new SessionManager(request, response);
		
		SystemUseLog systemUseLog = new SystemUseLog();
		
		bind(request, systemUseLog);
		
		String loginViewUrl = "";
		
		if(session.getDisplayMnuTp().equals("200")){
			loginViewUrl = "redirect:/mobile/index.page";
		}else if(session.getDisplayMnuTp().equals("300")){
			loginViewUrl = "redirect:/eslt/index.page";
		}else{
			loginViewUrl = configure.getLoginViewUrl();
		}

		System.out.println("※※※※※※※" + loginViewUrl + " / " + session.getDisplayMnuTp());
		
		//systemUseLog.setUserID(session.getUserID());
		systemUseLog.setLoginOutCD("OUT");
		systemUseLog.setIp(request.getRemoteAddr());
		simpleService.insert("commonservice.auth.systemUseLog.insert", systemUseLog);
		
//		/*
//		 * gtf 사원 근태 저장(퇴근)
//		 */
//		Attend attend = new Attend();
//		Date date = new Date();
//		//사원일 경우
//		if(session.getUser_div()!=null || !session.getUser_div().equals("")) {
//			if(session.getUser_div().equals("01")) {
//				attend.setAttend_date(StringUtil.unFormat(DateUtil.getConvertDate(
//						DateUtil.getDate(), 
//						session.getSystemTimezoneDesc(), 
//						session.getTimezoneDesc(), 
//						session.getDateFormat())));
//				attend.setUser_no(session.getUser_no());
//				attend.setLeave_work_time(DateUtil.getConvertDateTime(
//						DateUtil.getDate(), 
//						session.getSystemTimezoneDesc(), 
//						session.getTimezoneDesc(), 
//						session.getDateFormat(),
//						"").substring(8, 14));
//				attend.setUserID(session.getUserID());
//				simpleService.update("CMP0500101U", attend);
//			}
//		}
		
		session.killSession();
		
		return new ModelAndView(loginViewUrl);
	}
	
	@RequestMapping("/okta/login")
	public ModelAndView oktaLogin(HttpServletRequest request, HttpServletResponse response) throws Exception, IOException {

		ModelAndView mv = null;
		SessionManager session = new SessionManager(request, response);
		User user = new User();
		Map params = new HashMap();
		Map<String, String> userMap = new HashMap<String, String>();
		
		bind(request, user);
		bind(request, params);
		
		// Clear Session
		session.killSession();
		
		/*
		 * okta : code로 access_token 가져오기
		 */
		String code = request.getParameter("code");
		URL getTokenUrl = new URL(tokenUrl+code);
		HttpURLConnection conn = (HttpURLConnection)getTokenUrl.openConnection();
		String auth = clientId+":"+clientSecret;	// {Client ID}:{Client secret} 
		byte[] authEncBytes = Base64.encodeBase64(auth.getBytes());
        String authStringEnc = new String(authEncBytes);
        conn.setRequestProperty("Authorization", "Basic " + authStringEnc);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        JSONObject tokenObj = (JSONObject)JSONValue.parseWithException(br);
        String access_token = (String)tokenObj.get("access_token");
        br.close();
        conn.disconnect();
		
        /*
		 * okta : access_token으로 email 가져오기
		 */
		URL getUserinfoUrl = new URL(userinfoUrl);
		HttpURLConnection conn2 = (HttpURLConnection)getUserinfoUrl.openConnection();
		conn2.setRequestProperty("Authorization", "Bearer "+access_token);
		conn2.setRequestMethod("GET");
		conn2.setDoOutput(true);
		BufferedReader br2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
		JSONObject userInfoObj = (JSONObject)JSONValue.parseWithException(br2);
		String email = (String)userInfoObj.get("email");
		br2.close();
		conn2.disconnect();
		
		String openProgram = "";
		String boardID = "";
		String articleID = "";
		
		userMap.put("email", email);
		userMap.put("companyID", "000001");
		userMap.put("dkmdTpCD", "DK");
		
		try {
			
			// 사용자 등록여부 확인
			if (simpleService.queryForInt("SYS0003S2",userMap) > 0) {

//				// 사용자 정보 가져오기
				params = simpleService.queryForMap("SYS0002S2",userMap);
				user.setUserID((String)params.get("userID"));
				// 이 작업을 하지 않으면 menubar.jsp의 checkPasswordInit() 내 조건문 실행되어 비밀번호 변경 팝업 나옴
				params.put("passwd",user.getPasswd());
				params.put("encryptUserID", configure.encryptSHA256(user.getUserID().toUpperCase()));
				params.put("encryptINIT", configure.encryptSHA256("init"));
				
				// index_dk.jsp에 default로 100 선언되어있어서 임의 변경
				params.put("displayMnuTp", "100");
				session.setDisplayMnuTp("100");
				
				/*
				 * SaaS 서비스 접속 통제 체크
				 */
				if (params.get("blockYN") != null && params.get("blockYN").toString().equals("Y"))
					throw new Exception(getMessageSourceAccessor().getMessage("auth.info.loginBlock"));

				session.setUserID(params.get("userID").toString());
				session.setUserName(params.get("userName").toString());
				session.setAuthType(params.get("authType").toString());
				session.setGrpID(params.get("grpID").toString());
				session.setMnuConstructID(params.get("mnuConstructID").toString());
				/** Package Attribute - START **************************/

				// 회사ID
				if (!(params.get("companyID") == null || params.get("companyID").toString().equals(""))) {
					session.setCompanyID(params.get("companyID").toString());
				}
				
				// DIAGEO Extend Field (ADD: 2014.05.26)
				// DK/MD구분
				if (!(params.get("dkmdTpCD") == null || params.get("dkmdTpCD").toString().equals(""))) {
					session.setDkmdTpCD(params.get("dkmdTpCD").toString());
				}
				else {
					session.setDkmdTpCD("");
				}
				// 비밀번호 초기화
				if (!(params.get("initPasswdYN") == null || params.get("initPasswdYN").toString().equals(""))) {
					session.setInitPasswdYN(params.get("initPasswdYN").toString());
				}
				else {
					session.setInitPasswdYN("");
				}
				// 사번
				if (!(params.get("empID") == null || params.get("empID").toString().equals(""))) {
					session.setEmpID(params.get("empID").toString());
				}
				else {
					session.setEmpID("");
				}
				// 사원명
				if (!(params.get("empNm") == null || params.get("empNm").toString().equals(""))) {
					session.setEmpNm(params.get("empNm").toString());
				}
				else {
					session.setEmpNm("");
				}
				// 사원구분
				if (!(params.get("empTpCD") == null || params.get("empTpCD").toString().equals(""))) {
					session.setEmpTpCD(params.get("empTpCD").toString());
				}
				else {
					session.setEmpTpCD("");
				}
				// 권역
				if (!(params.get("rageSphereCD") == null || params.get("rageSphereCD").toString().equals(""))) {
					session.setRageSphereCD(params.get("rageSphereCD").toString());
				}
				else {
					session.setRageSphereCD("");
				}
				// 지점
				if (!(params.get("officeCD") == null || params.get("officeCD").toString().equals(""))) {
					session.setOfficeCD(params.get("officeCD").toString());
				}
				else {
					session.setOfficeCD("");
				}
				// 팀
				if (!(params.get("teamCD") == null || params.get("teamCD").toString().equals(""))) {
					session.setTeamCD(params.get("teamCD").toString());
				}
				else {
					session.setTeamCD("");
				}
				// Territory
				if (!(params.get("territoryCD") == null || params.get("territoryCD").toString().equals(""))) {
					session.setTerritoryCD(params.get("territoryCD").toString());
				}
				else {
					session.setTerritoryCD("");
				}
				// emailAddr
				if (!(params.get("emailAddr") == null || params.get("emailAddr").toString().equals(""))) {
					session.setEmailAddr(params.get("emailAddr").toString());
				}
				else {
					session.setEmailAddr("");
				}
				// 권역명
				if (!(params.get("rageSphereCDName") == null || params.get("rageSphereCDName").toString().equals(""))) {
					session.setRageSphereCDName(params.get("rageSphereCDName").toString());
				}
				else {
					session.setRageSphereCDName("");
				}
				// 지점명
				if (!(params.get("officeCDName") == null || params.get("officeCDName").toString().equals(""))) {
					session.setOfficeCDName(params.get("officeCDName").toString());
				}
				else {
					session.setOfficeCDName("");
				}
				// 팀명
				if (!(params.get("teamCDName") == null || params.get("teamCDName").toString().equals(""))) {
					session.setTeamCDName(params.get("teamCDName").toString());
				}
				else {
					session.setTeamCDName("");
				}
				// Territory명
				if (!(params.get("territoryCDName") == null || params.get("territoryCDName").toString().equals(""))) {
					session.setTerritoryCDName(params.get("territoryCDName").toString());
				}
				else {
					session.setTerritoryCDName("");
				}
				/** Package Attribute - END **************************/

				/** Menu Style , Theme - START **************************/

				if (params.get("menuStyle") == null || params.get("menuStyle").toString().equals("")) {
					session.setMenuStyle(configure.getMenuStyle());
					params.put("menuStyle",configure.getMenuStyle());
				}
				else {
					session.setMenuStyle(params.get("menuStyle").toString());
				}

				session.setThemeDefaultPath(configure.getThemeDefaultPath());

				if (params.get("themeCD") == null || params.get("themeCD").toString().equals("")) {
					session.setTheme(configure.getTheme());
				}
				else {
					session.setTheme(params.get("themeCD").toString());
				}

				session.setThemeDefaultPath(configure.getThemeDefaultPath());
				
				/*
				 * SaaS 서비스 사용자 여부
				 */
				if (!(params.get("saasYN") == null || params.get("saasYN").toString().equals(""))) {
					session.setSaaSYN(params.get("saasYN").toString());
				}
				else {
					session.setSaaSYN("N");
				}
				
				/** Menu Style , Theme - END **************************/

				/** Globalization - START *******************************/
				if (params.get("localeCD") == null || params.get("localeCD").toString().equals("")) {
					session.setLocale(configure.getLocale());
				}
				else {
					session.setLocale(params.get("localeCD").toString());
				}
				
				if (params.get("languageCD") == null || params.get("languageCD").toString().equals("")) {
					session.setLanguage(configure.getLanguage());
				}
				else {
					session.setLanguage(params.get("languageCD").toString());
				}
				session.setSystemLanguage(configure.getLanguage());
				
				if (params.get("currencyCD") == null || params.get("currencyCD").toString().equals("")) {
					session.setCurrency(configure.getCurrency());
				}
				else {
					session.setCurrency(params.get("currencyCD").toString());
				}
				session.setSystemTimezone(configure.getSystemTimezone());
				session.setSystemTimezoneDesc(configure.getSystemTimezoneDesc());
				if (params.get("timezoneCD") == null || params.get("timezoneCD").toString().equals("")) {
					session.setTimezone(configure.getTimezone());
					session.setTimezoneDesc(configure.getTimezoneDesc());
				}
				else {
					session.setTimezone(params.get("timezoneCD").toString());
					session.setTimezoneDesc(params.get("timezoneDesc").toString());
				}
				if (params.get("dateFormatCD") == null || params.get("dateFormatCD").toString().equals("")) {
					session.setDateFormat(configure.getDateFormat());
				}
				else {
					session.setDateFormat(params.get("dateFormatCD").toString());
				}
				if (params.get("amtFormatCD") == null || params.get("amtFormatCD").toString().equals("")) {
					session.setAmtFormat(configure.getAmtFormat());
				}
				else {
					session.setAmtFormat(params.get("amtFormatCD").toString());
				}
				session.setClientDate(session.getClientDate());
				
				session.setAppCount(params.get("APPCOUNT").toString());
				
				/** Globalization - END *******************************/

				/*
				 * 세션 유지시간 설정
				 */ 
				session.setMaxInactiveInterval(configure.getSessionMaxInActiveInterval());

				/*
				 * 접속시간 로그 저장
				 */
				SystemUseLog systemUseLog = new SystemUseLog();
				systemUseLog.setCompanyID(session.getCompanyID());
				systemUseLog.setUserID(session.getUserID());
				systemUseLog.setLoginOutCD("IN");
				systemUseLog.setIp(request.getRemoteAddr());
				simpleService.insert("commonservice.auth.systemUseLog.insert", systemUseLog);
				
				/*
				 * 접속자 클라이언트 IP 저장
				 */
//				userMap.put("currentClientIp", request.getRemoteAddr());
//				userMap.put("userID", user.getUserID());
				simpleService.update("commonservice.auth.userCurrentClientIp.update", user);
				
				mv = new ModelAndView(configure.getMainViewUrl());
				System.out.println("★★★★★★ : " + configure.getMainViewUrl());
				/*
				 * Menu Construct Setting
				 */
				Map mnuInfo = null;
				if (systemVersion.equals("sys3")) { //for tree menu
					System.out.println("▶▶ DisplayMnuTp ◀◀ : " + user.getDisplayMnuTp());
					mnuInfo = menuConstructService.getMenuMap(params);
					mv.addObject("mnuGrpIDList", mnuInfo.get("mnuGrpID"));
					mv.addObject("mnuMap", mnuInfo.get("mnuMap"));
				}
				else if (systemVersion.equals("sys4")) { //for jqWidgets
					mnuInfo = menuConstructService.getMenu(params);
					mv.addObject("mnuMap", mnuInfo.get("mnuMap"));
				}
				
				//ip 로그 카운트 초기화
				simpleService.update("API0100150U", user);
				
				/*
				 * User Widget Setting
				 */
				List widgetList = simpleService.queryForList("CMP0101504S", user);
				mv.addObject("widgetList", widgetList);
				
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				e.printStackTrace();
			}
			
			String loginViewUrl = configure.getLoginViewUrl();
			
			mv = new ModelAndView(loginViewUrl);
			if (e.getMessage().equals(""))
				mv.addObject("message", getMessageSourceAccessor().getMessage("auth.failure.login"));
			else
				mv.addObject("message", e.getMessage());
		}

		params.put("openProgram", openProgram);
		params.put("boardID", boardID);
		params.put("articleID", articleID);
		setObjectAll(mv, request, response, params);
		
		return mv;
	}
	
	@RequestMapping("/okta/loginPage")
	public String test(){
		return "redirect:https://dev-79640474.okta.com/oauth2/default/v1/authorize?client_id=0oasfkzszE46VtPIn5d6&response_type=code&scope=openid+email&redirect_uri=http%3A%2F%2Flocalhost%3A8026%2Fservice%2Fauth%2Fokta%2Flogin&state=state-296bc9a0-a2a2-4a57-be1a-d0e2fd9bb601&nonce=g5ly497e8ps";
	}

}
