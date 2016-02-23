<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.contract.contractmessages" var="messages"/>
<fmt:message key="artifact.contracts.results" var="results" bundle="${messages}"/>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><c:out value="${results}"></c:out></h3>
    </div>
    <div class="Content">
        <syswf:component name="/core/table" prefix="${viewId}.contract.contracts" wrap="false">
            <syswf:param name="customizationId" value="${viewId}.contract.contracts"/>
        </syswf:component>
    </div>
</syswf:block>