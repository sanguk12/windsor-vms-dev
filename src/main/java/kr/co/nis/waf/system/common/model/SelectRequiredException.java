package kr.co.nis.waf.system.common.model;

import org.springframework.core.ErrorCoded;

public class SelectRequiredException extends Exception implements ErrorCoded{

    public SelectRequiredException() {
        super();
    }

    public SelectRequiredException(String message, Throwable cause) {
        super(message, cause);
    }

    public SelectRequiredException(String message) {
        super(message);
    }
    
    public SelectRequiredException(Throwable cause) {
        super(cause);
    }

	public String getErrorCode() {
		return "infos.selected";
	}
}
