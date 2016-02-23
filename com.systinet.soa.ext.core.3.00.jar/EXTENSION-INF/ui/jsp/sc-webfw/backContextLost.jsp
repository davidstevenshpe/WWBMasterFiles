<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- Import the JSTL fmt. --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">       
	<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>
<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="frameworkJsp_Messagess"/>
<fmt:message key="error" var="errorText" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="backContextLost_title" var="contextLost" bundle="${frameworkJsp_Messagess}"/>

<%-- Get Messages. --%>
<fmt:message key="home" var="home" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="gotoProductHomePage" var="gotoProductHomePage" bundle="${webFrameworkUI_Messages}"/>

    <div class="shrPageTitle">
        <h2><c:out value="${contextLost}"/></h2>
        <span class="shrArtifactType"><c:out value="${errorText}"/></span>
        <div class="clear"></div>
    </div>
    <p class="shrWarning">
        <c:set var="controlGotoHomePage">
            <syswf:control mode="anchor" targetTask="/" caption="${home}" hint="${gotoProductHomePage}"/>
        </c:set>
        <fmt:message key="backContextLost_sorryMessage" bundle="${frameworkJsp_Messagess}">
            <fmt:param value="${controlGotoHomePage}"/>
        </fmt:message>
    </p>
