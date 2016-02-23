<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.admin.visualization.TasksSectionBean"--%>
<%--@elvariable id="taskBean" type="com.hp.systinet.lifecycle.ui.admin.visualization.TaskBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<%-- Actions --%>
<syswf:control id="taskActionReorder" mode="script" caption="taskActionReorder" action="reorder" affects="." loadingMask="true"/>
<syswf:input id="taskOrderCsv" name="taskOrderCsv" value="" mode="hidden"/>
<syswf:control id="taskActionAdd" mode="script" caption="taskActionAdd" action="add" affects="." loadingMask="true"/>
<syswf:control id="taskActionUpdate" mode="script" caption="taskActionUpdate" action="update" affects="." loadingMask="true"/>
<syswf:control id="taskActionDelete" mode="script" caption="taskActionDelete" action="delete" affects="." loadingMask="true"/>
<syswf:control id="taskActionDialogClose" mode="script" caption="taskActionDialogClose" action="closeTaskDialog" affects="." loadingMask="true"/>
<syswf:input id="taskId" name="taskId" value="" mode="hidden"/>

<%-- Delete confirm dialog --%>
<syswf:component prefix="taskDeleteDialog" name="/core/impl/util/dialog">
    <syswf:param name="handler" value="dummy" />
    <syswf:param name="heading"><fmt:message key="tasksSection.deletePopupTitle" bundle="${bundle}"/></syswf:param>
    <syswf:param name="noUndo" value="false" />
</syswf:component>

<%-- Add/Edit Task dialog --%>
<fmt:message key="taskDialog.okLabel" var="okLabel" bundle="${bundle}"/>
<fmt:message key="taskDialog.cancelLabel" var="cancelLabel" bundle="${bundle}"/>
<c:set var="okFn" value="${prefix}_submit"/>
<c:set var="cancelFn" value="taskActionDialogClose"/>
<c:set var="validateTaskFn" value="${prefix}_validateTask"/>
<c:set var="customButtons">
    [{
        text     : '${okLabel}',
        disabled : false,
        handler  : function() {
            if (${validateTaskFn}()) {
                ${okFn}();
                SPopup.Window.Instance['taskDialog'].removeListener('beforehide', ${cancelFn});
                SPopup.Window.Instance['taskDialog'].hide();
            }
        },
        id: '${prefix}_ok'
    },{
        text     : '${cancelLabel}',
        handler  : function(){
            SPopup.Window.Instance['taskDialog'].hide();
            return false;
        },
        id: '${prefix}_cancel'
    }]
</c:set>
<syswf:component name="/core/window" prefix="addTask">
    <syswf:param name="winId" value="taskDialog"/>
    <syswf:param name="winComponent" value="/newUi/lc/admin/visualization/taskDialog"/>
    <syswf:param name="winOpenFunctionName" value="taskDialog_open" />
    <syswf:param name="winCancelAction" value="${cancelFn}" />
    <syswf:param name="winGetParamsFunctionName" value="taskDialog_getParams" />
    <syswf:param name="winWidth" value="800" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winCustomButtons" value="${customButtons}" />
    <syswf:param name="taskBean" value="${taskBean}" />
    <syswf:param name="currentState" value="${bean.currentState}" />
    <syswf:param name="validateTaskFn" value="${validateTaskFn}" />
</syswf:component>
<script type="text/javascript">
//<![CDATA[

    var _addOrEdit = 0;
    var _storedTaskId;
    function storeTaskId(taskId) {
        Ext.get('taskId').dom.value = taskId;
    }
    function taskDialog_getParams() {
        return {
            'taskId' : Ext.get('taskId').dom.value
        };
    }
    function ${okFn}() {
        switch (_addOrEdit) {
        case 1: taskActionAdd(); break;
        case 2: taskActionUpdate(); break;
        }
    }
    function showAddTaskDialog() {
        _addOrEdit = 1;
        storeTaskId('');
        taskDialog_open();
        SPopup.Window.Instance['taskDialog'].setTitle('<fmt:message key="taskDialog.addTaskTitle" bundle="${bundle}"/>');
    }
    function showEditTaskDialog(taskId) {
        _addOrEdit = 2;
        storeTaskId(taskId);
        taskDialog_open();
        SPopup.Window.Instance['taskDialog'].setTitle('<fmt:message key="taskDialog.editTaskTitle" bundle="${bundle}"/>');
    }

//]]>
</script>

