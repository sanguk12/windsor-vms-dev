// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.common;

import java.io.OutputStream;
import java.io.FileOutputStream;
import java.net.SocketException;
import java.io.IOException;
import kr.co.nis.waf.util.StringUtil;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.File;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.commons.net.ftp.FTPClient;
import java.util.List;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;

public class FTPTransfer
{
    protected final Log logger;
    
    public FTPTransfer() {
        this.logger = LogFactory.getLog((Class)this.getClass());
    }
    
    public boolean FtpPut(final String ip, final int port, final String id, final String password, final String uploaddir, final String makedir, final List files) {
        boolean result = false;
        FTPClient ftp = null;
        int reply = 0;
        try {
            ftp = new FTPClient();
            ftp.connect(ip, port);
            reply = ftp.getReplyCode();
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftp.disconnect();
                return result;
            }
            if (!ftp.login(id, password)) {
                ftp.logout();
                return result;
            }
            ftp.setFileType(2);
            ftp.enterLocalPassiveMode();
            ftp.changeWorkingDirectory(uploaddir);
            ftp.makeDirectory(makedir);
            ftp.changeWorkingDirectory(makedir);
            for (int i = 0; i < files.size(); ++i) {
                final String sourceFile = (String) files.get(i);
                final File uploadFile = new File(sourceFile);
                FileInputStream fis = null;
                try {
                    fis = new FileInputStream(uploadFile);
                    final boolean isSuccess = ftp.storeFile(uploadFile.getName(), (InputStream)fis);
                    if (isSuccess) {
                        this.logger.debug((Object)(sourceFile + " Success."));
                    }
                }
                catch (final IOException ioe) {
                    this.logger.debug((Object)StringUtil.stackTraceToString(ioe));
                    if (fis != null) {
                        try {
                            fis.close();
                        }
                        catch (final IOException ioex) {
                            this.logger.debug((Object)StringUtil.stackTraceToString(ioe));
                        }
                    }
                }
                finally {
                    if (fis != null) {
                        try {
                            fis.close();
                        }
                        catch (final IOException ioe2) {
                            this.logger.debug((Object)StringUtil.stackTraceToString(ioe2));
                        }
                    }
                }
            }
            ftp.logout();
            result = true;
        }
        catch (final SocketException se) {
            this.logger.debug((Object)StringUtil.stackTraceToString(se));
        }
        catch (final IOException ioe3) {
            this.logger.debug((Object)StringUtil.stackTraceToString(ioe3));
        }
        catch (final Exception e) {
            this.logger.debug((Object)StringUtil.stackTraceToString(e));
        }
        finally {
            if (ftp != null && ftp.isConnected()) {
                try {
                    ftp.disconnect();
                }
                catch (final IOException ex) {}
            }
        }
        return result;
    }
    
    public boolean FtpGet(final String ip, final int port, final String id, final String password, final String localdir, final String serverdir, final String fileName) {
        final boolean result = false;
        FTPClient ftp = null;
        int reply = 0;
        try {
            ftp = new FTPClient();
            reply = ftp.getReplyCode();
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftp.disconnect();
                return result;
            }
            if (!ftp.login(id, password)) {
                ftp.logout();
                return result;
            }
            ftp.setFileType(2);
            ftp.enterLocalPassiveMode();
            ftp.changeWorkingDirectory(serverdir);
            final File f = new File(localdir, fileName);
            FileOutputStream fos = null;
            try {
                fos = new FileOutputStream(f);
                final boolean isSuccess = ftp.retrieveFile(fileName, (OutputStream)fos);
                if (isSuccess) {
                    this.logger.debug((Object)"Success");
                }
                else {
                    this.logger.debug((Object)"Failure");
                }
            }
            catch (final IOException ioe) {
                this.logger.debug((Object)StringUtil.stackTraceToString(ioe));
            }
            finally {
                if (fos != null) {
                    try {
                        fos.close();
                    }
                    catch (final IOException ex) {}
                }
            }
            ftp.logout();
        }
        catch (final SocketException se) {
            this.logger.debug((Object)StringUtil.stackTraceToString(se));
        }
        catch (final IOException ioe2) {
            this.logger.debug((Object)StringUtil.stackTraceToString(ioe2));
        }
        catch (final Exception e) {
            this.logger.debug((Object)StringUtil.stackTraceToString(e));
        }
        finally {
            if (ftp != null && ftp.isConnected()) {
                try {
                    ftp.disconnect();
                }
                catch (final IOException e2) {
                    this.logger.debug((Object)StringUtil.stackTraceToString(e2));
                }
            }
        }
        return result;
    }
}
