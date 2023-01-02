// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import java.util.List;
import net.sf.jxls.transformer.XLSTransformer;
import java.io.File;
import java.util.Date;
import java.text.SimpleDateFormat;
import kr.co.nis.waf.util.FormatUtil;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.ArrayList;
import kr.co.nis.waf.ResultMessage;
import java.util.HashMap;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.LogFactory;
import javax.annotation.Resource;
import kr.co.nis.waf.dao.SimpleService;
import org.springframework.beans.factory.annotation.Value;
import org.apache.commons.logging.Log;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@Controller
@RequestMapping({ "/service/simpleExport" })
public class SimpleExportController extends WafMultiActionController
{
    protected final Log logger;
//    @Value("#{system['jXls.templateFilePath']}")
//    private String templateFilePath;
    @Value("#{system['jXls.templateExcelExtension']}")
    private String templateExcelExtension;
    @Value("#{system['jXls.createExcelExtension']}")
    private String createExcelExtension;
//    @Value("#{system['jXls.createTempFilePath']}")
//    private String createTempFilePath;
    @Resource
    private SimpleService simpleService;
    
    public SimpleExportController() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    @RequestMapping({ "/jxls" })
    public ModelAndView createjXls(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
        String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
        final Map model = new HashMap();
        final ResultMessage rm = new ResultMessage();
        this.bind(request, model);
        String[] cellFormat = null;
        String[] outParamKey = null;
        try {
            cellFormat = model.get("cellFormat").toString().split(";");
            outParamKey = model.get("outParamKey").toString().split(";");
        }
        catch (final Exception ex) {}
        final List list = this.simpleService.queryForList(model);
        List resultList = new ArrayList();
        if (outParamKey != null && list.size() > 0) {
            for (int i = 0; i < list.size(); ++i) {
                final Map record = (Map) list.get(i);
                final Map data = new LinkedHashMap();
                for (int j = 0; j < outParamKey.length; ++j) {
                    if (cellFormat[j].equals("dat") || cellFormat[j].equals("date")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], FormatUtil.formatDate(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("tel") || cellFormat[j].equals("telno")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], FormatUtil.formatTelNo(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("biz") || cellFormat[j].equals("bizregno")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], FormatUtil.formatBizRegNo(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("zip") || cellFormat[j].equals("zipcode")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], FormatUtil.formatZipCode(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("card") || cellFormat[j].equals("cardno")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], FormatUtil.formatCardNo(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("cardnonstar") || cellFormat[j].equals("cardnononstar")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], FormatUtil.formatCardNoNonStar(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("num") || cellFormat[j].equals("number")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], Integer.parseInt(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("mon") || cellFormat[j].equals("month")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], FormatUtil.formatMonth(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("rem") || cellFormat[j].equals("remark")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], record.get(outParamKey[j]).toString().replaceAll("&lt;br&gt;", " "));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("time")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], FormatUtil.formatTime(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (cellFormat[j].equals("datetime")) {
                        if (record.get(outParamKey[j]) != null) {
                            data.put(outParamKey[j], FormatUtil.formatDateTime(record.get(outParamKey[j]).toString()));
                        }
                        else {
                            data.put(outParamKey[j], "");
                        }
                    }
                    else if (record.get(outParamKey[j]) != null) {
                        data.put(outParamKey[j], record.get(outParamKey[j]));
                    }
                    else {
                        data.put(outParamKey[j], "");
                    }
                }
                resultList.add(data);
            }
        }
        else {
            resultList = list;
        }
        model.put("data", resultList);
        final List resultList2 = (model.get("queryKey2") != null) ? this.simpleService.queryForList(model.get("queryKey2").toString(), model) : null;
        final List resultList3 = (model.get("queryKey3") != null) ? this.simpleService.queryForList(model.get("queryKey3").toString(), model) : null;
        final List resultList4 = (model.get("queryKey4") != null) ? this.simpleService.queryForList(model.get("queryKey4").toString(), model) : null;
        final List resultList5 = (model.get("queryKey5") != null) ? this.simpleService.queryForList(model.get("queryKey5").toString(), model) : null;
        final List resultList6 = (model.get("queryKey6") != null) ? this.simpleService.queryForList(model.get("queryKey6").toString(), model) : null;
        final List resultList7 = (model.get("queryKey7") != null) ? this.simpleService.queryForList(model.get("queryKey7").toString(), model) : null;
        final List resultList8 = (model.get("queryKey8") != null) ? this.simpleService.queryForList(model.get("queryKey8").toString(), model) : null;
        final List resultList9 = (model.get("queryKey9") != null) ? this.simpleService.queryForList(model.get("queryKey9").toString(), model) : null;
        final List resultList10 = (model.get("queryKey10") != null) ? this.simpleService.queryForList(model.get("queryKey10").toString(), model) : null;
        final List resultList11 = (model.get("queryKey11") != null) ? this.simpleService.queryForList(model.get("queryKey11").toString(), model) : null;
        final List resultList12 = (model.get("queryKey12") != null) ? this.simpleService.queryForList(model.get("queryKey12").toString(), model) : null;
        final List resultList13 = (model.get("queryKey13") != null) ? this.simpleService.queryForList(model.get("queryKey13").toString(), model) : null;
        final List resultList14 = (model.get("queryKey14") != null) ? this.simpleService.queryForList(model.get("queryKey14").toString(), model) : null;
        final List resultList15 = (model.get("queryKey15") != null) ? this.simpleService.queryForList(model.get("queryKey15").toString(), model) : null;
        final List resultList16 = (model.get("queryKey16") != null) ? this.simpleService.queryForList(model.get("queryKey16").toString(), model) : null;
        final List resultList17 = (model.get("queryKey17") != null) ? this.simpleService.queryForList(model.get("queryKey17").toString(), model) : null;
        final List resultList18 = (model.get("queryKey18") != null) ? this.simpleService.queryForList(model.get("queryKey18").toString(), model) : null;
        final List resultList19 = (model.get("queryKey19") != null) ? this.simpleService.queryForList(model.get("queryKey19").toString(), model) : null;
        final List resultList20 = (model.get("queryKey20") != null) ? this.simpleService.queryForList(model.get("queryKey20").toString(), model) : null;
        final List resultList21 = (model.get("queryKey21") != null) ? this.simpleService.queryForList(model.get("queryKey21").toString(), model) : null;
        final List resultList22 = (model.get("queryKey22") != null) ? this.simpleService.queryForList(model.get("queryKey22").toString(), model) : null;
        final List resultList23 = (model.get("queryKey23") != null) ? this.simpleService.queryForList(model.get("queryKey23").toString(), model) : null;
        final List resultList24 = (model.get("queryKey24") != null) ? this.simpleService.queryForList(model.get("queryKey24").toString(), model) : null;
        final List resultList25 = (model.get("queryKey25") != null) ? this.simpleService.queryForList(model.get("queryKey25").toString(), model) : null;
        final List resultList26 = (model.get("queryKey26") != null) ? this.simpleService.queryForList(model.get("queryKey26").toString(), model) : null;
        final List resultList27 = (model.get("queryKey27") != null) ? this.simpleService.queryForList(model.get("queryKey27").toString(), model) : null;
        final List resultList28 = (model.get("queryKey28") != null) ? this.simpleService.queryForList(model.get("queryKey28").toString(), model) : null;
        final List resultList29 = (model.get("queryKey29") != null) ? this.simpleService.queryForList(model.get("queryKey29").toString(), model) : null;
        final List resultList30 = (model.get("queryKey30") != null) ? this.simpleService.queryForList(model.get("queryKey30").toString(), model) : null;
        final List resultList31 = (model.get("queryKey31") != null) ? this.simpleService.queryForList(model.get("queryKey31").toString(), model) : null;
        final List resultList32 = (model.get("queryKey32") != null) ? this.simpleService.queryForList(model.get("queryKey32").toString(), model) : null;
        final List resultList33 = (model.get("queryKey33") != null) ? this.simpleService.queryForList(model.get("queryKey33").toString(), model) : null;
        final List resultList34 = (model.get("queryKey34") != null) ? this.simpleService.queryForList(model.get("queryKey34").toString(), model) : null;
        final List resultList35 = (model.get("queryKey35") != null) ? this.simpleService.queryForList(model.get("queryKey35").toString(), model) : null;
        final List resultList36 = (model.get("queryKey36") != null) ? this.simpleService.queryForList(model.get("queryKey36").toString(), model) : null;
        final List resultList37 = (model.get("queryKey37") != null) ? this.simpleService.queryForList(model.get("queryKey37").toString(), model) : null;
        final List resultList38 = (model.get("queryKey38") != null) ? this.simpleService.queryForList(model.get("queryKey38").toString(), model) : null;
        final List resultList39 = (model.get("queryKey39") != null) ? this.simpleService.queryForList(model.get("queryKey39").toString(), model) : null;
        final List resultList40 = (model.get("queryKey40") != null) ? this.simpleService.queryForList(model.get("queryKey40").toString(), model) : null;
        model.put("list2", resultList2);
        model.put("list3", resultList3);
        model.put("list4", resultList4);
        model.put("list5", resultList5);
        model.put("list6", resultList6);
        model.put("list7", resultList7);
        model.put("list8", resultList8);
        model.put("list9", resultList9);
        model.put("list10", resultList10);
        model.put("list11", resultList11);
        model.put("list12", resultList12);
        model.put("list13", resultList13);
        model.put("list14", resultList14);
        model.put("list15", resultList15);
        model.put("list16", resultList16);
        model.put("list17", resultList17);
        model.put("list18", resultList18);
        model.put("list19", resultList19);
        model.put("list20", resultList20);
        model.put("list21", resultList21);
        model.put("list22", resultList22);
        model.put("list23", resultList23);
        model.put("list24", resultList24);
        model.put("list25", resultList25);
        model.put("list26", resultList26);
        model.put("list27", resultList27);
        model.put("list28", resultList28);
        model.put("list29", resultList29);
        model.put("list30", resultList30);
        model.put("list31", resultList31);
        model.put("list32", resultList32);
        model.put("list33", resultList33);
        model.put("list34", resultList34);
        model.put("list35", resultList35);
        model.put("list36", resultList36);
        model.put("list37", resultList37);
        model.put("list38", resultList38);
        model.put("list39", resultList39);
        model.put("list40", resultList40);
        final String[] headerText = (String[])((model.get("headerText") != null) ? ((String[])model.get("headerText")) : null);
        final String[] headerText2 = (String[])((model.get("headerText2") != null) ? ((String[])model.get("headerText2")) : null);
        final String[] headerText3 = (String[])((model.get("headerText3") != null) ? ((String[])model.get("headerText3")) : null);
        final String[] headerText4 = (String[])((model.get("headerText4") != null) ? ((String[])model.get("headerText4")) : null);
        final String[] headerText5 = (String[])((model.get("headerText5") != null) ? ((String[])model.get("headerText5")) : null);
        final String[] headerText6 = (String[])((model.get("headerText6") != null) ? ((String[])model.get("headerText6")) : null);
        final String[] headerText7 = (String[])((model.get("headerText7") != null) ? ((String[])model.get("headerText7")) : null);
        final String[] headerText8 = (String[])((model.get("headerText8") != null) ? ((String[])model.get("headerText8")) : null);
        final String[] headerText9 = (String[])((model.get("headerText9") != null) ? ((String[])model.get("headerText9")) : null);
        final String[] headerText10 = (String[])((model.get("headerText10") != null) ? ((String[])model.get("headerText10")) : null);
        final String templateFile = String.valueOf(templateFilePath) + model.get("templateFile") + "." + this.templateExcelExtension;
        final String inDate = new SimpleDateFormat("yyyyMMdd").format(new Date());
        final String inDateTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        final String destFile = String.valueOf(createTempFilePath) + inDateTime + "." + this.createExcelExtension;
        final String createFile = inDateTime;
        final Map header = new HashMap();
        final Map header2 = new HashMap();
        final Map header3 = new HashMap();
        final Map header4 = new HashMap();
        final Map header5 = new HashMap();
        final Map header6 = new HashMap();
        final Map header7 = new HashMap();
        final Map header8 = new HashMap();
        final Map header9 = new HashMap();
        final Map header10 = new HashMap();
        if (headerText != null) {
            for (int k = 0; k < headerText.length; ++k) {
                header.put("header" + String.valueOf(k), headerText[k]);
            }
        }
        if (headerText2 != null) {
            for (int k = 0; k < headerText2.length; ++k) {
                header2.put("header2" + String.valueOf(k), headerText2[k]);
            }
        }
        if (headerText3 != null) {
            for (int k = 0; k < headerText3.length; ++k) {
                header3.put("header3" + String.valueOf(k), headerText3[k]);
            }
        }
        if (headerText4 != null) {
            for (int k = 0; k < headerText4.length; ++k) {
                header4.put("header4" + String.valueOf(k), headerText4[k]);
            }
        }
        if (headerText5 != null) {
            for (int k = 0; k < headerText5.length; ++k) {
                header5.put("header5" + String.valueOf(k), headerText5[k]);
            }
        }
        if (headerText6 != null) {
            for (int k = 0; k < headerText6.length; ++k) {
                header6.put("header6" + String.valueOf(k), headerText6[k]);
            }
        }
        if (headerText7 != null) {
            for (int k = 0; k < headerText7.length; ++k) {
                header7.put("header7" + String.valueOf(k), headerText7[k]);
            }
        }
        if (headerText8 != null) {
            for (int k = 0; k < headerText8.length; ++k) {
                header8.put("header8" + String.valueOf(k), headerText8[k]);
            }
        }
        if (headerText9 != null) {
            for (int k = 0; k < headerText9.length; ++k) {
                header9.put("header9" + String.valueOf(k), headerText9[k]);
            }
        }
        if (headerText10 != null) {
            for (int k = 0; k < headerText10.length; ++k) {
                header10.put("header10" + String.valueOf(k), headerText10[k]);
            }
        }
        model.putAll(header);
        model.putAll(header2);
        model.putAll(header3);
        model.putAll(header4);
        model.putAll(header5);
        model.putAll(header6);
        model.putAll(header7);
        model.putAll(header8);
        model.putAll(header9);
        model.putAll(header10);
        final File dir = new File(String.valueOf(createTempFilePath) + "/");
        try {
            if (!dir.isDirectory()) {
                dir.mkdirs();
            }
        }
        catch (final Exception e) {
            dir.mkdirs();
        }
        final XLSTransformer transformer = new XLSTransformer();
        transformer.transformXLS(templateFile, model, destFile);
        final ResultMessage resultMessage = rm;
        rm.getClass();
        resultMessage.setCode("S");
        rm.setParameters(createFile);
        final ModelAndView mv = new ModelAndView("resultView");
        mv.addObject("resultMsg", (Object)rm);
        return mv;
    }
    
    @RequestMapping({ "/download" })
    public ModelAndView download(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
        String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
        final Map model = new HashMap();
        this.bind(request, model);
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)model);
        }
        final Map parameters = new HashMap();
        parameters.put("fileName", String.valueOf(model.get("downloadFile").toString()) + "." + this.createExcelExtension);
        parameters.put("tempFileName", String.valueOf(model.get("tempFile").toString()) + "." + this.createExcelExtension);
        parameters.put("uploadDir", createTempFilePath);
        if (this.logger.isDebugEnabled()) {
            this.logger.debug((Object)parameters);
        }
        return new ModelAndView("selfTargetDownloadView", parameters);
    }
}