<syswf:block className="UI Block Plain">
    <%-- Section title --%>
    <div class="Title"><h4><span><fmt:message key="tasksSection.title" bundle="${bundle}"/></span></h4></div>
    <div class="Content">
        <%-- Task Items --%>
        <div class="Offset">
            <ul class="com_sortable" id="sortable_tasks">
                <%--Iterate task items --%>
                <c:forEach var="task" varStatus="tstatus" items="${bean.taskList}">
                    <li id="task_${task.id}">
                        <table class="UI Table Properties">
                            <col class="FormSelectCol"/>
                            <col class="MidLabelCol"/>
                            <col />
                            <col class="ControlCol"/>
                            <col class="SpacerCol"/>
                            <tr>
                                <td><a href="javascript:void(0)" class="UI Icon Expand" id="task_${task.id}_switch"
                                       onclick="AdvancedOptions.Comment.Switch('task_${task.id}_switch','task_${task.id}_comment');"><span>Expand</span></a>
                                </td>
                                <td class="LifecycleTaskAlignMiddle">
                                    <label class="SortCursor"><c:out value="${task.name}"/></label>
                                </td>
                                <td>
                                    <c:if test="${not empty task.assigneeList}">
                                        <c:forEach var="assignee" varStatus="astatus" items="${task.assigneeList}">
                                            <%-- Principal name --%>
                                            <syswf:component prefix="al${tstatus.index}${astatus.index}" name="/core/impl/util/principalLinkRenderer" wrap="false">
                                                <syswf:param name="principal" value="${assignee}"/>
                                                <syswf:param name="showIcon" value="${true}"/>
                                            </syswf:component>
                                            <c:if test="${not astatus.last}"><br/></c:if>
                                        </c:forEach>
                                    </c:if>
                                </td>
                                <td>
                                    <div class="Text RightAlign">
                                        <a id="taskEdit_${task.id}" href="javascript:void(0)" class="UI Icon Edit">
                                            <span><fmt:message key="button.edit" bundle="${bundle}"/></span>
                                        </a> &nbsp;
                                        <a id="task_del_${task.id}" href="javascript:void(0)" class="UI Icon Delete">
                                            <span><fmt:message key="button.delete" bundle="${bundle}"/></span>
                                        </a>
                                    </div>
                                </td>
                                <td>
                                    <div class="Text RightAlign">
                                        <span class="UI Icon DragnDrop" title="<fmt:message key="title.dragToChangeOrder" bundle="${bundle}"/>"></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div class="Comment x-hidden" id="task_${task.id}_comment">
                            <table class="UI Table Properties">
                                <col class="FormSelectCol"/>
                                <col/>
                                <tr>
                                    <td></td>
                                    <td>
                                        <c:if test="${not empty task.policyUuid}">
                                            <strong><fmt:message key="tasksSection.validatedByPolicy" bundle="${bundle}"/>:</strong>
                                            <%-- Policy Name --%>
                                            <syswf:component prefix="pl${tstatus.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                                <syswf:param name="uuid" value="${task.policyUuid}"/>
                                                <syswf:param name="caption" value="${task.policyName}"/>
                                            </syswf:component>
                                            <%-- Policy applicable to --%>
                                            <br/>
                                            <strong><fmt:message key="taskDialog.policyAplicableTo" bundle="${bundle}" />:</strong>
                                            <c:forEach var="artifactType" varStatus="atStatus" items="${task.applicableToLabels}">
                                                <c:out value="${artifactType}"/><c:if test="${not atStatus.last}">,</c:if>
                                            </c:forEach>
                                        </c:if>
                                        <%-- Task Description --%>
                                        <c:if test="${not empty task.fakeDescription}">
                                            <p class="Comment Plain">
                                                <c:out value="${task.fakeDescription}" escapeXml="false"/>
                                            </p>
                                        </c:if>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </li>
                </c:forEach>
            </ul>

            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    if (jQuery.isFunction(jQuery.fn.sortable)) {
                        jQuery('#sortable_tasks').sortable({placeholder: 'ui-state-highlight'});
                    }
                    <%-- //jQuery('#sortable_tasks').disableSelection(); --%>
                    jQuery('#sortable_tasks').bind('sortstop', function(event, ui) {
                        Ext.get('taskOrderCsv').dom.value = jQuery('#sortable_tasks').sortable('toArray').join(',');
                        taskActionReorder();
                    });
                <c:forEach var="task" items="${bean.taskList}">
                    var element = Ext.get('task_del_${task.id}');
                    element.on('click', function() {
                       ${prefix}_taskDeleteDialog_showDialog(element, null,
                               '<fmt:message key="tasksSection.deleteQuestion" bundle="${bundle}"/>',
                               null, function(){ storeTaskId('${task.id}'); taskActionDelete(); }, false);
                    });
                    attachOn('taskEdit_${task.id}','click',function() { showEditTaskDialog('${task.id}'); });
                </c:forEach>
                });

            
//]]>
</script>

            <%-- Add Link --%>
            <a id="taskAdd" class="UI Icon Add" href="javascript:void(0)"><fmt:message key="tasksSection.addTask" bundle="${bundle}"/></a>
            <script type="text/javascript">
//<![CDATA[

                attachOn('taskAdd','click',function() { showAddTaskDialog(); });
            
//]]>
</script>
        </div>
    </div>

</syswf:block>
