// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf;

import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import java.io.Serializable;

public class BaseObject implements Serializable
{
    static final String SUCCESS = "S";
    static final String ERROR = "E";
    static final String BUSY = "B";
    
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
