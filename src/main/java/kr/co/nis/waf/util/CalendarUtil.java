// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.util;

import java.util.Calendar;

public class CalendarUtil
{
    static String region;
    public static String[][] solarHolidays;
    
    public static String getAmPm(final String time) {
        final int hour = Integer.parseInt(time.substring(0, 2));
        String res;
        if (hour >= 12) {
            res = "PM";
        }
        else {
            res = "AM";
        }
        return res;
    }
    
    public static int getDate(final String date) {
        return Integer.parseInt(date.substring(6, 8));
    }
    
    public static String getDateOfInt(final int _year, final int _month, final int _day) {
        String strDate = Integer.toString(_year);
        strDate += "-";
        if (_month < 10) {
            strDate += "0";
        }
        strDate += Integer.toString(_month);
        strDate += "-";
        if (_day < 10) {
            strDate += "0";
        }
        strDate += Integer.toString(_day);
        return strDate;
    }
    
    public static int getDayOfWeek(final int _year, final int _month, final int _day) {
        final Calendar cal = Calendar.getInstance();
        cal.set(_year, _month - 1, _day);
        return cal.get(7);
    }
    
    public static String getEndDate(final String date) {
        final int year = getYear(date);
        final int month = getMonth(date);
        final int day = getDate(date);
        final int curDayOfWeek = getDayOfWeek(year, month, day);
        final int endTmp = 7 - curDayOfWeek;
        final Calendar tmpCalendar = Calendar.getInstance();
        tmpCalendar.set(year, month - 1, day);
        tmpCalendar.add(5, endTmp);
        String endDate = Integer.toString(tmpCalendar.get(1));
        if (tmpCalendar.get(2) + 1 < 10) {
            endDate += "0";
        }
        endDate += Integer.toString(tmpCalendar.get(2) + 1);
        if (tmpCalendar.get(5) < 10) {
            endDate += "0";
        }
        endDate += Integer.toString(tmpCalendar.get(5));
        return endDate;
    }
    
    public static int getFirstDayOfWeek(final int _year, final int _month) {
        final Calendar tmpCal = Calendar.getInstance();
        tmpCal.set(_year, _month - 1, 1);
        return tmpCal.get(7) - 1;
    }
    
    public static String[][] getHolidaies(String _region) {
        if (_region == null) {
            _region = "";
        }
        if (_region.equals("ko_KR")) {
            final String[][] holidaies = { { "11", "31", "45", "55", "66", "717", "815", "103", "1225" }, { "\uc2e0\uc815", "\uc0bc\uc77c\uc808", "\uc2dd\ubaa9\uc77c", "\uc5b4\ub9b0\uc774\ub0a0", "\ud604\ucda9\uc77c", "\uc81c\ud5cc\uc808", "\uad11\ubcf5\uc808", "\uac1c\ucc9c\uc808", "\uc131\ud0c4\uc808" } };
            return holidaies;
        }
        if (_region.equals("en_US")) {
            final String[][] holidaies = { { "" }, { "" } };
            return holidaies;
        }
        final String[][] holidaies = { { "" }, { "" } };
        return holidaies;
    }
    
    public static String getHour(final String time) {
        final int hour = Integer.parseInt(time.substring(0, 2));
        String ret_hour = null;
        if (hour > 12) {
            if (hour < 10) {
                ret_hour = "0" + Integer.toString(hour - 12);
            }
            else {
                ret_hour = Integer.toString(hour - 12);
            }
        }
        else if (hour < 10) {
            ret_hour = "0" + Integer.toString(hour);
        }
        else {
            ret_hour = time.substring(0, 2);
        }
        return ret_hour;
    }
    
    public static String getMinute(final String time) {
        return time.substring(2, 4);
    }
    
    public static String getMondayDate(final String date) {
        final int year = getYear(date);
        final int month = getMonth(date);
        final int day = getDate(date);
        final int curDayOfWeek = getDayOfWeek(year, month, day);
        int startTmp = 2 - curDayOfWeek;
        if (startTmp == 0) {
            return date;
        }
        if (startTmp > 0) {
            startTmp -= 7;
        }
        final Calendar tmpCalendar = Calendar.getInstance();
        tmpCalendar.set(year, month - 1, day);
        tmpCalendar.add(5, startTmp);
        String startDate = Integer.toString(tmpCalendar.get(1));
        if (tmpCalendar.get(2) + 1 < 10) {
            startDate += "0";
        }
        startDate += Integer.toString(tmpCalendar.get(2) + 1);
        if (tmpCalendar.get(5) < 10) {
            startDate += "0";
        }
        startDate += Integer.toString(tmpCalendar.get(5));
        return startDate;
    }
    
