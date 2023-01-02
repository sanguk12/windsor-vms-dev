// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.util;

import java.io.UnsupportedEncodingException;

public class HanUtil
{
    public static String ascToKsc(final String value) {
        try {
            final String strRet = new String(value.getBytes("8859_1"), "UTF-8");
            return strRet;
        }
        catch (final UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static String kscToAsc(final String value) {
        try {
            final String strRet = new String(value.getBytes("KSC5601"), "8859_1");
            return strRet;
        }
        catch (final UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }
}
