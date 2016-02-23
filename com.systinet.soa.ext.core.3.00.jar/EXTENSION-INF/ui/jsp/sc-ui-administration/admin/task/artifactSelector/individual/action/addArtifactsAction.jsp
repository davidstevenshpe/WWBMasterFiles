<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

<%--@elvariable id="controlName" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="availableArtifactTypes" type="java.util.List"--%>
<%--@elvariable id="selectionBag" type="ccom.hp.systinet.sc.ui.impl.table.SelectionBag"--%>

<c:set var="addArtifactsFn" value="${prefix}addArtifacts"/> <%-- javascript function for sending the changes to server--%>

<syswf:component name="/core/window" prefix="selectArtifact">
    <syswf:param name="winTitle"><fmt:message key="artifactSelector.individual.addDialogTitle"
                                              bundle="${messages}"/></syswf:param>
    <syswf:param name="winComponent" value="/core/impl/util/artifactSelectorWindow"/>
    <syswf:param name="winOpenFunctionName" value="${controlName}" />
    <syswf:param name="winOkAction" value="${addArtifactsFn}" />
    <syswf:param name="winResizable" value="${true}" />
    <syswf:param name="winWidth" value="700" />
    <syswf:param name="winButtonAlign" value="right"/>

    <syswf:param name="selectorCustomizationId" value="admin.task.artifactSelector.individual.add" />
    <syswf:param name="artifactTypes" value="${availableArtifactTypes}"/>
    <syswf:param name="visibleTypesOnly" value="${false}"/>
    <syswf:param name="selectionBag" value="${selectionBag}"/>
</syswf:component>

<syswf:control mode="script" action="addArtifacts" caption="${addArtifactsFn}">
	<syswf:param name="selectionBag" value="${selectionBag}"/>
</syswf:control>

