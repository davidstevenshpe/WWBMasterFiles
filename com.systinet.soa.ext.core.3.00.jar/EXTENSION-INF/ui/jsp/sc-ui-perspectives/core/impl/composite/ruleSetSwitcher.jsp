<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.composite.compositeMessages" var="compositeMessages"/>

<fmt:message var="impactLinkCaption" key="impactLinkCaption" bundle="${compositeMessages}"/>
<fmt:message var="dependenciesLinkCaption" key="dependenciesLinkCaption" bundle="${compositeMessages}"/>
<fmt:message var="governanceTreeLinkCaption" key="governanceTreeLinkCaption" bundle="${compositeMessages}"/>

<c:choose>

    <c:when test="${this.usedRuleSets.governanceTreeMode}">
    	<div class="EA-right-panel">
        <syswf:control id="switchToDefault" mode="anchor" action="switchToDefault" caption="${dependenciesLinkCaption}" >
            <syswf:attribute name="class" value="UI PageAction DependencyReport"/>
        </syswf:control>
        </div>
        <div class="EA-right-panel">
        <syswf:control id="switchToInverse" mode="anchor" action="switchToInverse" caption="${impactLinkCaption}" >
            <syswf:attribute name="class" value="UI PageAction ImpactReport"/>
        </syswf:control>
        </div>
    </c:when>
    
    <c:otherwise>
        <c:choose>
            <c:when test="${fn:contains(this.usedRuleSets.parentPathRuleSet, 'Impact')}">
                <c:set var="caption" value="${impactLinkCaption}"/>
                <c:set var="style" value="UI PageAction ImpactReport"/>
            </c:when>
            <c:otherwise>
                <c:set var="caption" value="${dependenciesLinkCaption}"/>
                <c:set var="style" value="UI PageAction DependencyReport"/>
            </c:otherwise>
        </c:choose>
        <div class="EA-right-panel">
        <syswf:control id="switchRuleSets" mode="anchor" action="switchRuleSets" caption="${caption}" >
            <syswf:attribute name="class" value="${style}"/>
        </syswf:control>
        </div>
        <c:if test="${this.governanceTreeViewEnabled}">
        	<div class="EA-right-panel">
            <syswf:control id="governanceTreeMode" mode="anchor" action="switchToGovernanceTreeMode" caption="${governanceTreeLinkCaption}" >
                <syswf:attribute name="class" value="UI PageAction Merge"/>
            </syswf:control>
            </div>
        </c:if>
    
    </c:otherwise>
</c:choose>

