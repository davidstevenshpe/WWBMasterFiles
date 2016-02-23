<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.contextactions.messages" var="messages"/>
<fmt:message bundle="${messages}" key="lastRevision" var="lastRevisionLabel" />
<fmt:message bundle="${messages}" key="nextRevision" var="nextRevisionLabel" />
<fmt:message bundle="${messages}" key="previousRevision" var="previousRevisionLabel" />
<fmt:message bundle="${messages}" key="outOfRevisionMode" var="outOfRevisionMode" />

<c:if test="${not (currentRevisionNumber == 1)}">
    <syswf:control id="linkToPreviousRevision" mode="anchor" caption="" hint="${previousRevisionLabel}" targetTask="/artifact/${artifact._uuid}">
        <syswf:param name="revision">${currentRevisionNumber - 1}</syswf:param>
        <syswf:attribute name="class" value="context-button GoBack"/>        
    </syswf:control>
</c:if>

<c:if test="${not lastRevision}">    
    <syswf:control id="linkToNextRevision" mode="anchor" caption="" hint="${nextRevisionLabel}" targetTask="/artifact/${artifact._uuid}">
        <syswf:param name="revision">${currentRevisionNumber + 1}</syswf:param>
        <syswf:attribute name="class" value="context-button GoForward"/>        
    </syswf:control>
</c:if>
    
<c:choose>
    <c:when test="${not lastRevision}">
        <c:set var="lastRevisionCaption" value="${lastRevisionLabel}"/>
    </c:when>
    <c:otherwise>
        <c:set var="lastRevisionCaption" value="${outOfRevisionMode}"/>
    </c:otherwise>
</c:choose>
    
<syswf:control id="linkToLastRevision" mode="anchor" caption="" hint="${lastRevisionCaption}" targetTask="/artifact/${artifact._uuid}">
    <syswf:attribute name="class" value="context-button GoLatest"/>
</syswf:control>