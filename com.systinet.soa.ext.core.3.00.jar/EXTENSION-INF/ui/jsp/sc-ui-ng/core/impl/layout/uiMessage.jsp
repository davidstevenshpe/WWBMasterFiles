<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- 
Possible sets of parameters:
	controls + text
	type or class
	
	text
	type or class
 --%>

<c:if test="${not empty type}">
    <c:choose>
        <c:when test="${type eq 'info'}">
            <c:set var="class">Info</c:set>
        </c:when>
        <c:when test="${type eq 'warning'}">
            <c:set var="class">Warning</c:set>
        </c:when>
        <c:when test="${type eq 'error'}">
            <c:set var="class">Error</c:set>
        </c:when>
    </c:choose>

</c:if>

<c:choose>
	<c:when test="${not empty controls}">
		<div class="<c:out value="${class}"/> withActions">
			<div class="shrFloatLeft">
				<c:out value="${text}" escapeXml="false"/>
			</div>
			<div class="shrFloatRight">
				<c:out value="${controls}" escapeXml="false"/>
			</div>
			<div class="clear">&nbsp;</div>
		</div>
	</c:when>
	<c:otherwise>
		<div class="UI SystemMessage ${class}">
            <c:set var="iconClass"><c:if test="${not empty icon}">Icon ${icon}</c:if></c:set>
            <div class="MessageContainer ${iconClass}">
                <div class="Text"><c:out value="${text}" escapeXml="false"/></div>
                <div class="x-clear"></div>
            </div>
		</div>
	</c:otherwise>
</c:choose>
