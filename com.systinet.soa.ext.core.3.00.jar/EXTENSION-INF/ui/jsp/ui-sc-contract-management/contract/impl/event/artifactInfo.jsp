<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<syswf:component prefix="l" name="/core/impl/util/artifactLinkRenderer" wrap="false">
    <syswf:param name="uuid" value="${info.uuid}"/>
    <syswf:param name="caption" value="${info.name}"/>
    <syswf:param name="sdmName" value="${info.sdmName}"/>
    <syswf:param name="showIcon" value="true"/>
    <syswf:param name="artifactTabId" value="contracts"/>
    <syswf:param name="mode" value="table"/>
</syswf:component>