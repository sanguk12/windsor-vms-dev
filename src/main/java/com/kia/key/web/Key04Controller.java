package com.kia.key.web;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.net.util.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kia.key.model.GKEY05MT;
import com.kia.key.model.GKEY06MT;
import com.kia.key.model.GKEY07MT;
import com.kia.key.model.GKEY08MT;
import com.kia.key.service.Key04Service;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.common.FileInfo;
import kr.co.nis.waf.common.FileUploadUtil;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.cms.model.DocLink;
import kr.co.nis.waf.system.cms.service.DocLinkService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.util.DateUtil;
import kr.co.nis.waf.view.SimpleDoc;

@Controller
@RequestMapping("/service/key04")
public class Key04Controller extends SimpleMultiActionController{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Value("#{system['docLink.realUploadPath']}")
	private String realUploadPath;
	
	@Value("#{system['docLink.realDownloadPath']}")
	private String realDownloadPath;
	
	@Value("#{system['docLink.fileServer.using']}")
	private String fileServer_using;
	
	@Value("#{system['docLink.fileServer.userID']}")
	private String fileServer_userID;
	
	@Value("#{system['docLink.fileServer.password']}")
	private String fileServer_password;
	
	
	@Resource
	private DocLinkService docLinkService;
	
	@Resource
	private CodeService codeService;
	
	@Resource
	private SimpleService simpleService;
	
	@Resource
	private Key04Service key04Service;
	
	@RequestMapping("/signSearch")
	public ModelAndView signSearch(HttpServletRequest request, HttpServletResponse reponse) throws Exception {
		Map command = new HashMap();
		bind(request, command);
		String outParamKey[] = null;
		try {
			outParamKey = ((String) command.get("outParamKey")).split(";");
		} catch (Exception e) {
		}
		
		
		List rslt = new ArrayList();
		HashMap param = new HashMap();
		param.put("kmID", command.get("kmID"));
		param.put("wordType", command.get("wordType"));
		
		Map sign = (Map) key04Service.signSearch(param);
		if (outParamKey != null && sign != null) {
				Map data = new LinkedHashMap();
				for (int j = 0; j < outParamKey.length; j++)
					data.put(outParamKey[j], sign.get(outParamKey[j]));

				rslt.add(data);

		} else {
			rslt = (List) sign;
		}
		
		if(rslt != null) {
			SimpleDoc simpleDoc = new SimpleDoc("XML", rslt);
			if (command.containsKey("format"))
				simpleDoc.setFormat(((String) command.get("format")).split(";"));
			return simpleDoc.create();
		}
		else {
			return null;
		}
	}
	
	@RequestMapping("/saveSaleRegist")
	public ModelAndView saveSaleRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY05MT gkey05mt = new GKEY05MT();
		GKEY06MT gkey06mt = new GKEY06MT();
		GKEY07MT gkey07mt = new GKEY07MT();
		GKEY08MT gkey08mt = new GKEY08MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		gkey05mt.setRegID(session.getUserID());
		bind(request, gkey05mt);
		bind(request, gkey06mt);
		bind(request, gkey07mt);
		bind(request, gkey08mt);
		
