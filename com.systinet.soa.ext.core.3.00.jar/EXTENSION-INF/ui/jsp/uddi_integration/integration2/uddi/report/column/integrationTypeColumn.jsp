<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n"/>
<syswf:out value="${label}" context="HtmlBody"/>