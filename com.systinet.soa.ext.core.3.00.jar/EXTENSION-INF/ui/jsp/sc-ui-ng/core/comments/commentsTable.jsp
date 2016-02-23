<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.comments.commentsmessages" var="commentsMessages"/>

<c:set var="modeName">${discussionBean.viewMode}</c:set>
<c:set var="modeClass">
    <c:choose>
        <c:when test="${'CommentList' eq modeName}">UI Messageboard ListView</c:when>
        <c:when test="${'AllThreads' eq modeName}">UI Messageboard ThreadView</c:when>
        <c:otherwise>UI Messageboard ThreadView</c:otherwise>
    </c:choose>
</c:set>

<hr class="float-clear" />

<syswf:block className="${modeClass}">
<!-- BEGIN: COMMENTS -->
<div class="MessageboardContainer">

    <div class="Content">
        
        <c:forEach items="${pagerInfo.items}" var="comment" varStatus="status">
            <syswf:component name="/core/comments/comment" prefix="${status.index}" wrap="false">
                <syswf:param name="comment" value="${comment}" />
                <syswf:param name="position" value="${status.index}" />
                <syswf:param name="author" value="${authors[comment.author]}" />
                <syswf:param name="discussionBean" value="${discussionBean}" />
                <syswf:param name="replyFunctionName" value="${functionPrefix}_reply" />
                <syswf:param name="editFunctionName" value="${functionPrefix}_edit" />
                <syswf:param name="deleteFunctionName" value="${functionPrefix}_delete" />
            </syswf:component>
        </c:forEach>

        <c:if test="${empty pagerInfo.items}">
            <syswf:component name="/core/impl/layout/uiMessage" prefix="${type}${i.index}" >
                <syswf:param name="type" value="info" />
                <syswf:param name="controls" value="${message.controls}" />
                <c:choose>
                    <c:when test="${not discussionBean.artifactDeleted}">
                        <syswf:param name="text">
                            <fmt:message key="commentsTable.empty.noDiscussion" bundle="${commentsMessages}" /> <a href="javascript:void(0);" id="${prefix}_noData"><fmt:message key="commentsTable.empty.addComment" bundle="${commentsMessages}" /></a>
                            <script type="text/javascript">
//<![CDATA[

                                Ext.onReady(function() {
                                    ${functionPrefix}_new(Ext.get('${prefix}_noData'));
                                });
                            
//]]>
</script>
                        </syswf:param>
                    </c:when>
                    <c:otherwise>
                        <syswf:param name="text">
                            <fmt:message key="commentsTable.empty.deletedArtifact" bundle="${commentsMessages}" />
                        </syswf:param>
                    </c:otherwise>
                </c:choose>
            </syswf:component>
        </c:if>
    </div>
    <!-- END: COMMENTS -->
</div>
<syswf:component name="/core/comments/pager" prefix="pager" wrap="false">
    <syswf:param name="pagerInfo" value="${pagerInfo}" />
    <syswf:param name="discussionBean" value="${discussionBean}" />
</syswf:component>

</syswf:block>


