<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="voterEntry" type="com.hp.systinet.lifecycle.ui.catalog.visualization.HeaderSection.SingleVoterEntry"--%>
<%--@elvariable id="hidePrincipal" type="java.lang.Boolean"--%>
<%--@elvariable id="parentPrincipal" type="com.hp.systinet.security.role.Principal"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<tr>
    <td>
        <c:set var="principal" value="${not empty parentPrincipal ? parentPrincipal : voterEntry.voter}"/>
        <c:if test="${not hidePrincipal}">
            <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="principal" wrap="false">
                <syswf:param name="principal" value="${principal}"/>
                <syswf:param name="showIcon" value="${true}"/>
            </syswf:component>
        </c:if>
    </td>
    <td>
        <c:choose>
            <c:when test="${voterEntry.pendingEntry}">
                <c:set var="voterInfo">
                    <fmt:message key="${voterEntry.infoKey}" bundle="${messages}">
                        <fmt:param value="${voterEntry.pendingCount}"/>
                    </fmt:message>
                    <c:if test="${not empty voterEntry.daysLeft}">
                        (<fmt:message key="voterInfo.daysLeft" bundle="${messages}">
                            <fmt:param value="${voterEntry.daysLeft}"/>
                        </fmt:message>)
                    </c:if>
                </c:set>
            </c:when>
            <c:otherwise>
                <c:set var="date">
                    <syswf:component prefix="date" name="/core/impl/util/enhancedDateRenderer" wrap="false">
                        <syswf:param name="dateValue" value="${voterEntry.date}"/>
                    </syswf:component>
                </c:set>
                <c:set var="user">
                    <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="user" wrap="false">
                        <syswf:param name="principal" value="${voterEntry.voter}"/>
                    </syswf:component>
                </c:set>
                <fmt:message key="${voterEntry.infoKey}" bundle="${messages}" var="voterInfo">
                    <fmt:param value="${fn:trim(date)}"/>
                    <fmt:param value="${fn:trim(user)}"/>
                </fmt:message>
            </c:otherwise>
        </c:choose>
        <c:set var="comment">
            <syswf:component prefix="comment" name="/newUi/lc/common/widget/flyoutComment" wrap="false">
                <syswf:param name="text" value="${voterEntry.message}"/>
                <syswf:param name="author" value="${voterEntry.voter}"/>
            </syswf:component>
        </c:set>
        <div class="UI Icon ${voterEntry.infoStyleClass}"
                >${voterInfo}<c:if test="${not empty voterEntry.message}">&nbsp;${fn:trim(comment)}</c:if></div>
    </td>
</tr>




