<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="addApprover.addLabel" var="addLabel" bundle="${messages}"/>
<fmt:message key="addApprover.title" var="addApproverTitle" bundle="${messages}"/>
<fmt:message key="selectApprover.title" var="selectApproverTitle" bundle="${messages}"/>

<syswf:control mode="script" action="addApprover" caption="${prefix}save" />
<syswf:control mode="script" action="cancel" caption="${prefix}cancel1" />

<syswf:component name="/core/principal/selector" prefix="addApproverPricipalSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}openSelectorAddApprover" />
    <syswf:param name="windowTitle" value="${selectApproverTitle}"/>
    <syswf:param name="holder" value="${approverHolder}" />
    <syswf:param name="winCancelAction" value="${prefix}cancel1" />
    <syswf:param name="enableContactsTab" value="true" />
</syswf:component>

<c:if test="${not empty approverHolder.selectedStages && approverHolder.principal eq null}">
	<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
		${prefix}openSelectorAddApprover();
	})
    //]]>
	</script>
</c:if>

<c:if test="${approverHolder.principal ne null}">
	<syswf:component name="/core/window" prefix="addApprover">
	    <syswf:param name="winTitle">${addApproverTitle}</syswf:param>
	    <syswf:param name="winComponent" value="/newUi/lc/admin/responsibilities/addApprover"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
	    <syswf:param name="winOkLabel" value="${addLabel}" />    
	    <syswf:param name="winOkAction" value="${prefix}save" />
	    <syswf:param name="winCancelAction" value="${prefix}cancel1" />
	    
	    <syswf:param name="approverHolder" value="${approverHolder}" />
	    <syswf:param name="parentComponent" value="${prefix}" />
	</syswf:component>

	<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
	    ${prefix}open();
	})
    //]]>
	</script>
</c:if>

<jsp:include page="storeStagesInclude.jsp" />
