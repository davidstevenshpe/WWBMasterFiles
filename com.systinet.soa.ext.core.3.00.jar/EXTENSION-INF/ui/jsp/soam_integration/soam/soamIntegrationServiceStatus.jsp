<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="globalSession" type="java.util.Map"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>
<%--@elvariable id="isSoamSynchronizable" type="java.lang.String"--%>
<%--@elvariable id="soamServiceStatusContextInfo" type="com.systinet.platform.ui.integration.soam.struct.SoamServiceStatusContexInfo"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.systinet.platform.ui.integration.soam.SoamIntegrationL10n" var="integrationMessages"/>

<c:choose>
    <c:when test="${isSoamSynchronizable == null}">
        <%-- do not show the section at all --%>
    </c:when>
    <c:otherwise>
        <c:if test="${soamServiceStatusContextInfo != null}">
            <div id='<c:out value="${prefix}_soamstatus"/>'>
                <syswf:component name="/integration/soam/servicestatus/cell" wrap="false" prefix="soamstatus">
                    <syswf:param name="artifact" value="${artifact}"/>
                    <syswf:param name="soamServiceStatusContextInfo" value="${soamServiceStatusContextInfo}"/>
                </syswf:component>
            </div>
        </c:if>
    </c:otherwise>

</c:choose>