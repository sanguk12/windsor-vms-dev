// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.util;

import java.util.ArrayList;
import java.util.StringTokenizer;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.Calendar;
import java.util.TimeZone;
import java.text.DateFormat;
import java.util.Date;
import java.text.SimpleDateFormat;
import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;

public class DateUtil
{
    private static Logger logger;
    public static SimpleDateFormat dateSqlFormat;
    public static SimpleDateFormat dateFormat;
    public static final int FORMAT_UNKNOWN = 0;
    public static final int FORMAT_YYYYMMDD = 123;
    public static final int FORMAT_MMDDYYYY = 231;
    public static final int FORMAT_DDMMYYYY = 321;
    
    public static int betweenDate(final Date from, final Date to) {
        return new Long((to.getTime() - from.getTime()) / 86400000L).intValue();
    }
    
    public static int betweenDate(String from, String to) {
        if (from == null) {
            throw new IllegalArgumentException("from can not be null");
        }
        if (to == null) {
            throw new IllegalArgumentException("to can not be null");
        }
        int len = from.length();
        if (len != 8 && len != 14) {
            throw new IllegalArgumentException("from length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)");
        }
        if (len == 8) {
            from += "000000";
        }
        len = to.length();
        if (len != 8 && len != 14) {
            throw new IllegalArgumentException("to length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)");
        }
        if (len == 8) {
            to += "000000";
        }
        return betweenDate(getUtilDate(from), getUtilDate(to));
    }
    
    public static String getCurrentDate() {
        final DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
        return df.format(new Date(System.currentTimeMillis()));
    }
    
    public static String getCurrentDate(final String delimiter) {
        final DateFormat df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
        return df.format(new Date(System.currentTimeMillis()));
    }
    
    public static String getCurrentDate(final String dateFormat, final String delimiter) {
        DateFormat df;
        if (dateFormat.equals("YMD")) {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
        }
        else if (dateFormat.equals("MDY")) {
            df = new SimpleDateFormat("MM" + delimiter + "dd" + delimiter + "yyyy");
        }
        else if (dateFormat.equals("DMY")) {
            df = new SimpleDateFormat("dd" + delimiter + "MM" + delimiter + "yyyy");
        }
        else {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
        }
        return df.format(new Date(System.currentTimeMillis()));
    }
    
    public static String getConvertDate(final Date sourceDate, final String sourceTimezone, final String targetTimezone, final String dateFormat) {
        String delimiter = ".";
        if (dateFormat.substring(3, 4).equals("D")) {
            delimiter = ".";
        }
        else if (dateFormat.substring(3, 4).equals("S")) {
            delimiter = "/";
        }
        else if (dateFormat.substring(3, 4).equals("B")) {
            delimiter = "-";
        }
        DateFormat df;
        if (dateFormat.substring(0, 3).equals("YMD")) {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
        }
        else if (dateFormat.substring(0, 3).equals("MDY")) {
            df = new SimpleDateFormat("MM" + delimiter + "dd" + delimiter + "yyyy");
        }
        else if (dateFormat.substring(0, 3).equals("DMY")) {
            df = new SimpleDateFormat("dd" + delimiter + "MM" + delimiter + "yyyy");
        }
        else {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
        }
        if (!sourceTimezone.equals(targetTimezone)) {
            final TimeZone sourceTZ = TimeZone.getTimeZone(sourceTimezone);
            final TimeZone targetTZ = TimeZone.getTimeZone(targetTimezone);
            final Calendar cal = Calendar.getInstance(sourceTZ);
            cal.setTimeZone(sourceTZ);
            cal.setTime(sourceDate);
            df.setTimeZone(targetTZ);
            return df.format(cal.getTime());
        }
        return df.format(sourceDate);
    }
    
    public static String getConvertDate(final Date sourceDate, final String sourceTimezone, final String targetTimezone, final String dateFormat, final String delimiter) {
        DateFormat df;
        if (dateFormat.substring(0, 3).equals("YMD")) {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
        }
        else if (dateFormat.substring(0, 3).equals("MDY")) {
            df = new SimpleDateFormat("MM" + delimiter + "dd" + delimiter + "yyyy");
        }
        else if (dateFormat.substring(0, 3).equals("DMY")) {
            df = new SimpleDateFormat("dd" + delimiter + "MM" + delimiter + "yyyy");
        }
        else {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
        }
        if (!sourceTimezone.equals(targetTimezone)) {
            final TimeZone sourceTZ = TimeZone.getTimeZone(sourceTimezone);
            final TimeZone targetTZ = TimeZone.getTimeZone(targetTimezone);
            final Calendar cal = Calendar.getInstance(sourceTZ);
            cal.setTimeZone(sourceTZ);
            cal.setTime(sourceDate);
            df.setTimeZone(targetTZ);
            return df.format(cal.getTime());
        }
        return df.format(sourceDate);
    }
    
