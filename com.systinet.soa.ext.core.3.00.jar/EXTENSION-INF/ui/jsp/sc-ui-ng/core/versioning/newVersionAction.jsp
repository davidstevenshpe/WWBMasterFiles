<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${this.permissions.write && isVersionable}">
    <fmt:setBundle basename="com.hp.systinet.sc.ui.versioning.versioning" var="versioningMessages"/>
	
	<c:choose>
	<c:when test="${ contextMenu == true}">
		<div class="EA-left-panel">
			<fmt:message var="newVersion_caption" bundle="${versioningMessages}" key="contextActions.newVersion.caption" />
			<syswf:control mode="postAnchor" targetTask="/common/newVersion" action="newVersion" caption="${newVersion_caption}" hint="${newVersion_caption}">
				<syswf:taskParam name="uuid" value="${artifact._uuid}" />
				<syswf:attribute name="class">UI PageAction NewVersion</syswf:attribute>
			</syswf:control>
		</div>
	</c:when>
	<c:otherwise>
		<fmt:message var="newVersion_caption" bundle="${versioningMessages}" key="contextActions.newVersion.caption" />
		<syswf:control mode="postAnchor" targetTask="/common/newVersion" action="newVersion" caption="" hint="${newVersion_caption}">
			<syswf:taskParam name="uuid" value="${artifact._uuid}" />
			<syswf:attribute name="class">context-button NewVersion</syswf:attribute>
		</syswf:control>
	</c:otherwise>
	</c:choose>
    
</c:if>