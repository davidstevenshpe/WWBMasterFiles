<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages" var="group_Messages" />
<fmt:message key="retire.group.action.Title" var="title" bundle="${group_Messages}" />

<c:if test="${not (group.external or retired or group.privateGroup)}">
	
	<a href="javascript:void(0);" class="context-button RetireGroup" id="${prefix}_retireGroupLink" title="${title}"></a>
	
	<c:set var="controlName" value="retireGroup" />
	<syswf:component name="/admin/group/bulk/retirePrincipals" prefix="retireSingle">
		<syswf:param name="singlePrincipal" value="${groupName}" />
		<syswf:param name="controlName" value="${controlName}" />
	</syswf:component>
	
	
	<script type="text/javascript">
//<![CDATA[

	    Ext.onReady(function() {
	        attachOn('${prefix}_retireGroupLink','click',${controlName});
	    });
	
//]]>
</script>
</c:if>


