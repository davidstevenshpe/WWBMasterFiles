<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="canDisplayButton" type="boolean"--%>
<c:if test="${canDisplayButton}">
    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

    <syswf:control mode="script" action="deleteTaskAction" caption="${prefix}deleteTask">
        <syswf:param name="selectionBag" value="${selectionBag}"/>
    </syswf:control>
    <syswf:component name="/core/impl/util/dialog" prefix="deleteTaskConfirmDialog">
        <syswf:param name="handler" value="${prefix}deleteTask"/>
        <%--@elvariable id="confirmDialogTitle" type="java.lang.String"--%>
        <syswf:param name="heading"><fmt:message key="actionDeleteTask_confirmDialogHeading"
                                                 bundle="${messages}"/></syswf:param>
        <%--@elvariable id="confirmDialogMessage" type="java.lang.String"--%>
        <syswf:param name="content"><fmt:message key="actionDeleteTask_confirmDialogText"
                                                 bundle="${messages}"/></syswf:param>
        <syswf:param name="noUndo" value="false"/>
    </syswf:component>
</c:if>