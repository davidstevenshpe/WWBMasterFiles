<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.systinet.platform.ui.bacintegration.BacIntegrationUiL10n" var="bacIntegrationUiL10n"/>

<fmt:message key="bac.webServiceContextActions_bacIntegration" var="bacIntegration" bundle="${bacIntegrationUiL10n}"/>
<syswf:wrap template="/layouts/designV3/areas/wrappedAreaTemplate.jsp">
    <syswf:param name="name" value="${prefix}_bac_synch"/>
    <syswf:param name="caption" value="${bacIntegration}"/>

	<syswf:component name="/integration/bac/servicestatus" prefix="integration_bac_servicestatus_table"/>
</syswf:wrap>