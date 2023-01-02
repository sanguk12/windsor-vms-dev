// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import java.io.InputStream;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletOutputStream;
import java.io.OutputStream;
import java.util.zip.GZIPOutputStream;
import kr.co.nis.waf.util.HanUtil;
import java.io.File;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import org.springframework.web.servlet.view.AbstractView;

public class SelfTargetDownloadView extends AbstractView
{
    protected final Log logger;
    
    public SelfTargetDownloadView() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    protected void renderMergedOutputModel(final Map map, final HttpServletRequest request, final HttpServletResponse response) throws IOException {
        String fileName = map.get("fileName").toString();
        final String tempFileName = map.get("tempFileName").toString();
        try {
            final String filePath = String.valueOf(map.get("uploadDir").toString()) + tempFileName;
            final File tempFile = new File(filePath);
            fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
            fileName = HanUtil.kscToAsc(fileName);
            final String agentType = request.getHeader("Accept-Encoding");
            try {
                if (!tempFile.exists() || !tempFile.canRead()) {
                    return;
                }
            }
            catch (final Exception e) {
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
            tempFile.delete();
        }
        catch (final Exception e2) {}
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
}
