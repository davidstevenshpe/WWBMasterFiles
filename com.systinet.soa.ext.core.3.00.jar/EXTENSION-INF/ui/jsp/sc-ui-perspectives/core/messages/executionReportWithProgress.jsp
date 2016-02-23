<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.wsdl.messages" var="messages"/>

<fmt:message bundle="${messages}" key="erMessage.seeReport" var="caption" />
<c:if test="${not hideLink}">
    <c:set var="link">
        <syswf:control mode="anchor" targetTask="/artifact/${reportArtifact._uuid}" caption="${caption}" />
    </c:set>
</c:if>
<div class="UI SystemMessage ${style}">
    <div class="MessageContainer<c:if test="${style eq 'Error'}"> Icon ${style}</c:if>">
        <syswf:component prefix="pb" name="/core/report/reportProgress" wrap="false">
            <syswf:param name="reportArtifact" value="${reportArtifact}"/>
            <syswf:param name="onCompleteCallback" value="${onCompleteCallback}"/>
        </syswf:component>
        <div class="Text">
            <c:out value="${opening}" escapeXml="false"/>
            <c:out value="${message}" escapeXml="false"/>
            <c:out value="${link}" escapeXml="false"/>
        </div>
        <div class="x-clear"></div>
    </div>
</div>