<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="utilmessages"/>

<%--@elvariable id="atomLink" type="java.lang.String"--%>
<%--@elvariable id="mode" type="java.lang.String"--%>
<%--@elvariable id="caption" type="java.lang.String"--%>

<c:set var="link" value="${atomLink}"/>
<c:set var="linkText">
  <c:if test="${not empty caption}">${caption}</c:if>
  <c:if test="${empty caption}"><fmt:message key="atomFeedTitle" bundle="${utilmessages}"/></c:if>
</c:set>
<c:if test="${not empty link}">
    <c:choose>
        <c:when test="${not empty mode}">
            <c:if test="${mode eq 'data'}">
                <a href="${link}"><span><c:out value="${caption}"/></span></a>
            </c:if>
            <c:if test="${mode eq 'artifact'}">
                <a href="${link}" class="UI PageAction RSS"><span>${caption}</span></a>
            </c:if>
			<c:if test="${mode eq 'context'}">
				<div class="EA-left-panel">
					<a href="${link}" class="UI PageAction RSS" title="${linkText}"><span>${linkText}</span></a>
				</div>	
            </c:if>
        </c:when>
        <c:otherwise>
            <a class="UI PageAction RSS" href="${link}" title="${linkText}"><span>${linkText}</span></a>
        </c:otherwise>
    </c:choose>
</c:if>
