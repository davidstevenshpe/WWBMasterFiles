<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${isAccessGranted}">
	<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="roleMsg" />
	<fmt:message key="edit.linker.Title" var="linkerCaption" bundle="${roleMsg}" />
	
	<syswf:control id="editRoleLink" mode="anchor" caption="" targetTask="/admin/role/edit">
		<syswf:param name="RoleId" value="${RoleId}" />
		<syswf:param name="mode" value="${mode}" />
		<syswf:param name="allowsLogin" value="${allowsLogin}" />
		<syswf:attribute name="class" value="context-button Edit" />
		<syswf:attribute name="title" value="${linkerCaption}" />
	</syswf:control>
</c:if>