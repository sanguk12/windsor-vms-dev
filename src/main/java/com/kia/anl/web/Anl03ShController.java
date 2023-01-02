package com.kia.anl.web;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.common.FileInfo;
import kr.co.nis.waf.common.FileUploadUtil;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.view.SimpleDoc;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kia.anl.model.ESLT_AREA_MT;
import com.kia.anl.model.ESLT_BRANCH_MT;
import com.kia.anl.model.ESLT_CD_ACT;
import com.kia.anl.model.ESLT_CD_FC;
import com.kia.anl.model.ESLT_CD_TG;
import com.kia.anl.model.ESLT_CUSTOMER_MT;
import com.kia.anl.model.ESLT_DC_ACT;
import com.kia.anl.model.ESLT_DC_FC;
import com.kia.anl.model.ESLT_DC_FCACT;
import com.kia.anl.model.ESLT_DC_TG;
import com.kia.anl.model.ESLT_NOTEG_ACT;
import com.kia.anl.model.ESLT_NOTEG_FC;
import com.kia.anl.model.ESLT_NOTEG_TG;
import com.kia.anl.model.ESLT_NTS_ACT;
import com.kia.anl.model.ESLT_NTS_FC;
import com.kia.anl.model.ESLT_NTS_TG;
import com.kia.anl.model.ESLT_PRODUCT_MT;
import com.kia.anl.model.ESLT_PRODUCT_SEQ;
import com.kia.anl.model.ESLT_SH_ACT;
import com.kia.anl.model.ESLT_SH_FC;
import com.kia.anl.model.ESLT_SH_TG;
import com.kia.anl.model.ESLT_TEAM_MT;
import com.kia.anl.service.Anl02Service;


@Controller
@RequestMapping("/service/anl03Sh")
public class Anl03ShController extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private Anl02Service anl02Service;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;

	@Value("#{system['docLink.realDownloadPath']}")
	private String realDownloadPath;

//	@Value("#{system['jXls.templateFilePath']}")
//	private String templateFilePath;
	
//	@Value("#{system['jXls.createTempFilePath']}")
//	private String createTempFilePath;

	//shipment 조회 row 시작
	private static int shipmentRow = 3;
	
	private HSSFWorkbook shBook = null;

	@RequestMapping("/shExcelDelete")
	public ModelAndView shExcelDelete(HttpServletRequest request, HttpServletResponse reponse) throws Exception {
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		String fileName = request.getParameter("fileName");
		// temp file delete
		try {
			File f = new File(createTempFilePath+fileName);
			f.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("resultView");
	}
	
	//엑셀 버튼
	@RequestMapping("/shExcelSearch")
	public ModelAndView shExcelSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		Map param = new HashMap();
		String templateFilePath = request.getServletContext().getRealPath("WEB-INF/excel/");
		String createTempFilePath = request.getServletContext().getRealPath("WEB-INF/temp/");
		
		bind(request, param);
		
		try {
			//파일명 생성
			String fyTxt = (String)param.get("fy"); 
			String periodTxt = (String)param.get("period");
			String channelTxt = (String)param.get("channel");
			String regionTxt = (String)param.get("region");
			String teamTxt = (String)param.get("branch");
			String ytdTxt = (String)param.get("ytd");
			String fileTxtName ="ESLT_Shipment";
			
			fileTxtName += "_"+fyTxt;
			
			if(!periodTxt.equals("")){
				fileTxtName += "_"+periodTxt;
			}else{
				fileTxtName += "_ALL";
			}
			
			fileTxtName += "_"+ytdTxt;
			
			if(!channelTxt.equals("")){
				fileTxtName += "_"+channelTxt;
			}
			
			if(!regionTxt.equals("")){
				if(channelTxt.equals("")){
					fileTxtName += "_ALL";
				}
				fileTxtName += "_"+regionTxt;
			}
			
			if(!teamTxt.equals("")){
				
				if(regionTxt.equals("")){
					
					if(channelTxt.equals("")){
						fileTxtName += "_ALL";
					}
					
					fileTxtName += "_ALL";
				}
				fileTxtName += "_"+teamTxt;
			}
			
			fileTxtName += ".xls";
			
			ArrayList<Map> list = new ArrayList<Map>();
			HashMap nonWhisky = new HashMap();
			ArrayList<Map> list2 = new ArrayList<Map>();
			ArrayList<Map> list3 = new ArrayList<Map>();
			HashMap cTarget = new HashMap();
			
			list = (ArrayList<Map>) simpleService.queryForList("ANL0200901S", param);//sh 조회
			nonWhisky = (HashMap) simpleService.queryForMap("ANL0200905S", param);//sh 조회(SDX조회)
			list2 = (ArrayList<Map>) simpleService.queryForList("ANL0200902S", param);//DC 조회
			list3 = (ArrayList<Map>) simpleService.queryForList("ANL0200903S", param);//Credit 조회
			cTarget = (HashMap) simpleService.queryForMap("ANL0200904S", param);//Credit(Target) 조회
			
			//엑셀 생성
			shBook = new HSSFWorkbook();
			HSSFSheet shSheet = shBook.createSheet("DK Total");
			
			HSSFRow row = null;
			HSSFCell cell = null;
			
			//row위치
			int count = 0;
			int tableRow = 0; //전체 리스트의 row수
			int headerRow = 2; //헤더 row수
			int listSize = 0;
			
			ArrayList<Map> dcMergeList = new ArrayList<Map>();
			ArrayList<Map> dcGsvList = new ArrayList<Map>();
			ArrayList<Map> dcCalcList = new ArrayList<Map>();
			ArrayList<Map> shMergeList = new ArrayList<Map>();
			ArrayList<Map> shTotalList = new ArrayList<Map>();
			ArrayList<Map> shCalcList = new ArrayList<Map>();
			ArrayList<Map> creditMergeList = new ArrayList<Map>();
			ArrayList<Map> creditCalcList = new ArrayList<Map>();
			
			shMergeList  = shForecast(list, param);//Shipment
			shTotalList = shWhisky(shMergeList, nonWhisky, param);
			shCalcList = shipmentCalC(shMergeList);
			listSize = shForecastExcel(shCalcList, shTotalList, tableRow, row, cell, shBook, shSheet, param);
			tableRow = headerRow+shipmentRow+listSize;//표마다 세줄간격 표시
			listSize = shTargetExcel(shCalcList, shTotalList, tableRow, row, cell, shBook, shSheet, param);
			tableRow += headerRow+shipmentRow+listSize; //표마다 세줄간격 표시
			
			dcMergeList  = dcForecast(list2, param);//DC
			dcGsvList = dcGsvTotalList(list, list2, param);
			dcCalcList = dcCalC(dcMergeList);
			listSize = dcForecastExcel(dcCalcList, dcGsvList, tableRow, row, cell, shBook, shSheet, param);
			tableRow += headerRow+shipmentRow+listSize;//표마다 세줄간격 표시
			listSize = dcTargetExcel(dcCalcList, dcGsvList, tableRow, row, cell, shBook, shSheet, param);
			tableRow += headerRow+shipmentRow+listSize;//표마다 세줄간격 표시
			
			creditMergeList = creditMerge(list3, cTarget, param);
			creditCalcList = creditCalC(creditMergeList);
			creditForecastExcel(creditCalcList, tableRow, row, cell, shBook, shSheet, param);
			tableRow += headerRow+shipmentRow+creditMergeList.size();//표마다 세줄간격 표시
			creditTargetExcel(creditCalcList, tableRow, row, cell, shBook, shSheet, param);
			tableRow += headerRow+shipmentRow+creditMergeList.size();//표마다 세줄간격 표시
			
			//파일 임시 저장소 (c:/deploy/diageo/WEB-INF/temp/)
			File dir = new File(createTempFilePath);
			try {
				if(!dir.isDirectory()) dir.mkdirs();
			}
			catch(Exception e) {
				dir.mkdirs();
			}
			FileOutputStream out = new FileOutputStream(new File(createTempFilePath+fileTxtName));
			shBook.write(out); 
			out.close();
			//shBook.close();
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setParameters(fileTxtName);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch(Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
				e.printStackTrace();
			}
			
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.completeAccre"));
			rm.setSystemMessage(e.toString());
		}
		
		
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);
		
		return mv;
	}
	
	//shipment 조회
	public ArrayList<Map> shForecast(ArrayList<Map>list, Map param) throws Exception {
		double sh_ac_p01_sum = 0; double sh_ac_p02_sum = 0; double sh_ac_p03_sum = 0; double sh_ac_p04_sum = 0; double sh_ac_p05_sum = 0; double sh_ac_p06_sum = 0;
		double sh_ac_p07_sum = 0; double sh_ac_p08_sum = 0; double sh_ac_p09_sum = 0; double sh_ac_p10_sum = 0; double sh_ac_p11_sum = 0; double sh_ac_p12_sum = 0;
		double sh_ac_q01_sum = 0; double sh_ac_q02_sum = 0; double sh_ac_q03_sum = 0; double sh_ac_q04_sum = 0; double sh_ac_h01_sum = 0; double sh_ac_h02_sum = 0; double sh_ac_ytd_sum = 0;
		
		double sh_for_p01_sum = 0; double sh_for_p02_sum = 0; double sh_for_p03_sum = 0; double sh_for_p04_sum = 0; double sh_for_p05_sum = 0; double sh_for_p06_sum = 0;
		double sh_for_p07_sum = 0; double sh_for_p08_sum = 0; double sh_for_p09_sum = 0; double sh_for_p10_sum = 0; double sh_for_p11_sum = 0; double sh_for_p12_sum = 0;
		double sh_for_q01_sum = 0; double sh_for_q02_sum = 0; double sh_for_q03_sum = 0; double sh_for_q04_sum = 0; double sh_for_h01_sum = 0; double sh_for_h02_sum = 0; double sh_for_ytd_sum = 0;
		
		double sh_out_p01_sum = 0; double sh_out_p02_sum = 0; double sh_out_p03_sum = 0; double sh_out_p04_sum = 0; double sh_out_p05_sum = 0; double sh_out_p06_sum = 0;
		double sh_out_p07_sum = 0; double sh_out_p08_sum = 0; double sh_out_p09_sum = 0; double sh_out_p10_sum = 0; double sh_out_p11_sum = 0; double sh_out_p12_sum = 0;
		double sh_out_q01_sum = 0; double sh_out_q02_sum = 0; double sh_out_q03_sum = 0; double sh_out_q04_sum = 0; double sh_out_h01_sum = 0; double sh_out_h02_sum = 0; double sh_out_ytd_sum = 0;
		
		double sh_tg_p01_sum = 0; double sh_tg_p02_sum = 0; double sh_tg_p03_sum = 0; double sh_tg_p04_sum = 0; double sh_tg_p05_sum = 0; double sh_tg_p06_sum = 0;
		double sh_tg_p07_sum = 0; double sh_tg_p08_sum = 0; double sh_tg_p09_sum = 0; double sh_tg_p10_sum = 0; double sh_tg_p11_sum = 0; double sh_tg_p12_sum = 0;
		double sh_tg_q01_sum = 0; double sh_tg_q02_sum = 0; double sh_tg_q03_sum = 0; double sh_tg_q04_sum = 0; double sh_tg_h01_sum = 0; double sh_tg_h02_sum = 0; double sh_tg_ytd_sum = 0;
		
		for(int i=0; i<list.size(); i++) {			// Actual, foreCast Total 계산
			
			//전년 SH Actual 실적 쿼터별 sum
			double sh_ac_q1 = Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P01"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P02"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P03")));
			double sh_ac_q2 = Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P04"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P05"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P06")));
			double sh_ac_q3 = Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P07"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P08"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P09")));
			double sh_ac_q4 = Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P10"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P11"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P12")));
			double sh_ac_h1 = sh_ac_q1 + sh_ac_q2;
			double sh_ac_h2 = sh_ac_q3 + sh_ac_q4;
			double sh_ac_ytd = setAcYTD(param, list.get(i), "SH");
			
			list.get(i).put("SH_AC_Q1",sh_ac_q1);
			list.get(i).put("SH_AC_Q2",sh_ac_q2);
			list.get(i).put("SH_AC_Q3",sh_ac_q3);
			list.get(i).put("SH_AC_Q4",sh_ac_q4);

			list.get(i).put("SH_AC_H1",sh_ac_h1);
			list.get(i).put("SH_AC_H2",sh_ac_h2);
			list.get(i).put("SH_AC_YTD",sh_ac_ytd);
			
			sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P01")));
			sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P02")));
			sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P03")));
			sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P04")));
			sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P05")));
			sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P06")));
			sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P07")));
			sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P08")));
			sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P09")));
			sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P10")));
			sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P11")));
			sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P12")));
			sh_ac_q01_sum += Double.parseDouble(String.valueOf(sh_ac_q1));
			sh_ac_q02_sum += Double.parseDouble(String.valueOf(sh_ac_q2));
			sh_ac_q03_sum += Double.parseDouble(String.valueOf(sh_ac_q3));
			sh_ac_q04_sum += Double.parseDouble(String.valueOf(sh_ac_q4));
			sh_ac_h01_sum += Double.parseDouble(String.valueOf(sh_ac_h1));
			sh_ac_h02_sum += Double.parseDouble(String.valueOf(sh_ac_h2));
			sh_ac_ytd_sum += Double.parseDouble(String.valueOf(sh_ac_ytd));
			
			list.get(i).put("sh_ac_p01_sum", sh_ac_p01_sum); list.get(i).put("sh_ac_p02_sum", sh_ac_p02_sum); list.get(i).put("sh_ac_p03_sum", sh_ac_p03_sum); 
			list.get(i).put("sh_ac_p04_sum", sh_ac_p04_sum); list.get(i).put("sh_ac_p05_sum", sh_ac_p05_sum); list.get(i).put("sh_ac_p06_sum", sh_ac_p06_sum); 
			list.get(i).put("sh_ac_p07_sum", sh_ac_p07_sum); list.get(i).put("sh_ac_p08_sum", sh_ac_p08_sum); list.get(i).put("sh_ac_p09_sum", sh_ac_p09_sum); 
			list.get(i).put("sh_ac_p10_sum", sh_ac_p10_sum); list.get(i).put("sh_ac_p11_sum", sh_ac_p11_sum); list.get(i).put("sh_ac_p12_sum", sh_ac_p12_sum);
			list.get(i).put("sh_ac_q01_sum", sh_ac_q01_sum); list.get(i).put("sh_ac_q02_sum", sh_ac_q02_sum); list.get(i).put("sh_ac_q03_sum", sh_ac_q03_sum); list.get(i).put("sh_ac_q04_sum", sh_ac_q04_sum);
			list.get(i).put("sh_ac_h01_sum", sh_ac_h01_sum); list.get(i).put("sh_ac_h02_sum", sh_ac_h02_sum); list.get(i).put("sh_ac_ytd_sum", sh_ac_ytd_sum);
			
			//당년 SH foreCast 실적 쿼터별 sum
			double sh_for_q1 = Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P01"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P02"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P03")));
			double sh_for_q2 = Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P04"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P05"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P06")));
			double sh_for_q3 = Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P07"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P08"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P09")));
			double sh_for_q4 = Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P10"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P11"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P12")));
			double sh_for_h1 = sh_for_q1 + sh_for_q2; 
			double sh_for_h2 = sh_for_q3 + sh_for_q4; 
			double sh_for_ytd = setForYTD(param, list.get(i), "SH");
			
			list.get(i).put("SH_FOR_Q1",sh_for_q1); list.get(i).put("SH_FOR_Q2",sh_for_q2); list.get(i).put("SH_FOR_Q3",sh_for_q3); list.get(i).put("SH_FOR_Q4",sh_for_q4);
			list.get(i).put("SH_FOR_H1",sh_for_h1); list.get(i).put("SH_FOR_H2",sh_for_h2); list.get(i).put("SH_FOR_YTD",sh_for_ytd);
			
			sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P01")));
			sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P02")));
			sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P03")));
			sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P04")));
			sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P05")));
			sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P06")));
			sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P07")));
			sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P08")));
			sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P09")));
			sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P10")));
			sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P11")));
			sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P12")));
			sh_for_q01_sum += Double.parseDouble(String.valueOf(sh_for_q1));
			sh_for_q02_sum += Double.parseDouble(String.valueOf(sh_for_q2));
			sh_for_q03_sum += Double.parseDouble(String.valueOf(sh_for_q3));
			sh_for_q04_sum += Double.parseDouble(String.valueOf(sh_for_q4));
			sh_for_h01_sum += Double.parseDouble(String.valueOf(sh_for_h1));
			sh_for_h02_sum += Double.parseDouble(String.valueOf(sh_for_h2));
			sh_for_ytd_sum += Double.parseDouble(String.valueOf(sh_for_ytd));
			
			list.get(i).put("sh_for_p01_sum", sh_for_p01_sum); list.get(i).put("sh_for_p02_sum", sh_for_p02_sum); list.get(i).put("sh_for_p03_sum", sh_for_p03_sum); list.get(i).put("sh_for_p04_sum", sh_for_p04_sum);
			list.get(i).put("sh_for_p05_sum", sh_for_p05_sum); list.get(i).put("sh_for_p06_sum", sh_for_p06_sum); list.get(i).put("sh_for_p07_sum", sh_for_p07_sum); list.get(i).put("sh_for_p08_sum", sh_for_p08_sum);
			list.get(i).put("sh_for_p09_sum", sh_for_p09_sum); list.get(i).put("sh_for_p10_sum", sh_for_p10_sum); list.get(i).put("sh_for_p11_sum", sh_for_p11_sum); list.get(i).put("sh_for_p12_sum", sh_for_p12_sum);
			list.get(i).put("sh_for_q01_sum", sh_for_q01_sum); list.get(i).put("sh_for_q02_sum", sh_for_q02_sum); list.get(i).put("sh_for_q03_sum", sh_for_q03_sum); list.get(i).put("sh_for_q04_sum", sh_for_q04_sum);
			list.get(i).put("sh_for_h01_sum", sh_for_h01_sum); list.get(i).put("sh_for_h02_sum", sh_for_h02_sum); list.get(i).put("sh_for_ytd_sum", sh_for_ytd_sum);
			
		}

		for(int i=0; i<list.size(); i++) {		// Target, Outlook TempData 입력
			
			//당년  SH  Actual(Outlook) sum
			double sh_out_q1 = Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03")));
			double sh_out_q2 = Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06")));
			double sh_out_q3 = Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09")));
			double sh_out_q4 = Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12")));
			double sh_out_h1 = sh_out_q1 + sh_out_q2;
			double sh_out_h2 = sh_out_q3 + sh_out_q4;
			double sh_out_ytd = setOutYTD(param, list.get(i), "SH");
			
			list.get(i).put("SH_OUT_Q1",sh_out_q1);
			list.get(i).put("SH_OUT_Q2",sh_out_q2);
			list.get(i).put("SH_OUT_Q3",sh_out_q3);
			list.get(i).put("SH_OUT_Q4",sh_out_q4);

			list.get(i).put("SH_OUT_H1",sh_out_h1);
			list.get(i).put("SH_OUT_H2",sh_out_h2);
			list.get(i).put("SH_OUT_YTD",sh_out_ytd);
			
			sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01")));
			sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02")));
			sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03")));
			sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04")));
			sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05")));
			sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06")));
			sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07")));
			sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08")));
			sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09")));
			sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10")));
			sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11")));
			sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12")));
			sh_out_q01_sum += Double.parseDouble(String.valueOf(sh_out_q1));
			sh_out_q02_sum += Double.parseDouble(String.valueOf(sh_out_q2));
			sh_out_q03_sum += Double.parseDouble(String.valueOf(sh_out_q3));
			sh_out_q04_sum += Double.parseDouble(String.valueOf(sh_out_q4));
			sh_out_h01_sum += Double.parseDouble(String.valueOf(sh_out_h1));
			sh_out_h02_sum += Double.parseDouble(String.valueOf(sh_out_h2));
			sh_out_ytd_sum += Double.parseDouble(String.valueOf(sh_out_ytd));

			list.get(i).put("sh_out_p01_sum", sh_out_p01_sum); list.get(i).put("sh_out_p02_sum", sh_out_p02_sum); list.get(i).put("sh_out_p03_sum", sh_out_p03_sum); list.get(i).put("sh_out_p04_sum", sh_out_p04_sum);
			list.get(i).put("sh_out_p05_sum", sh_out_p05_sum); list.get(i).put("sh_out_p06_sum", sh_out_p06_sum); list.get(i).put("sh_out_p07_sum", sh_out_p07_sum); list.get(i).put("sh_out_p08_sum", sh_out_p08_sum);
			list.get(i).put("sh_out_p09_sum", sh_out_p09_sum); list.get(i).put("sh_out_p10_sum", sh_out_p10_sum); list.get(i).put("sh_out_p11_sum", sh_out_p11_sum); list.get(i).put("sh_out_p12_sum", sh_out_p12_sum);
			list.get(i).put("sh_out_q01_sum", sh_out_q01_sum); list.get(i).put("sh_out_q02_sum", sh_out_q02_sum); list.get(i).put("sh_out_q03_sum", sh_out_q03_sum); list.get(i).put("sh_out_q04_sum", sh_out_q04_sum);
			list.get(i).put("sh_out_h01_sum", sh_out_h01_sum); list.get(i).put("sh_out_h02_sum", sh_out_h02_sum); list.get(i).put("sh_out_ytd_sum", sh_out_ytd_sum);
			
			
			//당년  SH  Target sum
			double sh_tg_q1 = Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03")));
			double sh_tg_q2 = Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06")));
			double sh_tg_q3 = Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09")));
			double sh_tg_q4 = Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11"))) + Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12")));
			double sh_tg_h1 = sh_tg_q1 + sh_tg_q2;
			double sh_tg_h2 = sh_tg_q3 + sh_tg_q4;
			double sh_tg_ytd = setTgYTD(param, list.get(i), "SH");
			
			list.get(i).put("SH_TG_Q1",sh_tg_q1); list.get(i).put("SH_TG_Q2",sh_tg_q2); list.get(i).put("SH_TG_Q3",sh_tg_q3); list.get(i).put("SH_TG_Q4",sh_tg_q4);
			list.get(i).put("SH_TG_H1",sh_tg_h1); list.get(i).put("SH_TG_H2",sh_tg_h2); list.get(i).put("SH_TG_YTD",sh_tg_ytd);
			
			sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01")));
			sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02")));
			sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03")));
			sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04")));
			sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05")));
			sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06")));
			sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07")));
			sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08")));
			sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09")));
			sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10")));
			sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11")));
			sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12")));
			sh_tg_q01_sum += Double.parseDouble(String.valueOf(sh_tg_q1));
			sh_tg_q02_sum += Double.parseDouble(String.valueOf(sh_tg_q2));
			sh_tg_q03_sum += Double.parseDouble(String.valueOf(sh_tg_q3));
			sh_tg_q04_sum += Double.parseDouble(String.valueOf(sh_tg_q4));
			sh_tg_h01_sum += Double.parseDouble(String.valueOf(sh_tg_h1));
			sh_tg_h02_sum += Double.parseDouble(String.valueOf(sh_tg_h2));
			sh_tg_ytd_sum += Double.parseDouble(String.valueOf(sh_tg_ytd));

			list.get(i).put("sh_tg_p01_sum", sh_tg_p01_sum); list.get(i).put("sh_tg_p02_sum", sh_tg_p02_sum); list.get(i).put("sh_tg_p03_sum", sh_tg_p03_sum); list.get(i).put("sh_tg_p04_sum", sh_tg_p04_sum);
			list.get(i).put("sh_tg_p05_sum", sh_tg_p05_sum); list.get(i).put("sh_tg_p06_sum", sh_tg_p06_sum); list.get(i).put("sh_tg_p07_sum", sh_tg_p07_sum); list.get(i).put("sh_tg_p08_sum", sh_tg_p08_sum);
			list.get(i).put("sh_tg_p09_sum", sh_tg_p09_sum); list.get(i).put("sh_tg_p10_sum", sh_tg_p10_sum); list.get(i).put("sh_tg_p11_sum", sh_tg_p11_sum); list.get(i).put("sh_tg_p12_sum", sh_tg_p12_sum);
			list.get(i).put("sh_tg_q01_sum", sh_tg_q01_sum); list.get(i).put("sh_tg_q02_sum", sh_tg_q02_sum); list.get(i).put("sh_tg_q03_sum", sh_tg_q03_sum); list.get(i).put("sh_tg_q04_sum", sh_tg_q04_sum);
			list.get(i).put("sh_tg_h01_sum", sh_tg_h01_sum); list.get(i).put("sh_tg_h02_sum", sh_tg_h02_sum); list.get(i).put("sh_tg_ytd_sum", sh_tg_ytd_sum);

		}
		
		
		//row위치
		int count = 0;
		int tableRow = 0; //전체 리스트의 row수
		
		//레벨 카운트
		String DataLv2 = null; //lv2 구분
		int DataLv2Count = 0; //lv2 구분 별 갯수(ex: local=5, non int'l=4)
		int Lv2Count = 0; // lv2구분 갯수
		ArrayList<Map> countList2 = new ArrayList();
		Map countMap2 = new HashMap();
		
		for(int i=0; i<list.size(); i++) {
			if(i == 0) {																		/* DataLv2에 첫번째 DATALV2의 값을 입력 */
				DataLv2 = (String) list.get(0).get("DATALV2"); 
			}
			
			/**
			 * 전체 리스트를 돌며 lv2데이터 비교 각각의 구분에 따라 카운트함
			 * lv1과 lv2 total값 표시 부분은 공백 처리
			 */
			if(DataLv2.equals(list.get(i).get("DATALV2")) && i == (list.size()-1)) {
				DataLv2Count++;
				Lv2Count++;
				countMap2.put(Lv2Count, DataLv2Count);
				countList2.add(countMap2);
			}
			else if(DataLv2.equals(list.get(i).get("DATALV2"))) {
				DataLv2Count++;
			}
			else {
				Lv2Count++;
				countMap2.put(Lv2Count, DataLv2Count);
				countList2.add(countMap2);
				DataLv2 = (String) list.get(i).get("DATALV2");
				DataLv2Count = 1;
			}

			if(i == list.size()-1){
				Lv2Count++;
				countMap2.put(Lv2Count, DataLv2Count);
				countList2.add(countMap2);
			}
			
		}
		
		/**
		 * shipment forecast
		 * lv1과 lv2 total값 표시 부분은 공백 처리
		 */
		int lv1Sum = 0; // lv1 total row 위치
		int lv2List = 0; // lv2 list count
		int currentRow = 0;
		
		/* 상단 테이블 Actual , foreCast 소계 및 합계 */
		double lv1_sh_ac_p01_sum = 0; double lv1_sh_ac_p02_sum = 0; double lv1_sh_ac_p03_sum = 0; double lv1_sh_ac_p04_sum = 0; double lv1_sh_ac_p05_sum = 0; double lv1_sh_ac_p06_sum = 0;
		double lv1_sh_ac_p07_sum = 0; double lv1_sh_ac_p08_sum = 0; double lv1_sh_ac_p09_sum = 0; double lv1_sh_ac_p10_sum = 0; double lv1_sh_ac_p11_sum = 0; double lv1_sh_ac_p12_sum = 0;
		double lv1_sh_ac_q01_sum = 0; double lv1_sh_ac_q02_sum = 0; double lv1_sh_ac_q03_sum = 0; double lv1_sh_ac_q04_sum = 0; double lv1_sh_ac_h01_sum = 0; double lv1_sh_ac_h02_sum = 0; double lv1_sh_ac_ytd_sum = 0;

		double lv1_sh_for_p01_sum = 0; double lv1_sh_for_p02_sum = 0; double lv1_sh_for_p03_sum = 0; double lv1_sh_for_p04_sum = 0; double lv1_sh_for_p05_sum = 0; double lv1_sh_for_p06_sum = 0;
		double lv1_sh_for_p07_sum = 0; double lv1_sh_for_p08_sum = 0; double lv1_sh_for_p09_sum = 0; double lv1_sh_for_p10_sum = 0; double lv1_sh_for_p11_sum = 0; double lv1_sh_for_p12_sum = 0;
		double lv1_sh_for_q01_sum = 0; double lv1_sh_for_q02_sum = 0; double lv1_sh_for_q03_sum = 0; double lv1_sh_for_q04_sum = 0; double lv1_sh_for_h01_sum = 0; double lv1_sh_for_h02_sum = 0; double lv1_sh_for_ytd_sum = 0;

		double lv2_sh_ac_p01_sum = 0; double lv2_sh_ac_p02_sum = 0; double lv2_sh_ac_p03_sum = 0; double lv2_sh_ac_p04_sum = 0; double lv2_sh_ac_p05_sum = 0; double lv2_sh_ac_p06_sum = 0;
		double lv2_sh_ac_p07_sum = 0; double lv2_sh_ac_p08_sum = 0; double lv2_sh_ac_p09_sum = 0; double lv2_sh_ac_p10_sum = 0; double lv2_sh_ac_p11_sum = 0; double lv2_sh_ac_p12_sum = 0;
		double lv2_sh_ac_q01_sum = 0; double lv2_sh_ac_q02_sum = 0; double lv2_sh_ac_q03_sum = 0; double lv2_sh_ac_q04_sum = 0; double lv2_sh_ac_h01_sum = 0; double lv2_sh_ac_h02_sum = 0; double lv2_sh_ac_ytd_sum = 0;

		double lv2_sh_for_p01_sum = 0; double lv2_sh_for_p02_sum = 0; double lv2_sh_for_p03_sum = 0; double lv2_sh_for_p04_sum = 0; double lv2_sh_for_p05_sum = 0; double lv2_sh_for_p06_sum = 0;
		double lv2_sh_for_p07_sum = 0; double lv2_sh_for_p08_sum = 0; double lv2_sh_for_p09_sum = 0; double lv2_sh_for_p10_sum = 0; double lv2_sh_for_p11_sum = 0; double lv2_sh_for_p12_sum = 0;
		double lv2_sh_for_q01_sum = 0; double lv2_sh_for_q02_sum = 0; double lv2_sh_for_q03_sum = 0; double lv2_sh_for_q04_sum = 0; double lv2_sh_for_h01_sum = 0; double lv2_sh_for_h02_sum = 0; double lv2_sh_for_ytd_sum = 0;
		
		/* 하단 테이블 Outlook , Target 소계 및 합계 */
		double lv1_sh_out_p01_sum = 0; double lv1_sh_out_p02_sum = 0; double lv1_sh_out_p03_sum = 0; double lv1_sh_out_p04_sum = 0; double lv1_sh_out_p05_sum = 0; double lv1_sh_out_p06_sum = 0;
		double lv1_sh_out_p07_sum = 0; double lv1_sh_out_p08_sum = 0; double lv1_sh_out_p09_sum = 0; double lv1_sh_out_p10_sum = 0; double lv1_sh_out_p11_sum = 0; double lv1_sh_out_p12_sum = 0;
		double lv1_sh_out_q01_sum = 0; double lv1_sh_out_q02_sum = 0; double lv1_sh_out_q03_sum = 0; double lv1_sh_out_q04_sum = 0; double lv1_sh_out_h01_sum = 0; double lv1_sh_out_h02_sum = 0; double lv1_sh_out_ytd_sum = 0;

		double lv1_sh_tg_p01_sum = 0; double lv1_sh_tg_p02_sum = 0; double lv1_sh_tg_p03_sum = 0; double lv1_sh_tg_p04_sum = 0; double lv1_sh_tg_p05_sum = 0; double lv1_sh_tg_p06_sum = 0;
		double lv1_sh_tg_p07_sum = 0; double lv1_sh_tg_p08_sum = 0; double lv1_sh_tg_p09_sum = 0; double lv1_sh_tg_p10_sum = 0; double lv1_sh_tg_p11_sum = 0; double lv1_sh_tg_p12_sum = 0;
		double lv1_sh_tg_q01_sum = 0; double lv1_sh_tg_q02_sum = 0; double lv1_sh_tg_q03_sum = 0; double lv1_sh_tg_q04_sum = 0; double lv1_sh_tg_h01_sum = 0; double lv1_sh_tg_h02_sum = 0; double lv1_sh_tg_ytd_sum = 0;

		double lv2_sh_out_p01_sum = 0; double lv2_sh_out_p02_sum = 0; double lv2_sh_out_p03_sum = 0; double lv2_sh_out_p04_sum = 0; double lv2_sh_out_p05_sum = 0; double lv2_sh_out_p06_sum = 0;
		double lv2_sh_out_p07_sum = 0; double lv2_sh_out_p08_sum = 0; double lv2_sh_out_p09_sum = 0; double lv2_sh_out_p10_sum = 0; double lv2_sh_out_p11_sum = 0; double lv2_sh_out_p12_sum = 0;
		double lv2_sh_out_q01_sum = 0; double lv2_sh_out_q02_sum = 0; double lv2_sh_out_q03_sum = 0; double lv2_sh_out_q04_sum = 0; double lv2_sh_out_h01_sum = 0; double lv2_sh_out_h02_sum = 0; double lv2_sh_out_ytd_sum = 0;

		double lv2_sh_tg_p01_sum = 0; double lv2_sh_tg_p02_sum = 0; double lv2_sh_tg_p03_sum = 0; double lv2_sh_tg_p04_sum = 0; double lv2_sh_tg_p05_sum = 0; double lv2_sh_tg_p06_sum = 0;
		double lv2_sh_tg_p07_sum = 0; double lv2_sh_tg_p08_sum = 0; double lv2_sh_tg_p09_sum = 0; double lv2_sh_tg_p10_sum = 0; double lv2_sh_tg_p11_sum = 0; double lv2_sh_tg_p12_sum = 0;
		double lv2_sh_tg_q01_sum = 0; double lv2_sh_tg_q02_sum = 0; double lv2_sh_tg_q03_sum = 0; double lv2_sh_tg_q04_sum = 0; double lv2_sh_tg_h01_sum = 0; double lv2_sh_tg_h02_sum = 0; double lv2_sh_tg_ytd_sum = 0;
		
		
		ArrayList<Map> shForeCast = new ArrayList<Map>();
		Map shForeCastMap = null;
		
		for(int i=0; i<countList2.size(); i++) {
			if(i < (countList2.size()/2)) {
				for(int x = 0; x<Integer.parseInt(String.valueOf(countList2.get(i).get(i+1))); x++) {
					lv1Sum++;
				}
			}
		}
		
		for(int j=0; j<countList2.size(); j++) {
			int lv2 = (Integer) countList2.get(j).get(j+1);
			
			for(int i=0; i<lv2; i++){  // lv1 구분 total값 표시
				if(lv2List == (lv1Sum-1) && i != 0){
					shForeCastMap = new HashMap();
					//Whisky INT`L Others의 값
					shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List).get("DATALV1_NM"));
					shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List).get("DATALV2_NM"));
					shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List).get("DATALV3_NM"));
					shForeCastMap.put("SH_AC_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P01"))));
					shForeCastMap.put("SH_AC_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P02"))));
					shForeCastMap.put("SH_AC_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P03"))));
					shForeCastMap.put("SH_AC_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P04"))));
					shForeCastMap.put("SH_AC_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P05"))));
					shForeCastMap.put("SH_AC_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P06"))));
					shForeCastMap.put("SH_AC_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P07"))));
					shForeCastMap.put("SH_AC_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P08"))));
					shForeCastMap.put("SH_AC_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P09"))));
					shForeCastMap.put("SH_AC_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P10"))));
					shForeCastMap.put("SH_AC_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P11"))));
					shForeCastMap.put("SH_AC_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P12"))));
					shForeCastMap.put("SH_AC_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q1"))));
					shForeCastMap.put("SH_AC_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q2"))));
					shForeCastMap.put("SH_AC_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q3"))));
					shForeCastMap.put("SH_AC_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q4"))));
					shForeCastMap.put("SH_AC_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H1"))));
					shForeCastMap.put("SH_AC_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H2"))));
					shForeCastMap.put("SH_AC_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_YTD"))));
					shForeCastMap.put("SH_FOR_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P01"))));
					shForeCastMap.put("SH_FOR_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P02"))));
					shForeCastMap.put("SH_FOR_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P03"))));
					shForeCastMap.put("SH_FOR_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P04"))));
					shForeCastMap.put("SH_FOR_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P05"))));
					shForeCastMap.put("SH_FOR_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P06"))));
					shForeCastMap.put("SH_FOR_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P07"))));
					shForeCastMap.put("SH_FOR_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P08"))));
					shForeCastMap.put("SH_FOR_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P09"))));
					shForeCastMap.put("SH_FOR_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P10"))));
					shForeCastMap.put("SH_FOR_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P11"))));
					shForeCastMap.put("SH_FOR_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P12"))));
					shForeCastMap.put("SH_FOR_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q1"))));
					shForeCastMap.put("SH_FOR_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q2"))));
					shForeCastMap.put("SH_FOR_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q3"))));
					shForeCastMap.put("SH_FOR_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q4"))));
					shForeCastMap.put("SH_FOR_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H1"))));
					shForeCastMap.put("SH_FOR_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H2"))));
					shForeCastMap.put("SH_FOR_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_YTD"))));
					
					//sh forecast(Outlook)
					shForeCastMap.put("SH_OUT_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P01"))));
					shForeCastMap.put("SH_OUT_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P02"))));
					shForeCastMap.put("SH_OUT_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P03"))));
					shForeCastMap.put("SH_OUT_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P04"))));
					shForeCastMap.put("SH_OUT_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P05"))));
					shForeCastMap.put("SH_OUT_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P06"))));
					shForeCastMap.put("SH_OUT_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P07"))));
					shForeCastMap.put("SH_OUT_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P08"))));
					shForeCastMap.put("SH_OUT_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P09"))));
					shForeCastMap.put("SH_OUT_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P10"))));
					shForeCastMap.put("SH_OUT_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P11"))));
					shForeCastMap.put("SH_OUT_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P12"))));
					shForeCastMap.put("SH_OUT_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q1"))));
					shForeCastMap.put("SH_OUT_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q2"))));
					shForeCastMap.put("SH_OUT_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q3"))));
					shForeCastMap.put("SH_OUT_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q4"))));
					shForeCastMap.put("SH_OUT_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H1"))));
					shForeCastMap.put("SH_OUT_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H2"))));
					shForeCastMap.put("SH_OUT_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_YTD"))));
					shForeCastMap.put("SH_TG_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P01"))));
					shForeCastMap.put("SH_TG_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P02"))));
					shForeCastMap.put("SH_TG_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P03"))));
					shForeCastMap.put("SH_TG_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P04"))));
					shForeCastMap.put("SH_TG_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P05"))));
					shForeCastMap.put("SH_TG_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P06"))));
					shForeCastMap.put("SH_TG_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P07"))));
					shForeCastMap.put("SH_TG_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P08"))));
					shForeCastMap.put("SH_TG_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P09"))));
					shForeCastMap.put("SH_TG_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P10"))));
					shForeCastMap.put("SH_TG_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P11"))));
					shForeCastMap.put("SH_TG_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P12"))));
					shForeCastMap.put("SH_TG_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q1"))));
					shForeCastMap.put("SH_TG_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q2"))));
					shForeCastMap.put("SH_TG_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q3"))));
					shForeCastMap.put("SH_TG_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q4"))));
					shForeCastMap.put("SH_TG_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H1"))));
					shForeCastMap.put("SH_TG_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H2"))));
					shForeCastMap.put("SH_TG_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_YTD"))));
					
					shForeCast.add(shForeCastMap);
					
					lv1_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P01")));
					lv1_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P02")));
					lv1_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P03")));
					lv1_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P04")));
					lv1_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P05")));
					lv1_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P06")));
					lv1_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P07")));
					lv1_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P08")));
					lv1_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P09")));
					lv1_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P10")));
					lv1_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P11")));
					lv1_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P12")));
					lv1_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q1")));
					lv1_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q2")));
					lv1_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q3")));
					lv1_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q4")));
					lv1_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H1")));
					lv1_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H2")));
					lv1_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_YTD")));

					lv1_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P01")));
					lv1_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P02")));
					lv1_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P03")));
					lv1_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P04")));
					lv1_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P05")));
					lv1_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P06")));
					lv1_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P07")));
					lv1_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P08")));
					lv1_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P09")));
					lv1_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P10")));
					lv1_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P11")));
					lv1_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P12")));
					lv1_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q1")));
					lv1_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q2")));
					lv1_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q3")));
					lv1_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q4")));
					lv1_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H1")));
					lv1_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H2")));
					lv1_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_YTD")));
					
					lv2_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P01")));
					lv2_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P02")));
					lv2_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P03")));
					lv2_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P04")));
					lv2_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P05")));
					lv2_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P06")));
					lv2_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P07")));
					lv2_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P08")));
					lv2_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P09")));
					lv2_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P10")));
					lv2_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P11")));
					lv2_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P12")));
					lv2_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q1")));
					lv2_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q2")));
					lv2_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q3")));
					lv2_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q4")));
					lv2_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H1")));
					lv2_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H2")));
					lv2_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_YTD")));

					lv2_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P01")));
					lv2_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P02")));
					lv2_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P03")));
					lv2_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P04")));
					lv2_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P05")));
					lv2_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P06")));
					lv2_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P07")));
					lv2_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P08")));
					lv2_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P09")));
					lv2_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P10")));
					lv2_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P11")));
					lv2_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P12")));
					lv2_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q1")));
					lv2_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q2")));
					lv2_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q3")));
					lv2_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q4")));
					lv2_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H1")));
					lv2_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H2")));
					lv2_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_YTD")));
					
					//sh forecast(outlook)
					lv1_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P01")));
					lv1_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P02")));
					lv1_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P03")));
					lv1_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P04")));
					lv1_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P05")));
					lv1_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P06")));
					lv1_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P07")));
					lv1_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P08")));
					lv1_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P09")));
					lv1_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P10")));
					lv1_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P11")));
					lv1_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P12")));
					lv1_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q1")));
					lv1_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q2")));
					lv1_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q3")));
					lv1_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q4")));
					lv1_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H1")));
					lv1_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H2")));
					lv1_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_YTD")));
					
					lv1_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P01")));
					lv1_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P02")));
					lv1_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P03")));
					lv1_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P04")));
					lv1_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P05")));
					lv1_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P06")));
					lv1_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P07")));
					lv1_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P08")));
					lv1_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P09")));
					lv1_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P10")));
					lv1_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P11")));
					lv1_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P12")));
					lv1_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q1")));
					lv1_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q2")));
					lv1_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q3")));
					lv1_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q4")));
					lv1_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H1")));
					lv1_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H2")));
					lv1_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_YTD")));
					
					lv2_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P01")));
					lv2_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P02")));
					lv2_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P03")));
					lv2_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P04")));
					lv2_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P05")));
					lv2_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P06")));
					lv2_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P07")));
					lv2_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P08")));
					lv2_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P09")));
					lv2_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P10")));
					lv2_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P11")));
					lv2_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P12")));
					lv2_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q1")));
					lv2_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q2")));
					lv2_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q3")));
					lv2_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q4")));
					lv2_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H1")));
					lv2_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H2")));
					lv2_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_YTD")));

					lv2_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P01")));
					lv2_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P02")));
					lv2_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P03")));
					lv2_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P04")));
					lv2_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P05")));
					lv2_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P06")));
					lv2_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P07")));
					lv2_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P08")));
					lv2_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P09")));
					lv2_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P10")));
					lv2_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P11")));
					lv2_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P12")));
					lv2_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q1")));
					lv2_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q2")));
					lv2_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q3")));
					lv2_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q4")));
					lv2_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H1")));
					lv2_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H2")));
					lv2_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_YTD")));
					
					shForeCastMap = new HashMap();
					
					// Whisky INT`L 합계
					shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List).get("DATALV1_NM"));
					shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List).get("DATALV2_NM"));
					shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List).get("DATALV2_NM")+" 합계");
					shForeCastMap.put("SH_AC_P01", lv2_sh_ac_p01_sum);
					shForeCastMap.put("SH_AC_P02", lv2_sh_ac_p02_sum);
					shForeCastMap.put("SH_AC_P03", lv2_sh_ac_p03_sum);
					shForeCastMap.put("SH_AC_P04", lv2_sh_ac_p04_sum);
					shForeCastMap.put("SH_AC_P05", lv2_sh_ac_p05_sum);
					shForeCastMap.put("SH_AC_P06", lv2_sh_ac_p06_sum);
					shForeCastMap.put("SH_AC_P07", lv2_sh_ac_p07_sum);
					shForeCastMap.put("SH_AC_P08", lv2_sh_ac_p08_sum);
					shForeCastMap.put("SH_AC_P09", lv2_sh_ac_p09_sum);
					shForeCastMap.put("SH_AC_P10", lv2_sh_ac_p10_sum);
					shForeCastMap.put("SH_AC_P11", lv2_sh_ac_p11_sum);
					shForeCastMap.put("SH_AC_P12", lv2_sh_ac_p12_sum);
					shForeCastMap.put("SH_AC_Q01", lv2_sh_ac_q01_sum);
					shForeCastMap.put("SH_AC_Q02", lv2_sh_ac_q02_sum);
					shForeCastMap.put("SH_AC_Q03", lv2_sh_ac_q03_sum);
					shForeCastMap.put("SH_AC_Q04", lv2_sh_ac_q04_sum);
					shForeCastMap.put("SH_AC_H01", lv2_sh_ac_h01_sum);
					shForeCastMap.put("SH_AC_H02", lv2_sh_ac_h02_sum);
					shForeCastMap.put("SH_AC_YTD", lv2_sh_ac_ytd_sum);
					shForeCastMap.put("SH_FOR_P01", lv2_sh_for_p01_sum);
					shForeCastMap.put("SH_FOR_P02", lv2_sh_for_p02_sum);
					shForeCastMap.put("SH_FOR_P03", lv2_sh_for_p03_sum);
					shForeCastMap.put("SH_FOR_P04", lv2_sh_for_p04_sum);
					shForeCastMap.put("SH_FOR_P05", lv2_sh_for_p05_sum);
					shForeCastMap.put("SH_FOR_P06", lv2_sh_for_p06_sum);
					shForeCastMap.put("SH_FOR_P07", lv2_sh_for_p07_sum);
					shForeCastMap.put("SH_FOR_P08", lv2_sh_for_p08_sum);
					shForeCastMap.put("SH_FOR_P09", lv2_sh_for_p09_sum);
					shForeCastMap.put("SH_FOR_P10", lv2_sh_for_p10_sum);
					shForeCastMap.put("SH_FOR_P11", lv2_sh_for_p11_sum);
					shForeCastMap.put("SH_FOR_P12", lv2_sh_for_p12_sum);
					shForeCastMap.put("SH_FOR_Q01", lv2_sh_for_q01_sum);
					shForeCastMap.put("SH_FOR_Q02", lv2_sh_for_q02_sum);
					shForeCastMap.put("SH_FOR_Q03", lv2_sh_for_q03_sum);
					shForeCastMap.put("SH_FOR_Q04", lv2_sh_for_q04_sum);
					shForeCastMap.put("SH_FOR_H01", lv2_sh_for_h01_sum);
					shForeCastMap.put("SH_FOR_H02", lv2_sh_for_h02_sum);
					shForeCastMap.put("SH_FOR_YTD", lv2_sh_for_ytd_sum);
					
					//sh Forecast(outlook)
					shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List).get("DATALV1_NM"));
					shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List).get("DATALV2_NM"));
					shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List).get("DATALV2_NM")+" 합계");
					shForeCastMap.put("SH_OUT_P01", lv2_sh_out_p01_sum);
					shForeCastMap.put("SH_OUT_P02", lv2_sh_out_p02_sum);
					shForeCastMap.put("SH_OUT_P03", lv2_sh_out_p03_sum);
					shForeCastMap.put("SH_OUT_P04", lv2_sh_out_p04_sum);
					shForeCastMap.put("SH_OUT_P05", lv2_sh_out_p05_sum);
					shForeCastMap.put("SH_OUT_P06", lv2_sh_out_p06_sum);
					shForeCastMap.put("SH_OUT_P07", lv2_sh_out_p07_sum);
					shForeCastMap.put("SH_OUT_P08", lv2_sh_out_p08_sum);
					shForeCastMap.put("SH_OUT_P09", lv2_sh_out_p09_sum);
					shForeCastMap.put("SH_OUT_P10", lv2_sh_out_p10_sum);
					shForeCastMap.put("SH_OUT_P11", lv2_sh_out_p11_sum);
					shForeCastMap.put("SH_OUT_P12", lv2_sh_out_p12_sum);
					shForeCastMap.put("SH_OUT_Q01", lv2_sh_out_q01_sum);
					shForeCastMap.put("SH_OUT_Q02", lv2_sh_out_q02_sum);
					shForeCastMap.put("SH_OUT_Q03", lv2_sh_out_q03_sum);
					shForeCastMap.put("SH_OUT_Q04", lv2_sh_out_q04_sum);
					shForeCastMap.put("SH_OUT_H01", lv2_sh_out_h01_sum);
					shForeCastMap.put("SH_OUT_H02", lv2_sh_out_h02_sum);
					shForeCastMap.put("SH_OUT_YTD", lv2_sh_out_ytd_sum);
					shForeCastMap.put("SH_TG_P01", lv2_sh_tg_p01_sum);
					shForeCastMap.put("SH_TG_P02", lv2_sh_tg_p02_sum);
					shForeCastMap.put("SH_TG_P03", lv2_sh_tg_p03_sum);
					shForeCastMap.put("SH_TG_P04", lv2_sh_tg_p04_sum);
					shForeCastMap.put("SH_TG_P05", lv2_sh_tg_p05_sum);
					shForeCastMap.put("SH_TG_P06", lv2_sh_tg_p06_sum);
					shForeCastMap.put("SH_TG_P07", lv2_sh_tg_p07_sum);
					shForeCastMap.put("SH_TG_P08", lv2_sh_tg_p08_sum);
					shForeCastMap.put("SH_TG_P09", lv2_sh_tg_p09_sum);
					shForeCastMap.put("SH_TG_P10", lv2_sh_tg_p10_sum);
					shForeCastMap.put("SH_TG_P11", lv2_sh_tg_p11_sum);
					shForeCastMap.put("SH_TG_P12", lv2_sh_tg_p12_sum);
					shForeCastMap.put("SH_TG_Q01", lv2_sh_tg_q01_sum);
					shForeCastMap.put("SH_TG_Q02", lv2_sh_tg_q02_sum);
					shForeCastMap.put("SH_TG_Q03", lv2_sh_tg_q03_sum);
					shForeCastMap.put("SH_TG_Q04", lv2_sh_tg_q04_sum);
					shForeCastMap.put("SH_TG_H01", lv2_sh_tg_h01_sum);
					shForeCastMap.put("SH_TG_H02", lv2_sh_tg_h02_sum);
					shForeCastMap.put("SH_TG_YTD", lv2_sh_tg_ytd_sum);
					
					shForeCast.add(shForeCastMap);
					
					lv2_sh_ac_p01_sum = 0;
					lv2_sh_ac_p02_sum = 0;
					lv2_sh_ac_p03_sum = 0;
					lv2_sh_ac_p04_sum = 0;
					lv2_sh_ac_p05_sum = 0;
					lv2_sh_ac_p06_sum = 0;
					lv2_sh_ac_p07_sum = 0;
					lv2_sh_ac_p08_sum = 0;
					lv2_sh_ac_p09_sum = 0;
					lv2_sh_ac_p10_sum = 0;
					lv2_sh_ac_p11_sum = 0;
					lv2_sh_ac_p12_sum = 0;
					lv2_sh_ac_q01_sum = 0;
					lv2_sh_ac_q02_sum = 0;
					lv2_sh_ac_q03_sum = 0;
					lv2_sh_ac_q04_sum = 0;
					lv2_sh_ac_h01_sum = 0;
					lv2_sh_ac_h02_sum = 0;
					lv2_sh_ac_ytd_sum = 0;
					
					lv2_sh_for_p01_sum = 0;
					lv2_sh_for_p02_sum = 0;
					lv2_sh_for_p03_sum = 0;
					lv2_sh_for_p04_sum = 0;
					lv2_sh_for_p05_sum = 0;
					lv2_sh_for_p06_sum = 0;
					lv2_sh_for_p07_sum = 0;
					lv2_sh_for_p08_sum = 0;
					lv2_sh_for_p09_sum = 0;
					lv2_sh_for_p10_sum = 0;
					lv2_sh_for_p11_sum = 0;
					lv2_sh_for_p12_sum = 0;
					lv2_sh_for_q01_sum = 0;
					lv2_sh_for_q02_sum = 0;
					lv2_sh_for_q03_sum = 0;
					lv2_sh_for_q04_sum = 0;
					lv2_sh_for_h01_sum = 0;
					lv2_sh_for_h02_sum = 0;
					lv2_sh_for_ytd_sum = 0;
					
					lv2_sh_out_p01_sum = 0;
					lv2_sh_out_p02_sum = 0;
					lv2_sh_out_p03_sum = 0;
					lv2_sh_out_p04_sum = 0;
					lv2_sh_out_p05_sum = 0;
					lv2_sh_out_p06_sum = 0;
					lv2_sh_out_p07_sum = 0;
					lv2_sh_out_p08_sum = 0;
					lv2_sh_out_p09_sum = 0;
					lv2_sh_out_p10_sum = 0;
					lv2_sh_out_p11_sum = 0;
					lv2_sh_out_p12_sum = 0;
					lv2_sh_out_q01_sum = 0;
					lv2_sh_out_q02_sum = 0;
					lv2_sh_out_q03_sum = 0;
					lv2_sh_out_q04_sum = 0;
					lv2_sh_out_h01_sum = 0;
					lv2_sh_out_h02_sum = 0;
					lv2_sh_out_ytd_sum = 0;

					lv2_sh_tg_p01_sum = 0;
					lv2_sh_tg_p02_sum = 0;
					lv2_sh_tg_p03_sum = 0;
					lv2_sh_tg_p04_sum = 0;
					lv2_sh_tg_p05_sum = 0;
					lv2_sh_tg_p06_sum = 0;
					lv2_sh_tg_p07_sum = 0;
					lv2_sh_tg_p08_sum = 0;
					lv2_sh_tg_p09_sum = 0;
					lv2_sh_tg_p10_sum = 0;
					lv2_sh_tg_p11_sum = 0;
					lv2_sh_tg_p12_sum = 0;
					lv2_sh_tg_q01_sum = 0;
					lv2_sh_tg_q02_sum = 0;
					lv2_sh_tg_q03_sum = 0;
					lv2_sh_tg_q04_sum = 0;
					lv2_sh_tg_h01_sum = 0;
					lv2_sh_tg_h02_sum = 0;
					lv2_sh_tg_ytd_sum = 0;
					
					shForeCastMap = new HashMap();
					
					// Whisky 합계 18Line
					shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List).get("DATALV1_NM"));
					shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List).get("DATALV1_NM")+" 합계");
					shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List).get("DATALV1_NM")+" 합계");
					shForeCastMap.put("SH_AC_P01", lv1_sh_ac_p01_sum);
					shForeCastMap.put("SH_AC_P02", lv1_sh_ac_p02_sum);
					shForeCastMap.put("SH_AC_P03", lv1_sh_ac_p03_sum);
					shForeCastMap.put("SH_AC_P04", lv1_sh_ac_p04_sum);
					shForeCastMap.put("SH_AC_P05", lv1_sh_ac_p05_sum);
					shForeCastMap.put("SH_AC_P06", lv1_sh_ac_p06_sum);
					shForeCastMap.put("SH_AC_P07", lv1_sh_ac_p07_sum);
					shForeCastMap.put("SH_AC_P08", lv1_sh_ac_p08_sum);
					shForeCastMap.put("SH_AC_P09", lv1_sh_ac_p09_sum);
					shForeCastMap.put("SH_AC_P10", lv1_sh_ac_p10_sum);
					shForeCastMap.put("SH_AC_P11", lv1_sh_ac_p11_sum);
					shForeCastMap.put("SH_AC_P12", lv1_sh_ac_p12_sum);
					shForeCastMap.put("SH_AC_Q01", lv1_sh_ac_q01_sum);
					shForeCastMap.put("SH_AC_Q02", lv1_sh_ac_q02_sum);
					shForeCastMap.put("SH_AC_Q03", lv1_sh_ac_q03_sum);
					shForeCastMap.put("SH_AC_Q04", lv1_sh_ac_q04_sum);
					shForeCastMap.put("SH_AC_H01", lv1_sh_ac_h01_sum);
					shForeCastMap.put("SH_AC_H02", lv1_sh_ac_h02_sum);
					shForeCastMap.put("SH_AC_YTD", lv1_sh_ac_ytd_sum);
					shForeCastMap.put("SH_FOR_P01", lv1_sh_for_p01_sum);
					shForeCastMap.put("SH_FOR_P02", lv1_sh_for_p02_sum);
					shForeCastMap.put("SH_FOR_P03", lv1_sh_for_p03_sum);
					shForeCastMap.put("SH_FOR_P04", lv1_sh_for_p04_sum);
					shForeCastMap.put("SH_FOR_P05", lv1_sh_for_p05_sum);
					shForeCastMap.put("SH_FOR_P06", lv1_sh_for_p06_sum);
					shForeCastMap.put("SH_FOR_P07", lv1_sh_for_p07_sum);
					shForeCastMap.put("SH_FOR_P08", lv1_sh_for_p08_sum);
					shForeCastMap.put("SH_FOR_P09", lv1_sh_for_p09_sum);
					shForeCastMap.put("SH_FOR_P10", lv1_sh_for_p10_sum);
					shForeCastMap.put("SH_FOR_P11", lv1_sh_for_p11_sum);
					shForeCastMap.put("SH_FOR_P12", lv1_sh_for_p12_sum);
					shForeCastMap.put("SH_FOR_Q01", lv1_sh_for_q01_sum);
					shForeCastMap.put("SH_FOR_Q02", lv1_sh_for_q02_sum);
					shForeCastMap.put("SH_FOR_Q03", lv1_sh_for_q03_sum);
					shForeCastMap.put("SH_FOR_Q04", lv1_sh_for_q04_sum);
					shForeCastMap.put("SH_FOR_H01", lv1_sh_for_h01_sum);
					shForeCastMap.put("SH_FOR_H02", lv1_sh_for_h02_sum);
					shForeCastMap.put("SH_FOR_YTD", lv1_sh_for_ytd_sum);
					
					//sh Forecast(outlook)
					shForeCastMap.put("SH_OUT_P01", lv1_sh_out_p01_sum);
					shForeCastMap.put("SH_OUT_P02", lv1_sh_out_p02_sum);
					shForeCastMap.put("SH_OUT_P03", lv1_sh_out_p03_sum);
					shForeCastMap.put("SH_OUT_P04", lv1_sh_out_p04_sum);
					shForeCastMap.put("SH_OUT_P05", lv1_sh_out_p05_sum);
					shForeCastMap.put("SH_OUT_P06", lv1_sh_out_p06_sum);
					shForeCastMap.put("SH_OUT_P07", lv1_sh_out_p07_sum);
					shForeCastMap.put("SH_OUT_P08", lv1_sh_out_p08_sum);
					shForeCastMap.put("SH_OUT_P09", lv1_sh_out_p09_sum);
					shForeCastMap.put("SH_OUT_P10", lv1_sh_out_p10_sum);
					shForeCastMap.put("SH_OUT_P11", lv1_sh_out_p11_sum);
					shForeCastMap.put("SH_OUT_P12", lv1_sh_out_p12_sum);
					shForeCastMap.put("SH_OUT_Q01", lv1_sh_out_q01_sum);
					shForeCastMap.put("SH_OUT_Q02", lv1_sh_out_q02_sum);
					shForeCastMap.put("SH_OUT_Q03", lv1_sh_out_q03_sum);
					shForeCastMap.put("SH_OUT_Q04", lv1_sh_out_q04_sum);
					shForeCastMap.put("SH_OUT_H01", lv1_sh_out_h01_sum);
					shForeCastMap.put("SH_OUT_H02", lv1_sh_out_h02_sum);
					shForeCastMap.put("SH_OUT_YTD", lv1_sh_out_ytd_sum);
					shForeCastMap.put("SH_TG_P01", lv1_sh_tg_p01_sum);
					shForeCastMap.put("SH_TG_P02", lv1_sh_tg_p02_sum);
					shForeCastMap.put("SH_TG_P03", lv1_sh_tg_p03_sum);
					shForeCastMap.put("SH_TG_P04", lv1_sh_tg_p04_sum);
					shForeCastMap.put("SH_TG_P05", lv1_sh_tg_p05_sum);
					shForeCastMap.put("SH_TG_P06", lv1_sh_tg_p06_sum);
					shForeCastMap.put("SH_TG_P07", lv1_sh_tg_p07_sum);
					shForeCastMap.put("SH_TG_P08", lv1_sh_tg_p08_sum);
					shForeCastMap.put("SH_TG_P09", lv1_sh_tg_p09_sum);
					shForeCastMap.put("SH_TG_P10", lv1_sh_tg_p10_sum);
					shForeCastMap.put("SH_TG_P11", lv1_sh_tg_p11_sum);
					shForeCastMap.put("SH_TG_P12", lv1_sh_tg_p12_sum);
					shForeCastMap.put("SH_TG_Q01", lv1_sh_tg_q01_sum);
					shForeCastMap.put("SH_TG_Q02", lv1_sh_tg_q02_sum);
					shForeCastMap.put("SH_TG_Q03", lv1_sh_tg_q03_sum);
					shForeCastMap.put("SH_TG_Q04", lv1_sh_tg_q04_sum);
					shForeCastMap.put("SH_TG_H01", lv1_sh_tg_h01_sum);
					shForeCastMap.put("SH_TG_H02", lv1_sh_tg_h02_sum);
					shForeCastMap.put("SH_TG_YTD", lv1_sh_tg_ytd_sum);
					
					shForeCast.add(shForeCastMap);
					
					lv1_sh_ac_p01_sum = 0;
					lv1_sh_ac_p02_sum = 0;
					lv1_sh_ac_p03_sum = 0;
					lv1_sh_ac_p04_sum = 0;
					lv1_sh_ac_p05_sum = 0;
					lv1_sh_ac_p06_sum = 0;
					lv1_sh_ac_p07_sum = 0;
					lv1_sh_ac_p08_sum = 0;
					lv1_sh_ac_p09_sum = 0;
					lv1_sh_ac_p10_sum = 0;
					lv1_sh_ac_p11_sum = 0;
					lv1_sh_ac_p12_sum = 0;
					lv1_sh_ac_q01_sum = 0;
					lv1_sh_ac_q02_sum = 0;
					lv1_sh_ac_q03_sum = 0;
					lv1_sh_ac_q04_sum = 0;
					lv1_sh_ac_h01_sum = 0;
					lv1_sh_ac_h02_sum = 0;
					lv1_sh_ac_ytd_sum = 0;
					
					lv1_sh_for_p01_sum = 0;
					lv1_sh_for_p02_sum = 0;
					lv1_sh_for_p03_sum = 0;
					lv1_sh_for_p04_sum = 0;
					lv1_sh_for_p05_sum = 0;
					lv1_sh_for_p06_sum = 0;
					lv1_sh_for_p07_sum = 0;
					lv1_sh_for_p08_sum = 0;
					lv1_sh_for_p09_sum = 0;
					lv1_sh_for_p10_sum = 0;
					lv1_sh_for_p11_sum = 0;
					lv1_sh_for_p12_sum = 0;
					lv1_sh_for_q01_sum = 0;
					lv1_sh_for_q02_sum = 0;
					lv1_sh_for_q03_sum = 0;
					lv1_sh_for_q04_sum = 0;
					lv1_sh_for_h01_sum = 0;
					lv1_sh_for_h02_sum = 0;
					lv1_sh_for_ytd_sum = 0;
					
				}
				else if(i == (lv2-1)) { // lv2 구분 total값 표시
					if(j == 0) {
						shForeCastMap = new HashMap();
						
						//Whisky Local Others
						shForeCastMap.put("DATALV1_NM", (String)list.get(i).get("DATALV1_NM"));
						shForeCastMap.put("DATALV2_NM", (String)list.get(i).get("DATALV2_NM"));
						shForeCastMap.put("DATALV3_NM", (String)list.get(i).get("DATALV3_NM"));
						shForeCastMap.put("SH_AC_P01", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P01"))));
						shForeCastMap.put("SH_AC_P02", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P02"))));
						shForeCastMap.put("SH_AC_P03", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P03"))));
						shForeCastMap.put("SH_AC_P04", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P04"))));
						shForeCastMap.put("SH_AC_P05", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P05"))));
						shForeCastMap.put("SH_AC_P06", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P06"))));
						shForeCastMap.put("SH_AC_P07", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P07"))));
						shForeCastMap.put("SH_AC_P08", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P08"))));
						shForeCastMap.put("SH_AC_P09", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P09"))));
						shForeCastMap.put("SH_AC_P10", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P10"))));
						shForeCastMap.put("SH_AC_P11", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P11"))));
						shForeCastMap.put("SH_AC_P12", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P12"))));
						shForeCastMap.put("SH_AC_Q01", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q1"))));
						shForeCastMap.put("SH_AC_Q02", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q2"))));
						shForeCastMap.put("SH_AC_Q03", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q3"))));
						shForeCastMap.put("SH_AC_Q04", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q4"))));
						shForeCastMap.put("SH_AC_H01", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H1"))));
						shForeCastMap.put("SH_AC_H02", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H2"))));
						shForeCastMap.put("SH_AC_YTD", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_YTD"))));
						shForeCastMap.put("SH_FOR_P01", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P01"))));
						shForeCastMap.put("SH_FOR_P02", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P02"))));
						shForeCastMap.put("SH_FOR_P03", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P03"))));
						shForeCastMap.put("SH_FOR_P04", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P04"))));
						shForeCastMap.put("SH_FOR_P05", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P05"))));
						shForeCastMap.put("SH_FOR_P06", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P06"))));
						shForeCastMap.put("SH_FOR_P07", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P07"))));
						shForeCastMap.put("SH_FOR_P08", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P08"))));
						shForeCastMap.put("SH_FOR_P09", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P09"))));
						shForeCastMap.put("SH_FOR_P10", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P10"))));
						shForeCastMap.put("SH_FOR_P11", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P11"))));
						shForeCastMap.put("SH_FOR_P12", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P12"))));
						shForeCastMap.put("SH_FOR_Q01", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q1"))));
						shForeCastMap.put("SH_FOR_Q02", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q2"))));
						shForeCastMap.put("SH_FOR_Q03", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q3"))));
						shForeCastMap.put("SH_FOR_Q04", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q4"))));
						shForeCastMap.put("SH_FOR_H01", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H1"))));
						shForeCastMap.put("SH_FOR_H02", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H2"))));
						shForeCastMap.put("SH_FOR_YTD", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_YTD"))));
						
						//sh forcast(outlook)
						shForeCastMap.put("DATALV1_NM", String.valueOf(list.get(i).get("DATALV1_NM")));
						shForeCastMap.put("DATALV2_NM", String.valueOf(list.get(i).get("DATALV2_NM")));
						shForeCastMap.put("DATALV3_NM", String.valueOf(list.get(i).get("DATALV3_NM")));
						shForeCastMap.put("SH_OUT_P01", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01"))));
						shForeCastMap.put("SH_OUT_P02", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02"))));
						shForeCastMap.put("SH_OUT_P03", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03"))));
						shForeCastMap.put("SH_OUT_P04", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04"))));
						shForeCastMap.put("SH_OUT_P05", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05"))));
						shForeCastMap.put("SH_OUT_P06", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06"))));
						shForeCastMap.put("SH_OUT_P07", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07"))));
						shForeCastMap.put("SH_OUT_P08", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08"))));
						shForeCastMap.put("SH_OUT_P09", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09"))));
						shForeCastMap.put("SH_OUT_P10", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10"))));
						shForeCastMap.put("SH_OUT_P11", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11"))));
						shForeCastMap.put("SH_OUT_P12", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12"))));
						shForeCastMap.put("SH_OUT_Q01", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q1"))));
						shForeCastMap.put("SH_OUT_Q02", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q2"))));
						shForeCastMap.put("SH_OUT_Q03", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q3"))));
						shForeCastMap.put("SH_OUT_Q04", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q4"))));
						shForeCastMap.put("SH_OUT_H01", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H1"))));
						shForeCastMap.put("SH_OUT_H02", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H2"))));
						shForeCastMap.put("SH_OUT_YTD", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_YTD"))));
						shForeCastMap.put("SH_TG_P01", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01"))));
						shForeCastMap.put("SH_TG_P02", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02"))));
						shForeCastMap.put("SH_TG_P03", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03"))));
						shForeCastMap.put("SH_TG_P04", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04"))));
						shForeCastMap.put("SH_TG_P05", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05"))));
						shForeCastMap.put("SH_TG_P06", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06"))));
						shForeCastMap.put("SH_TG_P07", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07"))));
						shForeCastMap.put("SH_TG_P08", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08"))));
						shForeCastMap.put("SH_TG_P09", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09"))));
						shForeCastMap.put("SH_TG_P10", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10"))));
						shForeCastMap.put("SH_TG_P11", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11"))));
						shForeCastMap.put("SH_TG_P12", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12"))));
						shForeCastMap.put("SH_TG_Q01", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q1"))));
						shForeCastMap.put("SH_TG_Q02", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q2"))));
						shForeCastMap.put("SH_TG_Q03", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q3"))));
						shForeCastMap.put("SH_TG_Q04", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q4"))));
						shForeCastMap.put("SH_TG_H01", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H1"))));
						shForeCastMap.put("SH_TG_H02", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H2"))));
						shForeCastMap.put("SH_TG_YTD", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_YTD"))));
						
						shForeCast.add(shForeCastMap);
						
						lv1_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P01")));
						lv1_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P02")));
						lv1_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P03")));
						lv1_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P04")));
						lv1_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P05")));
						lv1_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P06")));
						lv1_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P07")));
						lv1_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P08")));
						lv1_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P09")));
						lv1_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P10")));
						lv1_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P11")));
						lv1_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P12")));
						lv1_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q1")));
						lv1_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q2")));
						lv1_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q3")));
						lv1_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q4")));
						lv1_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H1")));
						lv1_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H2")));
						lv1_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_YTD")));

						lv1_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P01")));
						lv1_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P02")));
						lv1_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P03")));
						lv1_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P04")));
						lv1_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P05")));
						lv1_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P06")));
						lv1_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P07")));
						lv1_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P08")));
						lv1_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P09")));
						lv1_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P10")));
						lv1_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P11")));
						lv1_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P12")));
						lv1_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q1")));
						lv1_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q2")));
						lv1_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q3")));
						lv1_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q4")));
						lv1_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H1")));
						lv1_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H2")));
						lv1_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_YTD")));
						
						lv2_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P01")));
						lv2_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P02")));
						lv2_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P03")));
						lv2_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P04")));
						lv2_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P05")));
						lv2_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P06")));
						lv2_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P07")));
						lv2_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P08")));
						lv2_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P09")));
						lv2_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P10")));
						lv2_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P11")));
						lv2_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P12")));
						lv2_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q1")));
						lv2_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q2")));
						lv2_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q3")));
						lv2_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q4")));
						lv2_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H1")));
						lv2_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H2")));
						lv2_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_YTD")));

						lv2_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P01")));
						lv2_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P02")));
						lv2_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P03")));
						lv2_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P04")));
						lv2_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P05")));
						lv2_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P06")));
						lv2_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P07")));
						lv2_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P08")));
						lv2_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P09")));
						lv2_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P10")));
						lv2_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P11")));
						lv2_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P12")));
						lv2_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q1")));
						lv2_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q2")));
						lv2_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q3")));
						lv2_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q4")));
						lv2_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H1")));
						lv2_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H2")));
						lv2_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_YTD")));
						
						//sh forecast(outlook)
						lv1_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01")));
						lv1_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02")));
						lv1_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03")));
						lv1_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04")));
						lv1_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05")));
						lv1_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06")));
						lv1_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07")));
						lv1_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08")));
						lv1_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09")));
						lv1_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10")));
						lv1_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11")));
						lv1_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12")));
						lv1_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q1")));
						lv1_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q2")));
						lv1_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q3")));
						lv1_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q4")));
						lv1_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H1")));
						lv1_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H2")));
						lv1_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_YTD")));

						lv1_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01")));
						lv1_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02")));
						lv1_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03")));
						lv1_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04")));
						lv1_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05")));
						lv1_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06")));
						lv1_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07")));
						lv1_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08")));
						lv1_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09")));
						lv1_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10")));
						lv1_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11")));
						lv1_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12")));
						lv1_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q1")));
						lv1_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q2")));
						lv1_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q3")));
						lv1_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q4")));
						lv1_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H1")));
						lv1_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H2")));
						lv1_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_YTD")));
						
						lv2_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01")));
						lv2_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02")));
						lv2_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03")));
						lv2_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04")));
						lv2_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05")));
						lv2_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06")));
						lv2_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07")));
						lv2_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08")));
						lv2_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09")));
						lv2_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10")));
						lv2_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11")));
						lv2_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12")));
						lv2_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q1")));
						lv2_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q2")));
						lv2_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q3")));
						lv2_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q4")));
						lv2_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H1")));
						lv2_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H2")));
						lv2_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_YTD")));

						lv2_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01")));
						lv2_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02")));
						lv2_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03")));
						lv2_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04")));
						lv2_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05")));
						lv2_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06")));
						lv2_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07")));
						lv2_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08")));
						lv2_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09")));
						lv2_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10")));
						lv2_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11")));
						lv2_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12")));
						lv2_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q1")));
						lv2_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q2")));
						lv2_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q3")));
						lv2_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q4")));
						lv2_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H1")));
						lv2_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H2")));
						lv2_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_YTD")));
					}
					else {
						shForeCastMap = new HashMap();
						
						shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List).get("DATALV1_NM"));
						shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List).get("DATALV2_NM"));
						shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List).get("DATALV3_NM"));
						shForeCastMap.put("SH_AC_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P01"))));
						shForeCastMap.put("SH_AC_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P02"))));
						shForeCastMap.put("SH_AC_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P03"))));
						shForeCastMap.put("SH_AC_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P04"))));
						shForeCastMap.put("SH_AC_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P05"))));
						shForeCastMap.put("SH_AC_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P06"))));
						shForeCastMap.put("SH_AC_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P07"))));
						shForeCastMap.put("SH_AC_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P08"))));
						shForeCastMap.put("SH_AC_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P09"))));
						shForeCastMap.put("SH_AC_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P10"))));
						shForeCastMap.put("SH_AC_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P11"))));
						shForeCastMap.put("SH_AC_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P12"))));
						shForeCastMap.put("SH_AC_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q1"))));
						shForeCastMap.put("SH_AC_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q2"))));
						shForeCastMap.put("SH_AC_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q3"))));
						shForeCastMap.put("SH_AC_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q4"))));
						shForeCastMap.put("SH_AC_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H1"))));
						shForeCastMap.put("SH_AC_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H2"))));
						shForeCastMap.put("SH_AC_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_YTD"))));
						shForeCastMap.put("SH_FOR_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P01"))));
						shForeCastMap.put("SH_FOR_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P02"))));
						shForeCastMap.put("SH_FOR_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P03"))));
						shForeCastMap.put("SH_FOR_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P04"))));
						shForeCastMap.put("SH_FOR_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P05"))));
						shForeCastMap.put("SH_FOR_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P06"))));
						shForeCastMap.put("SH_FOR_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P07"))));
						shForeCastMap.put("SH_FOR_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P08"))));
						shForeCastMap.put("SH_FOR_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P09"))));
						shForeCastMap.put("SH_FOR_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P10"))));
						shForeCastMap.put("SH_FOR_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P11"))));
						shForeCastMap.put("SH_FOR_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P12"))));
						shForeCastMap.put("SH_FOR_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q1"))));
						shForeCastMap.put("SH_FOR_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q2"))));
						shForeCastMap.put("SH_FOR_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q3"))));
						shForeCastMap.put("SH_FOR_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q4"))));
						shForeCastMap.put("SH_FOR_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H1"))));
						shForeCastMap.put("SH_FOR_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H2"))));
						shForeCastMap.put("SH_FOR_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_YTD"))));
						
						//sh forecast(outlook)
						shForeCastMap.put("DATALV1_NM", String.valueOf(list.get(lv2List).get("DATALV1_NM")));
						shForeCastMap.put("DATALV2_NM", String.valueOf(list.get(lv2List).get("DATALV2_NM")));
						shForeCastMap.put("DATALV3_NM", String.valueOf(list.get(lv2List).get("DATALV3_NM")));
						shForeCastMap.put("SH_OUT_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P01"))));
						shForeCastMap.put("SH_OUT_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P02"))));
						shForeCastMap.put("SH_OUT_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P03"))));
						shForeCastMap.put("SH_OUT_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P04"))));
						shForeCastMap.put("SH_OUT_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P05"))));
						shForeCastMap.put("SH_OUT_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P06"))));
						shForeCastMap.put("SH_OUT_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P07"))));
						shForeCastMap.put("SH_OUT_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P08"))));
						shForeCastMap.put("SH_OUT_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P09"))));
						shForeCastMap.put("SH_OUT_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P10"))));
						shForeCastMap.put("SH_OUT_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P11"))));
						shForeCastMap.put("SH_OUT_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P12"))));
						shForeCastMap.put("SH_OUT_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q1"))));
						shForeCastMap.put("SH_OUT_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q2"))));
						shForeCastMap.put("SH_OUT_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q3"))));
						shForeCastMap.put("SH_OUT_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q4"))));
						shForeCastMap.put("SH_OUT_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H1"))));
						shForeCastMap.put("SH_OUT_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H2"))));
						shForeCastMap.put("SH_OUT_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_YTD"))));
						shForeCastMap.put("SH_TG_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P01"))));
						shForeCastMap.put("SH_TG_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P02"))));
						shForeCastMap.put("SH_TG_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P03"))));
						shForeCastMap.put("SH_TG_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P04"))));
						shForeCastMap.put("SH_TG_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P05"))));
						shForeCastMap.put("SH_TG_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P06"))));
						shForeCastMap.put("SH_TG_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P07"))));
						shForeCastMap.put("SH_TG_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P08"))));
						shForeCastMap.put("SH_TG_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P09"))));
						shForeCastMap.put("SH_TG_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P10"))));
						shForeCastMap.put("SH_TG_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P11"))));
						shForeCastMap.put("SH_TG_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P12"))));
						shForeCastMap.put("SH_TG_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q1"))));
						shForeCastMap.put("SH_TG_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q2"))));
						shForeCastMap.put("SH_TG_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q3"))));
						shForeCastMap.put("SH_TG_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q4"))));
						shForeCastMap.put("SH_TG_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H1"))));
						shForeCastMap.put("SH_TG_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H2"))));
						shForeCastMap.put("SH_TG_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_YTD"))));
						
						shForeCast.add(shForeCastMap);
													  
						lv1_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P01")));
						lv1_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P02")));
						lv1_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P03")));
						lv1_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P04")));
						lv1_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P05")));
						lv1_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P06")));
						lv1_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P07")));
						lv1_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P08")));
						lv1_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P09")));
						lv1_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P10")));
						lv1_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P11")));
						lv1_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P12")));
						lv1_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q1")));
						lv1_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q2")));
						lv1_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q3")));
						lv1_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q4")));
						lv1_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H1")));
						lv1_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H2")));
						lv1_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_YTD")));

						lv1_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P01")));
						lv1_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P02")));
						lv1_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P03")));
						lv1_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P04")));
						lv1_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P05")));
						lv1_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P06")));
						lv1_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P07")));
						lv1_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P08")));
						lv1_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P09")));
						lv1_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P10")));
						lv1_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P11")));
						lv1_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P12")));
						lv1_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q1")));
						lv1_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q2")));
						lv1_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q3")));
						lv1_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q4")));
						lv1_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H1")));
						lv1_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H2")));
						lv1_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_YTD")));
						
						lv2_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P01")));
						lv2_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P02")));
						lv2_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P03")));
						lv2_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P04")));
						lv2_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P05")));
						lv2_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P06")));
						lv2_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P07")));
						lv2_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P08")));
						lv2_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P09")));
						lv2_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P10")));
						lv2_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P11")));
						lv2_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P12")));
						lv2_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q1")));
						lv2_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q2")));
						lv2_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q3")));
						lv2_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q4")));
						lv2_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H1")));
						lv2_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H2")));
						lv2_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_YTD")));

						lv2_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P01")));
						lv2_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P02")));
						lv2_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P03")));
						lv2_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P04")));
						lv2_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P05")));
						lv2_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P06")));
						lv2_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P07")));
						lv2_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P08")));
						lv2_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P09")));
						lv2_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P10")));
						lv2_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P11")));
						lv2_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P12")));
						lv2_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q1")));
						lv2_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q2")));
						lv2_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q3")));
						lv2_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q4")));
						lv2_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H1")));
						lv2_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H2")));
						lv2_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_YTD")));
						
						//sh forecast(outlook)
						lv1_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P01")));
						lv1_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P02")));
						lv1_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P03")));
						lv1_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P04")));
						lv1_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P05")));
						lv1_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P06")));
						lv1_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P07")));
						lv1_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P08")));
						lv1_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P09")));
						lv1_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P10")));
						lv1_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P11")));
						lv1_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P12")));
						lv1_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q1")));
						lv1_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q2")));
						lv1_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q3")));
						lv1_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q4")));
						lv1_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H1")));
						lv1_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H2")));
						lv1_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_YTD")));

						lv1_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P01")));
						lv1_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P02")));
						lv1_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P03")));
						lv1_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P04")));
						lv1_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P05")));
						lv1_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P06")));
						lv1_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P07")));
						lv1_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P08")));
						lv1_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P09")));
						lv1_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P10")));
						lv1_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P11")));
						lv1_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P12")));
						lv1_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q1")));
						lv1_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q2")));
						lv1_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q3")));
						lv1_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q4")));
						lv1_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H1")));
						lv1_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H2")));
						lv1_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_YTD")));
						
						lv2_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P01")));
						lv2_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P02")));
						lv2_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P03")));
						lv2_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P04")));
						lv2_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P05")));
						lv2_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P06")));
						lv2_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P07")));
						lv2_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P08")));
						lv2_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P09")));
						lv2_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P10")));
						lv2_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P11")));
						lv2_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P12")));
						lv2_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q1")));
						lv2_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q2")));
						lv2_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q3")));
						lv2_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q4")));
						lv2_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H1")));
						lv2_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H2")));
						lv2_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_YTD")));

						lv2_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P01")));
						lv2_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P02")));
						lv2_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P03")));
						lv2_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P04")));
						lv2_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P05")));
						lv2_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P06")));
						lv2_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P07")));
						lv2_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P08")));
						lv2_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P09")));
						lv2_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P10")));
						lv2_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P11")));
						lv2_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P12")));
						lv2_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q1")));
						lv2_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q2")));
						lv2_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q3")));
						lv2_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q4")));
						lv2_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H1")));
						lv2_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H2")));
						lv2_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_YTD")));
					}
					
					shForeCastMap = new HashMap();
					
					shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List).get("DATALV1_NM"));
					shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List).get("DATALV2_NM"));
					shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List).get("DATALV2_NM")+" 합계");
					shForeCastMap.put("SH_AC_P01", lv2_sh_ac_p01_sum);
					shForeCastMap.put("SH_AC_P02", lv2_sh_ac_p02_sum);
					shForeCastMap.put("SH_AC_P03", lv2_sh_ac_p03_sum);
					shForeCastMap.put("SH_AC_P04", lv2_sh_ac_p04_sum);
					shForeCastMap.put("SH_AC_P05", lv2_sh_ac_p05_sum);
					shForeCastMap.put("SH_AC_P06", lv2_sh_ac_p06_sum);
					shForeCastMap.put("SH_AC_P07", lv2_sh_ac_p07_sum);
					shForeCastMap.put("SH_AC_P08", lv2_sh_ac_p08_sum);
					shForeCastMap.put("SH_AC_P09", lv2_sh_ac_p09_sum);
					shForeCastMap.put("SH_AC_P10", lv2_sh_ac_p10_sum);
					shForeCastMap.put("SH_AC_P11", lv2_sh_ac_p11_sum);
					shForeCastMap.put("SH_AC_P12", lv2_sh_ac_p12_sum);
					shForeCastMap.put("SH_AC_Q01", lv2_sh_ac_q01_sum);
					shForeCastMap.put("SH_AC_Q02", lv2_sh_ac_q02_sum);
					shForeCastMap.put("SH_AC_Q03", lv2_sh_ac_q03_sum);
					shForeCastMap.put("SH_AC_Q04", lv2_sh_ac_q04_sum);
					shForeCastMap.put("SH_AC_H01", lv2_sh_ac_h01_sum);
					shForeCastMap.put("SH_AC_H02", lv2_sh_ac_h02_sum);
					shForeCastMap.put("SH_AC_YTD", lv2_sh_ac_ytd_sum);
					shForeCastMap.put("SH_FOR_P01", lv2_sh_for_p01_sum);
					shForeCastMap.put("SH_FOR_P02", lv2_sh_for_p02_sum);
					shForeCastMap.put("SH_FOR_P03", lv2_sh_for_p03_sum);
					shForeCastMap.put("SH_FOR_P04", lv2_sh_for_p04_sum);
					shForeCastMap.put("SH_FOR_P05", lv2_sh_for_p05_sum);
					shForeCastMap.put("SH_FOR_P06", lv2_sh_for_p06_sum);
					shForeCastMap.put("SH_FOR_P07", lv2_sh_for_p07_sum);
					shForeCastMap.put("SH_FOR_P08", lv2_sh_for_p08_sum);
					shForeCastMap.put("SH_FOR_P09", lv2_sh_for_p09_sum);
					shForeCastMap.put("SH_FOR_P10", lv2_sh_for_p10_sum);
					shForeCastMap.put("SH_FOR_P11", lv2_sh_for_p11_sum);
					shForeCastMap.put("SH_FOR_P12", lv2_sh_for_p12_sum);
					shForeCastMap.put("SH_FOR_Q01", lv2_sh_for_q01_sum);
					shForeCastMap.put("SH_FOR_Q02", lv2_sh_for_q02_sum);
					shForeCastMap.put("SH_FOR_Q03", lv2_sh_for_q03_sum);
					shForeCastMap.put("SH_FOR_Q04", lv2_sh_for_q04_sum);
					shForeCastMap.put("SH_FOR_H01", lv2_sh_for_h01_sum);
					shForeCastMap.put("SH_FOR_H02", lv2_sh_for_h02_sum);
					shForeCastMap.put("SH_FOR_YTD", lv2_sh_for_ytd_sum);
					
					//sh forecast(outlook)
					shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List).get("DATALV1_NM"));
					shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List).get("DATALV2_NM"));
					shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List).get("DATALV2_NM")+" 합계");
					shForeCastMap.put("SH_OUT_P01", lv2_sh_out_p01_sum);
					shForeCastMap.put("SH_OUT_P02", lv2_sh_out_p02_sum);
					shForeCastMap.put("SH_OUT_P03", lv2_sh_out_p03_sum);
					shForeCastMap.put("SH_OUT_P04", lv2_sh_out_p04_sum);
					shForeCastMap.put("SH_OUT_P05", lv2_sh_out_p05_sum);
					shForeCastMap.put("SH_OUT_P06", lv2_sh_out_p06_sum);
					shForeCastMap.put("SH_OUT_P07", lv2_sh_out_p07_sum);
					shForeCastMap.put("SH_OUT_P08", lv2_sh_out_p08_sum);
					shForeCastMap.put("SH_OUT_P09", lv2_sh_out_p09_sum);
					shForeCastMap.put("SH_OUT_P10", lv2_sh_out_p10_sum);
					shForeCastMap.put("SH_OUT_P11", lv2_sh_out_p11_sum);
					shForeCastMap.put("SH_OUT_P12", lv2_sh_out_p12_sum);
					shForeCastMap.put("SH_OUT_Q01", lv2_sh_out_q01_sum);
					shForeCastMap.put("SH_OUT_Q02", lv2_sh_out_q02_sum);
					shForeCastMap.put("SH_OUT_Q03", lv2_sh_out_q03_sum);
					shForeCastMap.put("SH_OUT_Q04", lv2_sh_out_q04_sum);
					shForeCastMap.put("SH_OUT_H01", lv2_sh_out_h01_sum);
					shForeCastMap.put("SH_OUT_H02", lv2_sh_out_h02_sum);
					shForeCastMap.put("SH_OUT_YTD", lv2_sh_out_ytd_sum);
					shForeCastMap.put("SH_TG_P01", lv2_sh_tg_p01_sum);
					shForeCastMap.put("SH_TG_P02", lv2_sh_tg_p02_sum);
					shForeCastMap.put("SH_TG_P03", lv2_sh_tg_p03_sum);
					shForeCastMap.put("SH_TG_P04", lv2_sh_tg_p04_sum);
					shForeCastMap.put("SH_TG_P05", lv2_sh_tg_p05_sum);
					shForeCastMap.put("SH_TG_P06", lv2_sh_tg_p06_sum);
					shForeCastMap.put("SH_TG_P07", lv2_sh_tg_p07_sum);
					shForeCastMap.put("SH_TG_P08", lv2_sh_tg_p08_sum);
					shForeCastMap.put("SH_TG_P09", lv2_sh_tg_p09_sum);
					shForeCastMap.put("SH_TG_P10", lv2_sh_tg_p10_sum);
					shForeCastMap.put("SH_TG_P11", lv2_sh_tg_p11_sum);
					shForeCastMap.put("SH_TG_P12", lv2_sh_tg_p12_sum);
					shForeCastMap.put("SH_TG_Q01", lv2_sh_tg_q01_sum);
					shForeCastMap.put("SH_TG_Q02", lv2_sh_tg_q02_sum);
					shForeCastMap.put("SH_TG_Q03", lv2_sh_tg_q03_sum);
					shForeCastMap.put("SH_TG_Q04", lv2_sh_tg_q04_sum);
					shForeCastMap.put("SH_TG_H01", lv2_sh_tg_h01_sum);
					shForeCastMap.put("SH_TG_H02", lv2_sh_tg_h02_sum);
					shForeCastMap.put("SH_TG_YTD", lv2_sh_tg_ytd_sum);

					shForeCast.add(shForeCastMap);
					
					lv2_sh_ac_p01_sum = 0;
					lv2_sh_ac_p02_sum = 0;
					lv2_sh_ac_p03_sum = 0;
					lv2_sh_ac_p04_sum = 0;
					lv2_sh_ac_p05_sum = 0;
					lv2_sh_ac_p06_sum = 0;
					lv2_sh_ac_p07_sum = 0;
					lv2_sh_ac_p08_sum = 0;
					lv2_sh_ac_p09_sum = 0;
					lv2_sh_ac_p10_sum = 0;
					lv2_sh_ac_p11_sum = 0;
					lv2_sh_ac_p12_sum = 0;
					lv2_sh_ac_q01_sum = 0;
					lv2_sh_ac_q02_sum = 0;
					lv2_sh_ac_q03_sum = 0;
					lv2_sh_ac_q04_sum = 0;
					lv2_sh_ac_h01_sum = 0;
					lv2_sh_ac_h02_sum = 0;
					lv2_sh_ac_ytd_sum = 0;
					
					lv2_sh_for_p01_sum = 0;
					lv2_sh_for_p02_sum = 0;
					lv2_sh_for_p03_sum = 0;
					lv2_sh_for_p04_sum = 0;
					lv2_sh_for_p05_sum = 0;
					lv2_sh_for_p06_sum = 0;
					lv2_sh_for_p07_sum = 0;
					lv2_sh_for_p08_sum = 0;
					lv2_sh_for_p09_sum = 0;
					lv2_sh_for_p10_sum = 0;
					lv2_sh_for_p11_sum = 0;
					lv2_sh_for_p12_sum = 0;
					lv2_sh_for_q01_sum = 0;
					lv2_sh_for_q02_sum = 0;
					lv2_sh_for_q03_sum = 0;
					lv2_sh_for_q04_sum = 0;
					lv2_sh_for_h01_sum = 0;
					lv2_sh_for_h02_sum = 0;
					lv2_sh_for_ytd_sum = 0;
					
					//sh forecast(outlook)
					lv2_sh_out_p01_sum = 0;
					lv2_sh_out_p02_sum = 0;
					lv2_sh_out_p03_sum = 0;
					lv2_sh_out_p04_sum = 0;
					lv2_sh_out_p05_sum = 0;
					lv2_sh_out_p06_sum = 0;
					lv2_sh_out_p07_sum = 0;
					lv2_sh_out_p08_sum = 0;
					lv2_sh_out_p09_sum = 0;
					lv2_sh_out_p10_sum = 0;
					lv2_sh_out_p11_sum = 0;
					lv2_sh_out_p12_sum = 0;
					lv2_sh_out_q01_sum = 0;
					lv2_sh_out_q02_sum = 0;
					lv2_sh_out_q03_sum = 0;
					lv2_sh_out_q04_sum = 0;
					lv2_sh_out_h01_sum = 0;
					lv2_sh_out_h02_sum = 0;
					lv2_sh_out_ytd_sum = 0;

					lv2_sh_tg_p01_sum = 0;
					lv2_sh_tg_p02_sum = 0;
					lv2_sh_tg_p03_sum = 0;
					lv2_sh_tg_p04_sum = 0;
					lv2_sh_tg_p05_sum = 0;
					lv2_sh_tg_p06_sum = 0;
					lv2_sh_tg_p07_sum = 0;
					lv2_sh_tg_p08_sum = 0;
					lv2_sh_tg_p09_sum = 0;
					lv2_sh_tg_p10_sum = 0;
					lv2_sh_tg_p11_sum = 0;
					lv2_sh_tg_p12_sum = 0;
					lv2_sh_tg_q01_sum = 0;
					lv2_sh_tg_q02_sum = 0;
					lv2_sh_tg_q03_sum = 0;
					lv2_sh_tg_q04_sum = 0;
					lv2_sh_tg_h01_sum = 0;
					lv2_sh_tg_h02_sum = 0;
					lv2_sh_tg_ytd_sum = 0;
					
				}else {
					if(j == 0) {
						shForeCastMap = new HashMap();
						
						shForeCastMap.put("DATALV1_NM", (String)list.get(i).get("DATALV1_NM"));
						shForeCastMap.put("DATALV2_NM", (String)list.get(i).get("DATALV2_NM"));
						shForeCastMap.put("DATALV3_NM", (String)list.get(i).get("DATALV3_NM"));
						shForeCastMap.put("SH_AC_P01", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P01"))));
						shForeCastMap.put("SH_AC_P02", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P02"))));
						shForeCastMap.put("SH_AC_P03", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P03"))));
						shForeCastMap.put("SH_AC_P04", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P04"))));
						shForeCastMap.put("SH_AC_P05", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P05"))));
						shForeCastMap.put("SH_AC_P06", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P06"))));
						shForeCastMap.put("SH_AC_P07", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P07"))));
						shForeCastMap.put("SH_AC_P08", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P08"))));
						shForeCastMap.put("SH_AC_P09", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P09"))));
						shForeCastMap.put("SH_AC_P10", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P10"))));
						shForeCastMap.put("SH_AC_P11", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P11"))));
						shForeCastMap.put("SH_AC_P12", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P12"))));
						shForeCastMap.put("SH_AC_Q01", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q1"))));
						shForeCastMap.put("SH_AC_Q02", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q2"))));
						shForeCastMap.put("SH_AC_Q03", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q3"))));
						shForeCastMap.put("SH_AC_Q04", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q4"))));
						shForeCastMap.put("SH_AC_H01", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H1"))));
						shForeCastMap.put("SH_AC_H02", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H2"))));
						shForeCastMap.put("SH_AC_YTD", Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_YTD"))));
						shForeCastMap.put("SH_FOR_P01", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P01"))));
						shForeCastMap.put("SH_FOR_P02", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P02"))));
						shForeCastMap.put("SH_FOR_P03", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P03"))));
						shForeCastMap.put("SH_FOR_P04", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P04"))));
						shForeCastMap.put("SH_FOR_P05", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P05"))));
						shForeCastMap.put("SH_FOR_P06", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P06"))));
						shForeCastMap.put("SH_FOR_P07", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P07"))));
						shForeCastMap.put("SH_FOR_P08", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P08"))));
						shForeCastMap.put("SH_FOR_P09", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P09"))));
						shForeCastMap.put("SH_FOR_P10", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P10"))));
						shForeCastMap.put("SH_FOR_P11", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P11"))));
						shForeCastMap.put("SH_FOR_P12", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P12"))));
						shForeCastMap.put("SH_FOR_Q01", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q1"))));
						shForeCastMap.put("SH_FOR_Q02", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q2"))));
						shForeCastMap.put("SH_FOR_Q03", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q3"))));
						shForeCastMap.put("SH_FOR_Q04", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q4"))));
						shForeCastMap.put("SH_FOR_H01", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H1"))));
						shForeCastMap.put("SH_FOR_H02", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H2"))));
						shForeCastMap.put("SH_FOR_YTD", Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_YTD"))));
						
						//sh forecast(outlook)
						shForeCastMap.put("DATALV1_NM", String.valueOf(list.get(i).get("DATALV1_NM")));
						shForeCastMap.put("DATALV2_NM", String.valueOf(list.get(i).get("DATALV2_NM")));
						shForeCastMap.put("DATALV3_NM", String.valueOf(list.get(i).get("DATALV3_NM")));
						shForeCastMap.put("SH_OUT_P01", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01"))));
						shForeCastMap.put("SH_OUT_P02", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02"))));
						shForeCastMap.put("SH_OUT_P03", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03"))));
						shForeCastMap.put("SH_OUT_P04", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04"))));
						shForeCastMap.put("SH_OUT_P05", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05"))));
						shForeCastMap.put("SH_OUT_P06", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06"))));
						shForeCastMap.put("SH_OUT_P07", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07"))));
						shForeCastMap.put("SH_OUT_P08", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08"))));
						shForeCastMap.put("SH_OUT_P09", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09"))));
						shForeCastMap.put("SH_OUT_P10", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10"))));
						shForeCastMap.put("SH_OUT_P11", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11"))));
						shForeCastMap.put("SH_OUT_P12", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12"))));
						shForeCastMap.put("SH_OUT_Q01", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q1"))));
						shForeCastMap.put("SH_OUT_Q02", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q2"))));
						shForeCastMap.put("SH_OUT_Q03", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q3"))));
						shForeCastMap.put("SH_OUT_Q04", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q4"))));
						shForeCastMap.put("SH_OUT_H01", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H1"))));
						shForeCastMap.put("SH_OUT_H02", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H2"))));
						shForeCastMap.put("SH_OUT_YTD", Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_YTD"))));
						shForeCastMap.put("SH_TG_P01", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01"))));
						shForeCastMap.put("SH_TG_P02", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02"))));
						shForeCastMap.put("SH_TG_P03", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03"))));
						shForeCastMap.put("SH_TG_P04", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04"))));
						shForeCastMap.put("SH_TG_P05", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05"))));
						shForeCastMap.put("SH_TG_P06", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06"))));
						shForeCastMap.put("SH_TG_P07", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07"))));
						shForeCastMap.put("SH_TG_P08", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08"))));
						shForeCastMap.put("SH_TG_P09", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09"))));
						shForeCastMap.put("SH_TG_P10", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10"))));
						shForeCastMap.put("SH_TG_P11", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11"))));
						shForeCastMap.put("SH_TG_P12", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12"))));
						shForeCastMap.put("SH_TG_Q01", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q1"))));
						shForeCastMap.put("SH_TG_Q02", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q2"))));
						shForeCastMap.put("SH_TG_Q03", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q3"))));
						shForeCastMap.put("SH_TG_Q04", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q4"))));
						shForeCastMap.put("SH_TG_H01", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H1"))));
						shForeCastMap.put("SH_TG_H02", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H2"))));
						shForeCastMap.put("SH_TG_YTD", Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_YTD"))));
						
						shForeCast.add(shForeCastMap);
						
						lv1_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P01")));
						lv1_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P02")));
						lv1_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P03")));
						lv1_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P04")));
						lv1_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P05")));
						lv1_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P06")));
						lv1_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P07")));
						lv1_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P08")));
						lv1_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P09")));
						lv1_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P10")));
						lv1_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P11")));
						lv1_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P12")));
						lv1_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q1")));
						lv1_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q2")));
						lv1_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q3")));
						lv1_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q4")));
						lv1_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H1")));
						lv1_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H2")));
						lv1_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_YTD")));

						lv1_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P01")));
						lv1_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P02")));
						lv1_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P03")));
						lv1_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P04")));
						lv1_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P05")));
						lv1_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P06")));
						lv1_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P07")));
						lv1_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P08")));
						lv1_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P09")));
						lv1_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P10")));
						lv1_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P11")));
						lv1_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P12")));
						lv1_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q1")));
						lv1_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q2")));
						lv1_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q3")));
						lv1_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q4")));
						lv1_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H1")));
						lv1_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H2")));
						lv1_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_YTD")));
						
						lv2_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P01")));
						lv2_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P02")));
						lv2_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P03")));
						lv2_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P04")));
						lv2_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P05")));
						lv2_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P06")));
						lv2_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P07")));
						lv2_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P08")));
						lv2_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P09")));
						lv2_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P10")));
						lv2_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P11")));
						lv2_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P12")));
						lv2_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q1")));
						lv2_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q2")));
						lv2_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q3")));
						lv2_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q4")));
						lv2_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H1")));
						lv2_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H2")));
						lv2_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_YTD")));

						lv2_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P01")));
						lv2_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P02")));
						lv2_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P03")));
						lv2_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P04")));
						lv2_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P05")));
						lv2_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P06")));
						lv2_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P07")));
						lv2_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P08")));
						lv2_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P09")));
						lv2_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P10")));
						lv2_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P11")));
						lv2_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P12")));
						lv2_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q1")));
						lv2_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q2")));
						lv2_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q3")));
						lv2_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q4")));
						lv2_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H1")));
						lv2_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H2")));
						lv2_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_YTD")));
						
						//sh forecast(outlook)
						lv1_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01")));
						lv1_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02")));
						lv1_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03")));
						lv1_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04")));
						lv1_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05")));
						lv1_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06")));
						lv1_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07")));
						lv1_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08")));
						lv1_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09")));
						lv1_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10")));
						lv1_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11")));
						lv1_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12")));
						lv1_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q1")));
						lv1_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q2")));
						lv1_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q3")));
						lv1_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q4")));
						lv1_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H1")));
						lv1_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H2")));
						lv1_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_YTD")));

						lv1_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01")));
						lv1_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02")));
						lv1_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03")));
						lv1_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04")));
						lv1_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05")));
						lv1_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06")));
						lv1_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07")));
						lv1_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08")));
						lv1_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09")));
						lv1_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10")));
						lv1_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11")));
						lv1_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12")));
						lv1_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q1")));
						lv1_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q2")));
						lv1_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q3")));
						lv1_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q4")));
						lv1_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H1")));
						lv1_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H2")));
						lv1_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_YTD")));
						
						lv2_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01")));
						lv2_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02")));
						lv2_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03")));
						lv2_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04")));
						lv2_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05")));
						lv2_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06")));
						lv2_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07")));
						lv2_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08")));
						lv2_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09")));
						lv2_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10")));
						lv2_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11")));
						lv2_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12")));
						lv2_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q1")));
						lv2_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q2")));
						lv2_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q3")));
						lv2_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q4")));
						lv2_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H1")));
						lv2_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H2")));
						lv2_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_YTD")));

						lv2_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01")));
						lv2_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02")));
						lv2_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03")));
						lv2_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04")));
						lv2_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05")));
						lv2_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06")));
						lv2_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07")));
						lv2_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08")));
						lv2_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09")));
						lv2_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10")));
						lv2_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11")));
						lv2_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12")));
						lv2_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q1")));
						lv2_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q2")));
						lv2_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q3")));
						lv2_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q4")));
						lv2_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H1")));
						lv2_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H2")));
						lv2_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_YTD")));
						
					}else {
						
						shForeCastMap = new HashMap();
						shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List).get("DATALV1_NM"));
						shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List).get("DATALV2_NM"));
						shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List).get("DATALV3_NM"));
						shForeCastMap.put("SH_AC_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P01"))));
						shForeCastMap.put("SH_AC_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P02"))));
						shForeCastMap.put("SH_AC_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P03"))));
						shForeCastMap.put("SH_AC_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P04"))));
						shForeCastMap.put("SH_AC_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P05"))));
						shForeCastMap.put("SH_AC_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P06"))));
						shForeCastMap.put("SH_AC_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P07"))));
						shForeCastMap.put("SH_AC_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P08"))));
						shForeCastMap.put("SH_AC_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P09"))));
						shForeCastMap.put("SH_AC_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P10"))));
						shForeCastMap.put("SH_AC_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P11"))));
						shForeCastMap.put("SH_AC_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P12"))));
						shForeCastMap.put("SH_AC_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q1"))));
						shForeCastMap.put("SH_AC_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q2"))));
						shForeCastMap.put("SH_AC_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q3"))));
						shForeCastMap.put("SH_AC_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q4"))));
						shForeCastMap.put("SH_AC_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H1"))));
						shForeCastMap.put("SH_AC_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H2"))));
						shForeCastMap.put("SH_AC_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_YTD"))));
						shForeCastMap.put("SH_FOR_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P01"))));
						shForeCastMap.put("SH_FOR_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P02"))));
						shForeCastMap.put("SH_FOR_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P03"))));
						shForeCastMap.put("SH_FOR_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P04"))));
						shForeCastMap.put("SH_FOR_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P05"))));
						shForeCastMap.put("SH_FOR_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P06"))));
						shForeCastMap.put("SH_FOR_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P07"))));
						shForeCastMap.put("SH_FOR_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P08"))));
						shForeCastMap.put("SH_FOR_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P09"))));
						shForeCastMap.put("SH_FOR_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P10"))));
						shForeCastMap.put("SH_FOR_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P11"))));
						shForeCastMap.put("SH_FOR_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P12"))));
						shForeCastMap.put("SH_FOR_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q1"))));
						shForeCastMap.put("SH_FOR_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q2"))));
						shForeCastMap.put("SH_FOR_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q3"))));
						shForeCastMap.put("SH_FOR_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q4"))));
						shForeCastMap.put("SH_FOR_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H1"))));
						shForeCastMap.put("SH_FOR_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H2"))));
						shForeCastMap.put("SH_FOR_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_YTD"))));
						
						//sh forecast(outlook)
						shForeCastMap.put("DATALV1_NM", String.valueOf(list.get(lv2List).get("DATALV1_NM")));
						shForeCastMap.put("DATALV2_NM", String.valueOf(list.get(lv2List).get("DATALV2_NM")));
						shForeCastMap.put("DATALV3_NM", String.valueOf(list.get(lv2List).get("DATALV3_NM")));
						shForeCastMap.put("SH_OUT_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P01"))));
						shForeCastMap.put("SH_OUT_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P02"))));
						shForeCastMap.put("SH_OUT_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P03"))));
						shForeCastMap.put("SH_OUT_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P04"))));
						shForeCastMap.put("SH_OUT_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P05"))));
						shForeCastMap.put("SH_OUT_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P06"))));
						shForeCastMap.put("SH_OUT_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P07"))));
						shForeCastMap.put("SH_OUT_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P08"))));
						shForeCastMap.put("SH_OUT_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P09"))));
						shForeCastMap.put("SH_OUT_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P10"))));
						shForeCastMap.put("SH_OUT_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P11"))));
						shForeCastMap.put("SH_OUT_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P12"))));
						shForeCastMap.put("SH_OUT_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q1"))));
						shForeCastMap.put("SH_OUT_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q2"))));
						shForeCastMap.put("SH_OUT_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q3"))));
						shForeCastMap.put("SH_OUT_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q4"))));
						shForeCastMap.put("SH_OUT_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H1"))));
						shForeCastMap.put("SH_OUT_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H2"))));
						shForeCastMap.put("SH_OUT_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_YTD"))));
						shForeCastMap.put("SH_TG_P01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P01"))));
						shForeCastMap.put("SH_TG_P02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P02"))));
						shForeCastMap.put("SH_TG_P03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P03"))));
						shForeCastMap.put("SH_TG_P04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P04"))));
						shForeCastMap.put("SH_TG_P05", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P05"))));
						shForeCastMap.put("SH_TG_P06", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P06"))));
						shForeCastMap.put("SH_TG_P07", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P07"))));
						shForeCastMap.put("SH_TG_P08", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P08"))));
						shForeCastMap.put("SH_TG_P09", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P09"))));
						shForeCastMap.put("SH_TG_P10", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P10"))));
						shForeCastMap.put("SH_TG_P11", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P11"))));
						shForeCastMap.put("SH_TG_P12", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P12"))));
						shForeCastMap.put("SH_TG_Q01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q1"))));
						shForeCastMap.put("SH_TG_Q02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q2"))));
						shForeCastMap.put("SH_TG_Q03", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q3"))));
						shForeCastMap.put("SH_TG_Q04", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q4"))));
						shForeCastMap.put("SH_TG_H01", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H1"))));
						shForeCastMap.put("SH_TG_H02", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H2"))));
						shForeCastMap.put("SH_TG_YTD", Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_YTD"))));

						shForeCast.add(shForeCastMap);
						
						lv1_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P01")));
						lv1_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P02")));
						lv1_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P03")));
						lv1_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P04")));
						lv1_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P05")));
						lv1_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P06")));
						lv1_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P07")));
						lv1_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P08")));
						lv1_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P09")));
						lv1_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P10")));
						lv1_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P11")));
						lv1_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P12")));
						lv1_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q1")));
						lv1_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q2")));
						lv1_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q3")));
						lv1_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q4")));
						lv1_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H1")));
						lv1_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H2")));
						lv1_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_YTD")));

						lv1_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P01")));
						lv1_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P02")));
						lv1_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P03")));
						lv1_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P04")));
						lv1_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P05")));
						lv1_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P06")));
						lv1_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P07")));
						lv1_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P08")));
						lv1_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P09")));
						lv1_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P10")));
						lv1_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P11")));
						lv1_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P12")));
						lv1_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q1")));
						lv1_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q2")));
						lv1_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q3")));
						lv1_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q4")));
						lv1_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H1")));
						lv1_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H2")));
						lv1_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_YTD")));
						
						lv2_sh_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P01")));
						lv2_sh_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P02")));
						lv2_sh_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P03")));
						lv2_sh_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P04")));
						lv2_sh_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P05")));
						lv2_sh_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P06")));
						lv2_sh_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P07")));
						lv2_sh_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P08")));
						lv2_sh_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P09")));
						lv2_sh_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P10")));
						lv2_sh_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P11")));
						lv2_sh_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_P12")));
						lv2_sh_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q1")));
						lv2_sh_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q2")));
						lv2_sh_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q3")));
						lv2_sh_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_Q4")));
						lv2_sh_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H1")));
						lv2_sh_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_H2")));
						lv2_sh_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_AC_YTD")));

						lv2_sh_for_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P01")));
						lv2_sh_for_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P02")));
						lv2_sh_for_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P03")));
						lv2_sh_for_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P04")));
						lv2_sh_for_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P05")));
						lv2_sh_for_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P06")));
						lv2_sh_for_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P07")));
						lv2_sh_for_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P08")));
						lv2_sh_for_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P09")));
						lv2_sh_for_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P10")));
						lv2_sh_for_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P11")));
						lv2_sh_for_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_P12")));
						lv2_sh_for_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q1")));
						lv2_sh_for_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q2")));
						lv2_sh_for_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q3")));
						lv2_sh_for_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_Q4")));
						lv2_sh_for_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H1")));
						lv2_sh_for_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_H2")));
						lv2_sh_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_FOR_YTD")));
						
						//sh forecast(outlook)
						lv1_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P01")));
						lv1_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P02")));
						lv1_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P03")));
						lv1_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P04")));
						lv1_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P05")));
						lv1_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P06")));
						lv1_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P07")));
						lv1_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P08")));
						lv1_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P09")));
						lv1_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P10")));
						lv1_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P11")));
						lv1_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P12")));
						lv1_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q1")));
						lv1_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q2")));
						lv1_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q3")));
						lv1_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q4")));
						lv1_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H1")));
						lv1_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H2")));
						lv1_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_YTD")));

						lv1_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P01")));
						lv1_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P02")));
						lv1_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P03")));
						lv1_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P04")));
						lv1_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P05")));
						lv1_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P06")));
						lv1_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P07")));
						lv1_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P08")));
						lv1_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P09")));
						lv1_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P10")));
						lv1_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P11")));
						lv1_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P12")));
						lv1_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q1")));
						lv1_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q2")));
						lv1_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q3")));
						lv1_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q4")));
						lv1_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H1")));
						lv1_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H2")));
						lv1_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_YTD")));

						lv2_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P01")));
						lv2_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P02")));
						lv2_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P03")));
						lv2_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P04")));
						lv2_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P05")));
						lv2_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P06")));
						lv2_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P07")));
						lv2_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P08")));
						lv2_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P09")));
						lv2_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P10")));
						lv2_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P11")));
						lv2_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_P12")));
						lv2_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q1")));
						lv2_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q2")));
						lv2_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q3")));
						lv2_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_Q4")));
						lv2_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H1")));
						lv2_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_H2")));
						lv2_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_OUT_YTD")));

						lv2_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P01")));
						lv2_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P02")));
						lv2_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P03")));
						lv2_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P04")));
						lv2_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P05")));
						lv2_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P06")));
						lv2_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P07")));
						lv2_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P08")));
						lv2_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P09")));
						lv2_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P10")));
						lv2_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P11")));
						lv2_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_P12")));
						lv2_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q1")));
						lv2_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q2")));
						lv2_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q3")));
						lv2_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_Q4")));
						lv2_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H1")));
						lv2_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_H2")));
						lv2_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(lv2List).get("SH_TG_YTD")));
						
					}

				}
				lv2List++;
			}
			
			if(j == (countList2.size()-1)) {
				shForeCastMap = new HashMap();
				
				//Actual, foreCast Non Whisky 합계
				shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List-1).get("DATALV1_NM"));
				shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List-1).get("DATALV1_NM")+" 합계");
				shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List-1).get("DATALV1_NM")+" 합계");
				shForeCastMap.put("SH_AC_P01", lv1_sh_ac_p01_sum);
				shForeCastMap.put("SH_AC_P02", lv1_sh_ac_p02_sum);
				shForeCastMap.put("SH_AC_P03", lv1_sh_ac_p03_sum);
				shForeCastMap.put("SH_AC_P04", lv1_sh_ac_p04_sum);
				shForeCastMap.put("SH_AC_P05", lv1_sh_ac_p05_sum);
				shForeCastMap.put("SH_AC_P06", lv1_sh_ac_p06_sum);
				shForeCastMap.put("SH_AC_P07", lv1_sh_ac_p07_sum);
				shForeCastMap.put("SH_AC_P08", lv1_sh_ac_p08_sum);
				shForeCastMap.put("SH_AC_P09", lv1_sh_ac_p09_sum);
				shForeCastMap.put("SH_AC_P10", lv1_sh_ac_p10_sum);
				shForeCastMap.put("SH_AC_P11", lv1_sh_ac_p11_sum);
				shForeCastMap.put("SH_AC_P12", lv1_sh_ac_p12_sum);
				shForeCastMap.put("SH_AC_Q01", lv1_sh_ac_q01_sum);
				shForeCastMap.put("SH_AC_Q02", lv1_sh_ac_q02_sum);
				shForeCastMap.put("SH_AC_Q03", lv1_sh_ac_q03_sum);
				shForeCastMap.put("SH_AC_Q04", lv1_sh_ac_q04_sum);
				shForeCastMap.put("SH_AC_H01", lv1_sh_ac_h01_sum);
				shForeCastMap.put("SH_AC_H02", lv1_sh_ac_h02_sum);
				shForeCastMap.put("SH_AC_YTD", lv1_sh_ac_ytd_sum);
				shForeCastMap.put("SH_FOR_P01", lv1_sh_for_p01_sum);
				shForeCastMap.put("SH_FOR_P02", lv1_sh_for_p02_sum);
				shForeCastMap.put("SH_FOR_P03", lv1_sh_for_p03_sum);
				shForeCastMap.put("SH_FOR_P04", lv1_sh_for_p04_sum);
				shForeCastMap.put("SH_FOR_P05", lv1_sh_for_p05_sum);
				shForeCastMap.put("SH_FOR_P06", lv1_sh_for_p06_sum);
				shForeCastMap.put("SH_FOR_P07", lv1_sh_for_p07_sum);
				shForeCastMap.put("SH_FOR_P08", lv1_sh_for_p08_sum);
				shForeCastMap.put("SH_FOR_P09", lv1_sh_for_p09_sum);
				shForeCastMap.put("SH_FOR_P10", lv1_sh_for_p10_sum);
				shForeCastMap.put("SH_FOR_P11", lv1_sh_for_p11_sum);
				shForeCastMap.put("SH_FOR_P12", lv1_sh_for_p12_sum);
				shForeCastMap.put("SH_FOR_Q01", lv1_sh_for_q01_sum);
				shForeCastMap.put("SH_FOR_Q02", lv1_sh_for_q02_sum);
				shForeCastMap.put("SH_FOR_Q03", lv1_sh_for_q03_sum);
				shForeCastMap.put("SH_FOR_Q04", lv1_sh_for_q04_sum);
				shForeCastMap.put("SH_FOR_H01", lv1_sh_for_h01_sum);
				shForeCastMap.put("SH_FOR_H02", lv1_sh_for_h02_sum);
				shForeCastMap.put("SH_FOR_YTD", lv1_sh_for_ytd_sum);
				
				double nt_sh_out_p01_sum = 0;
				double nt_sh_out_p02_sum = 0;
				double nt_sh_out_p03_sum = 0;
				double nt_sh_out_p04_sum = 0;
				double nt_sh_out_p05_sum = 0;
				double nt_sh_out_p06_sum = 0;
				double nt_sh_out_p07_sum = 0;
				double nt_sh_out_p08_sum = 0;
				double nt_sh_out_p09_sum = 0;
				double nt_sh_out_p10_sum = 0;
				double nt_sh_out_p11_sum = 0;
				double nt_sh_out_p12_sum = 0;
				double nt_sh_out_q01_sum = 0;
				double nt_sh_out_q02_sum = 0;
				double nt_sh_out_q03_sum = 0;
				double nt_sh_out_q04_sum = 0;
				double nt_sh_out_h01_sum = 0;
				double nt_sh_out_h02_sum = 0;
				double nt_sh_out_ytd_sum = 0;
				
				double nt_sh_tg_p01_sum = 0;
				double nt_sh_tg_p02_sum = 0;
				double nt_sh_tg_p03_sum = 0;
				double nt_sh_tg_p04_sum = 0;
				double nt_sh_tg_p05_sum = 0;
				double nt_sh_tg_p06_sum = 0;
				double nt_sh_tg_p07_sum = 0;
				double nt_sh_tg_p08_sum = 0;
				double nt_sh_tg_p09_sum = 0;
				double nt_sh_tg_p10_sum = 0;
				double nt_sh_tg_p11_sum = 0;
				double nt_sh_tg_p12_sum = 0;
				double nt_sh_tg_q01_sum = 0;
				double nt_sh_tg_q02_sum = 0;
				double nt_sh_tg_q03_sum = 0;
				double nt_sh_tg_q04_sum = 0;
				double nt_sh_tg_h01_sum = 0;
				double nt_sh_tg_h02_sum = 0;
				double nt_sh_tg_ytd_sum = 0;
				
				for(int i=0; i<list.size(); i++){
					if(list.get(i).get("DATALV1").toString().equals("NON WHISKY")){
						nt_sh_out_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01")));
						nt_sh_out_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02")));
						nt_sh_out_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03")));
						nt_sh_out_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04")));
						nt_sh_out_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05")));
						nt_sh_out_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06")));
						nt_sh_out_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07")));
						nt_sh_out_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08")));
						nt_sh_out_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09")));
						nt_sh_out_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10")));
						nt_sh_out_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11")));
						nt_sh_out_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12")));
						nt_sh_out_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q1")));
						nt_sh_out_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q2")));
						nt_sh_out_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q3")));
						nt_sh_out_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q4")));
						nt_sh_out_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H1")));
						nt_sh_out_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H2")));
						nt_sh_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_YTD")));

						nt_sh_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01")));
						nt_sh_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02")));
						nt_sh_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03")));
						nt_sh_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04")));
						nt_sh_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05")));
						nt_sh_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06")));
						nt_sh_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07")));
						nt_sh_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08")));
						nt_sh_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09")));
						nt_sh_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10")));
						nt_sh_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11")));
						nt_sh_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12")));
						nt_sh_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q1")));
						nt_sh_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q2")));
						nt_sh_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q3")));
						nt_sh_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q4")));
						nt_sh_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H1")));
						nt_sh_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H2")));
						nt_sh_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_YTD")));
					}
				}
				
				//sh forecast(outlook) Outlook, Target Non Whisky 합계
				shForeCastMap.put("DATALV1_NM", (String)list.get(lv2List-1).get("DATALV1_NM"));
				shForeCastMap.put("DATALV2_NM", (String)list.get(lv2List-1).get("DATALV1_NM")+" 합계");
				shForeCastMap.put("DATALV3_NM", (String)list.get(lv2List-1).get("DATALV1_NM")+" 합계");
				shForeCastMap.put("SH_OUT_P01", nt_sh_out_p01_sum);
				shForeCastMap.put("SH_OUT_P02", nt_sh_out_p02_sum);
				shForeCastMap.put("SH_OUT_P03", nt_sh_out_p03_sum);
				shForeCastMap.put("SH_OUT_P04", nt_sh_out_p04_sum);
				shForeCastMap.put("SH_OUT_P05", nt_sh_out_p05_sum);
				shForeCastMap.put("SH_OUT_P06", nt_sh_out_p06_sum);
				shForeCastMap.put("SH_OUT_P07", nt_sh_out_p07_sum);
				shForeCastMap.put("SH_OUT_P08", nt_sh_out_p08_sum);
				shForeCastMap.put("SH_OUT_P09", nt_sh_out_p09_sum);
				shForeCastMap.put("SH_OUT_P10", nt_sh_out_p10_sum);
				shForeCastMap.put("SH_OUT_P11", nt_sh_out_p11_sum);
				shForeCastMap.put("SH_OUT_P12", nt_sh_out_p12_sum);
				shForeCastMap.put("SH_OUT_Q01", nt_sh_out_q01_sum);
				shForeCastMap.put("SH_OUT_Q02", nt_sh_out_q02_sum);
				shForeCastMap.put("SH_OUT_Q03", nt_sh_out_q03_sum);
				shForeCastMap.put("SH_OUT_Q04", nt_sh_out_q04_sum);
				shForeCastMap.put("SH_OUT_H01", nt_sh_out_h01_sum);
				shForeCastMap.put("SH_OUT_H02", nt_sh_out_h02_sum);
				shForeCastMap.put("SH_OUT_YTD", nt_sh_out_ytd_sum);
				shForeCastMap.put("SH_TG_P01", nt_sh_tg_p01_sum);
				shForeCastMap.put("SH_TG_P02", nt_sh_tg_p02_sum);
				shForeCastMap.put("SH_TG_P03", nt_sh_tg_p03_sum);
				shForeCastMap.put("SH_TG_P04", nt_sh_tg_p04_sum);
				shForeCastMap.put("SH_TG_P05", nt_sh_tg_p05_sum);
				shForeCastMap.put("SH_TG_P06", nt_sh_tg_p06_sum);
				shForeCastMap.put("SH_TG_P07", nt_sh_tg_p07_sum);
				shForeCastMap.put("SH_TG_P08", nt_sh_tg_p08_sum);
				shForeCastMap.put("SH_TG_P09", nt_sh_tg_p09_sum);
				shForeCastMap.put("SH_TG_P10", nt_sh_tg_p10_sum);
				shForeCastMap.put("SH_TG_P11", nt_sh_tg_p11_sum);
				shForeCastMap.put("SH_TG_P12", nt_sh_tg_p12_sum);
				shForeCastMap.put("SH_TG_Q01", nt_sh_tg_q01_sum);
				shForeCastMap.put("SH_TG_Q02", nt_sh_tg_q02_sum);
				shForeCastMap.put("SH_TG_Q03", nt_sh_tg_q03_sum);
				shForeCastMap.put("SH_TG_Q04", nt_sh_tg_q04_sum);
				shForeCastMap.put("SH_TG_H01", nt_sh_tg_h01_sum);
				shForeCastMap.put("SH_TG_H02", nt_sh_tg_h02_sum);
				shForeCastMap.put("SH_TG_YTD", nt_sh_tg_ytd_sum);

				shForeCast.add(shForeCastMap);
				
				lv1_sh_ac_p01_sum = 0;
				lv1_sh_ac_p02_sum = 0;
				lv1_sh_ac_p03_sum = 0;
				lv1_sh_ac_p04_sum = 0;
				lv1_sh_ac_p05_sum = 0;
				lv1_sh_ac_p06_sum = 0;
				lv1_sh_ac_p07_sum = 0;
				lv1_sh_ac_p08_sum = 0;
				lv1_sh_ac_p09_sum = 0;
				lv1_sh_ac_p10_sum = 0;
				lv1_sh_ac_p11_sum = 0;
				lv1_sh_ac_p12_sum = 0;
				lv1_sh_ac_q01_sum = 0;
				lv1_sh_ac_q02_sum = 0;
				lv1_sh_ac_q03_sum = 0;
				lv1_sh_ac_q04_sum = 0;
				lv1_sh_ac_h01_sum = 0;
				lv1_sh_ac_h02_sum = 0;
				lv1_sh_ac_ytd_sum = 0;
				
				lv1_sh_for_p01_sum = 0;
				lv1_sh_for_p02_sum = 0;
				lv1_sh_for_p03_sum = 0;
				lv1_sh_for_p04_sum = 0;
				lv1_sh_for_p05_sum = 0;
				lv1_sh_for_p06_sum = 0;
				lv1_sh_for_p07_sum = 0;
				lv1_sh_for_p08_sum = 0;
				lv1_sh_for_p09_sum = 0;
				lv1_sh_for_p10_sum = 0;
				lv1_sh_for_p11_sum = 0;
				lv1_sh_for_p12_sum = 0;
				lv1_sh_for_q01_sum = 0;
				lv1_sh_for_q02_sum = 0;
				lv1_sh_for_q03_sum = 0;
				lv1_sh_for_q04_sum = 0;
				lv1_sh_for_h01_sum = 0;
				lv1_sh_for_h02_sum = 0;
				lv1_sh_for_ytd_sum = 0;
				
				//sh forecast(outlook)
				
				lv1_sh_out_p01_sum = 0;
				lv1_sh_out_p02_sum = 0;
				lv1_sh_out_p03_sum = 0;
				lv1_sh_out_p04_sum = 0;
				lv1_sh_out_p05_sum = 0;
				lv1_sh_out_p06_sum = 0;
				lv1_sh_out_p07_sum = 0;
				lv1_sh_out_p08_sum = 0;
				lv1_sh_out_p09_sum = 0;
				lv1_sh_out_p10_sum = 0;
				lv1_sh_out_p11_sum = 0;
				lv1_sh_out_p12_sum = 0;
				lv1_sh_out_q01_sum = 0;
				lv1_sh_out_q02_sum = 0;
				lv1_sh_out_q03_sum = 0;
				lv1_sh_out_q04_sum = 0;
				lv1_sh_out_h01_sum = 0;
				lv1_sh_out_h02_sum = 0;
				lv1_sh_out_ytd_sum = 0;

				lv1_sh_tg_p01_sum = 0;
				lv1_sh_tg_p02_sum = 0;
				lv1_sh_tg_p03_sum = 0;
				lv1_sh_tg_p04_sum = 0;
				lv1_sh_tg_p05_sum = 0;
				lv1_sh_tg_p06_sum = 0;
				lv1_sh_tg_p07_sum = 0;
				lv1_sh_tg_p08_sum = 0;
				lv1_sh_tg_p09_sum = 0;
				lv1_sh_tg_p10_sum = 0;
				lv1_sh_tg_p11_sum = 0;
				lv1_sh_tg_p12_sum = 0;
				lv1_sh_tg_q01_sum = 0;
				lv1_sh_tg_q02_sum = 0;
				lv1_sh_tg_q03_sum = 0;
				lv1_sh_tg_q04_sum = 0;
				lv1_sh_tg_h01_sum = 0;
				lv1_sh_tg_h02_sum = 0;
				lv1_sh_tg_ytd_sum = 0;
			}
			
		}
		
		shForeCastMap = new HashMap();
		
		shForeCastMap.put("DATALV1_NM", "합계");
		shForeCastMap.put("DATALV2_NM", "합계");
		shForeCastMap.put("DATALV3_NM", "합계");
		shForeCastMap.put("SH_AC_P01", sh_ac_p01_sum);
		shForeCastMap.put("SH_AC_P02", sh_ac_p02_sum);
		shForeCastMap.put("SH_AC_P03", sh_ac_p03_sum);
		shForeCastMap.put("SH_AC_P04", sh_ac_p04_sum);
		shForeCastMap.put("SH_AC_P05", sh_ac_p05_sum);
		shForeCastMap.put("SH_AC_P06", sh_ac_p06_sum);
		shForeCastMap.put("SH_AC_P07", sh_ac_p07_sum);
		shForeCastMap.put("SH_AC_P08", sh_ac_p08_sum);
		shForeCastMap.put("SH_AC_P09", sh_ac_p09_sum);
		shForeCastMap.put("SH_AC_P10", sh_ac_p10_sum);
		shForeCastMap.put("SH_AC_P11", sh_ac_p11_sum);
		shForeCastMap.put("SH_AC_P12", sh_ac_p12_sum);
		shForeCastMap.put("SH_AC_Q01", sh_ac_q01_sum);
		shForeCastMap.put("SH_AC_Q02", sh_ac_q02_sum);
		shForeCastMap.put("SH_AC_Q03", sh_ac_q03_sum);
		shForeCastMap.put("SH_AC_Q04", sh_ac_q04_sum);
		shForeCastMap.put("SH_AC_H01", sh_ac_h01_sum);
		shForeCastMap.put("SH_AC_H02", sh_ac_h02_sum);
		shForeCastMap.put("SH_AC_YTD", sh_ac_ytd_sum);
		shForeCastMap.put("SH_FOR_P01", sh_for_p01_sum);
		shForeCastMap.put("SH_FOR_P02", sh_for_p02_sum);
		shForeCastMap.put("SH_FOR_P03", sh_for_p03_sum);
		shForeCastMap.put("SH_FOR_P04", sh_for_p04_sum);
		shForeCastMap.put("SH_FOR_P05", sh_for_p05_sum);
		shForeCastMap.put("SH_FOR_P06", sh_for_p06_sum);
		shForeCastMap.put("SH_FOR_P07", sh_for_p07_sum);
		shForeCastMap.put("SH_FOR_P08", sh_for_p08_sum);
		shForeCastMap.put("SH_FOR_P09", sh_for_p09_sum);
		shForeCastMap.put("SH_FOR_P10", sh_for_p10_sum);
		shForeCastMap.put("SH_FOR_P11", sh_for_p11_sum);
		shForeCastMap.put("SH_FOR_P12", sh_for_p12_sum);
		shForeCastMap.put("SH_FOR_Q01", sh_for_q01_sum);
		shForeCastMap.put("SH_FOR_Q02", sh_for_q02_sum);
		shForeCastMap.put("SH_FOR_Q03", sh_for_q03_sum);
		shForeCastMap.put("SH_FOR_Q04", sh_for_q04_sum);
		shForeCastMap.put("SH_FOR_H01", sh_for_h01_sum);
		shForeCastMap.put("SH_FOR_H02", sh_for_h02_sum);
		shForeCastMap.put("SH_FOR_YTD", sh_for_ytd_sum);
		
		//sh(outlook)
		shForeCastMap.put("DATALV1_NM", "합계");
		shForeCastMap.put("DATALV2_NM", "합계");
		shForeCastMap.put("DATALV3_NM", "합계");
		shForeCastMap.put("SH_OUT_P01", sh_out_p01_sum);
		shForeCastMap.put("SH_OUT_P02", sh_out_p02_sum);
		shForeCastMap.put("SH_OUT_P03", sh_out_p03_sum);
		shForeCastMap.put("SH_OUT_P04", sh_out_p04_sum);
		shForeCastMap.put("SH_OUT_P05", sh_out_p05_sum);
		shForeCastMap.put("SH_OUT_P06", sh_out_p06_sum);
		shForeCastMap.put("SH_OUT_P07", sh_out_p07_sum);
		shForeCastMap.put("SH_OUT_P08", sh_out_p08_sum);
		shForeCastMap.put("SH_OUT_P09", sh_out_p09_sum);
		shForeCastMap.put("SH_OUT_P10", sh_out_p10_sum);
		shForeCastMap.put("SH_OUT_P11", sh_out_p11_sum);
		shForeCastMap.put("SH_OUT_P12", sh_out_p12_sum);
		shForeCastMap.put("SH_OUT_Q01", sh_out_q01_sum);
		shForeCastMap.put("SH_OUT_Q02", sh_out_q02_sum);
		shForeCastMap.put("SH_OUT_Q03", sh_out_q03_sum);
		shForeCastMap.put("SH_OUT_Q04", sh_out_q04_sum);
		shForeCastMap.put("SH_OUT_H01", sh_out_h01_sum);
		shForeCastMap.put("SH_OUT_H02", sh_out_h02_sum);
		shForeCastMap.put("SH_OUT_YTD", sh_out_ytd_sum);
		shForeCastMap.put("SH_TG_P01", sh_tg_p01_sum);
		shForeCastMap.put("SH_TG_P02", sh_tg_p02_sum);
		shForeCastMap.put("SH_TG_P03", sh_tg_p03_sum);
		shForeCastMap.put("SH_TG_P04", sh_tg_p04_sum);
		shForeCastMap.put("SH_TG_P05", sh_tg_p05_sum);
		shForeCastMap.put("SH_TG_P06", sh_tg_p06_sum);
		shForeCastMap.put("SH_TG_P07", sh_tg_p07_sum);
		shForeCastMap.put("SH_TG_P08", sh_tg_p08_sum);
		shForeCastMap.put("SH_TG_P09", sh_tg_p09_sum);
		shForeCastMap.put("SH_TG_P10", sh_tg_p10_sum);
		shForeCastMap.put("SH_TG_P11", sh_tg_p11_sum);
		shForeCastMap.put("SH_TG_P12", sh_tg_p12_sum);
		shForeCastMap.put("SH_TG_Q01", sh_tg_q01_sum);
		shForeCastMap.put("SH_TG_Q02", sh_tg_q02_sum);
		shForeCastMap.put("SH_TG_Q03", sh_tg_q03_sum);
		shForeCastMap.put("SH_TG_Q04", sh_tg_q04_sum);
		shForeCastMap.put("SH_TG_H01", sh_tg_h01_sum);
		shForeCastMap.put("SH_TG_H02", sh_tg_h02_sum);
		shForeCastMap.put("SH_TG_YTD", sh_tg_ytd_sum);
		
		shForeCast.add(shForeCastMap);
		return shForeCast;
	}
	
	//%whishky (표밑 빨간 글씨)
	public ArrayList<Map> shWhisky(ArrayList<Map> list, HashMap nonWhisky, Map param) {
		ArrayList<Map> totalList = new ArrayList<Map>();
		Map totalMap = new HashMap();
		int whiskyTotal = 0;
		int total = list.size()-1;
		int period = Integer.parseInt(String.valueOf(param.get("ytd").toString().substring(1, 3)));
		
		String dataLv1 = null;
		for(int i=0; i<list.size()	; i++) {
			if(i==0) {
				dataLv1 = (String)list.get(i).get("DATALV1_NM");
			}
			
			if(!dataLv1.equals(list.get(i).get("DATALV1_NM"))) {
				whiskyTotal = i-1;
				break;
			}
		}
		
		totalMap.put("DATALV1_NM", "Whisky");
		totalMap.put("DATALV2_NM", "Whisky");
		totalMap.put("DATALV3_NM", "Whisky");
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P01")))!=0) {
			totalMap.put("SH_AC_P01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P01")))));
		}
		else {
			totalMap.put("SH_AC_P01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P02")))!=0) {
			totalMap.put("SH_AC_P02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P02")))));
		}
		else {
			totalMap.put("SH_AC_P02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P03")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P03")))!=0) {
			totalMap.put("SH_AC_P03", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P03")))));
		}
		else {
			totalMap.put("SH_AC_P03", 0);
		}	
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P04")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P04")))!=0) {
			totalMap.put("SH_AC_P04", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P04")))));
		}
		else {
			totalMap.put("SH_AC_P04", 0);
		}	
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P05")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P05")))!=0) {	
			totalMap.put("SH_AC_P05", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P05")))));
		}
		else {
			totalMap.put("SH_AC_P05", 0);
		}	
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P06")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P06")))!=0) {	
			totalMap.put("SH_AC_P06", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P06")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P06")))));
		}
		else {
			totalMap.put("SH_AC_P06", 0);
		}		
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P07")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P07")))!=0) {	
			totalMap.put("SH_AC_P07", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P07")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P07")))));
		}
		else {
			totalMap.put("SH_AC_P07", 0);
		}	
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P08")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P08")))!=0) {	
			totalMap.put("SH_AC_P08", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P08")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P08")))));
		}
		else {
			totalMap.put("SH_AC_P08", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P09")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P09")))!=0) {	
			totalMap.put("SH_AC_P09", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P09")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P09")))));
		}
		else {
			totalMap.put("SH_AC_P09", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P10")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P10")))!=0) {	
			totalMap.put("SH_AC_P10", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P10")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P10")))));
		}
		else {
			totalMap.put("SH_AC_P10", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P11")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P11")))!=0) {	
			totalMap.put("SH_AC_P11", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P11")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P11")))));
		}
		else {
			totalMap.put("SH_AC_P11", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P12")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P12")))!=0) {	
			totalMap.put("SH_AC_P12", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_P12")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P12")))));
		}
		else {
			totalMap.put("SH_AC_P12", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_Q01")))!=0) {	
			totalMap.put("SH_AC_Q01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_Q01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q01")))));
		}
		else {
			totalMap.put("SH_AC_Q01", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_Q02")))!=0) {	
			totalMap.put("SH_AC_Q02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_Q02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q02")))));
		}
		else {
			totalMap.put("SH_AC_Q02", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q03")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_Q03")))!=0) {	
			totalMap.put("SH_AC_Q03", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_Q03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q03")))));
		}
		else {
			totalMap.put("SH_AC_Q03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q04")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_Q04")))!=0) {	
			totalMap.put("SH_AC_Q04", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_Q04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q04")))));
		}
		else {
			totalMap.put("SH_AC_Q04", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_H01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_H01")))!=0) {	
			totalMap.put("SH_AC_H01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_H01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_H01")))));
		}
		else {
			totalMap.put("SH_AC_H01", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_H02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_H02")))!=0) {
			totalMap.put("SH_AC_H02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_H02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_H02")))));
		}
		else {
			totalMap.put("SH_AC_H02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_YTD")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_YTD")))!=0) {
			totalMap.put("SH_AC_YTD", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_AC_YTD")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_YTD")))));
		}
		else {
			totalMap.put("SH_AC_YTD", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P01")))!=0) {
			totalMap.put("SH_FOR_P01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P01")))));
		}
		else {
			totalMap.put("SH_FOR_P01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P02")))!=0) {
			totalMap.put("SH_FOR_P02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P02")))));
		}
		else {
			totalMap.put("SH_FOR_P02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P03")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P03")))!=0) {
			totalMap.put("SH_FOR_P03", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P03")))));
		}
		else {
			totalMap.put("SH_FOR_P03", 0);
		}	
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P04")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P04")))!=0) {
			totalMap.put("SH_FOR_P04", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P04")))));
		}
		else {
			totalMap.put("SH_FOR_P04", 0);
		}	
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P05")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P05")))!=0) {	
			totalMap.put("SH_FOR_P05", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P05")))));
		}
		else {
			totalMap.put("SH_FOR_P05", 0);
		}	
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P06")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P06")))!=0) {	
			totalMap.put("SH_FOR_P06", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P06")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P06")))));
		}
		else {
			totalMap.put("SH_FOR_P06", 0);
		}		
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P07")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P07")))!=0) {	
			totalMap.put("SH_FOR_P07", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P07")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P07")))));
		}
		else {
			totalMap.put("SH_FOR_P07", 0);
		}	
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P08")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P08")))!=0) {	
			totalMap.put("SH_FOR_P08", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P08")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P08")))));
		}
		else {
			totalMap.put("SH_FOR_P08", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P09")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P09")))!=0) {	
			totalMap.put("SH_FOR_P09", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P09")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P09")))));
		}
		else {
			totalMap.put("SH_FOR_P09", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P10")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P10")))!=0) {	
			totalMap.put("SH_FOR_P10", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P10")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P10")))));
		}
		else {
			totalMap.put("SH_FOR_P10", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P11")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P11")))!=0) {	
			totalMap.put("SH_FOR_P11", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P11")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P11")))));
		}
		else {
			totalMap.put("SH_FOR_P11", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P12")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P12")))!=0) {	
			totalMap.put("SH_FOR_P12", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_P12")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P12")))));
		}
		else {
			totalMap.put("SH_FOR_P12", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_Q01")))!=0) {	
			totalMap.put("SH_FOR_Q01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_Q01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q01")))));
		}
		else {
			totalMap.put("SH_FOR_Q01", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_Q02")))!=0) {	
			totalMap.put("SH_FOR_Q02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_Q02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q02")))));
		}
		else {
			totalMap.put("SH_FOR_Q02", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q03")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_Q03")))!=0) {	
			totalMap.put("SH_FOR_Q03", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_Q03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q03")))));
		}
		else {
			totalMap.put("SH_FOR_Q03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q04")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_Q04")))!=0) {	
			totalMap.put("SH_FOR_Q04", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_Q04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q04")))));
		}
		else {
			totalMap.put("SH_FOR_Q04", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_H01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_H01")))!=0) {	
			totalMap.put("SH_FOR_H01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_H01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_H01")))));
		}
		else {
			totalMap.put("SH_FOR_H01", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_H02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_H02")))!=0) {
			totalMap.put("SH_FOR_H02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_H02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_H02")))));
		}
		else {
			totalMap.put("SH_FOR_H02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_YTD")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_YTD")))!=0) {
			totalMap.put("SH_FOR_YTD", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_FOR_YTD")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_YTD")))));
		}
		else {
			totalMap.put("SH_FOR_YTD", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P01")))!=0) {
			totalMap.put("SH_OUT_P01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P01")))));
		}
		else {
			totalMap.put("SH_OUT_P01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P02")))!=0) {
			totalMap.put("SH_OUT_P02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P02")))));
		}
		else {
			totalMap.put("SH_OUT_P02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P03")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P03")))!=0) {
			totalMap.put("SH_OUT_P03", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P03")))));
		}
		else {
			totalMap.put("SH_OUT_P03", 0);
		}	
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P04")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P04")))!=0) {
			totalMap.put("SH_OUT_P04", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P04")))));
		}
		else {
			totalMap.put("SH_OUT_P04", 0);
		}	
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P05")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P05")))!=0) {	
			totalMap.put("SH_OUT_P05", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P05")))));
		}
		else {
			totalMap.put("SH_OUT_P05", 0);
		}	
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P06")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P06")))!=0) {	
			totalMap.put("SH_OUT_P06", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P06")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P06")))));
		}
		else {
			totalMap.put("SH_OUT_P06", 0);
		}		
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P07")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P07")))!=0) {	
			totalMap.put("SH_OUT_P07", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P07")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P07")))));
		}
		else {
			totalMap.put("SH_OUT_P07", 0);
		}	
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P08")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P08")))!=0) {	
			totalMap.put("SH_OUT_P08", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P08")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P08")))));
		}
		else {
			totalMap.put("SH_OUT_P08", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P09")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P09")))!=0) {	
			totalMap.put("SH_OUT_P09", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P09")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P09")))));
		}
		else {
			totalMap.put("SH_OUT_P09", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P10")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P10")))!=0) {	
			totalMap.put("SH_OUT_P10", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P10")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P10")))));
		}
		else {
			totalMap.put("SH_OUT_P10", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P11")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P11")))!=0) {	
			totalMap.put("SH_OUT_P11", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P11")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P11")))));
		}
		else {
			totalMap.put("SH_OUT_P11", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P12")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P12")))!=0) {	
			totalMap.put("SH_OUT_P12", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_P12")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P12")))));
		}
		else {
			totalMap.put("SH_OUT_P12", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_Q01")))!=0) {	
			totalMap.put("SH_OUT_Q01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_Q01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q01")))));
		}
		else {
			totalMap.put("SH_OUT_Q01", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_Q02")))!=0) {	
			totalMap.put("SH_OUT_Q02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_Q02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q02")))));
		}
		else {
			totalMap.put("SH_OUT_Q02", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q03")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_Q03")))!=0) {	
			totalMap.put("SH_OUT_Q03", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_Q03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q03")))));
		}
		else {
			totalMap.put("SH_OUT_Q03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q04")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_Q04")))!=0) {	
			totalMap.put("SH_OUT_Q04", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_Q04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q04")))));
		}
		else {
			totalMap.put("SH_OUT_Q04", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_H01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_H01")))!=0) {	
			totalMap.put("SH_OUT_H01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_H01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_H01")))));
		}
		else {
			totalMap.put("SH_OUT_H01", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_H02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_H02")))!=0) {
			totalMap.put("SH_OUT_H02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_H02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_H02")))));
		}
		else {
			totalMap.put("SH_OUT_H02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_YTD")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_YTD")))!=0) {
			totalMap.put("SH_OUT_YTD", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_OUT_YTD")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_YTD")))));
		}
		else {
			totalMap.put("SH_OUT_YTD", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P01")))!=0) {
			totalMap.put("SH_TG_P01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P01")))));
		}
		else {
			totalMap.put("SH_TG_P01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P02")))!=0) {
			totalMap.put("SH_TG_P02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P02")))));
		}
		else {
			totalMap.put("SH_TG_P02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P03")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P03")))!=0) {
			totalMap.put("SH_TG_P03", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P03")))));
		}
		else {
			totalMap.put("SH_TG_P03", 0);
		}	
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P04")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P04")))!=0) {
			totalMap.put("SH_TG_P04", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P04")))));
		}
		else {
			totalMap.put("SH_TG_P04", 0);
		}	
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P05")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P05")))!=0) {	
			totalMap.put("SH_TG_P05", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P05")))));
		}
		else {
			totalMap.put("SH_TG_P05", 0);
		}	
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P06")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P06")))!=0) {	
			totalMap.put("SH_TG_P06", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P06")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P06")))));
		}
		else {
			totalMap.put("SH_TG_P06", 0);
		}		
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P07")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P07")))!=0) {	
			totalMap.put("SH_TG_P07", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P07")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P07")))));
		}
		else {
			totalMap.put("SH_TG_P07", 0);
		}	
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P08")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P08")))!=0) {	
			totalMap.put("SH_TG_P08", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P08")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P08")))));
		}
		else {
			totalMap.put("SH_TG_P08", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P09")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P09")))!=0) {	
			totalMap.put("SH_TG_P09", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P09")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P09")))));
		}
		else {
			totalMap.put("SH_TG_P09", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P10")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P10")))!=0) {	
			totalMap.put("SH_TG_P10", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P10")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P10")))));
		}
		else {
			totalMap.put("SH_TG_P10", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P11")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P11")))!=0) {	
			totalMap.put("SH_TG_P11", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P11")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P11")))));
		}
		else {
			totalMap.put("SH_TG_P11", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P12")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P12")))!=0) {	
			totalMap.put("SH_TG_P12", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_P12")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P12")))));
		}
		else {
			totalMap.put("SH_TG_P12", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_Q01")))!=0) {	
			totalMap.put("SH_TG_Q01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_Q01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q01")))));
		}
		else {
			totalMap.put("SH_TG_Q01", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_Q02")))!=0) {	
			totalMap.put("SH_TG_Q02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_Q02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q02")))));
		}
		else {
			totalMap.put("SH_TG_Q02", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q03")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_Q03")))!=0) {	
			totalMap.put("SH_TG_Q03", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_Q03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q03")))));
		}
		else {
			totalMap.put("SH_TG_Q03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q04")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_Q04")))!=0) {	
			totalMap.put("SH_TG_Q04", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_Q04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q04")))));
		}
		else {
			totalMap.put("SH_TG_Q04", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_H01")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_H01")))!=0) {	
			totalMap.put("SH_TG_H01", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_H01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_H01")))));
		}
		else {
			totalMap.put("SH_TG_H01", 0);
		}
			
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_H02")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_H02")))!=0) {
			totalMap.put("SH_TG_H02", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_H02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_H02")))));
		}
		else {
			totalMap.put("SH_TG_H02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_YTD")))!=0 && Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_YTD")))!=0) {
			totalMap.put("SH_TG_YTD", (Double.parseDouble(String.valueOf(list.get(whiskyTotal).get("SH_TG_YTD")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_YTD")))));
		}
		else {
			totalMap.put("SH_TG_YTD", 0);
		}
		
		totalList.add(totalMap);
		
		double sh_ac_q01 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P01"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P02"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P03")))));
		double sh_ac_q02 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P04"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P05"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P06")))));
		double sh_ac_q03 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P07"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P08"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P09")))));
		double sh_ac_q04 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P10"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P11"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P12")))));
		double sh_ac_h01 = (sh_ac_q01+sh_ac_q02);
		double sh_ac_h02 = (sh_ac_q03+sh_ac_q04);
		double sh_ac_ytd = setAcYTD(param, nonWhisky, "SH");
		
		double sh_for_q01 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P01"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P02"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P03")))));
		double sh_for_q02 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P04"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P05"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P06")))));
		double sh_for_q03 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P07"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P08"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P09")))));
		double sh_for_q04 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P10"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P11"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P12")))));
		double sh_for_h01 = (sh_for_q01+sh_for_q02);
		double sh_for_h02 = (sh_for_q03+sh_for_q04);
		double sh_for_ytd = setForYTD(param, nonWhisky, "SH");
		
		double sh_out_q01 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P01"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P02"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P03")))));
		double sh_out_q02 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P04"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P05"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P06")))));
		double sh_out_q03 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P07"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P08"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P09")))));
		double sh_out_q04 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P10"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P11"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P12")))));
		double sh_out_h01 = (sh_out_q01+sh_out_q02);
		double sh_out_h02 = (sh_out_q03+sh_out_q04);
		double sh_out_ytd = setOutYTD(param, nonWhisky, "SH");

		double sh_tg_q01 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P01"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P02"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P03")))));
		double sh_tg_q02 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P04"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P05"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P06")))));
		double sh_tg_q03 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P07"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P08"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P09")))));
		double sh_tg_q04 = ((Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P10"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P11"))))+(Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P12")))));
		double sh_tg_h01 = (sh_tg_q01+sh_tg_q02);
		double sh_tg_h02 = (sh_tg_q03+sh_tg_q04);
		double sh_tg_ytd = setTgYTD(param, nonWhisky, "SH");
		
		nonWhisky.put("DATALV1_NM", "SDX Whisky");
		nonWhisky.put("DATALV2_NM", "SDX Whisky");
		nonWhisky.put("DATALV3_NM", "SDX Whisky");
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P01")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P01")))!=0) {
			nonWhisky.put("SH_AC_P01", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P01")))));
		}
		else {
			nonWhisky.put("SH_AC_P01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P02")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P02")))!=0) {
			nonWhisky.put("SH_AC_P02", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P02")))));
		}
		else {
			nonWhisky.put("SH_AC_P02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P03")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P03")))!=0) {
			nonWhisky.put("SH_AC_P03", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P03")))));
		}
		else {
			nonWhisky.put("SH_AC_P03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P04")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P04")))!=0) {
			nonWhisky.put("SH_AC_P04", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P04")))));
		}
		else {
			nonWhisky.put("SH_AC_P04", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P05")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P05")))!=0) {
			nonWhisky.put("SH_AC_P05", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P05")))));
		}
		else {
			nonWhisky.put("SH_AC_P05", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P06")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P06")))!=0) {
			nonWhisky.put("SH_AC_P06", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P06")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P06")))));
		}
		else {
			nonWhisky.put("SH_AC_P06", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P07")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P07")))!=0) {
			nonWhisky.put("SH_AC_P07", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P07")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P07")))));
		}
		else {
			nonWhisky.put("SH_AC_P07", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P08")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P08")))!=0) {
			nonWhisky.put("SH_AC_P08", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P08")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P08")))));
		}
		else {
			nonWhisky.put("SH_AC_P08", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P09")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P09")))!=0) {
			nonWhisky.put("SH_AC_P09", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P09")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P09")))));
		}
		else {
			nonWhisky.put("SH_AC_P09", 0);
		}
		
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P10")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P10")))!=0) {
			nonWhisky.put("SH_AC_P10", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P10")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P10")))));
		}
		else {
			nonWhisky.put("SH_AC_P10", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P11")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P11")))!=0) {
			nonWhisky.put("SH_AC_P11", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P11")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P11")))));
		}
		else {
			nonWhisky.put("SH_AC_P11", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P12")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P12")))!=0) {
			nonWhisky.put("SH_AC_P12", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_AC_P12")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_P12")))));
		}
		else {
			nonWhisky.put("SH_AC_P12", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q01")))!=0 && sh_ac_q01!=0) {
			nonWhisky.put("SH_AC_Q01", sh_ac_q01 / Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q01"))));
		}
		else {
			nonWhisky.put("SH_AC_Q01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q02")))!=0 && sh_ac_q02!=0) {
			nonWhisky.put("SH_AC_Q02", sh_ac_q02 / Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q02"))));
		}
		else {
			nonWhisky.put("SH_AC_Q02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q03")))!=0 && sh_ac_q03!=0) {
			nonWhisky.put("SH_AC_Q03", sh_ac_q03 / Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q03"))));
		}
		else {
			nonWhisky.put("SH_AC_Q03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q04")))!=0 && sh_ac_q04!=0) {
			nonWhisky.put("SH_AC_Q04", sh_ac_q04 / Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_Q04"))));
		}
		else {
			nonWhisky.put("SH_AC_Q04", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_H01")))!=0 && sh_ac_h01!=0) {
			nonWhisky.put("SH_AC_H01", sh_ac_h01 / Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_H01"))));
		}
		else {
			nonWhisky.put("SH_AC_H01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_H02")))!=0 && sh_ac_h02!=0) {
			nonWhisky.put("SH_AC_H02", sh_ac_h02 /  Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_H02"))));
		}
		else {
			nonWhisky.put("SH_AC_H02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_YTD")))!=0 && sh_ac_ytd!=0) {
			nonWhisky.put("SH_AC_YTD", sh_ac_ytd / Double.parseDouble(String.valueOf(list.get(total).get("SH_AC_YTD"))));
		}
		else {
			nonWhisky.put("SH_AC_YTD", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P01")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P01")))!=0) {
			nonWhisky.put("SH_FOR_P01", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P01")))));
		}
		else {
			nonWhisky.put("SH_FOR_P01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P02")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P02")))!=0) {
			nonWhisky.put("SH_FOR_P02", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P02")))));
		}
		else {
			nonWhisky.put("SH_FOR_P02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P03")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P03")))!=0) {
			nonWhisky.put("SH_FOR_P03", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P03")))));
		}
		else {
			nonWhisky.put("SH_FOR_P03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P04")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P04")))!=0) {
			nonWhisky.put("SH_FOR_P04", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P04")))));
		}
		else {
			nonWhisky.put("SH_FOR_P04", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P05")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P05")))!=0) {
			nonWhisky.put("SH_FOR_P05", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P05")))));
		}
		else {
			nonWhisky.put("SH_FOR_P05", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P05")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P05")))!=0) {
			nonWhisky.put("SH_FOR_P05", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P05")))));
		}
		else {
			nonWhisky.put("SH_FOR_P05", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P06")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P06")))!=0) {
			nonWhisky.put("SH_FOR_P06", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P06")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P06")))));
		}
		else {
			nonWhisky.put("SH_FOR_P06", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P07")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P07")))!=0) {
			nonWhisky.put("SH_FOR_P07", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P07")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P07")))));
		}
		else {
			nonWhisky.put("SH_FOR_P07", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P08")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P08")))!=0) {
			nonWhisky.put("SH_FOR_P08", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P08")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P08")))));
		}
		else {
			nonWhisky.put("SH_FOR_P08", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P09")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P09")))!=0) {
			nonWhisky.put("SH_FOR_P09", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P09")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P09")))));
		}
		else {
			nonWhisky.put("SH_FOR_P09", 0);
		}
		
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P10")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P10")))!=0) {
			nonWhisky.put("SH_FOR_P10", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P10")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P10")))));
		}
		else {
			nonWhisky.put("SH_FOR_P10", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P11")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P11")))!=0) {
			nonWhisky.put("SH_FOR_P11", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P11")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P11")))));
		}
		else {
			nonWhisky.put("SH_FOR_P11", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P12")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P12")))!=0) {
			nonWhisky.put("SH_FOR_P12", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_FOR_P12")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_P12")))));
		}
		else {
			nonWhisky.put("SH_FOR_P12", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q01")))!=0 && sh_for_q01!=0) {
			nonWhisky.put("SH_FOR_Q01", sh_for_q01 / Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q01"))));
		}
		else {
			nonWhisky.put("SH_FOR_Q01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q02")))!=0 && sh_for_q02!=0) {
			nonWhisky.put("SH_FOR_Q02", sh_for_q02 / Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q02"))));
		}
		else {
			nonWhisky.put("SH_FOR_Q02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q03")))!=0 && sh_for_q03!=0) {
			nonWhisky.put("SH_FOR_Q03", sh_for_q03 / Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q03"))));
		}
		else {
			nonWhisky.put("SH_FOR_Q03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q04")))!=0 && sh_for_q04!=0) {
			nonWhisky.put("SH_FOR_Q04", sh_for_q04 / Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_Q04"))));
		}
		else {
			nonWhisky.put("SH_FOR_Q04", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_H01")))!=0 && sh_for_h01!=0) {
			nonWhisky.put("SH_FOR_H01", sh_for_h01 / Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_H01"))));
		}
		else {
			nonWhisky.put("SH_FOR_H01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_H02")))!=0 && sh_for_h02!=0) {
			nonWhisky.put("SH_FOR_H02", sh_for_h02 /  Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_H02"))));
		}
		else {
			nonWhisky.put("SH_FOR_H02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_YTD")))!=0 && sh_for_ytd!=0) {
			nonWhisky.put("SH_FOR_YTD", sh_for_ytd / Double.parseDouble(String.valueOf(list.get(total).get("SH_FOR_YTD"))));
		}
		else {
			nonWhisky.put("SH_FOR_YTD", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P01")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P01")))!=0) {
			nonWhisky.put("SH_OUT_P01", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P01")))));
		}
		else {
			nonWhisky.put("SH_OUT_P01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P02")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P02")))!=0) {
			nonWhisky.put("SH_OUT_P02", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P02")))));
		}
		else {
			nonWhisky.put("SH_OUT_P02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P03")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P03")))!=0) {
			nonWhisky.put("SH_OUT_P03", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P03")))));
		}
		else {
			nonWhisky.put("SH_OUT_P03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P04")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P04")))!=0) {
			nonWhisky.put("SH_OUT_P04", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P04")))));
		}
		else {
			nonWhisky.put("SH_OUT_P04", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P05")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P05")))!=0) {
			nonWhisky.put("SH_OUT_P05", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P05")))));
		}
		else {
			nonWhisky.put("SH_OUT_P05", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P06")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P06")))!=0) {
			nonWhisky.put("SH_OUT_P06", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P06")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P06")))));
		}
		else {
			nonWhisky.put("SH_OUT_P06", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P07")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P07")))!=0) {
			nonWhisky.put("SH_OUT_P07", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P07")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P07")))));
		}
		else {
			nonWhisky.put("SH_OUT_P07", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P08")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P08")))!=0) {
			nonWhisky.put("SH_OUT_P08", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P08")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P08")))));
		}
		else {
			nonWhisky.put("SH_OUT_P08", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P09")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P09")))!=0) {
			nonWhisky.put("SH_OUT_P09", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P09")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P09")))));
		}
		else {
			nonWhisky.put("SH_OUT_P09", 0);
		}
		
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P10")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P10")))!=0) {
			nonWhisky.put("SH_OUT_P10", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P10")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P10")))));
		}
		else {
			nonWhisky.put("SH_OUT_P10", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P11")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P11")))!=0) {
			nonWhisky.put("SH_OUT_P11", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P11")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P11")))));
		}
		else {
			nonWhisky.put("SH_OUT_P11", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P12")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P12")))!=0) {
			nonWhisky.put("SH_OUT_P12", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_OUT_P12")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_P12")))));
		}
		else {
			nonWhisky.put("SH_OUT_P12", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q01")))!=0 && sh_out_q01!=0) {
			nonWhisky.put("SH_OUT_Q01", sh_out_q01 / Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q01"))));
		}
		else {
			nonWhisky.put("SH_OUT_Q01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q02")))!=0 && sh_out_q02!=0) {
			nonWhisky.put("SH_OUT_Q02", sh_out_q02 / Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q02"))));
		}
		else {
			nonWhisky.put("SH_OUT_Q02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q03")))!=0 && sh_out_q03!=0) {
			nonWhisky.put("SH_OUT_Q03", sh_out_q03 / Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q03"))));
		}
		else {
			nonWhisky.put("SH_OUT_Q03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q04")))!=0 && sh_out_q04!=0) {
			nonWhisky.put("SH_OUT_Q04", sh_out_q04 / Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_Q04"))));
		}
		else {
			nonWhisky.put("SH_OUT_Q04", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_H01")))!=0 && sh_out_h01!=0) {
			nonWhisky.put("SH_OUT_H01", sh_out_h01 / Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_H01"))));
		}
		else {
			nonWhisky.put("SH_OUT_H01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_H02")))!=0 && sh_out_h02!=0) {
			nonWhisky.put("SH_OUT_H02", sh_out_h02 /  Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_H02"))));
		}
		else {
			nonWhisky.put("SH_OUT_H02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_YTD")))!=0 && sh_out_ytd!=0) {
			nonWhisky.put("SH_OUT_YTD", sh_out_ytd / Double.parseDouble(String.valueOf(list.get(total).get("SH_OUT_YTD"))));
		}
		else {
			nonWhisky.put("SH_OUT_YTD", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P01")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P01")))!=0) {
			nonWhisky.put("SH_TG_P01", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P01")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P01")))));
		}
		else {
			nonWhisky.put("SH_TG_P01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P02")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P02")))!=0) {
			nonWhisky.put("SH_TG_P02", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P02")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P02")))));
		}
		else {
			nonWhisky.put("SH_TG_P02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P03")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P03")))!=0) {
			nonWhisky.put("SH_TG_P03", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P03")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P03")))));
		}
		else {
			nonWhisky.put("SH_TG_P03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P04")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P04")))!=0) {
			nonWhisky.put("SH_TG_P04", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P04")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P04")))));
		}
		else {
			nonWhisky.put("SH_TG_P04", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P05")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P05")))!=0) {
			nonWhisky.put("SH_TG_P05", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P05")))));
		}
		else {
			nonWhisky.put("SH_TG_P05", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P05")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P05")))!=0) {
			nonWhisky.put("SH_TG_P05", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P05")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P05")))));
		}
		else {
			nonWhisky.put("SH_TG_P05", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P06")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P06")))!=0) {
			nonWhisky.put("SH_TG_P06", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P06")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P06")))));
		}
		else {
			nonWhisky.put("SH_TG_P06", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P07")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P07")))!=0) {
			nonWhisky.put("SH_TG_P07", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P07")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P07")))));
		}
		else {
			nonWhisky.put("SH_TG_P07", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P08")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P08")))!=0) {
			nonWhisky.put("SH_TG_P08", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P08")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P08")))));
		}
		else {
			nonWhisky.put("SH_TG_P08", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P09")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P09")))!=0) {
			nonWhisky.put("SH_TG_P09", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P09")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P09")))));
		}
		else {
			nonWhisky.put("SH_TG_P09", 0);
		}
		
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P10")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P10")))!=0) {
			nonWhisky.put("SH_TG_P10", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P10")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P10")))));
		}
		else {
			nonWhisky.put("SH_TG_P10", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P11")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P11")))!=0) {
			nonWhisky.put("SH_TG_P11", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P11")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P11")))));
		}
		else {
			nonWhisky.put("SH_TG_P11", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P12")))!=0 && Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P12")))!=0) {
			nonWhisky.put("SH_TG_P12", (Double.parseDouble(String.valueOf(nonWhisky.get("SH_TG_P12")))/Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_P12")))));
		}
		else {
			nonWhisky.put("SH_TG_P12", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q01")))!=0 && sh_tg_q01!=0) {
			nonWhisky.put("SH_TG_Q01", sh_tg_q01 / Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q01"))));
		}
		else {
			nonWhisky.put("SH_TG_Q01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q02")))!=0 && sh_tg_q02!=0) {
			nonWhisky.put("SH_TG_Q02", sh_tg_q02 / Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q02"))));
		}
		else {
			nonWhisky.put("SH_TG_Q02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q03")))!=0 && sh_tg_q03!=0) {
			nonWhisky.put("SH_TG_Q03", sh_tg_q03 / Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q03"))));
		}
		else {
			nonWhisky.put("SH_TG_Q03", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q04")))!=0 && sh_tg_q04!=0) {
			nonWhisky.put("SH_TG_Q04", sh_tg_q04 / Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_Q04"))));
		}
		else {
			nonWhisky.put("SH_TG_Q04", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_H01")))!=0 && sh_tg_h01!=0) {
			nonWhisky.put("SH_TG_H01", sh_tg_h01 / Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_H01"))));
		}
		else {
			nonWhisky.put("SH_TG_H01", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_H02")))!=0 && sh_tg_h02!=0) {
			nonWhisky.put("SH_TG_H02", sh_tg_h02 /  Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_H02"))));
		}
		else {
			nonWhisky.put("SH_TG_H02", 0);
		}
		
		if(Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_YTD")))!=0 && sh_tg_ytd!=0) {
			nonWhisky.put("SH_TG_YTD", sh_tg_ytd / Double.parseDouble(String.valueOf(list.get(total).get("SH_TG_YTD"))));
		}
		else {
			nonWhisky.put("SH_TG_YTD", 0);
		}
		
		totalList.add(nonWhisky);
		
		return totalList;
	}
	
	//shipment 엑셀출력
	public int shForecastExcel(ArrayList<Map>list, ArrayList<Map>list1, int rowCount, HSSFRow row, HSSFCell cell, HSSFWorkbook shBook, HSSFSheet shSheet, Map param) throws Exception {
		String header1 = param.get("Lfy").toString().concat(" Actual");
		String header2 = param.get("fy").toString().concat(" Forecast");
		String header3 = "Forecast Accuracy% vs. Forecast";
		String[] headerNm = {header1, header2, header3}; 
		
		//헤더
		int strartRow = excelHeader(rowCount, row, cell, shBook, shSheet, headerNm, param);
		
		ArrayList<Map> lv1List = new ArrayList<Map>();
		ArrayList<Map> lv2List = new ArrayList<Map>();
		int lv1Count = 0;
		int dataLv1Count = 0;
		Map countMap1 = new HashMap();
		int listCount = 0;
		
		int lv2Count = 0;
		int dataLv2Count = 0;
		Map countMap2 = new HashMap();
		
		//lv1 구분
		String dataLv1 = null;
		for(int i=0; i<list.size(); i++) {
			if(i == 0) {
				dataLv1 = (String)list.get(0).get("DATALV1_NM");
			}
			if(dataLv1.equals(list.get(i).get("DATALV1_NM")) && i == (list.size()-1)) {
				dataLv1Count++;
				lv1Count++;
				countMap1.put(lv1Count, dataLv1Count);
				lv1List.add(countMap1);
			}
			else if(dataLv1.equals(list.get(i).get("DATALV1_NM"))) {
				dataLv1Count++;
			}
			else {
				lv1Count++;
				countMap1.put(lv1Count, dataLv1Count);
				lv1List.add(countMap1);
				dataLv1 = (String) list.get(i).get("DATALV1_NM");
				dataLv1Count = 1;
			}
		}
		
		//lv2 구분
		String dataLv2 = null;
		for(int i=0; i<list.size(); i++) {
			if(i == 0) {
				dataLv2 = (String)list.get(0).get("DATALV2_NM");
			}
			if(dataLv2.equals(list.get(i).get("DATALV2_NM")) && i == (list.size()-1)) {
				dataLv2Count++;
				lv2Count++;
				countMap2.put(lv2Count, dataLv2Count);
				lv2List.add(countMap2);
			}
			else if(dataLv2.equals(list.get(i).get("DATALV2_NM"))) {
				dataLv2Count++;
			}
			else {
				lv2Count++;
				countMap2.put(lv2Count, dataLv2Count);
				lv2List.add(countMap2);
				dataLv2 = (String) list.get(i).get("DATALV2_NM");
				dataLv2Count = 1;
			}
		}
		
		//표밑 빨간 글씨
		CellStyle style = shBook.createCellStyle();
    	DataFormat format = shBook.createDataFormat();
    	style.setDataFormat(format.getFormat("#,##0.0%"));
    	style.setAlignment(CellStyle.ALIGN_RIGHT);
    	HSSFFont font = (HSSFFont) shBook.createFont();
    	font.setColor(HSSFColor.RED.index);
    	font.setFontName("맑은 고딕");
    	style.setFont(font);
		
    	//lv1 글씨 스타일
    	CellStyle style3 = shBook.createCellStyle();
    	HSSFFont font3 = (HSSFFont) shBook.createFont();
    	font3.setFontName("맑은 고딕");
    	style3.setFont(font3);
    	style3.setAlignment(CellStyle.ALIGN_CENTER);
    	style3.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    	style3.setFillForegroundColor(HSSFColor.WHITE.index);
    	style3.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style3.setBorderRight(CellStyle.BORDER_THICK);
    	style3.setBorderLeft(CellStyle.BORDER_THICK);
    	style3.setBorderTop(CellStyle.BORDER_THIN);
    	style3.setBorderBottom(CellStyle.BORDER_THIN);//lv1
    	
    	//Row 숫자
    	CellStyle style4 = shBook.createCellStyle();
    	DataFormat format4 = shBook.createDataFormat();
    	style4.setDataFormat(format4.getFormat("#,##0"));
    	style4.setFont(font3);
    	style4.setAlignment(CellStyle.ALIGN_RIGHT);
    	style4.setFillForegroundColor(HSSFColor.WHITE.index);
    	style4.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style4.setBorderRight(CellStyle.BORDER_THIN);
    	style4.setBorderLeft(CellStyle.BORDER_THIN);
    	style4.setBorderTop(CellStyle.BORDER_THIN);
    	style4.setBorderBottom(CellStyle.BORDER_THIN);//값
    	
    	//Row 백분율 스타일
    	CellStyle style12 = shBook.createCellStyle();
    	DataFormat format12 = shBook.createDataFormat();
    	style12.setDataFormat(format12.getFormat("#,##0.0%"));
    	style12.setFont(font3);
    	style12.setAlignment(CellStyle.ALIGN_RIGHT);
    	style12.setFillForegroundColor(HSSFColor.WHITE.index);
    	style12.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style12.setBorderRight(CellStyle.BORDER_THIN);
    	style12.setBorderLeft(CellStyle.BORDER_THIN);
    	style12.setBorderTop(CellStyle.BORDER_THIN);
    	style12.setBorderBottom(CellStyle.BORDER_THIN);//값
    	
    	//sub Total(Lv2 total)
    	CellStyle style5 = shBook.createCellStyle();
    	style5.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font5 = (HSSFFont) shBook.createFont();
    	font5.setFontName("맑은 고딕");
    	style5.setFont(font5);
    	style5.setFillForegroundColor(HSSFColor.GOLD.index);
    	style5.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style5.setBorderRight(CellStyle.BORDER_THICK);
    	style5.setBorderLeft(CellStyle.BORDER_THICK);
    	style5.setBorderTop(CellStyle.BORDER_THIN);
    	style5.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	//sub Total(Lv2 total) 숫자
    	CellStyle style6 = shBook.createCellStyle();
    	DataFormat format6 = shBook.createDataFormat();
    	style6.setDataFormat(format4.getFormat("#,##0"));
    	style6.setFont(font5);
    	style6.setAlignment(CellStyle.ALIGN_RIGHT);
    	style6.setFillForegroundColor(HSSFColor.GOLD.index);
    	style6.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style6.setBorderRight(CellStyle.BORDER_THIN);
    	style6.setBorderLeft(CellStyle.BORDER_THIN);
    	style6.setBorderTop(CellStyle.BORDER_THIN);
    	style6.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	//sub Total(Lv2 total) 백분율
    	CellStyle style13 = shBook.createCellStyle();
    	DataFormat format13 = shBook.createDataFormat();
    	style13.setDataFormat(format13.getFormat("#,##0.0%"));
    	style13.setAlignment(CellStyle.ALIGN_RIGHT);
    	style13.setFillForegroundColor(HSSFColor.GOLD.index);
    	style13.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style13.setBorderRight(CellStyle.BORDER_THIN);
    	style13.setBorderLeft(CellStyle.BORDER_THIN);
    	style13.setBorderTop(CellStyle.BORDER_THIN);
    	style13.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	//Whisky Total(Lv1 total)
    	CellStyle style7 = shBook.createCellStyle();
    	style7.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font7 = (HSSFFont) shBook.createFont();
    	font7.setColor(HSSFColor.WHITE.index);
    	font7.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font7.setFontName("맑은 고딕");
    	style7.setFont(font7);
    	style7.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style7.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style7.setBorderRight(CellStyle.BORDER_THICK);
    	style7.setBorderLeft(CellStyle.BORDER_THICK);
    	style7.setBorderTop(CellStyle.BORDER_THICK);
    	style7.setBorderBottom(CellStyle.BORDER_THICK); 	
    	
    	//sub Total(Lv2 total) 숫자
    	CellStyle style8 = shBook.createCellStyle();
    	DataFormat format8 = shBook.createDataFormat();
    	style8.setDataFormat(format8.getFormat("#,##0"));
    	style8.setAlignment(CellStyle.ALIGN_RIGHT);
    	HSSFFont font8 = (HSSFFont) shBook.createFont();
    	font8.setColor(HSSFColor.WHITE.index);
    	font8.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font8.setFontName("맑은 고딕");
    	style8.setFont(font8);
    	style8.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style8.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style8.setBorderRight(CellStyle.BORDER_THIN);
    	style8.setBorderLeft(CellStyle.BORDER_THIN);
    	style8.setBorderTop(CellStyle.BORDER_THICK);
    	style8.setBorderBottom(CellStyle.BORDER_THICK);//값
    	
    	//sub Total(Lv2 total) 백분율
    	CellStyle style14 = shBook.createCellStyle();
    	DataFormat format14 = shBook.createDataFormat();
    	style14.setDataFormat(format14.getFormat("#,##0.0%"));
    	style14.setAlignment(CellStyle.ALIGN_RIGHT);
    	style14.setFont(font8);
    	style14.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style14.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style14.setBorderRight(CellStyle.BORDER_THIN);
    	style14.setBorderLeft(CellStyle.BORDER_THIN);
    	style14.setBorderTop(CellStyle.BORDER_THICK);
    	style14.setBorderBottom(CellStyle.BORDER_THICK);//값
    	
    	//Total(최종 합계)
    	CellStyle style9 = shBook.createCellStyle();
    	style9.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font9 = (HSSFFont) shBook.createFont();
    	font9.setColor(HSSFColor.WHITE.index);
    	font9.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	style9.setFont(font9);
    	style9.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style9.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style9.setBorderRight(CellStyle.BORDER_THICK);
    	style9.setBorderLeft(CellStyle.BORDER_THICK);
    	style9.setBorderTop(CellStyle.BORDER_THICK);
    	style9.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	//Total(최종합계) 숫자
    	CellStyle style10 = shBook.createCellStyle();
    	DataFormat format10 = shBook.createDataFormat();
    	style10.setDataFormat(format10.getFormat("#,##0"));
    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	HSSFFont font10 = (HSSFFont) shBook.createFont();
    	font10.setColor(HSSFColor.WHITE.index);
    	font10.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
    	style10.setFont(font10);
    	style10.setAlignment(CellStyle.ALIGN_RIGHT);
    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style10.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style10.setBorderRight(CellStyle.BORDER_THIN);
    	style10.setBorderLeft(CellStyle.BORDER_THIN);
    	style10.setBorderTop(CellStyle.BORDER_THICK);
    	style10.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	//Total(최종합계) 숫자 백분율
    	CellStyle style11 = shBook.createCellStyle();
    	DataFormat format11 = shBook.createDataFormat();
    	style11.setDataFormat(format11.getFormat("#,##0.0%"));
    	style11.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	HSSFFont font11 = (HSSFFont) shBook.createFont();
    	font11.setColor(HSSFColor.WHITE.index);
    	font11.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
    	style11.setFont(font11);
    	style11.setAlignment(CellStyle.ALIGN_RIGHT);
    	style11.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style11.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style11.setBorderRight(CellStyle.BORDER_THIN);
    	style11.setBorderLeft(CellStyle.BORDER_THIN);
    	style11.setBorderTop(CellStyle.BORDER_THICK);
    	style11.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	// 표 제목
    	CellStyle style1 = shBook.createCellStyle();
    	HSSFFont font1 = (HSSFFont) shBook.createFont();
    	font1.setColor(HSSFColor.DARK_RED.index);
    	font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font1.setFontName("맑은 고딕");
    	style1.setFont(font1);
    	
    	CellStyle shCalc1SignalStyle = null; 
    	HSSFFont shCalc1SignalFont = null;
    	
    	int tableRow =strartRow;
    	int lv1Sum = 0;
    	int lv2Sum = 0;
    	int currentRow = 0;
    	int lv2Row = tableRow;
    	int startCell = 0;
    	double [] calc = new double[7];
    	
		for(int i =0; i<list.size(); i++) {
			//row 생성
			//----------------------------------------
        	row = shSheet.createRow(2);
        	cell = row.createCell(1);
        	cell.setCellValue(new HSSFRichTextString("Shipment Forecast"));
        	cell.setCellStyle(style1);
        	//----------------------------------------
			row = shSheet.createRow(tableRow+i);
			
			//lv1 셀병합
			for(int j=0; j<lv1List.size(); j++) {
				if(j == 0) {
					lv1Sum = Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				}
				else {
					lv1Sum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				}
				
				if(i == lv1Sum){
					if(j == 0) {
						shSheet.addMergedRegion(new Region(( int) tableRow , ( short )1 , ( int) tableRow+i-1, (short )1 ));
						shSheet.addMergedRegion(new Region(( int) tableRow+i-1 , ( short )2 , ( int) tableRow+i-1, (short )4 ));
					}
					else {
						shSheet.addMergedRegion(new Region(( int) (tableRow+Integer.parseInt(String.valueOf(lv1List.get(j-1).get(j)))) , ( short )1 , ( int) tableRow+i-1, (short )1 ));
						shSheet.addMergedRegion(new Region(( int) tableRow+i-1 , ( short )2 , ( int) tableRow+i-1, (short )4 ));
					}
				}
			}
			
			//lv2 셀병합
			for(int j=0; j<lv2List.size(); j++) {
				if(j == 0) {
					lv2Sum = Integer.parseInt(String.valueOf(lv2List.get(j).get(j+1)));
				}
				else {
					lv2Sum += Integer.parseInt(String.valueOf(lv2List.get(j).get(j+1)));
				}
				
				if(i == lv2Sum){
					if(j == 0) {
						shSheet.addMergedRegion(new Region(( int) tableRow , ( short )2 , ( int) tableRow+i-1, (short )2 ));
					}
					else {
						lv2Row += Integer.parseInt(String.valueOf(lv2List.get(j-1).get(j)));
						shSheet.addMergedRegion(new Region(( int) lv2Row , ( short )2 , ( int) tableRow+i-1, (short )2 ));
					}
				}
			}
			
			//P01~P12 셀생성
			cell = row.createCell(1);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV1_NM"));
			
			cell = row.createCell(2);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV2_NM"));
			
			cell = row.createCell(3);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
			
			cell = row.createCell(4);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
			
			cell = row.createCell(5);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P01"))));
			
			cell = row.createCell(6);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P02"))));
			
			cell = row.createCell(7);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P03"))));
			
			cell = row.createCell(8);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P04"))));
			
			cell = row.createCell(9);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P05"))));
			
			cell = row.createCell(10);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P06"))));
			
			cell = row.createCell(11);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P07"))));
			
			cell = row.createCell(12);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P08"))));
			
			cell = row.createCell(13);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P09"))));
			
			cell = row.createCell(14);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P10"))));
			
			cell = row.createCell(15);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P11"))));
			
			cell = row.createCell(16);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_P12"))));
			

			cell = row.createCell(17);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q01"))));
			
			cell = row.createCell(18);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q02"))));
			
			cell = row.createCell(19);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q03"))));
			
			cell = row.createCell(20);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_Q04"))));
			
			cell = row.createCell(21);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H01"))));
			
			cell = row.createCell(22);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_H02"))));
			
			cell = row.createCell(23);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_AC_YTD"))));
			
			cell = row.createCell(24);
			cell.setCellType(0);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P01"))));
			                                                   
			cell = row.createCell(25);                         
			cell.setCellType(0);    
			cell.setCellStyle(style4);   
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P02"))));
			                                                    
			cell = row.createCell(26);                          
			cell.setCellType(0);      
			cell.setCellStyle(style4); 
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P03"))));
			                                                    
			cell = row.createCell(27);                          
			cell.setCellType(0); 
			cell.setCellStyle(style4);      
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P04"))));
			                                                    
			cell = row.createCell(28);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);  
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P05"))));
			                                                    
			cell = row.createCell(29);                          
			cell.setCellType(0);  
			cell.setCellStyle(style4);     
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P06"))));
			                                                    
			cell = row.createCell(30);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);  
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P07"))));
			                                                    
			cell = row.createCell(31);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);  
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P08"))));
			                                                    
			cell = row.createCell(32);                          
			cell.setCellType(0);    
			cell.setCellStyle(style4);   
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P09"))));
			                                                    
			cell = row.createCell(33);                          
			cell.setCellType(0);    
			cell.setCellStyle(style4);   
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P10"))));
			                                                    
			cell = row.createCell(34);                          
			cell.setCellType(0);   
			cell.setCellStyle(style4);    
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P11"))));
			                                                    
			cell = row.createCell(35);                          
			cell.setCellType(0);   
			cell.setCellStyle(style4);    
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_P12"))));
			                                                    
			cell = row.createCell(36);                          
			cell.setCellType(0);       
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q01"))));
			                                                    
			cell = row.createCell(37);                          
			cell.setCellType(0);    
			cell.setCellStyle(style4);   
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q02"))));
			                                                    
			cell = row.createCell(38);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);  
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q03"))));
			                                                    
			cell = row.createCell(39);                          
			cell.setCellType(0);   
			cell.setCellStyle(style4);    
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_Q04"))));
			                                                    
			cell = row.createCell(40);                          
			cell.setCellType(0);  
			cell.setCellStyle(style4);     
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H01"))));
			                                                    
			cell = row.createCell(41);                          
			cell.setCellType(0);   
			cell.setCellStyle(style4);    
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_H02"))));
			                                                    
			cell = row.createCell(42);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);  
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_FOR_YTD"))));
			
			int subSum = 0;
			int lv2SubSum = 0;
			
			//lv2 합계에 따른 스타일 적용
			for(int j=0; j<lv2List.size(); j++) {
				lv2SubSum += Integer.parseInt(String.valueOf(lv2List.get(j).get(j+1)));
				
				if(i == lv2SubSum-1) {
					for(int y=2; y<43; y++) {
						if(y > 4) {
							row.getCell(y).setCellStyle(style6);
						}
						else {
							row.getCell(y).setCellStyle(style5);
						}
					}
				}
				
				if(j == (lv2List.size() -1)) {
					lv2SubSum = 0;
				}
			}
			
			if(i == (list.size()-1)) {
				for(int y=2; y<43; y++) {
					row.getCell(y).setCellStyle(style10);
				}
			}
			
			//lv1 합계 따른 셀 스타일 적용
			for(int j=0; j<lv1List.size(); j++) {
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					for(int y=2; y<43; y++) {
						if(y > 4) {
							row.getCell(y).setCellStyle(style8);
						}
						else {
							row.getCell(y).setCellStyle(style7);
						}
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			//두번째 표 생성
			cell = row.createCell(44);
			cell.setCellType(0);
			cell.setCellStyle(style12);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P01"))));
			                                                   
			cell = row.createCell(45);                         
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P02"))));
			                                                    
			cell = row.createCell(46);                          
			cell.setCellType(0);  
			cell.setCellStyle(style12);     
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P03"))));
			                                                    
			cell = row.createCell(47);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P04"))));
			                                                    
			cell = row.createCell(48);                          
			cell.setCellType(0);     
			cell.setCellStyle(style12);  
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P05"))));
			                                                    
			cell = row.createCell(49);                          
			cell.setCellType(0);     
			cell.setCellStyle(style12);  
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P06"))));
			                                                    
			cell = row.createCell(50);                          
			cell.setCellType(0);     
			cell.setCellStyle(style12);  
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P07"))));
			                                                    
			cell = row.createCell(51);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P08"))));
			                                                    
			cell = row.createCell(52);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P09"))));
			                                                    
			cell = row.createCell(53);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P10"))));
			                                                    
			cell = row.createCell(54);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P11"))));
			                                                    
			cell = row.createCell(55);                          
			cell.setCellType(0);     
			cell.setCellStyle(style12);  
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_P12"))));
			                                                    
			cell = row.createCell(56);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_Q1"))));
			                                                    
			cell = row.createCell(57);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_Q2"))));
			                                                    
			cell = row.createCell(58);                          
			cell.setCellType(0);      
			cell.setCellStyle(style12); 
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_Q3"))));
			                                                    
			cell = row.createCell(59);                          
			cell.setCellType(0);      
			cell.setCellStyle(style12); 
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_Q4"))));
			                                                    
			cell = row.createCell(60);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_H1"))));
			                                                    
			cell = row.createCell(61);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_H2"))));
			                                                    
			cell = row.createCell(62);                          
			cell.setCellType(0);       
			cell.setCellStyle(style12);
			cell.setCellValue( Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_YTD"))));
			
			cell = row.createCell(63);                          
			cell.setCellType(0);       
			cell.setCellStyle(style4);
			cell.setCellValue("");
			
			cell = row.createCell(64);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);  
			cell.setCellValue("");
			
			cell = row.createCell(65);                          
			cell.setCellType(0);       
			cell.setCellStyle(style4);
			cell.setCellValue("");
			
			cell = row.createCell(66);                          
			cell.setCellType(0);       
			cell.setCellStyle(style4);
			cell.setCellValue("");
			
			cell = row.createCell(67);                          
			cell.setCellType(0);       
			cell.setCellStyle(style4);
			cell.setCellValue("");
			
			cell = row.createCell(68);                          
			cell.setCellType(0);       
			cell.setCellStyle(style4);
			cell.setCellValue("");
			
			cell = row.createCell(69);                          
			cell.setCellType(0);       
			cell.setCellStyle(style4);
			cell.setCellValue("");
			
			calc[0] = Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_Q1")));
			calc[1] = Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_Q2")));
			calc[2] = Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_Q3")));
			calc[3] = Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_Q4")));
			calc[4] = Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_H1")));
			calc[5] = Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_H2")));
			calc[6] = Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC1_YTD")));
			
			for(int j=0; j<lv2List.size(); j++) {
				lv2SubSum += Integer.parseInt(String.valueOf(lv2List.get(j).get(j+1)));
				
				if(i == lv2SubSum-1) {
					startCell = 63;
					for(int y=44; y<63; y++) {
						row.getCell(y).setCellStyle(style13);
					}
					for(int y=0; y<calc.length; y++) {
						double signalValue = 0;
						if(calc[y] < 0) {
							signalValue = calc[y] * -1;
						}
						else {
							signalValue = calc[y] * 1;
						}
						shCalc1SignalStyle = shBook.createCellStyle(); 
						shCalc1SignalFont = (HSSFFont) shBook.createFont();
						//setSignal1 신호등 스타일 입히기
						setSignal1(startCell, shCalc1SignalStyle, shCalc1SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc1SignalStyle(shCalc1SignalFont, signalValue, i, list.size()), "lv2");
						startCell++;
					}
				}
				
				if(j == (lv2List.size() -1)) {
					lv2SubSum = 0;
				}
			}
			
			for(int j=0; j<lv1List.size(); j++) {
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					startCell = 63;
					for(int y=44; y<63; y++) {
						row.getCell(y).setCellStyle(style14);
					}
					for(int y=0; y<calc.length; y++) {
						double signalValue = 0;
						if(calc[y] < 0) {
							signalValue = calc[y] * -1;
						}
						else {
							signalValue = calc[y] * 1;
						}
						
						shCalc1SignalStyle = shBook.createCellStyle(); 
						shCalc1SignalFont = (HSSFFont) shBook.createFont();
						setSignal1(startCell, shCalc1SignalStyle, shCalc1SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc1SignalStyle(shCalc1SignalFont, signalValue, i, list.size()), "lv1");
						startCell++;
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			if(i == (list.size()-1)) {
				startCell = 63;
				for(int y=44; y<63; y++) {
					row.getCell(y).setCellStyle(style11);
				}
				for(int y=0; y<calc.length; y++) {
					double signalValue = 0;
					if(calc[y] < 0) {
						signalValue = calc[y] * -1;
					}
					else {
						signalValue = calc[y] * 1;
					}
					
					shCalc1SignalStyle = shBook.createCellStyle(); 
					shCalc1SignalFont = (HSSFFont) shBook.createFont();
					setSignal1(startCell, shCalc1SignalStyle, shCalc1SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc1SignalStyle(shCalc1SignalFont, signalValue, i, list.size()), "lv1");
					startCell++;
				}
			}
			
			if(i == list.size()-1) {
				shSheet.addMergedRegion(new Region(( int) currentRow+1 , ( short )1 , ( int) currentRow+1, (short )4 ));
				row.getCell(1).setCellStyle(style9);
			}
			shSheet.addMergedRegion(new Region(( int) currentRow , ( short )3 , ( int) currentRow, (short )4 ));
			
			currentRow = row.getRowNum();
			listCount++;
		}
		
		for(int i=0; i<list1.size(); i++) {
			currentRow += 1;
			row = shSheet.createRow(currentRow);
			
			cell = row.createCell(1);
			cell.setCellType(1);
			cell.setCellStyle(style);
			cell.setCellValue(String.valueOf(list1.get(i).get("DATALV1_NM")));
			
			cell = row.createCell(5);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P01"))));
			
			cell = row.createCell(6);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P02"))));
			
			cell = row.createCell(7);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P03"))));
			
			cell = row.createCell(8);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P04"))));
			
			cell = row.createCell(9);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P05"))));
			
			cell = row.createCell(10);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P06"))));
			
			cell = row.createCell(11);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P07"))));
			
			cell = row.createCell(12);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P08"))));
			
			cell = row.createCell(13);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P09"))));
			
			cell = row.createCell(14);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P10"))));
			
			cell = row.createCell(15);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P11"))));
			
			cell = row.createCell(16);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_P12"))));
			

			cell = row.createCell(17);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_Q01"))));
			
			cell = row.createCell(18);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_Q02"))));
			
			cell = row.createCell(19);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_Q03"))));
			
			cell = row.createCell(20);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_Q04"))));
			
			cell = row.createCell(21);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_H01"))));
			
			cell = row.createCell(22);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_H02"))));
			
			cell = row.createCell(23);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_AC_YTD"))));
			
			cell = row.createCell(24);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P01"))));
			                                                   
			cell = row.createCell(25);                         
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P02"))));
			                                                    
			cell = row.createCell(26);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P03"))));
			                                                    
			cell = row.createCell(27);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P04"))));
			                                                    
			cell = row.createCell(28);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P05"))));
			                                                    
			cell = row.createCell(29);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P06"))));
			                                                    
			cell = row.createCell(30);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P07"))));
			                                                    
			cell = row.createCell(31);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P08"))));
			                                                    
			cell = row.createCell(32);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P09"))));
			                                                    
			cell = row.createCell(33);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P10"))));
			                                                    
			cell = row.createCell(34);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P11"))));
			                                                    
			cell = row.createCell(35);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_P12"))));
			                                                    
			cell = row.createCell(36);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_Q01"))));
			                                                    
			cell = row.createCell(37);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_Q02"))));
			                                                    
			cell = row.createCell(38);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_Q03"))));
			                                                    
			cell = row.createCell(39);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_Q04"))));
			                                                    
			cell = row.createCell(40);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_H01"))));
			                                                    
			cell = row.createCell(41);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_H02"))));
			                                                    
			cell = row.createCell(42);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_FOR_YTD"))));
			
			listCount++;
		}
		
		return listCount;
	}
	
	//shipment Target Excel 만들기
	public int shTargetExcel(ArrayList<Map> list, ArrayList<Map> list1, int rowCount, HSSFRow row, HSSFCell cell, HSSFWorkbook shBook, HSSFSheet shSheet, Map param) throws Exception {
		String header1 = param.get("fy").toString().concat(" Actual (Outlook)");
		String header2 = param.get("fy").toString().concat(" Target");
		String header3 = "Achievement% vs. Target";
		String header4 = "Growth Rate% vs ".concat(param.get("Lfy").toString());
		String[] headerNm = {header1, header2, header3, header4}; 
		
		int strartRow = excelHeader(rowCount, row, cell, shBook, shSheet, headerNm, param);
		
		ArrayList<Map> lv1List = new ArrayList<Map>();
		ArrayList<Map> lv2List = new ArrayList<Map>();
		int lv1Count = 0;
		int dataLv1Count = 0;
		Map countMap1 = new HashMap();
		int listCount = 0;
		
		int lv2Count = 0;
		int dataLv2Count = 0;
		Map countMap2 = new HashMap();
		
		String dataLv1 = null;
		for(int i=0; i<list.size(); i++) {
			if(i == 0) {
				dataLv1 = (String)list.get(0).get("DATALV1_NM");
			}
			if(dataLv1.equals(list.get(i).get("DATALV1_NM")) && i == (list.size()-1)) {
				dataLv1Count++;
				lv1Count++;
				countMap1.put(lv1Count, dataLv1Count);
				lv1List.add(countMap1);
			}
			else if(dataLv1.equals(list.get(i).get("DATALV1_NM"))) {
				dataLv1Count++;
			}
			else {
				lv1Count++;
				countMap1.put(lv1Count, dataLv1Count);
				lv1List.add(countMap1);
				dataLv1 = (String) list.get(i).get("DATALV1_NM");
				dataLv1Count = 1;
			}
		}
		
		String dataLv2 = null;
		for(int i=0; i<list.size(); i++) {
			if(i == 0) {
				dataLv2 = (String)list.get(0).get("DATALV2_NM");
			}
			if(dataLv2.equals(list.get(i).get("DATALV2_NM")) && i == (list.size()-1)) {
				dataLv2Count++;
				lv2Count++;
				countMap2.put(lv2Count, dataLv2Count);
				lv2List.add(countMap2);
			}
			else if(dataLv2.equals(list.get(i).get("DATALV2_NM"))) {
				dataLv2Count++;
			}
			else {
				lv2Count++;
				countMap2.put(lv2Count, dataLv2Count);
				lv2List.add(countMap2);
				dataLv2 = (String) list.get(i).get("DATALV2_NM");
				dataLv2Count = 1;
			}
		}
		
		CellStyle style = shBook.createCellStyle();
    	DataFormat format = shBook.createDataFormat();
    	style.setDataFormat(format.getFormat("#,##0.0%"));
    	style.setAlignment(CellStyle.ALIGN_RIGHT);
    	HSSFFont font = (HSSFFont) shBook.createFont();
    	font.setColor(HSSFColor.RED.index);
    	font.setFontName("맑은 고딕");
    	style.setFont(font);
		
    	CellStyle style3 = shBook.createCellStyle();
    	HSSFFont font3 = (HSSFFont) shBook.createFont();
    	font3.setFontName("맑은 고딕");
    	style3.setFont(font3);
    	style3.setAlignment(CellStyle.ALIGN_CENTER);
    	style3.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    	style3.setFillForegroundColor(HSSFColor.WHITE.index);
    	style3.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style3.setBorderRight(CellStyle.BORDER_THICK);
    	style3.setBorderLeft(CellStyle.BORDER_THICK);
    	style3.setBorderTop(CellStyle.BORDER_THIN);
    	style3.setBorderBottom(CellStyle.BORDER_THIN);//lv1
    	
    	CellStyle style4 = shBook.createCellStyle();
    	DataFormat format4 = shBook.createDataFormat();
    	style4.setDataFormat(format4.getFormat("#,##0"));
    	style4.setFont(font3);
    	style4.setAlignment(CellStyle.ALIGN_RIGHT);
    	style4.setFillForegroundColor(HSSFColor.WHITE.index);
    	style4.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style4.setBorderRight(CellStyle.BORDER_THIN);
    	style4.setBorderLeft(CellStyle.BORDER_THIN);
    	style4.setBorderTop(CellStyle.BORDER_THIN);
    	style4.setBorderBottom(CellStyle.BORDER_THIN);//값
    	
    	CellStyle style12 = shBook.createCellStyle();
    	DataFormat format12 = shBook.createDataFormat();
    	style12.setDataFormat(format12.getFormat("#,##0.0%"));
    	style12.setFont(font3);
    	style12.setAlignment(CellStyle.ALIGN_RIGHT);
    	style12.setFillForegroundColor(HSSFColor.WHITE.index);
    	style12.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style12.setBorderRight(CellStyle.BORDER_THIN);
    	style12.setBorderLeft(CellStyle.BORDER_THIN);
    	style12.setBorderTop(CellStyle.BORDER_THIN);
    	style12.setBorderBottom(CellStyle.BORDER_THIN);//값
    	
    	CellStyle style5 = shBook.createCellStyle();
    	style5.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font5 = (HSSFFont) shBook.createFont();
    	font5.setFontName("맑은 고딕");
    	style5.setFont(font5);
    	style5.setFillForegroundColor(HSSFColor.GOLD.index);
    	style5.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style5.setBorderRight(CellStyle.BORDER_THICK);
    	style5.setBorderLeft(CellStyle.BORDER_THICK);
    	style5.setBorderTop(CellStyle.BORDER_THIN);
    	style5.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	CellStyle style6 = shBook.createCellStyle();
    	DataFormat format6 = shBook.createDataFormat();
    	style6.setDataFormat(format4.getFormat("#,##0"));
    	style6.setFont(font5);
    	style6.setAlignment(CellStyle.ALIGN_RIGHT);
    	style6.setFillForegroundColor(HSSFColor.GOLD.index);
    	style6.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style6.setBorderRight(CellStyle.BORDER_THIN);
    	style6.setBorderLeft(CellStyle.BORDER_THIN);
    	style6.setBorderTop(CellStyle.BORDER_THIN);
    	style6.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	CellStyle style13 = shBook.createCellStyle();
    	DataFormat format13 = shBook.createDataFormat();
    	style13.setDataFormat(format13.getFormat("#,##0.0%"));
    	style13.setAlignment(CellStyle.ALIGN_RIGHT);
    	style13.setFillForegroundColor(HSSFColor.GOLD.index);
    	style13.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style13.setBorderRight(CellStyle.BORDER_THIN);
    	style13.setBorderLeft(CellStyle.BORDER_THIN);
    	style13.setBorderTop(CellStyle.BORDER_THIN);
    	style13.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	CellStyle style7 = shBook.createCellStyle();
    	style7.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font7 = (HSSFFont) shBook.createFont();
    	font7.setColor(HSSFColor.WHITE.index);
    	font7.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font7.setFontName("맑은 고딕");
    	style7.setFont(font7);
    	style7.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style7.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style7.setBorderRight(CellStyle.BORDER_THICK);
    	style7.setBorderLeft(CellStyle.BORDER_THICK);
    	style7.setBorderTop(CellStyle.BORDER_THICK);
    	style7.setBorderBottom(CellStyle.BORDER_THICK); 	
    	
    	CellStyle style8 = shBook.createCellStyle();
    	DataFormat format8 = shBook.createDataFormat();
    	style8.setDataFormat(format8.getFormat("#,##0"));
    	style8.setAlignment(CellStyle.ALIGN_RIGHT);
    	HSSFFont font8 = (HSSFFont) shBook.createFont();
    	font8.setColor(HSSFColor.WHITE.index);
    	font8.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font8.setFontName("맑은 고딕");
    	style8.setFont(font8);
    	style8.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style8.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style8.setBorderRight(CellStyle.BORDER_THIN);
    	style8.setBorderLeft(CellStyle.BORDER_THIN);
    	style8.setBorderTop(CellStyle.BORDER_THICK);
    	style8.setBorderBottom(CellStyle.BORDER_THICK);//값
    	
    	CellStyle style14 = shBook.createCellStyle();
    	DataFormat format14 = shBook.createDataFormat();
    	style14.setDataFormat(format14.getFormat("#,##0.0%"));
    	style14.setAlignment(CellStyle.ALIGN_RIGHT);
    	style14.setFont(font8);
    	style14.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style14.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style14.setBorderRight(CellStyle.BORDER_THIN);
    	style14.setBorderLeft(CellStyle.BORDER_THIN);
    	style14.setBorderTop(CellStyle.BORDER_THICK);
    	style14.setBorderBottom(CellStyle.BORDER_THICK);//값
    	
    	
    	CellStyle style9 = shBook.createCellStyle();
    	style9.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font9 = (HSSFFont) shBook.createFont();
    	font9.setColor(HSSFColor.WHITE.index);
    	font9.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	style9.setFont(font9);
    	style9.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style9.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style9.setBorderRight(CellStyle.BORDER_THICK);
    	style9.setBorderLeft(CellStyle.BORDER_THICK);
    	style9.setBorderTop(CellStyle.BORDER_THICK);
    	style9.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	CellStyle style10 = shBook.createCellStyle();
    	DataFormat format10 = shBook.createDataFormat();
    	style10.setDataFormat(format10.getFormat("#,##0"));
    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	HSSFFont font10 = (HSSFFont) shBook.createFont();
    	font10.setColor(HSSFColor.WHITE.index);
    	font10.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
    	style10.setFont(font10);
    	style10.setAlignment(CellStyle.ALIGN_RIGHT);
    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style10.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style10.setBorderRight(CellStyle.BORDER_THIN);
    	style10.setBorderLeft(CellStyle.BORDER_THIN);
    	style10.setBorderTop(CellStyle.BORDER_THICK);
    	style10.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	CellStyle style11 = shBook.createCellStyle();
    	DataFormat format11 = shBook.createDataFormat();
    	style11.setDataFormat(format11.getFormat("#,##0.0%"));
    	style11.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	HSSFFont font11 = (HSSFFont) shBook.createFont();
    	font11.setColor(HSSFColor.WHITE.index);
    	font11.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
    	style11.setFont(font11);
    	style11.setAlignment(CellStyle.ALIGN_RIGHT);
    	style11.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style11.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style11.setBorderRight(CellStyle.BORDER_THIN);
    	style11.setBorderLeft(CellStyle.BORDER_THIN);
    	style11.setBorderTop(CellStyle.BORDER_THICK);
    	style11.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	// 표 제목
    	CellStyle style1 = shBook.createCellStyle();
    	HSSFFont font1 = (HSSFFont) shBook.createFont();
    	font1.setColor(HSSFColor.DARK_RED.index);
    	font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font1.setFontName("맑은 고딕");
    	style1.setFont(font1);
    	
    	CellStyle shCalc2SignalStyle = null; 
    	HSSFFont shCalc2SignalFont = null;
    	
    	CellStyle shCalc3SignalStyle = null; 
    	HSSFFont shCalc3SignalFont = null;
		
    	int tableRow =strartRow;
    	int lv1Sum = 0;
    	int lv2Sum = 0;
    	int currentRow = 0;
    	int lv2Row = tableRow;
    	int startCell = 0;
    	String [] calc = new String[7];
    	
		for(int i =0; i<list.size(); i++) {
			
	    	//----------------------------------------
	    	row = shSheet.createRow(35);
	    	cell = row.createCell(1);
	    	cell.setCellValue(new HSSFRichTextString("Shipment Target"));
	    	cell.setCellStyle(style1);
	    	//----------------------------------------
			
			row = shSheet.createRow(tableRow+i);
			
			for(int j=0; j<lv1List.size(); j++) {
				if(j == 0) {
					lv1Sum = Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				}
				else {
					lv1Sum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				}
				
				if(i == lv1Sum){
					if(j == 0) {
						shSheet.addMergedRegion(new Region(( int) tableRow , ( short )1 , ( int) tableRow+i-1, (short )1 ));
						shSheet.addMergedRegion(new Region(( int) tableRow+i-1 , ( short )2 , ( int) tableRow+i-1, (short )4 ));
					}
					else {
						shSheet.addMergedRegion(new Region(( int) (tableRow+Integer.parseInt(String.valueOf(lv1List.get(j-1).get(j)))) , ( short )1 , ( int) tableRow+i-1, (short )1 ));
						shSheet.addMergedRegion(new Region(( int) tableRow+i-1 , ( short )2 , ( int) tableRow+i-1, (short )4 ));
					}
				}
			}
			
			for(int j=0; j<lv2List.size(); j++) {
				if(j == 0) {
					lv2Sum = Integer.parseInt(String.valueOf(lv2List.get(j).get(j+1)));
				}
				else {
					lv2Sum += Integer.parseInt(String.valueOf(lv2List.get(j).get(j+1)));
				}
				
				if(i == lv2Sum){
					if(j == 0) {
						shSheet.addMergedRegion(new Region(( int) tableRow , ( short )2 , ( int) tableRow+i-1, (short )2 ));
					}
					else {
						lv2Row += Integer.parseInt(String.valueOf(lv2List.get(j-1).get(j)));
						shSheet.addMergedRegion(new Region(( int) lv2Row , ( short )2 , ( int) tableRow+i-1, (short )2 ));
					}
				}
			}
			
			cell = row.createCell(1);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV1_NM"));
			
			cell = row.createCell(2);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV2_NM"));
			
			cell = row.createCell(3);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
			
			cell = row.createCell(4);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
			
			shSheet.addMergedRegion(CellRangeAddress.valueOf("D"+(row.getRowNum()+1)+":E"+(row.getRowNum()+1)));
			
			cell = row.createCell(5);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P01"))));
			
			cell = row.createCell(6);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P02"))));
			
			cell = row.createCell(7);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P03"))));
			
			cell = row.createCell(8);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P04"))));
			
			cell = row.createCell(9);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P05"))));
			
			cell = row.createCell(10);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P06"))));
			
			cell = row.createCell(11);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P07"))));
			
			cell = row.createCell(12);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P08"))));
			
			cell = row.createCell(13);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P09"))));
			
			cell = row.createCell(14);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P10"))));
			
			cell = row.createCell(15);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P11"))));
			
			cell = row.createCell(16);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_P12"))));
			

			cell = row.createCell(17);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q01"))));
			
			cell = row.createCell(18);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q02"))));
			
			cell = row.createCell(19);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q03"))));
			
			cell = row.createCell(20);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_Q04"))));
			
			cell = row.createCell(21);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H01"))));
			
			cell = row.createCell(22);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_H02"))));
			
			cell = row.createCell(23);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_OUT_YTD"))));
			
			cell = row.createCell(24);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P01"))));
			                                                   
			cell = row.createCell(25);                         
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P02"))));
			                                                    
			cell = row.createCell(26);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P03"))));
			                                                    
			cell = row.createCell(27);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P04"))));
			                                                    
			cell = row.createCell(28);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P05"))));
			                                                    
			cell = row.createCell(29);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P06"))));
			                                                    
			cell = row.createCell(30);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P07"))));
			                                                    
			cell = row.createCell(31);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P08"))));
			                                                    
			cell = row.createCell(32);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P09"))));
			                                                    
			cell = row.createCell(33);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P10"))));
			                                                    
			cell = row.createCell(34);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P11"))));
			                                                    
			cell = row.createCell(35);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_P12"))));
			                                                    
			cell = row.createCell(36);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q01"))));
			                                                    
			cell = row.createCell(37);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q02"))));
			                                                    
			cell = row.createCell(38);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q03"))));
			                                                    
			cell = row.createCell(39);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_Q04"))));
			                                                    
			cell = row.createCell(40);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H01"))));
			
			cell = row.createCell(41);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_H02"))));
			                                                    
			cell = row.createCell(42);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_TG_YTD"))));
			
			int subSum = 0;
			int lv2SubSum = 0;
			for(int j=0; j<lv2List.size(); j++) {
				lv2SubSum += Integer.parseInt(String.valueOf(lv2List.get(j).get(j+1)));
				
				if(i == lv2SubSum-1) {
					for(int y=2; y<43; y++) {
						if(y > 4) {
							row.getCell(y).setCellStyle(style6);
						}
						else {
							row.getCell(y).setCellStyle(style5);
						}
					}
				}
				
				if(j == (lv2List.size() -1)) {
					lv2SubSum = 0;
				}
			}
			
			if(i == (list.size()-1)) {
				for(int y=2; y<43; y++) {
					row.getCell(y).setCellStyle(style10);
				}
			}
			
			for(int j=0; j<lv1List.size(); j++) {
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					for(int y=2; y<43; y++) {
						if(y > 4) {
							row.getCell(y).setCellStyle(style8);
						}
						else {
							row.getCell(y).setCellStyle(style7);
						}
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			cell = row.createCell(44);
			cell.setCellStyle(style12);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P01"))));
			                                                   
			cell = row.createCell(45);                         
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P02"))));
			                                                    
			cell = row.createCell(46);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P03"))));
			                                                    
			cell = row.createCell(47);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P04"))));
			                                                    
			cell = row.createCell(48);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P05"))));
			                                                    
			cell = row.createCell(49);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P06"))));
			                                                    
			cell = row.createCell(50);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P07"))));
			                                                    
			cell = row.createCell(51);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P08"))));
			                                                    
			cell = row.createCell(52);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P09"))));
			                                                    
			cell = row.createCell(53);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P10"))));
			                                                    
			cell = row.createCell(54);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P11"))));
			                                                    
			cell = row.createCell(55);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_P12"))));
			                                                    
			cell = row.createCell(56);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_Q1"))));
			                                                    
			cell = row.createCell(57);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_Q2"))));
			                                                    
			cell = row.createCell(58);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_Q3"))));
			                                                    
			cell = row.createCell(59);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_Q4"))));
			                                                    
			cell = row.createCell(60);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_H1"))));
			                                                    
			cell = row.createCell(61);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_H2"))));
			                                                    
			cell = row.createCell(62);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_YTD"))));
			
			cell = row.createCell(63);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(64);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(65);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(66);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(67);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(68);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(69);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			calc[0] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_Q1"))));
			calc[1] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_Q2"))));
			calc[2] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_Q3"))));
			calc[3] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_Q4"))));
			calc[4] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_H1"))));
			calc[5] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_H2"))));
			calc[6] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC2_YTD"))));

			for(int j=0; j<lv2List.size(); j++) {
				lv2SubSum += Integer.parseInt(String.valueOf(lv2List.get(j).get(j+1)));
				
				if(i == lv2SubSum-1) {
					startCell = 63;
					for(int y=44; y<63; y++) {
						row.getCell(y).setCellStyle(style13);
					}
					for(int y=0; y<calc.length; y++) {
				    	shCalc2SignalStyle = shBook.createCellStyle(); 
				    	shCalc2SignalFont = (HSSFFont) shBook.createFont();
						setSignal1(startCell, shCalc2SignalStyle, shCalc2SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc2SignalStyle(shCalc2SignalFont, calc[y], i, list.size()), "lv2");
						startCell++;
					}
				}
				
				if(j == (lv2List.size() -1)) {
					lv2SubSum = 0;
				}
			}
			
			for(int j=0; j<lv1List.size(); j++) {
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					startCell = 63;
					for(int y=44; y<63; y++) {
						row.getCell(y).setCellStyle(style14);
					}
					for(int y=0; y<calc.length; y++) {
				    	shCalc2SignalStyle = shBook.createCellStyle(); 
				    	shCalc2SignalFont = (HSSFFont) shBook.createFont();
						setSignal1(startCell, shCalc2SignalStyle, shCalc2SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc2SignalStyle(shCalc2SignalFont, calc[y], i, list.size()), "lv1");
						startCell++;
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			if(i == (list.size()-1)) {
				startCell = 63;
				for(int y=44; y<63; y++) {
					row.getCell(y).setCellStyle(style11);
				}
				for(int y=0; y<calc.length; y++) {
			    	shCalc2SignalStyle = shBook.createCellStyle(); 
			    	shCalc2SignalFont = (HSSFFont) shBook.createFont();
					setSignal1(startCell, shCalc2SignalStyle, shCalc2SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc2SignalStyle(shCalc2SignalFont, calc[y], i, list.size()), "lv1");
					startCell++;
				}
			}
			
			cell = row.createCell(71);
			cell.setCellStyle(style12);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P01"))));
			                                                   
			cell = row.createCell(72);                         
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P02"))));
			                                                    
			cell = row.createCell(73);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P03"))));
			                                                    
			cell = row.createCell(74);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P04"))));
			                                                    
			cell = row.createCell(75);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P05"))));
			                                                    
			cell = row.createCell(76);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P06"))));
			                                                    
			cell = row.createCell(77);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P07"))));
			                                                    
			cell = row.createCell(78);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P08"))));
			                                                    
			cell = row.createCell(79);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P09"))));
			                                                    
			cell = row.createCell(80);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P10"))));
			                                                    
			cell = row.createCell(81);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P11"))));
			                                                    
			cell = row.createCell(82);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_P12"))));
			                                                    
			cell = row.createCell(83);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q1"))));
			                                                    
			cell = row.createCell(84);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q2"))));
			                                                    
			cell = row.createCell(85);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q3"))));
			                                                    
			cell = row.createCell(86);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q4"))));
			                                                    
			cell = row.createCell(87);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_H1"))));
			                                                    
			cell = row.createCell(88);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_H2"))));
			                                                    
			cell = row.createCell(89);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_YTD"))));
			
			cell = row.createCell(90);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(91);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(92);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(93);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(94);                          
			cell.setCellStyle(style4);      
			cell.setCellValue("");
			
			cell = row.createCell(95);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");
			
			cell = row.createCell(96);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");
			
			// Calc3 Yellow Line : Local합계 , INT'L합계 , Beer합계 , Vodka합계 , Others합계
			// Calc3 신호등 생성 ①①①①①①①
			for(int j=0; j<lv2List.size(); j++) {		
				lv2SubSum += Integer.parseInt(String.valueOf(lv2List.get(j).get(j+1)));
				/*if(i == 5 || i == 11 || i == 19 || i == 21) {*/
				if(i == lv2SubSum-1){
					startCell = 90;
					for(int y=71; y<90; y++) {
						row.getCell(y).setCellStyle(style13);
					}
					
					calc[0] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q1"))));
					calc[1] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q2"))));
					calc[2] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q3"))));
					calc[3] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q4"))));
					calc[4] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_H1"))));
					calc[5] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_H2"))));
					calc[6] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_YTD"))));
					
					for(int y=0; y<calc.length; y++) {
				    	shCalc3SignalStyle = shBook.createCellStyle(); 
				    	shCalc3SignalFont = (HSSFFont) shBook.createFont();
				    	if(i == 23){
				    		setSignal2(startCell, shCalc3SignalStyle, shCalc3SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc3SignalStyle(shCalc3SignalFont, calc[y], i, list.size(), row.getCell(61).getCellStyle().getFillForegroundColor(), lv2List), "lv2");
				    	}else if(i == 24){
				    		setSignal2(startCell, shCalc3SignalStyle, shCalc3SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc3SignalStyle(shCalc3SignalFont, calc[y], i, list.size(), row.getCell(61).getCellStyle().getFillForegroundColor(), lv2List), "lv2");
				    	}else{				    		
				    		setSignal1(startCell, shCalc3SignalStyle, shCalc3SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc3SignalStyle(shCalc3SignalFont, calc[y], i, list.size(), row.getCell(61).getCellStyle().getFillForegroundColor(), lv2List), "lv2");				    		
				    	}
						startCell++;
					}
				}
				
				if(j == (lv2List.size() -1)) {
					lv2SubSum = 0;
				}
			}
			
			// Calc3 Blue Line : Whisky 합계 , Non Whisky 합계
			// Calc3 신호등 생성 ②②②②②②②②②
			for(int j=0; j<lv1List.size(); j++) {			
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					startCell = 90;
					for(int y=71; y<90; y++) {
						row.getCell(y).setCellStyle(style14);
					}
					
					calc[0] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q1"))));
					calc[1] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q2"))));
					calc[2] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q3"))));
					calc[3] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q4"))));
					calc[4] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_H1"))));
					calc[5] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_H2"))));
					calc[6] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_YTD"))));
					
					for(int y=0; y<calc.length; y++) {
				    	shCalc3SignalStyle = shBook.createCellStyle(); 
				    	shCalc3SignalFont = (HSSFFont) shBook.createFont();
				    	if(i == 24){
				    		setSignal2(startCell, shCalc3SignalStyle, shCalc3SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc3SignalStyle(shCalc3SignalFont, calc[y], i, list.size(), row.getCell(61).getCellStyle().getFillForegroundColor(), lv2List), "lv2");
				    	}else{				    		
				    		setSignal1(startCell, shCalc3SignalStyle, shCalc3SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcCalc3SignalStyle(shCalc3SignalFont, calc[y], i, list.size(), row.getCell(61).getCellStyle().getFillForegroundColor(), lv2List), "lv2");				    		
				    	}
						startCell++;
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			// Calc3 RedLine : Total 
			// Calc3 신호등 생성 ③③③③③③③
			if(i == (list.size()-1)) {		
				startCell = 90;
				for(int y=71; y<90; y++) {				// CalC Total Line BackgroundColor
					row.getCell(y).setCellStyle(style11);
				}
				calc[0] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q1"))));
				calc[1] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q2"))));
				calc[2] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q3"))));
				calc[3] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_Q4"))));
				calc[4] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_H1"))));
				calc[5] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_H2"))));
				calc[6] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("SH_CALC3_YTD"))));
				
				for(int y=0; y<calc.length; y++) {
			    	shCalc3SignalStyle = shBook.createCellStyle(); 
			    	shCalc3SignalFont = (HSSFFont) shBook.createFont();
					setSignal1(startCell, shCalc3SignalStyle, shCalc3SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setAcTotalSignalStyle(shCalc3SignalFont, calc[y], i,  lv2List), "lv1");
					startCell++;
				}
			}
			
			if(i == list.size()-1) {
				shSheet.addMergedRegion(new Region(( int) tableRow+i , ( short )1 , ( int) tableRow+i, (short )4 ));
				row.getCell(1).setCellStyle(style9);
			}
			shSheet.addMergedRegion(new Region(( int) tableRow+i-1 , ( short )3 , ( int) tableRow+i-1, (short )4 ));
			
			currentRow = row.getRowNum();
			listCount++;
		}
		
		//SDX 
		for(int i=0; i<list1.size(); i++) {
			currentRow += 1;
			row = shSheet.createRow(currentRow);
			
			cell = row.createCell(1);
			cell.setCellType(1);
			cell.setCellStyle(style);
			cell.setCellValue(String.valueOf(list1.get(i).get("DATALV1_NM")));
			
			cell = row.createCell(5);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P01"))));
			
			cell = row.createCell(6);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P02"))));
			
			cell = row.createCell(7);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P03"))));
			
			cell = row.createCell(8);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P04"))));
			
			cell = row.createCell(9);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P05"))));
			
			cell = row.createCell(10);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P06"))));
			
			cell = row.createCell(11);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P07"))));
			
			cell = row.createCell(12);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P08"))));
			
			cell = row.createCell(13);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P09"))));
			
			cell = row.createCell(14);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P10"))));
			
			cell = row.createCell(15);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P11"))));
			
			cell = row.createCell(16);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_P12"))));
			

			cell = row.createCell(17);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_Q01"))));
			
			cell = row.createCell(18);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_Q02"))));
			
			cell = row.createCell(19);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_Q03"))));
			
			cell = row.createCell(20);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_Q04"))));
			
			cell = row.createCell(21);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_H01"))));
			
			cell = row.createCell(22);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_H02"))));
			
			cell = row.createCell(23);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_OUT_YTD"))));
			
			cell = row.createCell(24);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P01"))));
			                                                   
			cell = row.createCell(25);                         
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P02"))));
			                                                    
			cell = row.createCell(26);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P03"))));
			                                                    
			cell = row.createCell(27);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P04"))));
			                                                    
			cell = row.createCell(28);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P05"))));
			                                                    
			cell = row.createCell(29);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P06"))));
			                                                    
			cell = row.createCell(30);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P07"))));
			                                                    
			cell = row.createCell(31);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P08"))));
			                                                    
			cell = row.createCell(32);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P09"))));
			                                                    
			cell = row.createCell(33);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P10"))));
			                                                    
			cell = row.createCell(34);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P11"))));
			                                                    
			cell = row.createCell(35);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_P12"))));
			                                                    
			cell = row.createCell(36);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_Q01"))));
			                                                    
			cell = row.createCell(37);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_Q02"))));
			                                                    
			cell = row.createCell(38);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_Q03"))));
			                                                    
			cell = row.createCell(39);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_Q04"))));
			                                                    
			cell = row.createCell(40);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_H01"))));
			                                                    
			cell = row.createCell(41);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_H02"))));
			                                                    
			cell = row.createCell(42);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("SH_TG_YTD"))));
			
			listCount++;
		}
			
		return listCount;
	}
	
	
	//DC Forecast 엑셀 추출
	public int dcForecastExcel(ArrayList<Map> list, ArrayList<Map> list1, int rowCount, HSSFRow row, HSSFCell cell, HSSFWorkbook shBook, HSSFSheet shSheet, Map param) throws Exception {
		String header1 = param.get("Lfy").toString().concat(" Actual");
		String header2 = param.get("fy").toString().concat(" Forecast");
		String header4 = "Growth Rate% vs ".concat(param.get("Lfy").toString());
		String[] headerNm = {header1, header2, header4}; 
		
		int strartRow = excelHeader(rowCount, row, cell, shBook, shSheet, headerNm, param);
		
		ArrayList<Map> lv1List = new ArrayList<Map>();
		int lv1Count = 0;
		int dataLv1Count = 0;
		Map countMap1 = new HashMap();
		
		String dataLv1 = null;
		for(int i=0; i<list.size(); i++) {
			if(i == 0) {
				dataLv1 = (String)list.get(0).get("DATALV1_NM");
			}
			if(dataLv1.equals(list.get(i).get("DATALV1_NM")) && i == (list.size()-1)) {
				dataLv1Count++;
				lv1Count++;
				countMap1.put(lv1Count, dataLv1Count);
				lv1List.add(countMap1);
			}
			else if(dataLv1.equals(list.get(i).get("DATALV1_NM"))) {
				dataLv1Count++;
			}
			else {
				lv1Count++;
				countMap1.put(lv1Count, dataLv1Count);
				lv1List.add(countMap1);
				dataLv1 = (String) list.get(i).get("DATALV1_NM");
				dataLv1Count = 1;
			}
		}
		
		CellStyle style = shBook.createCellStyle();
    	DataFormat format = shBook.createDataFormat();
    	style.setDataFormat(format.getFormat("#,##0"));
    	style.setAlignment(CellStyle.ALIGN_RIGHT);
    	HSSFFont font = (HSSFFont) shBook.createFont();
    	font.setColor(HSSFColor.RED.index);
    	font.setFontName("맑은 고딕");
    	style.setFont(font);
		
    	CellStyle style3 = shBook.createCellStyle();
    	HSSFFont font3 = (HSSFFont) shBook.createFont();
    	font3.setFontName("맑은 고딕");
    	style3.setFont(font3);
    	style3.setAlignment(CellStyle.ALIGN_CENTER);
    	style3.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    	style3.setFillForegroundColor(HSSFColor.WHITE.index);
    	style3.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style3.setBorderRight(CellStyle.BORDER_THICK);
    	style3.setBorderLeft(CellStyle.BORDER_THICK);
    	style3.setBorderTop(CellStyle.BORDER_THIN);
    	style3.setBorderBottom(CellStyle.BORDER_THIN);//lv1
    	
    	CellStyle style4 = shBook.createCellStyle();
    	DataFormat format4 = shBook.createDataFormat();
    	style4.setDataFormat(format4.getFormat("#,##0"));
    	style4.setFont(font3);
    	style4.setAlignment(CellStyle.ALIGN_RIGHT);
    	style4.setFillForegroundColor(HSSFColor.WHITE.index);
    	style4.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style4.setBorderRight(CellStyle.BORDER_THIN);
    	style4.setBorderLeft(CellStyle.BORDER_THIN);
    	style4.setBorderTop(CellStyle.BORDER_THIN);
    	style4.setBorderBottom(CellStyle.BORDER_THIN);//값
    	
    	CellStyle style12 = shBook.createCellStyle();
    	DataFormat format12 = shBook.createDataFormat();
    	style12.setDataFormat(format12.getFormat("#,##0.0%"));
    	style12.setFont(font3);
    	style12.setAlignment(CellStyle.ALIGN_RIGHT);
    	style12.setFillForegroundColor(HSSFColor.WHITE.index);
    	style12.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style12.setBorderRight(CellStyle.BORDER_THIN);
    	style12.setBorderLeft(CellStyle.BORDER_THIN);
    	style12.setBorderTop(CellStyle.BORDER_THIN);
    	style12.setBorderBottom(CellStyle.BORDER_THIN);//값
    	
    	CellStyle style5 = shBook.createCellStyle();
    	style5.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font5 = (HSSFFont) shBook.createFont();
    	font5.setFontName("맑은 고딕");
    	style5.setFont(font5);
    	style5.setFillForegroundColor(HSSFColor.GOLD.index);
    	style5.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style5.setBorderRight(CellStyle.BORDER_THICK);
    	style5.setBorderLeft(CellStyle.BORDER_THICK);
    	style5.setBorderTop(CellStyle.BORDER_THIN);
    	style5.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	CellStyle style6 = shBook.createCellStyle();
    	DataFormat format6 = shBook.createDataFormat();
    	style6.setDataFormat(format4.getFormat("#,##0"));
    	style6.setFont(font5);
    	style6.setAlignment(CellStyle.ALIGN_RIGHT);
    	style6.setFillForegroundColor(HSSFColor.GOLD.index);
    	style6.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style6.setBorderRight(CellStyle.BORDER_THIN);
    	style6.setBorderLeft(CellStyle.BORDER_THIN);
    	style6.setBorderTop(CellStyle.BORDER_THIN);
    	style6.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	CellStyle style13 = shBook.createCellStyle();
    	DataFormat format13 = shBook.createDataFormat();
    	style13.setDataFormat(format13.getFormat("#,##0.0%"));
    	style13.setAlignment(CellStyle.ALIGN_RIGHT);
    	style13.setFillForegroundColor(HSSFColor.GOLD.index);
    	style13.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style13.setBorderRight(CellStyle.BORDER_THIN);
    	style13.setBorderLeft(CellStyle.BORDER_THIN);
    	style13.setBorderTop(CellStyle.BORDER_THIN);
    	style13.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	CellStyle style7 = shBook.createCellStyle();
    	style7.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font7 = (HSSFFont) shBook.createFont();
    	font7.setColor(HSSFColor.WHITE.index);
    	font7.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font7.setFontName("맑은 고딕");
    	style7.setFont(font7);
    	style7.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style7.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style7.setBorderRight(CellStyle.BORDER_THICK);
    	style7.setBorderLeft(CellStyle.BORDER_THICK);
    	style7.setBorderTop(CellStyle.BORDER_THICK);
    	style7.setBorderBottom(CellStyle.BORDER_THICK); 	
    	
    	CellStyle style8 = shBook.createCellStyle();
    	DataFormat format8 = shBook.createDataFormat();
    	style8.setDataFormat(format8.getFormat("#,##0"));
    	style8.setAlignment(CellStyle.ALIGN_RIGHT);
    	HSSFFont font8 = (HSSFFont) shBook.createFont();
    	font8.setColor(HSSFColor.WHITE.index);
    	font8.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font8.setFontName("맑은 고딕");
    	style8.setFont(font8);
    	style8.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style8.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style8.setBorderRight(CellStyle.BORDER_THIN);
    	style8.setBorderLeft(CellStyle.BORDER_THIN);
    	style8.setBorderTop(CellStyle.BORDER_THICK);
    	style8.setBorderBottom(CellStyle.BORDER_THICK);//값
    	
    	CellStyle style14 = shBook.createCellStyle();
    	DataFormat format14 = shBook.createDataFormat();
    	style14.setDataFormat(format14.getFormat("#,##0.0%"));
    	style14.setAlignment(CellStyle.ALIGN_RIGHT);
    	style14.setFont(font8);
    	style14.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style14.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style14.setBorderRight(CellStyle.BORDER_THIN);
    	style14.setBorderLeft(CellStyle.BORDER_THIN);
    	style14.setBorderTop(CellStyle.BORDER_THICK);
    	style14.setBorderBottom(CellStyle.BORDER_THICK);//값
    	
    	
    	CellStyle style9 = shBook.createCellStyle();
    	style9.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font9 = (HSSFFont) shBook.createFont();
    	font9.setColor(HSSFColor.WHITE.index);
    	font9.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	style9.setFont(font9);
    	style9.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style9.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style9.setBorderRight(CellStyle.BORDER_THICK);
    	style9.setBorderLeft(CellStyle.BORDER_THICK);
    	style9.setBorderTop(CellStyle.BORDER_THICK);
    	style9.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	CellStyle style10 = shBook.createCellStyle();
    	DataFormat format10 = shBook.createDataFormat();
    	style10.setDataFormat(format10.getFormat("#,##0"));
    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	HSSFFont font10 = (HSSFFont) shBook.createFont();
    	font10.setColor(HSSFColor.WHITE.index);
    	font10.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
    	style10.setFont(font10);
    	style10.setAlignment(CellStyle.ALIGN_RIGHT);
    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style10.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style10.setBorderRight(CellStyle.BORDER_THIN);
    	style10.setBorderLeft(CellStyle.BORDER_THIN);
    	style10.setBorderTop(CellStyle.BORDER_THICK);
    	style10.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	CellStyle style11 = shBook.createCellStyle();
    	DataFormat format11 = shBook.createDataFormat();
    	style11.setDataFormat(format11.getFormat("#,##0.0%"));
    	style11.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	HSSFFont font11 = (HSSFFont) shBook.createFont();
    	font11.setColor(HSSFColor.WHITE.index);
    	font11.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
    	style11.setFont(font11);
    	style11.setAlignment(CellStyle.ALIGN_RIGHT);
    	style11.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style11.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style11.setBorderRight(CellStyle.BORDER_THIN);
    	style11.setBorderLeft(CellStyle.BORDER_THIN);
    	style11.setBorderTop(CellStyle.BORDER_THICK);
    	style11.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	// 표 제목
    	CellStyle style1 = shBook.createCellStyle();
    	HSSFFont font1 = (HSSFFont) shBook.createFont();
    	font1.setColor(HSSFColor.DARK_RED.index);
    	font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font1.setFontName("맑은 고딕");
    	style1.setFont(font1);
    	
    	CellStyle dcCalc1SignalStyle = null; 
    	HSSFFont dcCalc1SignalFont = null;
		
    	int tableRow = strartRow;
    	int currentRow = 0;
    	int lv1Row = 0;
    	int lv1Sum = 0;
    	int lv2Sum = 0;
    	int listCount = 0;
    	int startCell = 0;
    	String [] calc = new String[7];
    	
		for(int i =0; i<list.size(); i++) {

	    	//----------------------------------------
	    	row = shSheet.createRow(68);
	    	cell = row.createCell(1);
	    	cell.setCellValue(new HSSFRichTextString("DC Forecast"));
	    	cell.setCellStyle(style1);
	    	//----------------------------------------
			
			row = shSheet.createRow(tableRow+i);
			
			for(int j=0; j<lv1List.size(); j++) {
				if(j == 0) {
					lv1Sum = Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				}
				else {
					lv1Sum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				}
				
				if(i == lv1Sum){
					if(j == 0) {
						lv1Row += (tableRow+i-1);
						shSheet.addMergedRegion(new Region(( int) tableRow , ( short )1 , ( int) lv1Row, (short )1 ));
						shSheet.addMergedRegion(new Region(( int) lv1Row , ( short )2 , ( int) lv1Row, (short )4 ));
					}
					else {
						shSheet.addMergedRegion(new Region(( int) (lv1Row+1) , ( short )1 , ( int) tableRow+i-1, (short )1 ));
						shSheet.addMergedRegion(new Region(( int) tableRow+i-1 , ( short )2 , ( int) tableRow+i-1, (short )4 ));
						lv1Row += Integer.parseInt(String.valueOf(lv1List.get(j-1).get(j)));
					}
				}else if(i == (lv1Sum-1) && j == (lv1List.size()-1)) {
					shSheet.addMergedRegion(new Region(( int) (lv1Row+1) , ( short )1 , ( int) tableRow+i, (short )1 ));
					shSheet.addMergedRegion(new Region(( int) tableRow+i , ( short )2 , ( int) tableRow+i, (short )4 ));
				}
			}
			
			cell = row.createCell(1);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV1_NM"));
			
			cell = row.createCell(2);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV2_NM"));
			
			cell = row.createCell(3);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
			
			cell = row.createCell(4);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
			
			shSheet.addMergedRegion(CellRangeAddress.valueOf("D"+(row.getRowNum()+1)+":E"+(row.getRowNum()+1)));
			
			cell = row.createCell(5);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P01"))));
			
			cell = row.createCell(6);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P02"))));
			
			cell = row.createCell(7);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P03"))));
			
			cell = row.createCell(8);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P04"))));
			
			cell = row.createCell(9);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P05"))));
			
			cell = row.createCell(10);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P06"))));
			
			cell = row.createCell(11);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P07"))));
			
			cell = row.createCell(12);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P08"))));
			
			cell = row.createCell(13);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P09"))));
			
			cell = row.createCell(14);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P10"))));
			
			cell = row.createCell(15);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P11"))));
			
			cell = row.createCell(16);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P12"))));
			

			cell = row.createCell(17);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q01"))));
			
			cell = row.createCell(18);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q02"))));
			
			cell = row.createCell(19);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q03"))));
			
			cell = row.createCell(20);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q04"))));
			
			cell = row.createCell(21);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H01"))));
			
			cell = row.createCell(22);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H02"))));
			
			cell = row.createCell(23);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_YTD"))));
			
			cell = row.createCell(24);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P01"))));
			                                                   
			cell = row.createCell(25);                         
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P02"))));
			                                                    
			cell = row.createCell(26);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P03"))));
			                                                    
			cell = row.createCell(27);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P04"))));
			                                                    
			cell = row.createCell(28);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P05"))));
			                                                    
			cell = row.createCell(29);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P06"))));
			                                                    
			cell = row.createCell(30);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P07"))));
			                                                    
			cell = row.createCell(31);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P08"))));
			                                                    
			cell = row.createCell(32);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P09"))));
			                                                    
			cell = row.createCell(33);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P10"))));
			                                                    
			cell = row.createCell(34);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P11"))));
			                                                    
			cell = row.createCell(35);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P12"))));
			                                                    
			cell = row.createCell(36);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q01"))));
			                                                    
			cell = row.createCell(37);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q02"))));
			                                                    
			cell = row.createCell(38);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q03"))));
			                                                    
			cell = row.createCell(39);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q04"))));
			                                                    
			cell = row.createCell(40);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H01"))));
			                                                    
			cell = row.createCell(41);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H02"))));
			                                                    
			cell = row.createCell(42);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_YTD"))));
			
			int subSum = 0;
			for(int j=0; j<lv1List.size(); j++) {
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					for(int y=2; y<43; y++) {
						if(y > 4) {
							row.getCell(y).setCellStyle(style8);
						}
						else {
							row.getCell(y).setCellStyle(style7);
						}
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			if(i == (list.size()-1)) {
				for(int y=2; y<43; y++) {
					if(y > 4) {
						row.getCell(y).setCellStyle(style11);
					}
					else {
						row.getCell(y).setCellStyle(style9);
					}
				}
			}
			
			if(i == (list.size()-2) || i == (list.size()-3)) {
				for(int j=5; j<43; j++) {
					row.getCell(j).setCellStyle(style12);
				}
			}
			
			cell = row.createCell(44);
			cell.setCellStyle(style12);  
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P01"))));

			cell = row.createCell(45);                         
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P02"))));
			                                                    
			cell = row.createCell(46);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P03"))));
			                                                    
			cell = row.createCell(47);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P04"))));
			                                                    
			cell = row.createCell(48);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P05"))));
			                                                    
			cell = row.createCell(49);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P06"))));
			                                                    
			cell = row.createCell(50);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P07"))));
			                                                    
			cell = row.createCell(51);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P08"))));
			                                                    
			cell = row.createCell(52);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P09"))));
			                                                    
			cell = row.createCell(53);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P10"))));
			                                                    
			cell = row.createCell(54);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P11"))));
			                                                    
			cell = row.createCell(55);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_P12"))));
			                                                    
			cell = row.createCell(56);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_Q1"))));
			                                                    
			cell = row.createCell(57);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_Q2"))));
			                                                    
			cell = row.createCell(58);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_Q3"))));
			                                                    
			cell = row.createCell(59);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_Q4"))));
			                                                    
			cell = row.createCell(60);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_H1"))));
			                                                    
			cell = row.createCell(61);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_H2"))));
			                                                    
			cell = row.createCell(62);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_YTD"))));
			
			cell = row.createCell(63);                          
			cell.setCellType(0);       
			cell.setCellStyle(style4);
			cell.setCellValue("");

			cell = row.createCell(64);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);
			cell.setCellValue("");

			cell = row.createCell(65);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);
			cell.setCellValue("");

			cell = row.createCell(66);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);
			cell.setCellValue("");

			cell = row.createCell(67);                          
			cell.setCellType(0);      
			cell.setCellStyle(style4);
			cell.setCellValue("");

			cell = row.createCell(68);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);
			cell.setCellValue("");

			cell = row.createCell(69);                          
			cell.setCellType(0);     
			cell.setCellStyle(style4);
			cell.setCellValue("");
			
			calc[0] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_Q1"))));
			calc[1] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_Q2"))));
			calc[2] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_Q3"))));
			calc[3] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_Q4"))));
			calc[4] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_H1"))));
			calc[5] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_H2"))));
			calc[6] = String.valueOf(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC1_YTD"))));
			
			for(int j=0; j<lv1List.size(); j++) {
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					startCell = 63;
					for(int y=44; y<63; y++) {
						row.getCell(y).setCellStyle(style14);
					}
					for(int y=0; y<calc.length; y++) {
						dcCalc1SignalStyle = shBook.createCellStyle(); 
						dcCalc1SignalFont = (HSSFFont) shBook.createFont();
						setSignal1(startCell, dcCalc1SignalStyle, dcCalc1SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setDcCalc1SignalStyle(dcCalc1SignalFont, calc[y], i, list.size()), "lv1");
						startCell++;
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			if(i == (list.size()-1)) {
				startCell = 63;
				for(int y=44; y<63; y++) {
					row.getCell(y).setCellStyle(style11);
				}
				for(int y=0; y<calc.length; y++) {
					dcCalc1SignalStyle = shBook.createCellStyle(); 
					dcCalc1SignalFont = (HSSFFont) shBook.createFont();
					setSignal1(startCell, dcCalc1SignalStyle, dcCalc1SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setDcCalc1SignalStyle(dcCalc1SignalFont, calc[y], i, list.size()), "lv1");
					startCell++;
				}
			}
			
			if(i == (list.size()-2) || i == (list.size()-3)) {
				for(int j=44; j<63; j++) {
					row.getCell(j).setCellStyle(style12);
				}
			}
			
			if(i == list.size()-1) {
				shSheet.addMergedRegion(new Region(( int) tableRow+i , ( short )2 , ( int) tableRow+i, (short )4 ));
				row.getCell(1).setCellStyle(style3);
			}
			shSheet.addMergedRegion(new Region(( int) tableRow+i-1 , ( short )2 , ( int) tableRow+i-1, (short )4 ));
			
			currentRow = row.getRowNum();
			listCount++;
		}
		
		for(int i=0; i<list1.size(); i++) {
			currentRow += 1;
			row = shSheet.createRow(currentRow);
			
			cell = row.createCell(1);
			cell.setCellType(1);
			cell.setCellStyle(style);
			cell.setCellValue(String.valueOf(list1.get(i).get("DATALV1_NM")));
			
			cell = row.createCell(3);
			cell.setCellType(1);
			cell.setCellStyle(style);
			cell.setCellValue(String.valueOf(list1.get(i).get("DATALV2_NM")));
			
			cell = row.createCell(5);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P01"))));
			
			cell = row.createCell(6);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P02"))));
			
			cell = row.createCell(7);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P03"))));
			
			cell = row.createCell(8);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P04"))));
			
			cell = row.createCell(9);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P05"))));
			
			cell = row.createCell(10);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P06"))));
			
			cell = row.createCell(11);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P07"))));
			
			cell = row.createCell(12);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P08"))));
			
			cell = row.createCell(13);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P09"))));
			
			cell = row.createCell(14);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P10"))));
			
			cell = row.createCell(15);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P11"))));
			
			cell = row.createCell(16);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_P12"))));
			

			cell = row.createCell(17);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_Q01"))));
			
			cell = row.createCell(18);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_Q02"))));
			
			cell = row.createCell(19);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_Q03"))));
			
			cell = row.createCell(20);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_Q04"))));
			
			cell = row.createCell(21);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_H01"))));
			
			cell = row.createCell(22);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_H02"))));
			
			cell = row.createCell(23);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_AC_YTD"))));
			
			cell = row.createCell(24);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P01"))));
			                                                   
			cell = row.createCell(25);                         
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P02"))));
			                                                    
			cell = row.createCell(26);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P03"))));
			                                                    
			cell = row.createCell(27);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P04"))));
			                                                    
			cell = row.createCell(28);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P05"))));
			                                                    
			cell = row.createCell(29);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P06"))));
			                                                    
			cell = row.createCell(30);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P07"))));
			                                                    
			cell = row.createCell(31);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P08"))));
			                                                    
			cell = row.createCell(32);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P09"))));
			                                                    
			cell = row.createCell(33);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P10"))));
			                                                    
			cell = row.createCell(34);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P11"))));
			                                                    
			cell = row.createCell(35);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_P12"))));
			                                                    
			cell = row.createCell(36);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_Q01"))));
			                                                    
			cell = row.createCell(37);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_Q02"))));
			                                                    
			cell = row.createCell(38);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_Q03"))));
			                                                    
			cell = row.createCell(39);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_Q04"))));
			                                                    
			cell = row.createCell(40);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_H01"))));
			                                                    
			cell = row.createCell(41);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_H02"))));
			                                                    
			cell = row.createCell(42);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_FOR_YTD"))));
			
			listCount++;
		}
			
		return listCount;
	}
	
	//DC Target 엑셀 추출
	public int dcTargetExcel(ArrayList<Map> list, ArrayList<Map> list1, int rowCount, HSSFRow row, HSSFCell cell, HSSFWorkbook shBook, HSSFSheet shSheet, Map param) throws Exception {
		String header1 = param.get("fy").toString().concat(" Actual (Outlook)");
		String header2 = param.get("fy").toString().concat(" Target");
		String header3 = "Achievement% vs. Target";
		String header4 = "Forecast Accuracy% vs Forecast";
		String[] headerNm = {header1, header2, header3, header4};
		
		int strartRow = excelHeader(rowCount, row, cell, shBook, shSheet, headerNm, param);
		
		ArrayList<Map> lv1List = new ArrayList<Map>();
		int lv1Count = 0;
		int dataLv1Count = 0;
		Map countMap1 = new HashMap();
		
		String dataLv1 = null;
		for(int i=0; i<list.size(); i++) {
			if(i == 0) {
				dataLv1 = (String)list.get(0).get("DATALV1_NM");
			}
			if(dataLv1.equals(list.get(i).get("DATALV1_NM")) && i == (list.size()-1)) {
				dataLv1Count++;
				lv1Count++;
				countMap1.put(lv1Count, dataLv1Count);
				lv1List.add(countMap1);
			}
			else if(dataLv1.equals(list.get(i).get("DATALV1_NM"))) {
				dataLv1Count++;
			}
			else {
				lv1Count++;
				countMap1.put(lv1Count, dataLv1Count);
				lv1List.add(countMap1);
				dataLv1 = (String) list.get(i).get("DATALV1_NM");
				dataLv1Count = 1;
			}
		}
		
		CellStyle style = shBook.createCellStyle();
    	DataFormat format = shBook.createDataFormat();
    	style.setDataFormat(format.getFormat("#,##0"));
    	style.setAlignment(CellStyle.ALIGN_RIGHT);
    	HSSFFont font = (HSSFFont) shBook.createFont();
    	font.setColor(HSSFColor.RED.index);
    	style.setFont(font);
		
    	CellStyle style3 = shBook.createCellStyle();
    	HSSFFont font3 = (HSSFFont) shBook.createFont();
    	font3.setFontName("맑은 고딕");
    	style3.setFont(font3);
    	style3.setAlignment(CellStyle.ALIGN_CENTER);
    	style3.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    	style3.setFillForegroundColor(HSSFColor.WHITE.index);
    	style3.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style3.setBorderRight(CellStyle.BORDER_THICK);
    	style3.setBorderLeft(CellStyle.BORDER_THICK);
    	style3.setBorderTop(CellStyle.BORDER_THIN);
    	style3.setBorderBottom(CellStyle.BORDER_THIN);//lv1
    	
    	CellStyle style4 = shBook.createCellStyle();
    	DataFormat format4 = shBook.createDataFormat();
    	style4.setDataFormat(format4.getFormat("#,##0"));
    	style4.setFont(font3);
    	style4.setAlignment(CellStyle.ALIGN_RIGHT);
    	style4.setFillForegroundColor(HSSFColor.WHITE.index);
    	style4.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style4.setBorderRight(CellStyle.BORDER_THIN);
    	style4.setBorderLeft(CellStyle.BORDER_THIN);
    	style4.setBorderTop(CellStyle.BORDER_THIN);
    	style4.setBorderBottom(CellStyle.BORDER_THIN);//값
    	
    	CellStyle style12 = shBook.createCellStyle();
    	DataFormat format12 = shBook.createDataFormat();
    	style12.setDataFormat(format12.getFormat("#,##0.0%"));
    	style12.setFont(font3);
    	style12.setAlignment(CellStyle.ALIGN_RIGHT);
    	style12.setFillForegroundColor(HSSFColor.WHITE.index);
    	style12.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style12.setBorderRight(CellStyle.BORDER_THIN);
    	style12.setBorderLeft(CellStyle.BORDER_THIN);
    	style12.setBorderTop(CellStyle.BORDER_THIN);
    	style12.setBorderBottom(CellStyle.BORDER_THIN);//값
    	
    	CellStyle style5 = shBook.createCellStyle();
    	style5.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font5 = (HSSFFont) shBook.createFont();
    	font5.setFontName("맑은 고딕");
    	style5.setFont(font5);
    	style5.setFillForegroundColor(HSSFColor.GOLD.index);
    	style5.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style5.setBorderRight(CellStyle.BORDER_THICK);
    	style5.setBorderLeft(CellStyle.BORDER_THICK);
    	style5.setBorderTop(CellStyle.BORDER_THIN);
    	style5.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	CellStyle style6 = shBook.createCellStyle();
    	DataFormat format6 = shBook.createDataFormat();
    	style6.setDataFormat(format4.getFormat("#,##0"));
    	style6.setFont(font5);
    	style6.setAlignment(CellStyle.ALIGN_RIGHT);
    	style6.setFillForegroundColor(HSSFColor.GOLD.index);
    	style6.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style6.setBorderRight(CellStyle.BORDER_THIN);
    	style6.setBorderLeft(CellStyle.BORDER_THIN);
    	style6.setBorderTop(CellStyle.BORDER_THIN);
    	style6.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	CellStyle style13 = shBook.createCellStyle();
    	DataFormat format13 = shBook.createDataFormat();
    	style13.setDataFormat(format13.getFormat("#,##0.0%"));
    	style13.setAlignment(CellStyle.ALIGN_RIGHT);
    	style13.setFillForegroundColor(HSSFColor.GOLD.index);
    	style13.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style13.setBorderRight(CellStyle.BORDER_THIN);
    	style13.setBorderLeft(CellStyle.BORDER_THIN);
    	style13.setBorderTop(CellStyle.BORDER_THIN);
    	style13.setBorderBottom(CellStyle.BORDER_THICK);//lv2소계
    	
    	CellStyle style7 = shBook.createCellStyle();
    	style7.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font7 = (HSSFFont) shBook.createFont();
    	font7.setColor(HSSFColor.WHITE.index);
    	font7.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font7.setFontName("맑은 고딕");
    	style7.setFont(font7);
    	style7.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style7.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style7.setBorderRight(CellStyle.BORDER_THICK);
    	style7.setBorderLeft(CellStyle.BORDER_THICK);
    	style7.setBorderTop(CellStyle.BORDER_THICK);
    	style7.setBorderBottom(CellStyle.BORDER_THICK); 	
    	
    	CellStyle style8 = shBook.createCellStyle();
    	DataFormat format8 = shBook.createDataFormat();
    	style8.setDataFormat(format8.getFormat("#,##0"));
    	style8.setAlignment(CellStyle.ALIGN_RIGHT);
    	HSSFFont font8 = (HSSFFont) shBook.createFont();
    	font8.setColor(HSSFColor.WHITE.index);
    	font8.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font8.setFontName("맑은 고딕");
    	style8.setFont(font8);
    	style8.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style8.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style8.setBorderRight(CellStyle.BORDER_THIN);
    	style8.setBorderLeft(CellStyle.BORDER_THIN);
    	style8.setBorderTop(CellStyle.BORDER_THICK);
    	style8.setBorderBottom(CellStyle.BORDER_THICK);//값
    	
    	CellStyle style14 = shBook.createCellStyle();
    	DataFormat format14 = shBook.createDataFormat();
    	style14.setDataFormat(format14.getFormat("#,##0.0%"));
    	style14.setAlignment(CellStyle.ALIGN_RIGHT);
    	style14.setFont(font8);
    	style14.setFillForegroundColor(HSSFColor.INDIGO.index);
    	style14.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style14.setBorderRight(CellStyle.BORDER_THIN);
    	style14.setBorderLeft(CellStyle.BORDER_THIN);
    	style14.setBorderTop(CellStyle.BORDER_THICK);
    	style14.setBorderBottom(CellStyle.BORDER_THICK);//값
    	
    	
    	CellStyle style9 = shBook.createCellStyle();
    	style9.setAlignment(CellStyle.ALIGN_CENTER);
    	HSSFFont font9 = (HSSFFont) shBook.createFont();
    	font9.setColor(HSSFColor.WHITE.index);
    	font9.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	style9.setFont(font9);
    	style9.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style9.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style9.setBorderRight(CellStyle.BORDER_THICK);
    	style9.setBorderLeft(CellStyle.BORDER_THICK);
    	style9.setBorderTop(CellStyle.BORDER_THICK);
    	style9.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	CellStyle style10 = shBook.createCellStyle();
    	DataFormat format10 = shBook.createDataFormat();
    	style10.setDataFormat(format10.getFormat("#,##0"));
    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	HSSFFont font10 = (HSSFFont) shBook.createFont();
    	font10.setColor(HSSFColor.WHITE.index);
    	font10.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
    	style10.setFont(font10);
    	style10.setAlignment(CellStyle.ALIGN_RIGHT);
    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style10.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style10.setBorderRight(CellStyle.BORDER_THIN);
    	style10.setBorderLeft(CellStyle.BORDER_THIN);
    	style10.setBorderTop(CellStyle.BORDER_THICK);
    	style10.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	CellStyle style11 = shBook.createCellStyle();
    	DataFormat format11 = shBook.createDataFormat();
    	style11.setDataFormat(format11.getFormat("#,##0.0%"));
    	style11.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	HSSFFont font11 = (HSSFFont) shBook.createFont();
    	font11.setColor(HSSFColor.WHITE.index);
    	font11.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
    	style11.setFont(font11);
    	style11.setAlignment(CellStyle.ALIGN_RIGHT);
    	style11.setFillForegroundColor(HSSFColor.DARK_RED.index);
    	style11.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style11.setBorderRight(CellStyle.BORDER_THIN);
    	style11.setBorderLeft(CellStyle.BORDER_THIN);
    	style11.setBorderTop(CellStyle.BORDER_THICK);
    	style11.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	// 표 제목
    	CellStyle style1 = shBook.createCellStyle();
    	HSSFFont font1 = (HSSFFont) shBook.createFont();
    	font1.setColor(HSSFColor.DARK_RED.index);
    	font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font1.setFontName("맑은 고딕");
    	style1.setFont(font1);
    	
    	CellStyle dcCalc2SignalStyle = null; 
    	HSSFFont dcCalc2SignalFont = null;
    	
    	CellStyle dcCalc3SignalStyle = null; 
    	HSSFFont dcCalc3SignalFont = null;
		
    	int tableRow = strartRow;
    	int currentRow = 0;
    	int lv1Row = 0;
    	int lv1Sum = 0;
    	int lv2Sum = 0;
    	int listCount = 0;
    	int startCell = 0;
    	double [] calc = new double[7];
    	
		for(int i =0; i<list.size(); i++) {

	    	//----------------------------------------
	    	row = shSheet.createRow(84);
	    	cell = row.createCell(1);
	    	cell.setCellValue(new HSSFRichTextString("DC Target"));
	    	cell.setCellStyle(style1);
	    	//----------------------------------------
			
			row = shSheet.createRow(tableRow+i);
			
			for(int j=0; j<lv1List.size(); j++) {
				if(j == 0) {
					lv1Sum = Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				}
				else {
					lv1Sum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				}
				
				if(i == lv1Sum){
					if(j == 0) {
						lv1Row += (tableRow+i-1);
						shSheet.addMergedRegion(new Region(( int) tableRow , ( short )1 , ( int) lv1Row, (short )1 ));
						shSheet.addMergedRegion(new Region(( int) lv1Row , ( short )2 , ( int) lv1Row, (short )4 ));
					}
					else {
						shSheet.addMergedRegion(new Region(( int) (lv1Row+1) , ( short )1 , ( int) tableRow+i-1, (short )1 ));
						shSheet.addMergedRegion(new Region(( int) tableRow+i-1 , ( short )2 , ( int) tableRow+i-1, (short )4 ));
						lv1Row += Integer.parseInt(String.valueOf(lv1List.get(j-1).get(j)));
					}
				}else if(i == (lv1Sum-1) && j == (lv1List.size()-1)) {
					shSheet.addMergedRegion(new Region(( int) (lv1Row+1) , ( short )1 , ( int) tableRow+i, (short )1 ));
					shSheet.addMergedRegion(new Region(( int) tableRow+i , ( short )2 , ( int) tableRow+i, (short )4 ));
				}
			}
			
			cell = row.createCell(1);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV1_NM"));
			
			cell = row.createCell(2);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV2_NM"));
			
			cell = row.createCell(3);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
			
			cell = row.createCell(4);
			cell.setCellType(1);
			cell.setCellStyle(style3);
			cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
			
			shSheet.addMergedRegion(CellRangeAddress.valueOf("D"+(row.getRowNum()+1)+":E"+(row.getRowNum()+1)));
			
			cell = row.createCell(5);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P01"))));
			
			cell = row.createCell(6);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P02"))));
			
			cell = row.createCell(7);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P03"))));
			
			cell = row.createCell(8);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P04"))));
			
			cell = row.createCell(9);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P05"))));
			
			cell = row.createCell(10);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P06"))));
			
			cell = row.createCell(11);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P07"))));
			
			cell = row.createCell(12);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P08"))));
			
			cell = row.createCell(13);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P09"))));
			
			cell = row.createCell(14);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P10"))));
			
			cell = row.createCell(15);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P11"))));
			
			cell = row.createCell(16);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P12"))));
			

			cell = row.createCell(17);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q01"))));
			
			cell = row.createCell(18);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q02"))));
			
			cell = row.createCell(19);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q03"))));
			
			cell = row.createCell(20);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q04"))));
			
			cell = row.createCell(21);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H01"))));
			
			cell = row.createCell(22);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H02"))));
			
			cell = row.createCell(23);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_YTD"))));
			
			cell = row.createCell(24);
			cell.setCellStyle(style4);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P01"))));
			                                                   
			cell = row.createCell(25);                         
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P02"))));
			                                                    
			cell = row.createCell(26);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P03"))));
			                                                    
			cell = row.createCell(27);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P04"))));
			                                                    
			cell = row.createCell(28);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P05"))));
			                                                    
			cell = row.createCell(29);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P06"))));
			                                                    
			cell = row.createCell(30);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P07"))));
			                                                    
			cell = row.createCell(31);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P08"))));
			                                                    
			cell = row.createCell(32);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P09"))));
			                                                    
			cell = row.createCell(33);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P10"))));
			                                                    
			cell = row.createCell(34);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P11"))));
			                                                    
			cell = row.createCell(35);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P12"))));
			                                                    
			cell = row.createCell(36);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q01"))));
			                                                    
			cell = row.createCell(37);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q02"))));
			                                                    
			cell = row.createCell(38);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q03"))));
			                                                    
			cell = row.createCell(39);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q04"))));
			                                                    
			cell = row.createCell(40);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H01"))));
			                                                    
			cell = row.createCell(41);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H02"))));
			                                                    
			cell = row.createCell(42);                          
			cell.setCellStyle(style4);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_YTD"))));
			
			int subSum = 0;
			for(int j=0; j<lv1List.size(); j++) {
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					for(int y=2; y<43; y++) {
						if(y > 4) {
							row.getCell(y).setCellStyle(style8);
						}
						else {
							row.getCell(y).setCellStyle(style7);
						}
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			if(i == (list.size()-1)) {
				for(int y=2; y<43; y++) {
					if(y > 4) {
						row.getCell(y).setCellStyle(style11);
					}
					else {
						row.getCell(y).setCellStyle(style10);
					}
				}
			}
			
			if(i == (list.size()-2) || i == (list.size()-3)) {
				for(int j=5; j<43; j++) {
					row.getCell(j).setCellStyle(style12);
				}
			}
			
			if(i == (list.size()-1)) {
				for(int j=5; j<43; j++) {
					row.getCell(j).setCellStyle(style11);
				}
			}
			
			if(i == (list.size()-2) || i == (list.size()-3)) {
				for(int j=5; j<43; j++) {
					row.getCell(j).setCellStyle(style12);
				}
			}
			
			cell = row.createCell(44);
			cell.setCellStyle(style12);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P01"))));
			                                                   
			cell = row.createCell(45);                         
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P02"))));
			                                                    
			cell = row.createCell(46);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P03"))));
			                                                    
			cell = row.createCell(47);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P04"))));
			                                                    
			cell = row.createCell(48);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P05"))));
			                                                    
			cell = row.createCell(49);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P06"))));
			                                                    
			cell = row.createCell(50);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P07"))));
			                                                    
			cell = row.createCell(51);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P08"))));
			                                                    
			cell = row.createCell(52);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P09"))));
			                                                    
			cell = row.createCell(53);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P10"))));
			                                                    
			cell = row.createCell(54);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P11"))));
			                                                    
			cell = row.createCell(55);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_P12"))));
			                                                    
			cell = row.createCell(56);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_Q1"))));
			                                                    
			cell = row.createCell(57);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_Q2"))));
			                                                    
			cell = row.createCell(58);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_Q3"))));
			                                                    
			cell = row.createCell(59);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_Q4"))));
			                                                    
			cell = row.createCell(60);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_H1"))));
			                                                    
			cell = row.createCell(61);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_H2"))));
			                                                    
			cell = row.createCell(62);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_YTD"))));
			
			cell = row.createCell(63);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(64);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(65);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(66);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(67);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(68);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(69);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");
			
			calc[0] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_Q1")));
			calc[1] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_Q2")));
			calc[2] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_Q3")));
			calc[3] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_Q4")));
			calc[4] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_H1")));
			calc[5] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_H2")));
			calc[6] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC2_YTD")));
			
			for(int j=0; j<lv1List.size(); j++) {
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					startCell = 63;
					for(int y=44; y<63; y++) {
						row.getCell(y).setCellStyle(style14);
					}
					for(int y=0; y<calc.length; y++) {
						dcCalc2SignalStyle = shBook.createCellStyle(); 
				    	dcCalc2SignalFont = (HSSFFont) shBook.createFont();
						setSignal1(startCell, dcCalc2SignalStyle, dcCalc2SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setDcCalc2SignalStyle(dcCalc2SignalFont, calc[y], i), "lv1");
						startCell++;
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			if(i == (list.size()-1)) {
				startCell = 63;
				for(int y=44; y<63; y++) {
					row.getCell(y).setCellStyle(style11);
				}
				for(int y=0; y<calc.length; y++) {
					dcCalc2SignalStyle = shBook.createCellStyle(); 
			    	dcCalc2SignalFont = (HSSFFont) shBook.createFont();
					setSignal1(startCell, dcCalc2SignalStyle, dcCalc2SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setDcCalc2SignalStyle(dcCalc2SignalFont, calc[y], i), "lv1");
					startCell++;
				}
			}
			
			if(i == (list.size()-2) || i == (list.size()-3)) {
				for(int j=44; j<63; j++) {
					row.getCell(j).setCellStyle(style12);
				}
			}
			
			cell = row.createCell(71);
			cell.setCellStyle(style12);
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P01"))));
			                                                   
			cell = row.createCell(72);                         
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P02"))));
			                                                    
			cell = row.createCell(73);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P03"))));
			                                                    
			cell = row.createCell(74);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P04"))));
			                                                    
			cell = row.createCell(75);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P05"))));
			                                                    
			cell = row.createCell(76);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P06"))));
			                                                    
			cell = row.createCell(77);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P07"))));
			                                                    
			cell = row.createCell(78);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P08"))));
			                                                    
			cell = row.createCell(79);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P09"))));
			                                                    
			cell = row.createCell(80);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P10"))));
			                                                    
			cell = row.createCell(81);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P11"))));
			                                                    
			cell = row.createCell(82);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_P12"))));
			                                                    
			cell = row.createCell(83);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_Q1"))));
			                                                    
			cell = row.createCell(84);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_Q2"))));
			                                                    
			cell = row.createCell(85);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_Q3"))));
			                                                    
			cell = row.createCell(86);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_Q4"))));
			                                                    
			cell = row.createCell(87);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_H1"))));
			                                                    
			cell = row.createCell(88);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_H2"))));
			                                                    
			cell = row.createCell(89);                          
			cell.setCellStyle(style12);       
			cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_YTD"))));
			
			cell = row.createCell(90);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(91);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(92);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(93);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(94);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(95);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");

			cell = row.createCell(96);                          
			cell.setCellStyle(style4);       
			cell.setCellValue("");
			
			calc[0] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_Q1")));
			calc[1] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_Q2")));
			calc[2] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_Q3")));
			calc[3] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_Q4")));  
			calc[4] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_H1")));
			calc[5] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_H2")));
			calc[6] = Double.parseDouble(String.valueOf(list.get(i).get("DC_CALC3_YTD")));
			
			for(int j=0; j<lv1List.size(); j++) {
				subSum += Integer.parseInt(String.valueOf(lv1List.get(j).get(j+1)));
				
				if(i == subSum-1) {
					startCell = 90;
					for(int y=71; y<90; y++) {
						row.getCell(y).setCellStyle(style14);
					}
					for(int y=0; y<calc.length; y++) {
						double signalValue = 0;
						if(calc[y] < 0) {
							signalValue = calc[y] * -1;
						}
						else {
							signalValue = calc[y] * 1;
						}
						dcCalc3SignalStyle = shBook.createCellStyle(); 
						dcCalc3SignalFont = (HSSFFont) shBook.createFont();
						setSignal1(startCell, dcCalc3SignalStyle, dcCalc3SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setDcCalc3SignalStyle(dcCalc3SignalFont, signalValue, i),"lv1");
						startCell++;
					}
				}
				
				if(j == (lv1List.size() -1)) {
					subSum = 0;
				}
			}
			
			if(i == (list.size()-1)) {
				startCell = 90;
				for(int y=71; y<90; y++) {
					row.getCell(y).setCellStyle(style11);
				}
				for(int y=0; y<calc.length; y++) {
					double signalValue = 0;
					if(calc[y] < 0) {
						signalValue = calc[y] * -1;
					}
					else {
						signalValue = calc[y] * 1;
					}
					
					dcCalc3SignalStyle = shBook.createCellStyle(); 
					dcCalc3SignalFont = (HSSFFont) shBook.createFont();
					setSignal1(startCell, dcCalc3SignalStyle, dcCalc3SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setDcCalc3SignalStyle(dcCalc3SignalFont, signalValue, i),"lv1");
					startCell++;
				}
			}
			
			if(i == (list.size()-2) || i == (list.size()-3)) {
				for(int j=71; j<90; j++) {
					row.getCell(j).setCellStyle(style12);
				}
			}
			
			if(i == list.size()-1) {
				shSheet.addMergedRegion(new Region(( int) tableRow+i , ( short )2 , ( int) tableRow+i, (short )4 ));
				row.getCell(1).setCellStyle(style3);
			}
			shSheet.addMergedRegion(new Region(( int) tableRow+i-1 , ( short )2 , ( int) tableRow+i-1, (short )4 ));
			
			currentRow = row.getRowNum();
			listCount++;
		}

		for(int i=0; i<list1.size(); i++) {
			currentRow += 1;
			row = shSheet.createRow(currentRow);
			
			cell = row.createCell(1);
			cell.setCellType(1);
			cell.setCellStyle(style);
			cell.setCellValue(String.valueOf(list1.get(i).get("DATALV1_NM")));
			
			cell = row.createCell(2);
			cell.setCellType(1);
			cell.setCellStyle(style);
			cell.setCellValue(String.valueOf(list1.get(i).get("DATALV2_NM")));
			
			cell = row.createCell(5);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P01"))));
			
			cell = row.createCell(6);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P02"))));
			
			cell = row.createCell(7);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P03"))));
			
			cell = row.createCell(8);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P04"))));
			
			cell = row.createCell(9);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P05"))));
			
			cell = row.createCell(10);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P06"))));
			
			cell = row.createCell(11);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P07"))));
			
			cell = row.createCell(12);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P08"))));
			
			cell = row.createCell(13);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P09"))));
			
			cell = row.createCell(14);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P10"))));
			
			cell = row.createCell(15);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P11"))));
			
			cell = row.createCell(16);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_P12"))));
			

			cell = row.createCell(17);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_Q01"))));
			
			cell = row.createCell(18);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_Q02"))));
			
			cell = row.createCell(19);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_Q03"))));
			
			cell = row.createCell(20);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_Q04"))));
			
			cell = row.createCell(21);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_H01"))));
			
			cell = row.createCell(22);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_H02"))));
			
			cell = row.createCell(23);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_OUT_YTD"))));
			
			cell = row.createCell(24);
			cell.setCellType(0);
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P01"))));
			                                                   
			cell = row.createCell(25);                         
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P02"))));
			                                                    
			cell = row.createCell(26);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P03"))));
			                                                    
			cell = row.createCell(27);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P04"))));
			                                                    
			cell = row.createCell(28);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P05"))));
			                                                    
			cell = row.createCell(29);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P06"))));
			                                                    
			cell = row.createCell(30);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P07"))));
			                                                    
			cell = row.createCell(31);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P08"))));
			                                                    
			cell = row.createCell(32);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P09"))));
			                                                    
			cell = row.createCell(33);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P10"))));
			                                                    
			cell = row.createCell(34);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P11"))));
			                                                    
			cell = row.createCell(35);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_P12"))));
			                                                    
			cell = row.createCell(36);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_Q01"))));
			                                                    
			cell = row.createCell(37);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_Q02"))));
			                                                    
			cell = row.createCell(38);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_Q03"))));
			                                                    
			cell = row.createCell(39);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_Q04"))));
			                                                    
			cell = row.createCell(40);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_H01"))));
			                                                    
			cell = row.createCell(41);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_H02"))));
			                                                    
			cell = row.createCell(42);                          
			cell.setCellType(0);     
			cell.setCellStyle(style);
			cell.setCellValue(Double.parseDouble(String.valueOf(list1.get(i).get("DC_TG_YTD"))));
			
			listCount++;
		}
			
		return listCount;
	}
	
	//Credit Forecast 엑셀 추출
		public ArrayList<Map> creditForecastExcel(ArrayList<Map> list, int rowCount, HSSFRow row, HSSFCell cell, HSSFWorkbook shBook, HSSFSheet shSheet, Map param) throws Exception {
			
			String header1 = param.get("Lfy").toString().concat(" Actual");
			String header2 = param.get("fy").toString().concat(" Forecast");
			String header4 = "Growth Rate% va ".concat(param.get("Lfy").toString());
			String[] headerNm = {header1, header2, header4}; 
			
			HSSFFont font10 = null;
			
			int strartRow = excelHeader(rowCount, row, cell, shBook, shSheet, headerNm, param);
			
			ArrayList<Map> lv1List = new ArrayList<Map>();
			int lv1Count = 0;
			int dataLv1Count = 0;
			Map countMap1 = new HashMap();
			
			String dataLv1 = null;
			for(int i=0; i<list.size(); i++) {
				if(i == 0) {
					dataLv1 = (String)list.get(0).get("DATALV1_NM");
				}
				if(dataLv1.equals(list.get(i).get("DATALV1_NM")) && i == (list.size()-1)) {
					dataLv1Count++;
					lv1Count++;
					countMap1.put(lv1Count, dataLv1Count);
					lv1List.add(countMap1);
				}
				else if(dataLv1.equals(list.get(i).get("DATALV1_NM"))) {
					dataLv1Count++;
				}
				else {
					lv1Count++;
					countMap1.put(lv1Count, dataLv1Count);
					lv1List.add(countMap1);
					dataLv1 = (String) list.get(i).get("DATALV1_NM");
					dataLv1Count = 1;
				}
			}
			
			CellStyle style3 = shBook.createCellStyle();
	    	style3.setAlignment(CellStyle.ALIGN_CENTER);
	    	style3.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	    	HSSFFont font3 = (HSSFFont) shBook.createFont();
	    	font3.setFontName("맑은 고딕");
	    	style3.setFont(font3);
	    	style3.setBorderRight(CellStyle.BORDER_THICK);
	    	style3.setBorderLeft(CellStyle.BORDER_THICK);
	    	style3.setBorderTop(CellStyle.BORDER_THICK);
	    	style3.setBorderBottom(CellStyle.BORDER_THICK);//lv1
	    	
	    	CellStyle style4 = shBook.createCellStyle();
	    	DataFormat format4 = shBook.createDataFormat();
	    	style4.setDataFormat(format4.getFormat("#,##0"));
	    	style4.setFont(font3);
	    	style4.setAlignment(CellStyle.ALIGN_RIGHT);
	    	style4.setBorderRight(CellStyle.BORDER_THIN);
	    	style4.setBorderLeft(CellStyle.BORDER_THIN);
	    	style4.setBorderTop(CellStyle.BORDER_THIN);
	    	style4.setBorderBottom(CellStyle.BORDER_THIN);//값
	    	
	    	CellStyle style7 = shBook.createCellStyle();
	    	style7.setAlignment(CellStyle.ALIGN_CENTER);
	    	HSSFFont font7 = (HSSFFont) shBook.createFont();
	    	font7.setColor(HSSFColor.WHITE.index);
	    	font7.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	font7.setFontName("맑은 고딕");
	    	style7.setFont(font7);
	    	style7.setFillForegroundColor(HSSFColor.INDIGO.index);
	    	style7.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style7.setBorderRight(CellStyle.BORDER_THICK);
	    	style7.setBorderLeft(CellStyle.BORDER_THICK);
	    	style7.setBorderTop(CellStyle.BORDER_THICK);
	    	style7.setBorderBottom(CellStyle.BORDER_THICK);
	    	
	    	CellStyle style8 = shBook.createCellStyle();
	    	DataFormat format8 = shBook.createDataFormat();
	    	style8.setDataFormat(format8.getFormat("#,##0"));
	    	style8.setAlignment(CellStyle.ALIGN_RIGHT);
	    	HSSFFont font8 = (HSSFFont) shBook.createFont();
	    	font8.setColor(HSSFColor.WHITE.index);
	    	font8.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	font8.setFontName("맑은 고딕");
	    	style8.setFont(font8);
	    	style8.setFillForegroundColor(HSSFColor.INDIGO.index);
	    	style8.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style8.setBorderRight(CellStyle.BORDER_THIN);
	    	style8.setBorderLeft(CellStyle.BORDER_THIN);
	    	style8.setBorderTop(CellStyle.BORDER_THICK);
	    	style8.setBorderBottom(CellStyle.BORDER_THICK);//값
	    	
	    	CellStyle style9 = shBook.createCellStyle();
	    	style9.setAlignment(CellStyle.ALIGN_CENTER);
	    	HSSFFont font9 = (HSSFFont) shBook.createFont();
	    	font9.setColor(HSSFColor.WHITE.index);
	    	font9.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	font9.setFontName("맑은 고딕");
	    	style9.setFont(font9);
	    	style9.setFillForegroundColor(HSSFColor.DARK_RED.index);
	    	style9.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style9.setBorderRight(CellStyle.BORDER_THICK);
	    	style9.setBorderLeft(CellStyle.BORDER_THICK);
	    	style9.setBorderTop(CellStyle.BORDER_THICK);
	    	style9.setBorderBottom(CellStyle.BORDER_THICK);
	    	
	    	CellStyle style10 = shBook.createCellStyle();
	    	DataFormat format10 = shBook.createDataFormat();
	    	style10.setDataFormat(format10.getFormat("#,##0.0%"));
	    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
	    	if(font10 == null) {
	    		font10 = (HSSFFont) shBook.createFont();
	    	}
	    	font10.setColor(HSSFColor.WHITE.index);
	    	font10.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
	    	style10.setFont(font10);
	    	font10.setFontName("맑은 고딕");
	    	style10.setAlignment(CellStyle.ALIGN_RIGHT);
	    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
	    	style10.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style10.setBorderRight(CellStyle.BORDER_THIN);
	    	style10.setBorderLeft(CellStyle.BORDER_THIN);
	    	style10.setBorderTop(CellStyle.BORDER_THICK);
	    	style10.setBorderBottom(CellStyle.BORDER_THICK);
	    	
	    	CellStyle style12 = shBook.createCellStyle();
	    	DataFormat format12 = shBook.createDataFormat();
	    	style12.setDataFormat(format12.getFormat("#,##0.0%"));
	    	style12.setFont(font3);
	    	style12.setAlignment(CellStyle.ALIGN_RIGHT);
	    	style12.setFillForegroundColor(HSSFColor.WHITE.index);
	    	style12.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style12.setBorderRight(CellStyle.BORDER_THIN);
	    	style12.setBorderLeft(CellStyle.BORDER_THIN);
	    	style12.setBorderTop(CellStyle.BORDER_THIN);
	    	style12.setBorderBottom(CellStyle.BORDER_THIN);//값
	    	
	    	CellStyle style13 = shBook.createCellStyle();
	    	DataFormat format13 = shBook.createDataFormat();
	    	style13.setDataFormat(format13.getFormat("#,##0.0%"));
	    	style13.setAlignment(CellStyle.ALIGN_RIGHT);
	    	HSSFFont font13 = (HSSFFont) shBook.createFont();
	    	font13.setColor(HSSFColor.WHITE.index);
	    	font13.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	font13.setFontName("맑은 고딕");
	    	style13.setFont(font13);
	    	style13.setFillForegroundColor(HSSFColor.INDIGO.index);
	    	style13.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style13.setBorderRight(CellStyle.BORDER_THIN);
	    	style13.setBorderLeft(CellStyle.BORDER_THIN);
	    	style13.setBorderTop(CellStyle.BORDER_THICK);
	    	style13.setBorderBottom(CellStyle.BORDER_THICK);//값
	    	
	    	// 표 제목
	    	CellStyle style1 = shBook.createCellStyle();
	    	HSSFFont font1 = (HSSFFont) shBook.createFont();
	    	font1.setColor(HSSFColor.DARK_RED.index);
	    	font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	font1.setFontName("맑은 고딕");
	    	style1.setFont(font1);
	    	
	    	CellStyle cdCalc1SignalStyle = null; 
	    	HSSFFont cdCalc1SignalFont = null;
	    	
	    	int tableRow = strartRow;
	    	int currentRow = 0;
	    	int lv1Sum = 0;
	    	int lv2Sum = 0;
	    	int startCell = 0;
	    	int endCell = 0;
	    	int signalCell = 0;
	    	double [] calc = new double[7];
	    	
			for(int i =0; i<list.size(); i++) {
		    	
		    	//----------------------------------------
		    	row = shSheet.createRow(100);
		    	cell = row.createCell(1);
		    	cell.setCellValue(new HSSFRichTextString("Credit Forecast"));
		    	cell.setCellStyle(style1);
		    	//----------------------------------------
				
				row = shSheet.createRow(tableRow+i);
				
				cell = row.createCell(1);
				cell.setCellType(1);
				cell.setCellValue((String)list.get(i).get("DATALV1_NM"));
				startCell = cell.getCellNum();
				
				cell = row.createCell(2);
				cell.setCellType(1);
				cell.setCellValue((String)list.get(i).get("DATALV2_NM"));
				
				cell = row.createCell(3);
				cell.setCellType(1);
				cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
				
				cell = row.createCell(4);
				cell.setCellType(1);
				cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
				
				cell = row.createCell(5);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P01"))));
				
				cell = row.createCell(6);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P02"))));
				
				cell = row.createCell(7);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P03"))));
				
				cell = row.createCell(8);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P04"))));
				
				cell = row.createCell(9);   
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P05"))));
				
				cell = row.createCell(10);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P06"))));
				
				cell = row.createCell(11);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P07"))));
				
				cell = row.createCell(12);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P08"))));
				
				cell = row.createCell(13);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P09"))));
				
				cell = row.createCell(14);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P10"))));
				
				cell = row.createCell(15);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P11"))));
				
				cell = row.createCell(16);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P12"))));
				

				cell = row.createCell(17);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_Q01"))));
				
				cell = row.createCell(18);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_Q02"))));
				
				cell = row.createCell(19);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_Q03"))));
				
				cell = row.createCell(20);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_Q04"))));
				
				cell = row.createCell(21);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_H01"))));
				
				cell = row.createCell(22);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_H02"))));
				
				cell = row.createCell(23);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_YTD"))));
				
				cell = row.createCell(24);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P01"))));
				                                                   
				cell = row.createCell(25);                         
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P02"))));
				                                                    
				cell = row.createCell(26);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P03"))));
				                                                    
				cell = row.createCell(27);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P04"))));
				                                                    
				cell = row.createCell(28);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P05"))));
				                                                    
				cell = row.createCell(29);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P06"))));
				                                                    
				cell = row.createCell(30);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P07"))));
				                                                    
				cell = row.createCell(31);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P08"))));
				                                                    
				cell = row.createCell(32);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P09"))));
				                                                    
				cell = row.createCell(33);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P10"))));
				                                                    
				cell = row.createCell(34);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P11"))));
				                                                    
				cell = row.createCell(35);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P12"))));
				                                                    
				cell = row.createCell(36);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_Q01"))));
				                                                    
				cell = row.createCell(37);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_Q02"))));
				                                                    
				cell = row.createCell(38);                          
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_Q03"))));
				                                                    
				cell = row.createCell(39);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_Q04"))));
				                                                    
				cell = row.createCell(40);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_H01"))));
				                                                    
				cell = row.createCell(41);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_H02"))));
				                                                    
				cell = row.createCell(42);                          
				cell.setCellType(1);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_YTD"))));
				endCell = cell.getCellNum();
				
				shSheet.addMergedRegion(new Region(( int) tableRow+i , ( short )1 , ( int) tableRow+i, (short )4 ));
				
				for(int y=startCell; y<=endCell; y++) {
					if(i == list.size()-1) {
						if(y < 5) {
							row.getCell(y).setCellStyle(style9);
						}
						else {
							row.getCell(y).setCellStyle(style10);
						}
					}
					else if(i == list.size()-2) {
						if(y < 5) {
							row.getCell(y).setCellStyle(style7);
						}
						else {
							row.getCell(y).setCellStyle(style8);
						}
					}
					else {
						if(y < 5) {
							row.getCell(y).setCellStyle(style3);
						}
						else {
							row.getCell(y).setCellStyle(style4);
						}
					}
				}
				
				cell = row.createCell(44);
				cell.setCellType(0);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P01"))));
				startCell = cell.getCellNum();
				                                                   
				cell = row.createCell(45);                         
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P02"))));
				                                                    
				cell = row.createCell(46);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P03"))));
				                                                    
				cell = row.createCell(47);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P04"))));
				                                                    
				cell = row.createCell(48);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P05"))));
				                                                    
				cell = row.createCell(49);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P06"))));
				                                                    
				cell = row.createCell(50);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P07"))));
				                                                    
				cell = row.createCell(51);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P08"))));
				                                                    
				cell = row.createCell(52);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P09"))));
				                                                    
				cell = row.createCell(53);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P10"))));
				                                                    
				cell = row.createCell(54);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P11"))));
				                                                    
				cell = row.createCell(55);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_P12"))));
				                                                    
				cell = row.createCell(56);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_Q1"))));
				                                                    
				cell = row.createCell(57);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_Q2"))));
				                                                    
				cell = row.createCell(58);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_Q3"))));
				                                                    
				cell = row.createCell(59);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_Q4"))));
				                                                    
				cell = row.createCell(60);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_H1"))));
				                                                    
				cell = row.createCell(61);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_H2"))));
				                                                    
				cell = row.createCell(62);                          
				cell.setCellType(0);       
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_YTD"))));
				
				cell = row.createCell(63);                          
				cell.setCellType(0);       
				cell.setCellValue("");

				cell = row.createCell(64);                          
				cell.setCellType(0);       
				cell.setCellValue("");

				cell = row.createCell(65);                          
				cell.setCellType(0);       
				cell.setCellValue("");

				cell = row.createCell(66);                          
				cell.setCellType(0);       
				cell.setCellValue("");

				cell = row.createCell(67);                          
				cell.setCellType(0);       
				cell.setCellValue("");

				cell = row.createCell(68);                          
				cell.setCellType(0);       
				cell.setCellValue("");

				cell = row.createCell(69);                          
				cell.setCellType(0);       
				cell.setCellValue("");
				endCell = cell.getCellNum();
				
				for(int y=startCell; y<=endCell; y++) {
					if(i == list.size()-1) {
						signalCell = 63;
						
						row.getCell(y).setCellStyle(style10);
						if(y > 63) {
							calc[0] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_Q1")));
							calc[1] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_Q2")));
							calc[2] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_Q3")));
							calc[3] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_Q4")));
							calc[4] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_H1")));
							calc[5] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_H2")));
							calc[6] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC1_YTD")));
							for(int x=0; x<calc.length; x++) {
								cdCalc1SignalStyle = shBook.createCellStyle(); 
								cdCalc1SignalFont = (HSSFFont) shBook.createFont();
								setSignal1(signalCell, cdCalc1SignalStyle, cdCalc1SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setCdCalcSignalStyle(cdCalc1SignalFont, calc[x], i),"lv1");
								signalCell++;
							}
						}
						
					}
					else if(i == list.size()-2) {
						row.getCell(y).setCellStyle(style13);
					}
					else {
						row.getCell(y).setCellStyle(style12);
					}
				}
				
			}
				
			return list;
		}
		
		//Credit Target 엑셀 추출
		public ArrayList<Map> creditTargetExcel(ArrayList<Map> list, int rowCount, HSSFRow row, HSSFCell cell, HSSFWorkbook shBook, HSSFSheet shSheet, Map param) throws Exception {
			String header1 = param.get("fy").toString().concat(" Actual (Outlook)");
			String header2 = param.get("fy").toString().concat(" Target");
			String header3 = "Achievement% vs. Target";
			String header4 = "Forecast Accuracy% vs Forecast";
			String[] headerNm = {header1, header2, header3, header4};  
			
			
			int strartRow = excelHeader(rowCount, row, cell, shBook, shSheet, headerNm, param);
			
			ArrayList<Map> lv1List = new ArrayList<Map>();
			int lv1Count = 0;
			int dataLv1Count = 0;
			Map countMap1 = new HashMap();
			
			String dataLv1 = null;
			for(int i=0; i<list.size(); i++) {
				if(i == 0) {
					dataLv1 = (String)list.get(0).get("DATALV1_NM");
				}
				if(dataLv1.equals(list.get(i).get("DATALV1_NM")) && i == (list.size()-1)) {
					dataLv1Count++;
					lv1Count++;
					countMap1.put(lv1Count, dataLv1Count);
					lv1List.add(countMap1);
				}
				else if(dataLv1.equals(list.get(i).get("DATALV1_NM"))) {
					dataLv1Count++;
				}
				else {
					lv1Count++;
					countMap1.put(lv1Count, dataLv1Count);
					lv1List.add(countMap1);
					dataLv1 = (String) list.get(i).get("DATALV1_NM");
					dataLv1Count = 1;
				}
			}
			
			CellStyle style3 = shBook.createCellStyle();
	    	style3.setAlignment(CellStyle.ALIGN_CENTER);
	    	style3.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	    	style3.setBorderRight(CellStyle.BORDER_THICK);
	    	style3.setBorderLeft(CellStyle.BORDER_THICK);
	    	style3.setBorderTop(CellStyle.BORDER_THICK);
	    	style3.setBorderBottom(CellStyle.BORDER_THICK);//lv1
	    	
	    	CellStyle style4 = shBook.createCellStyle();
	    	DataFormat format4 = shBook.createDataFormat();
	    	style4.setDataFormat(format4.getFormat("#,##0"));
	    	style4.setAlignment(CellStyle.ALIGN_RIGHT);
	    	style4.setBorderRight(CellStyle.BORDER_THIN);
	    	style4.setBorderLeft(CellStyle.BORDER_THIN);
	    	style4.setBorderTop(CellStyle.BORDER_THIN);
	    	style4.setBorderBottom(CellStyle.BORDER_THIN);//값
	    	
	    	CellStyle style7 = shBook.createCellStyle();
	    	style7.setAlignment(CellStyle.ALIGN_CENTER);
	    	HSSFFont font7 = (HSSFFont) shBook.createFont();
	    	font7.setColor(HSSFColor.WHITE.index);
	    	font7.setFontName("맑은 고딕");
	    	font7.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	style7.setFont(font7);
	    	style7.setFillForegroundColor(HSSFColor.INDIGO.index);
	    	style7.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style7.setBorderRight(CellStyle.BORDER_THICK);
	    	style7.setBorderLeft(CellStyle.BORDER_THICK);
	    	style7.setBorderTop(CellStyle.BORDER_THICK);
	    	style7.setBorderBottom(CellStyle.BORDER_THICK);
	    	
	    	CellStyle style8 = shBook.createCellStyle();
	    	DataFormat format8 = shBook.createDataFormat();
	    	style8.setDataFormat(format8.getFormat("#,##0"));
	    	style8.setAlignment(CellStyle.ALIGN_RIGHT);
	    	HSSFFont font8 = (HSSFFont) shBook.createFont();
	    	font8.setColor(HSSFColor.WHITE.index);
	    	font8.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	font8.setFontName("맑은 고딕");
	    	style8.setFont(font8);
	    	style8.setFillForegroundColor(HSSFColor.INDIGO.index);
	    	style8.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style8.setBorderRight(CellStyle.BORDER_THIN);
	    	style8.setBorderLeft(CellStyle.BORDER_THIN);
	    	style8.setBorderTop(CellStyle.BORDER_THICK);
	    	style8.setBorderBottom(CellStyle.BORDER_THICK);//값
	    	
	    	CellStyle style9 = shBook.createCellStyle();
	    	style9.setAlignment(CellStyle.ALIGN_CENTER);
	    	HSSFFont font9 = (HSSFFont) shBook.createFont();
	    	font9.setColor(HSSFColor.WHITE.index);
	    	font9.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	font9.setFontName("맑은 고딕");
	    	style9.setFont(font9);
	    	style9.setFillForegroundColor(HSSFColor.DARK_RED.index);
	    	style9.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style9.setBorderRight(CellStyle.BORDER_THICK);
	    	style9.setBorderLeft(CellStyle.BORDER_THICK);
	    	style9.setBorderTop(CellStyle.BORDER_THICK);
	    	style9.setBorderBottom(CellStyle.BORDER_THICK);
	    	
	    	CellStyle style10 = shBook.createCellStyle();
	    	DataFormat format10 = shBook.createDataFormat();
	    	style10.setDataFormat(format10.getFormat("#,##0.0%"));
	    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
	    	HSSFFont font10 = (HSSFFont) shBook.createFont();
	    	font10.setColor(HSSFColor.WHITE.index);
	    	font10.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 
	    	font10.setFontName("맑은 고딕");
	    	style10.setFont(font10);
	    	style10.setAlignment(CellStyle.ALIGN_RIGHT);
	    	style10.setFillForegroundColor(HSSFColor.DARK_RED.index);
	    	style10.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style10.setBorderRight(CellStyle.BORDER_THIN);
	    	style10.setBorderLeft(CellStyle.BORDER_THIN);
	    	style10.setBorderTop(CellStyle.BORDER_THICK);
	    	style10.setBorderBottom(CellStyle.BORDER_THICK);
	    	
	    	CellStyle style11 = shBook.createCellStyle();
	    	style11.setAlignment(CellStyle.ALIGN_CENTER);
	    	style11.setFillForegroundColor(HSSFColor.BLACK.index);
	    	style11.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style11.setBorderRight(CellStyle.BORDER_THIN);
	    	style11.setBorderLeft(CellStyle.BORDER_THIN);
	    	style11.setBorderTop(CellStyle.BORDER_THICK);
	    	style11.setBorderBottom(CellStyle.BORDER_THICK);
	    	
	    	CellStyle style14 = shBook.createCellStyle();
	    	DataFormat format14 = shBook.createDataFormat();
	    	style14.setDataFormat(format14.getFormat("#,##0.0%"));
	    	style14.setAlignment(CellStyle.ALIGN_RIGHT);
	    	style14.setFont(font8);
	    	style14.setFillForegroundColor(HSSFColor.INDIGO.index);
	    	style14.setFillPattern(CellStyle.SOLID_FOREGROUND);
	    	style14.setBorderRight(CellStyle.BORDER_THIN);
	    	style14.setBorderLeft(CellStyle.BORDER_THIN);
	    	style14.setBorderTop(CellStyle.BORDER_THICK);
	    	style14.setBorderBottom(CellStyle.BORDER_THICK);//값
	    	
	    	// 표 제목
	    	CellStyle style1 = shBook.createCellStyle();
	    	HSSFFont font1 = (HSSFFont) shBook.createFont();
	    	font1.setColor(HSSFColor.DARK_RED.index);
	    	font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	font1.setFontName("맑은 고딕");
	    	style1.setFont(font1);
	    	
	    	CellStyle cdCalc2SignalStyle = null; 
	    	HSSFFont cdCalc2SignalFont = null;
	    	
	    	CellStyle cdCalc3SignalStyle = null; 
	    	HSSFFont cdCalc3SignalFont = null;
			
	    	int tableRow = strartRow;
	    	int currentRow = 0;
	    	int lv1Sum = 0;
	    	int lv2Sum = 0;
	    	int startCell = 0;
	    	int endCell = 0;
	    	int signalCell = 0;
	    	double [] calc = new double[7];
	    	
			for(int i =0; i<list.size(); i++) {
		    	//----------------------------------------
		    	row = shSheet.createRow(109);
		    	cell = row.createCell(1);
		    	cell.setCellValue(new HSSFRichTextString("Credit Target"));
		    	cell.setCellStyle(style1);
		    	//----------------------------------------
				
				row = shSheet.createRow(tableRow+i);
				
				cell = row.createCell(1);
				cell.setCellType(1);
				cell.setCellValue((String)list.get(i).get("DATALV1_NM"));
				startCell = cell.getCellNum();
				
				cell = row.createCell(2);
				cell.setCellType(1);
				cell.setCellValue((String)list.get(i).get("DATALV2_NM"));
				
				cell = row.createCell(3);
				cell.setCellType(1);
				cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
				
				cell = row.createCell(4);
				cell.setCellType(1);
				cell.setCellValue((String)list.get(i).get("DATALV3_NM"));
				
				cell = row.createCell(5);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P01"))));
				
				cell = row.createCell(6);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P02"))));
				
				cell = row.createCell(7);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P03"))));
				
				cell = row.createCell(8);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P04"))));
				
				cell = row.createCell(9);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P05"))));
				
				cell = row.createCell(10);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P06"))));
				
				cell = row.createCell(11);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P07"))));
				
				cell = row.createCell(12);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P08"))));
				
				cell = row.createCell(13);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P09"))));
				
				cell = row.createCell(14);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P10"))));
				
				cell = row.createCell(15);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P11"))));
				
				cell = row.createCell(16);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P12"))));
				

				cell = row.createCell(17);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_Q01"))));
				
				cell = row.createCell(18);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_Q02"))));
				
				cell = row.createCell(19);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_Q03"))));
				
				cell = row.createCell(20);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_Q04"))));
				
				cell = row.createCell(21);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_H01"))));
				
				cell = row.createCell(22);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_H02"))));
				
				cell = row.createCell(23);
				cell.setCellType(1);
				cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_YTD"))));
				
				if(i == (list.size()-1)) {
					cell = row.createCell(24);
					cell.setCellType(1);
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P01"))));
					                                                   
					cell = row.createCell(25);                         
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P02"))));
					                                                    
					cell = row.createCell(26);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P03"))));
					                                                    
					cell = row.createCell(27);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P04"))));
					                                                    
					cell = row.createCell(28);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P05"))));
					                                                    
					cell = row.createCell(29);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P06"))));
					                                                    
					cell = row.createCell(30);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P07"))));
					                                                    
					cell = row.createCell(31);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P08"))));
					                                                    
					cell = row.createCell(32);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P09"))));
					                                                    
					cell = row.createCell(33);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P10"))));
					                                                    
					cell = row.createCell(34);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P11"))));
					                                                    
					cell = row.createCell(35);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_P12"))));
					                                                    
					cell = row.createCell(36);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_Q01"))));
					                                                    
					cell = row.createCell(37);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_Q02"))));
					                                                    
					cell = row.createCell(38);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_Q03"))));
					                                                    
					cell = row.createCell(39);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_Q04"))));
					                                                    
					cell = row.createCell(40);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_H01"))));
					                                                    
					cell = row.createCell(41);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_H02"))));
					                                                    
					cell = row.createCell(42);                          
					cell.setCellType(1);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_TG_YTD"))));
					endCell = cell.getCellNum();
					
					for(int y=startCell; y<=endCell; y++) {
						if(i == list.size()-1) {
							if(row.getCell(y).getCellType() == 1) {
								row.getCell(y).setCellStyle(style9);
							}
							else {
								row.getCell(y).setCellStyle(style10);
							}
						}
						else if(i == list.size()-2) {
							if(row.getCell(y).getCellType() == 1) {
								if(row.getCell(y).getStringCellValue().toString().equals("")) {
									row.getCell(y).setCellStyle(style11);
								}
								else {
									row.getCell(y).setCellStyle(style7);
								}
							}
							else {
								row.getCell(y).setCellStyle(style8);
							}
						}
						else {
							if(row.getCell(y).getCellType() == 1) {
								if(row.getCell(y).getStringCellValue().toString().equals("")) {
									row.getCell(y).setCellStyle(style11);
								}
								else {
									row.getCell(y).setCellStyle(style3);
								}
							}
							else {
								row.getCell(y).setCellStyle(style4);
							}
						}
					}
					
					cell = row.createCell(44);
					cell.setCellType(0);
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P01"))));
					startCell = cell.getCellNum();                      
					
					cell = row.createCell(45);                         
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P02"))));
					                                                    
					cell = row.createCell(46);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P03"))));
					                                                    
					cell = row.createCell(47);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P04"))));
					                                                    
					cell = row.createCell(48);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P05"))));
					                                                    
					cell = row.createCell(49);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P06"))));
					                                                    
					cell = row.createCell(50);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P07"))));
					                                                    
					cell = row.createCell(51);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P08"))));
					                                                    
					cell = row.createCell(52);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P09"))));
					                                                    
					cell = row.createCell(53);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P10"))));
					                                                    
					cell = row.createCell(54);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P11"))));
					                                                    
					cell = row.createCell(55);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_P12"))));
					                                                    
					cell = row.createCell(56);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_Q1"))));
					                                                    
					cell = row.createCell(57);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_Q2"))));
					                                                    
					cell = row.createCell(58);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_Q3"))));
					                                                    
					cell = row.createCell(59);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_Q4"))));
					                                                    
					cell = row.createCell(60);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_H1"))));
					                                                    
					cell = row.createCell(61);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_H2"))));
					                                                    
					cell = row.createCell(62);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_YTD"))));
					
					cell = row.createCell(63);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(64);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(65);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(66);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(67);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(68);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(69);                          
					cell.setCellType(0);       
					cell.setCellValue("");
					endCell = cell.getCellNum();
					
					for(int y=startCell; y<=endCell; y++) {
						if(i == list.size()-1) {
							signalCell = 63;
							
							if(y < 5) {
								row.getCell(y).setCellStyle(style9);
							}
							else {
								row.getCell(y).setCellStyle(style10);
								
								if(y > 63) {
									calc[0] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_Q1")));
									calc[1] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_Q2")));
									calc[2] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_Q3")));
									calc[3] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_Q4")));
									calc[4] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_H1")));
									calc[5] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_H2")));
									calc[6] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC2_YTD")));
									for(int x=0; x<calc.length; x++) {
										cdCalc2SignalStyle = shBook.createCellStyle(); 
										cdCalc2SignalFont = (HSSFFont) shBook.createFont();
										setSignal1(signalCell, cdCalc2SignalStyle, cdCalc2SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setCdCalcSignalStyle(cdCalc2SignalFont, calc[x], i),"lv1");
										signalCell++;
									}
								}
							}
						}
						else if(i == list.size()-2) {
							row.getCell(y).setCellStyle(style14);
						}
						else {
							row.getCell(y).setCellStyle(style8);
						}
					}
					
					cell = row.createCell(71);
					cell.setCellType(0);
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P01"))));
					startCell = cell.getCellNum();
					                                                   
					cell = row.createCell(72);                         
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P02"))));
					                                                    
					cell = row.createCell(73);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P03"))));
					                                                    
					cell = row.createCell(74);                          
					cell.setCellType(0);      
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P04"))));
					                                                    
					cell = row.createCell(75);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P05"))));
					                                                    
					cell = row.createCell(76);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P06"))));
					                                                    
					cell = row.createCell(77);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P07"))));
					                                                    
					cell = row.createCell(78);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P08"))));
					                                                    
					cell = row.createCell(79);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P09"))));
					                                                    
					cell = row.createCell(80);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P10"))));
					                                                    
					cell = row.createCell(81);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P11"))));
					                                                    
					cell = row.createCell(82);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_P12"))));
					                                                    
					cell = row.createCell(83);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_Q1"))));
					                                                    
					cell = row.createCell(84);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_Q2"))));
					                                                    
					cell = row.createCell(85);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_Q3"))));
					                                                    
					cell = row.createCell(86);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_Q4"))));
					                                                    
					cell = row.createCell(87);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_H1"))));
					                                                    
					cell = row.createCell(88);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_H2"))));
					                                                    
					cell = row.createCell(89);                          
					cell.setCellType(0);       
					cell.setCellValue(Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_YTD"))));
					
					cell = row.createCell(90);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(91);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(92);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(93);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(94);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(95);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(96);                          
					cell.setCellType(0);       
					cell.setCellValue("");
					endCell = cell.getCellNum();
					
					for(int y=startCell; y<=endCell; y++) {
						if(i == list.size()-1) {
							signalCell = 90;
							if(y < 5) {
								row.getCell(y).setCellStyle(style9);
							}
							else {
								row.getCell(y).setCellStyle(style10);
								if(y > 89) {
									calc[0] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_Q1")));
									calc[1] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_Q2")));
									calc[2] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_Q3")));
									calc[3] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_Q4")));
									calc[4] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_H1")));
									calc[5] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_H2")));
									calc[6] = Double.parseDouble(String.valueOf(list.get(i).get("CD_CALC3_YTD")));

									for(int x=0; x<calc.length; x++) {
										double signalValue = 0;
										if(calc[x] < 0) {
											signalValue = calc[x] * -1;
										}
										else {
											signalValue = calc[x] * 1;
										}
										cdCalc3SignalStyle = shBook.createCellStyle(); 
										cdCalc3SignalFont = (HSSFFont) shBook.createFont();
										setSignal1(signalCell, cdCalc3SignalStyle, cdCalc3SignalFont, row, row.getCell(61).getCellStyle().getFillForegroundColor(), setCdCalc3SignalStyle(cdCalc3SignalFont, signalValue, i),"lv1");
										signalCell++;
									}
								}
							}
						}
						else if(i == list.size()-2) {
							if(y < 5) {
								row.getCell(y).setCellStyle(style7);
							}
							else {
								row.getCell(y).setCellStyle(style8);
							}
						}
						else {
							if(y < 5) {
								row.getCell(y).setCellStyle(style3);
							}
							else {
								row.getCell(y).setCellStyle(style4);
							}
						}
					}
					
				}
				else {
					cell = row.createCell(24);
					cell.setCellType(1);
					cell.setCellValue("");
					cell = row.createCell(25);                         
					cell.setCellType(1);       
					cell.setCellValue("");
					cell = row.createCell(26);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(27);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(28);                          
					cell.setCellType(1); 
					cell.setCellValue("");
					cell = row.createCell(29);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(30);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(31);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(32);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(33);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(34);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(35);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(36);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(37);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(38);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(39);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(40);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(41);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					cell = row.createCell(42);                          
					cell.setCellType(1);  
					cell.setCellValue("");
					endCell = cell.getCellNum();
					
					for(int y=startCell; y<=endCell; y++) {
						if(i == list.size()-1) {
							if(row.getCell(y).getCellType() == 1) {
								row.getCell(y).setCellStyle(style9);
							}
							else {
								row.getCell(y).setCellStyle(style10);
							}
						}
						else if(i == list.size()-2) {
							if(row.getCell(y).getCellType() == 1) {
								if(row.getCell(y).getStringCellValue().toString().equals("")) {
									row.getCell(y).setCellStyle(style11);
								}
								else {
									row.getCell(y).setCellStyle(style7);
								}
							}
							else {
								row.getCell(y).setCellStyle(style8);
							}
						}
						else {
							if(row.getCell(y).getCellType() == 1) {
								if(row.getCell(y).getStringCellValue().toString().equals("")) {
									row.getCell(y).setCellStyle(style11);
								}
								else {
									row.getCell(y).setCellStyle(style3);
								}
							}
							else {
								row.getCell(y).setCellStyle(style4);
							}
						}
					}
					
					cell = row.createCell(44);
					cell.setCellType(0);
					cell.setCellValue("");
					startCell = cell.getCellNum();
					                                                   
					cell = row.createCell(45);                         
					cell.setCellType(0);       
					cell.setCellValue("");
					                                                    
					cell = row.createCell(46);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(47);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(48);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(49);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(50);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(51);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(52);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(53);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(54);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(55);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(56);                          
					cell.setCellType(0);     
					cell.setCellValue("");
					                                                    
					cell = row.createCell(57);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(58);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(59);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(60);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(61);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(62);                          
					cell.setCellType(0);       
					cell.setCellValue("");
					
					cell = row.createCell(63);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(64);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(65);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(66);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(67);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(68);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(69);                          
					cell.setCellType(0);       
					cell.setCellValue("");
					endCell = cell.getCellNum();
					
					for(int y=startCell; y<=endCell; y++) {
						if(i == list.size()-1) {
							if(row.getCell(y).getCellType() == 1) {
								row.getCell(y).setCellStyle(style9);
							}
							else {
								row.getCell(y).setCellStyle(style10);
							}
						}
						else if(i == list.size()-2) {
							if(row.getCell(y).getCellType() == 1) {
								if(row.getCell(y).getStringCellValue().toString().equals("")) {
									row.getCell(y).setCellStyle(style11);
								}
								else {
									row.getCell(y).setCellStyle(style7);
								}
							}
							else {
								row.getCell(y).setCellStyle(style8);
							}
						}
						else {
							if(row.getCell(y).getCellType() == 1) {
								if(row.getCell(y).getStringCellValue().toString().equals("")) {
									row.getCell(y).setCellStyle(style11);
								}
								else {
									row.getCell(y).setCellStyle(style3);
								}
							}
							else {
								row.getCell(y).setCellStyle(style4);
							}
						}
					}
					
					cell = row.createCell(71);
					cell.setCellType(0);
					cell.setCellValue("");
					startCell = cell.getCellNum();
					                                                   
					cell = row.createCell(72);                         
					cell.setCellType(0);       
					cell.setCellValue("");
					                                                    
					cell = row.createCell(73);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(74);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(75);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(76);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(77);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(78);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(79);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(80);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(81);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(82);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(83);                          
					cell.setCellType(0);     
					cell.setCellValue("");
					                                                    
					cell = row.createCell(84);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(85);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(86);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(87);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(88);                          
					cell.setCellType(0);  
					cell.setCellValue("");
					                                                    
					cell = row.createCell(89);                          
					cell.setCellType(0);       
					cell.setCellValue("");
					
					cell = row.createCell(90);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(91);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(92);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(93);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(94);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(95);                          
					cell.setCellType(0);       
					cell.setCellValue("");

					cell = row.createCell(96);                          
					cell.setCellType(0);       
					cell.setCellValue("");
					endCell = cell.getCellNum();
					
					for(int y=startCell; y<=endCell; y++) {
						if(i == list.size()-1) {
							if(row.getCell(y).getCellType() == 1) {
								row.getCell(y).setCellStyle(style9);
							}
							else {
								row.getCell(y).setCellStyle(style10);
							}
						}
						else if(i == list.size()-2) {
							if(row.getCell(y).getCellType() == 1) {
								if(row.getCell(y).getStringCellValue().toString().equals("")) {
									row.getCell(y).setCellStyle(style11);
								}
								else {
									row.getCell(y).setCellStyle(style7);
								}
							}
							else {
								row.getCell(y).setCellStyle(style8);
							}
						}
						else {
							if(row.getCell(y).getCellType() == 1) {
								if(row.getCell(y).getStringCellValue().toString().equals("")) {
									row.getCell(y).setCellStyle(style11);
								}
								else {
									row.getCell(y).setCellStyle(style3);
								}
							}
							else {
								row.getCell(y).setCellStyle(style4);
							}
						}
					}
				}
				
				shSheet.addMergedRegion(new Region(( int) tableRow+i , ( short )1 , ( int) tableRow+i, (short )4 ));
				
			}
				
			return list;
		}
	
	//신호등 스타일 적용
	public void setSignal1(int cellStartIndex, CellStyle style, HSSFFont font, HSSFRow row, short color, short fontColor, String level) {
		font.setColor(fontColor);
		font.setFontName("맑은 고딕");
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setFont(font);
		style.setFillForegroundColor(color);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setAlignment(CellStyle.ALIGN_CENTER);
		if(level.equals("lv2")) {
			style.setBorderTop(CellStyle.BORDER_THIN);
			style.setBorderBottom(CellStyle.BORDER_THICK);
			style.setBorderRight(CellStyle.BORDER_THIN);
			style.setBorderLeft(CellStyle.BORDER_THIN);
		}
		else {
			style.setBorderTop(CellStyle.BORDER_THICK);
			style.setBorderBottom(CellStyle.BORDER_THICK);
			style.setBorderRight(CellStyle.BORDER_THIN);
			style.setBorderLeft(CellStyle.BORDER_THIN);
		}
		row.getCell(cellStartIndex).setCellStyle(style);
		row.getCell(cellStartIndex).setCellValue("●");
	}
	
	//신호등 스타일 적용
		public void setSignal2(int cellStartIndex, CellStyle style, HSSFFont font, HSSFRow row, short color, short fontColor, String level) {
			font.setColor(fontColor);
			font.setFontName("맑은 고딕");
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			style.setFont(font);
			style.setFillForegroundColor(color);
			style.setFillPattern(CellStyle.SOLID_FOREGROUND);
			style.setAlignment(CellStyle.ALIGN_CENTER);
			if(level.equals("lv2")) {
				style.setBorderTop(CellStyle.BORDER_THIN);
				style.setBorderBottom(CellStyle.BORDER_THICK);
				style.setBorderRight(CellStyle.BORDER_THIN);
				style.setBorderLeft(CellStyle.BORDER_THIN);
			}
			else {
				style.setBorderTop(CellStyle.BORDER_THICK);
				style.setBorderBottom(CellStyle.BORDER_THICK);
				style.setBorderRight(CellStyle.BORDER_THIN);
				style.setBorderLeft(CellStyle.BORDER_THIN);
			}
			row.getCell(cellStartIndex).setCellStyle(style);
			row.getCell(cellStartIndex).setCellValue("");
		}
	
	//Sh Forecast Accuracy% .vs Forecast
	public short setAcCalc1SignalStyle(HSSFFont signalFont1, double calc, int listIndex, int listSize) {
		short fontColor = 0;
		if(calc >0.1) {
			fontColor = HSSFColor.RED.index;
		}
		else if(calc>0.05 && calc<=0.1) {
			fontColor = HSSFColor.YELLOW.index;
		}
		else if(calc<=0.05) {
			fontColor = HSSFColor.GREEN.index;
		}
		return fontColor;
	}
	
	//Sh Achievement% % vs. Target 신호등 구분
	public short setAcCalc2SignalStyle(HSSFFont signalFont1, String calc, int listIndex, int listSize) {
		short fontColor = 0;
		
		if(Double.parseDouble(calc)>1) {
			fontColor = HSSFColor.GREEN.index;
		}
		else if((Double.parseDouble(calc)>0.98) && Double.parseDouble(calc)<=1) {
			fontColor = HSSFColor.YELLOW.index;
		}
		else if(Double.parseDouble(calc)<=0.98) {
			fontColor = HSSFColor.RED.index;
		}
		return fontColor;
	}
	
	//Growth Rate% vs. F15 신호등 구분
	public short setAcCalc3SignalStyle(HSSFFont signalFont1, String calc, int listIndex, int listSize, short color, ArrayList<Map> lv2List) {
		short fontColor = 0;
		int lv2Row = 0;
		
		for(int i=0; i<lv2List.size(); i++) {
			if(listIndex == 5) {			//	Whisky Local SubTotal 
				fontColor = 0;
				if(Double.parseDouble(String.valueOf(calc))>(-0.064)) {
					fontColor = HSSFColor.GREEN.index;
				}
				else if((Double.parseDouble(calc)<=(-0.064)) && Double.parseDouble(calc)>=(-0.084)) {
					fontColor = HSSFColor.YELLOW.index;
				}
				else if(Double.parseDouble(String.valueOf(calc))<(-0.084)) {
					fontColor = HSSFColor.RED.index;
				}
			}else if(listIndex == 11) {		//	Whisky Int'L SubTotal
				fontColor = 0;
				if(Double.parseDouble(calc)>(-0.04)) {
					fontColor = HSSFColor.GREEN.index;
				}
				else if((Double.parseDouble(calc)<=(-0.04)) && Double.parseDouble(calc)>=(-0.06)) {
					fontColor = HSSFColor.YELLOW.index;
				}
				else if(Double.parseDouble(calc)<(-0.06)) {
					fontColor = HSSFColor.RED.index;
				}
			}else if(listIndex == 12) {		//	Whisky Total
				fontColor = 0;
				if(Double.parseDouble(calc)>(0)) {
					fontColor = HSSFColor.GREEN.index;
				}
				else if((Double.parseDouble(calc)>= -0.003) && Double.parseDouble(calc)<=0) {
					fontColor = HSSFColor.YELLOW.index;
				}
				else if(Double.parseDouble(calc)<=-0.003) {
					fontColor = HSSFColor.RED.index;
				}
			}else if(listIndex == 19) {		// Non Whisky Beer
				fontColor = 0;
				if(Double.parseDouble(calc) > (0.15)) {
					fontColor = HSSFColor.GREEN.index;
				}
				else if((Double.parseDouble(calc) <= (0.15)) && Double.parseDouble(calc) > (0.13)) {
					fontColor = HSSFColor.YELLOW.index;
				}
				else if(Double.parseDouble(calc) < (0.13)) {
					fontColor = HSSFColor.RED.index;
				}
			}else if(listIndex == 21) {		//	Non Whisky Vodka
				fontColor = 0;
				if(Double.parseDouble(calc)>(0.05)) {
					fontColor = HSSFColor.GREEN.index;
				}
				else if((Double.parseDouble(calc)>=0.03) && Double.parseDouble(calc)<=0.05) {
					fontColor = HSSFColor.YELLOW.index;
				}
				else if(Double.parseDouble(calc)<0.03) {
					fontColor = HSSFColor.RED.index;
				}
			}
		}
		return fontColor;
	}
	
	
	/*//Growth Rate% vs. F15 신호등 구분
	public short setAcCalc3SignalStyle(HSSFFont signalFont1, String calc, int listIndex, int listSize, short color, ArrayList<Map> lv2List) {
		short fontColor = 0;
		int lv2Row = 0;
		
		for(int i=0; i<lv2List.size(); i++) {
			lv2Row += Integer.parseInt(String.valueOf(lv2List.get(i).get(i+1)));
			if(i==0) {
				fontColor = 0;
				if(listIndex == (lv2Row)) {
					if(Double.parseDouble(String.valueOf(calc))>(-0.064)) {
						fontColor = HSSFColor.GREEN.index;
					}
					else if((Double.parseDouble(calc)<=(-0.064)) && Double.parseDouble(calc)>=(-0.084)) {
						fontColor = HSSFColor.YELLOW.index;
					}
					else if(Double.parseDouble(String.valueOf(calc))<(-0.084)) {
						fontColor = HSSFColor.RED.index;
						fontName = "0Red";
					}
				}
			}
			else if(i == 1) {
				fontColor = 0;
				if(listIndex == (lv2Row)) {
					if(Double.parseDouble(calc)>(-0.04)) {
						fontColor = HSSFColor.GREEN.index;
					}
					else if((Double.parseDouble(calc)<=(-0.04)) && Double.parseDouble(calc)>=(-0.06)) {
						fontColor = HSSFColor.YELLOW.index;
					}
					else if(Double.parseDouble(calc)<(-0.06)) {
						fontColor = HSSFColor.RED.index;
					}
				}
			}
			else if(i == 3) {
				fontColor = 0;
				if(listIndex == (lv2Row)) {
					if(Double.parseDouble(calc)>(0.15)) {
						fontColor = HSSFColor.GREEN.index;
					}
					else if((Double.parseDouble(calc)>=0.15) && Double.parseDouble(calc)<=0.15) {
						fontColor = HSSFColor.YELLOW.index;
					}
					else if(Double.parseDouble(calc)<0.13) {
						fontColor = HSSFColor.RED.index;
					}
				}
			}
			else if(i==5) {
				fontColor = 0;
				if(listIndex == (lv2Row)) {
					if(Double.parseDouble(calc)>(0.05)) {
						fontColor = HSSFColor.GREEN.index;
					}
					else if((Double.parseDouble(calc)<=0.05) && Double.parseDouble(calc)>=0.03) {
						fontColor = HSSFColor.YELLOW.index;
					}
					else if(Double.parseDouble(calc)<0.03) {
						fontColor = HSSFColor.RED.index;
					}
				}
			}
			else {
				fontColor = color;
			}
			
		}
		return fontColor;
	}*/
	
	//shipment Growth Rate% vs. F15 Total 신호등 구분 (마지막줄)
	public short setAcTotalSignalStyle(HSSFFont signalFont1, String calc, int listIndex, ArrayList<Map> lv2List) {
		
		short fontColor = 0;
		int lv2Row = 0;
		String fontName = null;
		
		if(Double.parseDouble(calc)>(0)) {
			fontColor = HSSFColor.GREEN.index;
			fontName = "Green";
			
		}
		else if((Double.parseDouble(calc)<=0) && Double.parseDouble(calc)>-0.003) {
			fontColor = HSSFColor.YELLOW.index;
			fontName = "Yellow";
		}
		else if(Double.parseDouble(calc)<=-0.003) {
			fontColor = HSSFColor.RED.index;
			fontName = "Red";
		}
		
		return fontColor;
	}
	
	//DC Growth Rate% vs. F15
	public short setDcCalc1SignalStyle(HSSFFont signalFont1, String calc, int listIndex, int listSize) {
		short fontColor = 0;
		if(listIndex != (listSize-1)) {
			if(Double.parseDouble(calc)>0.03) {
				fontColor = HSSFColor.RED.index;
			}
			else if((Double.parseDouble(calc)>0) && Double.parseDouble(calc)<=0.03) {
				fontColor = HSSFColor.YELLOW.index;
			}
			else if(Double.parseDouble(calc)<=0) {
				fontColor = HSSFColor.GREEN.index;
			}
		}
		else {
			if(Double.parseDouble(calc)>0.005) {
				fontColor = HSSFColor.RED.index;
			}
			else if((Double.parseDouble(calc)>0) && Double.parseDouble(calc)<=0.005) {
				fontColor = HSSFColor.YELLOW.index;
			}
			else if(Double.parseDouble(calc)<=0) {
				fontColor = HSSFColor.GREEN.index;
			}
		}
		return fontColor;
	}
	
	//Forecast Accuracy% vs. Forecast 신호등 구분
	public short setDcCalc3SignalStyle(HSSFFont signalFont1, double calc, int listIndex) {
		short fontColor = 0;
		if(calc>0.1) {
			fontColor = HSSFColor.RED.index;
		}
		else if(calc>0.05 && calc<=0.1) {
			fontColor = HSSFColor.YELLOW.index;
		}
		else if(calc<=0.05) {
			fontColor = HSSFColor.GREEN.index;
		}
		
		return fontColor;
	}
	
	//Achievement% % vs. Target 신호등 구분
	public short setDcCalc2SignalStyle(HSSFFont signalFont1, double calc, int listIndex) {
		short fontColor = 0;
		
		if(listIndex != 5) {
			if(Double.parseDouble(String.valueOf(calc))>1.1) {
				fontColor = HSSFColor.RED.index;
			}
			else if((Double.parseDouble(String.valueOf(calc))>=1) && Double.parseDouble(String.valueOf(calc))<=1.1) {
				fontColor = HSSFColor.YELLOW.index;
			}
			else if(Double.parseDouble(String.valueOf(calc))<1) {
				fontColor = HSSFColor.GREEN.index;
			}
		}
		else {
			if(Double.parseDouble(String.valueOf(calc))>1) {
				fontColor = HSSFColor.RED.index;
			}
			else if((Double.parseDouble(String.valueOf(calc))>=0.97) && Double.parseDouble(String.valueOf(calc))<=1) {
				fontColor = HSSFColor.YELLOW.index;
			}
			else if(Double.parseDouble(String.valueOf(calc))< 0.97) {
				fontColor = HSSFColor.GREEN.index;
			}
		}
		
		return fontColor;
	}
	
	//Credit 신호등(Achievement% % vs. Target 신호등 구분)
	public short setCdCalcSignalStyle(HSSFFont signalFont1, double calc, int listIndex) {
		short fontColor = 0;
		String name = "";
		if(calc>1.1) {
			fontColor = HSSFColor.RED.index;
			name = "Red";
		}
		else if(calc>1 && calc<=1.1) {
			fontColor = HSSFColor.YELLOW.index;
			name = "Yellow";
		}
		else if(calc<=1) {
			fontColor = HSSFColor.GREEN.index;
			name = "Green";
		}
		return fontColor;
	}
	
	//Credit Forecast Accuracy vs. Forecast
	public short setCdCalc3SignalStyle(HSSFFont signalFont1, double calc, int listIndex) {
		short fontColor = 0;
		if(calc>0.1) {
			fontColor = HSSFColor.RED.index;
		}
		else if(calc>0.05 && calc<=0.1) {
			fontColor = HSSFColor.YELLOW.index;
		}
		else if(calc<=0.05) {
			fontColor = HSSFColor.GREEN.index;
		}
		
		return fontColor;
	}
		
	//회계월에 의한 셀숨김
	public void hideCell (Map map, int startCell, int endCell, HSSFSheet sheet, HSSFRow row) {
		String cellValue[] = hideCellValue(map);
		
		for(int j=startCell; j<=endCell; j++) {
			sheet.setColumnWidth(j, 0);
		}
		
		for(int i =0; i<cellValue.length; i++) {
			for(int j=startCell; j<=endCell; j++) {
				if(cellValue[i].equals(row.getCell(j).getStringCellValue().toString())) {
					sheet.setColumnWidth(j, 4000);
				}
			}
		}
	}
	
	//셀 구분
	public String[] hideCellValue(Map param) {
		String[] cellValue = new String[13];
		
		if(param.get("period").equals("Q1")) {
			cellValue[0] = "P01";
			cellValue[1] = "P02";
			cellValue[2] = "P03";
			cellValue[3] = "Q1";
			cellValue[4] = "H1";
			cellValue[5] = "YTD";
			cellValue[6] = "Q1신호등";
			cellValue[7] = "H1신호등";
			cellValue[8] = "Q1신호등";
			cellValue[9] = "YTD신호등";
			cellValue[10] = "";
			cellValue[11] = "";
			cellValue[12] = "";
		}
		else if(param.get("period").equals("Q2")) {
			cellValue[0] = "P04";
			cellValue[1] = "P05";
			cellValue[2] = "P06";
			cellValue[3] = "Q1";
			cellValue[4] = "Q2";
			cellValue[5] = "H1";
			cellValue[6] = "YTD";
			cellValue[7] = "Q1신호등";
			cellValue[8] = "Q2신호등";
			cellValue[9] = "H1신호등";
			cellValue[10] = "YTD신호등";
			cellValue[11] = "";
			cellValue[12] = "";
		}
		else if(param.get("period").equals("Q3")) {
			cellValue[0] = "P07";
			cellValue[1] = "P08";
			cellValue[2] = "P09";
			cellValue[3] = "Q2";
			cellValue[4] = "Q3";
			cellValue[5] = "H1";
			cellValue[6] = "H2";
			cellValue[7] = "YTD";
			cellValue[8] = "Q2신호등";
			cellValue[9] = "Q3신호등";
			cellValue[10] = "H1신호등";
			cellValue[11] = "H2신호등";
			cellValue[12] = "YTD신호등";
		}
		else if(param.get("period").equals("Q4")) {
			cellValue[0] = "P10";
			cellValue[1] = "P11";
			cellValue[2] = "P12";
			cellValue[3] = "Q3";
			cellValue[4] = "Q4";
			cellValue[5] = "H1";
			cellValue[6] = "H2";
			cellValue[7] = "YTD";
			cellValue[8] = "Q3신호등";
			cellValue[9] = "Q4신호등";
			cellValue[10] = "H1신호등";
			cellValue[11] = "H2신호등";
			cellValue[12] = "YTD신호등";
		}
		
		return cellValue;
	}
	
	//DC 리스트 추출
	public ArrayList<Map> dcForecast(ArrayList<Map>list, Map param) throws Exception {
		
		for(int i=0; i<list.size(); i++) {
			
			double dc_ac_q1 = Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P01"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P02"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P03")));
			double dc_ac_q2 = Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P04"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P05"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P06")));
			double dc_ac_q3 = Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P07"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P08"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P09")));
			double dc_ac_q4 = Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P10"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P11"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P12")));
			double dc_ac_h1 = dc_ac_q1 + dc_ac_q2;
			double dc_ac_h2 = dc_ac_q3 + dc_ac_q4;
			double dc_ac_ytd = setAcYTD(param, list.get(i), "DC");
			
			list.get(i).put("DC_AC_Q1",dc_ac_q1);
			list.get(i).put("DC_AC_Q2",dc_ac_q2);
			list.get(i).put("DC_AC_Q3",dc_ac_q3);
			list.get(i).put("DC_AC_Q4",dc_ac_q4);

			list.get(i).put("DC_AC_H1",dc_ac_h1);
			list.get(i).put("DC_AC_H2",dc_ac_h2);
			
			list.get(i).put("DC_AC_YTD",dc_ac_ytd);

			double dc_for_q1 = Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P01"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P02"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P03")));
			double dc_for_q2 = Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P04"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P05"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P06")));
			double dc_for_q3 = Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P07"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P08"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P09")));
			double dc_for_q4 = Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P10"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P11"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P12")));
			double dc_for_h1 = dc_for_q1 + dc_for_q2;
			double dc_for_h2 = dc_for_q3 + dc_for_q4;
			double dc_for_ytd = setForYTD(param, list.get(i), "DC");

			list.get(i).put("DC_FOR_Q1",dc_for_q1);
			list.get(i).put("DC_FOR_Q2",dc_for_q2);
			list.get(i).put("DC_FOR_Q3",dc_for_q3);
			list.get(i).put("DC_FOR_Q4",dc_for_q4);

			list.get(i).put("DC_FOR_H1",dc_for_h1);
			list.get(i).put("DC_FOR_H2",dc_for_h2);
			
			list.get(i).put("DC_FOR_YTD",dc_for_ytd);

			double dc_out_q1 = Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P01"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P02"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P03")));
			double dc_out_q2 = Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P04"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P05"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P06")));
			double dc_out_q3 = Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P07"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P08"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P09")));
			double dc_out_q4 = Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P10"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P11"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P12")));
			double dc_out_h1 = dc_out_q1 + dc_out_q2;
			double dc_out_h2 = dc_out_q3 + dc_out_q4;
			double dc_out_ytd = setOutYTD(param, list.get(i), "DC");

			list.get(i).put("DC_OUT_Q1",dc_out_q1);
			list.get(i).put("DC_OUT_Q2",dc_out_q2);
			list.get(i).put("DC_OUT_Q3",dc_out_q3);
			list.get(i).put("DC_OUT_Q4",dc_out_q4);

			list.get(i).put("DC_OUT_H1",dc_out_h1);
			list.get(i).put("DC_OUT_H2",dc_out_h2);
			
			list.get(i).put("DC_OUT_YTD",dc_out_ytd);

			double dc_tg_q1 = Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P01"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P02"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P03")));
			double dc_tg_q2 = Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P04"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P05"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P06")));
			double dc_tg_q3 = Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P07"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P08"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P09")));
			double dc_tg_q4 = Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P10"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P11"))) + Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P12")));
			double dc_tg_h1 = dc_tg_q1 + dc_tg_q2;
			double dc_tg_h2 = dc_tg_q3 + dc_tg_q4;
			double dc_tg_ytd = setTgYTD(param, list.get(i), "DC");

			list.get(i).put("DC_TG_Q1",dc_tg_q1);
			list.get(i).put("DC_TG_Q2",dc_tg_q2);
			list.get(i).put("DC_TG_Q3",dc_tg_q3);
			list.get(i).put("DC_TG_Q4",dc_tg_q4);

			list.get(i).put("DC_TG_H1",dc_tg_h1);
			list.get(i).put("DC_TG_H2",dc_tg_h2);
			
			list.get(i).put("DC_TG_YTD",dc_tg_ytd);
			
		}
		
		//레벨 카운트
		String dataLv1 = null; //lv1 구분
		
		double lv1_dc_ac_p01_sum = 0;
		double lv1_dc_ac_p02_sum = 0;
		double lv1_dc_ac_p03_sum = 0;
		double lv1_dc_ac_p04_sum = 0;
		double lv1_dc_ac_p05_sum = 0;
		double lv1_dc_ac_p06_sum = 0;
		double lv1_dc_ac_p07_sum = 0;
		double lv1_dc_ac_p08_sum = 0;
		double lv1_dc_ac_p09_sum = 0;
		double lv1_dc_ac_p10_sum = 0;
		double lv1_dc_ac_p11_sum = 0;
		double lv1_dc_ac_p12_sum = 0;
		double lv1_dc_ac_q01_sum = 0;
		double lv1_dc_ac_q02_sum = 0;
		double lv1_dc_ac_q03_sum = 0;
		double lv1_dc_ac_q04_sum = 0;
		double lv1_dc_ac_h01_sum = 0;
		double lv1_dc_ac_h02_sum = 0;
		double lv1_dc_ac_ytd_sum = 0;

		double lv1_dc_for_p01_sum = 0;
		double lv1_dc_for_p02_sum = 0;
		double lv1_dc_for_p03_sum = 0;
		double lv1_dc_for_p04_sum = 0;
		double lv1_dc_for_p05_sum = 0;
		double lv1_dc_for_p06_sum = 0;
		double lv1_dc_for_p07_sum = 0;
		double lv1_dc_for_p08_sum = 0;
		double lv1_dc_for_p09_sum = 0;
		double lv1_dc_for_p10_sum = 0;
		double lv1_dc_for_p11_sum = 0;
		double lv1_dc_for_p12_sum = 0;
		double lv1_dc_for_q01_sum = 0;
		double lv1_dc_for_q02_sum = 0;
		double lv1_dc_for_q03_sum = 0;
		double lv1_dc_for_q04_sum = 0;
		double lv1_dc_for_h01_sum = 0;
		double lv1_dc_for_h02_sum = 0;
		double lv1_dc_for_ytd_sum = 0;

		double lv1_dc_out_p01_sum = 0;
		double lv1_dc_out_p02_sum = 0;
		double lv1_dc_out_p03_sum = 0;
		double lv1_dc_out_p04_sum = 0;
		double lv1_dc_out_p05_sum = 0;
		double lv1_dc_out_p06_sum = 0;
		double lv1_dc_out_p07_sum = 0;
		double lv1_dc_out_p08_sum = 0;
		double lv1_dc_out_p09_sum = 0;
		double lv1_dc_out_p10_sum = 0;
		double lv1_dc_out_p11_sum = 0;
		double lv1_dc_out_p12_sum = 0;
		double lv1_dc_out_q01_sum = 0;
		double lv1_dc_out_q02_sum = 0;
		double lv1_dc_out_q03_sum = 0;
		double lv1_dc_out_q04_sum = 0;
		double lv1_dc_out_h01_sum = 0;
		double lv1_dc_out_h02_sum = 0;
		double lv1_dc_out_ytd_sum = 0;


		double lv1_dc_tg_p01_sum = 0;
		double lv1_dc_tg_p02_sum = 0;
		double lv1_dc_tg_p03_sum = 0;
		double lv1_dc_tg_p04_sum = 0;
		double lv1_dc_tg_p05_sum = 0;
		double lv1_dc_tg_p06_sum = 0;
		double lv1_dc_tg_p07_sum = 0;
		double lv1_dc_tg_p08_sum = 0;
		double lv1_dc_tg_p09_sum = 0;
		double lv1_dc_tg_p10_sum = 0;
		double lv1_dc_tg_p11_sum = 0;
		double lv1_dc_tg_p12_sum = 0;
		double lv1_dc_tg_q01_sum = 0;
		double lv1_dc_tg_q02_sum = 0;
		double lv1_dc_tg_q03_sum = 0;
		double lv1_dc_tg_q04_sum = 0;
		double lv1_dc_tg_h01_sum = 0;
		double lv1_dc_tg_h02_sum = 0;
		double lv1_dc_tg_ytd_sum = 0;

		Map dcForeCastMap = null;
		ArrayList<Map> dcForeCast = new ArrayList<Map>();
		
		for(int i=0; i<list.size(); i++) {
			if(i == 0) {
				dataLv1 = (String) list.get(0).get("DATALV1"); 
			}
			
			if(dataLv1.equals(list.get(i).get("DATALV1"))) {
				dcForeCastMap = new HashMap();
				dcForeCastMap.put("DATALV1_NM", (String)list.get(i).get("DATALV1_NM"));
				dcForeCastMap.put("DATALV2_NM", (String)list.get(i).get("DATALV2_NM"));
				dcForeCastMap.put("DATALV1", (String)list.get(i).get("DATALV1_NM"));
				dcForeCastMap.put("DATALV2", (String)list.get(i).get("DATALV2_NM"));
				dcForeCastMap.put("DC_AC_P01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P01")))/1000));
				dcForeCastMap.put("DC_AC_P02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P02")))/1000));
				dcForeCastMap.put("DC_AC_P03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P03")))/1000));
				dcForeCastMap.put("DC_AC_P04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P04")))/1000));
				dcForeCastMap.put("DC_AC_P05", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P05")))/1000));
				dcForeCastMap.put("DC_AC_P06", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P06")))/1000));
				dcForeCastMap.put("DC_AC_P07", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P07")))/1000));
				dcForeCastMap.put("DC_AC_P08", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P08")))/1000));
				dcForeCastMap.put("DC_AC_P09", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P09")))/1000));
				dcForeCastMap.put("DC_AC_P10", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P10")))/1000));
				dcForeCastMap.put("DC_AC_P11", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P11")))/1000));
				dcForeCastMap.put("DC_AC_P12", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P12")))/1000));
				dcForeCastMap.put("DC_AC_Q01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q1")))/1000));
				dcForeCastMap.put("DC_AC_Q02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q2")))/1000));
				dcForeCastMap.put("DC_AC_Q03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q3")))/1000));
				dcForeCastMap.put("DC_AC_Q04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q4")))/1000));
				dcForeCastMap.put("DC_AC_H01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H1")))/1000));
				dcForeCastMap.put("DC_AC_H02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H2")))/1000));
				dcForeCastMap.put("DC_AC_YTD", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_YTD")))/1000));
				dcForeCastMap.put("DC_FOR_P01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P01")))));
				dcForeCastMap.put("DC_FOR_P02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P02")))));
				dcForeCastMap.put("DC_FOR_P03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P03")))));
				dcForeCastMap.put("DC_FOR_P04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P04")))));
				dcForeCastMap.put("DC_FOR_P05", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P05")))));
				dcForeCastMap.put("DC_FOR_P06", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P06")))));
				dcForeCastMap.put("DC_FOR_P07", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P07")))));
				dcForeCastMap.put("DC_FOR_P08", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P08")))));
				dcForeCastMap.put("DC_FOR_P09", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P09")))));
				dcForeCastMap.put("DC_FOR_P10", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P10")))));
				dcForeCastMap.put("DC_FOR_P11", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P11")))));
				dcForeCastMap.put("DC_FOR_P12", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P12")))));
				dcForeCastMap.put("DC_FOR_Q01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q1")))));
				dcForeCastMap.put("DC_FOR_Q02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q2")))));
				dcForeCastMap.put("DC_FOR_Q03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q3")))));
				dcForeCastMap.put("DC_FOR_Q04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q4")))));
				dcForeCastMap.put("DC_FOR_H01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H1")))));
				dcForeCastMap.put("DC_FOR_H02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H2")))));
				dcForeCastMap.put("DC_FOR_YTD", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_YTD")))));
				dcForeCastMap.put("DC_OUT_P01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P01")))));
				dcForeCastMap.put("DC_OUT_P02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P02")))));
				dcForeCastMap.put("DC_OUT_P03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P03")))));
				dcForeCastMap.put("DC_OUT_P04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P04")))));
				dcForeCastMap.put("DC_OUT_P05", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P05")))));
				dcForeCastMap.put("DC_OUT_P06", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P06")))));
				dcForeCastMap.put("DC_OUT_P07", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P07")))));
				dcForeCastMap.put("DC_OUT_P08", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P08")))));
				dcForeCastMap.put("DC_OUT_P09", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P09")))));
				dcForeCastMap.put("DC_OUT_P10", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P10")))));
				dcForeCastMap.put("DC_OUT_P11", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P11")))));
				dcForeCastMap.put("DC_OUT_P12", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P12")))));
				dcForeCastMap.put("DC_OUT_Q01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q1")))));
				dcForeCastMap.put("DC_OUT_Q02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q2")))));
				dcForeCastMap.put("DC_OUT_Q03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q3")))));
				dcForeCastMap.put("DC_OUT_Q04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q4")))));
				dcForeCastMap.put("DC_OUT_H01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H1")))));
				dcForeCastMap.put("DC_OUT_H02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H2")))));
				dcForeCastMap.put("DC_OUT_YTD", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_YTD")))));
				dcForeCastMap.put("DC_TG_P01", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P01"))));
				dcForeCastMap.put("DC_TG_P02", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P02"))));
				dcForeCastMap.put("DC_TG_P03", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P03"))));
				dcForeCastMap.put("DC_TG_P04", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P04"))));
				dcForeCastMap.put("DC_TG_P05", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P05"))));
				dcForeCastMap.put("DC_TG_P06", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P06"))));
				dcForeCastMap.put("DC_TG_P07", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P07"))));
				dcForeCastMap.put("DC_TG_P08", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P08"))));
				dcForeCastMap.put("DC_TG_P09", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P09"))));
				dcForeCastMap.put("DC_TG_P10", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P10"))));
				dcForeCastMap.put("DC_TG_P11", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P11"))));
				dcForeCastMap.put("DC_TG_P12", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P12"))));
				dcForeCastMap.put("DC_TG_Q01", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q1"))));
				dcForeCastMap.put("DC_TG_Q02", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q2"))));
				dcForeCastMap.put("DC_TG_Q03", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q3"))));
				dcForeCastMap.put("DC_TG_Q04", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q4"))));
				dcForeCastMap.put("DC_TG_H01", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H1"))));
				dcForeCastMap.put("DC_TG_H02", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H2"))));
				dcForeCastMap.put("DC_TG_YTD", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_YTD"))));
				
				dcForeCast.add(dcForeCastMap);
				
				lv1_dc_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P01")))/1000;
				lv1_dc_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P02")))/1000;
				lv1_dc_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P03")))/1000;
				lv1_dc_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P04")))/1000;
				lv1_dc_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P05")))/1000;
				lv1_dc_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P06")))/1000;
				lv1_dc_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P07")))/1000;
				lv1_dc_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P08")))/1000;
				lv1_dc_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P09")))/1000;
				lv1_dc_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P10")))/1000;
				lv1_dc_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P11")))/1000;
				lv1_dc_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P12")))/1000;
				lv1_dc_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q1")))/1000;
				lv1_dc_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q2")))/1000;
				lv1_dc_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q3")))/1000;
				lv1_dc_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q4")))/1000;
				lv1_dc_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H1")))/1000;
				lv1_dc_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H2")))/1000;
				lv1_dc_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_YTD")))/1000;

				lv1_dc_for_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P01")));
				lv1_dc_for_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P02")));
				lv1_dc_for_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P03")));
				lv1_dc_for_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P04")));
				lv1_dc_for_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P05")));
				lv1_dc_for_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P06")));
				lv1_dc_for_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P07")));
				lv1_dc_for_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P08")));
				lv1_dc_for_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P09")));
				lv1_dc_for_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P10")));
				lv1_dc_for_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P11")));
				lv1_dc_for_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P12")));
				lv1_dc_for_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q1")));
				lv1_dc_for_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q2")));
				lv1_dc_for_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q3")));
				lv1_dc_for_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q4")));
				lv1_dc_for_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H1")));
				lv1_dc_for_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H2")));
				lv1_dc_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_YTD")));

				lv1_dc_out_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P01")));
				lv1_dc_out_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P02")));
				lv1_dc_out_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P03")));
				lv1_dc_out_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P04")));
				lv1_dc_out_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P05")));
				lv1_dc_out_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P06")));
				lv1_dc_out_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P07")));
				lv1_dc_out_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P08")));
				lv1_dc_out_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P09")));
				lv1_dc_out_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P10")));
				lv1_dc_out_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P11")));
				lv1_dc_out_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P12")));
				lv1_dc_out_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q1")));
				lv1_dc_out_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q2")));
				lv1_dc_out_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q3")));
				lv1_dc_out_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q4")));
				lv1_dc_out_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H1")));
				lv1_dc_out_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H2")));
				lv1_dc_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_YTD")));

				lv1_dc_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P01")));
				lv1_dc_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P02")));
				lv1_dc_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P03")));
				lv1_dc_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P04")));
				lv1_dc_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P05")));
				lv1_dc_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P06")));
				lv1_dc_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P07")));
				lv1_dc_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P08")));
				lv1_dc_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P09")));
				lv1_dc_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P10")));
				lv1_dc_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P11")));
				lv1_dc_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P12")));
				lv1_dc_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q1")));
				lv1_dc_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q2")));
				lv1_dc_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q3")));
				lv1_dc_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q4")));
				lv1_dc_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H1")));
				lv1_dc_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H2")));
				lv1_dc_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_YTD")));
			}
			else if(i == (list.size()-1)) {
				dcForeCastMap = new HashMap();
				
				dcForeCastMap.put("DATALV1_NM", (String)list.get(i).get("DATALV1_NM"));
				dcForeCastMap.put("DATALV2_NM", (String)list.get(i).get("DATALV2_NM"));
				dcForeCastMap.put("DATALV1", (String)list.get(i).get("DATALV1_NM"));
				dcForeCastMap.put("DATALV2", (String)list.get(i).get("DATALV2_NM"));
				dcForeCastMap.put("DC_AC_P01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P01")))/1000));
				dcForeCastMap.put("DC_AC_P02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P02")))/1000));
				dcForeCastMap.put("DC_AC_P03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P03")))/1000));
				dcForeCastMap.put("DC_AC_P04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P04")))/1000));
				dcForeCastMap.put("DC_AC_P05", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P05")))/1000));
				dcForeCastMap.put("DC_AC_P06", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P06")))/1000));
				dcForeCastMap.put("DC_AC_P07", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P07")))/1000));
				dcForeCastMap.put("DC_AC_P08", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P08")))/1000));
				dcForeCastMap.put("DC_AC_P09", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P09")))/1000));
				dcForeCastMap.put("DC_AC_P10", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P10")))/1000));
				dcForeCastMap.put("DC_AC_P11", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P11")))/1000));
				dcForeCastMap.put("DC_AC_P12", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P12")))/1000));
				dcForeCastMap.put("DC_AC_Q01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q1")))/1000));
				dcForeCastMap.put("DC_AC_Q02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q2")))/1000));
				dcForeCastMap.put("DC_AC_Q03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q3")))/1000));
				dcForeCastMap.put("DC_AC_Q04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q4")))/1000));
				dcForeCastMap.put("DC_AC_H01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H1")))/1000));
				dcForeCastMap.put("DC_AC_H02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H2")))/1000));
				dcForeCastMap.put("DC_AC_YTD", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_YTD")))/1000));
				dcForeCastMap.put("DC_FOR_P01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P01")))));
				dcForeCastMap.put("DC_FOR_P02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P02")))));
				dcForeCastMap.put("DC_FOR_P03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P03")))));
				dcForeCastMap.put("DC_FOR_P04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P04")))));
				dcForeCastMap.put("DC_FOR_P05", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P05")))));
				dcForeCastMap.put("DC_FOR_P06", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P06")))));
				dcForeCastMap.put("DC_FOR_P07", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P07")))));
				dcForeCastMap.put("DC_FOR_P08", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P08")))));
				dcForeCastMap.put("DC_FOR_P09", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P09")))));
				dcForeCastMap.put("DC_FOR_P10", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P10")))));
				dcForeCastMap.put("DC_FOR_P11", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P11")))));
				dcForeCastMap.put("DC_FOR_P12", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P12")))));
				dcForeCastMap.put("DC_FOR_Q01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q1")))));
				dcForeCastMap.put("DC_FOR_Q02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q2")))));
				dcForeCastMap.put("DC_FOR_Q03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q3")))));
				dcForeCastMap.put("DC_FOR_Q04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q4")))));
				dcForeCastMap.put("DC_FOR_H01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H1")))));
				dcForeCastMap.put("DC_FOR_H02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H2")))));
				dcForeCastMap.put("DC_FOR_YTD", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_YTD")))));
				dcForeCastMap.put("DC_OUT_P01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P01")))));
				dcForeCastMap.put("DC_OUT_P02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P02")))));
				dcForeCastMap.put("DC_OUT_P03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P03")))));
				dcForeCastMap.put("DC_OUT_P04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P04")))));
				dcForeCastMap.put("DC_OUT_P05", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P05")))));
				dcForeCastMap.put("DC_OUT_P06", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P06")))));
				dcForeCastMap.put("DC_OUT_P07", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P07")))));
				dcForeCastMap.put("DC_OUT_P08", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P08")))));
				dcForeCastMap.put("DC_OUT_P09", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P09")))));
				dcForeCastMap.put("DC_OUT_P10", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P10")))));
				dcForeCastMap.put("DC_OUT_P11", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P11")))));
				dcForeCastMap.put("DC_OUT_P12", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P12")))));
				dcForeCastMap.put("DC_OUT_Q01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q1")))));
				dcForeCastMap.put("DC_OUT_Q02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q2")))));
				dcForeCastMap.put("DC_OUT_Q03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q3")))));
				dcForeCastMap.put("DC_OUT_Q04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q4")))));
				dcForeCastMap.put("DC_OUT_H01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H1")))));
				dcForeCastMap.put("DC_OUT_H02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H2")))));
				dcForeCastMap.put("DC_OUT_YTD", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_YTD")))));
				dcForeCastMap.put("DC_TG_P01", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P01"))));
				dcForeCastMap.put("DC_TG_P02", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P02"))));
				dcForeCastMap.put("DC_TG_P03", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P03"))));
				dcForeCastMap.put("DC_TG_P04", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P04"))));
				dcForeCastMap.put("DC_TG_P05", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P05"))));
				dcForeCastMap.put("DC_TG_P06", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P06"))));
				dcForeCastMap.put("DC_TG_P07", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P07"))));
				dcForeCastMap.put("DC_TG_P08", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P08"))));
				dcForeCastMap.put("DC_TG_P09", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P09"))));
				dcForeCastMap.put("DC_TG_P10", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P10"))));
				dcForeCastMap.put("DC_TG_P11", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P11"))));
				dcForeCastMap.put("DC_TG_P12", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P12"))));
				dcForeCastMap.put("DC_TG_Q01", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q1"))));
				dcForeCastMap.put("DC_TG_Q02", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q2"))));
				dcForeCastMap.put("DC_TG_Q03", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q3"))));
				dcForeCastMap.put("DC_TG_Q04", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q4"))));
				dcForeCastMap.put("DC_TG_H01", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H1"))));
				dcForeCastMap.put("DC_TG_H02", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H2"))));
				dcForeCastMap.put("DC_TG_YTD", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_YTD"))));
				
				dcForeCast.add(dcForeCastMap);
				
				lv1_dc_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P01")))/1000;
				lv1_dc_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P02")))/1000;
				lv1_dc_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P03")))/1000;
				lv1_dc_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P04")))/1000;
				lv1_dc_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P05")))/1000;
				lv1_dc_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P06")))/1000;
				lv1_dc_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P07")))/1000;
				lv1_dc_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P08")))/1000;
				lv1_dc_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P09")))/1000;
				lv1_dc_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P10")))/1000;
				lv1_dc_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P11")))/1000;
				lv1_dc_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P12")))/1000;
				lv1_dc_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q1")))/1000;
				lv1_dc_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q2")))/1000;
				lv1_dc_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q3")))/1000;
				lv1_dc_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q4")))/1000;
				lv1_dc_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H1")))/1000;
				lv1_dc_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H2")))/1000;
				lv1_dc_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_YTD")))/1000;

				lv1_dc_for_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P01")));
				lv1_dc_for_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P02")));
				lv1_dc_for_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P03")));
				lv1_dc_for_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P04")));
				lv1_dc_for_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P05")));
				lv1_dc_for_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P06")));
				lv1_dc_for_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P07")));
				lv1_dc_for_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P08")));
				lv1_dc_for_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P09")));
				lv1_dc_for_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P10")));
				lv1_dc_for_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P11")));
				lv1_dc_for_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P12")));
				lv1_dc_for_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q1")));
				lv1_dc_for_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q2")));
				lv1_dc_for_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q3")));
				lv1_dc_for_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q4")));
				lv1_dc_for_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H1")));
				lv1_dc_for_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H2")));
				lv1_dc_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_YTD")));

				lv1_dc_out_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P01")));
				lv1_dc_out_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P02")));
				lv1_dc_out_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P03")));
				lv1_dc_out_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P04")));
				lv1_dc_out_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P05")));
				lv1_dc_out_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P06")));
				lv1_dc_out_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P07")));
				lv1_dc_out_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P08")));
				lv1_dc_out_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P09")));
				lv1_dc_out_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P10")));
				lv1_dc_out_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P11")));
				lv1_dc_out_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P12")));
				lv1_dc_out_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q1")));
				lv1_dc_out_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q2")));
				lv1_dc_out_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q3")));
				lv1_dc_out_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q4")));
				lv1_dc_out_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H1")));
				lv1_dc_out_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H2")));
				lv1_dc_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_YTD")));

				lv1_dc_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P01")));
				lv1_dc_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P02")));
				lv1_dc_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P03")));
				lv1_dc_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P04")));
				lv1_dc_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P05")));
				lv1_dc_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P06")));
				lv1_dc_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P07")));
				lv1_dc_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P08")));
				lv1_dc_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P09")));
				lv1_dc_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P10")));
				lv1_dc_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P11")));
				lv1_dc_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P12")));
				lv1_dc_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q1")));
				lv1_dc_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q2")));
				lv1_dc_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q3")));
				lv1_dc_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q4")));
				lv1_dc_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H1")));
				lv1_dc_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H2")));
				lv1_dc_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_YTD")));
				
				dcForeCastMap = new HashMap();
				
				dcForeCastMap.put("DATALV1_NM", (String)list.get(i).get("DATALV1_NM"));
				dcForeCastMap.put("DATALV1", (String)list.get(i).get("DATALV1_NM"));
				dcForeCastMap.put("DATALV2", "SUM");
				dcForeCastMap.put("DATALV2_NM", (String)list.get(i).get("DATALV1_NM")+" 합계");

				dcForeCastMap.put("DC_AC_P01", lv1_dc_ac_p01_sum);
				dcForeCastMap.put("DC_AC_P02", lv1_dc_ac_p02_sum);
				dcForeCastMap.put("DC_AC_P03", lv1_dc_ac_p03_sum);
				dcForeCastMap.put("DC_AC_P04", lv1_dc_ac_p04_sum);
				dcForeCastMap.put("DC_AC_P05", lv1_dc_ac_p05_sum);
				dcForeCastMap.put("DC_AC_P06", lv1_dc_ac_p06_sum);
				dcForeCastMap.put("DC_AC_P07", lv1_dc_ac_p07_sum);
				dcForeCastMap.put("DC_AC_P08", lv1_dc_ac_p08_sum);
				dcForeCastMap.put("DC_AC_P09", lv1_dc_ac_p09_sum);
				dcForeCastMap.put("DC_AC_P10", lv1_dc_ac_p10_sum);
				dcForeCastMap.put("DC_AC_P11", lv1_dc_ac_p11_sum);
				dcForeCastMap.put("DC_AC_P12", lv1_dc_ac_p12_sum);
				dcForeCastMap.put("DC_AC_Q01", lv1_dc_ac_q01_sum);
				dcForeCastMap.put("DC_AC_Q02", lv1_dc_ac_q02_sum);
				dcForeCastMap.put("DC_AC_Q03", lv1_dc_ac_q03_sum);
				dcForeCastMap.put("DC_AC_Q04", lv1_dc_ac_q04_sum);
				dcForeCastMap.put("DC_AC_H01", lv1_dc_ac_h01_sum);
				dcForeCastMap.put("DC_AC_H02", lv1_dc_ac_h02_sum);
				dcForeCastMap.put("DC_AC_YTD", lv1_dc_ac_ytd_sum);

				dcForeCastMap.put("DC_FOR_P01", lv1_dc_for_p01_sum);
				dcForeCastMap.put("DC_FOR_P02", lv1_dc_for_p02_sum);
				dcForeCastMap.put("DC_FOR_P03", lv1_dc_for_p03_sum);
				dcForeCastMap.put("DC_FOR_P04", lv1_dc_for_p04_sum);
				dcForeCastMap.put("DC_FOR_P05", lv1_dc_for_p05_sum);
				dcForeCastMap.put("DC_FOR_P06", lv1_dc_for_p06_sum);
				dcForeCastMap.put("DC_FOR_P07", lv1_dc_for_p07_sum);
				dcForeCastMap.put("DC_FOR_P08", lv1_dc_for_p08_sum);
				dcForeCastMap.put("DC_FOR_P09", lv1_dc_for_p09_sum);
				dcForeCastMap.put("DC_FOR_P10", lv1_dc_for_p10_sum);
				dcForeCastMap.put("DC_FOR_P11", lv1_dc_for_p11_sum);
				dcForeCastMap.put("DC_FOR_P12", lv1_dc_for_p12_sum);
				dcForeCastMap.put("DC_FOR_Q01", lv1_dc_for_q01_sum);
				dcForeCastMap.put("DC_FOR_Q02", lv1_dc_for_q02_sum);
				dcForeCastMap.put("DC_FOR_Q03", lv1_dc_for_q03_sum);
				dcForeCastMap.put("DC_FOR_Q04", lv1_dc_for_q04_sum);
				dcForeCastMap.put("DC_FOR_H01", lv1_dc_for_h01_sum);
				dcForeCastMap.put("DC_FOR_H02", lv1_dc_for_h02_sum);
				dcForeCastMap.put("DC_FOR_YTD", lv1_dc_for_ytd_sum);
				                                   
				dcForeCastMap.put("DC_OUT_P01", lv1_dc_out_p01_sum);
				dcForeCastMap.put("DC_OUT_P02", lv1_dc_out_p02_sum);
				dcForeCastMap.put("DC_OUT_P03", lv1_dc_out_p03_sum);
				dcForeCastMap.put("DC_OUT_P04", lv1_dc_out_p04_sum);
				dcForeCastMap.put("DC_OUT_P05", lv1_dc_out_p05_sum);
				dcForeCastMap.put("DC_OUT_P06", lv1_dc_out_p06_sum);
				dcForeCastMap.put("DC_OUT_P07", lv1_dc_out_p07_sum);
				dcForeCastMap.put("DC_OUT_P08", lv1_dc_out_p08_sum);
				dcForeCastMap.put("DC_OUT_P09", lv1_dc_out_p09_sum);
				dcForeCastMap.put("DC_OUT_P10", lv1_dc_out_p10_sum);
				dcForeCastMap.put("DC_OUT_P11", lv1_dc_out_p11_sum);
				dcForeCastMap.put("DC_OUT_P12", lv1_dc_out_p12_sum);
				dcForeCastMap.put("DC_OUT_Q01", lv1_dc_out_q01_sum);
				dcForeCastMap.put("DC_OUT_Q02", lv1_dc_out_q02_sum);
				dcForeCastMap.put("DC_OUT_Q03", lv1_dc_out_q03_sum);
				dcForeCastMap.put("DC_OUT_Q04", lv1_dc_out_q04_sum);
				dcForeCastMap.put("DC_OUT_H01", lv1_dc_out_h01_sum);
				dcForeCastMap.put("DC_OUT_H02", lv1_dc_out_h02_sum);
				dcForeCastMap.put("DC_OUT_YTD", lv1_dc_out_ytd_sum);
				                                   
				dcForeCastMap.put("DC_TG_P01", lv1_dc_tg_p01_sum);
				dcForeCastMap.put("DC_TG_P02", lv1_dc_tg_p02_sum);
				dcForeCastMap.put("DC_TG_P03", lv1_dc_tg_p03_sum);
				dcForeCastMap.put("DC_TG_P04", lv1_dc_tg_p04_sum);
				dcForeCastMap.put("DC_TG_P05", lv1_dc_tg_p05_sum);
				dcForeCastMap.put("DC_TG_P06", lv1_dc_tg_p06_sum);
				dcForeCastMap.put("DC_TG_P07", lv1_dc_tg_p07_sum);
				dcForeCastMap.put("DC_TG_P08", lv1_dc_tg_p08_sum);
				dcForeCastMap.put("DC_TG_P09", lv1_dc_tg_p09_sum);
				dcForeCastMap.put("DC_TG_P10", lv1_dc_tg_p10_sum);
				dcForeCastMap.put("DC_TG_P11", lv1_dc_tg_p11_sum);
				dcForeCastMap.put("DC_TG_P12", lv1_dc_tg_p12_sum);
				dcForeCastMap.put("DC_TG_Q01", lv1_dc_tg_q01_sum);
				dcForeCastMap.put("DC_TG_Q02", lv1_dc_tg_q02_sum);
				dcForeCastMap.put("DC_TG_Q03", lv1_dc_tg_q03_sum);
				dcForeCastMap.put("DC_TG_Q04", lv1_dc_tg_q04_sum);
				dcForeCastMap.put("DC_TG_H01", lv1_dc_tg_h01_sum);
				dcForeCastMap.put("DC_TG_H02", lv1_dc_tg_h02_sum);
				dcForeCastMap.put("DC_TG_YTD", lv1_dc_tg_ytd_sum);
				
				dcForeCast.add(dcForeCastMap);
				
				lv1_dc_ac_p01_sum = 0;
				lv1_dc_ac_p02_sum = 0;
				lv1_dc_ac_p03_sum = 0;
				lv1_dc_ac_p04_sum = 0;
				lv1_dc_ac_p05_sum = 0;
				lv1_dc_ac_p06_sum = 0;
				lv1_dc_ac_p07_sum = 0;
				lv1_dc_ac_p08_sum = 0;
				lv1_dc_ac_p09_sum = 0;
				lv1_dc_ac_p10_sum = 0;
				lv1_dc_ac_p11_sum = 0;
				lv1_dc_ac_p12_sum = 0;
				lv1_dc_ac_q01_sum = 0;
				lv1_dc_ac_q02_sum = 0;
				lv1_dc_ac_q03_sum = 0;
				lv1_dc_ac_q04_sum = 0;
				lv1_dc_ac_h01_sum = 0;
				lv1_dc_ac_h02_sum = 0;
				lv1_dc_ac_ytd_sum = 0;

				lv1_dc_for_p01_sum = 0;
				lv1_dc_for_p02_sum = 0;
				lv1_dc_for_p03_sum = 0;
				lv1_dc_for_p04_sum = 0;
				lv1_dc_for_p05_sum = 0;
				lv1_dc_for_p06_sum = 0;
				lv1_dc_for_p07_sum = 0;
				lv1_dc_for_p08_sum = 0;
				lv1_dc_for_p09_sum = 0;
				lv1_dc_for_p10_sum = 0;
				lv1_dc_for_p11_sum = 0;
				lv1_dc_for_p12_sum = 0;
				lv1_dc_for_q01_sum = 0;
				lv1_dc_for_q02_sum = 0;
				lv1_dc_for_q03_sum = 0;
				lv1_dc_for_q04_sum = 0;
				lv1_dc_for_h01_sum = 0;
				lv1_dc_for_h02_sum = 0;
				lv1_dc_for_ytd_sum = 0;
				                      
				lv1_dc_out_p01_sum = 0;
				lv1_dc_out_p02_sum = 0;
				lv1_dc_out_p03_sum = 0;
				lv1_dc_out_p04_sum = 0;
				lv1_dc_out_p05_sum = 0;
				lv1_dc_out_p06_sum = 0;
				lv1_dc_out_p07_sum = 0;
				lv1_dc_out_p08_sum = 0;
				lv1_dc_out_p09_sum = 0;
				lv1_dc_out_p10_sum = 0;
				lv1_dc_out_p11_sum = 0;
				lv1_dc_out_p12_sum = 0;
				lv1_dc_out_q01_sum = 0;
				lv1_dc_out_q02_sum = 0;
				lv1_dc_out_q03_sum = 0;
				lv1_dc_out_q04_sum = 0;
				lv1_dc_out_h01_sum = 0;
				lv1_dc_out_h02_sum = 0;
				lv1_dc_out_ytd_sum = 0;

				lv1_dc_tg_p01_sum = 0;
				lv1_dc_tg_p02_sum = 0;
				lv1_dc_tg_p03_sum = 0;
				lv1_dc_tg_p04_sum = 0;
				lv1_dc_tg_p05_sum = 0;
				lv1_dc_tg_p06_sum = 0;
				lv1_dc_tg_p07_sum = 0;
				lv1_dc_tg_p08_sum = 0;
				lv1_dc_tg_p09_sum = 0;
				lv1_dc_tg_p10_sum = 0;
				lv1_dc_tg_p11_sum = 0;
				lv1_dc_tg_p12_sum = 0;
				lv1_dc_tg_q01_sum = 0;
				lv1_dc_tg_q02_sum = 0;
				lv1_dc_tg_q03_sum = 0;
				lv1_dc_tg_q04_sum = 0;
				lv1_dc_tg_h01_sum = 0;
				lv1_dc_tg_h02_sum = 0;
				lv1_dc_tg_ytd_sum = 0;
			}
			else {
				dcForeCastMap = new HashMap();
				
				dcForeCastMap.put("DATALV1_NM", (String)list.get(i-1).get("DATALV1_NM"));
				dcForeCastMap.put("DATALV2", "SUM");
				dcForeCastMap.put("DATALV2_NM", (String)list.get(i-1).get("DATALV1_NM")+" 합계");

				dcForeCastMap.put("DC_AC_P01", lv1_dc_ac_p01_sum);
				dcForeCastMap.put("DC_AC_P02", lv1_dc_ac_p02_sum);
				dcForeCastMap.put("DC_AC_P03", lv1_dc_ac_p03_sum);
				dcForeCastMap.put("DC_AC_P04", lv1_dc_ac_p04_sum);
				dcForeCastMap.put("DC_AC_P05", lv1_dc_ac_p05_sum);
				dcForeCastMap.put("DC_AC_P06", lv1_dc_ac_p06_sum);
				dcForeCastMap.put("DC_AC_P07", lv1_dc_ac_p07_sum);
				dcForeCastMap.put("DC_AC_P08", lv1_dc_ac_p08_sum);
				dcForeCastMap.put("DC_AC_P09", lv1_dc_ac_p09_sum);
				dcForeCastMap.put("DC_AC_P10", lv1_dc_ac_p10_sum);
				dcForeCastMap.put("DC_AC_P11", lv1_dc_ac_p11_sum);
				dcForeCastMap.put("DC_AC_P12", lv1_dc_ac_p12_sum);
				dcForeCastMap.put("DC_AC_Q01", lv1_dc_ac_q01_sum);
				dcForeCastMap.put("DC_AC_Q02", lv1_dc_ac_q02_sum);
				dcForeCastMap.put("DC_AC_Q03", lv1_dc_ac_q03_sum);
				dcForeCastMap.put("DC_AC_Q04", lv1_dc_ac_q04_sum);
				dcForeCastMap.put("DC_AC_H01", lv1_dc_ac_h01_sum);
				dcForeCastMap.put("DC_AC_H02", lv1_dc_ac_h02_sum);
				dcForeCastMap.put("DC_AC_YTD", lv1_dc_ac_ytd_sum);

				dcForeCastMap.put("DC_FOR_P01", lv1_dc_for_p01_sum);
				dcForeCastMap.put("DC_FOR_P02", lv1_dc_for_p02_sum);
				dcForeCastMap.put("DC_FOR_P03", lv1_dc_for_p03_sum);
				dcForeCastMap.put("DC_FOR_P04", lv1_dc_for_p04_sum);
				dcForeCastMap.put("DC_FOR_P05", lv1_dc_for_p05_sum);
				dcForeCastMap.put("DC_FOR_P06", lv1_dc_for_p06_sum);
				dcForeCastMap.put("DC_FOR_P07", lv1_dc_for_p07_sum);
				dcForeCastMap.put("DC_FOR_P08", lv1_dc_for_p08_sum);
				dcForeCastMap.put("DC_FOR_P09", lv1_dc_for_p09_sum);
				dcForeCastMap.put("DC_FOR_P10", lv1_dc_for_p10_sum);
				dcForeCastMap.put("DC_FOR_P11", lv1_dc_for_p11_sum);
				dcForeCastMap.put("DC_FOR_P12", lv1_dc_for_p12_sum);
				dcForeCastMap.put("DC_FOR_Q01", lv1_dc_for_q01_sum);
				dcForeCastMap.put("DC_FOR_Q02", lv1_dc_for_q02_sum);
				dcForeCastMap.put("DC_FOR_Q03", lv1_dc_for_q03_sum);
				dcForeCastMap.put("DC_FOR_Q04", lv1_dc_for_q04_sum);
				dcForeCastMap.put("DC_FOR_H01", lv1_dc_for_h01_sum);
				dcForeCastMap.put("DC_FOR_H02", lv1_dc_for_h02_sum);
				dcForeCastMap.put("DC_FOR_YTD", lv1_dc_for_ytd_sum);
				                                   
				dcForeCastMap.put("DC_OUT_P01", lv1_dc_out_p01_sum);
				dcForeCastMap.put("DC_OUT_P02", lv1_dc_out_p02_sum);
				dcForeCastMap.put("DC_OUT_P03", lv1_dc_out_p03_sum);
				dcForeCastMap.put("DC_OUT_P04", lv1_dc_out_p04_sum);
				dcForeCastMap.put("DC_OUT_P05", lv1_dc_out_p05_sum);
				dcForeCastMap.put("DC_OUT_P06", lv1_dc_out_p06_sum);
				dcForeCastMap.put("DC_OUT_P07", lv1_dc_out_p07_sum);
				dcForeCastMap.put("DC_OUT_P08", lv1_dc_out_p08_sum);
				dcForeCastMap.put("DC_OUT_P09", lv1_dc_out_p09_sum);
				dcForeCastMap.put("DC_OUT_P10", lv1_dc_out_p10_sum);
				dcForeCastMap.put("DC_OUT_P11", lv1_dc_out_p11_sum);
				dcForeCastMap.put("DC_OUT_P12", lv1_dc_out_p12_sum);
				dcForeCastMap.put("DC_OUT_Q01", lv1_dc_out_q01_sum);
				dcForeCastMap.put("DC_OUT_Q02", lv1_dc_out_q02_sum);
				dcForeCastMap.put("DC_OUT_Q03", lv1_dc_out_q03_sum);
				dcForeCastMap.put("DC_OUT_Q04", lv1_dc_out_q04_sum);
				dcForeCastMap.put("DC_OUT_H01", lv1_dc_out_h01_sum);
				dcForeCastMap.put("DC_OUT_H02", lv1_dc_out_h02_sum);
				dcForeCastMap.put("DC_OUT_YTD", lv1_dc_out_ytd_sum);
				                                   
				dcForeCastMap.put("DC_TG_P01", lv1_dc_tg_p01_sum);
				dcForeCastMap.put("DC_TG_P02", lv1_dc_tg_p02_sum);
				dcForeCastMap.put("DC_TG_P03", lv1_dc_tg_p03_sum);
				dcForeCastMap.put("DC_TG_P04", lv1_dc_tg_p04_sum);
				dcForeCastMap.put("DC_TG_P05", lv1_dc_tg_p05_sum);
				dcForeCastMap.put("DC_TG_P06", lv1_dc_tg_p06_sum);
				dcForeCastMap.put("DC_TG_P07", lv1_dc_tg_p07_sum);
				dcForeCastMap.put("DC_TG_P08", lv1_dc_tg_p08_sum);
				dcForeCastMap.put("DC_TG_P09", lv1_dc_tg_p09_sum);
				dcForeCastMap.put("DC_TG_P10", lv1_dc_tg_p10_sum);
				dcForeCastMap.put("DC_TG_P11", lv1_dc_tg_p11_sum);
				dcForeCastMap.put("DC_TG_P12", lv1_dc_tg_p12_sum);
				dcForeCastMap.put("DC_TG_Q01", lv1_dc_tg_q01_sum);
				dcForeCastMap.put("DC_TG_Q02", lv1_dc_tg_q02_sum);
				dcForeCastMap.put("DC_TG_Q03", lv1_dc_tg_q03_sum);
				dcForeCastMap.put("DC_TG_Q04", lv1_dc_tg_q04_sum);
				dcForeCastMap.put("DC_TG_H01", lv1_dc_tg_h01_sum);
				dcForeCastMap.put("DC_TG_H02", lv1_dc_tg_h02_sum);
				dcForeCastMap.put("DC_TG_YTD", lv1_dc_tg_ytd_sum);
				
				dcForeCast.add(dcForeCastMap);
				
				lv1_dc_ac_p01_sum = 0;
				lv1_dc_ac_p02_sum = 0;
				lv1_dc_ac_p03_sum = 0;
				lv1_dc_ac_p04_sum = 0;
				lv1_dc_ac_p05_sum = 0;
				lv1_dc_ac_p06_sum = 0;
				lv1_dc_ac_p07_sum = 0;
				lv1_dc_ac_p08_sum = 0;
				lv1_dc_ac_p09_sum = 0;
				lv1_dc_ac_p10_sum = 0;
				lv1_dc_ac_p11_sum = 0;
				lv1_dc_ac_p12_sum = 0;
				lv1_dc_ac_q01_sum = 0;
				lv1_dc_ac_q02_sum = 0;
				lv1_dc_ac_q03_sum = 0;
				lv1_dc_ac_q04_sum = 0;
				lv1_dc_ac_h01_sum = 0;
				lv1_dc_ac_h02_sum = 0;
				lv1_dc_ac_ytd_sum = 0;

				lv1_dc_for_p01_sum = 0;
				lv1_dc_for_p02_sum = 0;
				lv1_dc_for_p03_sum = 0;
				lv1_dc_for_p04_sum = 0;
				lv1_dc_for_p05_sum = 0;
				lv1_dc_for_p06_sum = 0;
				lv1_dc_for_p07_sum = 0;
				lv1_dc_for_p08_sum = 0;
				lv1_dc_for_p09_sum = 0;
				lv1_dc_for_p10_sum = 0;
				lv1_dc_for_p11_sum = 0;
				lv1_dc_for_p12_sum = 0;
				lv1_dc_for_q01_sum = 0;
				lv1_dc_for_q02_sum = 0;
				lv1_dc_for_q03_sum = 0;
				lv1_dc_for_q04_sum = 0;
				lv1_dc_for_h01_sum = 0;
				lv1_dc_for_h02_sum = 0;
				lv1_dc_for_ytd_sum = 0;
				                      
				lv1_dc_out_p01_sum = 0;
				lv1_dc_out_p02_sum = 0;
				lv1_dc_out_p03_sum = 0;
				lv1_dc_out_p04_sum = 0;
				lv1_dc_out_p05_sum = 0;
				lv1_dc_out_p06_sum = 0;
				lv1_dc_out_p07_sum = 0;
				lv1_dc_out_p08_sum = 0;
				lv1_dc_out_p09_sum = 0;
				lv1_dc_out_p10_sum = 0;
				lv1_dc_out_p11_sum = 0;
				lv1_dc_out_p12_sum = 0;
				lv1_dc_out_q01_sum = 0;
				lv1_dc_out_q02_sum = 0;
				lv1_dc_out_q03_sum = 0;
				lv1_dc_out_q04_sum = 0;
				lv1_dc_out_h01_sum = 0;
				lv1_dc_out_h02_sum = 0;
				lv1_dc_out_ytd_sum = 0;

				lv1_dc_tg_p01_sum = 0;
				lv1_dc_tg_p02_sum = 0;
				lv1_dc_tg_p03_sum = 0;
				lv1_dc_tg_p04_sum = 0;
				lv1_dc_tg_p05_sum = 0;
				lv1_dc_tg_p06_sum = 0;
				lv1_dc_tg_p07_sum = 0;
				lv1_dc_tg_p08_sum = 0;
				lv1_dc_tg_p09_sum = 0;
				lv1_dc_tg_p10_sum = 0;
				lv1_dc_tg_p11_sum = 0;
				lv1_dc_tg_p12_sum = 0;
				lv1_dc_tg_q01_sum = 0;
				lv1_dc_tg_q02_sum = 0;
				lv1_dc_tg_q03_sum = 0;
				lv1_dc_tg_q04_sum = 0;
				lv1_dc_tg_h01_sum = 0;
				lv1_dc_tg_h02_sum = 0;
				lv1_dc_tg_ytd_sum = 0;
				
				dcForeCastMap = new HashMap();
				
				dcForeCastMap.put("DATALV1", (String)list.get(i).get("DATALV1_NM"));
				dcForeCastMap.put("DATALV1_NM", (String)list.get(i).get("DATALV1_NM"));
				dcForeCastMap.put("DATALV2", (String)list.get(i).get("DATALV2_NM"));
				dcForeCastMap.put("DATALV2_NM", (String)list.get(i).get("DATALV2_NM"));
				dcForeCastMap.put("DC_AC_P01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P01")))/1000));
				dcForeCastMap.put("DC_AC_P02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P02")))/1000));
				dcForeCastMap.put("DC_AC_P03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P03")))/1000));
				dcForeCastMap.put("DC_AC_P04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P04")))/1000));
				dcForeCastMap.put("DC_AC_P05", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P05")))/1000));
				dcForeCastMap.put("DC_AC_P06", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P06")))/1000));
				dcForeCastMap.put("DC_AC_P07", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P07")))/1000));
				dcForeCastMap.put("DC_AC_P08", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P08")))/1000));
				dcForeCastMap.put("DC_AC_P09", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P09")))/1000));
				dcForeCastMap.put("DC_AC_P10", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P10")))/1000));
				dcForeCastMap.put("DC_AC_P11", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P11")))/1000));
				dcForeCastMap.put("DC_AC_P12", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P12")))/1000));
				dcForeCastMap.put("DC_AC_Q01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q1")))/1000));
				dcForeCastMap.put("DC_AC_Q02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q2")))/1000));
				dcForeCastMap.put("DC_AC_Q03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q3")))/1000));
				dcForeCastMap.put("DC_AC_Q04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q4")))/1000));
				dcForeCastMap.put("DC_AC_H01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H1")))/1000));
				dcForeCastMap.put("DC_AC_H02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H2")))/1000));
				dcForeCastMap.put("DC_AC_YTD", (Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_YTD")))/1000));
				dcForeCastMap.put("DC_FOR_P01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P01")))));
				dcForeCastMap.put("DC_FOR_P02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P02")))));
				dcForeCastMap.put("DC_FOR_P03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P03")))));
				dcForeCastMap.put("DC_FOR_P04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P04")))));
				dcForeCastMap.put("DC_FOR_P05", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P05")))));
				dcForeCastMap.put("DC_FOR_P06", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P06")))));
				dcForeCastMap.put("DC_FOR_P07", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P07")))));
				dcForeCastMap.put("DC_FOR_P08", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P08")))));
				dcForeCastMap.put("DC_FOR_P09", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P09")))));
				dcForeCastMap.put("DC_FOR_P10", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P10")))));
				dcForeCastMap.put("DC_FOR_P11", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P11")))));
				dcForeCastMap.put("DC_FOR_P12", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P12")))));
				dcForeCastMap.put("DC_FOR_Q01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q1")))));
				dcForeCastMap.put("DC_FOR_Q02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q2")))));
				dcForeCastMap.put("DC_FOR_Q03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q3")))));
				dcForeCastMap.put("DC_FOR_Q04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q4")))));
				dcForeCastMap.put("DC_FOR_H01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H1")))));
				dcForeCastMap.put("DC_FOR_H02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H2")))));
				dcForeCastMap.put("DC_FOR_YTD", (Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_YTD")))));
				dcForeCastMap.put("DC_OUT_P01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P01")))));
				dcForeCastMap.put("DC_OUT_P02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P02")))));
				dcForeCastMap.put("DC_OUT_P03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P03")))));
				dcForeCastMap.put("DC_OUT_P04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P04")))));
				dcForeCastMap.put("DC_OUT_P05", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P05")))));
				dcForeCastMap.put("DC_OUT_P06", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P06")))));
				dcForeCastMap.put("DC_OUT_P07", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P07")))));
				dcForeCastMap.put("DC_OUT_P08", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P08")))));
				dcForeCastMap.put("DC_OUT_P09", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P09")))));
				dcForeCastMap.put("DC_OUT_P10", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P10")))));
				dcForeCastMap.put("DC_OUT_P11", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P11")))));
				dcForeCastMap.put("DC_OUT_P12", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P12")))));
				dcForeCastMap.put("DC_OUT_Q01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q1")))));
				dcForeCastMap.put("DC_OUT_Q02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q2")))));
				dcForeCastMap.put("DC_OUT_Q03", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q3")))));
				dcForeCastMap.put("DC_OUT_Q04", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q4")))));
				dcForeCastMap.put("DC_OUT_H01", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H1")))));
				dcForeCastMap.put("DC_OUT_H02", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H2")))));
				dcForeCastMap.put("DC_OUT_YTD", (Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_YTD")))));
				dcForeCastMap.put("DC_TG_P01", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P01"))));
				dcForeCastMap.put("DC_TG_P02", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P02"))));
				dcForeCastMap.put("DC_TG_P03", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P03"))));
				dcForeCastMap.put("DC_TG_P04", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P04"))));
				dcForeCastMap.put("DC_TG_P05", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P05"))));
				dcForeCastMap.put("DC_TG_P06", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P06"))));
				dcForeCastMap.put("DC_TG_P07", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P07"))));
				dcForeCastMap.put("DC_TG_P08", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P08"))));
				dcForeCastMap.put("DC_TG_P09", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P09"))));
				dcForeCastMap.put("DC_TG_P10", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P10"))));
				dcForeCastMap.put("DC_TG_P11", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P11"))));
				dcForeCastMap.put("DC_TG_P12", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P12"))));
				dcForeCastMap.put("DC_TG_Q01", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q1"))));
				dcForeCastMap.put("DC_TG_Q02", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q2"))));
				dcForeCastMap.put("DC_TG_Q03", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q3"))));
				dcForeCastMap.put("DC_TG_Q04", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q4"))));
				dcForeCastMap.put("DC_TG_H01", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H1"))));
				dcForeCastMap.put("DC_TG_H02", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H2"))));
				dcForeCastMap.put("DC_TG_YTD", Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_YTD"))));
				
				dcForeCast.add(dcForeCastMap);
				
				dataLv1 = (String)list.get(i).get("DATALV1_NM");
				
				lv1_dc_ac_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P01")))/1000;
				lv1_dc_ac_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P02")))/1000;
				lv1_dc_ac_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P03")))/1000;
				lv1_dc_ac_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P04")))/1000;
				lv1_dc_ac_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P05")))/1000;
				lv1_dc_ac_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P06")))/1000;
				lv1_dc_ac_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P07")))/1000;
				lv1_dc_ac_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P08")))/1000;
				lv1_dc_ac_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P09")))/1000;
				lv1_dc_ac_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P10")))/1000;
				lv1_dc_ac_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P11")))/1000;
				lv1_dc_ac_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_P12")))/1000;
				lv1_dc_ac_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q1")))/1000;
				lv1_dc_ac_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q2")))/1000;
				lv1_dc_ac_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q3")))/1000;
				lv1_dc_ac_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_Q4")))/1000;
				lv1_dc_ac_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H1")))/1000;
				lv1_dc_ac_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_H2")))/1000;
				lv1_dc_ac_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_AC_YTD")))/1000;

				lv1_dc_for_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P01")));
				lv1_dc_for_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P02")));
				lv1_dc_for_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P03")));
				lv1_dc_for_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P04")));
				lv1_dc_for_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P05")));
				lv1_dc_for_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P06")));
				lv1_dc_for_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P07")));
				lv1_dc_for_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P08")));
				lv1_dc_for_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P09")));
				lv1_dc_for_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P10")));
				lv1_dc_for_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P11")));
				lv1_dc_for_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_P12")));
				lv1_dc_for_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q1")));
				lv1_dc_for_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q2")));
				lv1_dc_for_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q3")));
				lv1_dc_for_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_Q4")));
				lv1_dc_for_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H1")));
				lv1_dc_for_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_H2")));
				lv1_dc_for_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_FOR_YTD")));

				lv1_dc_out_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P01")));
				lv1_dc_out_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P02")));
				lv1_dc_out_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P03")));
				lv1_dc_out_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P04")));
				lv1_dc_out_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P05")));
				lv1_dc_out_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P06")));
				lv1_dc_out_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P07")));
				lv1_dc_out_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P08")));
				lv1_dc_out_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P09")));
				lv1_dc_out_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P10")));
				lv1_dc_out_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P11")));
				lv1_dc_out_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_P12")));
				lv1_dc_out_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q1")));
				lv1_dc_out_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q2")));
				lv1_dc_out_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q3")));
				lv1_dc_out_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_Q4")));
				lv1_dc_out_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H1")));
				lv1_dc_out_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_H2")));
				lv1_dc_out_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_OUT_YTD")));

				lv1_dc_tg_p01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P01")));
				lv1_dc_tg_p02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P02")));
				lv1_dc_tg_p03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P03")));
				lv1_dc_tg_p04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P04")));
				lv1_dc_tg_p05_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P05")));
				lv1_dc_tg_p06_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P06")));
				lv1_dc_tg_p07_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P07")));
				lv1_dc_tg_p08_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P08")));
				lv1_dc_tg_p09_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P09")));
				lv1_dc_tg_p10_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P10")));
				lv1_dc_tg_p11_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P11")));
				lv1_dc_tg_p12_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_P12")));
				lv1_dc_tg_q01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q1")));
				lv1_dc_tg_q02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q2")));
				lv1_dc_tg_q03_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q3")));
				lv1_dc_tg_q04_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_Q4")));
				lv1_dc_tg_h01_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H1")));
				lv1_dc_tg_h02_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_H2")));
				lv1_dc_tg_ytd_sum += Double.parseDouble(String.valueOf(list.get(i).get("DC_TG_YTD")));
			}
		}
		
		String dataLv2 = null;
		String checkData = "";
		int checkRow = dcForeCast.size();
		for(int i=0; i<checkRow/2; i++) {
			dataLv2 = (String)dcForeCast.get(i).get("DATALV2");
			for(int j=dcForeCast.size()/2; j<(checkRow); j++) {
				if(i != j && !checkData.equals(dataLv2)) {
					if(dataLv2.equals(dcForeCast.get(j).get("DATALV2"))) {
						dcForeCastMap = new HashMap();
						
						if(j == checkRow-1) {
							dcForeCastMap.put("DATALV1", "Total W.S DC %");
							dcForeCastMap.put("DATALV1_NM", "Total W.S DC %");
							dcForeCastMap.put("DATALV2", 0);
							dcForeCastMap.put("DATALV2_NM", "Total W.S DC %");
						}
						else {
							dcForeCastMap.put("DATALV1", "Total W.S DC %");
							dcForeCastMap.put("DATALV1_NM", "Total W.S DC %");
							dcForeCastMap.put("DATALV2", (String)list.get(i).get("DATALV2_NM"));
							dcForeCastMap.put("DATALV2_NM", (String)list.get(i).get("DATALV2_NM"));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P01"))) == 0) {
							dcForeCastMap.put("DC_AC_P01", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P02"))) == 0) {
							dcForeCastMap.put("DC_AC_P02", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P03"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P03"))) == 0) {
							dcForeCastMap.put("DC_AC_P03", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P03", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P03")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P03"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P04"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P04"))) == 0) {
							dcForeCastMap.put("DC_AC_P04", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P04", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P04")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P04"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P05"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P05"))) == 0) {
							dcForeCastMap.put("DC_AC_P05", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P05", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P05")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P05"))));
						}
					
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P06"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P06"))) == 0) {
							dcForeCastMap.put("DC_AC_P06", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P06", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P06")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P06"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P07"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P07"))) == 0) {
							dcForeCastMap.put("DC_AC_P07", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P07", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P07")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P07"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P08"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P08"))) == 0) {
							dcForeCastMap.put("DC_AC_P08", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P08", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P08")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P08"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P09"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P09"))) == 0) {
							dcForeCastMap.put("DC_AC_P09", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P09", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P09")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P09"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P10"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P10"))) == 0) {
							dcForeCastMap.put("DC_AC_P10", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P10", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P10")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P10"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P11"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P11"))) == 0) {
							dcForeCastMap.put("DC_AC_P11", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P11", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P11")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P11"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P12"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P12"))) == 0) {
							dcForeCastMap.put("DC_AC_P12", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_P12", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_P12")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_P12"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_Q01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_Q01"))) == 0) {
							dcForeCastMap.put("DC_AC_Q01", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_Q01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_Q01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_Q01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_Q02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_Q02"))) == 0) {
							dcForeCastMap.put("DC_AC_Q02", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_Q02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_Q02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_Q02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_Q03"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_Q03"))) == 0) {
							dcForeCastMap.put("DC_AC_Q03", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_Q03", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_Q03")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_Q03"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_Q04"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_Q04"))) == 0) {
							dcForeCastMap.put("DC_AC_Q04", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_Q04", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_Q04")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_Q04"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_H01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_H01"))) == 0) {
							dcForeCastMap.put("DC_AC_H01", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_H01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_H01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_H01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_H02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_H02"))) == 0) {
							dcForeCastMap.put("DC_AC_H02", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_H02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_H02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_H02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_YTD"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_YTD"))) == 0) {
							dcForeCastMap.put("DC_AC_YTD", 0);
						}
						else {
							dcForeCastMap.put("DC_AC_YTD", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_AC_YTD")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_AC_YTD"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P01"))) == 0) {
							dcForeCastMap.put("DC_FOR_P01", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P02"))) == 0) {
							dcForeCastMap.put("DC_FOR_P02", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P03"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P03"))) == 0) {
							dcForeCastMap.put("DC_FOR_P03", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P03", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P03")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P03"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P04"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P04"))) == 0) {
							dcForeCastMap.put("DC_FOR_P04", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P04", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P04")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P04"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P05"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P05"))) == 0) {
							dcForeCastMap.put("DC_FOR_P05", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P05", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P05")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P05"))));
						}
					
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P06"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P06"))) == 0) {
							dcForeCastMap.put("DC_FOR_P06", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P06", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P06")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P06"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P07"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P07"))) == 0) {
							dcForeCastMap.put("DC_FOR_P07", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P07", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P07")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P07"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P08"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P08"))) == 0) {
							dcForeCastMap.put("DC_FOR_P08", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P08", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P08")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P08"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P09"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P09"))) == 0) {
							dcForeCastMap.put("DC_FOR_P09", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P09", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P09")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P09"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P10"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P10"))) == 0) {
							dcForeCastMap.put("DC_FOR_P10", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P10", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P10")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P10"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P11"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P11"))) == 0) {
							dcForeCastMap.put("DC_FOR_P11", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P11", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P11")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P11"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P12"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P12"))) == 0) {
							dcForeCastMap.put("DC_FOR_P12", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_P12", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_P12")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_P12"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_Q01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_Q01"))) == 0) {
							dcForeCastMap.put("DC_FOR_Q01", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_Q01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_Q01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_Q01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_Q02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_Q02"))) == 0) {
							dcForeCastMap.put("DC_FOR_Q02", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_Q02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_Q02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_Q02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_Q03"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_Q03"))) == 0) {
							dcForeCastMap.put("DC_FOR_Q03", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_Q03", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_Q03")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_Q03"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_Q04"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_Q04"))) == 0) {
							dcForeCastMap.put("DC_FOR_Q04", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_Q04", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_Q04")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_Q04"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_H01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_H01"))) == 0) {
							dcForeCastMap.put("DC_FOR_H01", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_H01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_H01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_H01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_H02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_H02"))) == 0) {
							dcForeCastMap.put("DC_FOR_H02", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_H02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_H02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_H02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_YTD"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_YTD"))) == 0) {
							dcForeCastMap.put("DC_FOR_YTD", 0);
						}
						else {
							dcForeCastMap.put("DC_FOR_YTD", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_FOR_YTD")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_FOR_YTD"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P01"))) == 0) {
							dcForeCastMap.put("DC_OUT_P01", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P02"))) == 0) {
							dcForeCastMap.put("DC_OUT_P02", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P03"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P03"))) == 0) {
							dcForeCastMap.put("DC_OUT_P03", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P03", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P03")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P03"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P04"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P04"))) == 0) {
							dcForeCastMap.put("DC_OUT_P04", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P04", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P04")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P04"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P05"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P05"))) == 0) {
							dcForeCastMap.put("DC_OUT_P05", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P05", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P05")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P05"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P06"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P06"))) == 0) {
							dcForeCastMap.put("DC_OUT_P06", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P06", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P06")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P06"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P07"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P07"))) == 0) {
							dcForeCastMap.put("DC_OUT_P07", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P07", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P07")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P07"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P08"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P08"))) == 0) {
							dcForeCastMap.put("DC_OUT_P08", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P08", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P08")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P08"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P09"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P09"))) == 0) {
							dcForeCastMap.put("DC_OUT_P09", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P09", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P09")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P09"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P10"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P10"))) == 0) {
							dcForeCastMap.put("DC_OUT_P10", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P10", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P10")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P10"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P11"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P11"))) == 0) {
							dcForeCastMap.put("DC_OUT_P11", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P11", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P11")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P11"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P12"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P12"))) == 0) {
							dcForeCastMap.put("DC_OUT_P12", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_P12", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_P12")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_P12"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_Q01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_Q01"))) == 0) {
							dcForeCastMap.put("DC_OUT_Q01", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_Q01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_Q01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_Q01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_Q02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_Q02"))) == 0) {
							dcForeCastMap.put("DC_OUT_Q02", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_Q02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_Q02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_Q02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_Q03"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_Q03"))) == 0) {
							dcForeCastMap.put("DC_OUT_Q03", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_Q03", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_Q03")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_Q03"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_Q04"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_Q04"))) == 0) {
							dcForeCastMap.put("DC_OUT_Q04", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_Q04", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_Q04")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_Q04"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_H01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_H01"))) == 0) {
							dcForeCastMap.put("DC_OUT_H01", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_H01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_H01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_H01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_H02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_H02"))) == 0) {
							dcForeCastMap.put("DC_OUT_H02", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_H02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_H02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_H02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_YTD"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_YTD"))) == 0) {
							dcForeCastMap.put("DC_OUT_YTD", 0);
						}
						else {
							dcForeCastMap.put("DC_OUT_YTD", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_OUT_YTD")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_OUT_YTD"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P01"))) == 0) {
							dcForeCastMap.put("DC_TG_P01", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P02"))) == 0) {
							dcForeCastMap.put("DC_TG_P02", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P03"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P03"))) == 0) {
							dcForeCastMap.put("DC_TG_P03", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P03", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P03")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P03"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P04"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P04"))) == 0) {
							dcForeCastMap.put("DC_TG_P04", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P04", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P04")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P04"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P05"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P05"))) == 0) {
							dcForeCastMap.put("DC_TG_P05", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P05", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P05")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P05"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P06"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P06"))) == 0) {
							dcForeCastMap.put("DC_TG_P06", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P06", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P06")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P06"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P07"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P07"))) == 0) {
							dcForeCastMap.put("DC_TG_P07", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P07", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P07")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P07"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P08"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P08"))) == 0) {
							dcForeCastMap.put("DC_TG_P08", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P08", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P08")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P08"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P09"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P09"))) == 0) {
							dcForeCastMap.put("DC_TG_P09", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P09", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P09")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P09"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P10"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P10"))) == 0) {
							dcForeCastMap.put("DC_TG_P10", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P10", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P10")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P10"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P11"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P11"))) == 0) {
							dcForeCastMap.put("DC_TG_P11", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P11", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P11")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P11"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P12"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P12"))) == 0) {
							dcForeCastMap.put("DC_TG_P12", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_P12", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_P12")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_P12"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_Q01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_Q01"))) == 0) {
							dcForeCastMap.put("DC_TG_Q01", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_Q01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_Q01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_Q01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_Q02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_Q02"))) == 0) {
							dcForeCastMap.put("DC_TG_Q02", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_Q02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_Q02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_Q02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_Q03"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_Q03"))) == 0) {
							dcForeCastMap.put("DC_TG_Q03", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_Q03", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_Q03")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_Q03"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_Q04"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_Q04"))) == 0) {
							dcForeCastMap.put("DC_TG_Q04", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_Q04", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_Q04")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_Q04"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_H01"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_H01"))) == 0) {
							dcForeCastMap.put("DC_TG_H01", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_H01", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_H01")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_H01"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_H02"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_H02"))) == 0) {
							dcForeCastMap.put("DC_TG_H02", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_H02", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_H02")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_H02"))));
						}
						
						if(Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_YTD"))) == 0 || Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_YTD"))) == 0) {
							dcForeCastMap.put("DC_TG_YTD", 0);
						}
						else {
							dcForeCastMap.put("DC_TG_YTD", Double.parseDouble(String.valueOf(dcForeCast.get(i).get("DC_TG_YTD")))/Double.parseDouble(String.valueOf(dcForeCast.get(j).get("DC_TG_YTD"))));
						}
						
						dcForeCast.add(dcForeCastMap);
						
						checkData = dataLv2;
					}
				}
			}
		}
		return dcForeCast;
	}
	
	//Total GsvList(DC 표 밑 빨간 글씨)
	public ArrayList<Map> dcGsvTotalList(ArrayList<Map> shList, ArrayList<Map>dcList, Map param) {
		
		ArrayList<Map> dcGsvList = new ArrayList<Map>();
		ArrayList<Map> dcGsvShList = new ArrayList<Map>();
		ArrayList<Map> dcGsvDcList = new ArrayList<Map>();
		Map dcGsvMap = null;
		
		double sh_ac_p01_sum = 0;
		double sh_ac_p02_sum = 0;
		double sh_ac_p03_sum = 0;
		double sh_ac_p04_sum = 0;
		double sh_ac_p05_sum = 0;
		double sh_ac_p06_sum = 0;
		double sh_ac_p07_sum = 0;
		double sh_ac_p08_sum = 0;
		double sh_ac_p09_sum = 0;
		double sh_ac_p10_sum = 0;
		double sh_ac_p11_sum = 0;
		double sh_ac_p12_sum = 0;
		double sh_ac_q01_sum = 0;
		double sh_ac_q02_sum = 0;
		double sh_ac_q03_sum = 0;
		double sh_ac_q04_sum = 0;
		double sh_ac_h01_sum = 0;
		double sh_ac_h02_sum = 0;
		double sh_ac_ytd_sum = 0;

		double sh_for_p01_sum = 0;
		double sh_for_p02_sum = 0;
		double sh_for_p03_sum = 0;
		double sh_for_p04_sum = 0;
		double sh_for_p05_sum = 0;
		double sh_for_p06_sum = 0;
		double sh_for_p07_sum = 0;
		double sh_for_p08_sum = 0;
		double sh_for_p09_sum = 0;
		double sh_for_p10_sum = 0;
		double sh_for_p11_sum = 0;
		double sh_for_p12_sum = 0;
		double sh_for_q01_sum = 0;
		double sh_for_q02_sum = 0;
		double sh_for_q03_sum = 0;
		double sh_for_q04_sum = 0;
		double sh_for_h01_sum = 0;
		double sh_for_h02_sum = 0;
		double sh_for_ytd_sum = 0;

		double sh_out_p01_sum = 0;
		double sh_out_p02_sum = 0;
		double sh_out_p03_sum = 0;
		double sh_out_p04_sum = 0;
		double sh_out_p05_sum = 0;
		double sh_out_p06_sum = 0;
		double sh_out_p07_sum = 0;
		double sh_out_p08_sum = 0;
		double sh_out_p09_sum = 0;
		double sh_out_p10_sum = 0;
		double sh_out_p11_sum = 0;
		double sh_out_p12_sum = 0;
		double sh_out_q01_sum = 0;
		double sh_out_q02_sum = 0;
		double sh_out_q03_sum = 0;
		double sh_out_q04_sum = 0;
		double sh_out_h01_sum = 0;
		double sh_out_h02_sum = 0;
		double sh_out_ytd_sum = 0;

		double sh_tg_p01_sum = 0;
		double sh_tg_p02_sum = 0;
		double sh_tg_p03_sum = 0;
		double sh_tg_p04_sum = 0;
		double sh_tg_p05_sum = 0;
		double sh_tg_p06_sum = 0;
		double sh_tg_p07_sum = 0;
		double sh_tg_p08_sum = 0;
		double sh_tg_p09_sum = 0;
		double sh_tg_p10_sum = 0;
		double sh_tg_p11_sum = 0;
		double sh_tg_p12_sum = 0;
		double sh_tg_q01_sum = 0;
		double sh_tg_q02_sum = 0;
		double sh_tg_q03_sum = 0;
		double sh_tg_q04_sum = 0;
		double sh_tg_h01_sum = 0;
		double sh_tg_h02_sum = 0;
		double sh_tg_ytd_sum = 0;
		
		double dc_ac_p01_sum = 0;
		double dc_ac_p02_sum = 0;
		double dc_ac_p03_sum = 0;
		double dc_ac_p04_sum = 0;
		double dc_ac_p05_sum = 0;
		double dc_ac_p06_sum = 0;
		double dc_ac_p07_sum = 0;
		double dc_ac_p08_sum = 0;
		double dc_ac_p09_sum = 0;
		double dc_ac_p10_sum = 0;
		double dc_ac_p11_sum = 0;
		double dc_ac_p12_sum = 0;
		double dc_ac_q01_sum = 0;
		double dc_ac_q02_sum = 0;
		double dc_ac_q03_sum = 0;
		double dc_ac_q04_sum = 0;
		double dc_ac_h01_sum = 0;
		double dc_ac_h02_sum = 0;
		double dc_ac_ytd_sum = 0;

		double dc_for_p01_sum = 0;
		double dc_for_p02_sum = 0;
		double dc_for_p03_sum = 0;
		double dc_for_p04_sum = 0;
		double dc_for_p05_sum = 0;
		double dc_for_p06_sum = 0;
		double dc_for_p07_sum = 0;
		double dc_for_p08_sum = 0;
		double dc_for_p09_sum = 0;
		double dc_for_p10_sum = 0;
		double dc_for_p11_sum = 0;
		double dc_for_p12_sum = 0;
		double dc_for_q01_sum = 0;
		double dc_for_q02_sum = 0;
		double dc_for_q03_sum = 0;
		double dc_for_q04_sum = 0;
		double dc_for_h01_sum = 0;
		double dc_for_h02_sum = 0;
		double dc_for_ytd_sum = 0;

		double dc_out_p01_sum = 0;
		double dc_out_p02_sum = 0;
		double dc_out_p03_sum = 0;
		double dc_out_p04_sum = 0;
		double dc_out_p05_sum = 0;
		double dc_out_p06_sum = 0;
		double dc_out_p07_sum = 0;
		double dc_out_p08_sum = 0;
		double dc_out_p09_sum = 0;
		double dc_out_p10_sum = 0;
		double dc_out_p11_sum = 0;
		double dc_out_p12_sum = 0;
		double dc_out_q01_sum = 0;
		double dc_out_q02_sum = 0;
		double dc_out_q03_sum = 0;
		double dc_out_q04_sum = 0;
		double dc_out_h01_sum = 0;
		double dc_out_h02_sum = 0;
		double dc_out_ytd_sum = 0;
		 
		double dc_tg_p01_sum = 0;
		double dc_tg_p02_sum = 0;
		double dc_tg_p03_sum = 0;
		double dc_tg_p04_sum = 0;
		double dc_tg_p05_sum = 0;
		double dc_tg_p06_sum = 0;
		double dc_tg_p07_sum = 0;
		double dc_tg_p08_sum = 0;
		double dc_tg_p09_sum = 0;
		double dc_tg_p10_sum = 0;
		double dc_tg_p11_sum = 0;
		double dc_tg_p12_sum = 0;
		double dc_tg_q01_sum = 0;
		double dc_tg_q02_sum = 0;
		double dc_tg_q03_sum = 0;
		double dc_tg_q04_sum = 0;
		double dc_tg_h01_sum = 0;
		double dc_tg_h02_sum = 0;
		double dc_tg_ytd_sum = 0;
		
		String dataLv1 = null;
		
		for(int i=0; i<shList.size(); i++) {
			if(i==0) {
				dataLv1 = (String)shList.get(i).get("DATALV1_NM");
			}
			
			if(dataLv1.equals(shList.get(i).get("DATALV1_NM")) && i != (shList.size()-1)) {
				dcGsvMap = new HashMap();
				sh_ac_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P01")));
				sh_ac_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P02")));
				sh_ac_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P03")));
				sh_ac_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P04")));
				sh_ac_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P05")));
				sh_ac_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P06")));
				sh_ac_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P07")));
				sh_ac_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P08")));
				sh_ac_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P09")));
				sh_ac_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P10")));
				sh_ac_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P11")));
				sh_ac_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P12")));
				sh_ac_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P03"))));
				sh_ac_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P06"))));
				sh_ac_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P09"))));
				sh_ac_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P12"))));
				sh_ac_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P06"))));
				sh_ac_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P12"))));
				sh_ac_ytd_sum += setAcYTD(param, shList.get(i), "SH");
				
				sh_for_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P01")));
				sh_for_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P02")));
				sh_for_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P03")));
				sh_for_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P04")));
				sh_for_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P05")));
				sh_for_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P06")));
				sh_for_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P07")));
				sh_for_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P08")));
				sh_for_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P09")));
				sh_for_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P10")));
				sh_for_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P11")));
				sh_for_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P12")));
				sh_for_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P03"))));
				sh_for_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P06"))));
				sh_for_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P09"))));
				sh_for_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P12"))));
				sh_for_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P06"))));
				sh_for_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P12"))));
				sh_for_ytd_sum += setForYTD(param, shList.get(i), "SH");
				
				sh_out_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P01")));
				sh_out_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P02")));
				sh_out_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P03")));
				sh_out_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P04")));
				sh_out_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P05")));
				sh_out_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P06")));
				sh_out_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P07")));
				sh_out_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P08")));
				sh_out_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P09")));
				sh_out_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P10")));
				sh_out_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P11")));
				sh_out_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P12")));
				sh_out_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P03"))));
				sh_out_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P06"))));
				sh_out_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P09"))));
				sh_out_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P12"))));
				sh_out_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P06"))));
				sh_out_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P12"))));
				sh_out_ytd_sum += setOutYTD(param, shList.get(i), "SH");
				
				sh_tg_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P01")));
				sh_tg_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P02")));
				sh_tg_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P03")));
				sh_tg_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P04")));
				sh_tg_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P05")));
				sh_tg_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P06")));
				sh_tg_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P07")));
				sh_tg_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08")));
				sh_tg_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P09")));
				sh_tg_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P10")));
				sh_tg_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P11")));
				sh_tg_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P12")));
				sh_tg_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P03"))));
				sh_tg_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08"))));
				sh_tg_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P09"))));
				sh_tg_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P12"))));
				sh_tg_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08"))));
				sh_tg_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P12"))));
				sh_tg_ytd_sum += setTgYTD(param, shList.get(i), "SH");
				
				dcGsvMap = new HashMap();
				
				dcGsvMap.put("DATALV1_NM", "Total GSV");
				dcGsvMap.put("DATALV2_NM", shList.get(i).get("DATALV1_NM"));
				dcGsvMap.put("SH_AC_P01", sh_ac_p01_sum);
				dcGsvMap.put("SH_AC_P02", sh_ac_p02_sum);
				dcGsvMap.put("SH_AC_P03", sh_ac_p03_sum);
				dcGsvMap.put("SH_AC_P04", sh_ac_p04_sum);
				dcGsvMap.put("SH_AC_P05", sh_ac_p05_sum);
				dcGsvMap.put("SH_AC_P06", sh_ac_p06_sum);
				dcGsvMap.put("SH_AC_P07", sh_ac_p07_sum);
				dcGsvMap.put("SH_AC_P08", sh_ac_p08_sum);
				dcGsvMap.put("SH_AC_P09", sh_ac_p09_sum);
				dcGsvMap.put("SH_AC_P10", sh_ac_p10_sum);
				dcGsvMap.put("SH_AC_P11", sh_ac_p11_sum);
				dcGsvMap.put("SH_AC_P12", sh_ac_p12_sum);
				dcGsvMap.put("SH_AC_Q01", sh_ac_q01_sum);
				dcGsvMap.put("SH_AC_Q02", sh_ac_q02_sum);
				dcGsvMap.put("SH_AC_Q03", sh_ac_q03_sum);
				dcGsvMap.put("SH_AC_Q04", sh_ac_q04_sum);
				dcGsvMap.put("SH_AC_H01", sh_ac_h01_sum);
				dcGsvMap.put("SH_AC_H02", sh_ac_h02_sum);
				dcGsvMap.put("SH_AC_YTD", sh_ac_ytd_sum);

				dcGsvMap.put("SH_FOR_P01", sh_for_p01_sum);
				dcGsvMap.put("SH_FOR_P02", sh_for_p02_sum);
				dcGsvMap.put("SH_FOR_P03", sh_for_p03_sum);
				dcGsvMap.put("SH_FOR_P04", sh_for_p04_sum);
				dcGsvMap.put("SH_FOR_P05", sh_for_p05_sum);
				dcGsvMap.put("SH_FOR_P06", sh_for_p06_sum);
				dcGsvMap.put("SH_FOR_P07", sh_for_p07_sum);
				dcGsvMap.put("SH_FOR_P08", sh_for_p08_sum);
				dcGsvMap.put("SH_FOR_P09", sh_for_p09_sum);
				dcGsvMap.put("SH_FOR_P10", sh_for_p10_sum);
				dcGsvMap.put("SH_FOR_P11", sh_for_p11_sum);
				dcGsvMap.put("SH_FOR_P12", sh_for_p12_sum);
				dcGsvMap.put("SH_FOR_Q01", sh_for_q01_sum);
				dcGsvMap.put("SH_FOR_Q02", sh_for_q02_sum);
				dcGsvMap.put("SH_FOR_Q03", sh_for_q03_sum);
				dcGsvMap.put("SH_FOR_Q04", sh_for_q04_sum);
				dcGsvMap.put("SH_FOR_H01", sh_for_h01_sum);
				dcGsvMap.put("SH_FOR_H02", sh_for_h02_sum);
				dcGsvMap.put("SH_FOR_YTD", sh_for_ytd_sum);

				dcGsvMap.put("SH_OUT_P01", sh_out_p01_sum);
				dcGsvMap.put("SH_OUT_P02", sh_out_p02_sum);
				dcGsvMap.put("SH_OUT_P03", sh_out_p03_sum);
				dcGsvMap.put("SH_OUT_P04", sh_out_p04_sum);
				dcGsvMap.put("SH_OUT_P05", sh_out_p05_sum);
				dcGsvMap.put("SH_OUT_P06", sh_out_p06_sum);
				dcGsvMap.put("SH_OUT_P07", sh_out_p07_sum);
				dcGsvMap.put("SH_OUT_P08", sh_out_p08_sum);
				dcGsvMap.put("SH_OUT_P09", sh_out_p09_sum);
				dcGsvMap.put("SH_OUT_P10", sh_out_p10_sum);
				dcGsvMap.put("SH_OUT_P11", sh_out_p11_sum);
				dcGsvMap.put("SH_OUT_P12", sh_out_p12_sum);
				dcGsvMap.put("SH_OUT_Q01", sh_out_q01_sum);
				dcGsvMap.put("SH_OUT_Q02", sh_out_q02_sum);
				dcGsvMap.put("SH_OUT_Q03", sh_out_q03_sum);
				dcGsvMap.put("SH_OUT_Q04", sh_out_q04_sum);
				dcGsvMap.put("SH_OUT_H01", sh_out_h01_sum);
				dcGsvMap.put("SH_OUT_H02", sh_out_h02_sum);
				dcGsvMap.put("SH_OUT_YTD", sh_out_ytd_sum);

				dcGsvMap.put("SH_TG_P01", sh_tg_p01_sum);
				dcGsvMap.put("SH_TG_P02", sh_tg_p02_sum);
				dcGsvMap.put("SH_TG_P03", sh_tg_p03_sum);
				dcGsvMap.put("SH_TG_P04", sh_tg_p04_sum);
				dcGsvMap.put("SH_TG_P05", sh_tg_p05_sum);
				dcGsvMap.put("SH_TG_P06", sh_tg_p06_sum);
				dcGsvMap.put("SH_TG_P07", sh_tg_p07_sum);
				dcGsvMap.put("SH_TG_P08", sh_tg_p08_sum);
				dcGsvMap.put("SH_TG_P09", sh_tg_p09_sum);
				dcGsvMap.put("SH_TG_P10", sh_tg_p10_sum);
				dcGsvMap.put("SH_TG_P11", sh_tg_p11_sum);
				dcGsvMap.put("SH_TG_P12", sh_tg_p12_sum);
				dcGsvMap.put("SH_TG_Q01", sh_tg_q01_sum);
				dcGsvMap.put("SH_TG_Q02", sh_tg_q02_sum);
				dcGsvMap.put("SH_TG_Q03", sh_tg_q03_sum);
				dcGsvMap.put("SH_TG_Q04", sh_tg_q04_sum);
				dcGsvMap.put("SH_TG_H01", sh_tg_h01_sum);
				dcGsvMap.put("SH_TG_H02", sh_tg_h02_sum);
				dcGsvMap.put("SH_TG_YTD", sh_tg_ytd_sum);
				
			}
			else if(i == (shList.size()-1)) {
				dcGsvMap = new HashMap();
				sh_ac_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P01")));
				sh_ac_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P02")));
				sh_ac_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P03")));
				sh_ac_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P04")));
				sh_ac_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P05")));
				sh_ac_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P06")));
				sh_ac_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P07")));
				sh_ac_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P08")));
				sh_ac_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P09")));
				sh_ac_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P10")));
				sh_ac_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P11")));
				sh_ac_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P12")));
				sh_ac_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P03"))));
				sh_ac_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P06"))));
				sh_ac_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P09"))));
				sh_ac_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P12"))));
				sh_ac_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P06"))));
				sh_ac_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P12"))));
				sh_ac_ytd_sum += setAcYTD(param, shList.get(i), "SH");
				
				sh_for_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P01")));
				sh_for_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P02")));
				sh_for_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P03")));
				sh_for_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P04")));
				sh_for_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P05")));
				sh_for_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P06")));
				sh_for_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P07")));
				sh_for_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P08")));
				sh_for_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P09")));
				sh_for_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P10")));
				sh_for_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P11")));
				sh_for_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P12")));
				sh_for_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P03"))));
				sh_for_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P06"))));
				sh_for_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P09"))));
				sh_for_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P12"))));
				sh_for_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P06"))));
				sh_for_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P12"))));
				sh_for_ytd_sum += setForYTD(param, shList.get(i), "SH");
				
				sh_out_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P01")));
				sh_out_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P02")));
				sh_out_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P03")));
				sh_out_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P04")));
				sh_out_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P05")));
				sh_out_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P06")));
				sh_out_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P07")));
				sh_out_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P08")));
				sh_out_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P09")));
				sh_out_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P10")));
				sh_out_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P11")));
				sh_out_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P12")));
				sh_out_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P03"))));
				sh_out_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P06"))));
				sh_out_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P09"))));
				sh_out_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P12"))));
				sh_out_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P06"))));
				sh_out_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P12"))));
				sh_out_ytd_sum += setOutYTD(param, shList.get(i), "SH");
				
				sh_tg_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P01")));
				sh_tg_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P02")));
				sh_tg_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P03")));
				sh_tg_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P04")));
				sh_tg_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P05")));
				sh_tg_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P06")));
				sh_tg_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P07")));
				sh_tg_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08")));
				sh_tg_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P09")));
				sh_tg_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P10")));
				sh_tg_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P11")));
				sh_tg_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P12")));
				sh_tg_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P03"))));
				sh_tg_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08"))));
				sh_tg_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P09"))));
				sh_tg_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P12"))));
				sh_tg_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08"))));
				sh_tg_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P12"))));
				sh_tg_ytd_sum += setTgYTD(param, shList.get(i), "SH");
				
				dcGsvMap = new HashMap();
				
				dcGsvMap.put("DATALV1_NM", "Total GSV");
				dcGsvMap.put("DATALV2_NM", shList.get(i).get("DATALV1_NM"));
				dcGsvMap.put("SH_AC_P01", sh_ac_p01_sum);
				dcGsvMap.put("SH_AC_P02", sh_ac_p02_sum);
				dcGsvMap.put("SH_AC_P03", sh_ac_p03_sum);
				dcGsvMap.put("SH_AC_P04", sh_ac_p04_sum);
				dcGsvMap.put("SH_AC_P05", sh_ac_p05_sum);
				dcGsvMap.put("SH_AC_P06", sh_ac_p06_sum);
				dcGsvMap.put("SH_AC_P07", sh_ac_p07_sum);
				dcGsvMap.put("SH_AC_P08", sh_ac_p08_sum);
				dcGsvMap.put("SH_AC_P09", sh_ac_p09_sum);
				dcGsvMap.put("SH_AC_P10", sh_ac_p10_sum);
				dcGsvMap.put("SH_AC_P11", sh_ac_p11_sum);
				dcGsvMap.put("SH_AC_P12", sh_ac_p12_sum);
				dcGsvMap.put("SH_AC_Q01", sh_ac_q01_sum);
				dcGsvMap.put("SH_AC_Q02", sh_ac_q02_sum);
				dcGsvMap.put("SH_AC_Q03", sh_ac_q03_sum);
				dcGsvMap.put("SH_AC_Q04", sh_ac_q04_sum);
				dcGsvMap.put("SH_AC_H01", sh_ac_h01_sum);
				dcGsvMap.put("SH_AC_H02", sh_ac_h02_sum);
				dcGsvMap.put("SH_AC_YTD", sh_ac_ytd_sum);

				dcGsvMap.put("SH_FOR_P01", sh_for_p01_sum);
				dcGsvMap.put("SH_FOR_P02", sh_for_p02_sum);
				dcGsvMap.put("SH_FOR_P03", sh_for_p03_sum);
				dcGsvMap.put("SH_FOR_P04", sh_for_p04_sum);
				dcGsvMap.put("SH_FOR_P05", sh_for_p05_sum);
				dcGsvMap.put("SH_FOR_P06", sh_for_p06_sum);
				dcGsvMap.put("SH_FOR_P07", sh_for_p07_sum);
				dcGsvMap.put("SH_FOR_P08", sh_for_p08_sum);
				dcGsvMap.put("SH_FOR_P09", sh_for_p09_sum);
				dcGsvMap.put("SH_FOR_P10", sh_for_p10_sum);
				dcGsvMap.put("SH_FOR_P11", sh_for_p11_sum);
				dcGsvMap.put("SH_FOR_P12", sh_for_p12_sum);
				dcGsvMap.put("SH_FOR_Q01", sh_for_q01_sum);
				dcGsvMap.put("SH_FOR_Q02", sh_for_q02_sum);
				dcGsvMap.put("SH_FOR_Q03", sh_for_q03_sum);
				dcGsvMap.put("SH_FOR_Q04", sh_for_q04_sum);
				dcGsvMap.put("SH_FOR_H01", sh_for_h01_sum);
				dcGsvMap.put("SH_FOR_H02", sh_for_h02_sum);
				dcGsvMap.put("SH_FOR_YTD", sh_for_ytd_sum);

				dcGsvMap.put("SH_OUT_P01", sh_out_p01_sum);
				dcGsvMap.put("SH_OUT_P02", sh_out_p02_sum);
				dcGsvMap.put("SH_OUT_P03", sh_out_p03_sum);
				dcGsvMap.put("SH_OUT_P04", sh_out_p04_sum);
				dcGsvMap.put("SH_OUT_P05", sh_out_p05_sum);
				dcGsvMap.put("SH_OUT_P06", sh_out_p06_sum);
				dcGsvMap.put("SH_OUT_P07", sh_out_p07_sum);
				dcGsvMap.put("SH_OUT_P08", sh_out_p08_sum);
				dcGsvMap.put("SH_OUT_P09", sh_out_p09_sum);
				dcGsvMap.put("SH_OUT_P10", sh_out_p10_sum);
				dcGsvMap.put("SH_OUT_P11", sh_out_p11_sum);
				dcGsvMap.put("SH_OUT_P12", sh_out_p12_sum);
				dcGsvMap.put("SH_OUT_Q01", sh_out_q01_sum);
				dcGsvMap.put("SH_OUT_Q02", sh_out_q02_sum);
				dcGsvMap.put("SH_OUT_Q03", sh_out_q03_sum);
				dcGsvMap.put("SH_OUT_Q04", sh_out_q04_sum);
				dcGsvMap.put("SH_OUT_H01", sh_out_h01_sum);
				dcGsvMap.put("SH_OUT_H02", sh_out_h02_sum);
				dcGsvMap.put("SH_OUT_YTD", sh_out_ytd_sum);

				dcGsvMap.put("SH_TG_P01", sh_tg_p01_sum);
				dcGsvMap.put("SH_TG_P02", sh_tg_p02_sum);
				dcGsvMap.put("SH_TG_P03", sh_tg_p03_sum);
				dcGsvMap.put("SH_TG_P04", sh_tg_p04_sum);
				dcGsvMap.put("SH_TG_P05", sh_tg_p05_sum);
				dcGsvMap.put("SH_TG_P06", sh_tg_p06_sum);
				dcGsvMap.put("SH_TG_P07", sh_tg_p07_sum);
				dcGsvMap.put("SH_TG_P08", sh_tg_p08_sum);
				dcGsvMap.put("SH_TG_P09", sh_tg_p09_sum);
				dcGsvMap.put("SH_TG_P10", sh_tg_p10_sum);
				dcGsvMap.put("SH_TG_P11", sh_tg_p11_sum);
				dcGsvMap.put("SH_TG_P12", sh_tg_p12_sum);
				dcGsvMap.put("SH_TG_Q01", sh_tg_q01_sum);
				dcGsvMap.put("SH_TG_Q02", sh_tg_q02_sum);
				dcGsvMap.put("SH_TG_Q03", sh_tg_q03_sum);
				dcGsvMap.put("SH_TG_Q04", sh_tg_q04_sum);
				dcGsvMap.put("SH_TG_H01", sh_tg_h01_sum);
				dcGsvMap.put("SH_TG_H02", sh_tg_h02_sum);
				dcGsvMap.put("SH_TG_YTD", sh_tg_ytd_sum);
				
				
				dcGsvShList.add(dcGsvMap);
			}
			else {
				dcGsvShList.add(dcGsvMap);
				
				dataLv1 = (String)shList.get(i).get("DATALV1_NM");
				sh_ac_p01_sum = 0;
				sh_ac_p02_sum = 0;
				sh_ac_p03_sum = 0;
				sh_ac_p04_sum = 0;
				sh_ac_p05_sum = 0;
				sh_ac_p06_sum = 0;
				sh_ac_p07_sum = 0;
				sh_ac_p08_sum = 0;
				sh_ac_p09_sum = 0;
				sh_ac_p10_sum = 0;
				sh_ac_p11_sum = 0;
				sh_ac_p12_sum = 0;
				sh_ac_q01_sum = 0;
				sh_ac_q02_sum = 0;
				sh_ac_q03_sum = 0;
				sh_ac_q04_sum = 0;
				sh_ac_h01_sum = 0;
				sh_ac_h02_sum = 0;
				sh_ac_ytd_sum = 0;

				sh_for_p01_sum = 0;
				sh_for_p02_sum = 0;
				sh_for_p03_sum = 0;
				sh_for_p04_sum = 0;
				sh_for_p05_sum = 0;
				sh_for_p06_sum = 0;
				sh_for_p07_sum = 0;
				sh_for_p08_sum = 0;
				sh_for_p09_sum = 0;
				sh_for_p10_sum = 0;
				sh_for_p11_sum = 0;
				sh_for_p12_sum = 0;
				sh_for_q01_sum = 0;
				sh_for_q02_sum = 0;
				sh_for_q03_sum = 0;
				sh_for_q04_sum = 0;
				sh_for_h01_sum = 0;
				sh_for_h02_sum = 0;
				sh_for_ytd_sum = 0;

				sh_out_p01_sum = 0;
				sh_out_p02_sum = 0;
				sh_out_p03_sum = 0;
				sh_out_p04_sum = 0;
				sh_out_p05_sum = 0;
				sh_out_p06_sum = 0;
				sh_out_p07_sum = 0;
				sh_out_p08_sum = 0;
				sh_out_p09_sum = 0;
				sh_out_p10_sum = 0;
				sh_out_p11_sum = 0;
				sh_out_p12_sum = 0;
				sh_out_q01_sum = 0;
				sh_out_q02_sum = 0;
				sh_out_q03_sum = 0;
				sh_out_q04_sum = 0;
				sh_out_h01_sum = 0;
				sh_out_h02_sum = 0;
				sh_out_ytd_sum = 0;

				sh_tg_p01_sum = 0;
				sh_tg_p02_sum = 0;
				sh_tg_p03_sum = 0;
				sh_tg_p04_sum = 0;
				sh_tg_p05_sum = 0;
				sh_tg_p06_sum = 0;
				sh_tg_p07_sum = 0;
				sh_tg_p08_sum = 0;
				sh_tg_p09_sum = 0;
				sh_tg_p10_sum = 0;
				sh_tg_p11_sum = 0;
				sh_tg_p12_sum = 0;
				sh_tg_q01_sum = 0;
				sh_tg_q02_sum = 0;
				sh_tg_q03_sum = 0;
				sh_tg_q04_sum = 0;
				sh_tg_h01_sum = 0;
				sh_tg_h02_sum = 0;
				sh_tg_ytd_sum = 0;
				
				sh_ac_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P01")));
				sh_ac_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P02")));
				sh_ac_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P03")));
				sh_ac_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P04")));
				sh_ac_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P05")));
				sh_ac_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P06")));
				sh_ac_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P07")));
				sh_ac_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P08")));
				sh_ac_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P09")));
				sh_ac_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P10")));
				sh_ac_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P11")));
				sh_ac_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P12")));
				sh_ac_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P03"))));
				sh_ac_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P06"))));
				sh_ac_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P09"))));
				sh_ac_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P12"))));
				sh_ac_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P03"))))
						+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P06"))));
				sh_ac_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P09"))))
						+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_AC_P12"))));
				sh_ac_ytd_sum += setAcYTD(param, shList.get(i), "SH");
				
				sh_for_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P01")));
				sh_for_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P02")));
				sh_for_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P03")));
				sh_for_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P04")));
				sh_for_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P05")));
				sh_for_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P06")));
				sh_for_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P07")));
				sh_for_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P08")));
				sh_for_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P09")));
				sh_for_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P10")));
				sh_for_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P11")));
				sh_for_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P12")));
				sh_for_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P03"))));
				sh_for_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P06"))));
				sh_for_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P09"))));
				sh_for_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P12"))));
				sh_for_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P06"))));
				sh_for_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_FOR_P12"))));
				sh_for_ytd_sum += setForYTD(param, shList.get(i), "SH");
				
				sh_out_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P01")));
				sh_out_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P02")));
				sh_out_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P03")));
				sh_out_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P04")));
				sh_out_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P05")));
				sh_out_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P06")));
				sh_out_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P07")));
				sh_out_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P08")));
				sh_out_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P09")));
				sh_out_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P10")));
				sh_out_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P11")));
				sh_out_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P12")));
				sh_out_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P03"))));
				sh_out_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P06"))));
				sh_out_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P09"))));
				sh_out_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P12"))));
				sh_out_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P06"))));
				sh_out_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_OUT_P12"))));
				sh_out_ytd_sum += setOutYTD(param, shList.get(i), "SH");
				
				sh_tg_p01_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P01")));
				sh_tg_p02_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P02")));
				sh_tg_p03_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P03")));
				sh_tg_p04_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P04")));
				sh_tg_p05_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P05")));
				sh_tg_p06_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P06")));
				sh_tg_p07_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P07")));
				sh_tg_p08_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08")));
				sh_tg_p09_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P09")));
				sh_tg_p10_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P10")));
				sh_tg_p11_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P11")));
				sh_tg_p12_sum += Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P12")));
				sh_tg_q01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P03"))));
				sh_tg_q02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08"))));
				sh_tg_q03_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P09"))));
				sh_tg_q04_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P12"))));
				sh_tg_h01_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P01")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P02")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P03"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P04")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P05")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08"))));
				sh_tg_h02_sum += (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P07")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P08")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P09"))))
										+ (Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P10")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P11")))+Double.parseDouble(String.valueOf(shList.get(i).get("SH_TG_P12"))));
				sh_tg_ytd_sum += setTgYTD(param, shList.get(i), "SH");
				
				dcGsvMap = new HashMap();
				
				dcGsvMap.put("DATALV1_NM", "Total GSV");
				dcGsvMap.put("DATALV2_NM", shList.get(i).get("DATALV1_NM"));
				dcGsvMap.put("SH_AC_P01", sh_ac_p01_sum);
				dcGsvMap.put("SH_AC_P02", sh_ac_p02_sum);
				dcGsvMap.put("SH_AC_P03", sh_ac_p03_sum);
				dcGsvMap.put("SH_AC_P04", sh_ac_p04_sum);
				dcGsvMap.put("SH_AC_P05", sh_ac_p05_sum);
				dcGsvMap.put("SH_AC_P06", sh_ac_p06_sum);
				dcGsvMap.put("SH_AC_P07", sh_ac_p07_sum);
				dcGsvMap.put("SH_AC_P08", sh_ac_p08_sum);
				dcGsvMap.put("SH_AC_P09", sh_ac_p09_sum);
				dcGsvMap.put("SH_AC_P10", sh_ac_p10_sum);
				dcGsvMap.put("SH_AC_P11", sh_ac_p11_sum);
				dcGsvMap.put("SH_AC_P12", sh_ac_p12_sum);
				dcGsvMap.put("SH_AC_Q01", sh_ac_q01_sum);
				dcGsvMap.put("SH_AC_Q02", sh_ac_q02_sum);
				dcGsvMap.put("SH_AC_Q03", sh_ac_q03_sum);
				dcGsvMap.put("SH_AC_Q04", sh_ac_q04_sum);
				dcGsvMap.put("SH_AC_H01", sh_ac_h01_sum);
				dcGsvMap.put("SH_AC_H02", sh_ac_h02_sum);
				dcGsvMap.put("SH_AC_YTD", sh_ac_ytd_sum);

				dcGsvMap.put("SH_FOR_P01", sh_for_p01_sum);
				dcGsvMap.put("SH_FOR_P02", sh_for_p02_sum);
				dcGsvMap.put("SH_FOR_P03", sh_for_p03_sum);
				dcGsvMap.put("SH_FOR_P04", sh_for_p04_sum);
				dcGsvMap.put("SH_FOR_P05", sh_for_p05_sum);
				dcGsvMap.put("SH_FOR_P06", sh_for_p06_sum);
				dcGsvMap.put("SH_FOR_P07", sh_for_p07_sum);
				dcGsvMap.put("SH_FOR_P08", sh_for_p08_sum);
				dcGsvMap.put("SH_FOR_P09", sh_for_p09_sum);
				dcGsvMap.put("SH_FOR_P10", sh_for_p10_sum);
				dcGsvMap.put("SH_FOR_P11", sh_for_p11_sum);
				dcGsvMap.put("SH_FOR_P12", sh_for_p12_sum);
				dcGsvMap.put("SH_FOR_Q01", sh_for_q01_sum);
				dcGsvMap.put("SH_FOR_Q02", sh_for_q02_sum);
				dcGsvMap.put("SH_FOR_Q03", sh_for_q03_sum);
				dcGsvMap.put("SH_FOR_Q04", sh_for_q04_sum);
				dcGsvMap.put("SH_FOR_H01", sh_for_h01_sum);
				dcGsvMap.put("SH_FOR_H02", sh_for_h02_sum);
				dcGsvMap.put("SH_FOR_YTD", sh_for_ytd_sum);

				dcGsvMap.put("SH_OUT_P01", sh_out_p01_sum);
				dcGsvMap.put("SH_OUT_P02", sh_out_p02_sum);
				dcGsvMap.put("SH_OUT_P03", sh_out_p03_sum);
				dcGsvMap.put("SH_OUT_P04", sh_out_p04_sum);
				dcGsvMap.put("SH_OUT_P05", sh_out_p05_sum);
				dcGsvMap.put("SH_OUT_P06", sh_out_p06_sum);
				dcGsvMap.put("SH_OUT_P07", sh_out_p07_sum);
				dcGsvMap.put("SH_OUT_P08", sh_out_p08_sum);
				dcGsvMap.put("SH_OUT_P09", sh_out_p09_sum);
				dcGsvMap.put("SH_OUT_P10", sh_out_p10_sum);
				dcGsvMap.put("SH_OUT_P11", sh_out_p11_sum);
				dcGsvMap.put("SH_OUT_P12", sh_out_p12_sum);
				dcGsvMap.put("SH_OUT_Q01", sh_out_q01_sum);
				dcGsvMap.put("SH_OUT_Q02", sh_out_q02_sum);
				dcGsvMap.put("SH_OUT_Q03", sh_out_q03_sum);
				dcGsvMap.put("SH_OUT_Q04", sh_out_q04_sum);
				dcGsvMap.put("SH_OUT_H01", sh_out_h01_sum);
				dcGsvMap.put("SH_OUT_H02", sh_out_h02_sum);
				dcGsvMap.put("SH_OUT_YTD", sh_out_ytd_sum);

				dcGsvMap.put("SH_TG_P01", sh_tg_p01_sum);
				dcGsvMap.put("SH_TG_P02", sh_tg_p02_sum);
				dcGsvMap.put("SH_TG_P03", sh_tg_p03_sum);
				dcGsvMap.put("SH_TG_P04", sh_tg_p04_sum);
				dcGsvMap.put("SH_TG_P05", sh_tg_p05_sum);
				dcGsvMap.put("SH_TG_P06", sh_tg_p06_sum);
				dcGsvMap.put("SH_TG_P07", sh_tg_p07_sum);
				dcGsvMap.put("SH_TG_P08", sh_tg_p08_sum);
				dcGsvMap.put("SH_TG_P09", sh_tg_p09_sum);
				dcGsvMap.put("SH_TG_P10", sh_tg_p10_sum);
				dcGsvMap.put("SH_TG_P11", sh_tg_p11_sum);
				dcGsvMap.put("SH_TG_P12", sh_tg_p12_sum);
				dcGsvMap.put("SH_TG_Q01", sh_tg_q01_sum);
				dcGsvMap.put("SH_TG_Q02", sh_tg_q02_sum);
				dcGsvMap.put("SH_TG_Q03", sh_tg_q03_sum);
				dcGsvMap.put("SH_TG_Q04", sh_tg_q04_sum);
				dcGsvMap.put("SH_TG_H01", sh_tg_h01_sum);
				dcGsvMap.put("SH_TG_H02", sh_tg_h02_sum);
				dcGsvMap.put("SH_TG_YTD", sh_tg_ytd_sum);
			}
			
		}
		
		String dcDataLv1 = null;
		for(int i = 0; i<dcList.size(); i++) {
			if(i==0) {
				dcDataLv1 = (String)dcList.get(i).get("DATALV1_NM");
			}
			
			if(!dcDataLv1.equals(dcList.get(i).get("DATALV1_NM"))) {
				dcGsvMap = new HashMap();
				dc_ac_p01_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P01")));
				dc_ac_p02_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P02")));
				dc_ac_p03_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P03")));
				dc_ac_p04_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P04")));
				dc_ac_p05_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P05")));
				dc_ac_p06_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P06")));
				dc_ac_p07_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P07")));
				dc_ac_p08_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P08")));
				dc_ac_p09_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P09")));
				dc_ac_p10_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P10")));
				dc_ac_p11_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P11")));
				dc_ac_p12_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P12")));
				dc_ac_q01_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P01")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P02")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P03"))));
				dc_ac_q02_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P04")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P05")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P06"))));
				dc_ac_q03_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P07")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P08")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P09"))));
				dc_ac_q04_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P10")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P11")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P12"))));
				dc_ac_h01_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P01")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P02")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P03"))))
										+ (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P04")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P05")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P06"))));
				dc_ac_h02_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P07")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P08")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P09"))))
										+ (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P10")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P11")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_AC_P12"))));
				dc_ac_ytd_sum += setAcYTD(param, dcList.get(i), "DC");
				
				dc_for_p01_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P01")));
				dc_for_p02_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P02")));
				dc_for_p03_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P03")));
				dc_for_p04_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P04")));
				dc_for_p05_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P05")));
				dc_for_p06_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P06")));
				dc_for_p07_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P07")));
				dc_for_p08_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P08")));
				dc_for_p09_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P09")));
				dc_for_p10_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P10")));
				dc_for_p11_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P11")));
				dc_for_p12_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P12")));
				dc_for_q01_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P01")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P02")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P03"))));
				dc_for_q02_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P04")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P05")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P06"))));
				dc_for_q03_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P07")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P08")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P09"))));
				dc_for_q04_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P10")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P11")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P12"))));
				dc_for_h01_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P01")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P02")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P03"))))
										+ (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P04")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P05")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P06"))));
				dc_for_h02_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P07")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P08")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P09"))))
										+ (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P10")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P11")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_FOR_P12"))));
				dc_for_ytd_sum += setForYTD(param, dcList.get(i), "DC");
				
				dc_out_p01_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P01")));
				dc_out_p02_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P02")));
				dc_out_p03_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P03")));
				dc_out_p04_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P04")));
				dc_out_p05_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P05")));
				dc_out_p06_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P06")));
				dc_out_p07_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P07")));
				dc_out_p08_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P08")));
				dc_out_p09_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P09")));
				dc_out_p10_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P10")));
				dc_out_p11_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P11")));
				dc_out_p12_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P12")));
				dc_out_q01_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P01")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P02")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P03"))));
				dc_out_q02_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P04")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P05")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P06"))));
				dc_out_q03_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P07")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P08")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P09"))));
				dc_out_q04_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P10")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P11")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P12"))));
				dc_out_h01_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P01")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P02")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P03"))))
										+ (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P04")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P05")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P06"))));
				dc_out_h02_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P07")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P08")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P09"))))
										+ (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P10")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P11")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_OUT_P12"))));
				dc_out_ytd_sum += setOutYTD(param, dcList.get(i), "DC");
				
				dc_tg_p01_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P01")));
				dc_tg_p02_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P02")));
				dc_tg_p03_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P03")));
				dc_tg_p04_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P04")));
				dc_tg_p05_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P05")));
				dc_tg_p06_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P06")));
				dc_tg_p07_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P07")));
				dc_tg_p08_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P08")));
				dc_tg_p09_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P09")));
				dc_tg_p10_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P10")));
				dc_tg_p11_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P11")));
				dc_tg_p12_sum += Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P12")));
				dc_tg_q01_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P01")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P02")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P03"))));
				dc_tg_q02_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P04")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P05")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P06"))));
				dc_tg_q03_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P07")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P08")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P09"))));
				dc_tg_q04_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P10")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P11")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P12"))));
				dc_tg_h01_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P01")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P02")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P03"))))
										+ (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P04")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P05")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P06"))));
				dc_tg_h02_sum += (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P07")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P08")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P09"))))
										+ (Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P10")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P11")))+Double.parseDouble(String.valueOf(dcList.get(i).get("DC_TG_P12"))));
				dc_tg_ytd_sum += setTgYTD(param, dcList.get(i), "DC");
				
				dcGsvMap.put("DATALV1_NM", "Total Gsv");
				dcGsvMap.put("DATALV2_NM", dcList.get(i).get("DATALV1_NM"));
				dcGsvMap.put("DC_AC_P01", dc_ac_p01_sum);
				dcGsvMap.put("DC_AC_P02", dc_ac_p02_sum);
				dcGsvMap.put("DC_AC_P03", dc_ac_p03_sum);
				dcGsvMap.put("DC_AC_P04", dc_ac_p04_sum);
				dcGsvMap.put("DC_AC_P05", dc_ac_p05_sum);
				dcGsvMap.put("DC_AC_P06", dc_ac_p06_sum);
				dcGsvMap.put("DC_AC_P07", dc_ac_p07_sum);
				dcGsvMap.put("DC_AC_P08", dc_ac_p08_sum);
				dcGsvMap.put("DC_AC_P09", dc_ac_p09_sum);
				dcGsvMap.put("DC_AC_P10", dc_ac_p10_sum);
				dcGsvMap.put("DC_AC_P11", dc_ac_p11_sum);
				dcGsvMap.put("DC_AC_P12", dc_ac_p12_sum);
				dcGsvMap.put("DC_AC_Q01", dc_ac_q01_sum);
				dcGsvMap.put("DC_AC_Q02", dc_ac_q02_sum);
				dcGsvMap.put("DC_AC_Q03", dc_ac_q03_sum);
				dcGsvMap.put("DC_AC_Q04", dc_ac_q04_sum);
				dcGsvMap.put("DC_AC_H01", dc_ac_h01_sum);
				dcGsvMap.put("DC_AC_H02", dc_ac_h02_sum);
				dcGsvMap.put("DC_AC_YTD", dc_ac_ytd_sum);

				dcGsvMap.put("DC_FOR_P01", dc_for_p01_sum);
				dcGsvMap.put("DC_FOR_P02", dc_for_p02_sum);
				dcGsvMap.put("DC_FOR_P03", dc_for_p03_sum);
				dcGsvMap.put("DC_FOR_P04", dc_for_p04_sum);
				dcGsvMap.put("DC_FOR_P05", dc_for_p05_sum);
				dcGsvMap.put("DC_FOR_P06", dc_for_p06_sum);
				dcGsvMap.put("DC_FOR_P07", dc_for_p07_sum);
				dcGsvMap.put("DC_FOR_P08", dc_for_p08_sum);
				dcGsvMap.put("DC_FOR_P09", dc_for_p09_sum);
				dcGsvMap.put("DC_FOR_P10", dc_for_p10_sum);
				dcGsvMap.put("DC_FOR_P11", dc_for_p11_sum);
				dcGsvMap.put("DC_FOR_P12", dc_for_p12_sum);
				dcGsvMap.put("DC_FOR_Q01", dc_for_q01_sum);
				dcGsvMap.put("DC_FOR_Q02", dc_for_q02_sum);
				dcGsvMap.put("DC_FOR_Q03", dc_for_q03_sum);
				dcGsvMap.put("DC_FOR_Q04", dc_for_q04_sum);
				dcGsvMap.put("DC_FOR_H01", dc_for_h01_sum);
				dcGsvMap.put("DC_FOR_H02", dc_for_h02_sum);
				dcGsvMap.put("DC_FOR_YTD", dc_for_ytd_sum);

				dcGsvMap.put("DC_OUT_P01", dc_out_p01_sum);
				dcGsvMap.put("DC_OUT_P02", dc_out_p02_sum);
				dcGsvMap.put("DC_OUT_P03", dc_out_p03_sum);
				dcGsvMap.put("DC_OUT_P04", dc_out_p04_sum);
				dcGsvMap.put("DC_OUT_P05", dc_out_p05_sum);
				dcGsvMap.put("DC_OUT_P06", dc_out_p06_sum);
				dcGsvMap.put("DC_OUT_P07", dc_out_p07_sum);
				dcGsvMap.put("DC_OUT_P08", dc_out_p08_sum);
				dcGsvMap.put("DC_OUT_P09", dc_out_p09_sum);
				dcGsvMap.put("DC_OUT_P10", dc_out_p10_sum);
				dcGsvMap.put("DC_OUT_P11", dc_out_p11_sum);
				dcGsvMap.put("DC_OUT_P12", dc_out_p12_sum);
				dcGsvMap.put("DC_OUT_Q01", dc_out_q01_sum);
				dcGsvMap.put("DC_OUT_Q02", dc_out_q02_sum);
				dcGsvMap.put("DC_OUT_Q03", dc_out_q03_sum);
				dcGsvMap.put("DC_OUT_Q04", dc_out_q04_sum);
				dcGsvMap.put("DC_OUT_H01", dc_out_h01_sum);
				dcGsvMap.put("DC_OUT_H02", dc_out_h02_sum);
				dcGsvMap.put("DC_OUT_YTD", dc_out_ytd_sum);

				dcGsvMap.put("DC_TG_P01", dc_tg_p01_sum);
				dcGsvMap.put("DC_TG_P02", dc_tg_p02_sum);
				dcGsvMap.put("DC_TG_P03", dc_tg_p03_sum);
				dcGsvMap.put("DC_TG_P04", dc_tg_p04_sum);
				dcGsvMap.put("DC_TG_P05", dc_tg_p05_sum);
				dcGsvMap.put("DC_TG_P06", dc_tg_p06_sum);
				dcGsvMap.put("DC_TG_P07", dc_tg_p07_sum);
				dcGsvMap.put("DC_TG_P08", dc_tg_p08_sum);
				dcGsvMap.put("DC_TG_P09", dc_tg_p09_sum);
				dcGsvMap.put("DC_TG_P10", dc_tg_p10_sum);
				dcGsvMap.put("DC_TG_P11", dc_tg_p11_sum);
				dcGsvMap.put("DC_TG_P12", dc_tg_p12_sum);
				dcGsvMap.put("DC_TG_Q01", dc_tg_q01_sum);
				dcGsvMap.put("DC_TG_Q02", dc_tg_q02_sum);
				dcGsvMap.put("DC_TG_Q03", dc_tg_q03_sum);
				dcGsvMap.put("DC_TG_Q04", dc_tg_q04_sum);
				dcGsvMap.put("DC_TG_H01", dc_tg_h01_sum);
				dcGsvMap.put("DC_TG_H02", dc_tg_h02_sum);
				dcGsvMap.put("DC_TG_YTD", dc_tg_ytd_sum);
				
				dcGsvDcList.add(dcGsvMap);
			}
			dc_ac_p01_sum = 0;
			dc_ac_p02_sum = 0;
			dc_ac_p03_sum = 0;
			dc_ac_p04_sum = 0;
			dc_ac_p05_sum = 0;
			dc_ac_p06_sum = 0;
			dc_ac_p07_sum = 0;
			dc_ac_p08_sum = 0;
			dc_ac_p09_sum = 0;
			dc_ac_p10_sum = 0;
			dc_ac_p11_sum = 0;
			dc_ac_p12_sum = 0;
			dc_ac_q01_sum = 0;
			dc_ac_q02_sum = 0;
			dc_ac_q03_sum = 0;
			dc_ac_q04_sum = 0;
			dc_ac_h01_sum = 0;
			dc_ac_h02_sum = 0;
			dc_ac_ytd_sum = 0;

			dc_for_p01_sum = 0;
			dc_for_p02_sum = 0;
			dc_for_p03_sum = 0;
			dc_for_p04_sum = 0;
			dc_for_p05_sum = 0;
			dc_for_p06_sum = 0;
			dc_for_p07_sum = 0;
			dc_for_p08_sum = 0;
			dc_for_p09_sum = 0;
			dc_for_p10_sum = 0;
			dc_for_p11_sum = 0;
			dc_for_p12_sum = 0;
			dc_for_q01_sum = 0;
			dc_for_q02_sum = 0;
			dc_for_q03_sum = 0;
			dc_for_q04_sum = 0;
			dc_for_h01_sum = 0;
			dc_for_h02_sum = 0;
			dc_for_ytd_sum = 0;
		    
			dc_out_p01_sum = 0;
			dc_out_p02_sum = 0;
			dc_out_p03_sum = 0;
			dc_out_p04_sum = 0;
			dc_out_p05_sum = 0;
			dc_out_p06_sum = 0;
			dc_out_p07_sum = 0;
			dc_out_p08_sum = 0;
			dc_out_p09_sum = 0;
			dc_out_p10_sum = 0;
			dc_out_p11_sum = 0;
			dc_out_p12_sum = 0;
			dc_out_q01_sum = 0;
			dc_out_q02_sum = 0;
			dc_out_q03_sum = 0;
			dc_out_q04_sum = 0;
			dc_out_h01_sum = 0;
			dc_out_h02_sum = 0;
			dc_out_ytd_sum = 0;
		    
			dc_tg_p01_sum = 0;
			dc_tg_p02_sum = 0;
			dc_tg_p03_sum = 0;
			dc_tg_p04_sum = 0;
			dc_tg_p05_sum = 0;
			dc_tg_p06_sum = 0;
			dc_tg_p07_sum = 0;
			dc_tg_p08_sum = 0;
			dc_tg_p09_sum = 0;
			dc_tg_p10_sum = 0;
			dc_tg_p11_sum = 0;
			dc_tg_p12_sum = 0;
			dc_tg_q01_sum = 0;
			dc_tg_q02_sum = 0;
			dc_tg_q03_sum = 0;
			dc_tg_q04_sum = 0;
			dc_tg_h01_sum = 0;
			dc_tg_h02_sum = 0;
			dc_tg_ytd_sum = 0;

		}
				
		for(int i=0; i<dcGsvShList.size(); i++) {
			dcGsvMap = new HashMap();
			
			
			dcGsvMap.put("DATALV1_NM", "Total GSV C/R");
			dcGsvMap.put("DATALV2_NM", dcGsvShList.get(i).get("DATALV2_NM"));
			dcGsvMap.put("DATALV3_NM", dcGsvShList.get(i).get("DATALV2_NM"));
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P01"))) != 0) {
				dcGsvMap.put("DC_AC_P01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P01"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P02"))) != 0) {
				dcGsvMap.put("DC_AC_P02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P02"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P03"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P03"))) != 0) {
				dcGsvMap.put("DC_AC_P03", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P03")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P03"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P03", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P04"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P04"))) != 0) {
				dcGsvMap.put("DC_AC_P04", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P04")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P04"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P04", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P05"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P05"))) != 0) {
				dcGsvMap.put("DC_AC_P05", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P05")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P05"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P05", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P06"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P06"))) != 0) {
				dcGsvMap.put("DC_AC_P06", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P06")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P06"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P06", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P07"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P07"))) != 0) {
				dcGsvMap.put("DC_AC_P07", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P07")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P07"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P07", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P08"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P08"))) != 0) {
				dcGsvMap.put("DC_AC_P08", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P08")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P08"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P08", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P09"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P09"))) != 0) {
				dcGsvMap.put("DC_AC_P09", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P09")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P09"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P09", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P10"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P10"))) != 0) {
				dcGsvMap.put("DC_AC_P10",(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P10")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P10"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P10", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P11"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P11"))) != 0) {
				dcGsvMap.put("DC_AC_P11", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P11")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P11"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P11", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P12"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P12"))) != 0) {
				dcGsvMap.put("DC_AC_P12", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_P12")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_P12"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_P12", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_Q01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_Q01"))) != 0) {
				dcGsvMap.put("DC_AC_Q01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_Q01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_Q01"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_Q01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_Q02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_Q02"))) != 0) {
				dcGsvMap.put("DC_AC_Q02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_Q02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_Q02"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_Q02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_Q03"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_Q03"))) != 0) {
				dcGsvMap.put("DC_AC_Q03", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_Q03")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_Q03"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_Q03", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_Q04"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_Q04"))) != 0) {
				dcGsvMap.put("DC_AC_Q04", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_Q04")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_Q04"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_Q04", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_H01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_H01"))) != 0) {
				dcGsvMap.put("DC_AC_H01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_H01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_H01"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_H01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_H02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_H02"))) != 0) {
				dcGsvMap.put("DC_AC_H02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_H02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_H02"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_H02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_YTD"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_YTD"))) != 0) {
				dcGsvMap.put("DC_AC_YTD", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_AC_YTD")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_AC_YTD"))))/1000);
			}
			else {
				dcGsvMap.put("DC_AC_YTD", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P01"))) != 0) {
				dcGsvMap.put("DC_FOR_P01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P01")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P02"))) != 0) {
				dcGsvMap.put("DC_FOR_P02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P02")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P03"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P03"))) != 0) {
				dcGsvMap.put("DC_FOR_P03", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P03")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P03")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P03", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P04"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P04"))) != 0) {
				dcGsvMap.put("DC_FOR_P04", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P04")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P04")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P04", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P05"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P05"))) != 0) {
				dcGsvMap.put("DC_FOR_P05", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P05")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P05")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P05", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P06"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P06"))) != 0) {
				dcGsvMap.put("DC_FOR_P06", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P06")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P06")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P06", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P07"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P07"))) != 0) {
				dcGsvMap.put("DC_FOR_P07", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P07")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P07")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P07", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P08"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P08"))) != 0) {
				dcGsvMap.put("DC_FOR_P08", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P08")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P08")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P08", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P09"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P09"))) != 0) {
				dcGsvMap.put("DC_FOR_P09", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P09")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P09")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P09", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P10"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P10"))) != 0) {
				dcGsvMap.put("DC_FOR_P10", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P10")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P10")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P10", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P11"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P11"))) != 0) {
				dcGsvMap.put("DC_FOR_P11", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P11")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P11")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P11", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P12"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P12"))) != 0) {
				dcGsvMap.put("DC_FOR_P12", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_P12")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_P12")))));
			}
			else {
				dcGsvMap.put("DC_FOR_P12", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_Q01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_Q01"))) != 0) {
				dcGsvMap.put("DC_FOR_Q01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_Q01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_Q01")))));
			}
			else {
				dcGsvMap.put("DC_FOR_Q01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_Q02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_Q02"))) != 0) {
				dcGsvMap.put("DC_FOR_Q02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_Q02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_Q02")))));
			}
			else {
				dcGsvMap.put("DC_FOR_Q02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_Q03"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_Q03"))) != 0) {
				dcGsvMap.put("DC_FOR_Q03", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_Q03")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_Q03")))));
			}
			else {
				dcGsvMap.put("DC_FOR_Q03", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_Q04"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_Q04"))) != 0) {
				dcGsvMap.put("DC_FOR_Q04", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_Q04")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_Q04")))));
			}
			else {
				dcGsvMap.put("DC_FOR_Q04", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_H01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_H01"))) != 0) {
				dcGsvMap.put("DC_FOR_H01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_H01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_H01")))));
			}
			else {
				dcGsvMap.put("DC_FOR_H01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_H02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_H02"))) != 0) {
				dcGsvMap.put("DC_FOR_H02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_H02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_H02")))));
			}
			else {
				dcGsvMap.put("DC_FOR_H02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_YTD"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_YTD"))) != 0) {
				dcGsvMap.put("DC_FOR_YTD", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_FOR_YTD")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_FOR_YTD")))));
			}
			else {
				dcGsvMap.put("DC_FOR_YTD", 0);
			}
			
			
			
			
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P01"))) != 0) {
				dcGsvMap.put("DC_OUT_P01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P01")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P02"))) != 0) {
				dcGsvMap.put("DC_OUT_P02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P02")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P03"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P03"))) != 0) {
				dcGsvMap.put("DC_OUT_P03", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P03")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P03")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P03", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P04"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P04"))) != 0) {
				dcGsvMap.put("DC_OUT_P04", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P04")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P04")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P04", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P05"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P05"))) != 0) {
				dcGsvMap.put("DC_OUT_P05", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P05")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P05")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P05", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P06"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P06"))) != 0) {
				dcGsvMap.put("DC_OUT_P06", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P06")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P06")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P06", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P07"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P07"))) != 0) {
				dcGsvMap.put("DC_OUT_P07", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P07")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P07")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P07", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P08"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P08"))) != 0) {
				dcGsvMap.put("DC_OUT_P08", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P08")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P08")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P08", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P09"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P09"))) != 0) {
				dcGsvMap.put("DC_OUT_P09", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P09")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P09")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P09", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P10"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P10"))) != 0) {
				dcGsvMap.put("DC_OUT_P10", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P10")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P10")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P10", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P11"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P11"))) != 0) {
				dcGsvMap.put("DC_OUT_P11", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P11")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P11")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P11", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P12"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P12"))) != 0) {
				dcGsvMap.put("DC_OUT_P12", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_P12")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_P12")))));
			}
			else {
				dcGsvMap.put("DC_OUT_P12", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_Q01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_Q01"))) != 0) {
				dcGsvMap.put("DC_OUT_Q01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_Q01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_Q01")))));
			}
			else {
				dcGsvMap.put("DC_OUT_Q01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_Q02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_Q02"))) != 0) {
				dcGsvMap.put("DC_OUT_Q02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_Q02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_Q02")))));
			}
			else {
				dcGsvMap.put("DC_OUT_Q02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_Q03"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_Q03"))) != 0) {
				dcGsvMap.put("DC_OUT_Q03", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_Q03")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_Q03")))));
			}
			else {
				dcGsvMap.put("DC_OUT_Q03", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_Q04"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_Q04"))) != 0) {
				dcGsvMap.put("DC_OUT_Q04", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_Q04")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_Q04")))));
			}
			else {
				dcGsvMap.put("DC_OUT_Q04", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_H01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_H01"))) != 0) {
				dcGsvMap.put("DC_OUT_H01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_H01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_H01")))));
			}
			else {
				dcGsvMap.put("DC_OUT_H01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_H02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_H02"))) != 0) {
				dcGsvMap.put("DC_OUT_H02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_H02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_H02")))));
			}
			else {
				dcGsvMap.put("DC_OUT_H02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_YTD"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_YTD"))) != 0) {
				dcGsvMap.put("DC_OUT_YTD", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_OUT_YTD")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_OUT_YTD")))));
			}
			else {
				dcGsvMap.put("DC_OUT_YTD", 0);
			}
			
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P01"))) != 0) {
				dcGsvMap.put("DC_TG_P01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P01")))));
			}
			else {
				dcGsvMap.put("DC_TG_P01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P02"))) != 0) {
				dcGsvMap.put("DC_TG_P02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P02")))));
			}
			else {
				dcGsvMap.put("DC_TG_P02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P03"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P03"))) != 0) {
				dcGsvMap.put("DC_TG_P03", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P03")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P03")))));
			}
			else {
				dcGsvMap.put("DC_TG_P03", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P04"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P04"))) != 0) {
				dcGsvMap.put("DC_TG_P04", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P04")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P04")))));
			}
			else {
				dcGsvMap.put("DC_TG_P04", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P05"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P05"))) != 0) {
				dcGsvMap.put("DC_TG_P05", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P05")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P05")))));
			}
			else {
				dcGsvMap.put("DC_TG_P05", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P06"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P06"))) != 0) {
				dcGsvMap.put("DC_TG_P06", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P06")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P06")))));
			}
			else {
				dcGsvMap.put("DC_TG_P06", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P07"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P07"))) != 0) {
				dcGsvMap.put("DC_TG_P07", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P07")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P07")))));
			}
			else {
				dcGsvMap.put("DC_TG_P07", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P08"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P08"))) != 0) {
				dcGsvMap.put("DC_TG_P08", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P08")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P08")))));
			}
			else {
				dcGsvMap.put("DC_TG_P08", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P09"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P09"))) != 0) {
				dcGsvMap.put("DC_TG_P09", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P09")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P09")))));
			}
			else {
				dcGsvMap.put("DC_TG_P09", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P10"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P10"))) != 0) {
				dcGsvMap.put("DC_TG_P10", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P10")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P10")))));
			}
			else {
				dcGsvMap.put("DC_TG_P10", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P11"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P11"))) != 0) {
				dcGsvMap.put("DC_TG_P11", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P11")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P11")))));
			}
			else {
				dcGsvMap.put("DC_TG_P11", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P12"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P12"))) != 0) {
				dcGsvMap.put("DC_TG_P12", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_P12")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_P12")))));
			}
			else {
				dcGsvMap.put("DC_TG_P12", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_Q01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_Q01"))) != 0) {
				dcGsvMap.put("DC_TG_Q01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_Q01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_Q01")))));
			}
			else {
				dcGsvMap.put("DC_TG_Q01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_Q02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_Q02"))) != 0) {
				dcGsvMap.put("DC_TG_Q02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_Q02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_Q02")))));
			}
			else {
				dcGsvMap.put("DC_TG_Q02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_Q03"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_Q03"))) != 0) {
				dcGsvMap.put("DC_TG_Q03", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_Q03")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_Q03")))));
			}
			else {
				dcGsvMap.put("DC_TG_Q03", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_Q04"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_Q04"))) != 0) {
				dcGsvMap.put("DC_TG_Q04", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_Q04")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_Q04")))));
			}
			else {
				dcGsvMap.put("DC_TG_Q04", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_H01"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_H01"))) != 0) {
				dcGsvMap.put("DC_TG_H01", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_H01")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_H01")))));
			}
			else {
				dcGsvMap.put("DC_TG_H01", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_H02"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_H02"))) != 0) {
				dcGsvMap.put("DC_TG_H02", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_H02")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_H02")))));
			}
			else {
				dcGsvMap.put("DC_TG_H02", 0);
			}
			
			if(Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_YTD"))) != 0 && Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_YTD"))) != 0) {
				dcGsvMap.put("DC_TG_YTD", (Double.parseDouble(String.valueOf(dcGsvDcList.get(i).get("DC_TG_YTD")))/Double.parseDouble(String.valueOf(dcGsvShList.get(i).get("SH_TG_YTD")))));
			}
			else {
				dcGsvMap.put("DC_TG_YTD", 0);
			}
			
			dcGsvList.add(dcGsvMap);
		}

		return dcGsvList;
	}
	
	//Credit 리스트 추출
	public ArrayList<Map> creditMerge(ArrayList<Map> list, HashMap map, Map param) {
		ArrayList<Map> creditMerge = new ArrayList<Map>();
		Map creditMap = null;

		for(int i=0; i<list.size(); i++) {
			creditMap = new HashMap();
			
			creditMap.put("DATALV1_NM",list.get(i).get("DATALV1_NM"));
			creditMap.put("DATALV2_NM",list.get(i).get("DATALV1_NM"));
			creditMap.put("DATALV3_NM",list.get(i).get("DATALV1_NM"));
			
			creditMap.put("CD_AC_P01", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P01"))));
			creditMap.put("CD_AC_P02", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P02"))));
			creditMap.put("CD_AC_P03", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P03"))));
			creditMap.put("CD_AC_P04", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P04"))));
			creditMap.put("CD_AC_P05", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P05"))));
			creditMap.put("CD_AC_P06", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P06"))));
			creditMap.put("CD_AC_P07", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P07"))));
			creditMap.put("CD_AC_P08", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P08"))));
			creditMap.put("CD_AC_P09", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P09"))));
			creditMap.put("CD_AC_P10", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P10"))));
			creditMap.put("CD_AC_P11", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P11"))));
			creditMap.put("CD_AC_P12", Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P12"))));
			double cd_ac_q01 = Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P01")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P02")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P03")));
			double cd_ac_q02 = Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P04")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P05")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P06")));
			double cd_ac_q03 = Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P07")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P08")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P09")));
			double cd_ac_q04 = Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P10")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P11")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_AC_P12")));
			
			double cd_ac_h01 = cd_ac_q01+cd_ac_q02;
			double cd_ac_h02 = cd_ac_q03+cd_ac_q04;
			double cd_ac_ytd  = setAcYTD(param, list.get(i), "CD");
			creditMap.put("CD_AC_Q01", cd_ac_q01);
			creditMap.put("CD_AC_Q02", cd_ac_q02);
			creditMap.put("CD_AC_Q03", cd_ac_q03);
			creditMap.put("CD_AC_Q04", cd_ac_q04);
			creditMap.put("CD_AC_H01", cd_ac_h01);
			creditMap.put("CD_AC_H02", cd_ac_h02);
			creditMap.put("CD_AC_YTD", cd_ac_ytd);
			
			creditMap.put("CD_FOR_P01", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P01"))));
			creditMap.put("CD_FOR_P02", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P02"))));
			creditMap.put("CD_FOR_P03", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P03"))));
			creditMap.put("CD_FOR_P04", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P04"))));
			creditMap.put("CD_FOR_P05", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P05"))));
			creditMap.put("CD_FOR_P06", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P06"))));
			creditMap.put("CD_FOR_P07", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P07"))));
			creditMap.put("CD_FOR_P08", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P08"))));
			creditMap.put("CD_FOR_P09", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P09"))));
			creditMap.put("CD_FOR_P10", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P10"))));
			creditMap.put("CD_FOR_P11", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P11"))));
			creditMap.put("CD_FOR_P12", Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P12"))));
			double cd_for_q01 = Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P01")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P02")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P03")));
			double cd_for_q02 = Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P04")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P05")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P06")));
			double cd_for_q03 = Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P07")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P08")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P09")));
			double cd_for_q04 = Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P10")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P11")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_FOR_P12")));
			double cd_for_h01 = cd_for_q01+cd_for_q02;
			double cd_for_h02 = cd_for_q03+cd_for_q04;
			double cd_for_ytd = setForYTD(param, list.get(i), "CD");
			
			creditMap.put("CD_FOR_Q01", cd_for_q01);
			creditMap.put("CD_FOR_Q02", cd_for_q02);
			creditMap.put("CD_FOR_Q03", cd_for_q03);
			creditMap.put("CD_FOR_Q04", cd_for_q04);
			creditMap.put("CD_FOR_H01", cd_for_h01);
			creditMap.put("CD_FOR_H02", cd_for_h02);
			creditMap.put("CD_FOR_YTD", cd_for_ytd);
			
			creditMap.put("CD_OUT_P01", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P01"))));
			creditMap.put("CD_OUT_P02", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P02"))));
			creditMap.put("CD_OUT_P03", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P03"))));
			creditMap.put("CD_OUT_P04", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P04"))));
			creditMap.put("CD_OUT_P05", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P05"))));
			creditMap.put("CD_OUT_P06", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P06"))));
			creditMap.put("CD_OUT_P07", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P07"))));
			creditMap.put("CD_OUT_P08", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P08"))));
			creditMap.put("CD_OUT_P09", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P09"))));
			creditMap.put("CD_OUT_P10", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P10"))));
			creditMap.put("CD_OUT_P11", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P11"))));
			creditMap.put("CD_OUT_P12", Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P12"))));
			double cd_out_q01 = Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P01")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P02")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P03")));
			double cd_out_q02 = Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P04")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P05")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P06")));
			double cd_out_q03 = Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P07")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P08")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P09")));
			double cd_out_q04 = Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P10")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P11")))+Double.parseDouble(String.valueOf(list.get(i).get("CD_OUT_P12")));
			double cd_out_h01 = cd_out_q01+cd_out_q02;
			double cd_out_h02 = cd_out_q03+cd_out_q04;
			double cd_out_ytd = setOutYTD(param, list.get(i), "CD");
			
			creditMap.put("CD_OUT_Q01", cd_out_q01);
			creditMap.put("CD_OUT_Q02", cd_out_q02);
			creditMap.put("CD_OUT_Q03", cd_out_q03);
			creditMap.put("CD_OUT_Q04", cd_out_q04);
			creditMap.put("CD_OUT_H01", cd_out_h01);
			creditMap.put("CD_OUT_H02", cd_out_h02);
			creditMap.put("CD_OUT_YTD", cd_out_ytd);
			
			creditMerge.add(creditMap);
		}
		
		int creditRow = creditMerge.size()/2;
		
		creditMap = new HashMap();
		double cd_for_p01 = 0;
		double cd_for_p02 = 0;
		double cd_for_p03 = 0;
		double cd_for_p04 = 0;
		double cd_for_p05 = 0;
		double cd_for_p06 = 0;
		double cd_for_p07 = 0;
		double cd_for_p08 = 0;
		double cd_for_p09 = 0;
		double cd_for_p10 = 0;
		double cd_for_p11 = 0;
		double cd_for_p12 = 0;
		double cd_for_q01 = 0;
		double cd_for_q02 = 0;
		double cd_for_q03 = 0;
		double cd_for_q04 = 0;
		double cd_for_h01 = 0;
		double cd_for_h02 = 0;
		double cd_for_ytd = 0;
		
		double cd_out_p01 = 0;
		double cd_out_p02 = 0;
		double cd_out_p03 = 0;
		double cd_out_p04 = 0;
		double cd_out_p05 = 0;
		double cd_out_p06 = 0;
		double cd_out_p07 = 0;
		double cd_out_p08 = 0;
		double cd_out_p09 = 0;
		double cd_out_p10 = 0;
		double cd_out_p11 = 0;
		double cd_out_p12 = 0;
		double cd_out_q01 = 0;
		double cd_out_q02 = 0;
		double cd_out_q03 = 0;
		double cd_out_q04 = 0;
		double cd_out_h01 = 0;
		double cd_out_h02 = 0;
		double cd_out_ytd = 0;

		double cd_ac_p01 = 0;
		double cd_ac_p02 = 0;
		double cd_ac_p03 = 0;
		double cd_ac_p04 = 0;
		double cd_ac_p05 = 0;
		double cd_ac_p06 = 0;
		double cd_ac_p07 = 0;
		double cd_ac_p08 = 0;
		double cd_ac_p09 = 0;
		double cd_ac_p10 = 0;
		double cd_ac_p11 = 0;
		double cd_ac_p12 = 0;
		double cd_ac_q01 = 0;
		double cd_ac_q02 = 0;
		double cd_ac_q03 = 0;
		double cd_ac_q04 = 0;
		double cd_ac_h01 = 0;
		double cd_ac_h02 = 0;
		double cd_ac_ytd = 0;
		
		for(int i=0; i<creditMerge.size(); i++) {
			cd_ac_p01 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P01")));
			cd_ac_p02 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P02")));
			cd_ac_p03 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P03")));
			cd_ac_p04 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P04")));
			cd_ac_p05 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P05")));
			cd_ac_p06 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P06")));
			cd_ac_p07 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P07")));
			cd_ac_p08 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P08")));
			cd_ac_p09 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P09")));
			cd_ac_p10 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P10")));
			cd_ac_p11 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P11")));
			cd_ac_p12 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P12")));
			cd_ac_q01 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q01")));
			cd_ac_q02 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q02")));
			cd_ac_q03 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q03")));
			cd_ac_q04 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q04")));
			cd_ac_h01 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_H01")));
			cd_ac_h02 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_H02")));
			cd_ac_ytd += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_YTD")));

			cd_for_p01 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P01")));
			cd_for_p02 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P02")));
			cd_for_p03 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P03")));
			cd_for_p04 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P04")));
			cd_for_p05 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P05")));
			cd_for_p06 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P06")));
			cd_for_p07 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P07")));
			cd_for_p08 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P08")));
			cd_for_p09 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P09")));
			cd_for_p10 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P10")));
			cd_for_p11 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P11")));
			cd_for_p12 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P12")));
			cd_for_q01 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q01")));
			cd_for_q02 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q02")));
			cd_for_q03 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q03")));
			cd_for_q04 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q04")));
			cd_for_h01 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_H01")));
			cd_for_h02 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_H02")));
			cd_for_ytd += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_YTD")));

			cd_out_p01 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P01")));
			cd_out_p02 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P02")));
			cd_out_p03 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P03")));
			cd_out_p04 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P04")));
			cd_out_p05 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P05")));
			cd_out_p06 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P06")));
			cd_out_p07 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P07")));
			cd_out_p08 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P08")));
			cd_out_p09 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P09")));
			cd_out_p10 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P10")));
			cd_out_p11 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P11")));
			cd_out_p12 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P12")));
			cd_out_q01 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q01")));
			cd_out_q02 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q02")));
			cd_out_q03 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q03")));
			cd_out_q04 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q04")));
			cd_out_h01 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_H01")));
			cd_out_h02 += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_H02")));
			cd_out_ytd += Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_YTD")));
		}
		
		creditMap.put("DATALV1_NM","total");
		creditMap.put("DATALV3_NM","total");
		creditMap.put("DATALV3_NM","total");
		creditMap.put("CD_AC_P01", cd_ac_p01);
		creditMap.put("CD_AC_P02", cd_ac_p02);
		creditMap.put("CD_AC_P03", cd_ac_p03);
		creditMap.put("CD_AC_P04", cd_ac_p04);
		creditMap.put("CD_AC_P05", cd_ac_p05);
		creditMap.put("CD_AC_P06", cd_ac_p06);
		creditMap.put("CD_AC_P07", cd_ac_p07);
		creditMap.put("CD_AC_P08", cd_ac_p08);
		creditMap.put("CD_AC_P09", cd_ac_p09);
		creditMap.put("CD_AC_P10", cd_ac_p10);
		creditMap.put("CD_AC_P11", cd_ac_p11);
		creditMap.put("CD_AC_P12", cd_ac_p12);
		creditMap.put("CD_AC_Q01", cd_ac_q01);
		creditMap.put("CD_AC_Q02", cd_ac_q02);
		creditMap.put("CD_AC_Q03", cd_ac_q03);
		creditMap.put("CD_AC_Q04", cd_ac_q04);
		creditMap.put("CD_AC_H01", cd_ac_h01);
		creditMap.put("CD_AC_H02", cd_ac_h02);
		creditMap.put("CD_AC_YTD", cd_ac_ytd);
		
		creditMap.put("CD_FOR_P01", cd_for_p01);
		creditMap.put("CD_FOR_P02", cd_for_p02);
		creditMap.put("CD_FOR_P03", cd_for_p03);
		creditMap.put("CD_FOR_P04", cd_for_p04);
		creditMap.put("CD_FOR_P05", cd_for_p05);
		creditMap.put("CD_FOR_P06", cd_for_p06);
		creditMap.put("CD_FOR_P07", cd_for_p07);
		creditMap.put("CD_FOR_P08", cd_for_p08);
		creditMap.put("CD_FOR_P09", cd_for_p09);
		creditMap.put("CD_FOR_P10", cd_for_p10);
		creditMap.put("CD_FOR_P11", cd_for_p11);
		creditMap.put("CD_FOR_P12", cd_for_p12);
		creditMap.put("CD_FOR_Q01", cd_for_q01);
		creditMap.put("CD_FOR_Q02", cd_for_q02);
		creditMap.put("CD_FOR_Q03", cd_for_q03);
		creditMap.put("CD_FOR_Q04", cd_for_q04);
		creditMap.put("CD_FOR_H01", cd_for_h01);
		creditMap.put("CD_FOR_H02", cd_for_h02);
		creditMap.put("CD_FOR_YTD", cd_for_ytd);
		
		creditMap.put("CD_OUT_P01", cd_out_p01);
		creditMap.put("CD_OUT_P02", cd_out_p02);
		creditMap.put("CD_OUT_P03", cd_out_p03);
		creditMap.put("CD_OUT_P04", cd_out_p04);
		creditMap.put("CD_OUT_P05", cd_out_p05);
		creditMap.put("CD_OUT_P06", cd_out_p06);
		creditMap.put("CD_OUT_P07", cd_out_p07);
		creditMap.put("CD_OUT_P08", cd_out_p08);
		creditMap.put("CD_OUT_P09", cd_out_p09);
		creditMap.put("CD_OUT_P10", cd_out_p10);
		creditMap.put("CD_OUT_P11", cd_out_p11);
		creditMap.put("CD_OUT_P12", cd_out_p12);
		creditMap.put("CD_OUT_Q01", cd_out_q01);
		creditMap.put("CD_OUT_Q02", cd_out_q02);
		creditMap.put("CD_OUT_Q03", cd_out_q03);
		creditMap.put("CD_OUT_Q04", cd_out_q04);
		creditMap.put("CD_OUT_H01", cd_out_h01);
		creditMap.put("CD_OUT_H02", cd_out_h02);
		creditMap.put("CD_OUT_YTD", cd_out_ytd);
		
		creditMerge.add(creditMap);
		
		creditMap = new HashMap();
		
		for(int i=1; i<2; i++) {
			for(int j=2; j<3; j++) {
				
				creditMap.put("DATALV1_NM","Long Term Portion %");
				creditMap.put("DATALV3_NM","Long Term Portion %");
				creditMap.put("DATALV3_NM","Long Term Portion %");
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P01"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P01"))) != 0)  {
					creditMap.put("CD_AC_P01",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P01")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P01"))));
				}
				else {
					creditMap.put("CD_AC_P01", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P02"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P02"))) != 0)  {
					creditMap.put("CD_AC_P02",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P02")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P02"))));
				}
				else {
					creditMap.put("CD_AC_P02", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P03"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P03"))) != 0)  {
					creditMap.put("CD_AC_P03",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P03")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P03"))));
				}
				else {
					creditMap.put("CD_AC_P03", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P04"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P04"))) != 0)  {
					creditMap.put("CD_AC_P04",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P04")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P04"))));
				}
				else {
					creditMap.put("CD_AC_P04", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P05"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P05"))) != 0)  {
					creditMap.put("CD_AC_P05",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P05")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P05"))));
				}
				else {
					creditMap.put("CD_AC_P05", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P06"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P06"))) != 0)  {
					creditMap.put("CD_AC_P06",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P06")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P06"))));
				}
				else {
					creditMap.put("CD_AC_P06", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P07"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P07"))) != 0)  {
					creditMap.put("CD_AC_P07",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P07")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P07"))));
				}
				else {
					creditMap.put("CD_AC_P07", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P08"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P08"))) != 0)  {
					creditMap.put("CD_AC_P08",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P08")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P08"))));
				}
				else {
					creditMap.put("CD_AC_P08", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P09"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P09"))) != 0)  {
					creditMap.put("CD_AC_P09",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P09")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P09"))));
				}
				else {
					creditMap.put("CD_AC_P09", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P10"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P10"))) != 0)  {
					creditMap.put("CD_AC_P10",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P10")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P10"))));
				}
				else {
					creditMap.put("CD_AC_P10", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P11"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P11"))) != 0)  {
					creditMap.put("CD_AC_P11",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P11")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P11"))));
				}
				else {
					creditMap.put("CD_AC_P11", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P12"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P12"))) != 0)  {
					creditMap.put("CD_AC_P12",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_P12")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_P12"))));
				}
				else {
					creditMap.put("CD_AC_P12", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_Q01"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q01"))) != 0)  {
					creditMap.put("CD_AC_Q01",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q01")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_Q01"))));
				}
				else {
					creditMap.put("CD_AC_Q01", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_Q02"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q02"))) != 0)  {
					creditMap.put("CD_AC_Q02",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q02")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_Q02"))));
				}
				else {
					creditMap.put("CD_AC_Q02", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_Q03"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q03"))) != 0)  {
					creditMap.put("CD_AC_Q03",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q03")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_Q03"))));
				}
				else {
					creditMap.put("CD_AC_Q03", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_Q04"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q04"))) != 0)  {
					creditMap.put("CD_AC_Q04",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_Q04")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_Q04"))));
				}
				else {
					creditMap.put("CD_AC_Q04", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_H01"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_H01"))) != 0)  {
					creditMap.put("CD_AC_H01",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_H01")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_H01"))));
				}
				else {
					creditMap.put("CD_AC_H01", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_H02"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_H02"))) != 0)  {
					creditMap.put("CD_AC_H02",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_H02")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_H02"))));
				}
				else {
					creditMap.put("CD_AC_H02", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_YTD"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_YTD"))) != 0)  {
					creditMap.put("CD_AC_YTD",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_AC_YTD")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_AC_YTD"))));
				}
				else {
					creditMap.put("CD_AC_YTD", 0);
				}
					
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P01"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P01"))) != 0)  {
					creditMap.put("CD_FOR_P01",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P01")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P01"))));
				}
				else {
					creditMap.put("CD_FOR_P01", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P02"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P02"))) != 0)  {
					creditMap.put("CD_FOR_P02",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P02")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P02"))));
				}
				else {
					creditMap.put("CD_FOR_P02", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P03"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P03"))) != 0)  {
					creditMap.put("CD_FOR_P03",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P03")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P03"))));
				}
				else {
					creditMap.put("CD_FOR_P03", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P04"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P04"))) != 0)  {
					creditMap.put("CD_FOR_P04",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P04")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P04"))));
				}
				else {
					creditMap.put("CD_FOR_P04", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P05"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P05"))) != 0)  {
					creditMap.put("CD_FOR_P05",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P05")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P05"))));
				}
				else {
					creditMap.put("CD_FOR_P05", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P06"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P06"))) != 0)  {
					creditMap.put("CD_FOR_P06",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P06")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P06"))));
				}
				else {
					creditMap.put("CD_FOR_P06", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P07"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P07"))) != 0)  {
					creditMap.put("CD_FOR_P07",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P07")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P07"))));
				}
				else {
					creditMap.put("CD_FOR_P07", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P08"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P08"))) != 0)  {
					creditMap.put("CD_FOR_P08",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P08")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P08"))));
				}
				else {
					creditMap.put("CD_FOR_P08", 0);
				}
				
					
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P09"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P09"))) != 0)  {
					creditMap.put("CD_FOR_P09",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P09")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P09"))));
				}
				else {
					creditMap.put("CD_FOR_P09", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P10"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P10"))) != 0)  {
					creditMap.put("CD_FOR_P10",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P10")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P10"))));
				}
				else {
					creditMap.put("CD_FOR_P10", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P11"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P11"))) != 0)  {
					creditMap.put("CD_FOR_P11",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P11")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P11"))));
				}
				else {
					creditMap.put("CD_FOR_P11", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P12"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P12"))) != 0)  {
					creditMap.put("CD_FOR_P12",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_P12")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_P12"))));
				}
				else {
					creditMap.put("CD_FOR_P12", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_Q01"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q01"))) != 0)  {
					creditMap.put("CD_FOR_Q01",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q01")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_Q01"))));
				}
				else {
					creditMap.put("CD_FOR_Q01", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_Q02"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q02"))) != 0)  {
					creditMap.put("CD_FOR_Q02",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q02")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_Q02"))));
				}
				else {
					creditMap.put("CD_FOR_Q02", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_Q03"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q03"))) != 0)  {
					creditMap.put("CD_FOR_Q03",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q03")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_Q03"))));
				}
				else {
					creditMap.put("CD_FOR_Q03", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_Q04"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q04"))) != 0)  {
					creditMap.put("CD_FOR_Q04",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_Q04")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_Q04"))));
				}
				else {
					creditMap.put("CD_FOR_Q04", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_H01"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_H01"))) != 0)  {
					creditMap.put("CD_FOR_H01",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_H01")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_H01"))));
				}
				else {
					creditMap.put("CD_FOR_H01", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_H02"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_H02"))) != 0)  {
					creditMap.put("CD_FOR_H02",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_H02")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_H02"))));
				}
				else {
					creditMap.put("CD_FOR_H02", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_YTD"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_YTD"))) != 0)  {
					creditMap.put("CD_FOR_YTD",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_FOR_YTD")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_FOR_YTD"))));
				}
				else {
					creditMap.put("CD_FOR_YTD", 0);
				}
					
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P01"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P01"))) != 0)  {                                                                                                                              
					creditMap.put("CD_OUT_P01",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P01")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P01"))));
				}
				else {
					creditMap.put("CD_OUT_P01", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P02"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P02"))) != 0)  {
					creditMap.put("CD_OUT_P02",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P02")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P02"))));
				}
				else {
					creditMap.put("CD_OUT_P02", 0);
				}
					
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P03"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P03"))) != 0)  {
					creditMap.put("CD_OUT_P03",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P03")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P03"))));
				}
				else {
					creditMap.put("CD_OUT_P03", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P04"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P04"))) != 0)  {
					creditMap.put("CD_OUT_P04",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P04")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P04"))));
				}
				else {
					creditMap.put("CD_OUT_P04", 0);
				}
				
					
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P05"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P05"))) != 0)  {
					creditMap.put("CD_OUT_P05",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P05")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P05"))));
				}
				else {
					creditMap.put("CD_OUT_P05", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P06"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P06"))) != 0)  {	
					creditMap.put("CD_OUT_P06",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P06")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P06"))));
				}
				else {
					creditMap.put("CD_OUT_P06", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P07"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P07"))) != 0)  {	
					creditMap.put("CD_OUT_P07",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P07")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P07"))));
				}
				else {
					creditMap.put("CD_OUT_P07", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P08"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P08"))) != 0)  {		
					creditMap.put("CD_OUT_P08",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P08")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P08"))));
				}
				else {
					creditMap.put("CD_OUT_P08", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P09"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P09"))) != 0)  {
					creditMap.put("CD_OUT_P09",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P09")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P09"))));
				}
				else {
					creditMap.put("CD_OUT_P09", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P10"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P10"))) != 0)  {
					creditMap.put("CD_OUT_P10",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P10")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P10"))));
				}
				else {
					creditMap.put("CD_OUT_P10", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P11"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P11"))) != 0)  {
					creditMap.put("CD_OUT_P11",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P11")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P11"))));
				}
				else {
					creditMap.put("CD_OUT_P11", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P12"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P12"))) != 0)  {
					creditMap.put("CD_OUT_P12",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_P12")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_P12"))));
				}
				else {
					creditMap.put("CD_OUT_P12", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_Q01"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q01"))) != 0)  {
					creditMap.put("CD_OUT_Q01",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q01")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_Q01"))));
				}
				else {
					creditMap.put("CD_OUT_Q01", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_Q02"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q02"))) != 0)  {
					creditMap.put("CD_OUT_Q02",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q02")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_Q02"))));
				}
				else {
					creditMap.put("CD_OUT_Q02", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_Q03"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q03"))) != 0)  {
					creditMap.put("CD_OUT_Q03",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q03")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_Q03"))));
				}
				else {
					creditMap.put("CD_OUT_Q03", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_Q04"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q04"))) != 0)  {
					creditMap.put("CD_OUT_Q04",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_Q04")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_Q04"))));
				}
				else {
					creditMap.put("CD_OUT_Q04", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_H01"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_H01"))) != 0)  {
					creditMap.put("CD_OUT_H01",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_H01")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_H01"))));
				}
				else {
					creditMap.put("CD_OUT_H01", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_H02"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_H02"))) != 0)  {
					creditMap.put("CD_OUT_H02",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_H02")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_H02"))));
				}
				else {
					creditMap.put("CD_OUT_H02", 0);
				}
				
				if(Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_YTD"))) != 0 && Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_YTD"))) != 0)  {
					creditMap.put("CD_OUT_YTD",Double.parseDouble(String.valueOf(creditMerge.get(i).get("CD_OUT_YTD")))/Double.parseDouble(String.valueOf(creditMerge.get(j).get("CD_OUT_YTD"))));
				}
				else {
					creditMap.put("CD_OUT_YTD", 0);
				}
			}
		}
		
		if(map != null) {
			creditMap.put("CD_TG_P01", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL01"))));
			creditMap.put("CD_TG_P02", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL02"))));
			creditMap.put("CD_TG_P03", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL03"))));
			creditMap.put("CD_TG_P04", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL04"))));
			creditMap.put("CD_TG_P05", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL05"))));
			creditMap.put("CD_TG_P06", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL06"))));
			creditMap.put("CD_TG_P07", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL07"))));
			creditMap.put("CD_TG_P08", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL08"))));
			creditMap.put("CD_TG_P09", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL09"))));
			creditMap.put("CD_TG_P10", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL10"))));
			creditMap.put("CD_TG_P11", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL11"))));
			creditMap.put("CD_TG_P12", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOL12"))));
			creditMap.put("CD_TG_Q01", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOLQ01"))));
			creditMap.put("CD_TG_Q02", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOLQ01"))));
			creditMap.put("CD_TG_Q03", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOLQ02"))));
			creditMap.put("CD_TG_Q04", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOLQ03"))));
			creditMap.put("CD_TG_H01", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOLQ04"))));
			creditMap.put("CD_TG_H02", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOLH01"))));
			creditMap.put("CD_TG_YTD", Double.parseDouble(String.valueOf(map.get("N_AC_TG_VOLH02"))));
		}
		else {
			creditMap.put("CD_TG_P01", "0.0");
			creditMap.put("CD_TG_P02", "0.0");
			creditMap.put("CD_TG_P03", "0.0");
			creditMap.put("CD_TG_P04", "0.0");
			creditMap.put("CD_TG_P05", "0.0");
			creditMap.put("CD_TG_P06", "0.0");
			creditMap.put("CD_TG_P07", "0.0");
			creditMap.put("CD_TG_P08", "0.0");
			creditMap.put("CD_TG_P09", "0.0");
			creditMap.put("CD_TG_P10", "0.0");
			creditMap.put("CD_TG_P11", "0.0");
			creditMap.put("CD_TG_P12", "0.0");
			creditMap.put("CD_TG_Q01", "0.0");
			creditMap.put("CD_TG_Q02", "0.0");
			creditMap.put("CD_TG_Q03", "0.0");
			creditMap.put("CD_TG_Q04", "0.0");
			creditMap.put("CD_TG_H01", "0.0");
			creditMap.put("CD_TG_H02", "0.0");
			creditMap.put("CD_TG_YTD", "0.0");
		}
		
		creditMerge.add(creditMap);
		
		return creditMerge;
	}
	
	//헤더 생성
	public int excelHeader(int rowCount, HSSFRow row, HSSFCell cell, HSSFWorkbook shBook, HSSFSheet shSheet, String[] headerNm, Map param) {
		int headerRow = rowCount+shipmentRow;
		
		shSheet.setColumnWidth(1, 5000);
		shSheet.setColumnWidth(2, 5000);
		
		Font font1 = shBook.createFont();
    	font1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
    	font1.setFontName("맑은 고딕");
    	
    	Font font2 = shBook.createFont();
    	font2.setFontName("맑은 고딕");
		
		CellStyle style = shBook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
    	style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
    	style.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style.setBorderRight(CellStyle.BORDER_THIN);
    	style.setBorderTop(CellStyle.BORDER_THICK);
    	style.setBorderLeft(CellStyle.BORDER_THICK);
    	style.setBorderBottom(CellStyle.BORDER_THIN);
    	style.setFont(font1);
    	
    	CellStyle style1 = shBook.createCellStyle();
    	style1.setAlignment(CellStyle.ALIGN_CENTER);
    	style1.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
    	style1.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style1.setBorderRight(CellStyle.BORDER_THICK);
    	style1.setBorderLeft(CellStyle.BORDER_THIN);
    	style1.setBorderTop(CellStyle.BORDER_THICK);
    	style1.setBorderBottom(CellStyle.BORDER_THIN);
    	
    	CellStyle style2 = shBook.createCellStyle();
    	style2.setAlignment(CellStyle.ALIGN_CENTER);
    	style2.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
    	style2.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style2.setBorderRight(CellStyle.BORDER_THIN);
    	style2.setBorderLeft(CellStyle.BORDER_THIN);
    	style2.setBorderTop(CellStyle.BORDER_THICK);
    	style2.setBorderBottom(CellStyle.BORDER_THIN);
    	style2.setFont(font1);
    	//----------------------------------------
    	CellStyle style3 = shBook.createCellStyle();
    	style3.setAlignment(CellStyle.ALIGN_CENTER);
    	style3.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
    	style3.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style3.setBorderRight(CellStyle.BORDER_THICK);
    	style3.setBorderLeft(CellStyle.BORDER_THIN);
    	style3.setBorderTop(CellStyle.BORDER_THIN);
    	style3.setBorderBottom(CellStyle.BORDER_THICK);

    	CellStyle style4 = shBook.createCellStyle();
    	style4.setAlignment(CellStyle.ALIGN_CENTER);
    	style4.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
    	style4.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style4.setBorderRight(CellStyle.BORDER_THIN);
    	style4.setBorderLeft(CellStyle.BORDER_THIN);
    	style4.setBorderTop(CellStyle.BORDER_THIN);
    	style4.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	CellStyle style5 = shBook.createCellStyle();
    	style5.setAlignment(CellStyle.ALIGN_CENTER);
    	style5.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
    	style5.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style5.setBorderRight(CellStyle.BORDER_THIN);
    	style5.setBorderLeft(CellStyle.BORDER_THICK);
    	style5.setBorderTop(CellStyle.BORDER_THIN);
    	style5.setBorderBottom(CellStyle.BORDER_THICK);
    	
    	CellStyle style6 = shBook.createCellStyle();
    	style6.setAlignment(CellStyle.ALIGN_CENTER);
    	style6.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
    	style6.setFillPattern(CellStyle.SOLID_FOREGROUND);
    	style6.setBorderRight(CellStyle.BORDER_NONE);
    	style6.setBorderLeft(CellStyle.BORDER_NONE);
    	style6.setBorderTop(CellStyle.BORDER_NONE);
    	style6.setBorderBottom(CellStyle.BORDER_NONE);
		
    	int colStartIndex = 0; 
    	int colEndIndex = 0;
    	
    	shSheet.setColumnHidden(0, true); 
    	shSheet.setDisplayGridlines(false);
    	
		//헤더
		for(int i=0; i<2; i++) {
			if(i == 0) {
				row = shSheet.createRow(i+headerRow);
				
				cell = row.createCell(1);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style);
				
				cell = row.createCell(2);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(3);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(4);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style1);
				
				//P01~P12
				cell = row.createCell(5);
				cell.setCellType(1);
				cell.setCellValue(headerNm[0]);
				cell.setCellStyle(style2);
				colStartIndex = cell.getCellNum();
				
				cell = row.createCell(6);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(7);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(8);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(9);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(10);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(11);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(12);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(13);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(14);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(15);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(16);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(17);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(18);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(19);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(20);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(21);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(22);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(23);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(24);
				cell.setCellType(1);
				cell.setCellValue(headerNm[1]);
				cell.setCellStyle(style2);
				
				cell = row.createCell(25);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(26);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(27);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(28);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(29);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(30);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(31);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(32);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(33);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(34);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(35);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(36);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(37);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(38);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(39);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(40);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(41);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(42);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style1);
				
				cell = row.createCell(44);
				cell.setCellType(1);
				cell.setCellValue(headerNm[2]);
				cell.setCellStyle(style);
				colStartIndex = cell.getCellNum();
				
				cell = row.createCell(45);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(46);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(47);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(48);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(49);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(50);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(51);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(52);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(53);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(54);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(55);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(56);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(57);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(58);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(59);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(60);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(61);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(62);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(63);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(64);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(65);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(66);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(67);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(68);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style2);
				
				cell = row.createCell(69);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style1);
				
				if(headerNm.length >= 4) {
					cell = row.createCell(71);
					cell.setCellType(1);
					cell.setCellValue(headerNm[3]);
					cell.setCellStyle(style);
					colStartIndex = cell.getCellNum();
					
					cell = row.createCell(72);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(73);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(74);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(75);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(76);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(77);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(78);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(79);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(80);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(81);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(82);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(83);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(84);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(85);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(86);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(87);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(88);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(89);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(90);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(91);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(92);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(93);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(94);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(95);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style2);
					
					cell = row.createCell(96);
					cell.setCellType(1);
					cell.setCellValue("");
					cell.setCellStyle(style1);
					
				}
				
				shSheet.addMergedRegion(new Region(( int) i+headerRow , ( short )5 , ( int) i+headerRow, (short )23 ));
				shSheet.addMergedRegion(new Region(( int) i+headerRow , ( short )24 , ( int) i+headerRow, (short )42 ));
				shSheet.addMergedRegion(new Region(( int) i+headerRow , ( short )44 , ( int) i+headerRow, (short )69 ));
				shSheet.addMergedRegion(new Region(( int) i+headerRow , ( short )71 , ( int) i+headerRow, (short )95 ));
			}
			else {
 				row = shSheet.createRow(i+headerRow);
				
				cell = row.createCell(1);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style5);
				
				cell = row.createCell(2);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style4);
				
				cell = row.createCell(3);
				cell.setCellType(1);
				cell.setCellValue("");
				
				cell.setCellStyle(style4);
				
				cell = row.createCell(4);
				cell.setCellType(1);
				cell.setCellValue("");
				cell.setCellStyle(style3);
				
				//P01~P12
				cell = row.createCell(5);
				cell.setCellType(1);
				cell.setCellValue("P01");
				cell.setCellStyle(style4);
				colStartIndex = cell.getCellNum();
				
				cell = row.createCell(6);
				cell.setCellType(1);
				cell.setCellValue("P02");
				cell.setCellStyle(style4);
				
				cell = row.createCell(7);
				cell.setCellType(1);
				cell.setCellValue("P03");
				cell.setCellStyle(style4);
				
				cell = row.createCell(8);
				cell.setCellType(1);
				cell.setCellValue("P04");
				cell.setCellStyle(style4);
				
				cell = row.createCell(9);
				cell.setCellType(1);
				cell.setCellValue("P05");
				cell.setCellStyle(style4);
				
				cell = row.createCell(10);
				cell.setCellType(1);
				cell.setCellValue("P06");
				cell.setCellStyle(style4);
				
				cell = row.createCell(11);
				cell.setCellType(1);
				cell.setCellValue("P07");
				cell.setCellStyle(style4);
				
				cell = row.createCell(12);
				cell.setCellType(1);
				cell.setCellValue("P08");
				cell.setCellStyle(style4);
				
				cell = row.createCell(13);
				cell.setCellType(1);
				cell.setCellValue("P09");
				cell.setCellStyle(style4);
				
				cell = row.createCell(14);
				cell.setCellType(1);
				cell.setCellValue("P10");
				cell.setCellStyle(style4);
				
				cell = row.createCell(15);
				cell.setCellType(1);
				cell.setCellValue("P11");
				cell.setCellStyle(style4);
				
				cell = row.createCell(16);
				cell.setCellType(1);
				cell.setCellValue("P12");
				cell.setCellStyle(style4);
				
				cell = row.createCell(17);
				cell.setCellType(1);
				cell.setCellValue("Q1");
				cell.setCellStyle(style4);
				
				cell = row.createCell(18);
				cell.setCellType(1);
				cell.setCellValue("Q2");
				cell.setCellStyle(style4);
				
				cell = row.createCell(19);
				cell.setCellType(1);
				cell.setCellValue("Q3");
				cell.setCellStyle(style4);
				
				cell = row.createCell(20);
				cell.setCellType(1);
				cell.setCellValue("Q4");
				cell.setCellStyle(style4);
				
				cell = row.createCell(21);
				cell.setCellType(1);
				cell.setCellValue("H1");
				cell.setCellStyle(style4);
				
				cell = row.createCell(22);
				cell.setCellType(1);
				cell.setCellValue("H2");
				cell.setCellStyle(style4);
				
				cell = row.createCell(23);
				cell.setCellType(1);
				cell.setCellValue("YTD");
				cell.setCellStyle(style4);
				
				cell = row.createCell(24);
				cell.setCellType(1);
				cell.setCellValue("P01");
				cell.setCellStyle(style4);
				
				cell = row.createCell(25);
				cell.setCellType(1);
				cell.setCellValue("P02");
				cell.setCellStyle(style4);
				
				cell = row.createCell(26);
				cell.setCellType(1);
				cell.setCellValue("P03");
				cell.setCellStyle(style4);
				
				cell = row.createCell(27);
				cell.setCellType(1);
				cell.setCellValue("P04");
				cell.setCellStyle(style4);
				
				cell = row.createCell(28);
				cell.setCellType(1);
				cell.setCellValue("P05");
				cell.setCellStyle(style4);
				
				cell = row.createCell(29);
				cell.setCellType(1);
				cell.setCellValue("P06");
				cell.setCellStyle(style4);
				
				cell = row.createCell(30);
				cell.setCellType(1);
				cell.setCellValue("P07");
				cell.setCellStyle(style4);
				
				cell = row.createCell(31);
				cell.setCellType(1);
				cell.setCellValue("P08");
				cell.setCellStyle(style4);
				
				cell = row.createCell(32);
				cell.setCellType(1);
				cell.setCellValue("P09");
				cell.setCellStyle(style4);
				
				cell = row.createCell(33);
				cell.setCellType(1);
				cell.setCellValue("P10");
				cell.setCellStyle(style4);
				
				cell = row.createCell(34);
				cell.setCellType(1);
				cell.setCellValue("P11");
				cell.setCellStyle(style4);
				
				cell = row.createCell(35);
				cell.setCellType(1);
				cell.setCellValue("P12");
				cell.setCellStyle(style4);
				
				cell = row.createCell(36);
				cell.setCellType(1);
				cell.setCellValue("Q1");
				cell.setCellStyle(style4);
				
				cell = row.createCell(37);
				cell.setCellType(1);
				cell.setCellValue("Q2");
				cell.setCellStyle(style4);
				
				cell = row.createCell(38);
				cell.setCellType(1);
				cell.setCellValue("Q3");
				cell.setCellStyle(style4);
				
				cell = row.createCell(39);
				cell.setCellType(1);
				cell.setCellValue("Q4");
				cell.setCellStyle(style4);
				
				cell = row.createCell(40);
				cell.setCellType(1);
				cell.setCellValue("H1");
				cell.setCellStyle(style4);
				
				cell = row.createCell(41);
				cell.setCellType(1);
				cell.setCellValue("H2");
				cell.setCellStyle(style4);
				
				cell = row.createCell(42);
				cell.setCellType(1);
				cell.setCellValue("YTD");
				cell.setCellStyle(style3);
				colEndIndex = cell.getCellNum();
				if(!param.get("allData").equals("Y")) {
					hideCell(param, colStartIndex, colEndIndex, shSheet, row);
				}
				
				cell = row.createCell(44);
				cell.setCellType(1);
				cell.setCellValue("P01");
				cell.setCellStyle(style5);
				colStartIndex = cell.getCellNum();
				
				cell = row.createCell(45);
				cell.setCellType(1);
				cell.setCellValue("P02");
				cell.setCellStyle(style4);
				
				cell = row.createCell(46);
				cell.setCellType(1);
				cell.setCellValue("P03");
				cell.setCellStyle(style4);
				
				cell = row.createCell(47);
				cell.setCellType(1);
				cell.setCellValue("P04");
				cell.setCellStyle(style4);
				
				cell = row.createCell(48);
				cell.setCellType(1);
				cell.setCellValue("P05");
				cell.setCellStyle(style4);
				
				cell = row.createCell(49);
				cell.setCellType(1);
				cell.setCellValue("P06");
				cell.setCellStyle(style4);
				
				cell = row.createCell(50);
				cell.setCellType(1);
				cell.setCellValue("P07");
				cell.setCellStyle(style4);
				
				cell = row.createCell(51);
				cell.setCellType(1);
				cell.setCellValue("P08");
				cell.setCellStyle(style4);
				
				cell = row.createCell(52);
				cell.setCellType(1);
				cell.setCellValue("P09");
				cell.setCellStyle(style4);
				
				cell = row.createCell(53);
				cell.setCellType(1);
				cell.setCellValue("P10");
				cell.setCellStyle(style4);
				
				cell = row.createCell(54);
				cell.setCellType(1);
				cell.setCellValue("P11");
				cell.setCellStyle(style4);
				
				cell = row.createCell(55);
				cell.setCellType(1);
				cell.setCellValue("P12");
				cell.setCellStyle(style4);
				
				cell = row.createCell(56);
				cell.setCellType(1);
				cell.setCellValue("Q1");
				cell.setCellStyle(style4);
				
				cell = row.createCell(57);
				cell.setCellType(1);
				cell.setCellValue("Q2");
				cell.setCellStyle(style4);
				
				cell = row.createCell(58);
				cell.setCellType(1);
				cell.setCellValue("Q3");
				cell.setCellStyle(style4);
				
				cell = row.createCell(59);
				cell.setCellType(1);
				cell.setCellValue("Q4");
				cell.setCellStyle(style4);
				
				cell = row.createCell(60);
				cell.setCellType(1);
				cell.setCellValue("H1");
				cell.setCellStyle(style4);
				
				cell = row.createCell(61);
				cell.setCellType(1);
				cell.setCellValue("H2");
				cell.setCellStyle(style4);
				
				cell = row.createCell(62);
				cell.setCellType(1);
				cell.setCellValue("YTD");
				cell.setCellStyle(style4);
				
				cell = row.createCell(63);
				cell.setCellType(1);
				cell.setCellValue("Q1신호등");
				cell.setCellStyle(style4);
				
				cell = row.createCell(64);
				cell.setCellType(1);
				cell.setCellValue("Q2신호등");
				cell.setCellStyle(style4);
				
				cell = row.createCell(65);
				cell.setCellType(1);
				cell.setCellValue("Q3신호등");
				cell.setCellStyle(style4);
				
				cell = row.createCell(66);
				cell.setCellType(1);
				cell.setCellValue("Q4신호등");
				cell.setCellStyle(style4);
				
				cell = row.createCell(67);
				cell.setCellType(1);
				cell.setCellValue("H1신호등");
				cell.setCellStyle(style4);
				
				cell = row.createCell(68);
				cell.setCellType(1);
				cell.setCellValue("H2신호등");
				cell.setCellStyle(style4);
				
				cell = row.createCell(69);
				cell.setCellType(1);
				cell.setCellValue("YTD신호등");
				cell.setCellStyle(style3);
				colEndIndex = cell.getCellNum();
				if(!param.get("allData").equals("Y")) {
					hideCell(param, colStartIndex, colEndIndex, shSheet, row);
				}
				
				if(headerNm.length >= 4) {
					cell = row.createCell(71);
					cell.setCellType(1);
					cell.setCellValue("P01");
					cell.setCellStyle(style5);
					colStartIndex = cell.getCellNum();
					
					cell = row.createCell(72);
					cell.setCellType(1);
					cell.setCellValue("P02");
					cell.setCellStyle(style4);
					
					cell = row.createCell(73);
					cell.setCellType(1);
					cell.setCellValue("P03");
					cell.setCellStyle(style4);
					
					cell = row.createCell(74);
					cell.setCellType(1);
					cell.setCellValue("P04");
					cell.setCellStyle(style4);
					
					cell = row.createCell(75);
					cell.setCellType(1);
					cell.setCellValue("P05");
					cell.setCellStyle(style4);
					
					cell = row.createCell(76);
					cell.setCellType(1);
					cell.setCellValue("P06");
					cell.setCellStyle(style4);
					
					cell = row.createCell(77);
					cell.setCellType(1);
					cell.setCellValue("P07");
					cell.setCellStyle(style4);
					
					cell = row.createCell(78);
					cell.setCellType(1);
					cell.setCellValue("P08");
					cell.setCellStyle(style4);
					
					cell = row.createCell(79);
					cell.setCellType(1);
					cell.setCellValue("P09");
					cell.setCellStyle(style4);
					
					cell = row.createCell(80);
					cell.setCellType(1);
					cell.setCellValue("P10");
					cell.setCellStyle(style4);
					
					cell = row.createCell(81);
					cell.setCellType(1);
					cell.setCellValue("P11");
					cell.setCellStyle(style4);
					
					cell = row.createCell(82);
					cell.setCellType(1);
					cell.setCellValue("P12");
					cell.setCellStyle(style4);
					
					cell = row.createCell(83);
					cell.setCellType(1);
					cell.setCellValue("Q1");
					cell.setCellStyle(style4);
					
					cell = row.createCell(84);
					cell.setCellType(1);
					cell.setCellValue("Q2");
					cell.setCellStyle(style4);
					
					cell = row.createCell(85);
					cell.setCellType(1);
					cell.setCellValue("Q3");
					cell.setCellStyle(style4);
					
					cell = row.createCell(86);
					cell.setCellType(1);
					cell.setCellValue("Q4");
					cell.setCellStyle(style4);
					
					cell = row.createCell(87);
					cell.setCellType(1);
					cell.setCellValue("H1");
					cell.setCellStyle(style4);
					
					cell = row.createCell(88);
					cell.setCellType(1);
					cell.setCellValue("H2");
					cell.setCellStyle(style4);
					
					cell = row.createCell(89);
					cell.setCellType(1);
					cell.setCellValue("YTD");
					cell.setCellStyle(style4);
					
					cell = row.createCell(90);
					cell.setCellType(1);
					cell.setCellValue("Q1신호등");
					cell.setCellStyle(style4);
					
					cell = row.createCell(91);
					cell.setCellType(1);
					cell.setCellValue("Q2신호등");
					cell.setCellStyle(style4);
					
					cell = row.createCell(92);
					cell.setCellType(1);
					cell.setCellValue("Q3신호등");
					cell.setCellStyle(style4);
					
					cell = row.createCell(93);
					cell.setCellType(1);
					cell.setCellValue("Q4신호등");
					cell.setCellStyle(style4);
					
					cell = row.createCell(94);
					cell.setCellType(1);
					cell.setCellValue("H1신호등");
					cell.setCellStyle(style4);
					
					cell = row.createCell(95);
					cell.setCellType(1);
					cell.setCellValue("H2신호등");
					cell.setCellStyle(style4);
					
					cell = row.createCell(96);
					cell.setCellType(1);
					cell.setCellValue("YTD신호등");
					cell.setCellStyle(style3);
					
					colEndIndex = cell.getCellNum();
					if(!param.get("allData").equals("Y")) {
						hideCell(param, colStartIndex, colEndIndex, shSheet, row);
					}
				}
				shSheet.addMergedRegion(new Region(( int) i+headerRow-1 , ( short )1 , ( int) i+headerRow, (short )4 ));
			}
			
		}
		
		return row.getRowNum()+1;
	}
	
	//YTD 계산
	public double setAcYTD(Map param, Map map, String actual) {
		double sumYTD = 0;
		for(int j=1; j<=12; j++) {
			String key = String.valueOf(j);
			if(key.length() < 2) {
				key = "P0".concat(key);
			}
			else {
				key = "P".concat(key);
			}
			
			if(param.get("ytd").toString().equals(key)){
				sumYTD += Double.parseDouble(String.valueOf(map.get(actual+"_AC_"+key)));
				break;
			}
			else {
				sumYTD += Double.parseDouble(String.valueOf(map.get(actual+"_AC_"+key)));
			}
		}
		
		return sumYTD;
	}
	
	public double setForYTD(Map param, Map map, String forecast) {
		double sumYTD = 0;
		
		for(int j=1; j<=12; j++) {
			String key = String.valueOf(j);
			if(key.length() < 2) {
				key = "P0".concat(key);
			}
			else {
				key = "P".concat(key);
			}
			
			if(param.get("ytd").toString().equals(key)){
				sumYTD += Double.parseDouble(String.valueOf(map.get(forecast+"_FOR_"+key)));
				break;
			}
			else {
				sumYTD += Double.parseDouble(String.valueOf(map.get(forecast+"_FOR_"+key)));
			}
		}
		
		return sumYTD;
	}
	
	public double setOutYTD(Map param, Map map, String outlook) {
		double sumYTD = 0;
		
			for(int j=1; j<=12; j++) {
			String key = String.valueOf(j);
			if(key.length() < 2) {
				key = "P0".concat(key);
			}
			else {
				key = "P".concat(key);
			}
			
			if(param.get("ytd").toString().equals(key)){
				sumYTD += Double.parseDouble(String.valueOf(map.get(outlook+"_OUT_"+key)));
				break;
			}
			else {
				sumYTD += Double.parseDouble(String.valueOf(map.get(outlook+"_OUT_"+key)));
			}
		}
		
		return sumYTD;
	}
	
	public double setTgYTD(Map param, Map map, String target) {
		double sumYTD = 0;
		
		for(int j=1; j<=12; j++) {
			String key = String.valueOf(j);
			if(key.length() < 2) {
				key = "P0".concat(key);
			}
			else {
				key = "P".concat(key);
			}
			
			if(param.get("ytd").toString().equals(key)){
				sumYTD += Double.parseDouble(String.valueOf(map.get(target+"_TG_"+key)));
				break;
			}
			else {
				sumYTD += Double.parseDouble(String.valueOf(map.get(target+"_TG_"+key)));
			}
		}
		
		return sumYTD;
	}
	
	// Calc1 : Forecast Accuracy% vs. Forecast =(F15 Actual (Outlook)-F15 Forecast) / F15 Forecast
	// Calc2 : Achievement% vs. Target= F15 Actual (Outlook)/F15 Target
	// Calc3 : Growth Rate% vs. F14=(F15 Actual (Outlook) /F14 Actual)-1
	
	// try{resultData = (Outlook-foreCast) / foreCast;} catch(ArithmeticException  ae){resultData = 0;}
	// try{resultData = (Outlook / Target);} catch(ArithmeticException  ae){resultData = 0;}
	// try{resultData = (Outlook-Actual) - 1;} catch(ArithmeticException  ae){resultData = 0;}
	
	public ArrayList<Map> shipmentCalC(ArrayList<Map> list){
		
		ArrayList<Map> originalList = list; // 원본 데이터
		ArrayList<Map> mergeList = list;	// 합병 데이터
		ArrayList<Map> resultList = new ArrayList<Map>();	// 계산 데이터
		
		for(int i=0; i<list.size(); i++){
			Map record = new LinkedHashMap();
			for(int cell=1; cell<=19; cell++){
				
				if(cell == 1){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P01"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P01"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P01"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P01"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}

					record.put("SH_CALC1_P01", Calc1);
					record.put("SH_CALC2_P01", Calc2);
					record.put("SH_CALC3_P01", Calc3);
					
				}else if(cell== 2){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P02"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P02"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P02"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P02"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P02", Calc1);
					record.put("SH_CALC2_P02", Calc2);
					record.put("SH_CALC3_P02", Calc3);
	
				}else if(cell== 3){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P03"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P03"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P03"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P03"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P03", Calc1);
					record.put("SH_CALC2_P03", Calc2);
					record.put("SH_CALC3_P03", Calc3);
	
				}else if(cell== 4){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P04"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P04"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P04"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P04"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P04", Calc1);
					record.put("SH_CALC2_P04", Calc2);
					record.put("SH_CALC3_P04", Calc3);
	
				}else if(cell== 5){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P05"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P05"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P05"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P05"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P05", Calc1);
					record.put("SH_CALC2_P05", Calc2);
					record.put("SH_CALC3_P05", Calc3);
	
				}else if(cell== 6){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P06"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P06"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P06"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P06"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P06", Calc1);
					record.put("SH_CALC2_P06", Calc2);
					record.put("SH_CALC3_P06", Calc3);
	
				}else if(cell== 7){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P07"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P07"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P07"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P07"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P07", Calc1);
					record.put("SH_CALC2_P07", Calc2);
					record.put("SH_CALC3_P07", Calc3);
	
				}else if(cell== 8){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P08"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P08"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P08"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P08"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P08", Calc1);
					record.put("SH_CALC2_P08", Calc2);
					record.put("SH_CALC3_P08", Calc3);
	
				}else if(cell== 9){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P09"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P09"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P09"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P09"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P09", Calc1);
					record.put("SH_CALC2_P09", Calc2);
					record.put("SH_CALC3_P09", Calc3);
	
				}else if(cell== 10){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P10"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P10"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P10"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P10"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P10", Calc1);
					record.put("SH_CALC2_P10", Calc2);
					record.put("SH_CALC3_P10", Calc3);
	
				}else if(cell== 11){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P11"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P11"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P11"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P11"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P11", Calc1);
					record.put("SH_CALC2_P11", Calc2);
					record.put("SH_CALC3_P11", Calc3);
	
				}else if(cell== 12){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_P12"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_P12"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_P12"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_P12"));
					
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_P12", Calc1);
					record.put("SH_CALC2_P12", Calc2);
					record.put("SH_CALC3_P12", Calc3);
	
				}else if(cell == 13){
					double ActualQ1 = 0;
					double foreCastQ1 = 0;
					double OutlookQ1 = 0;
					double TargetQ1 = 0;
					
					double Calc1Q1 = 0;
					double Calc2Q1 = 0;
					double Calc3Q1 = 0;
					
					for(int j=1; j<=3; j++){
						String ActualKey = "SH_AC_P0"+j;
						String foreCastKey = "SH_FOR_P0"+j;
						String OutlookKey = "SH_OUT_P0"+j;
						String TargetKey = "SH_TG_P0"+j;
						
						String ActualValue = String.valueOf(list.get(i).get(ActualKey));
						String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
						String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
						String TargetValue = String.valueOf(list.get(i).get(TargetKey));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						ActualQ1 += Actual;
						foreCastQ1 += foreCast;
						OutlookQ1 += Outlook;
						TargetQ1 += Target;
					}
					
					try{if(OutlookQ1 == 0 || foreCastQ1 == 0){Calc1Q1 = 0.0;}else{Calc1Q1 = (OutlookQ1 - foreCastQ1) / foreCastQ1;}}catch(ArithmeticException ae){Calc1Q1 = 0.0;}
					try{if(OutlookQ1 == 0 || TargetQ1 == 0){Calc2Q1 = 0.0;}else{Calc2Q1 = OutlookQ1 / TargetQ1;}}catch(ArithmeticException ae){Calc2Q1 = 0.0;}
					try{if(OutlookQ1 == 0 || ActualQ1 == 0){Calc3Q1 = 0.0;}else{Calc3Q1 = (OutlookQ1 / ActualQ1) - 1;}}catch(ArithmeticException ae){Calc3Q1 = 0.0;}
					
					record.put("SH_CALC1_Q1", Calc1Q1);
					record.put("SH_CALC2_Q1", Calc2Q1);
					record.put("SH_CALC3_Q1", Calc3Q1);
					
				}else if(cell == 14){
					double ActualQ2 = 0;
					double foreCastQ2 = 0;
					double OutlookQ2 = 0;
					double TargetQ2 = 0;
					
					double Calc1Q2 = 0;
					double Calc2Q2 = 0;
					double Calc3Q2 = 0;
					
					for(int j=4; j<=6; j++){
						String ActualKey = "SH_AC_P0"+j;
						String foreCastKey = "SH_FOR_P0"+j;
						String OutlookKey = "SH_OUT_P0"+j;
						String TargetKey = "SH_TG_P0"+j;
						
						String ActualValue = String.valueOf(list.get(i).get(ActualKey));
						String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
						String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
						String TargetValue = String.valueOf(list.get(i).get(TargetKey));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						ActualQ2 += Actual;
						foreCastQ2 += foreCast;
						OutlookQ2 += Outlook;
						TargetQ2 += Target;
					}
					
					try{if(OutlookQ2 == 0 || foreCastQ2 == 0){Calc1Q2 = 0.0;}else{Calc1Q2 = (OutlookQ2 - foreCastQ2) / foreCastQ2;}}catch(ArithmeticException ae){Calc1Q2 = 0.0;}
					try{if(OutlookQ2 == 0 || TargetQ2 == 0){Calc2Q2 = 0.0;}else{Calc2Q2 = OutlookQ2 / TargetQ2;}}catch(ArithmeticException ae){Calc2Q2 = 0.0;}
					try{if(OutlookQ2 == 0 || ActualQ2 == 0){Calc3Q2 = 0.0;}else{Calc3Q2 = (OutlookQ2 / ActualQ2) - 1;}}catch(ArithmeticException ae){Calc3Q2 = 0.0;}
					
					record.put("SH_CALC1_Q2", Calc1Q2);
					record.put("SH_CALC2_Q2", Calc2Q2);
					record.put("SH_CALC3_Q2", Calc3Q2);
					
				}else if(cell == 15){
					double ActualQ3 = 0;
					double foreCastQ3 = 0;
					double OutlookQ3 = 0;
					double TargetQ3 = 0;
					
					double Calc1Q3 = 0;
					double Calc2Q3 = 0;
					double Calc3Q3 = 0;
					
					for(int j=7; j<=9; j++){
						String ActualKey = "SH_AC_P0"+j;
						String foreCastKey = "SH_FOR_P0"+j;
						String OutlookKey = "SH_OUT_P0"+j;
						String TargetKey = "SH_TG_P0"+j;
						
						String ActualValue = String.valueOf(list.get(i).get(ActualKey));
						String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
						String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
						String TargetValue = String.valueOf(list.get(i).get(TargetKey));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						ActualQ3 += Actual;
						foreCastQ3 += foreCast;
						OutlookQ3 += Outlook;
						TargetQ3 += Target;
					}
					
					try{if(OutlookQ3 == 0 || foreCastQ3 == 0){Calc1Q3 = 0.0;}else{Calc1Q3 = (OutlookQ3 - foreCastQ3) / foreCastQ3;}}catch(ArithmeticException ae){Calc1Q3 = 0.0;}
					try{if(OutlookQ3 == 0 || TargetQ3 == 0){Calc2Q3 = 0.0;}else{Calc2Q3 = OutlookQ3 / TargetQ3;}}catch(ArithmeticException ae){Calc2Q3 = 0.0;}
					try{if(OutlookQ3 == 0 || ActualQ3 == 0){Calc3Q3 = 0.0;}else{Calc3Q3 = (OutlookQ3 / ActualQ3) - 1;}}catch(ArithmeticException ae){Calc3Q3 = 0.0;}
					
					record.put("SH_CALC1_Q3", Calc1Q3);
					record.put("SH_CALC2_Q3", Calc2Q3);
					record.put("SH_CALC3_Q3", Calc3Q3);
					
				}else if(cell == 16){
					double ActualQ4 = 0;
					double foreCastQ4 = 0;
					double OutlookQ4 = 0;
					double TargetQ4 = 0;
					
					double Calc1Q4 = 0;
					double Calc2Q4 = 0;
					double Calc3Q4 = 0;
					
					for(int j=10; j<=12; j++){
						String ActualKey = "SH_AC_P"+j;
						String foreCastKey = "SH_FOR_P"+j;
						String OutlookKey = "SH_OUT_P"+j;
						String TargetKey = "SH_TG_P"+j;
						
						String ActualValue = String.valueOf(list.get(i).get(ActualKey));
						String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
						String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
						String TargetValue = String.valueOf(list.get(i).get(TargetKey));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						ActualQ4 += Actual;
						foreCastQ4 += foreCast;
						OutlookQ4 += Outlook;
						TargetQ4 += Target;
					}
					
					try{if(OutlookQ4 == 0 || foreCastQ4 == 0){Calc1Q4 = 0.0;}else{Calc1Q4 = (OutlookQ4 - foreCastQ4) / foreCastQ4;}}catch(ArithmeticException ae){Calc1Q4 = 0.0;}
					try{if(OutlookQ4 == 0 || TargetQ4 == 0){Calc2Q4 = 0.0;}else{Calc2Q4 = OutlookQ4 / TargetQ4;}}catch(ArithmeticException ae){Calc2Q4 = 0.0;}
					try{if(OutlookQ4 == 0 || ActualQ4 == 0){Calc3Q4 = 0.0;}else{Calc3Q4 = (OutlookQ4 / ActualQ4) - 1;}}catch(ArithmeticException ae){Calc3Q4 = 0.0;}
					
					record.put("SH_CALC1_Q4", Calc1Q4);
					record.put("SH_CALC2_Q4", Calc2Q4);
					record.put("SH_CALC3_Q4", Calc3Q4);
					
				}else if(cell == 17){
					double ActualH1 = 0;
					double foreCastH1 = 0;
					double OutlookH1 = 0;
					double TargetH1 = 0;
					
					double Calc1H1 = 0;
					double Calc2H1 = 0;
					double Calc3H1 = 0;
					
					for(int j=1; j<=6; j++){
						String ActualKey = "SH_AC_P0"+j;
						String foreCastKey = "SH_FOR_P0"+j;
						String OutlookKey = "SH_OUT_P0"+j;
						String TargetKey = "SH_TG_P0"+j;
						
						String ActualValue = String.valueOf(list.get(i).get(ActualKey));
						String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
						String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
						String TargetValue = String.valueOf(list.get(i).get(TargetKey));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						ActualH1 += Actual;
						foreCastH1 += foreCast;
						OutlookH1 += Outlook;
						TargetH1 += Target;
					}
					
					try{if(OutlookH1 == 0 || foreCastH1 == 0){Calc1H1 = 0.0;}else{Calc1H1 = (OutlookH1 - foreCastH1) / foreCastH1;}}catch(ArithmeticException ae){Calc1H1 = 0.0;}
					try{if(OutlookH1 == 0 || TargetH1 == 0){Calc2H1 = 0.0;}else{Calc2H1 = OutlookH1 / TargetH1;}}catch(ArithmeticException ae){Calc2H1 = 0.0;}
					try{if(OutlookH1 == 0 || ActualH1 == 0){Calc3H1 = 0.0;}else{Calc3H1 = (OutlookH1 / ActualH1) - 1;}}catch(ArithmeticException ae){Calc3H1 = 0.0;}
					
					record.put("SH_CALC1_H1", Calc1H1);
					record.put("SH_CALC2_H1", Calc2H1);
					record.put("SH_CALC3_H1", Calc3H1);
					
				}else if(cell == 18){
					double ActualH2 = 0;
					double foreCastH2 = 0;
					double OutlookH2 = 0;
					double TargetH2 = 0;
					
					double Calc1H2 = 0;
					double Calc2H2 = 0;
					double Calc3H2 = 0;
					
					for(int j=7; j<=12; j++){
						if(j == 7 || j == 8 || j == 9){
							String ActualKey = "SH_AC_P0"+j;
							String foreCastKey = "SH_FOR_P0"+j;
							String OutlookKey = "SH_OUT_P0"+j;
							String TargetKey = "SH_TG_P0"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualH2 += Actual;
							foreCastH2 += foreCast;
							OutlookH2 += Outlook;
							TargetH2 += Target;
						}else{
							String ActualKey = "SH_AC_P"+j;
							String foreCastKey = "SH_FOR_P"+j;
							String OutlookKey = "SH_OUT_P"+j;
							String TargetKey = "SH_TG_P"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualH2 += Actual;
							foreCastH2 += foreCast;
							OutlookH2 += Outlook;
							TargetH2 += Target;
						}
					}
					
					try{if(OutlookH2 == 0 || foreCastH2 == 0){Calc1H2 = 0.0;}else{Calc1H2 = (OutlookH2 - foreCastH2) / foreCastH2;}}catch(ArithmeticException ae){Calc1H2 = 0.0;}
					try{if(OutlookH2 == 0 || TargetH2 == 0){Calc2H2 = 0.0;}else{Calc2H2 = OutlookH2 / TargetH2;}}catch(ArithmeticException ae){Calc2H2 = 0.0;}
					try{if(OutlookH2 == 0 || ActualH2 == 0){Calc3H2 = 0.0;}else{Calc3H2 = (OutlookH2 / ActualH2) - 1;}}catch(ArithmeticException ae){Calc3H2 = 0.0;}
					
					record.put("SH_CALC1_H2", Calc1H2);
					record.put("SH_CALC2_H2", Calc2H2);
					record.put("SH_CALC3_H2", Calc3H2);
					
				}else if(cell == 19){
					String ActualValue = String.valueOf(list.get(i).get("SH_AC_YTD"));
					String foreCastValue = String.valueOf(list.get(i).get("SH_FOR_YTD"));
					String OutlookValue = String.valueOf(list.get(i).get("SH_OUT_YTD"));
					String TargetValue = String.valueOf(list.get(i).get("SH_TG_YTD"));
	
					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || foreCast == 0){Calc1 = 0.0;}else{Calc1 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || Actual == 0){Calc3 = 0.0;}else{Calc3 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("SH_CALC1_YTD", Calc1);
					record.put("SH_CALC2_YTD", Calc2);
					record.put("SH_CALC3_YTD", Calc3);
				}
			}

			resultList.add(record);
			mergeList.get(i).putAll(resultList.get(i));
		}
		return mergeList;
	}
	
	
	// Calc1 : Growth Rate% vs. F14=(F15 Actual (Outlook) /F14 Actual)-1
	// Calc2 : Achievement% vs. Target= F15 Actual (Outlook)/F15 Target
	// Calc3 : Forecast Accuracy% vs. Forecast =(F15 Actual (Outlook)-F15 Forecast) / F15 Forecast
	
	// try{Calc1 = (Outlook / Actual) - 1;} catch(ArithmeticException  ae){Calc1 = 0;}
	// try{Calc2 = (Outlook / Target);} catch(ArithmeticException  ae){Calc2 = 0;}
	// try{Calc3 = (Outlook - foreCast) / foreCast;} catch(ArithmeticException  ae){Calc3 = 0;}
	
	
	public ArrayList<Map> dcCalC(ArrayList<Map> list){
		ArrayList<Map> originalList = list; // 원본 데이터
		ArrayList<Map> mergeList = list;	// 합병 데이터
		ArrayList<Map> resultList = new ArrayList<Map>();	// 계산 데이터
		
		for(int i=0; i<list.size(); i++){
			Map record = new LinkedHashMap();
			for(int cell=1; cell<=19; cell++){
				
				double Calc2_WS = 0;
				double Calc2_GSV = 0;
				
				if(i < 6) {
					if(cell == 1){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P01"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P01"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P01"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P01"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						System.out.println("★ : " + Calc1);
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
	
						record.put("DC_CALC1_P01", Calc1);
						record.put("DC_CALC2_P01", Calc2);
						record.put("DC_CALC3_P01", Calc3);
						
					}else if(cell== 2){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P02"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P02"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P02"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P02"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P02", Calc1);
						record.put("DC_CALC2_P02", Calc2);
						record.put("DC_CALC3_P02", Calc3);
		
					}else if(cell== 3){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P03"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P03"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P03"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P03"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P03", Calc1);
						record.put("DC_CALC2_P03", Calc2);
						record.put("DC_CALC3_P03", Calc3);
		
					}else if(cell== 4){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P04"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P04"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P04"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P04"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P04", Calc1);
						record.put("DC_CALC2_P04", Calc2);
						record.put("DC_CALC3_P04", Calc3);
		
					}else if(cell== 5){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P05"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P05"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P05"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P05"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P05", Calc1);
						record.put("DC_CALC2_P05", Calc2);
						record.put("DC_CALC3_P05", Calc3);
		
					}else if(cell== 6){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P06"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P06"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P06"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P06"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P06", Calc1);
						record.put("DC_CALC2_P06", Calc2);
						record.put("DC_CALC3_P06", Calc3);
		
					}else if(cell== 7){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P07"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P07"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P07"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P07"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P07", Calc1);
						record.put("DC_CALC2_P07", Calc2);
						record.put("DC_CALC3_P07", Calc3);
		
					}else if(cell== 8){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P08"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P08"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P08"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P08"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P08", Calc1);
						record.put("DC_CALC2_P08", Calc2);
						record.put("DC_CALC3_P08", Calc3);
		
					}else if(cell== 9){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P09"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P09"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P09"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P09"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P09", Calc1);
						record.put("DC_CALC2_P09", Calc2);
						record.put("DC_CALC3_P09", Calc3);
		
					}else if(cell== 10){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P10"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P10"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P10"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P10"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P10", Calc1);
						record.put("DC_CALC2_P10", Calc2);
						record.put("DC_CALC3_P10", Calc3);
		
					}else if(cell== 11){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P11"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P11"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P11"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P11"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P11", Calc1);
						record.put("DC_CALC2_P11", Calc2);
						record.put("DC_CALC3_P11", Calc3);
		
					}else if(cell== 12){	
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P12"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P12"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P12"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P12"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P12", Calc1);
						record.put("DC_CALC2_P12", Calc2);
						record.put("DC_CALC3_P12", Calc3);
		
					}else if(cell == 13){
						double ActualQ1 = 0;
						double foreCastQ1 = 0;
						double OutlookQ1 = 0;
						double TargetQ1 = 0;
						
						double Calc1Q1 = 0;
						double Calc2Q1 = 0;
						double Calc3Q1 = 0;
						
						for(int j=1; j<=3; j++){
							String ActualKey = "DC_AC_P0"+j;
							String foreCastKey = "DC_FOR_P0"+j;
							String OutlookKey = "DC_OUT_P0"+j;
							String TargetKey = "DC_TG_P0"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualQ1 += Actual;
							foreCastQ1 += foreCast;
							OutlookQ1 += Outlook;
							TargetQ1 += Target;
						}
						
						Calc1Q1 = (OutlookQ1 / ActualQ1) - 1;
						try{if(OutlookQ1 == 0 || TargetQ1 == 0){Calc2Q1 = 0.0;}else{Calc2Q1 = OutlookQ1 / TargetQ1;}}catch(ArithmeticException ae){Calc2Q1 = 0.0;}
						try{if(OutlookQ1 == 0 || foreCastQ1 == 0){Calc3Q1 = 0.0;}else{Calc3Q1 = (OutlookQ1 - foreCastQ1) / foreCastQ1;}}catch(ArithmeticException ae){Calc3Q1 = 0.0;}
						
						record.put("DC_CALC1_Q1", Calc1Q1);
						record.put("DC_CALC2_Q1", Calc2Q1);
						record.put("DC_CALC3_Q1", Calc3Q1);
					}else if(cell == 14){
						double ActualQ2 = 0;
						double foreCastQ2 = 0;
						double OutlookQ2 = 0;
						double TargetQ2 = 0;
						
						double Calc1Q2 = 0;
						double Calc2Q2 = 0;
						double Calc3Q2 = 0;
						
						for(int j=4; j<=6; j++){
							String ActualKey = "DC_AC_P0"+j;
							String foreCastKey = "DC_FOR_P0"+j;
							String OutlookKey = "DC_OUT_P0"+j;
							String TargetKey = "DC_TG_P0"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualQ2 += Actual;
							foreCastQ2 += foreCast;
							OutlookQ2 += Outlook;
							TargetQ2 += Target;
						}
						
						Calc1Q2 = (OutlookQ2 / ActualQ2) - 1;
						try{if(OutlookQ2 == 0 || TargetQ2 == 0){Calc2Q2 = 0.0;}else{Calc2Q2 = OutlookQ2 / TargetQ2;}}catch(ArithmeticException ae){Calc2Q2 = 0.0;}
						try{if(OutlookQ2 == 0 || foreCastQ2 == 0){Calc3Q2 = 0.0;}else{Calc3Q2 = (OutlookQ2 - foreCastQ2) / foreCastQ2;}}catch(ArithmeticException ae){Calc3Q2 = 0.0;}
						
						record.put("DC_CALC1_Q2", Calc1Q2);
						record.put("DC_CALC2_Q2", Calc2Q2);
						record.put("DC_CALC3_Q2", Calc3Q2);
						
					}else if(cell == 15){
						double ActualQ3 = 0;
						double foreCastQ3 = 0;
						double OutlookQ3 = 0;
						double TargetQ3 = 0;
						
						double Calc1Q3 = 0;
						double Calc2Q3 = 0;
						double Calc3Q3 = 0;
						
						for(int j=7; j<=9; j++){
							String ActualKey = "DC_AC_P0"+j;
							String foreCastKey = "DC_FOR_P0"+j;
							String OutlookKey = "DC_OUT_P0"+j;
							String TargetKey = "DC_TG_P0"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualQ3 += Actual;
							foreCastQ3 += foreCast;
							OutlookQ3 += Outlook;
							TargetQ3 += Target;
						}
						
						Calc1Q3 = (OutlookQ3 / ActualQ3) - 1;
						try{if(OutlookQ3 == 0 || TargetQ3 == 0){Calc2Q3 = 0.0;}else{Calc2Q3 = OutlookQ3 / TargetQ3;}}catch(ArithmeticException ae){Calc2Q3 = 0.0;}
						try{if(OutlookQ3 == 0 || foreCastQ3 == 0){Calc3Q3 = 0.0;}else{Calc3Q3 = (OutlookQ3 - foreCastQ3) / foreCastQ3;}}catch(ArithmeticException ae){Calc3Q3 = 0.0;}
						
						record.put("DC_CALC1_Q3", Calc1Q3);
						record.put("DC_CALC2_Q3", Calc2Q3);
						record.put("DC_CALC3_Q3", Calc3Q3);
						
					}else if(cell == 16){
						double ActualQ4 = 0;
						double foreCastQ4 = 0;
						double OutlookQ4 = 0;
						double TargetQ4 = 0;
						
						double Calc1Q4 = 0;
						double Calc2Q4 = 0;
						double Calc3Q4 = 0;
						
						for(int j=10; j<=12; j++){
							String ActualKey = "DC_AC_P"+j;
							String foreCastKey = "DC_FOR_P"+j;
							String OutlookKey = "DC_OUT_P"+j;
							String TargetKey = "DC_TG_P"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualQ4 += Actual;
							foreCastQ4 += foreCast;
							OutlookQ4 += Outlook;
							TargetQ4 += Target;
						}
						
						Calc1Q4 = (OutlookQ4 / ActualQ4) - 1;
						try{if(OutlookQ4 == 0 || TargetQ4 == 0){Calc2Q4 = 0.0;}else{Calc2Q4 = OutlookQ4 / TargetQ4;}}catch(ArithmeticException ae){Calc2Q4 = 0.0;}
						try{if(OutlookQ4 == 0 || foreCastQ4 == 0){Calc3Q4 = 0.0;}else{Calc3Q4 = (OutlookQ4 - foreCastQ4) / foreCastQ4;}}catch(ArithmeticException ae){Calc3Q4 = 0.0;}
						
						record.put("DC_CALC1_Q4", Calc1Q4);
						record.put("DC_CALC2_Q4", Calc2Q4);
						record.put("DC_CALC3_Q4", Calc3Q4);
						
					}else if(cell == 17){
						double ActualH1 = 0;
						double foreCastH1 = 0;
						double OutlookH1 = 0;
						double TargetH1 = 0;
						
						double Calc1H1 = 0;
						double Calc2H1 = 0;
						double Calc3H1 = 0;
						
						for(int j=1; j<=6; j++){
							String ActualKey = "DC_AC_P0"+j;
							String foreCastKey = "DC_FOR_P0"+j;
							String OutlookKey = "DC_OUT_P0"+j;
							String TargetKey = "DC_TG_P0"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualH1 += Actual;
							foreCastH1 += foreCast;
							OutlookH1 += Outlook;
							TargetH1 += Target;
						}
						
						Calc1H1 = (OutlookH1 / ActualH1) - 1;
						try{if(OutlookH1 == 0 || TargetH1 == 0){Calc2H1 = 0.0;}else{Calc2H1 = OutlookH1 / TargetH1;}}catch(ArithmeticException ae){Calc2H1 = 0.0;}
						try{if(OutlookH1 == 0 || foreCastH1 == 0){Calc3H1 = 0.0;}else{Calc3H1 = (OutlookH1 - foreCastH1) / foreCastH1;}}catch(ArithmeticException ae){Calc3H1 = 0.0;}
						
						record.put("DC_CALC1_H1", Calc1H1);
						record.put("DC_CALC2_H1", Calc2H1);
						record.put("DC_CALC3_H1", Calc3H1);
						
					}else if(cell == 18){
						double ActualH2 = 0;
						double foreCastH2 = 0;
						double OutlookH2 = 0;
						double TargetH2 = 0;
						
						double Calc1H2 = 0;
						double Calc2H2 = 0;
						double Calc3H2 = 0;
						
						for(int j=7; j<=12; j++){
							if(j == 7 || j == 8 || j == 9){
								String ActualKey = "DC_AC_P0"+j;
								String foreCastKey = "DC_FOR_P0"+j;
								String OutlookKey = "DC_OUT_P0"+j;
								String TargetKey = "DC_TG_P0"+j;
								
								String ActualValue = String.valueOf(list.get(i).get(ActualKey));
								String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
								String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
								String TargetValue = String.valueOf(list.get(i).get(TargetKey));
								
								double Actual = Double.parseDouble(ActualValue);
								double foreCast = Double.parseDouble(foreCastValue);
								double Outlook = Double.parseDouble(OutlookValue);
								double Target = Double.parseDouble(TargetValue);
								
								ActualH2 += Actual;
								foreCastH2 += foreCast;
								OutlookH2 += Outlook;
								TargetH2 += Target;
							}else{
								String ActualKey = "DC_AC_P"+j;
								String foreCastKey = "DC_FOR_P"+j;
								String OutlookKey = "DC_OUT_P"+j;
								String TargetKey = "DC_TG_P"+j;
								
								String ActualValue = String.valueOf(list.get(i).get(ActualKey));
								String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
								String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
								String TargetValue = String.valueOf(list.get(i).get(TargetKey));
								
								double Actual = Double.parseDouble(ActualValue);
								double foreCast = Double.parseDouble(foreCastValue);
								double Outlook = Double.parseDouble(OutlookValue);
								double Target = Double.parseDouble(TargetValue);
								
								ActualH2 += Actual;
								foreCastH2 += foreCast;
								OutlookH2 += Outlook;
								TargetH2 += Target;
							}
						}
						
						Calc1H2 = (OutlookH2 / ActualH2) - 1;
						try{if(OutlookH2 == 0 || TargetH2 == 0){Calc2H2 = 0.0;}else{Calc2H2 = OutlookH2 / TargetH2;}}catch(ArithmeticException ae){Calc2H2 = 0.0;}
						try{if(OutlookH2 == 0 || foreCastH2 == 0){Calc3H2 = 0.0;}else{Calc3H2 = (OutlookH2 - foreCastH2) / foreCastH2;}}catch(ArithmeticException ae){Calc3H2 = 0.0;}
						
						record.put("DC_CALC1_H2", Calc1H2);
						record.put("DC_CALC2_H2", Calc2H2);
						record.put("DC_CALC3_H2", Calc3H2);
						
					}else if(cell == 19){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_YTD"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_YTD"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_YTD"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_YTD"));
		
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = (Outlook / Actual) - 1;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						record.put("DC_CALC1_YTD", Calc1);
						record.put("DC_CALC2_YTD", Calc2);
						record.put("DC_CALC3_YTD", Calc3);
					}
				}
				else {
					if(cell == 1){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P01"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P01"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P01"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P01"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
	
						record.put("DC_CALC1_P01", Calc1);
						record.put("DC_CALC2_P01", Calc2);
						record.put("DC_CALC3_P01", Calc3);
						
					}else if(cell== 2){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P02"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P02"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P02"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P02"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P02", Calc1);
						record.put("DC_CALC2_P02", Calc2);
						record.put("DC_CALC3_P02", Calc3);
		
					}else if(cell== 3){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P03"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P03"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P03"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P03"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P03", Calc1);
						record.put("DC_CALC2_P03", Calc2);
						record.put("DC_CALC3_P03", Calc3);
		
					}else if(cell== 4){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P04"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P04"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P04"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P04"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P04", Calc1);
						record.put("DC_CALC2_P04", Calc2);
						record.put("DC_CALC3_P04", Calc3);
		
					}else if(cell== 5){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P05"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P05"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P05"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P05"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P05", Calc1);
						record.put("DC_CALC2_P05", Calc2);
						record.put("DC_CALC3_P05", Calc3);
		
					}else if(cell== 6){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P06"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P06"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P06"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P06"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P06", Calc1);
						record.put("DC_CALC2_P06", Calc2);
						record.put("DC_CALC3_P06", Calc3);
		
					}else if(cell== 7){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P07"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P07"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P07"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P07"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P07", Calc1);
						record.put("DC_CALC2_P07", Calc2);
						record.put("DC_CALC3_P07", Calc3);
		
					}else if(cell== 8){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P08"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P08"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P08"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P08"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P08", Calc1);
						record.put("DC_CALC2_P08", Calc2);
						record.put("DC_CALC3_P08", Calc3);
		
					}else if(cell== 9){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P09"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P09"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P09"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P09"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P09", Calc1);
						record.put("DC_CALC2_P09", Calc2);
						record.put("DC_CALC3_P09", Calc3);
		
					}else if(cell== 10){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P10"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P10"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P10"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P10"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P10", Calc1);
						record.put("DC_CALC2_P10", Calc2);
						record.put("DC_CALC3_P10", Calc3);
		
					}else if(cell== 11){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P11"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P11"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P11"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P11"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P11", Calc1);
						record.put("DC_CALC2_P11", Calc2);
						record.put("DC_CALC3_P11", Calc3);
		
					}else if(cell== 12){	
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_P12"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_P12"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_P12"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_P12"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_P12", Calc1);
						record.put("DC_CALC2_P12", Calc2);
						record.put("DC_CALC3_P12", Calc3);
		
					}else if(cell == 13){
						
						/*
						double ActualQ1 = 0;
						double foreCastQ1 = 0;
						double OutlookQ1 = 0;
						double TargetQ1 = 0;
						
						double Calc1Q1 = 0;
						double Calc2Q1 = 0;
						double Calc3Q1 = 0;
						
						for(int j=1; j<=3; j++){
							String ActualKey = "DC_AC_P0"+j;
							String foreCastKey = "DC_FOR_P0"+j;
							String OutlookKey = "DC_OUT_P0"+j;
							String TargetKey = "DC_TG_P0"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualQ1 += Actual;
							foreCastQ1 += foreCast;
							OutlookQ1 += Outlook;
							TargetQ1 += Target;
						}
						
						try{if(OutlookQ1 == 0 || ActualQ1 == 0){Calc1Q1 = 0.0;}else{Calc1Q1 = OutlookQ1 - ActualQ1;}}catch(ArithmeticException ae){Calc1Q1 = 0.0;}
						try{if(OutlookQ1 == 0 || TargetQ1 == 0){Calc2Q1 = 0.0;}else{Calc2Q1 = OutlookQ1 / TargetQ1;}}catch(ArithmeticException ae){Calc2Q1 = 0.0;}
						try{if(OutlookQ1 == 0 || foreCastQ1 == 0){Calc3Q1 = 0.0;}else{Calc3Q1 = (OutlookQ1 - foreCastQ1) / foreCastQ1;}}catch(ArithmeticException ae){Calc3Q1 = 0.0;}
						
						record.put("DC_CALC1_Q1", Calc1Q1);
						record.put("DC_CALC2_Q1", Calc2Q1);
						record.put("DC_CALC3_Q1", Calc3Q1);
						
						*/
						
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_Q01"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_Q01"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_Q01"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_Q01"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_Q1", Calc1);
						record.put("DC_CALC2_Q1", Calc2);
						record.put("DC_CALC3_Q1", Calc3);
						
					}else if(cell == 14){
						
						/*
						double ActualQ2 = 0;
						double foreCastQ2 = 0;
						double OutlookQ2 = 0;
						double TargetQ2 = 0;
						
						double Calc1Q2 = 0;
						double Calc2Q2 = 0;
						double Calc3Q2 = 0;
						
						for(int j=4; j<=6; j++){
							String ActualKey = "DC_AC_P0"+j;
							String foreCastKey = "DC_FOR_P0"+j;
							String OutlookKey = "DC_OUT_P0"+j;
							String TargetKey = "DC_TG_P0"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualQ2 += Actual;
							foreCastQ2 += foreCast;
							OutlookQ2 += Outlook;
							TargetQ2 += Target;
						}
						
						try{if(OutlookQ2 == 0 || ActualQ2 == 0){Calc1Q2 = 0.0;}else{Calc1Q2 = OutlookQ2 - ActualQ2;}}catch(ArithmeticException ae){Calc1Q2 = 0.0;}
						try{if(OutlookQ2 == 0 || TargetQ2 == 0){Calc2Q2 = 0.0;}else{Calc2Q2 = OutlookQ2 / TargetQ2;}}catch(ArithmeticException ae){Calc2Q2 = 0.0;}
						try{if(OutlookQ2 == 0 || foreCastQ2 == 0){Calc3Q2 = 0.0;}else{Calc3Q2 = (OutlookQ2 - foreCastQ2) / foreCastQ2;}}catch(ArithmeticException ae){Calc3Q2 = 0.0;}
						
						record.put("DC_CALC1_Q2", Calc1Q2);
						record.put("DC_CALC2_Q2", Calc2Q2);
						record.put("DC_CALC3_Q2", Calc3Q2);
						*/
						
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_Q02"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_Q02"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_Q02"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_Q02"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_Q2", Calc1);
						record.put("DC_CALC2_Q2", Calc2);
						record.put("DC_CALC3_Q2", Calc3);
						
					}else if(cell == 15){
						
						/*
						double ActualQ3 = 0;
						double foreCastQ3 = 0;
						double OutlookQ3 = 0;
						double TargetQ3 = 0;
						
						double Calc1Q3 = 0;
						double Calc2Q3 = 0;
						double Calc3Q3 = 0;
						
						for(int j=7; j<=9; j++){
							String ActualKey = "DC_AC_P0"+j;
							String foreCastKey = "DC_FOR_P0"+j;
							String OutlookKey = "DC_OUT_P0"+j;
							String TargetKey = "DC_TG_P0"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualQ3 += Actual;
							foreCastQ3 += foreCast;
							OutlookQ3 += Outlook;
							TargetQ3 += Target;
						}
						
						try{if(OutlookQ3 == 0 || ActualQ3 == 0){Calc1Q3 = 0.0;}else{Calc1Q3 = OutlookQ3 - ActualQ3;}}catch(ArithmeticException ae){Calc1Q3 = 0.0;}
						try{if(OutlookQ3 == 0 || TargetQ3 == 0){Calc2Q3 = 0.0;}else{Calc2Q3 = OutlookQ3 / TargetQ3;}}catch(ArithmeticException ae){Calc2Q3 = 0.0;}
						try{if(OutlookQ3 == 0 || foreCastQ3 == 0){Calc3Q3 = 0.0;}else{Calc3Q3 = (OutlookQ3 - foreCastQ3) / foreCastQ3;}}catch(ArithmeticException ae){Calc3Q3 = 0.0;}
						
						record.put("DC_CALC1_Q3", Calc1Q3);
						record.put("DC_CALC2_Q3", Calc2Q3);
						record.put("DC_CALC3_Q3", Calc3Q3);
						*/
						
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_Q03"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_Q03"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_Q03"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_Q03"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_Q3", Calc1);
						record.put("DC_CALC2_Q3", Calc2);
						record.put("DC_CALC3_Q3", Calc3);
						
					}else if(cell == 16){
						/*
						double ActualQ4 = 0;
						double foreCastQ4 = 0;
						double OutlookQ4 = 0;
						double TargetQ4 = 0;
						
						double Calc1Q4 = 0;
						double Calc2Q4 = 0;
						double Calc3Q4 = 0;
						
						for(int j=10; j<=12; j++){
							String ActualKey = "DC_AC_P"+j;
							String foreCastKey = "DC_FOR_P"+j;
							String OutlookKey = "DC_OUT_P"+j;
							String TargetKey = "DC_TG_P"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualQ4 += Actual;
							foreCastQ4 += foreCast;
							OutlookQ4 += Outlook;
							TargetQ4 += Target;
						}
						
						try{if(OutlookQ4 == 0 || ActualQ4 == 0){Calc1Q4 = 0.0;}else{Calc1Q4 = OutlookQ4 - ActualQ4;}}catch(ArithmeticException ae){Calc1Q4 = 0.0;}
						try{if(OutlookQ4 == 0 || TargetQ4 == 0){Calc2Q4 = 0.0;}else{Calc2Q4 = OutlookQ4 / TargetQ4;}}catch(ArithmeticException ae){Calc2Q4 = 0.0;}
						try{if(OutlookQ4 == 0 || foreCastQ4 == 0){Calc3Q4 = 0.0;}else{Calc3Q4 = (OutlookQ4 - foreCastQ4) / foreCastQ4;}}catch(ArithmeticException ae){Calc3Q4 = 0.0;}
						
						record.put("DC_CALC1_Q4", Calc1Q4);
						record.put("DC_CALC2_Q4", Calc2Q4);
						record.put("DC_CALC3_Q4", Calc3Q4);
						*/
						
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_Q04"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_Q04"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_Q04"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_Q04"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_Q4", Calc1);
						record.put("DC_CALC2_Q4", Calc2);
						record.put("DC_CALC3_Q4", Calc3);
						
					}else if(cell == 17){
						/*
						double ActualH1 = 0;
						double foreCastH1 = 0;
						double OutlookH1 = 0;
						double TargetH1 = 0;
						
						double Calc1H1 = 0;
						double Calc2H1 = 0;
						double Calc3H1 = 0;
						
						for(int j=1; j<=6; j++){
							String ActualKey = "DC_AC_P0"+j;
							String foreCastKey = "DC_FOR_P0"+j;
							String OutlookKey = "DC_OUT_P0"+j;
							String TargetKey = "DC_TG_P0"+j;
							
							String ActualValue = String.valueOf(list.get(i).get(ActualKey));
							String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
							String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
							String TargetValue = String.valueOf(list.get(i).get(TargetKey));
							
							double Actual = Double.parseDouble(ActualValue);
							double foreCast = Double.parseDouble(foreCastValue);
							double Outlook = Double.parseDouble(OutlookValue);
							double Target = Double.parseDouble(TargetValue);
							
							ActualH1 += Actual;
							foreCastH1 += foreCast;
							OutlookH1 += Outlook;
							TargetH1 += Target;
						}
						
						try{if(OutlookH1 == 0 || ActualH1 == 0){Calc1H1 = 0.0;}else{Calc1H1 = OutlookH1 - ActualH1;}}catch(ArithmeticException ae){Calc1H1 = 0.0;}
						try{if(OutlookH1 == 0 || TargetH1 == 0){Calc2H1 = 0.0;}else{Calc2H1 = OutlookH1 / TargetH1;}}catch(ArithmeticException ae){Calc2H1 = 0.0;}
						try{if(OutlookH1 == 0 || foreCastH1 == 0){Calc3H1 = 0.0;}else{Calc3H1 = (OutlookH1 - foreCastH1) / foreCastH1;}}catch(ArithmeticException ae){Calc3H1 = 0.0;}
						
						record.put("DC_CALC1_H1", Calc1H1);
						record.put("DC_CALC2_H1", Calc2H1);
						record.put("DC_CALC3_H1", Calc3H1);
						*/
						
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_H01"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_H01"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_H01"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_H01"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_H1", Calc1);
						record.put("DC_CALC2_H1", Calc2);
						record.put("DC_CALC3_H1", Calc3);
						
					}else if(cell == 18){
						/*
						double ActualH2 = 0;
						double foreCastH2 = 0;
						double OutlookH2 = 0;
						double TargetH2 = 0;
						
						double Calc1H2 = 0;
						double Calc2H2 = 0;
						double Calc3H2 = 0;
						
						for(int j=7; j<=12; j++){
							if(j == 7 || j == 8 || j == 9){
								String ActualKey = "DC_AC_P0"+j;
								String foreCastKey = "DC_FOR_P0"+j;
								String OutlookKey = "DC_OUT_P0"+j;
								String TargetKey = "DC_TG_P0"+j;
								
								String ActualValue = String.valueOf(list.get(i).get(ActualKey));
								String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
								String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
								String TargetValue = String.valueOf(list.get(i).get(TargetKey));
								
								double Actual = Double.parseDouble(ActualValue);
								double foreCast = Double.parseDouble(foreCastValue);
								double Outlook = Double.parseDouble(OutlookValue);
								double Target = Double.parseDouble(TargetValue);
								
								ActualH2 += Actual;
								foreCastH2 += foreCast;
								OutlookH2 += Outlook;
								TargetH2 += Target;
							}else{
								String ActualKey = "DC_AC_P"+j;
								String foreCastKey = "DC_FOR_P"+j;
								String OutlookKey = "DC_OUT_P"+j;
								String TargetKey = "DC_TG_P"+j;
								
								String ActualValue = String.valueOf(list.get(i).get(ActualKey));
								String foreCastValue = String.valueOf(list.get(i).get(foreCastKey));
								String OutlookValue = String.valueOf(list.get(i).get(OutlookKey));
								String TargetValue = String.valueOf(list.get(i).get(TargetKey));
								
								double Actual = Double.parseDouble(ActualValue);
								double foreCast = Double.parseDouble(foreCastValue);
								double Outlook = Double.parseDouble(OutlookValue);
								double Target = Double.parseDouble(TargetValue);
								
								ActualH2 += Actual;
								foreCastH2 += foreCast;
								OutlookH2 += Outlook;
								TargetH2 += Target;
							}
						}
						
						try{if(OutlookH2 == 0 || ActualH2 == 0){Calc1H2 = 0.0;}else{Calc1H2 = OutlookH2 - ActualH2;}}catch(ArithmeticException ae){Calc1H2 = 0.0;}
						try{if(OutlookH2 == 0 || TargetH2 == 0){Calc2H2 = 0.0;}else{Calc2H2 = OutlookH2 / TargetH2;}}catch(ArithmeticException ae){Calc2H2 = 0.0;}
						try{if(OutlookH2 == 0 || foreCastH2 == 0){Calc3H2 = 0.0;}else{Calc3H2 = (OutlookH2 - foreCastH2) / foreCastH2;}}catch(ArithmeticException ae){Calc3H2 = 0.0;}
						
						record.put("DC_CALC1_H2", Calc1H2);
						record.put("DC_CALC2_H2", Calc2H2);
						record.put("DC_CALC3_H2", Calc3H2);
						*/
						
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_H02"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_H02"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_H02"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_H02"));
						
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_H2", Calc1);
						record.put("DC_CALC2_H2", Calc2);
						record.put("DC_CALC3_H2", Calc3);
						
					}else if(cell == 19){
						String ActualValue = String.valueOf(list.get(i).get("DC_AC_YTD"));
						String foreCastValue = String.valueOf(list.get(i).get("DC_FOR_YTD"));
						String OutlookValue = String.valueOf(list.get(i).get("DC_OUT_YTD"));
						String TargetValue = String.valueOf(list.get(i).get("DC_TG_YTD"));
		
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						Calc1 = Outlook - Actual;
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("DC_CALC1_YTD", Calc1);
						record.put("DC_CALC2_YTD", Calc2);
						record.put("DC_CALC3_YTD", Calc3);
					}
				}
			}

			resultList.add(record);
			mergeList.get(i).putAll(resultList.get(i));
			
		}
		
		return mergeList;
	}
	
	
	
	
	// Calc1 : Growth Rate% vs. F14=(F15 Actual (Outlook) /F14 Actual)-1
	// Calc2 : Achievement% vs. Target= F15 Actual (Outlook)/F15 Target
	// Calc3 : Forecast Accuracy% vs. Forecast =(F15 Actual (Outlook)-F15 Forecast) / F15 Forecast
	
	// try{Calc1 = (Outlook / Actual) - 1;} catch(ArithmeticException  ae){Calc1 = 0;}
	// try{Calc2 = (Outlook / Target);} catch(ArithmeticException  ae){Calc2 = 0;}
	// try{Calc3 = (Outlook - foreCast) / foreCast;} catch(ArithmeticException  ae){Calc3 = 0;}
	
	public ArrayList<Map> creditCalC(ArrayList<Map> list){
		
		ArrayList<Map> originalList = list; // 원본 데이터
		ArrayList<Map> mergeList = list;	// 합병 데이터
		ArrayList<Map> resultList = new ArrayList<Map>();	// 계산 데이터
		
		for(int i=0; i<list.size(); i++){
			
			Map record = new LinkedHashMap();
			
			for(int cell=1; cell<=19; cell++){
				
				if(cell == 1){
					String ActualValue = String.valueOf(list.get(i).get("CD_AC_P01"));
					String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P01"));
					String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P01"));
					String TargetValue = String.valueOf(list.get(i).get("CD_TG_P01"));
					
					if(TargetValue == "null"){
						TargetValue = "0.0";
					}

					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}

					record.put("CD_CALC1_P01", Calc1);
					record.put("CD_CALC2_P01", Calc2);
					record.put("CD_CALC3_P01", Calc3);
					
				}else if(cell == 2){
					String ActualValue = String.valueOf(list.get(i).get("CD_AC_P02"));
					String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P02"));
					String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P02"));
					String TargetValue = String.valueOf(list.get(i).get("CD_TG_P02"));
					
					if(TargetValue == "null"){
						TargetValue = "0.0";
					}

					double Actual = Double.parseDouble(ActualValue);
					double foreCast = Double.parseDouble(foreCastValue);
					double Outlook = Double.parseDouble(OutlookValue);
					double Target = Double.parseDouble(TargetValue);
					
					double Calc1 = 0;
					double Calc2 = 0;
					double Calc3 = 0;
					
					try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
					try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
					try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
					
					record.put("CD_CALC1_P02", Calc1);
					record.put("CD_CALC2_P02", Calc2);
					record.put("CD_CALC3_P02", Calc3);
					
				}else if(cell == 3){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P03"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P03"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P03"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P03"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P03", Calc1);
						record.put("CD_CALC2_P03", Calc2);
						record.put("CD_CALC3_P03", Calc3);
						
					}else if(cell == 4){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P04"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P04"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P04"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P04"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P04", Calc1);
						record.put("CD_CALC2_P04", Calc2);
						record.put("CD_CALC3_P04", Calc3);
						
					}else if(cell == 5){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P05"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P05"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P05"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P05"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P05", Calc1);
						record.put("CD_CALC2_P05", Calc2);
						record.put("CD_CALC3_P05", Calc3);
						
					}else if(cell == 6){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P06"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P06"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P06"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P06"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P06", Calc1);
						record.put("CD_CALC2_P06", Calc2);
						record.put("CD_CALC3_P06", Calc3);
						
					}else if(cell == 7){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P07"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P07"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P07"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P07"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P07", Calc1);
						record.put("CD_CALC2_P07", Calc2);
						record.put("CD_CALC3_P07", Calc3);
						
					}else if(cell == 8){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P08"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P08"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P08"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P08"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P08", Calc1);
						record.put("CD_CALC2_P08", Calc2);
						record.put("CD_CALC3_P08", Calc3);
						
					}else if(cell == 9){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P09"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P09"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P09"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P09"));
		
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P09", Calc1);
						record.put("CD_CALC2_P09", Calc2);
						record.put("CD_CALC3_P09", Calc3);
						
					}else if(cell == 10){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P10"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P10"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P10"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P10"));
		
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P10", Calc1);
						record.put("CD_CALC2_P10", Calc2);
						record.put("CD_CALC3_P10", Calc3);
						
					}else if(cell == 11){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P11"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P11"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P11"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P11"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P11", Calc1);
						record.put("CD_CALC2_P11", Calc2);
						record.put("CD_CALC3_P11", Calc3);
						
					}else if(cell == 12){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_P12"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_P12"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_P12"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_P12"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_P12", Calc1);
						record.put("CD_CALC2_P12", Calc2);
						record.put("CD_CALC3_P12", Calc3);
						
					}else if(cell == 13){
						
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_Q01"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_Q01"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_Q01"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_Q01"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_Q1", Calc1);
						record.put("CD_CALC2_Q1", Calc2);
						record.put("CD_CALC3_Q1", Calc3);
						
					}else if(cell == 14){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_Q02"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_Q02"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_Q02"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_Q02"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_Q2", Calc1);
						record.put("CD_CALC2_Q2", Calc2);
						record.put("CD_CALC3_Q2", Calc3);
						
					}else if(cell == 15){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_Q03"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_Q03"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_Q03"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_Q03"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_Q3", Calc1);
						record.put("CD_CALC2_Q3", Calc2);
						record.put("CD_CALC3_Q3", Calc3);
						
					}else if(cell == 16){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_Q04"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_Q04"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_Q04"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_Q04"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_Q4", Calc1);
						record.put("CD_CALC2_Q4", Calc2);
						record.put("CD_CALC3_Q4", Calc3);
						
					}else if(cell == 17){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_H01"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_H01"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_H01"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_H01"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_H1", Calc1);
						record.put("CD_CALC2_H1", Calc2);
						record.put("CD_CALC3_H1", Calc3);
						
					}else if(cell == 18){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_H02"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_H02"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_H02"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_H02"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}

						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_H2", Calc1);
						record.put("CD_CALC2_H2", Calc2);
						record.put("CD_CALC3_H2", Calc3);
						
					}else if(cell == 19){
						String ActualValue = String.valueOf(list.get(i).get("CD_AC_YTD"));
						String foreCastValue = String.valueOf(list.get(i).get("CD_FOR_YTD"));
						String OutlookValue = String.valueOf(list.get(i).get("CD_OUT_YTD"));
						String TargetValue = String.valueOf(list.get(i).get("CD_TG_YTD"));
						
						if(TargetValue == "null"){
							TargetValue = "0.0";
						}
		
						double Actual = Double.parseDouble(ActualValue);
						double foreCast = Double.parseDouble(foreCastValue);
						double Outlook = Double.parseDouble(OutlookValue);
						double Target = Double.parseDouble(TargetValue);
						
						double Calc1 = 0;
						double Calc2 = 0;
						double Calc3 = 0;
						
						try{if(Outlook == 0 || Actual == 0){Calc1 = 0.0;}else{Calc1 = (Outlook / Actual) - 1;}}catch(ArithmeticException ae){Calc1 = 0.0;}
						try{if(Outlook == 0 || Target == 0){Calc2 = 0.0;}else{Calc2 = Outlook / Target;}}catch(ArithmeticException ae){Calc2 = 0.0;}
						try{if(Outlook == 0 || foreCast == 0){Calc3 = 0.0;}else{Calc3 = (Outlook - foreCast) / foreCast;}}catch(ArithmeticException ae){Calc3 = 0.0;}
						
						record.put("CD_CALC1_YTD", Calc1);
						record.put("CD_CALC2_YTD", Calc2);
						record.put("CD_CALC3_YTD", Calc3);
					}
				}
				resultList.add(record);
				mergeList.get(i).putAll(resultList.get(i));
				
			}
		
		return mergeList;
	}
	
}