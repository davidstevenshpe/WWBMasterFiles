<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>

<%-- Get Message. --%>
<fmt:message key="contractrequest.wizard.summary.header" var="summaryHeader"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.summary.description" var="summaryDescription"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.messageDocuments.documents" var="documents"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.summary.contractdetails" var="contractdetails"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.summary.slo" var="slo"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.messageDocuments.messagetoprovider" var="messagetoprovider"
             bundle="${tornadoui_Message}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${summaryHeader}"/>
</syswf:component>

<div class="UI Text Description">
    <p>
        <c:out value="${summaryDescription}"/>
    </p>
</div>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><span><c:out value="${contractdetails}"/></span></h3>
    </div>
    <div class="Content">
        <table summary="" class="UI Table Properties">
            <colgroup>
                <col class="LabelCol"/>
                <col/>
            </colgroup>
            <tbody>
            <syswf:component name="/core/impl/contract/providerView"
                             prefix="contractRequestSlo.providerView" wrap="false">
                <syswf:param name="editProvider" value="${editProvider}"/>
                <syswf:param name="showProvidedBy" value="${showProvidedBy}"/>
            </syswf:component>
            <c:if test="${hasSloItems}">
                <tr>
                    <th><label class="UI Label Inline"><c:out value="${slo}"/>:</label></th>
                    <td>
                        <c:set var="counter" scope="request" value="${0}"/>
                        <c:forEach var="sloItem" items="${sloItems}">
                            <c:if test="${counter gt 0}">
                                <c:out value=", "/>
                            </c:if>
                            <syswf:component prefix="providerView"
                                             name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                <syswf:param name="caption" value="${sloItem.caption}"/>
                                <syswf:param name="uuid" value="${sloItem.uuid}"/>
                            </syswf:component>
                            <c:set var="counter" scope="request" value="${counter + 1}"/>
                        </c:forEach>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>

    </div>
</syswf:block>
<c:if test="${containsMessage}">
   <syswf:block className="UI Block Common">
        <div class="Title">
            <h3><span><c:out value="${messagetoprovider}"/></span></h3>
        </div>
        <div class="Content">
            <div class="UI Text Description">
                <c:out value="${messageText}" escapeXml="false"/>
            </div>
        </div>
    </syswf:block>
</c:if>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><span>${documents}</span></h3>
    </div>
    <div class="Content">
        <syswf:component prefix="documentation" name="/core/relations/genericRelationshipComponent">
            <syswf:param name="tableDefinitionId">${viewId}.contract.documentationSummary</syswf:param>
            <syswf:param name="relation">documentation</syswf:param>
            <syswf:param name="artifact" value="${contractRequestArtifact}"/>
            <syswf:param name="new">true</syswf:param>
            <syswf:param name="dataSourceBinding" value="${dataSourceBinding}"/>
        </syswf:component>
    </div>
</syswf:block>