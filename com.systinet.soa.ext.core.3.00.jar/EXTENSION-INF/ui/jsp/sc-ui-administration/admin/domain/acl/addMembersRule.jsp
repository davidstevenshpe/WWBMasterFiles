<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${ruleType eq 'Create'}">
	<c:set var="customizationMemberId" value="admin.domain.acl.tableMemberCreateRule"/>
</c:if>
<c:if test="${ruleType eq 'Access'}">
	<c:set var="customizationMemberId" value="admin.domain.acl.tableMemberAccessRule"/>
</c:if>

<syswf:component name="/core/table" prefix="membersTable" wrap="true">
    <syswf:param name="customizationId" value="${customizationMemberId}" />
    <syswf:param name="datasource" value="${membersDataSource}"/>
    <syswf:param name="addMembersHolder" value="${addMembersHolder}"/>
	<syswf:param name="disableUsersTab">${disableUsersTab}</syswf:param>
	<syswf:param name="disableGroupsTab">${disableGroupsTab}</syswf:param>    		
    <syswf:param name="domainId" value="${domainId}" />
    <syswf:param name="bean" value="${bean}"/>		    
    <syswf:param name="kind" value="browse" />
</syswf:component>
