<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="selectReadAccess.title" var="addReadAccessTitle" bundle="${messages}"/>
<fmt:message key="selectWriteAccess.title" var="addWriteAccessTitle" bundle="${messages}"/>

<syswf:control mode="script" action="cancel" caption="${prefix}cancel" />

<c:choose>
    <c:when test="${actionName eq 'addRead'}">
        <c:set var="addAccessTitle" value="${addReadAccessTitle}"></c:set>
    </c:when>
    <c:otherwise>
        <c:set var="addAccessTitle" value="${addWriteAccessTitle}"></c:set>            
    </c:otherwise>
</c:choose>

<syswf:component name="/core/principal/selector" prefix="addAccessPricipalSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}openSelector" />
    <syswf:param name="windowTitle" value="${addAccessTitle}"/>
    <syswf:param name="holder" value="${addAccessBean.principalHolder}" />
    <syswf:param name="winCancelAction" value="${prefix}cancel" />        
</syswf:component>

<c:if test="${not empty addAccessBean.selectedStages}">
    <script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        ${prefix}openSelector();
    })
    
//]]>
</script>
</c:if>

<jsp:include page="storeStagesInclude.jsp" />
