package kr.co.nis.waf.system.cms.web;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.common.FileInfo;
import kr.co.nis.waf.common.FileUploadUtil;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.biz.model.Code;
import kr.co.nis.waf.system.biz.service.CodeService;
import kr.co.nis.waf.system.cms.model.DocLink;
import kr.co.nis.waf.system.cms.service.DocLinkService;
import kr.co.nis.waf.system.common.web.SessionManager;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/service/doclink")
public class DocLinkController extends SimpleMultiActionController {

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

	
	@RequestMapping("/deleteListFile")
	public ModelAndView deleteListFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav;
		Map content = new HashMap();
		DocLink docLink = new DocLink();

		bind(request, docLink);
		bind(request, content);

		content.put("isView", StringUtil.nullToBlank(request.getParameter("isView"), "true"));

		try {
			docLinkService.deleteDocLink(docLink);
			mav = new ModelAndView("cms/doclinklist");
			mav.addObject("docLinkList", simpleService.queryForList("commonservice.docLinkList.select", docLink));
			content.put("msg", getMessageSourceAccessor().getMessage("success.remove"));
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.debug(e.toString());
			}
			content.put("msg", getMessageSourceAccessor().getMessage("failure.remove"));
			mav = new ModelAndView("defaultErrorMessage");
		}
		mav.addObject("paramFile", content);
		return mav;
	}

	@RequestMapping("/downloadFile")
	public ModelAndView downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map content = new HashMap();
		DocLink docLink = new DocLink();

		bind(request, docLink);
		
		content = simpleService.queryForMap("commonservice.docLink.select", docLink);

		String fileName = content.get("fileName").toString();
		String fileUrl = StringUtil.nullToBlank(content.get("fileUrl"));
		String uuID = content.get("uuID").toString();

		Map parameters = new HashMap();
		parameters.put("fileName", fileName);
		parameters.put("tempFileName", uuID);
		
		String downloadPath = realDownloadPath;
		if(fileServer_using.equals("Y")) {
			try {
				// ex) \\\\52.2.200.137\\uploadFiles
				String command = downloadPath+"/ user:"+fileServer_userID+" "+fileServer_password;
				Runtime.getRuntime().exec(command);
			}
			catch(IOException e){
			}
			
		}
		else {
			downloadPath = realDownloadPath;
		}
		
		parameters.put("uploadDir", downloadPath+fileUrl);
		return new ModelAndView("downloadView", parameters);
	}

	@RequestMapping("/insertFile")
	public ModelAndView insertFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Map content = new HashMap();
		DocLink docLink = new DocLink();
		Code seqID = new Code();

		bind(request, docLink);
		bind(request, content);
		bind(request, seqID);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator fileNameIterator = mpRequest.getFileNames();

		while (fileNameIterator.hasNext()) {
			MultipartFile multiFile = mpRequest.getFile((String) fileNameIterator.next());

			if (multiFile.getSize() > 0) {
				
				String uploadPath = realUploadPath;
				int fileNameOption = FileUploadUtil.ORIGINAL_FILE_NAME;
				
				if (configure.getUploadDirUse().equals("Y")) {
					
					File dir = new File(uploadPath + docLink.getLinkDivCD());
					try {
						if (!dir.isDirectory()) dir.mkdirs();
					}
					catch (Exception e) {
						dir.mkdirs();
					}
					
					uploadPath = uploadPath + docLink.getLinkDivCD() + "/";
				}
				
				if (configure.getUploadFileNameOption().equals("UUID")) {
					fileNameOption = FileUploadUtil.UUID_FILE_NAME;
				}
				
				FileInfo fileInfo = FileUploadUtil.uploadFormFile(multiFile, uploadPath, fileNameOption);
				docLink.setFileName(fileInfo.getFileName());
				docLink.setFileTypeCD(fileInfo.getFileName().substring(fileInfo.getFileName().length() - 3, fileInfo.getFileName().length()));
				docLink.setFileSize(String.valueOf(fileInfo.getFileSize()));
				if (configure.getUploadDirUse().equals("Y")) {
					docLink.setFileUrl(docLink.getLinkDivCD()+"/");
				}
				else {
					docLink.setFileUrl("");
				}
				docLink.setRemark("");
				docLink.setUuID(fileInfo.getTempFileName());
				seqID.setSeqDiv("DOCLINKID");
				String docLinkID = (codeService.getSeqID(seqID)).get("seqID").toString();
				docLink.setDocLinkID(docLinkID);
				try {
					if (logger.isDebugEnabled()) {
						logger.debug(docLink);
					}
					
					simpleService.insert("commonservice.docLink.insert", docLink);
					content.put("msg", getMessageSourceAccessor().getMessage("success.upload"));
					mav = new ModelAndView("cms/fileupload");
				}
				catch (Exception e) {
					e.printStackTrace();

					if (logger.isDebugEnabled()) {
						logger.debug(e.toString());
					}
					content.put("msg", getMessageSourceAccessor().getMessage("failure.upload"));
					mav = new ModelAndView("defaultErrorMessage");
				}
			}
		}
		mav.addObject("fileUpload", content);
		return mav;
	}
	
	@RequestMapping("/insertFileForYUI")
	public ModelAndView insertFileForYUI(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ModelAndView mav = new ModelAndView();
		Map content = new HashMap();
		DocLink docLink = new DocLink();
		Code seqID = new Code();

		bind(request, docLink);
		bind(request, content);
		bind(request, seqID);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator fileNameIterator = mpRequest.getFileNames();

		while (fileNameIterator.hasNext()) {
			MultipartFile multiFile = mpRequest.getFile((String) fileNameIterator.next());

			if (multiFile.getSize() > 0) {

				String uploadPath = realUploadPath;
				
				if(fileServer_using.equals("Y")) {
					try {
						// ex) \\\\52.2.200.137\\uploadFiles
						String command = realUploadPath+"/ user:"+fileServer_userID+" "+fileServer_password;
						Runtime.getRuntime().exec(command);
					}
					catch(IOException e){
					}
					
				}
				else {
					uploadPath = realUploadPath;
				}
				
				int fileNameOption = FileUploadUtil.ORIGINAL_FILE_NAME;
				
				if (configure.getUploadDirUse().equals("Y")) {
					
					File dir = new File(uploadPath + docLink.getLinkDivCD());
					try {
						if (!dir.isDirectory()) dir.mkdirs();
					}
					catch (Exception e) {
						dir.mkdirs();
					}
					
					uploadPath = uploadPath + docLink.getLinkDivCD() + "/";
				}
				
				if (configure.getUploadFileNameOption().equals("UUID")) {
					fileNameOption = FileUploadUtil.UUID_FILE_NAME;
				}
				
				FileInfo fileInfo = FileUploadUtil.uploadFormFile(multiFile, uploadPath, fileNameOption);
				
				docLink.setFileName(fileInfo.getFileName());
				docLink.setFileTypeCD(fileInfo.getFileName().substring(fileInfo.getFileName().length() - 3, fileInfo.getFileName().length()));
				docLink.setFileSize(String.valueOf(fileInfo.getFileSize()));
				if (configure.getUploadDirUse().equals("Y")) {
					docLink.setFileUrl(docLink.getLinkDivCD()+"/");
				}
				else {
					docLink.setFileUrl("");
				}
				docLink.setRemark("");
				docLink.setUuID(fileInfo.getTempFileName());
				
				seqID.setSeqDiv("DOCLINKID");
				String docLinkID = (codeService.getSeqID(seqID)).get("seqID").toString();
				docLink.setDocLinkID(docLinkID);
				
				try {
					simpleService.insert("commonservice.docLink.insert", docLink);
					content.put("msg", getMessageSourceAccessor().getMessage("success.upload"));
					mav = new ModelAndView("simpleHtmlView");
					mav.addObject("html","S;"+docLink.getFileTypeCD()+";"+docLink.getFileName()+";"+docLink.getFileSize()+";"+docLink.getDocLinkID()+";"+docLink.getUuID()+";"+docLink.getFileUrl()+";");
				}
				catch (Exception e) {
					e.printStackTrace();

					if (logger.isDebugEnabled()) {
						logger.debug(e.toString());
					}
					//content.put("msg", getMessageSourceAccessor().getMessage("failure.upload"));
					//mav = new ModelAndView("defaultErrorMessage");
					mav = new ModelAndView("simpleHtmlView");
					mav.addObject("html","E;");
				}
			}
		}
		
		return mav;
	}
	
	@RequestMapping("/insertFileForMobile")
	public ModelAndView insertFileForMobile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ResultMessage rm = new ResultMessage();
		ModelAndView mav = new ModelAndView();
		Map content = new HashMap();
		DocLink docLink = new DocLink();
		Code seqID = new Code();

		docLink.setLinkDivCD(request.getParameter("linkDivCD"));
		String companyID = request.getParameter("companyID");
		String kmID = request.getParameter("kmID");
		String wordType = request.getParameter("wordType");
		String viewName = request.getParameter("viewName");
		
		bind(request, content);
		bind(request, seqID);

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		Iterator fileNameIterator = mpRequest.getFileNames();

		while (fileNameIterator.hasNext()) {
			MultipartFile multiFile = mpRequest.getFile((String) fileNameIterator.next());

			if (multiFile.getSize() > 0) {

				String uploadPath = realUploadPath;
				
				if(fileServer_using.equals("Y")) {
					try {
						// ex) \\\\52.2.200.137\\uploadFiles
						String command = realUploadPath+"/ user:"+fileServer_userID+" "+fileServer_password;
						Runtime.getRuntime().exec(command);
					}
					catch(IOException e){
					}
					
				}
				else {
					uploadPath = realUploadPath;
				}
				
				int fileNameOption = FileUploadUtil.ORIGINAL_FILE_NAME;
				
				if (configure.getUploadDirUse().equals("Y")) {
					
					File dir = new File(uploadPath + docLink.getLinkDivCD());
					try {
						if (!dir.isDirectory()) dir.mkdirs();
					}
					catch (Exception e) {
						dir.mkdirs();
					}
					
					uploadPath = uploadPath + docLink.getLinkDivCD() + "/";
				}
				
				if (configure.getUploadFileNameOption().equals("UUID")) {
					fileNameOption = FileUploadUtil.UUID_FILE_NAME;
				}
				
				FileInfo fileInfo = FileUploadUtil.uploadFormFile(multiFile, uploadPath, fileNameOption);
				
				docLink.setCompanyID(companyID);
				docLink.setFileName(fileInfo.getFileName());
				docLink.setFileTypeCD(fileInfo.getFileName().substring(fileInfo.getFileName().length() - 3, fileInfo.getFileName().length()));
				docLink.setFileSize(String.valueOf(fileInfo.getFileSize()));
				if (configure.getUploadDirUse().equals("Y")) {
					docLink.setFileUrl(docLink.getLinkDivCD()+"/");
				}
				else {
					docLink.setFileUrl("");
				}
				docLink.setRemark("");
				docLink.setUuID(fileInfo.getTempFileName());
				
				seqID.setSeqDiv("DOCLINKID");
				String docLinkID = (codeService.getSeqID(seqID)).get("seqID").toString();
				docLink.setDocLinkID(docLinkID);
				
				File f = new File(uploadPath + StringUtil.nullToBlank(docLink.getUuID()));
				
				resizeImage(f, f, "");
				
				try {
					simpleService.insert("commonservice.docLink.insert", docLink);
					if(wordType.equals("300")) {
						mav = new ModelAndView("key/KEY04001D");
					}
					else if(wordType.equals("400")) {
						mav = new ModelAndView("key/KEY04001F");
					}
					Map params = new HashMap();
					
					params.put("kmID", kmID);
					params.put("wordType", wordType);
					params.put("docLinkID", docLink.getDocLinkID());
					params.put("fileUrl", docLink.getFileUrl());
					params.put("UUID", docLink.getUuID());
					params.put("fileName", docLink.getFileName());
					params.put("viewTitle", viewName);
					params.put("viewName", viewName);
					setObjectAll(mav, request, response, params);
				}
				catch (Exception e) {
					e.printStackTrace();

					if (logger.isDebugEnabled()) {
						logger.debug(e.toString());
					}
				}
			}
		}
		
		return mav;
	}
	
	
	public void resizeImage(File input, File output, String removeYn) throws Exception {
		
		BufferedImage oldImage = ImageIO.read(input);
		input.delete();
		
		BufferedImage newImage = new BufferedImage(oldImage.getHeight(), oldImage.getWidth(), oldImage.getType());
		
		Graphics2D graphics = (Graphics2D)newImage.getGraphics();
		
		if(removeYn.equals("L")) {
			graphics.rotate(Math.toRadians(-90), newImage.getWidth()/2, newImage.getHeight()/2);
		}
		else {
			graphics.rotate(Math.toRadians(90), newImage.getWidth()/2, newImage.getHeight()/2);
		}
		
		graphics.translate((newImage.getWidth()-oldImage.getWidth())/2, (newImage.getHeight()-oldImage.getHeight())/2); 
		
		graphics.drawImage(oldImage, 0, 0, oldImage.getWidth(), oldImage.getHeight(), null);

		ImageIO.write(newImage, "png", new FileOutputStream(output));
	}
	
	@RequestMapping("/deleteFile")
	public ModelAndView deleteFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		DocLink docLink = new DocLink();
		ResultMessage rm = new ResultMessage();

		bind(request, docLink);
		
		try {
			
			if(simpleService.queryForInt("commonservice.docLink.selectCount", docLink)!=0){
				Map fileInfo = simpleService.queryForMap("commonservice.docLink.select", docLink);
				String uploadPath = realUploadPath;
				
				if(fileServer_using.equals("Y")) {
					try {
						// ex) \\\\52.2.200.137\\uploadFiles
						String command = realUploadPath+"/ user:"+fileServer_userID+" "+fileServer_password;
						Runtime.getRuntime().exec(command);
					}
					catch(IOException e){
					}
				}
				
				File f = new File(uploadPath + StringUtil.nullToBlank(fileInfo.get("fileUrl")) + StringUtil.nullToBlank(fileInfo.get("uuID")));
				f.delete();
				
				docLinkService.deleteDocLink(docLink);
				
				rm.setCode(rm.RESULT_SUCCESS);
				rm.setMessage(getMessageSourceAccessor().getMessage("success.delete"));
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled())
			{
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.delete"));
			rm.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}	

	@RequestMapping("/listFile")
	public ModelAndView listFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav;
		Map param = new HashMap();
		DocLink docLink = new DocLink();

		bind(request, docLink);
		bind(request, param);

		param.put("isView", StringUtil.nullToBlank(request.getParameter("isView"), "true"));
		mav = new ModelAndView("cms/doclinklist");
		mav.addObject("docLinkList", simpleService.queryForList("commonservice.docLinkList.select", docLink));
		mav.addObject("paramFile", param);
		setObjectAll(mav, request, response, param);

		return mav;
	}

	@RequestMapping("/uploadFileInit")
	public ModelAndView uploadFileInit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav;
		Map param = new HashMap();

		bind(request, param);

		mav = new ModelAndView("cms/fileupload");
		mav.addObject("param", param);
		setObjectAll(mav, request, response, param);
		return mav;
	}
	
	//전환 버튼
	@RequestMapping("/removeImg")
	public ModelAndView removeImg (HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SessionManager session = new SessionManager(request, response);
		ModelAndView mav = new ModelAndView();
		DocLink docLink = new DocLink();
		UUID tmpUUID = UUID.randomUUID();

		String kmID = request.getParameter("kmID");
		String companyID = request.getParameter("companyID");
		String wordType = request.getParameter("wordType");
		String viewName = request.getParameter("viewName");
		String removeCD = request.getParameter("removeCD");
		docLink.setLinkDivCD(request.getParameter("linkDivCD"));
		docLink.setDocLinkID(request.getParameter("docLinkID"));
		docLink.setCompanyID(companyID);
		docLink.setUuID(String.valueOf(tmpUUID));
		
		if(simpleService.queryForInt("commonservice.docLink.selectCount", docLink)!=0){
			Map fileInfo = simpleService.queryForMap("commonservice.docLink.select", docLink);
			String uploadPath = realUploadPath;
			
			if(fileServer_using.equals("Y")) {
				try {
					// ex) \\\\52.2.200.137\\uploadFiles
					String command = realUploadPath+"/ user:"+fileServer_userID+" "+fileServer_password;
					Runtime.getRuntime().exec(command);
				}
				catch(IOException e){
				}
			}
			
			File inf = new File(uploadPath + StringUtil.nullToBlank(fileInfo.get("fileUrl")) + StringUtil.nullToBlank(fileInfo.get("uuID")));
			File outf = new File(uploadPath + StringUtil.nullToBlank(fileInfo.get("fileUrl")) + StringUtil.nullToBlank(docLink.getUuID()));
			
			resizeImage(inf, outf, removeCD);
				
			docLink.setFileUrl((String) fileInfo.get("fileUrl"));
			try {
				simpleService.update("KEY0400103U", docLink);
				if(wordType.equals("300")) {
					mav = new ModelAndView("key/KEY04001D");
				}
				else if(wordType.equals("400")) {
					mav = new ModelAndView("key/KEY04001F");
				}
				Map params = new HashMap();
				
				params.put("kmID", kmID);
				params.put("wordType", wordType);
				params.put("docLinkID", docLink.getDocLinkID());
				params.put("fileUrl", docLink.getFileUrl());
				params.put("UUID", docLink.getUuID());
				params.put("viewTitle", viewName);
				params.put("viewName", viewName);
				setObjectAll(mav, request, response, params);
			}
			catch (Exception e) {
				e.printStackTrace();

				if (logger.isDebugEnabled()) {
					logger.debug(e.toString());
				}
				
				if(wordType.equals("300")) {
					mav = new ModelAndView("key/KEY04001D");
				}
				else if(wordType.equals("400")) {
					mav = new ModelAndView("key/KEY04001F");
				}
			}
		}
		
		return mav;
	}
	/*@RequestMapping("/removeImg")
	public ModelAndView removeImg (HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		DocLink docLink = new DocLink();
		ResultMessage rm = new ResultMessage();
		String removeYn = request.getParameter("removeYn");
		
		bind(request, docLink);
		
		try {
			
			if(simpleService.queryForInt("commonservice.docLink.selectCount", docLink)!=0){
				Map fileInfo = simpleService.queryForMap("commonservice.docLink.select", docLink);
				String uploadPath = realUploadPath;
				
				if(fileServer_using.equals("Y")) {
					try {
						// ex) \\\\52.2.200.137\\uploadFiles
						String command = realUploadPath+"/ user:"+fileServer_userID+" "+fileServer_password;
						Runtime.getRuntime().exec(command);
					}
					catch(IOException e){
					}
				}
				
				File f = new File(uploadPath + StringUtil.nullToBlank(fileInfo.get("fileUrl")) + StringUtil.nullToBlank(fileInfo.get("uuID")));
				
				resizeImage(f, f, removeYn);
				//f.delete();
				
				//docLinkService.deleteDocLink(docLink);
				
				rm.setCode(rm.RESULT_SUCCESS);
				rm.setParameters((String) fileInfo.get("fileUrl"));
				rm.setParameters((String) fileInfo.get("uuID"));
				rm.setMessage(getMessageSourceAccessor().getMessage("success.delete"));
			}
		}
		catch (Exception e) {
			if (logger.isDebugEnabled())
			{
				logger.debug(e.toString());
				e.printStackTrace();
			}

			rm.setCode(rm.RESULT_ERROR);
			rm.setMessage(getMessageSourceAccessor().getMessage("failure.delete"));
			rm.setSystemMessage(e.toString());
		}
		
		ModelAndView mv = new ModelAndView("resultView");
		mv.addObject("resultMsg", rm);

		return mv;
	}*/
}