<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="bodyId" type="java.lang.String"--%>
<%--@elvariable id="content" type="java.lang.String"--%>
<%--@elvariable id="commentedTextHasCheckbox" type="java.lang.Boolean"--%>

<div class="Comment x-hidden" id="${bodyId}">
    <table class="UI Table Properties">
        <col class="${commentedTextHasCheckbox ? 'SpacerAltCol' : 'FormSelectCol'}"/>
        <col/>
        <tr>
            <td></td>
            <td>
                <c:out value="${content}" escapeXml="false"/>
            </td>
        </tr>
    </table>
</div>
