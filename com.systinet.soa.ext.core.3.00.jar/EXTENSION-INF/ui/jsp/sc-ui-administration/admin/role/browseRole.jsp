<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage"
	var="roleMsg" />
<fmt:message key="browse.Title" var="title"
	bundle="${roleMsg}" />	
<table class="UI Layout">
	<tbody>
		<tr>
			<td>
				<syswf:component name="/core/layout/header" prefix="header"
				    wrap="false">
				    <syswf:param name="title" value="${title}" />
				    <syswf:param name="iconFormat" value="small" />
				</syswf:component>
				<syswf:component name="/core/table" prefix="rolelist" wrap="false">
				    <syswf:param name="customizationId" value="admin.role.browseRoleTable" />
				    <syswf:param name="title" value="Roles"/>
				</syswf:component>
			</td>
		</tr>
	</tbody>
</table>