// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.mvc;

import java.io.PrintWriter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServlet;

public class HnwHtmlServlet extends HttpServlet
{
    static String classid;
    static String version;
    static String codebase;
    static String stJavaScriptSrc;
    
    public void init(final ServletConfig config) {
        HnwHtmlServlet.classid = config.getInitParameter("classid");
        HnwHtmlServlet.version = config.getInitParameter("version");
        HnwHtmlServlet.codebase = config.getInitParameter("codebase");
        HnwHtmlServlet.stJavaScriptSrc = config.getInitParameter("stJavaScriptSrc");
    }
    
    public void doGet(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        this.printHTML(request, response);
    }
    
    public void doPost(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        this.printHTML(request, response);
    }
    
    public void printHTML(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        final PrintWriter out = response.getWriter();
        String bg_color = new String("FFFFFF");
        final String userbgcol = request.getParameter("bgcolor");
        String sthnwsrc = request.getParameter("hnwsrc");
        if (sthnwsrc == null) {
            sthnwsrc = new String("");
        }
        String stinitvalue = request.getParameter("initvalue");
        if (stinitvalue == null) {
            stinitvalue = new String("");
        }
        if (userbgcol != null) {
            bg_color = userbgcol;
        }
        out.println("<html>");
        out.println("<head>");
        out.println("<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">");
        out.println("<script language=\"JavaScript\" src=\"" + HnwHtmlServlet.stJavaScriptSrc + "\"> </script>");
        out.println("<title>EZgen</title>");
        out.println("</head>\n");
        out.println("<body topmargin=\"0\" leftmargin=\"0\" bgcolor=" + bg_color + ">\n");
        out.println("<comment id=\"__ACTIVEOBJ_ID__\">");
        out.println("<object classid=" + HnwHtmlServlet.classid + " width=\"3\" height=\"40\"");
        out.println("codebase=" + HnwHtmlServlet.codebase + "#version=" + HnwHtmlServlet.version + ">");
        out.println("<param name=\"hnwsrc\" VALUE=\"" + sthnwsrc + "\">");
        out.println("<param name=\"initvalue\" VALUE=\"" + stinitvalue + "\">");
        out.println("</object>");
        out.println("</comment>");
        out.println("<script>WriteObjElement(__ACTIVEOBJ_ID__);</script>\n");
        out.println("</body>");
        out.println("</html>");
    }
    
    static {
        HnwHtmlServlet.classid = null;
        HnwHtmlServlet.version = null;
        HnwHtmlServlet.codebase = null;
        HnwHtmlServlet.stJavaScriptSrc = null;
    }
}
