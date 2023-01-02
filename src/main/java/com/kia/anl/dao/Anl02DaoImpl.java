package com.kia.anl.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientCallback;

import com.ibatis.sqlmap.client.SqlMapExecutor;
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

import kr.co.nis.waf.orm.WafSqlMapClientDaoSupport;

public class Anl02DaoImpl extends WafSqlMapClientDaoSupport implements Anl02Dao{

	@Override
	public int insert_ESLT_BRANCH_MT_Upload(final ArrayList<ESLT_BRANCH_MT> eslt_branch_mt) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_branch_mt.size(); i++) {
						executor.insert("ANL0200101I", eslt_branch_mt.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_CUSTOMER_MT_Upload(final ArrayList<ESLT_CUSTOMER_MT> eslt_customer_mt) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_customer_mt.size(); i++) {
						executor.insert("ANL0200102I", eslt_customer_mt.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_PRODUCT_MT_Upload(final ArrayList<ESLT_PRODUCT_MT> eslt_product_mt) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_product_mt.size(); i++) {
						executor.insert("ANL0200103I", eslt_product_mt.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_PRODUCT_SEQ_Upload(final ArrayList<ESLT_PRODUCT_SEQ> eslt_product_seq) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_product_seq.size(); i++) {
						executor.insert("ANL0200104I", eslt_product_seq.get(i));
						executor.insert("ANL0200105I", eslt_product_seq.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_TEAM_MT_Upload(final ArrayList<ESLT_TEAM_MT> eslt_team_mt) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_team_mt.size(); i++) {
						executor.insert("ANL0200201I", eslt_team_mt.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_AREA_MT_Upload(final ArrayList<ESLT_AREA_MT> eslt_area_mt) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_area_mt.size(); i++) {
						executor.insert("ANL0200202I", eslt_area_mt.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_SH_ACT_Upload(final ArrayList<ESLT_SH_ACT> eslt_sh_act) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_sh_act.size(); i++) {
						executor.insert("ANL0200301I", eslt_sh_act.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_DC_ACT_Upload(final ArrayList<ESLT_DC_ACT> eslt_dc_act) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_dc_act.size(); i++) {
						executor.insert("ANL0200302I", eslt_dc_act.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_DC_FCACT_Upload(final ArrayList<ESLT_DC_FCACT> eslt_dc_fcact) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_dc_fcact.size(); i++) {
						executor.insert("ANL0200303I", eslt_dc_fcact.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_CD_ACT_Upload(final ArrayList<ESLT_CD_ACT> eslt_cd_act) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_cd_act.size(); i++) {
						executor.insert("ANL0200304I", eslt_cd_act.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_NTS_ACT_Upload(final ArrayList<ESLT_NTS_ACT> eslt_nts_act) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_nts_act.size(); i++) {
						executor.insert("ANL0200305I", eslt_nts_act.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_NOTEG_ACT_Upload(final ArrayList<ESLT_NOTEG_ACT> eslt_noteg_act) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_noteg_act.size(); i++) {
						executor.insert("ANL0200306I", eslt_noteg_act.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_SH_TG_Upload(final ArrayList<ESLT_SH_TG> eslt_sh_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_sh_tg.size(); i++) {
						executor.insert("ANL0200401I", eslt_sh_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_DC_TG_Upload(final ArrayList<ESLT_DC_TG> eslt_dc_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_dc_tg.size(); i++) {
						executor.insert("ANL0200402I", eslt_dc_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_CD_TG_Upload(final ArrayList<ESLT_CD_TG> eslt_cd_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_cd_tg.size(); i++) {
						executor.insert("ANL0200403I", eslt_cd_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_NTS_TG_Upload(final ArrayList<ESLT_NTS_TG> eslt_nts_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_nts_tg.size(); i++) {
						executor.insert("ANL0200404I", eslt_nts_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_NOTEG_TG_Upload(final ArrayList<ESLT_NOTEG_TG> eslt_noteg_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_noteg_tg.size(); i++) {
						executor.insert("ANL0200405I", eslt_noteg_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_SH_FC_Upload(final ArrayList<ESLT_SH_FC> eslt_sh_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_sh_fc.size(); i++) {
						executor.insert("ANL0200501U", eslt_sh_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_DC_FC_Upload(final ArrayList<ESLT_DC_FC> eslt_dc_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_dc_fc.size(); i++) {
						executor.insert("ANL0200502U", eslt_dc_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_CD_FC_Upload(final ArrayList<ESLT_CD_FC> eslt_cd_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_cd_fc.size(); i++) {
						executor.insert("ANL0200503U", eslt_cd_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_SH_FC_Upload(final ArrayList<ESLT_SH_FC> eslt_sh_fc) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_sh_fc.size(); i++) {
						executor.insert("ANL0200501I", eslt_sh_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_DC_FC_Upload(final ArrayList<ESLT_DC_FC> eslt_dc_fc) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_dc_fc.size(); i++) {
						executor.insert("ANL0200502I", eslt_dc_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_CD_FC_Upload(final ArrayList<ESLT_CD_FC> eslt_cd_fc) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_cd_fc.size(); i++) {
						executor.insert("ANL0200503I", eslt_cd_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_SH_OL_Upload(final ArrayList<ESLT_SH_FC> eslt_sh_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_sh_fc.size(); i++) {
						executor.insert("ANL0200601U", eslt_sh_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_DC_OL_Upload(final ArrayList<ESLT_DC_FC> eslt_dc_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_dc_fc.size(); i++) {
						executor.insert("ANL0200602U", eslt_dc_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_CD_OL_Upload(final ArrayList<ESLT_CD_FC> eslt_cd_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_cd_fc.size(); i++) {
						executor.insert("ANL0200603U", eslt_cd_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_NTS_FC_Upload(final ArrayList<ESLT_NTS_FC> eslt_nts_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_nts_fc.size(); i++) {
						executor.insert("ANL0200701U", eslt_nts_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_NOTEG_FC_Upload(final ArrayList<ESLT_NOTEG_FC> eslt_noteg_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_noteg_fc.size(); i++) {
						executor.insert("ANL0200702U", eslt_noteg_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_NTS_FC_Upload(final ArrayList<ESLT_NTS_FC> eslt_nts_fc) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_nts_fc.size(); i++) {
						executor.insert("ANL0200701I", eslt_nts_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	@Override
	public int insert_ESLT_NOTEG_FC_Upload(final ArrayList<ESLT_NOTEG_FC> eslt_noteg_fc) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_noteg_fc.size(); i++) {
						executor.insert("ANL0200702I", eslt_noteg_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_NTS_OL_Upload(final ArrayList<ESLT_NTS_FC> eslt_nts_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_nts_fc.size(); i++) {
						executor.insert("ANL0200801U", eslt_nts_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int update_ESLT_NOTEG_OL_Upload(final ArrayList<ESLT_NOTEG_FC> eslt_noteg_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_noteg_fc.size(); i++) {
						executor.insert("ANL0200802U", eslt_noteg_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}

	public int insert_ESLT_NTS_OL_Upload(final ArrayList<ESLT_NTS_FC> eslt_nts_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_nts_fc.size(); i++) {
						executor.insert("ANL0200801I", eslt_nts_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	public int insert_ESLT_NOTEG_OL_Upload(final ArrayList<ESLT_NOTEG_FC> eslt_noteg_fc) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_noteg_fc.size(); i++) {
						executor.insert("ANL0200802I", eslt_noteg_fc.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	/*ESLT_SH_TG 신규 insert 로직*/
	@Override
	public int insert_ESLT_SH_TG_Upload_Temp(final ArrayList<ESLT_SH_TG> eslt_sh_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_sh_tg.size(); i++) {
						executor.insert("ANL0200504I", eslt_sh_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	/*ESLT_SH_TG 신규 update 로직*/
	public int update_ESLT_SH_TG_Upload_Temp(final ArrayList<ESLT_SH_TG> eslt_sh_tg) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_sh_tg.size(); i++) {
						executor.insert("ANL0200504U", eslt_sh_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	
	/*ESLT_DC_TG 신규 insert 로직*/
	@Override
	public int insert_ESLT_DC_TG_Upload_Temp(final ArrayList<ESLT_DC_TG> eslt_dc_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_dc_tg.size(); i++) {
						executor.insert("ANL0200505I", eslt_dc_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	/*ESLT_DC_TG 신규 update 로직*/
	public int update_ESLT_DC_TG_Upload_Temp(final ArrayList<ESLT_DC_TG> eslt_dc_tg) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_dc_tg.size(); i++) {
						executor.insert("ANL0200505U", eslt_dc_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	
	/*ESLT_CD_TG 신규 insert 로직*/
	@Override
	public int insert_ESLT_CD_TG_Upload_Temp(final ArrayList<ESLT_CD_TG> eslt_cd_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_cd_tg.size(); i++) {
						executor.insert("ANL0200506I", eslt_cd_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	/*ESLT_CD_TG 신규 update 로직*/
	public int update_ESLT_CD_TG_Upload_Temp(final ArrayList<ESLT_CD_TG> eslt_cd_tg) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_cd_tg.size(); i++) {
						executor.insert("ANL0200506U", eslt_cd_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	
	/*ESLT_NTS_TG 신규 insert 로직*/
	@Override
	public int insert_ESLT_NTS_TG_Upload_Temp(final ArrayList<ESLT_NTS_TG> eslt_nts_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_nts_tg.size(); i++) {
						executor.insert("ANL0200507I", eslt_nts_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	/*ESLT_NTS_TG 신규 update 로직*/
	public int update_ESLT_NTS_TG_Upload_Temp(final ArrayList<ESLT_NTS_TG> eslt_nts_tg) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_nts_tg.size(); i++) {
						executor.insert("ANL0200507U", eslt_nts_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	
	/*ESLT_NOTEG_TG 신규 insert 로직*/
	@Override
	public int insert_ESLT_NOTEG_TG_Upload_Temp(final ArrayList<ESLT_NOTEG_TG> eslt_noteg_tg) throws DataAccessException {
		//try {
				Integer insertCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_noteg_tg.size(); i++) {
						executor.insert("ANL0200508I", eslt_noteg_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return insertCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
	/*ESLT_NOTEG_TG 신규 update 로직*/
	public int update_ESLT_NOTEG_TG_Upload_Temp(final ArrayList<ESLT_NOTEG_TG> eslt_noteg_tg) throws DataAccessException {
		//try {
			Integer updateCount = (Integer)getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					for(int i=0; i<eslt_noteg_tg.size(); i++) {
						executor.insert("ANL0200508U", eslt_noteg_tg.get(i));
					}
					return new Integer(executor.executeBatch());
				}
			});
			return updateCount;
		//}
		//catch (Exception e) {
			//return -1;
		//}
	}
	
}
