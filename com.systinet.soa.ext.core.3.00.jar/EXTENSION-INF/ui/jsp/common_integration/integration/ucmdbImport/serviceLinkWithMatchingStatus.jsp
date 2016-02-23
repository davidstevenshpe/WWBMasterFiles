<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>

<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="matchingStatus" type="int"--%>
<%--@elvariable id="uuid" type="java.lang.String"--%>
<%--@elvariable id="name" type="java.lang.String"--%>

<span ${matchingStatus == 2 ? 'class="UI Icon Warning"' : ''}>
    <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="discoveredServiceLink" wrap="false">
        <syswf:param name="uuid" value="${uuid}"/>
        <syswf:param name="caption" value="${name}"/>
    </syswf:component>
</span>

