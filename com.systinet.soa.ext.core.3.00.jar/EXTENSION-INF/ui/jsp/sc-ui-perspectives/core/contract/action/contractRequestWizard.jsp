<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>
<fmt:message key="contractrequest.wizard.action" var="action" bundle="${tornadoui_Message}"/>

<c:if test="${render}">
    <syswf:control mode="anchor" caption="${action}" targetTask="/common/contract/contractRequestWizard">
        <syswf:param name="uuid" value="${artifact._uuid}"/>
        <syswf:param name="artifact" value="${artifact}"/>
        <syswf:attribute name="class" value="UI PageAction ApprovalRequest"/>
    </syswf:control>
</c:if>