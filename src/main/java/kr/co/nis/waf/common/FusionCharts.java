// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.http.HttpServletResponse;

public class FusionCharts
{
    public String encodeDataURL(String strDataURL, final String addNoCacheStr, final HttpServletResponse response) {
        String encodedURL = strDataURL;
        if (addNoCacheStr.equals("true")) {
            final Calendar nowCal = Calendar.getInstance();
            final Date now = nowCal.getTime();
            final SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH_mm_ss a");
            final String strNow = sdf.format(now);
            if (strDataURL.indexOf("?") > 0) {
                encodedURL = strDataURL + "&FCCurrTime=" + strNow;
            }
            else {
                strDataURL = strDataURL + "?FCCurrTime=" + strNow;
            }
            encodedURL = response.encodeURL(strDataURL);
        }
        return encodedURL;
    }
    
    public String createChart(final String chartSWF, final String strURL, final String strXML, final String chartId, final int chartWidth, final int chartHeight, final boolean debugMode, final boolean registerWithJS) {
        final StringBuffer strBuf = new StringBuffer();
        strBuf.append("<!--START Script Block for Chart -->\n");
        strBuf.append("\t\t<div id='" + chartId + "Div' align='center'>\n");
        strBuf.append("\t\t\t\tChart.\n");
        strBuf.append("\t\t</div>\n");
        strBuf.append("\t\t<script type='text/javascript'>\n");
        final Boolean registerWithJSBool = new Boolean(registerWithJS);
        final Boolean debugModeBool = new Boolean(debugMode);
        final int regWithJSInt = this.boolToNum(registerWithJSBool);
        final int debugModeInt = this.boolToNum(debugModeBool);
        strBuf.append("\t\t\t\tvar chart_" + chartId + " = new FusionCharts('" + chartSWF + "', '" + chartId + "', '" + chartWidth + "', '" + chartHeight + "', '" + debugModeInt + "', '" + regWithJSInt + "');\n");
        if (strXML.equals("")) {
            strBuf.append("\t\t\t\t//Set the dataURL of the chart\n");
            strBuf.append("\t\t\t\tchart_" + chartId + ".setDataURL(\"" + strURL + "\");\n");
        }
        else {
            strBuf.append("\t\t\t\t//Provide entire XML data using dataXML method\n");
            strBuf.append("\t\t\t\tchart_" + chartId + ".setDataXML(\"" + strXML + "\");\n");
        }
        strBuf.append("\t\t\t\t//Finally, render the chart.\n");
        strBuf.append("\t\t\t\tchart_" + chartId + ".render(\"" + chartId + "Div\");\n");
        strBuf.append("\t\t</script>\n");
        strBuf.append("\t\t<!--END Script Block for Chart-->\n");
        return strBuf.substring(0);
    }
    
    public String createChartHTML(final String chartSWF, final String strURL, final String strXML, final String chartId, final int chartWidth, final int chartHeight, final boolean debugMode) {
        String strFlashVars = "";
        final Boolean debugModeBool = new Boolean(debugMode);
        if (strXML.equals("")) {
            strFlashVars = "chartWidth=" + chartWidth + "&chartHeight=" + chartHeight + "&debugMode=" + this.boolToNum(debugModeBool) + "&dataURL=" + strURL + "";
        }
        else {
            strFlashVars = "chartWidth=" + chartWidth + "&chartHeight=" + chartHeight + "&debugMode=" + this.boolToNum(debugModeBool) + "&dataXML=" + strXML + "";
        }
        final StringBuffer strBuf = new StringBuffer();
        strBuf.append("\t\t<!--START Code Block for Chart-->\n");
        strBuf.append("\t\t\t\t<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='" + chartWidth + "' height='" + chartHeight + "' id='" + chartId + "'>\n");
        strBuf.append("\t\t\t\t\t<param name='allowScriptAccess' value='always' />\n");
        strBuf.append("\t\t\t\t\t<param name='movie' value='" + chartSWF + "'/>\n");
        strBuf.append("\t\t\t\t<param name='FlashVars' value=\"" + strFlashVars + "\" />\n");
        strBuf.append("\t\t\t\t\t<param name='quality' value='high' />\n");
        strBuf.append("\t\t\t\t<embed src='" + chartSWF + "' FlashVars=\"" + strFlashVars + "\" quality='high' width='" + chartWidth + "' height='" + chartHeight + "' name='" + chartId + "' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />\n");
        strBuf.append("\t\t</object>\n");
        strBuf.append("\t\t<!--END Code Block for Chart-->\n");
        return strBuf.substring(0);
    }
    
    public int boolToNum(final Boolean bool) {
        int num = 0;
        if (bool) {
            num = 1;
        }
        return num;
    }
}
