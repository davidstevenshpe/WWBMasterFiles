<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="cust_Message"/>

<syswf:control caption="${prefix}_restore" mode="script" action="restore" />

<fmt:message key="customizations.restore.confirm" var="restoreConfirmText" bundle="${cust_Message}">
   <fmt:param>
      <syswf:out context="HtmlBody" value="${releaseName}"/>
   </fmt:param>
</fmt:message>
<fmt:message key="customizations.restore.title" var="restoreConfirmTitle" bundle="${cust_Message}" />

<syswf:component name="/core/util/confirmPopUp" prefix="restoreConfirmPopUp">
        <syswf:param name="winOpenFunctionName" value="${prefix}_openRestoreConfirmPopUp" />
        <syswf:param name="winOkAction" value="${prefix}_restore" />
        <syswf:param name="confirmMessage" value="${restoreConfirmText}" />
        <syswf:param name="title" value="${restoreConfirmTitle}" />
</syswf:component>

<c:if test="${not oldest}">
    <fmt:message key="export_customizations" var="export_caption" bundle="${cust_Message}"/>
    <syswf:control caption="${export_caption}" mode="anchor" targetTask="/common/downloadCustomizations">
        <syswf:param name="releaseId" value="${releaseId}"/>
        <syswf:attribute name="class" value="UI Icon Download"/>
    </syswf:control>
</c:if>    

<c:if test="${(not newest) or oldest}">
    <fmt:message key="restore_customizations" var="restore_caption" bundle="${cust_Message}"/>
    
    <a href="javascript: ${prefix}_openRestoreConfirmPopUp();" class="UI Icon ChangeProject">${restore_caption}</a>
    
    <%--
    <syswf:control caption="${restore_caption}" mode="anchor" action="restore">
        <syswf:attribute name="class" value="UI Icon ChangeProject"/>
    </syswf:control>
    --%>
</c:if>
