<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>

<c:choose>
    <c:when test="${empty contentCustomizationId}">
        <c:set var="componentName" value="/core/composite/compositeTreeDisplay"/>
    </c:when>
    <c:otherwise>
        <c:set var="componentName" value="/core/composite/customizableCompositeTreeDisplay"/>
    </c:otherwise>
</c:choose>
<syswf:component name="${componentName}" prefix="w">
    <c:if test="${not empty contentCustomizationId}">
        <syswf:param name="customizationId" value="${contentCustomizationId}"/>
    </c:if>

    <syswf:param name="traversalRuleSet" value="aggregation"/>
    <syswf:param name="selectionBag" value="${selectionBag}"/>
    <syswf:param name="treeRowAcceptor" value="${treeRowAcceptor}"/>
    <syswf:param name="rootArtifactUuid">${owner._uuid}</syswf:param>

    <syswf:param name="removeDuplicateSubTrees" value="${false}"/>
    <syswf:param name="initialExpansionDepth" value="1"/>
    <syswf:param name="displayHeadings" value="true"/>
</syswf:component>
