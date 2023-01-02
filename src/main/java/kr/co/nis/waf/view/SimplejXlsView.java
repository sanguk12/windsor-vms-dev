// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.view;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import java.util.Enumeration;
import javax.servlet.ServletOutputStream;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.core.io.Resource;
import java.util.Locale;
import java.io.OutputStream;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import net.sf.jxls.transformer.XLSTransformer;
import java.net.URLEncoder;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.core.io.ResourceLoader;
import org.springframework.core.io.support.LocalizedResourceHelper;
import java.util.HashMap;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.view.AbstractView;

public class SimplejXlsView extends AbstractView
{
    private Log log;
    private static final String CONTENT_TYPE = "application/vnd.ms-excel";
    private static final String CONTENT_TYPE_X = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    
    public SimplejXlsView() {
        this.log = LogFactory.getLog((Class)this.getClass());
    }
    
    protected boolean generatesDownloadContent() {
        return true;
    }
    
    protected void renderMergedOutputModel(final Map model, final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        final String[] headerText = (String[]) model.get("headerText");
        final String templateFile = (String) model.get("templateFile");
        final String templateFilePath = (String) model.get("templateFilePath");
        final String templateExcelExtension = (String) model.get("templateExcelExtension");
        final String createExcelExtension = (String) model.get("createExcelExtension");
        final Map header = new HashMap();
        for (int i = 0; i < headerText.length; ++i) {
            header.put("header" + String.valueOf(i), headerText[i]);
        }
        model.putAll(header);
        this.exposeModelAsRequestAttributes(model, request);
        final LocalizedResourceHelper helper = new LocalizedResourceHelper((ResourceLoader)this.getApplicationContext());
        final Locale userLocale = RequestContextUtils.getLocale(request);
        final Resource resource = helper.findLocalizedResource(templateFilePath + templateFile + ".", templateExcelExtension, userLocale);
        final Map map = this.exposeRequestAttributesAsMap(request);
        String contentDisposition = "attachment; filename=";
        if (StringUtils.isNotEmpty((String)map.get("fileName"))) {
            contentDisposition = contentDisposition + URLEncoder.encode((String) map.get("fileName"), "UTF-8") + "." + createExcelExtension;
        }
        else {
            contentDisposition = contentDisposition + "simpleExcel." + createExcelExtension;
        }
        response.setHeader("Content-Disposition", contentDisposition);
        Workbook workbook;
        if (map != null) {
            workbook = new XLSTransformer().transformXLS(resource.getInputStream(), map);
        }
        else {
            workbook = (Workbook)new HSSFWorkbook();
            this.logger.debug((Object)"SimplejXlsView: Created Excel Workbook from scratch");
        }
        this.buildExcelDocument(model, workbook, request, response);
        if (createExcelExtension.equals("xlsx")) {
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        }
        else {
            response.setContentType("application/vnd.ms-excel");
        }
        final ServletOutputStream out = response.getOutputStream();
        workbook.write((OutputStream)out);
        out.flush();
    }
    
    protected Map exposeRequestAttributesAsMap(final HttpServletRequest request) throws Exception {
        final Map map = new HashMap();
        final Enumeration e = request.getAttributeNames();
        while (e.hasMoreElements()) {
            final String name = (String) e.nextElement();
            map.put(name, request.getAttribute(name));
        }
        return map;
    }
    
    protected void buildExcelDocument(final Map model, final Workbook workbook, final HttpServletRequest request, final HttpServletResponse response) throws Exception {
    }
    
    protected HSSFCell getCell(final HSSFSheet sheet, final int row, final int col) {
        HSSFRow sheetRow = sheet.getRow(row);
        if (sheetRow == null) {
            sheetRow = sheet.createRow(row);
        }
        HSSFCell cell = sheetRow.getCell((short)col);
        if (cell == null) {
            cell = sheetRow.createCell((short)col);
        }
        return cell;
    }
    
    protected void setText(final HSSFCell cell, final String text) {
        cell.setCellType(1);
        cell.setCellValue(text);
    }
}
