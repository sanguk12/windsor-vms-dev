// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf;

import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import java.util.ArrayList;
import java.util.List;

public class ResultMessage extends BaseObject
{
    public final String RESULT_ERROR = "E";
    public final String RESULT_SUCCESS = "S";
    private String code;
    private String message;
    private String systemMessage;
    private List parameters;
    
    public ResultMessage() {
        this.code = null;
        this.message = null;
        this.systemMessage = null;
        this.parameters = new ArrayList();
    }
    
    public String getCode() {
        return this.code;
    }
    
    public void setCode(final String code) {
        this.code = code;
    }
    
    public String getMessage() {
        return this.message;
    }
    
    public void setMessage(final String message) {
        this.message = message;
    }
    
    public String getSystemMessage() {
        return this.systemMessage;
    }
    
    public int getParametersSize() {
        return this.parameters.size();
    }
    
    public String getParameters(final int i) {
        return (String) this.parameters.get(i);
    }
    
    public void setParameters(final String parameter) {
        this.parameters.add(parameter);
    }
    
    public void setParameter(final List parameters) {
        this.parameters = parameters;
    }
    
    public void setSystemMessage(final String systemMessage) {
        this.systemMessage = systemMessage;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString((Object)this, ToStringStyle.MULTI_LINE_STYLE);
    }
    
    @Override
    public boolean equals(final Object o) {
        return EqualsBuilder.reflectionEquals((Object)this, o);
    }
    
    @Override
    public int hashCode() {
        return HashCodeBuilder.reflectionHashCode((Object)this);
    }
}
