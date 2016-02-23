<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%--Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.rating.ratingmessages" var="rating_Message"/>

<%-- Get Message --%>
<fmt:message key="rating.tableHint" var="hint" bundle="${rating_Message}">
    <fmt:param value="${ratingFormatted}" />
    <fmt:param value="${total}" />
</fmt:message>   

<div id="${prefix}_minirating-ct" class="minirating-ct">
    <c:forEach begin="1" end="5" var="i">
        <div class="ui-stars-star ui-stars-star-disabled <c:if test="${i <= (rating + 0.5)}">ui-stars-star-on</c:if>">
            <a title="${hint}">${i}</a>
        </div>
    </c:forEach>    
</div>