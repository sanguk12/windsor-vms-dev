package com.kia.anl.dao;

import java.util.ArrayList;

import org.springframework.dao.DataAccessException;

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

public interface Anl02Dao {
	
	// Shipment Master업로드
	public int insert_ESLT_BRANCH_MT_Upload(final ArrayList<ESLT_BRANCH_MT> eslt_branch_mt) throws DataAccessException;
	public int insert_ESLT_CUSTOMER_MT_Upload(final ArrayList<ESLT_CUSTOMER_MT> eslt_customer_mt) throws DataAccessException;
	public int insert_ESLT_PRODUCT_MT_Upload(final ArrayList<ESLT_PRODUCT_MT> eslt_product_mt) throws DataAccessException;
	public int insert_ESLT_PRODUCT_SEQ_Upload(final ArrayList<ESLT_PRODUCT_SEQ> eslt_product_seq) throws DataAccessException;
	
	// Depletion Master업로드
	public int insert_ESLT_TEAM_MT_Upload(final ArrayList<ESLT_TEAM_MT> eslt_team_mt) throws DataAccessException;
	public int insert_ESLT_AREA_MT_Upload(final ArrayList<ESLT_AREA_MT> eslt_area_mt) throws DataAccessException;
	
	// 실적자료 업로드
	public int insert_ESLT_SH_ACT_Upload(final ArrayList<ESLT_SH_ACT> eslt_sh_act) throws DataAccessException;
	public int insert_ESLT_DC_ACT_Upload(final ArrayList<ESLT_DC_ACT> eslt_dc_act) throws DataAccessException;
	public int insert_ESLT_DC_FCACT_Upload(final ArrayList<ESLT_DC_FCACT> eslt_dc_fcact) throws DataAccessException;
	public int insert_ESLT_CD_ACT_Upload(final ArrayList<ESLT_CD_ACT> eslt_cd_act) throws DataAccessException;
	public int insert_ESLT_NTS_ACT_Upload(final ArrayList<ESLT_NTS_ACT> eslt_nts_act) throws DataAccessException;
	public int insert_ESLT_NOTEG_ACT_Upload(final ArrayList<ESLT_NOTEG_ACT> eslt_noteg_act) throws DataAccessException;
	
	// 목표자료 업로드
	public int insert_ESLT_SH_TG_Upload(final ArrayList<ESLT_SH_TG> eslt_sh_tg) throws DataAccessException;
	public int insert_ESLT_DC_TG_Upload(final ArrayList<ESLT_DC_TG> eslt_dc_tg) throws DataAccessException;
	public int insert_ESLT_CD_TG_Upload(final ArrayList<ESLT_CD_TG> eslt_cd_tg) throws DataAccessException;
	public int insert_ESLT_NTS_TG_Upload(final ArrayList<ESLT_NTS_TG> eslt_nts_tg) throws DataAccessException;
	public int insert_ESLT_NOTEG_TG_Upload(final ArrayList<ESLT_NOTEG_TG> eslt_noteg_tg) throws DataAccessException;
	
	// 목표자료 업로드 신규 로직 
	public int update_ESLT_SH_TG_Upload_Temp(final ArrayList<ESLT_SH_TG> eslt_sh_tg) throws DataAccessException;
	public int update_ESLT_DC_TG_Upload_Temp(final ArrayList<ESLT_DC_TG> eslt_dc_tg) throws DataAccessException;
	public int update_ESLT_CD_TG_Upload_Temp(final ArrayList<ESLT_CD_TG> eslt_cd_tg) throws DataAccessException;
	public int update_ESLT_NTS_TG_Upload_Temp(final ArrayList<ESLT_NTS_TG> eslt_nts_tg) throws DataAccessException;
	public int update_ESLT_NOTEG_TG_Upload_Temp(final ArrayList<ESLT_NOTEG_TG> eslt_noteg_tg) throws DataAccessException;
	public int insert_ESLT_SH_TG_Upload_Temp(final ArrayList<ESLT_SH_TG> eslt_sh_tg) throws DataAccessException;
	public int insert_ESLT_DC_TG_Upload_Temp(final ArrayList<ESLT_DC_TG> eslt_dc_tg) throws DataAccessException;
	public int insert_ESLT_CD_TG_Upload_Temp(final ArrayList<ESLT_CD_TG> eslt_cd_tg) throws DataAccessException;
	public int insert_ESLT_NTS_TG_Upload_Temp(final ArrayList<ESLT_NTS_TG> eslt_nts_tg) throws DataAccessException;
	public int insert_ESLT_NOTEG_TG_Upload_Temp(final ArrayList<ESLT_NOTEG_TG> eslt_noteg_tg) throws DataAccessException;
	
	
	// Shipment Forecast 업로드
	public int update_ESLT_SH_FC_Upload(final ArrayList<ESLT_SH_FC> eslt_sh_fc) throws DataAccessException;
	public int update_ESLT_DC_FC_Upload(final ArrayList<ESLT_DC_FC> eslt_dc_fc) throws DataAccessException;
	public int update_ESLT_CD_FC_Upload(final ArrayList<ESLT_CD_FC> eslt_cd_fc) throws DataAccessException;
	public int insert_ESLT_SH_FC_Upload(final ArrayList<ESLT_SH_FC> eslt_sh_fc) throws DataAccessException;
	public int insert_ESLT_DC_FC_Upload(final ArrayList<ESLT_DC_FC> eslt_dc_fc) throws DataAccessException;
	public int insert_ESLT_CD_FC_Upload(final ArrayList<ESLT_CD_FC> eslt_cd_fc) throws DataAccessException;
	
	// Shipment Outlook 업로드
	public int update_ESLT_SH_OL_Upload(final ArrayList<ESLT_SH_FC> eslt_sh_fc) throws DataAccessException;
	public int update_ESLT_DC_OL_Upload(final ArrayList<ESLT_DC_FC> eslt_dc_fc) throws DataAccessException;
	public int update_ESLT_CD_OL_Upload(final ArrayList<ESLT_CD_FC> eslt_cd_fc) throws DataAccessException;
	
	// Depletion Forecast 업로드
	public int update_ESLT_NTS_FC_Upload(final ArrayList<ESLT_NTS_FC> eslt_nts_fc) throws DataAccessException;
	public int update_ESLT_NOTEG_FC_Upload(final ArrayList<ESLT_NOTEG_FC> eslt_noteg_fc) throws DataAccessException;
	public int insert_ESLT_NTS_FC_Upload(final ArrayList<ESLT_NTS_FC> eslt_nts_fc) throws DataAccessException;
	public int insert_ESLT_NOTEG_FC_Upload(final ArrayList<ESLT_NOTEG_FC> eslt_noteg_fc) throws DataAccessException;
	
	// Depletion Outlook 업로드
	public int update_ESLT_NTS_OL_Upload(final ArrayList<ESLT_NTS_FC> eslt_nts_fc) throws DataAccessException;
	public int update_ESLT_NOTEG_OL_Upload(final ArrayList<ESLT_NOTEG_FC> eslt_noteg_fc) throws DataAccessException;
	public int insert_ESLT_NTS_OL_Upload(final ArrayList<ESLT_NTS_FC> eslt_nts_fc) throws DataAccessException;
	public int insert_ESLT_NOTEG_OL_Upload(final ArrayList<ESLT_NOTEG_FC> eslt_noteg_fc) throws DataAccessException;
	
}
