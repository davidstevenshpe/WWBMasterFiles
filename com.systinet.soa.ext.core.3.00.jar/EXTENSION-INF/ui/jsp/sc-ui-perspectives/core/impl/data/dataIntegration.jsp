<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.data.datamessages" var="dataMessages"/>
<fmt:message var="synchronizeLink" key="synchronizeLink" bundle="${dataMessages}"/>
<fmt:message var="synchronizeWindowTitle" key="synchronizeWindowTitle" bundle="${dataMessages}"/>
<fmt:message var="synchronizeButtonTitle" key="synchronizeButtonTitle" bundle="${dataMessages}"/>
<fmt:message var="cancelButtonTitle" key="cancelButtonTitle" bundle="${dataMessages}"/>
<fmt:message var="lastUpdate" key="lastUpdate" bundle="${dataMessages}"/>
<fmt:message var="artifactLockedMessage" key="artifactLockedMessage" bundle="${dataMessages}"/>
<fmt:message var="invalidOriginUrl" key="invalidOriginUrl" bundle="${dataMessages}"/>
<fmt:message var="statusLabel" key="statusLabel" bundle="${dataMessages}"/>


<c:if test="${dataArtifact and not hideSynchronizationSection and synchronizable}">
    <syswf:block className="UI Block Common">
        <div class="Content">
            <div class="Title">
                <h3>${wrapCaption}</h3>
            </div>
            <div class="Content">
                <ul class="UI Synchronization">
                    <li>
                        <div class="OneLine">
                            <c:choose>
                                <c:when test="${not empty originURL and not empty hostname}">
                                    <a href="${originURL}" title="${originURL}" target="_blank"><syswf:out value="${hostname}" context="HtmlBody"/></a>
                                </c:when>
                                <c:otherwise>
                                    ${invalidOriginUrl}
                                </c:otherwise>
                            </c:choose>
                            
                        </div>
                    </li>
                   
                    <c:choose>
                        <c:when test="${empty artifact.syncStatus}">
                            <c:set var="bundleKey" value="syncStatus.UNKNOWN"/>
                            <c:set var="statusClass" value="Unknown"/>
                        </c:when>
                        <c:otherwise>                    
                            <c:set var="bundleKey" value="syncStatus.${artifact.syncStatus}"/>
                            <c:choose>
                                <c:when test="${artifact.syncStatus == 'IDENTICAL'}">
                                    <c:set var="statusClass" value="Completed"/>
                                </c:when>
                                <c:when test="${artifact.syncStatus == 'CHANGED'}">
                                    <c:set var="statusClass" value="EventChangedProperties"/>
                                </c:when>
                                <c:when test="${artifact.syncStatus == 'INVALID'}">
                                    <c:set var="statusClass" value="EventInvalid"/>
                                </c:when>
                                <c:when test="${artifact.syncStatus == 'INCOMPLETE'}">
                                    <c:set var="statusClass" value="NotCompleted"/>
                                </c:when>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                    <fmt:message var="syncStatusLabel" key="${bundleKey}" bundle="${dataMessages}"/>
                    <li>
                        ${statusLabel} <span class="UI Icon ${statusClass}" title="${lastUpdate} ${syncLastChecked}">${syncStatusLabel}</span>
                    </li>
                </ul>
                
                <c:if test="${not readOnly}">
                        <c:choose>
                            <c:when test="${not artifactLocked and hasWritePermission}">
                              <div class="Footer">
                                <a href="javascript:void(0);" class="UI Icon Synchronize" id="${prefix}synchronize">${synchronizeLink}</a>
                
                                <script type="text/javascript">
//<![CDATA[

                                    Ext.onReady(function() {
                                            Ext.get('${prefix}synchronize').on('click', ${prefix}openConfirmationDialog);
                                    });
                                
//]]>
</script>
                                
                                <div class="webfw-Window" id="${prefix}-webfw-Window">
                                    <div id="${prefix}window" class="x-hidden">
                                        <div class="x-window-header">${synchronizeWindowTitle}</div>
                                        <div class="x-window-body">
                                            <div class="UI Offset">
                                                <fmt:message var="confirmSynchronize" key="confirmSynchronize" bundle="${dataMessages}">
                                                    <fmt:param><syswf:out value="${artifact.name}" context="HtmlBody"/></fmt:param>
                                                </fmt:message>
                                                <p class="Warning">${confirmSynchronize}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                
                                <syswf:control mode="script" caption="${prefix}doSynchronize" action="synchronize"/>
                
                                <script type="text/javascript">
//<![CDATA[

                                
                                    var ${prefix}buttons = [
                                        {text: '${synchronizeButtonTitle}', handler: function(){ ${prefix}doSynchronize(); SPopup.Window.Instance['${prefix}window'].hide();}},
                                        {text: '${cancelButtonTitle}', handler: function(){ SPopup.Window.Instance['${prefix}window'].hide(); return false;}}
                                    ];
                                    var ${prefix}openConfirmationDialog = function() {
                                        SPopup.Window.forceOpen('${prefix}window','${prefix}window',{
                                            autoHeight: true, plain: true, buttons: ${prefix}buttons, width: 300, resizable: false, centerOnScreen:true, buttonAlign: 'center'
                                        });
                                    };
                                
                                
//]]>
</script>
                                </div>
                            </c:when>
                            <c:when test="${artifactLocked}">  
                                <div class="Footer">                          
                                    <p>${artifactLockedMessage}</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <%-- artifact is not locked by lifecycle but user has not a write permission, render nothing --%>
                            </c:otherwise>
                        </c:choose>
                </c:if>
            </div>
       </div>       
    </syswf:block>
</c:if>