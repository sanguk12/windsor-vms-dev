package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;

/**
 * 2013.02.19. gtf. staff commute
 * @author taejoon.jang
 *
 */
public class Attend extends CommonObject implements Model {

	private String attend_date = "";
	private String user_no = "";
	private String goto_work_time = "";
	private String leave_work_time = "";

	public void clean() {
//		try{cellular_no = StringUtil.unFormat(cellular_no);}catch(Exception e){}
//		try{emergency_tel_no = StringUtil.unFormat(emergency_tel_no);}catch(Exception e){}
//		try{home_tel_no = StringUtil.unFormat(home_tel_no);}catch(Exception e){}
//		try{entrada_date = StringUtil.unFormat(entrada_date);}catch(Exception e){}
//		try{resign_date = StringUtil.unFormat(resign_date);}catch(Exception e){}
//		try{postcode = StringUtil.unFormat(postcode);}catch(Exception e){}
		
	}
	
	public void validate(int action) throws Exception {
		
	}

	public String getAttend_date() {
		return attend_date;
	}

	public void setAttend_date(String attend_date) {
		this.attend_date = attend_date;
	}

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

	public String getGoto_work_time() {
		return goto_work_time;
	}

	public void setGoto_work_time(String goto_work_time) {
		this.goto_work_time = goto_work_time;
	}

	public String getLeave_work_time() {
		return leave_work_time;
	}

	public void setLeave_work_time(String leave_work_time) {
		this.leave_work_time = leave_work_time;
	}
	
}