<%--
~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="canDisplayButton" type="boolean"--%>
<c:if test="${canDisplayButton}">
    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>
    <fmt:message key="tasksLinkLabel" bundle="${messages}" var="browseLinkLabel"/>
    <li>
    	<syswf:control id="browseTasks" caption="${browseLinkLabel}" mode="anchor" targetTask="/admin/task/browseFromMenu" targetDepth="0"/>
    </li>
</c:if>
