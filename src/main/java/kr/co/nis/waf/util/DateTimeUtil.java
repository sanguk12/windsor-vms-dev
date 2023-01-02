// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.util;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class DateTimeUtil
{
    public static String getDateTimeByPattern(final String pattern) {
        final SimpleDateFormat formatter = new SimpleDateFormat(pattern, Locale.KOREA);
        final String dateString = formatter.format(new Date());
        return dateString;
    }
    
    public static String getParseDateString(final String dateTime, final String pattern) {
        if (dateTime != null) {
            final String year = dateTime.substring(0, 4);
            final String month = dateTime.substring(4, 6);
            final String day = dateTime.substring(6, 8);
            return year + pattern + month + pattern + day;
        }
        return "";
    }
}
