<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="userMessages" />

<fmt:message bundle="${userMessages}" key="deleteUser.confirmation" var="msgConfirm"/>
<fmt:message bundle="${userMessages}" key="deleteUser.delete" var="msgDelete"/>
<c:choose>
    <c:when test="${empty artifact.loginName}">
        <syswf:component name="/core/contextActions/deleteArtifact" prefix="deleteContact">
            <syswf:param name="artifact" value="${artifact}"/>
        </syswf:component>
    </c:when>
    <c:when test="${artifact.accountState.val == 'S3'}">
        <syswf:component name="/admin/user/actions" prefix="deleteUser">
            <syswf:param name="uuid" value="${artifact._uuid}"/>
            <syswf:param name="title" value="${msgDelete}"/>
            <syswf:param name="dialog_title" value="${msgConfirm}"/>
            <syswf:param name="mode" value="delete"/>
            <syswf:param name="styleClass" value="context-button Remove"/>
            <syswf:param name="userName" value="${artifact.name}"/>
        </syswf:component>
    </c:when>
</c:choose>


