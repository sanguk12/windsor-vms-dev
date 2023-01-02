package kr.co.nis.waf.system.auth.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;
import kr.co.nis.waf.system.auth.model.PasswordPolicy;
import kr.co.nis.waf.system.auth.model.UserExtend;
import kr.co.nis.waf.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;


@Service("securityService")
public class SecurityServiceImpl implements SecurityService {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	public void addPasswordPolicy(PasswordPolicy passwordPolicy) throws Exception {
		//F_PasswordPolicy
		simpleDao.insert("CMP0102302I", passwordPolicy);
	}

	public void modifyPasswordPolicy(PasswordPolicy passwordPolicy) throws Exception {
		//F_PasswordPolicy
		simpleDao.update("CMP0102303U", passwordPolicy);
	}
	
	public void modifyAccountBlock(Map param) throws Exception {
		//F_User
		simpleDao.update("SYS0018U", param);
	}
	
	public boolean checkPasswordValid(UserExtend userInfo) {
		
		boolean isPasswdValid = true;
		
		/* 변경 전 최근 10개의 비밀번호와 일치하는 검사 (재사용 금지) - START */
		List passwordHistory = simpleDao.queryForList("SYS0015S", userInfo);
		
		if (passwordHistory != null) {
			for (int i=0; i < passwordHistory.size(); i++) {
				Map passwdChgInfo = new HashMap();
				passwdChgInfo = (Map)passwordHistory.get(i);
				if (userInfo.getPasswd().equals(passwdChgInfo.get("passwd").toString())) {
					isPasswdValid = false;
					if (logger.isDebugEnabled()) logger.debug("변경 직전 10건 비밀번호 재사용 오류!!!");
				}
			}
		}
		/* 변경 전 최근 2개의 비밀번호와 일치하는 검사 (재사용 금지) - END */
		
//		/* 비밀번호 생성규칙 유효성 검사 - START */
//		PasswordPolicy passwordPolicy = new PasswordPolicy();
//		
//		int compositionCnt = 0;
//		//F_PasswordPolicy
//		passwordPolicy = (PasswordPolicy)simpleDao.queryForObject("CMP0102305S", userInfo.getCompanyID());
//		
//		if (isPasswdValid && passwordPolicy != null) {
//			//첫번째 규칙 검사
//			if (passwordPolicy.getPasswdRuleYN1().equals("Y")) {
//				
//				//비밀번호 최소자릿수 검사
//				if (userInfo.getPasswd().length() < Integer.parseInt(passwordPolicy.getPasswdMinNumbers1())) {
//					isPasswdValid = false;
//					if (logger.isDebugEnabled()) logger.debug("1번규칙: 비밀번호 최소자릿수 오류!!!");
//				}
//				
//				//영대문자 포함여부 검사
//				if (isPasswdValid && passwordPolicy.getUpperCaseYN1().equals("Y")) {
//					if (!StringUtil.checkPatternUpperCase(userInfo.getPasswd())) {
//						isPasswdValid = false;
//						if (logger.isDebugEnabled()) logger.debug("1번규칙: 영대문자 미포함 오류!!!");
//					}
//					else {
//						compositionCnt++;
//					}
//				}
//				//영소문자 포함여부 검사
//				if (isPasswdValid && passwordPolicy.getLowerCaseYN1().equals("Y")) {
//					if (!StringUtil.checkPatternLowerCase(userInfo.getPasswd())) {
//						isPasswdValid = false;
//						if (logger.isDebugEnabled()) logger.debug("1번규칙: 영소문자 미포함 오류!!!");
//					}
//					else {
//						compositionCnt++;
//					}
//				}
//				//숫자 포함여부 검사
//				if (isPasswdValid && passwordPolicy.getNumberYN1().equals("Y")) {
//					if (!StringUtil.checkPatternNum(userInfo.getPasswd())) {
//						isPasswdValid = false;
//						if (logger.isDebugEnabled()) logger.debug("1번규칙: 숫자 미포함 오류!!!");
//					}
//					else {
//						compositionCnt++;
//					}
//				}
//				//특수문자 포함여부 검사
//				if (isPasswdValid && passwordPolicy.getSpecialLettersYN1().equals("Y")) {
//					if (!StringUtil.checkPatternSpecialLetters(userInfo.getPasswd())) {
//						isPasswdValid = false;
//						if (logger.isDebugEnabled()) logger.debug("1번규칙: 특수문자 미포함 오류!!!");
//					}
//					else {
//						compositionCnt++;
//					}
//				}
//				//비밀번호 구성요소 종류수 충족여부 검사
//				if (compositionCnt < Integer.parseInt(passwordPolicy.getCompositionCnt1())) {
//					isPasswdValid = false;
//					if (logger.isDebugEnabled()) logger.debug("1번규칙: 비밀번호 구성요소 종류수 미충족 오류!!!");
//				}
//			}
//			
//			// 두번째 규칙 검사
//			if (passwordPolicy.getPasswdRuleYN1().equals("N") ||
//					isPasswdValid == false && passwordPolicy.getPasswdRuleYN2().equals("Y")) {
//				
//				isPasswdValid = true;
//				compositionCnt = 0;
//				
//				//비밀번호 최소자릿수 검사
//				if (userInfo.getPasswd().length() < Integer.parseInt(passwordPolicy.getPasswdMinNumbers2())) {
//					isPasswdValid = false;
//					if (logger.isDebugEnabled()) logger.debug("2번규칙: 비밀번호 최소자릿수 오류!!!");
//				}
//				//영대문자 포함여부 검사
//				if (isPasswdValid && passwordPolicy.getUpperCaseYN2().equals("Y")) {
//					if (!StringUtil.checkPatternUpperCase(userInfo.getPasswd())) {
//						isPasswdValid = false;
//						if (logger.isDebugEnabled()) logger.debug("2번규칙: 영대문자 미포함 오류!!!");
//					}
//					else {
//						compositionCnt++;
//					}
//				}
//				//영소문자 포함여부 검사
//				if (isPasswdValid && passwordPolicy.getLowerCaseYN2().equals("Y")) {
//					if (!StringUtil.checkPatternLowerCase(userInfo.getPasswd())) {
//						isPasswdValid = false;
//						if (logger.isDebugEnabled()) logger.debug("2번규칙: 영소문자 미포함 오류!!!");
//					}
//					else {
//						compositionCnt++;
//					}
//				}
//				//숫자 포함여부 검사
//				if (isPasswdValid && passwordPolicy.getNumberYN2().equals("Y")) {
//					if (!StringUtil.checkPatternNum(userInfo.getPasswd())) {
//						isPasswdValid = false;
//						if (logger.isDebugEnabled()) logger.debug("2번규칙: 숫자 미포함 오류!!!");
//					}
//					else {
//						compositionCnt++;
//					}
//				}
//				//특수문자 포함여부 검사
//				if (isPasswdValid && passwordPolicy.getSpecialLettersYN2().equals("Y")) {
//					if (!StringUtil.checkPatternSpecialLetters(userInfo.getPasswd())) {
//						isPasswdValid = false;
//						if (logger.isDebugEnabled()) logger.debug("2번규칙: 특수문자 미포함 오류!!!");
//					}
//					else {
//						compositionCnt++;
//					}
//				}
//				//비밀번호 구성요소 종류수 충족여부 검사
//				if (compositionCnt < Integer.parseInt(passwordPolicy.getCompositionCnt2())) {
//					isPasswdValid = false;
//					if (logger.isDebugEnabled()) logger.debug("2번규칙: 비밀번호 구성요소 종류수 미충족 오류!!!");
//				}
//			}
//		}
		
		return isPasswdValid;
		//비밀번호 생성규칙 유효성 검사 - END
	}
	
}
