<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="uimessages"/>
<fmt:message var="INTEGRATIONS" key="INTEGRATIONS" bundle="${uimessages}"/>
<fmt:message var="integrationsDesc" key="Integrations.desc" bundle="${uimessages}"/>

<div id="pagetitle" class="UI Block Common EA-Blue-Bar">
    <div class="EA-Block">
        <h3 class="EA-top-header">${INTEGRATIONS}</h3>
        <h5 class="Artifact EA-sub-type">${integrationsDesc}</h5>
    </div>
    <div class="EA-Block"></div>
    <div class="EA-Block EA-block-vote">
    </div>
    <div class="float-clear"></div>
</div>
<syswf:component prefix="tabs" name="/core/layout/tabs">
    <syswf:param name="customizationId" value="admin.integrations.tabs"/>
</syswf:component>
