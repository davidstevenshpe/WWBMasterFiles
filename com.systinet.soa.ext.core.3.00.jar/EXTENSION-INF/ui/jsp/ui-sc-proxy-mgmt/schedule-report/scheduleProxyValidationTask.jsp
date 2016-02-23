<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${isInRoles}">

<fmt:setBundle basename="com.hp.systinet.proxy.l10n.messages" var="l10n" />
<fmt:message var="title" key="proxy.schedule.validation.title" bundle="${l10n}" />
<a id="setupSchedule" href="javascript:void(0);" class="UI PageAction EditSchedule"><span>${title}</span></a>

<syswf:component name="/core/task/scheduleTaskWindow" prefix="scheduleTask">
    <syswf:param name="taskArtifactUuid" value="${taskArtifactUuid}"/>
    <syswf:param name="winTitle" value="${title}"/>
    <syswf:param name="winOpenFunctionName" value="fnOpenTaskScheduleWin"/>
    <syswf:param name="reloadPageAfterSave" value="true"/>
</syswf:component>


<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
	    Ext.get('setupSchedule').on('click', fnOpenTaskScheduleWin);
    });

//]]>
</script>

</c:if>