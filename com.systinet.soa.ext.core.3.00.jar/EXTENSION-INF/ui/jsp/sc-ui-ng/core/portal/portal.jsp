<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="Portal"/>
  <syswf:param name="code">
    function saveLayout(componentStateId,layout)
    {
       Packages.com.hp.systinet.sc.ui.portal.PortalActions.getInstance().saveLayout(componentStateId,layout);
    }

    function resetLayout(customizationID, componentStateId)
    {
       Packages.com.hp.systinet.sc.ui.portal.PortalActions.getInstance().resetLayout(customizationID, componentStateId);
    }

	function setReadOnly(readOnly, customizationID, componentStateId)
    {
       Packages.com.hp.systinet.sc.ui.portal.PortalActions.getInstance().setReadOnly(readOnly, customizationID, componentStateId);
    }
	
    function storeAsDefaultLayout(customizationID,data)
    {
       Packages.com.hp.systinet.sc.ui.portal.PortalActions.getInstance().storeAsDefaultLayout(customizationID,data);
    }
    
    function deleteDashboard(customizationID, componentStateId)
    {
       Packages.com.hp.systinet.sc.ui.portal.PortalActions.getInstance().deleteDashboard(customizationID, componentStateId);
    }

    function getPortletProviderInformation()
    {
       return Packages.com.hp.systinet.sc.ui.portal.PortalActions.getInstance().getPortletProviderInformation();
    }
  </syswf:param>
</syswf:component>


<div id="portlets" style="display: none">

    <c:if test="${widgetStatus['tagCloud'] eq 'ENABLED'}">
        <div id="tagCloudSrc">
            <syswf:component name="/core/keywords/homepageTagCloud" prefix="tagcloud">
                <syswf:param name="title" value="Common Keywords"/>
                <syswf:param name="views" value="all"/>
                <syswf:param name="customizationId" value="shared.tagCloud"/>
            </syswf:component>
        </div>
    </c:if>

    <c:if test="${widgetStatus['events'] eq 'ENABLED'}">
        <div id="eventsSrc">
            <syswf:component name="/core/userevent/eventBox" prefix="events">
            </syswf:component>
        </div>
    </c:if>

    <c:if test="${widgetStatus['categories'] eq 'ENABLED'}">
        <div id="categoriesSrc">
            <syswf:component name="/core/taxonomy/homepage/homepageView" prefix="categories">
                <syswf:param name="maxCategories" value="5"/>
                 <syswf:param name="views" value="all"/>
            </syswf:component>
        </div>
    </c:if>

    <c:if test="${widgetStatus['roadmap'] eq 'ENABLED'}">
        <div id="roadmapSrc">
            <syswf:component name="/widgets/roadmap" prefix="roadmap"/>
        </div>
    </c:if>

    <c:if test="${widgetStatus['favorites'] eq 'ENABLED'}">
        <div id="favoritesSrc">
            <syswf:component name="/core/favorites/favoriteList" prefix="rightColumn.favorites">
            </syswf:component>
        </div>
    </c:if>

    <c:if test="${widgetStatus['tasks'] eq 'ENABLED'}">
        <div id="tasksSrc">
            <syswf:component name="/usertask/common/pendingTasksBox" prefix="rightColumn.pendingtasks">
                <syswf:param name="numberOfTasks" value="5"/>
                <syswf:param name="ordering" value="desc"/>
            </syswf:component>
        </div>
    </c:if>

    <c:if test="${widgetStatus['links'] eq 'ENABLED'}">
        <div id="linksSrc">
            <syswf:component name="/core/text/editableRichTextArea" prefix="rightColumn.usefullinks">
                <syswf:param name="customizationId" value="${parentCustomizationId}.usefulLinks"/>
                <syswf:param name="title">Useful Links</syswf:param>
            </syswf:component>
        </div>
    </c:if>

    <c:if test="${widgetStatus['birtReports'] eq 'ENABLED'}">
        <div id="birtReportsSrc">
            <syswf:component name="/reports/catalog/birtReportBrowser" prefix="birt">
                <syswf:param name="browseLinkRenderer" value="/core/impl/catalog/artifactInstanceLinkRenderer"/>
                <syswf:param name="sdmName" value="hpsoaBirtReportArtifact"/>
                <syswf:param name="collectionId">hpsoaBirtReports</syswf:param>
            </syswf:component>
        </div>
    </c:if>
    <c:if test="${widgetStatus['contracts'] eq 'ENABLED'}">
        <div id="contractsSrc">
            <syswf:component name="/reports/dashboard/contractManagement" prefix="contractManagement">
                <syswf:param name="customizationId">reports.dashboard.contractManagementTable</syswf:param>
            </syswf:component>
        </div>
    </c:if>

    <c:if test="${widgetStatus['lifecycle'] eq 'ENABLED'}">
        <div id="lifecycleSrc">
            <syswf:component name="/reports/dashboard/artifactsByLifecycle" prefix="artifactsByLifecycle">
                <syswf:param name="customizationId">reports.dashboard.lifecycleStateTable</syswf:param>
                <syswf:param name="domainFilterType">report</syswf:param>
            </syswf:component>
        </div>
    </c:if>

    <c:if test="${widgetStatus['activity'] eq 'ENABLED'}">
        <div id="activitySrc" >
            <syswf:component name="/reports/dashboard/activityReport" prefix="activityReport"/>
        </div>
    </c:if>

    <c:if test="${widgetStatus['feeds'] eq 'ENABLED'}">
        <div id="feedsSrc">
            <syswf:component name="/reports/feeds/userFeeds" prefix="leftColumn.feeds">
                <syswf:param name="customizationId">reports.dashboard.feeds</syswf:param>
            </syswf:component>
        </div>
    </c:if>
 </div>

