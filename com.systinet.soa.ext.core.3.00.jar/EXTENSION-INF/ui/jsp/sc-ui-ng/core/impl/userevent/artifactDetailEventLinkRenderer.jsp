<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="eventBean" type="com.hp.systinet.userevent.UserEvent"--%>
<%--@elvariable id="targetUuid" type="java.lang.String"--%>
<syswf:component prefix="eventLink"
                 name="/core/impl/util/artifactLinkRenderer" wrap="false">
    <syswf:param name="uuid" value="${targetUuid}"/>
    <syswf:param name="caption" value="${eventBean.message}"/>
    <%--@elvariable id="tabId" type="java.lang.String"--%>
    <syswf:param name="artifactTabId" value="${tabId}"/>
    <%--@elvariable id="styleClass" type="java.lang.String"--%>    
    <syswf:param name="class" value="${styleClass}"/>
</syswf:component>
