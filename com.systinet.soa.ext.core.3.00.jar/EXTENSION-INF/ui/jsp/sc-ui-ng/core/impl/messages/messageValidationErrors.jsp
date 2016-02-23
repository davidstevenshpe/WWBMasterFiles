<%--

Parameters

- text (required)

--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.systinet.platform.ui.util.UtilMessages" var="util_Messages"/>

<div class="UI SystemMessage ${class}">
    <div class="MessageContainer">
        <strong><fmt:message key="CAPTION_UIMessageErrorLabel" bundle="${util_Messages}"/>:</strong>
        <c:out value="${text}" escapeXml="false"/>
        <c:if test="${not empty messages}">
        <ul class="UI Bullets">
        <c:forEach items="${messages}" var="message">
            <li class="New"><c:out value="${message}"/></li>
        </c:forEach>
        </ul>        
        </c:if>
    </div>
</div>