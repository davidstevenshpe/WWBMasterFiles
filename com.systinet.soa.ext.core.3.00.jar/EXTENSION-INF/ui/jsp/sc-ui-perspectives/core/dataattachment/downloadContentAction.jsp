<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.wsdl.messages" var="messages"/>
<fmt:message bundle="${messages}" key="dataattachement.downloadContent" var="caption" />

<c:if test="${not common}"><%-- for compatibility with legacy versions --%>
  <c:set var="blockClassName">EA-left-panel</c:set>
  <c:set var="linkClassName">UI PageAction Download</c:set>
  <c:set var="linkText" value="${caption}"/>
</c:if>
<c:if test="${common}"><%-- context buttons displayed at top content --%>
  <c:set var="blockClassName">AJAXContainer</c:set>
  <c:set var="linkClassName">context-button Download</c:set>
  <c:set var="linkText" value=""/>
</c:if>

<c:if test="${showAction}">
  <div class="${blockClassName}">
    <syswf:control mode="anchor" targetTask="/common/downloadContent" caption="${linkText}" hint="${caption}">
        <syswf:param name="uuid" value="${artifact._uuid}" />
        <syswf:attribute name="class" value="${linkClassName}" />
    </syswf:control>
  </div>
</c:if>