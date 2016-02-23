<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="sectionBean" type="com.hp.systinet.lifecycle.ui.catalog.visualization.TasksSection.TasksSectionBean"--%>
<%--@elvariable id="generalUpdateRegions" type="java.util.Set"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<syswf:block className="UI Block Plain">
    <div class="Title">
        <h4><span><fmt:message key="tasksSection.title" bundle="${messages}"/></span></h4>
    </div>
    <div class="Content">
        <c:choose>
            <c:when test="${sectionBean.hasEntries}">
                <c:if test="${not empty sectionBean.unfinishedEntries}">
                    <div class="Offset">
                        <c:forEach items="${sectionBean.unfinishedEntries}" var="entry" varStatus="status">
                            <syswf:component prefix="pendingTask_${entry.id}"
                                             name="/newUi/lc/catalog/visualization/taskRow">
                                <syswf:param name="entry" value="${entry}"/>
                                <syswf:param name="generalUpdateRegions" value="${generalUpdateRegions}"/>
                            </syswf:component>
                        </c:forEach>
                    </div>
                    <c:if test="${not empty sectionBean.runningRuntimeDataIds}">
                        <c:set var="reloadFunction" value="${prefix}_reloadFunction"/>
                        <syswf:control mode="script" action="reloadIfValidationsFinished" caption="${reloadFunction}"
                                       affects=".">
                            <syswf:param name="runtimeDataIds" value="${sectionBean.runningRuntimeDataIds}"/>
                        </syswf:control>
                        <script type="text/javascript">
//<![CDATA[

                            setTimeout("callFunction('${reloadFunction}')", getRandomLoadingInterval());
                        
//]]>
</script>
                    </c:if>
                </c:if>
                <c:if test="${not empty sectionBean.unfinishedEntries and not empty sectionBean.finishedEntries}">
                    <div class="Title">
                        <h5><fmt:message key="tasksSection.finishedTitle" bundle="${messages}"/></h5>
                    </div>
                </c:if>
                <c:if test="${not empty sectionBean.finishedEntries}">
                    <div class="Offset">
                        <c:forEach items="${sectionBean.finishedEntries}" var="entry" varStatus="status">
                            <syswf:component prefix="completedTask_${entry.id}"
                                             name="/newUi/lc/catalog/visualization/taskRow">
                                <syswf:param name="entry" value="${entry}"/>
                                <syswf:param name="generalUpdateRegions" value="${generalUpdateRegions}"/>
                            </syswf:component>
                        </c:forEach>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="Offset">
                    <fmt:message key="sections.noItems" bundle="${messages}"/>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</syswf:block>

