package kr.co.nis.waf.system.auth.service;

import java.util.Map;

import kr.co.nis.waf.system.auth.model.PasswordPolicy;
import kr.co.nis.waf.system.auth.model.UserExtend;

public interface SecurityService {
	
	/*
	 * 비밀번호 정책 추가
	 */
	public void addPasswordPolicy(PasswordPolicy passwordPolicy) throws Exception;
	
	/*
	 * 비밀번호 정책 변경
	 */
	public void modifyPasswordPolicy(PasswordPolicy passwordPolicy) throws Exception;

	/*
	 * 사용자 계정 설정기간 내 미접속시 자동 잠금
	 */
	public void modifyAccountBlock(Map param) throws Exception;
	
	/*
	 * 비밀번호 생성규칙 유효성 검사
	 */
	public boolean checkPasswordValid(UserExtend userInfo);
}