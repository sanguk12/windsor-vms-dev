// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.util;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.ByteArrayOutputStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat;

public class StringUtil
{
    public static String convertHtmlBr(final String comment) {
        if (comment == null) {
            return "";
        }
        final int length = comment.length();
        final StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < length; ++i) {
            String tmp = comment.substring(i, i + 1);
            if ("\r".compareTo(tmp) == 0) {
                tmp = comment.substring(++i, i + 1);
                if ("\n".compareTo(tmp) == 0) {
                    buffer.append("<br>\r");
                }
                else {
                    buffer.append("\r");
                }
            }
            buffer.append(tmp);
        }
        return buffer.toString();
    }
    
    public static String nowDate(final String format) {
        final SimpleDateFormat sdf = new SimpleDateFormat(format);
        final String result = sdf.format(new Date());
        return result;
    }
    
    public static String nowTime() {
        return nowTime(":");
    }
    
    public static String nowTime(final String div) {
        final Calendar cal = Calendar.getInstance();
        DateFormat df = null;
        df = new SimpleDateFormat("HH");
        final String hh = df.format(cal.getTime());
        df = new SimpleDateFormat("mm");
        String mm = df.format(cal.getTime());
        mm = new StringBuilder(String.valueOf(Integer.parseInt(mm))).toString();
        df = new SimpleDateFormat("ss");
        String ss = df.format(cal.getTime());
        ss = new StringBuilder(String.valueOf(Integer.parseInt(ss))).toString();
        return String.valueOf(hh) + div + mm + div + ss;
    }
    
    public static String nullToBlank(final Object o) {
        return nullToBlank(o, "");
    }
    
    public static String nullToBlank(final Object o, final String returnValue) {
        if (o == null) {
            return returnValue;
        }
        return new StringBuilder().append(o).toString();
    }
    
    public static String nullToBlank(final String s) {
        return nullToBlank(s, "");
    }
    
    public static String nullToBlank(final String s, final String returnValue) {
        if (s == null || s.length() == 0) {
            return returnValue;
        }
        return s.trim();
    }
    
    public static int nullToZero(final String s) {
        return nullToZero(s, 0);
    }
    
    public static int nullToZero(final String s, final int returnValue) {
        int result = 0;
        try {
            if (s == null || s.length() == 0) {
                result = returnValue;
            }
            else {
                result = Integer.parseInt(s);
            }
        }
        catch (final Exception e) {
            result = 0;
        }
        return result;
    }
    
    public static boolean NumberCheck(final String s) {
        boolean returnCheck = false;
        if (s == null || s.equals("")) {
            returnCheck = false;
        }
        else {
            final Pattern pattern = Pattern.compile("[0-9,.-]");
            final Matcher matcher = pattern.matcher(s);
            final String input = s;
            String output = "";
            final int index = s.indexOf("-");
            final String[] minusChk = s.split("-");
            final String[] dotChk = s.split(".");
            while (matcher.find()) {
                output = String.valueOf(output) + matcher.group();
            }
            returnCheck = ((s.length() != 2 || !".".equals(s.substring(0, 1)) || !".".equals(s.substring(1, 2)) || output.length() != input.length() || minusChk.length - 1 > 1 || index > 0 || dotChk.length - 1 > 1) && (s.length() != 2 || !"-".equals(s.substring(0, 1)) || !"-".equals(s.substring(1, 2)) || output.length() != input.length() || minusChk.length - 1 > 1 || index > 0 || dotChk.length - 1 > 1) && (output.length() == input.length() && minusChk.length - 1 <= 1 && index <= 0 && dotChk.length - 1 <= 1));
        }
        return returnCheck;
    }
    
    public static boolean NumberCheck(final String s, final String numType) {
        boolean returnCheck = false;
        if (s == null || s.equals("")) {
            returnCheck = false;
        }
        else {
            final Pattern pattern = Pattern.compile(numType);
            final Matcher matcher = pattern.matcher(s);
            final String input = s;
            String output = "";
            final int index = s.indexOf("-");
            final String[] minusChk = s.split("-");
            final String[] dotChk = s.split(".");
            while (matcher.find()) {
                output = String.valueOf(output) + matcher.group();
            }
            returnCheck = ((s.length() != 2 || !".".equals(s.substring(0, 1)) || !".".equals(s.substring(1, 2)) || output.length() != input.length() || minusChk.length - 1 > 1 || index > 0 || dotChk.length - 1 > 1) && (s.length() != 2 || !"-".equals(s.substring(0, 1)) || !"-".equals(s.substring(1, 2)) || output.length() != input.length() || minusChk.length - 1 > 1 || index > 0 || dotChk.length - 1 > 1) && (output.length() == input.length() && minusChk.length - 1 <= 1 && index <= 0 && dotChk.length - 1 <= 1));
        }
        return returnCheck;
    }
    
    public static String replaceTagSymbolToHTML(final String s) {
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("!", "&#33;");
    }
    
    public static String stackTraceToString(final Throwable ex) {
        final ByteArrayOutputStream b = new ByteArrayOutputStream();
        final PrintStream p = new PrintStream(b);
        ex.printStackTrace(p);
        p.close();
        final String stackTrace = b.toString();
        try {
            b.close();
        }
        catch (final IOException e) {
            e.printStackTrace();
        }
        return convertHtmlBr(stackTrace);
    }
    
    public static String unFormat(final String s) {
        return s.replace("-", "").replace(".", "").replace(":", "").replace("/", "");
    }
    
    public static String unFormat(final String s, final String formatChar) {
        return s.replace(formatChar, "");
    }
    
    public static String unFormatNum(final String s) {
        return s.replace(",", "");
    }
    
    public static String[] divideHanStr(final String org, final int len0) {
        final String[] results = new String[2];
        if (org == null || org.equals("")) {
            results[1] = (results[0] = "");
            return results;
        }
        final int charLen = org.length();
        final int byteLen = org.getBytes().length;
        if (byteLen <= len0 || len0 < 0) {
            results[0] = org;
            results[1] = "";
            return results;
        }
        int charIdx = 0;
        final char[] chars = org.toCharArray();
        final StringBuffer sbuf1 = new StringBuffer();
        for (int i = 0; i < len0; ++i) {
            sbuf1.append(chars[i]);
            final int len = sbuf1.toString().getBytes().length;
            if (len > len0) {
                sbuf1.deleteCharAt(i);
                break;
            }
            charIdx = i + 1;
        }
        results[0] = sbuf1.toString();
        final StringBuffer sbuf2 = new StringBuffer();
        for (int j = charIdx; j < charLen; ++j) {
            sbuf2.append(chars[j]);
        }
        results[1] = sbuf2.toString();
        return results;
    }
    
    public static String[] divideStr(final String org, final int len0) {
        final String[] results = new String[2];
        if (org == null || org.equals("")) {
            results[1] = (results[0] = "");
            return results;
        }
        final byte[] orgBytes = org.getBytes();
        final int orgLen = orgBytes.length;
        if (orgLen <= len0 || len0 < 0) {
            results[0] = org;
            results[1] = "";
            return results;
        }
        final byte[] bytes0 = new byte[len0];
        for (int i = 0; i < len0; ++i) {
            bytes0[i] = orgBytes[i];
        }
        results[0] = new String(bytes0);
        final int len = orgLen - len0;
        final byte[] bytes2 = new byte[len];
        for (int j = len0; j < orgLen; ++j) {
            bytes2[j - len0] = orgBytes[j];
        }
        results[1] = new String(bytes2);
        return results;
    }
    
    public static boolean checkPatternNum(final String str) {
        boolean okPattern = false;
        final String regex = ".*\\d.*";
        okPattern = str.matches(regex);
        return okPattern;
    }
    
    public static boolean checkPatternUpperCase(final String str) {
        boolean okPattern = false;
        final String regex = ".*\\p{Upper}.*";
        okPattern = str.matches(regex);
        return okPattern;
    }
    
    public static boolean checkPatternLowerCase(final String str) {
        boolean okPattern = false;
        final String regex = ".*\\p{Lower}.*";
        okPattern = str.matches(regex);
        return okPattern;
    }
    
    public static boolean checkPatternSpecialLetters(final String str) {
        boolean okPattern = false;
        final String regex = ".*\\p{Punct}.*";
        okPattern = str.matches(regex);
        return okPattern;
    }
}
