<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>
<fmt:message key="tasksLinkLabel" var="title" bundle="${messages}"/>
<div id="pagetitle" class="UI Block Common EA-Blue-Bar">
    <div class="EA-Block">
        <h3 class="EA-top-header">
            <syswf:out value="${title}" context="HtmlBody"/>
        </h3>
    </div>
    <div class="EA-Block"></div>
    <div class="EA-Block EA-block-vote">
    </div>
    <div class="float-clear"></div>
</div>
<syswf:component prefix="tabs.browseTask" name="/core/layout/tabs">
    <syswf:param name="customizationId" value="admin.task.browseTask"/>
    <syswf:param name="dontCustomize" value="true"/>
    <syswf:param name="fromLeftMenu" value="${fromLeftMenu}"/>
</syswf:component>