<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:choose>
    <c:when test="${not empty caption}">
        <c:set var="detailId_Label" value="${caption}"/>
    </c:when>
    <c:otherwise>
        <fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="pr_Messages" />
        <fmt:message key="policyreport.view.table.column.detailId.label" var="detailId_Label" bundle="${pr_Messages}" />
    </c:otherwise>
</c:choose>


<a class="UI Icon Artifact Documentation" href="#" onclick="Ext4.create('EA.governance.PolicyReportMenu', {uuid:'${id}',reportUuid:'${uuid}',detailId:'${detailId}'}).showBy(this);">${detailId_Label}</a>
