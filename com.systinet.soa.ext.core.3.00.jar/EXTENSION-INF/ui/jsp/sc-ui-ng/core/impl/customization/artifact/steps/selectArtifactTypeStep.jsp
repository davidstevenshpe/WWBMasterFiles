<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<c:choose>
    <c:when test="${wizardController.wizardContext.generate}">
        <fmt:message var="title" key="addArtifactType.title" bundle="${bundle}"/>
        <fmt:message var="desc" key="addArtifactType.selectArtifactTypeStep.desc" bundle="${bundle}"/>
    </c:when>
    <c:otherwise>
        <fmt:message var="title" key="editArtifactType.title" bundle="${bundle}"/>
        <fmt:message var="desc" key="editArtifactType.selectArtifactTypeStep.desc" bundle="${bundle}"/>    
    </c:otherwise>
</c:choose>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
</syswf:component>

<div class="UI Text Description">${desc}</div>

<%-- wizard context implements SelectOne interface for artifact selection --%>
<syswf:block className="UI Block Common">
    <syswf:component name="/core/util/artifactTree" prefix="artifactTree">
        <syswf:param name="singleHolder" value="${wizardController.wizardContext}"/>
        <syswf:param name="includedArtifacts" value="${include}"/>
        <syswf:param name="excludedArtifacts" value="${exclude}"/>
        <syswf:param name="showLoadingMaskOnClick" value="true"/>
        <syswf:param name="autoHeight" value="true"/>
        
    </syswf:component>
</syswf:block>