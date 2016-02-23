<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAssociated}">
    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>
    <fmt:message var="msgLinkLabel" key="processAction.viewUsage.label" bundle="${bundle}"/>
        
    <syswf:control mode="script" caption="${prefix}searchUsage" targetTask="/common/advancedSearch">
        <syswf:param name="advancedOptionsExpanded" value="true"/>
        <syswf:param name="search.governanceProcess" value="${processUuid}"/>
    </syswf:control>
    
    <a id="${prefix}viewUsageLink" href="#" class="context-button View" title="${msgLinkLabel}"></a>
    
    <script type="text/javascript">
//<![CDATA[

        attachOn('${prefix}viewUsageLink','click',function() { ${prefix}searchUsage(); });
//]]>
</script>
</c:if>