    public static String getConvertDateTime(final Date sourceDate, final String sourceTimezone, final String targetTimezone, final String dateFormat) {
        String delimiter = ".";
        if (dateFormat.substring(3, 4).equals("D")) {
            delimiter = ".";
        }
        else if (dateFormat.substring(3, 4).equals("S")) {
            delimiter = "/";
        }
        else if (dateFormat.substring(3, 4).equals("B")) {
            delimiter = "-";
        }
        DateFormat df;
        if (dateFormat.substring(0, 3).equals("YMD")) {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd HH:mm:ss");
        }
        else if (dateFormat.substring(0, 3).equals("MDY")) {
            df = new SimpleDateFormat("MM" + delimiter + "dd" + delimiter + "yyyy HH:mm:ss");
        }
        else if (dateFormat.substring(0, 3).equals("DMY")) {
            df = new SimpleDateFormat("dd" + delimiter + "MM" + delimiter + "yyyy HH:mm:ss");
        }
        else {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd HH:mm:ss");
        }
        if (!sourceTimezone.equals(targetTimezone)) {
            final TimeZone sourceTZ = TimeZone.getTimeZone(sourceTimezone);
            final TimeZone targetTZ = TimeZone.getTimeZone(targetTimezone);
            final Calendar cal = Calendar.getInstance(sourceTZ);
            cal.setTimeZone(sourceTZ);
            cal.setTime(sourceDate);
            df.setTimeZone(targetTZ);
            return df.format(cal.getTime());
        }
        return df.format(sourceDate);
    }
    
    public static String getConvertDateTime(final Date sourceDate, final String sourceTimezone, final String targetTimezone, final String dateFormat, final String delimiter) {
        DateFormat df;
        if (delimiter.equals("")) {
            if (dateFormat.substring(0, 3).equals("YMD")) {
                df = new SimpleDateFormat("yyyyMMddHHmmss");
            }
            else if (dateFormat.substring(0, 3).equals("MDY")) {
                df = new SimpleDateFormat("MMddyyyyHHmmss");
            }
            else if (dateFormat.substring(0, 3).equals("DMY")) {
                df = new SimpleDateFormat("ddMMyyyyHHmmss");
            }
            else {
                df = new SimpleDateFormat("yyyyMMddHHmmss");
            }
        }
        else if (dateFormat.substring(0, 3).equals("YMD")) {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd HH:mm:ss");
        }
        else if (dateFormat.substring(0, 3).equals("MDY")) {
            df = new SimpleDateFormat("MM" + delimiter + "dd" + delimiter + "yyyy HH:mm:ss");
        }
        else if (dateFormat.substring(0, 3).equals("DMY")) {
            df = new SimpleDateFormat("dd" + delimiter + "MM" + delimiter + "yyyy HH:mm:ss");
        }
        else {
            df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd HH:mm:ss");
        }
        if (!sourceTimezone.equals(targetTimezone)) {
            final TimeZone sourceTZ = TimeZone.getTimeZone(sourceTimezone);
            final TimeZone targetTZ = TimeZone.getTimeZone(targetTimezone);
            final Calendar cal = Calendar.getInstance(sourceTZ);
            cal.setTimeZone(sourceTZ);
            cal.setTime(sourceDate);
            df.setTimeZone(targetTZ);
            return df.format(cal.getTime());
        }
        return df.format(sourceDate);
    }
    
    public static String getCurrentMonthOnly() {
        final int month = getMonth(getCurrentDate());
        String result = "";
        if (month < 10) {
            result = "0" + month;
        }
        else {
            result = Integer.toString(month);
        }
        return result;
    }
    
    public static String getCurrentTime() {
        final DateFormat df = new SimpleDateFormat("hhmmss");
        return df.format(new Date(System.currentTimeMillis()));
    }
    
    public static String getCurrentYear() {
        final DateFormat df = new SimpleDateFormat("yyyy");
        return df.format(new Date(System.currentTimeMillis()));
    }
    
    public static String getCurrentYearMonth() {
        final DateFormat df = new SimpleDateFormat("yyyy.MM");
        return df.format(new Date(System.currentTimeMillis()));
    }
    
