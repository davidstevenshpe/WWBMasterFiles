<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" 
	var="role_Messages" />
<fmt:message var="dialog_title" key="uirole.assiged.remove.header.label" bundle="${role_Messages}"/>
<fmt:message var="message" key="uirole.assiged.remove.confirm.label" bundle="${role_Messages}"/>

<syswf:component name="/core/impl/util/dialog" prefix="dialogUIRole">
		<syswf:param name="handler" value="${prefix}removeAssingedUIRole" />
		<syswf:param name="heading">${dialog_title}</syswf:param>
		<syswf:param name="content">${message}</syswf:param>
</syswf:component>

<syswf:control mode="script" action="remove" caption="${prefix}removeAssingedUIRole" >
	<syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>
