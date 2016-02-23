<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="copy.title" var="copyTitle" bundle="${messages}"/>
<fmt:message key="copy.button.copy" var="copyButton" bundle="${messages}"/>

<syswf:control mode="script" action="copy" caption="${prefix}copy" />
<syswf:control mode="script" action="cancel" caption="${prefix}cancelCopy" />

<c:if test="${not empty copyBean.selectedStages}">
    <syswf:component name="/core/window" prefix="copy">
        <syswf:param name="winTitle">${copyTitle}</syswf:param>
        <syswf:param name="winComponent" value="/newUi/lc/admin/responsibilities/copy"/>
        <syswf:param name="winOpenFunctionName" value="${prefix}openCopy" />
        <syswf:param name="winOkLabel" value="${copyButton}" />    
        <syswf:param name="winOkAction" value="${prefix}copy" />
        <syswf:param name="winCancelAction" value="${prefix}cancelCopy" />    
        <syswf:param name="winWidth" value="450" />                    
        
        <syswf:param name="copyBean" value="${copyBean}" />        
    </syswf:component>

	<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
	    ${prefix}openCopy();
	})
	
//]]>
</script>
</c:if>

<jsp:include page="storeStagesInclude.jsp" />