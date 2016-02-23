<%--

Parameters

- text (required)
- linkUrl and linkText - when supplied, a link will be displayed
- artifactUuid - when linkUrl is empty and this param is supplied, link to single view of this artifact will be displayed
                 with linkText as caption
- statusGetter - when supplied, a progress bar will be displayed
- isRunning - ProgressBarReloader.Running instance

--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<c:set var="link">
    <c:choose>
        <c:when test="${not empty linkUrl}"><a href="<c:out value="${linkUrl}"/>"><c:out value="${linkText}"/></a></c:when>
        <c:when test="${not empty artifactUuid}">
              <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="mrp" wrap="false">
                  <syswf:param name="uuid" value="${artifactUuid}"/>
                  <syswf:param name="caption" value="${linkText}"/>
              </syswf:component>
        </c:when>
    </c:choose>
</c:set>

<div class="UI SystemMessage ${class}">
    <div class="MessageContainer">
        <c:if test="${not empty statusGetter}">
            <syswf:component name="/core/impl/widgets/progressBar" prefix="infobar" wrap="false">
                <syswf:param name="statusGetter" value="${statusGetter}"/>
                <syswf:param name="isRunning" value="${isRunning}"/>
            </syswf:component>
        </c:if>
        <div class="Text">
            <c:out value="${opening}" escapeXml="false"/>
            <c:out value="${text}" escapeXml="false"/>
            <c:out value="${link}" escapeXml="false"/>
        </div>
        <div class="x-clear"></div>
    </div>
</div>