<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="taskBean" type="com.hp.systinet.lifecycle.ui.admin.visualization.TaskBean"--%>
<%--@elvariable id="policySelector" type="com.hp.systinet.sc.ui.search.selector.ArtifactSelectorListener"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<syswf:control id="actionRemoveTaskPolicy" mode="script" caption="actionRemoveTaskPolicy" action="removePolicy" affects="." loadingMask="true" />

<%-- Policy Selector --%>
<syswf:component name="/core/search/selector/artifactSelector" prefix="policySelector">
    <syswf:param name="jsOpenFunction" value="policySelector_open" />
    <syswf:param name="windowTitle"><fmt:message key="taskDialog.policySelectorWindowTitle" bundle="${bundle}"/></syswf:param>
    <syswf:param name="selectorListener" value="${policySelector}" />
    <syswf:param name="artifactType" value="hpsoaTechnicalPolicyArtifact" />
    <syswf:param name="dqlCondition" value="${policyDqlCondition}"/>
    <syswf:param name="showDataBeforeSearch" value="true" />
    <syswf:param name="selectorCustomizationId" value="shared.technicalPolicySelector"/>
    <syswf:param name="availaibleApplicableTo" value="${availaibleApplicableTo}"/>
</syswf:component>

<c:choose>
    <c:when test="${not empty taskBean.policyUuid}">
        <%-- Policy Name --%>
        <syswf:component prefix="policyLink" name="/core/impl/util/artifactLinkRenderer" wrap="false">
            <syswf:param name="uuid" value="${taskBean.policyUuid}"/>
            <syswf:param name="caption" value="${taskBean.policyName}"/>
            <syswf:param name="class" value="IconAlign"/>       
        </syswf:component>
        &nbsp;(
        <%-- Change Policy Link --%>
        <a id ="changePolicyLink" href="javascript:void(0)"><fmt:message key="taskDialog.change" bundle="${bundle}"/></a>,
        <%-- Remove Policy Link --%>
        <a id="removePolicyLink" href="javascript:void(0)"><fmt:message key="taskDialog.remove" bundle="${bundle}"/></a>
        )
        <script type="text/javascript">
//<![CDATA[

            attachOn('changePolicyLink','click',function() { policySelector_open(); });
            attachOn('removePolicyLink','click',function() { actionRemoveTaskPolicy();  });
        
//]]>
</script>
    </c:when>
    <c:otherwise>
        <%-- Select Policy Button --%>
        <a id ="addPolicyLink" href="javascript:void(0)" class="btn btn-gray"><fmt:message key="taskDialog.select" bundle="${bundle}"/></a>
        <script type="text/javascript">
//<![CDATA[

            attachOn('addPolicyLink','click',function() { policySelector_open(); });
        
//]]>
</script>
    </c:otherwise>
</c:choose>
