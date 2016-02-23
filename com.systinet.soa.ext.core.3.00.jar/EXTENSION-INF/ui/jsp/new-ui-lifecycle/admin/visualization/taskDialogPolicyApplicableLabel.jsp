<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<c:if test="${not empty taskBean.policyUuid}">
    <label class="UI Label Inline"><fmt:message key="taskDialog.policyAplicableTo" bundle="${bundle}"/>:</label>
    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>    
</c:if>
