<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="failureInfo" type="com.hp.systinet.repository.structures.FailInfo"--%>
<%--@elvariable id="exception" type="com.hp.systinet.repository.exceptions.RepositoryException"--%>
<%--@elvariable id="message" type="java.lang.String"--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

<div class="UI SystemMessage Error">
    <div class="MessageContainer">
        <div class="Text">
        	<strong><fmt:message key="script.error" bundle="${messages}"/></strong>
        		<c:choose>
        			<c:when test="${not empty  failureInfo and not empty  failureInfo.failMessage}">
        				<c:out value="${failureInfo.failMessage}" escapeXml="false"/>
        			</c:when>
        			<c:otherwise>
        				<c:out value="${message}" escapeXml="false"/>
        			</c:otherwise>
        		</c:choose>
        </div>
        <div class="x-clear"></div>
    </div>
</div>