<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not common}"><!-- for compatibility with legacy versions -->
  <c:set var="blockClassName">EA-right-panel</c:set>
  <c:set var="linkClassName">UI PageAction</c:set>
</c:if>
<c:if test="${common}"><!-- context buttons displayed at top content -->
  <c:set var="blockClassName">AJAXContainer</c:set><%-- or 'UI Block Green' --%>
  <c:set var="linkClassName">context-button</c:set>
</c:if>

<c:if test="${not empty discussionBean.pagerInfo and discussionBean.pagerInfo.totalCount > 0}">
<fmt:setBundle basename="com.hp.systinet.sc.ui.comments.commentsmessages" var="commentsMessages"/>

<div class="${blockClassName}">
    <div class="Content">
        
        <c:forEach items="${discussionBean.linkedModes}" var="mode">
            <c:set var="modeName">${mode}</c:set>
            <c:set var="modeClass">
              <c:if test="${'CommentList' eq modeName}">${linkClassName} ListView</c:if>
              <c:if test="${'CommentList' ne modeName}">${linkClassName} ThreadView</c:if><%-- 'AllThreads' or 'SingleThread' or default --%>
            </c:set>
            <fmt:message var="modeCaption" bundle="${commentsMessages}" key="viewSwitch.linkToMode.${modeName}" />
            <syswf:component name="/core/comments/commentLinkRenderer" prefix="${modeName}">
                <syswf:param name="artifactUuid" value="${artifactUuid}"/>
                <syswf:param name="depth" value="${currentDepth}"/>
                <c:if test="${not common}">
                  <syswf:param name="caption" value="${modeCaption}"/>
                </c:if>
                <c:if test="${common}">
                  <syswf:param name="hint" value="${modeCaption}"/>
                </c:if>
                <syswf:param name="viewMode" value="${modeName}"/>
                <syswf:param name="threadId" value="${discussionBean.threadId}"/>
                <syswf:param name="class" value="${modeClass}"/>
                <syswf:param name="commentId" value=""/>
            </syswf:component>
        </c:forEach>
        
        <c:if test="${fn:length(discussionBean.sortWays) > 1}">
            <c:set var="sortName">${discussionBean.sort}</c:set>
            <c:set var="sortClass">
            <c:if test="${'CommentsByDateOldestFirst' eq sortName}">${linkClassName} SortByTimeAsc</c:if>
            <c:if test="${'CommentsByDateOldestFirst' ne sortName}">${linkClassName} SortByTimeDesc</c:if><%-- 'CommentsByDateNewestFirst' or default --%>
            </c:set>
        
            <fmt:message var="sortCaption" bundle="${commentsMessages}" key="viewSwitch.sort.${sortName}" />
            <fmt:message var="sortTitle" bundle="${commentsMessages}" key="viewSwitch.sortTitle" />

            <c:if test="${not common}">
            <span class="${sortClass}"> ${sortTitle} <a id="${prefix}_sort-more" href="javascript:void(0);" class="More"><span>${sortCaption}</span></a></span>
            </c:if>
            <c:if test="${common}">
            <div class="action-button" id="${prefix}_sort-more">
              <a class="${sortClass}" href="javascript:void(0);" title="${sortTitle} ${sortCaption}"></a>
            </div>
            </c:if>

            <div class="x-hidden flyout-menu UI Dropdown" id="${prefix}_sort-more_src">
                <div class="DropdownContent">
                    <ul class="SortTypeList">
                        <c:forEach items="${discussionBean.sortWays}" var="sort">
                            <c:set var="sortName">${sort}</c:set>
                            <fmt:message var="sortCaption" bundle="${commentsMessages}" key="viewSwitch.sort.${sortName}" />
                            <c:set var="sortClass">
                                <c:choose>
                                    <c:when test="${'CommentsByDateOldestFirst' eq sortName}">NewerFirst</c:when>
                                    <c:when test="${'CommentsByDateNewestFirst' eq sortName}">OlderFirst</c:when>
                                    <c:otherwise>NewerFirst</c:otherwise>
                                </c:choose>
                            </c:set>
                            <c:set var="activeClass"><c:if test="${discussionBean.sort eq sort}">Active</c:if></c:set>
                            <li>
                                <syswf:component name="/core/comments/commentLinkRenderer" prefix="${sortName}">
                                    <syswf:param name="artifactUuid" value="${artifactUuid}"/>
                                    <syswf:param name="depth" value="${currentDepth}"/>
                                    <syswf:param name="caption" value="${sortCaption}"/>
                                    <syswf:param name="viewMode">${discussionBean.viewMode}</syswf:param>
                                    <syswf:param name="commentId" value="${discussionBean.commentId}"/>
                                    <syswf:param name="threadId" value="${discussionBean.threadId}"/>
                                    <syswf:param name="sort" value="${sortName}"/>
                                    <syswf:param name="class" value="${sortClass} ${activeClass}"/>
                                </syswf:component>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <script type="text/javascript">
                //<![CDATA[

                Ext.onReady(function() { 
                    Dropdown.init('${prefix}_sort-more', '${prefix}_sort-more_src', {});
                });
                //]]>
            </script>
        </c:if>
    </div>
</div>
</c:if>
