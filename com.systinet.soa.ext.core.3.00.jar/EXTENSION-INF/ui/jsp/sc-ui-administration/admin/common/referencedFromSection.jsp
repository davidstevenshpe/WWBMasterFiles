<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="messages" />
<fmt:message var="referencedFromTitle" key="referencedFrom" bundle="${messages}" />

<syswf:block className="EA-right-panel">
    <div class="Title">
        <h3><span><syswf:out value="${referencedFromTitle}" context="HtmlBody"/></span></h3>
    </div>
	<syswf:component name="/admin/common/referencedFrom" prefix="{prefix}integrationSection">
		<syswf:param name="artifact" value="${artifact}"/>
		<syswf:param name="maxCount" value="10"/>
	</syswf:component>            
</syswf:block>