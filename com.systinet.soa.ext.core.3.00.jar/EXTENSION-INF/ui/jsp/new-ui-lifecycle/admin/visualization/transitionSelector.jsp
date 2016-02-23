<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="fromStageName" type="java.lang.String"--%>
<%--@elvariable id="toStageName" type="java.lang.String"--%>
<%--@elvariable id="mode" type="java.lang.String"--%>
<%--@elvariable id="selectedTransition" type="java.lang.String"--%>
<%--@elvariable id="availableTransitionTypes" type="java.util.Map"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="autoWarnings" type="java.lang.String"--%>
<%--@elvariable id="approvedWarnings" type="java.lang.String"--%>
<%--@elvariable id="transitionTypeValue" type="java.lang.String"--%>
<%--@elvariable id="multiTransitions" type="java.lang.Boolean"--%>
<%--@elvariable id="checkAllDeleteRadiosFn" type="java.lang.String"--%>
<%--@elvariable id="maxTransitionsToDelete" type="java.lang.Integer"--%>

<c:set var="warningsId" value="${prefix}_warnings"/> <%-- id of warnings div element --%>
<c:set var="autoWarningId" value="${prefix}_autoWarning"/> <%-- id of warning div element for automatic transition --%>
<c:set var="approvedWarningId" value="${prefix}_approveWarning"/> <%-- id of warnings div element for manual-after-approval transition--%>
<c:set var="emptyWarningId" value="${prefix}_warning_empty"/> <%-- id of empty warnings div element--%>
<c:set var="autoRadioVar" value="${prefix}_autoRadioVar"/><%-- javascript variable for automatic transition radio --%>
<c:set var="approvedRadioVar" value="${prefix}_approvedRadioVar"/><%-- javascript variable for manual-after-approval radio --%>
<c:set var="anytimeRadioVar" value="${prefix}_anytimeRadioVar"/><%-- javascript variable for manual-anytime transition radio --%>
<c:set var="deleteRadioVar" value="${prefix}_deleteRadioVar"/><%-- javascript variable for remove transition radio --%>
<script type="text/javascript">
//<![CDATA[

    var ${autoRadioVar} = null;
    var ${approvedRadioVar} = null;
    var ${anytimeRadioVar} = null;
    var ${deleteRadioVar} = null;

//]]>
</script>

<h4>
    <c:choose>
        <c:when test="${mode eq 'EDIT_TRANSITION'}">
            <fmt:message key="editTransition.transitionSectionLabel.fromTo" bundle="${messages}">
                <fmt:param><syswf:out value="${fromStageName}" context="HtmlBody"/></fmt:param>
                <fmt:param><syswf:out value="${toStageName}" context="HtmlBody"/></fmt:param>
            </fmt:message>
        </c:when>
        <c:otherwise>
            <fmt:message key="editTransition.transitionSectionLabel.from" bundle="${messages}">
                <fmt:param><syswf:out value="${fromStageName}" context="HtmlBody"/></fmt:param>
            </fmt:message>
        </c:otherwise>
    </c:choose>
</h4>

<div id="${warningsId}">
    <div id="${autoWarningId}" class="UI OptionArea x-hidden">
        <div class="UI SystemMessage Warning">
            <div class="MessageContainer Warning">
                <div class="Text"><syswf:out context="HtmlBody" value="${autoWarnings}"/></div>
                <div class="x-clear"></div>
            </div>
        </div>
    </div>
    <div id="${approvedWarningId}" class="UI OptionArea x-hidden">
        <div class="UI SystemMessage Warning">
            <div class="MessageContainer Warning">
                <div class="Text"><syswf:out context="HtmlBody" value="${approvedWarnings}"/></div>
                <div class="x-clear"></div>
            </div>
        </div>
    </div>
    <div id="${emptyWarningId}" class="UI OptionArea x-hidden"></div>
</div>

