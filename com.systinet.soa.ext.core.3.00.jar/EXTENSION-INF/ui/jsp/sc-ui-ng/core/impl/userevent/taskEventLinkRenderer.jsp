<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="eventBean" type="com.hp.systinet.userevent.UserEvent"--%>
<%--@elvariable id="viewId" type="java.lang.String"--%>
<%--@elvariable id="styleClass" type="java.lang.String"--%>
<syswf:component prefix="eventLink"
                 name="/core/impl/util/artifactLinkRenderer" wrap="false">
    <syswf:param name="uuid" value="${eventBean.linkParam1}"/>
    <syswf:param name="caption" value="${fn:escapeXml(eventBean.message)}"/>
    <syswf:param name="class" value="${styleClass}"/>
</syswf:component>