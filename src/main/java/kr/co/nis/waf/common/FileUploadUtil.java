// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import org.apache.commons.logging.LogFactory;
import java.io.OutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import kr.co.nis.waf.util.UUID;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.logging.Log;

public class FileUploadUtil
{
    protected static Log logger;
    public static int ORIGINAL_FILE_NAME;
    public static int UUID_FILE_NAME;
    
    public static FileInfo uploadFormFile(final MultipartFile formFile, final String realPath) {
        final UUID uuid = UUID.randomUUID();
        final String tempFileName = uuid.toString();
        try {
            final InputStream stream = formFile.getInputStream();
            final OutputStream bos = new FileOutputStream(realPath + tempFileName);
            int bytesRead = 0;
            final byte[] buffer = new byte[8192];
            while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
            bos.close();
            stream.close();
            if (FileUploadUtil.logger.isDebugEnabled()) {
                FileUploadUtil.logger.debug((Object)("The file has been written to \"" + realPath + tempFileName));
            }
        }
        catch (final FileNotFoundException e) {
            e.printStackTrace();
        }
        catch (final IOException e2) {
            e2.printStackTrace();
        }
        final FileInfo fileInfo = new FileInfo();
        fileInfo.setFileName(formFile.getOriginalFilename());
        fileInfo.setFileSize(formFile.getSize());
        fileInfo.setContentType(formFile.getContentType());
        fileInfo.setTempFileName(tempFileName);
        return fileInfo;
    }
    
    public static FileInfo uploadFormFile(final MultipartFile formFile, final String realPath, final int applyUUID) {
        String tempFileName = "";
        if (applyUUID == FileUploadUtil.UUID_FILE_NAME) {
            final UUID uuid = UUID.randomUUID();
            tempFileName = uuid.toString();
        }
        else if (applyUUID == FileUploadUtil.ORIGINAL_FILE_NAME) {
            tempFileName = formFile.getOriginalFilename();
        }
        try {
            final InputStream stream = formFile.getInputStream();
            final OutputStream bos = new FileOutputStream(realPath + tempFileName);
            int bytesRead = 0;
            final byte[] buffer = new byte[8192];
            while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
            bos.close();
            stream.close();
            if (FileUploadUtil.logger.isDebugEnabled()) {
                FileUploadUtil.logger.debug((Object)("The file has been written to \"" + realPath + tempFileName));
            }
        }
        catch (final FileNotFoundException e) {
            e.printStackTrace();
        }
        catch (final IOException e2) {
            e2.printStackTrace();
        }
        final FileInfo fileInfo = new FileInfo();
        fileInfo.setFileName(formFile.getOriginalFilename());
        fileInfo.setFileSize(formFile.getSize());
        fileInfo.setContentType(formFile.getContentType());
        fileInfo.setTempFileName(tempFileName);
        return fileInfo;
    }
    
    static {
        FileUploadUtil.logger = LogFactory.getLog((Class)FileUploadUtil.class);
        FileUploadUtil.ORIGINAL_FILE_NAME = 0;
        FileUploadUtil.UUID_FILE_NAME = 1;
    }
}
