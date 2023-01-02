package kr.co.nis.waf.system.ui.customtag;

import javax.servlet.jsp.tagext.TagSupport;


public class WebControl extends TagSupport {
	private String id = null;
	private String name = null;
	private String value = null;
	private String defaultText = null;
	private String defaultValue = null;
	private String event = null;
	private String eventProc = null;
	private String accessKey = null;
	private String backColor = null;
	private String foreColor = null;
	private String cssClass = null;
	private String preset = null;
	private String style = null;
	private String toolTip = null;
	private String align = null;
	private String valign = null;
	private boolean enable = true;
	private boolean visible = true;
	private int height = 0;
	private int width = 0;
	private int tabIndex = 0;
	private int fontSize = 0;
	private String callback = "";
	private String extend = "";
	private String readOnly = "";
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getValue() {
		return value;
	}
	
	public void setValue(String value) {
		this.value = value;
	}
	
	public String getDefaultValue() {
		return defaultValue;
	}
	
	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}
	
	public void setDefaultvalue(String defaultValue) {
		this.defaultValue = defaultValue;
	}
	
	public String getEvent() {
		return event;
	}
	
	public void setEvent(String event) {
		this.event = event;
	}
	
	public String getAccessKey() {
		return accessKey;
	}
	
	public void setAccessKey(String accessKey) {
		this.accessKey = accessKey;
	}
	
	public void setAccesskey(String accessKey) {
		this.accessKey = accessKey;
	}
	
	public String getBackColor() {
		return backColor;
	}
	
	public void setBackColor(String backColor) {
		this.backColor = backColor;
	}
	
	public void setBackcolor(String backColor) {
		this.backColor = backColor;
	}
	
	public String getForeColor() {
		return foreColor;
	}
	
	public void setForeColor(String foreColor) {
		this.foreColor = foreColor;
	}
	
	public void setForecolor(String foreColor) {
		this.foreColor = foreColor;
	}
	
	public String getCssClass() {
		return cssClass;
	}
	
	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}
	
	public void setCssclass(String cssClass) {
		this.cssClass = cssClass;
	}
	
	public String getPreset() {
		return preset;
	}
	
	public void setPreset(String preset) {
		this.preset = preset;
	}
	
	public boolean isEnable() {
		return enable;
	}
	
	public void setEnable(boolean enable) {
		this.enable = enable;
	}
	
	public boolean isVisible() {
		return visible;
	}
	
	public void setVisible(boolean visible) {
		this.visible = visible;
	}
	
	public int getHeight() {
		return height;
	}
	
	public void setHeight(int height) {
		this.height = height;
	}
	
	public int getWidth() {
		return width;
	}
	
	public void setWidth(int width) {
		this.width = width;
	}
	
	public int getTabIndex() {
		return tabIndex;
	}
	
	public void setTabIndex(int tabIndex) {
		this.tabIndex = tabIndex;
	}
	
	public void setTabindex(int tabIndex) {
		this.tabIndex = tabIndex;
	}
	
	public String getStyle() {
		return style;
	}
	
	public void setStyle(String style) {
		this.style = style;
	}
	
	public String getToolTip() {
		return toolTip;
	}
	
	public void setToolTip(String toolTip) {
		this.toolTip = toolTip;
	}
	
	public void setTooltip(String toolTip) {
		this.toolTip = toolTip;
	}
	
	public int getFontSize() {
		return fontSize;
	}
	
	public void setFontSize(int fontSize) {
		this.fontSize = fontSize;
	}
	
	public void setFontsize(int fontSize) {
		this.fontSize = fontSize;
	}
	
	public String getEventProc() {
		return eventProc;
	}
	
	public void setEventProc(String eventProc) {
		this.eventProc = eventProc;
	}
	
	public void setEventproc(String eventProc) {
		this.eventProc = eventProc;
	}
    
	public String getDefaultText() {
		return defaultText;
	}
	
	public void setDefaulttext(String defaultText) {
		this.defaultText = defaultText;
	}
	
	public void setDefaultText(String defaultText) {
		this.defaultText = defaultText;
	}
	
	public String getAlign() {
		return align;
	}
	
	public void setAlign(String align) {
		this.align = align;
	}
	
	public String getValign() {
		return valign;
	}
	
	public void setValign(String valign) {
		this.valign = valign;
	}
	
	public String getCallback()
	{
		return callback;
	}
	
	public void setCallback(String callback)
	{
		this.callback = callback;
	}
	
	public String getExtend()
	{
		return extend;
	}
	
	public void setExtend(String extend)
	{
		this.extend = extend;
	}
	
	public String getReadOnly()
	{
		return readOnly;
	}
	
	public void setReadOnly(String readOnly)
	{
		this.readOnly = readOnly;
	}	
}
