<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.TaskArtifact"--%>
<%--@elvariable id="isTaskRunning" type="boolean"--%>
<c:choose>
    <c:when test="${isTaskRunning}">
        <syswf:component name="/admin/task/bulk/actionStopTask" prefix="stopTask" wrap="false">
            <syswf:param name="artifact" value="${artifact}"/>
        </syswf:component>
    </c:when>
    <c:otherwise>
        <syswf:component name="/admin/task/bulk/actionRunTask" prefix="runTask" wrap="false">
            <syswf:param name="artifact" value="${artifact}"/>
        </syswf:component>
    </c:otherwise>
</c:choose>