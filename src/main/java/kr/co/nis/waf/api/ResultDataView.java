package kr.co.nis.waf.api;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.view.AbstractView;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * ResultMessage 클래스의 멤버변수 값들을 JSON로 전환하는 클래스
 * @version: 1.0
 */
public class ResultDataView extends AbstractView {

	protected final Log logger = LogFactory.getLog(getClass());

	protected void renderMergedOutputModel(Map map, HttpServletRequest request, HttpServletResponse response) throws IOException {

		try {
			ResultData resultData = (ResultData) map.get("resultData");
	
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
	
			ObjectMapper mapper = new ObjectMapper();
			
			if (logger.isDebugEnabled()) {
				logger.debug(mapper.writeValueAsString(resultData));
			}
			out.println(mapper.writeValueAsString(resultData));
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				e.printStackTrace();
			}
		}
	}
}
