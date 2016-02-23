<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="controlName" type="java.lang.String"--%>
<%--@elvariable id="policyDqlCondition" type="java.lang.String"--%>

<fmt:setBundle basename="com.hp.systinet.policy.ui.UiPolicyL10n" var="bundle"/>

<syswf:control mode="script" action="selectTechnicalPolicies" caption="${prefix}selectTechnicalPolicy">
	<syswf:param name="tpSelectionBag" value="${tpSelectionBag}"/>
</syswf:control>

<%-- Policy Selector --%>
<syswf:component name="/core/window" prefix="policySelector">
    <syswf:param name="winTitle"><fmt:message key="formValidation.addPolicy.dialogTitle" bundle="${bundle}"/></syswf:param>
    <syswf:param name="winComponent" value="/core/impl/util/artifactSelectorWindow"/>
    <syswf:param name="winOpenFunctionName" value="${controlName}"/>
    <syswf:param name="selectFunctionName" value="${prefix}_selectFunction"/>
    <syswf:param name="resultTableId" value="${prefix}selectPolicy_asTableId"/>
    <syswf:param name="popupWindowId" value="${prefix}selectPolicy_asWindowId"/>
    <syswf:param name="artifactType" value="hpsoaTechnicalPolicyArtifact"/>
    <syswf:param name="dqlCondition" value="${policyDqlCondition}" />
    <syswf:param name="availaibleApplicableTo" value="${availaibleApplicableTo}" />
    <syswf:param name="selectionBag" value="${technicalPolicySelectionBag}" />
    <syswf:param name="selectorCustomizationId" value="shared.artifactSelector.policySelector" />
    <syswf:param name="showDataBeforeSearch" value="true" />
    <syswf:param name="overrideselectionModel" value="multiple" />
    <syswf:param name="winOkAction" value="${prefix}selectTechnicalPolicy" />
	<syswf:param name="winWidth" value="850" />
	<syswf:param name="winResizable" value="true" />
	<syswf:param name="winButtonAlign" value="right" />
</syswf:component>