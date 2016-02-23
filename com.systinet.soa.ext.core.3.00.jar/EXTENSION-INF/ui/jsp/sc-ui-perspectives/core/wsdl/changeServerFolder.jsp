<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.wsdl.messages" var="messages"/>
<fmt:message bundle="${messages}" key="wsdl.change.contextAction" var="linkCaption"/>

<c:if test="${not common}"><%-- for compatibility with legacy versions --%>
  <c:set var="blockClassName">EA-left-panel</c:set>
  <c:set var="linkClassName">UI PageAction ChangeServerFolder</c:set>
  <c:set var="linkText" value="${linkCaption}"/>
</c:if>
<c:if test="${common}"><%-- context buttons displayed at top content --%>
  <c:set var="blockClassName">AJAXContainer</c:set>
  <c:set var="linkClassName">context-button ChangeServerFolder</c:set>
  <c:set var="linkText" value=""/>
</c:if>

<c:if test="${display and not empty changeServerFolderBean.fileName and not empty changeServerFolderBean.serverFolder}">

<syswf:component name="/core/window" prefix="w">
    <syswf:param name="winComponent" value="/core/impl/wsdl/changeServerFolderWindow" />
    <syswf:param name="winTitle"><fmt:message bundle="${messages}" key="wsdl.change.contextAction" /></syswf:param>
    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
    <syswf:param name="winOkLabel"><fmt:message bundle="${messages}" key="wsdl.change.changeFolder" /></syswf:param>
    <syswf:param name="winOkAction" value="${prefix}changeFolder" />
    <syswf:param name="winId" value="${prefix}changeServerFolderWin"/>
    <syswf:param name="changeServerFolderBean" value="${changeServerFolderBean}" />
</syswf:component>

<syswf:control mode="script" action="changeFolder" caption="${prefix}changeFolder" />
<div class="${blockClassName}">
<a href="javascript:void(0)" class="${linkClassName}" title="${linkCaption}" id="${prefix}anchor"><span>${linkText}</span></a>
</div>
<script type="text/javascript">
//<![CDATA[

Ext.onReady(function() {
    attachOn('${prefix}anchor','click',${prefix}open);
    moveWindow('${prefix}changeServerFolderWin','popupWindows');
});

//]]>
</script>

</c:if>