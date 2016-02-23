<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.platform.ui.bacintegration.BacIntegrationUiL10n" var="bacIntegrationUiL10n"/>
<fmt:message key="import.action.startImport" var="startImport" bundle="${bacIntegrationUiL10n}"/>
<fmt:message key="import.action.stopImport" var="stopImport" bundle="${bacIntegrationUiL10n}"/>

<c:choose>
    <%--@elvariable id="isBacDiscoveryToolRunning" type="boolean"--%>
    <c:when test="${empty notPageAction}">
        <div class="Content">
        <c:choose>
            <c:when test="${isBacDiscoveryToolRunning}">
                <syswf:control id="stopImport" caption="${stopImport}" action="stopDiscovery" mode="postAnchor"
                               loadingMask="true">
                    <syswf:attribute name="class" value="UI PageAction Stop"/>
                </syswf:control>
            </c:when>
            <c:otherwise>
                <syswf:control id="startImport" caption="${startImport}" action="startDiscovery" mode="postAnchor"
                               loadingMask="true">
                    <syswf:attribute name="class" value="UI PageAction Import"/>
                </syswf:control>
            </c:otherwise>
        </c:choose>
        </div>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${isBacDiscoveryToolRunning}">
                <syswf:control id="stopImport" caption="${stopImport}" action="stopDiscovery" mode="anchor"/>
            </c:when>
            <c:otherwise>
                <syswf:control id="startImport" caption="${startImport}" action="startDiscovery" mode="anchor"/>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
