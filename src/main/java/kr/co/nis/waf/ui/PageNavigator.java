// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui;

public class PageNavigator
{
    String pageNumberColor;
    String parameter;
    String pageUrl;
    String prevImage;
    String nextImage;
    boolean dropDownView;
    int currentPageNumber;
    int totalListCount;
    int pagePerList;
    int pagePerPaging;
    
    public PageNavigator() {
        this.pageNumberColor = "";
        this.parameter = "";
        this.pageUrl = "";
        this.prevImage = "";
        this.nextImage = "";
        this.dropDownView = true;
        this.currentPageNumber = 0;
        this.totalListCount = 0;
        this.pagePerList = 0;
        this.pagePerPaging = 0;
        this.currentPageNumber = 1;
        this.pageNumberColor = "#000000";
        this.totalListCount = 1;
        this.parameter = "";
        this.pagePerList = 10;
        this.pagePerPaging = 10;
        this.pageUrl = "";
        this.prevImage = "/images/btn/btnPrevPaging.gif";
        this.nextImage = "/images/btn/btnNextPaging.gif";
    }
    
    public String generatePaging(final String cID, final String selectStyle) {
        String html = "";
        final int maxPage = (this.getTotalListCount() - 1) / this.getPagePerList() + 1;
        final int beforePage = (this.getCurrentPageNumber() - 1) / this.getPagePerPaging() * this.getPagePerPaging();
        int nextPage = beforePage + this.getPagePerPaging() + 1;
        if (maxPage < nextPage) {
            nextPage = maxPage + 1;
        }
        html += "<table width\"100%\" cellspacing=\"0\" cellpadding=\"2\">";
        html += "  <tr height=\"25\"><td align=\"center\">";
        if (this.getCurrentPageNumber() > 10) {
            html = html + "<a href=\"" + this.getPageUrl() + "?pageNum=" + beforePage + "&" + this.getParameter() + "\">";
            html = html + "<img src=\"" + this.getPrevImage() + "\" name=\"" + cID + "_prev\" align=\"absmiddle\" border=\"0\"";
            html += "</a>&nbsp;";
        }
        for (int loopCount = beforePage + 1; loopCount <= nextPage - 1; ++loopCount) {
            if (loopCount == this.getCurrentPageNumber()) {
                html = html + "<b>" + loopCount + "</b>&nbsp;";
            }
            else {
                html = html + "<a href=\"" + this.getPageUrl() + "?pageNum=" + loopCount + "&" + this.getParameter() + "\">[" + loopCount + "]</a>&nbsp;";
            }
        }
        if (maxPage >= nextPage) {
            html = html + "<a href=\"" + this.getPageUrl() + "?pageNum=" + nextPage + "&" + this.getParameter() + "\">";
            html = html + "<img src=\"" + this.getNextImage() + "\" name=\"" + cID + "_next\" align=\"absmiddle\" border=\"0\"";
            html += "</a>";
        }
        if (this.isDropDownView() && maxPage > this.getPagePerPaging()) {
            html = html + "<select class='" + selectStyle + "' name=\"" + cID + "_select\" onchange=\"document.location.href='" + this.getPageUrl() + "?pageNum=' + this.value + '&" + this.getParameter() + "';\">";
            for (int cnt = 1; cnt <= maxPage; ++cnt) {
                if (this.getCurrentPageNumber() == cnt) {
                    html = html + "<option value=\"" + cnt + "\" selected>" + cnt + "</option>";
                }
                else {
                    html = html + "<option value=\"" + cnt + "\">" + cnt + "</option>";
                }
            }
            html += "</select>";
        }
        html += "  </td></tr>";
        html += "</table>";
        return html;
    }
    
    public int getCurrentPageNumber() {
        return this.currentPageNumber;
    }
    
    public void setCurrentPageNumber(final int currentPageNumber) {
        this.currentPageNumber = currentPageNumber;
    }
    
    public String getNextImage() {
        return this.nextImage;
    }
    
    public void setNextImage(final String nextImage) {
        this.nextImage = nextImage;
    }
    
    public String getPageNumberColor() {
        return this.pageNumberColor;
    }
    
    public void setPageNumberColor(final String pageNumberColor) {
        this.pageNumberColor = pageNumberColor;
    }
    
    public int getPagePerList() {
        return this.pagePerList;
    }
    
    public void setPagePerList(final int pagePerList) {
        this.pagePerList = pagePerList;
    }
    
    public int getPagePerPaging() {
        return this.pagePerPaging;
    }
    
    public void setPagePerPaging(final int pagePerPaging) {
        this.pagePerPaging = pagePerPaging;
    }
    
    public String getPageUrl() {
        return this.pageUrl;
    }
    
    public void setPageUrl(final String pageUrl) {
        this.pageUrl = pageUrl;
    }
    
    public String getParameter() {
        return this.parameter;
    }
    
    public void setParameter(final String parameter) {
        this.parameter = parameter;
    }
    
    public String getPrevImage() {
        return this.prevImage;
    }
    
    public void setPrevImage(final String prevImage) {
        this.prevImage = prevImage;
    }
    
    public int getTotalListCount() {
        return this.totalListCount;
    }
    
    public void setTotalListCount(final int totalListCount) {
        this.totalListCount = totalListCount;
    }
    
    public boolean isDropDownView() {
        return this.dropDownView;
    }
    
    public void setDropDownView(final boolean dropDownView) {
        this.dropDownView = dropDownView;
    }
}
