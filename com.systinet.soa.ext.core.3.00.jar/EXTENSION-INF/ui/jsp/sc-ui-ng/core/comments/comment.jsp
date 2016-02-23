<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.comments.commentsmessages" var="commentsmessages"/>

<c:set var="sortName">${discussionBean.sort}</c:set>
<c:set var="modeName">${discussionBean.viewMode}</c:set>
<c:set var="canDelete" value="${discussionBean.canDelete}"/>

<c:set var="level"> <c:if test="${'CommentList' ne modeName}">Level${comment.depth}</c:if></c:set>
<c:set var="direct"> <c:if test="${(comment.commentId eq discussionBean.commentId) and (comment.depth != 0)}">Direct</c:if></c:set>

<!-- BEGIN: COMMENT ITEM -->
<div class="Message ${level} ${direct}">

    <fmt:message key="comment.replyTitle" var="replyTitle" bundle="${commentsmessages}">
        <fmt:param value="${comment.title}" />
    </fmt:message>
    <c:set var="title"><c:choose>
        <c:when test="${comment.depth == 0}">${comment.title}</c:when>
        <c:when test="${position == 0 or 'CommentList' eq modeName}">${replyTitle}</c:when>
    </c:choose></c:set>
    
    <c:choose>
        <c:when test="${empty title}"></c:when>
        <c:when test="${'CommentList' eq modeName}">
            <div class="Subject">
                <syswf:component name="/core/comments/commentLinkRenderer" prefix="titleLink">
                    <syswf:param name="artifactUuid" value="${comment.artifactUuid}"/>
                    <syswf:param name="depth" value="${currentDepth - 1}"/>
                    <syswf:param name="caption" value="${title}"/>
                    <syswf:param name="commentId" value="${comment.commentId}"/>
                    <syswf:param name="threadId" value="${comment.threadId}"/>
                    <syswf:param name="viewMode">SingleThread</syswf:param>
                </syswf:component>
            </div>
        </c:when>
        <c:when test="${'AllThreads' eq modeName}">
            <div class="Subject">
                <syswf:component name="/core/comments/commentLinkRenderer" prefix="titleLink">
                    <syswf:param name="artifactUuid" value="${comment.artifactUuid}"/>
                    <syswf:param name="depth" value="${currentDepth - 1}"/>
                    <syswf:param name="caption" value="${title}"/>
                    <syswf:param name="commentId" value="${comment.commentId}"/>
                    <syswf:param name="threadId" value="${comment.threadId}"/>
                    <syswf:param name="viewMode">SingleThread</syswf:param>
                </syswf:component>
            </div>
        </c:when>
        <c:when test="${'SingleThread' eq modeName}">
            <div class="Subject">
                ${title}
            </div>
        </c:when>
    </c:choose>
    <div class="Author">
        <c:set var="atDate">
            <c:set var="shortAtDate"><syswf:value value="${comment.created}" dataType="shortDateTime" wrapper=""/></c:set>
            <c:set var="longAtDate"><syswf:value value="${comment.created}" dataType="dateTime" wrapper=""/></c:set>
            <span class="ItemDate" title="${longAtDate}">${shortAtDate}</span>
        </c:set>
    
        <c:set var="byWhom">
            <c:choose>
                <c:when test="${not empty author}">
                    <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="person_link" wrap="false">
                        <syswf:param name="caption" value="${author.name}" />
                        <syswf:param name="uuid" value="${author._uuid}" />
                    </syswf:component>
                </c:when>
                <c:otherwise>${comment.author}</c:otherwise>
            </c:choose>
        </c:set>
        ${fn:trim(byWhom)}, ${fn:trim(atDate)}
    </div>
    <div class="PostContainer">
        <div class="UI Text Description">
            ${comment.displayText}
        </div>
        <c:if test="${not discussionBean.artifactDeleted}">
        <div class="Controls">
            <div class="Actions">
                <%-- REPLY --%>
                <a id="${prefix}_replyComment_trigger" class="UI Icon Reply" href="javascript:void(0);"><span><fmt:message bundle="${commentsmessages}" key="comment.reply"/></span></a>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                    	<%-- element, id, title, text --%>
                        ${replyFunctionName}(Ext.get('${prefix}_replyComment_trigger'), '${comment.commentId}', '${comment.editTitle}', '');
                    });
                
//]]>
</script>
                
                <c:set var="canEdit" value="${userName eq comment.author and !comment.answered}" />
                <%-- EDIT only if author and no replies yet --%>
                <c:if test="${canEdit}">
                <a id="${prefix}_editComment_trigger" href="javascript:void(0);" class="UI Icon Edit"><span><fmt:message bundle="${commentsmessages}" key="comment.edit"/></span></a>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        <%-- element, id, title, text, editableTitle --%>
                        ${editFunctionName}(Ext.get('${prefix}_editComment_trigger'), '${comment.commentId}', '${comment.editTitle}', '${comment.editText}', ${empty comment.parentId});
                    });
                
//]]>
</script>
                </c:if>
                
                <%-- DELETE if artifactOwner or author and no replies yet --%>
                <c:if test="${canDelete or canEdit}">
                <a id="${prefix}_deleteComment_trigger" href="javascript:void(0);" class="UI Icon Delete"><span><fmt:message bundle="${commentsmessages}" key="comment.delete"/></span></a>
                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        <%-- element, id --%>
                        ${deleteFunctionName}(Ext.get('${prefix}_deleteComment_trigger'), '${comment.commentId}');
                    });
                
//]]>
</script>
                </c:if>
            </div>
            <div class="x-clear"></div>
        </div>
        </c:if>
    </div>
</div>
<hr/>
<!-- END: COMMENT ITEM -->
