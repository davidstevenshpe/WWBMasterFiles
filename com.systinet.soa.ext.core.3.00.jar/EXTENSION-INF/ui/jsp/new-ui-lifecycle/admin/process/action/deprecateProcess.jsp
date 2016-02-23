<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="process" type="com.hp.systinet.platform.lifecycle.GovernanceProcess"--%>
<%--@elvariable id="published" type="boolean"--%>

<c:if test="${published}">
    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>
    <fmt:message var="msgLinkLabel" key="processAction.deprecate.label" bundle="${bundle}"/>
    <fmt:message var="msgConfirmTitle" key="processAction.deprecate.confirmTitle" bundle="${bundle}"/>
    <fmt:message var="msgConfirmMessage" key="processAction.deprecate.confirmMessage" bundle="${bundle}">
        <fmt:param><c:out value="${process.name}"/></fmt:param>
    </fmt:message>

    <syswf:control mode="script" action="deprecateProcess" caption="${prefix}deprecateAction" >
        <syswf:param name="processId">${process.id}</syswf:param>
    </syswf:control>
    <syswf:component prefix="deprecateConfirmDialog" name="/core/impl/util/dialog">
        <syswf:param name="controlName" value="${prefix}deprecateControl" />
        <syswf:param name="handler" value="${prefix}deprecateAction" />
        <syswf:param name="heading">${msgConfirmTitle}</syswf:param>
        <syswf:param name="content">${msgConfirmMessage}</syswf:param>
        <syswf:param name="noUndo" value="no" />
    </syswf:component>
    <a id="${prefix}deprecateLink" href="#" class="context-button Deprecate" title="${msgLinkLabel}"></a>
    <script type="text/javascript">
//<![CDATA[

        attachOn('${prefix}deprecateLink','click',function() { ${prefix}deprecateControl(); });
        //]]>
    </script>
</c:if>