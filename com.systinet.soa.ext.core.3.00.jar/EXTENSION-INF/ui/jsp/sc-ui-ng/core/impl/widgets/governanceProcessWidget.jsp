<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message var="noGovernanceProcessAssigned" key="noGovernanceProcessAssigned" bundle="${widgetMessages}"/>

<c:if test="${mode eq 'table'}">
    <c:choose>
        <c:when test="${not empty governanceProcessName}">
            <c:out value="${governanceProcessName}"/>
        </c:when>
        <c:otherwise>
            ${noGovernanceProcessAssigned}
        </c:otherwise>       
    </c:choose>    
</c:if>