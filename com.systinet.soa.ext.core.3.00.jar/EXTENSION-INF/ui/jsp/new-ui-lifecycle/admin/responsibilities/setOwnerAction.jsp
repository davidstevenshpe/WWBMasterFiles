<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="selectOwner.title" var="selectOwnerTitle" bundle="${messages}"/>

<syswf:control mode="script" action="cancel" caption="${prefix}cancel" />

<c:if test="${not empty setOwnerBean.selectedStages}">
	<syswf:component name="/core/principal/selector" prefix="setOwnerPricipalSelector">
	    <syswf:param name="jsOpenFunction" value="${prefix}openSelectorOwner" />
	    <syswf:param name="windowTitle" value="${selectOwnerTitle}"/>
	    <syswf:param name="holder" value="${setOwnerBean.principalHolder}" />
        <syswf:param name="winCancelAction" value="${prefix}cancel" />            
	</syswf:component>
	
	<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
		${prefix}openSelectorOwner();
	})
	
//]]>
</script>
</c:if>

<script type="text/javascript">
//<![CDATA[

    function changeOwner(){
        ${controlName}();        
    }

//]]>
</script>

<jsp:include page="storeStagesInclude.jsp" />