    public static int getMonth(final String date) {
        return Integer.parseInt(date.substring(4, 6));
    }
    
    public static int[][] getMonthDays(final String date) {
        final int[][] months = new int[6][7];
        int days = 1;
        final int year = getYear(date);
        final int month = getMonth(date);
        final int day = getDate(date);
        for (int i = getFirstDayOfWeek(year, month); i < 7; ++i) {
            months[0][i] = days;
            ++days;
        }
        for (int i = 1; i < 6; ++i) {
            for (int j = 0; j < 7 && days <= LastDateInMonth(year, month, day); ++days, ++j) {
                months[i][j] = days;
            }
        }
        return months;
    }
    
    public static String getNamesolarHoliday(final String date) {
        String res = null;
        for (int i = 0; i < CalendarUtil.solarHolidays[0].length; ++i) {
            if (CalendarUtil.solarHolidays[0][i].equals(date)) {
                res = CalendarUtil.solarHolidays[1][i];
                break;
            }
        }
        return res;
    }
    
    public static String getNextMonth(final String Date) {
        final int year = getYear(FormatUtil.deleteDash(Date));
        final int month = getMonth(FormatUtil.deleteDash(Date));
        String endDate = "";
        final Calendar tmpCalendar = Calendar.getInstance();
        tmpCalendar.set(year, month - 1, 1);
        tmpCalendar.add(2, 1);
        endDate = Integer.toString(tmpCalendar.get(1));
        endDate += "-";
        if (tmpCalendar.get(2) + 1 < 10) {
            endDate += "0";
        }
        endDate += Integer.toString(tmpCalendar.get(2) + 1);
        return endDate;
    }
    
    public static int getNumSeqWeek(final String date) {
        int seqWeek = 0;
        final int curDate = getDate(date);
        final int[][] month = getMonthDays(date);
        for (int i = 0; i < 6; ++i) {
            for (int j = 0; j < 7; ++j) {
                if (month[i][j] != 0 && month[i][j] == curDate) {
                    seqWeek = i + 1;
                }
            }
        }
        return seqWeek;
    }
    
    public static String getPrevMonth(final String Date) {
        final int year = getYear(FormatUtil.deleteDash(Date));
        final int month = getMonth(FormatUtil.deleteDash(Date));
        String endDate = "";
        final Calendar tmpCalendar = Calendar.getInstance();
        tmpCalendar.set(year, month - 1, 1);
        tmpCalendar.add(2, -1);
        endDate = Integer.toString(tmpCalendar.get(1));
        endDate += "-";
        if (tmpCalendar.get(2) + 1 < 10) {
            endDate += "0";
        }
        endDate += Integer.toString(tmpCalendar.get(2) + 1);
        return endDate;
    }
    
    public static String getSeqWeek(final String date) {
        int seqWeek = 0;
        final int curDate = getDate(date);
        final int[][] month = getMonthDays(date);
        for (int i = 0; i < 6; ++i) {
            for (int j = 0; j < 7; ++j) {
                if (month[i][j] != 0 && month[i][j] == curDate) {
                    seqWeek = i + 1;
                }
            }
        }
        switch (seqWeek) {
            case 1: {
                return "1";
            }
            case 2: {
                return "2";
            }
            case 3: {
                return "3";
            }
            case 4: {
                return "4";
            }
            case 5: {
                return "5";
            }
            case 6: {
                return "6";
            }
            default: {
                return "";
            }
        }
    }
    
    public static String getStartDate(final String date) {
        final int year = getYear(date);
        final int month = getMonth(date);
        final int day = getDate(date);
        final int curDayOfWeek = getDayOfWeek(year, month, day);
        final int startTmp = 1 - curDayOfWeek;
        final Calendar tmpCalendar = Calendar.getInstance();
        tmpCalendar.set(year, month - 1, day);
        tmpCalendar.add(5, startTmp);
        String startDate = Integer.toString(tmpCalendar.get(1));
        if (tmpCalendar.get(2) + 1 < 10) {
            startDate += "0";
        }
        startDate += Integer.toString(tmpCalendar.get(2) + 1);
        if (tmpCalendar.get(5) < 10) {
            startDate += "0";
        }
        startDate += Integer.toString(tmpCalendar.get(5));
        return startDate;
    }
    
