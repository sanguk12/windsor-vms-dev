package kr.co.nis.waf.system.auth.model;

import kr.co.nis.waf.mvc.Model;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.system.common.model.InputRequiredException;

public class User extends CommonObject implements Model{
	
	public final int ACTION_DEFAULT = 0;
	public final int ACTION_ADD = 1;
	public final int ACTION_MODIFY = 2;
	public final int ACTION_REMOVE = 3;
	public final int ACTION_SAVE = 4;
	
	private String userID = "";
	private String userName = "";
	private String passwd = "";
	private String useYN = "";
	private String mnuConstructID = "";
	private String workerID = "";
	private String currentClientIp = "";
	private String activeFlg = "";
	private String initPasswdYN = "";
	private String dkmdTpCD = "";
	
	private String displayMnuTp = "";				// 모바일로그인시 모바일동의서 페이지 연결
	
	public void clean() throws Exception {
		this.userID = this.userID.toUpperCase();
		this.passwd = this.passwd.toUpperCase();
	}

	public void validate(int action) throws Exception {

		switch (action)
		{
		case ACTION_SAVE:
			if (this.userID.equals("")) {
				throw new InputRequiredException("userID");
			}
			else if (this.userName.equals("")) {
				throw new InputRequiredException("CMP01008A.userName");
			}
			/*
			else if (this.passwd.equals("")) {
				throw new InputRequiredException("passwd");
			}
			*/

			activeFlg = "U";

			break;

		case ACTION_REMOVE:
			if (this.userID.equals("")) {
				throw new InputRequiredException("userID");
			}

			activeFlg = "D";

			break;

		default:

			if (this.userID.equals("")) {
				throw new InputRequiredException("userID");
			}
			else if (this.userName.equals("")) {
				throw new InputRequiredException("userName");
			}
			/*
			else if (this.passwd.equals("")) {
				throw new InputRequiredException("passwd");
			}
			*/

			break;

		}
	}

	public String getDkmdTpCD() {
		return dkmdTpCD;
	}

	public void setDkmdTpCD(String dkmdTpCD) {
		this.dkmdTpCD = dkmdTpCD;
	}

	public String getInitPasswdYN() {
		return initPasswdYN;
	}

	public void setInitPasswdYN(String initPasswdYN) {
		this.initPasswdYN = initPasswdYN;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getUseYN() {
		return useYN;
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getMnuConstructID() {
		return mnuConstructID;
	}

	public void setMnuConstructID(String mnuConstructID) {
		this.mnuConstructID = mnuConstructID;
	}

	public String getWorkerID() {
		return workerID;
	}

	public void setWorkerID(String workerID) {
		this.workerID = workerID;
	}

	public String getCurrentClientIp() {
		return currentClientIp;
	}

	public void setCurrentClientIp(String currentClientIp) {
		this.currentClientIp = currentClientIp;
	}

	public String getActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(String activeFlg) {
		this.activeFlg = activeFlg;
	}

	public String getDisplayMnuTp() {
		return displayMnuTp;
	}

	public void setDisplayMnuTp(String displayMnuTp) {
		this.displayMnuTp = displayMnuTp;
	}
	
}