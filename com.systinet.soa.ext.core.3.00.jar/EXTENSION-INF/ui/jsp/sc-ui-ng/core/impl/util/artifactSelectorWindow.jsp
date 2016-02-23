<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="uimessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>

<syswf:component name="/core/search/searchCriteria" prefix="selectCriteria">
    <syswf:param name="customizationId" value="${selectorCustomizationIdNew}.criteria"/>
    <syswf:param name="sharedDataSourceWrapper" value="${sharedDataSourceWrapper}" />
    <syswf:param name="datasource" value="${datasource}"/>
    <syswf:param name="advancedOptionsExpanded" value="true" />
    <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
    <syswf:param name="availaibleApplicableTo" value="${availaibleApplicableTo}"/>
    <syswf:param name="resultTableId" value="${resultTableId}"/>
    <syswf:param name="selectFunctionName" value="${selectFunctionName}" />
</syswf:component>

<c:if test="${not sharedDataSourceWrapper.dataSource.runnable}">
<div class="UI SystemMessage Info">
    <div class="MessageContainer">
        <div class="Text"><strong><fmt:message bundle="${uimessages}" key="MESSAGE_INFO"/>:</strong> <fmt:message bundle="${relationshipmessages}" key="ENTER_SEARCH_CRITERIA"/></div>
        <div class="x-clear"></div>
    </div>
</div>
</c:if>

<syswf:component name="/core/table" prefix="selectResults">
    <syswf:param name="customizationId" value="${selectorCustomizationIdNew}.results"/>
    <syswf:param name="datasource" value="${sharedDataSourceWrapper.dataSource}"/>
    <syswf:param name="selectionBag" value="${selectionBag}"/>
    <syswf:param name="tableId" value="${resultTableId}"/>
    <syswf:param name="parentWindowId" value="${popupWindowId}"/>
</syswf:component>
