<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="taskBean" type="com.hp.systinet.lifecycle.ui.admin.visualization.TaskBean"--%>
<%--@elvariable id="assigneeSelector" type="com.hp.systinet.sc.ui.pricipal.PrincipalSelectorListner"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<syswf:control id="actionRemoveTaskAssignee" mode="script" caption="actionRemoveTaskAssignee" action="removeAssignee" affects="." loadingMask="true" />
<syswf:input id="assigneeIndex" name="assigneeIndex" value="" mode="hidden"/>
<script type="text/javascript">
//<![CDATA[

    function storeAssigneeIndex(assigneeIndex) {
        Ext.get('assigneeIndex').dom.value = assigneeIndex;
    }

//]]>
</script>

<%-- Assignee Selector --%>
<syswf:component name="/core/principal/selector" prefix="assigneeSelector">
    <syswf:param name="jsOpenFunction" value="assigneeSelector_open" />
    <syswf:param name="windowTitle"><fmt:message key="taskDialog.assigneeSelectorWindowTitle" bundle="${bundle}"/></syswf:param>
    <syswf:param name="holder" value="${assigneeSelector}" />
     <syswf:param name="enableContactsTab" value="true" />
</syswf:component>
<syswf:input id="assignee" name="assignee" value="" mode="hidden"/>

<c:choose>
    <c:when test="${not empty taskBean.assigneeList}">
        <%-- Iterate existing assignees --%>
        <c:forEach var="assignee" varStatus="status" items="${taskBean.assigneeList}">
            <%-- Principal name --%>
            <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="a${status.index}" wrap="false">
                <syswf:param name="principal" value="${assignee}"/>
                <syswf:param name="showIcon" value="${true}"/>
            </syswf:component>
            &nbsp;(
            <%--Remove link --%>
            <a id="assigneeRemove${status.index}" href="javascript:void(0)"><fmt:message key="taskDialog.remove" bundle="${bundle}"/></a>
            )<br/>
            <script type="text/javascript">
//<![CDATA[

                attachOn('assigneeRemove${status.index}','click',function() { storeAssigneeIndex('${status.index}'); actionRemoveTaskAssignee();  });
            
//]]>
</script>
        </c:forEach>
        <%-- Add Assignee Link --%>
        <a id="assigneeAdd" class="UI Icon Add" href="javascript:void(0)"><fmt:message key="taskDialog.addAssignee" bundle="${bundle}"/></a>
    </c:when>
    <c:otherwise>
        <%-- Select Button --%>
        <a id="assigneeAdd" class="btn btn-gray" href="javascript:void(0);"><fmt:message key="taskDialog.select" bundle="${bundle}"/></a>
    </c:otherwise>
</c:choose>
<script type="text/javascript">
//<![CDATA[

    attachOn('assigneeAdd','click',function() { assigneeSelector_open(); });

//]]>
</script>
