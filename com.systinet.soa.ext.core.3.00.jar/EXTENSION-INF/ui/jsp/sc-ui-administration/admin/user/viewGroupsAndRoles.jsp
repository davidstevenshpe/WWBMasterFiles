<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="viewProfile_Messages" />
<fmt:message var="groupCaption" key="viewProfile.group.caption" bundle="${viewProfile_Messages}" />

<syswf:component name="/admin/common/domainRoles" prefix="domainRoles">
    <syswf:param name="principal" value="${principalUser}"/>
    <!-- syswf:param name="domainWithRole" value="DomainUser"/-->
    <syswf:param name="readOnly" value="${artifact.accountState.val eq 'S3'}"/>
    <syswf:param name="affectOnComponent" value="${prefix}_domainRoles"/>
</syswf:component>

<c:choose>
<c:when test="${isManager and not (artifact.accountState.val eq 'S3')}">
 <syswf:component name="/core/table" prefix="browseUserGroup" wrap="false">
     <syswf:param name="customizationId" value="admin.user.tableUserGroups" />
     <syswf:param name="wrapCaption" value="${groupCaption}"/>
     <syswf:param name="loginName" value="${loginName}"/>
     <syswf:param name="datasource" value="${groupsTableDataSource}"/>
     <syswf:param name="internalGroupDS" value="${internalGroupDS}"/>
     <syswf:param name="addGroupHolder" value="${addGroupHolder}"/>
 </syswf:component>
</c:when>
<c:otherwise>
 <syswf:component name="/core/table" prefix="browseUserGroup" wrap="false">
     <syswf:param name="customizationId" value="admin.user.tableViewUserGroups" />
     <syswf:param name="wrapCaption" value="${groupCaption}"/>
     <syswf:param name="loginName" value="${loginName}"/>
     <syswf:param name="datasource" value="${groupsTableDataSource}"/>
     <syswf:param name="addGroupHolder" value="${addGroupHolder}"/>
 </syswf:component>

</c:otherwise>
</c:choose>
