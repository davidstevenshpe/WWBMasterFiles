 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tui_Message"/>

<%--c:choose>
     <c:when test="${selectionMode == 'multiple'}"--%>
        <syswf:component name="/core/table" prefix="relationship">
            <syswf:param name="customizationId" value="${tableDefinitionId}"/>
            <syswf:param name="selectionBag" value="${selectionBag}"/>
            <syswf:param name="datasource" value="${datasource}"/>
            <syswf:param name="useType" value="${useType}"/>
            <syswf:param name="wrapStyle" value="${wrapStyle}"/>
            <syswf:param name="wrapCaption" value="${wrapCaption}"/>
            <c:if test="${artifactDeleted}">
                    <syswf:param name="overrideselectionModel" value="none" />
            </c:if>
            <syswf:param name="direction" value="${direction}"/>
        </syswf:component>
     <%--/c:when>
     <c:otherwise>
         <syswf:component name="/core/impl/staticTable" prefix="relationship">
            <syswf:param name="customizationId" value="${tableDefinitionId}"/>
            <syswf:param name="selectionBag" value="${selectionBag}"/>
            <syswf:param name="datasource" value="${datasource}"/>
            <syswf:param name="wrapStyle" value="${wrapStyle}"/>
            <syswf:param name="wrapCaption" value="${wrapCaption}"/>
            <c:if test="${artifactDeleted}">
                <syswf:param name="overrideselectionModel" value="none" />
            </c:if>
            <syswf:param name="direction" value="${direction}"/>
        </syswf:component>
     </c:otherwise>
 </c:choose--%>


