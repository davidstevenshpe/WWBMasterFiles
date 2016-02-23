<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="clear.title" var="clearTitle" bundle="${messages}"/>
<fmt:message key="clear.button.clear" var="clearButton" bundle="${messages}"/>

<syswf:control mode="script" action="clear" caption="${prefix}clear" />
<syswf:control mode="script" action="cancel" caption="${prefix}cancelClear" />

<c:if test="${not empty clearBean.selectedStages}">
    <syswf:component name="/core/window" prefix="clear">
        <syswf:param name="winTitle">${clearTitle}</syswf:param>
        <syswf:param name="winComponent" value="/newUi/lc/admin/responsibilities/clear"/>
        <syswf:param name="winOpenFunctionName" value="${prefix}openClear" />
        <syswf:param name="winOkLabel" value="${clearButton}" />    
        <syswf:param name="winOkAction" value="${prefix}clear" />
        <syswf:param name="winCancelAction" value="${prefix}cancelClear" />
        <syswf:param name="winWidth" value="350" />
        
        <syswf:param name="clearBean" value="${clearBean}" />        
    </syswf:component>

	<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
	    ${prefix}openClear();
	})
	
//]]>
</script>
</c:if>

<jsp:include page="storeStagesInclude.jsp" />