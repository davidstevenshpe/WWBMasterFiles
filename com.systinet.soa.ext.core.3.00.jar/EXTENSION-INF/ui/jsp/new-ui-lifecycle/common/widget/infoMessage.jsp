<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="message" type="java.lang.String"--%>

<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>
<fmt:message var="infoMsg" key="info" bundle="${tornadoui_Message}"/>

<div class="UI SystemMessage Info Icon">
    <div class="MessageContainer" style="border-style: none;">
        <div class="Text">
            <c:out value="${message}" escapeXml="false"/>
        </div>
        <div class="x-clear"></div>
    </div>
</div>