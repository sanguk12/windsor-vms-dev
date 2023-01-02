// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.view;

import java.util.Iterator;
import com.lowagie.text.Paragraph;
import kr.co.nis.waf.util.StringUtil;
import org.springframework.context.NoSuchMessageException;
import java.util.List;
import java.awt.Color;
import com.lowagie.text.Element;
import com.lowagie.text.Cell;
import com.lowagie.text.Phrase;
import com.lowagie.text.Table;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import com.lowagie.text.pdf.PdfWriter;
import java.util.Map;
import com.lowagie.text.PageSize;
import com.lowagie.text.Document;
import org.apache.commons.logging.LogFactory;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.view.document.AbstractPdfView;

public class SimplePdfLandscapeView extends AbstractPdfView
{
    protected final Log logger;
    private BaseFont bf;
    private Font font;
    
    public SimplePdfLandscapeView() {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.bf = null;
        this.font = null;
    }
    
    protected Document newDocument() {
        final Document doc = new Document(PageSize.A4.rotate(), 50.0f, 50.0f, 50.0f, 50.0f);
        return doc;
    }
    
    protected void buildPdfDocument(final Map model, final Document doc, final PdfWriter writer, final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        try {
            this.bf = BaseFont.createFont("HYGoThic-Medium", "UniKS-UCS2-H", false);
            this.font = new Font(this.bf, 10.0f, 0);
            final int[] headerwidths = (int[]) model.get("columnWidth");
            final Table datatable = new Table(headerwidths.length);
            datatable.setWidths(headerwidths);
            datatable.setWidth(100.0f);
            datatable.setPadding(3.0f);
            final Cell cell = new Cell((Element)new Phrase(model.get("title").toString(), new Font(this.bf, 20.0f, 0)));
            cell.setHorizontalAlignment(1);
            cell.setLeading(30.0f);
            cell.setColspan(headerwidths.length);
            cell.setBorder(0);
            cell.setBackgroundColor(new Color(192, 192, 192));
            datatable.addCell(cell);
            final List<Map> data = (List<Map>)model.get("data");
            datatable.getDefaultLayout().setBorderWidth(2.0f);
            datatable.getDefaultLayout().setHorizontalAlignment(1);
            final String[] headerText = (String[]) model.get("headerText");
            final Iterator header = data.get(0).keySet().iterator();
            final String[] messagekey = new String[data.get(0).keySet().size()];
            int keyindex = 0;
            while (header.hasNext()) {
                messagekey[keyindex++] = header.next().toString();
                if (headerText != null && headerText.length != 0) {
                    if (!headerText[0].equals("")) {
                        datatable.addCell(new Phrase(headerText[keyindex - 1], this.font));
                        continue;
                    }
                }
                try {
                    datatable.addCell(new Phrase(this.getMessageSourceAccessor().getMessage(messagekey[keyindex - 1]), this.font));
                }
                catch (final NoSuchMessageException e) {
                    datatable.addCell(new Phrase(messagekey[keyindex - 1], this.font));
                }
            }
            datatable.endHeaders();
            datatable.getDefaultLayout().setBorderWidth(1.0f);
            Map resultSet = null;
            for (int i = 0; i < data.size(); ++i) {
                resultSet = data.get(i);
                datatable.getDefaultLayout().setHorizontalAlignment(1);
                if (i % 2 == 0) {
                    datatable.getDefaultLayout().setGrayFill(0.9f);
                }
                for (keyindex = 0; keyindex < messagekey.length; ++keyindex) {
                    datatable.addCell(new Phrase(StringUtil.nullToBlank(resultSet.get(messagekey[keyindex])), this.font));
                }
                if (i % 2 == 0) {
                    datatable.getDefaultLayout().setGrayFill(1.0f);
                }
            }
            doc.add((Element)new Paragraph(this.getMessageSourceAccessor().getMessage("paper.header.title")));
            doc.add((Element)datatable);
        }
        catch (final Exception e2) {
            if (this.logger.isDebugEnabled()) {
                e2.printStackTrace();
            }
        }
    }
}
