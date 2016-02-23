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

<%-- Get Messages. --%>
<fmt:message key="continue" var="continue" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="sessionExpired_homePage" var="homepage" bundle="${frameworkJsp_Messagess}"/>
<fmt:message key="gotoProductHomePage" var="gotoProductHomePage" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="error" var="errorText" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="sessionExpired_lostContext_title" var="expiredText" bundle="${frameworkJsp_Messagess}"/>

<div class="shrPageTitle">
    <h2><c:out value="${expiredText}"/></h2>
    <span class="shrArtifactType"><c:out value="${errorText}"/></span>
    <div class="clear"></div>
</div>
<p class="shrWarning">
    <%-- no longer possible in security model used in new Hermes deployment --%>
    <%--c:choose>
        <c:when test="${wasLoggedIn && (not empty previousTaskUri)}">
            <c:set var="controlContinue">
                <syswf:control mode="anchor" targetTask="${previousTaskUri}" caption="${continue}">
                    <c:if test="${not empty previousTaskParameters}">
                        <c:forEach var="parameter" items="${previousTaskParameters}">
                            <syswf:param name="${parameter.key}" value="${parameter.value}"/>
                        </c:forEach>
                    </c:if>
                </syswf:control>
            </c:set>
            <fmt:message key="sessionExpired_lostLoginInformationInstruction" bundle="${frameworkJsp_Messagess}">
                <fmt:param value="${controlContinue}"/>
            </fmt:message>
        </c:when>
        <c:otherwise--%>
            <c:set var="controlGoToHomePage">
                <syswf:control mode="anchor" targetTask="/" caption="${homepage}" hint="${gotoProductHomePage}"/>
            </c:set>
            <fmt:message key="sessionExpired_lostContextInformationInstruction" bundle="${frameworkJsp_Messagess}">
                <fmt:param value="${controlGoToHomePage}"/>
            </fmt:message>
        <%--/c:otherwise>
    </c:choose--%>
</p>