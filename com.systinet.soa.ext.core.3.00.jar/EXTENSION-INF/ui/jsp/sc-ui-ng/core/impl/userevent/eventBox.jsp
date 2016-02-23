<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.userevent.componentsusereventmessages" var="messages"/>

<%--@elvariable id="viewId" type="java.lang.String"--%>
<%--@elvariable id="resultEmpty" type="boolean"--%>
<%--@elvariable id="progressRows" type="java.util.List"--%>
<%--@elvariable id="nonProgressRows" type="java.util.List"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>
<%--@elvariable id="configType" type="com.hp.systinet.sc.userevent.config.ConfigurationType"--%>
<%--@elvariable id="unsupportedSources" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="onCompleteProgress" type="java.lang.Runnable"--%>
<syswf:block className="UI Block Common">
    <div class="Title Config">
        <table><tr>
            <td><h3><fmt:message key="eventBox.title" bundle="${messages}"/></h3></td>
            <c:if test="${empty artifact}">
                <td style="vertical-align: middle;padding-left:10px"><syswf:component name="/core/impl/userevent/userEventFeed" prefix="userEventFeed"/></td>
            </c:if>
        </tr></table>
        
        <div class="BlockControls">
            <c:set var="openButtonId" value="${prefix}_cfgButton"/>
            <c:set var="winOpenFn" value="${prefix}_cfgOpen"/>
            <a id="${openButtonId}" href="javascript:void(0);" class="Configuration"
                    ><span><fmt:message key="events.configButton" bundle="${messages}"/></span></a>

            <syswf:component name="/core/impl/userevent/eventConfigDialog" prefix="dialog">
                <syswf:param name="configType" value="${configType}"/>
                <syswf:param name="openFunctionName" value="${winOpenFn}"/>
                <syswf:param name="unsupportedSources" value="${unsupportedSources}"/>
            </syswf:component>

            <script type="text/javascript">
//<![CDATA[
			Ext.onReady(function() {
                attachOn('${openButtonId}','click', function() {
                    ${winOpenFn}();
                });
	            moveWindow('${prefix}_dialog','popupWindows');
			});
               
            
