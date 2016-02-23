<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>

<div class="UI Offset">
    <%-- TODO REVIEW (Svata, 30/04/2009): Use short prefixes --%>
    <syswf:component name="/core/impl/tree/table" prefix="contractRequestProviderTreeTable">
        <%-- TODO REVIEW (Svata, 30/04/2009): Check if really the same for partner and analyst or we want the configurations to be managed
                differently --%>
        <syswf:param name="customizationId"
                     value="partner.contract.contractRequestProviderTreeTable"/>
        <syswf:param name="uuid" value="${uuid}"/>
        <syswf:param name="reportType" value="${reportType}"/>
        <%-- TODO REVIEW (Svata, 30/04/2009): Unnecessary ? --%>
        <syswf:param name="availableArtifacts" value="${availableArtifacts}"/>
        <syswf:param name="datasourceInstance" value="${datasourceInstance}"/>
        <syswf:param name="selection" value="${selection}"/>
        <syswf:param name="availableConsumerTypes" value="${availableConsumerTypes}"/>
    </syswf:component>
</div>