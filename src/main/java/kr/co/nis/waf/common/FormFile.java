// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import java.io.InputStream;
import java.io.IOException;
import java.io.FileNotFoundException;

public interface FormFile
{
    String getContentType();
    
    void setContentType(final String p0);
    
    int getFileSize();
    
    void setFileSize(final int p0);
    
    String getFileName();
    
    void setFileName(final String p0);
    
    byte[] getFileData() throws FileNotFoundException, IOException;
    
    InputStream getInputStream() throws FileNotFoundException, IOException;
    
    void destroy();
}
