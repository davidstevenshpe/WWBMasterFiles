<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="bundle"/>
<fmt:message key="import.report.goToUcmdb" var="goToUcmdb" bundle="${bundle}"/>

<c:if test="${showUcmdbImport}">
    <a href="javascript:void(0)" class="IconButton" id="goToUcmdb"><span><span>${goToUcmdb}</span></span></a>
    <syswf:control id="viewImport" mode="script" caption="viewImport" targetTask="/common/integration/import/ucmdbImport" />
    
    <script type="text/javascript">
    //<![CDATA[
    attachOn('goToUcmdb','click',viewImport);
    //]]>
    </script>    
</c:if>
