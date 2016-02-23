<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="common_Messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.system.SystemSettingsMessages" var="system_Messages" />
<fmt:message var="downloadLabel" key="systemsettings.detailProperty.action.download.label" bundle="${system_Messages}"/>
 	
<a href="javascript:void(0);" class="UI Icon Upload" id="${prefix}upload_property"><fmt:message key="systemsettings.detailProperty.action.upload.label" bundle="${system_Messages}"/></a>

<syswf:control mode="anchor" caption="${downloadLabel}" targetTask="/admin/configuration/system/action/downloadProperty">
	<syswf:param name="propertyId" value="${propertyId}"/>
	<syswf:attribute name="class" value="UI Icon Download"/>
</syswf:control>

<div class="webfw-Window" id="${prefix}-webfw-Window">    
    <div id="${prefix}uploadPropertyWindow" class="x-hidden">
        <div class="x-window-header"><fmt:message key="systemsettings.detailProperty.action.upload.dialog.header" bundle="${system_Messages}"/></div>
        <div class="x-window-body">
          	<table class="UI Table Properties FileUpload">
			    <colgroup>
			        <col class="LabelCol" />
			        <col />
			    </colgroup>
			    <tbody>
			         <tr>
			             <th>
			                 <label class="UI Label Inline"><fmt:message key="systemsettings.properties.name.label" bundle="${system_Messages}"/>:</label>
			             </th>
			             <td>
			                 <span class="IconAlign"><c:out value="${propertyBean.name}"/></span>
			             </td>
			         </tr>
			         <tr>
			             <th>
			                 <label class="UI Label Inline"><fmt:message key="systemsettings.properties.value.label" bundle="${system_Messages}"/>:</label>
			             </th>
			             <td>
			                 <syswf:input id="${prefix}_localFile" name="uploadFileName" mode="file" value="${propertyBean}" property="value" hint="">
			                        <syswf:attribute name="size" value="35"/>
	                               <syswf:attribute name="class" value="UI Form FileInput"/>
			                  </syswf:input>
				         </td>
			         </tr>
			         
			    </tbody>
			</table>
        </div>
    </div>
</div>
<c:if test="${empty customButtons}">
	<c:set var="customButtons">
	    [{
	        text     : '<fmt:message key="systemsettings.detailProperty.action.edit.dialog.bt_save.label" bundle="${system_Messages}"/>',
	        disabled : false,
	        handler  : function() {
	            SPopup.Window.Instance['${prefix}uploadPropertyWindow'].hide();
	            ${prefix}upload();
	        },
	        id: '${prefix}_saveButton'
	    },
	    {
	        text     : '<fmt:message key="systemsettings.detailProperty.action.edit.dialog.bt_cancel.label" bundle="${system_Messages}"/>',
	        handler  : function(){
	            SPopup.Window.Instance['${prefix}uploadPropertyWindow'].hide();
	            return false;
	        },
	        id: '${prefix}_cancelButton'
	    }]
	</c:set>
</c:if>
<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="upload" caption="${prefix}upload" />
<script type="text/javascript">
//<![CDATA[


<%-- Popup window needs to be reinitialized on AJAX update --%>
Ext.onReady(function() {
	 attachOn('${prefix}upload_property','click',function() {
		 SPopup.Window.forceOpen('${prefix}uploadPropertyWindow','${prefix}uploadPropertyWindow',{
			 autoHeight: true, 
	         width: 430,
	         plain:false,
	         resizable: false,
	         buttons: <c:out value="${customButtons}" escapeXml="false"/>,
	         buttonAlign:'center',
	         centerOnScreen: true
		 });
	 });
})
Ext.onReady(function() {
    SPopup.Window.Instance['${prefix}upload_property'] = undefined;
})

//]]>
</script>
