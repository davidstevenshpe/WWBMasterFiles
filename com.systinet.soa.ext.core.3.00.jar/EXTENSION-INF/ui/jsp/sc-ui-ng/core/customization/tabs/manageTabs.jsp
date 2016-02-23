<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="title" key="manageTabs.title" bundle="${bundle}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
</syswf:component>

<%--
<div class="UI Text Description">&nbsp;</div>
--%>

<syswf:block className="UI Block Common">
    <syswf:component name="/core/impl/customization/editors/tabsCustomizationEditor" prefix="${viewId}.manageTabs" />
</syswf:block>