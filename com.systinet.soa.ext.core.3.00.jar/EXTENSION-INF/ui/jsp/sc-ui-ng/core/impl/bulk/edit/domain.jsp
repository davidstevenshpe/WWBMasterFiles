<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${not empty availableDomains && operationAllowed}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages"/>

<syswf:component name="/core/window" prefix="dw">
    <syswf:param name="winComponent" value="/core/impl/bulk/edit/domainWindow" />
    <syswf:param name="winTitle"><fmt:message bundle="${messages}" key="changeDomain.title" /></syswf:param>
    <syswf:param name="winOpenFunctionName" value="${controlName}" />
    <syswf:param name="winOkLabel"><fmt:message bundle="${messages}" key="changeDomain.okLabel" /></syswf:param>
    <syswf:param name="winOkAction" value="${prefix}change" />
    
    <syswf:param name="availableDomains" value="${availableDomains}" />
    <syswf:param name="availableDomainsCaptions" value="${availableDomainsCaptions}" />
    <syswf:param name="holder" value="${holder}" />
</syswf:component>

<syswf:control mode="script" caption="${prefix}change" action="change" />

</c:if>