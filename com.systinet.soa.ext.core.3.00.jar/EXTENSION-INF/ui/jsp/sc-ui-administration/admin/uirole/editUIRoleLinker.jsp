<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${isAccessGranted}">
<%-- share role bundle  --%>
	<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="roleMsg" />
	<fmt:message key="edit.linker.Title" var="linkerCaption" bundle="${roleMsg}" />
	
	<syswf:control id="editUIRoleLink" mode="anchor" caption="${linkerCaption}" targetTask="/admin/uirole/edit">
		<syswf:param name="UIRoleId" value="${UIRoleId}" />
		<syswf:param name="mode" value="${mode}" />
		<syswf:attribute name="class" value="UI PageAction Edit" />
	</syswf:control>
</c:if>