<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="process" type="com.hp.systinet.platform.lifecycle.GovernanceProcess"--%>
<%--@elvariable id="published" type="boolean"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>
<fmt:message var="msgLinkLabel" key="processAction.edit.label" bundle="${bundle}"/>

<c:choose>
    <c:when test="${published}">
        <%-- Show confirm dialog for published processes --%>
        <fmt:message var="msgConfirmTitle" key="processAction.edit.confirmTitle" bundle="${bundle}"/>
        <fmt:message var="msgConfirmMessage" key="processAction.edit.confirmMessage" bundle="${bundle}">
            <fmt:param><c:out value="${process.name}"/></fmt:param>
        </fmt:message>

        <syswf:control mode="script" targetTask="/admin/lifecycle/process/editProcess" caption="${prefix}editAction" >
            <syswf:param name="processId">${process.id}</syswf:param>
        </syswf:control>
        <syswf:component prefix="editConfirmDialog" name="/core/impl/util/dialog">
            <syswf:param name="controlName" value="${prefix}editControl" />
            <syswf:param name="handler" value="${prefix}editAction" />
            <syswf:param name="heading">${msgConfirmTitle}</syswf:param>
            <syswf:param name="content">${msgConfirmMessage}</syswf:param>
            <syswf:param name="noUndo" value="false" />
        </syswf:component>
        	
       	<a id="${prefix}editLink" href="#" class="context-button Edit" title="${msgLinkLabel}"></a>
        
        <script type="text/javascript">
            //<![CDATA[
            attachOn('${prefix}editLink','click',function() { ${prefix}editControl(); });
            //]]>
        </script>

    </c:when>
    <c:otherwise>
        <%-- Show simple link --%>
        <syswf:control mode="anchor" targetTask="/admin/lifecycle/process/editProcess" caption="">
            <syswf:attribute name="class">context-button Edit</syswf:attribute>
            <syswf:attribute name="title">${msgLinkLabel}</syswf:attribute>
            <syswf:param name="processId">${process.id}</syswf:param>
        </syswf:control>
    </c:otherwise>
</c:choose>
