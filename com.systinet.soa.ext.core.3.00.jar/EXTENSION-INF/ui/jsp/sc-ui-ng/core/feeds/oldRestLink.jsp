<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="utilmessages" />
<fmt:message key="oldRestLinkTitle" bundle="${utilmessages}" var="label"/>

<%--@elvariable id="oldRestLink" type="java.lang.String"--%>

<c:if test="${isOldRestPermitted}">	
    <c:if test="${not empty oldRestLink}">
		<c:choose>
			<c:when test="${ contextMenu == true}">
				<div class="EA-left-panel">
					<a class="UI PageAction XMLView" title="${label}" href="${oldRestLink}"><span>${label}</span></a>
				</div>
			</c:when>
			<c:otherwise>
				<a class="context-button RSS" href="${oldRestLink}" title="${label}"></a>
			</c:otherwise>
		</c:choose>
    </c:if>
</c:if>