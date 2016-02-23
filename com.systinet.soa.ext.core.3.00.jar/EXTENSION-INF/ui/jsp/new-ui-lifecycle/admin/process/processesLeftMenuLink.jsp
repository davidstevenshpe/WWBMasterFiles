<%--
~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="canDisplayComponent" type="boolean"--%>
<c:if test="${canDisplayComponent}">
    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
    <fmt:message key="processesLinkLabel" bundle="${messages}" var="browseLinkLabel"/>
    <li>
    	<syswf:control id="browseProcesses" caption="${browseLinkLabel}" mode="anchor"
                   targetTask="/admin/lifecycle/process/processBrowser" targetDepth="0"/>
	</li>                   
</c:if>
