<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.shortcut.ManageShortcutsMessages" var="manageShortcuts_Messages" />
<div id="pagetitle" class="UI Block Common EA-Blue-Bar">
    <div class="EA-Block">
        <h3 class="EA-top-header">
            <fmt:message key="manageShortcuts.title" bundle="${manageShortcuts_Messages}" />
        </h3>
        <h5 class="Artifact EA-sub-type">
            <fmt:message key="manageShortcuts.description" bundle="${manageShortcuts_Messages}" />
        </h5>
    </div>
    <div class="EA-Block"></div>
    <div class="EA-Block EA-block-vote">
    </div>
    <div class="float-clear"></div>
</div>
<syswf:component prefix="tabs" name="/core/layout/tabs">
    <syswf:param name="customizationId" value="admin.shortcut.manageShortcuts"/>
</syswf:component>