    public static String getStrDayOfWeek(final int _year, final int _month, final int _day) {
        final int dayofweek = getDayOfWeek(_year, _month, _day);
        String res = null;
        switch (dayofweek) {
            case 1: {
                res = "Sun";
                break;
            }
            case 2: {
                res = "Mon";
                break;
            }
            case 3: {
                res = "Tue";
                break;
            }
            case 4: {
                res = "Wed";
                break;
            }
            case 5: {
                res = "Thu";
                break;
            }
            case 6: {
                res = "Fri";
                break;
            }
            case 7: {
                res = "Sat";
                break;
            }
            default: {
                res = null;
                break;
            }
        }
        return res;
    }
    
    public static String getSundayDate(final String date) {
        final int year = getYear(date);
        final int month = getMonth(date);
        final int day = getDate(date);
        final int curDayOfWeek = getDayOfWeek(year, month, day);
        int endTmp = 8 - curDayOfWeek;
        if (endTmp >= 7) {
            endTmp -= 7;
        }
        final Calendar tmpCalendar = Calendar.getInstance();
        tmpCalendar.set(year, month - 1, day);
        tmpCalendar.add(5, endTmp);
        String endDate = Integer.toString(tmpCalendar.get(1));
        if (tmpCalendar.get(2) + 1 < 10) {
            endDate += "0";
        }
        endDate += Integer.toString(tmpCalendar.get(2) + 1);
        if (tmpCalendar.get(5) < 10) {
            endDate += "0";
        }
        endDate += Integer.toString(tmpCalendar.get(5));
        return endDate;
    }
    
    public static String[] getWeekDate(final String date) {
        final String[] weekDays = new String[7];
        weekDays[0] = getMondayDate(date);
        weekDays[1] = getWeekDays(weekDays[0], 1);
        weekDays[2] = getWeekDays(weekDays[0], 2);
        weekDays[3] = getWeekDays(weekDays[0], 3);
        weekDays[4] = getWeekDays(weekDays[0], 4);
        weekDays[5] = getWeekDays(weekDays[0], 5);
        weekDays[6] = getWeekDays(weekDays[0], 6);
        return weekDays;
    }
    
    public static String getWeekDays(final String _date, final int _amount) {
        int year = Integer.parseInt(_date.substring(0, 4));
        int month = Integer.parseInt(_date.substring(4, 6));
        int day = Integer.parseInt(_date.substring(6, 8));
        final Calendar wCal = Calendar.getInstance();
        wCal.set(year, month - 1, day);
        wCal.add(5, _amount);
        year = wCal.get(1);
        month = wCal.get(2) + 1;
        day = wCal.get(5);
        String res = Integer.toString(year);
        if (month < 10) {
            res = res + "0" + Integer.toString(month);
        }
        else {
            res += Integer.toString(month);
        }
        if (day < 10) {
            res += "0";
        }
        res += Integer.toString(day);
        return res;
    }
    
    public static int getYear(final String date) {
        return Integer.parseInt(date.substring(0, 4));
    }
    
    public static boolean isSolarHoliday(final String date) {
        boolean res = false;
        for (int i = 0; i < CalendarUtil.solarHolidays[0].length; ++i) {
            if (CalendarUtil.solarHolidays[0][i].equals(date)) {
                res = true;
                break;
            }
        }
        return res;
    }
    
    public static int LastDateInMonth(final int _year, final int _month, final int _day) {
        final Calendar tmpCal = Calendar.getInstance();
        tmpCal.set(1, _year);
        tmpCal.set(2, _month);
        tmpCal.set(5, 0);
        return tmpCal.get(5);
    }
    
    public static String setDate(final int _year, final int _month, final int _day) {
        String res = Integer.toString(_year);
        if (_month < 10) {
            res += "0";
        }
        res += Integer.toString(_month);
        if (_day < 10) {
            res += "0";
        }
        res += Integer.toString(_day);
        return res;
    }
    
    static {
        CalendarUtil.region = "ko_KR";
        CalendarUtil.solarHolidays = getHolidaies(CalendarUtil.region);
    }
}
