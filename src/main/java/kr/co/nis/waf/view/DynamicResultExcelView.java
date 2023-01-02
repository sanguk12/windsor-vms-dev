// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.view;

import org.apache.poi.hssf.usermodel.HSSFCell;
import java.util.Iterator;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import kr.co.nis.waf.util.StringUtil;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import java.util.Map;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class DynamicResultExcelView extends AbstractExcelView
{
    protected final Log logger;
    
    public DynamicResultExcelView() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    protected void buildExcelDocument(final Map model, final HSSFWorkbook wb, final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        try {
            final HSSFSheet sheet = wb.createSheet("Sheet1");
            sheet.setDefaultColumnWidth((short)12);
            final List<Map> data = (List) model.get("data");
            final String[] headerText = (String[]) model.get("headerText");
            final String[] dataType = (String[]) model.get("dataType");
            String fileName = (String) model.get("fileName");
            if (data.size() > 0) {
                final Iterator header = data.get(0).keySet().iterator();
                final String[] messagekey = new String[data.get(0).keySet().size()];
                int keyindex = 0;
                while (header.hasNext()) {
                    messagekey[keyindex++] = header.next().toString();
                    final HSSFCell cell = this.getCell(sheet, 0, keyindex - 1);
                    this.setText(cell, messagekey[keyindex - 1]);
                }
                Map resultSet = null;
                for (int i = 0; i < data.size(); ++i) {
                    resultSet = data.get(i);
                    for (keyindex = 0; keyindex < messagekey.length; ++keyindex) {
                        final HSSFCell cell2 = this.getCell(sheet, i + 1, keyindex);
                        if (dataType != null && dataType.length != 0) {
                            if (dataType[keyindex].equals("numeric") || dataType[keyindex].equals("n")) {
                                cell2.setCellType(0);
                                if ("".equals(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex]))) || StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])) == null) {
                                    cell2.setCellValue(Double.parseDouble("0"));
                                }
                                else {
                                    cell2.setCellValue(Double.parseDouble(StringUtil.unFormatNum(resultSet.get(messagekey[keyindex]).toString())));
                                }
                            }
                            else if (dataType[keyindex].equals("string") || dataType[keyindex].equals("s")) {
                                cell2.setCellType(1);
                                this.setText(cell2, StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])));
                            }
                        }
                        else if (StringUtil.NumberCheck(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])).toString())) {
                            cell2.setCellType(0);
                            cell2.setCellValue(Double.parseDouble(StringUtil.unFormatNum(resultSet.get(messagekey[keyindex]).toString())));
                        }
                        else {
                            this.setText(cell2, StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])));
                        }
                    }
                }
                final String strClient = request.getHeader("user-agent");
                if ("".equals(fileName) || fileName == null) {
                    fileName = "Excel";
                }
                if (strClient.indexOf("MSIE 5.5") != -1) {
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
                    response.setHeader("Content-Description", "JSP Generated Data");
                }
                else {
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xls");
                    response.setHeader("Content-Description", "JSP Generated Data");
                }
            }
            else {
                if (headerText != null) {
                    if (headerText.length != 0) {
                        for (int j = 0; j < headerText.length; ++j) {
                            final HSSFCell cell3 = this.getCell(sheet, 0, j);
                            this.setText(cell3, headerText[j]);
                        }
                    }
                }
                final String strClient2 = request.getHeader("user-agent");
                if ("".equals(fileName) || fileName == null) {
                    fileName = "Excel";
                }
                if (strClient2.indexOf("MSIE 5.5") != -1) {
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
                    response.setHeader("Content-Description", "JSP Generated Data");
                }
                else {
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xls");
                    response.setHeader("Content-Description", "JSP Generated Data");
                }
            }
        }
        catch (final Exception e) {
            if (this.logger.isDebugEnabled()) {
                e.printStackTrace();
            }
        }
    }
}
