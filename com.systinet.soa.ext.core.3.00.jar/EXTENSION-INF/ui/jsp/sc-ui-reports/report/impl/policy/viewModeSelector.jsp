<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="messages"/>
<fmt:message var="policies" key="viewModeSelector.policies" bundle="${messages}"/>
<fmt:message var="annotatedSources" key="viewModeSelector.annotatedSources" bundle="${messages}"/>

<%--@elvariable id="modelBean" type="com.hp.systinet.report.ui.impl.policy.ViewModeSelector.ViewModeSelectorBean"--%>

<label><fmt:message key="viewModeSelector.showLabel" bundle="${messages}"/></label>
<input id="${prefix}_viewModeSelector_policies" name="${prefix}_viewModeSelector" type="radio"
       value="policies" class="UI Form Radio"
        <c:if test="${not modelBean.showSources}">
            checked="checked"
        </c:if>/>
<label for="${prefix}_viewModeSelector_policies" class="UI Label Inline"><c:out value="${policies}"/></label>
<input id="${prefix}_viewModeSelector_sources" name="${prefix}_viewModeSelector" type="radio"
       value="annotatedSources" class="UI Form Radio"
        <c:if test="${modelBean.showSources}">
            checked="checked"
        </c:if>/>
<label for="${prefix}_viewModeSelector_sources" class="UI Label Inline"><c:out value="${annotatedSources}"/></label>

<c:set var="showSourcesFunction" value="${prefix}_showSourcesFunction"/>
<syswf:control mode="ajax" action="showSources" caption="${showSourcesFunction}"/>
<c:set var="showPoliciesFunction" value="${prefix}_showPoliciesFunction"/>
<syswf:control mode="ajax" action="showPolicies" caption="${showPoliciesFunction}"/>

<script type="text/javascript">
//<![CDATA[

    Ext.get('${prefix}_viewModeSelector_policies').on('click', function() {
        ${showPoliciesFunction}();
    });
    Ext.get('${prefix}_viewModeSelector_sources').on('click', function() {
        ${showSourcesFunction}();
    });

//]]>
</script>
