<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.comments.commentsmessages" var="commentsMessages"/>
	<c:set var="modeName">${discussionBean.viewMode}</c:set>
	<c:if test="${'SingleThread' ne modeName}">
	
	<fmt:message var="newComment_caption" bundle="${commentsMessages}" key="contextActions.newComment.caption" />
    <c:if test="${not common}">
	<div class="EA-right-panel">
		<a id="${prefix}_new_comment_trigger" href="javascript:void(0);" class="UI PageAction NewComment"><span>${newComment_caption}</span></a>
	</div>
	</c:if>
	<c:if test="${common}">
    <div class="AJAXContainer">
        <a class="context-button NewComment" id="${prefix}_new_comment_trigger" href="javascript:void(0);" title="${newComment_caption}"></a>
    </div>
	</c:if>
	<script type="text/javascript">
	//<![CDATA[
	
	    Ext.onReady(function() {
	        ${functionPrefix}_new(Ext.get('${prefix}_new_comment_trigger'));

            // work-around for redundant menu button "..." - if exists
            // Ext.get('actions_list').hide().setStyle('display','none');
	    });
	
	//]]>
	</script>
	</c:if>
	
	<c:if test="${not empty discussionBean.pagerInfo and discussionBean.pagerInfo.totalCount > 0}">
	<c:if test="${discussionBean.canDelete}">
	    <c:if test="${not empty discussionBean.threadId}">
	        <fmt:message var="deleteThread_caption" bundle="${commentsMessages}" key="contextActions.deleteThread.caption" />
            <c:if test="${not common}">
	        <div class="EA-right-panel">
	        	<a id="${prefix}_delete_thread_trigger" href="javascript:void(0);" class="UI PageAction Delete"><span>${deleteThread_caption}</span></a>
	        </div>
            </c:if>
            <c:if test="${common}">
            <div class="AJAXContainer">
                <a class="context-button Remove" id="${prefix}_delete_thread_trigger" href="javascript:void(0);" title="${deleteThread_caption}"></a>
            </div>
            </c:if>
	        <script type="text/javascript">
	//<![CDATA[
	
	            Ext.onReady(function() {
	                ${functionPrefix}_delete(Ext.get('${prefix}_delete_thread_trigger'), '${discussionBean.threadId}');
	            });
	        
	//]]>
	</script>
	    </c:if>
	    
	    <c:if test="${empty discussionBean.threadId}">
	        <fmt:message var="deleteAll_caption" bundle="${commentsMessages}" key="contextActions.deleteAll.caption" />
            <c:if test="${not common}">
	        <div class="EA-right-panel">
	        	<a id="${prefix}_delete_all_trigger" href="javascript:void(0);" class="UI PageAction Delete"><span>${deleteAll_caption}</span></a>
	        </div>
            </c:if>
            <c:if test="${common}">
            <div class="AJAXContainer" id="${prefix}_delete_all_comments">
                <a class="context-button Remove" id="${prefix}_delete_all_trigger" href="javascript:void(0);" title="${deleteAll_caption}"></a>
            </div>
            </c:if>
	        <script type="text/javascript">
	//<![CDATA[
	
	            Ext.onReady(function() {
	                ${functionPrefix}_deleteAll(Ext.get('${prefix}_delete_all_trigger'));
                    // Ext.get('${prefix}_delete_all_comments').hide().setStyle('display','none');
	            });
	        
	//]]>
	</script>
	    </c:if>
	</c:if>
	</c:if>
