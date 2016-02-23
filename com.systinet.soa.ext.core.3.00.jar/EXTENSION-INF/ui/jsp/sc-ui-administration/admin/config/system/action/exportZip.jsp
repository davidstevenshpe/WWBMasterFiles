<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages"
	var="common_Messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.system.SystemSettingsMessages"
	var="system_Messages" />
<fmt:message var="dialog_title" key="systemsettings.listProperties.action.export.dialog.header" bundle="${system_Messages}"/>
<fmt:message var="message" key="systemsettings.listProperties.action.export.dialog.confirmMessage" bundle="${system_Messages}"/>

<syswf:component name="/core/impl/util/dialog" prefix="dialog">
   <syswf:param name="handler" value="${prefix}exportZip" />
   <syswf:param name="heading">${dialog_title}</syswf:param>
   <syswf:param name="content">${message}</syswf:param>
</syswf:component>

<syswf:control mode="script" caption="${prefix}exportZip" targetTask="/admin/configuration/system/action/exportProperties">
	  <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>
