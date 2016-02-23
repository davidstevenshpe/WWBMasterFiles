<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="sectionBean" type="com.hp.systinet.lifecycle.ui.catalog.visualization.PoliciesSection.PoliciesSectionBean"--%>
<%--@elvariable id="generalUpdateRegions" type="java.util.Set"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<syswf:block className="UI Block Plain">
    <div class="Title">
        <h4><span><fmt:message key="policiesSection.title" bundle="${messages}"/></span></h4>
    </div>
    <div class="Content">
        <div class="Offset">
            <c:choose>
                <c:when test="${not empty sectionBean.entries}">
                    <c:forEach items="${sectionBean.entries}" var="entry" varStatus="status">
                        <c:set var="entryId" value="policyEntry${status.index}"/>
                        <syswf:component prefix="${entryId}"
                                         name="/newUi/lc/catalog/visualization/policyRow">
                            <syswf:param name="entry" value="${entry}"/>
                            <syswf:param name="entryId" value="${entryId}"/>
                            <syswf:param name="showValidationButton" value="${sectionBean.showValidationButton}"/>
                            <syswf:param name="showRuntimeData" value="${sectionBean.showRuntimeData}"/>
                            <syswf:param name="generalUpdateRegions" value="${generalUpdateRegions}"/>
                        </syswf:component>
                    </c:forEach>
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
                </c:when>
                <c:otherwise>
                    <fmt:message key="sections.noItems" bundle="${messages}"/>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</syswf:block>

