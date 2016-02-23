<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />

<fmt:setBundle basename="com.hp.systinet.sync.ui.L10nUIMessages" var="L10nUIMessages" />
<fmt:message bundle="${L10nUIMessages}" key="Ppm.externalLinkTitle" var="label" />

<%--@elvariable id="importedFromExternal" type="boolean"--%>
<%--@elvariable id="externalUrl" type="java.lang.String"--%>

<c:if test="${not common}"><!-- for compatibility with legacy versions -->
  <c:set var="blockClassName">EA-left-panel</c:set>
  <c:set var="linkClassName">UI PageAction ExternalLink</c:set>
  <c:set var="linkText" value="${label}"/>
  <c:set var="linkTooltip" value="${label}"/>
</c:if>
<c:if test="${common}"><!-- context buttons displayed at top content -->
  <c:set var="blockClassName">AJAXContainer</c:set>
  <c:set var="linkClassName">context-button ExternalLink</c:set>
  <c:set var="linkText" value=""/>
  <c:set var="linkTooltip" value="${label}"/>
</c:if>

<c:if test="${importedFromExternal}">
    <c:if test="${not empty externalUrl}">
      <div class="${blockClassName}" id="${prefix}_linkWrapper">
        <a class="${linkClassName}" href="${externalUrl}" target="_blank" title="${linkTooltip}">${linkText}</a>
      </div>
    </c:if>
</c:if>
