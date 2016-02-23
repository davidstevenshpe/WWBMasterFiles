<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<fmt:message var="title" key="processDeleted.title" bundle="${messages}" />
<fmt:message var="description" key="processDeleted.description" bundle="${messages}" />

<table class="UI Layout">
    <tbody>
        <tr>
            <td class="UI Middle">
                <!-- Title and description -->
                <div class="UI PageIdentity">
                    <h1>${title}</h1>
                </div>
                <div class="UI Text Description">${description}</div>
            </td>
        </tr>
    </tbody>
</table>