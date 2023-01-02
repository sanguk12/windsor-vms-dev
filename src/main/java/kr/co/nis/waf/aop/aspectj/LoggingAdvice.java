// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.aop.aspectj;

import org.aspectj.lang.ProceedingJoinPoint;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class LoggingAdvice
{
    protected final Log logger;
    
    public LoggingAdvice() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    public Object logOperations(final ProceedingJoinPoint pjp) throws Throwable {
        final String targetClassName = pjp.getTarget().getClass().getName();
        final String targetMethodName = pjp.getSignature().getName();
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)(targetClassName + "." + targetMethodName + " [ Start ]"));
            final Object[] args = pjp.getArgs();
            for (int i = 0; i < args.length; ++i) {
                this.logger.debug((Object)("arg[" + i + "] : " + args[i]));
            }
        }
        final Object returnValue = pjp.proceed();
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)(targetClassName + "." + targetMethodName + " [ End ]"));
        }
        return returnValue;
    }
}
