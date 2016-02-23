<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<c:choose>
<c:when test="${not empty statusGetter}">
    <syswf:component name="/core/impl/widgets/progressBar" prefix="inReport" wrap="false">
       <syswf:param name="statusGetter" value="${statusGetter}"/>
       <syswf:param name="isRunning" value="${isRunning}"/>
    </syswf:component>
</c:when>
<c:when test="${failed}">
    <div class="UI ProgressBar">
        <fmt:message bundle="${messages}" key="reportstatus.reportTerminated" />
    </div>
</c:when>
</c:choose>