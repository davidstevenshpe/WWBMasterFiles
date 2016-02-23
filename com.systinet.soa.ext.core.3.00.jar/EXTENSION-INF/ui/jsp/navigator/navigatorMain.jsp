<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.platform.ui.layouts.LayoutsMessages" var="layouts_Message"/>
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>
<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="frameworkJsp_Messagess"/>
<fmt:setBundle basename="com.hp.systinet.platform.rebranding" var="rebranding_Messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="newui_Messages"/>
<fmt:setBundle basename="com.hp.systinet.platform.ui.person.PersonMessages" var="person_messages"/>

<fmt:message key="designV3.designV3Main_rootLayout" var="varRootLayout" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_status" var="varStatus" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_content" var="varContent" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_navigation" var="varNavigation" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_notices" var="varNotices" bundle="${layouts_Message}"/>
<fmt:message key="designV3.designV3Main_leftMenu" var="varLeftMenu" bundle="${layouts_Message}"/>

<fmt:message var="poweredBy" key="rebranding.poweredByFooter" bundle="${rebranding_Messages}"/>
<fmt:message var="coCopyrightBefore" key="rebranding.coCopyright.before" bundle="${rebranding_Messages}"/>
<fmt:message var="coCopyrightAfter" key="rebranding.coCopyright.after" bundle="${rebranding_Messages}"/>

<fmt:message key="rebranding.logoProductName" var="productName" bundle="${rebranding_Messages}"/>
<fmt:message key="productText" var="productText" bundle="${webFrameworkUI_Messages}"/>
<c:if test="${not empty captionKey}">
    <c:set var="params" value="?captionKey=${captionKey}"/>
</c:if>
<c:if test="${not empty uuid}">
    <c:set var="params" value="${params}&uuid=${uuid}"/>
</c:if>
<c:if test="${not empty layoutId}">
    <c:set var="params" value="${params}&navigatorLayoutId=${layoutId}"/>
</c:if>
<c:if test="${not empty layoutModeId}">
    <c:set var="params" value="${params}&navigatorModeId=${layoutModeId}"/>
</c:if>

<c:if test="${not empty highlight}">
    <c:set var="params" value="${params}&highlight=${highlight}"/>
</c:if>
<c:if test="${not empty history}">
    <c:set var="params" value="${params}&history=${history}"/>
</c:if>
<syswf:panel name="main" wrap="false">

  <syswf:layout name="/navigator/layout/navigatorLayout">
	<syswf:box name="main" caption="${varRootLayout}"/>
  </syswf:layout>

	<syswf:area caption="header" name="header" defaultBox="header">
				
		<div id="systinet-application-header-left" onclick="javascript:window.location='<c:out value="${webdataPath}"/>/../../..'">
			<h1 class="Logo">${productName}</h1>			
		</div>
	</syswf:area>
	<syswf:area caption="domainselection" name="domainselection" defaultBox="domainselection">
		<div id="systinet-application-header-domain">
			<syswf:component name="/core/impl/layout/domainSelection" prefix="domainselection">				
				<syswf:param name="activeTab" value="navigator"/>	
				<syswf:param name="context" value="${context}"/>
			</syswf:component>			
		</div>
	</syswf:area>
	<syswf:area caption="search" name="search" defaultBox="search">
		<div id="systinet-application-header-search">
			<syswf:component name="/core/search/headerSearch" prefix="headerSearch">
				<syswf:param name="defaultView" value="${defaultView}"/>
				<syswf:param name="wrap" value="false"/>
			</syswf:component>
		</div>
	</syswf:area>
    <syswf:area caption="userevent" name="userevent" defaultBox="userevent">
		<div id="systinet-application-header-right">
			<syswf:component name="/core/impl/layout/userControls" prefix="userControls">
				<syswf:param name="defaultView" value="${defaultView}"/>
				<syswf:param name="eventCfgOpenFn" value="${eventCfgOpenFn}"/>
			</syswf:component>
		</div>
	</syswf:area>
	
  <syswf:area caption="${varContent}" name="content" defaultBox="content" placementPriority="1">
    <syswf:component name="${contentArea}" prefix="content" params="${contentParameters}"/>
  </syswf:area>

  <syswf:area caption="${varNavigation}" name="navigation" defaultBox="navigation">
	<syswf:component name="/core/impl/layout/tabs" prefix="tabs" wrap="false">
        <syswf:param name="activeTab" value="navigator"/>
	</syswf:component>
  </syswf:area>

  <syswf:area caption="${varNavigation}" name="flash" defaultBox="flash">
	<iframe id="nav_frame" src="${webContext}/service-catalog/navigator${params}" width="100%" style="z-index: 1;">
	</iframe>		
  </syswf:area>
</syswf:panel>