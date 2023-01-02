
package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.biz.model.SmsSend;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class SmsSend extends CommonObject implements Model {
	
	//SMS 전송대기 테이블
	private String schedule_type = ""; //발송시점구분(즉시:0, 예약 :1)
	private String dest_info = ""; //수신자번호
	private String callback = ""; //송신자번호
	private String send_date = "";  //발송 희망시간(예약일시)
	private String sms_msg = "";  //전송메세지내용
	private String sendCnt = ""; //SMS전송갯수
	private String reserved1  = ""; //여분필드1(회사코드)
	private String reserved2  = ""; //여분필드2(매장코드)
	
	private String desTel1 = "";
	private String desTel2 = "";
	private String desTel3 = "";
	private String srcTel1 = "";
	private String srcTel2 = "";
	private String srcTel3 = "";
	
	//현재년월
	private String currentMonth = "";
	
	//발송회원 배열
	private String[] custHpNoArr = null;
	
	//데이터 정제
	public void clean() {
	}
	
	//validate
	public void validate(int action) throws Exception {
		
	}
	
	//발송회원 size 가져오기
	public int getSize() {
		int size = 0 ;
		
		if (this.custHpNoArr != null)
		{
			 size = this.custHpNoArr.length;
		}
		
		return size;
	}
	
	//발송회원 목록 가져오기
	public SmsSend getObject(int i) {
		
		SmsSend smsSend = new SmsSend();
		if (getSize() > i) {
			smsSend.setUserID(getUserID());
			smsSend.setCompanyID(getCompanyID());
			smsSend.setSchedule_type(getSchedule_type());
			smsSend.setDest_info(this.custHpNoArr[i]);                
			smsSend.setCallback(getCallback());
			smsSend.setSend_date(getSend_date());
			smsSend.setSms_msg(getSms_msg());
			smsSend.setReserved1(getCompanyID());
			smsSend.setReserved2(getReserved2());
			
			if (this.custHpNoArr[i].length() == 11) {
				smsSend.setDesTel1(this.custHpNoArr[i].substring(0,3));
				smsSend.setDesTel2(this.custHpNoArr[i].substring(3,7));
				smsSend.setDesTel3(this.custHpNoArr[i].substring(7,11));
			} else if (this.custHpNoArr[i].length() == 10) {
				smsSend.setDesTel1(this.custHpNoArr[i].substring(0,3));
				smsSend.setDesTel2(this.custHpNoArr[i].substring(3,6));
				smsSend.setDesTel3(this.custHpNoArr[i].substring(6,10));
			}
			
			if (this.callback.length() == 11) {
				smsSend.setSrcTel1(this.callback.substring(0,3));
				smsSend.setSrcTel2(this.callback.substring(3,7));
				smsSend.setSrcTel3(this.callback.substring(7,11));
			} else if (this.callback.length() == 10) {
				if (this.callback.substring(0,2).equals("02")) {
					smsSend.setSrcTel1(this.callback.substring(0,2));
					smsSend.setSrcTel2(this.callback.substring(2,6));
					smsSend.setSrcTel3(this.callback.substring(6,10));
				} else {
					smsSend.setSrcTel1(this.callback.substring(0,3));
					smsSend.setSrcTel2(this.callback.substring(3,6));
					smsSend.setSrcTel3(this.callback.substring(6,10));
				}
			} else if (this.callback.length() == 9) {
				if (this.callback.substring(0,2).equals("02")) {
					smsSend.setSrcTel1(this.callback.substring(0,2));
					smsSend.setSrcTel2(this.callback.substring(2,5));
					smsSend.setSrcTel3(this.callback.substring(5,9));
				} else {
					smsSend.setSrcTel1(this.callback.substring(0,3));
					smsSend.setSrcTel2(this.callback.substring(3,5));
					smsSend.setSrcTel3(this.callback.substring(5,9));
				}
			}
		}
		
		return smsSend;
	}

	public String getSchedule_type() {
		return schedule_type;
	}

	public void setSchedule_type(String scheduleType) {
		schedule_type = scheduleType;
	}

	public String getDest_info() {
		return dest_info;
	}

	public void setDest_info(String destInfo) {
		dest_info = destInfo;
	}

	public String getCallback() {
		return callback;
	}

	public void setCallback(String callback) {
		this.callback = callback;
	}

	public String getSend_date() {
		return send_date;
	}

	public void setSend_date(String sendDate) {
		send_date = sendDate;
	}

	public String getSms_msg() {
		return sms_msg;
	}

	public void setSms_msg(String smsMsg) {
		sms_msg = smsMsg;
	}

	public String getSendCnt() {
		return sendCnt;
	}

	public void setSendCnt(String sendCnt) {
		this.sendCnt = sendCnt;
	}

	public String getReserved1() {
		return reserved1;
	}

	public void setReserved1(String reserved1) {
		this.reserved1 = reserved1;
	}

	public String getReserved2() {
		return reserved2;
	}

	public void setReserved2(String reserved2) {
		this.reserved2 = reserved2;
	}

	public String getDesTel1() {
		return desTel1;
	}

	public void setDesTel1(String desTel1) {
		this.desTel1 = desTel1;
	}

	public String getDesTel2() {
		return desTel2;
	}

	public void setDesTel2(String desTel2) {
		this.desTel2 = desTel2;
	}

	public String getDesTel3() {
		return desTel3;
	}

	public void setDesTel3(String desTel3) {
		this.desTel3 = desTel3;
	}

	public String getSrcTel1() {
		return srcTel1;
	}

	public void setSrcTel1(String srcTel1) {
		this.srcTel1 = srcTel1;
	}

	public String getSrcTel2() {
		return srcTel2;
	}

	public void setSrcTel2(String srcTel2) {
		this.srcTel2 = srcTel2;
	}

	public String getSrcTel3() {
		return srcTel3;
	}

	public void setSrcTel3(String srcTel3) {
		this.srcTel3 = srcTel3;
	}

	public String getCurrentMonth() {
		return currentMonth;
	}

	public void setCurrentMonth(String currentMonth) {
		this.currentMonth = currentMonth;
	}

	public String[] getCustHpNoArr() {
		return custHpNoArr;
	}

	public void setCustHpNoArr(String[] custHpNoArr) {
		this.custHpNoArr = custHpNoArr;
	}
	
	
}