<div  id="portal">
</div>

<c:forEach items="${widgets}" var="widget" varStatus="loop">
    <c:if test="${(not empty widget.portletClass) and (not empty portletRendererComponents[widget.portletClass])}">
    <c:choose>
	    <c:when test="${(widget.portletClass ne 'EA.portlets.PolicyReport') and (widget.portletClass ne 'EA.portlets.ArtifactReport')}">
	    	<c:set var="hiddenStyle" value="display:none"/>
	    </c:when>
	    <c:otherwise>
	    	<c:set var="hiddenStyle" value="visibility:hidden"/>
	    </c:otherwise>
    </c:choose>
	<div style="${hiddenStyle}">
        <div id="${widget.portletClass}.${widget.id}.src">
            <syswf:component name="${portletRendererComponents[widget.portletClass]}" prefix="${widget.portletClass}.${loop.index}.${widget.id}">
                <syswf:param name="configuration" value="${widget.configuration}"/>
                <syswf:param name="id" value="${widget.id}"/>
            </syswf:component>
        </div>
    </div>
    </c:if>
</c:forEach>


<style>

    .node circle {
        fill: #fff;
        stroke: steelblue;
        stroke-width: 1.5px;
    }

    .node {
        font: 10px sans-serif;
    }

    .link {
        fill: none;
        stroke: #ccc;
        stroke-width: 1.5px;
    }

</style>

<script type="text/javascript">
//<![CDATA[

    window.getPageSize = function() {
    	return ${winPageSize};
    }
    
    function getLifecycleColor() {
    	return ${lifecycleColors};
    }
    
    var portal;
    var recalculeDelayTime = ${recalculeDelayTime};

    Ext4.onReady(function(){
        portal=Ext4.create('EA.portal.PortalPanelController', {
            renderTo:'portal',
            width:1900,
            componentStateId:'${componentStateId}',
            customizationId: '${customizationId}',
            customizationMode: ${customizationMode},
			readOnly:${readOnly},
			allowReadOnlyMenu:${allowReadOnlyMenu},
			allowDelete:${allowDelete},
            actions: {
                "saveLayout": saveLayout,
                "resetLayout": resetLayout,
				"setReadOnly": setReadOnly,
                "storeAsDefaultLayout": storeAsDefaultLayout,
                "deleteDashboard": deleteDashboard,
                "getPortletProviderInformation":getPortletProviderInformation
            },
            componentState:${componentState},
            defaultComponentState: ${componentState},
            jspWidgets: ${jspWidgets},
            portletProviderInformation: ${portletProviderInformation}
        });
        portal.transferJSPWidgets();
    });
//]]>
</script>