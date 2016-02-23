<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="inProgressReport" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.ReportArtifact"--%>
<%--@elvariable id="eventBean" type="com.hp.systinet.userevent.UserEvent"--%>
<%--@elvariable id="onCompleteProgress" type="java.lang.Runnable"--%>
<c:if test="${empty inProgressReport}">
    <syswf:component prefix="eventDate" name="/core/impl/util/enhancedDateRenderer" wrap="false">
        <syswf:param name="dateValue" value="${eventBean.eventDate}"/>
    </syswf:component>
</c:if>
<c:if test="${not empty inProgressReport}">
    <syswf:component prefix="progressBar" name="/core/report/reportProgress">
        <syswf:param name="reportArtifact" value="${inProgressReport}"/>
        <syswf:param name="onCompleteCallback" value="${onCompleteProgress}"/>
    </syswf:component>
</c:if>