package kr.co.nis.waf.system.common.model;

import org.springframework.core.ErrorCoded;

public class InputRequiredException extends Exception implements ErrorCoded{

    public InputRequiredException() {
        super();
    }

    public InputRequiredException(String message, Throwable cause) {
        super(message, cause);
    }

    public InputRequiredException(String message) {
        super(message);
    }
    
    public InputRequiredException(Throwable cause) {
        super(cause);
    }

	public String getErrorCode() {
		return "infos.required";
	}
}
