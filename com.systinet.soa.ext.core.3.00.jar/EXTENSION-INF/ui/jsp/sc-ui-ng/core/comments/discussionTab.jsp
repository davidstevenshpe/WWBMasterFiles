<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.comments.commentsmessages" var="commentsmessages"/>
<fmt:message key="editPopup.title.replyCaption" var="replyCaption" bundle="${commentsmessages}" />
<fmt:message key="editPopup.title.caption" var="title" bundle="${commentsmessages}" />

<%-- Produces new, edit, reply, delete functions --%>
<syswf:component name="/core/comments/editPopup" prefix="commentPopup" wrap="false">
    <syswf:param name="artifactUuid" value="${artifact._uuid}"/>
    <syswf:param name="discussionBean" value="${discussionBean}"/>
    <syswf:param name="caption" value="${title}"/>
    <syswf:param name="replyCaption" value="${replyCaption}"/>
</syswf:component>

<syswf:component name="/core/customization/customizableComponent" prefix="columnLayout" wrap="false">
    <syswf:param name="customizationId" value="shared.comments"/>
    <syswf:param name="customizedComponent" value="/core/layout/columnsInternal"/>
    <syswf:param name="dontCustomize" value="true"/>
    
    <syswf:param name="functionPrefix" value="${prefix}_commentPopup"/>
    <syswf:param name="artifact" value="${artifact}"/>
    <syswf:param name="commentId" value="${commentId}"/> 
    <syswf:param name="threadId" value="${threadId}"/>
    <syswf:param name="discussionBean" value="${discussionBean}"/>
</syswf:component>
