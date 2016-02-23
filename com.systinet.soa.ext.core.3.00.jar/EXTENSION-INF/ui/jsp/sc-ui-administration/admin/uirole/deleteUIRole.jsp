<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="role_Messages" />

<c:if test="${isAccessGranted}">
<c:if test="${not uirole.systemRole}">
	<a href="javascript:void(0);" class="UI PageAction Delete" id="${prefix}_deleteUIRoleLink">
	<span><fmt:message key="role.action.delete.title" bundle="${role_Messages}" /></span>
	</a>

	<c:set var="controlName" value="deleteUIRole" />
	<syswf:component name="/admin/uirole/bulk/deleteUIRoles" prefix="deleteSingle">
		<syswf:param name="singleUIRole" value="${UIRoleId}" />
		<syswf:param name="controlName" value="${controlName}" />
	</syswf:component>
	
	
	<script type="text/javascript">
//<![CDATA[

	    Ext.onReady(function() {
	        attachOn('${prefix}_deleteUIRoleLink','click',${controlName});
	    });
	
//]]>
</script>	  
</c:if>
</c:if>