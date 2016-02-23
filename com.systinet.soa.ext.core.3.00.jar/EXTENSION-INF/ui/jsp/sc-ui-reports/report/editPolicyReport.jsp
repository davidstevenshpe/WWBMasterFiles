<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="canDisplayComponent" type="boolean"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>
<%--@elvariable id="editationListener" type="com.hp.systinet.sc.ui.artifact.EditArtifactComponent.EditationListener"--%>

<c:if test="${canDisplayComponent}">
    <syswf:component prefix="action" name="/core/contextActions/editArtifact" wrap="false">
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:param name="editationListener" value="${editationListener}"/>
    </syswf:component>
</c:if>