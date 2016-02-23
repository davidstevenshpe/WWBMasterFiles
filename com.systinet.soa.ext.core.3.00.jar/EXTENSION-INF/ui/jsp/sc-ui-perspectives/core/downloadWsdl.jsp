<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${(not empty wsdlLinkHolder) and (not empty wsdlLinkHolder.artifact)}">
    <c:if test="${not empty globalSession['userName']}">
       <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
    </c:if>
    
    <%-- Set Bundles. --%>
    <fmt:setBundle basename="com.systinet.contractmgr.ui.endpoint.EndpointMessages" var="endpointMessages"/>
    <fmt:message key="renderOneEnvironment_downloadWsdl" var="downloadWsdlTitle" bundle="${endpointMessages}"/>
    
    <syswf:component name="/util/locationLinkRenderer" prefix="envWsdl" wrap="false">
        <syswf:param name="artifact" value="${wsdlLinkHolder.artifact}"/>
        <syswf:param name="environment" value="${wsdlLinkHolder.environment}" />
        <syswf:param name="title" value="${downloadWsdlTitle}"/>
        <syswf:param name="mode" value="artifact"/>
    </syswf:component>
</c:if>