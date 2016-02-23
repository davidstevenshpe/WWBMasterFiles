<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:forEach var="item" items="${actionHolders}" varStatus="status">
    <c:set var="actionControl">
        <c:choose>
            <c:when test="${(item.type == 'group' || item.type == 'subgroup') && (not empty item.childs)}">
                <syswf:component name="/core/impl/table/actionsControls" prefix="controls${status.index}" wrap="false">
                    <syswf:param name="actionHolders" value="${item.childs}" />
                    <syswf:param name="datasource" value="${datasource}"/>
                    <syswf:param name="tableColumns" value="${tableColumns}"/>
                    <syswf:param name="rowPreview" value="${rowPreview}"/>
                    <syswf:param name="tableId" value="${tableId}"/>
                </syswf:component>
            </c:when>
            <c:when test="${item.type == 'component'}">
                <syswf:component prefix="${item.id}" name="${item.target}" wrap="false">
                    <syswf:paramSet value="${item.parameters}"/>
                    <syswf:param name="item" value="${item}"/>
                    <syswf:param name="controlName" value="${item.controlName}"/>
                    <syswf:param name="selectionBag" value="${selectionBag}"/>
                    <syswf:param name="datasource" value="${datasource}"/>
                    <syswf:param name="tableColumns" value="${tableColumns}"/>
                    <syswf:param name="rowPreview" value="${rowPreview}"/>
                    <syswf:param name="tableId" value="${tableId}"/>
                </syswf:component>
            </c:when>
            <c:when test="${item.type == 'task'}">
                <syswf:control mode="script" caption="${item.controlName}" targetTask="${item.target}">
                    <syswf:paramSet value="${item.parameters}"/>
                    <%--syswf:param name="selectionBag" value="${selectionBag}"/>
                    <syswf:param name="datasource" value="${datasource}"/>
                    <syswf:param name="tableColumns" value="${tableColumns}"/>
                    <syswf:param name="rowPreview" value="${rowPreview}"/>
                    <syswf:param name="tableId" value="${tableId}"/--%>
                </syswf:control>
            </c:when>
        </c:choose>
    </c:set>
    <c:if test="${not empty actionControl}">
        <%-- escapeXml verified OK --%>
        <c:out value="${actionControl}" escapeXml="false"/>
    </c:if>
    <c:set target="${item}" property="visible" value="${(not empty actionControl) || (item.type=='group' && (not empty item.childs))}"/>
</c:forEach>