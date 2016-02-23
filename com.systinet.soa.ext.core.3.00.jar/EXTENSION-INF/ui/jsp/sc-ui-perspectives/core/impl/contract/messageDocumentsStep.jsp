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
<fmt:message key="contractrequest.wizard.messageDocuments.header" var="messageDocumentsHeader"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.messageDocuments.description" var="messageDocumentsDescription"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.messageDocuments.documents" var="documents"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.messageDocuments.adddocument" var="adddocument"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.messageDocuments.messagetoprovider" var="messagetoprovider"
             bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.messageDocuments.remove" var="remove"
             bundle="${tornadoui_Message}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${messageDocumentsHeader}"/>
</syswf:component>

<div class="UI Text Description">
    <p>
        <%-- TODO REVIEW (Svata, 4/05/2009): Style: use ${} directly in text, c:out is not necessary --%>
        <c:out value="${messageDocumentsDescription}"/>
    </p>
</div>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><span><c:out value="${messagetoprovider}"/></span></h3>
    </div>
    <div class="Content">
        <table width="100%" class="shrTableHolder">
            <tr>
                <td>
                    <div id="ajax_descriptionEditor" class="AJAXContainer">
                        <syswf:textArea id="${prefix}_richTextAreaWidget" name="richTextAreaWidget"
                                        value="${contractRequestArtifact}" property="description">
                        </syswf:textArea>

                            <%-- TODO REVIEW (Svata, 4/05/2009): Coding: do not use ${prefix} in prefixes --%>
                            <%-- TODO REVIEW (Svata, 4/05/2009): Design: why Component does not create its own text area, and must be
                       given one from outside ? --%>
                        <syswf:component name="/core/impl/edit/richTextEditor" prefix="${prefix}_richText" wrap="false">
                            <syswf:param name="textAreaId" value="${prefix}_richTextAreaWidget"/>
                            <syswf:param name="height" value="400"/>
                        </syswf:component>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</syswf:block>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><span>${documents}</span></h3>
    </div>
    <div class="Content">
        <syswf:component prefix="documentation" name="/core/relations/genericRelationshipComponent">
            <syswf:param name="tableDefinitionId">${viewId}.contract.documentation</syswf:param>
            <syswf:param name="relation">documentation</syswf:param>
            <syswf:param name="artifact" value="${contractRequestArtifact}"/>
            <syswf:param name="dataSourceBinding" value="${dataSourceBinding}" />
            <syswf:param name="hideKeywords" value="true" />
            <syswf:param name="hideDocType" value="true" />
        </syswf:component>
    </div>
</syswf:block>