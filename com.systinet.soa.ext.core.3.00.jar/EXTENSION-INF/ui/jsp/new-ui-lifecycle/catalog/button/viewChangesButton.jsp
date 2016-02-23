<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="artifactLifecycleData" type="com.hp.systinet.lifecycle.ui.common.ArtifactLifecycleData"--%>
<%--@elvariable id="uuid" type="com.hp.systinet.repository.sdm.properties.Uuid"--%>

<%--check if any approved state exists too (not empty artifactLifecycleData.governanceRecord.lastApprovedState) and
    if there are any actual changes (current revision should not equal last approved revision)--%>
<c:if test="${not empty artifactLifecycleData && not empty artifactLifecycleData.governanceRecord && not empty artifactLifecycleData.governanceRecord.lastApprovedState && artifactLifecycleData.artifact._revision != artifactLifecycleData.governanceRecord.lastApprovedRevision}">
    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
    <fmt:message key="viewChangesButton_buttonLabel" var="viewchangesbutton_buttonlabel" bundle="${messages}"/>
	<div class="EA-right-panel">
	    <span class="UI PageAction ViewDetails">
	        <syswf:control mode="anchor" targetTask="/common/diff" caption="${viewchangesbutton_buttonlabel}">
	            <syswf:param name="uuid" value="${artifactLifecycleData.artifactUuidStr}"/>
	            <syswf:param name="firstRev">${artifactLifecycleData.governanceRecord.lastApprovedRevision}</syswf:param>
	            <syswf:param name="secondRev">${artifactLifecycleData.artifact._revision}</syswf:param>
	        </syswf:control>
	    </span>
	</div>    
</c:if>
