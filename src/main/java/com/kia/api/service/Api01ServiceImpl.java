package com.kia.api.service;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.api.model.GAPI01MT;

@Service("api01Service")
public class Api01ServiceImpl implements Api01Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;	

	/*** 본인인증 완료 */
	public void updateCompleteAuth(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100101U", gapi01mt);		
		simpleDao.update("API0100101U1", gapi01mt);		
	}
	
	/*** 비밀번호변경 */
	public void updateChangePassword(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100102U", gapi01mt);		
	}
	
	/*** 계약체결 */
	public void updateSignContract(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100103U", gapi01mt);		
		simpleDao.insert("API0100103U1", gapi01mt);		
		//simpleDao.insert("API0100103U2", gapi01mt); 프로그램 참여동의 안해도됨.		
		simpleDao.update("API0100103U3", gapi01mt);		
	}
	
	/*** 계좌번호변경 */
	public void updateSaveAccountNumber1(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100104U", gapi01mt);		
	}
	
	/*** 실적계좌번호변경 브랜드단위*/
	public void updateSaveAccountNumber2(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100108U1", gapi01mt);		
	}
	
	/*** 실적계좌번호변경 업소단위*/
	public void updateSaveAccountNumber3(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100108U2", gapi01mt);		
	}
	
	/*** 판매관리승인 업소*/
	public void updateSaveSalesPromotion1(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100105U", gapi01mt);	
	}
	
	/*** 판매관리승인 브랜드*/
	public void updateSaveSalesPromotion2(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100106U", gapi01mt);	
	}
	
	/*** 판매촉진활동*/
	public void updateSaveSalesPromotion3(GAPI01MT gapi01mt) throws Exception {
		simpleDao.insert("API0100107U", gapi01mt);	
	}
	
	
	/*** 판매관리반려 업소*/
	public void rejectSalesPromotion1(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100109U1", gapi01mt);	
		simpleDao.update("API0100109U1_1", gapi01mt);	
	}
	
	/*** 판매관리반려 브랜드*/
	public void rejectSalesPromotion2(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100109U2", gapi01mt);	
	}
	
	
	/*** 키맨 정보 수정(주소 등) */
	public void updateKeyman(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100110U1", gapi01mt);		
	}
	
	/*** 키맨 정보 수정(계좌정보) */
	public void updateKeymanBank(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100110U2", gapi01mt);		
	}
	
	/*** 이력 저장(개인인증)*/
	public void updateHistory(GAPI01MT gapi01mt) throws Exception {
		simpleDao.insert("API0100140U", gapi01mt);	
	}
	/*** 이력 저장(계좌조회)*/
	public void insertHistory(GAPI01MT gapi01mt) throws Exception {
		simpleDao.insert("API0100140I", gapi01mt);	
	}
	
	/*** 비밀번호초기화 */
	public void updateResetPassword(GAPI01MT gapi01mt) throws Exception {
		simpleDao.update("API0100160U", gapi01mt);		
	}
}