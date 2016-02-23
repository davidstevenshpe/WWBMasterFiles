<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message var="validatingPolicies" key="usertasks.myTasksBox.validatingPolicies" bundle="${messages}"/>
<fmt:message var="error" key="usertasks.myTasksBox.error" bundle="${messages}"/>
<fmt:message var="validationFailed" key="usertasks.myTasksBox.validationFailed" bundle="${messages}"/>
<fmt:message var="validationFailedDetails" key="usertasks.myTasksBox.validationFailed.details" bundle="${messages}"/>

<%--@elvariable id="taskInfo" type="com.hp.systinet.lifecycle.usertask.LifecycleManualTaskInfo"--%>
<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.usertask.LifecycleTaskCheckboxRenderer.LifecycleTaskCheckboxRendererBean"--%>

<%--
This component supports only lifecycle manual tasks.
--%>
<c:choose>
    <c:when test="${bean.validationRunning}">
        <%-- Show animated icon --%>
        <span title="" class="UI Icon Working"><c:out value="${validatingPolicies}"/></span>

        <c:set var="reloadFunction" value="${prefix}_reloadFunction"/>
        <syswf:control mode="ajax" action="refreshValidatedTask" caption="${reloadFunction}"/>
        <script type="text/javascript">
//<![CDATA[

            setTimeout("callFunction('${reloadFunction}')", getRandomLoadingInterval());
        
//]]>
</script>
    </c:when>
    <c:otherwise>
        <%-- Show checkbox (checked or unchecked) --%>
        <syswf:selectOne name="${prefix}_checkbox" id="${prefix}_checkbox"
                         value="${bean}"
                         property="complete"
                         optionValues="true"
                         optionCaptions=""
                         mode="checkbox"
                         dataType="boolean">
            <syswf:attribute name="class" value="UI Form Checkbox Inline"/>
            <c:if test="${bean.disableCheckbox}">
                <syswf:attribute name="disabled" value="disabled"/>
            </c:if>
        </syswf:selectOne>
        
        <label for="${prefix}_checkbox_0" class="UI Label Inline" id="${prefix}_taskInfo" ><c:out value="${taskInfo.name}"/></label>
        <c:if test="${not empty taskInfo.description}">
	        <div class="x-hidden flyout-menu UI Dropdown" id="${prefix}_taskInfo_content">
	             <div class="DropdownContent">
	                 <p class="Comment"><c:out value="${taskInfo.description}"/></p>
	             </div>
	        </div>
	        <script type="text/javascript">
//<![CDATA[

	             Ext.onReady(function() {
	                  Dropdown.init('${prefix}_taskInfo', '${prefix}_taskInfo_content', { align: 'tl-tr?', forceRefresh:true , alignOffset: [0,0] });
	             });
	        
//]]>
</script>
        </c:if>
        <c:set var="toggleFunction" value="${prefix}_toggleFunction"/>
        <c:set var="openUncheckDialogFunction" value="${prefix}_openUncheckDialogFunction"/>
        <c:set var="cancelUncheckFunction" value="${prefix}_cancelUncheckFunction"/>
        <syswf:control mode="ajax" action="toggle" caption="${toggleFunction}"/>

        <%-- uncheck confirmation dialog--%>
        <syswf:component name="/core/util/confirmPopUp" prefix="uncheckDialog">
            <syswf:param name="winOpenFunctionName" value="${openUncheckDialogFunction}" />
            <syswf:param name="winOkAction" value="${toggleFunction}" />
            <syswf:param name="winCancelAction" value="${cancelUncheckFunction}"/>
            <syswf:param name="confirmMessage"><fmt:message key="task.confirmUncheckText"
                                                            bundle="${messages}"/></syswf:param>
            <syswf:param name="title"><fmt:message key="task.confirmUncheckTitle"
                                                   bundle="${messages}"/></syswf:param>
        </syswf:component>

        <script type="text/javascript">
//<![CDATA[

            function ${cancelUncheckFunction}() {
                Ext.get('${prefix}_checkbox_0').dom.checked = 'checked';
            }

            Ext.get('${prefix}_checkbox_0').on('click', function() {
                <c:choose>
                    <c:when test="${bean.complete}">
                        ${openUncheckDialogFunction}();
                    </c:when>
                    <c:otherwise>
                        Ext.get('${prefix}_checkbox_0').dom.disabled = 'disabled';
                        <%-- to prevent multiple clicks --%>
                        ${toggleFunction}();
                    </c:otherwise>
                </c:choose>
            });
        
//]]>
</script>

        <c:if test="${bean.validationFailed}">
            <div class="OffsetLeft">
                <div class="UI SystemMessage Error ToDoValidationFailed">
                    <div class="MessageContainer">
                        <div class="Text Task">
                            <strong><c:out value="${error}"/></strong>
                            <c:out value="${validationFailed}"/>
                            <syswf:component prefix="${prefix}taskValidationReportLink" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                <syswf:param name="uuid" value="${artifact._uuid}"/>
                                <syswf:param name="caption" value="${validationFailedDetails}"/>
                                <syswf:param name="artifactTabId" value="compliance"/>
                                <syswf:param name="class" value="IconAlign"/>
                            </syswf:component>
                        </div>
                        <div class="x-clear"/>
                    </div>
                </div>
            </div>
        </c:if>
    </c:otherwise>
</c:choose>
