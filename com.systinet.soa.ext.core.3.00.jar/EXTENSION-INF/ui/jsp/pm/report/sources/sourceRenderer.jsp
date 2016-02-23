<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.policy.ui.UiPolicyL10n" var="messages"/>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="codeDivId" type="java.lang.String"--%>
<%--@elvariable id="codeTagId" type="java.lang.String"--%>
<%--@elvariable id="resourceFieldId" type="java.lang.String"--%>
<%--@elvariable id="bean" type="com.hp.systinet.policy.ui.report.sources.PanelBean"--%>
<%--@elvariable id="onAjaxRequest" type="java.lang.Boolean"--%>
<c:set var="resourceDetail" value="${bean.activeResource.detail}"/>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        <c:if test="${onAjaxRequest}">
            $("#${codeTagId}").chili(); <%-- needed to get syntax highlighting --%>
        </c:if>
        <c:if test="${not empty bean.activeIssue}">
            RichCode.Line.GoTo('${codeDivId}', ${bean.activeIssue.lineIndex + 1})
        </c:if>
    });    

//]]>
</script>

<syswf:input id="${resourceFieldId}" mode="hidden" name="resourceId" value="${bean.activeResource.id}"/>

<c:set var="flagIdPrefix" value="${prefix}_line_"/>
<div class="com_richcode OffsetTop" id="${codeDivId}">
    <div class="Scroll">
        <div class="ScrollContent">
            <div class="LineHighlight">
                <c:forEach items="${resourceDetail.lines}" var="line" varStatus="status"
                           end="${resourceDetail.lastLineIndexWithIssue}">
                    <c:set var="lineClass">
                        <c:choose>
                            <c:when test="${empty line.issues}"/>
                            <c:when test="${line.withErrors}">Error</c:when>
                            <c:otherwise>Warning</c:otherwise>
                        </c:choose>
                    </c:set>
                    <div class="Line ${fn:trim(lineClass)}"></div><!-- line ${status.index + 1} -->
                </c:forEach>
            </div>

            <div class="LineFlags">
                <c:forEach items="${resourceDetail.lines}" var="line" varStatus="status"
                           end="${resourceDetail.lastLineIndexWithIssue}">
                    <c:set var="lineClass">
                        <c:choose>
                            <c:when test="${empty line.issues}"/>
                            <c:when test="${line.withErrors}">UI Icon Error</c:when>
                            <c:otherwise>UI Icon Warning</c:otherwise>
                        </c:choose>
                    </c:set>
                    <div class="Line ${fn:trim(lineClass)}" id="${flagIdPrefix}${status.index + 1}"></div>
                </c:forEach>
            </div>

            <c:forEach items="${resourceDetail.linesWithIssues}" var="row" varStatus="rowStatus">
                <c:set var="flagId" value="${flagIdPrefix}${row.index + 1}"/>
                <c:set var="flagContentId" value="${flagId}_content"/>
                <div class="x-hidden flyout-menu UI Dropdown" id="${flagContentId}">
                    <div class="DropdownContent">
                        <c:forEach items="${row.issues}" var="issue" varStatus="issueStatus">
                            <c:set var="assertionLink">
                                <syswf:component prefix="assertion_${issue.id}"
                                                 name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                    <syswf:param name="uuid" value="${issue.assertionUuid}"/>
                                    <syswf:param name="caption" value="${issue.assertionName}"/>
                                </syswf:component>
                            </c:set>
                            <c:set var="policyLink">
                                <syswf:component prefix="policy_${issue.id}"
                                                 name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                    <syswf:param name="uuid" value="${issue.policyUuid}"/>
                                    <syswf:param name="caption" value="${issue.policyName}"/>
                                </syswf:component>
                            </c:set>
                            <strong class="UI Icon ${issue.error ? 'EventFailed' : 'Warning'}">
                                <fmt:message key="annotatedSources.assertionInfo" bundle="${messages}">
                                    <fmt:param value="${fn:trim(assertionLink)}"/>
                                    <fmt:param value="${fn:trim(policyLink)}"/>
                                </fmt:message>
                            </strong>
                            <p class="Comment"><c:out value="${issue.hint}"/></p>
                            <c:if test="${not issueStatus.last}"><hr/></c:if>
                        </c:forEach>
                    </div>
                </div>

                <script type="text/javascript">
//<![CDATA[

                    Ext.onReady(function() {
                        Dropdown.init('${flagId}', '${flagContentId}', {align: 'tl-tr?', forceRefresh: true});
                    });
                
//]]>
</script>
            </c:forEach>


<code><div class="TextScroll"><pre id="${codeTagId}" class="xml"><c:forEach items="${resourceDetail.lines}" var="row"><c:out
        value="${row.text}"/>
</c:forEach></pre></div></code>
            
        </div>
    </div>
</div>
