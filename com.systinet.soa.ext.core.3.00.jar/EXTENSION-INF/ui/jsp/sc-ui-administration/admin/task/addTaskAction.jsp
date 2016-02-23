<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>
<fmt:message bundle="${messages}" key="newTaskArtifact_addArtifactSyncTask" var="addArtifactSyncTask"/>
<fmt:message bundle="${messages}" key="newTaskArtifact_addArtifactCustom" var="addArtifactCustom"/>
<c:if test="${showAddTaskAction}">
    <div class="x-hidden flyout-menu UI Dropdown" id="add_task_content">
        <div class="DropdownContent">
            <c:if test="${showNewCustomJobAction}">
                <div class="rel-dropdown-menu-item">
                    <syswf:control mode="anchor" targetTask="/admin/task/newTaskArtifact" caption="${addArtifactCustom}" >
                        <syswf:attribute name="class" value="UI PageAction AddCustTask"/>
                        <syswf:taskParam name="artifactType" value="taskArtifact" />
                        <syswf:taskParam name="taskType" value="customTask" />
                    </syswf:control>
                </div>
            </c:if>
            <div class="rel-dropdown-menu-item">
                <syswf:control mode="anchor" targetTask="/admin/task/newTaskArtifact" caption="${addArtifactSyncTask}">
                    <syswf:attribute name="class" value="UI PageAction AddSyncTask"/>
                    <syswf:taskParam name="artifactType" value="taskArtifact"/>
                    <syswf:taskParam name="taskType" value="artifactSync"/>
                </syswf:control>
            </div>
        </div>
    </div>
    <a href="javascript:void(0);" onclick="return false;" class="context-button AddSyncTask" id="add_task"></a>

    <script type="text/javascript">
        //<![CDATA[

        Ext.onReady(function(){ Dropdown.init('add_task','add_task_content',{align:'tl-bl',forceRefresh:true,shadow:false}); });

        //]]>
    </script>

</c:if>