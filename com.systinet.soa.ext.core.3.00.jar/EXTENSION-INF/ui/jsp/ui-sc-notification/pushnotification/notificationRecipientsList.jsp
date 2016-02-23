<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%--parameter "selectorVariable"  - unique identifier for this recipient selector --%>
<%--parameter "recipientBeanList" - list of recipient beans --%>
<%--parameter "separateWithEndash" - start list with en dash entity --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.pushnotification.ui.notificationMessages" var="messages"/>
<fmt:message key="notificationEditor.more" var="moreLabel" bundle="${messages}"/>
<fmt:message key="notificationEditor.less" var="lessLabel" bundle="${messages}"/>
<fmt:message key="notificationEditor.find" var="findLabel" bundle="${messages}"/>
<fmt:message key="notificationEditor.close" var="closeLabel" bundle="${messages}"/>

<%--@elvariable id="recipientBeanList" type="java.util.List"--%>
<%--@elvariable id="separateWithEndash" type="java.lang.Boolean"--%>
<%--@elvariable id="recipientBean" type="com.hp.systinet.pushnotification.ui.bean.RecipientBean"--%>
<%--@elvariable id="selectorVariable" type="java.lang.String"--%>

<c:set var="maxSize" value="6"/>
<c:set var="maxSizeMinusOne" value="5"/>
<c:set var="listSize" value="${fn:length(recipientBeanList)}"/>
<c:set var="moreCount" value="${listSize - maxSize}"/>
<c:set var="editorId" value="inlinedit_${selectorVariable}" />

<c:forEach var="recipientBean" varStatus="index" items="${recipientBeanList}" >
    <syswf:component prefix="${recipientBean.id}" name="/pushnotification/renderer/recipientLinkRenderer" wrap="false">
        <syswf:param name="params" value="${recipientBean.params}"/>
    </syswf:component>
    <c:if test="${not index.last}">,</c:if>
</c:forEach>

<%--ToDo show more / show less is currently not supported for list --%>

<%--<div class="DatagridEditableCell" id="${editorId}">--%>
    <%--<c:if test="${not empty recipientBeanList}">--%>
        <%--<c:if test="${separateWithEndash}">&ndash;</c:if>--%>
        <%--<c:forEach var="recipientBean" varStatus="index" end="${maxSizeMinusOne}" items="${recipientBeanList}" >--%>
            <%--<syswf:component prefix="${recipientBean.id}" name="/pushnotification/renderer/recipientLinkRenderer" wrap="false">--%>
                <%--<syswf:param name="params" value="${recipientBean.params}"/>--%>
            <%--</syswf:component>--%>
            <%--<c:if test="${not index.last}">,</c:if>--%>
        <%--</c:forEach>--%>
        <%--<c:if test="${listSize gt maxSize}">--%>
            <%--<span class="HiddenOptions">,--%>
                <%--<c:forEach var="recipientBean" varStatus="index" begin="${maxSize}" items="${recipientBeanList}" >--%>
                    <%--<syswf:component prefix="${recipientBean.id}" name="/pushnotification/renderer/recipientLinkRenderer" wrap="false">--%>
                        <%--<syswf:param name="params" value="${recipientBean.params}"/>--%>
                    <%--</syswf:component>--%>
                    <%--<c:if test="${not index.last}">,</c:if>--%>
                <%--</c:forEach>--%>
            <%--</span>--%>
            <%--<span class="ControlShowMore"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${editorId}');">${moreCount} ${moreLabel}</a>)</span>--%>
            <%--<span class="ControlShowLess"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${editorId}');">${lessLabel}</a>)</span>--%>
        <%--</c:if>--%>
    <%--</c:if>--%>
<%--</div>--%>