		try {
			gkey05mt.clean();
			gkey05mt.validate(gkey05mt.ACTION_SAVE);
			gkey05mt.setEmpID(session.getEmpID());
			
			gkey06mt.clean();
			gkey06mt.validate(gkey05mt.ACTION_SAVE);
			gkey06mt.setEmpID(session.getEmpID());
			
			gkey07mt.clean();
			gkey07mt.validate(gkey05mt.ACTION_SAVE);
			gkey07mt.setEmpID(session.getEmpID());
			
			gkey08mt.clean();
			gkey08mt.validate(gkey05mt.ACTION_SAVE);
			gkey08mt.setEmpID(session.getEmpID());
			
			
			System.out.println("================" + request.getParameter("data"));
			
			if(request.getParameter("data") != null){
				String fileDocLink = signImg(request.getParameter("data"), gkey05mt.getKeymanID(), gkey05mt.getCompanyID(), request.getParameter("linkDivCD"));
				gkey05mt.setFileDocLink(fileDocLink);
			}
			
			key04Service.insertSaleRegist(gkey05mt, gkey06mt, gkey07mt, gkey08mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.save"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
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
	
	@RequestMapping("/updateGKEY05MT")
	public ModelAndView updateGKEY05MT(HttpServletRequest request, HttpServletResponse response) throws Exception {
		GKEY05MT gkey05mt = new GKEY05MT();
		ResultMessage rm = new ResultMessage();
		SessionManager session = new SessionManager(request, response);

		gkey05mt.setRegID(session.getUserID());
		bind(request, gkey05mt);
		
		try {
			gkey05mt.clean();
			gkey05mt.validate(gkey05mt.ACTION_SAVE);
			
			gkey05mt.setEmpID(session.getEmpID());

			key04Service.updateGKEY05MT(gkey05mt);
			
			rm.setCode(rm.RESULT_SUCCESS);
			rm.setMessage(getMessageSourceAccessor().getMessage("success.update"));
		}
		catch (InputRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (SelectRequiredException e) {
			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
		}
		catch (Exception e) {
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
	
	public String signImg(String data, String keymanID, String companyID, String linkDivCD) throws Exception
	  {
	    DocLink docLink = new DocLink();
	    Code seqID = new Code();

	    docLink.setCompanyID(companyID);
	    docLink.setLinkDivCD(linkDivCD);
	    seqID.setCompanyID(companyID);

	    data = data.replaceAll("data:image/png;base64,", "");
	    byte[] file = Base64.decodeBase64(data);
	    ByteArrayInputStream is = new ByteArrayInputStream(file);

	    String uploadPath = this.realUploadPath;
	    FileOutputStream fout = null;
	    int fsize = 0;
	    UUID tmpUUID = null;
	    try
	    {
	      if (is != null) {
	        if (this.fileServer_using.equals("Y")) {
	          try
	          {
	            String command = this.realUploadPath + "/ user:" + this.fileServer_userID + " " + this.fileServer_password;
	            Runtime.getRuntime().exec(command);
	          }
	          catch (IOException e)
	          {
	          }
	        }
	        else {
	          uploadPath = this.realUploadPath;
	        }

	        if (this.configure.getUploadDirUse().equals("Y"))
	        {
	          File dir = new File(uploadPath + docLink.getLinkDivCD());
	          try {
	            if (!dir.isDirectory()) dir.mkdirs(); 
	          }
	          catch (Exception e)
	          {
	            dir.mkdirs();
	          }

	          uploadPath = uploadPath + docLink.getLinkDivCD() + "/";
	        }

	        if (this.configure.getUploadFileNameOption().equals("UUID")) {
	          tmpUUID = UUID.randomUUID();
	          fout = new FileOutputStream(uploadPath + "/" + tmpUUID);
	        }
	        else {
	          fout = new FileOutputStream(uploadPath + "/" + keymanID + ".png");
	        }
	        while (true) {
	          int size = is.read();
	          if (size == -1) break;
	          fout.write(size);

	          fsize++;
	        }

	        docLink.setFileName(keymanID + ".png");
	        docLink.setFileTypeCD("png");
	        docLink.setFileSize(String.valueOf(fsize));
	        if (this.configure.getUploadDirUse().equals("Y")) {
	          docLink.setFileUrl(docLink.getLinkDivCD() + "/");
	        }
	        else {
	          docLink.setFileUrl("");
	        }
	        docLink.setRemark("");
	        docLink.setUuID(String.valueOf(tmpUUID));

	        seqID.setSeqDiv("DOCLINKID");
	        String docLinkID = this.codeService.getSeqID(seqID).get("seqID").toString();
	        docLink.setDocLinkID(docLinkID);

	        this.simpleService.insert("commonservice.docLink.insert", docLink);
	      }
	    }
	    catch (Exception e) {
	      e.printStackTrace();

	      if (this.logger.isDebugEnabled()) {
	        this.logger.debug(e.toString());
	      }
	    }

	    return docLink.getDocLinkID();
	  }
}
