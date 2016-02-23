<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<syswf:component name="/core/search/suggestedSearch" prefix="suggestedSearch" >
    <syswf:param name="customizationId" value="shared.relatedArtifact.suggestedSearch"/>
    <syswf:param name="suggestDatasource" value="${suggestDatasource}" />
    <syswf:param name="value" value="${webCondition}"/>
    <syswf:param name="cssOfInput" value="${cssOfInput}" />    
    <syswf:param name="combo" value="single" />
    <syswf:param name="styleOfInput" value="${style}" />
    <syswf:param name="classOfInput" value="${class}" />
    <syswf:param name="inputId" value="${inputId}" />
    <syswf:param name="allowAllAvailableArtifactTypes" value="${allowAllAvailableArtifactTypes}"/>
</syswf:component>