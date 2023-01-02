// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import org.springframework.web.bind.annotation.RequestMapping;
import java.util.Enumeration;
import java.util.List;
import kr.co.nis.waf.view.SimpleDoc;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.PathVariable;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.LogFactory;
import javax.annotation.Resource;
import kr.co.nis.waf.dao.SimpleService;
import org.springframework.beans.factory.annotation.Value;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Controller;

@Controller
public class SimpleActionNoSessionController extends WafMultiActionController
{
    protected final Log logger;
    private static final int PAPER_LANDSCAPE = 1;
    private static final int PAPER_PORTRAIT = 2;
//    @Value("#{system['jXls.templateFilePath']}")
//    private String templateFilePath;
    @Value("#{system['jXls.templateExcelExtension']}")
    private String templateExcelExtension;
    @Value("#{system['jXls.createExcelExtension']}")
    private String createExcelExtension;
    @Resource
    private SimpleService simpleService;
    
    public SimpleActionNoSessionController() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    @RequestMapping({ "/service/simpleActionNoS/{queryKey}" })
    public ModelAndView defaultAction(final HttpServletRequest request, final HttpServletResponse response, @PathVariable final String queryKey) throws Exception {
        String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
        String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");

        final Map command = new HashMap();
        List list = null;
        Map map = null;
        final Map message = new HashMap();
        this.bind(request, command);
        this.logger.debug((Object)"*************SIMPLEACTIONNOS IN************");
        String actionKey = "search";
        try {
            actionKey = (String) command.get("actionKey");
            if (actionKey == null) {
                actionKey = "search";
            }
        }
        catch (final Exception ex) {}
        try {
            if (command.get("queryKey").toString().equals("")) {
                command.put("queryKey", queryKey);
            }
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("queryKey=" + queryKey));
            }
        }
        catch (final Exception e) {
            command.put("queryKey", queryKey);
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("queryKey=" + queryKey));
            }
        }
        String resultURL = "";
        try {
            resultURL = (String) command.get("resultURL");
            if (resultURL == null) {
                resultURL = "";
            }
        }
        catch (final Exception ex2) {}
        String resultType = "XML";
        try {
            resultType = (String) command.get("resultType");
            if (resultType == null) {
                resultType = "XML";
            }
        }
        catch (final Exception ex3) {}
        String[] outParamKey = null;
        try {
            outParamKey = command.get("outParamKey").toString().split(";");
        }
        catch (final Exception ex4) {}
        final ModelAndView mav = new ModelAndView(resultURL);
        if (actionKey.equals("search")) {
            if (resultType.equals("List")) {
                list = this.simpleService.queryForList(command);
                mav.addObject("resultList", (Object)list);
            }
            else if (resultType.equals("Map")) {
                map = this.simpleService.queryForMap(command);
                mav.addObject("resultMap", (Object)map);
            }
            else {
                if (resultType.equals("XML")) {
                    this.logger.debug((Object)"*************XML IN************");
                    list = this.simpleService.queryForList(command);
                    List resultList = new ArrayList();
                    if (outParamKey != null && list.size() > 0) {
                        for (int i = 0; i < list.size(); ++i) {
                            final Map record = (Map) list.get(i);
                            final Map data = new LinkedHashMap();
                            for (int j = 0; j < outParamKey.length; ++j) {
                                data.put(outParamKey[j], record.get(outParamKey[j]));
                            }
                            resultList.add(data);
                        }
                    }
                    else {
                        resultList = list;
                    }
                    final SimpleDoc simpleDoc = new SimpleDoc("XML", resultList);
                    if (command.containsKey("format")) {
                        simpleDoc.setFormat(command.get("format").toString().split(";"));
                    }
                    return simpleDoc.create();
                }
                if (resultType.equals("JSON")) {
                    list = this.simpleService.queryForList(command);
                    final SimpleDoc simpleDoc2 = new SimpleDoc("JSON", list);
                    return simpleDoc2.create();
                }
                if (resultType.equals("CSV")) {
                    list = this.simpleService.queryForList(command);
                    List resultList = new ArrayList();
                    if (outParamKey != null && list.size() > 0) {
                        for (int i = 0; i < list.size(); ++i) {
                            final Map record = (Map) list.get(i);
                            final Map data = new LinkedHashMap();
                            for (int j = 0; j < outParamKey.length; ++j) {
                                data.put(outParamKey[j], record.get(outParamKey[j]));
                            }
                            resultList.add(data);
                        }
                    }
                    else {
                        resultList = list;
                    }
                    final SimpleDoc simpleDoc = new SimpleDoc("CSV", resultList);
                    if (command.containsKey("headerText")) {
                        simpleDoc.setHeaderText(command.get("headerText").toString().split(";"));
                    }
                    if (command.containsKey("fileName")) {
                        simpleDoc.setFileName((String) command.get("fileName"));
                    }
                    return simpleDoc.create();
                }
                if (resultType.equals("TEXT")) {
                    list = this.simpleService.queryForList(command);
                    List resultList = new ArrayList();
                    if (outParamKey != null && list.size() > 0) {
                        for (int i = 0; i < list.size(); ++i) {
                            final Map record = (Map) list.get(i);
                            final Map data = new LinkedHashMap();
                            for (int j = 0; j < outParamKey.length; ++j) {
                                data.put(outParamKey[j], record.get(outParamKey[j]));
                            }
                            resultList.add(data);
                        }
                    }
                    else {
                        resultList = list;
                    }
                    final SimpleDoc simpleDoc = new SimpleDoc("TEXT", list);
                    if (command.containsKey("headerText")) {
                        simpleDoc.setHeaderText(command.get("headerText").toString().split(";"));
                    }
                    if (command.containsKey("fileName")) {
                        simpleDoc.setFileName((String) command.get("fileName"));
                    }
                    return simpleDoc.create();
                }
                if (resultType.equals("EXCEL")) {
                    if (command.containsKey("iterateKey")) {
                        final String[] iterateKey = command.get("iterateKey").toString().split(";");
                        for (int i = 0; i < iterateKey.length; ++i) {
                            final String[] iterateValue = command.get(iterateKey[i]).toString().split(";");
                            try {
                                command.put(iterateKey[i], iterateValue);
                            }
                            catch (final ArrayIndexOutOfBoundsException e2) {
                                command.put(iterateKey[i], "");
                            }
                        }
                    }
                    list = this.simpleService.queryForList(command);
                    List resultList = new ArrayList();
                    if (outParamKey != null && list.size() > 0) {
                        for (int i = 0; i < list.size(); ++i) {
                            final Map record = (Map) list.get(i);
                            final Map data = new LinkedHashMap();
                            for (int j = 0; j < outParamKey.length; ++j) {
                                data.put(outParamKey[j], record.get(outParamKey[j]));
                            }
                            resultList.add(data);
                        }
                    }
                    else {
                        resultList = list;
                    }
                    final SimpleDoc simpleDoc = new SimpleDoc("EXCEL", resultList);
                    if (command.containsKey("headerText")) {
                        simpleDoc.setHeaderText(command.get("headerText").toString().split(";"));
                    }
                    if (command.containsKey("fileName")) {
                        simpleDoc.setFileName((String) command.get("fileName"));
                    }
                    if (command.containsKey("dataType")) {
                        simpleDoc.setDataType(command.get("dataType").toString().split(";"));
                    }
                    return simpleDoc.create();
                }
                if (resultType.equals("JXLS")) {
                    final List resultList = this.simpleService.queryForList(command);
                    final SimpleDoc simpleDoc = new SimpleDoc("JXLS", resultList);
                    if (command.containsKey("headerText")) {
                        simpleDoc.setHeaderText(command.get("headerText").toString().split(";"));
                    }
                    if (command.containsKey("fileName")) {
                        simpleDoc.setFileName((String) command.get("fileName"));
                    }
                    if (command.containsKey("templateFile")) {
                        simpleDoc.setTemplateFile((String) command.get("templateFile"));
                    }
                    simpleDoc.setTemplateFilePath(templateFilePath);
                    simpleDoc.setTemplateExcelExtension(this.templateExcelExtension);
                    simpleDoc.setCreateExcelExtension(this.createExcelExtension);
                    return simpleDoc.create();
                }
                if (resultType.equals("PDF")) {
                    if (command.containsKey("iterateKey")) {
                        final String[] iterateKey = command.get("iterateKey").toString().split(";");
                        for (int i = 0; i < iterateKey.length; ++i) {
                            final String[] iterateValue = command.get(iterateKey[i]).toString().split(";");
                            try {
                                command.put(iterateKey[i], iterateValue);
                            }
                            catch (final ArrayIndexOutOfBoundsException e2) {
                                command.put(iterateKey[i], "");
                            }
                        }
                    }
                    list = this.simpleService.queryForList(command);
                    final String paperDirection = (String) command.get("paperDirection");
                    SimpleDoc simpleDoc = null;
                    if (paperDirection.equals("landscape")) {
                        simpleDoc = new SimpleDoc("PDF", 1, list);
                    }
                    else if (paperDirection.equals("portrait")) {
                        simpleDoc = new SimpleDoc("PDF", 2, list);
                    }
                    else {
                        simpleDoc = new SimpleDoc("PDF", list);
                    }
                    simpleDoc.setTitle((String) command.get("docTitle"));
                    final String[] columnWidth = command.get("columnWidth").toString().split(";");
                    final int[] col = new int[columnWidth.length];
                    for (int k = 0; k < columnWidth.length; ++k) {
                        col[k] = Integer.parseInt(columnWidth[k]);
                    }
                    simpleDoc.setColumnWidth(col);
                    simpleDoc.setHeaderText(command.get("headerText").toString().split(";"));
                    return simpleDoc.create();
                }
            }
            mav.addObject("command", (Object)command);
        }
        else {
            try {
                this.simpleService.update(command);
                message.put("code", "S");
                message.put("message", this.getMessageSourceAccessor().getMessage("success.save"));
            }
            catch (final Exception e3) {
                message.put("code", "F");
                message.put("message", this.getMessageSourceAccessor().getMessage("failure.save"));
            }
            mav.addObject("command", (Object)command);
            mav.addObject("message", (Object)message);
        }
        final Enumeration en = request.getParameterNames();
        while (en.hasMoreElements()) {
            final String attribute = (String) en.nextElement();
            final Object attributeValue = request.getParameter(attribute);
            if (this.logger.isDebugEnabled()) {
                this.logger.debug((Object)("set Attribute in Request : " + attribute + "=" + attributeValue));
            }
            request.setAttribute(attribute, attributeValue);
        }
        return mav;
    }
}
