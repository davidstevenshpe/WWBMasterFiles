<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:component prefix="${prefix}taskLink" name="/core/impl/util/artifactLinkRenderer" wrap="false">
    <syswf:param name="caption" value="${caption}"/>
    <syswf:param name="uuid" value="${artifactUuid}"/>
    <syswf:param name="artifactTabId" value="lifecycle"/>
</syswf:component>
