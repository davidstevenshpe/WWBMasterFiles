<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="entry" type="com.hp.systinet.lifecycle.ui.catalog.visualization.TasksSection.TasksSectionEntry"--%>
<%--@elvariable id="completionAttempted" type="java.lang.Boolean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>

<c:set var="entryId" value="${prefix}"/>
<c:set var="commentAnchorId" value="${entryId}_commentAnchor"/>
<c:set var="commentBodyId" value="${entryId}_commentBody"/>
<table class="UI Table Properties">
    <col class="FormSelectCol"/>
    <col class="LongLabelCol"/>
    <col/>
    <col class="ControlCol"/>
    <tr>
        <td>
            <c:if test="${not empty entry.description or not empty entry.policyUuid or entry.validationFailed}">
                <syswf:component prefix="desc" name="/newUi/lc/common/widget/expandComment" wrap="false">
                    <syswf:param name="anchorId" value="${commentAnchorId}"/>
                    <syswf:param name="bodyId" value="${commentBodyId}"/>
                </syswf:component>
            </c:if>
        </td>
        <td class="LifecycleTaskAlignMiddle">
            <syswf:selectOne name="${entryId}_checkbox" id="${entryId}_checkbox"
                             value="${entry}"
                             property="completed"
                             optionValues="true"
                             optionCaptions=""
                             mode="checkbox"
                             dataType="boolean">
                <syswf:attribute name="class" value="UI Checkbox Inline"/>
                <c:if test="${not entry.checkboxEnabled}">
                    <syswf:attribute name="disabled" value="disabled"/>
                </c:if>
            </syswf:selectOne>
            <label for="${entryId}_checkbox_0" class="UI Label Inline"><c:out
                    value="${entry.name}"/></label>
            <c:set var="submitToggleFn" value="${prefix}_submitToggleFn"/> <%-- calls toggle action on server --%>
            <syswf:control mode="script" action="toggle" caption="${submitToggleFn}" affects="."/>
            <c:set var="toggleFn" value="${prefix}_toggleFn"/> <%-- disables check box and calls submitToggleFn --%>
            <c:set var="cancelUncheckFn" value="${prefix}_cancelUncheckFn"/> <%-- cancels uncheck --%>

            <%-- opens uncheck confirmation dialog--%>
            <c:set var="openUncheckDialogFn" value="${prefix}_openUncheckDialogFn"/>
            <syswf:component name="/core/util/confirmPopUp" prefix="uncheckDialog">
                <syswf:param name="winOpenFunctionName" value="${openUncheckDialogFn}" />
                <syswf:param name="winOkAction" value="${toggleFn}" />
                <syswf:param name="winCancelAction" value="${cancelUncheckFn}"/>
                <syswf:param name="confirmMessage"><fmt:message key="task.confirmUncheckText"
                                                                bundle="${messages}"/></syswf:param>
                <syswf:param name="title"><fmt:message key="task.confirmUncheckTitle"
                                                       bundle="${messages}"/></syswf:param>
            </syswf:component>

            <script type="text/javascript">
//<![CDATA[

                function ${toggleFn}() {
                    Ext.get('${entryId}_checkbox_0').dom.disabled = 'disabled';
                    ${submitToggleFn}();
                }
                function ${cancelUncheckFn}() {
                    Ext.get('${entryId}_checkbox_0').dom.checked = 'checked';
                }
                Ext.get('${entryId}_checkbox_0').on('click', function() {
                    <c:choose>
                        <c:when test="${entry.completed}">
                            ${openUncheckDialogFn}();
                        </c:when>
                        <c:otherwise>
                            ${toggleFn}();
                        </c:otherwise>
                    </c:choose>
                });
            
//]]>
</script>
        </td>
        <td>
            <c:choose>
                <c:when test="${entry.completed and not empty entry.completedBy}">
                    <c:set var="date">
                        <syswf:component prefix="date" name="/core/impl/util/enhancedDateRenderer" wrap="false">
                            <syswf:param name="dateValue" value="${entry.completedWhen}"/>
                        </syswf:component>
                    </c:set>
                    <c:set var="user">
                        <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="completedBy" wrap="false">
                            <syswf:param name="principal" value="${entry.completedBy}"/>
                        </syswf:component>
                    </c:set>
                    <div class="UI Icon Completed">${fn:trim(user)}, ${fn:trim(date)}</div>
                </c:when>
                <c:when test="${not entry.completed}">
                    <c:forEach items="${entry.assignees}" var="asignee" varStatus="status">
                        <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="asignee${status.index}"
                                 wrap="false">
                            <syswf:param name="principal" value="${asignee}"/>
                        </syswf:component>
                        <c:if test="${not status.last}"><br/></c:if>                      
                    </c:forEach>
                </c:when>
            </c:choose>
        </td>
        <td>
            <div class="Text RightAlign">
                <c:if test="${entry.validationRunning}">
                    <span class="UI Icon Working"><fmt:message key="policiesSection.validationRunningLabel"
                            bundle="${messages}"/></span>
                </c:if>
            </div>
        </td>
    </tr>
</table>
<c:if test="${not empty entry.description or not empty entry.policyUuid or entry.validationFailed}">
    <syswf:component prefix="descBody" name="/newUi/lc/common/widget/expandCommentBody" wrap="false">
        <syswf:param name="bodyId" value="${commentBodyId}"/>
        <syswf:param name="commentedTextHasCheckbox" value="${true}"/>        
        <syswf:param name="content">
            <c:if test="${not empty entry.policyUuid}">
                <strong><fmt:message key="tasksSection.validatedByPolicy" bundle="${messages}"/>:</strong>
                <syswf:component prefix="policy" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                    <syswf:param name="uuid" value="${entry.policyUuid}"/>
                    <syswf:param name="caption" value="${entry.policyName}"/>
                </syswf:component>
            </c:if>
            
            <c:if test="${not empty entry.description}">
                <p class="Comment Plain">
                    <c:out value="${entry.description}" escapeXml="false"/>
                </p>
            </c:if>
           
            <c:if test="${entry.validationFailed and (completionAttempted or entry.lifecycleStatusFailed)}">
                <span class="UI Icon Error">
                    <fmt:message key="tasksSection.failureMessage" bundle="${messages}"/>
                    <fmt:message key="tasksSection.failureReportLink" bundle="${messages}" var="reportLinkText"/>
                    <syswf:component prefix="${prefix}taskValidationReportLink" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                        <syswf:param name="uuid" value="${artifact._uuid}"/>
                        <syswf:param name="caption" value="${reportLinkText}"/>
                        <syswf:param name="artifactTabId" value="compliance"/>
                        <syswf:param name="class" value="IconAlign"/>
                    </syswf:component>
                </span>
            </c:if>
        </syswf:param>
    </syswf:component>  
</c:if>
<c:if test="${entry.validationFailed and completionAttempted}">
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            AdvancedOptions.Comment.Open('${commentAnchorId}', '${commentBodyId}');
        });
    
//]]>
</script>
</c:if>




