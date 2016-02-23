<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- Import the JSTL fmt. --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">       
	<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.webfw.ui.layout.LayoutMessages" var="layout_Messages"/>

<%-- Get Messages. --%>
<fmt:message key="common_leftPlacedButtons" var="leftPlacedButtons" bundle="${layout_Messages}"/>
<fmt:message key="common_pageTitleButtons" var="pageTitleButtons" bundle="${layout_Messages}"/>
<fmt:message key="common_pageMainContent" var="pageMainContent" bundle="${layout_Messages}"/>
<fmt:message key="common_mainActions" var="mainActions" bundle="${layout_Messages}"/>
<fmt:message key="common_advancedActions" var="advancedActions" bundle="${layout_Messages}"/>
<fmt:message key="common_pageAdditionContent" var="pageAdditionContent" bundle="${layout_Messages}"/>
<fmt:message key="common_messageBox" var="messageBox" bundle="${layout_Messages}"/>
<fmt:message key="common_infoBox" var="infoBox" bundle="${layout_Messages}"/>

<syswf:layout name="/layout/plainV3Layout">
  	<syswf:box name="leftButtons" caption="${leftPlacedButtons}"/>
  	<syswf:box name="pageTitleButtons" caption="${pageTitleButtons}"/>
  	<syswf:box name="mainPageActions" caption="${mainActions}"/>
  	<syswf:box name="advancedActions" caption="${advancedActions}"/>
  	<syswf:box name="content" caption="${pageMainContent}"/>
  	<syswf:box name="contentExt" caption="${pageAdditionContent}"/>
  	<syswf:box name="message" caption="${messageBox}"/>
  	<syswf:box name="info" caption="${infoBox}"/>
</syswf:layout>