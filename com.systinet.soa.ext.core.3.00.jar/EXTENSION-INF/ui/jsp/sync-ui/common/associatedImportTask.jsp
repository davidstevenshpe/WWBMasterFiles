<%-- (C) Copyright 2003-2013 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sync.ui.L10nUIMessages" var="syncUiL10n"/>
<fmt:message key="associatedImportTask.link.hint" var="associatedTaskHint" bundle="${syncUiL10n}"/>
<fmt:message key="associatedImportTask.link.label" var="associatedTaskLabel" bundle="${syncUiL10n}"/>

<%--@elvariable id="taskArtifact" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.TaskArtifact"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<c:if test="${not empty taskArtifact}">
     <c:choose>
     	<c:when test="${mode eq 'table'}">
           <syswf:control mode="anchor" targetTask="/artifact/${taskArtifact._uuid}" caption="${associatedTaskLabel}" hint="${associatedTaskHint}" id="associatedImportTask">
               <syswf:attribute name="class" value="UI Icon GovernanceStart"/>
           </syswf:control>
     	</c:when>
     	<c:otherwise>
           <syswf:control mode="anchor" targetTask="/artifact/${taskArtifact._uuid}" caption="" hint="${associatedTaskHint}" id="associatedImportTask">
	            <syswf:attribute name="class" value="context-button AssociatedTask"/>
           </syswf:control>
     	</c:otherwise>
     </c:choose>
</c:if>

