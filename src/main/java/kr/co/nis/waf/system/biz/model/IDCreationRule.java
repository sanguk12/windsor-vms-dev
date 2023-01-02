package kr.co.nis.waf.system.biz.model;

import kr.co.nis.waf.system.common.model.CommonObject;
import kr.co.nis.waf.mvc.Model;

public class IDCreationRule extends CommonObject implements Model {

	private String bizID = "";
	private String bizName = "";
	private String mappingTableID = "";
	private String mappingTableName = "";
	private String idType = "";
	private String idCreationRule = "";
	private String prefix = "";
	private String suffix = "";
	private int interval = 0;
	private int lastSeq = 0;
	private String useYN = "";
	private String remark = "";
	
	public void clean() throws Exception {
	}
	
	public void validate(int action) throws Exception {
	}
	
	public String getBizID() {
		return bizID;
	}

	public void setBizID(String bizID) {
		this.bizID = bizID;
	}

	public String getBizName() {
		return bizName;
	}

	public void setBizName(String bizName) {
		this.bizName = bizName;
	}

	public String getMappingTableID() {
		return mappingTableID;
	}

	public void setMappingTableID(String mappingTableID) {
		this.mappingTableID = mappingTableID;
	}

	public String getMappingTableName() {
		return mappingTableName;
	}

	public void setMappingTableName(String mappingTableName) {
		this.mappingTableName = mappingTableName;
	}

	public String getIdType() {
		return idType;
	}

	public void setIdType(String idType) {
		this.idType = idType;
	}

	public String getIdCreationRule() {
		return idCreationRule;
	}

	public void setIdCreationRule(String idCreationRule) {
		this.idCreationRule = idCreationRule;
	}

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public String getSuffix() {
		return suffix;
	}
	
	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}
	
	public int getInterval() {
		return interval;
	}
	
	public void setInterval(int interval) {
		this.interval = interval;
	}
	
	public int getLastSeq() {
		return lastSeq;
	}
	
	public void setLastSeq(int lastSeq) {
		this.lastSeq = lastSeq;
	}
	
	public String getUseYN() {
		return useYN;
	}
	
	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}
	
	public String getRemark() {
		return remark;
	}
	
	public void setRemark(String remark) {
		this.remark = remark;
	}
}