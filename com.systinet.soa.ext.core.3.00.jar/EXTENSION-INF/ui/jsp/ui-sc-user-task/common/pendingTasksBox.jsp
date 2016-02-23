<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setBundle basename="com.hp.systinet.usertask.ui.UserTaskUiL10n" var="messages"/>

<fmt:message var="noTasks" key="usertasks.pendingTasksBox.noTasks" bundle="${messages}"/>
<fmt:message var="more" key="usertasks.pendingTasksBox.more" bundle="${messages}"/>
<fmt:message var="title" key="usertasks.pendingTasksBox.title" bundle="${messages}"/>

<%--@elvariable id="bean" type="com.hp.systinet.usertask.ui.common.PendingTasksBox.PendingTasksBoxBean"--%>

<syswf:block className="UI Block Common">
    <div class="Title">
    	<h3>
			<table>
				<tr>
					<td>
    					<c:out value="${title}"/>
					</td>
					<td style="padding-left: 10px">
    					<syswf:component name="/usertask/common/lifecycleTaskFeed" prefix="lifecycleTaskFeed" />
					</td>
				</tr>
			</table>
		</h3>
    </div>
    <div class="Content">
        <c:choose>
            <c:when test="${fn:length(bean.userTasks) eq 0}">
                <p><c:out value="${noTasks}"/></p>
            </c:when>
            <c:otherwise>
                <ul class="UI Bullets">
                    <c:forEach items="${bean.userTasks}" var="taskInfo" varStatus="status">
                        <li><span>
                            <syswf:component prefix="${prefix}userTask${status.index}" name="/usertask/common/renderer/genericTaskLinkRenderer" wrap="false">
                                <syswf:param name="taskInfo" value="${taskInfo}"/>
                                <syswf:param name="showArtifactName" value="true"/>
                            </syswf:component>
						</span></li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="Footer">
        <syswf:control mode="anchor" targetTask="/common/usertask/taskBrowser" caption="${more}" targetDepth="0"/>
    </div>
</syswf:block>
