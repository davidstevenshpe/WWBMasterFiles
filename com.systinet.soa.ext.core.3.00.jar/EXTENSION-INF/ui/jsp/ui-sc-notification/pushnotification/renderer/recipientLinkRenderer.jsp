<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<%--@elvariable id="id" type="java.lang.String"--%>
<%--@elvariable id="params" type="java.util.Map"--%>

<c:set var="type" value="${params['type']}"/>

<c:if test="${type eq 'principal'}">
    <syswf:component prefix="${id}" name="/core/impl/util/principalLinkRenderer" wrap="false">
        <syswf:param name="principal" value="${params['principal']}"/>
        <syswf:param name="showIcon" value="true"/>
    </syswf:component>
</c:if>

<c:if test="${type eq 'artifact'}">
    <syswf:component prefix="${id}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
        <syswf:param name="uuid" value="${params['uuid']}"/>
        <syswf:param name="caption" value="${params['name']}"/>
    </syswf:component>
</c:if>

<c:if test="${type eq 'email'}">
    <c:set var="email" value="${params['name']}"/>
    <a href="mailto:${email}" class="UI Icon Email">
        <span><c:out value="${email}"/></span>
    </a>
</c:if>


<c:if test="${type eq 'uknown'}">
    <c:out value="${params['name']}"/>
</c:if>
