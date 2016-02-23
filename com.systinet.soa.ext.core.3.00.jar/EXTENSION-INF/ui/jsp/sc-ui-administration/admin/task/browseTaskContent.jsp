<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


    <c:choose>
        <%--@elvariable id="viewType" type="java.lang.String"--%>
        <c:when test="${viewType eq 'table'}">
            <syswf:component name="/admin/task/browseTaskTable" prefix="browseTaskTable"/>
        </c:when>
        <c:otherwise>
            <syswf:component name="/admin/task/browseTaskCalendar" prefix="browseTaskCalendar" wrap="true" >
                <%--@elvariable id="fromLeftMenu" type="java.lang.Boolean"--%>
                <syswf:param name="fromLeftMenu" value="${fromLeftMenu}"/>
            </syswf:component>
        </c:otherwise>
    </c:choose>
