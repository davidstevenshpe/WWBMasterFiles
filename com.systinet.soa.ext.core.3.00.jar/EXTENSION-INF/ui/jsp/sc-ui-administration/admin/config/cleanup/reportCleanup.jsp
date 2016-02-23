<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

<fmt:message key="cleanupConfig.reportCleanupTask.name" bundle="${messages}" var="reportCleanerTaskName"/>
<fmt:message key="cleanupConfig.button.save.label" bundle="${messages}" var="save_label"/>
<fmt:message key="cleanupConfig.button.resetToDefaults.label" bundle="${messages}" var="default_label"/>
<fmt:message key="cleanupConfig.days" bundle="${messages}" var="days_label"/>

<%--@elvariable id="bean" type="com.hp.systinet.sc.ui.admin.config.cleanup.ReportCleanup.ReportCleanupBean"--%>
<%--@elvariable id="errorPropertyName" type="java.lang.String"--%>
            <syswf:block className="UI SystemMessage Info">
                <div class="MessageContainer">
                    <c:set var="reportCleanerTask_link">
                        <syswf:component prefix="${prefix}_reportCleanerTask" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                            <syswf:param name="uuid" value="${bean.cleanupTaskUuid}"/>
                            <syswf:param name="caption" value="${reportCleanerTaskName}"/>
                        </syswf:component>
                    </c:set>
                    <strong><fmt:message key="cleanupConfig.infoMessage.note"
                                         bundle="${messages}"/></strong>
                    <fmt:message key="cleanupConfig.infoMessage.text" bundle="${messages}">
                        <fmt:param value="${reportCleanerTask_link}"/>
                    </fmt:message>
                </div>
            </syswf:block>
            <syswf:block className="UI Block Common">
                <div class="Content">
                    <table class="UI Table Properties">
                        <col class="MidLabelCol"/>
                        <col/>
                        <tbody>
                        <c:forEach items="${bean.properties}" var="property" varStatus="status">
                            <tr>
                                <th><label class="Label Inline">${property.label}</label></th>
                                <td>
                                    <syswf:input id="${prefix}_input_${property.name}"
                                                 name="${status.count}_cleanUp" mode="normal"
                                                 value="${property}" property="value">
                                        <c:choose>
                                            <c:when test="${(not empty errorPropertyName) and (property.name eq errorPropertyName)}">
                                                <syswf:attribute name="class">UI Form Input Text Int x-form-invalid</syswf:attribute>
                                            </c:when>
                                            <c:otherwise>
                                                <syswf:attribute name="class">UI Form Input Text Int</syswf:attribute>
                                            </c:otherwise>
                                        </c:choose>
                                    </syswf:input>
                                    <c:out value="${days_label}"/>
                                    <c:if test="${(not empty errorPropertyName) and (property.name eq errorPropertyName)}">
                                        <em class="x-form-invalid-msg UI Invalid">
                                            <span><fmt:message key="cleanupConfig.integerValueRequired" bundle="${messages}"/></span>
                                        </em>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </syswf:block>
            <syswf:block className="UI Block Green">
                <div class="UI Form Controls">
                    <syswf:control mode="button" caption="${save_label}" hint="${save_label}" action="save">
                        <syswf:attribute name="class" value="btn btn-primary" />
                    </syswf:control>
                    <syswf:control mode="button" caption="${default_label}" hint="${default_label}" action="resetToDefaults">
                        <syswf:attribute name="class" value="btn btn-gray" />
                    </syswf:control>
                </div>
            </syswf:block>
