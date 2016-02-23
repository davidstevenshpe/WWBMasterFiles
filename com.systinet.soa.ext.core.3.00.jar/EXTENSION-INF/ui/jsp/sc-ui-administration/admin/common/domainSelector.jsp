<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--
Parameters:  
jsOpenFunction = name of a function that opens the window, has to be bound to an element onClick method
windowTitle = title of the opened window
holder - implementation of DomainSelectorListener to hole selected domain.
--%>

<syswf:component name="/core/window" prefix="ds">
    <syswf:param name="winComponent" value="/admin/common/domainSelectorWindow" />
    <syswf:param name="winTitle" value="${windowTitle}" />
    <syswf:param name="winOpenFunctionName" value="${jsOpenFunction}" />
    <syswf:param name="winOkLabel" value="Select" />
    <syswf:param name="winOkAction" value="${prefix}changeDomain" />
    <syswf:param name="winId" value="${prefix}domainWindow" />
    <syswf:param name="winWidth" value="400" />
    
    <syswf:param name="artifact" value="${artifact}" />
    <syswf:param name="selectedDomainHolder" value="${selectedDomainHolder}" />
</syswf:component>

<c:choose>
<c:when test="${empty actionMode}">
    <syswf:control mode="script" action="changeDomain" caption="${prefix}changeDomain" affects="." />
</c:when>
<c:otherwise>
    <syswf:control mode="${actionMode}" action="changeDomain" caption="${prefix}changeDomain" />
</c:otherwise>
</c:choose>
