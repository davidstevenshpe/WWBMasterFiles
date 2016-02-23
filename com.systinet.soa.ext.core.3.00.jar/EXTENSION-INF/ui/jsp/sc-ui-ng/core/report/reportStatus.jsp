<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="uimessages"/>
<fmt:message var="delete_buttonLabel" key="CONTEXT_ACTION_DELETE_LABEL" bundle="${uimessages}"/>
<fmt:message var="reportStatus_paused" key="reportStatus.paused" bundle="${messages}"/>
<fmt:message var="reportStatus_waiting" key="reportStatus.waiting" bundle="${messages}"/>
<fmt:message var="reportStatus_technicalDetailsLink" key="reportStatus.technicalDetailsLink" bundle="${messages}"/>
<fmt:message var="reportStatus_technicalDetailsWindowTitle" key="reportStatus.technicalDetailsWindowTitle" bundle="${messages}"/>
<fmt:message var="reportStatus_NOT_COMPLETE" key="reportStatus.NOT_COMPLETE" bundle="${messages}"/>

<c:set var="principal">
    <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="principal" wrap="false">
        <syswf:param name="principal" value="${startedBy}" />
    </syswf:component>
</c:set>

<fmt:message var="reportStatus_startedBy" key="reportStatus.startedBy" bundle="${messages}">
    <fmt:param>${principal}</fmt:param>
    <fmt:param>${startedAt}</fmt:param>
</fmt:message>

<c:set var="isError" value="${reportResultCode == 'ERROR'}"/> 
<c:set var="isWarning" value="${reportResultCode == 'REVIEW'}"/>
<c:set var="isFinishedWithErrors" value="${reportResultCode == 'FINISHED_WITH_ERRORS'}"/>
<c:set var="isFinishedWithWarnings" value="${reportResultCode == 'FINISHED_WITH_WARNINGS'}"/>

<c:choose>
    <c:when test="${waitingForUserInput}">
        <div class="UI SystemMessage Warning">
            <div class="MessageContainer Icon Pending">
                <div class="Text">
                    <strong>${reportStatus_paused}</strong>${reportStatus_waiting}
                    <span class="Comment">${reportStatus_startedBy}</span>
                </div>
                <div class="x-clear"></div>
            </div>
        </div>
    </c:when>

    <c:otherwise>
        <div class="UI SystemMessage <c:choose><c:when test="${isError or isFinishedWithErrors}">Error</c:when><c:when test="${isFinishedWithWarnings}">Warning</c:when><c:otherwise>Done</c:otherwise></c:choose>">
            <div class="MessageContainer Icon <c:choose><c:when test="${isError or isFinishedWithErrors}">Error</c:when><c:when test="${isFinishedWithWarnings}">Warning</c:when><c:when test="${reportStatus eq 'COMPLETE' || reportStatus eq 'STOPPED'}">Completed</c:when><c:otherwise>Pending</c:otherwise></c:choose>">
            
                <syswf:component name="/core/report/reportProgress" prefix="progress">
                    <syswf:param name="reportArtifact" value="${reportArtifact}" />
                    <syswf:param name="onCompleteCallback" value="${onCompleteCallback}" />
                    <syswf:param name="onUpdateCallback" value="${onUpdateCallback}" />
                </syswf:component>
        
                <div class="Text">
                    <strong>
                        <c:choose>
                            <c:when test="${reportStatus == 'COMPLETE'}">
                                <c:choose>
                                    <c:when test="${reportResultCode == 'OK' or reportResultCode == 'ERROR' or reportResultCode == 'FINISHED_WITH_WARNINGS' or reportResultCode == 'FINISHED_WITH_ERRORS'}">
                                        <fmt:message key="reportResultCode.${reportResultCode}" bundle="${messages}"/>
                                    </c:when>
                                    <c:otherwise>
                                        ${reportResultCodeLabel}
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:when test="${reportStatus == 'NOT_COMPLETE'}">
                                ${reportStatus_NOT_COMPLETE}
                            </c:when>
                            <c:otherwise>
                                ${reportStatusLabel}
                            </c:otherwise>
                        </c:choose>
                    </strong>
                    ${reportStatus_startedBy}
                    <br/>
                    <syswf:component name="/core/report/progressMessage" prefix="progressMessage">
                        <syswf:param name="reportArtifact" value="${reportArtifact}"/>
                    </syswf:component>                    
                </div>
                
                <c:if test="${isError and not empty exceptionContent}">
                    <div class="ErrorDetails">
                        <a id="uilink_techdetails" href="javascript:void(0);" class="UI Icon ViewDetails">${reportStatus_technicalDetailsLink}</a>

                        <script type="text/javascript">
//<![CDATA[

                            Ext.onReady(function() {
                                Ext.get('uilink_techdetails').on('click', function() {
                                    SPopup.Window.forceOpen('techdetails-win', 'technicalDetailsContent', {
                                        id: 'techdetails-win',
                                        width: 640,
                                        height: 320,
                                        autoScroll: true,
                                        resizable: true,
                                        plain: false,
                                        cls: 'hp-stacktrace-window',
                                        centerOnScreen: true,
                                        moveout: true,
                                        buttonAlign: 'center',
                                        buttons: [{
                                            text: '<fmt:message key="OK" bundle="${messages}" />',
                                            handler: function() {
                                                // do your code
                                                SPopup.Window.Instance['techdetails-win'].hide();
                                            }
                                        }
                                    ]});
                                });
                            });
                        
//]]>
</script>
                   
                    
                        <div id="technicalDetailsContent" class="x-hidden">
                            <div class="x-window-header">${reportStatus_technicalDetailsWindowTitle}</div>
                            <div class="x-window-body">
                                <div class="UI Offset">
                                    <pre><c:out value="${exceptionContent.errorStackTrace}" escapeXml="true"/></pre>
                                </div>
                            </div>
                        </div>
                    </div>

                </c:if>
                
                <c:if test="${not unsupportUndo}">
	                <div class="ControlButtons">
	
	                    <syswf:component name="/core/impl/reports/stop" prefix="stop" wrap="false">
	                        <syswf:param name="reportArtifact" value="${reportArtifact}" />
	                    </syswf:component>
	            
	                    <syswf:component name="/core/impl/reports/notifyMe" prefix="notifyMe" wrap="false">
	                        <syswf:param name="reportArtifact" value="${reportArtifact}" />
	                    </syswf:component>
	                    
	                    <c:if test="${not empty actionComponents}">
	                        <c:forEach var="actionComponent" items="${actionComponents}" varStatus="status">
	                            <syswf:component name="${actionComponent}" prefix="action_${status}" wrap="false">
	                                <syswf:param name="reportArtifact" value="${reportArtifact}" />
	                            </syswf:component>
	                        </c:forEach>
	                    </c:if>
	                    
	                    <c:if test="${hasLocation and reportStatus == 'COMPLETE'}">
	                        <fmt:message var="downloadCaption" key="reportStatus.downloadContents" bundle="${messages}" />
	                        <%-- button is created manually in order to be possible to copy the link --%>
	                        <a href="${restLink}" class="IconButton"><span><span><span class="Download">${downloadCaption}</span></span></span></a>
	                    </c:if>
	                    
	                    <c:if test="${not empty serverLink}">
	                        ${serverLink}
	                    </c:if>
	                </div>
                </c:if>
            </div>
        </div>
    </c:otherwise>
</c:choose> 