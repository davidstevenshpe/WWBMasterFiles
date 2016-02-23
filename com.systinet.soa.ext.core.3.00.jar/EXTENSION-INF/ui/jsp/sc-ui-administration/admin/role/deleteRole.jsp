<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="role_Messages" />

<fmt:message key="role.action.delete.title" var="title" bundle="${role_Messages}" />

<c:if test="${isAccessGranted}">
<c:if test="${role.roleType == 'NONSYSTEM'}">
	<a href="javascript:void(0);" class="context-button Remove" title="${title}" id="${prefix}_deleteRoleLink">
	</a>

	<c:set var="controlName" value="deleteRole" />

	<syswf:component name="/admin/role/bulk/deleteRoles" prefix="deleteSingle">
		<syswf:param name="singlePrincipal" value="${roleId}" />
		<syswf:param name="controlName" value="${controlName}" />
	</syswf:component>
	
	<script type="text/javascript">
//<![CDATA[

	    Ext.onReady(function() {
	        attachOn('${prefix}_deleteRoleLink','click',${controlName});
	    });
	
//]]>
</script>	  
</c:if>
</c:if>