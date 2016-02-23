<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="L10nSCAdministration"/>

<c:choose>
    <%--@elvariable id="currentViewType" type="java.lang.String"--%>
    <c:when test="${currentViewType eq 'table'}">
        <fmt:message key="browseTaskSelectorPanel_showGrid" var="showGridMessage" bundle="${L10nSCAdministration}"/>
        <syswf:control targetTask="/admin/task/browse" targetDepth="${currentDepth}" mode="anchor" caption="">
			<syswf:attribute name="title">${showGridMessage}</syswf:attribute>
			<syswf:attribute name="class">context-button BlockView</syswf:attribute>
         </syswf:control>
    </c:when>
    <c:otherwise>
         <fmt:message key="browseTaskSelectorPanel_showTaskList" var="showTaskListMessage" bundle="${L10nSCAdministration}"/>
         <syswf:control targetTask="/admin/task/browse" targetDepth="${currentDepth}" mode="anchor" caption="">
             <syswf:param name="viewType" value="table"/>
             <syswf:attribute name="title">${showTaskListMessage}</syswf:attribute>
             <syswf:attribute name="class">context-button ListView</syswf:attribute>
         </syswf:control>
    </c:otherwise>
</c:choose>
