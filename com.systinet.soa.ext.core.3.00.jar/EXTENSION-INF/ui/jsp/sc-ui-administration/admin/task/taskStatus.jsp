<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <%--@elvariable id="taskStatus" type="com.hp.systinet.sc.ui.admin.task.TaskStatus.TaskStatusBean"--%>
    <c:when test="${not empty taskStatus and not empty taskStatus.reportArtifact}">
        <syswf:component name="/core/report/reportProgress" prefix="taskStatusReportProgress">
            <syswf:param name="reportArtifact" value="${taskStatus.reportArtifact}"/>
            <syswf:param name="onCompleteCallback" value="${taskStatus.onCompleteCallback}"/>
        </syswf:component>
    </c:when>
    <c:when test="${not empty taskStatus and empty taskStatus.reportArtifact and not empty taskStatus.statusMessage}">
        <c:out value="${taskStatus.statusMessage}"/>
    </c:when>
    <%--<c:otherwise>
        <c:out value="message or report not set - should not happen"/>
    </c:otherwise>--%>
</c:choose>
