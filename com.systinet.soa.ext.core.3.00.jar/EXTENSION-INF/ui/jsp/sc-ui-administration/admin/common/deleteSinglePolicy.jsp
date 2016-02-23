<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="messages" />

<syswf:component name="/core/window" prefix="deleteSinglePolicy">
    <syswf:param name="winComponent" value="/admin/policy/bulk/deleteSingleWindow" />
    <syswf:param name="winTitle"><fmt:message bundle="${messages}" key="delete.title" /></syswf:param>
    <syswf:param name="winOpenFunctionName" value="${controlName}" />
    <syswf:param name="winOkAction" value="${prefix}delete" />
    <syswf:param name="winWidth"><c:out value="${winWidth}" default="300" /></syswf:param>    
    <syswf:param name="settings" value="${settings}"/>
    <syswf:param name="selectionBag" value="${selectionBag}" />
    <syswf:param name="artifact" value="${artifact}" />
    <syswf:param name="artifactName" value="${artifactName}" />    
    <syswf:param name="disableAdvancedOptions" value="${disableAdvancedOptions}"/>    
    <syswf:param name="singleDelete" value="${singleDelete}" />    
</syswf:component>

<syswf:control mode="script" action="delete" caption="${prefix}delete" />