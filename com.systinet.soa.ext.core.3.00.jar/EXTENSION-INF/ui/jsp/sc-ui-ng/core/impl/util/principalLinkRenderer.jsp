<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page trimDirectiveWhitespaces="true" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>
<fmt:message key="user.settings" var="userSettings" bundle="${messages}"/>

<%--@elvariable id="this" type="com.hp.systinet.sc.ui.impl.util.PrincipalLinkRenderer"--%>
<%--@elvariable id="showIcon" type="java.lang.Boolean"--%>
<fmt:message key="principal.icon.${this.principalCategory}" bundle="${messages}" var="principalIcon"/>
<c:choose>
	<c:when test="${getLoginNameText eq 'true'}">
		<c:out value="${this.name}"/>
	</c:when>
	<c:when test="${getLoginNameLink eq 'true'}">
		<syswf:control mode="anchor" caption="${userSettings}" targetTask="${this.ownerUri}" targetDepth="${targetDepth}">
            <c:if test="${not empty this.ownerParams}">
                <syswf:paramSet value="${this.ownerParams}"/>
            </c:if>
            <c:if test="${not empty target}">
                <syswf:attribute name="target" value="${target}"/>
            </c:if>
            <syswf:param name="view" value="${view}"/>
        </syswf:control>
	</c:when>
	<c:otherwise>
		<c:choose>
		    <c:when test="${this.forInternalAdmin}">
		        <span class="Comment"><c:out value="${this.name}"/></span>
		    </c:when>
		    <c:when test="${not empty this.ownerUri}">
		        <syswf:control mode="anchor" caption="${this.name}" targetTask="${this.ownerUri}" targetDepth="${targetDepth}">
		            <c:if test="${not empty this.ownerParams}">
		                <syswf:paramSet value="${this.ownerParams}"/>
		            </c:if>
		            <c:if test="${empty showIcon or showIcon}">
		                <syswf:attribute name="class" value="UI Icon ${principalIcon} ${additionalIconCss}"/>
		            </c:if>
		            <c:if test="${not empty target}">
		                <syswf:attribute name="target" value="${target}"/>
		            </c:if>
		            <syswf:param name="view" value="${view}"/>
		        </syswf:control>
		    </c:when>
		    <c:when test="${not empty showIcon and not showIcon}">
		        <c:out value="${this.name}"/>
		    </c:when>
		    <c:when test="${not empty this.name}">
		        <span class="UI Icon ${principalIcon}"><c:out value="${this.name}"/></span>
		    </c:when>
	    </c:choose>
    </c:otherwise>
</c:choose>