<c:set var="radioName" value="${prefix}_radioName"/><%-- name attribute of radio input elements --%>
<%-- id attribute of radio input elements for automatic transition --%>
<c:set var="autoRadioId" value="${prefix}_autoRadioId"/>
<%-- id attribute of radio input elements for manual-after-approval transition --%>
<c:set var="approvedRadioId" value="${prefix}_approvedRadioId"/>
<%-- id attribute of radio input elements for manual-anytime transition --%>
<c:set var="anytimeRadioId" value="${prefix}_anytimeRadioId"/>
<%-- id attribute of radio input elements for delete transition --%>
<c:set var="deleteRadioId" value="${prefix}_deleteRadioId"/>

<c:set var="autoRadioEnabled" value="${false}"/>
<c:set var="approvedRadioEnabled" value="${false}"/>
<c:set var="anytimeRadioEnabled" value="${false}"/>

<c:if test="${not empty availableTransitionTypes['AUTO'] and availableTransitionTypes['AUTO']}">
    <c:set var="autoRadioEnabled" value="${true}"/>
</c:if>
<c:if test="${not empty availableTransitionTypes['MANUAL_AFTER_APPROVAL'] and availableTransitionTypes['MANUAL_AFTER_APPROVAL']}">
    <c:set var="approvedRadioEnabled" value="${true}"/>
</c:if>
<c:if test="${not empty availableTransitionTypes['MANUAL_ANYTIME'] and availableTransitionTypes['MANUAL_ANYTIME']}">
    <c:set var="anytimeRadioEnabled" value="${true}"/>
</c:if>

<table class="UI Table Properties">
    <col class="FormSelectCol" />
    <col class="LabelCol" />
    <col/>
    <c:if test="${autoRadioEnabled}">
        <syswf:component prefix="autoRadio" name="/newUi/lc/admin/visualization/transitionSelectorRow"
                         wrap="false">
            <syswf:param name="radioId" value="${autoRadioId}"/>
            <syswf:param name="radioName" value="${radioName}"/>
            <syswf:param name="iconFile" value="lifecycle_automatic"/>
            <syswf:param name="transition" value="AUTO"/>
            <syswf:param name="fromStageName" value="${fromStageName}"/>
            <syswf:param name="selectedTransition" value="${selectedTransition}"/>
        </syswf:component>
    </c:if>
    <c:if test="${approvedRadioEnabled}">
        <syswf:component prefix="approvedRadio" name="/newUi/lc/admin/visualization/transitionSelectorRow"
                         wrap="false">
            <syswf:param name="radioId" value="${approvedRadioId}"/>
            <syswf:param name="radioName" value="${radioName}"/>
            <syswf:param name="iconFile" value="lifecycle_manual"/>
            <syswf:param name="transition" value="MANUAL_AFTER_APPROVAL"/>
            <syswf:param name="fromStageName" value="${fromStageName}"/>
            <syswf:param name="selectedTransition" value="${selectedTransition}"/>
        </syswf:component>
    </c:if>
    <c:if test="${anytimeRadioEnabled}">
        <syswf:component prefix="anytimeRadio" name="/newUi/lc/admin/visualization/transitionSelectorRow"
                         wrap="false">
            <syswf:param name="radioId" value="${anytimeRadioId}"/>
            <syswf:param name="radioName" value="${radioName}"/>
            <syswf:param name="iconFile" value="lifecycle_manual2"/>
            <syswf:param name="transition" value="MANUAL_ANYTIME"/>
            <syswf:param name="fromStageName" value="${fromStageName}"/>
            <syswf:param name="selectedTransition" value="${selectedTransition}"/>
        </syswf:component>
    </c:if>
    <c:if test="${multiTransitions}">
        <tr>
            <td>
                <fmt:message key="editTransition.deleteTransitionHint" bundle="${messages}" var="deleteTransitionHint">
                    <fmt:param value="${maxTransitionsToDelete}"/>
                </fmt:message>
                <input type="radio" name="${radioName}" value="DELETE_TRANSITION" id="${deleteRadioId}"
                       class="UI Form Radio" title="${deleteTransitionHint}">
            </td>
            <td colspan="2">
                <c:set var="fromStageNameEscaped"><c:out value="${fromStageName}"/></c:set>
                <fmt:message key="editTransition.deleteTransitionLabel" bundle="${messages}" var="transitionTitle"/>
                <label for="${deleteRadioId}" class="UI Label Inline" title="${deleteTransitionHint}">${transitionTitle}</label>
            </td>
        </tr>
    </c:if>
