<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>

<%--@elvariable id="savedSearchDefinition" type="com.hp.systinet.sc.search.SavedSearchDefinition"--%>
<%--@elvariable id="criteriaCustomizationId" type="java.lang.String"--%>

<syswf:component name="/core/impl/search/customizableSearchCriteriaDescription" prefix="search">
    <syswf:param name="savedSearchDefinition" value="${savedSearchDefinition}" />
    <syswf:param name="customizationId" value="${criteriaCustomizationId}" />
</syswf:component>