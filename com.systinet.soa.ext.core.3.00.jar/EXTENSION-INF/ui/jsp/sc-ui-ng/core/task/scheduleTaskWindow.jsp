<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- PARAMETERS: --%>
<%--@elvariable id="taskArtifactUuid" type="java.lang.String"--%>
<%--@elvariable id="winTitle" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="winOpenFunctionName" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<%--@elvariable id="bean" type="com.hp.systinet.sc.ui.task.ScheduleTaskWindowBean"--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.task.taskmessages" var="messages"/>

<syswf:control mode="script" affects="." action="cleanup" caption="${prefix}fnCleanup" id="${prefix}fnCleanup"/>
<syswf:control mode="script" affects="." action="cancel" caption="${prefix}cancel" />

<fmt:message bundle="${messages}" key="scheduleTask.ok" var="okLabel" />
<fmt:message bundle="${messages}" key="scheduleTask.cancel" var="cancelLabel" />

<c:set var="customButtons">
    [{
        text     : '${okLabel}',
        disabled : false,
        handler  : function() {
            fnUpdateSchedule();        
        },
        id: '${prefix}_okScheduleDialog'        
    },{
            text     : '${cancelLabel}',
            handler  : function(){
                ${prefix}cancel();
                SPopup.Window.Instance['${prefix}taskScheduleWin'].hide();
                return false;
            },
            id: '${prefix}_cancelScheduleDialog'
        }]    
</c:set>

<script type="text/javascript">
//<![CDATA[

    function ${prefix}close(){
        SPopup.Window.Instance['${prefix}taskScheduleWin'].hide();
        ${prefix}fnCleanup();
    }

//]]>
</script>

<syswf:component name="/core/window" prefix="taskScheduleWin">
    <syswf:param name="winId" value="${prefix}taskScheduleWin"/>
    <syswf:param name="winTitle" value="${winTitle}"/>
    <syswf:param name="winOpenFunctionName" value="${winOpenFunctionName}" />
    <syswf:param name="winComponent" value="/core/impl/task/scheduleTaskWindowContent"/>
    <syswf:param name="winWidth" value="575" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winCustomButtons" value="${customButtons}" />    

    <syswf:param name="bean" value="${bean}" />
    <syswf:param name="taskArtifactUuid" value="${taskArtifactUuid}" />
    <syswf:param name="taskArtifact" value="${taskArtifact}" />    
    <syswf:param name="parentWinId" value="${prefix}taskScheduleWin" />
    <syswf:param name="parentPrefix" value="${prefix}" />
    <syswf:param name="closeWindowFce" value="${prefix}close" /> 
    <syswf:param name="updateArtifact" value="${updateArtifact}"/>
    <syswf:param name="checkOnStartDate" value="${checkOnStartDate}"/>
</syswf:component>
