<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="bundle"/>
<fmt:message key="import.ucmdb" var="ucmdb" bundle="${bundle}"/>

<c:if test="${showUcmdbImport}">
	<li>
    	<syswf:control id="viewImport" caption="${ucmdb}" mode="anchor" targetTask="/common/integration/import/ucmdbImport" targetDepth="0" />
    </li>
</c:if>
