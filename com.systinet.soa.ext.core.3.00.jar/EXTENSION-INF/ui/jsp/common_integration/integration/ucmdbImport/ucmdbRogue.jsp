<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="IntegrationL10n"/>
<fmt:message key="web.rogueServices" var="rogueServicesTitle" bundle="${IntegrationL10n}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${rogueServicesTitle}"/>
</syswf:component>

<syswf:component prefix="columns" name="/integration/ucmdbImport/ucmdbRogueContents" />
