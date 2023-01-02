package com.kia.anl.service;

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
import com.kia.anl.model.ESLT_PRODUCT_SEQ;
import com.kia.anl.model.ESLT_PRODUCT_MT;
import com.kia.anl.model.ESLT_SH_ACT;
import com.kia.anl.model.ESLT_SH_FC;
import com.kia.anl.model.ESLT_SH_TG;
import com.kia.anl.model.ESLT_TEAM_MT;

public interface Anl02Service {

	// Shipment Master업로드
	public void save_ESLT_BRANCH_MT(ESLT_BRANCH_MT eslt_branch_mt) throws Exception;
	public void save_ESLT_CUSTOMER_MT(ESLT_CUSTOMER_MT eslt_customer_mt) throws Exception;
	public void save_ESLT_PRODUCT_MT(ESLT_PRODUCT_MT eslt_product_mt) throws Exception;
	public void save_ESLT_PRODUCT_SEQ(ESLT_PRODUCT_SEQ eslt_product_seq) throws Exception;
	
	// Depletion Master업로드
	public void save_ESLT_TEAM_MT(ESLT_TEAM_MT eslt_team_mt) throws Exception;
	public void save_ESLT_AREA_MT(ESLT_AREA_MT eslt_area_mt) throws Exception;
	
	// 실적자료 업로드
	public void save_ESLT_SH_ACT(ESLT_SH_ACT eslt_sh_act) throws Exception;
	public void save_ESLT_DC_ACT(ESLT_DC_ACT eslt_dc_act) throws Exception;
	public void save_ESLT_DC_FCACT(ESLT_DC_FCACT eslt_dc_fcact) throws Exception;
	public void save_ESLT_CD_ACT(ESLT_CD_ACT eslt_cd_act) throws Exception;
	public void save_ESLT_NTS_ACT(ESLT_NTS_ACT eslt_nts_act) throws Exception;
	public void save_ESLT_NOTEG_ACT(ESLT_NOTEG_ACT eslt_noteg_act) throws Exception;
	
	// 목표자료 업로드
	public void save_ESLT_SH_TG(ESLT_SH_TG eslt_sh_tg) throws Exception;
	public void save_ESLT_DC_TG(ESLT_DC_TG eslt_dc_tg) throws Exception;
	public void save_ESLT_CD_TG(ESLT_CD_TG eslt_cd_tg) throws Exception;
	public void save_ESLT_NTS_TG(ESLT_NTS_TG eslt_nts_tg) throws Exception;
	public void save_ESLT_NOTEG_TG(ESLT_NOTEG_TG eslt_noteg_tg) throws Exception;
	
	/* ESLT_SH_TG 신규 업로드 로직 */
	public void save_ESLT_SH_TG_TEMP(ESLT_SH_TG eslt_sh_tg) throws Exception;
	public void save_ESLT_DC_TG_TEMP(ESLT_DC_TG eslt_dc_tg) throws Exception;
	public void save_ESLT_CD_TG_TEMP(ESLT_CD_TG eslt_cd_tg) throws Exception;
	public void save_ESLT_NTS_TG_TEMP(ESLT_NTS_TG eslt_nts_tg) throws Exception;
	public void save_ESLT_NOTEG_TG_TEMP(ESLT_NOTEG_TG eslt_noteg_tg) throws Exception;
	
	// Shipment Forecast 업로드
	public void save_ESLT_SH_FC(ESLT_SH_FC eslt_sh_fc) throws Exception;
	public void save_ESLT_DC_FC(ESLT_DC_FC eslt_dc_fc) throws Exception;
	public void save_ESLT_CD_FC(ESLT_CD_FC eslt_cd_fc) throws Exception;
	
	// Shipment Outlook 업로드
	public void save_ESLT_SH_OL(ESLT_SH_FC eslt_sh_fc) throws Exception;
	public void save_ESLT_DC_OL(ESLT_DC_FC eslt_dc_fc) throws Exception;
	public void save_ESLT_CD_OL(ESLT_CD_FC eslt_cd_fc) throws Exception;
		
	// Depletion Forecast 업로드
	public void save_ESLT_NTS_FC(ESLT_NTS_FC eslt_nts_fc) throws Exception;
	public void save_ESLT_NOTEG_FC(ESLT_NOTEG_FC eslt_noteg_fc) throws Exception;
	
	// Depletion Outlook 업로드
	public void save_ESLT_NTS_OL(ESLT_NTS_FC eslt_nts_fc) throws Exception;
	public void save_ESLT_NOTEG_OL(ESLT_NOTEG_FC eslt_noteg_fc) throws Exception;
}
