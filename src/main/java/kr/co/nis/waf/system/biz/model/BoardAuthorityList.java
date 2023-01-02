package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.biz.model.BoardAuthority;
import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class BoardAuthorityList extends CommonObject implements Model{
	
	private String boardID = "";
	private String[] publicID = null;
	private String[] publicClassCD = null;
	private String[] publicName = null;

	public void clean() throws Exception {
	}

	public void validate(int action) throws Exception {
	}

	public BoardAuthority getObject(int index) {
		
		BoardAuthority boardAuthority = new BoardAuthority();

		if (this.publicID.length > index) {	
			
			boardAuthority.setCompanyID(this.getCompanyID());
			boardAuthority.setUserID(this.getUserID());
			boardAuthority.setBoardID(this.boardID);
			try {boardAuthority.setPublicID(this.publicID[index]);} catch (Exception e){}
			try {boardAuthority.setPublicClassCD(this.publicClassCD[index]);} catch (Exception e){}
			try {boardAuthority.setPublicName(this.publicName[index]);} catch (Exception e){}
		    
		}
		return boardAuthority;
	}
	
	public int getSize() {
		int size = 0;
		if (publicID != null) {
			size = publicID.length;
		}
		return size;
	}

	public String getBoardID() {
		return boardID;
	}

	public void setBoardID(String boardID) {
		this.boardID = boardID;
	}

	public String[] getPublicID() {
		return publicID;
	}

	public void setPublicID(String[] publicID) {
		this.publicID = publicID;
	}

	public String[] getPublicClassCD() {
		return publicClassCD;
	}

	public void setPublicClassCD(String[] publicClassCD) {
		this.publicClassCD = publicClassCD;
	}

	public String[] getPublicName() {
		return publicName;
	}

	public void setPublicName(String[] publicName) {
		this.publicName = publicName;
	}

}