<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${actionVisible}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.wsdl.messages" var="messages"/>

<fmt:message bundle="${messages}" key="changeWSDL" var="changeWsdl" />

<c:if test="${not common}"><%-- for compatibility with legacy versions --%>
  <c:set var="blockClassName">EA-left-panel</c:set>
  <c:set var="linkClassName">UI PageAction ChangeServerFolder</c:set>
  <c:set var="linkText" value="${changeWsdl}"/>
</c:if>
<c:if test="${common}"><%-- context buttons displayed at top content --%>
  <c:set var="blockClassName">AJAXContainer</c:set>
  <c:set var="linkClassName">context-button ChangeServerFolder</c:set>
  <c:set var="linkText" value=""/>
</c:if>

<syswf:component name="/core/window" prefix="upWsdl">
    <syswf:param name="winComponent" value="/core/wsdl/uploadWindow" />
    <syswf:param name="winTitle" value="${changeWsdl}" />
    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
    <syswf:param name="winOkLabel" value="Upload" />
    <syswf:param name="winOkAction" value="${prefix}upload" />
    <syswf:param name="winWidth" value="850" />
    <syswf:param name="winId" value="${prefix}win" />
    
    <syswf:param name="importFileBean" value="${importFileBean}"/>
    <syswf:param name="enableCrdStore" value="${enableCrdStore}" />
</syswf:component>

<syswf:control mode="script" caption="${prefix}upload" action="upload" />
<div class="${blockClassName}">
<a href="javascript:void(0)" id="${prefix}link" class="${linkClassName}" title="${changeWsdl}"><span>${linkText}</span></a>
</div>
<script type="text/javascript">
//<![CDATA[

Ext.onReady(function() {
    attachOn('${prefix}link','click',${prefix}open);
    moveWindow('${prefix}_upWsdl','popupWindows');
});

//]]>
</script>

</c:if>