    public static Date getDate() {
        return new Date(System.currentTimeMillis());
    }
    
    public static String getDate(final Date date, final TimeZone timeZone) {
        final Calendar cal = Calendar.getInstance(timeZone);
        cal.setTime(date);
        return FormatUtil.getMake2String(String.valueOf(cal.get(5)));
    }
    
    public static Date getDate(final String yyyymmdd) {
        if (yyyymmdd != null && yyyymmdd.length() == 8 && isDigit(yyyymmdd)) {
            final Calendar cal = Calendar.getInstance();
            cal.set(Integer.parseInt(yyyymmdd.substring(0, 4)), Integer.parseInt(yyyymmdd.substring(4, 6)) - 1, Integer.parseInt(yyyymmdd.substring(6, 8)));
            return cal.getTime();
        }
        return null;
    }
    
    public static Date getDate(final String timeParam, final Locale locale) {
        Date d = null;
        switch (getDateFormat(locale)) {
            case 123: {
                d = getDateYYYYMMDD(timeParam);
                break;
            }
            case 231: {
                d = getDateMMDDYYYY(timeParam);
                break;
            }
            case 321: {
                d = getDateDDMMYYYY(timeParam);
                break;
            }
        }
        return d;
    }
    
    public static Date getDateDDMMYYYY(final String date) {
        if (date != null) {
            final GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(date.substring(4, 8)), Integer.parseInt(date.substring(2, 4)) - 1, Integer.parseInt(date.substring(0, 2)));
            cal.getTime();
        }
        return null;
    }
    
    public static Date getDateFirstDayOfMonth(final Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar = new GregorianCalendar(calendar.get(1), calendar.get(2), 1);
        return calendar.getTime();
    }
    
    public static int getDateFormat(final Locale locale) {
        final String datePattern = ((SimpleDateFormat)DateFormat.getDateInstance(2, locale)).toPattern();
        StringTokenizer st = new StringTokenizer(datePattern);
        int formatCode = 0;
        while (st.hasMoreTokens()) {
            String token = st.nextToken();
            token = token.replaceAll(",", "").replaceAll("/", "").replaceAll("-", "").replaceAll(".", "");
            if ("yy".equals(token) || "yyyy".equals(token)) {
                formatCode = formatCode * 10 + 1;
            }
            else if ("M".equals(token) || "MM".equals(token) || "MMM".equals(token) || "MMMM".equals(token)) {
                formatCode = formatCode * 10 + 2;
            }
            else {
                if (!"d".equals(token) && !"dd".equals(token)) {
                    continue;
                }
                formatCode = formatCode * 10 + 3;
            }
        }
        if (formatCode == 0) {
            st = new StringTokenizer(datePattern, "-");
            while (st.hasMoreTokens()) {
                String token = st.nextToken();
                token = token.replaceAll(",", "").replaceAll("/", "").replaceAll("-", "").replaceAll(".", "");
                if ("yy".equals(token) || "yyyy".equals(token)) {
                    formatCode = formatCode * 10 + 1;
                }
                else if ("M".equals(token) || "MM".equals(token) || "MMM".equals(token) || "MMMM".equals(token)) {
                    formatCode = formatCode * 10 + 2;
                }
                else {
                    if (!"d".equals(token) && !"dd".equals(token)) {
                        continue;
                    }
                    formatCode = formatCode * 10 + 3;
                }
            }
        }
        return formatCode;
    }
    
    public static Date getDateLastDayOfMonth(final Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar = new GregorianCalendar(calendar.get(1), calendar.get(2), calendar.getActualMaximum(5));
        return calendar.getTime();
    }
    
    public static Date getDateMMDDYYYY(final String date) {
        if (date != null) {
            final GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(date.substring(4, 8)), Integer.parseInt(date.substring(0, 2)) - 1, Integer.parseInt(date.substring(2, 4)));
            return cal.getTime();
        }
        return null;
    }
    
    public static Date getDateMMYYYY(final String date) {
        if (date != null) {
            final GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(date.substring(2, 6)), Integer.parseInt(date.substring(0, 2)) - 1, 1);
            return cal.getTime();
        }
        return null;
    }
    
    public static String getDateStr(final Date date) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("yyyyMMdd");
            return df.format(date);
        }
        return null;
    }
    
    public static String getDateStr(final Date date, final char delimiter) {
        return getDateStr(date, delimiter + "");
    }
    
    public static String getDateStr(final Date date, final String delimiter) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
            return df.format(date);
        }
        return null;
    }
    
    public static String getDateString(final Date timeParam, final Locale locale) {
        return getDateString(timeParam, locale, "");
    }
    
    public static String getDateString(final Date timeParam, final Locale locale, final String delimiter) {
        String str = null;
        switch (getDateFormat(locale)) {
            case 123: {
                str = getYYYYMMDD(timeParam, delimiter);
                break;
            }
            case 231: {
                str = getMMDDYYYY(timeParam, delimiter);
                break;
            }
            case 321: {
                str = getDDMMYYYY(timeParam, delimiter);
                break;
            }
        }
        return str;
    }
    
    public static String getDateStringYM(final Date timeParam, final Locale locale, final String delimiter) {
        String str = null;
        switch (getDateFormat(locale)) {
            case 123: {
                str = getYYYYMM(timeParam, delimiter);
                break;
            }
            case 231: {
                str = getMMYYYY(timeParam, delimiter);
                break;
            }
            case 321: {
                str = getMMYYYY(timeParam, delimiter);
                break;
            }
        }
        return str;
    }
    
    public static String getDateStrWeekly(final Date date, final char delimiter) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("(E)MM" + delimiter + "dd");
            return df.format(date);
        }
        return null;
    }
    
    public static String getDateStrWithMMDD(final Date date) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("MMdd");
            return df.format(date);
        }
        return null;
    }
    
    public static String getDateStrYYYY(final Date date) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("yyyy");
            return df.format(date);
        }
        return null;
    }
    
    public static String getDateStrYYYYMM(final Date date, final char delimiter) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("yyyy" + delimiter + "MM");
            return df.format(date);
        }
        return null;
    }
    
    public static Date getDateWithDelimiter(final String yyyymmdd) {
        return getDateWithDelimiter(yyyymmdd, '\0');
    }
    
    public static Date getDateWithDelimiter(final String yyyymmdd, final char delimiter) {
        if (yyyymmdd != null && !yyyymmdd.equals("")) {
            final StringTokenizer st = new StringTokenizer(yyyymmdd, String.valueOf(delimiter) + "/.-");
            final String yyyy = st.nextToken();
            String mm = st.nextToken();
            String dd = st.nextToken();
            if (mm.length() < 2) {
                mm = "0" + mm;
            }
            if (dd.length() < 2) {
                dd = "0" + dd;
            }
            final String temp = yyyy + mm + dd;
            if (isDigit(temp)) {
                return getDate(temp);
            }
        }
        return null;
    }
    
    public static Date getDateWithDelimiterYYYYMM(final String yyyymm) {
        return getDateWithDelimiterYYYYMM(yyyymm, '\0');
    }
    
    public static Date getDateWithDelimiterYYYYMM(final String yyyymm, final char delimiter) {
        if (yyyymm != null && !yyyymm.equals("")) {
            final StringTokenizer st = new StringTokenizer(yyyymm, String.valueOf(delimiter) + "/.-");
            final String yyyy = st.nextToken();
            String mm = st.nextToken();
            if (mm.length() < 2) {
                mm = "0" + mm;
            }
            final String temp = yyyy + mm;
            if (isDigit(temp)) {
                return getDateYYYYMM(temp);
            }
        }
        return null;
    }
    
    public static Date getDateYM(final String timeParam, final Locale locale) {
        Date d = null;
        switch (getDateFormat(locale)) {
            case 123: {
                d = getDateYYYYMM(timeParam);
                break;
            }
            case 231: {
                d = getDateMMYYYY(timeParam);
                break;
            }
            case 321: {
                d = getDateMMYYYY(timeParam);
                break;
            }
        }
        return d;
    }
    
    public static Date getDateYYYYMM(final String date) {
        if (date != null) {
            final GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(date.substring(0, 4)), Integer.parseInt(date.substring(4, 6)) - 1, 1);
            return cal.getTime();
        }
        return null;
    }
    
    public static Date getDateYYYYMMDD(final String date) {
        if (date != null) {
            final GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(date.substring(0, 4)), Integer.parseInt(date.substring(4, 6)) - 1, Integer.parseInt(date.substring(6, 8)));
            return cal.getTime();
        }
        return null;
    }
    
    public static String getDayAfter(final int day) {
        return getDayAfter(getCurrentDate(), day);
    }
    
    public static String getDayAfter(final String _startDate, final int day) {
        final Calendar cal = Calendar.getInstance();
        cal.set(Integer.parseInt(_startDate.substring(0, 4)), Integer.parseInt(_startDate.substring(5, 7)) - 1, Integer.parseInt(_startDate.substring(8, 10)));
        final Date currentTime = cal.getTime();
        final Date oneTime = new Date(86400000 * day);
        final Date findTime = new Date(currentTime.getTime() + oneTime.getTime());
        return getDateStr(findTime, "-");
    }
    
    public static String getDayAfterWithOutSlash(final String startDate, final int day) {
        final Calendar cal = Calendar.getInstance();
        cal.set(Integer.parseInt(startDate.substring(0, 4)), Integer.parseInt(startDate.substring(4, 6)) - 1, Integer.parseInt(startDate.substring(6, 8)));
        final Date startTime = cal.getTime();
        final Date oneTime = new Date(86400000 * day);
        final long fTime = startTime.getTime() + oneTime.getTime();
        final Date findTime = new Date(fTime);
        return DateUtil.dateFormat.format(findTime);
    }
    
    public static int getDayStr(final Date date) {
        final Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.get(5);
    }
    
    public static String getDDMMYYYY(final Date date) {
        return getDDMMYYYY(date, "");
    }
    
    public static String getDDMMYYYY(final Date date, final String delimiter) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("dd" + delimiter + "MM" + delimiter + "yyyy");
            return df.format(date);
        }
        return null;
    }
    
    public static int getDiffDays(final String start) {
        final Calendar cal = Calendar.getInstance();
        int daydiff = 0;
        if (start != null && !start.trim().equals("") && start.length() == 8) {
            cal.set(Integer.parseInt(start.substring(0, 4)), Integer.parseInt(start.substring(4, 6)), Integer.parseInt(start.substring(6, 8)));
            final Date startDate = cal.getTime();
            final Date endDate = new Date(System.currentTimeMillis());
            final long ccc = endDate.getTime() - startDate.getTime();
            daydiff = (int)(ccc / 86400000L);
        }
        return daydiff;
    }
    
    public static int getDiffDays(final String start, final String end) {
        final Calendar cal = Calendar.getInstance();
        cal.set(Integer.parseInt(start.substring(0, 4)), Integer.parseInt(start.substring(4, 6)), Integer.parseInt(start.substring(6, 8)));
        final Date startDate = cal.getTime();
        cal.set(Integer.parseInt(end.substring(0, 4)), Integer.parseInt(end.substring(4, 6)), Integer.parseInt(end.substring(6, 8)));
        final Date endDate = cal.getTime();
        final long ccc = endDate.getTime() - startDate.getTime();
        final int daydiff = (int)(ccc / 86400000L);
        return daydiff;
    }
    
    public static int getDiffMonth(final String start) {
        final Calendar cal = Calendar.getInstance();
        int daydiff = 0;
        if (start != null && !start.trim().equals("") && start.length() == 8) {
            cal.set(Integer.parseInt(start.substring(0, 4)), 12, Integer.parseInt(start.substring(6, 8)));
            final Date startDate = cal.getTime();
            final Date endDate = new Date(System.currentTimeMillis());
            final long ccc = endDate.getTime() - startDate.getTime();
            daydiff = (int)(ccc / 86400000L);
        }
        return daydiff;
    }
    
    public static String getFirstDate(final int num) {
        final Calendar c = Calendar.getInstance();
        final DateFormat df = new SimpleDateFormat("yyyy.MM");
        c.set(2, c.get(2) + num);
        return df.format(c.getTime()) + "." + "01";
    }
    
    public static String getFirstDateByTimezone(final int num, final String timezone) {
        final TimeZone tz = TimeZone.getTimeZone(timezone);
        final Calendar c = Calendar.getInstance(tz);
        final DateFormat df = new SimpleDateFormat("yyyyMM");
        c.set(2, c.get(2) + num);
        return df.format(c.getTime()) + "01";
    }
    
    public static String getFirstDate(final int num, final String delimiter) {
        final Calendar c = Calendar.getInstance();
        final DateFormat df = new SimpleDateFormat("yyyy" + delimiter + "MM");
        c.set(2, c.get(2) + num);
        return df.format(c.getTime()) + delimiter + "01";
    }
    
    public static String getFirstYearDate(final int num) {
        final Calendar c = Calendar.getInstance();
        final DateFormat df = new SimpleDateFormat("yyyy-MM");
        c.set(1, c.get(1) + num);
        return df.format(c.getTime()) + "-" + "01";
    }
    
    public static String getForeMonth(String dateStr, final int i) {
        dateStr = FormatUtil.deleteSlash(dateStr);
        dateStr = FormatUtil.deleteDash(dateStr);
        final Date date = getDate(dateStr);
        final Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(2, i);
        return getDateStr(cal.getTime(), "-");
    }
    
    public static String getForeYear(String dateStr, final int i) {
        dateStr = FormatUtil.deleteSlash(dateStr);
        dateStr = FormatUtil.deleteDash(dateStr);
        final Date date = getDate(dateStr);
        final Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(1, i);
        return getDateStr(cal.getTime(), "-");
    }
    
    public static String getLastDate(final int num) {
        final Calendar c = Calendar.getInstance();
        final DateFormat df = new SimpleDateFormat("yyyy.MM");
        c.set(2, c.get(2) + num);
        return df.format(c.getTime()) + "." + c.getActualMaximum(5);
    }
    
    public static String getLastDateByTimezone(final int num, final String timezone) {
        final TimeZone tz = TimeZone.getTimeZone(timezone);
        final Calendar c = Calendar.getInstance(tz);
        final DateFormat df = new SimpleDateFormat("yyyyMM");
        c.set(2, c.get(2) + num);
        return df.format(c.getTime()) + c.getActualMaximum(5);
    }
    
    public static String getLastDate(final int num, final String delimiter) {
        final Calendar c = Calendar.getInstance();
        final DateFormat df = new SimpleDateFormat("yyyy" + delimiter + "MM");
        c.set(2, c.get(2) + num);
        return df.format(c.getTime()) + delimiter + c.getActualMaximum(5);
    }
    
    public static String getMM() {
        final Date current = new Date(System.currentTimeMillis());
        return new SimpleDateFormat("MM").format(current);
    }
    
    public static String getMMDD(final String delimiter) {
        final Date current = new Date(System.currentTimeMillis());
        final String month = new SimpleDateFormat("MM").format(current);
        final String day = new SimpleDateFormat("dd").format(current);
        return month + delimiter + day;
    }
    
    public static String getMMDDYYYY(final Date date) {
        return getMMDDYYYY(date, "");
    }
    
    public static String getMMDDYYYY(final Date date, final String delimiter) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("MM" + delimiter + "dd" + delimiter + "yyyy");
            return df.format(date);
        }
        return null;
    }
    
    public static String getMMYYYY(final Date date, final String delimiter) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("MM" + delimiter + "yyyy");
            return df.format(date);
        }
        return null;
    }
    
    public static String getMonth(final Date date, final TimeZone timeZone) {
        final Calendar cal = Calendar.getInstance(timeZone);
        cal.setTime(date);
        return FormatUtil.getMake2String(String.valueOf(cal.get(2)));
    }
    
    public static int getMonth(String date) {
        date = FormatUtil.deleteSlash(date);
        date = FormatUtil.deleteDash(date);
        date = FormatUtil.deleteDot(date);
        return Integer.parseInt(date.substring(4, 6));
    }
    
    public static String getMonthString(String date) {
        date = FormatUtil.deleteSlash(date);
        date = FormatUtil.deleteDash(date);
        return date.substring(4, 6);
    }
    
    public static String getNextDay() {
        return getNextDay(getCurrentDate());
    }
    
    public static String getNextDay(final String _startDate) {
        final Calendar cal = Calendar.getInstance();
        cal.set(Integer.parseInt(_startDate.substring(0, 4)), Integer.parseInt(_startDate.substring(5, 7)) - 1, Integer.parseInt(_startDate.substring(8, 10)));
        final Date currentTime = cal.getTime();
        final Date oneTime = new Date(86400000L);
        final Date findTime = new Date(currentTime.getTime() + oneTime.getTime());
        return getDateStr(findTime, "-");
    }
    
    public static String getOneDayPlusSomeDate(String _oneDay, final int _aFewDays) {
        if (_oneDay == null || "".equals(_oneDay)) {
            return "";
        }
        _oneDay = FormatUtil.deleteChar(_oneDay, "-");
        final Date now = new Date(System.currentTimeMillis());
        final String currentDate = DateUtil.dateFormat.format(now);
        long interval = Long.parseLong(_oneDay) - Long.parseLong(currentDate);
        interval += _aFewDays;
        final long intervalMillis = interval * 24L * 60L * 60L * 1000L;
        final Date current = new Date(System.currentTimeMillis() + intervalMillis);
        return DateUtil.dateSqlFormat.format(current);
    }
    
    public static String getPrevMonth(final String dateStr) {
        final Date date = getDateWithDelimiter(dateStr);
        final Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(2, -1);
        return getDateStr(cal.getTime(), "-");
    }
    
    public static String getPrevYear(final String dateStr) {
        final Date date = getDateWithDelimiter(dateStr);
        final Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(1, -1);
        return getDateStr(cal.getTime(), "-");
    }
    
    public static String getPreYYYYMM() {
        final String budgetYm = getForeMonth(getCurrentDate(), 1);
        return budgetYm;
    }
    
    public static Date getTime(final String hhmm) {
        if (hhmm != null && hhmm.length() == 4 && isDigit(hhmm)) {
            final Calendar cal = Calendar.getInstance();
            cal.set(11, Integer.parseInt(hhmm.substring(0, 2)));
            cal.set(12, Integer.parseInt(hhmm.substring(2, 4)));
            return cal.getTime();
        }
        return null;
    }
    
    public static String getTimeStr(final Date date, final char delimiter) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("HH" + delimiter + "mm");
            return df.format(date);
        }
        return null;
    }
    
    public static Date getTimeWithDelimiter(final String hhmm) {
        return getTimeWithDelimiter(hhmm, '\0');
    }
    
    public static Date getTimeWithDelimiter(final String hhmm, final char delimiter) {
        if (hhmm != null) {
            final StringTokenizer st = new StringTokenizer(hhmm, String.valueOf(delimiter) + ":-");
            String hh = st.nextToken();
            String mm = st.nextToken();
            if (hh.length() < 2) {
                hh = "0" + hh;
            }
            if (mm.length() < 2) {
                mm = "0" + mm;
            }
            final String temp = hh + mm;
            if (isDigit(temp)) {
                return getTime(temp);
            }
        }
        return null;
    }
    
    public static Date getUtilDate(final String dt) {
        final Calendar cal = Calendar.getInstance();
        cal.set(Integer.parseInt(dt.substring(0, 4)), Integer.parseInt(dt.substring(4, 6)) - 1, Integer.parseInt(dt.substring(6, 8)), Integer.parseInt(dt.substring(8, 10)), Integer.parseInt(dt.substring(10, 12)), Integer.parseInt(dt.substring(12, 14)));
        return cal.getTime();
    }
    
    public static String getYear(final Date date, final TimeZone timeZone) {
        final Calendar cal = Calendar.getInstance(timeZone);
        cal.setTime(date);
        return String.valueOf(cal.get(1));
    }
    
    public static int getYear(String date) {
        date = FormatUtil.deleteSlash(date);
        date = FormatUtil.deleteDash(date);
        return Integer.parseInt(date.substring(0, 4));
    }
    
    public static String getYYMM() {
        final Date current = new Date(System.currentTimeMillis());
        return new SimpleDateFormat("yyMM").format(current);
    }
    
    public static String getYYYY() {
        final Date current = new Date(System.currentTimeMillis());
        return new SimpleDateFormat("yyyy").format(current);
    }
    
    public static String getYYYY(final Date date) {
        final Calendar result = Calendar.getInstance();
        result.setTime(date);
        final DateFormat df = new SimpleDateFormat("yyyy");
        return df.format(result.getTime());
    }
    
    public static String getYYYYMM() {
        final Date current = new Date(System.currentTimeMillis());
        return new SimpleDateFormat("yyyyMM").format(current);
    }
    
    public static String getYYYYMM(final Date date) {
        return getYYYYMM(date, "");
    }
    
    public static String getYYYYMM(final Date date, final String delimiter) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
            return df.format(date);
        }
        return null;
    }
    
    public static String getYYYYMM(String dateString, final Locale locale) {
        dateString = FormatUtil.deleteDot(dateString);
        return getYYYYMM(getDateYM(dateString, locale));
    }
    
    public static String getYYYYMMBeforeMonth(final String yyyymm, final int beforeMonth) {
        if (yyyymm != null && yyyymm.length() == 6 && isDigit(yyyymm)) {
            final Calendar result = Calendar.getInstance();
            result.set(1, Integer.parseInt(yyyymm.substring(0, 4)));
            result.set(2, Integer.parseInt(yyyymm.substring(4, 6)) - 1);
            result.add(2, beforeMonth);
            final DateFormat df = new SimpleDateFormat("yyyyMM");
            return df.format(result.getTime());
        }
        return null;
    }
    
    public static String getYYYYMMDD(final Date date) {
        return getYYYYMMDD(date, "");
    }
    
    public static String getYYYYMMDD(final Date date, final String delimiter) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("yyyy" + delimiter + "MM" + delimiter + "dd");
            return df.format(date);
        }
        return null;
    }
    
    public static String getYYYYMMDD(String dateString, final Locale locale) {
        dateString = FormatUtil.deleteDot(dateString);
        return getYYYYMMDD(getDate(dateString, locale));
    }
    
    private static boolean isDigit(final String digitStr) {
        if (digitStr != null) {
            for (int i = 0; i < digitStr.length(); ++i) {
                if (!Character.isDigit(digitStr.charAt(i))) {
                    return false;
                }
            }
        }
        return true;
    }
    
    public static ArrayList listMonthlyDate(final String dateStr) {
        final ArrayList row = new ArrayList();
        ArrayList col = null;
        final Date searchDate = getDateWithDelimiter(dateStr);
        final Calendar cal = Calendar.getInstance();
        cal.setTime(searchDate);
        cal.set(5, 1);
        final int firstWeek = cal.get(7);
        final int endDay = cal.getActualMaximum(5);
        col = new ArrayList();
        int i;
        for (i = 0, i = 1; i < firstWeek; ++i) {
            col.add("");
        }
        for (i = 1; i <= 7 - (firstWeek - 1); ++i) {
            col.add("" + i);
        }
        row.add(col);
        col = new ArrayList();
        for (int j = i, k = 1; j <= endDay; ++j, ++k) {
            if (k > 7) {
                row.add(col);
                k = 1;
                col = new ArrayList();
            }
            col.add("" + j);
        }
        row.add(col);
        return row;
    }
    
    public static ArrayList listWeeklyDate(final String dateStr) {
        final Date searchDate = getDateWithDelimiter(dateStr);
        final Calendar cal = Calendar.getInstance();
        cal.setTime(searchDate);
        final int t = cal.get(7);
        cal.add(5, -(t - 1));
        Date start = cal.getTime();
        cal.add(5, 6);
        final Date end = cal.getTime();
        final ArrayList dateList = new ArrayList();
        while (start.getTime() <= end.getTime()) {
            dateList.add(getDateStr(start, "-"));
            cal.setTime(start);
            cal.add(5, 1);
            start = cal.getTime();
        }
        return dateList;
    }
    
    public static void main(final String[] arg) {
        final Date date = new Date();
        final String budgetYm = getForeMonth(getCurrentDate(), 1);
        System.out.println("\ub2e4\uc74c\ub2ec:" + getYear(budgetYm) + "/" + getMonthString(budgetYm) + "]");
        System.out.println(getCurrentDate() + ":vs:" + getOneDayPlusSomeDate("2003/06/30", -30) + "]");
        System.out.println("First day:" + date);
        System.out.println("First day:" + getDateFirstDayOfMonth(new Date()));
        System.out.println("First day:" + getDateLastDayOfMonth(new Date()));
    }
    
    public static String toDBFormat(final String _displayDate) {
        if (_displayDate == null) {
            return null;
        }
        if (_displayDate.length() == 10) {
            return _displayDate.substring(0, 4) + _displayDate.substring(5, 7) + _displayDate.substring(8);
        }
        if (_displayDate.length() == 7) {
            return _displayDate.substring(0, 4) + _displayDate.substring(5, 7);
        }
        return _displayDate;
    }
    
    public static String toDisplayFormat(final String _srcDate) {
        if (_srcDate == null || (_srcDate.length() != 8 && _srcDate.length() != 14)) {
            return _srcDate;
        }
        String time = "";
        if (_srcDate.length() == 14) {
            try {
                time = " " + _srcDate.substring(8, 10) + ":" + _srcDate.substring(10, 12) + ":" + _srcDate.substring(12, 14);
            }
            catch (final Exception ex) {}
        }
        return _srcDate.substring(0, 4) + "-" + _srcDate.substring(4, 6) + "-" + _srcDate.substring(6, 8) + time;
    }
    
    public static String toDisplayMonth(final String _dbDate, final String del) {
        if (_dbDate.length() < 6) {
            return _dbDate;
        }
        return _dbDate.substring(0, 4) + del + _dbDate.substring(4);
    }
    
    static {
        DateUtil.logger = (ch.qos.logback.classic.Logger)LoggerFactory.getLogger((Class)DateUtil.class);
        DateUtil.dateSqlFormat = new SimpleDateFormat("yyyy.MM.dd");
        DateUtil.dateFormat = new SimpleDateFormat("yyyyMMdd");
    }
}
