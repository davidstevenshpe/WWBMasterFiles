<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<syswf:component name="/core/table" prefix="membersRole" wrap="true">
    <syswf:param name="customizationId" value="admin.domain.role.tableMemberRole" />
    <syswf:param name="datasource" value="${membersRoleDataSource}"/>
    <syswf:param name="addMembersHolder" value="${addMembersRoleHolder}"/>		
    <syswf:param name="raHolder" value="${raHolder}"/>
    <syswf:param name="addMembersRoleHolder" value="${addMembersRoleHolder}"/>
    <c:if test="${showReadOnly}"> 
        <syswf:param name="overrideselectionModel" value="none"/>
    </c:if>
    <syswf:param name="kind" value="browse" />
</syswf:component>