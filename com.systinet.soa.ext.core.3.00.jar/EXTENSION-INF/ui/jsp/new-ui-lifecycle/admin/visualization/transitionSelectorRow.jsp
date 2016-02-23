<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="webResourcePath" type="String"--%>
<%--@elvariable id="radioName" type="java.lang.String"--%>
<%--@elvariable id="radioId" type="java.lang.String"--%>
<%--@elvariable id="iconFile" type="java.lang.String"--%>
<%--@elvariable id="fromStageName" type="java.lang.String"--%>
<%--@elvariable id="transition" type="java.lang.String"--%>
<%--@elvariable id="selectedTransition" type="java.lang.String"--%>

<tr>
    <td>
        <input type="radio" name="${radioName}" value="${transition}" id="${radioId}" class="UI Form Radio"
                <c:if test="${selectedTransition eq transition}">checked="checked"</c:if>>
    </td>
    <td>

        <img src="${webResourcePath}/skin/img/default/${iconFile}.png" width="100" height="20" align="top"
             alt="<fmt:message key="editTransition.transitionImageAlt.${transition}" bundle="${messages}"/>"/>
    </td>
    <td>
        <c:set var="fromStageNameEscaped"><c:out value="${fromStageName}"/></c:set>
        <fmt:message key="editTransition.transitionTitle.${transition}" bundle="${messages}" var="transitionTitle">
            <fmt:param value="${fromStageNameEscaped}"/>
        </fmt:message>
        <label for="${radioId}" class="UI Label Inline">${transitionTitle}</label>
    </td>
</tr>