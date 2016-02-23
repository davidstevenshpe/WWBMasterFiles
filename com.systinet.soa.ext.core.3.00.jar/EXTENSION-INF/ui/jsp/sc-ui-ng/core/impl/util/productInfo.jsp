<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="uimessages_Message"/>
<%-- shared messages from about box --%>
<fmt:setBundle basename="shared.aboutBox" var="aboutMsg"/>

<table class="UI Layout">
    <tbody>
        <tr>
            <td class="UI Middle">
                <div class="UI PageIdentity">
                    <h1><fmt:message key="PRODUCT_INFO_TASK_CAPTION" bundle="${uimessages_Message}"/></h1>
                </div>

                <syswf:block className="UI Block Common">
                    <div class="Content">

                        <table class="UI Table Properties">
                            <col class="LabelCol" />
                            <col />

                            <tr>
                                <th><label class="UI Label Inline"><fmt:message key="versionLabel" bundle="${aboutMsg}"/></label></th>
                                <td>
                                    <fmt:message key="version" bundle="${aboutMsg}">
                                        <fmt:param value="${aboutBean.buildVersion}"/>
                                        <fmt:param value="${aboutBean.buildId}"/>
                                    </fmt:message>
                                </td>
                            </tr>
                            <c:if test="${not empty aboutBean.updates}">
                                <tr>
                                    <th><label class="UI Label Inline"><fmt:message key="versionUpdatesTitle" bundle="${aboutMsg}"/>:</label></th>
                                    <td>
                                        <c:forEach var="package" items="${aboutBean.updates}" varStatus="status">
                                              <c:out value="${package.name}"/> <c:out value="${package.version}"/>
                                              <c:if test="${not status.last}">, </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty aboutBean.extensions}">
                                <tr>
                                    <th><label class="UI Label Inline"><fmt:message key="versionExtensionsTitle" bundle="${aboutMsg}"/>:</label></th>
                                    <td>
                                        <c:forEach var="package" items="${aboutBean.extensions}" varStatus="status">
                                            <c:out value="${package.name}"/> <c:out value="${package.version}"/>
                                            <c:if test="${not status.last}">, </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                            </c:if>

                        </table>
                    </div>

                </syswf:block>
            </td>
        </tr>
    </tbody>
</table>
