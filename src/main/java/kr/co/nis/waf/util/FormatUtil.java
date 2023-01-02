// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.util;

import java.math.BigDecimal;
import java.text.FieldPosition;
import java.text.MessageFormat;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
import java.util.Locale;
import java.text.DecimalFormat;
import java.util.StringTokenizer;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.sql.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;

public class FormatUtil
{
    private static Logger logger;
    public static SimpleDateFormat checkSdf;
    public static final String CHECK_DATE_FORMAT = "yyyyMMdd";
    public static final String DASH = "-";
    public static final String SLASH = "/";
    
    static {
        FormatUtil.logger = (ch.qos.logback.classic.Logger) LoggerFactory.getLogger((Class)FormatUtil.class);
        FormatUtil.checkSdf = null;
    }
    
    public static void append(final StringBuffer sb, final String str) {
        sb.append(str).append("\n");
    }
    
    public static boolean checkDate(final String _str) {
        FormatUtil.checkSdf = new SimpleDateFormat("yyyyMMdd");
        final String newStr = getherDigit(_str);
        if (newStr != null && newStr.length() == 8) {
            final Calendar cal = Calendar.getInstance();
            cal.set(Integer.parseInt(newStr.substring(0, 4)), Integer.parseInt(newStr.substring(4, 6)) - 1, Integer.parseInt(newStr.substring(6, 8)));
            if (FormatUtil.checkSdf.format(cal.getTime()).equals(newStr)) {
                return true;
            }
        }
        return false;
    }
    
    public static String chkNull(final Object obj) {
        return (String)((obj == null) ? "" : obj);
    }
    
    public static String chkNumber(final Object obj) {
        return (String)((obj == null) ? "0" : obj);
    }
    
