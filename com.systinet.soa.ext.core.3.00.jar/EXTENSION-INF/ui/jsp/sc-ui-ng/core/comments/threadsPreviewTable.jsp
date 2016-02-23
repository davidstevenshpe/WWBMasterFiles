<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.comments.commentsmessages" var="messages" />

<%-- Discussion (title) --%>
<fmt:message key="threadsPreview.title" bundle="${messages}" var="title" />
<%-- Enter Discussion --%>
<fmt:message key="threadsPreview.enterDiscussion" bundle="${messages}" var="enterDiscussion" />
<%-- Last Comment --%>
<fmt:message key="threadsPreview.lastComment" bundle="${messages}" var="lastComment" />

<c:if test="${not empty this.comments}">
    <syswf:block className="UI Block Common Last">
        <div class="Title">
            <h3><span>${title}</span></h3>
        </div>
        <div class="Content">
            <ul class="DiscussionList">
                <c:forEach items="${this.comments}" var="comment">
                <li>
                    <div class="Title">
                        <syswf:component name="/core/comments/commentLinkRenderer" prefix="threadLink${comment.commentId}" wrap="false">
                            <syswf:param name="uuid" value="${uuid}" />
                            <syswf:param name="caption" value="${comment.title}" />
                            <syswf:param name="threadId" value="${comment.threadId}" />
                        </syswf:component>
                        <span><fmt:message key="threadsPreview.commentCount" bundle="${messages}">
                            <fmt:param value="${comment.threadInfo.commentCount}"/>
                        </fmt:message></span>
                    </div>
                    <div class="Meta">
                        <span>${lastComment}</span>
                        
                        <c:set var="shortAtDate"><syswf:value value="${comment.created}" dataType="shortDateTime" wrapper=""/></c:set>
                        <c:set var="longAtDate"><syswf:value value="${comment.created}" dataType="dateTime" wrapper=""/></c:set>
                        <c:set var="author" value="${this.authors[comment.author]}" />
                        <c:set var="byWhom">
                            <c:choose>
                                <c:when test="${not empty author}">${author.name}</c:when>
                                <c:otherwise>${comment.author}</c:otherwise>
                            </c:choose>
                        </c:set>
                        <syswf:component name="/core/comments/commentLinkRenderer" prefix="commentLink${comment.commentId}" wrap="false">
                            <syswf:param name="uuid" value="${uuid}" />
                            <syswf:param name="caption" value="${fn:trim(byWhom)}, ${fn:trim(shortAtDate)}" />
                            <syswf:param name="hint" value="${longAtDate}" />
                            <syswf:param name="commentId" value="${comment.commentId}" />
                            <syswf:param name="threadId" value="${comment.threadId}" />
                        </syswf:component> 
                    </div>
                </li>
                </c:forEach>
            </ul>
            <div class="DiscussionControls">
                <syswf:component name="/core/comments/commentLinkRenderer" prefix="enterDiscussionLink" wrap="false">
                    <syswf:param name="uuid" value="${uuid}" />
                    <syswf:param name="caption" value="${enterDiscussion}" />
                </syswf:component> 
            </div>
        </div>
    </syswf:block>
</c:if>