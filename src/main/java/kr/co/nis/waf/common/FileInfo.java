// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import kr.co.nis.waf.BaseObject;

public class FileInfo extends BaseObject
{
    private String fileName;
    private Long fileSize;
    private String contentType;
    private String tempFileName;
    
    public FileInfo() {
        this.fileName = null;
        this.fileSize = null;
        this.contentType = null;
        this.tempFileName = null;
    }
    
    public String getContentType() {
        return this.contentType;
    }
    
    public void setContentType(final String contentType) {
        this.contentType = contentType;
    }
    
    public String getFileName() {
        return this.fileName;
    }
    
    public void setFileName(final String fileName) {
        this.fileName = fileName;
    }
    
    public Long getFileSize() {
        return this.fileSize;
    }
    
    public void setFileSize(final Long fileSize) {
        this.fileSize = fileSize;
    }
    
    public String getTempFileName() {
        return this.tempFileName;
    }
    
    public void setTempFileName(final String tempFileName) {
        this.tempFileName = tempFileName;
    }
}
