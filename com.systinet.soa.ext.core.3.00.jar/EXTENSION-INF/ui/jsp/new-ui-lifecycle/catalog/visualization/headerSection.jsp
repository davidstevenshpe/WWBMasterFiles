<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="headerSectionBean" type="com.hp.systinet.lifecycle.ui.catalog.visualization.HeaderSectionBean"--%>
<%--@elvariable id="voterCommentBean" type="com.hp.systinet.lifecycle.ui.catalog.visualization.HeaderSection.VoterCommentBean"--%>
<%--@elvariable id="descriptionBoxBean" type="com.hp.systinet.lifecycle.ui.catalog.visualization.DescriptionBoxBean"--%>
<c:set var="statusComment">
    <span class="UI Icon ${headerSectionBean.stageStyleClass}">${headerSectionBean.stageLabel}</span>
    <c:if test="${not empty headerSectionBean.statusCommentKey}">
        <c:set var="statusCommentDate">
            <syswf:component prefix="statusCommentDate" name="/core/impl/util/enhancedDateRenderer" wrap="false">
                <syswf:param name="dateValue" value="${headerSectionBean.statusCommentDate}"/>
            </syswf:component>
        </c:set>
        <c:set var="statusCommentUser">
            <c:if test="${not empty headerSectionBean.statusCommentUser}">
                <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="user" wrap="false">
                    <syswf:param name="principal" value="${headerSectionBean.statusCommentUser}"/>
                </syswf:component>
            </c:if>
        </c:set>
        <fmt:message key="${headerSectionBean.statusCommentKey}" bundle="${messages}" var="statusComment">
            <fmt:param value="${fn:trim(statusCommentDate)}"/>
            <fmt:param value="${fn:trim(statusCommentUser)}"/>
        </fmt:message>
        <span class="Comment">(${statusComment})</span>
    </c:if>
</c:set>
<c:choose>
    <c:when test="${headerSectionBean.lastInStage}">
        <div class="StageLabel">
                ${statusComment}
        </div>
    </c:when>
    <c:otherwise>
        <div class="StageLabel">
            <span class="UI Icon StageHistory"><fmt:message key="header.stageHistory" bundle="${messages}"/></span>
        </div>
        <div class="StageLabel Secondary">${statusComment}</div>
    </c:otherwise>
</c:choose>

