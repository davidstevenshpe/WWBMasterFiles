<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>    

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n"/>

<syswf:block className="">
    <c:if test="${not empty missingTaxonomiesRequestResponse}">
        <div class="Title">
            <h3><fmt:message key="uddi.report.missingTaxonomies.missingTaxonomies" bundle="${l10n}"/></h3>
        </div>
                                                
        <syswf:component name="/core/table" prefix="missingTaxonomy" >
			<syswf:param name="customizationId" value="integration.uddi.report.properties.missingTaxonomyReport"/>
			<syswf:param name="datasource" value="${taxonomyDataSource}"/>          
		</syswf:component>
    </c:if>
</syswf:block>

<c:choose>
<c:when test="${missingTaxonomiesRequestResponse.type eq 'Export'}">
    <c:set var="okCaption" value="Export"/>
</c:when>
<c:otherwise>
    <c:set var="okCaption" value="Import"/>    
</c:otherwise>
</c:choose>
            
<syswf:block className="UI Block Common Green">
    <div class="UI Form Controls">
        <syswf:control action="accept" mode="postAnchor" caption="${okCaption}" id="${prefix}Ok" wrapper="span">
            <syswf:attribute name="class" value="btn btn-primary"/>
        </syswf:control>
        <syswf:control action="cancel" mode="postAnchor" caption="Cancel" id="${prefix}Cancel" wrapper="span"/>
    </div>
</syswf:block>