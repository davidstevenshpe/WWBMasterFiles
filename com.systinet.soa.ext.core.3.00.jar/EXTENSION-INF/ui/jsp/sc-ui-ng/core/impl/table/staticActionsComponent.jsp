<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- render cotrols part --%>
<c:forEach var="item" items="${actionHolders}">
    <c:set var="actionControl">
    <c:choose>
        <c:when test="${item.type == 'component'}">
            <syswf:component prefix="${item.id}" name="${item.target}" wrap="false">
                <syswf:paramSet value="${item.parameters}"/>
                <syswf:param name="controlName" value="${item.controlName}"/>
            </syswf:component>
        </c:when>
        <c:when test="${item.type == 'task'}">
            <syswf:control mode="script" caption="${item.controlName}" targetTask="${item.target}">
                <syswf:paramSet value="${item.parameters}"/>
            </syswf:control>
        </c:when>
    </c:choose>
    </c:set>
    <c:if test="${not empty actionControl}">
        <%-- escapeXml verified OK --%>
        <c:out value="${actionControl}" escapeXml="false"/>
    </c:if>
    <c:set target="${item}" property="visible" value="${not empty actionControl}"/>
</c:forEach>

<%-- render toolbar buttons part --%>
<div class="Footer">
    <c:forEach var="item" items="${actionHolders}" varStatus="status">
        <c:choose>
            <c:when test="${item.type == 'ruler'}">
                |
            </c:when>
            <c:when test="${item.visible}">                
                <a href="javascript:${item.controlName}()" id="${item.controlName}" <c:if test="${not empty item.description}">title="${item.description}"</c:if> class="UI Icon<c:if test="${not empty item.styleClass}"> ${item.styleClass}</c:if>">
                    <c:choose>
                        <c:when test="${not empty item.label}">
                            <span>${item.label}</span>
                        </c:when>
                        <c:otherwise>
                            <span>${item.id}</span>
                        </c:otherwise>
                    </c:choose>
                </a>
            </c:when>
        </c:choose>
    </c:forEach>
</div>