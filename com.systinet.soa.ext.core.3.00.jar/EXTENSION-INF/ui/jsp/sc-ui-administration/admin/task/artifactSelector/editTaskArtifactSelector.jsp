<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="taskType" type="java.lang.String"--%>
<%--@elvariable id="editedSelectorValue" type="com.hp.systinet.sc.tool.ArtifactSelector"--%>
<%--@elvariable id="editorBean" type="com.hp.systinet.sc.ui.admin.task.artifactSelector.SelectorEditorBean"--%>


<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages" />

<c:if test="${taskType == 'artifactSync' or taskType == 'customTask'}">
    <c:choose>
        <c:when test="${taskType == 'artifactSync'}">
            <c:set var="supportsUnspecifiedSelector" value="false" />
            <c:set var="syncableTypesOnly" value="true" />
            <fmt:message key="editTask.syncTaskSelectorLabel" var="selectorLabel" bundle="${messages}" />
        </c:when>
        <c:when test="${taskType == 'customTask'}">
            <c:set var="supportsUnspecifiedSelector" value="true" />
            <c:set var="syncableTypesOnly" value="false" />
            <fmt:message key="editTask.customTaskSelectorLabel" var="selectorLabel" bundle="${messages}" />
        </c:when>
    </c:choose>

    <table class="UI Table Properties">
    <col class="LabelCol">
    <col>
        <tbody>
            <tr>
                <td><label class="UI Label Inline">${selectorLabel}:</label>
                </td>
                <td>
                    <syswf:component prefix="editor" name="/admin/task/artifactSelector/selectorEditor">
                        <syswf:param name="editedSelectorValue" value="${editedSelectorValue}"/>
                        <syswf:param name="supportsUnspecifiedSelector" value="${supportsUnspecifiedSelector}"/>
                        <syswf:param name="syncableTypesOnly" value="${syncableTypesOnly}"/>
                        <syswf:param name="editorBean" value="${editorBean}"/>
                    </syswf:component>
                </td>
            </tr>
        </tbody>
    </table>
</c:if>
