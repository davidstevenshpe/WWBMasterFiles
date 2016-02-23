<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="domains" type="java.util.List"--%>
<%--@elvariable id="domainIdNamePair" type="com.hp.systinet.lang.Pair"--%>
<c:forEach items="${domains}"
    var="domainIdNamePair" varStatus="status"><c:if test="${!status.first}">,</c:if>
    <c:out value="${domainIdNamePair.second}"/></c:forEach>
