<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="viewProfile_Messages" />
<p class="Message Warning">
    <fmt:message key="viewProfile.selectRole.set_action.warning_msg" bundle="${viewProfile_Messages}" />
</p>  
<syswf:component name="/core/table" prefix="roleSelector">
    <syswf:param name="customizationId" value="admin.util.roleSelector"/>
    <syswf:param name="selectionBag" value="${selectionBag}"/>
    <syswf:param name="datasource" value="${domainRolesDataSource}"/>
    <c:if test="${not empty inheritedRolesBag}">
        <syswf:param name="checkedSelectionBag" value="${inheritedRolesBag}"/>
    </c:if>
</syswf:component>