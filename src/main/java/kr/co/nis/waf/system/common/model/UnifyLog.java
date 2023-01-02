package kr.co.nis.waf.system.common.model;

import kr.co.nis.waf.mvc.Model;

public class UnifyLog extends CommonObject implements Model {

	private String unify_log_no = "";
	private String serial_no = "";
	private String work_division = "";
	private String msg = "";
	private String register = "";
	private String[] unify_log_nos = null;
	private String[] work_divisions = null;
	private String[] msgs = null;
	
	private String userID2 = "";
	private String unify_log_no2 = "";
	private String serial_no2 = "";
	private String work_division2 = "";
	private String msg2 = "";
	private String register2 = "";
	private String[] unify_log_nos2 = null;
	private String[] work_divisions2 = null;
	private String[] msgs2 = null;
	
	private String userID3 = "";
	private String unify_log_no3 = "";
	private String serial_no3 = "";
	private String work_division3 = "";
	private String msg3 = "";
	private String register3 = "";
	private String[] unify_log_nos3 = null;
	private String[] work_divisions3 = null;
	private String[] msgs3 = null;
	
	public int getSize() {
		int size = 0 ;
		if (this.unify_log_nos != null) {
			 size = this.unify_log_nos.length;
		}
		return size;
	}
	public UnifyLog getObject(int index) {
		UnifyLog vo = new UnifyLog();
		if (getSize() > index) {
			try{vo.setRegister(this.getUserID());}catch(Exception e){}
			try{vo.setWork_division(this.getWork_division());}catch(Exception e){}
			try{vo.setMsg(this.getMsg());}catch(Exception e){}
			
			try{vo.setUnify_log_no(this.unify_log_nos[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public int getSize2() {
		int size = 0 ;
		if (this.unify_log_nos2 != null) {
			 size = this.unify_log_nos2.length;
		}
		return size;
	}
	public UnifyLog getObject2(int index) {
		UnifyLog vo = new UnifyLog();
		if (getSize2() > index) {
			try{vo.setRegister2(this.getUserID2());}catch(Exception e){}
			try{vo.setWork_division2(this.getWork_division2());}catch(Exception e){}
			try{vo.setMsg2(this.getMsg2());}catch(Exception e){}
			
			try{vo.setUnify_log_no2(this.unify_log_nos2[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public int getSize3() {
		int size = 0 ;
		if (this.unify_log_nos3 != null) {
			 size = this.unify_log_nos3.length;
		}
		return size;
	}
	public UnifyLog getObject3(int index) {
		UnifyLog vo = new UnifyLog();
		if (getSize3() > index) {
			try{vo.setRegister3(this.getUserID3());}catch(Exception e){}
			try{vo.setWork_division3(this.getWork_division3());}catch(Exception e){}
			try{vo.setMsg3(this.getMsg3());}catch(Exception e){}
			
			try{vo.setUnify_log_no3(this.unify_log_nos3[index]);}catch(Exception e){}
		}
		return vo;
	}
	
	public void clean() {
	}
	
	public void validate(int action) throws Exception {
		
	}

	public String getUserID2() {
		return userID2;
	}
	public void setUserID2(String userID2) {
		this.userID2 = userID2;
	}
	public String getUserID3() {
		return userID3;
	}
	public void setUserID3(String userID3) {
		this.userID3 = userID3;
	}
	public String getUnify_log_no2() {
		return unify_log_no2;
	}
	public void setUnify_log_no2(String unify_log_no2) {
		this.unify_log_no2 = unify_log_no2;
	}
	public String getSerial_no2() {
		return serial_no2;
	}
	public void setSerial_no2(String serial_no2) {
		this.serial_no2 = serial_no2;
	}
	public String getWork_division2() {
		return work_division2;
	}
	public void setWork_division2(String work_division2) {
		this.work_division2 = work_division2;
	}
	public String getMsg2() {
		return msg2;
	}
	public void setMsg2(String msg2) {
		this.msg2 = msg2;
	}
	public String getRegister2() {
		return register2;
	}
	public void setRegister2(String register2) {
		this.register2 = register2;
	}
	public String[] getUnify_log_nos2() {
		return unify_log_nos2;
	}
	public void setUnify_log_nos2(String[] unify_log_nos2) {
		this.unify_log_nos2 = unify_log_nos2;
	}
	public String[] getWork_divisions2() {
		return work_divisions2;
	}
	public void setWork_divisions2(String[] work_divisions2) {
		this.work_divisions2 = work_divisions2;
	}
	public String[] getMsgs2() {
		return msgs2;
	}
	public void setMsgs2(String[] msgs2) {
		this.msgs2 = msgs2;
	}
	public String getUnify_log_no3() {
		return unify_log_no3;
	}
	public void setUnify_log_no3(String unify_log_no3) {
		this.unify_log_no3 = unify_log_no3;
	}
	public String getSerial_no3() {
		return serial_no3;
	}
	public void setSerial_no3(String serial_no3) {
		this.serial_no3 = serial_no3;
	}
	public String getWork_division3() {
		return work_division3;
	}
	public void setWork_division3(String work_division3) {
		this.work_division3 = work_division3;
	}
	public String getMsg3() {
		return msg3;
	}
	public void setMsg3(String msg3) {
		this.msg3 = msg3;
	}
	public String getRegister3() {
		return register3;
	}
	public void setRegister3(String register3) {
		this.register3 = register3;
	}
	public String[] getUnify_log_nos3() {
		return unify_log_nos3;
	}
	public void setUnify_log_nos3(String[] unify_log_nos3) {
		this.unify_log_nos3 = unify_log_nos3;
	}
	public String[] getWork_divisions3() {
		return work_divisions3;
	}
	public void setWork_divisions3(String[] work_divisions3) {
		this.work_divisions3 = work_divisions3;
	}
	public String[] getMsgs3() {
		return msgs3;
	}
	public void setMsgs3(String[] msgs3) {
		this.msgs3 = msgs3;
	}
	public String[] getUnify_log_nos() {
		return unify_log_nos;
	}

	public void setUnify_log_nos(String[] unify_log_nos) {
		this.unify_log_nos = unify_log_nos;
	}

	public String[] getWork_divisions() {
		return work_divisions;
	}

	public void setWork_divisions(String[] work_divisions) {
		this.work_divisions = work_divisions;
	}

	public String[] getMsgs() {
		return msgs;
	}

	public void setMsgs(String[] msgs) {
		this.msgs = msgs;
	}

	public String getUnify_log_no() {
		return unify_log_no;
	}

	public void setUnify_log_no(String unify_log_no) {
		this.unify_log_no = unify_log_no;
	}

	public String getSerial_no() {
		return serial_no;
	}

	public void setSerial_no(String serial_no) {
		this.serial_no = serial_no;
	}

	public String getWork_division() {
		return work_division;
	}

	public void setWork_division(String work_division) {
		this.work_division = work_division;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getRegister() {
		return register;
	}

	public void setRegister(String register) {
		this.register = register;
	}

}