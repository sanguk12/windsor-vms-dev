package com.kia.api.service;

import com.kia.api.model.GAPI01MT;

public interface Api01Service {	
	
	/*** 본인인증 완료 */
	public void updateCompleteAuth(GAPI01MT gapi01mt) throws Exception;	
	
	/*** 비밀번호변경 */
	public void updateChangePassword(GAPI01MT gapi01mt) throws Exception;	
	
	/*** 계약체결 */
	public void updateSignContract(GAPI01MT gapi01mt) throws Exception;	
	
	/*** 계좌번호변경 */
	public void updateSaveAccountNumber1(GAPI01MT gapi01mt) throws Exception;	
	
	/*** 실적계좌번호변경 브랜드단위*/
	public void updateSaveAccountNumber2(GAPI01MT gapi01mt) throws Exception;
	
	/*** 실적계좌번호변경 업소단위*/
	public void updateSaveAccountNumber3(GAPI01MT gapi01mt) throws Exception;
	
	/*** 판매관리승인 업소*/
	public void updateSaveSalesPromotion1(GAPI01MT gapi01mt) throws Exception;	
	
	/*** 판매관리승인 브랜드*/
	public void updateSaveSalesPromotion2(GAPI01MT gapi01mt) throws Exception;	
	
	/*** 판매촉진활동*/
	public void updateSaveSalesPromotion3(GAPI01MT gapi01mt) throws Exception;	
	
	/*** 판매관리승인 업소*/
	public void rejectSalesPromotion1(GAPI01MT gapi01mt) throws Exception;	
	
	/*** 판매관리승인 브랜드*/
	public void rejectSalesPromotion2(GAPI01MT gapi01mt) throws Exception;	
	
	/*** 키맨 정보 수정(주소 등) */
	public void updateKeyman(GAPI01MT gapi01mt) throws Exception;
	
	/*** 키맨 정보 수정(계좌정보) */
	public void updateKeymanBank(GAPI01MT gapi01mt) throws Exception;
	
	/*** 이력저장(개인인증) */
	public void updateHistory(GAPI01MT gapi01mt) throws Exception;
	
	/*** 이력저장(계좌조회) */
	public void insertHistory(GAPI01MT gapi01mt) throws Exception;
	
	/*** 비밀번호 초기화 */
	public void updateResetPassword(GAPI01MT gapi01mt) throws Exception;	

}