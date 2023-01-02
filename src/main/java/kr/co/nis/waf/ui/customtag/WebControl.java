// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.ui.customtag;

import javax.servlet.jsp.tagext.TagSupport;

public class WebControl extends TagSupport
{
    private String id;
    private String name;
    private String value;
    private String defaultText;
    private String defaultValue;
    private String event;
    private String eventProc;
    private String accessKey;
    private String backColor;
    private String foreColor;
    private String cssClass;
    private String preset;
    private String style;
    private String toolTip;
    private String align;
    private String valign;
    private boolean enable;
    private boolean visible;
    private int height;
    private int width;
    private int tabIndex;
    private int fontSize;
    private String callback;
    private String extend;
    private String readOnly;
    
    public WebControl() {
        this.id = null;
        this.name = null;
        this.value = null;
        this.defaultText = null;
        this.defaultValue = null;
        this.event = null;
        this.eventProc = null;
        this.accessKey = null;
        this.backColor = null;
        this.foreColor = null;
        this.cssClass = null;
        this.preset = null;
        this.style = null;
        this.toolTip = null;
        this.align = null;
        this.valign = null;
        this.enable = true;
        this.visible = true;
        this.height = 0;
        this.width = 0;
        this.tabIndex = 0;
        this.fontSize = 0;
        this.callback = "";
        this.extend = "";
        this.readOnly = "";
    }
    
    public String getId() {
        return this.id;
    }
    
    public void setId(final String id) {
        this.id = id;
    }
    
    public String getName() {
        return this.name;
    }
    
    public void setName(final String name) {
        this.name = name;
    }
    
    public String getValue() {
        return this.value;
    }
    
    public void setValue(final String value) {
        this.value = value;
    }
    
    public String getDefaultValue() {
        return this.defaultValue;
    }
    
    public void setDefaultValue(final String defaultValue) {
        this.defaultValue = defaultValue;
    }
    
    public void setDefaultvalue(final String defaultValue) {
        this.defaultValue = defaultValue;
    }
    
    public String getEvent() {
        return this.event;
    }
    
    public void setEvent(final String event) {
        this.event = event;
    }
    
    public String getAccessKey() {
        return this.accessKey;
    }
    
    public void setAccessKey(final String accessKey) {
        this.accessKey = accessKey;
    }
    
    public void setAccesskey(final String accessKey) {
        this.accessKey = accessKey;
    }
    
    public String getBackColor() {
        return this.backColor;
    }
    
    public void setBackColor(final String backColor) {
        this.backColor = backColor;
    }
    
    public void setBackcolor(final String backColor) {
        this.backColor = backColor;
    }
    
    public String getForeColor() {
        return this.foreColor;
    }
    
    public void setForeColor(final String foreColor) {
        this.foreColor = foreColor;
    }
    
    public void setForecolor(final String foreColor) {
        this.foreColor = foreColor;
    }
    
    public String getCssClass() {
        return this.cssClass;
    }
    
    public void setCssClass(final String cssClass) {
        this.cssClass = cssClass;
    }
    
    public void setCssclass(final String cssClass) {
        this.cssClass = cssClass;
    }
    
    public String getPreset() {
        return this.preset;
    }
    
    public void setPreset(final String preset) {
        this.preset = preset;
    }
    
    public boolean isEnable() {
        return this.enable;
    }
    
    public void setEnable(final boolean enable) {
        this.enable = enable;
    }
    
    public boolean isVisible() {
        return this.visible;
    }
    
    public void setVisible(final boolean visible) {
        this.visible = visible;
    }
    
    public int getHeight() {
        return this.height;
    }
    
    public void setHeight(final int height) {
        this.height = height;
    }
    
    public int getWidth() {
        return this.width;
    }
    
    public void setWidth(final int width) {
        this.width = width;
    }
    
    public int getTabIndex() {
        return this.tabIndex;
    }
    
    public void setTabIndex(final int tabIndex) {
        this.tabIndex = tabIndex;
    }
    
    public void setTabindex(final int tabIndex) {
        this.tabIndex = tabIndex;
    }
    
    public String getStyle() {
        return this.style;
    }
    
    public void setStyle(final String style) {
        this.style = style;
    }
    
    public String getToolTip() {
        return this.toolTip;
    }
    
    public void setToolTip(final String toolTip) {
        this.toolTip = toolTip;
    }
    
    public void setTooltip(final String toolTip) {
        this.toolTip = toolTip;
    }
    
    public int getFontSize() {
        return this.fontSize;
    }
    
    public void setFontSize(final int fontSize) {
        this.fontSize = fontSize;
    }
    
    public void setFontsize(final int fontSize) {
        this.fontSize = fontSize;
    }
    
    public String getEventProc() {
        return this.eventProc;
    }
    
    public void setEventProc(final String eventProc) {
        this.eventProc = eventProc;
    }
    
    public void setEventproc(final String eventProc) {
        this.eventProc = eventProc;
    }
    
    public String getDefaultText() {
        return this.defaultText;
    }
    
    public void setDefaulttext(final String defaultText) {
        this.defaultText = defaultText;
    }
    
    public void setDefaultText(final String defaultText) {
        this.defaultText = defaultText;
    }
    
    public String getAlign() {
        return this.align;
    }
    
    public void setAlign(final String align) {
        this.align = align;
    }
    
    public String getValign() {
        return this.valign;
    }
    
    public void setValign(final String valign) {
        this.valign = valign;
    }
    
    public String getCallback() {
        return this.callback;
    }
    
    public void setCallback(final String callback) {
        this.callback = callback;
    }
    
    public String getExtend() {
        return this.extend;
    }
    
    public void setExtend(final String extend) {
        this.extend = extend;
    }
    
    public String getReadOnly() {
        return this.readOnly;
    }
    
    public void setReadOnly(final String readOnly) {
        this.readOnly = readOnly;
    }
}
