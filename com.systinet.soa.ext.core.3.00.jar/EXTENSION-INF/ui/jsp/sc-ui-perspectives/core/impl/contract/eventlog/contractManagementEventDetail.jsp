<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="messages"/>

<syswf:component name="/core/layout/header" prefix="eventDetailsTitle" wrap="false">
    <syswf:param name="title" value="${eventBean.description}"/>
</syswf:component>

<syswf:block className="UI Block Common">
    <div class="Content">
        <table class="UI Table Properties">
            <colgroup>
                <col class="LabelCol"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th>
                    <label class="UI Label Inline"><fmt:message key="contractManagement.event.detail.artifact"
                                                                bundle="${messages}"/></label>
                </th>
                <td>
                    <syswf:component prefix="artifact_link" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                        <syswf:param name="uuid" value="${eventBean.uuid}"/>
                        <syswf:param name="caption" value="${eventBean.name}"/>
                    </syswf:component>
                </td>
            </tr>
            <tr>
                <th>
                    <label class="UI Label Inline"><fmt:message key="contractManagement.event.detail.when"
                                                                bundle="${messages}"/></label>
                </th>
                <td>
                    <c:set var="whenDate">
                        <c:set var="shortAtDate"><syswf:value value="${eventBean.startingDate}" dataType="shortDateTime" wrapper=""/></c:set>
                        <c:set var="longAtDate"><syswf:value value="${eventBean.startingDate}" dataType="dateTime" wrapper=""/></c:set>
                        <span class="ItemDate" title="${longAtDate}">${shortAtDate}</span>
                    </c:set>
                    <c:set var="userLink">
                        <syswf:component name="/core/impl/util/artifactLinkRenderer"
                                         prefix="contact_link" wrap="false">
                            <syswf:param name="caption" value="${fullUserName}" />
                            <syswf:param name="uuid" value="${contactArtifactUuid}" />
                        </syswf:component>
                    </c:set>

                    <c:choose>
                        <c:when test="${not empty eventBean.user}">
                            <fmt:message key="contractManagement.event.detail.dateByUser" bundle="${messages}">
                                <fmt:param value="${fn:trim(whenDate)}"/>
                                <fmt:param value="${fn:trim(userLink)}"/>
                            </fmt:message>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${whenDate}" escapeXml="false"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</syswf:block>