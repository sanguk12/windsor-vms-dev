// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.Hashtable;
import java.util.List;

public class CommonsMultipartRequestHandler implements MultipartRequestHandler
{
    public static final long DEFAULT_SIZE_MAX = 262144000L;
    public static final int DEFAULT_SIZE_THRESHOLD = 262144;
    protected static Log log;
    private Hashtable elementsAll;
    private Hashtable<String, FormFile> elementsFile;
    private Hashtable<String, String[]> elementsText;
    private String tempDir;
    private long sizeMax;
    private long sizeThreshold;

    public CommonsMultipartRequestHandler(final String tempDir) {
        this(tempDir, 262144000L, 262144L);
    }

    public CommonsMultipartRequestHandler(final String tempDir, final long sizeMax) {
        this(tempDir, sizeMax, 262144L);
    }

    public CommonsMultipartRequestHandler(final String tempDir, final long sizeMax, final long sizeThreshold) {
        this.tempDir = tempDir;
        this.sizeMax = sizeMax;
        this.sizeThreshold = sizeThreshold;
    }

    @Override
    public void handleRequest(final HttpServletRequest request) throws ServletException {
        final DiskFileUpload upload = new DiskFileUpload();
        upload.setHeaderEncoding(request.getCharacterEncoding());
        upload.setSizeMax(this.getSizeMax());
        upload.setSizeThreshold((int)this.getSizeThreshold());
        upload.setRepositoryPath(this.getTempDir());
        this.elementsText = new Hashtable();
        this.elementsFile = new Hashtable();
        this.elementsAll = new Hashtable();
        List<FileItem> items = null;
        try {
            items = upload.parseRequest(request);
        }
        catch (final FileUploadBase.SizeLimitExceededException e) {
            throw new ServletException((Throwable)e);
        }
        catch (final FileUploadException e2) {
            CommonsMultipartRequestHandler.log.error((Object)"Failed to parse multipart request", (Throwable)e2);
            throw new ServletException((Throwable)e2);
        }
        for (final FileItem item : items) {
            if (item.isFormField()) {
                this.addTextParameter(request, item);
            }
            else {
                this.addFileParameter(item);
            }
        }
    }

    @Override
    public Hashtable getTextElements() {
        return this.elementsText;
    }

    public String getParameter(final String name) {
        final String[] params = (String[]) this.getTextElements().get(name);
        if (params != null && params.length > 0) {
            return params[0];
        }
        return null;
    }

    public String[] getParameterValues(final String name) {
        return (String[]) this.getTextElements().get(name);
    }

    public FormFile getFileParameter(final String name) {
        return (FormFile) this.getFileElements().get(name);
    }

    @Override
    public Hashtable getFileElements() {
        return this.elementsFile;
    }

    @Override
    public Hashtable getAllElements() {
        return this.elementsAll;
    }

    @Override
    public void rollback() {
        for (final FormFile formFile : this.elementsFile.values()) {
            formFile.destroy();
        }
    }

    @Override
    public void finish() {
        this.rollback();
    }

    protected long getSizeMax() {
        if (this.sizeMax == 0L) {
            return 262144000L;
        }
        return this.sizeMax;
    }

    protected long getSizeThreshold() {
        if (this.sizeThreshold == 0L) {
            return 262144L;
        }
        return this.sizeThreshold;
    }

    protected long convertSizeToBytes(String sizeString, final long defaultSize) {
        int multiplier = 1;
        if (sizeString.endsWith("K")) {
            multiplier = 1024;
        }
        else if (sizeString.endsWith("M")) {
            multiplier = 1048576;
        }
        else if (sizeString.endsWith("G")) {
            multiplier = 1073741824;
        }
        if (multiplier != 1) {
            sizeString = sizeString.substring(0, sizeString.length() - 1);
        }
        long size = 0L;
        try {
            size = Long.parseLong(sizeString);
        }
        catch (final NumberFormatException nfe) {
            CommonsMultipartRequestHandler.log.warn((Object)("Invalid format for file size ('" + sizeString + "'). Using default."));
            size = defaultSize;
            multiplier = 1;
        }
        return size * multiplier;
    }

    protected String getTempDir() {
        if (this.tempDir == null || this.tempDir.length() == 0) {
            this.tempDir = System.getProperty("java.io.tmpdir");
        }
        return this.tempDir;
    }

    protected void addTextParameter(final HttpServletRequest request, final FileItem item) {
        final String name = item.getFieldName();
        String value = null;
        boolean haveValue = false;
        final String encoding = request.getCharacterEncoding();
        if (encoding != null) {
            try {
                value = item.getString(encoding);
                haveValue = true;
            }
            catch (final Exception ex) {}
        }
        if (!haveValue) {
            try {
                value = item.getString("ISO-8859-1");
            }
            catch (final UnsupportedEncodingException uee) {
                value = item.getString();
            }
            haveValue = true;
        }
        if (request instanceof MultipartRequestWrapper) {
            final MultipartRequestWrapper wrapper = (MultipartRequestWrapper)request;
            wrapper.setParameter(name, value);
        }
        final String[] oldArray = this.elementsText.get(name);
        String[] newArray;
        if (oldArray != null) {
            newArray = new String[oldArray.length + 1];
            System.arraycopy(oldArray, 0, newArray, 0, oldArray.length);
            newArray[oldArray.length] = value;
        }
        else {
            newArray = new String[] { value };
        }
        this.elementsText.put(name, newArray);
        this.elementsAll.put(name, newArray);
    }

    protected void addFileParameter(final FileItem item) {
        final FormFile formFile = new CommonsFormFile(item);
        this.elementsFile.put(item.getFieldName(), formFile);
        this.elementsAll.put(item.getFieldName(), formFile);
    }

    static {
        CommonsMultipartRequestHandler.log = LogFactory.getLog((Class)CommonsMultipartRequestHandler.class);
    }

    static class CommonsFormFile implements FormFile, Serializable
    {
        FileItem fileItem;

        public CommonsFormFile(final FileItem fileItem) {
            this.fileItem = fileItem;
        }

        @Override
        public String getContentType() {
            return this.fileItem.getContentType();
        }

        @Override
        public void setContentType(final String contentType) {
            throw new UnsupportedOperationException("The setContentType() method is not supported.");
        }

        @Override
        public int getFileSize() {
            return (int)this.fileItem.getSize();
        }

        @Override
        public void setFileSize(final int filesize) {
            throw new UnsupportedOperationException("The setFileSize() method is not supported.");
        }

        @Override
        public String getFileName() {
            return this.getBaseFileName(this.fileItem.getName());
        }

        @Override
        public void setFileName(final String fileName) {
            throw new UnsupportedOperationException("The setFileName() method is not supported.");
        }

        @Override
        public byte[] getFileData() throws FileNotFoundException, IOException {
            return this.fileItem.get();
        }

        @Override
        public InputStream getInputStream() throws FileNotFoundException, IOException {
            return this.fileItem.getInputStream();
        }

        @Override
        public void destroy() {
            this.fileItem.delete();
        }

        protected String getBaseFileName(final String filePath) {
            String fileName = new File(filePath).getName();
            int colonIndex = fileName.indexOf(":");
            if (colonIndex == -1) {
                colonIndex = fileName.indexOf("\\\\");
            }
            final int backslashIndex = fileName.lastIndexOf("\\");
            if (colonIndex > -1 && backslashIndex > -1) {
                fileName = fileName.substring(backslashIndex + 1);
            }
            return fileName;
        }

        @Override
        public String toString() {
            return this.getFileName();
        }
    }
}
