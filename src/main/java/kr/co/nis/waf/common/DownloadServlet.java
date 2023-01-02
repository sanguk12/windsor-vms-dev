// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import java.io.IOException;
import javax.servlet.ServletException;
import java.io.InputStream;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import javax.servlet.ServletOutputStream;
import java.io.PrintWriter;
import java.io.OutputStream;
import java.util.zip.GZIPOutputStream;
import kr.co.nis.waf.util.HanUtil;
import java.io.File;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServlet;

public class DownloadServlet extends HttpServlet
{
    private String uploadDir;
    
    public DownloadServlet() {
        this.uploadDir = null;
    }
    
    protected void performTask(final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        String fileName = request.getParameter("fileName");
        final String tempFileName = request.getParameter("tempFileName");
        try {
            final String filePath = this.uploadDir + tempFileName;
            final File tempFile = new File(filePath);
            fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
            fileName = HanUtil.kscToAsc(fileName);
            final String agentType = request.getHeader("Accept-Encoding");
            try {
                if (!tempFile.exists() || !tempFile.canRead()) {
                    final PrintWriter out = response.getWriter();
                    out.println("<script>alert('File Not Found');history.back();</script>");
                    return;
                }
            }
            catch (final Exception e) {
                final PrintWriter out2 = response.getWriter();
                out2.println("<script>alert('File Not Found');history.back();</script>");
                return;
            }
            boolean flag = false;
            if (agentType != null && agentType.indexOf("gzip") >= 0) {
                flag = true;
            }
            flag = false;
            if (flag) {
                response.setHeader("Content-Encoding", "gzip");
                response.setHeader("Content-disposition", "attachment;filename=" + fileName);
                final ServletOutputStream servletoutputstream = response.getOutputStream();
                final GZIPOutputStream gzipoutputstream = new GZIPOutputStream((OutputStream)servletoutputstream);
                this.dumpFile(tempFile, gzipoutputstream);
                gzipoutputstream.close();
                servletoutputstream.close();
            }
            else {
                response.setContentType("application/octet-stream");
                response.setHeader("Content-disposition", "attachment;filename=" + fileName);
                final ServletOutputStream servletoutputstream2 = response.getOutputStream();
                this.dumpFile(tempFile, (OutputStream)servletoutputstream2);
                servletoutputstream2.flush();
                servletoutputstream2.close();
            }
        }
        catch (final Exception e2) {
            final PrintWriter out3 = response.getWriter();
            out3.println("<script>alert('File Not Found');history.back();</script>");
        }
    }
    
    private void dumpFile(final File realFile, final OutputStream outputstream) {
        final byte[] readByte = new byte[4096];
        try {
            final BufferedInputStream bufferedinputstream = new BufferedInputStream(new FileInputStream(realFile));
            int i;
            while ((i = bufferedinputstream.read(readByte, 0, 4096)) != -1) {
                outputstream.write(readByte, 0, i);
            }
            bufferedinputstream.close();
        }
        catch (final Exception ex) {}
    }
    
    protected void doGet(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }
    
    protected void doPost(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        try {
            this.performTask(req, resp);
        }
        catch (final Exception e) {
            throw new ServletException(e.getMessage());
        }
    }
}