    public static String convJS(final Object pObject) {
        if (pObject == null) {
            return "";
        }
        final String value = (String)pObject;
        final StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < value.length(); ++i) {
            final char ch = value.charAt(i);
            switch (ch) {
                case '\\': {
                    buffer.append("\\\\");
                    break;
                }
                case '\'': {
                    buffer.append("\\'");
                    break;
                }
                case '\"': {
                    buffer.append("\\\"");
                    break;
                }
                case '\r': {
                    buffer.append("\\r");
                    break;
                }
                case '\n': {
                    buffer.append("\\n");
                    break;
                }
                default: {
                    buffer.append(ch);
                    break;
                }
            }
        }
        return buffer.toString();
    }
    
    public static String dateToStr(final Date date) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("yyyyMMdd");
            return df.format(date);
        }
        return "";
    }
    
    public static String decode(final String str) {
        if (str == null) {
            return null;
        }
        try {
            return new String(str.getBytes("ISO8859_1"), "UTF-8");
        }
        catch (final UnsupportedEncodingException e) {
            return null;
        }
    }
    
    public static String deleteChar(final String source, final String deleteStr) {
        if (source == null || source.equals("")) {
            return source;
        }
        final StringBuffer temp = new StringBuffer("");
        final StringTokenizer st = new StringTokenizer(source, deleteStr);
        while (st.hasMoreTokens()) {
            temp.append(st.nextToken());
        }
        return temp.toString();
    }
    
    public static String deleteComma(final String value) {
        return deleteChar(value, ",");
    }
    
    public static String deleteDash(final String value) {
        return deleteChar(value, "-");
    }
    
    public static String deleteDot(final String value) {
        return deleteChar(value, ".");
    }
    
    public static String deleteSlash(final String value) {
        return deleteChar(value, "/");
    }
    
    public static String formatDate(String s) {
        if (s == null) {
            return "";
        }
        if (s.equals("") || unFormat(s).length() != 8) {
            return s;
        }
        s = unFormat(s);
        final String yyyy = s.substring(0, 4);
        final String mm = s.substring(4, 6);
        final String dd = s.substring(6, 8);
        return String.valueOf(yyyy) + "." + mm + "." + dd;
    }
    
    public static String convertDate(final String s, final String sourceDateFormat, final String targetDateFormat) {
        if (s == null) {
            return "";
        }
        String date = s.replace("-", "").replace(".", "").replace("/", "");
        if (date.equals("") || unFormat(date).length() != 8) {
            return date;
        }
        String yyyy = "";
        String mm = "";
        String dd = "";
        String delimiter = "";
        if (targetDateFormat.substring(3, 4).equals("D")) {
            delimiter = ".";
        }
        else if (targetDateFormat.substring(3, 4).equals("S")) {
            delimiter = "/";
        }
        else if (targetDateFormat.substring(3, 4).equals("B")) {
            delimiter = "-";
        }
        else {
            delimiter = ".";
        }
        if (sourceDateFormat.substring(0, 3).equals("YMD")) {
            yyyy = date.substring(0, 4);
            mm = date.substring(4, 6);
            dd = date.substring(6, 8);
        }
        else if (sourceDateFormat.substring(0, 3).equals("MDY")) {
            yyyy = date.substring(4, 8);
            mm = date.substring(0, 2);
            dd = date.substring(2, 4);
        }
        else if (sourceDateFormat.substring(0, 3).equals("DMY")) {
            yyyy = date.substring(4, 8);
            mm = date.substring(2, 4);
            dd = date.substring(0, 2);
        }
        else {
            yyyy = date.substring(0, 4);
            mm = date.substring(4, 6);
            dd = date.substring(6, 8);
        }
        if (targetDateFormat.substring(0, 3).equals("YMD")) {
            date = String.valueOf(yyyy) + delimiter + mm + delimiter + dd;
        }
        else if (targetDateFormat.substring(0, 3).equals("MDY")) {
            date = String.valueOf(mm) + delimiter + dd + delimiter + yyyy;
        }
        else if (targetDateFormat.substring(0, 3).equals("DMY")) {
            date = String.valueOf(dd) + delimiter + mm + delimiter + yyyy;
        }
        else {
            date = String.valueOf(yyyy) + delimiter + mm + delimiter + dd;
        }
        return date;
    }
    
    public static String convertDate(final String s, final String sourceDateFormat, final String targetDateFormat, final String delimiter) {
        if (s == null) {
            return "";
        }
        String date = s.replace("-", "").replace(".", "").replace("/", "");
        if (date.equals("") || unFormat(date).length() != 8) {
            return date;
        }
        String yyyy = "";
        String mm = "";
        String dd = "";
        if (sourceDateFormat.substring(0, 3).equals("YMD")) {
            yyyy = date.substring(0, 4);
            mm = date.substring(4, 6);
            dd = date.substring(6, 8);
        }
        else if (sourceDateFormat.substring(0, 3).equals("MDY")) {
            yyyy = date.substring(4, 8);
            mm = date.substring(0, 2);
            dd = date.substring(2, 4);
        }
        else if (sourceDateFormat.substring(0, 3).equals("DMY")) {
            yyyy = date.substring(4, 8);
            mm = date.substring(2, 4);
            dd = date.substring(0, 2);
        }
        else {
            yyyy = date.substring(0, 4);
            mm = date.substring(4, 6);
            dd = date.substring(6, 8);
        }
        if (targetDateFormat.substring(0, 3).equals("YMD")) {
            date = String.valueOf(yyyy) + delimiter + mm + delimiter + dd;
        }
        else if (targetDateFormat.substring(0, 3).equals("MDY")) {
            date = String.valueOf(mm) + delimiter + dd + delimiter + yyyy;
        }
        else if (targetDateFormat.substring(0, 3).equals("DMY")) {
            date = String.valueOf(dd) + delimiter + mm + delimiter + yyyy;
        }
        else {
            date = String.valueOf(yyyy) + delimiter + mm + delimiter + dd;
        }
        return date;
    }
    
    public static String formatMonth(String s) {
        if (s == null) {
            return "";
        }
        if (s.equals("") || unFormat(s).length() != 6) {
            return s;
        }
        s = unFormat(s);
        final String yyyy = s.substring(0, 4);
        final String mm = s.substring(4, 6);
        return String.valueOf(yyyy) + "." + mm;
    }
    
    public static String formatDateTime(String s) {
        if (s == null) {
            return "";
        }
        if (s.equals("") || unFormat(s).length() < 12) {
            return s;
        }
        s = unFormat(s);
        final String yyyy = s.substring(0, 4);
        final String mm = s.substring(4, 6);
        final String dd = s.substring(6, 8);
        final String hour = s.substring(8, 10);
        final String min = s.substring(10, 12);
        return String.valueOf(yyyy) + "." + mm + "." + dd + " " + hour + ":" + min;
    }
    
    public static String formatTime(String s) {
        if (s == null) {
            return "";
        }
        if (s.equals("") || (unFormat(s).length() != 4 && unFormat(s).length() != 6)) {
            return s;
        }
        s = unFormat(s);
        final String hour = s.substring(0, 2);
        final String min = s.substring(2, 4);
        String sec = "";
        try {
            sec = s.substring(4, 6);
        }
        catch (final Exception ex) {}
        if (s.length() == 4) {
            return String.valueOf(hour) + ":" + min;
        }
        if (s.length() == 6) {
            return String.valueOf(hour) + ":" + min + ":" + sec;
        }
        return s;
    }
    
    public static String formatNum(final String s) {
        if (s != null) {
            final DecimalFormat df = new DecimalFormat("#,###");
            String temp;
            try {
                temp = df.format(new Double(s));
            }
            catch (final NumberFormatException e) {
                temp = "";
            }
            return temp;
        }
        return "";
    }
    
    public static String formatDecimal(final String s) {
        if (s != null) {
            final DecimalFormat df = new DecimalFormat("#,###.#");
            String temp;
            try {
                temp = df.format(new Double(s));
            }
            catch (final NumberFormatException e) {
                temp = "";
            }
            return temp;
        }
        return "";
    }
    
    public static String formatDecimal(final String s, final int digit) {
        if (s != null) {
            DecimalFormat df = null;
            if (digit == 1) {
                df = new DecimalFormat("#,###.#");
            }
            else if (digit == 2) {
                df = new DecimalFormat("#,###.##");
            }
            else if (digit == 3) {
                df = new DecimalFormat("#,###.###");
            }
            else if (digit == 4) {
                df = new DecimalFormat("#,###.####");
            }
            else if (digit == 5) {
                df = new DecimalFormat("#,###.#####");
            }
            else if (digit == 6) {
                df = new DecimalFormat("#,###.######");
            }
            String temp;
            try {
                temp = df.format(new Double(s));
            }
            catch (final NumberFormatException e) {
                temp = "";
            }
            return temp;
        }
        return "";
    }
    
    public static String formatTelNo(String s) {
        if (s == null) {
            return "";
        }
        if (s.equals("") || unFormat(s).length() > 11) {
            return s;
        }
        s = unFormat(s);
        if (s.length() == 11) {
            final String fore = s.substring(0, 3);
            final String mid = s.substring(3, 7);
            final String rear = s.substring(7, 11);
            return String.valueOf(fore) + "-" + mid + "-" + rear;
        }
        if (s.length() == 10) {
            String fore = "";
            String mid = "";
            String rear = "";
            if (s.substring(0, 2) == "02") {
                fore = s.substring(0, 2);
                mid = s.substring(2, 6);
                rear = s.substring(6, 10);
            }
            else {
                fore = s.substring(0, 3);
                mid = s.substring(3, 6);
                rear = s.substring(6, 10);
            }
            return String.valueOf(fore) + "-" + mid + "-" + rear;
        }
        if (s.length() == 9) {
            String fore = "";
            String mid = "";
            String rear = "";
            if (s.substring(0, 2) == "02") {
                fore = s.substring(0, 2);
                mid = s.substring(2, 5);
                rear = s.substring(5, 9);
            }
            else {
                fore = s.substring(0, 3);
                mid = s.substring(3, 5);
                rear = s.substring(5, 9);
            }
            return String.valueOf(fore) + "-" + mid + "-" + rear;
        }
        return s;
    }
    
    public static String formatZipCode(String s) {
        if (s == null) {
            return "";
        }
        if (s.equals("") || unFormat(s).length() != 6) {
            return s;
        }
        s = unFormat(s);
        final String fore = s.substring(0, 3);
        final String mid = s.substring(3, 6);
        return String.valueOf(fore) + "-" + mid;
    }
    
    public static String formatBizRegNo(String s) {
        if (s == null) {
            return "";
        }
        if (s.equals("") || unFormat(s).length() != 10) {
            return s;
        }
        s = unFormat(s);
        final String fore = s.substring(0, 3);
        final String mid = s.substring(3, 5);
        final String rear = s.substring(5, 10);
        return String.valueOf(fore) + "-" + mid + "-" + rear;
    }
    
    public static String formatIDNo(String s) {
        if (s == null) {
            return "";
        }
        if (s.equals("") || unFormat(s).length() != 13) {
            return s;
        }
        s = unFormat(s);
        final String fore = s.substring(0, 6);
        final String rear = s.substring(6, 13);
        return String.valueOf(fore) + "-" + rear;
    }
    
    public static String formatIDNo(String s, final String hidden) {
        if (s == null) {
            return "";
        }
        if (s.equals("") || unFormat(s).length() != 13) {
            return s;
        }
        s = unFormat(s);
        final String fore = s.substring(0, 6);
        final String rear = s.substring(6, 13);
        if (hidden.equals("*")) {
            return String.valueOf(fore) + "-" + rear.substring(0, 1) + "******";
        }
        return String.valueOf(fore) + "-" + rear;
    }
    
    public static String formatCardNo(String s) {
        if (s == null) {
            return "";
        }
        s = unFormat(s);
        String fore = "";
        String mid = "";
        String mid2 = "";
        String rear = "";
        if (s.length() >= 10) {
            fore = s.substring(0, 4);
            mid = "";
            mid = s.substring(4, 6);
            for (int i = 6; i < 8; ++i) {
                mid = String.valueOf(mid) + "*";
            }
            mid2 = "";
            for (int i = 8; i < s.length() - 4; ++i) {
                mid2 = String.valueOf(mid2) + "*";
            }
            rear = s.substring(s.length() - 4, s.length());
        }
        else if (s.length() < 10) {
            fore = "?";
            mid = "?";
            for (int i = 0; i < s.length() - 4; ++i) {
                mid2 = String.valueOf(mid2) + "*";
            }
            rear = s.substring(s.length() - 4, s.length());
        }
        return String.valueOf(fore) + "-" + mid + "-" + mid2 + "-" + rear;
    }
    
    public static String formatCardNoNonStar(String s) {
        if (s == null) {
            return "";
        }
        s = unFormat(s);
        String one = "";
        String two = "";
        String three = "";
        String four = "";
        String returnValue = "";
        if (s.length() >= 12) {
            one = s.substring(0, 4);
            two = s.substring(4, 8);
            three = s.substring(8, 12);
            four = s.substring(12, s.length());
            returnValue = String.valueOf(one) + "-" + two + "-" + three + "-" + four;
        }
        else if (s.length() < 12) {
            one = s.substring(0, 4);
            two = s.substring(4, 8);
            three = s.substring(8, s.length());
            returnValue = String.valueOf(one) + "-" + two + "-" + three;
        }
        return returnValue;
    }
    
    public static String formatPassword(String s) {
        if (s == null) {
            return "";
        }
        s = unFormat(s);
        String rtnStr = "";
        for (int i = 0; i < s.length(); ++i) {
            rtnStr = String.valueOf(rtnStr) + "*";
        }
        return rtnStr;
    }
    
    public static String getBRStr(final String str) {
        if (str == null) {
            return "";
        }
        final StringBuffer out = new StringBuffer();
        final StringTokenizer st = new StringTokenizer(str.toString(), "\n");
        while (st.hasMoreTokens()) {
            out.append(String.valueOf(st.nextToken()) + "<br>");
        }
        return out.toString();
    }
    
    public static String getCheckDate(final String _str) {
        FormatUtil.checkSdf = new SimpleDateFormat("yyyyMMdd");
        final String newStr = getherDigit(_str);
        if (newStr != null && newStr.length() == 8) {
            final Calendar cal = Calendar.getInstance();
            cal.set(Integer.parseInt(newStr.substring(0, 4)), Integer.parseInt(newStr.substring(4, 6)) - 1, Integer.parseInt(newStr.substring(6, 8)));
            if (FormatUtil.checkSdf.format(cal.getTime()).equals(newStr)) {
                return _str;
            }
        }
        return "0";
    }
    
    public static String getCommaStr(final double value) {
        final DecimalFormat df = new DecimalFormat("#,###.###");
        String temp;
        try {
            temp = df.format(new Double(value));
        }
        catch (final NumberFormatException e) {
            temp = "";
        }
        return temp;
    }
    
    public static String getCommaStr(final float value) {
        final DecimalFormat df = new DecimalFormat("#,###.###");
        String temp;
        try {
            temp = df.format(new Float(value));
        }
        catch (final NumberFormatException e) {
            temp = "";
        }
        return temp;
    }
    
    public static String getCommaStr(final int value) {
        final DecimalFormat df = new DecimalFormat("#,###.###");
        String temp;
        try {
            temp = df.format(new Integer(value));
        }
        catch (final NumberFormatException e) {
            temp = "";
        }
        return temp;
    }
    
    public static String getCommaStr(final long value) {
        final DecimalFormat df = new DecimalFormat("#,###.###");
        String temp;
        try {
            temp = df.format(new Long(value));
        }
        catch (final NumberFormatException e) {
            temp = "";
        }
        return temp;
    }
    
    public static String getCommaStr(final String value) {
        if (value != null) {
            final DecimalFormat df = new DecimalFormat("#,###.###");
            String temp;
            try {
                temp = df.format(new Double(value));
            }
            catch (final NumberFormatException e) {
                temp = "";
            }
            return temp;
        }
        return "";
    }
    
    public static String getCommaStr2(final double value) {
        final DecimalFormat df = new DecimalFormat("#,###.#");
        String temp;
        try {
            temp = df.format(new Double(value));
        }
        catch (final NumberFormatException e) {
            temp = "";
        }
        return temp;
    }
    
    protected static ClassLoader getCurrentClassLoader(final Object defaultObject) {
        ClassLoader loader = Thread.currentThread().getContextClassLoader();
        if (loader == null) {
            loader = defaultObject.getClass().getClassLoader();
        }
        return loader;
    }
    
    public static String getDisplayString(final String bundleName, final String id, final Object[] params, final Locale locale) {
        String text = null;
        final ResourceBundle bundle = ResourceBundle.getBundle(bundleName, locale, getCurrentClassLoader(params));
        try {
            text = bundle.getString(id);
        }
        catch (final MissingResourceException e) {
            text = "!! key " + id + " not found !!";
        }
        if (params != null) {
            final MessageFormat mf = new MessageFormat(text, locale);
            text = mf.format(params, new StringBuffer(), null).toString();
        }
        return text;
    }
    
    public static String[] getDivBizNubmer(final String oriBizNubmer) {
        final String[] divOriNumber = { "", "", "" };
        if (oriBizNubmer == null || oriBizNubmer.equals("")) {
            return divOriNumber;
        }
        if (oriBizNubmer.length() != 10) {
            return divOriNumber;
        }
        divOriNumber[0] = oriBizNubmer.substring(0, 3);
        divOriNumber[1] = oriBizNubmer.substring(3, 5);
        divOriNumber[2] = oriBizNubmer.substring(5, 10);
        return divOriNumber;
    }
    
    public static String[] getDivEMailAddress(final String oriEMail) {
        final String[] divOriNumber = { "", "" };
        if (oriEMail == null || oriEMail.indexOf("@") < 0) {
            return divOriNumber;
        }
        divOriNumber[0] = oriEMail.substring(0, oriEMail.indexOf("@"));
        divOriNumber[1] = oriEMail.substring(oriEMail.indexOf("@") + 1, oriEMail.length());
        return divOriNumber;
    }
    
    public static String[] getDivJuminNubmer(final String oriJuminNubmer) {
        final String[] divJuminNubmer = { "", "" };
        if (oriJuminNubmer == null || oriJuminNubmer.equals("")) {
            return divJuminNubmer;
        }
        if (oriJuminNubmer.length() != 13) {
            return divJuminNubmer;
        }
        divJuminNubmer[0] = oriJuminNubmer.substring(0, 6);
        divJuminNubmer[1] = oriJuminNubmer.substring(6, 13);
        return divJuminNubmer;
    }
    
    public static String[] getDivTelephoneNumber(final String oriTelephoneNumber) {
        final String[] divPhoneNumber = { "", "", "" };
        if (oriTelephoneNumber == null || oriTelephoneNumber.equals("")) {
            return divPhoneNumber;
        }
        if (oriTelephoneNumber.length() < 9) {
            return divPhoneNumber;
        }
        if (oriTelephoneNumber.startsWith("02")) {
            divPhoneNumber[0] = "02";
            divPhoneNumber[1] = oriTelephoneNumber.substring(2, oriTelephoneNumber.length() - 4);
            divPhoneNumber[2] = oriTelephoneNumber.substring(oriTelephoneNumber.length() - 4, oriTelephoneNumber.length());
        }
        else {
            divPhoneNumber[0] = oriTelephoneNumber.substring(0, 3);
            divPhoneNumber[1] = oriTelephoneNumber.substring(3, oriTelephoneNumber.length() - 4);
            divPhoneNumber[2] = oriTelephoneNumber.substring(oriTelephoneNumber.length() - 4, oriTelephoneNumber.length());
        }
        return divPhoneNumber;
    }
    
    public static String[] getDivZipNubmer(final String oriZipNubmer) {
        final String[] divZipNubmer = { "", "" };
        if (oriZipNubmer == null || oriZipNubmer.equals("")) {
            return divZipNubmer;
        }
        if (oriZipNubmer.length() != 6) {
            return divZipNubmer;
        }
        divZipNubmer[0] = oriZipNubmer.substring(0, 3);
        divZipNubmer[1] = oriZipNubmer.substring(3, 6);
        return divZipNubmer;
    }
    
    public static String getherDigit(String _digitStr) {
        String returnStr = "";
        if (_digitStr != null) {
            _digitStr = _digitStr.trim();
            for (int i = 0; i < _digitStr.length(); ++i) {
                if (Character.isDigit(_digitStr.charAt(i))) {
                    returnStr = String.valueOf(returnStr) + _digitStr.charAt(i);
                }
            }
        }
        return returnStr;
    }
    
    public static String getMake2String(final String str) {
        if (str != null && str.length() == 1) {
            return "0" + str;
        }
        return str;
    }
    
    public static String getPostCodeStr(final String value) {
        try {
            return new String(String.valueOf(value.substring(0, 3)) + "-" + value.substring(3, 6));
        }
        catch (final Exception ex) {
            return value;
        }
    }
    
    public static String getReplaceStr(final String str) {
        if (str == null) {
            return "";
        }
        final StringBuffer out = new StringBuffer();
        final StringTokenizer st = new StringTokenizer(str.toString(), "\n");
        while (st.hasMoreTokens()) {
            out.append(String.valueOf(st.nextToken()) + ", ");
        }
        return out.toString();
    }
    
    public static String getReplaceStr(final String str, final String oldChar, final String newChar) {
        if (str == null) {
            return "";
        }
        final StringBuffer out = new StringBuffer();
        final StringTokenizer st = new StringTokenizer(str.toString(), oldChar);
        while (st.hasMoreTokens()) {
            out.append(String.valueOf(st.nextToken()) + newChar);
        }
        return out.toString();
    }
    
    public static String getSaupStr(final String value) {
        if (value != null) {
            try {
                return new String(String.valueOf(value.substring(0, 3)) + "-" + value.substring(3, 5) + "-" + value.substring(5, 10));
            }
            catch (final Exception ex) {
                return value;
            }
        }
        return "";
    }
    
    public static Date getSqlDateFormat(final String s) {
        try {
            return Date.valueOf(s);
        }
        catch (final Exception ex) {
            return null;
        }
    }
    
    public static String[] getStrArray(final String str, final String tokenStr) {
        if (str == null) {
            return new String[0];
        }
        final StringTokenizer st = new StringTokenizer(str.toString(), tokenStr);
        final String[] data = new String[st.countTokens()];
        int i = 0;
        while (st.hasMoreTokens()) {
            data[i] = st.nextToken();
            ++i;
        }
        return data;
    }
    
    public static String getTrim(final String value) {
        if (value != null) {
            return value.trim();
        }
        return "";
    }
    
    public static String getYear(final Date date) {
        if (date != null) {
            final DateFormat df = new SimpleDateFormat("yyyy");
            return df.format(date);
        }
        return "";
    }
    
    public static void main(final String[] args) {
        System.out.println("A1");
    }
    
    public static double round(double r, final int decimalPlace) {
        BigDecimal bd = new BigDecimal(r);
        bd = bd.setScale(decimalPlace, 4);
        r = bd.doubleValue();
        return r;
    }
    
    public static float round(float r, final int decimalPlace) {
        BigDecimal bd = new BigDecimal(r);
        bd = bd.setScale(decimalPlace, 4);
        r = bd.floatValue();
        return r;
    }
    
    public static String shortCutString(String str, final int limit) {
        if (str == null || limit < 4) {
            return str;
        }
        final int len = str.length();
        int cnt = 0;
        int index = 0;
        while (index < len && cnt < limit) {
            if (str.charAt(index++) < '\u0100') {
                ++cnt;
            }
            else {
                cnt += 2;
            }
        }
        if (index < len && limit >= cnt) {
            str = str.substring(0, index);
        }
        else if (index < len && limit < cnt) {
            str = String.valueOf(str.substring(0, index - 1)) + "..";
        }
        return str;
    }
    
    public static Date StrToDate(final String str) {
        if (str != null) {
            return Date.valueOf(str);
        }
        return null;
    }
    
    public static String unFormat(final String s) {
        return s.replace("-", "").replace(".", "").replace(":", "");
    }
    
    public static String unFormat(final String s, final String formatChar) {
        return s.replace(formatChar, "");
    }
    
    public static String unFormatNum(final String s) {
        return s.replace(",", "");
    }
    
    public static String toHtmlChr(final String _value) {
        try {
            if (_value.indexOf(38) != -1 || _value.indexOf(60) != -1 || _value.indexOf(62) != -1 || _value.indexOf(39) != -1 || _value.indexOf(34) != -1 || _value.indexOf(10) != -1) {
                final StringBuffer sb = new StringBuffer();
                for (int i = 0, j = _value.length(); i < j; ++i) {
                    final char c;
                    if ((c = _value.charAt(i)) == '&') {
                        sb.append("&amp;");
                    }
                    else if (c == '<') {
                        sb.append("&lt;");
                    }
                    else if (c == '>') {
                        sb.append("&gt;");
                    }
                    else if (c == '\'') {
                        sb.append("\\'");
                    }
                    else if (c == '\"') {
                        sb.append("&quot;");
                    }
                    else if (c == '\\') {
                        sb.append("\\\\");
                    }
                    else if (c == '\n') {
                        sb.append("<br>");
                    }
                    else {
                        sb.append(c);
                    }
                }
                return sb.toString();
            }
            return _value;
        }
        catch (final Exception ex) {
            return _value;
        }
    }
    
    public static String uni12To20(final String uni12) {
        if (uni12 == null) {
            return null;
        }
        final int len = uni12.length();
        final char[] out = new char[len];
        final byte[] ksc = new byte[2];
        for (int i = 0; i < len; ++i) {
            final char c = uni12.charAt(i);
            if (c < '\u3400' || '\u4dff' < c) {
                out[i] = c;
            }
            else if ('\u3d2e' <= c) {
                out[i] = '\ufffd';
            }
            else {
                try {
                    ksc[0] = (byte)((c - '\u3400') / 94 + 176);
                    ksc[1] = (byte)((c - '\u3400') % 94 + 161);
                    out[i] = new String(ksc, "KSC5601").charAt(0);
                }
                catch (final Exception ex) {
                    return null;
                }
            }
        }
        return new String(out);
    }
    
    public static String uni20To12(final String uni20) {
        if (uni20 == null) {
            return "";
        }
        final int len = uni20.length();
        final char[] out = new char[len];
        for (int i = 0; i < len; ++i) {
            final char c = uni20.charAt(i);
            if (c < '\uac00' || '\ud7a3' < c) {
                out[i] = c;
            }
            else {
                try {
                    final byte[] ksc = String.valueOf(c).getBytes("KSC5601");
                    if (ksc.length != 2) {
                        out[i] = '\ufffd';
                    }
                    else {
                        out[i] = (char)(13312 + ((ksc[0] & 0xFF) - 176) * 94 + (ksc[1] & 0xFF) - 161);
                    }
                }
                catch (final UnsupportedEncodingException ex) {
                    FormatUtil.logger.error("Fatal Error: KSC5601 encoding is not supported.");
                }
            }
        }
        return new String(out);
    }
}
