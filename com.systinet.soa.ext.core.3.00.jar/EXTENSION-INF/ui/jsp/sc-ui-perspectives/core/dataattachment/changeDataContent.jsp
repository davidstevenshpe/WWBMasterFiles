<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="hasNoContent" type="java.lang.Boolean"--%>
<%--@elvariable id="message" type="java.lang.String"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.imports.importsMessages" var="importsmessages"/>
<fmt:message var="linkCaption" key="changeDataContent" bundle="${importsmessages}"/>

<c:if test="${not common}"><%-- for compatibility with legacy versions --%>
  <c:set var="blockClassName">EA-left-panel</c:set>
  <c:set var="linkClassName">UI PageAction ChangeDataContent</c:set>
  <c:set var="linkText" value="${linkCaption}"/>
</c:if>
<c:if test="${common}"><%-- context buttons displayed at top content --%>
  <c:set var="blockClassName">AJAXContainer</c:set>
  <c:set var="linkClassName">context-button ChangeDataContent</c:set>
  <c:set var="linkText" value=" "/>
</c:if>

<c:if test="${not hasNoContent}">
  <div class="${blockClassName}">
    <syswf:component prefix="upload" name="/core/dataattachment/uploadDataContent">
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:param name="asLink" value="${true}"/>
        <syswf:param name="linkClass" value="${linkClassName}"/>
        <syswf:param name="linkCaption" value="${linkText}"/>
        <syswf:param name="hint" value="${linkCaption}"/>
        <syswf:param name="hasNoContent" value="${hasNoContent}"/>
    </syswf:component>
  </div>
</c:if>