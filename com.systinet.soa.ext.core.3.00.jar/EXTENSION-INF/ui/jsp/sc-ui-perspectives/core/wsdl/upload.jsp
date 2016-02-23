<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<c:if test="${actionVisible}">

    <fmt:setBundle basename="com.hp.systinet.sc.ui.imports.importsMessages" var="importsMessages"/>
    
    <fmt:message bundle="${importsMessages}" key="uploadWinTitle" var="winTitle" />
    <fmt:message bundle="${importsMessages}" key="Upload" var="winOkLabel" />

    <syswf:component name="/core/window" prefix="upWsdl">
        <syswf:param name="winComponent" value="/core/wsdl/uploadWindow" />
        <syswf:param name="winTitle" value="${winTitle}" />
        <syswf:param name="winOpenFunctionName" value="${controlName}" />
        <syswf:param name="winOkLabel" value="${winOkLabel}" />
        <syswf:param name="winOkAction" value="${prefix}upload" />
        <syswf:param name="winWidth" value="850" />
        <syswf:param name="winId" value="${prefix}win" />
        
        <syswf:param name="importFileBean" value="${importFileBean}"/>
    </syswf:component>
    
    <syswf:control mode="script" caption="${prefix}upload" action="upload" />

</c:if>