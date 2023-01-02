// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.view;

import java.util.List;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.logging.Log;

public class SimpleDoc
{
    protected final Log logger;
    private final int PAPER_LANDSCAPE = 1;
    private final int PAPER_PORTRAIT = 2;
    private ModelAndView mav;
    
    public SimpleDoc(String docType) {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.mav = null;
        docType = docType.toLowerCase();
        if (docType.equals("pdf")) {
            this.mav = new ModelAndView("simplePdfLandscapeView");
        }
        else if (docType.equals("excel")) {
            this.mav = new ModelAndView("simpleExcelView");
        }
        else if (docType.equals("jxls")) {
            this.mav = new ModelAndView("simplejXlsView");
        }
        else if (docType.equals("xml")) {
            this.mav = new ModelAndView("simpleXmlView");
        }
        else if (docType.equals("csv")) {
            this.mav = new ModelAndView("simpleCsvView");
        }
        else if (docType.equals("text")) {
            this.mav = new ModelAndView("simpleTextView");
        }
        else if (docType.equals("json")) {
            this.mav = new ModelAndView("simpleJsonView");
        }
    }
    
    public SimpleDoc(String docType, final int paperDirection) {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.mav = null;
        docType = docType.toLowerCase();
        if (docType.equals("pdf")) {
            if (paperDirection == 1) {
                this.mav = new ModelAndView("simplePdfLandscapeView");
            }
            else if (paperDirection == 2) {
                this.mav = new ModelAndView("simplePdfPortraitView");
            }
            else if (docType.equals("excel")) {
                this.mav = new ModelAndView("simpleExcelView");
            }
            else if (docType.equals("jxls")) {
                this.mav = new ModelAndView("simplejXlsView");
            }
            else if (docType.equals("xml")) {
                this.mav = new ModelAndView("simpleXmlView");
            }
            else if (docType.equals("csv")) {
                this.mav = new ModelAndView("simpleCsvView");
            }
            else if (docType.equals("text")) {
                this.mav = new ModelAndView("simpleTextView");
            }
            else if (docType.equals("json")) {
                this.mav = new ModelAndView("simpleJsonView");
            }
        }
    }
    
    public SimpleDoc(String docType, final List data) {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.mav = null;
        docType = docType.toLowerCase();
        if (docType.equals("pdf")) {
            this.mav = new ModelAndView("simplePdfLandscapeView");
        }
        else if (docType.equals("excel")) {
            this.mav = new ModelAndView("simpleExcelView");
        }
        else if (docType.equals("jxls")) {
            this.mav = new ModelAndView("simplejXlsView");
        }
        else if (docType.equals("xml")) {
            this.mav = new ModelAndView("simpleXmlView");
        }
        else if (docType.equals("csv")) {
            this.mav = new ModelAndView("simpleCsvView");
        }
        else if (docType.equals("text")) {
            this.mav = new ModelAndView("simpleTextView");
        }
        else if (docType.equals("json")) {
            this.mav = new ModelAndView("simpleJsonView");
        }
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)data);
        }
        this.mav.addObject("data", (Object)data);
    }
    
    public SimpleDoc(String docType, final int paperDirection, final List data) {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.mav = null;
        docType = docType.toLowerCase();
        if (docType.equals("pdf")) {
            if (paperDirection == 1) {
                this.mav = new ModelAndView("simplePdfLandscapeView");
            }
            else if (paperDirection == 2) {
                this.mav = new ModelAndView("simplePdfPortraitView");
            }
            else if (docType.equals("excel")) {
                this.mav = new ModelAndView("simpleExcelView");
            }
            else if (docType.equals("jxls")) {
                this.mav = new ModelAndView("simplejXlsView");
            }
            else if (docType.equals("xml")) {
                this.mav = new ModelAndView("simpleXmlView");
            }
            else if (docType.equals("csv")) {
                this.mav = new ModelAndView("simpleCsvView");
            }
            else if (docType.equals("text")) {
                this.mav = new ModelAndView("simpleTextView");
            }
            else if (docType.equals("json")) {
                this.mav = new ModelAndView("simpleJsonView");
            }
        }
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)data);
        }
        this.mav.addObject("data", (Object)data);
    }
    
    public SimpleDoc(String docType, final String title, final int[] columnWidth, final List data) {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.mav = null;
        docType = docType.toLowerCase();
        if (docType.equals("pdf")) {
            this.mav = new ModelAndView("simplePdfLanscapeView");
        }
        else if (docType.equals("excel")) {
            this.mav = new ModelAndView("simpleExcelView");
        }
        this.mav.addObject("title", (Object)title);
        this.mav.addObject("columnWidth", (Object)columnWidth);
        this.mav.addObject("data", (Object)data);
    }
    
    public SimpleDoc(String docType, final String title, final int[] columnWidth, final int paperDirection, final List data) {
        this.logger = LogFactory.getLog((Class)this.getClass());
        this.mav = null;
        docType = docType.toLowerCase();
        if (docType.equals("pdf")) {
            if (paperDirection == 1) {
                this.mav = new ModelAndView("simplePdfLandscapeView");
            }
            else if (paperDirection == 2) {
                this.mav = new ModelAndView("simplePdfPortraitView");
            }
            else if (docType.equals("excel")) {
                this.mav = new ModelAndView("simpleExcelView");
            }
            else if (docType.equals("jxls")) {
                this.mav = new ModelAndView("simplejXlsView");
            }
        }
        this.mav.addObject("title", (Object)title);
        this.mav.addObject("columnWidth", (Object)columnWidth);
        this.mav.addObject("data", (Object)data);
    }
    
    public ModelAndView create() {
        return this.mav;
    }
    
    public void setTitle(final String title) {
        this.mav.addObject("title", (Object)title);
    }
    
    public void setColumnWidth(final int[] columnwidth) {
        this.mav.addObject("columnWidth", (Object)columnwidth);
    }
    
    public void setHeaderText(final String[] headerText) {
        this.mav.addObject("headerText", (Object)headerText);
    }
    
    public void setHeaderText(final String headerText) {
        this.mav.addObject("headerText", (Object)headerText);
    }
    
    public void setData(final List data) {
        this.mav.addObject("data", (Object)data);
    }
    
    public void setDataType(final String[] dataType) {
        this.mav.addObject("dataType", (Object)dataType);
    }
    
    public void setFileName(final String fileName) {
        this.mav.addObject("fileName", (Object)fileName);
    }
    
    public void setFormat(final String[] format) {
        this.mav.addObject("format", (Object)format);
    }
    
    public void setTemplateFile(final String templateFile) {
        this.mav.addObject("templateFile", (Object)templateFile);
    }
    
    public void setTemplateFilePath(final String templateFilePath) {
        this.mav.addObject("templateFilePath", (Object)templateFilePath);
    }
    
    public void setTemplateExcelExtension(final String templateExcelExtension) {
        this.mav.addObject("templateExcelExtension", (Object)templateExcelExtension);
    }
    
    public void setCreateExcelExtension(final String createExcelExtension) {
        this.mav.addObject("createExcelExtension", (Object)createExcelExtension);
    }
}
