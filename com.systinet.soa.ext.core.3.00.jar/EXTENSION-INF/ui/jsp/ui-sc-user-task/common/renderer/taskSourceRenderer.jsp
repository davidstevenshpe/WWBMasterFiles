<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="caption" type="java.lang.String"--%>
<%--@elvariable id="sourceTypeId" type="java.lang.String"--%>
<%--@elvariable id="iconMap" type="java.util.Map"--%>

<span class="UI Icon ${iconMap[sourceTypeId]}"><c:out value="${caption}"/></span>
