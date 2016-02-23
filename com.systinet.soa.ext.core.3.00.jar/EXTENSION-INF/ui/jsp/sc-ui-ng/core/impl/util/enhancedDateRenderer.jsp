<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="dateValue" type="java.util.Date"--%>
<%--@elvariable id="styleClass" type="java.lang.String"--%>
<c:set var="shortDate"><syswf:value value="${dateValue}" dataType="shortDateTime" wrapper=""/></c:set>
<c:set var="longDate"><syswf:value value="${dateValue}" dataType="dateTime" wrapper=""/></c:set>
<span class="${styleClass}" title="${longDate}">${shortDate}</span>