<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="entries" type="java.util.List"--%>

<syswf:block className="UI Block Plain">
    <div class="Title">
        <h4><span><fmt:message key="approversSection.title" bundle="${messages}"/></span></h4>
    </div>
    <div class="Content">
        <div class="Offset">
            <c:choose>
                <c:when test="${not empty entries}">
                    <table class="UI Table Properties">
                        <col class="XLongLabelCol"/>
                        <col/>
                        <c:forEach items="${entries}" var="entry" varStatus="status">
                            <%--@elvariable id="entry" type="com.hp.systinet.lifecycle.ui.catalog.visualization.ApproversSection.ApproverSectionEntry"--%>
                            <tr>
                                <td>
                                    <syswf:component name="/core/impl/util/principalLinkRenderer"
                                                     prefix="voter${status.index}" wrap="false">
                                        <syswf:param name="principal" value="${entry.voter}"/>
                                        <syswf:param name="showIcon" value="${true}"/>
                                    </syswf:component>
                                </td>
                                <td>
                                    <div class="UI Icon ${entry.withPassiveApproval ? 'EventUserActionPending' : 'Unknown'}">
                                      <c:out value="${entry.info}"/></div>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <fmt:message key="sections.noItems" bundle="${messages}"/>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</syswf:block>