//]]>
</script>
        </div>
        <div class="x-clear"></div>
    </div>
    <c:set var="newLabel"><span class="Text FlagNew"><fmt:message key="events.newLabel"
                                                                  bundle="${messages}"/></span></c:set>
    <c:if test="${empty artifact}">
        <div class="Content">
            <c:if test="${not resultEmpty}">
                <c:if test="${not empty progressRows}">
                    <ul class="UI Bullets Plain">
                        <c:forEach items="${progressRows}" var="row" varStatus="status">
                            <c:set var="date">
                                <syswf:component prefix="progressEventDate_${status.index}"
                                                 name="/core/impl/util/enhancedDateRenderer" wrap="false">
                                    <syswf:param name="dateValue" value="${row['date']}"/>
                                    <syswf:param name="styleClass" value="ItemDate"/>
                                </syswf:component>
                            </c:set>
                            <li class="${row['eventStyleClass']}
                                    <c:if test="${row['pausedFlag']}">HighlightItem</c:if>" >
                                <div class="UI Align">
                                    <div class="Left">
                                        <syswf:component prefix="progressEventLink_${status.index}"
                                                         name="/core/impl/userevent/eventLinkRenderer" wrap="false">
                                            <syswf:param name="eventBean" value="${row['bean']}"/>
                                            <syswf:param name="styleClass" value="ItemName"/>
                                        </syswf:component>
                                        <br/>
                                        <fmt:message key="eventBox.eventSubtitle.progress" bundle="${messages}">
                                            <fmt:param value="${fn:trim(date)}"/>
                                        </fmt:message><c:if test="${row['newFlag']}">, ${newLabel}</c:if>
                                    </div>
                                    <div class="Right">
                                        <c:if test="${not empty row['inProgressReport']}">
                                            <div class="UI ProgressBar Short">
                                                <syswf:component prefix="progressBar_${status.index}"
                                                                 name="/core/report/reportProgress">
                                                    <syswf:param name="reportArtifact"
                                                                 value="${row['inProgressReport']}"/>
                                                    <syswf:param name="onCompleteCallback"
                                                                 value="${onCompleteProgress}"/>
                                                </syswf:component>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="x-clear"></div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${not empty progressRows and not empty nonProgressRows}">
                    <hr/>
                </c:if>
                <c:if test="${not empty nonProgressRows}">
                    <ul class="UI Bullets Plain">
                        <c:forEach items="${nonProgressRows}" var="row" varStatus="status">
                            <c:set var="actor">
                                <syswf:component name="/core/impl/util/principalLinkRenderer"
                                                 prefix="nonProgressActor_${status.index}"
                                                 wrap="false">
                                    <syswf:param name="principal" value="${row['actorPrincipal']}"/>
                                    <syswf:param name="customName" value="${row['actorName']}"/>
                                    <syswf:param name="showIcon" value="${false}"/>
                                </syswf:component>
                            </c:set>
                            <c:set var="date">
                                <syswf:component prefix="nonProgressEventDate_${status.index}"
                                                 name="/core/impl/util/enhancedDateRenderer" wrap="false">
                                    <syswf:param name="dateValue" value="${row['date']}"/>>
                                    <syswf:param name="styleClass" value="ItemDate"/>
                                </syswf:component>
                            </c:set>
                            <li class="${row['eventStyleClass']}
                                    <c:if test="${row['pausedFlag']}">HighlightItem</c:if>" >
                                <syswf:component prefix="nonProgressEventLink_${status.index}"
                                                 name="/core/impl/userevent/eventLinkRenderer" wrap="false">
                                    <syswf:param name="eventBean" value="${row['bean']}"/>
                                    <syswf:param name="styleClass" value="ItemName"/>
                                </syswf:component>
                                <br/>
                                <span class="ItemAuthor"><fmt:message key="eventBox.eventSubtitle.nonProgress.author"
                                                                      bundle="${messages}">
                                    <fmt:param value="${fn:trim(actor)}"/>
                                </fmt:message></span>, ${fn:trim(date)}<c:if test="${row['newFlag']}"
                                    >, ${newLabel}</c:if>
                            </li>
                        </c:forEach>

                    </ul>
                </c:if>
            </c:if>
            <c:if test="${resultEmpty}">
                <p><fmt:message key="eventBox.noItems" bundle="${messages}"/></p>
            </c:if>
        </div>
        <div class="Footer">
            <fmt:message key="eventBox.moreLabel" bundle="${messages}" var="moreLabel"/>
            <syswf:control id="moreLink" mode="anchor" caption="${moreLabel}"
                           targetTask="/${viewId}/userevent/eventBrowser"/>
        </div>
    </c:if>
    <c:if test="${not empty artifact}">
        <div class="Content">
            <c:if test="${not resultEmpty}">
                <table class="UI Table Properties">
                    <col/>
                    <col class="MidLabelCol"/>
                    <tbody>
                    <c:forEach items="${nonProgressRows}" var="row" varStatus="status">
                        <c:set var="actor">
                            <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="actor_${status.index}"
                                             wrap="false">
                                <syswf:param name="principal" value="${row['actorPrincipal']}"/>
                                <syswf:param name="customName" value="${row['actorName']}"/>
                                <syswf:param name="showIcon" value="${false}"/>
                            </syswf:component>
                        </c:set>
                        <c:set var="date">
                            <syswf:component prefix="eventDate_${status.index}"
                                             name="/core/impl/util/enhancedDateRenderer" wrap="false">
                                <syswf:param name="dateValue" value="${row['date']}"/>
                                <syswf:param name="styleClass" value="ItemDate"/>
                            </syswf:component>
                        </c:set>
                        <tr class="<c:if test="${row['pausedFlag']}">HighlightItem</c:if>" >
                            <td>
                                <syswf:component prefix="eventLink_${status.index}"
                                                 name="/core/impl/userevent/eventLinkRenderer" wrap="false">
                                    <syswf:param name="eventBean" value="${row['bean']}"/>
                                    <syswf:param name="styleClass" value="${row['eventStyleClass']}"/>
                                    <syswf:param name="showNewFlag" value="${true}"/>
                                    <syswf:param name="newFlag" value="${row['newFlag']}"/>
                                </syswf:component>
                            </td>
                            <td>
                                <span class="IconAlign">
                                    <fmt:message key="eventBox.eventComment" bundle="${messages}">
                                        <fmt:param value="${fn:trim(actor)}"/>
                                        <fmt:param value="${fn:trim(date)}"/>
                                    </fmt:message>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${resultEmpty}">
                <p><fmt:message key="eventBox.noItems" bundle="${messages}"/></p>
            </c:if>
        </div>
        <div class="Footer">
            <fmt:message key="eventBox.moreLabel" bundle="${messages}" var="moreLabel"/>
            <syswf:component prefix="moreLink"
                             name="/core/impl/util/artifactLinkRenderer" wrap="false">
                <syswf:param name="uuid" value="${artifact._uuid}"/>
                <syswf:param name="revision" value="${artifact._revision}"/>
                <syswf:param name="caption" value="${moreLabel}"/>
                <syswf:param name="artifactTabId" value="events"/>
                <syswf:param name="class" value=""/>
            </syswf:component>
        </div>
    </c:if>
</syswf:block>