<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<c:set var="contentPopUp">
  <p class="Warning">${confirmMessage}</p>
</c:set>

<syswf:component name="/core/window" prefix="browsePopup">
    <syswf:param name="winTitle">${title}</syswf:param>
    <syswf:param name="winOpenFunctionName" value="${winOpenFunctionName}"/>    
    <syswf:param name="winOkLabel"><fmt:message key="ok" bundle="${bundle}"/></syswf:param>
    <syswf:param name="winOkAction" value="${winOkAction}"/>
    <c:if test="${not empty winCancelAction}">
        <syswf:param name="winCancelAction" value="${winCancelAction}"/>    
    </c:if>
    <syswf:param name="winCancelLabel"><fmt:message key="cancel" bundle="${bundle}"/></syswf:param>
    <syswf:param name="winButtonAlign" value="right"/>
    <syswf:param name="winRenderContents" value="true" />
    <syswf:param name="winResizable" value="false"/>
    <syswf:param name="winContents" value="${contentPopUp}"/>
</syswf:component>