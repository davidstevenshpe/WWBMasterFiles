<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>
<fmt:message key="contractrequest.wizard.searchconsumer.message.warning" var="warning" bundle="${tornadoui_Message}"/>
<fmt:message key="contractrequest.wizard.searchconsumer.message.text.selectartifact" var="selectArtifact"
             bundle="${tornadoui_Message}"/>

<c:if test="${showWarningNotSelectedArtifact}">
    <div class="UI SystemMessage Warning">
        <div class="MessageContainer">
            <div class="Text">
                <strong>
                    <c:out value="${warning}"/>:
                </strong> <c:out value="${selectArtifact}"/>
            </div>
            <div class="x-clear"></div>
        </div>
    </div>
</c:if>

<%-- TODO REVIEW (Svata, 4/05/2009): Style: make short prefixes --%>
<syswf:component prefix="contractRequestWizard.selectConsumerStep" name="/core/search/advancedSearch" ajax="true">
    <syswf:param name="customizationId" value="analyst.contract.contractRequestConsumerSearch"/>
    <syswf:param name="selectionBag" value="${selectionBag}"/>
    <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
</syswf:component>