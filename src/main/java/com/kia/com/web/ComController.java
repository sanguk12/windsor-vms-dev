package com.kia.com.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nis.waf.ResultMessage;
import kr.co.nis.waf.dao.SimpleService;
import kr.co.nis.waf.system.common.model.InputRequiredException;
import kr.co.nis.waf.system.common.model.RandomGenerator;
import kr.co.nis.waf.system.common.model.SelectRequiredException;
import kr.co.nis.waf.system.common.web.EmailSender;
import kr.co.nis.waf.system.common.web.SimpleMultiActionController;
import kr.co.nis.waf.view.SimpleDoc;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kia.com.service.ComService;


@Controller
@RequestMapping("/service/com")
public class ComController extends SimpleMultiActionController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	private ComService comService;
	
	@Resource
	private SimpleService simpleService;
	
	@Resource
	private EmailSender emailSender;
	
	@Value("#{appenv['web.url']}")
	private String web_url;
	
//	@RequestMapping("/initialPwdCustStaff")
//	public ModelAndView initialPwdCustStaff(HttpServletRequest request, HttpServletResponse response) throws Exception {
//
//		Map<String, String> map = new HashMap<String, String>();
//		
//		ResultMessage rm = new ResultMessage();
//
//		bind(request, map);
//		
//		try {
//			RandomGenerator generator = new RandomGenerator();
//			String passwd = generator.getData(10);
//			map.put("pwd", passwd);
//			comService.initialPwdCustStaff(map);
//			
//			String email_addr = map.get("email_addr").toString();
//			if(!email_addr.equals("")) {
//				String content = "";
//				content+="<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> \n";
//				content+="<html xmlns='http://www.w3.org/1999/xhtml' lang='ko' xml:lang='ko'> \n";
//				content+="<head> \n";
//				content+="<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> \n";
//				content+="<meta http-equiv='Content-Script-Type' content='text/javascript' /> \n";
//				content+="<meta http-equiv='Content-Style-Type' content='text/css' /> \n";
//				content+="<style> \n";
//				content+="body {word-wrap:break-word;margin:0;padding:0} \n";
//				content+="body {line-height:1.5; border:0 none;font-size:12px; font-family:'돋움',Dotum, AppleGothic, Helvetica, sans-serif; color:#444444;} \n";
//				content+="img {border:0 none;} \n";
//				content+="ul, ol, li {list-style:none;} \n";
//				content+="a {text-decoration:none; color:#444444;} \n";
//				content+="a:hover, a:active, a:focus {color:#999999; text-decoration:none;} \n";
//				content+="a:focus, input:focus, button:focus, textarea:focus {outline:1px dotted #dddddd;} \n";
//				content+="</style> \n";
//				content+="<title>----</title> \n";
//				content+="</head> \n";
//				content+="<body> \n";
//				content+="<table width='726' cellpadding='0' cellspacing='0' border='0' bgcolor='#ef7c1b'> \n";
//				content+="	<tr> \n";
//				content+="		<td height='107' style='width:726px;height:107px;background:url("+web_url+"/images/mail/img/bgbox01.gif) no-repeat'>&nbsp;</td> \n";
//				content+="	</tr> \n";
//				content+="	<tr> \n";
//				content+="		<td align='center'> \n";
//				content+="			<table width='686' cellpadding='0' cellspacing='0' border='0' style='padding:0 20px 10px 20px;background:#fff url("+web_url+"/images/mail/img/bgimg_lock.gif) no-repeat bottom right'> \n";
//				content+="				<tr> \n";
//				content+="					<td style='padding:20px 0;color:#7a6a56;font-size:17px;text-align:center;line-height:25px;font-weight:bold'>'eTRS Merchant Management System 사용자 임시 비밀번호가<br/>발급되었습니다.'</td> \n";
//				content+="				</tr> \n";
//				content+="				<tr> \n";
//				content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>"+map.get("name").toString()+"님, 안녕하세요.</td> \n";
//				content+="				</tr> \n";
//				content+="				<tr> \n";
//				content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>계정 <span style='color:#2c62ae;text-decoration:none'>( "+email_addr+" )</span> 의 임시 비밀번호가 발급 되었습니다.</td> \n";
//				content+="				</tr> \n";
//				content+="				<tr> \n";
//				content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>비밀번호 : <span style='color:#8f3301'>"+passwd+"</span> 입니다.</td> \n";
//				content+="				</tr> \n";
//				content+="				<tr> \n";
//				content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>반드시 로그인 <a href='"+homepage_url+"' target='_blank'><span style='color:#e46d19'>( "+homepage_url+" )</span></a> 후 비밀번호 변경하시기 바랍니다.</td> \n";
//				content+="				</tr> \n";
//				content+="				<tr> \n";
//				content+="					<td style='padding:20px 0 20px 20px;line-height:18px;font-size:14px;text-align:left'>감사합니다.</td> \n";
//				content+="				</tr> \n";
//				content+="			</table> \n";
//				content+="		</td> \n";
//				content+="	</tr> \n";
//				content+="	<tr> \n";
//				content+="		<td height='40' style='width:686px;height:40px;background:url("+web_url+"/images/mail/img/bgbox02.gif) no-repeat'>&nbsp;</td> \n";
//				content+="	</tr> \n";
//				content+="</table> \n";
//				content+="</body> \n";
//				content+="</html> \n";
//				
//				map.put("to", email_addr);
//				map.put("subject", "Global Tax Free - "+map.get("name").toString()+"님 비밀번호가 재발급되었습니다.");
//				map.put("content", content);
//				map.put("from", cust_staff_mail_address); 
//				emailSender.sendMail(map);
//			}
//
//			rm.setCode(rm.RESULT_SUCCESS);
//			rm.setMessage(getMessageSourceAccessor().getMessage("success.update"));
//		}
//		catch (InputRequiredException e) {
//			rm.setCode(rm.RESULT_ERROR);
//			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
//		}
//		catch (SelectRequiredException e) {
//			rm.setCode(rm.RESULT_ERROR);
//			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
//		}
//		catch (Exception e) {
//			if (logger.isDebugEnabled()) {
//				logger.debug(e.toString());
//				e.printStackTrace();
//			}
//
//			rm.setCode(rm.RESULT_ERROR);
//			rm.setMessage(getMessageSourceAccessor().getMessage("failure.update"));
//			rm.setSystemMessage(e.toString());
//		}
//
//		ModelAndView mv = new ModelAndView("resultView");
//		mv.addObject("resultMsg", rm);
//
//		return mv;
//	}
//	
//	@RequestMapping("/initialPwdUser")
//	public ModelAndView initialPwdUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
//
//		Map<String, String> map = new HashMap<String, String>();
//		
//		ResultMessage rm = new ResultMessage();
//
//		bind(request, map);
//		
//		try {
//			String email_addr = map.get("email_addr").toString();
////			email_addr = simpleService.queryForMap("COM000501S", map).get("email_addr").toString();
//			
//			if(!email_addr.equals("")) {
//				map.put("email_addr", email_addr);
//				
//				RandomGenerator generator = new RandomGenerator();
//				String passwd = generator.getData(10);
//				map.put("passwd", passwd);
//				comService.initialPwdUser(map);
//				
//				String content = "";
//				//map_div, 01:사원, 02:외부사용자
//				if(map.get("mail_div").equals("01")) {
//					content+="<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> \n";
//					content+="<html xmlns='http://www.w3.org/1999/xhtml' lang='ko' xml:lang='ko'> \n";
//					content+="<head> \n";
//					content+="<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> \n";
//					content+="<meta http-equiv='Content-Script-Type' content='text/javascript' /> \n";
//					content+="<meta http-equiv='Content-Style-Type' content='text/css' /> \n";
//					content+="<style type='text/css'> \n";
//					content+="body {word-wrap:break-word;margin:0;padding:0} \n";
//					content+="body {line-height:1.5; border:0 none;font-size:12px; font-family:'돋움',Dotum, AppleGothic, Helvetica, sans-serif; color:#444444;} \n";
//					content+="img {border:0 none;} \n";
//					content+="ul, ol, li {list-style:none;} \n";
//					content+="a {text-decoration:none; color:#444444;} \n";
//					content+="a:hover, a:active, a:focus {color:#999999; text-decoration:none;} \n";
//					content+="a:focus, input:focus, button:focus, textarea:focus {outline:1px dotted #dddddd;} \n";
//					content+="</style> \n";
//					content+="<title>----</title> \n";
//					content+="</head> \n";
//					content+="<body> \n";
//					content+="<table width='726' cellpadding='0' cellspacing='0' border='0' bgcolor='#ef7c1b'> \n";
//					content+="	<tr> \n";
//					content+="		<td height='107' style='width:726px;height:107px;background:url("+web_url+"/images/mail/img/bgbox01.gif) no-repeat'>&nbsp;</td> \n";
//					content+="	</tr> \n";
//					content+="	<tr> \n";
//					content+="		<td align='center'> \n";
//					content+="			<table width='686' cellpadding='0' cellspacing='0' border='0' style='padding:0 20px 10px 20px;background:#fff url("+web_url+"/images/mail/img/bgimg_lock.gif) no-repeat bottom right'> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:20px 0;color:#7a6a56;font-size:17px;text-align:center;line-height:25px;font-weight:bold'>'Admin 사용자 임시 비밀번호가 발급되었습니다.'</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>"+map.get("userName")+"님, 안녕하세요.</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>계정 <span style='color:#2c62ae;text-decoration:none'>( "+map.get("user_no").toString()+" )</span> 의 임시 비밀번호가 발급 되었습니다.</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>비밀번호 : <span style='color:#8f3301'>"+passwd+"</span> 입니다.</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>반드시 로그인 <a href='"+web_url+"' target='_blank'><span style='color:#e46d19'>( "+web_url+" )</span></a> 후 비밀번호 변경하시기 바랍니다.</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:20px 0 20px 20px;line-height:18px;font-size:14px;text-align:left'>감사합니다.</td> \n";
//					content+="				</tr> \n";
//					content+="			</table> \n";
//					content+="		</td> \n";
//					content+="	</tr> \n";
//					content+="	<tr> \n";
//					content+="		<td height='40' style='width:686px;height:40px;background:url("+web_url+"/images/mail/img/bgbox02.gif) no-repeat'>&nbsp;</td> \n";
//					content+="	</tr> \n";
//					content+="</table> \n";
//					content+="</body> \n";
//					content+="</html> \n";
//					
//					map.put("to", email_addr);
//					map.put("subject", "Global Tax Free - "+map.get("userName")+"님 비밀번호가 재발급되었습니다.");
//					map.put("content", content);
//					map.put("from", staff_mail_address); 
//					emailSender.sendMail(map);
//				}
//				else if(map.get("mail_div").equals("02")) {
//					content+="<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> \n";
//					content+="<html xmlns='http://www.w3.org/1999/xhtml' lang='ko' xml:lang='ko'> \n";
//					content+="<head> \n";
//					content+="<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> \n";
//					content+="<meta http-equiv='Content-Script-Type' content='text/javascript' /> \n";
//					content+="<meta http-equiv='Content-Style-Type' content='text/css' /> \n";
//					content+="<style> \n";
//					content+="body {word-wrap:break-word;margin:0;padding:0} \n";
//					content+="body {line-height:1.5; border:0 none;font-size:12px; font-family:'돋움',Dotum, AppleGothic, Helvetica, sans-serif; color:#444444;} \n";
//					content+="img {border:0 none;} \n";
//					content+="ul, ol, li {list-style:none;} \n";
//					content+="a {text-decoration:none; color:#444444;} \n";
//					content+="a:hover, a:active, a:focus {color:#999999; text-decoration:none;} \n";
//					content+="a:focus, input:focus, button:focus, textarea:focus {outline:1px dotted #dddddd;} \n";
//					content+="</style> \n";
//					content+="<title>----</title> \n";
//					content+="</head> \n";
//					content+="<body> \n";
//					content+="<table width='726' cellpadding='0' cellspacing='0' border='0' bgcolor='#ef7c1b'> \n";
//					content+="	<tr> \n";
//					content+="		<td height='107' style='width:726px;height:107px;background:url("+web_url+"/images/mail/img/bgbox01.gif) no-repeat'>&nbsp;</td> \n";
//					content+="	</tr> \n";
//					content+="	<tr> \n";
//					content+="		<td align='center'> \n";
//					content+="			<table width='686' cellpadding='0' cellspacing='0' border='0' style='padding:0 20px 10px 20px;background:#fff url("+web_url+"/images/mail/img/bgimg_lock.gif) no-repeat bottom right'> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:20px 0;color:#7a6a56;font-size:17px;text-align:center;line-height:25px;font-weight:bold'>'eTRS Merchant Management System 사용자 임시 비밀번호가<br/>발급되었습니다.'</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>"+map.get("userName").toString()+"님, 안녕하세요.</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>계정 <span style='color:#2c62ae;text-decoration:none'>( "+map.get("external_userID").toString()+" )</span> 의 임시 비밀번호가 발급 되었습니다.</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>비밀번호 : <span style='color:#8f3301'>"+passwd+"</span> 입니다.</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:0 0 5px 20px;font-size:14px;color:#444;text-align:left'>반드시 로그인 <a href='"+web_url+"' target='_blank'><span style='color:#e46d19'>( "+web_url+" )</span></a> 후 비밀번호 변경하시기 바랍니다.</td> \n";
//					content+="				</tr> \n";
//					content+="				<tr> \n";
//					content+="					<td style='padding:20px 0 20px 20px;line-height:18px;font-size:14px;text-align:left'>감사합니다.</td> \n";
//					content+="				</tr> \n";
//					content+="			</table> \n";
//					content+="		</td> \n";
//					content+="	</tr> \n";
//					content+="	<tr> \n";
//					content+="		<td height='40' style='width:686px;height:40px;background:url("+web_url+"/images/mail/img/bgbox02.gif) no-repeat'>&nbsp;</td> \n";
//					content+="	</tr> \n";
//					content+="</table> \n";
//					content+="</body> \n";
//					content+="</html> \n";
//					
//					map.put("to", email_addr);
//					map.put("subject", "Global Tax Free - "+map.get("userName").toString()+"님 비밀번호가 재발급되었습니다.");
//					map.put("content", content);
//					map.put("from", staff_mail_address); 
//					emailSender.sendMail(map);
//				}
//
//				rm.setCode(rm.RESULT_SUCCESS);
//				rm.setMessage(getMessageSourceAccessor().getMessage("success.update"));
//			}
//			else {
//				rm.setCode(rm.RESULT_ERROR);
//				rm.setMessage(getMessageSourceAccessor().getMessage("failure.update"));
//			}
//			
//		}
//		catch (InputRequiredException e) {
//			rm.setCode(rm.RESULT_ERROR);
//			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
//		}
//		catch (SelectRequiredException e) {
//			rm.setCode(rm.RESULT_ERROR);
//			rm.setMessage(getMessageSourceAccessor().getMessage(e.getErrorCode(), new Object[] { getMessageSourceAccessor().getMessage(e.getMessage()) }));
//		}
//		catch (Exception e) {
//			if (logger.isDebugEnabled()) {
//				logger.debug(e.toString());
//				e.printStackTrace();
//			}
//
//			rm.setCode(rm.RESULT_ERROR);
//			rm.setMessage(getMessageSourceAccessor().getMessage("failure.update"));
//			rm.setSystemMessage(e.toString());
//		}
//
//		ModelAndView mv = new ModelAndView("resultView");
//		mv.addObject("resultMsg", rm);
//
//		return mv;
//	}
//	
//	@RequestMapping("/ex")
//	public ModelAndView ex(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		Map<String, String> map = new HashMap<String, String>();
//		
//		bind(request, map);
//
//		ModelAndView mav = null;
//		List resultList = new ArrayList();
////		resultList = this.readFileInfo(map);
//
//		SimpleDoc simpleDoc = new SimpleDoc("XML", resultList);
//		mav = simpleDoc.create();
//
//		return mav;
//	}
	
}