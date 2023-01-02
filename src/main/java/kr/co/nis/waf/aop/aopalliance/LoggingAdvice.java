// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.aop.aopalliance;

import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.aopalliance.intercept.MethodInterceptor;

public class LoggingAdvice implements MethodInterceptor
{
    protected final Log logger;
    
    public LoggingAdvice() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    public Object invoke(final MethodInvocation invocation) throws Throwable {
        final String className = invocation.getThis().getClass().getName();
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)(className + "." + invocation.getMethod().getName() + "() [Start]"));
            final Object[] args = invocation.getArguments();
            if (args != null && args.length > 0) {
                this.logger.debug((Object)("Argument Size : " + args.length));
                for (int i = 0; i < args.length; ++i) {
                    this.logger.debug((Object)("Argument[" + i + "] : " + args[i]));
                }
            }
        }
        final Object retVal = invocation.proceed();
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)(className + " | " + invocation.getMethod().getName() + " [End]"));
        }
        return retVal;
    }
}
