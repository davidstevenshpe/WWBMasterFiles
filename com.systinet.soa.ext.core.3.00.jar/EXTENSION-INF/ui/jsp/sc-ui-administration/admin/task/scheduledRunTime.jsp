<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="scheduledText" type="java.lang.String"--%>
<%--@elvariable id="scheduledHint" type="java.lang.String"--%>
<span class="IconAlign">
<c:if test="${not empty scheduledText}">
    <c:if test="${not empty scheduledHint}">
        <label title="${scheduledHint}">
    </c:if>
    <c:out value="${scheduledText}"/>
    <c:if test="${not empty scheduledHint}">
        </label>
    </c:if>
</c:if>
</span>