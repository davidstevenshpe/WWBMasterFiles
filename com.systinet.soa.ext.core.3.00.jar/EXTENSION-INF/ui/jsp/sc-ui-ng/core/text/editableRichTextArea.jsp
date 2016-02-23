<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="useful.link.instruction" bundle="${widgetMessages}" var="instructionMsg" />

<syswf:block className="UI Block Common">
<div class="Content">
    <c:choose>
        <c:when test="${empty contentBean.evaluatedContent and not canCustomize}">
            <c:out value="${instructionMsg}" escapeXml="false" />
        </c:when>
        <c:when test="${empty contentBean.evaluatedContent and canCustomize}">
            <c:out value="" escapeXml="false" />
        </c:when>
        <c:otherwise>
            <c:out value="${contentBean.evaluatedContent}" escapeXml="false" />
        </c:otherwise>
    </c:choose>
</div>
<c:if test="${canCustomize}">
<div class="Footer">
    <syswf:component name="/core/impl/customization/customizationEditor" prefix="editableRichTextArea">
	     <syswf:param name="customizationId" value="${customizationId}"/>
	     <syswf:param name="richText" value="true"/>
	     <syswf:param name="bean" value="${contentBean}"/>
	</syswf:component>
</div>
</c:if>
</syswf:block>