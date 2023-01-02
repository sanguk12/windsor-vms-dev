package kr.co.nis.waf.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.nis.waf.BaseObject;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * Ajax 방식의 Request에 대한 결과데이터(JSON형식) 생성 클래스
 */
public class ResultData extends BaseObject {

	public final String RESULT_ERROR = "E";
	public final String RESULT_SUCCESS = "S";
	
	/**
	 * 결과코드
	 * RESULT_ERROR 또는 RESULT_SUCCESS 값 중 하나가 들어간다.
	 */
	private String code = null;
	
	/**
	 * 사용자 정의 결과 메세지
	 * 완료 또는 실패 같은 사용자가 인식가능한 결과 메세지를 설정한다.
	 */
	private String message = null;
	
	/**
	 * 시스템 결과 메세지
	 * Java Exception(DB 또는 WAS 에러 메세지)과 같은 시스템 결과 메세지를 설정한다.
	 */
	private String systemMessage = null;
	
	/**
	 * 결과 데이터 (복수 건)
	 * 결과 View 에서 리턴받아 처리해야 할 파라메터를 설정한다.
	 */
	private List data = new ArrayList();
	
	/**
	 * 결과 파라메터
	 * 결과 View 에서 리턴받아 처리해야 할 파라메터를 설정한다.
	 */
	private Map param = new HashMap();
	
	/**
	 * Error List
	 */
	private List error = new ArrayList();
	private String errorTxt = null;
	

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSystemMessage() {
		return systemMessage;
	}

	public void setSystemMessage(String systemMessage) {
		this.systemMessage = systemMessage;
	}
	
	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}

	public Map getParam() {
		return param;
	}
	
	public void setParam(String key, String value) {
		param.put(key, value);
	}
	
	public List getError() {
		return error;
	}

	public void setErrorList(List errorList) {
		this.error = errorList;
	}
	
	public String getErrorTxt() {
		return errorTxt;
	}

	public void setErrorTxt(String errorTxt) {
		this.errorTxt = errorTxt;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

	public boolean equals(Object o) {
		return EqualsBuilder.reflectionEquals(this, o);
	}

	public int hashCode() {
		return HashCodeBuilder.reflectionHashCode(this);
	}
}
