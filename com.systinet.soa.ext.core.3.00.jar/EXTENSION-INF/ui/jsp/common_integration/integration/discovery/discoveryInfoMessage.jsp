<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="IntegrationL10n"/>
<fmt:message key="MESSAGE_notStarted_scheduledImport" var="scheduleImport" bundle="${IntegrationL10n}"/>

<div class="UI SystemMessage Info">
    <div class="MessageContainer">
        <div class="Text"><span class="UI Icon Info"> </span>
        <c:choose>
            <c:when test="${not empty scheduledDiscoveryDate}">
                <fmt:message key="MESSAGE_notStarted_scheduled" bundle="${IntegrationL10n}"/>
                <c:out value=" ${scheduledDiscoveryDate}"/>
            </c:when>
            <c:otherwise>
                <fmt:message key="MESSAGE_notStarted_partOne" bundle="${IntegrationL10n}"/>
                <syswf:component prefix="messageStartImportButton"
                                 name="/integration/ucmdbImport/startImportButton" wrap="false">
                    <syswf:param name="notPageAction" value="true"/>
                </syswf:component>

                <fmt:message key="MESSAGE_notStarted_partTwo" bundle="${IntegrationL10n}">
                    <fmt:param>
                        <a id="${prefix}scheduleTaskButton" href="javascript:void(0);"><c:out value="${scheduleImport}"/></a>
                    </fmt:param>
                </fmt:message>
            </c:otherwise>
        </c:choose>
        </div>
        <div class="x-clear"></div>
    </div>
</div>
<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        Ext.get('${prefix}scheduleTaskButton').on('click', fnOpenDiscoveryTaskScheduleWin);
    });
    //]]>
</script>

