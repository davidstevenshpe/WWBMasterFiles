<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n"/>

<c:choose>
	<c:when test="${not empty registryBean.uuid}">
	    <label class="UI Label Inline"><fmt:message key="uddi.report.registryLabel" bundle="${l10n}"/>:</label>
	    <syswf:component name="/integration2/uddi/common/uddiServerLinker" prefix="serverLinker" wrap="false">
           <syswf:param name="serverName" value="${registryBean.name}"/>
           <syswf:param name="serverUUID" value="${registryBean.uuid}"/>
        </syswf:component>
	</c:when>
	<c:when test="${not empty registryBean.name}">
        <label class="UI Label Inline"><fmt:message key="uddi.report.registryLabel" bundle="${l10n}"/>: ${registryBean.name}</label>
	</c:when>
</c:choose>