</table>

<%-- function names --%>
<c:set var="getWarningDivIdFn" value="${prefix}_getWarningDivId"/>
<c:set var="updateWarningAfterStageChangeFn" value="${prefix}_updateWarningAfterStageChange"/>
<c:set var="updateWarningsAfterTransitionChangeFn" value="${prefix}_updateWarningsAfterTransitionChange"/>
<c:set var="showWarningDivFn" value="${prefix}_showWarningDiv"/>

<script type="text/javascript">
//<![CDATA[

    <c:if test="${autoRadioEnabled}">
        ${autoRadioVar} = new Ext.form.Radio({id: '${autoRadioId}', applyTo: '${autoRadioId}', hideLabel: true});
    </c:if>
    <c:if test="${approvedRadioEnabled}">
        ${approvedRadioVar} = new Ext.form.Radio({id: '${approvedRadioId}', applyTo: '${approvedRadioId}', hideLabel: true});
    </c:if>
    <c:if test="${anytimeRadioEnabled}">
        ${anytimeRadioVar} = new Ext.form.Radio({id: '${anytimeRadioId}', applyTo: '${anytimeRadioId}', hideLabel: true});
    </c:if>
    if (${multiTransitions}) {
        ${deleteRadioVar} = new Ext.form.Radio({id: '${deleteRadioId}', applyTo: '${deleteRadioId}', hideLabel: true});
    }

    function ${showWarningDivFn}(divId) {
        AdvancedOptions.Form.Switch('${warningsId}', divId);
    }

    function ${getWarningDivIdFn}(transition) {
        switch (transition) {
            case 'AUTO':
                return (${not empty autoWarnings} ? '${autoWarningId}' : '${emptyWarningId}');
                break;
            case 'MANUAL_AFTER_APPROVAL':
                return (${not empty approvedWarnings} ? '${approvedWarningId}' : '${emptyWarningId}');
                break;
            default:
                return '${emptyWarningId}';
        }
        return '${emptyWarningId}';
    }

    function ${updateWarningAfterStageChangeFn}() {
        if ('${mode}' != 'ADD_STAGE' && '${mode}' != 'EDIT_STAGE') {
            return;
        }
        if (${autoRadioVar} != null) {
            var transition = ${autoRadioVar}.getGroupValue();
            var warningDivId = ${getWarningDivIdFn}(transition);
            if (Ext.get(warningDivId).hasClass('x-hidden')) {
                <%--prevent no-op switches--%>
                ${showWarningDivFn}(warningDivId);
            }
        }
    }

    function ${updateWarningsAfterTransitionChangeFn}() {
        if (${autoRadioVar} != null) {
            var transition = ${autoRadioVar}.getGroupValue();
            ${showWarningDivFn}(${getWarningDivIdFn}(transition));
        }
    }

    Ext.onReady(function() {
        if (${autoRadioVar} != null) {
            ${autoRadioVar}.on('check', function(radio, checked) {
                if (checked) {
                    ${updateWarningsAfterTransitionChangeFn}();
                    if (${multiTransitions}) {
                        ${checkAllDeleteRadiosFn}();
                    }
                }
            });
            ${approvedRadioVar}.on('check', function(radio, checked) {
                if (checked) {
                    ${updateWarningsAfterTransitionChangeFn}();
                    if (${multiTransitions}) {
                        ${checkAllDeleteRadiosFn}();
                    }
                }
            });
            ${anytimeRadioVar}.on('check', function(radio, checked) {
                if (checked) {
                    ${updateWarningsAfterTransitionChangeFn}();
                    if (${multiTransitions}) {
                        ${checkAllDeleteRadiosFn}();
                    }
                }
            });
            if (${multiTransitions}) {
                ${deleteRadioVar}.on('check', function(radio, checked) {
                    if (checked) {
                         ${checkAllDeleteRadiosFn}();
                    }
                });
            }
         }
    });

//]]>
</script>
