<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- Import the JSTL fmt. --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.platform.ui.design.DesignMessages" var="designMessages"/>
<fmt:message key="situationBar_signOutAnchor" var="signOutAnchor" bundle="${designMessages}"/>
<fmt:message key="situationBar_signOutAnchorHint" var="signOutAnchorHint" bundle="${designMessages}"/>

<syswf:control mode="anchor" targetTask="/logout" caption="${signOutAnchor}" hint="${signOutAnchorHint}">
    <syswf:attribute name="target" value="_top" />
    <syswf:attribute name="onclick" value="setCookie('isHideCustBox', 'false', '1')" />
</syswf:control>
