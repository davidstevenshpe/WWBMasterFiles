<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="bundle"/>
<fmt:message key="import.link.viewUcmdbRogue" var="viewRogue" bundle="${bundle}"/>
<fmt:message key="import.link.viewUcmdbIgnored" var="viewIgnored" bundle="${bundle}"/>
<fmt:message key="import.link.viewUcmdbImport" var="viewUcmdbImport" bundle="${bundle}"/>

<syswf:block className="UI Block Green">
    <div class="Content">
        <c:if test="${showUCMDBImportLink}">
            <syswf:control id="viewImport" caption="${viewUcmdbImport}" mode="anchor"
                           targetTask="/common/integration/import/ucmdbImport" targetDepth="0">
                <syswf:attribute name="class" value="UI PageAction Import"/>
            </syswf:control>
        </c:if>
        <c:if test="${showRogueLink}">
            <syswf:control id="viewRougue" caption="${viewRogue}" mode="anchor" targetTask="/common/integration/import/ucmdbRogue">
                <syswf:attribute name="class" value="UI PageAction ViewRogue"/>
            </syswf:control>
        </c:if>
        <c:if test="${showIgnoredLink}">
            <syswf:control id="viewIgnored" caption="${viewIgnored}" mode="anchor" targetTask="/common/integration/import/ucmdbIgnored">
                <syswf:attribute name="class" value="UI PageAction ViewIgnored"/>
            </syswf:control>
        </c:if>

    </div>

</syswf:block>