<div class="StageNotes">
    <c:if test="${not empty headerSectionBean.message}">
        <div class="UI SystemMessage">
            <div class="MessageContainer">
                <div class="Text">
                    <span class="Comment UI Icon NewComment"><c:out value="${headerSectionBean.message}"/></span>
                </div>
                <div class="x-clear"></div>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty headerSectionBean.policyProgress or not empty headerSectionBean.taskProgress}">
        <div class="StageNotes">
            <ul class="UI Bullets">
                <c:set var="policyProgress" value="${headerSectionBean.policyProgress}"/>
                <c:if test="${not empty policyProgress}">
                    <li>
                        <c:choose>
                            <c:when test="${policyProgress.unfinished == 0}">
                                <fmt:message key="progress.policies.noNonCompliant" bundle="${messages}">
                                    <fmt:param value="${policyProgress.unknown}"/>
                                    <fmt:param value="${policyProgress.total}"/>
                                </fmt:message>
                            </c:when>
                            <c:when test="${policyProgress.unknown == 0}">
                                <fmt:message key="progress.policies.noUnknown" bundle="${messages}">
                                    <fmt:param value="${policyProgress.unfinished}"/>
                                    <fmt:param value="${policyProgress.total}"/>
                                </fmt:message>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="progress.policies" bundle="${messages}">
                                    <fmt:param value="${policyProgress.unfinished}"/>
                                    <fmt:param value="${policyProgress.unknown}"/>
                                    <fmt:param value="${policyProgress.total}"/>
                                </fmt:message>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </c:if>
                <c:if test="${not empty headerSectionBean.taskProgress}">
                    <li>
                        <fmt:message key="progress.tasks" bundle="${messages}">
                            <fmt:param value="${headerSectionBean.taskProgress.unfinished}"/>
                            <fmt:param value="${headerSectionBean.taskProgress.total}"/>
                        </fmt:message></li>
                </c:if>
            </ul>
        </div>
    </c:if>

    <c:if test="${headerSectionBean.showVotingButtons}">
        <div class="Offset">
            <script>
            //<![CDATA[
                ${prefix}_approveFunctionWithMessageBox=function()
                {
                    Ext.MessageBox.wait('Approval is being processed...', 'Please wait...', '');
                    ${prefix}_approveFunction();
                }
            //]]>
            </script>

            <c:set var="maxResponseLength" value="2000"/> <%-- max comment length for approval or rejection --%>
            <c:set var="approveButtonId" value="approveButton"/>
            <a href="javascript:void(0);" class="IconButton Confirm" id="${approveButtonId}"><span><span><span
                    class="OK"><fmt:message key="button.approve" bundle="${messages}"/></span></span></span></a>
            <c:set var="approveFunction" value="${prefix}_approveFunction"/>
            <%-- removing the affects AJAX because of the waiting window - the behavior was different accross browsers anyway--%>
            <syswf:control mode="script" action="approve" caption="${approveFunction}">
                <syswf:param name="approvalDataUuid" value="${headerSectionBean.approvalDataUuid}"/>
            </syswf:control>
            <c:set var="stageName"><c:out value="${descriptionBoxBean.definitionData.stage.name}"/></c:set>
            <syswf:component name="/newUi/lc/common/dialog/messageInput" prefix="approveDialog" wrap="false">
                <syswf:param name="title"><fmt:message key="dialog.approve.title" bundle="${messages}">
                        <fmt:param value="${stageName}"/>
                    </fmt:message></syswf:param>
                <syswf:param name="windowId">${approveButtonId}</syswf:param>
                <syswf:param name="submitFunction">${prefix}_approveFunctionWithMessageBox</syswf:param>
                <syswf:param name="msgBean" value="${voterCommentBean}"/>
                <syswf:param name="msgProperty">approvalComment</syswf:param>
                <syswf:param name="maxLength">${maxResponseLength}</syswf:param>
                <syswf:param name="subTitle"><fmt:message key="dialog.approve.areaCaption"
                                                          bundle="${messages}"/></syswf:param>
                <syswf:param name="actionCaption"><fmt:message key="dialog.approve.submitButton"
                                                               bundle="${messages}"/></syswf:param>
                <syswf:param name="emptyText"><fmt:message key="dialog.approve.emptyText"
                                                           bundle="${messages}"/></syswf:param>
            </syswf:component>

            <c:set var="rejectButtonId" value="rejectButton"/>
            <a href="javascript:void(0);" class="IconButton" id="${rejectButtonId}"><span><span><span
                    class="Cancel"><fmt:message key="button.reject" bundle="${messages}"/></span></span></span></a>
            <c:set var="rejectFunction" value="${prefix}_rejectFunction"/>
            <syswf:control mode="script" action="reject" caption="${rejectFunction}"> <%-- non-ajax --%>
                <syswf:param name="approvalDataUuid" value="${headerSectionBean.approvalDataUuid}"/>
            </syswf:control>
            <syswf:component name="/newUi/lc/common/dialog/messageInput" prefix="rejectDialog" wrap="false">
                <syswf:param name="title"><fmt:message key="dialog.reject.title" bundle="${messages}"/></syswf:param>
                <syswf:param name="windowId">${rejectButtonId}</syswf:param>
                <syswf:param name="submitFunction">${rejectFunction}</syswf:param>
                <syswf:param name="msgBean" value="${voterCommentBean}"/>
                <syswf:param name="msgProperty">rejectionComment</syswf:param>
                <syswf:param name="minLength">1</syswf:param>
                <syswf:param name="maxLength">${maxResponseLength}</syswf:param>
                <syswf:param name="subTitle"><fmt:message key="dialog.reject.areaCaption"
                                                          bundle="${messages}"/></syswf:param>
                <syswf:param name="actionCaption"><fmt:message key="dialog.reject.submitButton"
                                                               bundle="${messages}"/></syswf:param>
                <syswf:param name="emptyText"><fmt:message key="dialog.reject.emptyText"
                                                           bundle="${messages}"/></syswf:param>
            </syswf:component>
        </div>
    </c:if>
</div>

<c:if test="${not empty headerSectionBean.voters}">
    <syswf:block className="UI Block Plain">
        <div class="Content">
            <table class="UI Table Properties">
                <col class="XLongLabelCol"/>
                <col/>
                <c:forEach items="${headerSectionBean.voters}" var="voterEntry" varStatus="status">
                    <c:if test="${not voterEntry.multi}">
                        <syswf:component prefix="headerVoter_${status.index}}"
                                         name="/newUi/lc/catalog/visualization/headerVoterRow" wrap="false">
                            <syswf:param name="voterEntry" value="${voterEntry}"/>
                        </syswf:component>
                    </c:if>
                    <c:if test="${voterEntry.multi}">
                        <%--@elvariable id="voterEntry" type="com.hp.systinet.lifecycle.ui.catalog.visualization.HeaderSection.MultiVoterEntry"--%>
                        <c:forEach items="${voterEntry.entries}" var="entry" varStatus="entryStatus">
                            <syswf:component prefix="headerVoter_${status.index}_${entryStatus.index}}"
                                             name="/newUi/lc/catalog/visualization/headerVoterRow" wrap="false">
                                <syswf:param name="voterEntry" value="${entry}"/>
                                <syswf:param name="hidePrincipal" value="${not entryStatus.first}"/>
                                <syswf:param name="parentPrincipal" value="${voterEntry.voter}"/>
                            </syswf:component>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </table>
        </div>
    </syswf:block>
</c:if>

<c:if test="${not empty headerSectionBean.message or not empty headerSectionBean.policyProgress
            or not empty headerSectionBean.taskProgress or not empty headerSectionBean.voters}">
    <hr/>
</c:if>
