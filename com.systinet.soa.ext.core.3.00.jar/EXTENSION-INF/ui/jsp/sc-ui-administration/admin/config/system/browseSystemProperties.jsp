<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.system.SystemSettingsMessages" var="system_Messages" />

<syswf:block className="UI SystemMessage Info">
    <div class="MessageContainer"><fmt:message
        key="systemsettings.note" bundle="${system_Messages}" /></div>
</syswf:block>

<syswf:component name="/admin/configuration/system/action/editProperty" prefix="editPropertyPrefix">
    <syswf:param name="openDialogFunction" value="${prefix}openDialogFunction"/>
</syswf:component>

<syswf:block className="UI Block Common">
	<div class="webfw-Window" id="${prefix}-webfw-Window">
		<syswf:component name="/core/table" prefix="browseSystemProperties" wrap="false">
		    <syswf:param name="customizationId" value="admin.config.system.browseSystemProperties" />
		    <syswf:param name="openDialogFunction" value="${prefix}openDialogFunction"/>
		    <syswf:param name="kind" value="browse" />    
		</syswf:component>
	</div>
</syswf:block>


