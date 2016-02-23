<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${show}">

    <c:if test="${refreshOnSelect}">
        <syswf:control mode="script" id="${prefix}RefreshOnSelect" caption="${prefix}RefreshOnSelect" action="REFRESH_JMS"/>
    </c:if>

    <syswf:component name="${widgetName}" prefix="W" wrapIfEmpty="false">
        <syswf:paramSet value="${componentParams}" />
        <c:if test="${refreshOnSelect}">
            <syswf:param name="onSelectAction" value="${prefix}RefreshOnSelect" />
        </c:if>
    </syswf:component>
</c:if>