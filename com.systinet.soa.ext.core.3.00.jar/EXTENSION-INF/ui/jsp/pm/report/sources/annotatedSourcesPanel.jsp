<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.policy.ui.UiPolicyL10n" var="messages"/>

<%--@elvariable id="bean" type="com.hp.systinet.policy.ui.report.sources.PanelBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<c:if test="${not empty bean}">
    <%-- id of code div --%>
    <c:set var="codeDivId" value="${prefix}_codeDiv"/>
    <%-- id of code tag --%>
    <c:set var="codeTagId" value="${prefix}_codeTag"/>
    <%-- id of hidden input field holding the id of the resource displayed in source renderer --%>
    <c:set var="resourceFieldId" value="${prefix}_shownRes"/>
    <script type="text/javascript">
    //<![CDATA[

        Ext.onReady(function() {
            RichCode.URI.LoadParams();
        });
    
    //]]>
    </script>

    <div class="RichCodeWrapper">
        <div class="com_richcode">
            <div class="Scroll Short">
                <div class="LineReportList">
                    <fmt:message key="annotatedSources.viewSourceLink" bundle="${messages}" var="jumpLabel"/>
                    <c:forEach items="${bean.resources}" var="resource" varStatus="resourceStatus">
                        <%-- id of jump-to-resource anchor --%>
                        <c:set var="resourceLinkId" value="${prefix}_resources_${resourceStatus.index}"/>
                        <c:set var="activateResourceFn" value="${prefix}_activate_${resourceStatus.index}"/>
                        <c:set var="resourceLink">
                            <c:choose>
                                <c:when test="${not empty resource.externalResourceUri}">
                                    <a href="${resource.externalResourceUri}"
                                            ><span><c:out value="${resource.name}"/></span></a>
                                </c:when>
                                <c:otherwise>
                                    <syswf:component prefix="resource${resourceStatus.index}"
                                                     name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                        <syswf:param name="uuid" value="${resource.artifactUuid}"/>
                                        <syswf:param name="caption" value="${resource.name}"/>
                                    </syswf:component>
                                </c:otherwise>
                            </c:choose>
                        </c:set>
                        <syswf:control id="${activateResourceFn}" mode="script" action="activate"
                                       caption="${activateResourceFn}" affects=".">
                            <syswf:param name="resource" value="${resource}"/>
                        </syswf:control>
                        <div class="LineReport GroupTitle">
                            ${resourceLink}
                            <small>(<a href="javascript:void(0)" id="${resourceLinkId}"
                                       class="UI Icon FindLine"><span><syswf:out value="${jumpLabel}" context="HtmlBody"/></span></a>)</small>
                        </div>
                        <script type="text/javascript">
                        //<![CDATA[

                            Ext.onReady(function() {
                                Ext.get('${resourceLinkId}').on('click', function() {
                                    var activeResourceId = Ext.get('${resourceFieldId}').dom.value;
                                    if ('${resource.id}' == activeResourceId) {
                                        RichCode.Line.GoTo('${codeDivId}', 1);
                                    } else {
                                        ${activateResourceFn}();
                                    }
                                });
                            });
                        
                        //]]>
                        </script>

                        <c:forEach items="${resource.issues}" var="issue" varStatus="issueStatus">
                            <%-- id of jump-to-issue anchor --%>
                            <c:set var="issueLinkId" value="${resourceLinkId}_${issueStatus.index}"/>
                            <fmt:message key="annotatedSources.lineInfo" bundle="${messages}" var="lineInfo">
                                <fmt:param value="${issue.lineIndex + 1}"/>
                            </fmt:message>
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
                            <c:set var="activateIssueFn" value="${activateResourceFn}_${issueStatus.index}"/>
                            <syswf:control id="${activateIssueFn}" mode="script" action="activate"
                                           caption="${activateIssueFn}" affects=".">
                                <syswf:param name="resource" value="${resource}"/>
                                <syswf:param name="issue" value="${issue}"/>
                            </syswf:control>
                            <div class="LineReport ${issue.error ? 'Error' : 'Warning'}">
                                <span class="LineReportContent">
                                   <c:if test="${not issue.appliesToWholeDoc}">${lineInfo}:</c:if>
                                   <fmt:message key="annotatedSources.assertionInfo" bundle="${messages}">
                                        <fmt:param value="<strong>${fn:trim(assertionLink)}</strong>"/>
                                        <fmt:param value="<strong>${fn:trim(policyLink)}</strong>"/>
                                    </fmt:message>
                                    <small>(<a href="javascript:void(0)" id="${issueLinkId}"
                                               class="UI Icon FindLine"><span>${jumpLabel}</span></a>)</small>
                                    <br/>
                                    <span class="Comment"><c:out value="${issue.hint}"/></span>
                                </span>
                            </div>
                            <script type="text/javascript">
                            //<![CDATA[

                                Ext.onReady(function() {
                                    Ext.get('${issueLinkId}').on('click', function() {
                                        var activeResourceId = Ext.get('${resourceFieldId}').dom.value;
                                        if ('${resource.id}' == activeResourceId) {
                                            RichCode.Line.GoTo('${codeDivId}', ${issue.lineIndex + 1});
                                        } else {
                                            ${activateIssueFn}();
                                        }
                                    });
                                });
                            
                            //]]>
                            </script>
                        </c:forEach>
                        <br/>
                    </c:forEach>
                </div>
           </div>
        </div>
        <br/>
        <syswf:component prefix="source" name="/pm/report/sources/sourceRenderer">
            <syswf:param name="codeDivId" value="${codeDivId}"/>
            <syswf:param name="codeTagId" value="${codeTagId}"/>
            <syswf:param name="resourceFieldId" value="${resourceFieldId}"/>
            <syswf:param name="bean" value="${bean}"/>
        </syswf:component>
    </div>
</c:if>
