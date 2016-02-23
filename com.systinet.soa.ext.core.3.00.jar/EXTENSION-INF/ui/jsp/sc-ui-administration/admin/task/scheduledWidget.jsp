<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="scheduleEnabled" type="java.lang.Boolean"--%>
<c:if test="${scheduleEnabled}">
    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="L10nSCAdministration"/>
    <%--@elvariable id="scheduled" type="com.hp.systinet.repository.sdm.propertytypes.Scheduled"--%>
    <%--@elvariable id="recurrenceTypeString" type="java.lang.String"--%>


    <syswf:block className="UI Block Common">
        <div class="Title">
            <h3><span><fmt:message key="scheduledWidget_scheduled" bundle="${L10nSCAdministration}"/></span></h3>
        </div>
        <div class="Content">
            <table class="UI Table Properties">
                <col class="LabelCol"/>
                <col/>
                <tr>
                    <th><label class="UI Label Inline">
                        <fmt:message key="scheduledWidget_nextRun" bundle="${L10nSCAdministration}"/>:
                    </label></th>
                    <td>
                        <syswf:component prefix="scheduledWidgetScheduledRunTime" name="/admin/task/scheduledRunTime">
                            <syswf:param name="scheduled" value="${scheduled}"/>
                        </syswf:component>
                    </td>
                </tr>
                <tr>
                    <th><label class="UI Label Inline">
                        <fmt:message key="scheduledWidget_recurrence" bundle="${L10nSCAdministration}"/>:
                    </label></th>
                    <td><span class="IconAlign"><syswf:out value="${recurrenceTypeString}" context="HtmlBody"/></span></td>
                </tr>
            </table>
        </div>
    </syswf:block>
</c:if>