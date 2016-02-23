<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>

<%--@elvariable id="uuid" type="com.hp.systinet.repository.sdm.properties.Uuid"--%>

<div class="UI SystemMessage Info">
    <div class="MessageContainer">
        <div class="Text">
            <fmt:message key="artifactLocked.message" bundle="${messages}">
                <fmt:param>
                    <syswf:component prefix="link" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                        <syswf:param name="uuid" value="${uuid}"/>
                        <syswf:param name="artifactTabId" value="lifecycle"/>
                        <syswf:param name="caption">
                            <fmt:message key="artifactLocked.linkCaption" bundle="${messages}"/>
                        </syswf:param>
                    </syswf:component>
                </fmt:param>
            </fmt:message>
        </div>
        <div class="x-clear"></div>
    </div>
</div>
