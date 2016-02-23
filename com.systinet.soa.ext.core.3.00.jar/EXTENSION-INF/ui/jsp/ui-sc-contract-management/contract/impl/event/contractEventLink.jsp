<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="eventBean" type="com.hp.systinet.userevent.UserEvent"--%>
<%--@elvariable id="styleClass" type="java.lang.String"--%>

<syswf:component prefix="l" name="/core/impl/util/artifactLinkRenderer" wrap="false">
    <syswf:param name="uuid" value="${eventBean.linkParam1}"/>
    <syswf:param name="sdmName" value="contractArtifact"/>
    <syswf:param name="caption" value="${eventBean.message}"/>
    <syswf:param name="class" value="${styleClass}"/>
</syswf:component>
