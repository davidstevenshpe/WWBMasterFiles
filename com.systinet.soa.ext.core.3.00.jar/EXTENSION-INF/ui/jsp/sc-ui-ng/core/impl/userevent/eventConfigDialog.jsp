<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.userevent.componentsusereventmessages" var="messages"/>

<%--@elvariable id="config" type="com.hp.systinet.sc.ui.impl.userevent.EventConfigBean"--%>
<%--@elvariable id="configType" type="com.hp.systinet.sc.userevent.config.ConfigurationType"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="openFunctionName" type="java.lang.String"--%>
<c:set var="saveConfigFunction" value="${prefix}_saveConfig"/>
<syswf:control mode="script" action="saveConfig" caption="${saveConfigFunction}"/>
<c:set var="cancelFunction" value="${prefix}_cancel"/>
<syswf:control mode="script" action="cancelConfigChange" caption="${cancelFunction}"/>

<syswf:component name="/core/window" prefix="cfg">
    <syswf:param name="winTitle"><fmt:message key="events.config.dialogTitle"
                                              bundle="${messages}"/></syswf:param>
    <syswf:param name="winOpenFunctionName" value="${openFunctionName}"/>
    <syswf:param name="winOkAction" value="${saveConfigFunction}"/>
    <syswf:param name="winOkLabel"><fmt:message key="events.config.saveButton"
                                                bundle="${messages}"/></syswf:param>
    <syswf:param name="winCancelAction" value="${cancelFunction}"/>
    <syswf:param name="winCancelLabel"><fmt:message key="events.config.cancelButton"
                                                    bundle="${messages}"/></syswf:param>
    <syswf:param name="winResizable" value="true"/>
    <syswf:param name="winRenderContents" value="true"/>
    <syswf:param name="winWidth" value="650"/>
    <syswf:param name="winButtonAlign" value="right"/>
    <syswf:param name="winContents">
        <div class="Message Info">
            <div class="MessageContainer"><span>&nbsp;</span
                    ><fmt:message key="events.config.dialogNotice.${configType.name}" bundle="${messages}"/>
            </div>
        </div>
        <div class="Offset">
            <table class="UI Table Configuration">
                <colgroup>
                    <col class="MidLabelCol"/>
                    <col/>
                </colgroup>
                <tbody>
                    <tr>
                        <td>
                            <fmt:message key="events.config.eventCount" bundle="${messages}"/>:
                        </td>
                        <td>
                            <syswf:selectOne
                                    name="eventCount" value="${config}"
                                    optionValues="${config.eventCountOptions}"
                                    property="eventCount" mode="menu"
                                    dataType="int"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <fmt:message key="events.config.relationToDomain"
                                         bundle="${messages}"/>:
                        </td>
                        <td>
                            <fmt:message var="workingDomainLabel"
                                         key="events.config.relationToDomain.working"
                                         bundle="${messages}"/>
                            <fmt:message var="allDomainsLabel"
                                         key="events.config.relationToDomain.all"
                                         bundle="${messages}"/>
                            <syswf:selectOne name="limitedToWorkingDomain"
                                             optionCaptions="${workingDomainLabel},${allDomainsLabel}"
                                             optionValues="true,false"
                                             optionClasses="UI Label Inline,UI Label Inline"
                                             value="${config}"
                                             property="limitedToWorkingDomain"
                                             mode="radio" displayAsRow="true"
                                             dataType="boolean">
                                <syswf:attribute name="class" value="UI Form Checkbox Inline"/>
                            </syswf:selectOne>
                        </td>
                    </tr>
                    <c:if test="${configType.name eq 'NOTIFICATIONS'}">
                        <tr>
                            <td>
                                <fmt:message key="events.config.notificationsEnabled"
                                             bundle="${messages}"/>:
                            </td>
                            <td>
                                <syswf:selectOne name="notificationsEnabled"
                                                 optionCaptions=" "
                                                 optionValues="true"
                                                 value="${config}"
                                                 property="notificationsEnabled"
                                                 mode="checkbox" dataType="boolean">
                                    <syswf:attribute name="class" value="UI Form Checkbox Inline"/>
                                </syswf:selectOne>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            <h4><fmt:message key="events.config.visibilitySection" bundle="${messages}"/></h4>
            <table class="UI Table Configuration">
                <colgroup>
                    <col class="MidLabelCol"/>
                    <col/>
                </colgroup>
                <tbody>
                    <c:forEach items="${config.sourceBeans}" var="item">
                        <tr>
                            <td><c:out value="${item.source.label}"/>:</td>
                            <td>
                                <syswf:selectOne name="mode_${item.source.id}"
                                                 value="${item}" property="mode" dataType="enum"
                                                 optionCaptions="${item.modeCaptions}"
                                                 optionValues="${item.modeValues}"
                                                 optionClasses="${item.modeClasses}"
                                                 mode="radio" displayAsRow="true">
                                    <syswf:attribute name="class" value="UI Form Checkbox Inline"/>
                                </syswf:selectOne>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </syswf:param>
</syswf:component>