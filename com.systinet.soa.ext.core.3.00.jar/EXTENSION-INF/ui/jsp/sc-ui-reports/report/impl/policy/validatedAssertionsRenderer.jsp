<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="messages"/>

<%--@elvariable id="validatedAssertions" type="java.util.List<ValidatedAssertionBean>"--%>
<%--@elvariable id="showAssertionArtifacts" type="java.lang.Boolean"--%>
<%--@elvariable id="assertionArtifactTabId" type="java.lang.String"--%>
<%--@elvariable id="policyUuid" type="com.hp.systinet.repository.sdm.properties.Uuid"--%>
<%--@elvariable id="bean" type="com.hp.systinet.report.ui.impl.policy.ValidatedAssertionsRenderer.ValidatedAssertionsRendererBean"--%>

<c:if test="${(not empty bean.assertionBeans) and (fn:length(bean.assertionBeans) gt 0)}">
    <div class="Children">
        <c:forEach var="item" items="${bean.assertionBeans}" varStatus="status">
            <c:choose>
                <c:when test="${item.statusText eq 'notCompliant'}">
                    <c:set var="itemClass" value="Child Error"/>
                </c:when>
                <c:when test="${item.statusText eq 'warning'}">
                    <c:set var="itemClass" value="Child Warning"/>
                </c:when>
                <c:otherwise>
                    <c:set var="itemClass" value="Child NotApplicable"/>
                </c:otherwise>
            </c:choose>
            <div class="${itemClass}">
                <div class="ChildLabel">
                    <syswf:component prefix="${prefix}_assertionLink_${item.assertionId}"
                                     name="/core/impl/util/artifactLinkRenderer" wrap="false">
                        <syswf:param name="uuid" value="${item.assertionDefinitionUuid}"/>
                        <syswf:param name="caption" value="${item.assertionName}"/>
                        <syswf:param name="sdmName" value="assertionArtifact"/>
                        <%--<syswf:param name="class" value="${styleClass}"/>--%>
                    </syswf:component>
                </div>
                <div class="ChildBody">
                    <c:if test="${not empty showAssertionArtifacts and showAssertionArtifacts and not empty assertionArtifactTabId}">
                        <%-- Shows artifacts validated by assertions --%>
                        <div>
                            <fmt:message key="validationResult.assertions.artifacts" bundle="${messages}"/>
                            <syswf:component prefix="${prefix}_${policyUuid}_assertionArtifacts_${status.index}"
                                             name="/core/impl/util/artifactListLinkRenderer" wrap="false">
                                <syswf:param name="artifactNames" value="${item.validatedArtifactNames}"/>
                                <syswf:param name="artifactUuids" value="${item.validatedArtifactUuids}"/>
                                <syswf:param name="artifactTabId" value="${assertionArtifactTabId}"/>
                                <syswf:param name="defaultShow" value="3"/>
                                <syswf:param name="emptyListKey" value="none"/>
                                <syswf:param name="inline" value="${true}"/>
                            </syswf:component>
                        </div>
                    </c:if>
                    <div>
                        <span class="Comment">
                                                <c:choose>
                                                    <c:when test="${not empty item.errorHint}">
                                                        <c:forEach items="${item.processedErrorHint}" var="j"><c:choose>
                                                            <c:when test="${j.class.name eq 'java.lang.String'}"><c:out value="${j}" escapeXml="true"/></c:when>
                                                            <c:otherwise><syswf:control targetTask="/artifact/${j.uuid}" caption="${j.name}" mode="anchor"/></c:otherwise>
                                                        </c:choose></c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:out value="${ item.assertionDescription }"/>
                                                    </c:otherwise>
                                                </c:choose>
                        </span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</c:if>
