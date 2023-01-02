package com.kia.anl.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import kr.co.nis.waf.dao.SimpleDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.kia.anl.dao.Anl02Dao;
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

@Service("anl02Service")
public class Anl02ServiceImpl implements Anl02Service {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private SimpleDao simpleDao;
	
	@Resource
	private Anl02Dao anl02Dao;
	
	public void setAnl02Dao(Anl02Dao anl02Dao) {
		this.anl02Dao = anl02Dao;
	}
	
	public void save_ESLT_BRANCH_MT(ESLT_BRANCH_MT eslt_branch_mt) throws Exception {
		
		ArrayList<ESLT_BRANCH_MT> insertList = new ArrayList<ESLT_BRANCH_MT>();
		for(int i = 0; i<eslt_branch_mt.getSize(); i++) {
			if(i == 0){
				simpleDao.delete("ANL0200101D", eslt_branch_mt); 
			}
			insertList.add(eslt_branch_mt.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_BRANCH_MT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);

	}
	
	public void save_ESLT_CUSTOMER_MT(ESLT_CUSTOMER_MT eslt_customer_mt) throws Exception {
		
		ArrayList<ESLT_CUSTOMER_MT> insertList = new ArrayList<ESLT_CUSTOMER_MT>();
		for(int i = 0; i<eslt_customer_mt.getSize(); i++) {
			if(i == 0){
				simpleDao.delete("ANL0200102D", eslt_customer_mt); 
			}
			insertList.add(eslt_customer_mt.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_CUSTOMER_MT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);

	}

	public void save_ESLT_PRODUCT_MT(ESLT_PRODUCT_MT eslt_product_mt) throws Exception {
	
		ArrayList<ESLT_PRODUCT_MT> insertList = new ArrayList<ESLT_PRODUCT_MT>();
		for(int i = 0; i<eslt_product_mt.getSize(); i++) {
			if(i == 0){
				simpleDao.delete("ANL0200103D", eslt_product_mt); 
			}
			insertList.add(eslt_product_mt.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_PRODUCT_MT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);

	}

	public void save_ESLT_PRODUCT_SEQ(ESLT_PRODUCT_SEQ eslt_product_seq) throws Exception {
	
		ArrayList<ESLT_PRODUCT_SEQ> insertList = new ArrayList<ESLT_PRODUCT_SEQ>();
		for(int i = 0; i<eslt_product_seq.getSize(); i++) {
			if(i == 0){
				simpleDao.delete("ANL0200104D", eslt_product_seq);
				simpleDao.delete("ANL0200105D", eslt_product_seq);
			}
			insertList.add(eslt_product_seq.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_PRODUCT_SEQ_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);

	}
	
	public void save_ESLT_TEAM_MT(ESLT_TEAM_MT eslt_team_mt) throws Exception {
		
		ArrayList<ESLT_TEAM_MT> insertList = new ArrayList<ESLT_TEAM_MT>();
		for(int i = 0; i<eslt_team_mt.getSize(); i++) {
			if(i == 0){
				simpleDao.delete("ANL0200201D", eslt_team_mt); 
			}
			insertList.add(eslt_team_mt.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_TEAM_MT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);

	}
	
	public void save_ESLT_AREA_MT(ESLT_AREA_MT eslt_area_mt) throws Exception {
		
		ArrayList<ESLT_AREA_MT> insertList = new ArrayList<ESLT_AREA_MT>();
		for(int i = 0; i<eslt_area_mt.getSize(); i++) {
			if(i == 0){
				simpleDao.delete("ANL0200202D", eslt_area_mt); 
			}
			insertList.add(eslt_area_mt.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_AREA_MT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);

	}
	
	public void save_ESLT_SH_ACT(ESLT_SH_ACT eslt_sh_act) throws Exception {
		
		ArrayList<ESLT_SH_ACT> insertList = new ArrayList<ESLT_SH_ACT>();
		for(int i = 0; i<eslt_sh_act.getSize(); i++) {
			if(i == 0){
				simpleDao.delete("ANL0200301D", eslt_sh_act); 
			}
			insertList.add(eslt_sh_act.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_SH_ACT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);

	}
	
	public void save_ESLT_DC_ACT(ESLT_DC_ACT eslt_dc_act) throws Exception {
			
		ArrayList<ESLT_DC_ACT> insertList = new ArrayList<ESLT_DC_ACT>();
		for(int i = 0; i<eslt_dc_act.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200302D", eslt_dc_act); 
			}
			insertList.add(eslt_dc_act.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_DC_ACT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);

	}
	
	public void save_ESLT_DC_FCACT(ESLT_DC_FCACT eslt_dc_fcact) throws Exception {
		
		ArrayList<ESLT_DC_FCACT> insertList = new ArrayList<ESLT_DC_FCACT>();
		for(int i = 0; i<eslt_dc_fcact.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200303D", eslt_dc_fcact); 
			}
			insertList.add(eslt_dc_fcact.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_DC_FCACT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);
	
	}
	
	public void save_ESLT_CD_ACT(ESLT_CD_ACT eslt_cd_act) throws Exception {
		
		ArrayList<ESLT_CD_ACT> insertList = new ArrayList<ESLT_CD_ACT>();
		for(int i = 0; i<eslt_cd_act.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200304D", eslt_cd_act); 
			}
			insertList.add(eslt_cd_act.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_CD_ACT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);
	
	}
	
	public void save_ESLT_NTS_ACT(ESLT_NTS_ACT eslt_nts_act) throws Exception {
		
		ArrayList<ESLT_NTS_ACT> insertList = new ArrayList<ESLT_NTS_ACT>();
		for(int i = 0; i<eslt_nts_act.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200305D", eslt_nts_act); 
			}
			insertList.add(eslt_nts_act.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_NTS_ACT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);
	
	}
	
	public void save_ESLT_NOTEG_ACT(ESLT_NOTEG_ACT eslt_noteg_act) throws Exception {
		
		ArrayList<ESLT_NOTEG_ACT> insertList = new ArrayList<ESLT_NOTEG_ACT>();
		for(int i = 0; i<eslt_noteg_act.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200306D", eslt_noteg_act); 
			}
			insertList.add(eslt_noteg_act.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_NOTEG_ACT_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);
	
	}

	public void save_ESLT_SH_TG(ESLT_SH_TG eslt_sh_tg) throws Exception {
		
		ArrayList<ESLT_SH_TG> insertList = new ArrayList<ESLT_SH_TG>();
		for(int i = 0; i<eslt_sh_tg.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200401D", eslt_sh_tg); 
			}
			insertList.add(eslt_sh_tg.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_SH_TG_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);
	
	}

	public void save_ESLT_DC_TG(ESLT_DC_TG eslt_dc_tg) throws Exception {
		
		ArrayList<ESLT_DC_TG> insertList = new ArrayList<ESLT_DC_TG>();
		for(int i = 0; i<eslt_dc_tg.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200402D", eslt_dc_tg); 
			}
			insertList.add(eslt_dc_tg.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_DC_TG_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);
	
	}

	public void save_ESLT_CD_TG(ESLT_CD_TG eslt_cd_tg) throws Exception {
	
		ArrayList<ESLT_CD_TG> insertList = new ArrayList<ESLT_CD_TG>();
		for(int i = 0; i<eslt_cd_tg.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200403D", eslt_cd_tg); 
			}
			insertList.add(eslt_cd_tg.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_CD_TG_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);

	}

	public void save_ESLT_NTS_TG(ESLT_NTS_TG eslt_nts_tg) throws Exception {
		
		ArrayList<ESLT_NTS_TG> insertList = new ArrayList<ESLT_NTS_TG>();
		for(int i = 0; i<eslt_nts_tg.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200404D", eslt_nts_tg); 
			}
			insertList.add(eslt_nts_tg.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_NTS_TG_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);
	
	}
	
	public void save_ESLT_NOTEG_TG(ESLT_NOTEG_TG eslt_noteg_tg) throws Exception {
		
		ArrayList<ESLT_NOTEG_TG> insertList = new ArrayList<ESLT_NOTEG_TG>();
		for(int i = 0; i<eslt_noteg_tg.getSize(); i++) {
			if(i==0){
				simpleDao.delete("ANL0200405D", eslt_noteg_tg); 
			}
			insertList.add(eslt_noteg_tg.getObject(i));
		}
		
		int insertCount = anl02Dao.insert_ESLT_NOTEG_TG_Upload(insertList);
		
		logger.debug("insertCount : "+insertCount);
	
	}
	
	public void save_ESLT_SH_FC(ESLT_SH_FC eslt_sh_fc) throws Exception {
			
		ArrayList<ESLT_SH_FC> insertList = new ArrayList<ESLT_SH_FC>();
		ArrayList<ESLT_SH_FC> updatetList = new ArrayList<ESLT_SH_FC>();
		
		for(int i = 0; i<eslt_sh_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200504S", eslt_sh_fc.getObject(i)) > 0) {
				updatetList.add(eslt_sh_fc.getObject(i));
			}
			else {
				insertList.add(eslt_sh_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_SH_FC_Upload(updatetList);
		int insertCount = anl02Dao.insert_ESLT_SH_FC_Upload(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
		
	}
	
	public void save_ESLT_DC_FC(ESLT_DC_FC eslt_dc_fc) throws Exception {
		
		ArrayList<ESLT_DC_FC> insertList = new ArrayList<ESLT_DC_FC>();
		ArrayList<ESLT_DC_FC> updatetList = new ArrayList<ESLT_DC_FC>();
		
		for(int i = 0; i<eslt_dc_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200505S", eslt_dc_fc.getObject(i)) > 0) {
				updatetList.add(eslt_dc_fc.getObject(i));
			}
			else {
				insertList.add(eslt_dc_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_DC_FC_Upload(updatetList);
		int insertCount = anl02Dao.insert_ESLT_DC_FC_Upload(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
	
	}
	
	public void save_ESLT_CD_FC(ESLT_CD_FC eslt_cd_fc) throws Exception {
		
		ArrayList<ESLT_CD_FC> insertList = new ArrayList<ESLT_CD_FC>();
		ArrayList<ESLT_CD_FC> updatetList = new ArrayList<ESLT_CD_FC>();
		
		for(int i = 0; i<eslt_cd_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200506S", eslt_cd_fc.getObject(i)) > 0) {
				updatetList.add(eslt_cd_fc.getObject(i));
			}
			else {
				insertList.add(eslt_cd_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_CD_FC_Upload(updatetList);
		int insertCount = anl02Dao.insert_ESLT_CD_FC_Upload(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
	
	}

	public void save_ESLT_SH_OL(ESLT_SH_FC eslt_sh_fc) throws Exception {
		
		ArrayList<ESLT_SH_FC> updatetList = new ArrayList<ESLT_SH_FC>();
		
		for(int i = 0; i<eslt_sh_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200604S", eslt_sh_fc.getObject(i)) > 0) {
				updatetList.add(eslt_sh_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_SH_OL_Upload(updatetList);
		
		logger.debug("updateCount : "+updateCount);
		
	}
	
	public void save_ESLT_DC_OL(ESLT_DC_FC eslt_dc_fc) throws Exception {
		
		ArrayList<ESLT_DC_FC> updatetList = new ArrayList<ESLT_DC_FC>();
		
		for(int i = 0; i<eslt_dc_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200605S", eslt_dc_fc.getObject(i)) > 0) {
				updatetList.add(eslt_dc_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_DC_OL_Upload(updatetList);
		
		logger.debug("updateCount : "+updateCount);
	
	}
	
	public void save_ESLT_CD_OL(ESLT_CD_FC eslt_cd_fc) throws Exception {
		
		ArrayList<ESLT_CD_FC> updatetList = new ArrayList<ESLT_CD_FC>();
		
		for(int i = 0; i<eslt_cd_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200606S", eslt_cd_fc.getObject(i)) > 0) {
				updatetList.add(eslt_cd_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_CD_OL_Upload(updatetList);
		
		logger.debug("updateCount : "+updateCount);
	
	}

	public void save_ESLT_NTS_FC(ESLT_NTS_FC eslt_nts_fc) throws Exception {
		
		ArrayList<ESLT_NTS_FC> insertList = new ArrayList<ESLT_NTS_FC>();
		ArrayList<ESLT_NTS_FC> updatetList = new ArrayList<ESLT_NTS_FC>();
		
		for(int i = 0; i<eslt_nts_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200704S", eslt_nts_fc.getObject(i)) > 0) {
				updatetList.add(eslt_nts_fc.getObject(i));
			}
			else {
				insertList.add(eslt_nts_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_NTS_FC_Upload(updatetList);
		int insertCount = anl02Dao.insert_ESLT_NTS_FC_Upload(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
		
	}
	
	public void save_ESLT_NOTEG_FC(ESLT_NOTEG_FC eslt_noteg_fc) throws Exception {
		
		ArrayList<ESLT_NOTEG_FC> insertList = new ArrayList<ESLT_NOTEG_FC>();
		ArrayList<ESLT_NOTEG_FC> updatetList = new ArrayList<ESLT_NOTEG_FC>();
		
		for(int i = 0; i<eslt_noteg_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200705S", eslt_noteg_fc.getObject(i)) > 0) {
				updatetList.add(eslt_noteg_fc.getObject(i));
			}
			else {
				insertList.add(eslt_noteg_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_NOTEG_FC_Upload(updatetList);
		int insertCount = anl02Dao.insert_ESLT_NOTEG_FC_Upload(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
	
	}
	
	public void save_ESLT_NTS_OL(ESLT_NTS_FC eslt_nts_fc) throws Exception {
		
		ArrayList<ESLT_NTS_FC> insertList = new ArrayList<ESLT_NTS_FC>();
		ArrayList<ESLT_NTS_FC> updatetList = new ArrayList<ESLT_NTS_FC>();
		
		for(int i = 0; i<eslt_nts_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200804S", eslt_nts_fc.getObject(i)) > 0) {
				updatetList.add(eslt_nts_fc.getObject(i));
			}
			else {
				insertList.add(eslt_nts_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_NTS_OL_Upload(updatetList);
		
		logger.debug("updateCount : "+updateCount);
		
	}
	
	public void save_ESLT_NOTEG_OL(ESLT_NOTEG_FC eslt_noteg_fc) throws Exception {
		
		ArrayList<ESLT_NOTEG_FC> insertList = new ArrayList<ESLT_NOTEG_FC>();
		ArrayList<ESLT_NOTEG_FC> updatetList = new ArrayList<ESLT_NOTEG_FC>();
		
		for(int i = 0; i<eslt_noteg_fc.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200805S", eslt_noteg_fc.getObject(i)) > 0) {
				updatetList.add(eslt_noteg_fc.getObject(i));
			}
			else {
				insertList.add(eslt_noteg_fc.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_NOTEG_OL_Upload(updatetList);
		
		logger.debug("updateCount : "+updateCount);
	
	}
	
	/* ESLT_SH_TG 신규 업로드 로직 */
	public void save_ESLT_SH_TG_TEMP(ESLT_SH_TG eslt_sh_tg) throws Exception {
		
		ArrayList<ESLT_SH_TG> insertList = new ArrayList<ESLT_SH_TG>();
		ArrayList<ESLT_SH_TG> updatetList = new ArrayList<ESLT_SH_TG>();
		
		for(int i = 0; i<eslt_sh_tg.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200507S", eslt_sh_tg.getObject(i)) > 0) {
				updatetList.add(eslt_sh_tg.getObject(i));
			}
			else {
				insertList.add(eslt_sh_tg.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_SH_TG_Upload_Temp(updatetList);
		int insertCount = anl02Dao.insert_ESLT_SH_TG_Upload_Temp(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
		
	}
	
	public void save_ESLT_DC_TG_TEMP(ESLT_DC_TG eslt_dc_tg) throws Exception {
		
		ArrayList<ESLT_DC_TG> insertList = new ArrayList<ESLT_DC_TG>();
		ArrayList<ESLT_DC_TG> updatetList = new ArrayList<ESLT_DC_TG>();
		
		for(int i = 0; i<eslt_dc_tg.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200508S", eslt_dc_tg.getObject(i)) > 0) {
				updatetList.add(eslt_dc_tg.getObject(i));
			}
			else {
				insertList.add(eslt_dc_tg.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_DC_TG_Upload_Temp(updatetList);
		int insertCount = anl02Dao.insert_ESLT_DC_TG_Upload_Temp(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
		
	}
	
	public void save_ESLT_CD_TG_TEMP(ESLT_CD_TG eslt_cd_tg) throws Exception {
		
		ArrayList<ESLT_CD_TG> insertList = new ArrayList<ESLT_CD_TG>();
		ArrayList<ESLT_CD_TG> updatetList = new ArrayList<ESLT_CD_TG>();
		
		for(int i = 0; i<eslt_cd_tg.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200509S", eslt_cd_tg.getObject(i)) > 0) {
				updatetList.add(eslt_cd_tg.getObject(i));
			}
			else {
				insertList.add(eslt_cd_tg.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_CD_TG_Upload_Temp(updatetList);
		int insertCount = anl02Dao.insert_ESLT_CD_TG_Upload_Temp(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
		
	}
	
	public void save_ESLT_NTS_TG_TEMP(ESLT_NTS_TG eslt_nts_tg) throws Exception {
		
		ArrayList<ESLT_NTS_TG> insertList = new ArrayList<ESLT_NTS_TG>();
		ArrayList<ESLT_NTS_TG> updatetList = new ArrayList<ESLT_NTS_TG>();
		
		for(int i = 0; i<eslt_nts_tg.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200510S", eslt_nts_tg.getObject(i)) > 0) {
				updatetList.add(eslt_nts_tg.getObject(i));
			}
			else {
				insertList.add(eslt_nts_tg.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_NTS_TG_Upload_Temp(updatetList);
		int insertCount = anl02Dao.insert_ESLT_NTS_TG_Upload_Temp(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
		
	}
	
	
	public void save_ESLT_NOTEG_TG_TEMP(ESLT_NOTEG_TG eslt_noteg_tg) throws Exception {
		
		ArrayList<ESLT_NOTEG_TG> insertList = new ArrayList<ESLT_NOTEG_TG>();
		ArrayList<ESLT_NOTEG_TG> updatetList = new ArrayList<ESLT_NOTEG_TG>();
		
		for(int i = 0; i<eslt_noteg_tg.getSize(); i++) {
			if(simpleDao.queryForInt("ANL0200511S", eslt_noteg_tg.getObject(i)) > 0) {
				updatetList.add(eslt_noteg_tg.getObject(i));
			}
			else {
				insertList.add(eslt_noteg_tg.getObject(i));
			}
		}
		
		int updateCount = anl02Dao.update_ESLT_NOTEG_TG_Upload_Temp(updatetList);
		int insertCount = anl02Dao.insert_ESLT_NOTEG_TG_Upload_Temp(insertList);
		
		logger.debug("updateCount : "+updateCount);
		logger.debug("insertCount : "+insertCount);
		
	}

	
}