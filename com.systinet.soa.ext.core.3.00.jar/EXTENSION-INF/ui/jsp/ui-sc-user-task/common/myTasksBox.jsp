<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setBundle basename="com.hp.systinet.usertask.ui.UserTaskUiL10n" var="messages"/>

<fmt:message var="myTasksTitle" key="usertasks.myTasksBox.title" bundle="${messages}"/>
<fmt:message var="noTasksDefined" key="usertasks.myTasksBox.noTasksDefined" bundle="${messages}"/>
<fmt:message var="finished" key="usertasks.myTasksBox.finished" bundle="${messages}"/>

<%--@elvariable id="bean" type="com.hp.systinet.usertask.ui.common.MyTasksBox.MyTasksBoxBean"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>

<c:if test="${empty artifact._sliceTime}">
	<script type="text/javascript">
//<![CDATA[

        var enableButton = false;
        function enableLifecycleButton() {
        	enableButton = true;
        }
    
//]]>
</script>
	<c:if test="${isEmptyLifeCyclePendingTask and isGovernance}">
	     <c:set var="lifecycleButton">
			 <%-- Request Approval --%>
			 <syswf:component name="/newUi/lc/catalog/button/requestApprovalButton" prefix="lifecycleTab.requestApproval"  >
			     <syswf:param name="uuid" value="${artifact._uuid}"/>
			     <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
			     <syswf:param name="record" value="${governanceRecord}"/>
			     <syswf:param name="callbackFunction" value="enableLifecycleButton"/>
			     <syswf:param name="insideTaskBox" value="true"/>
			 </syswf:component>
			 <%-- Cancel Approval --%>
			 <syswf:component name="/newUi/lc/catalog/button/cancelApprovalButton" prefix="lifecycleTab.cancelApproval">
			     <syswf:param name="uuid" value="${artifact._uuid}"/>
			     <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
			     <syswf:param name="record" value="${governanceRecord}"/>
			     <syswf:param name="insideTaskBox" value="true"/>
			 </syswf:component>
		 </c:set>
	</c:if>
    <div id="${prefix}myTasksId">
		<c:if test="${isHasTask || isGovernance}">
					<div class="EA-right-panel">
						<c:out value="${myTasksTitle}" />
						<div>
							<ul class="UI Checklist">
								<c:forEach items="${bean.pendingTasks}" var="taskInfo"
									varStatus="status">
									<li><syswf:component
											prefix="pendingUserTask_${taskInfo.uuid}"
											name="/usertask/common/renderer/genericMyTasksItemRenderer"
											wrap="false">
											<syswf:param name="taskInfo" value="${taskInfo}" />
											<syswf:param name="myTasksBoxPrefix" value="${prefix}" />
										</syswf:component>
									</li>
								</c:forEach>
							</ul>
							<c:out value="${lifecycleButton}" escapeXml="false" />
							<c:if
								test="${fn:length(bean.completedTasks) eq 0 && fn:length(bean.pendingTasks) eq 0}">
								<div class="Offset">
									<c:out value="${noTasksDefined}" />
								</div>
							</c:if>
							<c:if test="${fn:length(bean.completedTasks) gt 0}">
								<div class="OffsetLeft">
									<h4 class="Subheader">
										<c:out value="${finished}" />
									</h4>
									<ul class="UI Checklist">
										<c:forEach items="${bean.completedTasks}" var="taskInfo"
											varStatus="status">
											<li><syswf:component
													prefix="completedUserTask_${taskInfo.uuid}"
													name="/usertask/common/renderer/genericMyTasksItemRenderer"
													wrap="false">
													<syswf:param name="taskInfo" value="${taskInfo}" />
													<syswf:param name="myTasksBoxPrefix" value="${prefix}" />
												</syswf:component>
											</li>
										</c:forEach>
									</ul>
								</div>
							</c:if>
						</div>
					</div>
		</c:if>
    </div>
    <div id="${prefix}noTasksId">
        <div class="EA-right-panel">
        	<c:out value="${myTasksTitle}"/>
        	<div>
        		<span><c:out value="${noTasksDefined}"/></span>
       		</div>
        </div>
    </div>
    <script type="text/javascript">
//<![CDATA[

         var myTasks = Ext.get('${prefix}myTasksId');
         var noTasks = Ext.get('${prefix}noTasksId');
         var enableStyle = {display:'block'};
         var disableStyle = {display:'none'};
         var hasTask = enableButton;
         <c:if test="${isHasTask}">
            hasTask = true;
         </c:if>
         
         if (hasTask){
        	 myTasks.setStyle(enableStyle);
             noTasks.setStyle(disableStyle);
         }else{
        	 myTasks.setStyle(disableStyle);
             noTasks.setStyle(enableStyle);
         }         
    
//]]>
</script>
</c:if>

