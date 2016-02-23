<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="process" type="com.hp.systinet.platform.lifecycle.GovernanceProcess"--%>
<%--@elvariable id="published" type="java.lang.Boolean"--%>
<%--@elvariable id="isAssociated" type="java.lang.Boolean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<c:if test="${!isAssociated}">
    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>
    <fmt:message var="msgLinkLabel" key="processAction.delete.label" bundle="${bundle}"/>
    <fmt:message var="msgConfirmTitle" key="processAction.delete.confirmTitle" bundle="${bundle}"/>
    <fmt:message var="msgConfirmMessage" key="processAction.delete.confirmMessage" bundle="${bundle}">
        <fmt:param><c:out value="${process.name}"/></fmt:param>
    </fmt:message>

    <syswf:control mode="script" action="deleteProcess" caption="${prefix}deleteAction" >
        <syswf:param name="processId">${process.id}</syswf:param>
    </syswf:control>
    <syswf:component prefix="deleteConfirmDialog" name="/core/impl/util/dialog">
        <syswf:param name="controlName" value="${prefix}deleteControl" />
        <syswf:param name="handler" value="${prefix}deleteAction" />
        <syswf:param name="heading">${msgConfirmTitle}</syswf:param>
        <syswf:param name="content">${msgConfirmMessage}</syswf:param>
        <syswf:param name="noUndo" value="true" />
    </syswf:component>
    <a id="${prefix}deleteLink" href="javascript:void(0);" class="context-button Remove" title="${msgLinkLabel}"></a>
    <script type="text/javascript">
//<![CDATA[

        attachOn('${prefix}deleteLink','click',function() { ${prefix}deleteControl(); });
        //]]>
    </script>
</c:if>